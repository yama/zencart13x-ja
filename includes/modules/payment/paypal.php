<?php
/**
 * @copyright Copyright 2006-2008 Bigmouse, Inc
 * @copyright Portions Copyright 2003-2007 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: paypal.php 45 2008-07-25 07:48:54Z bigmouse-nfox $
**/

define('MODULE_PAYMENT_PAYPAL_TAX_OVERRIDE', 'true');

// ensure dependencies are loaded
  include_once((IS_ADMIN_FLAG === true ? DIR_FS_CATALOG_MODULES : DIR_WS_MODULES) . 'payment/paypal/paypal_functions.php');
/**
 * paypal IPN payment method class
 *
 */
class paypal extends base {
  /**
   * string repesenting the payment method
   *
   * @var string
   */
  var $code;
  /**
   * $title is the displayed name for this payment method
   *
   * @var string
    */
  var $title;
  /**
   * $description is a soft name for this payment method
   *
   * @var string
    */
  var $description;
  /**
   * $enabled determines whether this module shows or not... in catalog.
   *
   * @var boolean
    */
  var $enabled;
  /**
    * constructor
    *
    * @param int $paypal_ipn_id
    * @return paypal
    */
  function paypal($paypal_ipn_id = '') {
    global $order, $messageStack;
    $this->code = 'paypal';
    $this->codeVersion = '1.3.8a';
    if (IS_ADMIN_FLAG === true) {
      $this->title = MODULE_PAYMENT_PAYPAL_TEXT_ADMIN_TITLE; // Payment Module title in Admin
      if (IS_ADMIN_FLAG === true && defined('MODULE_PAYMENT_PAYPAL_IPN_DEBUG') && MODULE_PAYMENT_PAYPAL_IPN_DEBUG != 'Off') $this->title .= '<span class="alert"> (debug mode active)</span>';
      if (IS_ADMIN_FLAG === true && MODULE_PAYMENT_PAYPAL_TESTING == 'Test') $this->title .= '<span class="alert"> (dev/test mode active)</span>';
    } else {
      $this->title = MODULE_PAYMENT_PAYPAL_TEXT_CATALOG_TITLE; // Payment Module title in Catalog
    }
    $this->description = MODULE_PAYMENT_PAYPAL_TEXT_DESCRIPTION;
    $this->sort_order = MODULE_PAYMENT_PAYPAL_SORT_ORDER;
    $this->enabled = ((MODULE_PAYMENT_PAYPAL_STATUS == 'True') ? true : false);
    if ((int)MODULE_PAYMENT_PAYPAL_ORDER_STATUS_ID > 0) {
      $this->order_status = MODULE_PAYMENT_PAYPAL_ORDER_STATUS_ID;
    }
    if (is_object($order)) $this->update_status();
    if (MODULE_PAYMENT_PAYPAL_TESTING == 'Test') {
      if (!file_exists(DIR_WS_CATALOG . 'ipn_test.php')) {
        $messageStack->add('header', 'WARNING: PayPal TEST mode enabled but ipn_test*.php files not found. Thus, module has been disabled in storefront.', 'caution');
        if (IS_ADMIN_FLAG === false) $this->enabled = false;
      }
      $this->form_action_url = DIR_WS_CATALOG . 'ipn_test.php';
    } else {
      $this->form_action_url = 'https://' . MODULE_PAYMENT_PAYPAL_HANDLER;
    }

    if (PROJECT_VERSION_MAJOR != '1' && substr(PROJECT_VERSION_MINOR, 0, 3) != '3.8') $this->enabled = false;

    // verify table structure
    if (IS_ADMIN_FLAG === true) $this->tableCheckup();
  }
  /**
   * calculate zone matches and flag settings to determine whether this module should display to customers or not
    *
    */
  function update_status() {
    global $order, $db;

    if ( ($this->enabled == true) && ((int)MODULE_PAYMENT_PAYPAL_ZONE > 0) ) {
      $check_flag = false;
      $check_query = $db->Execute("select zone_id from " . TABLE_ZONES_TO_GEO_ZONES . " where geo_zone_id = '" . MODULE_PAYMENT_PAYPAL_ZONE . "' and zone_country_id = '" . $order->billing['country']['id'] . "' order by zone_id");
      while (!$check_query->EOF) {
        if ($check_query->fields['zone_id'] < 1) {
          $check_flag = true;
          break;
        } elseif ($check_query->fields['zone_id'] == $order->billing['zone_id']) {
          $check_flag = true;
          break;
        }
        $check_query->MoveNext();
      }

      if ($check_flag == false) {
        $this->enabled = false;
      }
    }
  }
  /**
   * JS validation which does error-checking of data-entry if this module is selected for use
   * (Number, Owner, and CVV Lengths)
   *
   * @return string
    */
  function javascript_validation() {
    return false;
  }
  /**
   * Displays payment method name along with Credit Card Information Submission Fields (if any) on the Checkout Payment Page
   *
   * @return array
    */
  function selection() {
    return array('id' => $this->code,
                 'module' => MODULE_PAYMENT_PAYPAL_TEXT_CATALOG_LOGO,
                 'icon' => MODULE_PAYMENT_PAYPAL_TEXT_CATALOG_LOGO
                 );
  }
  /**
   * Normally evaluates the Credit Card Type for acceptance and the validity of the Credit Card Number & Expiration Date
   * Since paypal module is not collecting info, it simply skips this step.
   *
   * @return boolean
   */
  function pre_confirmation_check() {
    return false;
  }
  /**
   * Display Credit Card Information on the Checkout Confirmation Page
   * Since none is collected for paypal before forwarding to paypal site, this is skipped
   *
   * @return boolean
    */
  function confirmation() {
    return false;
  }
  /**
   * Build the data and actions to process when the "Submit" button is pressed on the order-confirmation screen.
   * This sends the data to the payment gateway for processing.
   * (These are hidden fields on the checkout confirmation page)
   *
   * @return string
    */
  function process_button() {
    global $db, $order, $currencies, $currency;
    $options = array();
    $optionsCore = array();
    $optionsPhone = array();
    $optionsShip = array();
    $optionsLineItems = array();
    $optionsAggregate = array();
    $optionsTrans = array();
    $buttonArray = array();

    $this->totalsum = $order->info['total'];

    // save the session stuff permanently in case paypal loses the session
    $_SESSION['ppipn_key_to_remove'] = session_id();
    $db->Execute("delete from " . TABLE_PAYPAL_SESSION . " where session_id = '" . zen_db_input($_SESSION['ppipn_key_to_remove']) . "'");

    $sql = "insert into " . TABLE_PAYPAL_SESSION . " (session_id, saved_session, expiry) values (
            '" . zen_db_input($_SESSION['ppipn_key_to_remove']) . "',
            '" . base64_encode(serialize($_SESSION)) . "',
            '" . (time() + (1*60*60*24*2)) . "')";

    $db->Execute($sql);

    $my_currency = select_pp_currency();
    $this->transaction_currency = $my_currency;

    $this->transaction_amount = ($this->totalsum * $currencies->get_value($my_currency));

    $telephone = preg_replace('/\D/', '', $order->customer['telephone']);
    if ($telephone != '') {
      $optionsPhone['H_PhoneNumber'] = $telephone;
      if (in_array($order->customer['country']['iso_code_2'], array('US','CA'))) {
        $optionsPhone['night_phone_a'] = substr($telephone,0,3);
        $optionsPhone['night_phone_b'] = substr($telephone,3,3);
        $optionsPhone['night_phone_c'] = substr($telephone,6,4);
        $optionsPhone['day_phone_a'] = substr($telephone,0,3);
        $optionsPhone['day_phone_b'] = substr($telephone,3,3);
        $optionsPhone['day_phone_c'] = substr($telephone,6,4);
    } else {
        $optionsPhone['night_phone_b'] = $telephone;
        $optionsPhone['day_phone_b'] = $telephone;
      }
    }

    $optionsCore = array(
                   'charset' => CHARSET,
                   'lc' => $order->customer['country']['iso_code_2'],
                   'page_style' => MODULE_PAYMENT_PAYPAL_PAGE_STYLE,
                   'custom' => zen_session_name() . '=' . zen_session_id(),
                   'business' => MODULE_PAYMENT_PAYPAL_BUSINESS_ID,
                   'return' => zen_href_link(FILENAME_CHECKOUT_PROCESS, 'referer=paypal', 'SSL'),
                   'cancel_return' => zen_href_link(FILENAME_CHECKOUT_PAYMENT, '', 'SSL'),
                   'shopping_url' => zen_href_link(FILENAME_SHOPPING_CART, '', 'SSL'),
                   'notify_url' => zen_href_link('ipn_main_handler.php', '', 'SSL',false,false,true),
                   'redirect_cmd' => '_xclick',
                   'rm' => 2,
                   'bn' => 'zencart',
                   'mrb' => 'R-6C7952342H795591R',
                   'pal' => 'UATS2MUHJ5AS8',
                   );
    $optionsCust = array(
                   'address1' => replace_accents($order->customer['street_address']),
                   'city' => replace_accents($order->customer['city']),
                   'state' => zen_get_zone_code($order->customer['country']['id'], $order->customer['zone_id'], $order->customer['zone_id']),
                   'zip' => $order->customer['postcode'],
                   'country' => $order->customer['country']['iso_code_2'],
                   'email' => $order->customer['email_address'],
                   );
    if (mb_strlen($order->customer['firstname']) === strlen($order->customer['firstname'])) {
      $optionsCust['first_name'] = replace_accents($order->customer['firstname']);
      $optionsCust['last_name'] = replace_accents($order->customer['lastname']);
    } else {
      $optionsCust['first_name'] = replace_accents($order->customer['lastname']);
      $optionsCust['last_name'] = replace_accents($order->customer['firstname']);
    }
    if ($order->customer['suburb'] != '') $optionsCust['address2'] = $order->customer['suburb'];
    if (MODULE_PAYMENT_PAYPAL_ADDRESS_REQUIRED == 2) $optionsCust = array(
                   'address_name' => replace_accents($order->customer['firstname'] . ' ' . $order->customer['lastname']),
                   'address_street' => replace_accents($order->customer['street_address']),
                   'address_city' => replace_accents($order->customer['city']),
                   'address_state' => zen_get_zone_code($order->customer['country']['id'], $order->customer['zone_id'], $order->customer['zone_id']),
                   'address_zip' => $order->customer['postcode'],
                   'address_country' => $order->customer['country']['title'],
                   'address_country_code' => $order->customer['country']['iso_code_2'],
                   'payer_email' => $order->customer['email_address'],
                   );
    $optionsShip = array(
                   //'address_override' => MODULE_PAYMENT_PAYPAL_ADDRESS_OVERRIDE,
                   'no_shipping' => MODULE_PAYMENT_PAYPAL_ADDRESS_REQUIRED,
                   );
    if (MODULE_PAYMENT_PAYPAL_DETAILED_CART == 'Yes') $optionsLineItems = ipn_getLineItemDetails();
    if (sizeof($optionsLineItems) > 0) {
      $optionsLineItems['cmd'] = '_cart';
//      $optionsLineItems['num_cart_items'] = sizeof($order->products);
      if (isset($optionsLineItems['shipping'])) {
        $optionsLineItems['shipping_1'] = $optionsLineItems['shipping'];
        unset($optionsLineItems['shipping']);
      }
      if (isset($optionsLineItems['handling'])) {
        $optionsLineItems['handling_1'] = $optionsLineItems['handling'];
        unset($optionsLineItems['handling']);
      }
      unset($optionsLineItems['subtotal']);
      // if line-item details couldn't be kept due to calculation mismatches or discounts etc, default to aggregate mode
      if (!isset($optionsLineItems['item_name_1'])) $optionsLineItems = array();
      //if ($optionsLineItems['amount'] != $this->transaction_amount) $optionsLineItems = array();
      ipn_debug_email('Line Item Details (if blank, this means there was a data mismatch, and thus bypassed): ' . "\n" . print_r($optionsLineItems, true));
    }
    $optionsAggregate = array(
                   'cmd' => '_ext-enter',
                   'item_name' => MODULE_PAYMENT_PAYPAL_PURCHASE_DESCRIPTION_TITLE,
                   'item_number' => MODULE_PAYMENT_PAYPAL_PURCHASE_DESCRIPTION_ITEMNUM,
                   //'num_cart_items' => sizeof($order->products),
                   'amount' => number_format($this->transaction_amount, $currencies->get_decimal_places($my_currency)),
                   'shipping' => '0.00',
                    );
    if (MODULE_PAYMENT_PAYPAL_TAX_OVERRIDE == 'true') $optionsAggregate['tax'] = '0.00';
    if (MODULE_PAYMENT_PAYPAL_TAX_OVERRIDE == 'true') $optionsAggregate['tax_cart'] = '0.00';
    $optionsTrans = array(
                   'upload' => (int)(sizeof($order->products) > 0),
                   'currency_code' => $my_currency,
//                   'paypal_order_id' => $paypal_order_id,
                   //'no_note' => '1',
                   //'invoice' => '',
                    );

    // if line-item info is invalid, use aggregate:
    if (sizeof($optionsLineItems) > 0) $optionsAggregate = $optionsLineItems;

    // prepare submission
    $options = array_merge($optionsCore, $optionsCust, $optionsPhone, $optionsShip, $optionsTrans, $optionsAggregate);
    ipn_debug_email('Keys for submission: ' . print_r($options, true));
    // build the button fields
    foreach ($options as $name => $value) {
      // remove quotation marks
      $value = str_replace('"', '', $value);
      // check for invalid chars
      if (preg_match('/[^a-zA-Z_0-9]/', $name)) {
        ipn_debug_email('datacheck - ABORTING - preg_match found invalid submission key: ' . $name . ' (' . $value . ')');
        break;
      }
      // do we need special handling for & and = symbols?
      //if (strpos($value, '&') !== false || strpos($value, '=') !== false) $value = urlencode($value);

      $buttonArray[] = zen_draw_hidden_field($name, $value);
    }
    $process_button_string = implode("\n", $buttonArray) . "\n";

    $_SESSION['paypal_transaction_info'] = array($this->transaction_amount, $this->transaction_currency);
    return $process_button_string;
  }
  /**
   * Store transaction info to the order and process any results that come back from the payment gateway
   */
  function before_process() {
    global $order_total_modules;
    list($this->transaction_amount, $this->transaction_currency) = $_SESSION['paypal_transaction_info'];
    unset($_SESSION['paypal_transaction_info']);
    if (isset($_GET['referer']) && $_GET['referer'] == 'paypal') {
      $this->notify('NOTIFY_PAYMENT_PAYPAL_RETURN_TO_STORE');
      if (MODULE_PAYMENT_PAYPAL_TESTING == 'Test') {
        // simulate call to ipn_handler.php here
        ipn_simulate_ipn_handler((int)$_GET['count']);
      }
      if (defined('MODULE_PAYMENT_PAYPAL_PDTTOKEN') && MODULE_PAYMENT_PAYPAL_PDTTOKEN != '') {
        $pdtStatus = $this->_getPDTresults($this->transaction_amount, $this->transaction_currency);
      } else {
        $pdtStatus = false;
      }
      if ($pdtStatus == false) {
        $_SESSION['cart']->reset(true);
        unset($_SESSION['sendto']);
        unset($_SESSION['billto']);
        unset($_SESSION['shipping']);
        unset($_SESSION['payment']);
        unset($_SESSION['comments']);
        unset($_SESSION['cot_gv']);
        $order_total_modules->clear_posts();//ICW ADDED FOR CREDIT CLASS SYSTEM
        zen_redirect(zen_href_link(FILENAME_CHECKOUT_SUCCESS, '', 'SSL'));
      } else {
        // PDT was good, so delete IPN session from PayPal table -- housekeeping.
        global $db;
        $db->Execute("delete from " . TABLE_PAYPAL_SESSION . " where session_id = '" . zen_db_input($_SESSION['ppipn_key_to_remove']) . "'");
        unset($_SESSION['ppipn_key_to_remove']);
        $_SESSION['paypal_transaction_PDT_passed'] = true;
        return true;
      }
    } else {
      $this->notify('NOTIFY_PAYMENT_PAYPAL_CANCELLED_DURING_CHECKOUT');
      zen_redirect(zen_href_link(FILENAME_CHECKOUT_PAYMENT, '', 'SSL'));
    }
  }
  /**
    * Checks referrer
    *
    * @param string $zf_domain
    * @return boolean
    */
  function check_referrer($zf_domain) {
    return true;
  }
  /**
    * Build admin-page components
    *
    * @param int $zf_order_id
    * @return string
    */
  function admin_notification($zf_order_id) {
    global $db;
    $output = '';
    $sql = "select * from " . TABLE_PAYPAL . " where order_id = '" . (int)$zf_order_id . "' order by paypal_ipn_id DESC LIMIT 1";
    $ipn = $db->Execute($sql);
    if ($ipn->RecordCount() > 0 && file_exists(DIR_FS_CATALOG . DIR_WS_MODULES . 'payment/paypal/paypal_admin_notification.php')) require(DIR_FS_CATALOG . DIR_WS_MODULES . 'payment/paypal/paypal_admin_notification.php');
    return $output;
  }
  /**
   * Post-processing activities
   * When the order returns from the processor, if PDT was successful, this stores the results in order-status-history and logs data for subsequent reference
   *
   * @return boolean
    */
  function after_process() {
    global $insert_id, $db;
    if ($_SESSION['paypal_transaction_PDT_passed'] != true) {
      $_SESSION['order_created'] = '';
      unset($_SESSION['paypal_transaction_PDT_passed']);
      return false;
    } else {
    // PDT found order to be approved, so add a new OSH record for this order's PP details
      unset($_SESSION['paypal_transaction_PDT_passed']);
      $sql_data_array= array(array('fieldName'=>'orders_id', 'value'=>$insert_id, 'type'=>'integer'),
                             array('fieldName'=>'orders_status_id', 'value'=>$this->order_status, 'type'=>'integer'),
                             array('fieldName'=>'date_added', 'value'=>'now()', 'type'=>'noquotestring'),
                             array('fieldName'=>'customer_notified', 'value'=>0, 'type'=>'integer'),
                             array('fieldName'=>'comments', 'value'=>'PayPal status: ' . $this->pdtData['payment_status'] . ' ' . ' @ ' . $this->pdtData['payment_date'] . "\n" . ' Trans ID:' . $this->pdtData['txn_id'] . "\n" . ' Amount: ' . $this->pdtData['mc_gross'] . ' ' . $this->pdtData['mc_currency'] . '.', 'type'=>'string'));
      $db->perform(TABLE_ORDERS_STATUS_HISTORY, $sql_data_array);
      ipn_debug_email('PDT NOTICE :: Order added: ' . $insert_id . "\n" . 'PayPal status: ' . $this->pdtData['payment_status'] . ' ' . ' @ ' . $this->pdtData['payment_date'] . "\n" . ' Trans ID:' . $this->pdtData['txn_id'] . "\n" . ' Amount: ' . $this->pdtData['mc_gross'] . ' ' . $this->pdtData['mc_currency']);

      // store the PayPal order meta data -- used for later matching and back-end processing activities
      $sql_data_array = array('order_id' => $insert_id,
                          'txn_type' => $this->pdtData['txn_type'],
                          'module_name' => $this->code . ' ' . $this->codeVersion,
                          'module_mode' => 'PDT',
                          'reason_code' => $this->pdtData['reasoncode'],
                          'payment_type' => $this->pdtData['payment_type'],
                          'payment_status' => $this->pdtData['payment_status'],
                          'pending_reason' => $this->pdtData['pendingreason'],
                          'invoice' => $this->pdtData['invoice'],
                          'first_name' => $this->pdtData['first_name'],
                          'last_name' => $this->pdtData['last_name'],
                          'payer_business_name' => $order->billing['company'],
                          'address_name' => $order->billing['name'],
                          'address_street' => $order->billing['street_address'],
                          'address_city' => $order->billing['city'],
                          'address_state' => $order->billing['state'],
                          'address_zip' => $order->billing['postcode'],
                          'address_country' => $this->pdtData['residence_country'], // $order->billing['country']
                          'address_status' => $this->pdtData['address_status'],
                          'payer_email' => $this->pdtData['payer_email'],
                          'payer_id' => $this->pdtData['payer_id'],
                          'payer_status' => $this->pdtData['payer_status'],
                          'payment_date' => trim(preg_replace('/[^0-9-:]/', ' ', $this->pdtData['payment_date'])),
                          'business' => $this->pdtData['business'],
                          'receiver_email' => $this->pdtData['receiver_email'],
                          'receiver_id' => $this->pdtData['receiver_id'],
                          'txn_id' => $this->pdtData['txn_id'],
                          'parent_txn_id' => $this->pdtData['parent_txn_id'],
                          'num_cart_items' => (float)$this->pdtData['num_cart_items'],
                          'mc_gross' => (float)$this->pdtData['mc_gross'],
                          'mc_fee' => (float)$this->pdtData['mc_fee'],
                          'mc_currency' => $this->pdtData['mc_currency'],
                          'settle_amount' => (float)$this->pdtData['settle_amount'],
                          'settle_currency' => $this->pdtData['settle_currency'],
                          'exchange_rate' => ($this->pdtData['exchange_rate'] > 0 ? $this->pdtData['exchange_rate'] : 1.0),
                          'notify_version' => (float)$this->pdtData['notify_version'],
                          'verify_sign' => $this->pdtData['verify_sign'],
                          'date_added' => 'now()',
                          'memo' => '{Successful PDT Confirmation - Record auto-generated by payment module}'
                         );
      zen_db_perform(TABLE_PAYPAL, $sql_data_array);
    }
  }
  /**
   * Used to display error message details
   *
   * @return boolean
    */
  function output_error() {
    return false;
  }
  /**
   * Check to see whether module is installed
   *
   * @return boolean
    */
  function check() {
    global $db;
    if (IS_ADMIN_FLAG === true) {
      global $sniffer;
      if ($sniffer->field_exists(TABLE_PAYPAL, 'zen_order_id'))  $db->Execute("ALTER TABLE " . TABLE_PAYPAL . " CHANGE COLUMN zen_order_id order_id int(11) NOT NULL default '0'");
    }
    if (!isset($this->_check)) {
      $check_query = $db->Execute("select configuration_value from " . TABLE_CONFIGURATION . " where configuration_key = 'MODULE_PAYMENT_PAYPAL_STATUS'");
      $this->_check = $check_query->RecordCount();
    }
    return $this->_check;
  }
  /**
   * Install the payment module and its configuration settings
    *
    */
  function install() {
    global $db;
    $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('PayPal 支払いを有効にする', 'MODULE_PAYMENT_PAYPAL_STATUS', 'False', 'PayPal での支払いを有効にしますか？', '6', '0', 'zen_cfg_select_option(array(\'True\', \'False\'), ', now())");
    $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Business ID', 'MODULE_PAYMENT_PAYPAL_BUSINESS_ID','".STORE_OWNER_EMAIL_ADDRESS."', 'PayPal アカウントのメールアドレスです。<br />注意: 入力されたメールアドレスは、PayPalに登録されている<strong>「主」ステータスのメールアドレスと完全に一致</strong>している必要があります。 <strong>非常に重要な設定です。</strong> paypal.com　の「個人設定」で登録されている「主」ステータスで登録されているメールアドレスを正確に入力してください。', '6', '2', now())");
    $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('取引通貨', 'MODULE_PAYMENT_PAYPAL_CURRENCY', '取引通貨を設定してください。', 'PayPalに送信する通貨を指定します。 <br />注意: サポートされていない通貨を選択した場合、自動的に USD に変更されます。<br />（Selected Currency=ショップで選択されている通貨）<br /> 通常は 「Only JPY」（日本円）を選択してください。', '6', '3', 'zen_cfg_select_option(array(\'Selected Currency\', \'Only USD\', \'Only AUD\', \'Only CAD\', \'Only EUR\', \'Only GBP\', \'Only CHF\', \'Only CZK\', \'Only DKK\', \'Only HKD\', \'Only HUF\', \'Only JPY\', \'Only NOK\', \'Only NZD\', \'Only PLN\', \'Only SEK\', \'Only SGD\', \'Only THB\'), ', now())");
    $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) values ('適用地域', 'MODULE_PAYMENT_PAYPAL_ZONE', '0', '適用地域を選択すると、選択した地域のみで利用可能となります。', '6', '4', 'zen_get_zone_class_title', 'zen_cfg_pull_down_zone_classes(', now())");
    $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, use_function, date_added) values ('処理中 注文ステータス', 'MODULE_PAYMENT_PAYPAL_PROCESSING_STATUS_ID', '" . DEFAULT_ORDERS_STATUS_ID .  "', '注文完了時に適用される注文ステータスを設定します。<br />(「処理待ち」推奨)', '6', '5', 'zen_cfg_pull_down_order_statuses(', 'zen_get_order_status_name', now())");
    $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, use_function, date_added) values ('支払い完了 注文ステータス', 'MODULE_PAYMENT_PAYPAL_ORDER_STATUS_ID', '2', '支払い完了時に適用される注文ステータスを設定します。<br />(「処理中」推奨)', '6', '6', 'zen_cfg_pull_down_order_statuses(', 'zen_get_order_status_name', now())");
    $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, use_function, date_added) values ('払い戻し 注文ステータス', 'MODULE_PAYMENT_PAYPAL_REFUND_ORDER_STATUS_ID', '1', '払い戻し発生時に適用される注文ステータスを設定します。<br />(「処理待ち」推奨)', '6', '7', 'zen_cfg_pull_down_order_statuses(', 'zen_get_order_status_name', now())");
    $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('表示の整列順', 'MODULE_PAYMENT_PAYPAL_SORT_ORDER', '0', '表示の整列順を設定できます。数字が小さいほど上位に表示されます。', '6', '8', now())");
    //     $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('取扱手数料', 'MODULE_PAYMENT_PAYPAL_HANDLING', '0', '取扱時に手数料を加算します。この項目は数量とは関係がありません。 購入商品数に関わらず同じ手数料が加算されます。 もし、省略するか 0 と設定すると手数料は加算されません。', '6', '15', now())");
    $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('住所の上書き', 'MODULE_PAYMENT_PAYPAL_ADDRESS_OVERRIDE', '', ' 1 に設定すると、ZenCart から送信された住所によって、購入者が PayPalに登録している住所が置き換わります。 利用者には ZenCart で入力した住所が表示されますが変更する事ができません。もし、住所が正しくない場合(例えば、国名などの必要項目が入力されていないなど)は、住所自体が表示されません。<br />空欄 = 上書きしない<br />1 = ZenCart が送信した住所で PayPal 上の登録住所を置き換える', '6', '18', 'zen_cfg_select_option(array(\'\',\'1\'), ', now())");
    $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('配送住所オプション', 'MODULE_PAYMENT_PAYPAL_ADDRESS_REQUIRED', '1', '購入者の配送先住所。 0 に設定した場合、利用者は配送先住所を入力するよう促されます。 1 に設定した場合、配送先住所の指定は表示されません。 2 に設定した場合は、配送先住所の入力が必須になります。<br />0=選択可<br />1=非表示<br />2=入力必須<br /><br /><strong>注意: 購入者が自由に配送先住所を指定できるように設定した場合は、注文処理において、PayPal 支払いの詳細が正しいアドレスである事を間違いなく確認するようにしてください。ZenCart側では、注文時に入力した配送先住所と別の住所が入力されてもそれを知る方法がありません。</strong>', '6', '20', 'zen_cfg_select_option(array(\'0\',\'1\',\'2\'), ', now())");
    $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('商品項目の詳細', 'MODULE_PAYMENT_PAYPAL_DETAILED_CART', 'No', 'PayPal に商品項目の詳細を送信しますか？ True　に設定した場合、商品項目の詳細をPayPalに知らせることになります。もし、割引や商品項目の詳細をPayPalに知らせることになります。もし、割引の適用や税、送料などがシンプルなものであれば。そうでなければ、全体でのようやくが送信されます。', '6', '22', 'zen_cfg_select_option(array(\'No\',\'Yes\'), ', now())");
    $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('ページのスタイル', 'MODULE_PAYMENT_PAYPAL_PAGE_STYLE', 'Primary', '支払ページの表示スタイルを設定してください。<br />PayPal で「ページのスタイル」を追加・編集する際に選択した「ページのスタイル名」です。<br />「ページのスタイル」のカスタマイズは、PayPal サイトの「マイアカウント」＞「個人設定」＞「カスタム支払いページ」より行う事ができます。もし常に「主」に設定してあるスタイルを表示させる場合は、 \"primary\" と設定します。もし、もしデフォルトの PayPal ページを利用する場合は、\"paypal\"と設定します。', '6', '25', now())");
    $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('PayPal ウェブサービス接続先<br /><br />デフォルト:<br /><code>www.paypal.com/cgi-bin/webscr</code><br />もしくは、<br /><code>www.paypal.com/us/cgi-bin/webscr</code><br />英国の場合、<br /><code>www.paypal.com/uk/cgi-bin/webscr</code>', 'MODULE_PAYMENT_PAYPAL_HANDLER', 'www.paypal.com/cgi-bin/webscr', 'PayPal とのオンライン取引のためのURLを入力します。', '6', '73', '', now())");
// sandbox:  www.sandbox.paypal.com/cgi-bin/webscr
    $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, use_function) values ('支払いデータ転送 IDトークン', 'MODULE_PAYMENT_PAYPAL_PDTTOKEN', '', '処理後すぐに取引を有効にするために、「IDトークン」を入力します。 (承認通った場合)<br />「IDトークン」は、PayPal のマイアカウントより「個人設定」＞「ウェブサイト決済の設定」画面内の「支払いデータ転送(オプション)」項目で確認できます。', '6', '25', now(), 'zen_cfg_password_display')");

    // Paypal testing options go here
    $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('デバッグモード', 'MODULE_PAYMENT_PAYPAL_IPN_DEBUG', 'Off', 'デバッグログを保存しますか? <br />注意: メールボックスに多量のメールが届くようになります！<br />ログは /includes/modules/payment/paypal/logs フォルダに保存されます。<br />メールは、ショップ管理者メールアドレスに送信されます。<br /><strong>通常の運営では OFF に設定しておいてください。</strong>', '6', '71', 'zen_cfg_select_option(array(\'Off\',\'Log File\',\'Log and Email\'), ', now())");
    $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('ステータス Live（本番）/Testing（テスト）', 'MODULE_PAYMENT_PAYPAL_TESTING', 'Live', 'PayPal module の実行環境を設定します　Live（本番環境）、Test（テスト環境）', '6', '1', 'zen_cfg_select_option(array(\'Live\', \'Test\'), ', now())");
    $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('デバグ用メールアドレス', 'MODULE_PAYMENT_PAYPAL_DEBUG_EMAIL_ADDRESS','".STORE_OWNER_EMAIL_ADDRESS."', 'PayPal デバギング用のメールアドレスです', '6', '72', now())");

    $this->notify('NOTIFY_PAYMENT_PAYPAL_INSTALLED');
  }
  /**
   * Remove the module and all its settings
    *
    */
  function remove() {
    global $db;
    $db->Execute("delete from " . TABLE_CONFIGURATION . " where configuration_key LIKE 'MODULE\_PAYMENT\_PAYPAL\_%'");
    $this->notify('NOTIFY_PAYMENT_PAYPAL_UNINSTALLED');
  }
  /**
   * Internal list of configuration keys used for configuration of the module
   *
   * @return array
    */
  function keys() {
    $keys_list = array(
                       'MODULE_PAYMENT_PAYPAL_STATUS',
                       'MODULE_PAYMENT_PAYPAL_BUSINESS_ID',
                       'MODULE_PAYMENT_PAYPAL_PDTTOKEN',
                       'MODULE_PAYMENT_PAYPAL_CURRENCY',
                       'MODULE_PAYMENT_PAYPAL_ZONE',
                       'MODULE_PAYMENT_PAYPAL_PROCESSING_STATUS_ID',
                       'MODULE_PAYMENT_PAYPAL_ORDER_STATUS_ID',
                       'MODULE_PAYMENT_PAYPAL_REFUND_ORDER_STATUS_ID',
                       'MODULE_PAYMENT_PAYPAL_SORT_ORDER',
                       //         'MODULE_PAYMENT_PAYPAL_DETAILED_CART',
                       //         'MODULE_PAYMENT_PAYPAL_ADDRESS_OVERRIDE' ,
                       //         'MODULE_PAYMENT_PAYPAL_ADDRESS_REQUIRED' ,
                       'MODULE_PAYMENT_PAYPAL_PAGE_STYLE' ,
                       'MODULE_PAYMENT_PAYPAL_HANDLER',
                        );

    // Paypal testing/debug options go here:
    $keys_list[]='MODULE_PAYMENT_PAYPAL_IPN_DEBUG';
    if (IS_ADMIN_FLAG === true) {
      if (isset($_GET['debug']) && $_GET['debug']=='on') {
        $keys_list[]='MODULE_PAYMENT_PAYPAL_DEBUG_EMAIL_ADDRESS';  /* this defaults to store-owner-email-address */
        $keys_list[]='MODULE_PAYMENT_PAYPAL_TESTING';  /* this is for ipn_test tools, for developers only */
      }
      // to enable detailed cart contents --- BETA MODE
      if (isset($_GET['beta']) && $_GET['beta']=='details') {
        $keys_list[]='MODULE_PAYMENT_PAYPAL_DETAILED_CART';
      }
    }
    return $keys_list;
  }

  function _getPDTresults($orderAmount, $my_currency) {
    global $db;
    $ipnData  = ipn_postback('PDT');
    $respdata = $ipnData['info'];

    // parse the data
    $lines = explode("\n", $respdata);
    $this->pdtData = array();
    for ($i=1; $i<count($lines);$i++){
      if (!strstr($lines[$i], "=")) continue;
      list($key,$val) = explode("=", $lines[$i]);
      $this->pdtData[urldecode($key)] = mb_convert_encoding(urldecode($val), 'UTF-8', 'auto');
    }

    ipn_debug_email('PDT Returned Data ' . print_r($this->pdtData, true));

    $_POST['mc_gross'] = $this->pdtData['mc_gross'];
    $_POST['mc_currency'] = $this->pdtData['mc_currency'];
    $_POST['business'] = $this->pdtData['business'];
    $_POST['receiver_email'] = $this->pdtData['receiver_email'];

    $PDTstatus = (ipn_validate_transaction($respdata, $this->pdtData, 'PDT') && valid_payment($orderAmount, $my_currency, 'PDT') && $this->pdtData['payment_status'] == 'Completed');
    if ($this->pdtData['payment_status'] != 'Completed') {
      ipn_debug_email('PDT WARNING :: Order not marked as "Completed".  Check for Pending reasons or wait for IPN to complete.' . "\n" . '[payment_status] => ' . $this->pdtData['payment_status'] . "\n" . '[pending_reason] => ' . $this->pdtData['pending_reason']);
    }

    $useTable = (MODULE_PAYMENT_PAYPAL_TESTING == 'Test') ? TABLE_PAYPAL_TESTING : TABLE_PAYPAL;
    $sql = "SELECT order_id, paypal_ipn_id, payment_status, txn_type, pending_reason
                FROM " . $useTable . "
                WHERE txn_id = :transactionID OR parent_txn_id = :transactionID
                ORDER BY order_id DESC  ";
    $sql = $db->bindVars($sql, ':transactionID', $this->pdtData['txn_id'], 'string');
    $ipn_id = $db->Execute($sql);
    if($ipn_id->RecordCount() != 0) {
      ipn_debug_email('PDT WARNING :: Transaction already exists. Perhaps IPN already added it.  PDT processing ended.');
      $pdtTXN_is_unique = false;
    } else {
      $pdtTXN_is_unique = true;
    }

    $PDTstatus = ($pdtTXN_is_unique && $PDTstatus);

    return $PDTstatus;
  }


  function tableCheckup() {
    global $db, $sniffer;
    $fieldOkay1 = (method_exists($sniffer, 'field_type')) ? $sniffer->field_type(TABLE_PAYPAL, 'txn_id', 'varchar(20)', true) : -1;
    $fieldOkay2 = ($sniffer->field_exists(TABLE_PAYPAL, 'module_name')) ? true : -1;
    $fieldOkay3 = ($sniffer->field_exists(TABLE_PAYPAL, 'order_id')) ? true : -1;

    if ($fieldOkay1 == -1) {
      $sql = "show fields from " . TABLE_PAYPAL;
      $result = $db->Execute($sql);
      while (!$result->EOF) {
        if  ($result->fields['Field'] == 'txn_id') {
          if  ($result->fields['Type'] == 'varchar(20)') {
            $fieldOkay1 = true; // exists and matches required type, so skip to other checkup
          } else {
            $fieldOkay1 = $result->fields['Type']; // doesn't match, so return what it "is"
            break;
          }
        }
        $result->MoveNext();
      }
    }

    if ($fieldOkay1 !== true) {
      // temporary fix to table structure for v1.3.7.x -- will remove in later release
      $db->Execute("ALTER TABLE " . TABLE_PAYPAL . " CHANGE payment_type payment_type varchar(40) NOT NULL default ''");
      $db->Execute("ALTER TABLE " . TABLE_PAYPAL . " CHANGE txn_type txn_type varchar(40) NOT NULL default ''");
      $db->Execute("ALTER TABLE " . TABLE_PAYPAL . " CHANGE payment_status payment_status varchar(32) NOT NULL default ''");
      $db->Execute("ALTER TABLE " . TABLE_PAYPAL . " CHANGE reason_code reason_code varchar(40) default NULL");
      $db->Execute("ALTER TABLE " . TABLE_PAYPAL . " CHANGE pending_reason pending_reason varchar(32) default NULL");
      $db->Execute("ALTER TABLE " . TABLE_PAYPAL . " CHANGE invoice invoice varchar(128) default NULL");
      $db->Execute("ALTER TABLE " . TABLE_PAYPAL . " CHANGE payer_business_name payer_business_name varchar(128) default NULL");
      $db->Execute("ALTER TABLE " . TABLE_PAYPAL . " CHANGE address_name address_name varchar(64) default NULL");
      $db->Execute("ALTER TABLE " . TABLE_PAYPAL . " CHANGE address_street address_street varchar(254) default NULL");
      $db->Execute("ALTER TABLE " . TABLE_PAYPAL . " CHANGE address_city address_city varchar(120) default NULL");
      $db->Execute("ALTER TABLE " . TABLE_PAYPAL . " CHANGE address_state address_state varchar(120) default NULL");
      $db->Execute("ALTER TABLE " . TABLE_PAYPAL . " CHANGE payer_email payer_email varchar(128) NOT NULL default ''");
      $db->Execute("ALTER TABLE " . TABLE_PAYPAL . " CHANGE business business varchar(128) NOT NULL default ''");
      $db->Execute("ALTER TABLE " . TABLE_PAYPAL . " CHANGE receiver_email receiver_email varchar(128) NOT NULL default ''");
      $db->Execute("ALTER TABLE " . TABLE_PAYPAL . " CHANGE txn_id txn_id varchar(20) NOT NULL default ''");
      $db->Execute("ALTER TABLE " . TABLE_PAYPAL . " CHANGE parent_txn_id parent_txn_id varchar(20) default NULL");
    }
    if ($fieldOkay2 !== true) {
      $db->Execute("ALTER TABLE " . TABLE_PAYPAL . " ADD COLUMN module_name varchar(40) NOT NULL default '' after txn_type");
      $db->Execute("ALTER TABLE " . TABLE_PAYPAL . " ADD COLUMN module_mode varchar(40) NOT NULL default '' after module_name");
    }
    if ($fieldOkay3 !== true) {
      $db->Execute("ALTER TABLE " . TABLE_PAYPAL . " CHANGE zen_order_id order_id int(11) NOT NULL default '0'");
    }
  }

}
?>
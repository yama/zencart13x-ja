<?php
/*
  $Id: cod_table.php 17 2008-02-14 03:43:21Z bigmouse-sugimoto $

  osCommerce, Open Source E-Commerce Solutions
  http://www.oscommerce.com

  Copyright (c) 2003 osCommerce

  Released under the GNU General Public License
*/
  class cod_table {
    var $code, $title, $description, $enabled;
    var $n_fee, $s_error;
    var $email_footer;

// class constructor
    function cod_table() {
      global $order;

      $this->code = 'cod_table';
      $this->title       = MODULE_PAYMENT_COD_TABLE_TEXT_TITLE;
      $this->description = MODULE_PAYMENT_COD_TABLE_TEXT_DESCRIPTION;
      $this->sort_order  = MODULE_PAYMENT_COD_TABLE_SORT_ORDER;
      $this->enabled = ((MODULE_PAYMENT_COD_TABLE_STATUS == 'True') ? true : false);

      if ((int)MODULE_PAYMENT_COD_TABLE_ORDER_STATUS_ID > 0) {
        $this->order_status = MODULE_PAYMENT_COD_TABLE_ORDER_STATUS_ID;
      }

      if (is_object($order)) $this->update_status();

      $this->email_footer = MODULE_PAYMENT_COD_TABLE_TEXT_PROCESS;
    }

// class methods
    function update_status() {
      global $db;
      global $order;
      if ( ($this->enabled == true) && ((int)MODULE_PAYMENT_COD_TABLE_ZONE > 0) ) {

        $check_flag = false;
        $check = $db->Execute("select zone_id from " . TABLE_ZONES_TO_GEO_ZONES . " where geo_zone_id = '" . MODULE_PAYMENT_COD_TABLE_ZONE . "' and zone_country_id = '" . $order->billing['country']['id'] . "' order by zone_id");

        while (!$check->EOF) {
          if ($check->fields['zone_id'] < 1) {
            $check_flag = true;
            break;
          } elseif ($check->fields['zone_id'] == $order->delivery['zone_id']) {
            $check_flag = true;
            break;
          }
          $check->MoveNext();
        }

        if ($check_flag == false) {
          $this->enabled = false;
        }
      }

    if (($this->enabled == true) && MODULE_PAYMENT_COD_TABLE_SHIPPING_PAYMENT == 'False') {
      if ($this->enabled == true) {
        if ($_SESSION['sendto'] != $_SESSION['billto']) {
          $this->enabled = false;
        }
      }
    }
// disable the module if the order only contains virtual products
      if ($this->enabled == true) {
        if ($order->content_type != 'physical') {
          $this->enabled = false;
        }
      }

      if (MODULE_PAYMENT_COD_TABLE_SHIPPING_MODULE != '') {
        $this->enabled = false;
        $shipping_modules = split(',', MODULE_PAYMENT_COD_TABLE_SHIPPING_MODULE);
        list($session_shipping) = split('_', $_SESSION['shipping']['id']);
        if (in_array($session_shipping, $shipping_modules)) $this->enabled = true;
      }
    }

    function calc_fee($total_cost) {
      $table_fee = split("[:,]" , MODULE_PAYMENT_COD_TABLE_COST);
      $f_find = false;
      $this->n_fee = 0;
      for ($i = 0; $i < count($table_fee); $i+=2) {
        if ($total_cost <= $table_fee[$i]) {
          $this->n_fee = $table_fee[$i+1];
          $f_find = true;
          break;
        }
      }
      if ( !$f_find ) {
        $this->s_error = MODULE_PAYMENT_COD_TABLE_TEXT_OVERFLOW_ERROR;
      }

      return $f_find;
    }

// class methods
    function javascript_validation() {
      return false;
    }

    function selection() {
      global $currencies;
      global $order;

      $total_cost = $order->info['total'];
      $f_result = $this->calc_fee($total_cost);

      $added_hidden = $f_result
          ? zen_draw_hidden_field('codt_fee', $this->n_fee).zen_draw_hidden_field('cod_total_cost', $total_cost)
          : zen_draw_hidden_field('codt_fee_error', $this->s_error);

      $s_message = $f_result
        ? (MODULE_PAYMENT_COD_TABLE_TEXT_FEE . '&nbsp;' . $currencies->format($this->n_fee))
        : ('<font color="#FF0000">' . $this->s_error . '</font>');

      $selection = array(
          'id' => $this->code,
          'module' => $this->title,
          'fields' => array(array('title' => MODULE_PAYMENT_COD_TABLE_TEXT_PROCESS,
                                  'field' => ''),
                            array('title' => $s_message,
                                  'field' => $added_hidden))
      );

      return $selection;
    }

    function pre_confirmation_check() {
    	global $messageStack ,$order;
    	 $total_cost = $order->info['total'];
    	 $f_result = $this->calc_fee($total_cost);
	    if ( !$f_result ) {
	      $messageStack->add_session('checkout_payment', MODULE_PAYMENT_COD_TABLE_TEXT_OVERFLOW_ERROR . '['.$this->title.']', 'error');
	      zen_redirect(zen_href_link(FILENAME_CHECKOUT_PAYMENT, '', 'SSL', true, false));
	    }
      return false;
    }

    function confirmation() {
      global $currencies;

      $s_result = !$_POST['codt_fee_error'];
      $s_message = $s_result
        ? (MODULE_PAYMENT_COD_TABLE_TEXT_FEE . '&nbsp;' . $currencies->format($_POST['codt_fee']))
        : ('<font color="#FF0000">' . $_POST['codt_fee_error'] . '</font>');

      $confirmation = array(
          'title' => $this->title,
          'fields' => array(array('title' => MODULE_PAYMENT_COD_TABLE_TEXT_PROCESS,
                                  'field' => ''),
                            array('title' => $s_message,
                                  'field' => ''),
                           )
      );
      return $confirmation;
    }

    function process_button() {
      global $currencies;
      global $order;

      $s_message = $_POST['codt_fee_error']
        ? $_POST['codt_fee_error']
        : MODULE_PAYMENT_COD_TABLE_TEXT_MAILFOOTER;

      return zen_draw_hidden_field('codt_message', $s_message)
           . zen_draw_hidden_field('codt_fee',$_POST['codt_fee']); // for ot_codt
    }

    function before_process() {
      $this->email_footer = $_POST['codt_message'];
    }

    function after_process() {
      return false;
    }

    function get_error() {
      return false;
    }

    function check() {
      global $db;
      if (!isset($this->_check)) {
        $check_query = $db->Execute("select configuration_value from " . TABLE_CONFIGURATION . " where configuration_key = 'MODULE_PAYMENT_COD_TABLE_STATUS'");
        $this->_check = $check_query->RecordCount();
      }
      return $this->_check;
    }

    function install() {
      global $db;
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('代金引換払いを有効にする', 'MODULE_PAYMENT_COD_TABLE_STATUS', 'False', '代金引換による支払いを有効にする<br />支払い総額に代金引換手数料を加算したい時には<br />注文合計モジュールの ot_cod_table を有効にしてください。', '6', '1', 'zen_cfg_select_option(array(\'True\', \'False\'), ',now());");

      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('代引手数料の計算表', 'MODULE_PAYMENT_COD_TABLE_COST', '9999:315,29999:420,99999:630,299999:1050', '支払い金額に連動する代引手数料. 例: 9999:315,29999:420,99999:630,299999:1050 ... 9999円まで315円, 29999円まで420円, ...', '6', '2', now())");

      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('表示の整列順', 'MODULE_PAYMENT_COD_TABLE_SORT_ORDER', '0', '表示の整列順を設定できます。数字が小さいほど上位に表示されます.', '6', '0' , now())");

      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) values ('適用地域', 'MODULE_PAYMENT_COD_TABLE_ZONE', '0', '適用地域を選択すると、選択した地域のみで利用可能となります.', '6', '3', 'zen_get_zone_class_title', 'zen_cfg_pull_down_zone_classes(', now())");

      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, use_function, date_added) values ('初期注文ステータス', 'MODULE_PAYMENT_COD_TABLE_ORDER_STATUS_ID', '0', '設定したステータスが受注時に適用されます.', '6', '4', 'zen_cfg_pull_down_order_statuses(', 'zen_get_order_status_name', now())");

      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('配送方法選択', 'MODULE_PAYMENT_COD_TABLE_SHIPPING_MODULE', '', '代金引換モジュールを有効にする配送方法を指定できます。<br />代金引換モジュールを有効にしたい配送モジュールをカンマ区切りで入力してください。<br />例）flat,item<br />何も入力していない場合は全ての配送モジュールで利用可能となります。', '6', '0' , now())");

      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('配送先と支払い先', 'MODULE_PAYMENT_COD_TABLE_SHIPPING_PAYMENT', 'False', '配送先と支払い先が違っていても代金引換モジュールを有効にしますか？<br />True - 有効にする。<br />False - 無効にする。', '6', '1', 'zen_cfg_select_option(array(\'True\', \'False\'), ',now());");
    }

    function remove() {
      global $db;
      $db->Execute("delete from " . TABLE_CONFIGURATION . " where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
      return array(
          'MODULE_PAYMENT_COD_TABLE_STATUS',
          'MODULE_PAYMENT_COD_TABLE_COST',
          'MODULE_PAYMENT_COD_TABLE_SHIPPING_MODULE',
          'MODULE_PAYMENT_COD_TABLE_SHIPPING_PAYMENT',
          'MODULE_PAYMENT_COD_TABLE_SORT_ORDER',
          'MODULE_PAYMENT_COD_TABLE_ZONE',
          'MODULE_PAYMENT_COD_TABLE_ORDER_STATUS_ID'
      );
    }
  }
?>
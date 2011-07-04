<?php
/**
 * @copyright Copyright 2006-2008 Bigmouse, Inc
 * @copyright Portions Copyright 2003-2007 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: ot_atobaraicom.php 639 2009-10-02 05:45:52Z makiya $
**/

  class ot_atobaraicom {
    var $title, $output, $n_fee;

    function ot_atobaraicom() {
      $this->code = 'ot_atobaraicom';
      $this->title = MODULE_ORDER_TOTAL_ATOBARAICOM_ADMIN_TITLE;
      $this->description = MODULE_ORDER_TOTAL_ATOBARAICOM_DESCRIPTION;
      $this->enabled = ((MODULE_ORDER_TOTAL_ATOBARAICOM_STATUS == 'true') ? true : false);
      $this->sort_order = MODULE_ORDER_TOTAL_ATOBARAICOM_SORT_ORDER;
      $this->output = array();
    }

    function process() {
      global $currencies, $order;

      if ($_SESSION['payment'] == 'atobaraicom' && (int)MODULE_PAYMENT_ATOBARAICOM_COST > 0) {
            $this->output[] = array('title' => MODULE_ORDER_TOTAL_ATOBARAICOM_COST_TITLE . ':',
                                    'text' => $currencies->format((int)MODULE_PAYMENT_ATOBARAICOM_COST, true, $order->info['currency'], $order->info['currency_value']),
                                    'value' => (int)MODULE_PAYMENT_ATOBARAICOM_COST);
            $order->info['total'] = $order->info['total'] + (int)MODULE_PAYMENT_ATOBARAICOM_COST;
        }
      }

    function check() {
      global $db;
      if (!isset($this->_check)) {
        $check_query = $db->Execute("select configuration_value from " . TABLE_CONFIGURATION . " where configuration_key = 'MODULE_ORDER_TOTAL_ATOBARAICOM_STATUS'");
        $this->_check = $check_query->RecordCount();
      }

      return $this->_check;
    }
//lagt tilk servicepakke her!!!!
    function keys() {
      return array('MODULE_ORDER_TOTAL_ATOBARAICOM_STATUS', 'MODULE_ORDER_TOTAL_ATOBARAICOM_SORT_ORDER');
    }

    function install() {
      global $db;
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('後払い手数料', 'MODULE_ORDER_TOTAL_ATOBARAICOM_STATUS', 'true', '後払い手数料を表示しますか？', '6', '1','zen_cfg_select_option(array(\'true\', \'false\'), ', now())");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('ソート順', 'MODULE_ORDER_TOTAL_ATOBARAICOM_SORT_ORDER', '997', '表示の整列順を設定します。<br />数値が小さいほど上に表示されます。<br />※ot_totalモジュールよりも必ず上に表示させるようにしてください。', '6', '2', now())");
    }
    function remove() {
      global $db;
      $keys = '';
      $keys_array = $this->keys();
      $keys_size = sizeof($keys_array);
      for ($i=0; $i<$keys_size; $i++) {
        $keys .= "'" . $keys_array[$i] . "',";
      }
      $keys = substr($keys, 0, -1);

      $db->Execute("delete from " . TABLE_CONFIGURATION . " where configuration_key in (" . $keys . ")");
    }
  }
?>

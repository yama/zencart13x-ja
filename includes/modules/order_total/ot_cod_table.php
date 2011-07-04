<?php
/**
 * @version $Id: config.core.php 17 2008-02-14 03:43:21Z bigmouse-sugimoto $
 */
  class ot_cod_table {
    var $title, $output, $n_fee;

    function ot_cod_table() {
      $this->code = 'ot_cod_table';
      $this->title = MODULE_ORDER_TOTAL_COD_TABLE_ADMIN_TITLE;
      $this->description = MODULE_ORDER_TOTAL_COD_TABLE_DESCRIPTION;
      $this->enabled = ((MODULE_ORDER_TOTAL_COD_TABLE_STATUS == 'true') ? true : false);
      $this->sort_order = MODULE_ORDER_TOTAL_COD_TABLE_SORT_ORDER;

      $this->output = array();
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
      return $f_find;
    }

    function process() {
      global $currencies, $order;

      if ($_SESSION['payment'] == 'cod_table') {
        $total = $order->info['total'];
        $f_result = $this->calc_fee($total);
        $cod_table_cost = $this->n_fee;
        $payment_total = $total + $cod_table_cost;

            $this->output[] = array('title' => MODULE_ORDER_TOTAL_COD_TABLE_COST_TITLE . ':',
                                    'text' => $currencies->format($cod_table_cost, true, $order->info['currency'], $order->info['currency_value']),
                                    'value' => $cod_table_cost);
            $order->info['total'] = $order->info['total'] + $cod_table_cost;
        }
      }

    function check() {
      global $db;
      if (!isset($this->_check)) {
        $check_query = $db->Execute("select configuration_value from " . TABLE_CONFIGURATION . " where configuration_key = 'MODULE_ORDER_TOTAL_COD_TABLE_STATUS'");
        $this->_check = $check_query->RecordCount();
      }

      return $this->_check;
    }
//lagt tilk servicepakke her!!!!
    function keys() {
      return array('MODULE_ORDER_TOTAL_COD_TABLE_STATUS', 'MODULE_ORDER_TOTAL_COD_TABLE_SORT_ORDER');
    }

    function install() {
      global $db;
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('代金引換手数料', 'MODULE_ORDER_TOTAL_COD_TABLE_STATUS', 'true', '代金引換手数料を表示しますか？', '6', '1','zen_cfg_select_option(array(\'true\', \'false\'), ', now())");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('Sort Order', 'MODULE_ORDER_TOTAL_COD_TABLE_SORT_ORDER', '998', '表示の整列順を設定できます・数字が小さいほど上位に表示されます。<br>他の数字とかぶらないよう注意してください。<br />※ot_totalモジュールよりも必ず上に表示させるようにしてください。', '6', '2', now())");
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

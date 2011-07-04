<?php
/**
 * @package shippingMethod
 * @copyright Copyright 2003-2006 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: freeoptions.php 4238 2006-08-24 10:01:04Z drbyte $
 */

  class freeoptions extends base {
    var $code, $title, $description, $icon, $enabled;
    var $ck_freeoptions_total, $ck_freeoptions_weight, $ck_freeoptions_items;

// class constructor
    function freeoptions() {
      global $order, $db;

      $this->code = 'freeoptions';
      $this->title = MODULE_SHIPPING_FREEOPTIONS_TEXT_TITLE;
      $this->description = MODULE_SHIPPING_FREEOPTIONS_TEXT_DESCRIPTION;
      $this->sort_order = MODULE_SHIPPING_FREEOPTIONS_SORT_ORDER;
      $this->icon = '';
      $this->tax_class = MODULE_SHIPPING_FREEOPTIONS_TAX_CLASS;
      $this->tax_basis = MODULE_SHIPPING_FREEOPTIONS_TAX_BASIS;

      // disable only when entire cart is free shipping
      if (zen_get_shipping_enabled($this->code)) {
          $this->enabled = ((MODULE_SHIPPING_FREEOPTIONS_STATUS == 'True') ? true : false);
      }

      if ( ($this->enabled == true) && ((int)MODULE_SHIPPING_FREEOPTIONS_ZONE > 0) ) {
        $check_flag = false;
        $check = $db->Execute("select zone_id from " . TABLE_ZONES_TO_GEO_ZONES . " where geo_zone_id = '" . MODULE_SHIPPING_FREEOPTIONS_ZONE . "' and zone_country_id = '" . $order->delivery['country']['id'] . "' order by zone_id");
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
    }

// class methods
    function quote($method = '') {
      global $order;
      $order_weight = round($_SESSION['cart']->show_weight(),9);

      // check if anything is configured for total, weight or item
      if ((MODULE_SHIPPING_FREEOPTIONS_TOTAL_MIN !='' or MODULE_SHIPPING_FREEOPTIONS_TOTAL_MAX !='')) {
        $this->ck_freeoptions_total = true;
      } else {
        $this->ck_freeoptions_total = false;
      }
      if ((MODULE_SHIPPING_FREEOPTIONS_WEIGHT_MIN !='' or MODULE_SHIPPING_FREEOPTIONS_WEIGHT_MAX !='')) {
        $this->ck_freeoptions_weight = true;
      } else {
        $this->ck_freeoptions_weight = false;
      }
      if ((MODULE_SHIPPING_FREEOPTIONS_ITEMS_MIN !='' or MODULE_SHIPPING_FREEOPTIONS_ITEMS_MAX !='')) {
        $this->ck_freeoptions_items = true;
      } else {
        $this->ck_freeoptions_items = false;
      }
      if ($this->ck_freeoptions_total or $this->ck_freeoptions_weight or $this->ck_freeoptions_items) {
        $this->enabled = true;
      } else {
        $this->enabled = false;
      }

      // disabled if nothing validates for total, weight or item
      if ($this->enabled) {
        if ($this->ck_freeoptions_total) {
          switch (true) {
          case ((MODULE_SHIPPING_FREEOPTIONS_TOTAL_MIN !='' and MODULE_SHIPPING_FREEOPTIONS_TOTAL_MAX !='')):
// free shipping total should not need adjusting
//            if (($_SESSION['cart']->show_total() - $_SESSION['cart']->free_shipping_prices()) >= MODULE_SHIPPING_FREEOPTIONS_TOTAL_MIN and ($_SESSION['cart']->show_total() - $_SESSION['cart']->free_shipping_prices()) <= MODULE_SHIPPING_FREEOPTIONS_TOTAL_MAX) {
            if (($_SESSION['cart']->show_total()) >= MODULE_SHIPPING_FREEOPTIONS_TOTAL_MIN and ($_SESSION['cart']->show_total()) <= MODULE_SHIPPING_FREEOPTIONS_TOTAL_MAX) {
              $this->ck_freeoptions_total = true;
            } else {
              $this->ck_freeoptions_total = false;
            }
            break;
          case ((MODULE_SHIPPING_FREEOPTIONS_TOTAL_MIN !='')):
//            if (($_SESSION['cart']->show_total() - $_SESSION['cart']->free_shipping_prices()) >= MODULE_SHIPPING_FREEOPTIONS_TOTAL_MIN) {
            if (($_SESSION['cart']->show_total()) >= MODULE_SHIPPING_FREEOPTIONS_TOTAL_MIN) {
              $this->ck_freeoptions_total = true;
            } else {
              $this->ck_freeoptions_total = false;
            }
            break;
          case ((MODULE_SHIPPING_FREEOPTIONS_TOTAL_MAX !='')):
//            if (($_SESSION['cart']->show_total() - $_SESSION['cart']->free_shipping_prices()) <= MODULE_SHIPPING_FREEOPTIONS_TOTAL_MAX) {
            if (($_SESSION['cart']->show_total()) <= MODULE_SHIPPING_FREEOPTIONS_TOTAL_MAX) {
              $this->ck_freeoptions_total = true;
            } else {
              $this->ck_freeoptions_total = false;
            }
            break;
          }
        }

        if ($this->ck_freeoptions_weight) {
          switch (true) {
          case ((MODULE_SHIPPING_FREEOPTIONS_WEIGHT_MIN !='' and MODULE_SHIPPING_FREEOPTIONS_WEIGHT_MAX !='')):
            if ($order_weight >= MODULE_SHIPPING_FREEOPTIONS_WEIGHT_MIN and $order_weight <= MODULE_SHIPPING_FREEOPTIONS_WEIGHT_MAX) {
              $this->ck_freeoptions_weight = true;
            } else {
              $this->ck_freeoptions_weight = false;
            }
            break;
          case ((MODULE_SHIPPING_FREEOPTIONS_WEIGHT_MIN !='')):
            if ($order_weight >= MODULE_SHIPPING_FREEOPTIONS_WEIGHT_MIN) {
              $this->ck_freeoptions_weight = true;
            } else {
              $this->ck_freeoptions_weight = false;
            }
            break;
          case ((MODULE_SHIPPING_FREEOPTIONS_WEIGHT_MAX !='')):
            if ($order_weight <= MODULE_SHIPPING_FREEOPTIONS_WEIGHT_MAX) {
              $this->ck_freeoptions_weight = true;
            } else {
              $this->ck_freeoptions_weight = false;
            }
            break;
          }
        }

        if ($this->ck_freeoptions_items) {
          switch (true) {
          case ((MODULE_SHIPPING_FREEOPTIONS_ITEMS_MIN !='' and MODULE_SHIPPING_FREEOPTIONS_ITEMS_MAX !='')):
// free shipping items should not need adjusting
//            if (($_SESSION['cart']->count_contents() - $_SESSION['cart']->free_shipping_items()) >= MODULE_SHIPPING_FREEOPTIONS_ITEMS_MIN and ($_SESSION['cart']->count_contents() - $_SESSION['cart']->free_shipping_items()) <= MODULE_SHIPPING_FREEOPTIONS_ITEMS_MAX) {
            if (($_SESSION['cart']->count_contents()) >= MODULE_SHIPPING_FREEOPTIONS_ITEMS_MIN and ($_SESSION['cart']->count_contents()) <= MODULE_SHIPPING_FREEOPTIONS_ITEMS_MAX) {
              $this->ck_freeoptions_items = true;
            } else {
              $this->ck_freeoptions_items = false;
            }
            break;
          case ((MODULE_SHIPPING_FREEOPTIONS_ITEMS_MIN !='')):
//            if (($_SESSION['cart']->count_contents() - $_SESSION['cart']->free_shipping_items()) >= MODULE_SHIPPING_FREEOPTIONS_ITEMS_MIN) {
            if (($_SESSION['cart']->count_contents()) >= MODULE_SHIPPING_FREEOPTIONS_ITEMS_MIN) {
              $this->ck_freeoptions_items = true;
            } else {
              $this->ck_freeoptions_items = false;
            }
            break;
          case ((MODULE_SHIPPING_FREEOPTIONS_ITEMS_MAX !='')):
//            if (($_SESSION['cart']->count_contents() - $_SESSION['cart']->free_shipping_items())<= MODULE_SHIPPING_FREEOPTIONS_ITEMS_MAX) {
            if (($_SESSION['cart']->count_contents())<= MODULE_SHIPPING_FREEOPTIONS_ITEMS_MAX) {
              $this->ck_freeoptions_items = true;
            } else {
              $this->ck_freeoptions_items = false;
            }
            break;
          }
        }
      }

/*
echo 'I see count: ' . $_SESSION['cart']->count_contents() . ' free count: ' . $_SESSION['cart']->free_shipping_items() . '<br>' .
'I see weight: ' . $_SESSION['cart']->show_weight() . '<br>' .
'I see total: ' . $_SESSION['cart']->show_total() . ' free price: ' . $_SESSION['cart']->free_shipping_prices() . '<br>' .
'Final check ' . ($this->ck_freeoptions_total ? 'T: YES ' : 'T: NO ') . ($this->ck_freeoptions_weight ? 'W: YES ' : 'W: NO ') . ($this->ck_freeoptions_items ? 'I: YES ' : 'I: NO ') . '<br>';
*/

// final check for display of Free Options
      if ($this->ck_freeoptions_total or $this->ck_freeoptions_weight or $this->ck_freeoptions_items) {
        $this->enabled = true;
      } else {
        $this->enabled = false;
      }

      if ($this->enabled) {
        $this->quotes = array('id' => $this->code,
                              'module' => MODULE_SHIPPING_FREEOPTIONS_TEXT_TITLE,
                              'methods' => array(array('id' => $this->code,
                                                       'title' => MODULE_SHIPPING_FREEOPTIONS_TEXT_WAY,
                                                       'cost'  => MODULE_SHIPPING_FREEOPTIONS_COST + MODULE_SHIPPING_FREEOPTIONS_HANDLING)));
      }

      if ($this->tax_class > 0) {
        $this->quotes['tax'] = zen_get_tax_rate($this->tax_class, $order->delivery['country']['id'], $order->delivery['zone_id']);
      }

      if (zen_not_null($this->icon)) $this->quotes['icon'] = zen_image($this->icon, $this->title);

      return $this->quotes;
    }

    function check() {
      global $db;
      if (!isset($this->_check)) {
        $check_query = $db->Execute("select configuration_value from " . TABLE_CONFIGURATION . " where configuration_key = 'MODULE_SHIPPING_FREEOPTIONS_STATUS'");
        $this->_check = $check_query->RecordCount();
      }
      return $this->_check;
    }

    function install() {
      global $db;
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('配送料無料オプションを有効にする', 'MODULE_SHIPPING_FREEOPTIONS_STATUS', 'False', '無料オプションは他の配送モジュールが表示されている時に配送料無料オプションを表示するために使用します。常に表示、注文合計金額、注文重量または注文点数を基準に設定できます。この無料オプションモジュールは配送料無料が表示されているときは見えません。<br><br>対象合計金額を0円以上に設定し、なおかつ0円以下にも設定すると配送料無料以外の全てのモジュールに有効になります。<br><br>注意: 合計、重量、点数の全ての設定を空欄にするとこのモジュールを無効になります。<br><br>注意: 配送料無料オプションは重量０で無料に設定されていると表示されません。配送料無料モジュールを参照してください<br><br>
配送料無料オプションを有効にしますか？', '6', '0', 'zen_cfg_select_option(array(\'True\', \'False\'), ', now())");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('配送料', 'MODULE_SHIPPING_FREEOPTIONS_COST', '0.00', '配送料は 0円になります。', '6', '0', now())");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('取扱い手数料', 'MODULE_SHIPPING_FREEOPTIONS_HANDLING', '0', 'この配送方法を利用した場合の取扱い手数料。.', '6', '0', now())");

      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('対象合計金額（以上）', 'MODULE_SHIPPING_FREEOPTIONS_TOTAL_MIN', '0.00', '合計がいくら以上で配送料無料になりますか', '6', '0', now())");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('対象合計金額（以下）', 'MODULE_SHIPPING_FREEOPTIONS_TOTAL_MAX', '', '合計がいくら以下で配送料無料になりますか', '6', '0', now())");

      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('対象重量（以上）', 'MODULE_SHIPPING_FREEOPTIONS_WEIGHT_MIN', '', '重量が何キロ以上で配送料無料になりますか', '6', '0', now())");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('対象重量（以下）', 'MODULE_SHIPPING_FREEOPTIONS_WEIGHT_MAX', '', '重量が何キロ以下で配送料無料になりますか', '6', '0', now())");

      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('対象商品点数（以上）', 'MODULE_SHIPPING_FREEOPTIONS_ITEMS_MIN', '', '商品点数がいくつ以上で配送料無料になりますか', '6', '0', now())");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('対象商品点数（以下）', 'MODULE_SHIPPING_FREEOPTIONS_ITEMS_MAX', '', '商品点数がいくつ以下で配送料無料になりますか', '6', '0', now())");

      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) values ('税種別', 'MODULE_SHIPPING_FREEOPTIONS_TAX_CLASS', '0', '配送料に適用される税種別を設定できます', '6', '0', 'zen_get_tax_class_title', 'zen_cfg_pull_down_tax_classes(', now())");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('税率の計算ベース', 'MODULE_SHIPPING_FREEOPTIONS_TAX_BASIS', 'Shipping', '配送料にかかる税金オプションの設定します。<br><br>・Shipping - 顧客の送付先住所に基づく<br>・Billing - 顧客の請求先住所に基づく<br>・Store - ショップの所在住所に基づく(送付先/請求先がショップ所在地と同じ地域の場合に有効)', '6', '0', 'zen_cfg_select_option(array(\'Shipping\', \'Billing\', \'Store\'), ', now())");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) values ('配送地域', 'MODULE_SHIPPING_FREEOPTIONS_ZONE', '0', '配送地域を選択すると選択された地域のみで利用可能となります', '6', '0', 'zen_get_zone_class_title', 'zen_cfg_pull_down_zone_classes(', now())");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('表示の整列順', 'MODULE_SHIPPING_FREEOPTIONS_SORT_ORDER', '0', '表示の整列順を設定できます. 数字が小さいほど上位に表示されます', '6', '0', now())");
    }

   function remove() {
     global $db;
     $db->Execute("delete from " . TABLE_CONFIGURATION . " where configuration_key LIKE  'MODULE_SHIPPING_FREEOPTIONS_%'");
   }

    function keys() {
      return array('MODULE_SHIPPING_FREEOPTIONS_STATUS', 'MODULE_SHIPPING_FREEOPTIONS_COST', 'MODULE_SHIPPING_FREEOPTIONS_HANDLING', 'MODULE_SHIPPING_FREEOPTIONS_TOTAL_MIN', 'MODULE_SHIPPING_FREEOPTIONS_TOTAL_MAX', 'MODULE_SHIPPING_FREEOPTIONS_WEIGHT_MIN', 'MODULE_SHIPPING_FREEOPTIONS_WEIGHT_MAX', 'MODULE_SHIPPING_FREEOPTIONS_ITEMS_MIN', 'MODULE_SHIPPING_FREEOPTIONS_ITEMS_MAX', 'MODULE_SHIPPING_FREEOPTIONS_TAX_CLASS', 'MODULE_SHIPPING_FREEOPTIONS_TAX_BASIS', 'MODULE_SHIPPING_FREEOPTIONS_ZONE', 'MODULE_SHIPPING_FREEOPTIONS_SORT_ORDER');
    }
  }
?>
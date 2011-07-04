<?php
/**
 * @version $Id: config.core.php 17 2008-02-14 03:43:21Z bigmouse-sugimoto $
 */
  class specialshipping {
	var $code, $title, $description, $sort_order, $icon, $tax_class, $enabled;
	var $quote;

	function specialshipping() {
	  global $order,$db;

	  $this->code        = 'specialshipping';
	  $this->title       = MODULE_SHIPPING_SPECIALSHIPPING_TEXT_TITLE;
	  $this->description = MODULE_SHIPPING_SPECIALSHIPPING_TEXT_DESCRIPTION;
	  $this->sort_order  = MODULE_SHIPPING_SPECIALSHIPPING_SORT_ORDER;

	  if( zen_get_shipping_enabled( $this->code ) ){
		  $this->enabled = ((MODULE_SHIPPING_SPECIALSHIPPING_STATUS == 'True') ? true : false);
		}

	  if ( ($this->enabled == true) && ((int)MODULE_SHIPPING_SPECIALSHIPPING_ZONE > 0) ) {
		$check_flag = false;
		$check = $db->Execute("select zone_id from " . TABLE_ZONES_TO_GEO_ZONES . "
		                                 where geo_zone_id = '" . MODULE_SHIPPING_SPECIALSHIPPING_ZONE . "'
		                                 and zone_country_id = '" . $order->delivery['country']['id'] . "' order by zone_id");
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

	function quote() {
	  global $shipping_weight, $shipping_num_boxes;
	  global $order;
	  global $a_specialshipping_time;
	  global $cart;
	  global $db;

	  $zone_id = STORE_ZONE;
	  $this->quotes = array('id' => $this->code,
							'module' => $this->title);
	  $country_id = $order->delivery['country']['id'];
	  $zone_id    = $order->delivery['zone_id'];

	  $japan_area = array('182' => 'area_1',
                                '183' => 'area_2', '184' => 'area_2', '186' => 'area_2',
                                '185' => 'area_3', '187' => 'area_3', '188' => 'area_3',
                                '189' => 'area_4', '190' => 'area_4', '191' => 'area_4', '192' => 'area_4', '193' => 'area_4', '194' => 'area_4', '195' => 'area_4', '200' => 'area_4',
                                '196' => 'area_5', '201' => 'area_5',
                                '202' => 'area_6', '203' => 'area_6', '204' => 'area_6', '205' => 'area_6',
                                '197' => 'area_7', '198' => 'area_7', '199' => 'area_7',
                                '206' => 'area_8', '207' => 'area_8', '208' => 'area_8', '209' => 'area_8', '210' => 'area_8', '211' => 'area_8',
                                '212' => 'area_9', '213' => 'area_9', '214' => 'area_9', '215' => 'area_9', '216' => 'area_9',
                                '217' => 'area_10', '218' => 'area_10', '219' => 'area_10', '220' => 'area_10',
                                '221' => 'area_11', '222' => 'area_11', '223' => 'area_11', '224' => 'area_11', '225' => 'area_11', '226' => 'area_11', '227' => 'area_11',
                                '228' => 'area_12');
        $delivery_zone = $japan_area[$zone_id];
        $size_query = $db->Execute("select size from " . TABLE_SPECIAL_SHIPPING . " order by size asc");
        $set_size = '';

        while (!$size_query->EOF) {
           if ($size_query->fields['size'] >= $shipping_weight * $shipping_num_boxes) {
             $set_size = $size_query->fields['size'];
          break;
           }
          $size_query->MoveNext();
        }

        if ($set_size == '') {
           $this->quotes['error'] = MODULE_SHIPPING_SPECIALSHIPPING_TEXT_OVERSIZE;
        } elseif ($delivery_zone != '')  {
          $timespec = $this->get_timespec();
          if ( (MODULE_SHIPPING_SPECIALSHIPPING_FREE_SHIPPING != 'True') || ((int)$order->info['subtotal'] < (int)MODULE_SHIPPING_SPECIALSHIPPING_OVER) ) {
          $shipping_cost = $db->Execute("select $delivery_zone from " . TABLE_SPECIAL_SHIPPING . "
                                                    where size = '" . $set_size . "'");
          } else {
            $shipping_cost->fields[$delivery_zone] = CART_SHIPPING_METHOD_FREE_TEXT;
          }
          $this->quotes = array('id' => $this->code,
                                      'module' => MODULE_SHIPPING_SPECIALSHIPPING_COMPANYNAME);
          $tmpQuote = array('id' => $this->code,
                                   'title' => MODULE_SHIPPING_SPECIALSHIPPING_TEXT_WAY,
                                   'cost' => $shipping_cost->fields[$delivery_zone]);
          if (MODULE_SHIPPING_SPECIALSHIPPING_TIMESPEC == 'True') {
            $timespec_array = array('option' => TEXT_TIME_SPECIFY . zen_draw_pull_down_menu('specialshipping_timespec', $a_specialshipping_time, $timespec),
                                           'timespec' => $timespec);
             $tmpQuote = array_merge($tmpQuote, $timespec_array);
          }
          $this->quotes['methods'][] = $tmpQuote;
        }
		return $this->quotes;
	}

	function get_timespec() {
		global $a_specialshipping_time;
		global $shipping;
		$selected = $a_specialshipping_time[0]['id'];
		if (isset($_POST['specialshipping_timespec']) ) {
			$selected = $_POST['specialshipping_timespec'];
		} elseif ( is_array($shipping) ) {
			list($module, $method) = explode('_', $shipping['id']);
			if ($module == $this->code) {
				$selected = $shipping['timespec'];
			}
		} elseif(isset($_SESSION['shipping']['timespec']) && $_SESSION['shipping']['id'] == 'specialshipping_specialshipping') {
		  $selected = $_SESSION['shipping']['timespec'];
		}
		return $selected;
	}

	function check() {
			global $db;
	  if (!isset($this->_check)) {
		$check_query = $db->Execute("select configuration_value from " . TABLE_CONFIGURATION . "
		                                         where configuration_key = 'MODULE_SHIPPING_SPECIALSHIPPING_STATUS'");
		$this->_check = $check_query->RecordCount();
	  }
	  return $this->_check;
	}

	function install() {
			global $db;
	  $db->Execute("insert into " . TABLE_CONFIGURATION .   "
	                    (configuration_title, configuration_key, configuration_value, configuration_description,
	                     configuration_group_id, sort_order, set_function, date_added)
	                     values ('カスタム配送の配送を有効にする', 'MODULE_SHIPPING_SPECIALSHIPPING_STATUS', 'False',
	                     'カスタム配送の配送を提供しますか?', '6', '0', 'zen_cfg_select_option(array(\'True\', \'False\'), ', now())");

	  $db->Execute("insert into " . TABLE_CONFIGURATION . "
	                    (configuration_title, configuration_key, configuration_value, configuration_description,
	                     configuration_group_id, sort_order, date_added)
	                     values ('運送会社名', 'MODULE_SHIPPING_SPECIALSHIPPING_COMPANYNAME', 'カスタム配送',
	                     'カート側に表示される運送会社名を記入してください。.', '6', '6', now())");

	  $db->Execute("insert into " . TABLE_CONFIGURATION .   "
	                    (configuration_title, configuration_key, configuration_value, configuration_description,
	                     configuration_group_id, sort_order, set_function, date_added)
	                     values ('配送時間指定', 'MODULE_SHIPPING_SPECIALSHIPPING_TIMESPEC', 'True',
	                     '配送時間指定プルダウンを表示しますか?', '6', '0', 'zen_cfg_select_option(array(\'True\', \'False\'), ', now())");

	  $db->Execute("insert into " . TABLE_CONFIGURATION . "
	                    (configuration_title, configuration_key, configuration_value, configuration_description,
	                     configuration_group_id, sort_order, set_function, date_added)
	                     values ('送料無料設定', 'MODULE_SHIPPING_SPECIALSHIPPING_FREE_SHIPPING', 'False',
	                     '送料無料設定を有効にしますか? [合計モジュール]-[送料]-[送料無料設定]を優先する場合は False を選んでください.',
	                     '6', '2', 'zen_cfg_select_option(array(\'True\', \'False\'), ', now())");

	  $db->Execute("INSERT INTO " . TABLE_CONFIGURATION . "
	                    (configuration_title, configuration_key, configuration_value, configuration_description,
	                     configuration_group_id, sort_order, date_added)
	                     values ('送料を無料にする購入金額設定', 'MODULE_SHIPPING_SPECIALSHIPPING_OVER',
	                     '5000', '設定金額以上をご購入の場合は送料を無料にします.', '6', '3', now())");

	  $db->Execute("insert into " . TABLE_CONFIGURATION . "
	                    (configuration_title, configuration_key, configuration_value, configuration_description,
	                     configuration_group_id, sort_order, use_function, set_function, date_added)
	                     values ('配送地域', 'MODULE_SHIPPING_SPECIALSHIPPING_ZONE', '0',
	                     '配送地域を選択すると選択された地域のみで利用可能となります.', '6', '5',
	                     'zen_get_zone_class_title', 'zen_cfg_pull_down_zone_classes(', now())");

	  $db->Execute("insert into " . TABLE_CONFIGURATION . "
	                    (configuration_title, configuration_key, configuration_value, configuration_description,
	                     configuration_group_id, sort_order, date_added)
	                     values ('表示の整列順', 'MODULE_SHIPPING_SPECIALSHIPPING_SORT_ORDER', '0',
	                     '表示の整列順を設定できます. 数字が小さいほど上位に表示されます.', '6', '6', now())");
	}

	function remove() {
	  global $db;
	  $db->Execute("delete from " . TABLE_CONFIGURATION . " where configuration_key in ('" . implode("', '", $this->keys()) . "')");
	}

	function keys() {
	  return array(
		'MODULE_SHIPPING_SPECIALSHIPPING_STATUS',
		'MODULE_SHIPPING_SPECIALSHIPPING_COMPANYNAME',
		'MODULE_SHIPPING_SPECIALSHIPPING_TIMESPEC',
		'MODULE_SHIPPING_SPECIALSHIPPING_FREE_SHIPPING',
		'MODULE_SHIPPING_SPECIALSHIPPING_OVER',
		'MODULE_SHIPPING_SPECIALSHIPPING_ZONE',
		'MODULE_SHIPPING_SPECIALSHIPPING_SORT_ORDER',
	  );
	}
  }
?>

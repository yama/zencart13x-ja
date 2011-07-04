<?php
/**
 * @copyright Copyright 2006-2008 Bigmouse, Inc
 * @copyright Portions Copyright 2003-2007 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: atobaraicom.php 368 2009-10-08 07:26:24Z bigmouse-sugimoto $
**/

  class atobaraicom {
    var $code, $title, $description, $enabled;

// class constructor
    function atobaraicom() {
      global $order;

      $this->code = 'atobaraicom';
      $this->title = MODULE_PAYMENT_ATOBARAICOM_TEXT_TITLE;
      $this->description = MODULE_PAYMENT_ATOBARAICOM_TEXT_DESCRIPTION;
      $this->sort_order = MODULE_PAYMENT_ATOBARAICOM_SORT_ORDER;
      $this->enabled = ((MODULE_PAYMENT_ATOBARAICOM_STATUS == 'True') ? true : false);

      if ((int)MODULE_PAYMENT_ATOBARAICOM_ORDER_STATUS_ID > 0) {
        $this->order_status = MODULE_PAYMENT_ATOBARAICOM_ORDER_STATUS_ID;
      }

      if (is_object($order)) $this->update_status();

      $this->email_footer = MODULE_PAYMENT_ATOBARAICOM_TEXT_EMAIL_FOOTER;
    }

// class methods
    function update_status() {
      global $order, $db;

      if ( ($this->enabled == true) && ((int)MODULE_PAYMENT_ATOBARAICOM_ZONE > 0) ) {
        $check_flag = false;
        $check = $db->Execute("select zone_id from " . TABLE_ZONES_TO_GEO_ZONES . " where geo_zone_id = '" . MODULE_PAYMENT_ATOBARAICOM_ZONE . "' and zone_country_id = '" . $order->billing['country']['id'] . "' order by zone_id");
        while (!$check->EOF) {
          if ($check->fields['zone_id'] < 1) {
            $check_flag = true;
            break;
          } elseif ($check->fields['zone_id'] == $order->billing['zone_id']) {
            $check_flag = true;
            break;
          }
          $check->MoveNext();
        }

        if ($check_flag == false) {
          $this->enabled = false;
        }
      }
      
// disable the module if the order only contains virtual products
      if ($this->enabled == true) {
        if ($order->content_type != 'physical') {
          $this->enabled = false;
        }
      }
      
      if (MODULE_PAYMENT_ATOBARAICOM_PAYTO == '' && $this->enabled == true) {
      	$this->enabled = false;
      }
      if ($this->enabled == true) {
        $this->enabled = false;
        $shipping_modules = explode(', ', MODULE_PAYMENT_ATOBARAICOM_PAYTO);

        list($session_shipping) = explode('_', $_SESSION['shipping']['id']);
       // if (array_search($session_shipping, $shipping_modules)) $this->enabled = true;
        if (is_int(array_search($session_shipping, $shipping_modules))) $this->enabled = true;
      }
      
	if ($this->enabled == true && MODULE_PAYMENT_ATOBARAICOM_SITE_ID == '') {
		$this->enabled = false;
  	}
  	if ($this->enabled == true && MODULE_PAYMENT_ATOBARAICOM_API_STATUS == 'True') {
		if (!function_exists('curl_init')) {
			$this->enabled = false;
	  	}
		if (MODULE_PAYMENT_ATOBARAICOM_API_URL == '') {
			$this->enabled = false;
	  	}
		if (MODULE_PAYMENT_ATOBARAICOM_API_ZIGYOUSYA_ID == '') {
			$this->enabled = false;
	  	}
		if (MODULE_PAYMENT_ATOBARAICOM_API_USER_ID == '') {
			$this->enabled = false;
	  	}
		if (MODULE_PAYMENT_ATOBARAICOM_API_MAIL == '' || zen_validate_email(MODULE_PAYMENT_ATOBARAICOM_API_MAIL) == false) {
			$this->enabled = false;
		}
  	}
  	if ($this->enabled == true && (int)MODULE_PAYMENT_ATOBARAICOM_COST > 0 && MODULE_ORDER_TOTAL_ATOBARAICOM_STATUS != 'true') {
  		$this->enabled = false;
  	}
      
    }

    function javascript_validation() {
      return false;
    }

    function selection() {
    	global $currencies;
    	if ((int)MODULE_PAYMENT_ATOBARAICOM_COST > 0) {

      $message = MODULE_PAYMENT_ATOBARAICOM_TEXT_FEE . '&nbsp;' . $currencies->format((int)MODULE_PAYMENT_ATOBARAICOM_COST);

      $selection = array(
          'id' => $this->code,
          'module' => $this->title,
          'fields' => array(array('title' => MODULE_PAYMENT_ATOBARAICOM_TEXT_PROCESS,
                                  'field' => ''),
                            array('title' => $message,
                                  'field' => ''))
      );
    	} else {
      $selection = array('id' => $this->code,
                   'module' => $this->title,
          		 'fields' => array(array('title' => MODULE_PAYMENT_ATOBARAICOM_TEXT_PROCESS,))                  
                   );
    	}

      return $selection;
    }

    function pre_confirmation_check() {
      return false;
    }

    function confirmation() {
      $confirmation = array(
          'title' => '',
          'fields' => array(array('title' => MODULE_PAYMENT_ATOBARAICOM_TEXT_DESCRIPTION,
                                  'field' => ''),
                           )
      );
      return $confirmation;
    }

    function process_button() {
    	global $currencies ,$order;
    	if ((int)MODULE_PAYMENT_ATOBARAICOM_COST > 0) {
    		$cost = $currencies->format((int)MODULE_PAYMENT_ATOBARAICOM_COST, true, $order->info['currency'], $order->info['currency_value']);
    	} else {
    		$cost = MODULE_PAYMENT_ATOBARAICOM_TEXT_FREE;
    	}
    	$shipping_cost = $currencies->format((int)$order->info['shipping_cost'], true, $order->info['currency'], $order->info['currency_value']);
    $process_button_string = nl2br(sprintf(MODULE_PAYMENT_ATOBARAICOM_TEXT_INFO ,$cost ,$shipping_cost ,$cost));

    return $process_button_string;
    }

    function before_process() {
		return false;
    }

    function after_process() {
    	global $insert_id,$order;
      if (MODULE_PAYMENT_ATOBARAICOM_API_STATUS == 'True') {
	      $show_difference = true;
	      if (($order->delivery['name'] != $order->billing['name'] and $order->delivery['name'] != '')) {
	        $show_difference = false;
	      }
	      if (($order->delivery['state'] .$order->delivery['city'] .$order->delivery['street_address'] .$order->delivery['suburb'] != $order->billing['state'] .$order->billing['city'] .$order->billing['street_address'] .$order->billing['suburb'] and $order->delivery['state'] .$order->delivery['city'] .$order->delivery['street_address'] .$order->delivery['suburb'] != '')) {
	        $show_difference = false;
	      }
	      
	      	$data = array();
			$data = array(
						'O_ReceiptOrderDate' => date("Y/m/d"),
						'O_EnterpriseId' => MODULE_PAYMENT_ATOBARAICOM_API_ZIGYOUSYA_ID,
						'O_SiteId' => MODULE_PAYMENT_ATOBARAICOM_SITE_ID,
						'O_ApiUserId' => MODULE_PAYMENT_ATOBARAICOM_API_USER_ID,
						'O_Ent_OrderId' => $insert_id,
						'O_Ent_Note' => '',
						'O_UseAmount' => (int)$order->info['total'],
						'C_PostalCode' => $this->atobarai_string_format('postcode' ,$order->billing['postcode']),
						'C_UnitingAddress' => $this->atobarai_string_format('address' ,$order->billing['state'] .$order->billing['city'] .$order->billing['street_address'] .$order->billing['suburb']),
						'C_NameKj' => $this->atobarai_string_format('name' ,$order->billing['firstname'] .' ' .$order->billing['lastname']),
						'C_NameKn' => $this->atobarai_string_format('name_kana' ,$order->billing['firstname_kana'] .' ' .$order->billing['lastname_kana']),
						'C_Phone' => $this->atobarai_string_format('telephone' ,$order->billing['telephone']),
						'C_MailAddress' => $this->atobarai_string_format('email_address' ,$order->customer['email_address']),
						'C_Occupation' => '',					
						'O_AnotherDeliFlg' => ($show_difference)? '0' : '1',
						'D_PostalCode' => ($show_difference)? '' : $this->atobarai_string_format('postcode' ,$order->delivery['postcode']),
						'D_UnitingAddress' => ($show_difference)? '' : $this->atobarai_string_format('address' ,$order->delivery['state'] .$order->delivery['city'] .$order->delivery['street_address'] .$order->delivery['suburb']),
						'D_DestNameKj' => ($show_difference)? '' : $this->atobarai_string_format('name' ,$order->delivery['firstname'] .' ' .$order->delivery['lastname']),
						'D_DestNameKn' => ($show_difference)? '' : $this->atobarai_string_format('name_kana' ,$order->delivery['firstname_kana'] .' ' .$order->delivery['lastname_kana']),
						'D_Phone' => ($show_difference)? '' : $this->atobarai_string_format('telephone' ,$order->delivery['telephone']),
						);
			for ($i=0, $n=sizeof($order->products); $i<$n; $i++) {
				$product_data = array();
				$product_data = array(
							'I_ItemNameKj_' .($i + 1) => $this->atobarai_string_format('product_name' ,$order->products[$i]['name']),
							'I_UnitPrice_' .($i + 1) => zen_round($order->products[$i]['final_price'], $currencies->currencies[DEFAULT_CURRENCY]['decimal_places']) + zen_calculate_tax($order->products[$i]['final_price'], $order->products[$i]['tax']),
							'I_ItemNum_' .($i + 1) => $order->products[$i]['qty'],
							);
				$data = array_merge($data,$product_data);
			}
			
			$data['I_ItemCarriage'] = (int)$order->info['shipping_cost'];
			$data['I_ItemCharge'] = (int)MODULE_PAYMENT_ATOBARAICOM_COST;
		 $ch = curl_init();
	      curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
	      curl_setopt($ch, CURLOPT_TIMEOUT, 30);
	      curl_setopt($ch, CURLOPT_URL, MODULE_PAYMENT_ATOBARAICOM_API_URL);
	      curl_setopt($ch, CURLOPT_POST, 1);
	      curl_setopt($ch, CURLOPT_HEADER, 1); 
	      curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
	      $req_body = curl_exec($ch);
	      $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
	      curl_close($ch);

	      $message = MODULE_PAYMENT_ATOBARAICOM_TEXT_API_OK_ORDER_ID .$insert_id ."\n";
	      $mail_sub = MODULE_PAYMENT_ATOBARAICOM_EMAIL_TEXT_SUBJECT;
	      if ($http_code != 200 ) {
	      	$message = MODULE_PAYMENT_ATOBARAICOM_TEXT_API_HTTP_ERROR .$http_code;
	      } else {
	      	if ($req_body == '') {
	      		$message = MODULE_PAYMENT_ATOBARAICOM_TEXT_API_ERROR1;
	      		$mail_sub .= ' NG'; 
	      	} else {
	      		preg_match('/<status>(.*?)<\/status>/i' ,$req_body ,$match);
	      		if ($match[1] == 'success') {
	      			preg_match('/<systemOrderId>(.*?)<\/systemOrderId>/i' ,$req_body ,$match);
	      			$message = MODULE_PAYMENT_ATOBARAICOM_TEXT_API_OK ."\n" .MODULE_PAYMENT_ATOBARAICOM_TEXT_API_OK_ID .$match[1];
	      			$mail_sub .= ' OK'; 
	      		} else {
	      			$match = array();
					$req_body = preg_replace('/\r|\n|\t|\s|\s+/' ,'' ,$req_body);
					preg_match_all('/cd="(.*?)">(.*?)<\//i' ,$req_body ,$match ,PREG_SET_ORDER);
	      			foreach ($match as $key=>$val) {
	      				$message .= $val[1] .':' .$val[2] ."\n";
	      			}
	      			$mail_sub .= ' NG'; 
	      		}
	      	}
	      }
			zen_mail(STORE_NAME, MODULE_PAYMENT_ATOBARAICOM_API_MAIL ,$mail_sub, $message, STORE_NAME, EMAIL_FROM);
      }
      
    }

    function get_error() {
      return false;
    }

    function check() {
      global $db;
      if (!isset($this->_check)) {
        $check_query = $db->Execute("select configuration_value from " . TABLE_CONFIGURATION . " where configuration_key = 'MODULE_PAYMENT_ATOBARAICOM_STATUS'");
        $this->_check = $check_query->RecordCount();
      }
      return $this->_check;
    }

    function install() {
      global $db;
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('後払い.comを有効にする', 'MODULE_PAYMENT_ATOBARAICOM_STATUS', 'False', '後払い.comによる支払いを受け付けますか？<br>支払い総額に後払い手数料を加算したい時には注文合計モジュールの ot_atobarai を有効にしてください。', '6', '1', 'zen_cfg_select_option(array(\'True\', \'False\'), ', now());");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('手数料', 'MODULE_PAYMENT_ATOBARAICOM_COST', '200', '後払い.com利用手数料(税込)', '6', '2', now())");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('配送モジュール:', 'MODULE_PAYMENT_ATOBARAICOM_PAYTO', '', '後払い.comを有効にする配送モジュールを選んで下さい。', '6', '1', 'zen_cfg_select_payment(', now());");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('サイトID', 'MODULE_PAYMENT_ATOBARAICOM_SITE_ID', '', '後払い.comより発行されたサイトIDを入力してください。', '6', '0', now())");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('APIによる売り上げ自動登録', 'MODULE_PAYMENT_ATOBARAICOM_API_STATUS', 'False', '後払い.com 注文登録APIを使った自動売り上げ登録機能を使いますか？', '6', '1', 'zen_cfg_select_option(array(\'True\', \'False\'), ', now());");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('接続先URL（APIを使う場合のみ）', 'MODULE_PAYMENT_ATOBARAICOM_API_URL', '', '後払い.comより発行されたAPI接続先URL入力してください。', '6', '0', now())");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('受付事業者ID（APIを使う場合のみ）', 'MODULE_PAYMENT_ATOBARAICOM_API_ZIGYOUSYA_ID', '', 'APIを使う場合のみ受付事業者IDが必須となりますので、後払い.comより発行された受付事業者IDを入力してください。', '6', '0', now())");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('APIユーザーID（APIを使う場合のみ）', 'MODULE_PAYMENT_ATOBARAICOM_API_USER_ID', '', 'APIを使う場合のみAPIユーザーIDが必須となりますので、後払い.comより発行されたAPIユーザーIDを入力してください。', '6', '0', now())"); 
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('API処理結果メールアドレス（APIを使う場合のみ）', 'MODULE_PAYMENT_ATOBARAICOM_API_MAIL', '', 'APIを使う場合のみ処理結果を送信するメールアドレスを入力してください。<br>処理結果がNGの場合CSVによる手動売上登録して下さい。', '6', '0', now())"); 
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('表示の整列順', 'MODULE_PAYMENT_ATOBARAICOM_SORT_ORDER', '0', '表示の整列順を設定できます。数字が小さいほど上位に表示されます。', '6', '0', now())");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) values ('適用地域', 'MODULE_PAYMENT_ATOBARAICOM_ZONE', '0', '適用地域を選択すると、選択した地域のみで利用可能となります。', '6', '2', 'zen_get_zone_class_title', 'zen_cfg_pull_down_zone_classes(', now())");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, use_function, date_added) values ('初期注文ステータス', 'MODULE_PAYMENT_ATOBARAICOM_ORDER_STATUS_ID', '0', '設定したステータスが受注時に適用されます。', '6', '0', 'zen_cfg_pull_down_order_statuses(', 'zen_get_order_status_name', now())");

    }

    function remove() {
      global $db;
      $db->Execute("delete from " . TABLE_CONFIGURATION . " where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
      return array(
      'MODULE_PAYMENT_ATOBARAICOM_STATUS',
      'MODULE_PAYMENT_ATOBARAICOM_COST',
      'MODULE_PAYMENT_ATOBARAICOM_PAYTO',
      'MODULE_PAYMENT_ATOBARAICOM_SITE_ID',
      'MODULE_PAYMENT_ATOBARAICOM_API_STATUS',
      'MODULE_PAYMENT_ATOBARAICOM_API_URL',
      'MODULE_PAYMENT_ATOBARAICOM_API_ZIGYOUSYA_ID',
      'MODULE_PAYMENT_ATOBARAICOM_API_USER_ID',
      'MODULE_PAYMENT_ATOBARAICOM_API_MAIL',
      'MODULE_PAYMENT_ATOBARAICOM_ZONE',
      'MODULE_PAYMENT_ATOBARAICOM_ORDER_STATUS_ID',
      'MODULE_PAYMENT_ATOBARAICOM_SORT_ORDER',
      );
    }

	function atobarai_string_format ($type ,$str) {
		if (strlen($str) < 1) return false;
		$str = @preg_replace('/("|,)/' ,'' ,$str);
		$moji_count = 0;
		$moji_code = 'utf-8';
		switch ($type) {
			case 'company':
				$moji_count = 30;
				break;
			case 'name':
				$moji_count = 15;
				break;
			case 'name_kana':
				$moji_count = 25;
				$str = mb_convert_kana($str, "KVC" ,$moji_code);
				break;
			case 'postcode':
				$moji_count = 7;
				$str = mb_convert_kana($str, "a" ,$moji_code);
				$str = @preg_replace('/[^0-9]/' ,'' ,$str);
				break;
			case 'address':
				$str = mb_convert_kana($str, "n" ,$moji_code);
				$str = str_replace('ー', "-" ,$str);
				$moji_count = 100;
				break;
			case 'telephone':
				$str = mb_convert_kana($str, "a" ,$moji_code);
				$str = preg_replace('/[^0-9]/' ,'' ,$str);
				if (@preg_match('/^0(5|7|9)0/' ,$str)) {
					$moji_count = 11;
				} else {
					$moji_count = 10;
				}
				break;
			case 'email_address':
				$moji_count = 100;
				break;	
			case 'product_name':
				$moji_count = 150;
				break;
		
			default:
				break;
		}
		$str = mb_substr($str ,0 ,$moji_count ,$moji_code);
		return $str;
	}
  }
  
  if (!function_exists('zen_cfg_select_payment')) {
	  function zen_cfg_select_payment($key_value, $key = '') {
	  	$key_value = explode(", " ,$key_value);
	    $string = '';
	    $file_extension = '.php';
		$module_directory = DIR_FS_CATALOG_MODULES . 'shipping/';
	  $directory_array = array();
	  if ($dir = @dir($module_directory)) {
	    while ($file = $dir->read()) {
	      if (!is_dir($module_directory . $file)) {
	        if (substr($file, strrpos($file, '.')) == $file_extension) {
	          $directory_array[] = $file;
	        }
	      }
	    }
	    sort($directory_array);
	    $dir->close();
	  }

		for ($i=0, $n=sizeof($directory_array); $i<$n; $i++) {
		    $file = $directory_array[$i];
		    include_once(DIR_FS_CATALOG_LANGUAGES . $_SESSION['language'] . '/modules/shipping/' . $file);
		    include_once($module_directory . $file);
		    $class = substr($file, 0, strrpos($file, '.'));
		    if (zen_class_exists($class)) {
		      $module = new $class;
		      if ($module->check() > 0) {
		        if ($module->sort_order > 0) {
		          if ($installed_modules[$module->sort_order] != '') {
		            $zc_valid = false;
		          }
		          $installed_modules[$module->sort_order] = $file;
		        } else {
		          $installed_modules[] = $file;
		        }
		      }
		    }
		    	    $name = ((zen_not_null($key)) ? 'configuration[' . $key . '][]' : 'configuration_value');
			    $string .= '<br><input type="checkbox" name="' . zen_output_string($name) . '"';
			    if (zen_not_null($module->code)) $string .= ' value="' . zen_output_string($module->code) . '"';
			    if (is_int(array_search($module->code,$key_value))) $string .= ' CHECKED';

				$string .= '>' .zen_output_string($module->title);
		}
	    return $string;
	  }
  }
  
  if (!function_exists('zen_validate_email')) {
	  function zen_validate_email($email) {
	    $valid_address = true;
	
	    // fail if contains no @ symbol or more than one @ symbol
	    if (substr_count($email,'@') != 1) return false;
	
	    // split the email address into user and domain parts
	    // this method will most likely break in that case
	    list( $user, $domain ) = explode( "@", $email );
	    $valid_ip_form = '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}';
	//    $valid_email_pattern = '^[a-z0-9]+[a-z0-9_\.\'\-]*@[a-z0-9]+[a-z0-9\.\-]*\.(([a-z]{2,6})|([0-9]{1,3}))$';
	    $valid_email_pattern = '^[a-z0-9_\.\'\-]+[a-z0-9_\.\'\-]*@[a-z0-9]+[a-z0-9\.\-]*\.(([a-z]{2,6})|([0-9]{1,3}))$';
	    //preg_match('/^([a-zA-Z0-9])+([a-zA-Z0-9\._-])*@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9\._-]+)+$/', $email))
	    //preg_match('/^[a-z0-9&\'\.\-_\+]+@[a-z0-9\-]+\.([a-z0-9\-]+\.)*?[a-z]+$/is');
	    $space_check = '[ ]';
	
	    // strip beginning and ending quotes, if and only if both present
	    if( (ereg('^["]', $user) && ereg('["]$', $user)) ){
	      $user = ereg_replace ( '^["]', '', $user );
	      $user = ereg_replace ( '["]$', '', $user );
	      $user = ereg_replace ( $space_check, '', $user ); //spaces in quoted addresses OK per RFC (?)
	      $email = $user."@".$domain; // contine with stripped quotes for remainder
	    }
	
	    // fail if contains spaces in domain name
	    if (strstr($domain,' ')) return false;
	
	    // if email domain part is an IP address, check each part for a value under 256
	    if (ereg($valid_ip_form, $domain)) {
	      $digit = explode( ".", $domain );
	      for($i=0; $i<4; $i++) {
	        if ($digit[$i] > 255) {
	          $valid_address = false;
	          return $valid_address;
	          exit;
	        }
	        // stop crafty people from using internal IP addresses
	        if (($digit[0] == 192) || ($digit[0] == 10)) {
	          $valid_address = false;
	          return $valid_address;
	          exit;
	        }
	      }
	    }
	
	    if (!ereg($space_check, $email)) { // trap for spaces in
	      if ( eregi($valid_email_pattern, $email)) { // validate against valid email patterns
	        $valid_address = true;
	      } else {
	        $valid_address = false;
	        return $valid_address;
	        exit;
	      }
	    }
	    return $valid_address;
	  }
  }
?>
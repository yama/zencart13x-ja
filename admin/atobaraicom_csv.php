<?php
/**
 * @copyright Copyright 2006-2008 Bigmouse, Inc
 * @copyright Portions Copyright 2003-2007 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
**/

  require('includes/application_top.php');

  require(DIR_WS_CLASSES . 'currencies.php');
  $currencies = new currencies();
  
  include(DIR_WS_CLASSES . 'order.php');

  // prepare order-status pulldown list
  $orders_statuses = array();
  $orders_status_array = array();
  $orders_status = $db->Execute("select orders_status_id, orders_status_name
                                 from " . TABLE_ORDERS_STATUS . "
                                 where language_id = '" . (int)$_SESSION['languages_id'] . "'");
  while (!$orders_status->EOF) {
    $orders_statuses[] = array('id' => $orders_status->fields['orders_status_id'],
                               'text' => $orders_status->fields['orders_status_name'] . ' [' . $orders_status->fields['orders_status_id'] . ']');
    $orders_status_array[$orders_status->fields['orders_status_id']] = $orders_status->fields['orders_status_name'];
    $orders_status->MoveNext();
  }
  $moji_code = 'utf-8';
  $action = (isset($_GET['action']) ? $_GET['action'] : '');

  $search = '';
  $new_table = '';
  $new_fields = '';
 // eof: search orders or orders_products
    $new_fields = ", o.customers_company, o.customers_email_address, o.customers_street_address,
                         o.delivery_company, o.delivery_name, o.delivery_street_address, o.billing_company,
                         o.billing_name, o.billing_street_address, o.payment_module_code, o.shipping_module_code ";
	if ($_GET['status'] != '') {
      $status = zen_db_prepare_input($_GET['status']);
      $orders_query_raw = "select o.orders_id, o.customers_id, o.customers_name, o.payment_method, o.shipping_method, o.date_purchased,
                                  o.last_modified, o.currency, o.currency_value, s.orders_status_name, ot.text as order_total" .
                          $new_fields . "
                          from (" . TABLE_ORDERS . " o, " .
                          TABLE_ORDERS_STATUS . " s " .
                          $new_table . ")
                          left join " . TABLE_ORDERS_TOTAL . " ot on (o.orders_id = ot.orders_id) " . "
                          where o.orders_status = s.orders_status_id
                          and o.payment_module_code = 'atobaraicom'
                          and s.language_id = '" . (int)$_SESSION['languages_id'] . "'
                          and s.orders_status_id = '" . (int)$status . "'
                          and ot.class = 'ot_total'  " .
                          $search;
//echo '<BR><BR>I SEE B: ' . $orders_query_raw . '<BR><BR>';

    } else {
      $orders_query_raw = "select " . $search_distinct . " o.orders_id, o.customers_id, o.customers_name, o.payment_method, o.shipping_method,
                                  o.date_purchased, o.last_modified, o.currency, o.currency_value, s.orders_status_name, ot.text as order_total" .
                          $new_fields . "
                          from " . TABLE_ORDERS_STATUS . " s,
                          (" .TABLE_ORDERS . " o " .
                          $new_table . ")
                          left join " . TABLE_ORDERS_TOTAL . " ot on (o.orders_id = ot.orders_id) " . "
                          where (o.orders_status = s.orders_status_id
                          and o.payment_module_code = 'atobaraicom'
                          and s.language_id = '" . (int)$_SESSION['languages_id'] . "'
                          and ot.class = 'ot_total')  " .
                          $search;

//echo '<BR><BR>I SEE C: ' . $orders_query_raw . '<BR><BR>';

    }

    if (zen_not_null($action)) {
    		switch ($action) {
    			case 'csv_1':
				zen_set_time_limit(600);
				ini_set('memory_limit', '32M');
    				atobarai_csv_torihiki($orders_query_raw);
    				break;
    			case 'csv_2':
				zen_set_time_limit(600);
				ini_set('memory_limit', '32M');
    				atobarai_csv_shipping($orders_query_raw);    				
    				break;   		
    			default:
    				break;
    		}
    }
    
	if (isset($_FILES['imp_csv_file']) && $_FILES['imp_csv_file']['error'] == 0 && (int)$_POST['imp_csv_status'] > 0 && $_POST['action'] == 'imp_csv') {
	  $csv_tmp = $_FILES['imp_csv_file']['tmp_name'];
	  zen_set_time_limit(600);
	  $r = 0;
	  $handle = fopen($csv_tmp, "rb");
	  while (($data = fgetcsv_reg_atobarai($handle, 50000 ,',')) !== FALSE) {
		  	mb_convert_variables($moji_code , 'sjis-win' ,$data);
		  	$shipping_name = $data[1];
		  	$shipping_number = $data[2];  	
        		$oID = zen_db_prepare_input($data[8]);
	  	if ($r > 0 && (int)$oID > 0) {
        		$status = zen_db_prepare_input($_POST['imp_csv_status']);
        		$comments = zen_db_prepare_input($_POST['comments']);
        		
		          if (isset($_POST['auto_shipping_comments']) && ($_POST['auto_shipping_comments'] == 'on')) {
		          $auto_shipping_comments = '';
		          if (is_array($csv_shipping_code) && $shipping_number != '' && $shipping_name != '' && isset($csv_shipping_code[$shipping_name])) {
		          		if ($csv_shipping_code[$shipping_name] ) {
		          			$auto_shipping_comments .= ENTRY_NOTIFY_COMMENTS_AUTO_SHIPPING_TEXT1 .$shipping_name ."\n";
		          			$auto_shipping_comments .= ENTRY_NOTIFY_COMMENTS_AUTO_SHIPPING_TEXT2 .$shipping_number ."\n";
		          			if ($csv_shipping_code[$shipping_name] != '') {
		          				$auto_shipping_comments .= ENTRY_NOTIFY_COMMENTS_AUTO_SHIPPING_TEXT3 .$csv_shipping_code[$shipping_name] ."\n\n";
		          			}
		          		}
		          }
		          	$comments .= (zen_not_null($comments)? "\n\n":'') .$auto_shipping_comments;
		          }
		          
        		$check_status = $db->Execute("select payment_module_code ,customers_name, customers_email_address, orders_status,
                                      date_purchased from " . TABLE_ORDERS . "
                                      where orders_id = '" . (int)$oID . "'");
			if ($check_status->RecordCount() > 0 && $check_status->fields['payment_module_code'] == 'atobaraicom') {
		          $db->Execute("update " . TABLE_ORDERS . "
		                        set orders_status = '" . zen_db_input($status) . "', last_modified = now()
		                        where orders_id = '" . (int)$oID . "'");
		
		          $notify_comments = '';
		          if (isset($_POST['notify_comments']) && ($_POST['notify_comments'] == 'on') && zen_not_null($comments)) {
		            $notify_comments = EMAIL_TEXT_COMMENTS_UPDATE . $comments . "\n\n";
		          }

		          //send emails
		          $message = STORE_NAME . "\n" . EMAIL_SEPARATOR . "\n" .
		          EMAIL_TEXT_ORDER_NUMBER . ' ' . $oID . "\n\n" .
		          EMAIL_TEXT_INVOICE_URL . ' ' . zen_catalog_href_link(FILENAME_CATALOG_ACCOUNT_HISTORY_INFO, 'order_id=' . $oID, 'SSL') . "\n\n" .
		          EMAIL_TEXT_DATE_ORDERED . ' ' . zen_date_long($check_status->fields['date_purchased']) . "\n\n" .
		          strip_tags($notify_comments) .
		          EMAIL_TEXT_STATUS_UPDATED . sprintf(EMAIL_TEXT_STATUS_LABEL, $orders_status_array[$status] ) .
		          EMAIL_TEXT_STATUS_PLEASE_REPLY;
		
		          $html_msg['EMAIL_CUSTOMERS_NAME']    = $check_status->fields['customers_name'];
		          $html_msg['EMAIL_TEXT_ORDER_NUMBER'] = EMAIL_TEXT_ORDER_NUMBER . ' ' . $oID;
		          $html_msg['EMAIL_TEXT_INVOICE_URL']  = '<a href="' . zen_catalog_href_link(FILENAME_CATALOG_ACCOUNT_HISTORY_INFO, 'order_id=' . $oID, 'SSL') .'">'.str_replace(':','',EMAIL_TEXT_INVOICE_URL).'</a>';
		          $html_msg['EMAIL_TEXT_DATE_ORDERED'] = EMAIL_TEXT_DATE_ORDERED . ' ' . zen_date_long($check_status->fields['date_purchased']);
		          $html_msg['EMAIL_TEXT_STATUS_COMMENTS'] = nl2br($notify_comments);
		          $html_msg['EMAIL_TEXT_STATUS_UPDATED'] = str_replace('\n','', EMAIL_TEXT_STATUS_UPDATED);
		          $html_msg['EMAIL_TEXT_STATUS_LABEL'] = str_replace('\n','', sprintf(EMAIL_TEXT_STATUS_LABEL, $orders_status_array[$status] ));
		          $html_msg['EMAIL_TEXT_NEW_STATUS'] = $orders_status_array[$status];
		          $html_msg['EMAIL_TEXT_STATUS_PLEASE_REPLY'] = str_replace('\n','', EMAIL_TEXT_STATUS_PLEASE_REPLY);
		
		          $customer_notified = '0';
		          if (isset($_POST['notify']) && ($_POST['notify'] == 'on')) {
		            zen_mail($check_status->fields['customers_name'], $check_status->fields['customers_email_address'], EMAIL_TEXT_SUBJECT . ' #' . $oID, $message, STORE_NAME, EMAIL_FROM, $html_msg, 'order_status');
		            $customer_notified = '1';
		
		            //send extra emails
		            if (SEND_EXTRA_ORDERS_STATUS_ADMIN_EMAILS_TO_STATUS == '1' and SEND_EXTRA_ORDERS_STATUS_ADMIN_EMAILS_TO != '') {
		              zen_mail('', SEND_EXTRA_ORDERS_STATUS_ADMIN_EMAILS_TO, SEND_EXTRA_ORDERS_STATUS_ADMIN_EMAILS_TO_SUBJECT . ' ' . EMAIL_TEXT_SUBJECT . ' #' . $oID, $message, STORE_NAME, EMAIL_FROM, $html_msg, 'order_status_extra');
		            }
		          }
		
		          // add update_point_history module require
		          if (MODULE_ORDER_TOTAL_GIVE_POINT_STATUS == 'true') {
		            require(DIR_WS_MODULES . 'orders_point/update_point_history.php');
		          }
		
		          $db->Execute("insert into " . TABLE_ORDERS_STATUS_HISTORY . "
		                      (orders_id, orders_status_id, date_added, customer_notified, comments)
		                      values ('" . (int)$oID . "',
		                      '" . zen_db_input($status) . "',
		                      now(),
		                      '" . zen_db_input($customer_notified) . "',
		                      '" . zen_db_input($comments)  . "')");
		          $messageStack->add_session($oID .' : ' .TEXT_IMPORT_CSV_UPDATE_OK , 'success');
		  	
		  	} else {
		  		if ($check_status->RecordCount() > 0) {
		  			$messageStack->add_session($oID .' : ' .TEXT_IMPORT_CSV_ERROR_ORDER , 'error');
		  		} else {
		  			$messageStack->add_session($oID .' : ' .TEXT_IMPORT_CSV_ERROR_ORDER_PAYMENT , 'error');
		  		}
		  	}
	  	}
	  	$r++ ;
	  }
		zen_redirect(zen_href_link(FILENAME_ATOBARAICOM_CSV));
	}
	
	if (isset($_FILES['imp_csv_file_yosin']) && $_FILES['imp_csv_file_yosin']['error'] == 0 && (int)$_POST['imp_csv_status_yosin_ok'] > 0 && (int)$_POST['imp_csv_status_yosin_ng'] > 0 && $_POST['action'] == 'imp_csv_yosin') {
	  $csv_tmp = $_FILES['imp_csv_file_yosin']['tmp_name'];
	  zen_set_time_limit(600);
	  $r = 0;
	  $order_id_check = false;
	  $handle = fopen($csv_tmp, "rb");
	  while (($data = fgetcsv_reg_atobarai($handle, 50000 ,',')) !== FALSE) {
		  mb_convert_variables($moji_code , 'sjis-win' ,$data);
	        if($r == 0){
		        	$hedder_array = '';
		        	for ($i=0, $n=sizeof($data); $i<$n; $i++) {
		        		$hedder_array[] = trim($data[$i]);
		        	}
		        	if (is_int(array_search(CSV_HEADER_ORDER_ID ,$hedder_array))) {
		        		$order_id_check = true;
		        	} else {
		        		$messageStack->add_session(TEXT_IMPORT_CSV_ERROR_ORDER_ID_COLUMN , 'error');
		        		zen_redirect(zen_href_link(FILENAME_ATOBARAICOM_CSV));
		        	}
		        	if (is_int(array_search(CSV_HEADER_SINSA_KEKKA ,$hedder_array))) {
		        		$order_id_check = true;
		        	} else {
		        		$messageStack->add_session(TEXT_IMPORT_CSV_ERROR_SINSA_KEKKA_COLUMN , 'error');
		        		zen_redirect(zen_href_link(FILENAME_ATOBARAICOM_CSV));
		        	}
	        }
	        $oID = zen_db_prepare_input($data[array_search(CSV_HEADER_ORDER_ID, $hedder_array)]);
	        $kekka = zen_db_prepare_input($data[array_search(CSV_HEADER_SINSA_KEKKA, $hedder_array)]);
	        $status_ok = zen_db_prepare_input($_POST['imp_csv_status_yosin_ok']);
	        $status_ng = zen_db_prepare_input($_POST['imp_csv_status_yosin_ng']);
	        $comments = zen_db_prepare_input($_POST['comments_yosin']);
	  	if ($r > 0  && (int)$oID > 0 && ($kekka == 'OK' || $kekka == 'NG')) {
			if ($kekka == 'OK') {
				$kekka_comments = CSV_HEADER_SINSA_KEKKA_OK;
				$status = $status_ok;
			} else {
				$kekka_comments = CSV_HEADER_SINSA_KEKKA_NG;
				$status = $status_ng;
			}
		     $comments .= (zen_not_null($comments)? "\n\n":'') .$kekka_comments;
        		$check_status = $db->Execute("select payment_module_code ,customers_name, customers_email_address, orders_status,
                                      date_purchased from " . TABLE_ORDERS . "
                                      where orders_id = '" . (int)$oID . "'");
			if ($check_status->RecordCount() > 0 && $check_status->fields['payment_module_code'] == 'atobaraicom') {
		        if ( ($check_status->fields['orders_status'] != $status) || zen_not_null($comments)) {
		          $db->Execute("update " . TABLE_ORDERS . "
		                        set orders_status = '" . zen_db_input($status) . "', last_modified = now()
		                        where orders_id = '" . (int)$oID . "'");
		
		          $notify_comments = '';
		          if (isset($_POST['notify_comments_yosin']) && ($_POST['notify_comments_yosin'] == 'on') && zen_not_null($comments)) {
		            $notify_comments = EMAIL_TEXT_COMMENTS_UPDATE . $comments . "\n\n";
		          }

		          //send emails
		          $message = STORE_NAME . "\n" . EMAIL_SEPARATOR . "\n" .
		          EMAIL_TEXT_ORDER_NUMBER . ' ' . $oID . "\n\n" .
		          EMAIL_TEXT_INVOICE_URL . ' ' . zen_catalog_href_link(FILENAME_CATALOG_ACCOUNT_HISTORY_INFO, 'order_id=' . $oID, 'SSL') . "\n\n" .
		          EMAIL_TEXT_DATE_ORDERED . ' ' . zen_date_long($check_status->fields['date_purchased']) . "\n\n" .
		          strip_tags($notify_comments) .
		          EMAIL_TEXT_STATUS_UPDATED . sprintf(EMAIL_TEXT_STATUS_LABEL, $orders_status_array[$status] ) .
		          EMAIL_TEXT_STATUS_PLEASE_REPLY;
		
		          $html_msg['EMAIL_CUSTOMERS_NAME']    = $check_status->fields['customers_name'];
		          $html_msg['EMAIL_TEXT_ORDER_NUMBER'] = EMAIL_TEXT_ORDER_NUMBER . ' ' . $oID;
		          $html_msg['EMAIL_TEXT_INVOICE_URL']  = '<a href="' . zen_catalog_href_link(FILENAME_CATALOG_ACCOUNT_HISTORY_INFO, 'order_id=' . $oID, 'SSL') .'">'.str_replace(':','',EMAIL_TEXT_INVOICE_URL).'</a>';
		          $html_msg['EMAIL_TEXT_DATE_ORDERED'] = EMAIL_TEXT_DATE_ORDERED . ' ' . zen_date_long($check_status->fields['date_purchased']);
		          $html_msg['EMAIL_TEXT_STATUS_COMMENTS'] = nl2br($notify_comments);
		          $html_msg['EMAIL_TEXT_STATUS_UPDATED'] = str_replace('\n','', EMAIL_TEXT_STATUS_UPDATED);
		          $html_msg['EMAIL_TEXT_STATUS_LABEL'] = str_replace('\n','', sprintf(EMAIL_TEXT_STATUS_LABEL, $orders_status_array[$status] ));
		          $html_msg['EMAIL_TEXT_NEW_STATUS'] = $orders_status_array[$status];
		          $html_msg['EMAIL_TEXT_STATUS_PLEASE_REPLY'] = str_replace('\n','', EMAIL_TEXT_STATUS_PLEASE_REPLY);
		
		          $customer_notified = '0';
		          if (isset($_POST['notify_yosin']) && ($_POST['notify_yosin'] == 'on')) {
		            zen_mail($check_status->fields['customers_name'], $check_status->fields['customers_email_address'], EMAIL_TEXT_SUBJECT . ' #' . $oID, $message, STORE_NAME, EMAIL_FROM, $html_msg, 'order_status');
		            $customer_notified = '1';
		
		            //send extra emails
		            if (SEND_EXTRA_ORDERS_STATUS_ADMIN_EMAILS_TO_STATUS == '1' and SEND_EXTRA_ORDERS_STATUS_ADMIN_EMAILS_TO != '') {
		              zen_mail('', SEND_EXTRA_ORDERS_STATUS_ADMIN_EMAILS_TO, SEND_EXTRA_ORDERS_STATUS_ADMIN_EMAILS_TO_SUBJECT . ' ' . EMAIL_TEXT_SUBJECT . ' #' . $oID, $message, STORE_NAME, EMAIL_FROM, $html_msg, 'order_status_extra');
		            }
		          }
		
		          // add update_point_history module require
		          if (MODULE_ORDER_TOTAL_GIVE_POINT_STATUS == 'true') {
		            require(DIR_WS_MODULES . 'orders_point/update_point_history.php');
		          }
		
		          $db->Execute("insert into " . TABLE_ORDERS_STATUS_HISTORY . "
		                      (orders_id, orders_status_id, date_added, customer_notified, comments)
		                      values ('" . (int)$oID . "',
		                      '" . zen_db_input($status) . "',
		                      now(),
		                      '" . zen_db_input($customer_notified) . "',
		                      '" . zen_db_input($comments)  . "')");
		          $messageStack->add_session($oID .' : ' .TEXT_IMPORT_CSV_UPDATE_OK , 'success');
		        } else {
		        		$messageStack->add_session($oID .' : ' .TEXT_IMPORT_CSV_ERROR_ORDER_STATUS , 'caution');
		        }
		  	
		  	} else {
		  		if ($check_status->RecordCount() > 0) {
		  			$messageStack->add_session($oID .' : ' .TEXT_IMPORT_CSV_ERROR_ORDER , 'error');
		  		} else {
		  			$messageStack->add_session($oID .' : ' .TEXT_IMPORT_CSV_ERROR_ORDER_PAYMENT , 'error');
		  		}
		  	}
	  	}
	  	$r++ ;
	  }
		zen_redirect(zen_href_link(FILENAME_ATOBARAICOM_CSV));
	}
    
    $orders_query_raw .= " order by o.orders_id DESC";
?>
<!doctype html public "-//W3C//DTD HTML 4.01 Transitional//EN">
<html <?php echo HTML_PARAMS; ?>>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<?php echo CHARSET; ?>">
<title><?php echo TITLE; ?></title>
<link rel="stylesheet" type="text/css" href="includes/stylesheet.css">
<link rel="stylesheet" type="text/css" media="print" href="includes/stylesheet_print.css">
<link rel="stylesheet" type="text/css" href="includes/cssjsmenuhover.css" media="all" id="hoverJS">
<script language="javascript" src="includes/menu.js"></script>
<script language="javascript" src="includes/general.js"></script>
<script type="text/javascript">
  <!--
  function init()
  {
    cssjsmenu('navbar');
    if (document.getElementById)
    {
      var kill = document.getElementById('hoverJS');
      kill.disabled = true;
    }
  }
  // -->
</script>
<script language="javascript" type="text/javascript"><!--
function couponpopupWindow(url) {
  window.open(url,'popupWindow','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=no,width=450,height=280,screenX=150,screenY=150,top=150,left=150')
}
//--></script>
</head>
<body onLoad="init();">
<!-- header //-->
<div class="header-area">
<?php
  require(DIR_WS_INCLUDES . 'header.php');
?>
</div>
<!-- header_eof //-->

<!-- body //-->
<table border="0" width="100%" cellspacing="2" cellpadding="2">
  <tr>
<!-- body_text //-->
      <tr>
        <td width="100%"><table border="0" width="100%" cellspacing="0" cellpadding="0">
          <tr>
            <td class="pageHeading"><?php echo HEADING_TITLE; ?></td>
            <td class="pageHeading" align="right"><?php echo zen_draw_separator('pixel_trans.gif', 1, HEADING_IMAGE_HEIGHT); ?></td>
            <td align="right"><table border="0" width="100%" cellspacing="0" cellpadding="0">
              <tr><?php echo zen_draw_form('orders', FILENAME_ATOBARAICOM_CSV, '', 'get', '', true); ?>
                <td class="smallText" align="right"><?php echo zen_hide_session_id(); ?></td>
              </form></tr>
              <tr><?php echo zen_draw_form('status', FILENAME_ATOBARAICOM_CSV, '', 'get', '', true); ?>
                <td class="smallText" align="right">
                  <?php
                    echo HEADING_TITLE_STATUS . ' ' . zen_draw_pull_down_menu('status', array_merge(array(array('id' => '', 'text' => TEXT_ALL_ORDERS)), $orders_statuses), $_GET['status'], 'onChange="this.form.submit();"');
                    echo zen_hide_session_id();
                  ?>
                </td>
              </form></tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td><table border="0" width="100%" cellspacing="0" cellpadding="0">
          <tr>
            <td class="smallText"><?php echo TEXT_LEGEND . ' ' . zen_image(DIR_WS_IMAGES . 'icon_status_red.gif', TEXT_BILLING_SHIPPING_MISMATCH, 10, 10) . ' ' . TEXT_BILLING_SHIPPING_MISMATCH; ?>
          </td>
          <tr>
            <td valign="top"><table border="0" width="100%" cellspacing="0" cellpadding="2">
              <tr class="dataTableHeadingRow">
<?php
// Sort Listing
          switch ($_GET['list_order']) {
              case "id-asc":
              $disp_order = "c.customers_id";
              break;
              case "firstname":
              $disp_order = "c.customers_firstname";
              break;
              case "firstname-desc":
              $disp_order = "c.customers_firstname DESC";
              break;
              case "lastname":
              $disp_order = "c.customers_lastname, c.customers_firstname";
              break;
              case "lastname-desc":
              $disp_order = "c.customers_lastname DESC, c.customers_firstname";
              break;
              case "company":
              $disp_order = "a.entry_company";
              break;
              case "company-desc":
              $disp_order = "a.entry_company DESC";
              break;
              default:
              $disp_order = "c.customers_id DESC";
          }
?>
                <td class="dataTableHeadingContent" align="center"><?php echo TABLE_HEADING_ORDERS_ID; ?></td>
                <td class="dataTableHeadingContent"><?php echo TABLE_HEADING_CUSTOMERS; ?></td>
                <td class="dataTableHeadingContent" align="right"><?php echo TABLE_HEADING_ORDER_TOTAL; ?></td>
                <td class="dataTableHeadingContent" align="center"><?php echo TABLE_HEADING_DATE_PURCHASED; ?></td>
                <td class="dataTableHeadingContent" align="left"><?php echo TABLE_HEADING_SHIPPING_METHOD; ?></td>
                <td class="dataTableHeadingContent" align="center"><?php echo TABLE_HEADING_STATUS; ?></td>
              </tr>

<?php
// Only one or the other search
// create search_orders_products filter


// Split Page
// reset page when page is unknown
if (($_GET['page'] == '' or $_GET['page'] <= 1) and $_GET['oID'] != '') {
  $check_page = $db->Execute($orders_query_raw);
  $check_count=1;
  if ($check_page->RecordCount() > MAX_DISPLAY_SEARCH_RESULTS_ORDERS) {
    while (!$check_page->EOF) {
      if ($check_page->fields['orders_id'] == $_GET['oID']) {
        break;
      }
      $check_count++;
      $check_page->MoveNext();
    }
    $_GET['page'] = round((($check_count/MAX_DISPLAY_SEARCH_RESULTS_ORDERS)+(fmod_round($check_count,MAX_DISPLAY_SEARCH_RESULTS_ORDERS) !=0 ? .5 : 0)),0);
  } else {
    $_GET['page'] = 1;
  }
}

//    $orders_query_numrows = '';
    $orders_split = new splitPageResults($_GET['page'], MAX_DISPLAY_SEARCH_RESULTS_ORDERS, $orders_query_raw, $orders_query_numrows);
    $orders = $db->Execute($orders_query_raw);
    while (!$orders->EOF) {
    if ((!isset($_GET['oID']) || (isset($_GET['oID']) && ($_GET['oID'] == $orders->fields['orders_id']))) && !isset($oInfo)) {
        $oInfo = new objectInfo($orders->fields);
      }
        echo '              <tr class="dataTableRow" onmouseover="rowOverEffect(this)" onmouseout="rowOutEffect(this)">' . "\n";
      

      $show_difference = '';
      if (($orders->fields['delivery_name'] != $orders->fields['billing_name'] and $orders->fields['delivery_name'] != '')) {
        $show_difference = zen_image(DIR_WS_IMAGES . 'icon_status_red.gif', TEXT_BILLING_SHIPPING_MISMATCH, 10, 10) . '&nbsp;';
      }
      if (($orders->fields['delivery_street_address'] != $orders->fields['billing_street_address'] and $orders->fields['delivery_street_address'] != '')) {
        $show_difference = zen_image(DIR_WS_IMAGES . 'icon_status_red.gif', TEXT_BILLING_SHIPPING_MISMATCH, 10, 10) . '&nbsp;';
      }

?>
                <td class="dataTableContent" align="right"><?php echo $show_difference . $orders->fields['orders_id']; ?></td>
                <td class="dataTableContent"><?php echo '<a href="' . zen_href_link(FILENAME_CUSTOMERS, 'cID=' . $orders->fields['customers_id'], 'NONSSL') . '">' . zen_image(DIR_WS_ICONS . 'preview.gif', ICON_PREVIEW . ' ' . TABLE_HEADING_CUSTOMERS) . '</a>&nbsp;' . $orders->fields['customers_name'] . ($orders->fields['customers_company'] != '' ? '<br />' . $orders->fields['customers_company'] : ''); ?></td>
                <td class="dataTableContent" align="right"><?php echo strip_tags($orders->fields['order_total']); ?></td>
                <td class="dataTableContent" align="center"><?php echo zen_datetime_short($orders->fields['date_purchased']); ?></td>
                <td class="dataTableContent" align="left" nowrap="nowrap"><?php echo $orders->fields['shipping_method']; ?></td>
                <td class="dataTableContent" align="center"><?php echo $orders->fields['orders_status_name']; ?></td>
              </tr>
<?php
      $orders->MoveNext();
    }
?>
              <tr>
                <td colspan="6"><table border="0" width="100%" cellspacing="0" cellpadding="2">
                  <tr>
                    <td class="smallText" valign="top"><?php echo $orders_split->display_count($orders_query_numrows, MAX_DISPLAY_SEARCH_RESULTS_ORDERS, $_GET['page'], TEXT_DISPLAY_NUMBER_OF_ORDERS); ?></td>
                    <td class="smallText" align="right"><?php echo $orders_split->display_links($orders_query_numrows, MAX_DISPLAY_SEARCH_RESULTS_ORDERS, MAX_DISPLAY_PAGE_LINKS, $_GET['page'], zen_get_all_get_params(array('page', 'oID', 'action'))); ?></td>
                  </tr>
<?php
  if (isset($_GET['search']) && zen_not_null($_GET['search'])) {
?>
                  <tr>
                    <td class="smallText" align="right" colspan="2">
                      <?php
                        echo '<a href="' . zen_href_link(FILENAME_ATOBARAICOM_CSV, '', 'NONSSL') . '">' . zen_image_button('button_reset.gif', IMAGE_RESET) . '</a>';
                        if (isset($_GET['search']) && zen_not_null($_GET['search'])) {
                          $keywords = zen_db_input(zen_db_prepare_input($_GET['search']));
                          echo '<br/ >' . TEXT_INFO_SEARCH_DETAIL_FILTER . $keywords;
                        }
                      ?>
                    </td>
                  </tr>
<?php
  }
?>
                </table></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
	  <tr>
	  	<td>
	  		<table border="0" width="100%" cellspacing="0" cellpadding="0">
	  			<tr>
	  				<td><?php echo zen_draw_separator('pixel_trans.gif', 1 ,10); ?></td>
	  			</tr>
	  			<tr>
	  				<td><?php echo zen_draw_separator('pixel_black.gif', '100%', 2); ?></td>
	  			</tr>
	  			<tr>
	  				<td><?php echo zen_draw_separator('pixel_trans.gif', 1 ,10); ?></td>
	  			</tr>
	  			<tr>
				      <td valign="top">
						<fieldset style="border:solid 1px blue;width:200px;text-align:center;">
						<legend style="background-color:#FFFFC0;">
				          	<?php
				                $csv_status = (int)$_GET['status'];
				                $orders_status_array_csv = array_merge(array(0=>TEXT_ALL_ORDERS) ,$orders_status_array);
				                echo $orders_status_array_csv[$csv_status] .TEXT_CSV_EXPLODE;
				              ?>
						</legend>
						<div><a href="<?php echo zen_href_link(FILENAME_ATOBARAICOM_CSV, 'action=csv_1&status=' .$_GET['status'], 'NONSSL'); ?>" style="color:#000;background-color:#D9DAE7;border:solid 1px #003C74;font-size:120%;font-weight: bold;text-decoration:none;"><?php echo TEXT_VP_CSV;?></a><?php //echo zen_draw_separator('pixel_trans.gif', 10, 1); ?></div>
						<div><?php echo TEXT_VP_CSV_INFO;?></div>
						</fieldset>
				       </td>
	  			</tr>
	  			<tr>
	  				<td valign="top">
						<fieldset style="border:solid 1px blue;width:80%;text-align:left;">
						<legend style="background-color:#FFFFC0;">
				          	<?php
				                echo TEXT_IMPORT_CSV_YOSIN;
				              ?>
						</legend>
						<div>
						<?php
					          echo zen_draw_form('yosin', FILENAME_ATOBARAICOM_CSV,'','post', 'enctype="multipart/form-data"');
					          echo zen_draw_hidden_field('action', 'imp_csv_yosin');
						?>
						</div>
						<div style="text-align:left;">
						<?php echo TEXT_IMPORT_CSV_DESC_YOSIN; ?>
						</div>
						<div>
						<?php
		                    echo '<strong>' .HEADING_TITLE_STATUS_YOSIN_OK . '</strong>' . zen_draw_pull_down_menu('imp_csv_status_yosin_ok', $orders_statuses, 2);
		                    echo zen_hide_session_id();
						?>
						</div>
						<div>
						<?php
		                    echo '<strong>' .HEADING_TITLE_STATUS_YOSIN_NG . '</strong>' . zen_draw_pull_down_menu('imp_csv_status_yosin_ng', $orders_statuses, 1);
		                    echo zen_hide_session_id();
						?>
						</div>
						<div><strong><?php echo ENTRY_NOTIFY_CUSTOMER; ?></strong> <?php echo zen_draw_checkbox_field('notify_yosin', '', true); ?></div>
						<div><strong><?php echo ENTRY_NOTIFY_COMMENTS; ?></strong> <?php echo zen_draw_checkbox_field('notify_comments_yosin', '', true) .' '  ; ?></div>
						<div><?php echo zen_draw_textarea_field('comments_yosin', 'soft', '50', '2' ,'' ,' style="width:100%"'); ?></div>
						<div><?php echo zen_draw_file_field('imp_csv_file_yosin') .'<input type="submit" value="' .TEXT_IMPORT_CSV_SUBMIT .'">';?></form></div>
						</fieldset>
	  				</td>
	  			</tr>
	  			<tr>
	  				<td><?php echo zen_draw_separator('pixel_trans.gif', 1 ,10); ?></td>
	  			</tr>
	  			<tr>
	  				<td><?php echo zen_draw_separator('pixel_black.gif', '100%', 2); ?></td>
	  			</tr>
	  			<tr>
	  				<td><?php echo zen_draw_separator('pixel_trans.gif', 1 ,10); ?></td>
	  			</tr>
	  			<tr>
				      <td valign="top">
						<fieldset style="border:solid 1px red;width:200px;text-align:center;">
						<legend style="background-color:#FFFFC0;">
				          	<?php
				                $csv_status = (int)$_GET['status'];
				                $orders_status_array_csv = array_merge(array(0=>TEXT_ALL_ORDERS) ,$orders_status_array);
				                echo $orders_status_array_csv[$csv_status] .TEXT_CSV_EXPLODE2;
				              ?>
						</legend>
						<div><a href="<?php echo zen_href_link(FILENAME_ATOBARAICOM_CSV, 'action=csv_2&status=' .$_GET['status'], 'NONSSL'); ?>" style="color:#000;background-color:#D9DAE7;border:solid 1px #003C74;font-size:120%;font-weight: bold;text-decoration:none;"><?php echo TEXT_VP_CSV2;?></a><?php //echo zen_draw_separator('pixel_trans.gif', 10, 1); ?></div>
						<div><?php echo TEXT_VP_CSV_INFO;?></div>
						</fieldset>
				       </td>
	  			</tr>
	  			<tr>
	  				<td valign="top">
						<fieldset style="border:solid 1px red;width:80%;text-align:left;">
						<legend style="background-color:#FFFFC0;">
				          	<?php
				                echo TEXT_IMPORT_CSV;
				              ?>
						</legend>
						<div>
						<?php
					          echo zen_draw_form('category', FILENAME_ATOBARAICOM_CSV,'','post', 'enctype="multipart/form-data"');
					          echo zen_draw_hidden_field('action', 'imp_csv');
						?>
						</div>
						<div style="text-align:left;">
						<?php echo TEXT_IMPORT_CSV_DESC; ?>
						</div>
						<div>
						<?php
		                    echo '<strong>' .HEADING_TITLE_STATUS . '</strong>' . zen_draw_pull_down_menu('imp_csv_status', $orders_statuses, 3);
		                    echo zen_hide_session_id();
						?>
						</div>
						<div><strong><?php echo ENTRY_NOTIFY_CUSTOMER; ?></strong> <?php echo zen_draw_checkbox_field('notify', '', true); ?></div>
						<div><strong><?php echo ENTRY_AUTO_SHIPPING_COMMENTS; ?></strong> <?php echo zen_draw_checkbox_field('auto_shipping_comments', '', true).ENTRY_AUTO_SHIPPING_COMMENTS_KOME1; ?></div>
						<div><strong><?php echo ENTRY_NOTIFY_COMMENTS; ?></strong> <?php echo zen_draw_checkbox_field('notify_comments', '', true) .' '  ; ?></div>
						<div><?php echo zen_draw_textarea_field('comments', 'soft', '50', '2' ,'' ,' style="width:100%"'); ?></div>
						<div><?php echo zen_draw_file_field('imp_csv_file') .'<input type="submit" value="' .TEXT_IMPORT_CSV_SUBMIT .'">';?></form></div>
						<div><?php echo ENTRY_AUTO_SHIPPING_COMMENTS_INFO;?></div>
						</fieldset>
	  				</td>
	  			</tr>
	  		</table>
	  	</td>
	  </tr>
    </table></td>
<!-- body_text_eof //-->
  </tr>
</table>
<!-- body_eof //-->

<!-- footer //-->
<div class="footer-area">
<?php require(DIR_WS_INCLUDES . 'footer.php'); ?>
</div>
<!-- footer_eof //-->
<br />
</body>
</html>
<?php require(DIR_WS_INCLUDES . 'application_bottom.php'); ?>
<?php
function atobarai_csv_torihiki ($sql) {
	global $db ,$csv_torihiki_header;
	$main_body[] = '"' .implode('","' ,$csv_torihiki_header) .'"';
	$csv = $db->Execute($sql ." order by o.orders_id ASC");
    while (!$csv->EOF) {
    	  $order = new order($csv->fields['orders_id']);
    	  for ($i=0, $n=sizeof($order->products); $i<$n; $i++) {
    	  	$body_array = array();
		//注文日
		$body_array[] = ($i == 0) ? atobarai_datetime_format($order->info['date_purchased']) :'';
		//郵便番号
		$body_array[] = ($i == 0) ? atobarai_string_format('postcode' ,$order->billing['postcode']) :'';
		//住所
		$body_array[] = ($i == 0) ? atobarai_string_format('address' ,$order->billing['state'] .$order->billing['city'] .$order->billing['street_address'] .$order->billing['suburb']) :'';
		//氏名
		$body_array[] = ($i == 0) ? atobarai_string_format('name' ,$order->billing['name']) :'';
		//氏名かな
		$body_array[] = ($i == 0) ? atobarai_string_format('name_kana' ,$order->billing['name_kana']) :'';
		//電話番号
		$body_array[] = ($i == 0) ? atobarai_string_format('telephone' ,$order->billing['telephone']) :'';
		//メールアドレス
		$body_array[] = ($i == 0) ? atobarai_string_format('email_address' ,$order->customer['email_address']) :'';
		//職業
		$body_array[] = '';
	      $show_difference = true;
	      if (($csv->fields['delivery_name'] != $csv->fields['billing_name'] and $csv->fields['delivery_name'] != '')) {
	        $show_difference = false;
	      }
	      if (($csv->fields['delivery_street_address'] != $csv->fields['billing_street_address'] and $csv->fields['delivery_street_address'] != '')) {
	        $show_difference = false;
	      }
		//別配送先郵便番号
		if ($show_difference || ($i != 0)) {
			$body_array[] = '';
		} else {
			$body_array[] = atobarai_string_format('postcode' ,$order->delivery['postcode']);
		}
		//別配送先住所
		if ($show_difference || ($i != 0)) {
			$body_array[] = '';
		} else {
			$body_array[] = atobarai_string_format('address' ,$order->delivery['state'] .$order->delivery['city'] .$order->delivery['street_address'] .$order->delivery['suburb']);
		}
		//別配送先氏名
		if ($show_difference || ($i != 0)) {
			$body_array[] = '';
		} else {
			$body_array[] = atobarai_string_format('name' ,$order->delivery['name']);
		}
		//別配送先氏名かな
		if ($show_difference || ($i != 0)) {
			$body_array[] = '';
		} else {
			$body_array[] = atobarai_string_format('name_kana' ,$order->delivery['name_kana']);
		}
		//別配送先電話番号
		if ($show_difference || ($i != 0)) {
			$body_array[] = '';
		} else {
			$body_array[] = atobarai_string_format('telephone' ,$order->delivery['telephone']);
		}
		//購入品目(複数商品の場合は縦に列記)
		$body_array[] = atobarai_string_format('product_name' ,$order->products[$i]['name']);
		//単価
		//$body_array[] = zen_add_tax($order->products[$i]['final_price'], $order->products[$i]['tax']);
		$body_array[] = zen_round($order->products[$i]['final_price'], $currencies->currencies[DEFAULT_CURRENCY]['decimal_places']) + zen_calculate_tax($order->products[$i]['final_price'], $order->products[$i]['tax']);
		//数量
		$body_array[] = $order->products[$i]['qty'];
		//送料(複数商品がある場合は最後の行にあわせて入力)
		if (($i+1) == $n) {
			$shipping_cost = $db->Execute("select value from " .TABLE_ORDERS_TOTAL ." where orders_id='" .$csv->fields['orders_id'] ."' and class='ot_shipping'");
			$body_array[] = (int)$shipping_cost->fields['value'];
		} else {
			$body_array[] = '';
		}
		//店舗手数料(複数商品がある場合は最後の行にあわせて入力)
		if (($i+1) == $n) {
			$atobaraicom_cost = $db->Execute("select value from " .TABLE_ORDERS_TOTAL ." where orders_id='" .$csv->fields['orders_id'] ."' and class='ot_atobaraicom'");
			$body_array[] = (int)$atobaraicom_cost->fields['value'];
		} else {
			$body_array[] = '';
		}
		//請求金額合計(複数商品がある場合は最後の行にあわせて入力)
		if (($i+1) == $n) {
			$body_array[] = (int)$order->info['total'];
		} else {
			$body_array[] = '';
		}
		//受付サイト
		if ($i == 0) {
			$body_array[] = MODULE_PAYMENT_ATOBARAICOM_SITE_ID;
		} else {
			$body_array[] = '';
		}
		//任意注文番号
		if ($i == 0) {
			$body_array[] = $csv->fields['orders_id'];
		} else {
			$body_array[] = '';
		}
		//備考
		$body_array[] = '';
		$main_body[] = '"' .implode('","' ,$body_array) .'"';
    	  }
      $csv->MoveNext();
    }
	
	$csv_text = implode("\r\n" ,$main_body);
	atobarai_csv_output('uriage' ,$csv_text);
}

function atobarai_csv_shipping ($sql) {
	global $db ,$csv_shipping_header;
	$main_body[] = '"' .implode('","' ,$csv_shipping_header) .'"';
	$csv = $db->Execute($sql ." order by o.orders_id ASC");
    while (!$csv->EOF) {
    	  $order = new order($csv->fields['orders_id']);
    	  	$body_array = array();
		//注文ID(このデータは書き換えないでください)
		$body_array[] = '';
		//配送会社名
		$body_array[] = '';
		//配送伝票番号
		$body_array[] = '';
		//注文日(表示用データ。編集不可)
		$body_array[] = atobarai_datetime_format($order->info['date_purchased']);
		//購入者名(表示用データ。編集不可)
		$body_array[] = atobarai_string_format('name' ,$order->billing['name']);
		//購入者電話番号(表示用データ。編集不可)
		$body_array[] = atobarai_string_format('telephone' ,$order->billing['telephone']);
		//購入金額(表示用データ。編集不可)
		$body_array[] = (int)$order->info['total'];
		//配送先住所(表示用データ。編集不可)
		$body_array[] = atobarai_string_format('address' ,$order->delivery['state'] .$order->delivery['city'] .$order->delivery['street_address'] .$order->delivery['suburb']);
		//任意注文番号(このデータは書き換えないでください)
		$body_array[] = $csv->fields['orders_id'];
		$main_body[] = '"' .implode('","' ,$body_array) .'"';
      $csv->MoveNext();
    }
	
	$csv_text = implode("\r\n" ,$main_body);
	atobarai_csv_output('haisou' ,$csv_text);
}
function atobarai_string_format ($type ,$str) {
	global $moji_code;
	if (strlen($str) < 1) return false;
	$str = @preg_replace('/("|,)/' ,'' ,$str);
	$moji_count = 0;
	
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

function atobarai_csv_output($file_name ,$csv_text) {
	global $moji_code;
	$csv_text = mb_convert_encoding($csv_text, 'sjis-win', $moji_code);
	$file_name = $file_name .'-' . date("YmdHis") .'.csv';
	$temp = tempnam('' ,$file_name);
	$file = fopen($temp, "wb" );
	fputs($file, $csv_text);
	fclose($file);
	$len = filesize($temp);
	header ( "Content-Disposition: attachment; filename=$file_name" ) ;
	header ( "Content-type: text/octet-stream" ) ;
	header ( "Content-Length: ". $len ) ;
	$kanji_code = mb_internal_encoding();
	mb_http_output("SJIS");
	readfile($temp);
	mb_internal_encoding($kanji_code);
	unlink($temp);
	exit;
}

  function atobarai_datetime_format($raw_datetime) {
    if ( ($raw_datetime == '0001-01-01 00:00:00') || ($raw_datetime == '') ) return false;

    $year = (int)substr($raw_datetime, 0, 4);
    $month = (int)substr($raw_datetime, 5, 2);
    $day = (int)substr($raw_datetime, 8, 2);
    $hour = (int)substr($raw_datetime, 11, 2);
    $minute = (int)substr($raw_datetime, 14, 2);
    $second = (int)substr($raw_datetime, 17, 2);
    return date("Y/m/d", mktime($hour, $minute, $second, $month, $day, $year));
  }
  
  function fgetcsv_reg_atobarai (&$handle, $length = null, $d = ',', $e = '"') {
      $d = preg_quote($d);
      $e = preg_quote($e);
      $_line = "";
      while ($eof != true) {
          $_line .= (empty($length) ? fgets($handle) : fgets($handle, $length));
          $itemcnt = preg_match_all('/'.$e.'/', $_line, $dummy);
          if ($itemcnt % 2 == 0) $eof = true;
      }
      $_csv_line = preg_replace('/(?:\r\n|[\r\n])?$/', $d, trim($_line));
      $_csv_pattern = '/('.$e.'[^'.$e.']*(?:'.$e.$e.'[^'.$e.']*)*'.$e.'|[^'.$d.']*)'.$d.'/';
      preg_match_all($_csv_pattern, $_csv_line, $_csv_matches);
      $_csv_data = $_csv_matches[1];
      for($_csv_i=0;$_csv_i<count($_csv_data);$_csv_i++){
          $_csv_data[$_csv_i]=preg_replace('/^'.$e.'(.*)'.$e.'$/s','$1',$_csv_data[$_csv_i]);
          $_csv_data[$_csv_i]=str_replace($e.$e, $e, $_csv_data[$_csv_i]);
      }
      return empty($_line) ? false : $_csv_data;
  }
?>
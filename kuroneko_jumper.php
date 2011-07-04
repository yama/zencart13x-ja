<?php
//クロネコ＠ペイメント
//utf-8→sjisコンバーター
require('includes/application_top.php');
	  if (!$_SESSION['customer_id'] || MODULE_PAYMENT_KURONEKO_AT_PAYMENT_STATUS == 'False') {
	    $_SESSION['navigation']->set_snapshot();
	    zen_redirect(zen_href_link(FILENAME_LOGIN, '', 'SSL'));
	  }
	  if (isset($_POST) && sizeof($_POST) < 1) {
	    zen_redirect(zen_href_link(FILENAME_DEFAULT));
	  }
require(DIR_WS_LANGUAGES . $_SESSION['language'] .'/modules/payment/kuroneko_at_payment.php');
ob_start();
?>
<!doctype html public "-//W3C//DTD HTML 4.01 Transitional//EN">
<html dir="ltr" lang="ja">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=Shift_JIS">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Cache-Control" CONTENT="no-cache">
<title><?php echo MODULE_PAYMENT_KURONEKO_AT_PAYMENT_TEXT_TITLE; ?></title>
</head>
<body onLoad="document.UserForm.submit()">
<?php

$button_image = MODULE_PAYMENT_KURONEKO_AT_PAYMENT_BUTTON_IMAGE;
$button_alt = MODULE_PAYMENT_KURONEKO_AT_PAYMENT_BUTTON_ALT;
$action = MODULE_PAYMENT_KURONEKO_AT_PAYMENT_ACTION_URL;

      $link_button .= zen_draw_form('UserForm', $action, 'post' ,'onsubmit="this.onsubmit=function(){return false}"') . "\n";
      foreach ($_POST as $name => $value) {
      	//$link_button .= zen_draw_hidden_field($name, mb_convert_encoding($value, "EUC-JP", "UTF-8")) . "\n";
      	$link_button .= zen_draw_hidden_field($name, $value) . "\n";
      }
      $link_button .= zen_image_submit($button_image,$button_alt) . "\n";
      $link_button .= "</form>\n";
      echo '<br /><br /><div align="center"><b>お支払い手続きのページに移動します</b></div>
<br /><br />
<div align="center">自動的にページが切り替らない方は、下のボタンをクリックして進んでください。</div>
<br />
<div align="center">　' .$link_button .'　</div>
';
?>
</body>
</html>
<?php
$html = ob_get_contents();
ob_clean();
$html = mb_convert_encoding($html ,'Shift_JIS' ,'UTF-8');
header('content-type:text/html; charset=Shift_JIS');
echo $html;
?>
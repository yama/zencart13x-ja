<?php
/**
 * @copyright Copyright 2006-2008 Bigmouse, Inc
 * @copyright Portions Copyright 2003-2007 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: paypal.php 45 2008-07-25 07:48:54Z bigmouse-nfox $
**/

  define('MODULE_PAYMENT_PAYPAL_TEXT_ADMIN_TITLE', 'PayPal IPN - ウェブサイト決済スタンダード');
  define('MODULE_PAYMENT_PAYPAL_TEXT_CATALOG_TITLE', 'PayPal');
  if (IS_ADMIN_FLAG === true) {
    define('MODULE_PAYMENT_PAYPAL_TEXT_DESCRIPTION', '<strong>PayPal IPN</strong> (標準の PayPal　サービス)<br /><a href="https://www.paypal.com/j1/mrb/pal=UATS2MUHJ5AS8" target="_blank">PayPal アカウントの管理。</a><br /><br /><font color="green">設定方法:</font><br />1. <a href="https://www.paypal.com/j1/mrb/pal=UATS2MUHJ5AS8" target="_blank">まずペイパルのアカウントにログインしてください - ここをクリック</a><br />2. ペイパルのアカウントにログインしたら、<strong>「個人設定」</strong>をクリックします。<ul><li>「販売の設定」メニューにある<strong>「即時支払い通知の設定」</strong>を開き<span class="alert">「即時支払い通知を利用…」にチェックを入れます。</span><br /><strong>「通知URL:」に以下に表示されているURLを入力してください。</strong><br />(ペイパルの入力項目にすでに他のURLが設定され利用中であるなら変更しないでください)<br /><br />'.str_replace('index.php?main_page=index','ipn_main_handler.php',zen_catalog_href_link(FILENAME_DEFAULT, '', 'SSL')) . '<br /><br /></li><li>同じく「販売の設定」にある<strong>「ウェブサイト決済の設定」</strong> を開き<strong>「自動復帰」</strong>のチェックボックスを<strong>「オン」</strong>にします。<br /><strong>「復帰URL:」に以下に表示されているURLを入力してください</strong><br /><br />'.zen_catalog_href_link(FILENAME_CHECKOUT_PROCESS, '', 'SSL',false).'</li>' . (defined('MODULE_PAYMENT_PAYPAL_STATUS') ? '' : '<br /><li>ペイパルの設定が完了したら、このページにある<strong>「モジュールインストール」</strong>をクリックして「PayPal 支払い」を有効にしてください。表示される設定項目を正しく入力して保存します。</li>') . '</ul><font color="green"><hr /><strong>利用条件:</strong></font><br /><hr />*<strong>PayPal アカウント</strong> (<a href="http://www.zen-cart.com/partners/paypal" target="_blank"> 無い場合はここから新規登録</a>)<br />*<strong>Port 80</strong> が利用サーバーのルータ/ファイアーウォールの設定で開かれており、双方向通信が可能になっていること。<br />*<strong>allow_url_fopen</strong> がPHP の設定で利用可能になっていること。<br />*<strong>各種設定</strong> が上記に従い正しく行われていること。' );
  } else {
    define('MODULE_PAYMENT_PAYPAL_TEXT_DESCRIPTION', '<strong>PayPal</strong>');
  }
  // to show the PayPal logo as the payment option name, use this:  https://www.paypal.com/en_US/i/logo/PayPal_mark_37x23.gif
  // to show CC icons with PayPal, use this instead:  https://www.paypal.com/en_US/i/bnr/horizontal_solution_PPeCheck.gif
  define('MODULE_PAYMENT_PAYPALWPP_MARK_BUTTON_IMG', 'https://www.paypal.com/en_US/i/logo/PayPal_mark_37x23.gif');
  define('MODULE_PAYMENT_PAYPALWPP_MARK_BUTTON_ALT', 'PayPalで支払い');
  define('MODULE_PAYMENT_PAYPAL_ACCEPTANCE_MARK_TEXT', '安全・簡単にお支払い <br />支払情報を入力しなくても決済ができます！');

  define('MODULE_PAYMENT_PAYPAL_TEXT_CATALOG_LOGO', '<img src="' . MODULE_PAYMENT_PAYPALWPP_MARK_BUTTON_IMG . '" alt="' . MODULE_PAYMENT_PAYPALWPP_MARK_BUTTON_ALT . '" title="' . MODULE_PAYMENT_PAYPALWPP_MARK_BUTTON_ALT . '" /> &nbsp;' .  '<span class="smallText">' . MODULE_PAYMENT_PAYPAL_ACCEPTANCE_MARK_TEXT . '</span>');

  define('MODULE_PAYMENT_PAYPAL_ENTRY_FIRST_NAME', '姓:');
  define('MODULE_PAYMENT_PAYPAL_ENTRY_LAST_NAME', '名:');
  define('MODULE_PAYMENT_PAYPAL_ENTRY_BUSINESS_NAME', '事業名:');
  define('MODULE_PAYMENT_PAYPAL_ENTRY_ADDRESS_NAME', '表示名:');
  define('MODULE_PAYMENT_PAYPAL_ENTRY_ADDRESS_STREET', '番地 マンション・アパート名:');
  define('MODULE_PAYMENT_PAYPAL_ENTRY_ADDRESS_CITY', '市町村区:');
  define('MODULE_PAYMENT_PAYPAL_ENTRY_ADDRESS_STATE', '都道府県:');
  define('MODULE_PAYMENT_PAYPAL_ENTRY_ADDRESS_ZIP', '郵便番号:');
  define('MODULE_PAYMENT_PAYPAL_ENTRY_ADDRESS_COUNTRY', '国名:');
  define('MODULE_PAYMENT_PAYPAL_ENTRY_EMAIL_ADDRESS', '支払人メールアドレス:');
  define('MODULE_PAYMENT_PAYPAL_ENTRY_EBAY_ID', 'Ebay ID:');
  define('MODULE_PAYMENT_PAYPAL_ENTRY_PAYER_ID', '支払人 ID:');
  define('MODULE_PAYMENT_PAYPAL_ENTRY_PAYER_STATUS', '支払人ステータス:');
  define('MODULE_PAYMENT_PAYPAL_ENTRY_ADDRESS_STATUS', '住所ステータス:');

  define('MODULE_PAYMENT_PAYPAL_ENTRY_PAYMENT_TYPE', '支払タイプ:');
  define('MODULE_PAYMENT_PAYPAL_ENTRY_PAYMENT_STATUS', '支払ステータス:');
  define('MODULE_PAYMENT_PAYPAL_ENTRY_PENDING_REASON', '保留事由:');
  define('MODULE_PAYMENT_PAYPAL_ENTRY_INVOICE', '通知:');
  define('MODULE_PAYMENT_PAYPAL_ENTRY_PAYMENT_DATE', '支払日:');
  define('MODULE_PAYMENT_PAYPAL_ENTRY_CURRENCY', '通貨:');
  define('MODULE_PAYMENT_PAYPAL_ENTRY_GROSS_AMOUNT', '総合計:');
  define('MODULE_PAYMENT_PAYPAL_ENTRY_PAYMENT_FEE', '支払手数料:');
  define('MODULE_PAYMENT_PAYPAL_ENTRY_EXCHANGE_RATE', '通貨換算レート:');
  define('MODULE_PAYMENT_PAYPAL_ENTRY_CART_ITEMS', '商品点数:');
  define('MODULE_PAYMENT_PAYPAL_ENTRY_TXN_TYPE', '取引タイプ:');
  define('MODULE_PAYMENT_PAYPAL_ENTRY_TXN_ID', '取引ID:');
  define('MODULE_PAYMENT_PAYPAL_ENTRY_PARENT_TXN_ID', '親取引ID:');


  define('MODULE_PAYMENT_PAYPAL_PURCHASE_DESCRIPTION_TITLE', STORE_NAME . 'での購入商品');
  define('MODULE_PAYMENT_PAYPAL_PURCHASE_DESCRIPTION_ITEMNUM', 'ショップの注文明細を参照');

?>
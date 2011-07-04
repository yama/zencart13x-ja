<?php
/**
 * @package languageDefines
 * @copyright Copyright 2003-2006 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: create_account.php 17 2008-02-14 03:43:21Z bigmouse-sugimoto $
 */

define('NAVBAR_TITLE', 'アカウント作成');

define('HEADING_TITLE', 'アカウント作成');

define('TEXT_ORIGIN_LOGIN', '<strong class="note">注意:</strong>すでに当ショップでのアカウントをお持ちの場合は、<a href="%s">こちら</a>からログインしてください。');

// greeting salutation
define('EMAIL_SUBJECT', STORE_NAME . 'へようこそ');
define('EMAIL_GREET_MR', '%s 様' . "\n\n");
define('EMAIL_GREET_MS', '%s 様' . "\n\n");
define('EMAIL_GREET_NONE', '%s 様' . "\n\n");

// First line of the greeting
define('EMAIL_WELCOME', '謹啓　この度は<strong>' . STORE_NAME . 'にご登録いただきありがとうございました。</strong>');
define('EMAIL_SEPARATOR', '--------------------');
define('EMAIL_COUPON_INCENTIVE_HEADER', 'ご登録いただいたお礼に、<strong>' . STORE_NAME . '</strong>をご利用の際にお使い' . "\n" .'いただける「割引クーポン」をお送りします!' . "<br /><br />\n\n");
// your Discount Coupon Description will be inserted before this next define
define('EMAIL_COUPON_REDEEM','この割引クーポンをお使いになるには、お買い物の精算時に以下のコードを入力' . "\n" . 'してください。' . "<br /><br />\n\n" . 'クーポンコード： <strong>%s</strong>' . "\n\n");
define('TEXT_COUPON_HELP_DATE', '<p>このクーポンの有効期限は %s から %s までとなっております。</p>');

define('EMAIL_GV_INCENTIVE_HEADER', '本日に限り %sの' . TEXT_GV_NAME . 'をお送りします!' . "<br />\n\n");
define('EMAIL_GV_REDEEM', '' . TEXT_GV_NAME . ' ' . TEXT_GV_REDEEM . ' : %s ' . "<br /><br />\n\n" . 'お客様が当ショップで商品をお選びになった後、精算時に「' . TEXT_GV_REDEEM . '」を' . "\n" . '入力していただくことでお使いいただけます。<br />' . "\n");
define('EMAIL_GV_LINK', '下記のリンクから今すぐ引き換えることもできます。' . "<br />\n\n");
// GV link will automatically be included before this line

define('EMAIL_GV_LINK_OTHER','<br />お客様ご自身のアカウントに' . TEXT_GV_NAME . 'を追加しておけば、ご自分で' . TEXT_GV_NAME . 'を' . "\n" . 'お使いいただくこともできます。<br />またお知り合いの方にプレゼントすることもできます。' . "\n\n");

define('EMAIL_TEXT', 
 '当ショップにご登録いただいたアカウントで、お客様はこれから以下の<strong>便利な' . "\n" . 
 'サービス</strong>をご利用いただけます。' . "<br /><br />\n\n" . 
 '・<strong>ショッピングカート</strong>' . "<br />\n" . 
 'ショッピングカートに入れた商品は、削除または精算するまで保持しておくこと' . "\n" . 'ができます。' . "<br /><br />\n\n" . 
 '・<strong>アドレス帳</strong>' . "<br />\n" . 
 ' 贈り物などの際に便利なように、ご自宅の他にもお届け先を5件まで登録する' . "\n" . 'ことができます。' . "<br /><br />\n\n" . 
 '・<strong>注文履歴</strong>' . "<br />\n" . 
 'マイページから、当店でご注文いただいた商品の一覧を確認することができます。' . "<br /><br />\n\n" . 
 '・<strong>商品のレビュー</strong>' . "<br />\n" . 
 '当ショップの商品についてのレビュー(感想)を書き込んでいただくことができます。' . "<br />\n" . 
 '是非他のお客様に感想をお伝えください。' . "\n\n");
define('EMAIL_CONTACT', '当ショップのオンラインサービスで何かご不明な点がございましたら、Eメール' . "\n" . 'にてお気軽にお問い合わせ下さい。' . "<br />\n" . 'お問合せ： <a href="mailto:' . STORE_OWNER_EMAIL_ADDRESS . '">'. STORE_OWNER_EMAIL_ADDRESS ." </a><br /><br />\n\n");
define('EMAIL_GV_CLOSURE','謹白' . "\n\n店長 " . STORE_OWNER . "\n\n". '<a href="' . HTTP_SERVER . DIR_WS_CATALOG . '">'.HTTP_SERVER . DIR_WS_CATALOG ."</a>\n\n");

// email disclaimer - this disclaimer is separate from all other email disclaimers
define('EMAIL_DISCLAIMER_NEW_CUSTOMER', 'このメールアドレスは、お客様ご自身によって当ショップに登録されました。' . "<br />\n" . 'もしアカウント登録をされた覚えがない場合には、お手数ですが %s までご連絡ください。');

//moved definitions to english.php
//define('TABLE_HEADING_PRIVACY_CONDITIONS', 'Privacy Statement');
//define('TEXT_PRIVACY_CONDITIONS_DESCRIPTION', 'Please acknowledge you agree with our privacy statement by ticking the following box. The privacy statement can be read <a href="' . zen_href_link(FILENAME_PRIVACY, '', 'SSL') . '"><span class="pseudolink">here</span></a>.');
//define('TEXT_PRIVACY_CONDITIONS_CONFIRM', 'I have read and agreed to your privacy statement.');
//define('TABLE_HEADING_ADDRESS_DETAILS', 'Address Details');
//define('TABLE_HEADING_PHONE_FAX_DETAILS', 'Additional Contact Details');
//define('TABLE_HEADING_DATE_OF_BIRTH', 'Verify Your Age');
//define('TABLE_HEADING_LOGIN_DETAILS', 'Login Details');
//define('TABLE_HEADING_REFERRAL_DETAILS', 'Were You Referred to Us?');
?>

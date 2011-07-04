<?php
/**
 * @package languageDefines
 * @copyright Copyright 2003-2007 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: email_extras.php 17 2008-02-14 03:43:21Z bigmouse-sugimoto $
 */

// office use only
  define('OFFICE_FROM','<strong>差出人:</strong>');
  define('OFFICE_EMAIL','<strong>メール:</strong>');

  define('OFFICE_SENT_TO','<strong>宛先:</strong>');
  define('OFFICE_EMAIL_TO','<strong>メール:</strong>');

  define('OFFICE_USE','<strong>事務欄:</strong>');
  define('OFFICE_LOGIN_NAME','<strong>ログイン名:</strong>');
  define('OFFICE_LOGIN_EMAIL','<strong>ログイン用メールアドレス:</strong>');
  define('OFFICE_LOGIN_PHONE','<strong>電話番号:</strong>');
  define('OFFICE_LOGIN_FAX','<strong>Fax:</strong>');
  define('OFFICE_IP_ADDRESS','<strong>IPアドレス:</strong>');
  define('OFFICE_HOST_ADDRESS','<strong>ホストアドレス:</strong>');
  define('OFFICE_DATE_TIME','<strong>日時:</strong>');
  if (!defined('OFFICE_IP_TO_HOST_ADDRESS')) define('OFFICE_IP_TO_HOST_ADDRESS', '非表示');

  define('EMAIL_GREET', '様');

// email disclaimer
  define('EMAIL_DISCLAIMER', 'このメールは当ショップに登録されたお客様に対してお送りしています。' . "\n" . 'お心当たりが無いようでしたら大変お手数ですがメールにて' . "\n" . ' %s までご連絡ください。');
  define('EMAIL_SPAM_DISCLAIMER','このメールは、「特定電子メールの送信の適正化等に関する法律」の表示義務' . "\n" . '（第３条）に準拠して送信されました。配信停止を希望される場合は、こちらの' . "\n" . 'メールの差出人アドレスにリクエストいただければ速やかに対処いたします。');
  define('EMAIL_FOOTER_COPYRIGHT','Copyright (c) 2003-2006 <a href="http://www.zen-cart.com" target="_blank">Zen Cart</a>. Powered by <a href="http://www.zen-cart.com" target="_blank">Zen Cart</a>');
  define('TEXT_UNSUBSCRIBE', "\n\n今後メールマガジンやお知らせメールの配信の停止を希望される場合は、以下のリンクをクリックしてください: \n");

// email advisory for all emails customer generate - tell-a-friend and GV send
  define('EMAIL_ADVISORY', '-----' . "\n" . '「<strong>重要:</strong>お客様の個人情報保護および迷惑行為防止のために、当ショップを経由' . "\n" . 'して送信されるメールはショップ管理者が通信記録として保存しています。' . "\n" . 'もしこのメールにお心当たりがないようでしたら、大変お手数ですがメールにて' . "\n" . STORE_OWNER_EMAIL_ADDRESS . ' までご連絡くださいますようお願いいたします。」' . "\n\n");

// email advisory included warning for all emails customer generate - tell-a-friend and GV send
  define('EMAIL_ADVISORY_INCLUDED_WARNING', '<strong>このサイトを経由して送信される全てのEメールの末尾に以下のメッセージが付加されます:</strong><br />');


// Admin additional email subjects
  define('SEND_EXTRA_CREATE_ACCOUNT_EMAILS_TO_SUBJECT','[アカウント作成]');
  define('SEND_EXTRA_TELL_A_FRIEND_EMAILS_TO_SUBJECT','[友達に教える]');
  define('SEND_EXTRA_GV_CUSTOMER_EMAILS_TO_SUBJECT','[ギフト券の贈呈]');
  define('SEND_EXTRA_NEW_ORDERS_EMAILS_TO_SUBJECT','[新規注文]');
  define('SEND_EXTRA_CC_EMAILS_TO_SUBJECT','[クレジットカード番号情報] #');

// Low Stock Emails
  define('EMAIL_TEXT_SUBJECT_LOWSTOCK','警告: 在庫が少なくなりました');
  define('SEND_EXTRA_LOW_STOCK_EMAIL_TITLE','在庫警告レポート: ');

// for when gethost is off
  define('OFFICE_IP_TO_HOST_ADDRESS', '非表示');
?>
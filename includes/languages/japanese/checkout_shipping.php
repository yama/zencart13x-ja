<?php
/**
 * @package languageDefines
 * @copyright Copyright 2003-2006 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: checkout_shipping.php 17 2008-02-14 03:43:21Z bigmouse-sugimoto $
 */

define('NAVBAR_TITLE_1', 'レジへ進む');
define('NAVBAR_TITLE_2', '配送情報');

define('HEADING_TITLE', 'ステップ１ - お届け先と配送方法を記入してください');

define('TABLE_HEADING_SHIPPING_ADDRESS', 'お届け先住所');
define('TEXT_CHOOSE_SHIPPING_DESTINATION', 'ご注文の品物は左記の住所にお届けします。<em>お届け先の変更</em>ボタンをクリックしてお届け先を変更できます。');
define('TITLE_SHIPPING_ADDRESS', 'お届け先:');

define('TABLE_HEADING_SHIPPING_METHOD', '配送方法:');
define('TEXT_CHOOSE_SHIPPING_METHOD', 'ご希望の配送方法をお選び下さい。');
define('TITLE_PLEASE_SELECT', '選択してください');
define('TEXT_ENTER_SHIPPING_INFORMATION', '今回のご注文でご利用いただける配送方法はこちらのみです。');

define('TITLE_NO_SHIPPING_AVAILABLE', '今回ご利用可能な配送方法がありません');
define('TEXT_NO_SHIPPING_AVAILABLE','<span class="alert">申し訳ありません。今回あなたのお住まいの地域で利用可能な配送方法がありません。</span><br />別の手段を検討させていただきますので、当店まで直接お問い合わせください。');

define('TABLE_HEADING_COMMENTS', '注文についてご意見、ご要望などあればご記入ください。');

define('TITLE_CONTINUE_CHECKOUT_PROCEDURE', '次画面に進んでください');
define('TEXT_CONTINUE_CHECKOUT_PROCEDURE', '→お支払い方法を選択');

// when free shipping for orders over $XX.00 is active
  define('FREE_SHIPPING_TITLE', '配送料無料');
  define('FREE_SHIPPING_DESCRIPTION', '%s以上お買い上げの場合、配送料が無料になります。');
?>

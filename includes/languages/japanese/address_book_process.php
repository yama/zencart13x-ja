<?php
/**
 * @package languageDefines
 * @copyright Copyright 2003-2005 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: address_book_process.php 17 2008-02-14 03:43:21Z bigmouse-sugimoto $
 */

define('NAVBAR_TITLE_1', 'マイページ');
define('NAVBAR_TITLE_2', 'アドレス帳');

define('NAVBAR_TITLE_ADD_ENTRY', '新規住所登録');
define('NAVBAR_TITLE_MODIFY_ENTRY', '住所変更');
define('NAVBAR_TITLE_DELETE_ENTRY', '住所の削除');

define('HEADING_TITLE_ADD_ENTRY', '<h1>新規住所登録</h1>');
define('HEADING_TITLE_MODIFY_ENTRY', '<h1>住所変更</h1>');
define('HEADING_TITLE_DELETE_ENTRY', '<h1>住所の削除</h1>');
define('HEADING_TITLE', '住所');

define('DELETE_ADDRESS_TITLE', '住所削除');
define('DELETE_ADDRESS_DESCRIPTION', 'この住所を本当に削除してもよろしいですか?');

define('NEW_ADDRESS_TITLE', '新規住所追加');

define('SELECTED_ADDRESS', '削除される住所');
define('SET_AS_PRIMARY', 'お客様の住所を設定する');

define('SUCCESS_ADDRESS_BOOK_ENTRY_DELETED', '指定された住所をアドレス帳から削除しました。.');
define('SUCCESS_ADDRESS_BOOK_ENTRY_UPDATED', 'アドレス帳が更新されました。');

define('WARNING_PRIMARY_ADDRESS_DELETION', 'お客様の住所は削除できません。もう一度違う住所で設定し直してください。');

define('ERROR_NONEXISTING_ADDRESS_BOOK_ENTRY', '現在アドレス帳には何も登録されていません。');
define('ERROR_ADDRESS_BOOK_FULL', 'アドレス帳にこれ以上登録できません。新しく住所を登録するには古い住所を一つ以上削除してください。');
//add nfox
define('ERROR_ADDRESS_BOOK_COUNTRY_ERROR', '当ショップで御利用できる国に変更があり、お客様の登録されている国はお取り扱い出来なくなりました。<br />詳しい情報はショップまでお問い合わせください。');
?>

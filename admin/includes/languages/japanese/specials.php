<?php
//
// +----------------------------------------------------------------------+
// |zen-cart Open Source E-commerce                                       |
// +----------------------------------------------------------------------+
// | Copyright (c) 2003 The zen-cart developers                           |
// |                                                                      |
// | http://www.zen-cart.com/index.php                                    |
// |                                                                      |
// | Portions Copyright (c) 2003 osCommerce                               |
// +----------------------------------------------------------------------+
// | This source file is subject to version 2.0 of the GPL license,       |
// | that is bundled with this package in the file LICENSE, and is        |
// | available through the world-wide-web at the following url:           |
// | http://www.zen-cart.com/license/2_0.txt.                             |
// | If you did not receive a copy of the zen-cart license and are unable |
// | to obtain it through the world-wide-web, please send a note to       |
// | license@zen-cart.com so we can mail you a copy immediately.          |
// +----------------------------------------------------------------------+
//  $Id: specials.php 17 2008-02-14 03:43:21Z bigmouse-sugimoto $
//

define('HEADING_TITLE', '特価商品の管理');

define('TABLE_HEADING_PRODUCTS', '商品名');
define('TABLE_HEADING_PRODUCTS_MODEL','型番');
define('TABLE_HEADING_PRODUCTS_PRICE', '商品価格/特価価格/セール価格');
define('TABLE_HEADING_PRODUCTS_PERCENTAGE','パーセント');
define('TABLE_HEADING_AVAILABLE_DATE', '提供開始日');
define('TABLE_HEADING_EXPIRES_DATE','提供終了日');
define('TABLE_HEADING_STATUS', 'ステータス');
define('TABLE_HEADING_ACTION', '操作');

define('TEXT_SPECIALS_PRODUCT', '商品名:');
define('TEXT_SPECIALS_SPECIAL_PRICE', '特価価格:');
define('TEXT_SPECIALS_EXPIRES_DATE', '提供終了日:');
define('TEXT_SPECIALS_AVAILABLE_DATE', '提供開始日:');
define('TEXT_SPECIALS_PRICE_TIP', '<b>注:</b><ul><li>割引率をパーセントで入力できます。例：<b>20%</b></li><li>新しい価格を入力する場合には、小数点\'.\'で区切ってください。例：<b>49.99</b></li><li>期間を限定したくない場合は「終了日」を未記入のままにしておいてください。</li></ul>');

define('TEXT_INFO_DATE_ADDED', '登録日：');
define('TEXT_INFO_LAST_MODIFIED', '更新日：');
define('TEXT_INFO_NEW_PRICE', '新価格：');
define('TEXT_INFO_ORIGINAL_PRICE', '元の価格：');
define('TEXT_INFO_DISPLAY_PRICE', '表示価格：<br />');
define('TEXT_INFO_AVAILABLE_DATE', '提供開始日：');
define('TEXT_INFO_EXPIRES_DATE', '提供終了日：');
define('TEXT_INFO_STATUS_CHANGE', 'ステータス変更：');
define('TEXT_IMAGE_NONEXISTENT', '画像が存在しません。');

define('TEXT_INFO_HEADING_DELETE_SPECIALS', '特価商品を削除');
define('TEXT_INFO_DELETE_INTRO', 'この特価商品を本当に削除しますか?');

define('SUCCESS_SPECIALS_PRE_ADD', '特価商品の追加に成功しました');
define('WARNING_SPECIALS_PRE_ADD_EMPTY', '警告：商品IDが指定されていません ... 商品は追加されませんでした ...');
define('WARNING_SPECIALS_PRE_ADD_DUPLICATE', '警告: 既に特価商品に登録済みの商品IDです ... 商品は追加されませんでした ...');
define('WARNING_SPECIALS_PRE_ADD_BAD_PRODUCTS_ID', '指定された商品IDは登録されていません');
define('TEXT_INFO_HEADING_PRE_ADD_SPECIALS', '商品IDを指定して特価商品を追加');
define('TEXT_INFO_PRE_ADD_INTRO', '大量の商品を登録している場合などは、商品のドロップダウンを作成する事を考えると直接指定したほうが効率が良い事があります。');
define('TEXT_PRE_ADD_PRODUCTS_ID', '特価商品に追加したい商品IDを入力してください');
define('TEXT_INFO_MANUAL', '商品IDを指定して特価商品を追加');
?>

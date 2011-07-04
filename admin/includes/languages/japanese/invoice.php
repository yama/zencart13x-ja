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
//  $Id: invoice.php 17 2008-02-14 03:43:21Z bigmouse-sugimoto $
//

define('TABLE_HEADING_COMMENTS', 'コメント');
define('TABLE_HEADING_CUSTOMER_NOTIFIED', 'お客様へのお知らせメール送信');
define('TABLE_HEADING_DATE_ADDED', '処理日');
define('TABLE_HEADING_STATUS', '注文処理状況');

define('TABLE_HEADING_PRODUCTS_MODEL', '型番');
define('TABLE_HEADING_PRODUCTS', '商品名');
define('TABLE_HEADING_TAX', '税金');
define('TABLE_HEADING_TOTAL', '合計');
define('TABLE_HEADING_PRICE_EXCLUDING_TAX', '価格 (税別)');
define('TABLE_HEADING_PRICE_INCLUDING_TAX', '価格 (税込み)');
define('TABLE_HEADING_TOTAL_EXCLUDING_TAX', '合計 (税別)');
define('TABLE_HEADING_TOTAL_INCLUDING_TAX', '合計 (税込み)');

define('ENTRY_CUSTOMER', 'ご注文者様:');

define('ENTRY_SOLD_TO', '請求先:');
define('ENTRY_SHIP_TO', 'お届け先:');
define('ENTRY_PAYMENT_METHOD', 'お支払方法:');
define('ENTRY_SUB_TOTAL', '小計:');
define('ENTRY_TAX', '税金:');
define('ENTRY_SHIPPING', '配送:');
define('ENTRY_TOTAL', '合計:');
define('ENTRY_DATE_PURCHASED', 'ご注文日:');

define('ENTRY_ORDER_ID','注文番号 ');
define('TEXT_INFO_ATTRIBUTE_FREE', '&nbsp;-&nbsp;FREE');
?>

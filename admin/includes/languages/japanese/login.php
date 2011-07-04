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
//  $Id: login.php 17 2008-02-14 03:43:21Z bigmouse-sugimoto $
//

define('HEADING_TITLE', '管理者ログイン');

define('TEXT_ADMIN_NAME', '管理者ユーザID: ');
define('TEXT_ADMIN_PASS', '管理者パスワード: ');

define('ERROR_WRONG_LOGIN', '<p>ユーザIDまたはパスワードが間違っています。</p>');
define('ERROR_SECURITY_ERROR', 'ログイン時にセキュリティ上のエラーが発生しました。');

define('TEXT_PASSWORD_FORGOTTEN', 'パスワード再送信');
?>
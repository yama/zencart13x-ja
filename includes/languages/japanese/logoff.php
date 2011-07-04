<?php
/**
 * @package languageDefines
 * @copyright Copyright 2003-2006 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: logoff.php 17 2008-02-14 03:43:21Z bigmouse-sugimoto $
 */

define('HEADING_TITLE', 'ログアウト');
define('NAVBAR_TITLE', 'ログアウト');
define('TEXT_MAIN', 'ログアウトしました。<br /><br />カートの内容はログアウト前の状態で保存されています。<br />アカウントに<a href="' . zen_href_link(FILENAME_LOGIN, '', 'SSL') . '"><span class="pseudolink">再度ログイン</span></a>した際にカートの情報は復元されます。<br />');

?>
<?php 
/**
 * @package patches
 * @copyright Copyright 2003-2009 Zen Cart Development Team
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: security_patch_v138_20090619.php 346 2009-07-07 09:39:17Z bigmouse-sugimoto $
 */
/**
 * Security Patch v138 20090619
 * @package patches
 */ 
if (basename ( $PHP_SELF ) == FILENAME_PASSWORD_FORGOTTEN . '.php' && substr_count ( $PHP_SELF, '.php' ) > 1)
{
  zen_redirect ( zen_href_link ( FILENAME_LOGIN, '', 'SSL' ) );
}
<?php
/**
 * @copyright Copyright 2006-2008 Bigmouse, Inc
 * @copyright Portions Copyright 2003-2007 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: ie8.php 383 2010-01-05 01:15:30Z bigmouse-nfox $
**/

function zen_ie8_header () {
 if (strstr($_SERVER['HTTP_USER_AGENT'], 'Trident/4.0') && strspn($_SERVER['HTTP_USER_AGENT'], 'compatible; MSIE 8')) header("X-UA-Compatible: IE=emulateIE7");
}
?>
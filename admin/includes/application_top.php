<?php
/**
 * @package admin
 * @copyright Copyright 2003-2007 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: application_top.php 2 2010-11-05 09:04:44Z kitsune3 $
 */
/**
 * File contains just application_top code
 *
 * Initializes common classes & methods. Controlled by an array which describes
 * the elements to be initialised and the order in which that happens.
 *
 * @package admin
 * @copyright Copyright 2003-2007 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 */
define('DEBUG_AUTOLOAD', false); // boolean if true the autoloader scripts will be parsed and their output shown. For debugging purposes only.
define('IS_ADMIN_FLAG', true); // boolean used to see if we are in the admin script, obviously set to false here. DO NOT REMOVE THE define BELOW. WILL BREAK ADMIN
define('PAGE_PARSE_START_TIME', microtime()); // integer saves the time at which the script started. Start the clock for the page parse time log

/**
* set the level of error reporting
*
* Note STRICT_ERROR_REPORTING should never be set to true on a production site. <br />
* It is mainly there to show php warnings during testing/bug fixing phases.<br />
* note for strict error reporting we also turn on show_errors as this may be disabled<br />
* in php.ini. Otherwise we respect the php.ini setting
*
*/
if (defined('STRICT_ERROR_REPORTING') && STRICT_ERROR_REPORTING == true)
{
	@ini_set('display_errors', TRUE);
	if    (version_compare(6.0, PHP_VERSION, '<=')) error_reporting(E_ALL & ~E_DEPRECATED & ~E_NOTICE & ~E_STRICT);
	elseif(version_compare(5.3, PHP_VERSION, '<=')) error_reporting(E_ALL & ~E_DEPRECATED & ~E_NOTICE);
	else                                            error_reporting(E_ALL & ~E_NOTICE);
}
else
{
	error_reporting(0);
}

// turn off magic-quotes support, for both runtime and sybase, as both will cause problems if enabled
if(function_exists('set_magic_quotes_runtime') && version_compare(PHP_VERSION, 5.3, '<')) set_magic_quotes_runtime(0);
if(@ini_get('magic_quotes_sybase') != 0) @ini_set('magic_quotes_sybase', 0);
if(!isset($PHP_SELF)) $PHP_SELF = $_SERVER['PHP_SELF']; // set php_self in the local scope

// Set the local configuration parameters - mainly for developers
if(file_exists('includes/local/configure.php'))
{
	include('includes/local/configure.php'); // load any local(user created) configure file.
}

// check for and load application configuration parameters
if(file_exists('includes/configure.php'))
{
	include('includes/configure.php'); // load the main configure file.
}
if(!defined('DIR_FS_CATALOG') || !is_dir(DIR_FS_CATALOG.'/includes/classes') || !defined('DB_TYPE') || DB_TYPE == '')
{
	if (file_exists('../includes/templates/template_default/templates/tpl_zc_install_suggested_default.php'))
	{
		require('../includes/templates/template_default/templates/tpl_zc_install_suggested_default.php');
		exit;
	}
	else
	{
		die('ERROR: admin/includes/configure.php file not found. Suggest running zc_install/index.php?');
	}
}

// ignore version-check if INI file setting has been set
if (file_exists(DIR_FS_ADMIN . 'includes/local/skip_version_check.ini'))
{
	$lines = @file(DIR_FS_ADMIN . 'includes/local/skip_version_check.ini');
	if (is_array($lines))
	{
		foreach($lines as $line)
		{
			if (substr($line,0,14)=='admin_configure_php_check=') $check_cfg=substr(trim(strtolower(str_replace('admin_configure_php_check=','',$line))),0,3);
		}
	}
}

// include the list of extra configure files
if($za_dir = @dir(DIR_WS_INCLUDES . 'extra_configures'))
{
	while ($zv_file = $za_dir->read())
	{
		if(preg_match('/\.php$/', $zv_file) > 0)
		{
			include(DIR_WS_INCLUDES . 'extra_configures/' . $zv_file); // load any user/contribution specific configuration files.
		}
	}
	$za_dir->close();
}

// init some vars
$template_dir = '';
define('DIR_WS_TEMPLATES', DIR_WS_INCLUDES . 'templates/');

// Prepare init-system
unset($loaderPrefix); // admin doesn't need this override
$autoLoadConfig = array();
if (isset($loaderPrefix))
{
	$loaderPrefix = preg_replace('/[a-z_]^/', '', $loaderPrefix);
}
else
{
	$loaderPrefix = 'config';
}
$loader_file = $loaderPrefix . '.core.php';
require('includes/initsystem.php');

// load the autoloader interpreter code.
require(DIR_FS_CATALOG . 'includes/autoload_func.php');

<?php
/**
 * @package admin
 * @copyright Copyright 2003-2006 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: configuration_dhtml.php - amendment for Admin Profiles 2006-04-17 by kuroi
 */
if (!defined('IS_ADMIN_FLAG')) die('Illegal Access');

$za_heading['text'] = BOX_HEADING_CONFIGURATION;
$za_heading['link'] = zen_href_link(FILENAME_ALT_NAV, '', 'NONSSL');

$tbl_cfg_group = TABLE_CONFIGURATION_GROUP;
$sql = "select configuration_group_id as cgID,configuration_group_title as cgTitle from {$tbl_cfg_group} where visible = '1' order by sort_order";
$configuration_groups = $db->Execute($sql);

$za_contents = array();
while(!$configuration_groups->EOF)
{
	$item['text'] = $configuration_groups->fields['cgTitle'];
	$item['link'] = zen_href_link(FILENAME_CONFIGURATION, 'gID=' . $configuration_groups->fields['cgID'], 'NONSSL');
	$za_contents[] = $item;
	$configuration_groups->MoveNext();
}

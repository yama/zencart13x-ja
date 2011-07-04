<?php
/**
 * @package admin
 * @copyright Copyright 2003-2006 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: configuration_dhtml.php - amendment for Admin Profiles 2006-04-17 by kuroi
 */
if (!defined('IS_ADMIN_FLAG')) {
  die('Illegal Access');
}

  $za_heading = array('text' => BOX_HEADING_CONFIGURATION, 'link' => zen_href_link(FILENAME_ALT_NAV, '', 'NONSSL'));
  $za_contents = '';
  if (1 == 1) {
    $cfg_groups = '';
    $configuration_groups = $db->Execute("select configuration_group_id as cgID,
                                                       configuration_group_title as cgTitle
                                                from " . TABLE_CONFIGURATION_GROUP . "
                                                where visible = '1' order by sort_order");

    while (!$configuration_groups->EOF) {
      $za_contents[] = array('text' => $configuration_groups->fields['cgTitle'], 'link' => zen_href_link(FILENAME_CONFIGURATION, 'gID=' . $configuration_groups->fields['cgID'], 'NONSSL'));
      $configuration_groups->MoveNext();
    }
  }
//echo $cfg_groups;
?>
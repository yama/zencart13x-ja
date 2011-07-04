<?php
/**
 * Low Priority - PCI Scans - Patch v1.3.8 20090628
 *
 * @package initSystem
 * @copyright Copyright 2003-2008 Zen Cart Development Team
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: pci_patch_v138_search.php 351 2009-08-21 07:25:25Z bigmouse-nfox $
 */

if (isset($_GET['keyword']) && $_GET['keyword'] != '')
{
  $count =  substr_count($_GET['keyword'], '"');
  if ($count == 1)
  {
    if(substr(stripslashes(trim($_GET['keyword'])), 0, 1) == '"')
    {
      $_GET['keyword'] .= '"';
    }
  }
  $_GET['keyword'] = stripslashes($_GET['keyword']);
}
?>
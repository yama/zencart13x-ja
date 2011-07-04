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
//  $Id: alt_nav.php 1969 2005-09-13 06:57:21Z drbyte $
//

  require('includes/application_top.php');

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" <?php echo HTML_PARAMS; ?>>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<?php echo CHARSET; ?>">
<title><?php echo TITLE; ?></title>
<script language="JavaScript" src="includes/menu.js" type="text/JavaScript"></script>
<link href="includes/<?php echo $_SESSION['select_css']; ?>stylesheet.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="includes/cssjsmenuhover.css" media="all" id="hoverJS" />
<script type="text/javascript">
  <!--
  function init()
  {
    cssjsmenu('navbar');
    if (document.getElementById)
    {
      var kill = document.getElementById('hoverJS');
      kill.disabled = true;
    }
  }
  // -->
</script>
</head>
<body onload="init()">
<!-- header //-->
<?php require(DIR_WS_INCLUDES . 'header.php'); ?>
<!-- header_eof //-->
<br /><br />
<div id="colone">
<div class="reportBox">
<div class="header">
<?php
require(DIR_WS_BOXES . 'configuration_dhtml.php');
echo $za_heading['text']; ?>
</div>
<?php
foreach ($za_contents as $value) {
	echo '<div class="row"><a href="' . $value['link'] . '">' . $value['text'] . '</a></div>';
}
?>
</div>
<div class="headerspacer"></div>
<div class="reportBox">
<div class="header">
<?php
require(DIR_WS_BOXES . 'catalog_dhtml.php');
echo $za_heading['text']; ?>
</div>
<?php
foreach ($za_contents as $value) {
	echo '<div class="row"><a href="' . $value['link'] . '">' . $value['text'] . '</a></div>';
}
?>
</div>
</div>
 <div id="coltwo">
 <div class="reportBox">
<div class="header">
<?php
require(DIR_WS_BOXES . 'modules_dhtml.php');
echo $za_heading['text']; ?>
</div>
<?php
foreach ($za_contents as $value) {
	echo '<div class="row"><a href="' . $value['link'] . '">' . $value['text'] . '</a></div>';
}
?>
 </div>
<div class="headerspacer"></div>
<div class="reportBox">
<div class="header"><?php
require(DIR_WS_BOXES . 'customers_dhtml.php');
echo $za_heading['text']; ?>
</div>
<?php
foreach ($za_contents as $value) {
	echo '<div class="row"><a href="' . $value['link'] . '">' . $value['text'] . '</a></div>';
}
?>
</div>
<div class="headerspacer"></div>
<div class="reportBox">
<div class="header"><?php
require(DIR_WS_BOXES . 'taxes_dhtml.php');
echo $za_heading['text']; ?>
</div>
<?php
foreach ($za_contents as $value) {
	echo '<div class="row"><a href="' . $value['link'] . '">' . $value['text'] . '</a></div>';
}
?>
</div>
<div class="headerspacer"></div>
<div class="reportBox">
<div class="header"><?php
require(DIR_WS_BOXES . 'localization_dhtml.php');
echo $za_heading['text']; ?>
</div>
<?php
foreach ($za_contents as $value) {
	echo '<div class="row"><a href="' . $value['link'] . '">' . $value['text'] . '</a></div>';
}
?>
 </div>
</div>
</div>
<div id="colthree">
<div class="reportBox">
<div class="header"><?php
require(DIR_WS_BOXES . 'reports_dhtml.php');
echo $za_heading['text']; ?>
</div>
<?php
foreach ($za_contents as $value) {
	echo '<div class="row"><a href="' . $value['link'] . '">' . $value['text'] . '</a></div>';
}
?>
</div>
<div class="headerspacer"></div>
<div class="reportBox">
<div class="header"><?php
require(DIR_WS_BOXES . 'tools_dhtml.php');
echo $za_heading['text']; ?>
</div>
<?php
foreach ($za_contents as $value) {
	echo '<div class="row"><a href="' . $value['link'] . '">' . $value['text'] . '</a></div>';
}
?>
</div>
<div class="headerspacer"></div>
<div class="reportBox">
<div class="header"><?php
require(DIR_WS_BOXES . 'gv_admin_dhtml.php');
echo $za_heading['text']; ?>
</div>
<?php
foreach ($za_contents as $value) {
	echo '<div class="row"><a href="' . $value['link'] . '">' . $value['text'] . '</a></div>';
}
?>
</div>
<div class="headerspacer"></div>
<div class="reportBox">
<div class="header">
<?php
require(DIR_WS_BOXES . 'extras_dhtml.php');
echo $za_heading['text']; ?>
</div>
<?php
foreach ($za_contents as $value) {
	echo '<div class="row"><a href="' . $value['link'] . '">' . $value['text'] . '</a></div>';
}
?>
 </div>
</div>
<div style="clear:both;"></div>
<?php require(DIR_WS_INCLUDES . 'footer.php'); ?>
</body>
</html>
<?php require('includes/application_bottom.php'); ?>
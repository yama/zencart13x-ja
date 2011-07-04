<?php
   require('includes/application_top.php');

  if (isset($_POST) && $_POST['action'] == 'update_shipping') {
    $result = $db->Execute("TRUNCATE TABLE " . TABLE_SPECIAL_SHIPPING );
    foreach ($_POST as $key => $value) {
    	 $$key = zen_db_prepare_input($value);
    }
    $ii = 0;
    while ($ii < count($size)) {
       $ii++;
       if ($size[$ii] != '') {
        $insert_array = array('size' => (int)mb_convert_kana($size[$ii],"n"),
                                   'area_1' => (int)mb_convert_kana($area_1[$ii],"n"),
                                   'area_2' => (int)mb_convert_kana($area_2[$ii],"n"),
                                   'area_3' => (int)mb_convert_kana($area_3[$ii],"n"),
                                   'area_4' => (int)mb_convert_kana($area_4[$ii],"n"),
                                   'area_5' => (int)mb_convert_kana($area_5[$ii],"n"),
                                   'area_6' => (int)mb_convert_kana($area_6[$ii],"n"),
                                   'area_7' => (int)mb_convert_kana($area_7[$ii],"n"),
                                   'area_8' => (int)mb_convert_kana($area_8[$ii],"n"),
                                   'area_9' => (int)mb_convert_kana($area_9[$ii],"n"),
                                   'area_10' => (int)mb_convert_kana($area_10[$ii],"n"),
                                   'area_11' => (int)mb_convert_kana($area_11[$ii],"n"),
                                   'area_12' => (int)mb_convert_kana($area_12[$ii],"n")
                                   );
          zen_db_perform(TABLE_SPECIAL_SHIPPING,$insert_array);
       }
    }
    zen_redirect(zen_href_link(FILENAME_SPECIAL_SHIPPING));
  }
?>
<!doctype html public "-//W3C//DTD HTML 4.01 Transitional//EN">
<html <?php echo HTML_PARAMS; ?>>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<?php echo CHARSET; ?>">
<title><?php echo TITLE; ?></title>
<link rel="stylesheet" type="text/css" href="includes/<?php echo $_SESSION['select_css']; ?>stylesheet.css">
<link rel="stylesheet" type="text/css" href="includes/cssjsmenuhover.css" media="all" id="hoverJS">
<script language="javascript" src="includes/menu.js"></script>
<script language="javascript" src="includes/general.js"></script>
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
if (typeof _editor_url == "string") HTMLArea.replaceAll();
 }
 // -->
</script>
</head>
<body marginwidth="0" marginheight="0" topmargin="0" bottommargin="0" leftmargin="0" rightmargin="0" bgcolor="#FFFFFF" onload="init()">
<div id="spiffycalendar" class="text"></div>
<!-- header //-->
<?php require(DIR_WS_INCLUDES . 'header.php'); ?>
<!-- header_eof //-->
<!-- body //-->
<div class="main">
<table  width="750" border="0" align="center" cellpadding="3" cellspacing="1">
    <tr>
      <td class="pageHeading" colspan="12"><?php echo SPECIALSHIPPING_HEADING_TITLE; ?></td>
      <td class="pageHeading" align="right"><?php echo zen_draw_separator('pixel_trans.gif', HEADING_IMAGE_WIDTH, HEADING_IMAGE_HEIGHT); ?></td>
    </tr>
  <tr>
    <td align="center" bgcolor="#ffff93"><?php echo SPECIALSHIPPING_SIZE; ?></td>
    <td align="center" bgcolor="#555fdd"><?php echo SPECIALSHIPPING_HOKKAIDO; ?></td>
    <td align="center" bgcolor="#555fdd"><?php echo SPECIALSHIPPING_HOKUTOKITA; ?></td>
    <td align="center" bgcolor="#555fdd"><?php echo SPECIALSHIPPING_NANTOKITA; ?></td>
    <td align="center" bgcolor="#555fdd"><?php echo SPECIALSHIPPING_KANTO; ?></td>
    <td align="center" bgcolor="#555fdd"><?php echo SPECIALSHIPPING_SHINETU; ?></td>
    <td align="center" bgcolor="#555fdd"><?php echo SPECIALSHIPPING_CHUBU; ?></td>
    <td align="center" bgcolor="#555fdd"><?php echo SPECIALSHIPPING_HOKURIKU; ?></td>
    <td align="center" bgcolor="#555fdd"><?php echo SPECIALSHIPPING_KANSAI; ?></td>
    <td align="center" bgcolor="#555fdd"><?php echo SPECIALSHIPPING_CYUGOKU; ?></td>
    <td align="center" bgcolor="#555fdd"><?php echo SPECIALSHIPPING_SHIKOKU; ?></td>
    <td align="center" bgcolor="#555fdd"><?php echo SPECIALSHIPPING_KYUSYU; ?></td>
    <td align="center" bgcolor="#555fdd"><?php echo SPECIALSHIPPING_OKINAWA; ?></td>
  </tr>
  <tr>
<td align="center" bgcolor="#fbfbce">&nbsp;</td>
<td align="center" valign="top" nowrap bgcolor="#dedeff"><?php echo SPECIALSHIPPING_HOKKAIDO; ?><br></td>
<td align="center" valign="top" nowrap bgcolor="#dedeff"><?php echo SPECIALSHIPPING_HOKUTOKITA_ARRAY; ?></td>
<td align="center" valign="top" nowrap bgcolor="#dedeff"><?php echo SPECIALSHIPPING_NANTOKITA_ARRAY; ?></td>
<td align="center" valign="top" nowrap bgcolor="#dedeff"><?php echo SPECIALSHIPPING_KANTO_ARRAY; ?></td>
<td align="center" valign="top" nowrap bgcolor="#dedeff"><?php echo SPECIALSHIPPING_SHINETU_ARRAY; ?></td>
<td align="center" valign="top" nowrap bgcolor="#dedeff"><?php echo SPECIALSHIPPING_CHUBU_ARRAY; ?></td>
<td align="center" valign="top" nowrap bgcolor="#dedeff"><?php echo SPECIALSHIPPING_HOKURIKU_ARRAY; ?></td>
<td align="center" valign="top" nowrap bgcolor="#dedeff"><?php echo SPECIALSHIPPING_KANSAI_ARRAY; ?></td>
<td align="center" valign="top" nowrap bgcolor="#dedeff"><?php echo SPECIALSHIPPING_CYUGOKU_ARRAY; ?></td>
<td align="center" valign="top" nowrap bgcolor="#dedeff"><?php echo SPECIALSHIPPING_SHIKOKU_ARRAY; ?></td>
<td align="center" valign="top" nowrap bgcolor="#dedeff"><?php echo SPECIALSHIPPING_KYUSYU_ARRAY; ?></td>
<td align="center" valign="top" nowrap bgcolor="#dedeff"><?php echo SPECIALSHIPPING_OKINAWA; ?></td>
</tr>
<?php
  echo zen_draw_form('special_shipping', FILENAME_SPECIAL_SHIPPING);
  echo zen_draw_hidden_field('action', 'update_shipping');
  $area_array = $db->Execute("select count(*) as count from " . TABLE_SPECIAL_SHIPPING . "");
  if ($area_array->fields['count'] == '0') {
    $i = 1;
    while ($i < 10) {
?>
  <tr>
    <td><?php echo zen_draw_input_field('size[' . $i . ']', '', 'size="8" maxlength="3"'); ?></td>
    <td><?php echo zen_draw_input_field('area_1[' . $i . ']', '', 'size="8" maxlength="5"'); ?></td>
    <td><?php echo zen_draw_input_field('area_2[' . $i . ']', '', 'size="8" maxlength="5"'); ?></td>
    <td><?php echo zen_draw_input_field('area_3[' . $i . ']', '', 'size="8" maxlength="5"'); ?></td>
    <td><?php echo zen_draw_input_field('area_4[' . $i . ']', '', 'size="8" maxlength="5"'); ?></td>
    <td><?php echo zen_draw_input_field('area_5[' . $i . ']', '', 'size="8" maxlength="5"'); ?></td>
    <td><?php echo zen_draw_input_field('area_6[' . $i . ']', '', 'size="8" maxlength="5"'); ?></td>
    <td><?php echo zen_draw_input_field('area_7[' . $i . ']', '', 'size="8" maxlength="5"'); ?></td>
    <td><?php echo zen_draw_input_field('area_8[' . $i . ']', '', 'size="8" maxlength="5"'); ?></td>
    <td><?php echo zen_draw_input_field('area_9[' . $i . ']', '', 'size="8" maxlength="5"'); ?></td>
    <td><?php echo zen_draw_input_field('area_10[' . $i . ']', '', 'size="8" maxlength="5"'); ?></td>
    <td><?php echo zen_draw_input_field('area_11[' . $i . ']', '', 'size="8" maxlength="5"'); ?></td>
    <td><?php echo zen_draw_input_field('area_12[' . $i . ']', '', 'size="8" maxlength="5"'); ?></td>
  </tr>
<?php
      $i++;
    }
  } else {
    $area_array = $db->Execute("select * from " . TABLE_SPECIAL_SHIPPING . "");
    $ii = 1;
    while (!$area_array->EOF) {
  ?>
    <tr>
      <td><?php echo zen_draw_input_field('size[' . $ii . ']', (int)$area_array->fields['size'], 'size="8" maxlength="3"'); ?></td>
      <td><?php echo zen_draw_input_field('area_1[' . $ii . ']', (int)$area_array->fields['area_1'], 'size="8" maxlength="5"'); ?></td>
      <td><?php echo zen_draw_input_field('area_2[' . $ii . ']', (int)$area_array->fields['area_2'], 'size="8" maxlength="5"'); ?></td>
      <td><?php echo zen_draw_input_field('area_3[' . $ii . ']', (int)$area_array->fields['area_3'], 'size="8" maxlength="5"'); ?></td>
      <td><?php echo zen_draw_input_field('area_4[' . $ii . ']', (int)$area_array->fields['area_4'], 'size="8" maxlength="5"'); ?></td>
      <td><?php echo zen_draw_input_field('area_5[' . $ii . ']', (int)$area_array->fields['area_5'], 'size="8" maxlength="5"'); ?></td>
      <td><?php echo zen_draw_input_field('area_6[' . $ii . ']', (int)$area_array->fields['area_6'], 'size="8" maxlength="5"'); ?></td>
      <td><?php echo zen_draw_input_field('area_7[' . $ii . ']', (int)$area_array->fields['area_7'], 'size="8" maxlength="5"'); ?></td>
      <td><?php echo zen_draw_input_field('area_8[' . $ii . ']', (int)$area_array->fields['area_8'], 'size="8" maxlength="5"'); ?></td>
      <td><?php echo zen_draw_input_field('area_9[' . $ii . ']', (int)$area_array->fields['area_9'], 'size="8" maxlength="5"'); ?></td>
      <td><?php echo zen_draw_input_field('area_10[' . $ii . ']', (int)$area_array->fields['area_10'], 'size="8" maxlength="5"'); ?></td>
      <td><?php echo zen_draw_input_field('area_11[' . $ii . ']', (int)$area_array->fields['area_11'], 'size="8" maxlength="5"'); ?></td>
      <td><?php echo zen_draw_input_field('area_12[' . $ii . ']', (int)$area_array->fields['area_12'], 'size="8" maxlength="5"'); ?></td>
    </tr>
  <?php
      $ii++;
      $area_array->MoveNext();
    }
    while ($ii < 10) {
?>
  <tr>
    <td><?php echo zen_draw_input_field('size[' . $ii . ']', '', 'size="8" maxlength="3"'); ?></td>
    <td><?php echo zen_draw_input_field('area_1[' . $ii . ']', '', 'size="8" maxlength="5"'); ?></td>
    <td><?php echo zen_draw_input_field('area_2[' . $ii . ']', '', 'size="8" maxlength="5"'); ?></td>
    <td><?php echo zen_draw_input_field('area_3[' . $ii . ']', '', 'size="8" maxlength="5"'); ?></td>
    <td><?php echo zen_draw_input_field('area_4[' . $ii . ']', '', 'size="8" maxlength="5"'); ?></td>
    <td><?php echo zen_draw_input_field('area_5[' . $ii . ']', '', 'size="8" maxlength="5"'); ?></td>
    <td><?php echo zen_draw_input_field('area_6[' . $ii . ']', '', 'size="8" maxlength="5"'); ?></td>
    <td><?php echo zen_draw_input_field('area_7[' . $ii . ']', '', 'size="8" maxlength="5"'); ?></td>
    <td><?php echo zen_draw_input_field('area_8[' . $ii . ']', '', 'size="8" maxlength="5"'); ?></td>
    <td><?php echo zen_draw_input_field('area_9[' . $ii . ']', '', 'size="8" maxlength="5"'); ?></td>
    <td><?php echo zen_draw_input_field('area_10[' . $ii . ']', '', 'size="8" maxlength="5"'); ?></td>
    <td><?php echo zen_draw_input_field('area_11[' . $ii . ']', '', 'size="8" maxlength="5"'); ?></td>
    <td><?php echo zen_draw_input_field('area_12[' . $ii . ']', '', 'size="8" maxlength="5"'); ?></td>
  </tr>
<?php
      $ii++;
    }
  }
?>
  <tr>
    <td colspan="13" align="right"><input type="submit" value="<?php echo SPECIALSHIPPING_SUBMIT; ?>"></form></td>
  </tr>
  <tr>
    <td colspan="13"><?php echo SPECIALSHIPPING_ATTENTION; ?></td>
  </tr>



</table>
</div>
</body>
</html>
<?php
  require(DIR_WS_INCLUDES . 'application_bottom.php');
?>

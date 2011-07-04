<?php
  function zen_image_resize($src_image, $dst_image, $dst_width, $dst_height, $keep_ratio = true) {

    list($src_width, $src_height, $src_type) = getimagesize($src_image);
    preg_match("/.*\/(.*)\.(\w*)$/", $dst_image, $file_name);
    switch ($file_name[2]) {
      case 'gif':
      case 'GIF':
        $dst_type = 1;
        break;

      case 'jpg':
      case 'jpeg';
      case 'JPG':
      case 'JPEG';
      $dst_type = 2;
      break;

      case 'png':
      case 'PNG':
        $dst_type = 3;
        break;

      default:
        die("Can not support image file:" .  $src_image);
        break;
    }

    if ($keep_ratio) {
      $k = max($src_height / $dst_height, $src_width / $dst_width);
      $dst_width = @round($src_width / $k);
      $dst_height = @round($src_height / $k);
    }

    if ($dst_type == '') {
      $dst_type = $src_type;
    }

    switch ($src_type) {
      case 1: //gif
        $tmp_src_image = imagecreatefromgif($src_image);
        break;

      case 2: //jpg
        $tmp_src_image = imagecreatefromjpeg($src_image);
        break;

      case 3: //png
        $tmp_src_image = imagecreatefrompng($src_image);
        break;

      default:
        die("Can not support image file:" .  $src_image);
        break;
    }

    switch ($dst_type) {
      case 1: //gif
        $tmp_dst_image = imagecreate($dst_width, $dst_height);
        imagecopyresized($tmp_dst_image, $tmp_src_image, 0, 0, 0, 0, $dst_width, $dst_height, $src_width, $src_height) or die();
        imagegif($tmp_dst_image,$dst_image);
        break;

      case 2: //jpg
        $tmp_dst_image = imagecreatetruecolor($dst_width, $dst_height);
        imagecopyresampled($tmp_dst_image, $tmp_src_image, 0, 0, 0, 0, $dst_width, $dst_height, $src_width, $src_height) or die();
        imagejpeg($tmp_dst_image,$dst_image);
        break;

      case 3: //png
        $tmp_dst_image = imagecreatetruecolor($dst_width, $dst_height);
        imagecopyresampled($tmp_dst_image, $tmp_src_image, 0, 0, 0, 0, $dst_width, $dst_height, $src_width, $src_height) or die();
        imagepng($tmp_dst_image,$dst_image);
        break;

      default:
        die("Can not support image file:" .  $src_image);
        break;
    }
    imagedestroy($tmp_src_image);
    imagedestroy($tmp_dst_image);
  }

?>
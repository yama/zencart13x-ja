<?php
/**
 * @package admin
 * @copyright Copyright 2003-2006 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: new_product_preview.php 3009 2006-02-11 15:41:10Z wilt $
 */
if (!defined('IS_ADMIN_FLAG')) {
  die('Illegal Access');
}
// copy image only if modified
      if (IMAGE_MANAGER_CONFIG != 'true')  {
        if (!isset($_GET['read']) || $_GET['read'] == 'only') {
          $products_image = new upload('products_image');
          $products_image->set_destination(DIR_FS_CATALOG_IMAGES . $_POST['img_dir']);
          if ($products_image->parse() && $products_image->save($_POST['overwrite'])) {
            $products_image_name = $_POST['img_dir'] . $products_image->filename;
          } else {
            $products_image_name = (isset($_POST['products_previous_image']) ? $_POST['products_previous_image'] : '');
          }
        }
      } else {
        if (isset($_SESSION['new_image'])) {
          if ($_SESSION['new_image'] != 'temporary_images/' . $_POST['products_previous_image']) {
           unset($_SESSION['new_image']);
          }
         }
         if (!isset($_GET['read']) || $_GET['read'] == 'only') {
          $img1tmp = $_FILES['products_image']['tmp_name'];
          $img1name = $_FILES['products_image']['name'];

          if (!file_exists(DIR_FS_CATALOG_IMAGES . 'temporary_images/')) {
            mkdir(DIR_FS_CATALOG_IMAGES . 'temporary_images/', 0777);
            @copy(DIR_FS_SQL_CACHE . '/.htaccess', DIR_FS_CATALOG_IMAGES . 'temporary_images/.htaccess');
          }
          if ($img1tmp != '' && $_POST['overwrite'] == '1') {
            $image_dir = DIR_FS_CATALOG_IMAGES . $_POST['img_dir'];
              if (!file_exists(DIR_FS_CATALOG_IMAGES . 'temporary_images/' . $_POST['img_dir'])) {
                mkdir(DIR_FS_CATALOG_IMAGES . 'temporary_images/' . $_POST['img_dir'], 0777);
              }
                $products_image = new upload('products_image');
                $products_image->set_destination(DIR_FS_CATALOG_IMAGES . 'temporary_images/' . $_POST['img_dir']);
                if ($products_image->parse() && $products_image->save($_POST['overwrite'])) {
                  $products_image_name = 'temporary_images/' . $_POST['img_dir'] . $products_image->filename;
                } else {
                  $products_image_name = (isset($_POST['products_previous_image']) ? $_POST['products_previous_image'] : '');
                }
              //copy($img1tmp, DIR_FS_CATALOG_IMAGES . 'temporary_images/' . $_POST['img_dir'] . $img1name);
              //chmod(DIR_FS_CATALOG_IMAGES . 'temporary_images/' . $_POST['img_dir'] . $img1name, 0777);
              $products_image_name = $_POST['img_dir'] . $img1name;
              $_SESSION['new_image'] = 'temporary_images/' . $_POST['img_dir'] . $img1name;
              $_SESSION['post_img_dir'] = $_POST['img_dir'];
            } else {
              $products_image_name = (isset($_POST['products_previous_image']) ? $_POST['products_previous_image'] : '');
            }
         }
      }
?>
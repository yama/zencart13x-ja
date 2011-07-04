<?php
/**
 * @package admin
 * @copyright Copyright 2003-2006 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: update_product.php 5974 2007-03-04 01:17:35Z ajeh $
 */
  if (!defined('IS_ADMIN_FLAG')) {
    die('Illegal Access');
  }
  if (isset($_POST['edit_x']) || isset($_POST['edit_y'])) {
    $action = 'new_product';
  } else {
    if (isset($_GET['pID'])) $products_id = zen_db_prepare_input($_GET['pID']);
    $products_date_available = zen_db_prepare_input($_POST['products_date_available']);

    $products_date_available = (date('Y-m-d') < $products_date_available) ? $products_date_available : 'null';

    // Data-cleaning to prevent MySQL5 data-type mismatch errors:
    $tmp_value = zen_db_prepare_input($_POST['products_quantity']);
    $products_quantity = (!zen_not_null($tmp_value) || $tmp_value=='' || $tmp_value == 0) ? 0 : $tmp_value;
    $tmp_value = zen_db_prepare_input($_POST['products_price']);
    $products_price = (!zen_not_null($tmp_value) || $tmp_value=='' || $tmp_value == 0) ? 0 : $tmp_value;
    $tmp_value = zen_db_prepare_input($_POST['products_weight']);
    $products_weight = (!zen_not_null($tmp_value) || $tmp_value=='' || $tmp_value == 0) ? 0 : $tmp_value;
    $tmp_value = zen_db_prepare_input($_POST['manufacturers_id']);
    $manufacturers_id = (!zen_not_null($tmp_value) || $tmp_value=='' || $tmp_value == 0) ? 0 : $tmp_value;

    $sql_data_array = array('products_quantity' => $products_quantity,
                            'products_type' => zen_db_prepare_input($_GET['product_type']),
                            'products_model' => zen_db_prepare_input($_POST['products_model']),
                            'products_price' => $products_price,
                            'products_date_available' => $products_date_available,
                            'products_weight' => $products_weight,
                            'products_status' => zen_db_prepare_input($_POST['products_status']),
                            'products_virtual' => zen_db_prepare_input($_POST['products_virtual']),
                            'products_tax_class_id' => zen_db_prepare_input($_POST['products_tax_class_id']),
                            'manufacturers_id' => $manufacturers_id,
                            'products_quantity_order_min' => zen_db_prepare_input($_POST['products_quantity_order_min']),
                            'products_quantity_order_units' => zen_db_prepare_input($_POST['products_quantity_order_units']),
                            'products_priced_by_attribute' => zen_db_prepare_input($_POST['products_priced_by_attribute']),
                            'product_is_free' => zen_db_prepare_input($_POST['product_is_free']),
                            'product_is_call' => zen_db_prepare_input($_POST['product_is_call']),
                            'products_quantity_mixed' => zen_db_prepare_input($_POST['products_quantity_mixed']),
                            'product_is_always_free_shipping' => zen_db_prepare_input($_POST['product_is_always_free_shipping']),
                            'products_qty_box_status' => zen_db_prepare_input($_POST['products_qty_box_status']),
                            'products_quantity_order_max' => zen_db_prepare_input($_POST['products_quantity_order_max']),
                            'products_sort_order' => (int)zen_db_prepare_input($_POST['products_sort_order']),
                            'products_discount_type' => zen_db_prepare_input($_POST['products_discount_type']),
                            'products_discount_type_from' => zen_db_prepare_input($_POST['products_discount_type_from']),
                            'products_price_sorter' => zen_db_prepare_input($_POST['products_price_sorter'])
                            );

    // when set to none remove from database
    // if (isset($_POST['products_image']) && zen_not_null($_POST['products_image']) && ($_POST['products_image'] != 'none')) {
    if (isset($_POST['products_image'])
            && zen_not_null($_POST['products_image'])
            && ($_POST['products_image'] != 'none')
            && ($_POST['products_image'] != $_POST['products_previous_image'])) {
      $sql_data_array['products_image'] = zen_db_prepare_input($_POST['products_image']);
      $new_image= 'true';
    } else {
      $sql_data_array['products_image'] = $_POST['products_previous_image'];
      $new_image= 'false';
    }

if ($_POST['image_delete'] == 1) {
      $sql_data_array['products_image'] = '';
      $new_image= 'false';
}

    if ($action == 'insert_product') {
      $insert_sql_data = array( 'products_date_added' => 'now()',
                                'master_categories_id' => (int)$current_category_id);

      $sql_data_array = array_merge($sql_data_array, $insert_sql_data);

      zen_db_perform(TABLE_PRODUCTS, $sql_data_array);
      $products_id = zen_db_insert_id();

      // reset products_price_sorter for searches etc.
      zen_update_products_price_sorter($products_id);

      $db->Execute("insert into " . TABLE_PRODUCTS_TO_CATEGORIES . "
                    (products_id, categories_id)
                    values ('" . (int)$products_id . "', '" . (int)$current_category_id . "')");

      ///////////////////////////////////////////////////////
      //// INSERT PRODUCT-TYPE-SPECIFIC *INSERTS* HERE //////


      ////    *END OF PRODUCT-TYPE-SPECIFIC INSERTS* ////////
      ///////////////////////////////////////////////////////
    } elseif ($action == 'update_product') {
      $update_sql_data = array( 'products_last_modified' => 'now()',
                                'master_categories_id' => ($_POST['master_category'] > 0 ? zen_db_prepare_input($_POST['master_category']) : zen_db_prepare_input($_POST['master_categories_id'])));

      $sql_data_array = array_merge($sql_data_array, $update_sql_data);

      zen_db_perform(TABLE_PRODUCTS, $sql_data_array, 'update', "products_id = '" . (int)$products_id . "'");

      // reset products_price_sorter for searches etc.
      zen_update_products_price_sorter((int)$products_id);

      ///////////////////////////////////////////////////////
      //// INSERT PRODUCT-TYPE-SPECIFIC *UPDATES* HERE //////


      ////    *END OF PRODUCT-TYPE-SPECIFIC UPDATES* ////////
      ///////////////////////////////////////////////////////
    }

    $languages = zen_get_languages();
    for ($i=0, $n=sizeof($languages); $i<$n; $i++) {
      $language_id = $languages[$i]['id'];

      $sql_data_array = array('products_name' => zen_db_prepare_input(mb_strimwidth($_POST['products_name'][$language_id], 0, zen_field_length(TABLE_PRODUCTS_DESCRIPTION, 'products_name'))),
                              'products_description' => zen_db_prepare_input($_POST['products_description'][$language_id]),
                              'products_url' => zen_db_prepare_input($_POST['products_url'][$language_id]));

      if ($action == 'insert_product') {
        $insert_sql_data = array('products_id' => $products_id,
                                 'language_id' => $language_id);

        $sql_data_array = array_merge($sql_data_array, $insert_sql_data);

        zen_db_perform(TABLE_PRODUCTS_DESCRIPTION, $sql_data_array);
      } elseif ($action == 'update_product') {
        zen_db_perform(TABLE_PRODUCTS_DESCRIPTION, $sql_data_array, 'update', "products_id = '" . (int)$products_id . "' and language_id = '" . (int)$language_id . "'");
      }
    }

    // add meta tags
    $languages = zen_get_languages();
    for ($i=0, $n=sizeof($languages); $i<$n; $i++) {
      $language_id = $languages[$i]['id'];

      $sql_data_array = array('metatags_title' => zen_db_prepare_input($_POST['metatags_title'][$language_id]),
                              'metatags_keywords' => zen_db_prepare_input($_POST['metatags_keywords'][$language_id]),
                              'metatags_description' => zen_db_prepare_input($_POST['metatags_description'][$language_id]));

      if ($action == 'insert_product_meta_tags') {

        $insert_sql_data = array('products_id' => $products_id,
                                 'language_id' => $language_id);

        $sql_data_array = array_merge($sql_data_array, $insert_sql_data);

        zen_db_perform(TABLE_META_TAGS_PRODUCTS_DESCRIPTION, $sql_data_array);
      } elseif ($action == 'update_product_meta_tags') {
        zen_db_perform(TABLE_META_TAGS_PRODUCTS_DESCRIPTION, $sql_data_array, 'update', "products_id = '" . (int)$products_id . "' and language_id = '" . (int)$language_id . "'");
      }
    }


    // future image handler code
    define('IMAGE_MANAGER_HANDLER', 0);
    define('DIR_IMAGEMAGICK', '');
    if (isset($_SESSION['new_image']) ) {
//      $src=  DIR_WS_IMAGES_FULL_PATH . zen_get_products_image((int)$products_id);
      $src = DIR_FS_CATALOG . DIR_WS_IMAGES . $_SESSION['new_image'];

      if (IMAGE_MANAGER_CONFIG == 'true')  {
        preg_match("/.*\/(.*)\.(\w*)$/", $src, $fname);
        list($oiwidth, $oiheight, $oitype) = getimagesize($src);

        $small_width= SMALL_IMAGE_WIDTH;
        $small_height= SMALL_IMAGE_HEIGHT;
        $medium_width= MEDIUM_IMAGE_WIDTH;
        $medium_height= MEDIUM_IMAGE_HEIGHT;
        $large_width= LARGE_IMAGE_WIDTH;
        $large_height= LARGE_IMAGE_HEIGHT;

        $k = @max($oiheight / $small_height, $oiwidth / $small_width); //use smallest size
        $small_width = @round($oiwidth / $k);
        $small_height = @round($oiheight / $k);

        $k = @max($oiheight / $medium_height, $oiwidth / $medium_width); //use smallest size
        $medium_width = @round($oiwidth / $k);
        $medium_height = @round($oiheight / $k);

        $large_width= $oiwidth;
        $large_height= $oiheight;

        $products_image = zen_get_products_image((int)$products_id);
        $products_image_extension = substr($products_image, strrpos($products_image, '.'));
        $products_image_base = ereg_replace($products_image_extension, '', $products_image);

        //dir check
        if (isset($_SESSION['post_img_dir']) && $_SESSION['post_img_dir'] != '') {
          if (!file_exists(DIR_FS_CATALOG . DIR_WS_IMAGES . 'large/' . $_SESSION['post_img_dir'])) {
            mkdir(DIR_FS_CATALOG . DIR_WS_IMAGES . 'large/' . $_SESSION['post_img_dir'], 0777);
            chmod(DIR_FS_CATALOG . DIR_WS_IMAGES . 'large/' . $_SESSION['post_img_dir'], 0777);
          }
          if (!file_exists(DIR_FS_CATALOG . DIR_WS_IMAGES . 'medium/' . $_SESSION['post_img_dir'])) {
            mkdir(DIR_FS_CATALOG . DIR_WS_IMAGES . 'medium/' . $_SESSION['post_img_dir'], 0777);
            chmod(DIR_FS_CATALOG . DIR_WS_IMAGES . 'medium/' . $_SESSION['post_img_dir'], 0777);
          }
          unset($_SESSION['post_img_dir']);
        }
        $filename_medium .= DIR_FS_CATALOG . DIR_WS_IMAGES . 'medium/' . $products_image_base . IMAGE_SUFFIX_MEDIUM . '.' . $fname[2];
        $filename_large = DIR_FS_CATALOG . DIR_WS_IMAGES . 'large/' . $products_image_base . IMAGE_SUFFIX_LARGE . '.' . $fname[2];
        $filename_small = DIR_FS_CATALOG . DIR_WS_IMAGES . $products_image_base . '.' . $fname[2];
        copy($src, $filename_large);
        chmod($filename_large, 0777);
        zen_image_resize($src, $filename_medium, $medium_width, $medium_height);
        chmod($filename_medium, 0777);
        zen_image_resize($src, $filename_small, $small_width, $small_height);
        chmod($filename_small, 0777);
      } else {
        $products_image = DIR_FS_CATALOG . DIR_WS_IMAGES . zen_get_products_image((int)$products_id);
        copy($src, $products_image);
        chmod($products_image, 0777);
      }
    unset($_SESSION['new_image']);
//    unlink($src);
    }

    zen_redirect(zen_href_link(FILENAME_CATEGORIES, 'cPath=' . $cPath . '&pID=' . $products_id . (isset($_GET['page']) ? '&page=' . $_GET['page'] : '')));
  }
?>
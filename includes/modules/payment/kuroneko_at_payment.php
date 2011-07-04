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
// $Id: kuroneko_at_payment.php 377 2009-10-23 09:50:34Z bigmouse-nfox $
//
// 支払いモジュール クロネコ＠ペイメント
//
// 作者
// 有限会社ビッグマウス　佐々木　剛治
// sasaki@bigmouse.jp
// http://www.bigmouse.jp
//
//
// 更新履歴
// 2005/03/21
// ・最低適用金額を設定できるようにしました。
//
//
// パッケージの内容 ----------------------------------------------------
//
// ・クロネコ@ペイメントモジュールクラスファイル
// includes/modules/payment/kuroneko_at_payment.php
//
// ・クロネコ@ペイメントモジュール言語ファイル（japanese）
// includes/languages/japanese/modules/payment/kuroneko_at_payment.php
//
// ・クロネコ@ペイメントリンクボタン画像ファイル（japanese）
// includes/templates/template_default/buttons/japanese/button_kuroneko_at_payment.gif
//
// ・tpl_checkout_success_default.phpテンプレートファイル修正例
// includes/templates/template_default/templates/tpl_checkout_success_default.php
// 　(B23行目に < ?php if (isset($_SESSION['kuroneko_at_payment'])) echo $_SESSION['kuroneko_at_payment']['box']; ? >　を挿入
//
// ----------------------------------------------------------------------
//
//
// 注文確認後、$_SESSION['kuroneko_at_payment']　にリンクボタンのHTMLソースが
// 配列で代入されます。
//
// 配列の内容
// $_SESSION['kuroneko_at_payment']['link_button'] 　リンクボタンのみのhtmlソース
// $_SESSION['kuroneko_at_payment']['text_urge']　決済手続きへ促す文章のhtmlソース
// $_SESSION['kuroneko_at_payment']['box']　上記２つを含むplainBoxのhtmlソース
//
// includes/templates/template_default/templates/tpl_checkout_success_default.php　内で
// 必要なソースをechoする
//
// 例）クロネコ＠ペイメント決済へのボックスの表示
// < ?php if (isset($_SESSION['kuroneko_at_payment'])) echo $_SESSION['kuroneko_at_payment']['box'];  ? >
//
// ----------------------------------------------------------------------
//
//
//
// モジュール設定 -------------------------------------------------------
//
// ・クロネコ＠ペイメントモジュールを有効にする
// 　　True　・・・ 有効
// 　　False ・・・ 無効
// 　　デフォルト値　True
//
// ・本番ページへの切替え
// 　　True　・・・ 本当の決済ページへつながります。
// 　　False ・・・ 動作テスト用のページにつながります。
// 　　$,1s;(B 本番稼動の前に動作テスト用のページで十分テストしてください。
// 　　デフォルト値　False
//
// ・加盟店コード
// 　　加盟店コードを半角数字で入力します。
// 　　デフォルト値　空欄
//
// ・最低金額
// 　　クロネコ＠ペイメントを適用する最低金額を入力します。
// 　　内税外税の計算に関係なくカートの小計が入力した金額以上で
// 　　表示されます。
// 　　デフォルト値　0
//
// ・送信先URL
// 　　リンクボタン（フォーム）の送信先のURLを入力します。
// 　　デフォルト値　https://payment.kuronekoyamato.co.jp/kuroneko/servlet/YCS_ServletC
//
// ・クロネコ＠ペイメントリンクバナー
// 　　お支払い方法選択ページでクロネコ＠ペイメントの説明ページへのリンクバナーのソースを
// 　　入力してください。リンクバナーのソースはクロネコ＠ペイメントのWEBサイトから入手
// 　　出来ます。
// 　　デフォルト値　<a href="http://payment.kuronekoyamato.co.jp/help/hanbai/card.html" target="_blank"><img src=http://payment.kuronekoyamato.co.jp/help/images/payment04.gif width="50" height="50" border="0" alt="クロネコ＠ペイメント"></a>
//
// ・適用地域
// 　　日本以外の地域が選択可能になっていますが必ず日本を選択してください。
// 　　デフォルト値　日本
//
// ・初期注文ステータス
// 　　注文確認完了後の注文ステータスを選択してください。
// 　　デフォルト値　デフォルト
//
// ・表示の整列順
// 　　お支払い方法選択ページでの表示の整列順を設定できます。数字が小さいほど上位に表示されます。
// 　　デフォルト値　0
//
// ----------------------------------------------------------------------
//
// [参照]
// http://www.zen-cart.jp/bbs/7/tree.php?all=126
// http://www.zen-cart.jp/bbs/7/tree.php?all=166
// http://www.zen-cart.jp/bbs/7/tree.php?all=230

  class kuroneko_at_payment {
    var $code, $title, $description, $enabled;

// class constructor
    function kuroneko_at_payment() {
      global $order;
      if (isset($_SESSION['kuroneko_at_payment'])) {
        unset($_SESSION['kuroneko_at_payment']);
      }
      $this->code = 'kuroneko_at_payment';
      $this->title = MODULE_PAYMENT_KURONEKO_AT_PAYMENT_TEXT_TITLE;
      $this->description = MODULE_PAYMENT_KURONEKO_AT_PAYMENT_TEXT_DESCRIPTION;
      $this->sort_order = MODULE_PAYMENT_KURONEKO_AT_PAYMENT_SORT_ORDER;
      $this->enabled = ((MODULE_PAYMENT_KURONEKO_AT_PAYMENT_STATUS == 'True') ? true : false);

      if ((int)MODULE_PAYMENT_KURONEKO_AT_PAYMENT_ORDER_STATUS_ID > 0) {
        $this->order_status = MODULE_PAYMENT_KURONEKO_AT_PAYMENT_ORDER_STATUS_ID;
      }

      if (is_object($order)) $this->update_status();

    }

// class methods
    function update_status() {
      global $order, $db;

    if ( ($this->enabled == true) && ((int)MODULE_PAYMENT_KURONEKO_AT_PAYMENT_ZONE > 0) ) {
      $check_flag = false;
      $check = $db->Execute("select zone_id from " . TABLE_ZONES_TO_GEO_ZONES . " where geo_zone_id = '" . MODULE_PAYMENT_KURONEKO_AT_PAYMENT_ZONE . "' and zone_country_id = '" . $order->billing['country']['id'] . "' order by zone_id");
      while (!$check->EOF) {
        if ($check->fields['zone_id'] < 1) {
          $check_flag = true;
          break;
        } elseif ($check->fields['zone_id'] == $order->billing['zone_id']) {
          $check_flag = true;
          break;
        }
        $check->MoveNext();
      }

      if ($check_flag == false) {
        $this->enabled = false;
      }
    }

    if ($this->enabled == true) {
        $total_price = $order->info['total'];
        if ($total_price < MODULE_PAYMENT_KURONEKO_AT_PAYMENT_MINIMUM_TOTAL_PRICE) {
          //$check_flag = false;
          $this->enabled = false;
        }
    }

// disable the module if the order only contains virtual products
      if ($this->enabled == true) {
        if ($order->content_type != 'physical') {
          $this->enabled = false;
        }
      }
    }

    function javascript_validation() {
      return false;
    }

    function selection() {
      return array('id' => $this->code,
                   'module' => $this->title,
                   'fields' => array(array('title' => MODULE_PAYMENT_KURONEKO_AT_PAYMENT_TEXT_ABOUT,
                                                      'field' => MODULE_PAYMENT_KURONEKO_AT_PAYMENT_LINK_BANNER)));
    }

    function pre_confirmation_check() {
      return false;
    }

    function confirmation() {
      return array('title' => MODULE_PAYMENT_KURONEKO_AT_PAYMENT_TEXT_CONFIRMATION);
    }

    function process_button() {
      return false;
    }

    function before_process() {
      return false;
    }

    function after_process() {
      global $db;
      $orders_query = "select orders_id, billing_name, order_total, billing_telephone, customers_email_address from " . TABLE_ORDERS . "
                       where customers_id = '" . (int)$_SESSION['customer_id'] . "'
                       order by date_purchased desc limit 1";

      $orders = $db->Execute($orders_query);

      $products_array = array();

      $products_query = "select products_id, products_name, products_quantity from " . TABLE_ORDERS_PRODUCTS . "
                         where orders_id = '" . (int)$orders->fields['orders_id'] . "'
                         order by products_name";

      $products = $db->Execute($products_query);
      $leading_product_name = sprintf(MODULE_PAYMENT_KURONEKO_AT_PAYMENT_LEADING_PRODUCT, $products->fields['products_name'], (int)$products->fields['products_quantity']);
      $products_count = $products->RecordCount();
      $total_products_quantity = 0;
      $products->MoveNext();
      while (!$products->EOF) {
        $other_products_quantity = $other_products_quantity + (int)$products->fields['products_quantity'];
        $products->MoveNext();
      }

      $action = HTTP_SERVER .DIR_WS_CATALOG .'kuroneko_jumper.php';
      if (MODULE_PAYMENT_KURONEKO_AT_PAYMENT_NO_TEST == 'True') {
        $trs_map = 'V_W02';
      } else {
        $trs_map = 'L_TEST';
      }
      $trader_code = MODULE_PAYMENT_KURONEKO_AT_PAYMENT_TRADER_CODE;
      $order_no = (int)$orders->fields['orders_id'];
      $goods_name = $leading_product_name;
      if ($other_products_quantity > 0) {
       $goods_name .= sprintf(MODULE_PAYMENT_KURONEKO_AT_PAYMENT_OTHER_PRODUCTS, $other_products_quantity);
      }
      $settle_price = (int)$orders->fields['order_total'];
      $buyer_name_kanji = $orders->fields['billing_name'];
      $buyer_tel = $orders->fields['billing_telephone'];
      $buyer_email = $orders->fields['customers_email_address'];
      $button_image = MODULE_PAYMENT_KURONEKO_AT_PAYMENT_BUTTON_IMAGE;
      $button_alt = MODULE_PAYMENT_KURONEKO_AT_PAYMENT_BUTTON_ALT;

      $link_button .= zen_draw_form('UserForm', $action, 'post', 'target="_blank"' ,'onsubmit="this.onsubmit=function(){return false}"') . "\n";
      $link_button .= zen_draw_hidden_field('TRS_MAP', $trs_map) . "\n";
      $link_button .= zen_draw_hidden_field('trader_code', $trader_code) . "\n";
      $link_button .= zen_draw_hidden_field('order_no', $order_no) . "\n";
      $link_button .= zen_draw_hidden_field('goods_name', $goods_name) . "\n";
      $link_button .= zen_draw_hidden_field('settle_price', $settle_price) . "\n";
      $link_button .= zen_draw_hidden_field('buyer_name_kanji', $buyer_name_kanji) . "\n";
      $link_button .= zen_draw_hidden_field('buyer_tel', $buyer_tel) . "\n";
      $link_button .= zen_draw_hidden_field('buyer_email', $buyer_email) . "\n";
      $link_button .= zen_image_submit($button_image, $button_alt) . "\n";
      $link_button .= "</form>\n";

      $text_urge = MODULE_PAYMENT_KURONEKO_AT_PAYMENT_TEXT_URGE;

      $box = "<table  width=\"100%\" border=\"0\" cellspacing=\"2\" cellpadding=\"2\">\n";
      $box .= "  <tr>\n";
      $box .= "    <td class=\"plainBox\" align=\"center\">" . MODULE_PAYMENT_KURONEKO_AT_PAYMENT_TEXT_URGE . "<br />\n";
      $box .= $link_button;
      $box .= "    </td>\n";
      $box .= "  </tr>\n";
      $box .= "</table>\n";

      $kuroneko_at_payment = array('link_button' => $link_button,'text_urge' => $text_urge,'box' => $box);
      $_SESSION['kuroneko_at_payment'] = $kuroneko_at_payment;
    }

    function get_error() {
      return false;
    }

    function check() {
      global $db;
      if (!isset($this->_check)) {
        $check_query = $db->Execute("select configuration_value from " . TABLE_CONFIGURATION . " where configuration_key = 'MODULE_PAYMENT_KURONEKO_AT_PAYMENT_STATUS'");
        $this->_check = $check_query->RecordCount();
      }
      return $this->_check;
    }

    function install() {
      global $db;
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('クロネコ＠ペイメントモジュールを有効にする', 'MODULE_PAYMENT_KURONEKO_AT_PAYMENT_STATUS', 'True', 'クロネコ＠ペイメントを受け付けますか？', '6', '1', 'zen_cfg_select_option(array(\'True\', \'False\'), ', now())");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) values ('本番ページへの切替え', 'MODULE_PAYMENT_KURONEKO_AT_PAYMENT_NO_TEST', 'False', '本番ページへ切り替えますか？<br />本番ページへ切り替えは、十分にテストをしてから行ってください。', '6', '2', 'zen_cfg_select_option(array(\'True\', \'False\'), ', now())");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('加盟店コード', 'MODULE_PAYMENT_KURONEKO_AT_PAYMENT_TRADER_CODE', '', '加盟店コード', '6', '3', now())");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('最低金額', 'MODULE_PAYMENT_KURONEKO_AT_PAYMENT_MINIMUM_TOTAL_PRICE', '0', 'クロネコ＠ペイメントを適用する最低金額を入力してください。', '6', '4', now())");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('送信先URL', 'MODULE_PAYMENT_KURONEKO_AT_PAYMENT_ACTION_URL', 'https://payment.kuronekoyamato.co.jp/kuroneko/servlet/YCS_ServletC', 'リンクボタンの送信先のURLを指定します。', '6', '5', now())");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('クロネコ＠ペイメントリンクバナー', 'MODULE_PAYMENT_KURONEKO_AT_PAYMENT_LINK_BANNER', '<a href=\"https://payment.kuronekoyamato.co.jp/help/hanbai/card.html\" target=\"_blank\"><img src=https://payment.kuronekoyamato.co.jp/help/images/payment04.gif width=\"50\" height=\"50\" border=\"0\" alt=\"クロネコ＠ペイメント\"></a>', 'クロネコ＠ペイメントリンクバーナーのHTMLソースを入力してください。', '6', '6', now())");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) values ('適用地域', 'MODULE_PAYMENT_KURONEKO_AT_PAYMENT_ZONE', '2', '必ず日本を選択してください。<br />クロネコ＠ペイメントは日本国外では利用できません。', '6', '7', 'zen_get_zone_class_title', 'zen_cfg_pull_down_zone_classes(', now())");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) values ('表示の整列順', 'MODULE_PAYMENT_KURONEKO_AT_PAYMENT_SORT_ORDER', '0', '表示の整列順を設定できます。数字が小さいほど上位に表示されます。', '6', '8', now())");
      $db->Execute("insert into " . TABLE_CONFIGURATION . " (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, use_function, date_added) values ('初期注文ステータス', 'MODULE_PAYMENT_KURONEKO_AT_PAYMENT_ORDER_STATUS_ID', '0', '設定したステータスが受注時に適用されます。', '6', '9', 'zen_cfg_pull_down_order_statuses(', 'zen_get_order_status_name', now())");
   }

    function remove() {
      global $db;
      $db->Execute("delete from " . TABLE_CONFIGURATION . " where configuration_key in ('" . implode("', '", $this->keys()) . "')");
    }

    function keys() {
      return array('MODULE_PAYMENT_KURONEKO_AT_PAYMENT_STATUS', 'MODULE_PAYMENT_KURONEKO_AT_PAYMENT_NO_TEST', 'MODULE_PAYMENT_KURONEKO_AT_PAYMENT_TRADER_CODE', 'MODULE_PAYMENT_KURONEKO_AT_PAYMENT_MINIMUM_TOTAL_PRICE', 'MODULE_PAYMENT_KURONEKO_AT_PAYMENT_ACTION_URL', 'MODULE_PAYMENT_KURONEKO_AT_PAYMENT_LINK_BANNER', 'MODULE_PAYMENT_KURONEKO_AT_PAYMENT_ZONE', 'MODULE_PAYMENT_KURONEKO_AT_PAYMENT_ORDER_STATUS_ID', 'MODULE_PAYMENT_KURONEKO_AT_PAYMENT_SORT_ORDER');
    }
  }

?>

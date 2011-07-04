<?php
  define('MODULE_SHIPPING_SPECIALSHIPPING_TEXT_TITLE',       'カスタム配送');
  define('MODULE_SHIPPING_SPECIALSHIPPING_TEXT_DESCRIPTION', '新たに運送会社・配送料金表を設定することができます。配送料金は「配送料金自由設定」画面で細かく設定ができます。');

  define('MODULE_SHIPPING_SPECIALSHIPPING_TEXT_WAY',  '宅急便');

  define('MODULE_SHIPPING_SPECIALSHIPPING_TEXT_NOTAVAILABLE', 'このサービスは、選択された地域間では提供されません。');
  define('MODULE_SHIPPING_SPECIALSHIPPING_TEXT_OVERSIZE',     '重量またはサイズが制限を超えています。');
  define('MODULE_SHIPPING_SPECIALSHIPPING_TEXT_ILLEGAL_ZONE', '指定された都道府県が正しくありません。');
  define('MODULE_SHIPPING_SPECIALSHIPPING_TEXT_OUT_OF_AREA',  '配達区域外です。');


$GLOBALS['a_specialshipping_time']=array(
  array('id'=>'希望なし',  'text'=>'希望なし'),
  array('id'=>'午前中',    'text'=>'午前中'),
  array('id'=>'12時～14時','text'=>'12時～14時'),
  array('id'=>'14時～16時','text'=>'14時～16時'),
  array('id'=>'16時～18時','text'=>'16時～18時'),
  array('id'=>'18時～20時','text'=>'18時～20時'),
  array('id'=>'20時～21時','text'=>'20時～21時'),
);
?>
<?php
  define('SPECIALSHIPPING_SIZE', '重量（kg）');
  define('SPECIALSHIPPING_HOKKAIDO', '北海道');
  define('SPECIALSHIPPING_HOKUTOKITA', '北東北');
  define('SPECIALSHIPPING_NANTOKITA', '南東北');
  define('SPECIALSHIPPING_KANTO', '関東');
  define('SPECIALSHIPPING_SHINETU', '信越');
  define('SPECIALSHIPPING_CHUBU', '中部');
  define('SPECIALSHIPPING_HOKURIKU', '北陸');
  define('SPECIALSHIPPING_KANSAI', '関西');
  define('SPECIALSHIPPING_CYUGOKU', '中国');
  define('SPECIALSHIPPING_SHIKOKU', '四国');
  define('SPECIALSHIPPING_KYUSYU', '九州');
  define('SPECIALSHIPPING_OKINAWA', '沖縄');

  define('SPECIALSHIPPING_HOKUTOKITA_ARRAY', '青森県<br>秋田県<br>岩手県');
  define('SPECIALSHIPPING_NANTOKITA_ARRAY', '宮城県<br>山形県<br>福島県');
  define('SPECIALSHIPPING_KANTO_ARRAY', '茨城県<br>栃木県<br>群馬県<br>埼玉県<br>千葉県<br>神奈川県<br>東京都<br>山梨県');
  define('SPECIALSHIPPING_SHINETU_ARRAY', '新潟県<br>長野県');
  define('SPECIALSHIPPING_CHUBU_ARRAY', '静岡県<br>愛知県<br>三重県<br>岐阜県');
  define('SPECIALSHIPPING_HOKURIKU_ARRAY', '富山県<br>石川県<br>福井県');
  define('SPECIALSHIPPING_KANSAI_ARRAY', '大阪府<br>京都府<br>滋賀県<br>奈良県<br>和歌山県<br>兵庫県');
  define('SPECIALSHIPPING_CYUGOKU_ARRAY', '岡山県<br>広島県<br>山口県<br>鳥取県<br>島根県');
  define('SPECIALSHIPPING_SHIKOKU_ARRAY', '香川県<br>徳島県<br>愛媛県<br>高知県');
  define('SPECIALSHIPPING_KYUSYU_ARRAY', '福岡県<br>佐賀県<br>長崎県<br>熊本県<br>大分県<br>宮崎県<br>鹿児島県<br>');
  define('SPECIALSHIPPING_HEADING_TITLE', '配送料金自由設定');
  define('SPECIALSHIPPING_SUBMIT', '送信');
  define('SPECIALSHIPPING_ATTENTION', 'この配送料金表は<a href="' . zen_href_link(FILENAME_MODULES, 'set=shipping&module=specialshipping') . '">カスタム配送</a>に対応しています。<br />入力した値のチェックなどは一切行っていませんので、十分注意して設定してください。<br />重量はkg単位ですので、1.5kg等と入力しても1kgとして保存されますので注意してください。<br />設定されている最高重量を超えた時には配送モジュールの選択が出来なくなります。');
?>
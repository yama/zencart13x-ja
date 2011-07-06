DROP TABLE IF EXISTS address_book;
CREATE TABLE address_book (
  `address_book_id` int(11) NOT NULL auto_increment,
  `customers_id` int(11) NOT NULL default '0',
  `entry_gender` char(1) NOT NULL default '',
  `entry_company` varchar(255) default NULL,
  `entry_firstname` varchar(32) NOT NULL default '',
  `entry_lastname` varchar(32) NOT NULL default '',
  `entry_street_address` varchar(64) NOT NULL default '',
  `entry_suburb` varchar(32) default NULL,
  `entry_postcode` varchar(10) NOT NULL default '',
  `entry_city` varchar(32) NOT NULL default '',
  `entry_state` varchar(32) default NULL,
  `entry_country_id` int(11) NOT NULL default '0',
  `entry_zone_id` int(11) NOT NULL default '0',
  `entry_telephone` varchar(32) NOT NULL default '',
  `entry_fax` varchar(32) NOT NULL default '',
  `entry_firstname_kana` varchar(64) NOT NULL default '',
  `entry_lastname_kana` varchar(64) NOT NULL default '',
  PRIMARY KEY  (`address_book_id`),
  KEY `idx_address_book_customers_id_zen` (`customers_id`)
)   ;

-- --------------------------------------------------------


DROP TABLE IF EXISTS address_format;
CREATE TABLE address_format (
  `address_format_id` int(11) NOT NULL auto_increment,
  `address_format` varchar(128) NOT NULL default '',
  `address_summary` varchar(48) NOT NULL default '',
  PRIMARY KEY  (`address_format_id`)
)   AUTO_INCREMENT=7 ;

INSERT INTO address_format (`address_format_id`, `address_format`, `address_summary`) VALUES(1, '$firstname $lastname$cr$streets$cr$city, $postcode$cr$statecomma$country', '$city / $country');
INSERT INTO address_format (`address_format_id`, `address_format`, `address_summary`) VALUES(2, '$firstname $lastname$cr$streets$cr$city, $state    $postcode$cr$country', '$city, $state / $country');
INSERT INTO address_format (`address_format_id`, `address_format`, `address_summary`) VALUES(3, '$firstname $lastname$cr$streets$cr$city$cr$postcode - $statecomma$country', '$state / $country');
INSERT INTO address_format (`address_format_id`, `address_format`, `address_summary`) VALUES(4, '$firstname $lastname$cr$streets$cr$city ($postcode)$cr$country', '$postcode / $country');
INSERT INTO address_format (`address_format_id`, `address_format`, `address_summary`) VALUES(5, '$firstname $lastname$cr$streets$cr$postcode $city$cr$country', '$city / $country');
INSERT INTO address_format (`address_format_id`, `address_format`, `address_summary`) VALUES(6, '$firstname $lastname$cr$postcode$cr$state$city$cr$streets$cr$country$cr$telephone$cr$fax', '$statename $city');

-- --------------------------------------------------------

DROP TABLE IF EXISTS admin;
CREATE TABLE admin (
  `admin_id` int(11) NOT NULL auto_increment,
  `admin_name` varchar(32) NOT NULL default '',
  `admin_email` varchar(96) NOT NULL default '',
  `admin_pass` varchar(40) NOT NULL default '',
  `admin_level` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`admin_id`),
  KEY `idx_admin_name_zen` (`admin_name`),
  KEY `idx_admin_email_zen` (`admin_email`)
)   ;
INSERT INTO admin VALUES (1, 'Admin', 'admin@localhost', '351683ea4e19efe34874b501fdbf9792:9b', 1);
-- --------------------------------------------------------

DROP TABLE IF EXISTS admin_activity_log;
CREATE TABLE admin_activity_log (
  `log_id` int(15) NOT NULL auto_increment,
  `access_date` datetime NOT NULL default '0001-01-01 00:00:00',
  `admin_id` int(11) NOT NULL default '0',
  `page_accessed` varchar(80) NOT NULL default '',
  `page_parameters` text,
  `ip_address` varchar(15) NOT NULL default '',
  PRIMARY KEY  (`log_id`),
  KEY `idx_page_accessed_zen` (`page_accessed`),
  KEY `idx_access_date_zen` (`access_date`),
  KEY `idx_ip_zen` (`ip_address`)
)  ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS authorizenet;
CREATE TABLE authorizenet (
  `id` int(11) unsigned NOT NULL auto_increment,
  `customer_id` int(11) NOT NULL default '0',
  `order_id` int(11) NOT NULL default '0',
  `response_code` int(1) NOT NULL default '0',
  `response_text` varchar(255) NOT NULL default '',
  `authorization_type` varchar(50) NOT NULL default '',
  `transaction_id` int(15) NOT NULL default '0',
  `sent` longtext NOT NULL,
  `received` longtext NOT NULL,
  `time` varchar(50) NOT NULL default '',
  `session_id` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`)
)  ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS banners;
CREATE TABLE banners (
  `banners_id` int(11) NOT NULL auto_increment,
  `banners_title` varchar(64) NOT NULL default '',
  `banners_url` varchar(255) NOT NULL default '',
  `banners_image` varchar(64) NOT NULL default '',
  `banners_group` varchar(15) NOT NULL default '',
  `banners_html_text` text,
  `expires_impressions` int(7) default '0',
  `expires_date` datetime default NULL,
  `date_scheduled` datetime default NULL,
  `date_added` datetime NOT NULL default '0001-01-01 00:00:00',
  `date_status_change` datetime default NULL,
  `status` int(1) NOT NULL default '1',
  `banners_open_new_windows` int(1) NOT NULL default '1',
  `banners_on_ssl` int(1) NOT NULL default '1',
  `banners_sort_order` int(11) NOT NULL default '0',
  PRIMARY KEY  (`banners_id`),
  KEY `idx_status_group_zen` (`status`,`banners_group`),
  KEY `idx_expires_date_zen` (`expires_date`),
  KEY `idx_date_scheduled_zen` (`date_scheduled`)
)   ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS banners_history;
CREATE TABLE banners_history (
  `banners_history_id` int(11) NOT NULL auto_increment,
  `banners_id` int(11) NOT NULL default '0',
  `banners_shown` int(5) NOT NULL default '0',
  `banners_clicked` int(5) NOT NULL default '0',
  `banners_history_date` datetime NOT NULL default '0001-01-01 00:00:00',
  PRIMARY KEY  (`banners_history_id`),
  KEY `idx_banners_id_zen` (`banners_id`)
)   ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS categories;
CREATE TABLE categories (
  `categories_id` int(11) NOT NULL auto_increment,
  `categories_image` varchar(64) default NULL,
  `parent_id` int(11) NOT NULL default '0',
  `sort_order` int(3) default NULL,
  `date_added` datetime default NULL,
  `last_modified` datetime default NULL,
  `categories_status` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`categories_id`),
  KEY `idx_parent_id_cat_id_zen` (`parent_id`,`categories_id`),
  KEY `idx_status_zen` (`categories_status`),
  KEY `idx_sort_order_zen` (`sort_order`)
)   ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS categories_description;
CREATE TABLE categories_description (
  `categories_id` int(11) NOT NULL default '0',
  `language_id` int(11) NOT NULL default '1',
  `categories_name` varchar(32) NOT NULL default '',
  `categories_description` text NOT NULL,
  PRIMARY KEY  (`categories_id`,`language_id`),
  KEY `idx_categories_name_zen` (`categories_name`)
) ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS configuration;
CREATE TABLE configuration (
  `configuration_id` int(11) NOT NULL auto_increment,
  `configuration_title` text NOT NULL,
  `configuration_key` varchar(255) NOT NULL default '',
  `configuration_value` text NOT NULL,
  `configuration_description` text NOT NULL,
  `configuration_group_id` int(11) NOT NULL default '0',
  `sort_order` int(5) default NULL,
  `last_modified` datetime default NULL,
  `date_added` datetime NOT NULL default '0001-01-01 00:00:00',
  `use_function` text,
  `set_function` text,
  PRIMARY KEY  (`configuration_id`),
  UNIQUE KEY `unq_config_key_zen` (`configuration_key`),
  KEY `idx_key_value_zen` (`configuration_key`,`configuration_value`(10)),
  KEY `idx_cfg_grp_id_zen` (`configuration_group_id`)
)   ;


INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ショップ名', 'STORE_NAME', 'Zencart', 'デフォルトでは、以下の項目で反映されます<br>\r\n・会員登録等のメール送信者名<br>\r\n・メールタイトル部分<br>\r\n・メール本文中の挨拶文中<br>\r\n・会員登録画面', 1, 1, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ショップオーナー名', 'STORE_OWNER', 'ショップオーナー', 'ショップオーナー名(または運営管理者名)を設定します。<br>\r\nデフォルトでは以下の項目で反映されます<br>\r\n・メール送信時の署名', 1, 2, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '国', 'STORE_COUNTRY', '107', '店舗が存在する国名を入力してください。<strong>注意：変更したら店舗のゾーンの更新を忘れずに行ってください。</strong>', 1, 6, NULL, now(), 'zen_get_country_name', 'zen_cfg_pull_down_country_list(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '地域', 'STORE_ZONE', '194', 'ショップの所在地域(県名)を設定します。<br>\r\n・配送計算/税計算で利用します', 1, 7, NULL, now(), 'zen_cfg_get_zone_name', 'zen_cfg_pull_down_zone_list(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '入荷予定商品のソート順', 'EXPECTED_PRODUCTS_SORT', 'desc', '入荷予定商品のソート順を設定します。<br /><br />\r\n・asc(昇順)<br />\r\n・desc(降順)', 1, 8, NULL, now(), NULL, 'zen_cfg_select_option(array(''asc'', ''desc''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '入荷予定商品のソート順に用いるフィールド', 'EXPECTED_PRODUCTS_FIELD', 'date_expected', '入荷予定商品のソート順に使用するフィールドを設定します。<BR>・products_name:品名<BR>・date_expected:予定日', 1, 9, NULL, now(), NULL, 'zen_cfg_select_option(array(''products_name'', ''date_expected''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '表示言語と通貨の連動', 'USE_DEFAULT_LANGUAGE_CURRENCY', 'false', '表示言語と通貨の変更を連動させるかどうか設定します。<br /><br />true(連動)<br />false(非連動)', 1, 10, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '表示言語の選択', 'LANGUAGE_DEFAULT_SELECTOR', 'Default', 'ショップのデフォルトの表示言語はショップの初期設定またはユーザーのブラウザ設定のどちらに基づくかを設定します。<br /><br />デフォルト：ショップの初期設定', 1, 11, NULL, now(), NULL, 'zen_cfg_select_option(array(''Default'', ''Browser''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'サーチエンジンフレンドリーなURL表記(開発中)', 'SEARCH_ENGINE_FRIENDLY_URLS', 'false', 'サーチエンジンに拾われやすい、静的HTMLのようなURL表記を行うかどうかを設定します。<br><br>\r\n注意：Googleでは動的URLのクロールが強化されたため、あまり意味はないようです。<br><br>※　商品・カテゴリページでの「エイリアス設定」が有効になります', 6, 12, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品の追加後にカートを表示', 'DISPLAY_CART', 'true', '商品をカートに追加した直後にカートの内容を表示するか、または元ページにすぐ戻るかを設定します。<br /><br />\r\n・true (表示)<br />\r\n・false (非表示)', 1, 14, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'デフォルトの検索演算子', 'ADVANCED_SEARCH_DEFAULT_OPERATOR', 'and', 'デフォルトの検索演算子を設定します。', 1, 17, NULL, now(), NULL, 'zen_cfg_select_option(array(''and'', ''or''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ショップの住所と電話番号', 'STORE_NAME_ADDRESS', '店舗名\r\n 住所\r\n 国名\r\n 電話番号', 'ショップ名、国名、住所、電話番号を設定します。<br>\r\nデフォルトでは以下の項目で反映されます<br>\r\n・問合せ画面の店舗情報表示<br>\r\n・支払い方法で「銀行振込」を選択時の確認ページ<br>\r\n・管理画面内「配送表」「注文書」タイトル部分', 1, 18, NULL, now(), NULL, 'zen_cfg_textarea(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'カテゴリ内の商品数を表示', 'SHOW_COUNTS', 'true', 'カテゴリ内の商品数を下位カテゴリも含めてカウント表示するかどうかを設定します。<br /><br />\r\n・true (する)<br />\r\n・false (しない)', 1, 19, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '税額の小数点位置', 'TAX_DECIMAL_PLACES', '0', '税額の小数点以下の桁数を設定します。', 1, 20, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '価格を税込みで表示', 'DISPLAY_PRICE_WITH_TAX', 'true', '価格を税込みで表示するかどうかを設定します。<br /><br />\r\n・true = 価格を税込みで表示<br />\r\n・false = 税額をまとめて表示', 1, 21, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '価格を税込みで表示 - 管理画面', 'DISPLAY_PRICE_WITH_TAX_ADMIN', 'false', '管理画面で価格を税込みで表示するかどうかを設定します。<br /><br />\r\n・true = 価格を税込みで表示<br />\r\n・false = 最後に税額を表示', 1, 21, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品にかかる税額の算定基準', 'STORE_PRODUCT_TAX_BASIS', 'Shipping', '商品にかかる税額を算出する際の基準を設定します。<br><br>\r\n・Shipping …顧客(商品送付先)の住所<br>\r\n・Billing …顧客の請求先の住所<br>\r\n・Store …ショップの所在地による(送付先・請求先ともショップの所在地域（県名）である場合に有効)', 1, 21, NULL, now(), NULL, 'zen_cfg_select_option(array(''Shipping'', ''Billing'', ''Store''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '送料にかかる税額の算定基準', 'STORE_SHIPPING_TAX_BASIS', 'Shipping', '商品にかかる税額を算出する際の基準を設定します。<br><br>\r\n・Shipping …顧客(商品送付先)の住所<br>\r\n・Billing …顧客の請求先の住所<br>\r\n・Store …ショップの所在地による(送付先・請求先ともショップの所在地域（県名）である場合に有効)', 1, 21, NULL, now(), NULL, 'zen_cfg_select_option(array(''Shipping'', ''Billing'', ''Store''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '税金の表示', 'STORE_TAX_DISPLAY_STATUS', '0', '合計額が0円でも税金を表示しますか?<br />0= Off<br />1= On', 1, 21, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '管理画面のタイムアウト設定(秒数)', 'SESSION_TIMEOUT_ADMIN', '3600', '管理画面がタイムアウトするまでの秒数を設定します。デフォルトは3600秒＝1時間です。<br />あまり短めに設定すると商品登録中などにタイムアウトしてしまいますので注意。<br />900秒未満を設定すると900秒に自動的に設定されます。', 1, 40, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '管理画面のプログラム処理の上限時間設定(秒)\r\n', 'GLOBAL_SET_TIME_LIMIT', '60', '管理画面においてなんらかの操作を行った場合の、プログラム処理の強制終了時間を設定します。デフォルトは60秒＝1分。この設定は、プログラム処理時間に問題がある場合などにだけ変更してください。\r\n', 1, 42, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'Zen Cart新バージョンの自動チェック(ヘッダで告知するか否か)', 'SHOW_VERSION_UPDATE_IN_HEADER', 'false', 'Zen Cartの新バージョンがリリースされた場合、ヘッダに情報を表示しますか?<br /><br />\r\n注意：この設定をオンにすると、管理者ページの表示が遅くなる場合があります。インターネットに繋がっていないテスト環境などではfalseにしてください。\r\n', 1, 44, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ショップのステータス', 'STORE_STATUS', '0', 'ショップの状態を設定します。<br /><br />\r\n・0＝通常のショップ<br />\r\n・1＝価格表示なしのデモショップ<br />\r\n・2＝価格表示付きのデモショップ\r\n', 1, 25, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'サーバの稼動時間(アップタイム)', 'DISPLAY_SERVER_UPTIME', 'false', 'サーバの稼働時間を表示するかどうかを設定します。この情報はいくつかのサーバでエラーログとして残ることがあります。<br /><br />true＝表示<br /><br />false＝非表示', 1, 46, NULL, now(), '', 'zen_cfg_select_option(array(''true'', ''false''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'リンク切れページのチェック', 'MISSING_PAGE_CHECK', 'Page Not Found', 'Zen Cart で存在しないページへのアクセスがあった場合、自動的にトップページに転送しますか?<br><br>\r\n・On = オン<br>\r\n・Off = オフ<br>\r\n・Page Not Found = ページが見つかりません画面へ遷移する<br><br>\r\n注意：デバックの際などにはこの機能をオフにするとよいでしょう。', 1, 48, NULL, now(), '', 'zen_cfg_select_option(array(''On'', ''Off'', ''Page Not Found''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'cURLプロキシのステータス', 'CURL_PROXY_REQUIRED', 'False', '利用中のホストでは、cURL通信のためのプロキシを使用する必要がありますか？', 1, 50, NULL, now(), NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'cURL プロキシアドレス', 'CURL_PROXY_SERVER_DETAILS', '', 'cURLで外部のサイトと通信するためにプロキシを経由する必要があるGoDaddyや他のホスティングサービスをご利用の場合は、指定のプロキシアドレスを入力してください。<br /><br />フォーマット=>　アドレス：ポート<br />例）GoDaddyの場合、　64.202.165.130:3128 　と入力します。', 1, 51, NULL, now(), NULL, NULL);
INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'HTMLエディタ', 'HTML_EDITOR_PREFERENCE', 'NONE', 'メールマガジンや商品説明などで用いるHTML/リッチテキスト用のソフトウェアを設定します。', 1, 110, NULL, now(), NULL, 'zen_cfg_pull_down_htmleditors(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'phpBBへのリンクを表示', 'PHPBB_LINKS_ENABLED', '', 'Zen Cart上に(インストール済みの)phpBBのフォーラムへのリンクを表示するかどうかを設定します。\r\n', 1, 120, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'カテゴリ内の商品数を表示 - 管理画面', 'SHOW_COUNTS_ADMIN', 'true', 'ショップのカテゴリサイドボックス内で、カテゴリ以下の商品数を下位カテゴリも含めてカウント表示するかどうかを設定します。<br>\r\n※　商品点数が多くなり表示速度が遅くなった場合には非表示にすることで改善することがあります。<br><br>\r\n・true (する)<br>\r\n・false (しない)', 1, 19, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '通貨換算率', 'CURRENCY_UPLIFT_RATIO', '1.05', '通貨設定で「為替レート更新」機能を利用する際に、ショップで利用する際の換算率としてどれだけ"上乗せ"計算するかを設定します。<br />\r\nつまり、為替サーバから取得した公定歩合と消費者レートの違いを補うためにどれだけ上乗せ計算するかを設定する事ができます。<br /><br />\r\nデフォルト： 1.05 <br />\r\n取得した公定歩合に1.05を掛けてショップの通貨の為替レートとして保存します', 1, 55, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '名前の最小文字数', 'ENTRY_FIRST_NAME_MIN_LENGTH', '1', '名前の文字数の最小値を設定します。', 2, 1, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '姓の最小文字数', 'ENTRY_LAST_NAME_MIN_LENGTH', '1', '姓の文字数の最小値を設定します。', 2, 2, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '生年月日の最小文字数', 'ENTRY_DOB_MIN_LENGTH', '10', '生年月日の文字数の最小値を設定します。', 2, 3, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メールアドレスの最小文字数', 'ENTRY_EMAIL_ADDRESS_MIN_LENGTH', '6', 'メールアドレスの文字数の最小値を設定します。', 2, 4, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '住所の最小文字数', 'ENTRY_STREET_ADDRESS_MIN_LENGTH', '5', '番地・マンション・アパート名の最小文字数を設定します。', 2, 5, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '会社名の最小文字数', 'ENTRY_COMPANY_MIN_LENGTH', '0', '会社名の文字数の最小値を設定します。', 2, 6, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '郵便番号の最小文字数', 'ENTRY_POSTCODE_MIN_LENGTH', '4', '郵便番号の文字数の最小値を設定します。', 2, 7, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '市区町村の最小文字数', 'ENTRY_CITY_MIN_LENGTH', '2', '市区町村の文字数の最小値を設定します。', 2, 8, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '都道府県名の最小文字数', 'ENTRY_STATE_MIN_LENGTH', '2', '都道府県の文字数の最小値を設定します。', 2, 9, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '電話番号の最小文字数', 'ENTRY_TELEPHONE_MIN_LENGTH', '3', '電話番号の文字数の最小値を設定します。', 2, 10, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'パスワードの最小文字数', 'ENTRY_PASSWORD_MIN_LENGTH', '5', 'パスワードの文字数の最小値を設定します。', 2, 11, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'クレジットカード名義の最小文字数', 'CC_OWNER_MIN_LENGTH', '3', 'クレジットカード所有者名の文字数の最小値を設定します。', 2, 12, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'クレジットカード番号の最小文字数', 'CC_NUMBER_MIN_LENGTH', '10', 'クレジットカード番号の文字数の最小値を設定します。', 2, 13, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'クレジットカードCVV番号の最小文字数', 'CC_CVV_MIN_LENGTH', '3', 'クレジットカードCVV番号の文字数の最小値を設定します。', 2, 13, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'レビューの文章の最小文字数', 'REVIEW_TEXT_MIN_LENGTH', '50', 'レビューの文章の文字数の最小値を設定します。', 2, 14, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ベストセラーの最小表示件数', 'MIN_DISPLAY_BESTSELLERS', '1', 'ベストセラーとして表示する商品の最小値を設定します。', 2, 15, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「こんな商品も購入しています」の最小表示数', 'MIN_DISPLAY_ALSO_PURCHASED', '1', '「この商品を購入した人はこんな商品も購入しています」で表示する商品数の最小値を設定します。', 2, 16, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ニックネームの最小文字数', 'ENTRY_NICK_MIN_LENGTH', '3', 'ニックネームの文字数の最小値を設定します。', 2, 1, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'アドレス帳の最大登録数', 'MAX_ADDRESS_BOOK_ENTRIES', '5', '顧客が登録できるアドレス帳の登録数の最大値を設定します。', 3, 1, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '管理画面 - 1ページに表示する検索結果の最大数', 'MAX_DISPLAY_SEARCH_RESULTS', '20', '管理画面の1ページに表示する検索結果の数の最大値を設定します。', 3, 2, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ページ・リンク数の最大表示数', 'MAX_DISPLAY_PAGE_LINKS', '5', '商品リストや購入履歴の一覧表示でページの下などに表示されるページ数・リンク数の最大値を設定します。', 3, 3, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '特価商品の最大表示数', 'MAX_DISPLAY_SPECIAL_PRODUCTS', '9', '特価商品一覧ページで一ページで表示する商品の最大数を設定します。', 3, 4, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '今月の新着商品の最大表示数', 'MAX_DISPLAY_NEW_PRODUCTS', '9', '「新着商品センターボックス」で商品を最大何点表示するかを設定します。', 3, 5, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '入荷予定商品の最大表示数', 'MAX_DISPLAY_UPCOMING_PRODUCTS', '10', '「入荷予定商品センターボックス」で商品を最大何点表示するかを設定します。', 3, 6, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メーカーリスト - スクロールボックスのサイズ/スタイル', 'MAX_MANUFACTURERS_LIST', '3', 'スクロールボックスに表示されるメーカー数は ?<br />1か0に設定するとドロップダウンリストになります。', 3, 7, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メーカーリスト - 商品の存在を確認', 'PRODUCTS_MANUFACTURERS_STATUS', '1', '各メーカーについて、1点以上の商品があり、かつ閲覧可能であるかどうかを確認しますか?<br /><br />注意：この機能がONの場合、商品数やメーカーの数が多いと表示が遅くなります。<br />0= off 1= on', 3, 7, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '音楽ジャンルリスト - スクロールボックスのサイズ/スタイル', 'MAX_MUSIC_GENRES_LIST', '3', 'スクロールボックスに表示される音楽ジャンルリストの数を設定します。1か0に設定すると、ドロップダウンリストになります。\r\n', 3, 7, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'レコード会社リスト - スクロールボックスのサイズ/スタイル', 'MAX_RECORD_COMPANY_LIST', '3', 'スクロールボックスに表示されるレコード会社リストの数です。1か0に設定すると、ドロップダウンリストになります。\r\n', 3, 7, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'レコード会社名表示の長さ', 'MAX_DISPLAY_RECORD_COMPANY_NAME_LEN', '15', 'レコード会社名ボックスで表示される名前の長さを設定します。設定より長い名前は省略表示されます。\r\n', 3, 8, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '音楽ジャンル名の文字数の長さ', 'MAX_DISPLAY_MUSIC_GENRES_NAME_LEN', '15', '音楽ジャンルボックスで表示される名前の長さを設定します。設定より長い名前は省略表示されます。\r\n', 3, 8, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メーカー名の長さ', 'MAX_DISPLAY_MANUFACTURER_NAME_LEN', '15', 'メーカーリストで表示されるメーカー名の文字数の最大値を設定します。', 3, 8, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '新しいレビューの表示数最大値', 'MAX_DISPLAY_NEW_REVIEWS', '6', '新しいレビューとして表示される数の最大値を設定します。', 3, 9, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'レビューのランダム表示数', 'MAX_RANDOM_SELECT_REVIEWS', '1', 'ランダムに表示するレビュー数の最大値を設定します。<br /><br />注意：この設定値をXとすると、ランダム表示の対象になるのは、もっとも古いアクティブなレビューから数えてX番目に登録されたアクティブなレビューまでになります。', 3, 10, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '新着商品のランダム表示数', 'MAX_RANDOM_SELECT_NEW', '3', 'ランダムに表示する新着商品数の最大値を設定します。<br /><br />注意：この設定値をXとすると、ランダム表示の対象になるのは、もっとも古いアクティブな新着商品から数えてX番目に登録されたアクティブな新着商品までになります。', 3, 11, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '特価商品のランダム表示数', 'MAX_RANDOM_SELECT_SPECIALS', '2', 'ランダムに表示する特価商品数の最大値を設定します。<br /><br />注意：この設定値をXとすると、ランダム表示の対象になるのは、もっとも古いアクティブな特価商品から数えてX番目に登録されたアクティブな特価商品までになります。', 3, 12, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '一行に表示するカテゴリ数', 'MAX_DISPLAY_CATEGORIES_PER_ROW', '3', '一行に表示するカテゴリ数を設定します。', 3, 13, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '新着商品一覧表示数', 'MAX_DISPLAY_PRODUCTS_NEW', '10', '新着商品ページ１ページに表示する商品数の最大値を設定します。', 3, 14, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ベストセラーの最大表示件数', 'MAX_DISPLAY_BESTSELLERS', '10', 'ベストセラーページ１ページに表示するベストセラー商品数の最大値を設定します。', 3, 15, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「こんな商品も買っています」の最大表示件数', 'MAX_DISPLAY_ALSO_PURCHASED', '6', '「こんな商品も買っています」欄に表示する商品数の最大値を設定します。', 3, 16, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '顧客の注文履歴ボックスの最大表示数', 'MAX_DISPLAY_PRODUCTS_IN_ORDER_HISTORY_BOX', '6', '顧客の注文履歴ボックスに表示する商品数の最大値を設定します。', 3, 17, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '注文履歴ページの最大表示件数', 'MAX_DISPLAY_ORDER_HISTORY', '10', '顧客の注文履歴ページ１ページに表示する商品数の最大値を設定します。', 3, 18, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '顧客管理ページで表示する顧客数の最大値', 'MAX_DISPLAY_SEARCH_RESULTS_CUSTOMER', '20', '', 3, 19, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '注文管理ページで表示する注文数の最大値', 'MAX_DISPLAY_SEARCH_RESULTS_ORDERS', '20', '', 3, 20, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'レポートページで表示する商品数の最大値', 'MAX_DISPLAY_SEARCH_RESULTS_REPORTS', '20', '', 3, 21, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'カテゴリ/商品ページで表示するリスト数', 'MAX_DISPLAY_RESULTS_CATEGORIES', '10', '１ページに表示する商品数の最大値を設定します。', 3, 22, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品リスト - ページあたり最大表示数', 'MAX_DISPLAY_PRODUCTS_LISTING', '10', 'カテゴリ内商品一覧と検索結果で表示する商品の最大数を設定します。', 3, 30, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品オプション - オプション名とオプション値の表示', 'MAX_ROW_LISTS_OPTIONS', '10', '「オプション名の管理」と「オプション値の管理」で一ページで表示するリストの最大数を設定します。', 3, 24, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品オプション - オプション管理画面', 'MAX_ROW_LISTS_ATTRIBUTES_CONTROLLER', '30', '商品のオプション属性管理画面で一ページで表示する設定済みオプションの最大数を設定します。', 3, 25, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品属性- ダウンロード管理ページの表示', 'MAX_DISPLAY_SEARCH_RESULTS_DOWNLOADS_MANAGER', '30', '「ダウンロード商品の管理」画面で一ページで表示するダウンロード商品属性の最大数を設定します。', 3, 26, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'おすすめ商品 - 管理画面でのページあたり表示最大数', 'MAX_DISPLAY_SEARCH_RESULTS_FEATURED_ADMIN', '10', '「おすすめ商品の管理」画面において、一ページで表示する商品の最大数を設定します。', 3, 27, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'おすすめ商品 - メインページでの最大表示数', 'MAX_DISPLAY_SEARCH_RESULTS_FEATURED', '9', '「おすすめ商品センターボックス」で商品を最大何点表示するかを設定します。', 3, 28, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'おすすめ商品 - 商品リストでの最大表示数', 'MAX_DISPLAY_PRODUCTS_FEATURED_PRODUCTS', '10', 'おすすめ商品一覧ページで一ページで表示する商品の最大数を設定します。', 3, 29, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'おすすめ商品のランダム表示ボックス - 最大表示数', 'MAX_RANDOM_SELECT_FEATURED_PRODUCTS', '2', 'おすすめ商品のランダム表示ボックスにおいて、最大何点表示するかを設定します。', 3, 30, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '特価商品 - メインページでの最大表示点数', 'MAX_DISPLAY_SPECIAL_PRODUCTS_INDEX', '9', '「特価商品センターボックス」で商品を最大何点表示するかを設定します。', 3, 31, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '新着商品 - 表示期限', 'SHOW_NEW_PRODUCTS_LIMIT', '0', '新着商品の表示期限を設定します。<br />\r\n<br />\r\n・0=全て・降順<br />\r\n・1=当月登録分のみ<br />\r\n・30=登録から30日間<br />\r\n・60=登録から60日間(ほか90、120の設定が可能)', 3, 40, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''7'', ''14'', ''30'', ''60'', ''90'', ''120''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品一覧ページ - ページあたり表示点数', 'MAX_DISPLAY_PRODUCTS_ALL', '10', '全商品一覧ページで一ページで表示する商品の最大数を設定します。', 3, 45, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '言語サイドボックス -　フラッグ最大表示数', 'MAX_LANGUAGE_FLAGS_COLUMNS', '3', '言語サイドボックスにおいて、列あたりのフラッグの最大表示点数を設定します。', 3, 50, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ファイルのアップロードサイズ - 上限', 'MAX_FILE_UPLOAD_SIZE', '2048000', 'ファイルアップロードの際の上限サイズを設定します。デフォルトは2MB(2,048,000バイト)です。', 3, 60, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'アップロードファイルに許可するファイルタイプ', 'UPLOAD_FILENAME_EXTENSIONS', 'jpg,jpeg,gif,png,eps,cdr,ai,pdf,tif,tiff,bmp,zip', 'ユーザーがアップロードするファイルに対して許可するファイルタイプの拡張子を設定します。複数の場合はカンマ(,)で区切り、コロン(.)は含めないでください。<br /><br />設定例: "jpg,jpeg,gif,png,eps,cdr,ai,pdf,tif,tiff,bmp,zip"', 3, 61, NULL, now(), NULL, 'zen_cfg_textarea(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '管理画面の注文リストで表示する注文詳細の最大件数', 'MAX_DISPLAY_RESULTS_ORDERS_DETAILS_LISTING', '0', '管理画面の注文リストでの注文詳細の最大表示件数は?<br />0 = 無制限', 3, 65, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '管理画面のリストで表示するPayPal IPNの最大件数', 'MAX_DISPLAY_SEARCH_RESULTS_PAYPAL_IPN', '20', '管理画面のリストでのPayPal IPNの表示件数は?<br />デフォルトは20です。', 3, 66, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'マルチカテゴリマネージャで商品を表示するカラムの最大数', 'MAX_DISPLAY_PRODUCTS_TO_CATEGORIES_COLUMNS', '3', 'マルチカテゴリマネージャ(Multiple Categories Manager)で商品を表示するカラムの最大数は?<br />3 = デフォルト', 3, 70, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'EZページの表示の最大件数', 'MAX_DISPLAY_SEARCH_RESULTS_EZPAGE', '20', 'EZページの表示の最大件数は?<br />20 = デフォルト', 3, 71, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品画像(小)の横幅', 'SMALL_IMAGE_WIDTH', '100', '小さな画像の横幅(ピクセル)を設定します。', 4, 1, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品画像(小)の高さ', 'SMALL_IMAGE_HEIGHT', '80', '小さな画像の高さ(ピクセル)を設定します。', 4, 2, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ヘッダ画像の横幅 - 管理画面', 'HEADING_IMAGE_WIDTH', '57', '管理画面でのヘッダ画像の横幅を設定します。', 4, 3, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ヘッダ画像の高さ - 管理画面', 'HEADING_IMAGE_HEIGHT', '40', '管理画面でのヘッダ画像の高さを設定します。', 4, 4, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'サブカテゴリ画像の横幅', 'SUBCATEGORY_IMAGE_WIDTH', '100', 'サブカテゴリ画像の横幅をピクセル数で設定します。', 4, 5, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'サブカテゴリ画像の高さ', 'SUBCATEGORY_IMAGE_HEIGHT', '57', 'サブカテゴリ画像の高さをピクセル数で設定します。', 4, 6, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '画像サイズを計算', 'CONFIG_CALCULATE_IMAGE_SIZE', 'true', '元画像サイズをチェックし、設定値と整合しない場合にはそのままのサイズで表示します。', 4, 7, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '画像を必須とする', 'IMAGE_REQUIRED', 'true', '画像がないことを表示します。(カタログの作成時に有効)', 4, 8, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ショッピングカートの中身 - 商品画像の表示オン・オフ', 'IMAGE_SHOPPING_CART_STATUS', '1', 'ショッピングカートの中身に入っている商品の画像を表示するかどうかを設定します。<br /><br />\r\n・0= off<br />\r\n・1= on', 4, 9, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ショッピングカートの中身の画像の横幅', 'IMAGE_SHOPPING_CART_WIDTH', '50', 'デフォルト = 50', 4, 10, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ショッピングカートの中身の画像の高さ', 'IMAGE_SHOPPING_CART_HEIGHT', '40', 'デフォルト = 40', 4, 11, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品情報 - カテゴリアイコン画像の横幅', 'CATEGORY_ICON_IMAGE_WIDTH', '57', '商品情報ページでのカテゴリアイコンの横幅(ピクセル数)は?', 4, 13, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品情報 - カテゴリアイコン画像の高さ', 'CATEGORY_ICON_IMAGE_HEIGHT', '40', '商品情報ページでのカテゴリアイコンの高さ(ピクセル数)は?', 4, 14, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'トップサブカテゴリ画像の横幅', 'SUBCATEGORY_IMAGE_TOP_WIDTH', '150', 'トップサブカテゴリ画像の横幅（ピクセル数）は？\r\nトップサブカテゴリとは、サブカテゴリを持っているカテゴリです。', 4, 15, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'トップサブカテゴリ画像の高さ', 'SUBCATEGORY_IMAGE_TOP_HEIGHT', '85', 'トップサブカテゴリ画像の高さ（ピクセル数）は？\r\nトップサブカテゴリとは、サブカテゴリを持っているカテゴリです。', 4, 16, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品情報 - 画像の横幅', 'MEDIUM_IMAGE_WIDTH', '150', '商品画像の横幅を設定します。', 4, 20, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品情報 - 画像の高さ', 'MEDIUM_IMAGE_HEIGHT', '120', '商品画像の高さを設定します。', 4, 21, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品情報 - 画像(中)のファイル接尾辞(Suffix)', 'IMAGE_SUFFIX_MEDIUM', '_MED', '商品画像のファイル接尾辞を設定します。<br /><br />・デフォルト = _MED', 4, 22, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品情報 - 画像(大)のファイル接尾辞(Suffix)', 'IMAGE_SUFFIX_LARGE', '_LRG', '商品画像のファイル接尾辞を設定します。<br /><br />\r\n・デフォルト = _LRG', 4, 23, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品情報 - １行に表示する追加画像数', 'IMAGES_AUTO_ADDED', '3', '商品情報で１行に表示する追加画像数を設定します。<br /><br />\r\n・デフォルト = 3', 4, 30, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品リスト - 画像の横幅', 'IMAGE_PRODUCT_LISTING_WIDTH', '100', 'デフォルト = 100', 4, 40, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品リスト - 画像の高さ', 'IMAGE_PRODUCT_LISTING_HEIGHT', '80', 'デフォルト = 80', 4, 41, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '新商品リスト - 画像の横幅', 'IMAGE_PRODUCT_NEW_LISTING_WIDTH', '100', 'デフォルト = 100', 4, 42, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '新商品リスト - 画像の高さ', 'IMAGE_PRODUCT_NEW_LISTING_HEIGHT', '80', 'デフォルト = 80', 4, 43, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '新商品 - 画像の横幅', 'IMAGE_PRODUCT_NEW_WIDTH', '100', 'デフォルト = 100', 4, 44, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '新商品 - 画像の高さ', 'IMAGE_PRODUCT_NEW_HEIGHT', '80', 'デフォルト = 80', 4, 45, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'おすすめ商品 -画像の幅', 'IMAGE_FEATURED_PRODUCTS_LISTING_WIDTH', '100', 'デフォルト = 100', 4, 46, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'おすすめ商品 - 画像の高さ', 'IMAGE_FEATURED_PRODUCTS_LISTING_HEIGHT', '80', 'デフォルト = 80', 4, 47, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '全商品一覧 - 画像の幅', 'IMAGE_PRODUCT_ALL_LISTING_WIDTH', '100', 'デフォルト = 100', 4, 48, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '全商品一覧 - 画像の高さ', 'IMAGE_PRODUCT_ALL_LISTING_HEIGHT', '80', 'デフォルト = 80', 4, 49, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品画像 - 画像がない場合のNo Image画像', 'PRODUCTS_IMAGE_NO_IMAGE_STATUS', '1', '「No Image」画像を自動的に表示するかどうかを設定します。<br /><br />\r\n・0= off<br />\r\n・1= On<br />', 4, 60, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品画像 - No Image画像の指定', 'PRODUCTS_IMAGE_NO_IMAGE', 'no_picture.gif', '商品画像がない場合に表示するNo Image画像を設定します。<br /><br />Default = no_picture.gif', 4, 61, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品画像 - 商品・カテゴリでプロポーショナルな画像を使う', 'PROPORTIONAL_IMAGES_STATUS', '1', '商品情報・カテゴリで元画像の縦横比を保持して表示させますか？<br><br>\r\n注意：プロポーショナル画像には高さ・横幅とも"0"(ピクセル)を指定しないでください。<br>\r\n0= off <br>1= on', 4, 75, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '性別', 'ACCOUNT_GENDER', 'true', '顧客のアカウント作成の際、性別の選択を表示するかどうかを設定します。<br>英語の場合メール内の呼びかけ部分に Mr. もしくは Ms. がつきます<br>\r\n※　必須選択項目になります', 5, 1, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '生年月日', 'ACCOUNT_DOB', 'true', '顧客のアカウント作成の際、「生年月日」の欄を表示するかどうかを設定します。<br>\r\n注意: 不要な場合はfalseに、必要な場合はtrueを指定してください。<br>\r\n※　必須入力項目になります。', 5, 2, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '会社名', 'ACCOUNT_COMPANY', 'true', '顧客のアカウント作成の際、「会社名」を表示するかどうかを設定します。', 5, 3, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '住所2', 'ACCOUNT_SUBURB', 'true', '顧客のアカウント作成の際、「住所2」を表示するかどうかを設定します。', 5, 4, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '都道府県名', 'ACCOUNT_STATE', 'true', '顧客のアカウント作成の際、「都道府県名」を表示するかどうかを設定します。', 5, 5, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '都道府県名 - ドロップダウンで表示', 'ACCOUNT_STATE_DRAW_INITIAL_DROPDOWN', 'true', '「都道府県名」は常にドロップダウン形式で表示しますか?', 5, 5, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'アカウントのデフォルト国別IDの作成', 'SHOW_CREATE_ACCOUNT_DEFAULT_COUNTRY', '107', 'アカウントのデフォルト国別IDを設定します。<br />デフォルトはJapanです。', 5, 6, NULL, now(), 'zen_get_country_name', 'zen_cfg_pull_down_country_list_none(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'Fax番号', 'ACCOUNT_FAX_NUMBER', 'true', '顧客のアカウント作成の際、「Fax番号」を表示するかどうかを設定します。', 5, 10, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メールマガジンのチェックボックスの表示', 'ACCOUNT_NEWSLETTER_STATUS', '1', 'メールマガジンのチェックボックスの表示設定をします。<br />0= 表示オフ<br />1= ボックス表示・チェックなし状態<br />2= ボックス表示・チェックあり状態<br />【注意】デフォルトで「チェックあり」の状態にしておくと、各国のスパム規制法規に抵触する恐れがあります。', 5, 45, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'デフォルトのメール形式の設定', 'ACCOUNT_EMAIL_PREFERENCE', '0', '顧客のデフォルトのメール形式を設定します。<br />0= テキスト形式<br />1= HTML形式', 5, 46, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '顧客への商品の通知 - ステータス', 'CUSTOMERS_PRODUCTS_NOTIFICATION_STATUS', '1', '顧客がチェックアウト後に、商品の通知(product notifications)について尋ねるかどうかを設定します。<br /><br />\r\n・0= 尋ねない<br />\r\n・1= 尋ねる(サイト全体に対して設定されていない場合)<br />\r\n【注意】サイドボックスはこの設定とは別にオフにする必要があります。', 5, 50, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品・価格の閲覧制限', 'CUSTOMERS_APPROVAL', '0', '顧客がショップ内で商品や価格を閲覧するのを制限するかどうかを設定します。<br />0= 要ログインなどの制限なし<br />1= ブラウスにはログインが必須<br />2= ログインなしでブラウズ可能だが価格は非表示<br />3= 商品閲覧のみ<br /><br />【注意】オプション「2」は、サーチエンジンのロボットに収集されたくない場合や、ログイン済みの顧客にのみ価格を開示したい場合に有効です。', 5, 55, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '顧客の購入オーソライズ', 'CUSTOMERS_APPROVAL_AUTHORIZATION', '0', 'ショップでの購入に際して、顧客はショップ側に審査・許可される必要があるかどうかを設定します。<br />0= 不要<br />1= 商品の閲覧にも許可が必要<br />2= 商品の閲覧は自由だが価格の閲覧は許可された顧客のみ<br />【注意】オプション「2」はサーチエンジンのロボット除けに用いることもできます。', 5, 65, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '顧客のオーソライズ(閲覧制限) - ファイル名', 'CUSTOMERS_AUTHORIZATION_FILENAME', 'customers_authorization', '顧客のオーソライズ(閲覧制限)に使うファイル名を設定します。拡張子なしで表記してください。<br />デフォルトは\r\n"customers_authorization"', 5, 66, NULL, now(), NULL, '');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '顧客のオーソライズ(閲覧制限) - ヘッダを隠す', 'CUSTOMERS_AUTHORIZATION_HEADER_OFF', 'false', '顧客のオーソライズ(閲覧制限) でヘッダを表示するかどうかを設定します。<br /><br />\r\n・true= 表示しない<br />\r\n・false= 表示する', 5, 67, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '顧客のオーソライズ(閲覧制限) - 左カラムを隠す', 'CUSTOMERS_AUTHORIZATION_COLUMN_LEFT_OFF', 'false', '顧客のオーソライズ(閲覧制限) で、左カラムを表示するかどうかを設定します。<br /><br />\r\n・true= 表示しない<br />\r\n・false= 表示する', 5, 68, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '顧客のオーソライズ(閲覧制限) - 右カラムを隠す', 'CUSTOMERS_AUTHORIZATION_COLUMN_RIGHT_OFF', 'false', '顧客のオーソライズ(閲覧制限)で、右カラムを表示するかどうかを設定します。<br /><br />\r\n・true=  表示しない<br />\r\n・false= 表示する', 5, 69, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '顧客のオーソライズ(閲覧制限) - フッタを隠す', 'CUSTOMERS_AUTHORIZATION_FOOTER_OFF', 'false', '顧客のオーソライズ(閲覧制限) で、フッタを表示するかどうかを設定します。<br /><br />\r\n・true= 表示しない<br />\r\n・false= 表示する', 5, 70, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '顧客のオーソライズ(閲覧制限) - 価格の非表示', 'CUSTOMERS_AUTHORIZATION_PRICES_OFF', 'false', '顧客のオーソライズで、価格を表示するかどうかを設定します。<br /><br />\r\n・true= 表示しない<br />\r\n・false= 表示する', 5, 71, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '顧客の紹介(Customers Referral)ステータス', 'CUSTOMERS_REFERRAL_STATUS', '0', '「販促レポート」で利用する顧客の紹介コードについて設定します。<br>\r\n0= 使用しない<br>\r\n1= その顧客が初めて購入に利用した割引クーポンを紹介コードとする<br>\r\n2= アカウント作成の際、顧客自身が入力<br>\r\n　　会員登録画面に入力枠が表示されます。<br><br>\r\n注意：登録されたコードは顧客管理画面で参照可能です。顧客の紹介コードがセットされると、管理画面からだけ変更することができます。', 5, 80, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'インストール済みの支払いモジュール', 'MODULE_PAYMENT_INSTALLED', 'cod_table.php', 'インストールされている支払いモジュールのファイル名のリスト( セミコロン(;)区切り )です。この情報は自動的に更新されますので編集の必要はありません。', 6, 0, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'インストール済み注文合計モジュール', 'MODULE_ORDER_TOTAL_INSTALLED', 'ot_subtotal.php;ot_shipping.php;ot_coupon.php;ot_group_pricing.php;ot_tax.php;ot_loworderfee.php;ot_gv.php;ot_cod_table.php;ot_total.php', 'インストールされている注文合計モジュールのファイル名のリスト(セミコロン(;)区切り)です。\r\n<br /><br />\r\n【注意】この情報は自動的に更新されますので編集の必要はありません。', 6, 0, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'インストール済み配送モジュール', 'MODULE_SHIPPING_INSTALLED', 'specialshipping.php', 'インストールされている配送モジュールのファイル名のリスト(セミコロン(;)区切り)です。この情報は自動的に更新されますので編集の必要はありません。', 6, 0, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'カスタム料金の配送を有効にする', 'MODULE_SHIPPING_SPECIALSHIPPING_STATUS', 'True', 'カスタム料金の配送を提供しますか?', 6, 0, NULL, now(), NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '運送会社名', 'MODULE_SHIPPING_SPECIALSHIPPING_COMPANYNAME', 'カスタム運輸', 'カート側に表示される運送会社名を記入してください。.', 6, 6, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '配送時間指定', 'MODULE_SHIPPING_SPECIALSHIPPING_TIMESPEC', 'True', '配送時間指定プルダウンを表示しますか?', 6, 0, NULL, now(), NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '送料無料設定', 'MODULE_SHIPPING_SPECIALSHIPPING_FREE_SHIPPING', 'False', '送料無料設定を有効にしますか? [合計モジュール]-[送料]-[送料無料設定]を優先する場合は False を選んでください.', 6, 2, NULL, now(), NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '送料を無料にする購入金額設定', 'MODULE_SHIPPING_SPECIALSHIPPING_OVER', '5000', '設定金額以上をご購入の場合は送料を無料にします.', 6, 3, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '配送地域', 'MODULE_SHIPPING_SPECIALSHIPPING_ZONE', '0', '配送地域を選択すると選択された地域のみで利用可能となります.', 6, 5, NULL, now(), 'zen_get_zone_class_title', 'zen_cfg_pull_down_zone_classes(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '表示の整列順', 'MODULE_SHIPPING_SPECIALSHIPPING_SORT_ORDER', '0', '表示の整列順を設定できます. 数字が小さいほど上位に表示されます.', 6, 6, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '税金を含める', 'MODULE_ORDER_TOTAL_GROUP_PRICING_INC_TAX', 'false', '税金を計算に含めますか？', 6, 6, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'インストール状態', 'MODULE_ORDER_TOTAL_GROUP_PRICING_STATUS', 'true', '', 6, 1, NULL, now(), NULL, 'zen_cfg_select_option(array(''true''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '表示の整列順', 'MODULE_ORDER_TOTAL_GROUP_PRICING_SORT_ORDER', '290', '表示の整列順を設定できます. 数字が小さいほど上位に表示されます。', 6, 2, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '送料を含める', 'MODULE_ORDER_TOTAL_GROUP_PRICING_INC_SHIPPING', 'false', '送料を計算に含めますか？', 6, 5, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '税金の再計算', 'MODULE_ORDER_TOTAL_GROUP_PRICING_CALC_TAX', 'Standard', '税金を再計算しますか？', 6, 7, NULL, now(), NULL, 'zen_cfg_select_option(array(''None'', ''Standard'', ''Credit Note''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '税種別', 'MODULE_ORDER_TOTAL_GROUP_PRICING_TAX_CLASS', '0', '顧客割引をCredit Note（貸方票）取引として利用する際に適応する税種別。', 6, 0, NULL, now(), 'zen_get_tax_class_title', 'zen_cfg_pull_down_tax_classes(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '初期注文ステータス', 'MODULE_PAYMENT_COD_TABLE_ORDER_STATUS_ID', '0', '設定したステータスが受注時に適用されます.', 6, 4, NULL, now(), 'zen_get_order_status_name', 'zen_cfg_pull_down_order_statuses(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '配送方法選択', 'MODULE_PAYMENT_COD_TABLE_SHIPPING_MODULE', '', '代金引換モジュールを有効にする配送方法を指定できます。<br />代金引換モジュールを有効にしたい配送モジュールをカンマ区切りで入力してください。<br />例）flat,item<br />何も入力していない場合は全ての配送モジュールで利用可能となります。', 6, 0, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'デフォルトの通貨', 'DEFAULT_CURRENCY', 'JPY', 'デフォルトの通貨を設定します。', 6, 0, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'デフォルトの言語', 'DEFAULT_LANGUAGE', 'ja', 'デフォルトの言語を設定します。', 6, 0, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '新規注文のデフォルトステータス', 'DEFAULT_ORDERS_STATUS_ID', '1', '新規の注文を受け付けたときのデフォルトステータスを設定します。', 6, 0, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '管理画面で設定キー(configuration_key)を表示', 'ADMIN_CONFIGURATION_KEY_ON', '1', '管理画面で設定キー(configuration_key)を表示しますか?<br />\r\n表示したい場合は1に設定してください。', 6, 0, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '出荷国名', 'SHIPPING_ORIGIN_COUNTRY', '107', '配送料の計算に利用するための国名を選択します。', 7, 1, NULL, now(), 'zen_get_country_name', 'zen_cfg_pull_down_country_list(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ショップの郵便番号', 'SHIPPING_ORIGIN_ZIP', '7210971', 'ショップの郵便番号を入力します。', 7, 2, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '一回の配送で配送可能な最大重量(kg)', 'SHIPPING_MAX_WEIGHT', '50', '一回の配送で可能な重量(kg)の最大値を設定します。例えば10kgに設定した状態でカートに30kgの商品があった場合、10kg × 3回の配送という形で処理されます。', 7, 3, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '小・中パッケージの風袋 - 比率・重量', 'SHIPPING_BOX_WEIGHT', '0:0', '『一回の配送で配送可能な最大重量(kg) 』以内の標準的な小・中パッケージの際に商品重量に加算する梱包材の重量を”商品重量との比率”+”指定重量”で指定します。<br>\r\n例：<br>\r\n商品重量の10% +　1kg = 10:1<br>\r\n商品重量とは関係なく + 5kg = 0:5<br>\r\n梱包重量は加算しない　＝ 0:0', 7, 4, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '大型パッケージの風袋 - 大きさ・重量', 'SHIPPING_BOX_PADDING', '10:0', '『一回の配送で配送可能な最大重量(kg) 』を超える場合の標準的な大パッケージの際に商品重量に加算する梱包材の重量を”商品重量との比率”+”指定重量”で指定します。<br>\r\n例：<br>\r\n商品重量の10% +　1kg = 10:1<br>\r\n商品重量とは関係なく + 5kg = 0:5<br>\r\n梱包重量は加算しない　＝ 0:0', 7, 5, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '個数と重量の表示', 'SHIPPING_BOX_WEIGHT_DISPLAY', '3', '配送する荷物の個数と重量を表示するかどうかを設定します。<br /><br />\r\n・0= off<br />\r\n・1= 個数のみ表示<br />\r\n・2= 重量のみ表示<br />\r\n・3= 両方表示', 7, 15, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '送料概算表示の表示・非表示', 'SHOW_SHIPPING_ESTIMATOR_BUTTON', '1', '送料概算ボタンの表示するかどうかを設定します。<br />\r\n・0= Off<br />\r\n・1= ショッピングカート上にボタンとして表示', 7, 20, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '納品書にコメントを挿入しますか？', 'ORDER_COMMENTS_INVOICE', '1', '納品書にコメントを挿入するかどうかの設定をします<br />0= 挿入しない<br />1= 注文時のコメントのみ<br />2= 全てのコメント', 7, 25, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '配送表にコメントを挿入しますか？', 'ORDER_COMMENTS_PACKING_SLIP', '1', '配送表にコメントを挿入するかどうかの設定をします<br />0= 挿入しない<br />1= 注文時のコメントのみ<br />2= 全てのコメント', 7, 26, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '注文の重量が0なら送料無料に', 'ORDER_WEIGHT_ZERO_STATUS', '0', '注文の重量が0の場合、送料無料にしますか?\r\n<br />\r\n・0= いいえ<br />\r\n・1= はい<br />\r\n注意：「送料無料」表記をしたい場合には送料無料モジュールを使うことをお勧めします。このオプションは実際に送料無料のときに表示されるだけです。', 7, 15, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品イメージの表示', 'PRODUCT_LIST_IMAGE', '1', '検索及びカテゴリ商品一覧ページで表示可能な7つの項目のうち、商品画像の表示・非表示/ソート順を設定します。<br><br>\r\n・数値が小さいほど先（左）に表示<br>\r\n・0 = 非表示', 8, 1, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品メーカーの表示', 'PRODUCT_LIST_MANUFACTURER', '0', '検索及びカテゴリ商品一覧ページで表示可能な7つの項目のうち、商品のメーカー名の表示・非表示/ソート順を設定します。<br><br>\r\n・数値が小さいほど先（左）に表示<br>\r\n・0 = 非表示', 8, 2, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品型番の表示', 'PRODUCT_LIST_MODEL', '0', '検索及びカテゴリ商品一覧ページで表示可能な7つの項目のうち、商品型番の表示・非表示/ソート順を設定します。<br><br>\r\n・数値が小さいほど先（左）に表示<br>\r\n・0 = 非表示', 8, 3, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品名', 'PRODUCT_LIST_NAME', '2', '検索及びカテゴリ商品一覧ページで表示可能な7つの項目のうち、商品名の表示・非表示/ソート順を設定します。<br><br>\r\n・数値が小さいほど先（左）に表示<br>\r\n・0 = 非表示', 8, 4, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品価格・「カートに入れる」を表示', 'PRODUCT_LIST_PRICE', '3', '検索及びカテゴリ商品一覧ページで表示可能な7つの項目のうち、商品価格・「カートに入れる」の表示・非表示/ソート順を設定します。<br><br>\r\n・数値が小さいほど先（左）に表示<br>\r\n・0 = 非表示', 8, 5, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品数量の表示', 'PRODUCT_LIST_QUANTITY', '0', '検索及びカテゴリ商品一覧ページで表示可能な7つの項目のうち、商品数量の表示・非表示/ソート順を設定します。<br><br>\r\n・数値が小さいほど先（左）に表示<br>\r\n・0 = 非表示', 8, 6, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品重量の表示', 'PRODUCT_LIST_WEIGHT', '0', '検索及びカテゴリ商品一覧ページで表示可能な7つの項目のうち、商品重量の表示・非表示/ソート順を設定します。<br><br>\r\n・数値が小さいほど先（左）に表示<br>\r\n・0 = 非表示', 8, 7, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品価格・「カートに入れる」カラムの幅', 'PRODUCTS_LIST_PRICE_WIDTH', '125', '商品価格・「カートに入れる」ボタンを表示するカラムの幅(ピクセル数)を設定します。<br />\r\n・Default= 125', 8, 8, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'カテゴリ/メーカーの絞り込みの表示', 'PRODUCT_LIST_FILTER', '1', 'カテゴリ一覧ページで [絞り込み] を表示するかどうかを設定します。<br />\r\n・0=非表示<br />\r\n・1=表示', 8, 9, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '[前ページ] [次ページ] の表示位置', 'PREV_NEXT_BAR_LOCATION', '3', '[前ページ] [次ページ] の表示位置を設定します。<br /><br />\r\n・1 = 上<br />\r\n・2 = 下<br />\r\n・3 = 両方', 8, 10, NULL, now(), NULL, 'zen_cfg_select_option(array(''1'', ''2'', ''3''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品リストのデフォルトソート順', 'PRODUCT_LISTING_DEFAULT_SORT_ORDER', '', '商品リストのデフォルトの並び順を設定します。<br />\r\n例）左から2列目に表示されている項目で昇順にする場合 = 2a<br />\r\n　　左から4列目に表示されている項目で降順にする場合 = 4d\r\n<br />\r\n注意：商品毎に設定した sortを有効にする場合は空欄にしてください。', 8, 15, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「カートに入れる」ボタンの表示', 'PRODUCT_LIST_PRICE_BUY_NOW', '1', '商品リストページから商品を直接カートに入れることが出来るかどうかを設定します。<br>\r\n※　表示内容は直下の項目の設定に準じます。<br>\r\n・0= 非表示<br>\r\n・1= ボタンのみ表示（数量1固定）<br>\r\n・2= 数量欄とボタンを表示', 8, 20, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '複数商品の数量欄の有無・表示位置', 'PRODUCT_LISTING_MULTIPLE_ADD_TO_CART', '3', '複数商品をカートに入れる数量欄を表示するかどうかと、「カートに入れる」ボタンの表示位置を設定します。<br>\r\n0= off<br>\r\n1= 上部<br>\r\n2= 下部<br>\r\n3= 両方<br><br>\r\n※　0　にすると商品毎に「今すぐ購入」ボタンが表示されます。', 8, 25, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品説明の表示', 'PRODUCT_LIST_DESCRIPTION', '150', '商品説明よりプレビュー表示する文字数を指定します。説明文の文頭より指定された文字数分だけが表示されます。<br />\r\n0 を指定すると非表示になります。', 8, 30, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品リストの昇順を表示する記号', 'PRODUCT_LIST_SORT_ORDER_ASCENDING', '+', '商品リストの昇順を示す記号は?<br />デフォルト = +', 8, 40, NULL, now(), NULL, 'zen_cfg_textarea_small(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品リストの降順を表示する記号', 'PRODUCT_LIST_SORT_ORDER_DESCENDING', '-', '商品リストの降順を示す記号は?<br />デフォルト = -', 8, 41, NULL, now(), NULL, 'zen_cfg_textarea_small(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品一覧ページ内アルファベットソート', 'PRODUCT_LIST_ALPHA_SORTER', 'false', '商品一覧ページにアルファベットによるソートを行うドロップダウンを表示しますか？<br><strong>注意！！</strong>マルチバイト商品に対しては機能しません', 8, 50, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品一覧でカテゴリイメージを表示', 'PRODUCT_LIST_CATEGORIES_IMAGE_STATUS', 'true', 'カテゴリ内商品一覧でカテゴリ画像を表示しますか', 8, 52, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'サブカテゴリ一覧でトップサブカテゴリ画像を表示', 'PRODUCT_LIST_CATEGORIES_IMAGE_STATUS_TOP', 'true', 'トップサブカテゴリ（サブカテゴリを含むカテゴリ）選択時、サブカテゴリ一覧でトップサブカテゴリ画像を表示しますか', 8, 53, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'サブカテゴリ一覧表示', 'PRODUCT_LIST_CATEGORY_ROW_STATUS', '1', 'トップサブカテゴリ（サブカテゴリを含むカテゴリ）選択時、サブカテゴリを一覧表示しますか。\r\n<br /><br />0= 表示しない<br />1= 表示する', 8, 60, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '在庫水準のチェック', 'STOCK_CHECK', 'true', '十分な在庫があるかチェックするかどうかを設定します。<br>\r\nTrue にするとカスタマーが在庫数以上の点数をショッピングカートに入れた際に警告を表示します。', 9, 1, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '在庫数からマイナス', 'STOCK_LIMITED', 'true', '受注時点で各在庫数から注文数をマイナスしますか?', 9, 2, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'チェックアウトを許可', 'STOCK_ALLOW_CHECKOUT', 'true', '在庫が不足している場合にチェックアウトを許可しますか?<br><br>\r\nTrue-　「在庫切れ商品はバックオーダーとなります。」のコメントを出しますが、指定の数量で注文が出来ます。<br><br>\r\nfalse-　「おそれいりますが(在庫切れです)印のついた商品のご注文数量を変更お願いいたします。」のコメントを出し、数量を在庫数以内に変更しなければ注文を行うことが出来ません。', 9, 3, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '在庫切れ商品のサイン', 'STOCK_MARK_PRODUCT_OUT_OF_STOCK', '***', '注文時点で商品が在庫切れの場合に顧客へ表示するサインを設定します。', 9, 4, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '在庫の再注文水準', 'STOCK_REORDER_LEVEL', '5', '在庫の再注文が必要になる商品数を設定します。<br>\r\n「メールの設定」で「在庫わずかになったらメール送信」を有効にしていると、注文により在庫数が設定値を下回った際に指定されたアドレスに対して警告メールが送信されます。（管理画面からの変更では動作しません）', 9, 5, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '在庫切れ商品のステータス変更', 'SHOW_PRODUCTS_SOLD_OUT', '0', '商品の在庫がない場合のステータス表示を設定します。<br><br>\r\n0= 商品ステータスをOFFに（商品管理画面の「商品ステータス」項目が「在庫切れ」に変更され、ショップに商品が表示されなくなります）<br>\r\n1= 商品ステータスはONのまま（商品は表示されたままになります）<br><br>\r\n※　ショップでの注文により在庫が引き落とされ、在庫数が0、あるいはマイナスになった際に動作します。管理画面からの数量変更では、自動的にステータスが変更することはありません。', 9, 10, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '在庫切れ商品に「売り切れ」画像表示', 'SHOW_PRODUCTS_SOLD_OUT_IMAGE', '1', '在庫がなくなった商品の場合に「カートへ入れる」ボタンの代わりに「売り切れ」画像を表示しますか?<br /><br />\r\n・0= 表示しない<br />\r\n・1= 表示する', 9, 11, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品数量に指定できる小数点の桁数', 'QUANTITY_DECIMALS', '0', '商品の数量に小数点の利用を許可する桁数を設定します。<br><br>\r\n※　「リボンを1.5メートル」といった注文を許可する場合に利用しますが、商品の数量-価格関連の設定を正しく行っている必要があります。', 9, 15, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ショッピングカート - 「削除」チェックボックス/ボタン', 'SHOW_SHOPPING_CART_DELETE', '3', '「削除」チェックボックス/ボタンの表示について設定します。<br /><br />1= ボタンのみ<br />2= チェックボックスのみ<br />3= ボタン/チェックボックス両方', 9, 20, NULL, now(), NULL, 'zen_cfg_select_option(array(''1'', ''2'', ''3''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ショッピングカート -「カートの中身を更新」ボタンの位置', 'SHOW_SHOPPING_CART_UPDATE', '3', '「カートの中身を更新」ボタンの位置を設定します。<br /><br />1=「注文数」欄の横<br />2= 商品リストの下<br />3=「注文数」欄の横と商品リストの下<br /><br />注意：この設定は3つの"tpl_shopping_cart_default"ファイルが呼ばれる部分を設定します。', 9, 22, NULL, now(), NULL, 'zen_cfg_select_option(array(''1'', ''2'', ''3''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ショッピングカートページでの新着商品表示設定', 'SHOW_SHOPPING_CART_EMPTY_NEW_PRODUCTS', '1', 'カート内が空の状態でショッピングカート内ページに移行してきた時に新着情報を表示しますか？<br />0= 非表示<br />それ以外= ソート順', 9, 30, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ショッピングカートページでのおすすめ商品表示設定', 'SHOW_SHOPPING_CART_EMPTY_FEATURED_PRODUCTS', '2', 'カート内が空の状態でショッピングカート内ページに移行してきた時におすすめ情報を表示しますか？<br />0= 非表示<br />それ以外= ソート順', 9, 31, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ショッピングカートページでの特価商品表示設定', 'SHOW_SHOPPING_CART_EMPTY_SPECIALS_PRODUCTS', '3', 'カート内が空の状態でショッピングカート内ページに移行してきた時に特価情報を表示しますか？<br />0= 非表示<br />それ以外= ソート順', 9, 32, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ショッピングカートページでの入荷情報表示設定', 'SHOW_SHOPPING_CART_EMPTY_UPCOMING', '4', 'カート内が空の状態でショッピングカート内ページに移行してきた時に入荷情報を表示しますか？<br />0= 非表示<br />それ以外= ソート順', 9, 33, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ログイン時カート内情報通知', 'SHOW_SHOPPING_CART_COMBINED', '1', '顧客がログインした際に、前回ログイン時にカート内に商品が存在した際にどのように通知しますか？<br /><br />0= 通知しない<br />1= メッセージを表示してショッピングカートページへ移動する<br />2= メッセージは表示するがショッピングカートへは移動しない', 9, 35, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'パースタイムログ', 'STORE_PAGE_PARSE_TIME', 'false', 'ページのパースに要した時間をログに記録するかどうかを設定します。', 10, 1, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'パースログ保存ディレクトリ', 'STORE_PAGE_PARSE_TIME_LOG', '', 'ページのパースログを保存するディレクトリとファイル名を設定します。', 10, 2, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ログの日付形式', 'STORE_PARSE_DATE_TIME_FORMAT', '%d/%m/%Y %H:%M:%S', 'ログに記録する日付形式を設定します。', 10, 3, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'パースタイムの表示', 'DISPLAY_PAGE_PARSE_TIME', 'true', '各ページの下にパース時間を表示するかどうかを設定します。<br />「ページのパース時間を記録」を true にしておく必要はありません。', 10, 4, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'データベースクエリーの記録(PHP4の場合のみ)', 'STORE_DB_TRANSACTIONS', 'false', 'ログにデータベースクエリーを記録しておくかどうか設定します。(PHP4の場合のみ)', 10, 5, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メール送信 - 接続方法', 'EMAIL_TRANSPORT', 'PHP', 'メール送信にsendmailへのローカル接続を使用するかTCP/IP経由のSMTP接続を使用するかを設定します。サーバのOSがWindowsやMacOSの場合はSMTPに設定してください。<br /><br />SMTPAUTHは、サーバーがメール送信の際にSMTP authorizationを求める場合にのみ使ってください。その場合、管理画面でSMTPAUTH設定を行う必要があります。<br /><br />"Sendmail -f"は、-fパラメータが必要なサーバ向けの設定で、スプーフィングを防ぐために用いられることが多いセキュリティ上の設定です。メールサーバーのホスト側で使用可能な設定になっていない場合、エラーになることがあります。', 12, 1, NULL, now(), NULL, 'zen_cfg_select_option(array(''PHP'', ''sendmail'', ''sendmail-f'', ''smtp'', ''smtpauth'', ''Qmail''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'SMTP認証 - メールアカウント', 'EMAIL_SMTPAUTH_MAILBOX', 'YourEmailAccountNameHere', 'あなたのホスティングサービスが提供しているメールアカウント(例：me@mydomain.com)を入力してください。これはSMTP認証に必要な情報です。<br />メールにSMTP認証を使っている場合にのみ必要です。', 12, 101, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'SMTP認証 - パスワード', 'EMAIL_SMTPAUTH_PASSWORD', 'YourPasswordHere', 'SMTPメールボックスのパスワードを入力してください。<br />メールにSMTP認証を使っている場合にのみ必要です。', 12, 101, NULL, now(), 'zen_cfg_password_display', NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'SMTP認証 - DNS名', 'EMAIL_SMTPAUTH_MAIL_SERVER', 'mail.EnterYourDomain.com', 'SMTPメールサーバのDNS名を入力してください。<br />例：mail.mydomain.com or 55.66.77.88<br />メールにSMTP認証を使っている場合にのみ必要です。', 12, 101, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'SMTP認証 - IPポート番号', 'EMAIL_SMTPAUTH_MAIL_SERVER_PORT', '25', 'SMTPメールサーバが運用されているIPポート番号を入力してください。<br />メールにSMTP認証を使っている場合にのみ必要です。', 12, 101, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'テキストメールでの貨幣の変換', 'CURRENCIES_TRANSLATIONS', '&pound;,￡:&euro;,?', 'テキスト形式のメールに、どんな貨幣の変換が必要ですか?<br />Default = &amp;pound;,￡:&amp;euro;,EUR', 12, 120, NULL, now(), NULL, 'zen_cfg_textarea_small(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メールの改行コード', 'EMAIL_LINEFEED', 'LF', 'メールヘッダを区切るのに使用する改行コードを指定します。', 12, 2, NULL, now(), NULL, 'zen_cfg_select_option(array(''LF'', ''CRLF''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メール送信にMIME HTMLを使用', 'EMAIL_USE_HTML', 'false', 'メールをHTML形式で送信するかどうかを設定します。', 12, 3, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メールアドレスをDNSで確認', 'ENTRY_EMAIL_ADDRESS_CHECK', 'false', 'メールアドレスをDNSサーバに問い合わせ確認するかどうかを設定します。', 6, 6, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メールを送信', 'SEND_EMAILS', 'true', 'E-Mailを外部に送信するかどうかを設定します。', 12, 5, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メール保存の設定', 'EMAIL_ARCHIVE', 'false', '送信済みのメールを保存しておく場合はtrueを設定してください。', 12, 6, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メール送信エラーの表示', 'EMAIL_FRIENDLY_ERRORS', 'true', 'メール送信が失敗した際、ひと目でわかるエラーを表示しますか? 運営中のショップではtrueに設定することを勧めます。falseに設定するとPHPのエラーメッセージを表示されるので、トラブル解決のヒントになります。', 12, 7, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メールアドレス (ショップに表示する問い合わせ先)', 'STORE_OWNER_EMAIL_ADDRESS', 'root@localhost', 'ショップオーナーのメールアドレスとしてサイト上で表示されるアドレスを設定します。', 12, 10, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メールアドレス (顧客への送信元)', 'EMAIL_FROM', 'root@localhost', '顧客に送信されるメールのデフォルトの送信元として表示されるアドレスを設定します。\r\n顧客からの返信メールはこちらのアドレスに届くようになります。<br><br>\r\n管理画面でメールを作成をする都度、書き換えることもできます。', 12, 11, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '送信メールの送信元アドレスの実在性', 'EMAIL_SEND_MUST_BE_STORE', 'Yes', 'お使いのメールサーバでは、送信するメールの送信元(From)アドレスがWebサーバ上に実在することが必須ですか?<br /><br />spam送信を防止するなどのためにこのように設定されていることがあります。Yesに設定すると、送信元アドレスとメール内のFromアドレスが一致していることが求められます。', 12, 11, NULL, now(), NULL, 'zen_cfg_select_option(array(''No'', ''Yes''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '管理者が送信するメールフォーマット', 'ADMIN_EXTRA_EMAIL_FORMAT', 'TEXT', '管理者が送付するメールフォーマットを設定します。<br /><br />\r\n・TEXT =テキスト形式<br />\r\n・HTML =HTML形式', 12, 12, NULL, now(), NULL, 'zen_cfg_select_option(array(''TEXT'', ''HTML''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '注文確認メール(コピー)送信先', 'SEND_EXTRA_ORDER_EMAILS_TO', 'root@localhost', '顧客に送信される注文確認メールのコピーを送付するメールアドレスを設定します。<br />記入例: 名前1 &lt;email@address1&gt;, 名前2 &lt;email@address2&gt;', 12, 12, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'アカウント作成完了メール(コピー)の送信', 'SEND_EXTRA_CREATE_ACCOUNT_EMAILS_TO_STATUS', '0', 'アカウント作成完了メールのコピーを指定のメールアドレスに送信しますか?<br /><br />\r\n・0= off<br />\r\n・1= on', 12, 13, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'アカウント作成完了メール(コピー)の送信先', 'SEND_EXTRA_CREATE_ACCOUNT_EMAILS_TO', 'root@localhost', 'アカウント作成完了メールのコピーを送信するメールアドレスを設定します。<br /><br />\r\n記入例： 名前1 &lt;email@address1&gt;, 名前2 &lt;email@address2&gt;', 12, 14, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「友達に知らせる」メール(コピー)の送信', 'SEND_EXTRA_TELL_A_FRIEND_EMAILS_TO_STATUS', '0', '「友達に知らせる」メールのコピーを送信しますか?<br />0= off 1= on', 12, 15, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「友達に知らせる」メール(コピー)の送信先', 'SEND_EXTRA_TELL_A_FRIEND_EMAILS_TO', 'root@localhost', '「友達に知らせる」メールのコピーを送信するメールアドレスを設定します。記入例: 名前1 &lt;email@address1&gt;, 名前2 &lt;email@address2&gt;', 12, 16, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ギフト券送付メール(コピー)の送信', 'SEND_EXTRA_GV_CUSTOMER_EMAILS_TO_STATUS', '0', '顧客が送付するギフト券送付メールのコピーを送信しますか?<br /><br />\r\n・0= off<br />\r\n・1= on', 12, 17, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ギフト券送付メール(コピー)の送信先', 'SEND_EXTRA_GV_CUSTOMER_EMAILS_TO', 'root@localhost', '顧客が送付するギフト券送付メールのコピーを送信するメールアドレスを設定します。<br /><br />記入例： 名前1 &lt;email@address1&gt;, 名前2&lt;email@address2&gt;', 12, 18, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ショップ運営者からのギフト券送付メール(コピー)の送信', 'SEND_EXTRA_GV_ADMIN_EMAILS_TO_STATUS', '0', 'ショップ運営者からのギフト券送付メールのコピーを送信しますか?<br /><br />\r\n・0= off<br />\r\n・1= on', 12, 19, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ショップ運営者からのギフト券送付メール(コピー)の送信先', 'SEND_EXTRA_GV_ADMIN_EMAILS_TO', 'root@localhost', 'ショップ運営者からのギフト券送付メールのコピーを送信するメールアドレスを設定します。<br /><br />\r\n記入例：名前1 &lt;email@address1&gt;, 名前2 &lt;email@address2&gt;', 12, 20, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ショップ運営者からのクーポン券送付メール(コピー)の送信', 'SEND_EXTRA_DISCOUNT_COUPON_ADMIN_EMAILS_TO_STATUS', '0', 'ショップ運営者からのクーポン券送付メールのコピーを送信しますか?<br />0= off 1= on', 12, 21, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ショップ運営者からのクーポン券送付メール(コピー)の送信先', 'SEND_EXTRA_DISCOUNT_COUPON_ADMIN_EMAILS_TO', 'root@localhost', 'ショップ運営者からのクーポン券送付メールのコピーを送信するメールアドレスを設定します。<br /><br />\r\n記入例： 名前1 &lt;email@address1&gt;, 名前2 &lt;email@address2&gt;', 12, 22, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ショップ運営者の注文ステータスメール(コピー)の送信', 'SEND_EXTRA_ORDERS_STATUS_ADMIN_EMAILS_TO_STATUS', '0', 'ショップ運営者の注文ステータスメールのコピーを送信しますか?<br /><br />\r\n・0= off<br />\r\n・1= on', 12, 23, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ショップ運営者の注文ステータスメール(コピー)の送信先', 'SEND_EXTRA_ORDERS_STATUS_ADMIN_EMAILS_TO', 'root@localhost', 'ショップ運営者の注文ステータスメールのコピーを送信するメールアドレスを設定します。<br /><br />\r\n記入例： 名前1 &lt;email@address1&gt;, 名前2 &lt;email@address2&gt;', 12, 24, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '掲載待ちレビューについてメール送信', 'SEND_EXTRA_REVIEW_NOTIFICATION_EMAILS_TO_STATUS', '0', '掲載待ちのレビューについてメールを送信しますか?<br />0= off 1= on', 12, 25, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '掲載待ちレビューについてのメール送信先', 'SEND_EXTRA_REVIEW_NOTIFICATION_EMAILS_TO', 'root@localhost', '掲載待ちのレビューについてのメールを送信するアドレスを設定します。<br />フォーマット：Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;', 12, 26, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「お問い合わせ」メールのドロップダウン設定', 'CONTACT_US_LIST', '', '「お問い合わせ」ページで、メールアドレスのリストを設定し、ドロップダウンリストとして表示できます。<br />\r\nフォーマット：Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;', 12, 40, NULL, now(), NULL, 'zen_cfg_textarea(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ゲストに「友達に知らせる」機能を許可', 'ALLOW_GUEST_TO_TELL_A_FRIEND', 'false', 'ゲスト(未登録ユーザ)に「友達に知らせる」機能を許可するかどうかを設定します。 <br />[false]に設定すると、この機能を利用しようとした際にログインを促します。', 12, 50, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「お問い合わせ」にショップ名と住所を表記', 'CONTACT_US_STORE_NAME_ADDRESS', '1', '「お問い合わせ」画面にショップ名と住所を表記するかどうかを設定します。<br /><br />\r\n・0= off<br />\r\n・1= on', 12, 50, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '在庫わずかになったらメール送信', 'SEND_LOWSTOCK_EMAIL', '0', '商品の在庫が水準を下回った際にメールを送信するかどうかを設定します。<br>\r\n注文により在庫数が「在庫の設定」の「在庫の再注文水準」の設定値を下回った際に、指定されたアドレスに対して警告メールが送信されます。（管理画面からの変更では動作しません）<br />\r\n・0= off<br />\r\n・1= on', 12, 60, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '在庫わずかになった際のメール送信先', 'SEND_EXTRA_LOW_STOCK_EMAILS_TO', 'root@localhost', '商品の在庫が水準を下回った際にメールを送信するアドレスを設定します。複数設定することができます。<br />\r\nフォーマット：Name 1 &lt;email@address1&gt;, Name 2 &lt;email@address2&gt;', 12, 61, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「メールマガジンの購読解除」リンクの表示', 'SHOW_NEWSLETTER_UNSUBSCRIBE_LINK', 'true', '「メールマガジンの購読解除」リンクをインフォメーションサイドボックスに表示しますか?', 12, 70, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メール受信者数の表示設定', 'AUDIENCE_SELECT_DISPLAY_COUNTS', 'true', '「管理画面」内のメール送信画面で送信先の選択リストを表示する際に、メールグループ内のユーザー数を表示しますか？<br /><br />\r\n【注意】この設定をtrueにすると、顧客数が多い場合に表示が遅くなるかもしれません。', 12, 90, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ダウンロードを有効にする', 'DOWNLOAD_ENABLED', 'true', '商品のダウンロード機能を設定します。', 13, 1, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'リダイレクトでダウンロード画面へ', 'DOWNLOAD_BY_REDIRECT', 'true', 'ダウンロードの際にブラウザによるリダイレクト(転送)を可能にするかどうかを設定します。<br />\r\nUNIX系でないサーバではオフにしてください。\r\n<br />注意：この設定をオンにしたら、/pub ディレクトリのパーミッションを777にしてください。', 13, 2, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ストリーミングによるダウンロード', 'DOWNLOAD_IN_CHUNKS', 'false', '「リダイレクトでダウンロード」がオフで、かつPHP memory_limit設定が8MB以下の場合、この設定をオンにしてください。ストリーミングで、より小さな単位でのファイル転送を行うためです。<br /><br />「リダイレクトでダウンロード」がオンの場合、効果はありません。', 13, 2, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ダウンロードの有効期限(日数)', 'DOWNLOAD_MAX_DAYS', '7', 'ダウンロードリンクの有効期間の日数を設定します。<br /><br />\r\n・0 = 無期限', 13, 3, NULL, now(), NULL, '');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ダウンロード可能回数(商品ごと)', 'DOWNLOAD_MAX_COUNT', '5', 'ダウンロードできる回数の最大値を設定します。<br /><br />\r\n・0 = ダウンロード不可', 13, 4, NULL, now(), NULL, '');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ダウンロード設定 - 注文状況による更新', 'DOWNLOADS_ORDERS_STATUS_UPDATED_VALUE', '4', 'orders_statusによるダウンロードの有効期限・可能回数のリセットについて設定します。<br />デフォルト = 4', 13, 10, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ダウンロード可能となる注文ステータスのID - デフォルト >= 2', 'DOWNLOADS_CONTROLLER_ORDERS_STATUS', '2', 'ダウンロード可能となる注文ステータスのID - デフォルト >= 2<br /><br />注文ステータスのIDがこの値より高い注文はダウンロード可能になります。購入完了時の注文ステータスは支払いモジュールに毎に設定されます。', 13, 12, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ダウンロード終了となる注文ステータスのID', 'DOWNLOADS_CONTROLLER_ORDERS_STATUS_END', '4', 'ダウンロード終了となる注文ステータスのID - デフォルト >= 4<br /><br />注文ステータスがこの値より高い注文はダウンロードが終了となります。', 13, 13, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'プライスファクター属性を有効にする', 'ATTRIBUTES_ENABLED_PRICE_FACTOR', 'true', '「商品オプション属性の管理」でプライスファクター属性を利用可能にするかどうかを設定します。<br>\r\n注意：無効にすると、既存の設定値がクリアされます。', 13, 25, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '数量割引属性のオン/オフ', 'ATTRIBUTES_ENABLED_QTY_PRICES', 'true', '「商品価格の管理」」で 「数量割引」属性を利用するかどうかを設定します。<br>\r\n注意：無効にすると、既存の設定値がクリアされます。', 13, 26, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'イメージ属性のオン/オフ', 'ATTRIBUTES_ENABLED_IMAGES', 'true', '「商品オプション属性の管理」画面で、オプション画像の登録を利用可能にするかどうかを設定します。<br>\r\n注意：　オフにしてもそれまでに設定した情報はクリアされません。', 13, 28, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '(言葉・文字による)テキストによる価格設定のオン/オフ', 'ATTRIBUTES_ENABLED_TEXT_PRICES', 'true', '「商品オプション属性の管理」画面で、入力されたテキストによる「単語毎の価格 」「文字毎の価格」設定を利用可能にするかどうかを設定します。<br>\r\n注意：　オフにしてもそれまでに設定した情報はクリアされません。', 13, 35, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'テキストによる価格設定 - 空欄の場合は無料', 'TEXT_SPACES_FREE', '1', 'テキストによる価格設定の場合、空欄のままなら無料にするかどうかを設定します。<br>\r\nOFF の場合、未入力の際に入力を促す警告が表示されます。<br>\r\n・0= off<br />\r\n・1= on', 13, 36, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'Read Only属性の商品 -「カートに入れる」ボタンの表示', 'PRODUCTS_OPTIONS_TYPE_READONLY_IGNORED', '1', 'READONLY属性だけが設定された商品に「カートに入れる」ボタンを表示しますか?<br />0= OFF<br />1= ON', 13, 37, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'GZip圧縮を使用する', 'GZIP_LEVEL', '0', 'HTTP通信にGZip圧縮を使用してページを転送しますか?<br /><br />\r\n・0= off<br />\r\n・1= on', 14, 1, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'セッション情報保存ディレクトリ', 'SESSION_WRITE_DIRECTORY', '', 'セッション管理がファイルベースの場合に保存するディレクトリを設定します。', 15, 1, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'クッキーに保存するドメイン名の設定', 'SESSION_USE_FQDN', 'True', 'クッキーに保存するドメイン名について設定します。<br /><br />\r\n\r\n・True = ドメインネーム全体をクッキーに保存(例：www.mydomain.com)<br />\r\n・False = ドメインネームの一部を保存(例：mydomain.com)。<br />\r\nよくわからない場合はこの設定はTrueにしておいてください。', 15, 2, NULL, now(), NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'クッキー使用', 'SESSION_FORCE_COOKIE_USE', 'True', 'セッションに必ずクッキーを利用します。True指定するとブラウザのクッキーがオフになっている場合はセッションを開始しません。セキュリティ上の理由から余程の理由のない限りはTrue指定のままとすることを強く推奨します。', 15, 2, NULL, now(), NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'SSLセッションIDチェック', 'SESSION_CHECK_SSL_SESSION_ID', 'False', '全てのHTTPSリクエストでSSLセッションIDをチェックしますか?', 15, 3, NULL, now(), NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'User Agentチェック', 'SESSION_CHECK_USER_AGENT', 'True', '全てのリクエスト時にUser Agentのチェックを行いますか?', 15, 4, NULL, now(), NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'IPアドレスチェック', 'SESSION_CHECK_IP_ADDRESS', 'False', '全てのリクエスト時にIPアドレスをチェックしますか?', 15, 5, NULL, now(), NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ロボット(スパイダー)のセッションを防止', 'SESSION_BLOCK_SPIDERS', 'True', '既知のロボット(スパイダー)がセッションを開始することを防止しますか?', 15, 6, NULL, now(), NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'セッション再発行', 'SESSION_RECREATE', 'True', 'ユーザーがログオンまたはアカウントを作成した場合にセッションを再発行しますか?<br />(PHP4.1以上が必要)', 15, 7, NULL, now(), NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'IPアドレス変換の設定', 'SESSION_IP_TO_HOST_ADDRESS', 'true', 'IPアドレスをホストアドレスに変換しますか?<br /><br />注意：サーバによっては、この設定でメール送信のスタート・終了が遅くなることがあります。', 15, 10, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ギフト/クーポン券コードの長さ', 'SECURITY_CODE_LENGTH', '10', 'ギフト/クーポン券コードの長さを設定します。<br /><br />\r\n注意：コードが長いほど安全です。', 16, 1, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '差引残高0の場合の注文ステータス', 'DEFAULT_ZERO_BALANCE_ORDERS_STATUS_ID', '2', '注文の差引残高が0の場合に適用される注文ステータスを設定します。', 16, 0, NULL, now(), 'zen_get_order_status_name', 'zen_cfg_pull_down_order_statuses(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '会員登録時のウェルカムクーポン券プレゼント', 'NEW_SIGNUP_DISCOUNT_COUPON', '', '会員登録時にその会員に対して自動発行するクーポン券を選択してください。', 16, 75, NULL, now(), NULL, 'zen_cfg_select_coupon_id(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '会員登録時のウェルカムギフト券プレゼント金額', 'NEW_SIGNUP_GIFT_VOUCHER_AMOUNT', '', '会員登録時にその会員に対して自動発行するギフト券の金額を入力してください。', 16, 76, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'クーポン券のページあたり最大表示件数', 'MAX_DISPLAY_SEARCH_RESULTS_DISCOUNT_COUPONS', '20', 'クーポン券の1ページあたりの表示件数を設定します。', 16, 81, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'クーポン券レポートのページあたり最大表示件数', 'MAX_DISPLAY_SEARCH_RESULTS_DISCOUNT_COUPONS_REPORTS', '20', 'クーポン券のレポートページでの表示件数を設定します。', 16, 81, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'クレジットカード利用の可否 - VISA', 'CC_ENABLED_VISA', '1', 'VISAを有効にしますか?<br /><br />\r\n・0= off<br />\r\n・1= on', 17, 1, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'クレジットカード利用の可否 - MasterCard', 'CC_ENABLED_MC', '1', 'MasterCardを有効にしますか?<br /><br />\r\n・0= off<br />\r\n・1= on', 17, 2, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'クレジットカード利用の可否 - AmericanExpress', 'CC_ENABLED_AMEX', '0', 'AmericanExpressを有効にしますか?<br /><br />\r\n・0= off<br />\r\n・1= on', 17, 3, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'クレジットカード利用の可否 - Diners Club', 'CC_ENABLED_DINERS_CLUB', '0', 'Diners Clubを有効にしますか?<br /><br />\r\n・0= off<br />\r\n・1= on', 17, 4, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'クレジットカード利用の可否 - Discover Card', 'CC_ENABLED_DISCOVER', '0', 'Discover Cardを有効にしますか?<br /><br />\r\n・0= off<br />\r\n・1= on', 17, 5, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'クレジットカード利用の可否 - JCB', 'CC_ENABLED_JCB', '0', 'JCBを有効にしますか?<br /><br />\r\n・0= off<br />\r\n・1= on', 17, 6, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'クレジットカード利用の可否 - AUSTRALIAN BANKCARD', 'CC_ENABLED_AUSTRALIAN_BANKCARD', '0', 'AUSTRALIAN BANKCARDを有効にしますか?<br /><br />\r\n・0= off<br />\r\n・1= on', 17, 7, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'クレジットカード利用の可否 - SOLO', 'CC_ENABLED_SOLO', '0', 'SOLOを有効にしますか?<br />0= off <br />1= on', 17, 8, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'クレジットカード利用の可否 - Switch', 'CC_ENABLED_SWITCH', '0', 'Switch を有効にしますか? <br />0= off <br />1= on', 17, 9, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'クレジットカード利用の可否 - Maestro', 'CC_ENABLED_MAESTRO', '0', 'MAESTRO Card を有効にしますか?<br />0= off <br />1= on', 17, 10, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '利用可能なクレジットカード - 支払いページに表示', 'SHOW_ACCEPTED_CREDIT_CARDS', '0', '利用可能なクレジットカードを支払いページに表示しますか?<br /><br />\r\n・0= off<br />\r\n・1= テキストを表示<br />\r\n・2= 画像を表示<br />\r\n【注意】クレジットカードの画像とテキストは、データベースとランゲージファイル内で定義されている必要があります。', 17, 50, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'インストール状態', 'MODULE_ORDER_TOTAL_GV_STATUS', 'true', '', 6, 1, NULL, now(), NULL, 'zen_cfg_select_option(array(''true''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '表示の整列順', 'MODULE_ORDER_TOTAL_GV_SORT_ORDER', '840', '表示の整列順を設定します。<br />数字が小さいほど上位に表示されます。', 6, 2, NULL, '2003-10-30 22:16:40', NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '購入待ち行列', 'MODULE_ORDER_TOTAL_GV_QUEUE', 'true', 'ギフト券購入を承認待ちリストに追加しますか?', 6, 3, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '送料を含める', 'MODULE_ORDER_TOTAL_GV_INC_SHIPPING', 'true', '合計計算に送料を含めますか?', 6, 5, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '税金を含める', 'MODULE_ORDER_TOTAL_GV_INC_TAX', 'true', '計算時に税金を含めるかどうかを設定します。', 6, 6, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '税金を再計算する', 'MODULE_ORDER_TOTAL_GV_CALC_TAX', 'None', '税金を再計算しますか?', 6, 7, NULL, now(), NULL, 'zen_cfg_select_option(array(''None'', ''Standard'', ''Credit Note''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '税種別', 'MODULE_ORDER_TOTAL_GV_TAX_CLASS', '0', 'ギフト券に適用される税種別を設定します。', 6, 0, NULL, now(), 'zen_get_tax_class_title', 'zen_cfg_pull_down_tax_classes(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ギフト券に税金を付加する', 'MODULE_ORDER_TOTAL_GV_CREDIT_TAX', 'false', 'ギフト券を計算する際に税金を付加しますか?', 6, 8, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '注文ステータス', 'MODULE_ORDER_TOTAL_GV_ORDER_STATUS_ID', '0', 'ギフト券で全額支払いを行った場合の注文ステータスを設定します。', 6, 0, NULL, now(), 'zen_get_order_status_name', 'zen_cfg_pull_down_order_statuses(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'インストール状態', 'MODULE_ORDER_TOTAL_LOWORDERFEE_STATUS', 'true', '', 6, 1, NULL, now(), NULL, 'zen_cfg_select_option(array(''true''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '表示の整列順', 'MODULE_ORDER_TOTAL_LOWORDERFEE_SORT_ORDER', '400', '表示の整列順を設定します。数字が小さいほど上位に表示されます。', 6, 2, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '低額商品取扱い手数料設定', 'MODULE_ORDER_TOTAL_LOWORDERFEE_LOW_ORDER_FEE', 'false', '低額商品取扱い手数料設定を有効にしますか?', 6, 3, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '取扱い手数料を課金する注文金額', 'MODULE_ORDER_TOTAL_LOWORDERFEE_ORDER_UNDER', '50', 'この注文金額未満の場合、手数料を課金します。', 6, 4, NULL, now(), 'currencies->format', NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '低額商品取扱い手数料金額', 'MODULE_ORDER_TOTAL_LOWORDERFEE_FEE', '5', '手数料を設定します。<br /><br />\r\n率(%)で計算する場合には「10%」などと記入し、固定の場合には「500」(500円)などと記入します。', 6, 5, NULL, now(), '', NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '低額商品取扱い手数料を適用する地域の設定', 'MODULE_ORDER_TOTAL_LOWORDERFEE_DESTINATION', 'both', '設定した地域に対して低額商品取扱い手数料が適用されます。', 6, 6, NULL, now(), NULL, 'zen_cfg_select_option(array(''national'', ''international'', ''both''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '税種別', 'MODULE_ORDER_TOTAL_LOWORDERFEE_TAX_CLASS', '0', '低額商品取扱い手数料金額に適用される税種別を設定します。', 6, 7, NULL, now(), 'zen_get_tax_class_title', 'zen_cfg_pull_down_tax_classes(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ヴァーチャル商品だけの注文には適応しない', 'MODULE_ORDER_TOTAL_LOWORDERFEE_VIRTUAL', 'false', 'カート内がヴァーチャル商品だけの際に、低額商品取扱い手数料を徴収するかどうかを設定します。', 6, 8, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ヴァーチャルギフト券だけの注文には適応しない', 'MODULE_ORDER_TOTAL_LOWORDERFEE_GV', 'false', 'カート内がギフト券などだけのときに低額商品取扱い手数料を徴収するかどうかを設定します。', 6, 9, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'インストール状態', 'MODULE_ORDER_TOTAL_SHIPPING_STATUS', 'true', '', 6, 1, NULL, now(), NULL, 'zen_cfg_select_option(array(''true''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '表示の整列順', 'MODULE_ORDER_TOTAL_SHIPPING_SORT_ORDER', '200', '表示の整列順を設定できます. 数字が小さいほど上位に表示されます。', 6, 2, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '送料無料設定', 'MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING', 'false', '送料無料設定を有効にしますか？', 6, 3, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '送料を無料にする購入金額設定', 'MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING_OVER', '50', '設定金額以上のご購入の場合は送料を無料にします。', 6, 4, NULL, now(), 'currencies->format', NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '送料無料を適用する地域の設定', 'MODULE_ORDER_TOTAL_SHIPPING_DESTINATION', 'national', '設定した地域に対して送料無料を適用します。', 6, 5, NULL, now(), NULL, 'zen_cfg_select_option(array(''national'', ''international'', ''both''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'インストール状態', 'MODULE_ORDER_TOTAL_SUBTOTAL_STATUS', 'true', '', 6, 1, NULL, now(), NULL, 'zen_cfg_select_option(array(''true''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '表示の整列順', 'MODULE_ORDER_TOTAL_SUBTOTAL_SORT_ORDER', '100', '表示の整列順を設定できます. 数字が小さいほど上位に表示されます。', 6, 2, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'インストール状態', 'MODULE_ORDER_TOTAL_TAX_STATUS', 'true', '', 6, 1, NULL, now(), NULL, 'zen_cfg_select_option(array(''true''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '表示の整列順', 'MODULE_ORDER_TOTAL_TAX_SORT_ORDER', '300', '表示の整列順を設定できます. 数字が小さいほど上位に表示されます。', 6, 2, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '合計の表示', 'MODULE_ORDER_TOTAL_TOTAL_STATUS', 'true', '', 6, 1, NULL, now(), NULL, 'zen_cfg_select_option(array(''true''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '表示の整列順', 'MODULE_ORDER_TOTAL_TOTAL_SORT_ORDER', '999', '表示の整列順を設定できます. 数字が小さいほど上位に表示されます。', 6, 2, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '税種別', 'MODULE_ORDER_TOTAL_COUPON_TAX_CLASS', '0', 'クーポン券に適用される税種別を設定します。', 6, 0, NULL, now(), 'zen_get_tax_class_title', 'zen_cfg_pull_down_tax_classes(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '税金を含める', 'MODULE_ORDER_TOTAL_COUPON_INC_TAX', 'false', '代金計算に税金を含めるかどうかを設定します。', 6, 6, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '表示の整列順', 'MODULE_ORDER_TOTAL_COUPON_SORT_ORDER', '280', '表示の整列順を設定します。', 6, 2, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '送料を含める', 'MODULE_ORDER_TOTAL_COUPON_INC_SHIPPING', 'false', '送料を計算に含めるかどうかを設定します。', 6, 5, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'インストール状態', 'MODULE_ORDER_TOTAL_COUPON_STATUS', 'true', '', 6, 1, NULL, now(), NULL, 'zen_cfg_select_option(array(''true''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '税金の再計算', 'MODULE_ORDER_TOTAL_COUPON_CALC_TAX', 'Standard', '税金を再計算しますか?', 6, 7, NULL, now(), NULL, 'zen_cfg_select_option(array(''None'', ''Standard'', ''Credit Note''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '管理者デモ -オン/オフ', 'ADMIN_DEMO', '0', '管理者デモを有効にするかどうかを設定します。<br /><br />\r\n・0= off<br />\r\n・1= on', 6, 0, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'Product option type Select', 'PRODUCTS_OPTIONS_TYPE_SELECT', '0', 'セレクトボックス型の商品オプションの数値は?', 0, NULL, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品オプション - テキスト型', 'PRODUCTS_OPTIONS_TYPE_TEXT', '1', 'テキスト型の商品オプションの数値は?', 6, NULL, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品オプション - ラジオボタン型', 'PRODUCTS_OPTIONS_TYPE_RADIO', '2', 'ラジオボタン型の商品オプションの数値は?', 6, NULL, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品オプション - チェックボックス型', 'PRODUCTS_OPTIONS_TYPE_CHECKBOX', '3', 'チェックボックス型の商品オプションの数値は?', 6, NULL, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品オプション - ファイル型', 'PRODUCTS_OPTIONS_TYPE_FILE', '4', 'ファイル型の商品オプションの数値は?', 6, NULL, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ID for text and file products options values', 'PRODUCTS_OPTIONS_VALUES_TEXT_ID', '0', 'テキスト型・ファイル型属性のproducts_options_values_idで使われる数値は?', 6, NULL, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'Upload prefix', 'UPLOAD_PREFIX', 'upload_', 'アップロードオプションを他のオプションと区別するために使う接頭辞(Prefix)は?', 0, NULL, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'Text prefix', 'TEXT_PREFIX', 'txt_', 'テキストオプションを他のオプションと区別するために使う接頭辞(Prefix)は?', 0, NULL, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品オプション - READ ONLY型', 'PRODUCTS_OPTIONS_TYPE_READONLY', '5', 'READ ONLY型の商品オプションの数値は?', 6, NULL, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品情報 - 商品オプションのソート順', 'PRODUCTS_OPTIONS_SORT_ORDER', '0', '商品情報における商品オプション名の並び順を設定します。<br><br>\r\n・0= 設定されたソート順とオプション名順<br>\r\n・1= オプション名順', 18, 35, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品情報 - 商品オプション値のソート順', 'PRODUCTS_OPTIONS_SORT_BY_PRICE', '1', '商品情報における商品オプション値の並び順を設定します。<br><br>\r\n・0= 設定されたソート順と価格順<br>\r\n・1= 設定されたソート順とオプション値順', 18, 36, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品の属性画像の下に表示するオプション値', 'PRODUCT_IMAGES_ATTRIBUTES_NAMES', '1', '商品の属性画像の下にオプション名を表示しますか?<br /><br />\r\n・0= off<br />\r\n・1= on', 18, 41, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品情報 - セール割引表示', 'SHOW_SALE_DISCOUNT_STATUS', '1', 'セール割引分を表示しますか?<br /><br />\r\n・0= off<br />\r\n・1= on', 18, 45, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品情報 - セール割引の表示方法(割引額・パーセント)', 'SHOW_SALE_DISCOUNT', '1', 'セール割引幅の表示方法を設定します。<br /><br />\r\n・1= 割引率(%) でのoff<br />\r\n・2= 割引金額 でのoff', 18, 46, NULL, now(), NULL, 'zen_cfg_select_option(array(''1'', ''2''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品情報 - 割引率表示の小数点', 'SHOW_SALE_DISCOUNT_DECIMALS', '0', '割引率表示のパーセントの小数点位置を設定します。<br /><br />\r\n・デフォルト= 0', 18, 47, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品情報 - 無料商品の画像・テキストのステータス', 'OTHER_IMAGE_PRICE_IS_FREE_ON', '1', '商品情報での無料商品の画像・イメージの表示を設定します。<br />\r\n<br />\r\n・0= Text<br />\r\n・1= Image', 18, 50, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品情報 - お問い合わせ商品表示設定', 'PRODUCTS_PRICE_IS_CALL_IMAGE_ON', '1', 'お問い合わせ商品であることを表示する画像またはテキストについて設定します。<br /><br />\r\n・0= テキスト<br />\r\n・1= 画像', 18, 51, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '管理画面 - 新しく商品を追加する際の商品の数量欄デフォルト値', 'PRODUCTS_QTY_BOX_STATUS', '1', '新しい商品の登録画面で、「商品の数量欄の表示:」項目のデフォルト値の設定をします。<br /><br />\r\n・0= off<br />\r\n・1= on<br />\r\n※on の状態で商品登録するとショップの画面ではカートに入れる数量入力欄を表示します。 off の場合は数量入力欄は表示されず「カートに入れる」ボタンだけが表示され、カートには数量＝1で商品が追加されます。', 18, 55, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品レビュー - 承認の要否', 'REVIEWS_APPROVAL', '1', '商品レビューの表示には承認が必要にしますか?<br /><br />\r\n・0= off<br />\r\n・1= on<br />\r\n注意：レビューが非表示設定になっている場合は無視されます。', 18, 62, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'Meta Tags - Include Product Model in Title', 'META_TAG_INCLUDE_MODEL', '1', 'Do you want to include the Product Model in the Meta Tag Title?<br /><br />0= off 1= on', 18, 69, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'METAタグ - TITLEタグへの商品価格表示', 'META_TAG_INCLUDE_PRICE', '1', 'TITLEタグに商品価格を表示しますか?<br />\r\n<br />\r\n・0= off<br />\r\n・1= on', 18, 70, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'METAタグ - Meta Descriptionの長さ', 'MAX_META_TAG_DESCRIPTION_LENGTH', '50', 'Meta Descriptionの最大の長さを設定してください。<br />デフォルトの最大値(ワード数)：50', 18, 71, NULL, now(), '', '');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「こんな商品も購入しています」 - 横列あたりの表示点数', 'SHOW_PRODUCT_INFO_COLUMNS_ALSO_PURCHASED_PRODUCTS', '3', '「こんな商品も買っています」の横列(Row)あたりの表示点数を設定します。<br />0= off またはソート順を設定', 18, 72, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4'', ''5'', ''6'', ''7'', ''8'', ''9'', ''10'', ''11'', ''12''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '[前へ] [次へ] - ナビゲーションバーの位置', 'PRODUCT_INFO_PREVIOUS_NEXT', '1', '[前へ] [次へ] ナビゲーションバーの表示・非表示と表示位置を設定します。', 18, 21, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''0'', ''text''=>''Off''), array(''id''=>''1'', ''text''=>''Top of Page''), array(''id''=>''2'', ''text''=>''Bottom of Page''), array(''id''=>''3'', ''text''=>''Both Top & Bottom of Page'')),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '[前へ] [次へ] - ソート順', 'PRODUCT_INFO_PREVIOUS_NEXT_SORT', '1', '商品のソート順を設定します。\r\n<br />', 18, 22, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''0'', ''text''=>''Product ID''), array(''id''=>''1'', ''text''=>''Name''), array(''id''=>''2'', ''text''=>''Product Model''), array(''id''=>''3'', ''text''=>''Product Price - Name''), array(''id''=>''4'', ''text''=>''Product Price - Model''), array(''id''=>''5'', ''text''=>''Product Name - Model''), array(''id''=>''6'', ''text''=>''Product Sort Order'')),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '[前へ] [次へ] - ボタンと画像のステータス', 'SHOW_PREVIOUS_NEXT_STATUS', '0', '[前へ] [次へ] ボタンと対応する商品画像の表示を設定します。<br />\r\n・0= Off<br />\r\n・1= On', 18, 20, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''0'', ''text''=>''Off''), array(''id''=>''1'', ''text''=>''On'')),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '[前へ] [次へ] - ボタンと画像の表示設定', 'SHOW_PREVIOUS_NEXT_IMAGES', '0', '上部の[前へ] [次へ] - ボタンと画像のステータスの設定の範囲内での設定ができます。', 18, 21, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''0'', ''text''=>''Button Only''), array(''id''=>''1'', ''text''=>''Button and Product Image''), array(''id''=>''2'', ''text''=>''Product Image Only'')),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '[前へ] [次へ] - 画像の横幅', 'PREVIOUS_NEXT_IMAGE_WIDTH', '50', '[前へ] [次へ] で表示される商品画像の横幅の横幅を設定します。', 18, 22, NULL, now(), '', '');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '[前へ] [次へ] - 画像の高さ', 'PREVIOUS_NEXT_IMAGE_HEIGHT', '40', '[前へ] [次へ] 画像の横幅の高さは?', 18, 23, NULL, now(), '', '');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '[前へ] [次へ] - カテゴリ名と画像の配置', 'PRODUCT_INFO_CATEGORIES', '1', '[前へ] [次へ] ナビゲーションの上に表示される カテゴリ画像とカテゴリ名の配置', 18, 20, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''0'', ''text''=>''Off''), array(''id''=>''1'', ''text''=>''Align Left''), array(''id''=>''2'', ''text''=>''Align Center''), array(''id''=>''3'', ''text''=>''Align Right'')),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '[前へ] [次へ] - カテゴリ名と画像の表示設定', 'PRODUCT_INFO_CATEGORIES_IMAGE_STATUS', '2', 'カテゴリの画像とカテゴリ名の表示設定<br />0 = カテゴリ名と画像を常に表示<br />1 = カテゴリ名だけを表示<br />2 = カテゴリ名と対象がある場合だけ画像を表示<br />', 18, 20, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''0'', ''text''=>''Category Name and Image Always''), array(''id''=>''1'', ''text''=>''Category Name only''), array(''id''=>''2'', ''text''=>''Category Name and Image when not blank'')),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '左側サイドボックスの横幅', 'BOX_WIDTH_LEFT', '200px', '左側に表示されるサイドボックスの横幅を設定します。pxを含めて入力できます。\r\n<br /><br />\r\n・デフォルト = 200px', 19, 1, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '右側サイドボックスの横幅', 'BOX_WIDTH_RIGHT', '200px', '右側に表示されるサイドボックスの横幅を設定します。pxを含めて入力できます。<br /><br />\r\n・Default = 200px', 19, 2, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'パン屑リストの区切り文字', 'BREAD_CRUMBS_SEPARATOR', '&nbsp;::&nbsp;', 'パン屑リストの区切り文字を設定します。<br /><br />\r\n【注意】空白を含む場合は&amp;nbsp;を使用することができます。<br />\r\n・デフォルト = &amp;nbsp;::&amp;nbsp;', 19, 3, NULL, now(), NULL, 'zen_cfg_textarea_small(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'パン屑リストの設定', 'DEFINE_BREADCRUMB_STATUS', '1', 'パン屑リストのリンクを有効にしますか?<br />0= OFF<br />1= ON', 19, 4, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ベストセラー - 桁数合わせ文字', 'BEST_SELLERS_FILLER', '&nbsp;', '桁数を合わせるために挿入する文字を設定します。<br />デフォルト = &amp;nbsp;(空白)', 19, 5, NULL, now(), NULL, 'zen_cfg_textarea_small(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ベストセラー - 表示文字数', 'BEST_SELLERS_TRUNCATE', '35', 'ベストセラーのサイドボックスで表示する商品名の長さを設定します。<br />デフォルト = 35', 19, 6, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ベストセラー - 表示文字数を超えた場合に「...」を表示', 'BEST_SELLERS_TRUNCATE_MORE', 'true', '商品名が途中で切れた場合に「...」を表示します。<br />デフォルト = true', 19, 7, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'カテゴリボックス - 特価商品のリンク表示', 'SHOW_CATEGORIES_BOX_SPECIALS', 'true', 'カテゴリボックスに特価商品のリンクを表示します。', 19, 8, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'カテゴリボックス - 新着商品のリンク表示', 'SHOW_CATEGORIES_BOX_PRODUCTS_NEW', 'true', 'カテゴリボックスに新着商品へのリンクを表示します。', 19, 9, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ショッピングカートボックスの表示', 'SHOW_SHOPPING_CART_BOX_STATUS', '1', 'ショッピングカートの表示を設定します。<br />\r\n<br />\r\n・0= 常に表示<br />\r\n・1= 商品が入っているときだけ表示<br />\r\n・2= 商品が入っているときに表示するが、ショッピングカートページでは表示しない', 19, 10, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'カテゴリボックス - おすすめ商品へのリンクを表示', 'SHOW_CATEGORIES_BOX_FEATURED_PRODUCTS', 'true', 'カテゴリボックスにおすすめ商品へのリンクを表示しますか?', 19, 11, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'カテゴリボックス - 全商品リストへのリンクを表示', 'SHOW_CATEGORIES_BOX_PRODUCTS_ALL', 'true', 'カテゴリボックスに全商品リストへのリンクを表示しますか?', 19, 12, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '左側カラムの表示', 'COLUMN_LEFT_STATUS', '1', '左側カラムを表示しますか? (ページをオーバーライドするものがない場合)<br /><br />\r\n・0= 常に非表示<br />\r\n1= オーバーライドがなければ表示', 19, 15, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '右側カラムの表示', 'COLUMN_RIGHT_STATUS', '1', '右側カラムを表示しますか? (ページをオーバーライドするものがない場合)<br /><br />\r\n・0= 常に非表示<br />\r\n・1= オーバーライドがなければ表示', 19, 16, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '左側カラムの横幅', 'COLUMN_WIDTH_LEFT', '200px', '左側カラムの横幅を設定します。pxを含めて指定可能。<br /><br />\r\nデフォルト = 200px', 19, 20, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '右側カラムの横幅', 'COLUMN_WIDTH_RIGHT', '200px', '右側カラムの横幅を設定します。pxを含めて指定可能。<br /><br />\r\nデフォルト = 200px', 19, 21, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'カテゴリ名・リンク間の区切り', 'SHOW_CATEGORIES_SEPARATOR_LINK', '1', 'カテゴリ名とリンク（「おすすめ商品」など）の間にセパレータ(区切り)を表示しますか?<br /><br />\r\n・0= off<br />\r\n・1= on', 19, 24, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'カテゴリの区切り - カテゴリ名・商品数', 'CATEGORIES_SEPARATOR', '-&gt;', 'カテゴリ名と(カテゴリ内の)商品数の間のセパレータ(区切り)は何にしますか?<br /><br />\r\nデフォルト = -&amp;gt;', 19, 25, NULL, now(), NULL, 'zen_cfg_textarea_small(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'カテゴリの区切り - カテゴリ名とサブカテゴリ名の間', 'CATEGORIES_SEPARATOR_SUBS', '|_&nbsp;', 'カテゴリ名・サブカテゴリ名の間のセパレータ(区切り)は何にしますか?<br />\r\n<br />\r\nデフォルト = |_&amp;nbsp;', 19, 26, NULL, now(), NULL, 'zen_cfg_textarea_small(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'カテゴリ内商品数の接頭辞(Prefix)', 'CATEGORIES_COUNT_PREFIX', '(', 'カテゴリ内の商品数表示の接頭辞(Prefix)は?\r\n<br /><br />\r\n・デフォルト= (', 19, 27, NULL, now(), NULL, 'zen_cfg_textarea_small(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'カテゴリ内商品数の接尾辞(Suffix)', 'CATEGORIES_COUNT_SUFFIX', ')', 'カテゴリ内の商品数表示の接尾辞(Suffix)は?\r\n<br /><br />\r\n・デフォルト= )', 19, 28, NULL, now(), NULL, 'zen_cfg_textarea_small(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'カテゴリ・サブカテゴリのインデント', 'CATEGORIES_SUBCATEGORIES_INDENT', '&nbsp;&nbsp;', 'サブカテゴリをインデント(字下げ)表示する際の文字・記号は?<br /><br />\r\n・デフォルト = &nbsp;&nbsp;', 19, 29, NULL, now(), NULL, 'zen_cfg_textarea_small(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品登録0のカテゴリ - 表示・非表示', 'CATEGORIES_COUNT_ZERO', '0', '商品数が0のカテゴリを表示しますか?<br />\r\n<br />\r\n・0 = off<br />\r\n・1 = on', 19, 30, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'カテゴリボックスのスプリット(分割)表示', 'CATEGORIES_SPLIT_DISPLAY', 'True', '商品タイプによってカテゴリボックスをスプリット(分割)表示するかどうかを設定します。', 19, 31, NULL, now(), NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ショッピングカート - 合計を表示', 'SHOW_TOTALS_IN_CART', '1', '合計額をショッピングカートの上に表示しますか?<br />・0= off<br />・1= on: 商品の数量、重量合計<br />・2= on: 商品の数量、重量合計(0のときには非表示)<br />・3= on: 商品の数量合計', 19, 31, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '顧客への挨拶 - トップページに表示', 'SHOW_CUSTOMER_GREETING', '1', '顧客への歓迎メッセージを常にトップページに表示しますか?<br />0= off<br />1= on', 19, 40, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'カテゴリ - トップページに表示', 'SHOW_CATEGORIES_ALWAYS', '0', '特定のカテゴリをトップページに表示しますか?<br>\r\n・0= off<br>\r\n・1= on<br><br>\r\n特定のカテゴリをトップページに指定することも可能です。<br>\r\n表示するデフォルトカテゴリは、次項で設定します。<br>', 19, 45, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'カテゴリ - トップページ での開閉', 'CATEGORIES_START_MAIN', '0', 'トップページで表示させるカテゴリを設定します。<br>\r\n・0= トップレベル(親)カテゴリのみをリスト表示<br>\r\n・カテゴリIDを入力することで、特定のカテゴリもしくはサブカテゴリを開く事も出来ます。<br>\r\n【例】3_10 (カテゴリID:3、サブカテゴリID:10)', 19, 46, NULL, now(), '', '');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'カテゴリ - サブカテゴリを常に開いておく', 'SHOW_CATEGORIES_SUBCATEGORIES_ALWAYS', '1', 'カテゴリとサブカテゴリは常に表示しますか?<br />0= OFF 親カテゴリのみ<br />1= ON カテゴリ・サブカテゴリは選択されたら常に表示', 19, 47, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'バナー表示グループ - ヘッダポジション1', 'SHOW_BANNERS_GROUP_SET1', '', 'どのバナーグループをヘッダポジション1に使用しますか? 使わない場合は未記入にします。<br />\r\n<br />\r\nバナー表示グループは1つ(1バナーグループ)または複数(マルチバナーグループ)にすることもできます。マルチバナーグループを表示するためにはグループ名をコロン(<strong>:</strong>)で区切って入力します。<br />\r\n例：Wide-Banners:SideBox-Banners', 19, 55, NULL, now(), '', '');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'バナー表示グループ - ヘッダポジション2', 'SHOW_BANNERS_GROUP_SET2', '', 'どのバナーグループをヘッダポジション2に使用しますか? 使わない場合は未記入にします。<br />\r\n<br />\r\nバナー表示グループは1つ(1バナーグループ)または複数(マルチバナーグループ)にすることもできます。マルチバナーグループを表示するためにはグループ名をコロン(<strong>:</strong>)で区切って入力します。<br />\r\n例：Wide-Banners:SideBox-Banners', 19, 56, NULL, now(), '', '');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'バナー表示グループ - ヘッダポジション3', 'SHOW_BANNERS_GROUP_SET3', '', 'どのバナーグループをヘッダポジション3に使用しますか? 使わない場合は未記入にします。<br />\r\n<br />\r\nバナー表示グループは1つ(1バナーグループ)または複数(マルチバナーグループ)にすることもできます。マルチバナーグループを表示するためにはグループ名をコロン(<strong>:</strong>)で区切って入力します。<br />\r\n例：Wide-Banners:SideBox-Banners', 19, 57, NULL, now(), '', '');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'バナー表示グループ - フッタポジション1', 'SHOW_BANNERS_GROUP_SET4', '', 'どのバナーグループをフッタポジション1に使用しますか? 使わない場合は未記入にします。<br />\r\n<br />\r\nバナー表示グループは1つ(1バナーグループ)または複数(マルチバナーグループ)にすることもできます。マルチバナーグループを表示するためにはグループ名をコロン(<strong>:</strong>)で区切って入力します。<br />\r\n例：Wide-Banners:SideBox-Banners', 19, 65, NULL, now(), '', '');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'バナー表示グループ - フッタポジション2', 'SHOW_BANNERS_GROUP_SET5', '', 'どのバナーグループをフッタポジション2に使用しますか? 使わない場合は未記入にします。<br />\r\n<br />\r\nバナー表示グループは1つ(1バナーグループ)または複数(マルチバナーグループ)にすることもできます。マルチバナーグループを表示するためにはグループ名をコロン(<strong>:</strong>)で区切って入力します。<br />\r\n例：Wide-Banners:SideBox-Banners', 19, 66, NULL, now(), '', '');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'バナー表示グループ - フッタポジション3', 'SHOW_BANNERS_GROUP_SET6', 'Wide-Banners', 'どのバナーグループをフッタポジション3に使用しますか? 使わない場合は未記入にします。<br />\r\n<br />\r\nバナー表示グループは1つ(1バナーグループ)または複数(マルチバナーグループ)にすることもできます。マルチバナーグループを表示するためにはグループ名をコロン(<strong>:</strong>)で区切って入力します。<br />\r\n例：Wide-Banners:SideBox-Banners', 19, 67, NULL, now(), '', '');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'バナー表示グループ - サイドボックス内バナーボックス', 'SHOW_BANNERS_GROUP_SET7', 'SideBox-Banners', 'どのバナーグループをサイドボックス内バナーボックス2に使用しますか? 使わない場合は未記入にします。<br />\r\nデフォルトのグループはSideBox-Bannersです。<br />\r\n<br />\r\nバナー表示グループは1つ(1バナーグループ)または複数(マルチバナーグループ)にすることもできます。マルチバナーグループを表示するためにはグループ名をコロン(<strong>:</strong>)で区切って入力します。<br />\r\n例：Wide-Banners:SideBox-Banners', 19, 70, NULL, now(), '', '');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'バナー表示グループ - サイドボックス内バナーボックス2', 'SHOW_BANNERS_GROUP_SET8', 'SideBox-Banners', 'どのバナーグループをサイドボックス内バナーボックス2に使用しますか? 使わない場合は未記入にします。<br />\r\nデフォルトのグループはSideBox-Bannersです。<br />\r\n<br />\r\nバナー表示グループは1つ(1バナーグループ)または複数(マルチバナーグループ)にすることもできます。マルチバナーグループを表示するためにはグループ名をコロン(<strong>:</strong>)で区切って入力します。<br />\r\n例：Wide-Banners:SideBox-Banners', 19, 71, NULL, now(), '', '');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'バナー表示グループ - サイドボックス内バナーボックス全て', 'SHOW_BANNERS_GROUP_SET_ALL', 'BannersAll', 'サイドボックス内バナーボックス全て(Banner All sidebox)で表示するバナー表示グループは、1つです。デフォルトのグループはBannersAllです。どのバナーグループをサイドボックスのbanner_box_allに表示しますか?<br />表示しない場合は空欄にしてください。', 19, 72, NULL, now(), '', '');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'フッタ - IPアドレスの表示・非表示', 'SHOW_FOOTER_IP', '1', '顧客のIPアドレスをフッタに表示しますか?<br />\r\n<br />\r\n・0= off<br />\r\n・1= on<br />', 19, 80, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '数量割引 - 追加割引レベル数', 'DISCOUNT_QTY_ADD', '5', '数量割引の割引レベルの追加数を指定します。一つの割引レベルに一つの割引設定を行うことができます。', 19, 90, NULL, now(), '', '');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '数量割引 - 一行あたりの表示数', 'DISCOUNT_QUANTITY_PRICES_COLUMN', '5', '商品情報ページで表示する数量割引設定の一行あたり表示数を指定します。割引設定数（割引レベル数）が一行あたりの表示数を超えた場合は、複数行で表示されます。', 19, 95, NULL, now(), '', '');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'カテゴリ/商品のソート順', 'CATEGORIES_PRODUCTS_SORT_ORDER', '0', 'カテゴリ/商品のソート順を設定します。<br />0= カテゴリ/商品 ソート順/名前<br />1= カテゴリ/商品 名前<br />2= 商品モデル<br />3= 商品数量+, 商品名<br />4= 商品数量-, 商品名<br />5= 商品価格+, 商品名<br />6= 商品価格+, 商品名', 19, 100, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4'', ''5'', ''6''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'オプション名/オプション値の追加・コピー・削除', 'OPTION_NAMES_VALUES_GLOBAL_STATUS', '1', 'オプション名/オプション値の追加・コピー・削除の機能についてのグローバルな設定を行います。<br />0= 機能を隠す<br />1= 機能を表示する', 19, 110, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'カテゴリ - タブメニュー', 'CATEGORIES_TABS_STATUS', '1', 'カテゴリ - タブをオンにするとショップ画面のヘッダ部分にカテゴリが表示されます。さまざまな応用ができるでしょう。<br />0= カテゴリのタブを隠す<br />1= カテゴリのタブを表示', 19, 112, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'サイトマップ - Myページの表示', 'SHOW_ACCOUNT_LINKS_ON_SITE_MAP', 'No', 'Myページのリンクをサイトマップに表示しますか?<br />注意：サーチエンジンのクローラーがこのページをインデックスしようとしてログインページに誘導されてしまう可能性があり、お勧めしません。<br /><br />デフォルト：false (表示しない)', 19, 115, NULL, now(), NULL, 'zen_cfg_select_option(array(''Yes'', ''No''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '1商品だけのカテゴリの表示をスキップ', 'SKIP_SINGLE_PRODUCT_CATEGORIES', 'True', '商品が1つだけのカテゴリの表示をスキップしますか?<br />このオプションがTrueの場合、ユーザーが商品が1つだけのカテゴリをクリックすると、Zen Cartは直接商品ページを表示するようになります。<br />デフォルト：True', 19, 120, NULL, now(), NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ログイン画面とアカウント作成画面を分ける', 'USE_SPLIT_LOGIN_MODE', 'False', 'ログインページと別ページでアカウント作成画面を表示しますか？<br />\r\nTrue -　ログインページに「アカウント作成」へのリンクを表示<br />\r\nFalse - ログイン画面内にアカウント作成項目を表示', 19, 121, NULL, now(), NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'CSSボタン', 'IMAGE_USE_CSS_BUTTONS', 'No', 'CSS画像(gif/jpg)の代わりにボタンを表示しますか?<br />ONにした場合、ボタンのスタイルはスタイルシートで定義してください。', 19, 147, NULL, now(), NULL, 'zen_cfg_select_option(array(''No'', ''Yes''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '<strong>「メンテナンス中」 オン/オフ</strong>', 'DOWN_FOR_MAINTENANCE', 'false', '「メンテナンス中」の表示について設定します。<br />\r\n<br />\r\n・true = オン（メンテナンス中）<br />\r\n・false = オフ（通常表示）', 20, 1, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「メンテナンス中」- 表示するファイル', 'DOWN_FOR_MAINTENANCE_FILENAME', 'down_for_maintenance', 'メンテナンス中に表示するファイルのファイル名を設定します。デフォルトは"down_for_maintenance"です。<br /><br />\r\n【注意】拡張子は付けないでください。', 20, 2, NULL, now(), NULL, '');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「メンテナンス中」- ヘッダを隠す', 'DOWN_FOR_MAINTENANCE_HEADER_OFF', 'false', '「メンテナンス中」表示モードの際、ヘッダを隠しますか?<br /><br />\r\n・true = 表示しない<br />\r\n・false = 表示する', 20, 3, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「メンテナンス中」- 左カラムを隠す', 'DOWN_FOR_MAINTENANCE_COLUMN_LEFT_OFF', 'false', '「メンテナンス中」表示モードの際、左カラムを隠しますか?<br /><br />\r\n・true = 表示しない<br />\r\n・false = 表示する', 20, 4, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「メンテナンス中」- 右カラムを隠す', 'DOWN_FOR_MAINTENANCE_COLUMN_RIGHT_OFF', 'false', '「メンテナンス中」表示モードの際、右カラムを隠しますか?<br /><br />\r\n・true = 表示しない<br />\r\n・false = 表示する', 20, 5, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「メンテナンス中」- フッタを隠す', 'DOWN_FOR_MAINTENANCE_FOOTER_OFF', 'false', '「メンテナンス中」表示モードの際、フッタを隠しますか?<br /><br />\r\n・true = 表示しない<br />\r\n・false = 表示する', 20, 6, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「メンテナンス中」- 価格を表示しない', 'DOWN_FOR_MAINTENANCE_PRICES_OFF', 'false', '「メンテナンス中」表示モードの際、商品価格を隠しますか?<br /><br />\r\n・true = 表示しない<br />\r\n・false = 表示する', 20, 7, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「メンテナンス中」- 設定したIPアドレスを除く', 'EXCLUDE_ADMIN_IP_FOR_MAINTENANCE', '', 'ショップ管理者用などに、「メンテナンス中」表示モードの際でもアクセス可能なIPアドレスを設定しますか?<br /><br />\r\n複数のIPアドレスを指定するにはカンマ(,)で区切ります。また、あなたのアクセス元のIPアドレスがわからない場合は、ショップのフッタに表示されるIPアドレスをチェックしてください。', 20, 8, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「メンテナンス予告(NOTICE PUBLIC)」-  オン/オフ', 'WARN_BEFORE_DOWN_FOR_MAINTENANCE', 'false', 'ショップの「メンテナンス中」表示を出す前に告知を出しますか?<br /><br />\r\n・true = 表示する<br />\r\n・false = 表示しない<br /><br />\r\n注意：「メンテナンス中」表示が有効になると、この設定は自動的にfalseに書き換えられます。', 20, 9, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「メンテナンス予告」- メッセージに表示する日時', 'PERIOD_BEFORE_DOWN_FOR_MAINTENANCE', '15/05/2003  2-3 PM', 'ヘッダに表示するメンテナンス予告メッセージの開始日と時間を設定します。', 20, 10, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「メンテナンス中」- メンテナンスを開始した日時を表示', 'DISPLAY_MAINTENANCE_TIME', 'false', 'ショップ管理者がいつ「メンテナンス中」表示をオンにしたか表示しますか?<br /><br />\r\n・true = 表示する<br />\r\n・false = 表示しない', 20, 11, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「メンテナンス中」- メンテナンス期間を表示', 'DISPLAY_MAINTENANCE_PERIOD', 'false', 'メンテナンスの期間を表示しますか?<br /><br />\r\n・true = 表示する<br />\r\n・false = 表示しない', 20, 12, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メンテナンス期間', 'TEXT_MAINTENANCE_PERIOD_TIME', '2h00', 'メンテナンス期間を設定します。<br />\r\n書式：(hh:mm)<br />h = 時間　m = 分', 20, 13, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'チェックアウト時に「ご利用規約」確認画面を表示', 'DISPLAY_CONDITIONS_ON_CHECKOUT', 'false', 'チェックアウトの際に「ご利用規約」の画面を表示しますか?', 11, 1, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'アカウント作成時に個人情報保護方針確認画面を表示', 'DISPLAY_PRIVACY_CONDITIONS', 'true', 'アカウント作成の際、個人情報保護方針への同意画面を表示しますか?<br /><div style="color: red;">注意：「個人情報保護法」では、個人情報保護方針を開示することが求められています。</div>', 11, 2, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品画像を表示', 'PRODUCT_NEW_LIST_IMAGE', '1102', '商品画像を表示しますか?<br />\r\n<br />\r\n・0= off<br />\r\n・1桁目：左か右か<br />\r\n・2・3桁目：(他の表示項目との)ソート順<br />\r\n・4桁目：表示後の改行(br)数<br />', 21, 1, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品の数量を表示', 'PRODUCT_NEW_LIST_QUANTITY', '1202', '商品数量を表示しますか?<br />\r\n<br />\r\n・0= off<br />\r\n・1桁目：左か右か<br />\r\n・2・3桁目：(他の表示項目との)ソート順<br />\r\n・4桁目：表示後の改行(br)数<br />', 21, 2, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「今すぐ買う」ボタンの表示', 'PRODUCT_NEW_BUY_NOW', '1300', '「今すぐ買う」ボタンを表示しますか?<br />\r\n<br />\r\n・0= off<br />\r\n・1桁目：左か右か<br />\r\n・2・3桁目：(他の表示項目との)ソート順<br />\r\n・4桁目：表示後の改行(br)数<br />', 21, 3, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品名の表示', 'PRODUCT_NEW_LIST_NAME', '2101', '商品名を表示しますか?<br />\r\n<br />\r\n・0= off<br />\r\n・1桁目：左か右か<br />\r\n・2・3桁目：(他の表示項目との)ソート順<br />\r\n・4桁目：表示後の改行(br)数<br />', 21, 4, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品型番の表示', 'PRODUCT_NEW_LIST_MODEL', '2201', '商品型番を表示しますか?<br />\r\n<br />\r\n・0= off<br />\r\n・1桁目：左か右か<br />\r\n・2・3桁目：(他の表示項目との)ソート順<br />\r\n・4桁目：表示後の改行(br)数<br />', 21, 5, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品メーカーの表示', 'PRODUCT_NEW_LIST_MANUFACTURER', '2302', '商品メーカーを表示しますか?<br />\r\n<br />\r\n・0= off<br />\r\n・1桁目：左か右か<br />\r\n・2・3桁目：(他の表示項目との)ソート順<br />\r\n・4桁目：表示後の改行(br)数<br />', 21, 6, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品価格の表示', 'PRODUCT_NEW_LIST_PRICE', '2402', '商品価格を表示しますか?<br />\r\n<br />\r\n・0= off<br />\r\n・1桁目：左か右か<br />\r\n・2・3桁目：(他の表示項目との)ソート順<br />\r\n・4桁目：表示後の改行(br)数<br />', 21, 7, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品重量の表示', 'PRODUCT_NEW_LIST_WEIGHT', '2502', '商品の重量を表示しますか?<br />\r\n<br />\r\n・0= off<br />\r\n・1桁目：左か右か<br />\r\n・2・3桁目：(他の表示項目との)ソート順<br />\r\n・4桁目：表示後の改行(br)数<br />', 21, 8, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品登録日の表示', 'PRODUCT_NEW_LIST_DATE_ADDED', '2601', '商品登録日を表示しますか?<br />\r\n<br />\r\n・0= off<br />\r\n・1桁目：左か右か<br />\r\n・2・3桁目：(他の表示項目との)ソート順<br />\r\n・4桁目：表示後の改行(br)数<br />', 21, 9, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品説明の表示', 'PRODUCT_NEW_LIST_DESCRIPTION', '150', '商品説明よりプレビュー表示する文字数を指定します。説明文の文頭より指定された文字数分だけが表示されます。<br />\r\n0 を指定すると非表示になります。', 21, 10, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品の表示 - デフォルトのソート順', 'PRODUCT_NEW_LIST_SORT_DEFAULT', '6', '新着商品リストの表示のデフォルトのソート順は? デフォルト値は6です。<br /><br />\r\n・1= 商品名<br />\r\n・2= 商品名(降順)<br />\r\n・3= 価格が安いものから商品名<br />\r\n・4= 価格が高いものから商品名<br />\r\n・5= 型番<br />\r\n・6= 商品登録日(降順)<br />\r\n・7= 商品登録日<br />\r\n・8= 商品順(Product Sort)\r\n', 21, 11, NULL, now(), NULL, 'zen_cfg_select_option(array(''1'', ''2'', ''3'', ''4'', ''5'', ''6'', ''7'', ''8''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '新着商品 - デフォルトのグループID', 'PRODUCT_NEW_LIST_GROUP_ID', '21', '新着商品リストの設定グループID(configuration_group_id)は何ですか?<br />\r\n<br />\r\n注意：新着商品リストのグループIDがデフォルトの21から変更されたときだけ設定してください。', 21, 12, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '複数商品の数量欄の有無・表示位置', 'PRODUCT_NEW_LISTING_MULTIPLE_ADD_TO_CART', '3', '複数商品の数量欄の表示の有無と表示位置について設定します。<br />0= off<br />1= 上部<br />2= 下部<br />3= 両方', 21, 25, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '新着商品に入荷待ち商品を加えますか？', 'SHOW_NEW_PRODUCTS_UPCOMING_MASKED', '0', '新着商品一覧時に入荷待ち商品を加えますか？<br />0= 加える<br />1= 加えない', 21, 30, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品画像の表示', 'PRODUCT_FEATURED_LIST_IMAGE', '1102', '商品画像を表示しますか?<br />\r\n<br />\r\n・0 =  表示しない<br />\r\n・1桁目：左か右か<br />\r\n・2・3桁目：(他の表示項目との)ソート順<br />\r\n・4桁目：表示後の改行(br)数<br />\r\n', 22, 1, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品数量の表示', 'PRODUCT_FEATURED_LIST_QUANTITY', '1202', '商品数量を表示しますか?<br />\r\n<br />\r\n・0 =  表示しない<br />\r\n・1桁目：左か右か<br />\r\n・2・3桁目：(他の表示項目との)ソート順<br />\r\n・4桁目：表示後の改行(br)数<br />\r\n', 22, 2, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「今すぐ買う」ボタンの表示', 'PRODUCT_FEATURED_BUY_NOW', '1300', '「今すぐ買う」ボタンを表示しますか?<br />\r\n<br />\r\n・0 =  表示しない<br />\r\n・1桁目：左か右か<br />\r\n・2・3桁目：(他の表示項目との)ソート順<br />\r\n・4桁目：表示後の改行(br)数<br />', 22, 3, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品名の表示', 'PRODUCT_FEATURED_LIST_NAME', '2101', '商品名を表示しますか?<br />\r\n<br />\r\n・0 =  表示しない<br />\r\n・1桁目：左か右か<br />\r\n・2・3桁目：(他の表示項目との)ソート順<br />\r\n・4桁目：表示後の改行(br)数<br />', 22, 4, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品型番の表示', 'PRODUCT_FEATURED_LIST_MODEL', '2201', '商品型番を表示しますか?<br />\r\n<br />\r\n・0 = 表示しない<br />\r\n・1桁目：左か右か<br />\r\n・2・3桁目：(他の表示項目との)ソート順<br />\r\n・4桁目：表示後の改行(br)数<br />', 22, 5, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品メーカーの表示', 'PRODUCT_FEATURED_LIST_MANUFACTURER', '2302', '商品メーカーを表示しますか?<br />\r\n<br />\r\n・0 = 表示しない<br />\r\n・1桁目：左か右か<br />\r\n・2・3桁目：(他の表示項目との)ソート順<br />\r\n・4桁目：表示後の改行(br)数<br />', 22, 6, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品価格の表示', 'PRODUCT_FEATURED_LIST_PRICE', '2402', '商品価格を表示しますか?<br />\r\n<br />\r\n・0 = 表示しない<br />\r\n・1桁目：左か右か<br />\r\n・2・3桁目：(他の表示項目との)ソート順<br />\r\n・4桁目：表示後の改行(br)数<br />', 22, 7, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品重量の表示', 'PRODUCT_FEATURED_LIST_WEIGHT', '2502', '商品重量を表示しますか?<br />\r\n<br />\r\n・0 = 表示しない<br />\r\n・1桁目：左か右か<br />\r\n・2・3桁目：(他の表示項目との)ソート順<br />\r\n・4桁目：表示後の改行(br)数<br />', 22, 8, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品登録日の表示', 'PRODUCT_FEATURED_LIST_DATE_ADDED', '2601', '商品登録日を表示しますか?<br />\r\n<br />\r\n・0 = 表示しない<br />\r\n・1桁目：左か右か<br />\r\n・2・3桁目：(他の表示項目との)ソート順<br />\r\n・4桁目：表示後の改行(br)数<br />', 22, 9, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品説明の表示', 'PRODUCT_FEATURED_LIST_DESCRIPTION', '150', '商品説明よりプレビュー表示する文字数を指定します。説明文の文頭より指定された文字数分だけが表示されます。<br />\r\n0 を指定すると非表示になります。', 22, 10, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品表示 - デフォルトのソート順', 'PRODUCT_FEATURED_LIST_SORT_DEFAULT', '1', 'おすすめ商品リストの表示のデフォルトのソート順は? デフォルト値は1です。<br />\r\n<br />\r\n・1= 商品名<br />\r\n・2= 商品名(降順)<br />\r\n・3= 価格が安いものから、商品名<br />\r\n・4= 価格が高いものから、商品名<br />\r\n・5= 型番<br />\r\n・6= 商品登録日(降順)<br />\r\n・7= 商品登録日<br />\r\n・8= 商品順(Product Sort)', 22, 11, NULL, now(), NULL, 'zen_cfg_select_option(array(''1'', ''2'', ''3'', ''4'', ''5'', ''6'', ''7'', ''8''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'おすすめ商品 - デフォルトのグループID', 'PRODUCT_FEATURED_LIST_GROUP_ID', '22', 'おすすめ商品リストの設定グループID(configuration_group_id)は何ですか?<br />\r\n<br />\r\n注意：おすすめ商品リストのグループIDがデフォルトの22から変更されたときだけ設定してください。<br />\r\n', 22, 12, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '複数商品の数量欄の有無・表示位置', 'PRODUCT_FEATURED_LISTING_MULTIPLE_ADD_TO_CART', '3', 'リスト内各商品への数量欄の表示の有無と「選択した商品をカートに入れる」ボタンの表示位置を設定します。<br /><br />\r\n・0 = 表示しない<br />\r\n・1 = 上部<br />\r\n・2 = 下部<br />\r\n・3 = 両方', 22, 25, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品画像の表示', 'PRODUCT_ALL_LIST_IMAGE', '1102', '商品画像を表示しますか?<br />\r\n<br />\r\n・0= off<br />\r\n・1桁目：左か右か<br />\r\n・2・3桁目：(他の表示項目との)ソート順<br />\r\n・4桁目：表示後の改行(br)数<br />', 23, 1, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品数量の表示', 'PRODUCT_ALL_LIST_QUANTITY', '1202', '商品数量を表示しますか?<br />\r\n<br />\r\n・0= off<br />\r\n・1桁目：左か右か<br />\r\n・2・3桁目：(他の表示項目との)ソート順<br />\r\n・4桁目：表示後の改行(br)数<br />', 23, 2, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「今すぐ買う」ボタンの表示', 'PRODUCT_ALL_BUY_NOW', '1300', '「今すぐ買う」ボタンを表示しますか?<br />\r\n<br />\r\n・0= off<br />\r\n・1桁目：左か右か<br />\r\n・2・3桁目：(他の表示項目との)ソート順<br />\r\n・4桁目：表示後の改行(br)数<br />', 23, 3, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品名の表示', 'PRODUCT_ALL_LIST_NAME', '2101', '商品名を表示しますか?<br />\r\n<br />\r\n・0= off<br />\r\n・1桁目：左か右か<br />\r\n・2・3桁目：(他の表示項目との)ソート順<br />\r\n・4桁目：表示後の改行(br)数<br />', 23, 4, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品型番の表示', 'PRODUCT_ALL_LIST_MODEL', '2201', '商品型番を表示しますか?<br />\r\n<br />\r\n・0= off<br />\r\n・1桁目：左か右か<br />\r\n・2・3桁目：(他の表示項目との)ソート順<br />\r\n・4桁目：表示後の改行(br)数<br />', 23, 5, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品メーカーの表示', 'PRODUCT_ALL_LIST_MANUFACTURER', '2302', '商品メーカーを表示しますか?<br />\r\n<br />\r\n・0= off<br />\r\n・1桁目：左か右か<br />\r\n・2・3桁目：(他の表示項目との)ソート順<br />\r\n・4桁目：表示後の改行(br)数<br />', 23, 6, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品価格の表示', 'PRODUCT_ALL_LIST_PRICE', '2402', '商品価格を表示しますか?<br />\r\n<br />\r\n・0= off<br />\r\n・1桁目：左か右か<br />\r\n・2・3桁目：(他の表示項目との)ソート順<br />\r\n・4桁目：表示後の改行(br)数<br />', 23, 7, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品重量の表示', 'PRODUCT_ALL_LIST_WEIGHT', '2502', '商品重量を表示しますか?<br />\r\n<br />\r\n・0= off<br />\r\n・1桁目：左か右か<br />\r\n・2・3桁目：(他の表示項目との)ソート順<br />\r\n・4桁目：表示後の改行(br)数<br />', 23, 8, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品登録日の表示', 'PRODUCT_ALL_LIST_DATE_ADDED', '2601', '商品登録日を表示しますか?<br />\r\n<br />\r\n・0= off<br />\r\n・1桁目：左か右か<br />\r\n・2・3桁目：(他の表示項目との)ソート順<br />\r\n・4桁目：表示後の改行(br)数<br />', 23, 9, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品説明の表示', 'PRODUCT_ALL_LIST_DESCRIPTION', '150', '商品説明よりプレビュー表示する文字数を指定します。説明文の文頭より指定された文字数分だけが表示されます。<br />\r\n0 を指定すると非表示になります。', 23, 10, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品表示 - デフォルトのソート順', 'PRODUCT_ALL_LIST_SORT_DEFAULT', '1', '全商品リストの表示のデフォルトのソート順は? デフォルト値は1です。<br />\r\n<br />\r\n・1= 商品名<br />\r\n・2= 商品名(降順)<br />\r\n・3= 価格が安いものから、商品名<br />\r\n・4= 価格が高いものから、商品名<br />\r\n・5= 型番<br />\r\n・6= 商品登録日(降順)<br />\r\n・7= 商品登録日<br />\r\n・8= 商品順(Product Sort)', 23, 11, NULL, now(), NULL, 'zen_cfg_select_option(array(''1'', ''2'', ''3'', ''4'', ''5'', ''6'', ''7'', ''8''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '全商品リスト - デフォルトのグループID', 'PRODUCT_ALL_LIST_GROUP_ID', '23', '全商品リストの設定グループID(configuration_group_id)は?<br />\r\n<br />\r\n注意：全商品リストのグループIDがデフォルトの23から変更されたときだけ設定してください。\r\n', 23, 12, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '複数商品の数量欄の有無・表示位置', 'PRODUCT_ALL_LISTING_MULTIPLE_ADD_TO_CART', '3', 'リスト内各商品への数量欄の表示の有無と「選択した商品をカートに入れる」ボタンの表示位置を設定します。<br>\r\n0= off<br>\r\n1= 上部<br>\r\n2= 下部<br>\r\n3= 両方', 23, 25, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '新着商品をメインページに表示する', 'SHOW_PRODUCT_INFO_MAIN_NEW_PRODUCTS', '1', '「新着商品センターボックス」をメインページに表示 しますか?<br /><br />\r\n0 =  表示しない<br />\r\nまたは表示順を数値で設定してください。<br />\r\n4つのセンターボックスの内で数値の小さいものが上に表示されます。', 24, 65, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'おすすめ商品をメインページに表示する', 'SHOW_PRODUCT_INFO_MAIN_FEATURED_PRODUCTS', '2', '「おすすめ商品センターボックス」をメインページに表示 しますか?<br /><br />\r\n0 =  表示しない<br />\r\nまたは表示順を数値で設定してください。<br />\r\n4つのセンターボックスの内で数値の小さいものが上に表示されます。', 24, 66, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '特価商品をメインページに表示する', 'SHOW_PRODUCT_INFO_MAIN_SPECIALS_PRODUCTS', '3', '「特価商品センターボックス」をメインページに表示 しますか?<br /><br />\r\n0 =  表示しない<br />\r\nまたは表示順を数値で設定してください。<br />\r\n4つのセンターボックスの内で数値の小さいものが上に表示されます。', 24, 67, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '入荷予定商品をメインページに表示する', 'SHOW_PRODUCT_INFO_MAIN_UPCOMING', '4', '「入荷予定商品センターボックス」をメインページに表示 しますか?<br /><br />\r\n0 =  表示しない<br />\r\nまたは表示順を数値で設定してください。<br />\r\n4つのセンターボックスの内で数値の小さいものが上に表示されます。', 24, 68, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '新着商品をメインページに表示する - カテゴリ・サブカテゴリ共に\r\n', 'SHOW_PRODUCT_INFO_CATEGORY_NEW_PRODUCTS', '1', '「新着商品センターボックス」をサブカテゴリ一覧表示ページで表示 しますか?<br /><br />\r\n0 =  表示しない<br />\r\nまたは表示順を数値で設定してください。<br />\r\n4つのセンターボックスの内で数値の小さいものが上に表示されます。', 24, 70, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'おすすめ商品をメインページに表示する - カテゴリ・サブカテゴリ共に', 'SHOW_PRODUCT_INFO_CATEGORY_FEATURED_PRODUCTS', '2', '「おすすめ商品センターボックス」をサブカテゴリ一覧表示ページで表示 しますか?<br /><br />\r\n0 =  表示しない<br />\r\nまたは表示順を数値で設定してください。<br />\r\n4つのセンターボックスの内で数値の小さいものが上に表示されます。\r\n', 24, 71, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '特価商品をメインページに表示する - カテゴリ・サブカテゴリ共に', 'SHOW_PRODUCT_INFO_CATEGORY_SPECIALS_PRODUCTS', '3', '「特価商品センターボックス」をサブカテゴリ一覧表示ページで表示 しますか?<br /><br />\r\n0 =  表示しない<br />\r\nまたは表示順を数値で設定してください。<br />\r\n4つのセンターボックスの内で数値の小さいものが上に表示されます。', 24, 72, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '入荷予定商品をメインページに表示する - カテゴリ・サブカテゴリ共に', 'SHOW_PRODUCT_INFO_CATEGORY_UPCOMING', '4', '「入荷予定商品センターボックス」をサブカテゴリ一覧表示ページで表示 しますか?<br /><br />\r\n0 =  表示しない<br />\r\nまたは表示順を数値で設定してください。<br />\r\n4つのセンターボックスの内で数値の小さいものが上に表示されます。', 24, 73, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '新着商品をメインページに表示する - エラーとリンク切れ商品ページ', 'SHOW_PRODUCT_INFO_MISSING_NEW_PRODUCTS', '1', '「新着商品センターボックス」を存在しないＵＲＬを指定された場合のエラーページで表示 しますか?<br /><br />\r\n0 =  表示しない<br />\r\nまたは表示順を数値で設定してください。<br />\r\n4つのセンターボックスの内で数値の小さいものが上に表示されます。<br />\r\n※　「ショップ全般の設定」で「リンク切れページのチェック」がＯＦＦの時に有効です。', 24, 75, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'おすすめ商品をメインページに表示する - エラーとリンク切れ商品ページ', 'SHOW_PRODUCT_INFO_MISSING_FEATURED_PRODUCTS', '2', '「おすすめ商品センターボックス」を存在しないＵＲＬを指定された場合のエラーページで表示 しますか?<br /><br />\r\n0 =  表示しない<br />\r\nまたは表示順を数値で設定してください。<br />\r\n4つのセンターボックスの内で数値の小さいものが上に表示されます。<br />\r\n※　「ショップ全般の設定」で「リンク切れページのチェック」がＯＦＦの時に有効です。', 24, 76, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '特価商品をメインページに表示する - エラーとリンク切れ商品ページ', 'SHOW_PRODUCT_INFO_MISSING_SPECIALS_PRODUCTS', '3', '「特価商品センターボックス」を存在しないＵＲＬを指定された場合のエラーページで表示 しますか?<br /><br />\r\n0 = 表示しない<br />\r\nまたは表示順を数値で設定してください。<br />\r\n4つのセンターボックスの内で数値の小さいものが上に表示されます。<br />\r\n※　「ショップ全般の設定」で「リンク切れページのチェック」がＯＦＦの時に有効です。', 24, 77, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '入荷予定商品をメインページに表示する - エラーとリンク切れ商品ページ', 'SHOW_PRODUCT_INFO_MISSING_UPCOMING', '4', '「入荷予定商品センターボックス」を存在しないＵＲＬを指定された場合のエラーページで表示 しますか?<br /><br />\r\n0 = 表示しない<br />\r\nまたは表示順を数値で設定してください。<br />\r\n4つのセンターボックスの内で数値の小さいものが上に表示されます。<br />\r\n※　「ショップ全般の設定」で「リンク切れページのチェック」がＯＦＦの時に有効です。', 24, 78, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '新着商品を表示する - 商品リストの下部に', 'SHOW_PRODUCT_INFO_LISTING_BELOW_NEW_PRODUCTS', '1', '商品リストの下に「新着商品センターボックス」を表示しますか?<br /><br />\r\n0 = 表示しない<br />\r\nまたは配置順を数値(1～4)で設定してください。', 24, 85, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'おすすめ商品を表示する - 商品リストの下部に', 'SHOW_PRODUCT_INFO_LISTING_BELOW_FEATURED_PRODUCTS', '2', '商品リストの下に「おすすめ商品センターボックス」を表示しますか?<br /><br />\r\n0 = 表示しない<br />\r\nまたは配置順を数値(1~4)で設定してください。', 24, 86, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '特価商品を表示する - 商品リストの下部に', 'SHOW_PRODUCT_INFO_LISTING_BELOW_SPECIALS_PRODUCTS', '3', '商品リストの下に「特価商品センターボックス」を表示しますか?<br /><br />\r\n0 = 表示しない<br />\r\nまたは配置順を数値(1～4)で設定してください。', 24, 87, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '入荷予定商品を表示する - 商品リストの下部に', 'SHOW_PRODUCT_INFO_LISTING_BELOW_UPCOMING', '4', '商品リストの下に「入荷予定商品センターボックス」を表示しますか?<br /><br />\r\n0 = 表示しない<br />\r\nまたは配置順を数値(1～4)で設定してください。', 24, 88, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3'', ''4''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '新着商品 - 横列あたりの表示点数', 'SHOW_PRODUCT_INFO_COLUMNS_NEW_PRODUCTS', '3', '新着商品の列(Row)あたりの配置点数を設定します。', 24, 95, NULL, now(), NULL, 'zen_cfg_select_option(array(''1'', ''2'', ''3'', ''4'', ''5'', ''6'', ''7'', ''8'', ''9'', ''10'', ''11'', ''12''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'おすすめ商品 - 横列あたりの表示点数', 'SHOW_PRODUCT_INFO_COLUMNS_FEATURED_PRODUCTS', '3', 'おすすめ商品の列(Row)あたりの配置点数を設定します。', 24, 96, NULL, now(), NULL, 'zen_cfg_select_option(array(''1'', ''2'', ''3'', ''4'', ''5'', ''6'', ''7'', ''8'', ''9'', ''10'', ''11'', ''12''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '特価商品 - 横列あたりの表示点数', 'SHOW_PRODUCT_INFO_COLUMNS_SPECIALS_PRODUCTS', '3', '特価商品の列(Row)あたりの配置点数を設定します。', 24, 97, NULL, now(), NULL, 'zen_cfg_select_option(array(''1'', ''2'', ''3'', ''4'', ''5'', ''6'', ''7'', ''8'', ''9'', ''10'', ''11'', ''12''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'センターボックスの対象商品フィルタ', 'SHOW_PRODUCT_INFO_ALL_PRODUCTS', '1', '商品リストでセンターボックスを表示する場合、表示中のページの最上位カテゴリ以下の商品のみを表示するか、全カテゴリから商品を表示するかを設定します。<br /><br />\r\n0= 全商品から表示<br />\r\n1= 最上位カテゴリ以下の商品から表示', 24, 100, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'トップページの定義領域 - ステータス', 'DEFINE_MAIN_PAGE_STATUS', '1', '編集された領域の表示を行いますか?<br />0= リンク:表示　　編集領域:非表示<br />1= リンク:表示　　編集領域:表示<br />2= リンク:非表示　編集領域:表示<br />3= リンク:非表示　編集領域:非表示', 25, 60, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「お問い合わせ」ページの表示 - ステータス', 'DEFINE_CONTACT_US_STATUS', '1', '編集された「お問い合わせ」テキストを表示しますか?<br />0= リンク:表示　　編集領域:非表示<br />1= リンク:表示　　編集領域:表示<br />2= リンク:非表示　編集領域:表示<br />3= リンク:非表示　編集領域:非表示', 25, 61, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「個人情報保護方針」表示 - ステータス', 'DEFINE_PRIVACY_STATUS', '1', '編集された「個人情報保護方針」を表示しますか?<br />0= リンク:表示　　編集領域:非表示<br />1= リンク:表示　　編集領域:表示<br />2= リンク:非表示　編集領域:表示<br />3= リンク:非表示　編集領域:非表示', 25, 62, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「配送・送料について」 ページ - ステータス', 'DEFINE_SHIPPINGINFO_STATUS', '1', '編集された「配送・送料について」テキストを表示しますか?<br />0= リンク:表示　　編集領域:非表示<br />1= リンク:表示　　編集領域:表示<br />2= リンク:非表示　編集領域:表示<br />3= リンク:非表示　編集領域:非表示', 25, 63, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「ご利用規約」ページ - ステータス', 'DEFINE_CONDITIONS_STATUS', '1', '編集された「ご利用規約」ページを表示しますか?<br />0= リンク:表示　　編集領域:非表示<br />1= リンク:表示　　編集領域:表示<br />2= リンク:非表示　編集領域:表示<br />3= リンク:非表示　編集領域:非表示', 25, 64, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「ご注文が完了しました」ページ - ステータス', 'DEFINE_CHECKOUT_SUCCESS_STATUS', '1', '編集された「ご注文が完了しました」テキストを表示しますか?<br />0= リンク:表示　　編集領域:非表示<br />1= リンク:表示　　編集領域:表示<br />2= リンク:非表示　編集領域:表示<br />3= リンク:非表示　編集領域:非表示', 25, 65, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「クーポン券」ページ - ステータス', 'DEFINE_DISCOUNT_COUPON_STATUS', '1', '編集された「クーポン券」テキストを表示しますか?<br />0= リンク:表示　　編集領域:非表示<br />1= リンク:表示　　編集領域:表示<br />2= リンク:非表示　編集領域:表示<br />3= リンク:非表示　編集領域:非表示', 25, 66, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「サイトマップ」ページ - ステータス', 'DEFINE_SITE_MAP_STATUS', '1', '編集された「サイトマップ」テキストを表示しますか?<br />0= リンク:表示　　編集領域:非表示<br />1= リンク:表示　　編集領域:表示<br />2= リンク:非表示　編集領域:表示<br />3= リンク:非表示　編集領域:非表示', 25, 67, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '自由編集ページ(Define Page) ページが見つかりません(Not-Found)', 'DEFINE_PAGE_NOT_FOUND_STATUS', '1', '自由編集ページ define_page_not_found.php (ページが見つかりません)で設定したコメントを表示しますか？<br />\r\n0= 表示しない<br />\r\n1= 表示する', 25, 67, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '自由編集ページ(Define Page) 2', 'DEFINE_PAGE_2_STATUS', '1', '自由編集ページ2を表示しますか?<br />0= リンク:表示　　編集領域:非表示<br />1= リンク:表示　　編集領域:表示<br />2= リンク:非表示　編集領域:表示<br />3= リンク:非表示　編集領域:非表示', 25, 82, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '自由編集ページ(Define Page) 3', 'DEFINE_PAGE_3_STATUS', '1', '自由編集ページ3 を表示しますか?<br />0= リンク:表示　　編集領域:非表示<br />1= リンク:表示　　編集領域:表示<br />2= リンク:非表示　編集領域:表示<br />3= リンク:非表示　編集領域:非表示', 25, 83, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '自由編集ページ(Define Page) 4', 'DEFINE_PAGE_4_STATUS', '1', '自由編集ページ(Define Page) 4を表示しますか?<br />0= リンク:表示　　編集領域:非表示<br />1= リンク:表示　　編集領域:表示<br />2= リンク:非表示　編集領域:表示<br />3= リンク:非表示　編集領域:非表示', 25, 84, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'EZページの表示 - ページヘッダ', 'EZPAGES_STATUS_HEADER', '1', 'EZページのコンテンツをページヘッダに表示するかどうかをグローバル(サイト全体)に設定します。<br /><br />\r\n0 = 表示しない<br />\r\n1 = 表示する<br />\r\n2 = サイトメンテナンスの際に管理者のIPアドレスでアクセスした場合のみ表示<br />\r\n注意：ワーニングは公開されず管理者にだけ表示されます。', 30, 10, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'EZページの表示 - ページフッタ', 'EZPAGES_STATUS_FOOTER', '1', 'EZページのコンテンツをページフッタに表示するかどうかをグローバル(サイト全体)に設定します。<br /><br />\r\n0 = 表示しない<br />\r\n1 = 表示する<br />\r\n2 = サイトメンテナンスの際に管理者のIPアドレスでアクセスした場合のみ表示<br />\r\n注意：ワーニングは公開されず管理者にだけ表示されます。', 30, 11, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'EZページの表示 - サイドボックス', 'EZPAGES_STATUS_SIDEBOX', '1', 'EZページのコンテンツをサイドボックスに表示するかどうかをグローバル(サイト全体)に設定します。<br /><br />\r\n0 = 表示しない<br />\r\n1 = 表示する<br />\r\n2 = サイトメンテナンスの際に管理者のIPアドレスでアクセスした場合のみ表示<br />\r\n注意：ワーニングは公開されず管理者にだけ表示されます。', 30, 12, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'EZページ のヘッダ - リンクのセパレータ(区切り記号)', 'EZPAGES_SEPARATOR_HEADER', '&nbsp;::&nbsp;', 'EＺページのヘッダのリンク表示のセパレータ(区切り文字)は?<br />デフォルト = &amp;nbsp;::&amp;nbsp;', 30, 20, NULL, now(), NULL, 'zen_cfg_textarea_small(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'EZページ のフッタ - リンクのセパレータ(区切り記号)', 'EZPAGES_SEPARATOR_FOOTER', '&nbsp;::&nbsp;', 'EＺページのフッタのリンク表示のセパレータ(区切り文字)は?<br />デフォルト = &amp;nbsp;::&amp;nbsp;', 30, 21, NULL, now(), NULL, 'zen_cfg_textarea_small(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'EZページ - [次へ][前へ]ボタン', 'EZPAGES_SHOW_PREV_NEXT_BUTTONS', '2', 'EZページのコンテンツ内[前へ][続ける][次へ]ボタンを表示しますか?<br /><br />\r\n0 = 表示しない (ボタンなし)<br />\r\n1 =「続ける」を表示<br />\r\n2 =「前へ」「続ける」「次へ」を表示<br /><br />\r\nデフォルト：2', 30, 30, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'EZページ - 目次の表示', 'EZPAGES_SHOW_TABLE_CONTENTS', '1', 'EZページの目次を表示しますか?<br /><br />\r\n0 = 表示しない<br />\r\n1 = 表示する', 30, 35, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1''),');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'EZ-ページ - ヘッダで表示しないページ', 'EZPAGES_DISABLE_HEADER_DISPLAY_LIST', '', 'EZページのうち通常のページヘッダに表示しないページは?<br />表示しないページのページIDをカンマ(,)区切りで記述してください。ページIDは管理画面の[追加設定・ツール]のEZページ設定画面で確認できます。<br />例：1,5,2<br />ない場合は空欄のまま', 30, 40, NULL, now(), NULL, 'zen_cfg_textarea_small(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'EZ-ページ - フッタで表示しないページ', 'EZPAGES_DISABLE_FOOTER_DISPLAY_LIST', '', 'EZページのうち通常のページフッタに表示しないページは?<br />表示しないページのページIDをカンマ(,)区切りで記述してください。ページIDは管理画面の[追加設定・ツール]のEZページ設定画面で確認できます。<br />例：3,7<br />ない場合は空欄のまま', 30, 41, NULL, now(), NULL, 'zen_cfg_textarea_small(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'EZ-ページ - 左カラムで表示しないページ', 'EZPAGES_DISABLE_LEFTCOLUMN_DISPLAY_LIST', '', 'EZページのうち通常の左カラムに表示しないページは?<br />表示しないページのページIDをカンマ(,)区切りで記述してください。ページIDは管理画面の[追加設定・ツール]のEZページ設定画面で確認できます。<br />例：6,17<br />ない場合は空欄のまま', 30, 42, NULL, now(), NULL, 'zen_cfg_textarea_small(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'EZ-ページ - 右カラムで表示しないページ', 'EZPAGES_DISABLE_RIGHTCOLUMN_DISPLAY_LIST', '', 'EZページのうち通常の右カラムに表示しないページは?<br />表示しないページのページIDをカンマ(,)区切りで記述してください。ページIDは管理画面の[追加設定・ツール]のEZページ設定画面で確認できます。<br />例：5,23,47<br />ない場合は空欄のまま', 30, 43, NULL, now(), NULL, 'zen_cfg_textarea_small(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '配送先と支払い先', 'MODULE_PAYMENT_COD_TABLE_SHIPPING_PAYMENT', 'False', '配送先と支払い先が違っていても代金引換モジュールを有効にしますか？<br />True - 有効にする。<br />False - 無効にする。', 6, 1, NULL, now(), NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '表示の整列順', 'MODULE_PAYMENT_COD_TABLE_SORT_ORDER', '0', '表示の整列順を設定できます。数字が小さいほど上位に表示されます.', 6, 0, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '適用地域', 'MODULE_PAYMENT_COD_TABLE_ZONE', '0', '適用地域を選択すると、選択した地域のみで利用可能となります.', 6, 3, NULL, now(), 'zen_get_zone_class_title', 'zen_cfg_pull_down_zone_classes(');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '代金引換払いを有効にする', 'MODULE_PAYMENT_COD_TABLE_STATUS', 'True', '代金引換による支払いを有効にする<br />支払い総額に代金引換手数料を加算したい時には<br />注文合計モジュールの ot_cod_table を有効にしてください。', 6, 1, NULL, now(), NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '代引手数料の計算表', 'MODULE_PAYMENT_COD_TABLE_COST', '9999:315,29999:420,99999:630,299999:1050', '支払い金額に連動する代引手数料. 例: 9999:315,29999:420,99999:630,299999:1050 ... 9999円まで315円, 29999円まで420円, ...', 6, 2, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '代金引換手数料', 'MODULE_ORDER_TOTAL_COD_TABLE_STATUS', 'true', '代金引換手数料を表示しますか？', 6, 1, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''), ');

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'Sort Order', 'MODULE_ORDER_TOTAL_COD_TABLE_SORT_ORDER', '998', '表示の整列順を設定できます・数字が小さいほど上位に表示されます。<br>他の数字とかぶらないよう注意してください。<br />※ot_totalモジュールよりも必ず上に表示させるようにしてください。', 6, 2, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ふりがな入力枠を表示する言語', 'ADD_FURIGANA_LANG', 'ja', '住所登録時などにふりがな入力枠を表示する言語コードをカンマ区切りで記述してください。<br />例:ja,en<br />言語コードが判らない場合は ローカライズ - 言語設定 で確認出来ます。', 5, NULL, NULL, now(), NULL, NULL);

INSERT INTO configuration ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '国名ドロップダウンの表示', 'USE_COUNTRY_DROPDOWN', 'True', 'アカウント作成時などに国名のドロップダウンを表示しますか？<br /><br />\r\n\r\n・True = 表示する<br />\r\n・False = 表示しない<br />\r\n非表示にした場合はアカウントのデフォルト国別IDが国名として利用されます。', 5, 7, NULL, now(), NULL, 'zen_cfg_select_option(array(''True'', ''False''), ');

-- --------------------------------------------------------

DROP TABLE IF EXISTS configuration_group;
CREATE TABLE configuration_group (
  `configuration_group_id` int(11) NOT NULL auto_increment,
  `configuration_group_title` varchar(64) NOT NULL default '',
  `configuration_group_description` varchar(255) NOT NULL default '',
  `sort_order` int(5) default NULL,
  `visible` int(1) default '1',
  PRIMARY KEY  (`configuration_group_id`),
  KEY `idx_visible_zen` (`visible`)
)   AUTO_INCREMENT=31 ;

INSERT INTO configuration_group (`configuration_group_id`, `configuration_group_title`, `configuration_group_description`, `sort_order`, `visible`) VALUES(1, 'ショップ全般の設定', 'ショップ全般の設定を行います', 1, 1);
INSERT INTO configuration_group (`configuration_group_id`, `configuration_group_title`, `configuration_group_description`, `sort_order`, `visible`) VALUES(2, '最小値の設定', '文字数や数値の最小値を設定します', 2, 1);
INSERT INTO configuration_group (`configuration_group_id`, `configuration_group_title`, `configuration_group_description`, `sort_order`, `visible`) VALUES(3, '最大値の設定', '文字数や数値の最大値を設定します', 3, 1);
INSERT INTO configuration_group (`configuration_group_id`, `configuration_group_title`, `configuration_group_description`, `sort_order`, `visible`) VALUES(4, '画像の設定', '表示画像のサイズ等の設定を行います', 4, 1);
INSERT INTO configuration_group (`configuration_group_id`, `configuration_group_title`, `configuration_group_description`, `sort_order`, `visible`) VALUES(5, '顧客アカウントの設定', '顧客のアカウントに関する設定を行います', 5, 1);
INSERT INTO configuration_group (`configuration_group_id`, `configuration_group_title`, `configuration_group_description`, `sort_order`, `visible`) VALUES(6, '各種設定', '管理画面では非表示の項目です', 6, 0);
INSERT INTO configuration_group (`configuration_group_id`, `configuration_group_title`, `configuration_group_description`, `sort_order`, `visible`) VALUES(7, '配送料・パッケージに関する設定', '配送料・パッケージに関する設定を行います', 7, 1);
INSERT INTO configuration_group (`configuration_group_id`, `configuration_group_title`, `configuration_group_description`, `sort_order`, `visible`) VALUES(8, '商品リストの設定', '商品のリストページに関わる設定を行います', 8, 1);
INSERT INTO configuration_group (`configuration_group_id`, `configuration_group_title`, `configuration_group_description`, `sort_order`, `visible`) VALUES(9, '在庫の設定', '商品在庫の設定を行います', 9, 1);
INSERT INTO configuration_group (`configuration_group_id`, `configuration_group_title`, `configuration_group_description`, `sort_order`, `visible`) VALUES(10, 'ログの設定', '様々なログに関する設定を行います', 10, 1);
INSERT INTO configuration_group (`configuration_group_id`, `configuration_group_title`, `configuration_group_description`, `sort_order`, `visible`) VALUES(11, '規約関連の設定', '利用規約に関する設定を行います', 16, 1);
INSERT INTO configuration_group (`configuration_group_id`, `configuration_group_title`, `configuration_group_description`, `sort_order`, `visible`) VALUES(12, 'メールの設定', 'メール全般の設定を行います', 12, 1);
INSERT INTO configuration_group (`configuration_group_id`, `configuration_group_title`, `configuration_group_description`, `sort_order`, `visible`) VALUES(13, '商品属性の設定', '商品属性に関する設定を行います', 13, 1);
INSERT INTO configuration_group (`configuration_group_id`, `configuration_group_title`, `configuration_group_description`, `sort_order`, `visible`) VALUES(14, 'GZip圧縮の設定', 'GZip圧縮に関する設定を行います', 14, 1);
INSERT INTO configuration_group (`configuration_group_id`, `configuration_group_title`, `configuration_group_description`, `sort_order`, `visible`) VALUES(15, 'セッションの設定', 'セッションに関する設定を行います', 15, 1);
INSERT INTO configuration_group (`configuration_group_id`, `configuration_group_title`, `configuration_group_description`, `sort_order`, `visible`) VALUES(16, 'ギフト・クーポン券の設定', 'ギフト券・クーポン券に関する設定を行います', 16, 1);
INSERT INTO configuration_group (`configuration_group_id`, `configuration_group_title`, `configuration_group_description`, `sort_order`, `visible`) VALUES(17, 'クレジットカードの設定', '利用可能なクレジットカードなどの設定を行います', 17, 1);
INSERT INTO configuration_group (`configuration_group_id`, `configuration_group_title`, `configuration_group_description`, `sort_order`, `visible`) VALUES(18, '商品情報の設定', '商品情報に関する設定を行います', 18, 1);
INSERT INTO configuration_group (`configuration_group_id`, `configuration_group_title`, `configuration_group_description`, `sort_order`, `visible`) VALUES(19, 'レイアウトの設定', 'レイアウトに関する設定を行います', 19, 1);
INSERT INTO configuration_group (`configuration_group_id`, `configuration_group_title`, `configuration_group_description`, `sort_order`, `visible`) VALUES(20, 'メンテナンス表示の設定', 'メンテナンス表示に関する設定を行います', 20, 1);
INSERT INTO configuration_group (`configuration_group_id`, `configuration_group_title`, `configuration_group_description`, `sort_order`, `visible`) VALUES(21, '新着商品の設定', '新着商品リストに関する設定を行います', 21, 1);
INSERT INTO configuration_group (`configuration_group_id`, `configuration_group_title`, `configuration_group_description`, `sort_order`, `visible`) VALUES(22, 'おすすめ商品の設定', 'おすすめ商品リストの設定を行います', 22, 1);
INSERT INTO configuration_group (`configuration_group_id`, `configuration_group_title`, `configuration_group_description`, `sort_order`, `visible`) VALUES(23, '全商品の設定', '全商品リストに関する設定を行います', 23, 1);
INSERT INTO configuration_group (`configuration_group_id`, `configuration_group_title`, `configuration_group_description`, `sort_order`, `visible`) VALUES(24, '商品カタログページの設定', '商品カタログページの表示内容についての設定を行います', 24, 1);
INSERT INTO configuration_group (`configuration_group_id`, `configuration_group_title`, `configuration_group_description`, `sort_order`, `visible`) VALUES(25, '定番ページの設定', '定番ページに関する設定を行います', 25, 1);
INSERT INTO configuration_group (`configuration_group_id`, `configuration_group_title`, `configuration_group_description`, `sort_order`, `visible`) VALUES(30, 'Ez-Pagesの設定', 'Ez-Pagesに関する設定を行います', 30, 1);

-- --------------------------------------------------------

DROP TABLE IF EXISTS counter;
CREATE TABLE counter (
  `startdate` char(8) default NULL,
  `counter` int(12) default NULL
) ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS counter_history;
CREATE TABLE counter_history (
  `startdate` char(8) default NULL,
  `counter` int(12) default NULL,
  `session_counter` int(12) default NULL
) ;

-- --------------------------------------------------------

--
-- テーブルの構造 `countries`
--

DROP TABLE IF EXISTS countries;
CREATE TABLE countries (
  `countries_id` int(11) NOT NULL auto_increment,
  `countries_name` varchar(64) NOT NULL default '',
  `countries_iso_code_2` char(2) NOT NULL default '',
  `countries_iso_code_3` char(3) NOT NULL default '',
  `address_format_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`countries_id`),
  KEY `idx_countries_name_zen` (`countries_name`),
  KEY `idx_address_format_id_zen` (`address_format_id`),
  KEY `idx_iso_2_zen` (`countries_iso_code_2`),
  KEY `idx_iso_3_zen` (`countries_iso_code_3`)
)   AUTO_INCREMENT=241 ;

INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(240, 'Aaland Islands', 'AX', 'ALA', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(1, 'Afghanistan', 'AF', 'AFG', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(2, 'Albania', 'AL', 'ALB', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(3, 'Algeria', 'DZ', 'DZA', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(4, 'American Samoa', 'AS', 'ASM', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(5, 'Andorra', 'AD', 'AND', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(6, 'Angola', 'AO', 'AGO', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(7, 'Anguilla', 'AI', 'AIA', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(8, 'Antarctica', 'AQ', 'ATA', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(9, 'Antigua and Barbuda', 'AG', 'ATG', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(10, 'Argentina', 'AR', 'ARG', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(11, 'Armenia', 'AM', 'ARM', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(12, 'Aruba', 'AW', 'ABW', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(13, 'Australia', 'AU', 'AUS', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(14, 'Austria', 'AT', 'AUT', 5);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(15, 'Azerbaijan', 'AZ', 'AZE', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(16, 'Bahamas', 'BS', 'BHS', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(17, 'Bahrain', 'BH', 'BHR', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(18, 'Bangladesh', 'BD', 'BGD', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(19, 'Barbados', 'BB', 'BRB', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(20, 'Belarus', 'BY', 'BLR', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(21, 'Belgium', 'BE', 'BEL', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(22, 'Belize', 'BZ', 'BLZ', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(23, 'Benin', 'BJ', 'BEN', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(24, 'Bermuda', 'BM', 'BMU', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(25, 'Bhutan', 'BT', 'BTN', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(26, 'Bolivia', 'BO', 'BOL', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(27, 'Bosnia and Herzegowina', 'BA', 'BIH', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(28, 'Botswana', 'BW', 'BWA', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(29, 'Bouvet Island', 'BV', 'BVT', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(30, 'Brazil', 'BR', 'BRA', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(31, 'British Indian Ocean Territory', 'IO', 'IOT', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(32, 'Brunei Darussalam', 'BN', 'BRN', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(33, 'Bulgaria', 'BG', 'BGR', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(34, 'Burkina Faso', 'BF', 'BFA', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(35, 'Burundi', 'BI', 'BDI', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(36, 'Cambodia', 'KH', 'KHM', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(37, 'Cameroon', 'CM', 'CMR', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(38, 'Canada', 'CA', 'CAN', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(39, 'Cape Verde', 'CV', 'CPV', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(40, 'Cayman Islands', 'KY', 'CYM', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(41, 'Central African Republic', 'CF', 'CAF', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(42, 'Chad', 'TD', 'TCD', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(43, 'Chile', 'CL', 'CHL', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(44, 'China', 'CN', 'CHN', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(45, 'Christmas Island', 'CX', 'CXR', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(46, 'Cocos (Keeling) Islands', 'CC', 'CCK', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(47, 'Colombia', 'CO', 'COL', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(48, 'Comoros', 'KM', 'COM', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(49, 'Congo', 'CG', 'COG', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(50, 'Cook Islands', 'CK', 'COK', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(51, 'Costa Rica', 'CR', 'CRI', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(52, 'Cote D''Ivoire', 'CI', 'CIV', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(53, 'Croatia', 'HR', 'HRV', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(54, 'Cuba', 'CU', 'CUB', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(55, 'Cyprus', 'CY', 'CYP', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(56, 'Czech Republic', 'CZ', 'CZE', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(57, 'Denmark', 'DK', 'DNK', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(58, 'Djibouti', 'DJ', 'DJI', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(59, 'Dominica', 'DM', 'DMA', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(60, 'Dominican Republic', 'DO', 'DOM', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(61, 'East Timor', 'TP', 'TMP', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(62, 'Ecuador', 'EC', 'ECU', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(63, 'Egypt', 'EG', 'EGY', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(64, 'El Salvador', 'SV', 'SLV', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(65, 'Equatorial Guinea', 'GQ', 'GNQ', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(66, 'Eritrea', 'ER', 'ERI', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(67, 'Estonia', 'EE', 'EST', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(68, 'Ethiopia', 'ET', 'ETH', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(69, 'Falkland Islands (Malvinas)', 'FK', 'FLK', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(70, 'Faroe Islands', 'FO', 'FRO', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(71, 'Fiji', 'FJ', 'FJI', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(72, 'Finland', 'FI', 'FIN', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(73, 'France', 'FR', 'FRA', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(74, 'France, Metropolitan', 'FX', 'FXX', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(75, 'French Guiana', 'GF', 'GUF', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(76, 'French Polynesia', 'PF', 'PYF', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(77, 'French Southern Territories', 'TF', 'ATF', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(78, 'Gabon', 'GA', 'GAB', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(79, 'Gambia', 'GM', 'GMB', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(80, 'Georgia', 'GE', 'GEO', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(81, 'Germany', 'DE', 'DEU', 5);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(82, 'Ghana', 'GH', 'GHA', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(83, 'Gibraltar', 'GI', 'GIB', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(84, 'Greece', 'GR', 'GRC', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(85, 'Greenland', 'GL', 'GRL', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(86, 'Grenada', 'GD', 'GRD', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(87, 'Guadeloupe', 'GP', 'GLP', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(88, 'Guam', 'GU', 'GUM', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(89, 'Guatemala', 'GT', 'GTM', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(90, 'Guinea', 'GN', 'GIN', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(91, 'Guinea-bissau', 'GW', 'GNB', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(92, 'Guyana', 'GY', 'GUY', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(93, 'Haiti', 'HT', 'HTI', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(94, 'Heard and Mc Donald Islands', 'HM', 'HMD', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(95, 'Honduras', 'HN', 'HND', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(96, 'Hong Kong', 'HK', 'HKG', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(97, 'Hungary', 'HU', 'HUN', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(98, 'Iceland', 'IS', 'ISL', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(99, 'India', 'IN', 'IND', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(100, 'Indonesia', 'ID', 'IDN', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(101, 'Iran (Islamic Republic of)', 'IR', 'IRN', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(102, 'Iraq', 'IQ', 'IRQ', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(103, 'Ireland', 'IE', 'IRL', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(104, 'Israel', 'IL', 'ISR', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(105, 'Italy', 'IT', 'ITA', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(106, 'Jamaica', 'JM', 'JAM', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(107, 'Japan', 'JP', 'JPN', 6);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(108, 'Jordan', 'JO', 'JOR', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(109, 'Kazakhstan', 'KZ', 'KAZ', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(110, 'Kenya', 'KE', 'KEN', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(111, 'Kiribati', 'KI', 'KIR', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(112, 'Korea, Democratic People''s Republic of', 'KP', 'PRK', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(113, 'Korea, Republic of', 'KR', 'KOR', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(114, 'Kuwait', 'KW', 'KWT', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(115, 'Kyrgyzstan', 'KG', 'KGZ', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(116, 'Lao People''s Democratic Republic', 'LA', 'LAO', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(117, 'Latvia', 'LV', 'LVA', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(118, 'Lebanon', 'LB', 'LBN', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(119, 'Lesotho', 'LS', 'LSO', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(120, 'Liberia', 'LR', 'LBR', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(121, 'Libyan Arab Jamahiriya', 'LY', 'LBY', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(122, 'Liechtenstein', 'LI', 'LIE', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(123, 'Lithuania', 'LT', 'LTU', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(124, 'Luxembourg', 'LU', 'LUX', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(125, 'Macau', 'MO', 'MAC', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(126, 'Macedonia, The Former Yugoslav Republic of', 'MK', 'MKD', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(127, 'Madagascar', 'MG', 'MDG', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(128, 'Malawi', 'MW', 'MWI', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(129, 'Malaysia', 'MY', 'MYS', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(130, 'Maldives', 'MV', 'MDV', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(131, 'Mali', 'ML', 'MLI', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(132, 'Malta', 'MT', 'MLT', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(133, 'Marshall Islands', 'MH', 'MHL', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(134, 'Martinique', 'MQ', 'MTQ', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(135, 'Mauritania', 'MR', 'MRT', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(136, 'Mauritius', 'MU', 'MUS', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(137, 'Mayotte', 'YT', 'MYT', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(138, 'Mexico', 'MX', 'MEX', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(139, 'Micronesia, Federated States of', 'FM', 'FSM', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(140, 'Moldova, Republic of', 'MD', 'MDA', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(141, 'Monaco', 'MC', 'MCO', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(142, 'Mongolia', 'MN', 'MNG', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(143, 'Montserrat', 'MS', 'MSR', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(144, 'Morocco', 'MA', 'MAR', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(145, 'Mozambique', 'MZ', 'MOZ', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(146, 'Myanmar', 'MM', 'MMR', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(147, 'Namibia', 'NA', 'NAM', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(148, 'Nauru', 'NR', 'NRU', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(149, 'Nepal', 'NP', 'NPL', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(150, 'Netherlands', 'NL', 'NLD', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(151, 'Netherlands Antilles', 'AN', 'ANT', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(152, 'New Caledonia', 'NC', 'NCL', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(153, 'New Zealand', 'NZ', 'NZL', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(154, 'Nicaragua', 'NI', 'NIC', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(155, 'Niger', 'NE', 'NER', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(156, 'Nigeria', 'NG', 'NGA', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(157, 'Niue', 'NU', 'NIU', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(158, 'Norfolk Island', 'NF', 'NFK', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(159, 'Northern Mariana Islands', 'MP', 'MNP', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(160, 'Norway', 'NO', 'NOR', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(161, 'Oman', 'OM', 'OMN', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(162, 'Pakistan', 'PK', 'PAK', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(163, 'Palau', 'PW', 'PLW', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(164, 'Panama', 'PA', 'PAN', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(165, 'Papua New Guinea', 'PG', 'PNG', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(166, 'Paraguay', 'PY', 'PRY', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(167, 'Peru', 'PE', 'PER', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(168, 'Philippines', 'PH', 'PHL', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(169, 'Pitcairn', 'PN', 'PCN', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(170, 'Poland', 'PL', 'POL', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(171, 'Portugal', 'PT', 'PRT', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(172, 'Puerto Rico', 'PR', 'PRI', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(173, 'Qatar', 'QA', 'QAT', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(174, 'Reunion', 'RE', 'REU', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(175, 'Romania', 'RO', 'ROM', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(176, 'Russian Federation', 'RU', 'RUS', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(177, 'Rwanda', 'RW', 'RWA', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(178, 'Saint Kitts and Nevis', 'KN', 'KNA', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(179, 'Saint Lucia', 'LC', 'LCA', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(180, 'Saint Vincent and the Grenadines', 'VC', 'VCT', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(181, 'Samoa', 'WS', 'WSM', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(182, 'San Marino', 'SM', 'SMR', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(183, 'Sao Tome and Principe', 'ST', 'STP', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(184, 'Saudi Arabia', 'SA', 'SAU', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(185, 'Senegal', 'SN', 'SEN', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(186, 'Seychelles', 'SC', 'SYC', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(187, 'Sierra Leone', 'SL', 'SLE', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(188, 'Singapore', 'SG', 'SGP', 4);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(189, 'Slovakia (Slovak Republic)', 'SK', 'SVK', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(190, 'Slovenia', 'SI', 'SVN', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(191, 'Solomon Islands', 'SB', 'SLB', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(192, 'Somalia', 'SO', 'SOM', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(193, 'South Africa', 'ZA', 'ZAF', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(194, 'South Georgia and the South Sandwich Islands', 'GS', 'SGS', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(195, 'Spain', 'ES', 'ESP', 3);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(196, 'Sri Lanka', 'LK', 'LKA', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(197, 'St. Helena', 'SH', 'SHN', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(198, 'St. Pierre and Miquelon', 'PM', 'SPM', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(199, 'Sudan', 'SD', 'SDN', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(200, 'Suriname', 'SR', 'SUR', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(201, 'Svalbard and Jan Mayen Islands', 'SJ', 'SJM', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(202, 'Swaziland', 'SZ', 'SWZ', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(203, 'Sweden', 'SE', 'SWE', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(204, 'Switzerland', 'CH', 'CHE', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(205, 'Syrian Arab Republic', 'SY', 'SYR', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(206, 'Taiwan', 'TW', 'TWN', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(207, 'Tajikistan', 'TJ', 'TJK', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(208, 'Tanzania, United Republic of', 'TZ', 'TZA', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(209, 'Thailand', 'TH', 'THA', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(210, 'Togo', 'TG', 'TGO', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(211, 'Tokelau', 'TK', 'TKL', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(212, 'Tonga', 'TO', 'TON', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(213, 'Trinidad and Tobago', 'TT', 'TTO', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(214, 'Tunisia', 'TN', 'TUN', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(215, 'Turkey', 'TR', 'TUR', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(216, 'Turkmenistan', 'TM', 'TKM', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(217, 'Turks and Caicos Islands', 'TC', 'TCA', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(218, 'Tuvalu', 'TV', 'TUV', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(219, 'Uganda', 'UG', 'UGA', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(220, 'Ukraine', 'UA', 'UKR', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(221, 'United Arab Emirates', 'AE', 'ARE', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(222, 'United Kingdom', 'GB', 'GBR', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(223, 'United States', 'US', 'USA', 2);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(224, 'United States Minor Outlying Islands', 'UM', 'UMI', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(225, 'Uruguay', 'UY', 'URY', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(226, 'Uzbekistan', 'UZ', 'UZB', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(227, 'Vanuatu', 'VU', 'VUT', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(228, 'Vatican City State (Holy See)', 'VA', 'VAT', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(229, 'Venezuela', 'VE', 'VEN', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(230, 'Viet Nam', 'VN', 'VNM', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(231, 'Virgin Islands (British)', 'VG', 'VGB', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(232, 'Virgin Islands (U.S.)', 'VI', 'VIR', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(233, 'Wallis and Futuna Islands', 'WF', 'WLF', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(234, 'Western Sahara', 'EH', 'ESH', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(235, 'Yemen', 'YE', 'YEM', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(236, 'Yugoslavia', 'YU', 'YUG', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(237, 'Zaire', 'ZR', 'ZAR', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(238, 'Zambia', 'ZM', 'ZMB', 1);
INSERT INTO countries (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`) VALUES(239, 'Zimbabwe', 'ZW', 'ZWE', 1);

-- --------------------------------------------------------

DROP TABLE IF EXISTS coupons;
CREATE TABLE coupons (
  `coupon_id` int(11) NOT NULL auto_increment,
  `coupon_type` char(1) NOT NULL default 'F',
  `coupon_code` varchar(32) NOT NULL default '',
  `coupon_amount` decimal(15,4) NOT NULL default '0.0000',
  `coupon_minimum_order` decimal(15,4) NOT NULL default '0.0000',
  `coupon_start_date` datetime NOT NULL default '0001-01-01 00:00:00',
  `coupon_expire_date` datetime NOT NULL default '0001-01-01 00:00:00',
  `uses_per_coupon` int(5) NOT NULL default '1',
  `uses_per_user` int(5) NOT NULL default '0',
  `restrict_to_products` varchar(255) default NULL,
  `restrict_to_categories` varchar(255) default NULL,
  `restrict_to_customers` text,
  `coupon_active` char(1) NOT NULL default 'Y',
  `date_created` datetime NOT NULL default '0001-01-01 00:00:00',
  `date_modified` datetime NOT NULL default '0001-01-01 00:00:00',
  `coupon_zone_restriction` int(11) NOT NULL default '0',
  PRIMARY KEY  (`coupon_id`),
  KEY `idx_active_type_zen` (`coupon_active`,`coupon_type`),
  KEY `idx_coupon_code_zen` (`coupon_code`),
  KEY `idx_coupon_type_zen` (`coupon_type`)
)   ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS coupons_description;
CREATE TABLE coupons_description (
  `coupon_id` int(11) NOT NULL default '0',
  `language_id` int(11) NOT NULL default '0',
  `coupon_name` varchar(32) NOT NULL default '',
  `coupon_description` text,
  PRIMARY KEY  (`coupon_id`,`language_id`)
) ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS coupon_email_track;
CREATE TABLE coupon_email_track (
  `unique_id` int(11) NOT NULL auto_increment,
  `coupon_id` int(11) NOT NULL default '0',
  `customer_id_sent` int(11) NOT NULL default '0',
  `sent_firstname` varchar(32) default NULL,
  `sent_lastname` varchar(32) default NULL,
  `emailed_to` varchar(32) default NULL,
  `date_sent` datetime NOT NULL default '0001-01-01 00:00:00',
  PRIMARY KEY  (`unique_id`),
  KEY `idx_coupon_id_zen` (`coupon_id`)
)   ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS coupon_gv_customer;
CREATE TABLE coupon_gv_customer (
  `customer_id` int(5) NOT NULL default '0',
  `amount` decimal(15,4) NOT NULL default '0.0000',
  PRIMARY KEY  (`customer_id`)
) ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS coupon_gv_queue;
CREATE TABLE coupon_gv_queue (
  `unique_id` int(5) NOT NULL auto_increment,
  `customer_id` int(5) NOT NULL default '0',
  `order_id` int(5) NOT NULL default '0',
  `amount` decimal(15,4) NOT NULL default '0.0000',
  `date_created` datetime NOT NULL default '0001-01-01 00:00:00',
  `ipaddr` varchar(32) NOT NULL default '',
  `release_flag` char(1) NOT NULL default 'N',
  PRIMARY KEY  (`unique_id`),
  KEY `idx_cust_id_order_id_zen` (`customer_id`,`order_id`),
  KEY `idx_release_flag_zen` (`release_flag`)
)   ;


-- --------------------------------------------------------

DROP TABLE IF EXISTS coupon_redeem_track;
CREATE TABLE coupon_redeem_track (
  `unique_id` int(11) NOT NULL auto_increment,
  `coupon_id` int(11) NOT NULL default '0',
  `customer_id` int(11) NOT NULL default '0',
  `redeem_date` datetime NOT NULL default '0001-01-01 00:00:00',
  `redeem_ip` varchar(32) NOT NULL default '',
  `order_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`unique_id`),
  KEY `idx_coupon_id_zen` (`coupon_id`)
)   ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS coupon_restrict;
CREATE TABLE coupon_restrict (
  `restrict_id` int(11) NOT NULL auto_increment,
  `coupon_id` int(11) NOT NULL default '0',
  `product_id` int(11) NOT NULL default '0',
  `category_id` int(11) NOT NULL default '0',
  `coupon_restrict` char(1) NOT NULL default 'N',
  PRIMARY KEY  (`restrict_id`),
  KEY `idx_coup_id_prod_id_zen` (`coupon_id`,`product_id`)
)  ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS currencies;
CREATE TABLE currencies (
  `currencies_id` int(11) NOT NULL auto_increment,
  `title` varchar(32) NOT NULL default '',
  `code` char(3) NOT NULL default '',
  `symbol_left` varchar(24) default NULL,
  `symbol_right` varchar(24) default NULL,
  `decimal_point` char(1) default NULL,
  `thousands_point` char(1) default NULL,
  `decimal_places` char(1) default NULL,
  `value` float(13,8) default NULL,
  `last_updated` datetime default NULL,
  PRIMARY KEY  (`currencies_id`)
)   AUTO_INCREMENT=2 ;

INSERT INTO currencies (`currencies_id`, `title`, `code`, `symbol_left`, `symbol_right`, `decimal_point`, `thousands_point`, `decimal_places`, `value`, `last_updated`) VALUES(1, 'Japanese YEN', 'JPY', '', '円', '.', ',', '0', 1.00000000, NULL);

-- --------------------------------------------------------

--
-- テーブルの構造 `customers`
--

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
  `customers_id` int(11) NOT NULL auto_increment,
  `customers_gender` char(1) NOT NULL default '',
  `customers_firstname` varchar(32) NOT NULL default '',
  `customers_lastname` varchar(32) NOT NULL default '',
  `customers_dob` datetime NOT NULL default '0001-01-01 00:00:00',
  `customers_email_address` varchar(96) NOT NULL default '',
  `customers_nick` varchar(96) NOT NULL default '',
  `customers_default_address_id` int(11) NOT NULL default '0',
  `customers_telephone` varchar(32) NOT NULL default '',
  `customers_fax` varchar(32) default NULL,
  `customers_password` varchar(40) NOT NULL default '',
  `customers_newsletter` char(1) default NULL,
  `customers_group_pricing` int(11) NOT NULL default '0',
  `customers_email_format` varchar(4) NOT NULL default 'TEXT',
  `customers_authorization` int(1) NOT NULL default '0',
  `customers_referral` varchar(32) NOT NULL default '',
  `customers_paypal_payerid` varchar(20) NOT NULL default '',
  `customers_paypal_ec` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`customers_id`),
  KEY `idx_email_address_zen` (`customers_email_address`),
  KEY `idx_referral_zen` (`customers_referral`(10)),
  KEY `idx_grp_pricing_zen` (`customers_group_pricing`),
  KEY `idx_nick_zen` (`customers_nick`),
  KEY `idx_newsletter_zen` (`customers_newsletter`)
)   ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS customers_basket;
CREATE TABLE customers_basket (
  `customers_basket_id` int(11) NOT NULL auto_increment,
  `customers_id` int(11) NOT NULL default '0',
  `products_id` tinytext NOT NULL,
  `customers_basket_quantity` float NOT NULL default '0',
  `final_price` decimal(15,4) NOT NULL default '0.0000',
  `customers_basket_date_added` varchar(8) default NULL,
  PRIMARY KEY  (`customers_basket_id`),
  KEY `idx_customers_id_zen` (`customers_id`)
)   ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS customers_basket_attributes;
CREATE TABLE customers_basket_attributes (
  `customers_basket_attributes_id` int(11) NOT NULL auto_increment,
  `customers_id` int(11) NOT NULL default '0',
  `products_id` tinytext NOT NULL,
  `products_options_id` varchar(64) NOT NULL default '0',
  `products_options_value_id` int(11) NOT NULL default '0',
  `products_options_value_text` blob,
  `products_options_sort_order` text NOT NULL,
  PRIMARY KEY  (`customers_basket_attributes_id`),
  KEY `idx_cust_id_prod_id_zen` (`customers_id`,`products_id`(36))
)  AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS customers_info;
CREATE TABLE customers_info (
  `customers_info_id` int(11) NOT NULL default '0',
  `customers_info_date_of_last_logon` datetime default NULL,
  `customers_info_number_of_logons` int(5) default NULL,
  `customers_info_date_account_created` datetime default NULL,
  `customers_info_date_account_last_modified` datetime default NULL,
  `global_product_notifications` int(1) default '0',
  PRIMARY KEY  (`customers_info_id`)
) ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS customers_wishlist;
CREATE TABLE customers_wishlist (
  `products_id` int(13) NOT NULL default '0',
  `customers_id` int(13) NOT NULL default '0',
  `products_model` varchar(13) default NULL,
  `products_name` varchar(64) NOT NULL default '',
  `products_price` decimal(8,2) NOT NULL default '0.00',
  `final_price` decimal(8,2) NOT NULL default '0.00',
  `products_quantity` int(2) NOT NULL default '0',
  `wishlist_name` varchar(64) default NULL
) ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS db_cache;
CREATE TABLE db_cache (
  `cache_entry_name` varchar(64) NOT NULL default '',
  `cache_data` mediumblob,
  `cache_entry_created` int(15) default NULL,
  PRIMARY KEY  (`cache_entry_name`)
) ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS email_archive;
CREATE TABLE email_archive (
  `archive_id` int(11) NOT NULL auto_increment,
  `email_to_name` varchar(96) NOT NULL default '',
  `email_to_address` varchar(96) NOT NULL default '',
  `email_from_name` varchar(96) NOT NULL default '',
  `email_from_address` varchar(96) NOT NULL default '',
  `email_subject` varchar(255) NOT NULL default '',
  `email_html` text NOT NULL,
  `email_text` text NOT NULL,
  `date_sent` datetime NOT NULL default '0001-01-01 00:00:00',
  `module` varchar(64) NOT NULL default '',
  PRIMARY KEY  (`archive_id`),
  KEY `idx_email_to_address_zen` (`email_to_address`),
  KEY `idx_module_zen` (`module`)
)  AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS ezpages;
CREATE TABLE ezpages (
  `pages_id` int(11) NOT NULL auto_increment,
  `languages_id` int(11) NOT NULL default '1',
  `pages_title` varchar(64) NOT NULL default '',
  `alt_url` varchar(255) NOT NULL default '',
  `alt_url_external` varchar(255) NOT NULL default '',
  `pages_html_text` mediumtext,
  `status_header` int(1) NOT NULL default '1',
  `status_sidebox` int(1) NOT NULL default '1',
  `status_footer` int(1) NOT NULL default '1',
  `status_toc` int(1) NOT NULL default '1',
  `header_sort_order` int(3) NOT NULL default '0',
  `sidebox_sort_order` int(3) NOT NULL default '0',
  `footer_sort_order` int(3) NOT NULL default '0',
  `toc_sort_order` int(3) NOT NULL default '0',
  `page_open_new_window` int(1) NOT NULL default '0',
  `page_is_ssl` int(1) NOT NULL default '0',
  `toc_chapter` int(11) NOT NULL default '0',
  PRIMARY KEY  (`pages_id`),
  KEY `idx_lang_id_zen` (`languages_id`),
  KEY `idx_ezp_status_header_zen` (`status_header`),
  KEY `idx_ezp_status_sidebox_zen` (`status_sidebox`),
  KEY `idx_ezp_status_footer_zen` (`status_footer`),
  KEY `idx_ezp_status_toc_zen` (`status_toc`)
)   ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS ezpages_content;
CREATE TABLE ezpages_content (
  `pc_id` int(11) NOT NULL auto_increment,
  `pages_id` int(11) NOT NULL default '0',
  `languages_id` int(11) NOT NULL default '1',
  `pages_title` varchar(64) NOT NULL default '',
  `pages_html_text` text,
  PRIMARY KEY  (`pc_id`),
  KEY `idx_ezpages_content` (`pages_id`,`languages_id`)
)   ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS featured;
CREATE TABLE featured (
  `featured_id` int(11) NOT NULL auto_increment,
  `products_id` int(11) NOT NULL default '0',
  `featured_date_added` datetime default NULL,
  `featured_last_modified` datetime default NULL,
  `expires_date` date NOT NULL default '0001-01-01',
  `date_status_change` datetime default NULL,
  `status` int(1) NOT NULL default '1',
  `featured_date_available` date NOT NULL default '0001-01-01',
  PRIMARY KEY  (`featured_id`),
  KEY `idx_status_zen` (`status`),
  KEY `idx_products_id_zen` (`products_id`),
  KEY `idx_date_avail_zen` (`featured_date_available`),
  KEY `idx_expires_date_zen` (`expires_date`)
)    ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS files_uploaded;
CREATE TABLE files_uploaded (
  `files_uploaded_id` int(11) NOT NULL auto_increment,
  `sesskey` varchar(32) default NULL,
  `customers_id` int(11) default NULL,
  `files_uploaded_name` varchar(64) NOT NULL default '',
  PRIMARY KEY  (`files_uploaded_id`),
  KEY `idx_customers_id_zen` (`customers_id`)
)  COMMENT='Must always have either a sesskey or customers_id' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS geo_zones;
CREATE TABLE geo_zones (
  `geo_zone_id` int(11) NOT NULL auto_increment,
  `geo_zone_name` varchar(32) NOT NULL default '',
  `geo_zone_description` varchar(255) NOT NULL default '',
  `last_modified` datetime default NULL,
  `date_added` datetime NOT NULL default '0001-01-01 00:00:00',
  PRIMARY KEY  (`geo_zone_id`)
)   AUTO_INCREMENT=2 ;

INSERT INTO geo_zones (`geo_zone_id`, `geo_zone_name`, `geo_zone_description`, `last_modified`, `date_added`) VALUES(1, '日本', '', NULL, now());

-- --------------------------------------------------------

DROP TABLE IF EXISTS get_terms_to_filter;
CREATE TABLE get_terms_to_filter (
  `get_term_name` varchar(255) NOT NULL default '',
  `get_term_table` varchar(64) NOT NULL,
  `get_term_name_field` varchar(64) NOT NULL,
  PRIMARY KEY  (`get_term_name`)
) ;

--
-- テーブルのデータをダンプしています `get_terms_to_filter`
--

INSERT INTO get_terms_to_filter (`get_term_name`, `get_term_table`, `get_term_name_field`) VALUES('manufacturers_id', 'TABLE_MANUFACTURERS', 'manufacturers_name');
INSERT INTO get_terms_to_filter (`get_term_name`, `get_term_table`, `get_term_name_field`) VALUES('music_genre_id', 'TABLE_MUSIC_GENRE', 'music_genre_name');
INSERT INTO get_terms_to_filter (`get_term_name`, `get_term_table`, `get_term_name_field`) VALUES('record_company_id', 'TABLE_RECORD_COMPANY', 'record_company_name');

-- --------------------------------------------------------

DROP TABLE IF EXISTS group_pricing;
CREATE TABLE group_pricing (
  `group_id` int(11) NOT NULL auto_increment,
  `group_name` varchar(32) NOT NULL default '',
  `group_percentage` decimal(5,2) NOT NULL default '0.00',
  `last_modified` datetime default NULL,
  `date_added` datetime NOT NULL default '0001-01-01 00:00:00',
  PRIMARY KEY  (`group_id`)
)  AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS languages;
CREATE TABLE languages (
  `languages_id` int(11) NOT NULL auto_increment,
  `name` varchar(32) NOT NULL default '',
  `code` char(2) NOT NULL default '',
  `image` varchar(64) default NULL,
  `directory` varchar(32) default NULL,
  `sort_order` int(3) default NULL,
  PRIMARY KEY  (`languages_id`),
  KEY `idx_languages_name_zen` (`name`)
)   AUTO_INCREMENT=3 ;

INSERT INTO languages (`languages_id`, `name`, `code`, `image`, `directory`, `sort_order`) VALUES(1, 'English', 'en', 'icon.gif', 'english', 2);
INSERT INTO languages (`languages_id`, `name`, `code`, `image`, `directory`, `sort_order`) VALUES(2, 'Japanese', 'ja', 'icon.gif', 'japanese', 1);

-- --------------------------------------------------------

DROP TABLE IF EXISTS layout_boxes;
CREATE TABLE layout_boxes (
  `layout_id` int(11) NOT NULL auto_increment,
  `layout_template` varchar(64) NOT NULL default '',
  `layout_box_name` varchar(64) NOT NULL default '',
  `layout_box_status` tinyint(1) NOT NULL default '0',
  `layout_box_location` tinyint(1) NOT NULL default '0',
  `layout_box_sort_order` int(11) NOT NULL default '0',
  `layout_box_sort_order_single` int(11) NOT NULL default '0',
  `layout_box_status_single` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`layout_id`),
  KEY `idx_name_template_zen` (`layout_template`,`layout_box_name`),
  KEY `idx_layout_box_status_zen` (`layout_box_status`),
  KEY `idx_layout_box_sort_order_zen` (`layout_box_sort_order`)
)   AUTO_INCREMENT=103 ;

--
-- テーブルのデータをダンプしています `layout_boxes`
--

INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(1, 'default_template_settings', 'banner_box_all.php', 1, 1, 5, 0, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(2, 'default_template_settings', 'banner_box.php', 1, 0, 300, 1, 127);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(3, 'default_template_settings', 'banner_box2.php', 1, 1, 15, 1, 15);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(4, 'default_template_settings', 'best_sellers.php', 1, 1, 30, 70, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(5, 'default_template_settings', 'categories.php', 1, 0, 10, 10, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(6, 'default_template_settings', 'currencies.php', 1, 1, 80, 60, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(7, 'default_template_settings', 'document_categories.php', 1, 0, 0, 0, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(8, 'default_template_settings', 'ezpages.php', 1, 1, -1, 2, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(9, 'default_template_settings', 'featured.php', 1, 0, 45, 0, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(10, 'default_template_settings', 'information.php', 1, 0, 50, 40, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(11, 'default_template_settings', 'languages.php', 1, 1, 70, 50, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(12, 'default_template_settings', 'manufacturers.php', 1, 0, 30, 20, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(13, 'default_template_settings', 'manufacturer_info.php', 1, 1, 35, 95, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(14, 'default_template_settings', 'more_information.php', 1, 0, 200, 200, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(15, 'default_template_settings', 'music_genres.php', 1, 1, 0, 0, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(16, 'default_template_settings', 'order_history.php', 1, 1, 0, 0, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(17, 'default_template_settings', 'product_notifications.php', 1, 1, 55, 85, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(18, 'default_template_settings', 'record_companies.php', 1, 1, 0, 0, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(19, 'default_template_settings', 'reviews.php', 1, 0, 40, 0, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(20, 'default_template_settings', 'search.php', 1, 1, 10, 0, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(21, 'default_template_settings', 'search_header.php', 0, 0, 0, 0, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(22, 'default_template_settings', 'shopping_cart.php', 1, 1, 20, 30, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(23, 'default_template_settings', 'specials.php', 1, 1, 45, 0, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(24, 'default_template_settings', 'tell_a_friend.php', 1, 1, 65, 0, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(25, 'default_template_settings', 'whats_new.php', 1, 0, 20, 0, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(26, 'default_template_settings', 'whos_online.php', 1, 1, 200, 200, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(27, 'template_default', 'banner_box_all.php', 1, 1, 5, 0, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(28, 'template_default', 'banner_box.php', 1, 0, 300, 1, 127);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(29, 'template_default', 'banner_box2.php', 1, 1, 15, 1, 15);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(30, 'template_default', 'best_sellers.php', 1, 1, 30, 70, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(31, 'template_default', 'categories.php', 1, 0, 10, 10, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(32, 'template_default', 'currencies.php', 1, 1, 80, 60, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(33, 'template_default', 'ezpages.php', 1, 1, -1, 2, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(34, 'template_default', 'featured.php', 1, 0, 45, 0, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(35, 'template_default', 'information.php', 1, 0, 50, 40, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(36, 'template_default', 'languages.php', 1, 1, 70, 50, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(37, 'template_default', 'manufacturers.php', 1, 0, 30, 20, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(38, 'template_default', 'manufacturer_info.php', 1, 1, 35, 95, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(39, 'template_default', 'more_information.php', 1, 0, 200, 200, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(40, 'template_default', 'my_broken_box.php', 1, 0, 0, 0, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(41, 'template_default', 'order_history.php', 1, 1, 0, 0, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(42, 'template_default', 'product_notifications.php', 1, 1, 55, 85, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(43, 'template_default', 'reviews.php', 1, 0, 40, 0, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(44, 'template_default', 'search.php', 1, 1, 10, 0, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(45, 'template_default', 'search_header.php', 0, 0, 0, 0, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(46, 'template_default', 'shopping_cart.php', 1, 1, 20, 30, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(47, 'template_default', 'specials.php', 1, 1, 45, 0, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(48, 'template_default', 'tell_a_friend.php', 1, 1, 65, 0, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(49, 'template_default', 'whats_new.php', 1, 0, 20, 0, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(50, 'template_default', 'whos_online.php', 1, 1, 200, 200, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(51, 'classic', 'banner_box.php', 1, 0, 300, 1, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(52, 'classic', 'banner_box2.php', 1, 1, 15, 1, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(53, 'classic', 'banner_box_all.php', 1, 1, 5, 0, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(54, 'classic', 'best_sellers.php', 1, 1, 30, 70, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(55, 'classic', 'categories.php', 1, 0, 10, 10, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(56, 'classic', 'currencies.php', 1, 1, 80, 60, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(57, 'classic', 'document_categories.php', 1, 0, 0, 0, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(58, 'classic', 'ezpages.php', 1, 1, 2, 2, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(59, 'classic', 'featured.php', 1, 0, 45, 0, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(60, 'classic', 'information.php', 1, 0, 50, 40, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(61, 'classic', 'languages.php', 1, 1, 70, 50, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(62, 'classic', 'manufacturers.php', 1, 0, 30, 20, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(63, 'classic', 'manufacturer_info.php', 1, 1, 35, 95, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(64, 'classic', 'more_information.php', 1, 0, 200, 200, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(65, 'classic', 'music_genres.php', 1, 1, 0, 0, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(66, 'classic', 'order_history.php', 1, 1, 0, 0, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(67, 'classic', 'product_notifications.php', 1, 1, 55, 85, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(68, 'classic', 'record_companies.php', 1, 1, 0, 0, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(69, 'classic', 'reviews.php', 1, 0, 40, 0, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(70, 'classic', 'search.php', 1, 1, 10, 0, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(71, 'classic', 'search_header.php', 0, 0, 0, 0, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(72, 'classic', 'shopping_cart.php', 1, 1, 20, 30, 1);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(73, 'classic', 'specials.php', 1, 1, 45, 0, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(74, 'classic', 'tell_a_friend.php', 1, 1, 65, 0, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(75, 'classic', 'whats_new.php', 1, 0, 20, 0, 0);
INSERT INTO layout_boxes (`layout_id`, `layout_template`, `layout_box_name`, `layout_box_status`, `layout_box_location`, `layout_box_sort_order`, `layout_box_sort_order_single`, `layout_box_status_single`) VALUES(76, 'classic', 'whos_online.php', 1, 1, 200, 200, 1);

-- --------------------------------------------------------


DROP TABLE IF EXISTS manufacturers;
CREATE TABLE manufacturers (
  `manufacturers_id` int(11) NOT NULL auto_increment,
  `manufacturers_name` varchar(32) NOT NULL default '',
  `manufacturers_image` varchar(64) default NULL,
  `date_added` datetime default NULL,
  `last_modified` datetime default NULL,
  PRIMARY KEY  (`manufacturers_id`),
  KEY `idx_mfg_name_zen` (`manufacturers_name`)
)  AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS manufacturers_info;
CREATE TABLE manufacturers_info (
  `manufacturers_id` int(11) NOT NULL default '0',
  `languages_id` int(11) NOT NULL default '0',
  `manufacturers_url` varchar(255) NOT NULL default '',
  `url_clicked` int(5) NOT NULL default '0',
  `date_last_click` datetime default NULL,
  PRIMARY KEY  (`manufacturers_id`,`languages_id`)
) ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS media_clips;
CREATE TABLE media_clips (
  `clip_id` int(11) NOT NULL auto_increment,
  `media_id` int(11) NOT NULL default '0',
  `clip_type` smallint(6) NOT NULL default '0',
  `clip_filename` text NOT NULL,
  `date_added` datetime NOT NULL default '0001-01-01 00:00:00',
  `last_modified` datetime NOT NULL default '0001-01-01 00:00:00',
  PRIMARY KEY  (`clip_id`),
  KEY `idx_media_id_zen` (`media_id`),
  KEY `idx_clip_type_zen` (`clip_type`)
)  AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS media_manager;
CREATE TABLE media_manager (
  `media_id` int(11) NOT NULL auto_increment,
  `media_name` varchar(255) NOT NULL default '',
  `last_modified` datetime NOT NULL default '0001-01-01 00:00:00',
  `date_added` datetime NOT NULL default '0001-01-01 00:00:00',
  PRIMARY KEY  (`media_id`),
  KEY `idx_media_name_zen` (`media_name`)
)  AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS media_to_products;
CREATE TABLE media_to_products (
  `media_id` int(11) NOT NULL default '0',
  `product_id` int(11) NOT NULL default '0',
  KEY `idx_media_product_zen` (`media_id`,`product_id`)
) ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types (
  `type_id` int(11) NOT NULL auto_increment,
  `type_name` varchar(64) NOT NULL default '',
  `type_ext` varchar(8) NOT NULL default '',
  PRIMARY KEY  (`type_id`),
  KEY `idx_type_name_zen` (`type_name`)
)   AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS meta_tags_categories_description;
CREATE TABLE meta_tags_categories_description (
  `categories_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL default '1',
  `metatags_title` varchar(255) NOT NULL default '',
  `metatags_keywords` text,
  `metatags_description` text,
  PRIMARY KEY  (`categories_id`,`language_id`)
) ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS meta_tags_products_description;
CREATE TABLE meta_tags_products_description (
  `products_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL default '1',
  `metatags_title` varchar(255) NOT NULL default '',
  `metatags_keywords` text,
  `metatags_description` text,
  PRIMARY KEY  (`products_id`,`language_id`)
) ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS music_genre;
CREATE TABLE music_genre (
  `music_genre_id` int(11) NOT NULL auto_increment,
  `music_genre_name` varchar(32) NOT NULL default '',
  `date_added` datetime default NULL,
  `last_modified` datetime default NULL,
  PRIMARY KEY  (`music_genre_id`),
  KEY `idx_music_genre_name_zen` (`music_genre_name`)
)  AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS newsletters;
CREATE TABLE newsletters (
  `newsletters_id` int(11) NOT NULL auto_increment,
  `title` varchar(255) NOT NULL default '',
  `content` text NOT NULL,
  `content_html` text NOT NULL,
  `module` varchar(255) NOT NULL default '',
  `date_added` datetime NOT NULL default '0001-01-01 00:00:00',
  `date_sent` datetime default NULL,
  `status` int(1) default NULL,
  `locked` int(1) default '0',
  PRIMARY KEY  (`newsletters_id`)
)  AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS nochex_apc_transactions;
CREATE TABLE nochex_apc_transactions (
  `nochex_apc_id` int(11) unsigned NOT NULL auto_increment,
  `order_id` int(11) unsigned NOT NULL default '0',
  `nc_transaction_id` varchar(30) NOT NULL,
  `nc_transaction_date` varchar(100) NOT NULL,
  `nc_to_email` varchar(255) NOT NULL,
  `nc_from_email` varchar(255) NOT NULL,
  `nc_order_id` varchar(255) NOT NULL,
  `nc_custom` varchar(255) NOT NULL,
  `nc_amount` decimal(9,2) NOT NULL,
  `nc_security_key` varchar(255) NOT NULL,
  `nc_status` varchar(15) NOT NULL,
  `nochex_response` varchar(255) NOT NULL,
  `last_modified` datetime NOT NULL default '0001-01-01 00:00:00',
  `date_added` datetime NOT NULL default '0001-01-01 00:00:00',
  `memo` text,
  PRIMARY KEY  (`nochex_apc_id`),
  KEY `idx_order_id_zen` (`order_id`)
)  AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS nochex_sessions;
CREATE TABLE nochex_sessions (
  `unique_id` int(11) NOT NULL auto_increment,
  `session_id` text NOT NULL,
  `saved_session` mediumblob NOT NULL,
  `expiry` int(17) NOT NULL default '0',
  PRIMARY KEY  (`unique_id`),
  KEY `idx_session_id_zen` (`session_id`(36))
)  AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  `orders_id` int(11) NOT NULL auto_increment,
  `customers_id` int(11) NOT NULL default '0',
  `customers_name` varchar(64) NOT NULL default '',
  `customers_company` varchar(255) default NULL,
  `customers_street_address` varchar(64) NOT NULL default '',
  `customers_suburb` varchar(32) default NULL,
  `customers_city` varchar(32) NOT NULL default '',
  `customers_postcode` varchar(10) NOT NULL default '',
  `customers_state` varchar(32) default NULL,
  `customers_country` varchar(32) NOT NULL default '',
  `customers_telephone` varchar(32) NOT NULL default '',
  `customers_email_address` varchar(96) NOT NULL default '',
  `customers_address_format_id` int(5) NOT NULL default '0',
  `delivery_name` varchar(64) NOT NULL default '',
  `delivery_company` varchar(255) default NULL,
  `delivery_street_address` varchar(64) NOT NULL default '',
  `delivery_suburb` varchar(32) default NULL,
  `delivery_city` varchar(32) NOT NULL default '',
  `delivery_postcode` varchar(10) NOT NULL default '',
  `delivery_state` varchar(32) default NULL,
  `delivery_country` varchar(32) NOT NULL default '',
  `delivery_address_format_id` int(5) NOT NULL default '0',
  `billing_name` varchar(64) NOT NULL default '',
  `billing_company` varchar(255) default NULL,
  `billing_street_address` varchar(64) NOT NULL default '',
  `billing_suburb` varchar(32) default NULL,
  `billing_city` varchar(32) NOT NULL default '',
  `billing_postcode` varchar(10) NOT NULL default '',
  `billing_state` varchar(32) default NULL,
  `billing_country` varchar(32) NOT NULL default '',
  `billing_address_format_id` int(5) NOT NULL default '0',
  `payment_method` varchar(128) NOT NULL default '',
  `payment_module_code` varchar(32) NOT NULL default '',
  `shipping_method` varchar(128) NOT NULL default '',
  `shipping_module_code` varchar(32) NOT NULL default '',
  `coupon_code` varchar(32) NOT NULL default '',
  `cc_type` varchar(20) default NULL,
  `cc_owner` varchar(64) default NULL,
  `cc_number` varchar(32) default NULL,
  `cc_expires` varchar(4) default NULL,
  `cc_cvv` blob,
  `last_modified` datetime default NULL,
  `date_purchased` datetime default NULL,
  `orders_status` int(5) NOT NULL default '0',
  `orders_date_finished` datetime default NULL,
  `currency` char(3) default NULL,
  `currency_value` decimal(14,6) default NULL,
  `order_total` decimal(14,2) default NULL,
  `order_tax` decimal(14,2) default NULL,
  `paypal_ipn_id` int(11) NOT NULL default '0',
  `ip_address` varchar(96) NOT NULL default '',
  `delivery_telephone` varchar(32) NOT NULL,
  `delivery_fax` varchar(32) NOT NULL,
  `billing_telephone` varchar(32) NOT NULL,
  `billing_fax` varchar(32) NOT NULL,
  `customers_fax` varchar(32) NOT NULL,
  `customers_name_kana` varchar(128) NOT NULL,
  `delivery_name_kana` varchar(128) NOT NULL,
  `billing_name_kana` varchar(128) NOT NULL,
  PRIMARY KEY  (`orders_id`),
  KEY `idx_status_orders_cust_zen` (`orders_status`,`orders_id`,`customers_id`),
  KEY `idx_date_purchased_zen` (`date_purchased`)
)   AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
  `orders_products_id` int(11) NOT NULL auto_increment,
  `orders_id` int(11) NOT NULL default '0',
  `products_id` int(11) NOT NULL default '0',
  `products_model` varchar(32) default NULL,
  `products_name` varchar(64) NOT NULL default '',
  `products_price` decimal(15,4) NOT NULL default '0.0000',
  `final_price` decimal(15,4) NOT NULL default '0.0000',
  `products_tax` decimal(7,4) NOT NULL default '0.0000',
  `products_quantity` float NOT NULL default '0',
  `onetime_charges` decimal(15,4) NOT NULL default '0.0000',
  `products_priced_by_attribute` tinyint(1) NOT NULL default '0',
  `product_is_free` tinyint(1) NOT NULL default '0',
  `products_discount_type` tinyint(1) NOT NULL default '0',
  `products_discount_type_from` tinyint(1) NOT NULL default '0',
  `products_prid` tinytext NOT NULL,
  PRIMARY KEY  (`orders_products_id`),
  KEY `idx_orders_id_prod_id_zen` (`orders_id`,`products_id`)
)   AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS orders_products_attributes;
CREATE TABLE orders_products_attributes (
  `orders_products_attributes_id` int(11) NOT NULL auto_increment,
  `orders_id` int(11) NOT NULL default '0',
  `orders_products_id` int(11) NOT NULL default '0',
  `products_options` varchar(32) NOT NULL default '',
  `products_options_values` text NOT NULL,
  `options_values_price` decimal(15,4) NOT NULL default '0.0000',
  `price_prefix` char(1) NOT NULL default '',
  `product_attribute_is_free` tinyint(1) NOT NULL default '0',
  `products_attributes_weight` float NOT NULL default '0',
  `products_attributes_weight_prefix` char(1) NOT NULL default '',
  `attributes_discounted` tinyint(1) NOT NULL default '1',
  `attributes_price_base_included` tinyint(1) NOT NULL default '1',
  `attributes_price_onetime` decimal(15,4) NOT NULL default '0.0000',
  `attributes_price_factor` decimal(15,4) NOT NULL default '0.0000',
  `attributes_price_factor_offset` decimal(15,4) NOT NULL default '0.0000',
  `attributes_price_factor_onetime` decimal(15,4) NOT NULL default '0.0000',
  `attributes_price_factor_onetime_offset` decimal(15,4) NOT NULL default '0.0000',
  `attributes_qty_prices` text,
  `attributes_qty_prices_onetime` text,
  `attributes_price_words` decimal(15,4) NOT NULL default '0.0000',
  `attributes_price_words_free` int(4) NOT NULL default '0',
  `attributes_price_letters` decimal(15,4) NOT NULL default '0.0000',
  `attributes_price_letters_free` int(4) NOT NULL default '0',
  `products_options_id` int(11) NOT NULL default '0',
  `products_options_values_id` int(11) NOT NULL default '0',
  `products_prid` tinytext NOT NULL,
  PRIMARY KEY  (`orders_products_attributes_id`),
  KEY `idx_orders_id_prod_id_zen` (`orders_id`,`orders_products_id`)
)  AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS orders_products_download;
CREATE TABLE orders_products_download (
  `orders_products_download_id` int(11) NOT NULL auto_increment,
  `orders_id` int(11) NOT NULL default '0',
  `orders_products_id` int(11) NOT NULL default '0',
  `orders_products_filename` varchar(255) NOT NULL default '',
  `download_maxdays` int(2) NOT NULL default '0',
  `download_count` int(2) NOT NULL default '0',
  `products_prid` tinytext NOT NULL,
  PRIMARY KEY  (`orders_products_download_id`),
  KEY `idx_orders_id_zen` (`orders_id`),
  KEY `idx_orders_products_id_zen` (`orders_products_id`)
)  AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS orders_status;
CREATE TABLE orders_status (
  `orders_status_id` int(11) NOT NULL default '0',
  `language_id` int(11) NOT NULL default '1',
  `orders_status_name` varchar(32) NOT NULL default '',
  PRIMARY KEY  (`orders_status_id`,`language_id`),
  KEY `idx_orders_status_name_zen` (`orders_status_name`)
) ;

INSERT INTO orders_status  (`orders_status_id`, `language_id`, `orders_status_name`) VALUES(1, 1, 'Pending');
INSERT INTO orders_status  (`orders_status_id`, `language_id`, `orders_status_name`) VALUES(2, 1, 'Processing');
INSERT INTO orders_status  (`orders_status_id`, `language_id`, `orders_status_name`) VALUES(3, 1, 'Delivered');
INSERT INTO orders_status  (`orders_status_id`, `language_id`, `orders_status_name`) VALUES(4, 1, 'Update');
INSERT INTO orders_status  (`orders_status_id`, `language_id`, `orders_status_name`) VALUES(1, 2, '処理待ち');
INSERT INTO orders_status  (`orders_status_id`, `language_id`, `orders_status_name`) VALUES(2, 2, '処理中');
INSERT INTO orders_status  (`orders_status_id`, `language_id`, `orders_status_name`) VALUES(3, 2, '配送済み');
INSERT INTO orders_status  (`orders_status_id`, `language_id`, `orders_status_name`) VALUES(4, 2, '更新');

-- --------------------------------------------------------

DROP TABLE IF EXISTS orders_status_history;
CREATE TABLE orders_status_history (
  `orders_status_history_id` int(11) NOT NULL auto_increment,
  `orders_id` int(11) NOT NULL default '0',
  `orders_status_id` int(5) NOT NULL default '0',
  `date_added` datetime NOT NULL default '0001-01-01 00:00:00',
  `customer_notified` int(1) default '0',
  `comments` text,
  PRIMARY KEY  (`orders_status_history_id`),
  KEY `idx_orders_id_status_id_zen` (`orders_id`,`orders_status_id`)
)   AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS orders_total;
CREATE TABLE orders_total (
  `orders_total_id` int(10) unsigned NOT NULL auto_increment,
  `orders_id` int(11) NOT NULL default '0',
  `title` varchar(255) NOT NULL default '',
  `text` varchar(255) NOT NULL default '',
  `value` decimal(15,4) NOT NULL default '0.0000',
  `class` varchar(32) NOT NULL default '',
  `sort_order` int(11) NOT NULL default '0',
  PRIMARY KEY  (`orders_total_id`),
  KEY `idx_ot_orders_id_zen` (`orders_id`),
  KEY `idx_ot_class_zen` (`class`)
)   AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS paypal;
CREATE TABLE paypal (
  `paypal_ipn_id` int(11) unsigned NOT NULL auto_increment,
  `order_id` int(11) unsigned NOT NULL default '0',
  `txn_type` varchar(40) NOT NULL default '',
  `module_name` varchar(40) NOT NULL default '',
  `module_mode` varchar(40) NOT NULL default '',
  `reason_code` varchar(40) default NULL,
  `payment_type` varchar(40) NOT NULL default '',
  `payment_status` varchar(32) NOT NULL default '',
  `pending_reason` varchar(32) default NULL,
  `invoice` varchar(128) default NULL,
  `mc_currency` char(3) NOT NULL default '',
  `first_name` varchar(32) NOT NULL default '',
  `last_name` varchar(32) NOT NULL default '',
  `payer_business_name` varchar(128) default NULL,
  `address_name` varchar(64) default NULL,
  `address_street` varchar(254) default NULL,
  `address_city` varchar(120) default NULL,
  `address_state` varchar(120) default NULL,
  `address_zip` varchar(10) default NULL,
  `address_country` varchar(64) default NULL,
  `address_status` varchar(11) default NULL,
  `payer_email` varchar(128) NOT NULL default '',
  `payer_id` varchar(32) NOT NULL default '',
  `payer_status` varchar(10) NOT NULL default '',
  `payment_date` datetime NOT NULL default '0001-01-01 00:00:00',
  `business` varchar(128) NOT NULL default '',
  `receiver_email` varchar(128) NOT NULL default '',
  `receiver_id` varchar(32) NOT NULL default '',
  `txn_id` varchar(20) NOT NULL default '',
  `parent_txn_id` varchar(20) default NULL,
  `num_cart_items` tinyint(4) unsigned NOT NULL default '1',
  `mc_gross` decimal(7,2) NOT NULL default '0.00',
  `mc_fee` decimal(7,2) NOT NULL default '0.00',
  `payment_gross` decimal(7,2) default NULL,
  `payment_fee` decimal(7,2) default NULL,
  `settle_amount` decimal(7,2) default NULL,
  `settle_currency` char(3) default NULL,
  `exchange_rate` decimal(4,2) default NULL,
  `notify_version` decimal(2,1) NOT NULL default '0.0',
  `verify_sign` varchar(128) NOT NULL default '',
  `last_modified` datetime NOT NULL default '0001-01-01 00:00:00',
  `date_added` datetime NOT NULL default '0001-01-01 00:00:00',
  `memo` text,
  PRIMARY KEY  (`paypal_ipn_id`,`txn_id`),
  KEY `idx_order_id_zen` (`order_id`)
)  AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS paypal_payment_status;
CREATE TABLE paypal_payment_status (
  `payment_status_id` int(11) NOT NULL auto_increment,
  `payment_status_name` varchar(64) NOT NULL default '',
  PRIMARY KEY  (`payment_status_id`)
)   AUTO_INCREMENT=8 ;

INSERT INTO paypal_payment_status (`payment_status_id`, `payment_status_name`) VALUES(1, 'Completed');
INSERT INTO paypal_payment_status (`payment_status_id`, `payment_status_name`) VALUES(2, 'Pending');
INSERT INTO paypal_payment_status (`payment_status_id`, `payment_status_name`) VALUES(3, 'Failed');
INSERT INTO paypal_payment_status (`payment_status_id`, `payment_status_name`) VALUES(4, 'Denied');
INSERT INTO paypal_payment_status (`payment_status_id`, `payment_status_name`) VALUES(5, 'Refunded');
INSERT INTO paypal_payment_status (`payment_status_id`, `payment_status_name`) VALUES(6, 'Canceled_Reversal');
INSERT INTO paypal_payment_status (`payment_status_id`, `payment_status_name`) VALUES(7, 'Reversed');

-- --------------------------------------------------------

DROP TABLE IF EXISTS paypal_payment_status_history;
CREATE TABLE paypal_payment_status_history (
  `payment_status_history_id` int(11) NOT NULL auto_increment,
  `paypal_ipn_id` int(11) NOT NULL default '0',
  `txn_id` varchar(64) NOT NULL default '',
  `parent_txn_id` varchar(64) NOT NULL default '',
  `payment_status` varchar(17) NOT NULL default '',
  `pending_reason` varchar(14) default NULL,
  `date_added` datetime NOT NULL default '0001-01-01 00:00:00',
  PRIMARY KEY  (`payment_status_history_id`),
  KEY `idx_paypal_ipn_id_zen` (`paypal_ipn_id`)
)  AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS paypal_session;
CREATE TABLE paypal_session (
  `unique_id` int(11) NOT NULL auto_increment,
  `session_id` text NOT NULL,
  `saved_session` mediumblob NOT NULL,
  `expiry` int(17) NOT NULL default '0',
  PRIMARY KEY  (`unique_id`),
  KEY `idx_session_id_zen` (`session_id`(36))
)  AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS paypal_testing;
CREATE TABLE paypal_testing (
  `paypal_ipn_id` int(11) unsigned NOT NULL auto_increment,
  `order_id` int(11) unsigned NOT NULL default '0',
  `custom` varchar(255) NOT NULL default '',
  `txn_type` varchar(40) NOT NULL default '',
  `module_name` varchar(40) NOT NULL default '',
  `module_mode` varchar(40) NOT NULL default '',
  `reason_code` varchar(40) default NULL,
  `payment_type` varchar(40) NOT NULL default '',
  `payment_status` varchar(32) NOT NULL default '',
  `pending_reason` varchar(32) default NULL,
  `invoice` varchar(128) default NULL,
  `mc_currency` char(3) NOT NULL default '',
  `first_name` varchar(32) NOT NULL default '',
  `last_name` varchar(32) NOT NULL default '',
  `payer_business_name` varchar(128) default NULL,
  `address_name` varchar(64) default NULL,
  `address_street` varchar(254) default NULL,
  `address_city` varchar(120) default NULL,
  `address_state` varchar(120) default NULL,
  `address_zip` varchar(10) default NULL,
  `address_country` varchar(64) default NULL,
  `address_status` varchar(11) default NULL,
  `payer_email` varchar(128) NOT NULL default '',
  `payer_id` varchar(32) NOT NULL default '',
  `payer_status` varchar(10) NOT NULL default '',
  `payment_date` datetime NOT NULL default '0001-01-01 00:00:00',
  `business` varchar(128) NOT NULL default '',
  `receiver_email` varchar(128) NOT NULL default '',
  `receiver_id` varchar(32) NOT NULL default '',
  `txn_id` varchar(20) NOT NULL default '',
  `parent_txn_id` varchar(20) default NULL,
  `num_cart_items` tinyint(4) unsigned NOT NULL default '1',
  `mc_gross` decimal(7,2) NOT NULL default '0.00',
  `mc_fee` decimal(7,2) NOT NULL default '0.00',
  `payment_gross` decimal(7,2) default NULL,
  `payment_fee` decimal(7,2) default NULL,
  `settle_amount` decimal(7,2) default NULL,
  `settle_currency` char(3) default NULL,
  `exchange_rate` decimal(4,2) default NULL,
  `notify_version` decimal(2,1) NOT NULL default '0.0',
  `verify_sign` varchar(128) NOT NULL default '',
  `last_modified` datetime NOT NULL default '0001-01-01 00:00:00',
  `date_added` datetime NOT NULL default '0001-01-01 00:00:00',
  `memo` text,
  PRIMARY KEY  (`paypal_ipn_id`,`txn_id`),
  KEY `idx_order_id_zen` (`order_id`)
)  AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS products;
CREATE TABLE products (
  `products_id` int(11) NOT NULL auto_increment,
  `products_type` int(11) NOT NULL default '1',
  `products_quantity` float NOT NULL default '0',
  `products_model` varchar(32) default NULL,
  `products_image` varchar(64) default NULL,
  `products_price` decimal(15,4) NOT NULL default '0.0000',
  `products_virtual` tinyint(1) NOT NULL default '0',
  `products_date_added` datetime NOT NULL default '0001-01-01 00:00:00',
  `products_last_modified` datetime default NULL,
  `products_date_available` datetime default NULL,
  `products_weight` float NOT NULL default '0',
  `products_status` tinyint(1) NOT NULL default '0',
  `products_tax_class_id` int(11) NOT NULL default '0',
  `manufacturers_id` int(11) default NULL,
  `products_ordered` float NOT NULL default '0',
  `products_quantity_order_min` float NOT NULL default '1',
  `products_quantity_order_units` float NOT NULL default '1',
  `products_priced_by_attribute` tinyint(1) NOT NULL default '0',
  `product_is_free` tinyint(1) NOT NULL default '0',
  `product_is_call` tinyint(1) NOT NULL default '0',
  `products_quantity_mixed` tinyint(1) NOT NULL default '0',
  `product_is_always_free_shipping` tinyint(1) NOT NULL default '0',
  `products_qty_box_status` tinyint(1) NOT NULL default '1',
  `products_quantity_order_max` float NOT NULL default '0',
  `products_sort_order` int(11) NOT NULL default '0',
  `products_discount_type` tinyint(1) NOT NULL default '0',
  `products_discount_type_from` tinyint(1) NOT NULL default '0',
  `products_price_sorter` decimal(15,4) NOT NULL default '0.0000',
  `master_categories_id` int(11) NOT NULL default '0',
  `products_mixed_discount_quantity` tinyint(1) NOT NULL default '1',
  `metatags_title_status` tinyint(1) NOT NULL default '0',
  `metatags_products_name_status` tinyint(1) NOT NULL default '0',
  `metatags_model_status` tinyint(1) NOT NULL default '0',
  `metatags_price_status` tinyint(1) NOT NULL default '0',
  `metatags_title_tagline_status` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`products_id`),
  KEY `idx_products_date_added_zen` (`products_date_added`),
  KEY `idx_products_status_zen` (`products_status`),
  KEY `idx_products_date_available_zen` (`products_date_available`),
  KEY `idx_products_ordered_zen` (`products_ordered`),
  KEY `idx_products_model_zen` (`products_model`),
  KEY `idx_products_price_sorter_zen` (`products_price_sorter`),
  KEY `idx_master_categories_id_zen` (`master_categories_id`),
  KEY `idx_products_sort_order_zen` (`products_sort_order`),
  KEY `idx_manufacturers_id_zen` (`manufacturers_id`)
)   AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS products_attributes;
CREATE TABLE products_attributes (
  `products_attributes_id` int(11) NOT NULL auto_increment,
  `products_id` int(11) NOT NULL default '0',
  `options_id` int(11) NOT NULL default '0',
  `options_values_id` int(11) NOT NULL default '0',
  `options_values_price` decimal(15,4) NOT NULL default '0.0000',
  `price_prefix` char(1) NOT NULL default '',
  `products_options_sort_order` int(11) NOT NULL default '0',
  `product_attribute_is_free` tinyint(1) NOT NULL default '0',
  `products_attributes_weight` float NOT NULL default '0',
  `products_attributes_weight_prefix` char(1) NOT NULL default '',
  `attributes_display_only` tinyint(1) NOT NULL default '0',
  `attributes_default` tinyint(1) NOT NULL default '0',
  `attributes_discounted` tinyint(1) NOT NULL default '1',
  `attributes_image` varchar(64) default NULL,
  `attributes_price_base_included` tinyint(1) NOT NULL default '1',
  `attributes_price_onetime` decimal(15,4) NOT NULL default '0.0000',
  `attributes_price_factor` decimal(15,4) NOT NULL default '0.0000',
  `attributes_price_factor_offset` decimal(15,4) NOT NULL default '0.0000',
  `attributes_price_factor_onetime` decimal(15,4) NOT NULL default '0.0000',
  `attributes_price_factor_onetime_offset` decimal(15,4) NOT NULL default '0.0000',
  `attributes_qty_prices` text,
  `attributes_qty_prices_onetime` text,
  `attributes_price_words` decimal(15,4) NOT NULL default '0.0000',
  `attributes_price_words_free` int(4) NOT NULL default '0',
  `attributes_price_letters` decimal(15,4) NOT NULL default '0.0000',
  `attributes_price_letters_free` int(4) NOT NULL default '0',
  `attributes_required` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`products_attributes_id`),
  KEY `idx_id_options_id_values_zen` (`products_id`,`options_id`,`options_values_id`),
  KEY `idx_opt_sort_order_zen` (`products_options_sort_order`)
)   AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS products_attributes_download;
CREATE TABLE products_attributes_download (
  `products_attributes_id` int(11) NOT NULL default '0',
  `products_attributes_filename` varchar(255) NOT NULL default '',
  `products_attributes_maxdays` int(2) default '0',
  `products_attributes_maxcount` int(2) default '0',
  PRIMARY KEY  (`products_attributes_id`)
) ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS products_description;
CREATE TABLE products_description (
  `products_id` int(11) NOT NULL auto_increment,
  `language_id` int(11) NOT NULL default '1',
  `products_name` varchar(64) NOT NULL default '',
  `products_description` text,
  `products_url` varchar(255) default NULL,
  `products_viewed` int(5) default '0',
  PRIMARY KEY  (`products_id`,`language_id`),
  KEY `idx_products_name_zen` (`products_name`)
)   AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS products_discount_quantity;
CREATE TABLE products_discount_quantity (
  `discount_id` int(4) NOT NULL default '0',
  `products_id` int(11) NOT NULL default '0',
  `discount_qty` float NOT NULL default '0',
  `discount_price` decimal(15,4) NOT NULL default '0.0000',
  KEY `idx_id_qty_zen` (`products_id`,`discount_qty`)
) ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS products_notifications;
CREATE TABLE products_notifications (
  `products_id` int(11) NOT NULL default '0',
  `customers_id` int(11) NOT NULL default '0',
  `date_added` datetime NOT NULL default '0001-01-01 00:00:00',
  PRIMARY KEY  (`products_id`,`customers_id`)
) ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS products_options;
CREATE TABLE products_options (
  `products_options_id` int(11) NOT NULL default '0',
  `language_id` int(11) NOT NULL default '1',
  `products_options_name` varchar(32) NOT NULL default '',
  `products_options_sort_order` int(11) NOT NULL default '0',
  `products_options_type` int(5) NOT NULL default '0',
  `products_options_length` smallint(2) NOT NULL default '32',
  `products_options_comment` varchar(64) default NULL,
  `products_options_size` smallint(2) NOT NULL default '32',
  `products_options_images_per_row` int(2) default '5',
  `products_options_images_style` int(1) default '0',
  `products_options_rows` smallint(2) NOT NULL default '1',
  PRIMARY KEY  (`products_options_id`,`language_id`),
  KEY `idx_lang_id_zen` (`language_id`),
  KEY `idx_products_options_sort_order_zen` (`products_options_sort_order`),
  KEY `idx_products_options_name_zen` (`products_options_name`)
) ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS products_options_types;
CREATE TABLE products_options_types (
  `products_options_types_id` int(11) NOT NULL default '0',
  `products_options_types_name` varchar(32) default NULL,
  PRIMARY KEY  (`products_options_types_id`)
)  COMMENT='Track products_options_types';

INSERT INTO products_options_types (`products_options_types_id`, `products_options_types_name`) VALUES(0, 'Dropdown');
INSERT INTO products_options_types (`products_options_types_id`, `products_options_types_name`) VALUES(1, 'Text');
INSERT INTO products_options_types (`products_options_types_id`, `products_options_types_name`) VALUES(2, 'Radio');
INSERT INTO products_options_types (`products_options_types_id`, `products_options_types_name`) VALUES(3, 'Checkbox');
INSERT INTO products_options_types (`products_options_types_id`, `products_options_types_name`) VALUES(4, 'File');
INSERT INTO products_options_types (`products_options_types_id`, `products_options_types_name`) VALUES(5, 'Read Only');

-- --------------------------------------------------------

DROP TABLE IF EXISTS products_options_values;
CREATE TABLE products_options_values (
  `products_options_values_id` int(11) NOT NULL default '0',
  `language_id` int(11) NOT NULL default '1',
  `products_options_values_name` varchar(64) NOT NULL default '',
  `products_options_values_sort_order` int(11) NOT NULL default '0',
  PRIMARY KEY  (`products_options_values_id`,`language_id`),
  KEY `idx_products_options_values_name_zen` (`products_options_values_name`),
  KEY `idx_products_options_values_sort_order_zen` (`products_options_values_sort_order`)
) ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS products_options_values_to_products_options;
CREATE TABLE products_options_values_to_products_options (
  `products_options_values_to_products_options_id` int(11) NOT NULL auto_increment,
  `products_options_id` int(11) NOT NULL default '0',
  `products_options_values_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`products_options_values_to_products_options_id`),
  KEY `idx_products_options_id_zen` (`products_options_id`),
  KEY `idx_products_options_values_id_zen` (`products_options_values_id`)
)   AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS products_to_categories;
CREATE TABLE products_to_categories (
  `products_id` int(11) NOT NULL default '0',
  `categories_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`products_id`,`categories_id`),
  KEY `idx_cat_prod_id_zen` (`categories_id`,`products_id`)
) ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS product_music_extra;
CREATE TABLE product_music_extra (
  `products_id` int(11) NOT NULL default '0',
  `artists_id` int(11) NOT NULL default '0',
  `record_company_id` int(11) NOT NULL default '0',
  `music_genre_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`products_id`),
  KEY `idx_music_genre_id_zen` (`music_genre_id`),
  KEY `idx_artists_id_zen` (`artists_id`),
  KEY `idx_record_company_id_zen` (`record_company_id`)
) ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS product_types;
CREATE TABLE product_types (
  `type_id` int(11) NOT NULL auto_increment,
  `type_name` varchar(255) NOT NULL default '',
  `type_handler` varchar(255) NOT NULL default '',
  `type_master_type` int(11) NOT NULL default '1',
  `allow_add_to_cart` char(1) NOT NULL default 'Y',
  `default_image` varchar(255) NOT NULL default '',
  `date_added` datetime NOT NULL default '0001-01-01 00:00:00',
  `last_modified` datetime NOT NULL default '0001-01-01 00:00:00',
  PRIMARY KEY  (`type_id`),
  KEY `idx_type_master_type_zen` (`type_master_type`)
)   AUTO_INCREMENT=6 ;

INSERT INTO product_types (`type_id`, `type_name`, `type_handler`, `type_master_type`, `allow_add_to_cart`, `default_image`, `date_added`, `last_modified`) VALUES(1, 'Product - General', 'product', 1, 'Y', '', '2008-01-18 12:04:45', '2008-01-18 12:04:45');
INSERT INTO product_types (`type_id`, `type_name`, `type_handler`, `type_master_type`, `allow_add_to_cart`, `default_image`, `date_added`, `last_modified`) VALUES(2, 'Product - Music', 'product_music', 1, 'Y', '', '2008-01-18 12:04:45', '2008-01-18 12:04:45');
INSERT INTO product_types (`type_id`, `type_name`, `type_handler`, `type_master_type`, `allow_add_to_cart`, `default_image`, `date_added`, `last_modified`) VALUES(3, 'Document - General', 'document_general', 3, 'N', '', '2008-01-18 12:04:45', '2008-01-18 12:04:45');
INSERT INTO product_types (`type_id`, `type_name`, `type_handler`, `type_master_type`, `allow_add_to_cart`, `default_image`, `date_added`, `last_modified`) VALUES(4, 'Document - Product', 'document_product', 3, 'Y', '', '2008-01-18 12:04:45', '2008-01-18 12:04:45');
INSERT INTO product_types (`type_id`, `type_name`, `type_handler`, `type_master_type`, `allow_add_to_cart`, `default_image`, `date_added`, `last_modified`) VALUES(5, 'Product - Free Shipping', 'product_free_shipping', 1, 'Y', '', '2008-01-18 12:04:45', '2008-01-18 12:04:45');

-- --------------------------------------------------------

DROP TABLE IF EXISTS product_types_to_category;
CREATE TABLE product_types_to_category (
  `product_type_id` int(11) NOT NULL default '0',
  `category_id` int(11) NOT NULL default '0',
  KEY `idx_category_id_zen` (`category_id`),
  KEY `idx_product_type_id_zen` (`product_type_id`)
) ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS product_type_layout;
CREATE TABLE product_type_layout (
  `configuration_id` int(11) NOT NULL auto_increment,
  `configuration_title` text NOT NULL,
  `configuration_key` varchar(255) NOT NULL default '',
  `configuration_value` text NOT NULL,
  `configuration_description` text NOT NULL,
  `product_type_id` int(11) NOT NULL default '0',
  `sort_order` int(5) default NULL,
  `last_modified` datetime default NULL,
  `date_added` datetime NOT NULL default '0001-01-01 00:00:00',
  `use_function` text,
  `set_function` text,
  PRIMARY KEY  (`configuration_id`),
  UNIQUE KEY `unq_config_key_zen` (`configuration_key`),
  KEY `idx_key_value_zen` (`configuration_key`,`configuration_value`(10)),
  KEY `idx_type_id_sort_order_zen` (`product_type_id`,`sort_order`)
)   ;

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '型番表示', 'SHOW_PRODUCT_INFO_MODEL', '1', '商品情報で型番を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 1, 1, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '重量表示', 'SHOW_PRODUCT_INFO_WEIGHT', '1', '商品情報で型番を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 1, 2, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'オプション重量表示', 'SHOW_PRODUCT_INFO_WEIGHT_ATTRIBUTES', '1', '商品情報でオプションの重量を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 1, 3, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メーカーの表示', 'SHOW_PRODUCT_INFO_MANUFACTURER', '1', '商品ページに、メーカー名を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 1, 4, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'カート内の数量表示', 'SHOW_PRODUCT_INFO_IN_CART_QTY', '1', '商品情報でカート内の数量を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 1, 5, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '在庫数表示', 'SHOW_PRODUCT_INFO_QUANTITY', '1', '商品情報で在庫数を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 1, 6, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'レビュー数表示', 'SHOW_PRODUCT_INFO_REVIEWS_COUNT', '1', '商品情報でレビュー数を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 1, 7, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'レビューボタン表示', 'SHOW_PRODUCT_INFO_REVIEWS', '1', '商品情報でレビューボタンを表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 1, 8, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '購入可能になった日付の表示', 'SHOW_PRODUCT_INFO_DATE_AVAILABLE', '1', '商品情報で商品が購入可能になった日付を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 1, 9, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '登録日表示', 'SHOW_PRODUCT_INFO_DATE_ADDED', '1', '商品情報で商品が登録された日付を表示<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 1, 10, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品URL表示', 'SHOW_PRODUCT_INFO_URL', '1', '商品情報で商品のURLを表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 1, 11, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '追加画像を表示しますか？', 'SHOW_PRODUCT_INFO_ADDITIONAL_IMAGES', '0', '商品詳細ページに追加画像を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 1, 13, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ベース価格の表示', 'SHOW_PRODUCT_INFO_STARTING_AT', '1', '商品ページに、ベース価格を表示<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 1, 12, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「友達に知らせる」ボタン表示', 'SHOW_PRODUCT_INFO_TELL_A_FRIEND', '1', '商品情報で「友達に知らせる」ボタンを表示する<br />\r\n<br />\r\nNote:サイドボックスの「友達に知らせる」とは別の機能です。 \r\nこの設定を「表示しない」にしてもサイドボックスの「友達に知らせる」は消えません。また、サイドボックスの「友達に知らせる」をoffにしてもこのボタン表示の設定に影響はありません。\r\n<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 1, 15, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '送料無料の画像ステータス - カタログ', 'SHOW_PRODUCT_INFO_ALWAYS_FREE_SHIPPING_IMAGE_SWITCH', '1', 'カタログ中で送料無料の画像/テキストを表示する<br />\r\n<br />\r\n0 = 表示しない (No)<br />\r\n1 = 表示する　 (Yes)<br />\r\n', 1, 16, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '税種別のデフォルト - 新商品追加時', 'DEFAULT_PRODUCT_TAX_CLASS_ID', '0', '新商品を追加する時の、税種別のデフォルトIDを入力してください。', 1, 100, NULL, now(), '', '');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'デフォルトをヴァーチャル商品に設定 - 新商品追加時', 'DEFAULT_PRODUCT_PRODUCTS_VIRTUAL', '0', '新商品を追加する時に、デフォルトでヴァーチャル商品に設定しますか？<br />\r\n<br />\r\n0 = デフォルトは通常商品に設定 (False)<br />\r\n1 = デフォルトでヴァーチャル商品に設定　 (True)<br />\r\n', 1, 101, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'デフォルトを常に送料無料に設定 - 新商品追加時', 'DEFAULT_PRODUCT_PRODUCTS_IS_ALWAYS_FREE_SHIPPING', '0', '新商品追加時の配送タイプのデフォルト設定<br />\r\n<br />\r\n0 = 通常の送料を適用 (No,Always OFF)<br />\r\n1 = 常に送料無料 (Yes,Always ON)<br />\r\n2 = 特別：配送先指定の必要な… (Special)<br />\r\n\r\n', 1, 102, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes, Always ON''), array(''id''=>''0'', ''text''=>''No, Always OFF''), array(''id''=>''2'', ''text''=>''Special'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '型番表示', 'SHOW_PRODUCT_MUSIC_INFO_MODEL', '1', '商品情報で型番を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 2, 1, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '重量表示', 'SHOW_PRODUCT_MUSIC_INFO_WEIGHT', '0', '商品情報で型番を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 2, 2, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'オプション重量表示', 'SHOW_PRODUCT_MUSIC_INFO_WEIGHT_ATTRIBUTES', '1', '商品情報でオプションの重量を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 2, 3, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'アーティストの表示', 'SHOW_PRODUCT_MUSIC_INFO_ARTIST', '1', '商品ページに、アーティスト名を表示<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 2, 4, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '音楽ジャンルの表示', 'SHOW_PRODUCT_MUSIC_INFO_GENRE', '1', '商品ページに、音楽ジャンルを表示<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 2, 4, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'レコード会社の表示', 'SHOW_PRODUCT_MUSIC_INFO_RECORD_COMPANY', '1', '商品ページに、レコード会社を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 2, 4, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'カート内の数量表示', 'SHOW_PRODUCT_MUSIC_INFO_IN_CART_QTY', '1', '商品情報でカート内の数量を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 2, 5, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '在庫数表示', 'SHOW_PRODUCT_MUSIC_INFO_QUANTITY', '0', '商品情報で在庫数を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 2, 6, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'レビュー数表示', 'SHOW_PRODUCT_MUSIC_INFO_REVIEWS_COUNT', '1', '商品情報でレビュー数を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 2, 7, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'レビューボタン表示', 'SHOW_PRODUCT_MUSIC_INFO_REVIEWS', '1', '商品情報でレビューボタンを表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 2, 8, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '購入可能になった日付の表示', 'SHOW_PRODUCT_MUSIC_INFO_DATE_AVAILABLE', '1', '商品情報で商品が購入可能になった日付を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 2, 9, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '登録日表示', 'SHOW_PRODUCT_MUSIC_INFO_DATE_ADDED', '1', '商品情報で商品が登録された日付を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 2, 10, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ベース価格の表示', 'SHOW_PRODUCT_MUSIC_INFO_STARTING_AT', '1', '商品ページに、ベース価格を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 2, 12, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '追加画像を表示しますか？', 'SHOW_PRODUCT_MUSIC_INFO_ADDITIONAL_IMAGES', '1', '商品詳細ページに追加画像を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 2, 13, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「友達に知らせる」ボタン表示', 'SHOW_PRODUCT_MUSIC_INFO_TELL_A_FRIEND', '1', '商品情報で「友達に知らせる」ボタンを表示する<br />\r\n<br />\r\nNote:サイドボックスの「友達に知らせる」とは別の機能です。 \r\nこの設定を「表示しない」にしてもサイドボックスの「友達に知らせる」は消えません。また、サイドボックスの「友達に知らせる」をoffにしてもこのボタン表示の設定に影響はありません。\r\n<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />', 2, 15, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '送料無料の画像ステータス - カタログ', 'SHOW_PRODUCT_MUSIC_INFO_ALWAYS_FREE_SHIPPING_IMAGE_SWITCH', '0', 'カタログ中の送料無料の画像/テキストを表示する<br />\r\n<br />\r\n0 = 表示しない (No)<br />\r\n1 = 表示する　 (Yes)<br />\r\n', 2, 16, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '税種別のデフォルト - 新商品追加時', 'DEFAULT_PRODUCT_MUSIC_TAX_CLASS_ID', '0', '新商品を追加する時の、税種別のデフォルトIDを入力してください。', 2, 100, NULL, now(), '', '');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'デフォルトをヴァーチャル商品に設定 - 新商品追加時', 'DEFAULT_PRODUCT_MUSIC_PRODUCTS_VIRTUAL', '0', '新商品を追加する時に、デフォルトでヴァーチャル商品に設定しますか？<br />\r\n<br />\r\n0 = デフォルトは通常商品に設定 (False)<br />\r\n1 = デフォルトでヴァーチャル商品に設定　 (True)<br />', 2, 101, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'デフォルトを常に送料無料に設定 - 新商品追加時', 'DEFAULT_PRODUCT_MUSIC_PRODUCTS_IS_ALWAYS_FREE_SHIPPING', '0', '新商品追加時の配送タイプのデフォルト設定<br />\r\n<br />\r\n0 = 通常の送料を適用 (No,Always OFF)<br />\r\n1 = 常に送料無料 (Yes,Always ON)<br />\r\n2 = 特別：配送先指定の必要な… (Special)<br />', 2, 102, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes, Always ON''), array(''id''=>''0'', ''text''=>''No, Always OFF''), array(''id''=>''2'', ''text''=>''Special'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'レビュー数表示', 'SHOW_DOCUMENT_GENERAL_INFO_REVIEWS_COUNT', '1', '商品情報でレビュー数を表示する <br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 3, 7, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'レビューボタン表示', 'SHOW_DOCUMENT_GENERAL_INFO_REVIEWS', '1', '商品情報でレビューボタンを表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 3, 8, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '購入可能になった日付の表示', 'SHOW_DOCUMENT_GENERAL_INFO_DATE_AVAILABLE', '1', '商品情報で商品が購入可能になった日付を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 3, 9, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '登録日表示', 'SHOW_DOCUMENT_GENERAL_INFO_DATE_ADDED', '1', '商品情報で商品が登録された日付を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 3, 10, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「友達に知らせる」ボタン表示', 'SHOW_DOCUMENT_GENERAL_INFO_TELL_A_FRIEND', '1', '商品情報で「友達に知らせる」ボタンを表示する<br />\r\n<br />\r\nNote:サイドボックスの「友達に知らせる」とは別の機能です。 \r\nこの設定を「表示しない」にしてもサイドボックスの「友達に知らせる」は消えません。また、サイドボックスの「友達に知らせる」をoffにしてもこのボタン表示の設定に影響はありません。\r\n<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />', 3, 15, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品URL表示', 'SHOW_DOCUMENT_GENERAL_INFO_URL', '1', '商品情報で商品のURLを表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 3, 11, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '追加画像を表示しますか？', 'SHOW_DOCUMENT_GENERAL_INFO_ADDITIONAL_IMAGES', '1', '商品詳細ページに追加画像を表示しますか？<br />※この設定項目は現在機能していません<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 3, 13, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '型番表示', 'SHOW_DOCUMENT_PRODUCT_INFO_MODEL', '1', '商品情報で型番を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 4, 1, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '重量表示', 'SHOW_DOCUMENT_PRODUCT_INFO_WEIGHT', '0', '商品情報で型番を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 4, 2, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'オプション重量表示', 'SHOW_DOCUMENT_PRODUCT_INFO_WEIGHT_ATTRIBUTES', '1', '商品情報でオプションの重量を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 4, 3, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メーカーの表示', 'SHOW_DOCUMENT_PRODUCT_INFO_MANUFACTURER', '1', '商品ページに、メーカー名を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 4, 4, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'カート内の数量表示', 'SHOW_DOCUMENT_PRODUCT_INFO_IN_CART_QTY', '1', '商品情報でカート内の数量を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 4, 5, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '在庫数表示', 'SHOW_DOCUMENT_PRODUCT_INFO_QUANTITY', '0', '商品情報で在庫数を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 4, 6, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'レビュー数表示', 'SHOW_DOCUMENT_PRODUCT_INFO_REVIEWS_COUNT', '1', '商品情報でレビュー数を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 4, 7, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'レビューボタン表示', 'SHOW_DOCUMENT_PRODUCT_INFO_REVIEWS', '1', '商品情報でレビューボタンを表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 4, 8, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '購入可能になった日付の表示', 'SHOW_DOCUMENT_PRODUCT_INFO_DATE_AVAILABLE', '1', '商品情報で商品が購入可能になった日付を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 4, 9, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '登録日表示', 'SHOW_DOCUMENT_PRODUCT_INFO_DATE_ADDED', '1', '商品情報で商品が登録された日付を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 4, 10, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品URL表示', 'SHOW_DOCUMENT_PRODUCT_INFO_URL', '1', '商品情報で商品のURLを表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 4, 11, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '追加画像を表示しますか？', 'SHOW_DOCUMENT_PRODUCT_INFO_ADDITIONAL_IMAGES', '1', '商品詳細ページに追加画像を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 4, 13, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ベース価格の表示', 'SHOW_DOCUMENT_PRODUCT_INFO_STARTING_AT', '1', '商品ページに、ベース価格を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 4, 12, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「友達に知らせる」ボタン表示', 'SHOW_DOCUMENT_PRODUCT_INFO_TELL_A_FRIEND', '1', '商品情報で「友達に知らせる」ボタンを表示する<br />\r\n<br />\r\nNote:サイドボックスの「友達に知らせる」とは別の機能です。 \r\nこの設定を「表示しない」にしてもサイドボックスの「友達に知らせる」は消えません。また、サイドボックスの「友達に知らせる」をoffにしてもこのボタン表示の設定に影響はありません。\r\n<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />', 4, 15, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '送料無料の画像ステータス - カタログ', 'SHOW_DOCUMENT_PRODUCT_INFO_ALWAYS_FREE_SHIPPING_IMAGE_SWITCH', '0', 'カタログ中の送料無料の画像/テキストを表示する<br />\r\n<br />\r\n0 = 表示しない (No)<br />\r\n1 = 表示する　 (Yes)<br />\r\n', 4, 16, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '税種別のデフォルト - 新商品追加時', 'DEFAULT_DOCUMENT_PRODUCT_TAX_CLASS_ID', '0', '新商品を追加する時の、税種別のデフォルトIDを入力してください。', 4, 100, NULL, now(), '', '');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'デフォルトをヴァーチャル商品に設定 - 新商品追加時', 'DEFAULT_DOCUMENT_PRODUCT_PRODUCTS_VIRTUAL', '0', '新商品を追加する時に、デフォルトでヴァーチャル商品に設定しますか？<br />\r\n<br />\r\n0 = デフォルトは通常商品に設定 (False)<br />\r\n1 = デフォルトでヴァーチャル商品に設定　 (True)<br />', 4, 101, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'デフォルトを常に送料無料に設定 - 新商品追加時', 'DEFAULT_DOCUMENT_PRODUCT_PRODUCTS_IS_ALWAYS_FREE_SHIPPING', '0', '新商品追加時の配送タイプのデフォルト設定<br />\r\n<br />\r\n0 = 通常の送料を適用 (No,Always OFF)<br />\r\n1 = 常に送料無料 (Yes,Always ON)<br />\r\n2 = 特別：配送先指定の必要な… (Special)<br />', 4, 102, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes, Always ON''), array(''id''=>''0'', ''text''=>''No, Always OFF''), array(''id''=>''2'', ''text''=>''Special'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '型番表示', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_MODEL', '1', '商品情報で型番を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 5, 1, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '重量表示', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_WEIGHT', '0', '商品情報で型番を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 5, 2, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'オプション重量表示', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_WEIGHT_ATTRIBUTES', '1', '商品情報でオプションの重量を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 5, 3, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メーカーの表示', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_MANUFACTURER', '1', '商品ページに、メーカー名を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 5, 4, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'カート内の数量表示', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_IN_CART_QTY', '1', '商品情報でカート内の数量を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 5, 5, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '在庫数表示', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_QUANTITY', '1', '商品情報で在庫数を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 5, 6, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'レビュー数表示', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_REVIEWS_COUNT', '1', '商品情報でレビュー数を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 5, 7, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'レビューボタン表示', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_REVIEWS', '1', '商品情報でレビューボタンを表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 5, 8, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '購入可能になった日付の表示', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_DATE_AVAILABLE', '0', '商品情報で商品が購入可能になった日付を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 5, 9, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '登録日表示', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_DATE_ADDED', '1', '商品情報で商品が登録された日付を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 5, 10, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品URL表示', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_URL', '1', '商品情報で商品のURLを表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 5, 11, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '追加画像を表示しますか？', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_ADDITIONAL_IMAGES', '1', '商品詳細ページに追加画像を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 5, 13, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'ベース価格の表示', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_STARTING_AT', '1', '商品ページに、ベース価格を表示する<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 5, 12, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「友達に知らせる」ボタン表示', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_TELL_A_FRIEND', '1', '商品情報で「友達に知らせる」ボタンを表示する<br />\r\n<br />\r\nNote:サイドボックスの「友達に知らせる」とは別の機能です。 \r\nこの設定を「表示しない」にしてもサイドボックスの「友達に知らせる」は消えません。また、サイドボックスの「友達に知らせる」をoffにしてもこのボタン表示の設定に影響はありません。\r\n<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />', 5, 15, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '送料無料の画像ステータス - カタログ', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_ALWAYS_FREE_SHIPPING_IMAGE_SWITCH', '1', 'カタログ中の送料無料の画像/テキストを表示する<br />\r\n<br />\r\n0 = 表示しない (No)<br />\r\n1 = 表示する　 (Yes)<br />\r\n', 5, 16, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '税種別のデフォルト - 新商品追加時', 'DEFAULT_PRODUCT_FREE_SHIPPING_TAX_CLASS_ID', '0', '新商品を追加する時の、税種別のデフォルトIDを入力してください。', 5, 100, NULL, now(), '', '');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'デフォルトをヴァーチャル商品に設定 - 新商品追加時', 'DEFAULT_PRODUCT_FREE_SHIPPING_PRODUCTS_VIRTUAL', '0', '新商品を追加する時に、デフォルトでヴァーチャル商品に設定しますか？<br />\r\n<br />\r\n0 = デフォルトは通常商品に設定 (False)<br />\r\n1 = デフォルトでヴァーチャル商品に設定　 (True)<br />', 5, 101, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'デフォルトを常に送料無料に設定 - 新商品追加時', 'DEFAULT_PRODUCT_FREE_SHIPPING_PRODUCTS_IS_ALWAYS_FREE_SHIPPING', '1', '新商品追加時の配送タイプのデフォルト設定<br />\r\n<br />\r\n0 = 通常の送料を適用 (No,Always OFF)<br />\r\n1 = 常に送料無料 (Yes,Always ON)<br />\r\n2 = 特別：配送先指定の必要な… (Special)<br />', 5, 102, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes, Always ON''), array(''id''=>''0'', ''text''=>''No, Always OFF''), array(''id''=>''2'', ''text''=>''Special'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メタタグデフォルト設定 - "title" に「タイトル」を表示', 'SHOW_PRODUCT_INFO_METATAGS_TITLE_STATUS', '0', '「タイトル」の設定内容をメタタグ "title" に表示する\r\n<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 1, 50, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メタタグデフォルト設定 - "title" に「商品名」を表示\r\n', 'SHOW_PRODUCT_INFO_METATAGS_PRODUCTS_NAME_STATUS', '1', '「商品名」をメタタグ "title" に表示する\r\n<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />', 1, 51, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メタタグデフォルト設定 - "title" に「型番（モデル）」を表示\r\n', 'SHOW_PRODUCT_INFO_METATAGS_MODEL_STATUS', '1', '「型番（モデル）」をメタタグ "title" に表示する\r\n<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 1, 52, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メタタグデフォルト設定 - "title" に「価格」を表示\r\n', 'SHOW_PRODUCT_INFO_METATAGS_PRICE_STATUS', '1', '「価格」をメタタグ "title" に表示する\r\n<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 1, 53, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メタタグデフォルト設定 - "title" に「タグライン」を表示\r\n', 'SHOW_PRODUCT_INFO_METATAGS_TITLE_TAGLINE_STATUS', '1', '「タグライン」をメタタグ "title" に表示する\r\n<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 1, 54, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メタタグデフォルト設定 - "title" に「タイトル」を表示\r\n', 'SHOW_PRODUCT_MUSIC_INFO_METATAGS_TITLE_STATUS', '1', '「タイトル」の設定内容をメタタグ "title" に表示する\r\n<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 2, 50, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メタタグデフォルト設定 - "title" に「商品名」を表示\r\n', 'SHOW_PRODUCT_MUSIC_INFO_METATAGS_PRODUCTS_NAME_STATUS', '1', '「商品名」をメタタグ "title" に表示する\r\n<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 2, 51, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メタタグデフォルト設定 - "title" に「型番（モデル）」を表示\r\n', 'SHOW_PRODUCT_MUSIC_INFO_METATAGS_MODEL_STATUS', '1', '「型番（モデル）」をメタタグ "title" に表示する\r\n<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 2, 52, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メタタグデフォルト設定 - "title" に「価格」を表示\r\n', 'SHOW_PRODUCT_MUSIC_INFO_METATAGS_PRICE_STATUS', '1', '「価格」をメタタグ "title" に表示する\r\n<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 2, 53, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メタタグデフォルト設定 - "title" に「タグライン」を表示\r\n', 'SHOW_PRODUCT_MUSIC_INFO_METATAGS_TITLE_TAGLINE_STATUS', '1', '「タグライン」をメタタグ "title" に表示する\r\n<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 2, 54, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「タイトル」の設定内容をメタタグ "title" に表示する\r\n', 'SHOW_DOCUMENT_GENERAL_INFO_METATAGS_TITLE_STATUS', '1', '「タイトル」の設定内容をメタタグ "title" に表示する\r\n<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 3, 50, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メタタグデフォルト設定 - "title" に「ドキュメント名」を表示\r\n', 'SHOW_DOCUMENT_GENERAL_INFO_METATAGS_PRODUCTS_NAME_STATUS', '1', '「ドキュメント名」をメタタグ "title" に表示する\r\n<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 3, 51, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メタタグデフォルト設定 - "title" に「タグライン」を表示\r\n', 'SHOW_DOCUMENT_GENERAL_INFO_METATAGS_TITLE_TAGLINE_STATUS', '1', '「タグライン」をメタタグ "title" に表示する\r\n<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 3, 54, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メタタグデフォルト設定 - "title" に「タイトル」を表示\r\n', 'SHOW_DOCUMENT_PRODUCT_INFO_METATAGS_TITLE_STATUS', '1', '「タイトル」の設定内容をメタタグ "title" に表示する\r\n<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 4, 50, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メタタグデフォルト設定 - "title" に「ドキュメント名」を表示\r\n', 'SHOW_DOCUMENT_PRODUCT_INFO_METATAGS_PRODUCTS_NAME_STATUS', '1', '「ドキュメント名」をメタタグ "title" に表示する\r\n<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 4, 51, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メタタグデフォルト設定 - "title" に「ドキュメント型番（モデル）」を表示\r\n', 'SHOW_DOCUMENT_PRODUCT_INFO_METATAGS_MODEL_STATUS', '1', '「ドキュメント型番（モデル）」をメタタグ  "title" に表示する\r\n<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 4, 52, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メタタグデフォルト設定 - "title" に「価格」を表示\r\n', 'SHOW_DOCUMENT_PRODUCT_INFO_METATAGS_PRICE_STATUS', '1', '「価格」をメタタグ "title" に表示する\r\n<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 4, 53, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メタタグデフォルト設定 - "title" に「タグライン」を表示\r\n', 'SHOW_DOCUMENT_PRODUCT_INFO_METATAGS_TITLE_TAGLINE_STATUS', '1', '「タグライン」をメタタグ "title" に表示する\r\n<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 4, 54, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メタタグデフォルト設定 - "title" に「タイトル」を表示\r\n', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_METATAGS_TITLE_STATUS', '1', '「タイトル」の設定内容をメタタグ "title" に表示する\r\n<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 5, 50, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メタタグデフォルト設定 - "title" に「商品名」を表示\r\n', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_METATAGS_PRODUCTS_NAME_STATUS', '1', '「商品名」をメタタグ "title" に表示する\r\n<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 5, 51, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メタタグデフォルト設定 - "title" に「型番（モデル）」を表示\r\n', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_METATAGS_MODEL_STATUS', '1', '「型番（モデル）」をメタタグ "title" に表示する\r\n<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 5, 52, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メタタグデフォルト設定 - "title" に「価格」を表示\r\n', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_METATAGS_PRICE_STATUS', '1', '「価格」をメタタグ "title" に表示する\r\n<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 5, 53, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( 'メタタグデフォルト設定 - "title" に「タグライン」を表示\r\n', 'SHOW_PRODUCT_FREE_SHIPPING_INFO_METATAGS_TITLE_TAGLINE_STATUS', '1', '「タグライン」をメタタグ "title" に表示する\r\n<br />\r\n<br />\r\n0 = 表示しない (False)<br />\r\n1 = 表示する　 (True)<br />\r\n', 5, 54, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''True''), array(''id''=>''0'', ''text''=>''False'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品属性オプションデフォルト設定 - 「表示のみ」', 'DEFAULT_PRODUCT_ATTRIBUTES_DISPLAY_ONLY', '0', '商品属性オプションで「表示のみ」をデフォルト設定にする\r\n<br />\r\n<br />\r\n0 = 「表示のみ」無効(No)<br />\r\n1 = 「表示のみ」有効(Yes)<br />\r\n', 1, 200, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品属性オプションデフォルト設定 - 「無料オプション」', 'DEFAULT_PRODUCT_ATTRIBUTE_IS_FREE', '1', '商品属性オプションで「商品が無料商品のとき\r\n属性による価格も無料にする」をデフォルト設定にする\r\n<br />\r\n<br />\r\n0 = 「無料オプション」無効(No)<br />\r\n1 = 「無料オプション」有効(Yes)<br />\r\n', 1, 201, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品属性オプションデフォルト設定 - 「デフォルト選択」\r\n', 'DEFAULT_PRODUCT_ATTRIBUTES_DEFAULT', '0', '商品属性オプションで「デフォルトで選択される」をデフォルト設定にする\r\n<br />\r\n<br />\r\n0 = 「デフォルト選択」無効(No)<br />\r\n1 = 「デフォルト選択」有効(Yes)<br />\r\n', 1, 202, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品属性オプションデフォルト設定 - 「割引適用」\r\n', 'DEFAULT_PRODUCT_ATTRIBUTES_DISCOUNTED', '1', '商品属性オプションで「属性による価格増減にも特価/セールの割引を適用する」をデフォルト設定にする\r\n<br />\r\n<br />\r\n0 = 「割引適用」無効(No)<br />\r\n1 = 「割引適用」有効(Yes)<br />\r\n', 1, 203, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品属性オプションデフォルト設定 - 「ベース価格に含める」\r\n', 'DEFAULT_PRODUCT_ATTRIBUTES_PRICE_BASE_INCLUDED', '1', '商品属性オプションで「属性による価格増減をベース価格に含める」をデフォルト設定にする\r\n<br />\r\n<br />\r\n0 = 「ベース価格に含める」無効(No)<br />\r\n1 = 「ベース価格に含める」有効(Yes)<br />\r\n', 1, 204, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品属性オプションデフォルト設定 - 「必須項目」\r\n', 'DEFAULT_PRODUCT_ATTRIBUTES_REQUIRED', '0', '商品属性オプションで「テキスト入力を必須にする」をデフォルト設定にする\r\n<br />\r\n<br />\r\n0 = 「必須項目」無効(No)<br />\r\n1 = 「必須項目」有効(Yes)<br />\r\n', 1, 205, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品属性オプションデフォルト設定 - 「価格プリフィックス記号」\r\n', 'DEFAULT_PRODUCT_PRICE_PREFIX', '1', '商品属性オプションで「オプション価格」に設定するデフォルトの記号<br />\r\n<br />\r\n0 = 空欄(Blank)<br />\r\n1 = + (+)<br />\r\n2 = - (-)<br />\r\n', 1, 206, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''0'', ''text''=>''Blank''), array(''id''=>''1'', ''text''=>''+''), array(''id''=>''2'', ''text''=>''-'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品属性オプションデフォルト設定 - 「重量プリフィックス記号」\r\n', 'DEFAULT_PRODUCT_PRODUCTS_ATTRIBUTES_WEIGHT_PREFIX', '1', '商品属性オプションで「オプション重量」に設定するデフォルトの記号<br />\r\n<br />\r\n0 = 空欄(Blank)<br />\r\n1 = + (+)<br />\r\n2 = - (-)<br />\r\n', 1, 207, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''0'', ''text''=>''Blank''), array(''id''=>''1'', ''text''=>''+''), array(''id''=>''2'', ''text''=>''-'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品属性オプションデフォルト設定 - 「表示のみ」\r\n\r\n', 'DEFAULT_PRODUCT_MUSIC_ATTRIBUTES_DISPLAY_ONLY', '0', '商品属性オプションで「表示のみ」をデフォルト設定にする\r\n<br />\r\n<br />\r\n0 = 「表示のみ」無効(No)<br />\r\n1 = 「表示のみ」有効(Yes)<br />\r\n', 2, 200, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品属性オプションデフォルト設定 - 「無料オプション」\r\n', 'DEFAULT_PRODUCT_MUSIC_ATTRIBUTE_IS_FREE', '1', '商品属性オプションで「商品が無料商品のとき\r\n属性による価格も無料にする」をデフォルト設定にする\r\n<br />\r\n<br />\r\n0 = 「無料オプション」無効(No)<br />\r\n1 = 「無料オプション」有効(Yes)<br />\r\n', 2, 201, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品属性オプションデフォルト設定 - 「デフォルトで選択」\r\n', 'DEFAULT_PRODUCT_MUSIC_ATTRIBUTES_DEFAULT', '0', '商品属性オプションで「デフォルトで選択される」をデフォルト設定にする\r\n<br />\r\n<br />\r\n0 = 「デフォルト」無効(No)<br />\r\n1 = 「デフォルト」有効(Yes)<br />\r\n', 2, 202, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品属性オプションデフォルト設定 - 「割引適用」\r\n', 'DEFAULT_PRODUCT_MUSIC_ATTRIBUTES_DISCOUNTED', '1', '商品属性オプションで「属性による価格増減にも特価/セールの割引を適用する」をデフォルト設定にする\r\n<br />\r\n<br />\r\n0 = 「割引適用」無効(No)<br />\r\n1 = 「割引適用」有効(Yes)<br />\r\n', 2, 203, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品属性オプションデフォルト設定 - 「ベース価格に含める」\r\n', 'DEFAULT_PRODUCT_MUSIC_ATTRIBUTES_PRICE_BASE_INCLUDED', '1', '商品属性オプションで「属性による価格増減をベース価格に含める」をデフォルト設定にする\r\n<br />\r\n<br />\r\n0 = 「ベース価格に含める」無効(No)<br />\r\n1 = 「ベース価格に含める」有効(Yes)<br />\r\n', 2, 204, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品属性オプションデフォルト設定 - 「必須項目」\r\n', 'DEFAULT_PRODUCT_MUSIC_ATTRIBUTES_REQUIRED', '0', '商品属性オプションで「テキスト入力を必須にする」をデフォルト設定にする\r\n<br />\r\n<br />\r\n0 = 「必須項目」無効(No)<br />\r\n1 = 「必須項目」有効(Yes)<br />\r\n', 2, 205, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品属性オプションデフォルト設定 - 「価格プリフィックス記号」\r\n', 'DEFAULT_PRODUCT_MUSIC_PRICE_PREFIX', '1', '商品属性オプションで「オプション価格」に設定するデフォルトの記号<br />\r\n<br />\r\n0 = 空欄(Blank)<br />\r\n1 = + (+)<br />\r\n2 = - (-)<br />\r\n', 2, 206, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''0'', ''text''=>''Blank''), array(''id''=>''1'', ''text''=>''+''), array(''id''=>''2'', ''text''=>''-'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '商品属性オプションデフォルト設定 - 「重量プリフィックス記号」\r\n', 'DEFAULT_PRODUCT_MUSIC_PRODUCTS_ATTRIBUTES_WEIGHT_PREFIX', '1', '商品属性オプションで「オプション重量」に設定するデフォルトの記号<br  />\r\n<br />\r\n0 = 空欄(Blank)<br />\r\n1 = + (+)<br />\r\n2 = - (-)<br />\r\n', 2, 207, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''0'', ''text''=>''Blank''), array(''id''=>''1'', ''text''=>''+''), array(''id''=>''2'', ''text''=>''-'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '属性オプションデフォルト設定 - 「表示のみ」\r\n', 'DEFAULT_DOCUMENT_GENERAL_ATTRIBUTES_DISPLAY_ONLY', '0', '属性オプションで「表示のみ」をデフォルト設定にする\r\n<br />\r\n<br />\r\n0 = 「表示のみ」無効(No)<br />\r\n1 = 「表示のみ」有効(Yes)<br />\r\n', 3, 200, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '属性オプションデフォルト設定 - 「無料オプション」\r\n', 'DEFAULT_DOCUMENT_GENERAL_ATTRIBUTE_IS_FREE', '1', '属性オプションで「商品が無料商品のとき属性による価格も無料にする」をデフォルト設定にする\r\n<br />\r\n<br />\r\n0 = 「無料オプション」無効(No)<br />\r\n1 = 「無料オプション」有効(Yes)<br />\r\n', 3, 201, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '属性オプションデフォルト設定 - 「デフォルト選択」\r\n', 'DEFAULT_DOCUMENT_GENERAL_ATTRIBUTES_DEFAULT', '0', '属性オプションで「デフォルトで選択される」をデフォルト設定にする\r\n<br />\r\n<br />\r\n0 = 「デフォルト選択」無効(No)<br />\r\n1 = 「デフォルト選択」有効(Yes)<br />\r\n', 3, 202, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '属性オプションデフォルト設定 - 「割引適用」\r\n', 'DEFAULT_DOCUMENT_GENERAL_ATTRIBUTES_DISCOUNTED', '1', '属性オプションで「属性による価格増減にも特価/セールの割引を適用する」をデフォルト設定にする\r\n<br />\r\n<br />\r\n0 = 「割引適用」無効(No)<br />\r\n1 = 「割引適用」有効(Yes)<br />\r\n', 3, 203, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '属性オプションデフォルト設定 - 「ベース価格に含める」\r\n', 'DEFAULT_DOCUMENT_GENERAL_ATTRIBUTES_PRICE_BASE_INCLUDED', '1', '属性オプションで「属性による価格増減をベース価格に含める」をデフォルト設定にする\r\n<br />\r\n<br />\r\n0 = 「ベース価格に含める」無効(No)<br />\r\n1 = 「ベース価格に含める」有効(Yes)<br />\r\n', 3, 204, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '属性オプションデフォルト設定 - 「必須項目」\r\n', 'DEFAULT_DOCUMENT_GENERAL_ATTRIBUTES_REQUIRED', '0', '属性オプションで「テキスト入力を必須にする\r\n」をデフォルト設定にする\r\n<br />\r\n<br />\r\n0 = 「必須項目」無効(No)<br />\r\n1 = 「必須項目」有効(Yes)<br />\r\n', 3, 205, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '属性オプションデフォルト設定 - 「価格プリフィックス記号」\r\n', 'DEFAULT_DOCUMENT_GENERAL_PRICE_PREFIX', '1', '属性オプションで「オプション価格」に設定するデフォルトの記号<br />\r\n<br />\r\n0 = 空欄(Blank)<br />\r\n1 = + (+)<br />\r\n2 = - (-)<br />\r\n', 3, 206, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''0'', ''text''=>''Blank''), array(''id''=>''1'', ''text''=>''+''), array(''id''=>''2'', ''text''=>''-'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '属性オプションデフォルト設定 - 「重量プリフィックス記号」\r\n', 'DEFAULT_DOCUMENT_GENERAL_PRODUCTS_ATTRIBUTES_WEIGHT_PREFIX', '1', '商品属性オプションで「オプション重量」に設定するデフォルトの記号<br />\r\n<br />\r\n0 = 空欄(Blank)<br />\r\n1 = + (+)<br />\r\n2 = - (-)<br />', 3, 207, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''0'', ''text''=>''Blank''), array(''id''=>''1'', ''text''=>''+''), array(''id''=>''2'', ''text''=>''-'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '属性オプションデフォルト設定 - 「表示のみ」\r\n', 'DEFAULT_DOCUMENT_PRODUCT_ATTRIBUTES_DISPLAY_ONLY', '0', '属性オプションで「表示のみ」をデフォルト設定にする\r\n<br />\r\n<br />\r\n0 = 「表示のみ」無効(No)<br />\r\n1 = 「表示のみ」有効(Yes)<br />\r\n', 4, 200, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '属性オプションデフォルト設定 - 「無料オプション」\r\n', 'DEFAULT_DOCUMENT_PRODUCT_ATTRIBUTE_IS_FREE', '1', '属性オプションで「商品が無料商品のとき属性による価格も無料にする」をデフォルト設定にする\r\n<br />\r\n<br />\r\n0 = 「無料オプション」無効(No)<br />\r\n1 = 「無料オプション」有効(Yes)<br />\r\n', 4, 201, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '属性オプションデフォルト設定 - 「デフォルト選択」\r\n', 'DEFAULT_DOCUMENT_PRODUCT_ATTRIBUTES_DEFAULT', '0', '属性オプションで「デフォルトで選択される」をデフォルト設定にする\r\n<br />\r\n<br />\r\n0 = 「デフォルト選択」無効(No)<br />\r\n1 = 「デフォルト選択」有効(Yes)<br />\r\n', 4, 202, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');
INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '属性オプションデフォルト設定 - 「割引適用」\r\n', 'DEFAULT_DOCUMENT_PRODUCT_ATTRIBUTES_DISCOUNTED', '1', '属性オプションで「属性による価格増減にも特価/セールの割引を適用する」をデフォルト設定にする\r\n<br />\r\n<br />\r\n0 = 「割引適用」無効(No)<br />\r\n1 = 「割引適用」有効(Yes)<br />\r\n', 4, 203, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '属性オプションデフォルト設定 - 「ベース価格に含める」\r\n', 'DEFAULT_DOCUMENT_PRODUCT_ATTRIBUTES_PRICE_BASE_INCLUDED', '1', '属性オプションで「属性による価格増減をベース価格に含める」をデフォルト設定にする\r\n<br />\r\n<br />\r\n0 = 「ベース価格に含める」無効(No)<br />\r\n1 = 「ベース価格に含める」有効(Yes)<br />\r\n', 4, 204, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '属性オプションデフォルト設定 - 「必須項目」\r\n', 'DEFAULT_DOCUMENT_PRODUCT_ATTRIBUTES_REQUIRED', '0', '属性オプションで「テキスト入力を必須にする」をデフォルト設定にする\r\n<br />\r\n<br />\r\n0 = 「必須項目」無効(No)<br />\r\n1 = 「必須項目」有効(Yes)<br />\r\n', 4, 205, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '属性オプションデフォルト設定 - 「価格プリフィックス記号」\r\n', 'DEFAULT_DOCUMENT_PRODUCT_PRICE_PREFIX', '1', '属性オプションで「オプション価格」に設定するデフォルトの記号<br />\r\n<br />\r\n0 = 空欄(Blank)<br />\r\n1 = + (+)<br />\r\n2 = - (-)<br />', 4, 206, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''0'', ''text''=>''Blank''), array(''id''=>''1'', ''text''=>''+''), array(''id''=>''2'', ''text''=>''-'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '属性オプションデフォルト設定 - 「重量プリフィックス記号」\r\n', 'DEFAULT_DOCUMENT_PRODUCT_PRODUCTS_ATTRIBUTES_WEIGHT_PREFIX', '1', '属性オプションで「オプション重量」に設定するデフォルトの記号<br />\r\n<br />\r\n0 = 空欄(Blank)<br />\r\n1 = + (+)<br />\r\n2 = - (-)<br />\r\n', 4, 207, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''0'', ''text''=>''Blank''), array(''id''=>''1'', ''text''=>''+''), array(''id''=>''2'', ''text''=>''-'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '属性オプションデフォルト設定 - 「表示のみ」\r\n', 'DEFAULT_PRODUCT_FREE_SHIPPING_ATTRIBUTES_DISPLAY_ONLY', '0', '属性オプションで「表示のみ」をデフォルト設定にする\r\n<br />\r\n<br />\r\n0 = 「表示のみ」無効(No)<br />\r\n1 = 「表示のみ」有効(Yes)<br />\r\n', 5, 201, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '属性オプションデフォルト設定 - 「無料オプション」\r\n', 'DEFAULT_PRODUCT_FREE_SHIPPING_ATTRIBUTE_IS_FREE', '1', '属性オプションで「商品が無料商品のとき属性による価格も無料にする」をデフォルト設定にする\r\n<br />\r\n<br />\r\n0 = 「無料オプション」無効(No)<br />\r\n1 = 「無料オプション」有効(Yes)<br />\r\n', 5, 201, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '属性オプションデフォルト設定 - 「デフォルト選択」\r\n', 'DEFAULT_PRODUCT_FREE_SHIPPING_ATTRIBUTES_DEFAULT', '0', '属性オプションで「デフォルトで選択される」をデフォルト設定にする\r\n<br />\r\n<br />\r\n0 = 「デフォルト選択」無効(No)<br />\r\n1 = 「デフォルト選択」有効(Yes)<br />\r\n', 5, 202, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '属性オプションデフォルト設定 - 「割引適用」\r\n', 'DEFAULT_PRODUCT_FREE_SHIPPING_ATTRIBUTES_DISCOUNTED', '1', '属性オプションで「属性による価格増減にも特価/セールの割引を適用する」をデフォルト設定にする\r\n<br />\r\n<br />\r\n0 = 「割引適用」無効(No)<br />\r\n1 = 「割引適用」有効(Yes)<br />\r\n', 5, 203, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '属性オプションデフォルト設定 - 「ベース価格に含める」\r\n', 'DEFAULT_PRODUCT_FREE_SHIPPING_ATTRIBUTES_PRICE_BASE_INCLUDED', '1', '属性オプションで「属性による価格増減をベース価格に含める」をデフォルト設定にする\r\n<br />\r\n<br />\r\n0 = 「ベース価格に含める」無効(No)<br />\r\n1 = 「ベース価格に含める」有効(Yes)<br />\r\n', 5, 204, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '属性オプションデフォルト設定 - 「必須項目」\r\n', 'DEFAULT_PRODUCT_FREE_SHIPPING_ATTRIBUTES_REQUIRED', '0', '属性オプションで「テキスト入力を必須にする」をデフォルト設定にする\r\n<br />\r\n<br />\r\n0 = 「必須項目」無効(No)<br />\r\n1 = 「必須項目」有効(Yes)<br />\r\n', 5, 205, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''1'', ''text''=>''Yes''), array(''id''=>''0'', ''text''=>''No'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '属性オプションデフォルト設定 - 「価格プリフィックス記号」\r\n', 'DEFAULT_PRODUCT_FREE_SHIPPING_PRICE_PREFIX', '1', '属性オプションで「オプション価格」に設定するデフォルトの記号<br />\r\n<br />\r\n0 = 空欄(Blank)<br />\r\n1 = + (+)<br />\r\n2 = - (-)<br />\r\n', 5, 206, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''0'', ''text''=>''Blank''), array(''id''=>''1'', ''text''=>''+''), array(''id''=>''2'', ''text''=>''-'')), ');

INSERT INTO product_type_layout ( `configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `product_type_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '属性オプションデフォルト設定 - 「重量プリフィックス記号」\r\n', 'DEFAULT_PRODUCT_FREE_SHIPPING_PRODUCTS_ATTRIBUTES_WEIGHT_PREFIX', '1', '属性オプションで「オプション重量」に設定するデフォルトの記号<br />\r\n<br />\r\n0 = 空欄(Blank)<br />\r\n1 = + (+)<br />\r\n2 = - (-)<br />\r\n', 5, 207, NULL, now(), NULL, 'zen_cfg_select_drop_down(array(array(''id''=>''0'', ''text''=>''Blank''), array(''id''=>''1'', ''text''=>''+''), array(''id''=>''2'', ''text''=>''-'')), ');

-- --------------------------------------------------------

DROP TABLE IF EXISTS project_version;
CREATE TABLE project_version (
  `project_version_id` tinyint(3) NOT NULL auto_increment,
  `project_version_key` varchar(40) NOT NULL default '',
  `project_version_major` varchar(20) NOT NULL default '',
  `project_version_minor` varchar(20) NOT NULL default '',
  `project_version_patch1` varchar(20) NOT NULL default '',
  `project_version_patch2` varchar(20) NOT NULL default '',
  `project_version_patch1_source` varchar(20) NOT NULL default '',
  `project_version_patch2_source` varchar(20) NOT NULL default '',
  `project_version_comment` varchar(250) NOT NULL default '',
  `project_version_date_applied` datetime NOT NULL default '0001-01-01 01:01:01',
  PRIMARY KEY  (`project_version_id`),
  UNIQUE KEY `idx_project_version_key_zen` (`project_version_key`)
)   COMMENT='Database Version Tracking' AUTO_INCREMENT=3 ;

INSERT INTO project_version (`project_version_id`, `project_version_key`, `project_version_major`, `project_version_minor`, `project_version_patch1`, `project_version_patch2`, `project_version_patch1_source`, `project_version_patch2_source`, `project_version_comment`, `project_version_date_applied`) VALUES(1, 'Zen-Cart Main', '1', '3.8', '', '', '', '', 'Fresh Installation', '2008-01-18 12:04:46');
INSERT INTO project_version (`project_version_id`, `project_version_key`, `project_version_major`, `project_version_minor`, `project_version_patch1`, `project_version_patch2`, `project_version_patch1_source`, `project_version_patch2_source`, `project_version_comment`, `project_version_date_applied`) VALUES(2, 'Zen-Cart Database', '1', '3.8', '', '', '', '', 'Fresh Installation', '2008-01-18 12:04:46');

-- --------------------------------------------------------

DROP TABLE IF EXISTS project_version_history;
CREATE TABLE project_version_history (
  `project_version_id` tinyint(3) NOT NULL auto_increment,
  `project_version_key` varchar(40) NOT NULL default '',
  `project_version_major` varchar(20) NOT NULL default '',
  `project_version_minor` varchar(20) NOT NULL default '',
  `project_version_patch` varchar(20) NOT NULL default '',
  `project_version_comment` varchar(250) NOT NULL default '',
  `project_version_date_applied` datetime NOT NULL default '0001-01-01 01:01:01',
  PRIMARY KEY  (`project_version_id`)
)   COMMENT='Database Version Tracking History' AUTO_INCREMENT=3 ;

INSERT INTO project_version_history (`project_version_id`, `project_version_key`, `project_version_major`, `project_version_minor`, `project_version_patch`, `project_version_comment`, `project_version_date_applied`) VALUES(1, 'Zen-Cart Main', '1', '3.8', '', 'Fresh Installation', '2008-01-18 12:04:46');
INSERT INTO project_version_history (`project_version_id`, `project_version_key`, `project_version_major`, `project_version_minor`, `project_version_patch`, `project_version_comment`, `project_version_date_applied`) VALUES(2, 'Zen-Cart Database', '1', '3.8', '', 'Fresh Installation', '2008-01-18 12:04:46');

-- --------------------------------------------------------

DROP TABLE IF EXISTS query_builder;
CREATE TABLE query_builder (
  `query_id` int(11) NOT NULL auto_increment,
  `query_category` varchar(40) NOT NULL default '',
  `query_name` varchar(80) NOT NULL default '',
  `query_description` text NOT NULL,
  `query_string` text NOT NULL,
  `query_keys_list` text NOT NULL,
  PRIMARY KEY  (`query_id`),
  UNIQUE KEY `query_name` (`query_name`)
)   COMMENT='Stores queries for re-use in Admin email and report modules' AUTO_INCREMENT=8 ;

INSERT INTO query_builder (`query_id`, `query_category`, `query_name`, `query_description`, `query_string`, `query_keys_list`) VALUES(1, 'email', 'All Customers', 'Returns all customers name and email address for sending mass emails (ie: for newsletters, coupons, GVs, messages, etc).', 'select customers_email_address, customers_firstname, customers_lastname from TABLE_CUSTOMERS order by customers_lastname, customers_firstname, customers_email_address', '');
INSERT INTO query_builder (`query_id`, `query_category`, `query_name`, `query_description`, `query_string`, `query_keys_list`) VALUES(2, 'email,newsletters', 'All Newsletter Subscribers', 'Returns name and email address of newsletter subscribers', 'select customers_firstname, customers_lastname, customers_email_address from TABLE_CUSTOMERS where customers_newsletter = ''1''', '');
INSERT INTO query_builder (`query_id`, `query_category`, `query_name`, `query_description`, `query_string`, `query_keys_list`) VALUES(3, 'email,newsletters', 'Dormant Customers (>3months) (Subscribers)', 'Subscribers who HAVE purchased something, but have NOT purchased for at least three months.', 'select o.date_purchased, c.customers_email_address, c.customers_lastname, c.customers_firstname from TABLE_CUSTOMERS c, TABLE_ORDERS o WHERE c.customers_id = o.customers_id AND c.customers_newsletter = 1 GROUP BY c.customers_email_address HAVING max(o.date_purchased) <= subdate(now(),INTERVAL 3 MONTH) ORDER BY c.customers_lastname, c.customers_firstname ASC', '');
INSERT INTO query_builder (`query_id`, `query_category`, `query_name`, `query_description`, `query_string`, `query_keys_list`) VALUES(4, 'email,newsletters', 'Active customers in past 3 months (Subscribers)', 'Newsletter subscribers who are also active customers (purchased something) in last 3 months.', 'select c.customers_email_address, c.customers_lastname, c.customers_firstname from TABLE_CUSTOMERS c, TABLE_ORDERS o where c.customers_newsletter = ''1'' AND c.customers_id = o.customers_id and o.date_purchased > subdate(now(),INTERVAL 3 MONTH) GROUP BY c.customers_email_address order by c.customers_lastname, c.customers_firstname ASC', '');
INSERT INTO query_builder (`query_id`, `query_category`, `query_name`, `query_description`, `query_string`, `query_keys_list`) VALUES(5, 'email,newsletters', 'Active customers in past 3 months (Regardless of subscription status)', 'All active customers (purchased something) in last 3 months, ignoring newsletter-subscription status.', 'select c.customers_email_address, c.customers_lastname, c.customers_firstname from TABLE_CUSTOMERS c, TABLE_ORDERS o WHERE c.customers_id = o.customers_id and o.date_purchased > subdate(now(),INTERVAL 3 MONTH) GROUP BY c.customers_email_address order by c.customers_lastname, c.customers_firstname ASC', '');
INSERT INTO query_builder (`query_id`, `query_category`, `query_name`, `query_description`, `query_string`, `query_keys_list`) VALUES(6, 'email,newsletters', 'Administrator', 'Just the email account of the current administrator', 'select ''ADMIN'' as customers_firstname, admin_name as customers_lastname, admin_email as customers_email_address from TABLE_ADMIN where admin_id = $SESSION:admin_id', '');
INSERT INTO query_builder (`query_id`, `query_category`, `query_name`, `query_description`, `query_string`, `query_keys_list`) VALUES(7, 'email,newsletters', 'Customers who have never completed a purchase', 'For sending newsletter to all customers who registered but have never completed a purchase', 'SELECT DISTINCT c.customers_email_address as customers_email_address, c.customers_lastname as customers_lastname, c.customers_firstname as customers_firstname FROM TABLE_CUSTOMERS c LEFT JOIN  TABLE_ORDERS o ON c.customers_id=o.customers_id WHERE o.date_purchased IS NULL', '');

-- --------------------------------------------------------

DROP TABLE IF EXISTS record_artists;
CREATE TABLE record_artists (
  `artists_id` int(11) NOT NULL auto_increment,
  `artists_name` varchar(32) NOT NULL default '',
  `artists_image` varchar(64) default NULL,
  `date_added` datetime default NULL,
  `last_modified` datetime default NULL,
  PRIMARY KEY  (`artists_id`),
  KEY `idx_rec_artists_name_zen` (`artists_name`)
)  AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS record_artists_info;
CREATE TABLE record_artists_info (
  `artists_id` int(11) NOT NULL default '0',
  `languages_id` int(11) NOT NULL default '0',
  `artists_url` varchar(255) NOT NULL default '',
  `url_clicked` int(5) NOT NULL default '0',
  `date_last_click` datetime default NULL,
  PRIMARY KEY  (`artists_id`,`languages_id`)
) ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS record_company;
CREATE TABLE record_company (
  `record_company_id` int(11) NOT NULL auto_increment,
  `record_company_name` varchar(32) NOT NULL default '',
  `record_company_image` varchar(64) default NULL,
  `date_added` datetime default NULL,
  `last_modified` datetime default NULL,
  PRIMARY KEY  (`record_company_id`),
  KEY `idx_rec_company_name_zen` (`record_company_name`)
)  AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS record_company_info;
CREATE TABLE record_company_info (
  `record_company_id` int(11) NOT NULL default '0',
  `languages_id` int(11) NOT NULL default '0',
  `record_company_url` varchar(255) NOT NULL default '',
  `url_clicked` int(5) NOT NULL default '0',
  `date_last_click` datetime default NULL,
  PRIMARY KEY  (`record_company_id`,`languages_id`)
) ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS reviews;
CREATE TABLE reviews (
  `reviews_id` int(11) NOT NULL auto_increment,
  `products_id` int(11) NOT NULL default '0',
  `customers_id` int(11) default NULL,
  `customers_name` varchar(64) NOT NULL default '',
  `reviews_rating` int(1) default NULL,
  `date_added` datetime default NULL,
  `last_modified` datetime default NULL,
  `reviews_read` int(5) NOT NULL default '0',
  `status` int(1) NOT NULL default '1',
  PRIMARY KEY  (`reviews_id`),
  KEY `idx_products_id_zen` (`products_id`),
  KEY `idx_customers_id_zen` (`customers_id`),
  KEY `idx_status_zen` (`status`),
  KEY `idx_date_added_zen` (`date_added`)
)   ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS reviews_description;
CREATE TABLE reviews_description (
  `reviews_id` int(11) NOT NULL default '0',
  `languages_id` int(11) NOT NULL default '0',
  `reviews_text` text NOT NULL,
  PRIMARY KEY  (`reviews_id`,`languages_id`)
) ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS salemaker_sales;
CREATE TABLE salemaker_sales (
  `sale_id` int(11) NOT NULL auto_increment,
  `sale_status` tinyint(4) NOT NULL default '0',
  `sale_name` varchar(30) NOT NULL default '',
  `sale_deduction_value` decimal(15,4) NOT NULL default '0.0000',
  `sale_deduction_type` tinyint(4) NOT NULL default '0',
  `sale_pricerange_from` decimal(15,4) NOT NULL default '0.0000',
  `sale_pricerange_to` decimal(15,4) NOT NULL default '0.0000',
  `sale_specials_condition` tinyint(4) NOT NULL default '0',
  `sale_categories_selected` text,
  `sale_categories_all` text,
  `sale_date_start` date NOT NULL default '0001-01-01',
  `sale_date_end` date NOT NULL default '0001-01-01',
  `sale_date_added` date NOT NULL default '0001-01-01',
  `sale_date_last_modified` date NOT NULL default '0001-01-01',
  `sale_date_status_change` date NOT NULL default '0001-01-01',
  PRIMARY KEY  (`sale_id`),
  KEY `idx_sale_status_zen` (`sale_status`),
  KEY `idx_sale_date_start_zen` (`sale_date_start`),
  KEY `idx_sale_date_end_zen` (`sale_date_end`)
)  AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS sessions;
CREATE TABLE sessions (
  `sesskey` varchar(32) NOT NULL default '',
  `expiry` int(11) unsigned NOT NULL default '0',
  `value` mediumblob NOT NULL,
  PRIMARY KEY  (`sesskey`)
) ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS specials;
CREATE TABLE specials (
  `specials_id` int(11) NOT NULL auto_increment,
  `products_id` int(11) NOT NULL default '0',
  `specials_new_products_price` decimal(15,4) NOT NULL default '0.0000',
  `specials_date_added` datetime default NULL,
  `specials_last_modified` datetime default NULL,
  `expires_date` date NOT NULL default '0001-01-01',
  `date_status_change` datetime default NULL,
  `status` int(1) NOT NULL default '1',
  `specials_date_available` date NOT NULL default '0001-01-01',
  PRIMARY KEY  (`specials_id`),
  KEY `idx_status_zen` (`status`),
  KEY `idx_products_id_zen` (`products_id`),
  KEY `idx_date_avail_zen` (`specials_date_available`),
  KEY `idx_expires_date_zen` (`expires_date`)
)   ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS special_shipping;
CREATE TABLE special_shipping (
  `size` int(3) NOT NULL,
  `area_1` int(6) NOT NULL,
  `area_2` int(6) NOT NULL,
  `area_3` int(6) NOT NULL,
  `area_4` int(6) NOT NULL,
  `area_5` int(6) NOT NULL,
  `area_6` int(6) NOT NULL,
  `area_7` int(6) NOT NULL,
  `area_8` int(6) NOT NULL,
  `area_9` int(6) NOT NULL,
  `area_10` int(6) NOT NULL,
  `area_11` int(6) NOT NULL,
  `area_12` int(6) NOT NULL,
  KEY `size` (`size`)
) ;

INSERT INTO special_shipping (`size`, `area_1`, `area_2`, `area_3`, `area_4`, `area_5`, `area_6`, `area_7`, `area_8`, `area_9`, `area_10`, `area_11`, `area_12`) VALUES(2, 1160, 840, 740, 740, 740, 740, 740, 840, 950, 1050, 1160, 1260);
INSERT INTO special_shipping (`size`, `area_1`, `area_2`, `area_3`, `area_4`, `area_5`, `area_6`, `area_7`, `area_8`, `area_9`, `area_10`, `area_11`, `area_12`) VALUES(5, 1370, 1050, 950, 950, 950, 950, 950, 1050, 1160, 1260, 1370, 1790);
INSERT INTO special_shipping (`size`, `area_1`, `area_2`, `area_3`, `area_4`, `area_5`, `area_6`, `area_7`, `area_8`, `area_9`, `area_10`, `area_11`, `area_12`) VALUES(10, 1580, 1260, 1160, 1160, 1160, 1160, 1160, 1260, 1370, 1470, 1580, 2310);
INSERT INTO special_shipping (`size`, `area_1`, `area_2`, `area_3`, `area_4`, `area_5`, `area_6`, `area_7`, `area_8`, `area_9`, `area_10`, `area_11`, `area_12`) VALUES(15, 1790, 1470, 1370, 1370, 1370, 1370, 1370, 1470, 1580, 1680, 1790, 2840);
INSERT INTO special_shipping (`size`, `area_1`, `area_2`, `area_3`, `area_4`, `area_5`, `area_6`, `area_7`, `area_8`, `area_9`, `area_10`, `area_11`, `area_12`) VALUES(20, 2000, 1680, 1580, 1580, 1580, 1580, 1580, 1680, 1790, 1890, 2000, 3360);
INSERT INTO special_shipping (`size`, `area_1`, `area_2`, `area_3`, `area_4`, `area_5`, `area_6`, `area_7`, `area_8`, `area_9`, `area_10`, `area_11`, `area_12`) VALUES(25, 2210, 1890, 1790, 1790, 1790, 1790, 1790, 1890, 2000, 2100, 2210, 3890);

-- --------------------------------------------------------

DROP TABLE IF EXISTS tax_class;
CREATE TABLE tax_class (
  `tax_class_id` int(11) NOT NULL auto_increment,
  `tax_class_title` varchar(32) NOT NULL default '',
  `tax_class_description` varchar(255) NOT NULL default '',
  `last_modified` datetime default NULL,
  `date_added` datetime NOT NULL default '0001-01-01 00:00:00',
  PRIMARY KEY  (`tax_class_id`)
)   AUTO_INCREMENT=2 ;

INSERT INTO tax_class (`tax_class_id`, `tax_class_title`, `tax_class_description`, `last_modified`, `date_added`) VALUES(1, '消費税', '消費税（日本）', '2007-01-15 11:43:40', '2004-01-21 01:35:29');

-- --------------------------------------------------------

DROP TABLE IF EXISTS tax_rates;
CREATE TABLE tax_rates (
  `tax_rates_id` int(11) NOT NULL auto_increment,
  `tax_zone_id` int(11) NOT NULL default '0',
  `tax_class_id` int(11) NOT NULL default '0',
  `tax_priority` int(5) default '1',
  `tax_rate` decimal(7,4) NOT NULL default '0.0000',
  `tax_description` varchar(255) NOT NULL default '',
  `last_modified` datetime default NULL,
  `date_added` datetime NOT NULL default '0001-01-01 00:00:00',
  PRIMARY KEY  (`tax_rates_id`),
  KEY `idx_tax_zone_id_zen` (`tax_zone_id`),
  KEY `idx_tax_class_id_zen` (`tax_class_id`)
)   AUTO_INCREMENT=2 ;

INSERT INTO tax_rates (`tax_rates_id`, `tax_zone_id`, `tax_class_id`, `tax_priority`, `tax_rate`, `tax_description`, `last_modified`, `date_added`) VALUES(1, 1, 1, 1, 5.0000, '消費税：5%', '2007-01-15 11:44:17', '2006-11-29 16:18:40');

-- --------------------------------------------------------

DROP TABLE IF EXISTS template_select;
CREATE TABLE template_select (
  `template_id` int(11) NOT NULL auto_increment,
  `template_dir` varchar(64) NOT NULL default '',
  `template_language` varchar(64) NOT NULL default '0',
  PRIMARY KEY  (`template_id`),
  KEY `idx_tpl_lang_zen` (`template_language`)
)   AUTO_INCREMENT=3 ;

INSERT INTO template_select (`template_id`, `template_dir`, `template_language`) VALUES(1, 'classic', '0');

-- --------------------------------------------------------

DROP TABLE IF EXISTS upgrade_exceptions;
CREATE TABLE upgrade_exceptions (
  `upgrade_exception_id` smallint(5) NOT NULL auto_increment,
  `sql_file` varchar(50) default NULL,
  `reason` varchar(200) default NULL,
  `errordate` datetime default '0001-01-01 00:00:00',
  `sqlstatement` text,
  PRIMARY KEY  (`upgrade_exception_id`)
)  AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS whos_online;
CREATE TABLE whos_online (
  `customer_id` int(11) default NULL,
  `full_name` varchar(64) NOT NULL default '',
  `session_id` varchar(128) NOT NULL default '',
  `ip_address` varchar(15) NOT NULL default '',
  `time_entry` varchar(14) NOT NULL default '',
  `time_last_click` varchar(14) NOT NULL default '',
  `last_page_url` varchar(255) NOT NULL default '',
  `host_address` text NOT NULL,
  `user_agent` varchar(255) NOT NULL default '',
  KEY `idx_ip_address_zen` (`ip_address`),
  KEY `idx_session_id_zen` (`session_id`),
  KEY `idx_customer_id_zen` (`customer_id`),
  KEY `idx_time_entry_zen` (`time_entry`),
  KEY `idx_time_last_click_zen` (`time_last_click`),
  KEY `idx_last_page_url_zen` (`last_page_url`)
) ;

-- --------------------------------------------------------

DROP TABLE IF EXISTS zones;
CREATE TABLE zones (
  `zone_id` int(11) NOT NULL auto_increment,
  `zone_country_id` int(11) NOT NULL default '0',
  `zone_code` varchar(32) NOT NULL default '',
  `zone_name` varchar(32) NOT NULL default '',
  PRIMARY KEY  (`zone_id`),
  KEY `idx_zone_country_id_zen` (`zone_country_id`),
  KEY `idx_zone_code_zen` (`zone_code`)
)   AUTO_INCREMENT=229 ;

INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(1, 223, 'AL', 'Alabama');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(2, 223, 'AK', 'Alaska');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(3, 223, 'AS', 'American Samoa');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(4, 223, 'AZ', 'Arizona');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(5, 223, 'AR', 'Arkansas');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(6, 223, 'AF', 'Armed Forces Africa');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(7, 223, 'AA', 'Armed Forces Americas');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(8, 223, 'AC', 'Armed Forces Canada');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(9, 223, 'AE', 'Armed Forces Europe');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(10, 223, 'AM', 'Armed Forces Middle East');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(11, 223, 'AP', 'Armed Forces Pacific');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(12, 223, 'CA', 'California');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(13, 223, 'CO', 'Colorado');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(14, 223, 'CT', 'Connecticut');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(15, 223, 'DE', 'Delaware');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(16, 223, 'DC', 'District of Columbia');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(17, 223, 'FM', 'Federated States Of Micronesia');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(18, 223, 'FL', 'Florida');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(19, 223, 'GA', 'Georgia');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(20, 223, 'GU', 'Guam');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(21, 223, 'HI', 'Hawaii');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(22, 223, 'ID', 'Idaho');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(23, 223, 'IL', 'Illinois');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(24, 223, 'IN', 'Indiana');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(25, 223, 'IA', 'Iowa');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(26, 223, 'KS', 'Kansas');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(27, 223, 'KY', 'Kentucky');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(28, 223, 'LA', 'Louisiana');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(29, 223, 'ME', 'Maine');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(30, 223, 'MH', 'Marshall Islands');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(31, 223, 'MD', 'Maryland');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(32, 223, 'MA', 'Massachusetts');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(33, 223, 'MI', 'Michigan');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(34, 223, 'MN', 'Minnesota');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(35, 223, 'MS', 'Mississippi');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(36, 223, 'MO', 'Missouri');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(37, 223, 'MT', 'Montana');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(38, 223, 'NE', 'Nebraska');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(39, 223, 'NV', 'Nevada');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(40, 223, 'NH', 'New Hampshire');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(41, 223, 'NJ', 'New Jersey');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(42, 223, 'NM', 'New Mexico');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(43, 223, 'NY', 'New York');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(44, 223, 'NC', 'North Carolina');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(45, 223, 'ND', 'North Dakota');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(46, 223, 'MP', 'Northern Mariana Islands');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(47, 223, 'OH', 'Ohio');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(48, 223, 'OK', 'Oklahoma');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(49, 223, 'OR', 'Oregon');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(50, 223, 'PW', 'Palau');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(51, 223, 'PA', 'Pennsylvania');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(52, 223, 'PR', 'Puerto Rico');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(53, 223, 'RI', 'Rhode Island');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(54, 223, 'SC', 'South Carolina');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(55, 223, 'SD', 'South Dakota');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(56, 223, 'TN', 'Tennessee');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(57, 223, 'TX', 'Texas');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(58, 223, 'UT', 'Utah');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(59, 223, 'VT', 'Vermont');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(60, 223, 'VI', 'Virgin Islands');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(61, 223, 'VA', 'Virginia');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(62, 223, 'WA', 'Washington');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(63, 223, 'WV', 'West Virginia');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(64, 223, 'WI', 'Wisconsin');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(65, 223, 'WY', 'Wyoming');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(66, 38, 'AB', 'Alberta');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(67, 38, 'BC', 'British Columbia');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(68, 38, 'MB', 'Manitoba');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(69, 38, 'NF', 'Newfoundland');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(70, 38, 'NB', 'New Brunswick');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(71, 38, 'NS', 'Nova Scotia');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(72, 38, 'NT', 'Northwest Territories');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(73, 38, 'NU', 'Nunavut');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(74, 38, 'ON', 'Ontario');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(75, 38, 'PE', 'Prince Edward Island');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(76, 38, 'QC', 'Quebec');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(77, 38, 'SK', 'Saskatchewan');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(78, 38, 'YT', 'Yukon Territory');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(79, 81, 'NDS', 'Niedersachsen');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(80, 81, 'BAW', 'Baden-Wrttemberg');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(81, 81, 'BAY', 'Bayern');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(82, 81, 'BER', 'Berlin');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(83, 81, 'BRG', 'Brandenburg');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(84, 81, 'BRE', 'Bremen');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(85, 81, 'HAM', 'Hamburg');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(86, 81, 'HES', 'Hessen');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(87, 81, 'MEC', 'Mecklenburg-Vorpommern');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(88, 81, 'NRW', 'Nordrhein-Westfalen');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(89, 81, 'RHE', 'Rheinland-Pfalz');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(90, 81, 'SAR', 'Saarland');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(91, 81, 'SAS', 'Sachsen');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(92, 81, 'SAC', 'Sachsen-Anhalt');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(93, 81, 'SCN', 'Schleswig-Holstein');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(94, 81, 'THE', 'Thringen');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(95, 14, 'WI', 'Wien');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(96, 14, 'NO', 'Niedersterreich');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(97, 14, 'OO', 'Obersterreich');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(98, 14, 'SB', 'Salzburg');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(99, 14, 'KN', 'Kten');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(100, 14, 'ST', 'Steiermark');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(101, 14, 'TI', 'Tirol');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(102, 14, 'BL', 'Burgenland');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(103, 14, 'VB', 'Voralberg');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(104, 204, 'AG', 'Aargau');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(105, 204, 'AI', 'Appenzell Innerrhoden');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(106, 204, 'AR', 'Appenzell Ausserrhoden');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(107, 204, 'BE', 'Bern');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(108, 204, 'BL', 'Basel-Landschaft');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(109, 204, 'BS', 'Basel-Stadt');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(110, 204, 'FR', 'Freiburg');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(111, 204, 'GE', 'Genf');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(112, 204, 'GL', 'Glarus');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(113, 204, 'JU', 'Graubnden');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(114, 204, 'JU', 'Jura');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(115, 204, 'LU', 'Luzern');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(116, 204, 'NE', 'Neuenburg');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(117, 204, 'NW', 'Nidwalden');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(118, 204, 'OW', 'Obwalden');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(119, 204, 'SG', 'St. Gallen');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(120, 204, 'SH', 'Schaffhausen');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(121, 204, 'SO', 'Solothurn');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(122, 204, 'SZ', 'Schwyz');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(123, 204, 'TG', 'Thurgau');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(124, 204, 'TI', 'Tessin');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(125, 204, 'UR', 'Uri');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(126, 204, 'VD', 'Waadt');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(127, 204, 'VS', 'Wallis');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(128, 204, 'ZG', 'Zug');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(129, 204, 'ZH', 'Zrich');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(130, 195, 'A Corua', 'A Corua');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(131, 195, 'Alava', 'Alava');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(132, 195, 'Albacete', 'Albacete');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(133, 195, 'Alicante', 'Alicante');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(134, 195, 'Almeria', 'Almeria');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(135, 195, 'Asturias', 'Asturias');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(136, 195, 'Avila', 'Avila');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(137, 195, 'Badajoz', 'Badajoz');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(138, 195, 'Baleares', 'Baleares');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(139, 195, 'Barcelona', 'Barcelona');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(140, 195, 'Burgos', 'Burgos');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(141, 195, 'Caceres', 'Caceres');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(142, 195, 'Cadiz', 'Cadiz');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(143, 195, 'Cantabria', 'Cantabria');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(144, 195, 'Castellon', 'Castellon');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(145, 195, 'Ceuta', 'Ceuta');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(146, 195, 'Ciudad Real', 'Ciudad Real');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(147, 195, 'Cordoba', 'Cordoba');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(148, 195, 'Cuenca', 'Cuenca');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(149, 195, 'Girona', 'Girona');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(150, 195, 'Granada', 'Granada');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(151, 195, 'Guadalajara', 'Guadalajara');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(152, 195, 'Guipuzcoa', 'Guipuzcoa');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(153, 195, 'Huelva', 'Huelva');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(154, 195, 'Huesca', 'Huesca');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(155, 195, 'Jaen', 'Jaen');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(156, 195, 'La Rioja', 'La Rioja');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(157, 195, 'Las Palmas', 'Las Palmas');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(158, 195, 'Leon', 'Leon');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(159, 195, 'Lleida', 'Lleida');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(160, 195, 'Lugo', 'Lugo');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(161, 195, 'Madrid', 'Madrid');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(162, 195, 'Malaga', 'Malaga');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(163, 195, 'Melilla', 'Melilla');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(164, 195, 'Murcia', 'Murcia');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(165, 195, 'Navarra', 'Navarra');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(166, 195, 'Ourense', 'Ourense');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(167, 195, 'Palencia', 'Palencia');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(168, 195, 'Pontevedra', 'Pontevedra');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(169, 195, 'Salamanca', 'Salamanca');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(170, 195, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(171, 195, 'Segovia', 'Segovia');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(172, 195, 'Sevilla', 'Sevilla');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(173, 195, 'Soria', 'Soria');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(174, 195, 'Tarragona', 'Tarragona');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(175, 195, 'Teruel', 'Teruel');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(176, 195, 'Toledo', 'Toledo');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(177, 195, 'Valencia', 'Valencia');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(178, 195, 'Valladolid', 'Valladolid');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(179, 195, 'Vizcaya', 'Vizcaya');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(180, 195, 'Zamora', 'Zamora');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(181, 195, 'Zaragoza', 'Zaragoza');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(182, 107, '北海道', '北海道');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(183, 107, '青森県', '青森県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(184, 107, '岩手県', '岩手県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(185, 107, '宮城県', '宮城県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(186, 107, '秋田県', '秋田県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(187, 107, '山形県', '山形県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(188, 107, '福島県', '福島県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(189, 107, '茨城県', '茨城県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(190, 107, '栃木県', '栃木県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(191, 107, '群馬県', '群馬県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(192, 107, '埼玉県', '埼玉県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(193, 107, '千葉県', '千葉県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(194, 107, '東京都', '東京都');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(195, 107, '神奈川県', '神奈川県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(196, 107, '新潟県', '新潟県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(197, 107, '富山県', '富山県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(198, 107, '石川県', '石川県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(199, 107, '福井県', '福井県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(200, 107, '山梨県', '山梨県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(201, 107, '長野県', '長野県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(202, 107, '岐阜県', '岐阜県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(203, 107, '静岡県', '静岡県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(204, 107, '愛知県', '愛知県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(205, 107, '三重県', '三重県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(206, 107, '滋賀県', '滋賀県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(207, 107, '京都府', '京都府');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(208, 107, '大阪府', '大阪府');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(209, 107, '兵庫県', '兵庫県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(210, 107, '奈良県', '奈良県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(211, 107, '和歌山県', '和歌山県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(212, 107, '鳥取県', '鳥取県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(213, 107, '島根県', '島根県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(214, 107, '岡山県', '岡山県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(215, 107, '広島県', '広島県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(216, 107, '山口県', '山口県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(217, 107, '徳島県', '徳島県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(218, 107, '香川県', '香川県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(219, 107, '愛媛県', '愛媛県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(220, 107, '高知県', '高知県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(221, 107, '福岡県', '福岡県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(222, 107, '佐賀県', '佐賀県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(223, 107, '長崎県', '長崎県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(224, 107, '熊本県', '熊本県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(225, 107, '大分県', '大分県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(226, 107, '宮崎県', '宮崎県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(227, 107, '鹿児島県', '鹿児島県');
INSERT INTO zones (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES(228, 107, '沖縄県', '沖縄県');

-- --------------------------------------------------------

DROP TABLE IF EXISTS zones_to_geo_zones;
CREATE TABLE zones_to_geo_zones (
  `association_id` int(11) NOT NULL auto_increment,
  `zone_country_id` int(11) NOT NULL default '0',
  `zone_id` int(11) default NULL,
  `geo_zone_id` int(11) default NULL,
  `last_modified` datetime default NULL,
  `date_added` datetime NOT NULL default '0001-01-01 00:00:00',
  PRIMARY KEY  (`association_id`),
  KEY `idx_zones_zen` (`geo_zone_id`,`zone_country_id`,`zone_id`)
)   AUTO_INCREMENT=2 ;

INSERT INTO zones_to_geo_zones (`association_id`, `zone_country_id`, `zone_id`, `geo_zone_id`, `last_modified`, `date_added`) VALUES(1, 107, NULL, 1, '', now());

CREATE TABLE repetition_check (
  `customers_id` int(11) NOT NULL default '0',
  `check_hash` varchar(64) NOT NULL default '0',
  `shipping_cost` int(11) NOT NULL default '0',
  `subtotal` int(11) NOT NULL default '0',
  `total` int(11) NOT NULL default '0',
  PRIMARY KEY  (`customers_id`,`check_hash`)
) ;

INSERT INTO configuration VALUES('', 'DBによる多重注文防止を利用する', 'REPETITION_CHECK_ENABLED', 'true', '注文画面での購入ボタン多重クリックによる重複注文を防止するためにDBを利用するかどうかの設定をします<br />true 利用する<br />false 利用しない', 1, 130, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''),');
INSERT INTO configuration VALUES('', '画像リサイズ', 'IMAGE_MANAGER_CONFIG', 'false', '商品画像の自動リサイズを利用しますか？<br />true 利用する<br />false 利用しない<br /><br />注）この機能を利用するにはサーバーにGDがインストールされている必要があります。', 4, 100, NULL, now(), NULL, 'zen_cfg_select_option(array(''true'', ''false''),');

INSERT INTO configuration (`configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「会社概要」ページ - ステータス', 'DEFINE_COMPANY_INFO_STATUS', '1', '「定番ページの編集」で編集された内容をページ内に表示するかどうかと、サイドボックスにページへのリンクを表示するかどうかを設定します。<br />編集された「会社概要」内容を表示しますか?<br />0= リンク:表示　　編集領域:非表示<br />1= リンク:表示　　編集領域:表示<br />2= リンク:非表示　編集領域:表示<br />3= リンク:非表示　編集領域:非表示', 25, 90, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''),');

INSERT INTO configuration (`configuration_title`, `configuration_key`, `configuration_value`, `configuration_description`, `configuration_group_id`, `sort_order`, `last_modified`, `date_added`, `use_function`, `set_function`) VALUES( '「特定商取引法表記」 - ステータス', 'DEFINE_TOKUSHO_STATUS', '1', '「定番ページの編集」で編集された内容をページ内に表示するかどうかと、サイドボックスにページへのリンクを表示するかどうかを設定します。<br />編集された「特定商取引法表記」内容を表示しますか?<br />0= リンク:表示　　編集領域:非表示<br />1= リンク:表示　　編集領域:表示<br />2= リンク:非表示　編集領域:表示<br />3= リンク:非表示　編集領域:非表示', 25, 91, NULL, now(), NULL, 'zen_cfg_select_option(array(''0'', ''1'', ''2'', ''3''),');

INSERT INTO products_options_values VALUES (0, 1, 'TEXT', 0);
INSERT INTO products_options_values VALUES (0, 2, 'TEXT', 0);

INSERT INTO banners (`banners_id`, `banners_title`, `banners_url`, `banners_image`, `banners_group`, `banners_html_text`, `expires_impressions`, `expires_date`, `date_scheduled`, `date_added`, `date_status_change`, `status`, `banners_open_new_windows`, `banners_on_ssl`, `banners_sort_order`) VALUES
(1, 'Zen cart pro by - bigmouse Inc.', 'http://www.zencart-pro.com', 'banners/b_125x125_a.gif', 'SideBox-Banners', '', 0, NULL, NULL, now(), NULL, 1, 1, 1, 0),
(2, 'Zen Cart Pro - by bigmouse Inc.', 'http://www.bigmouse.jp', 'banners/b_125x125_b.gif', 'SideBox-Banners', '', 0, NULL, NULL, now(), NULL, 1, 1, 1, 0),
(3, 'Zen Cart Pro - by bigmouse Inc.', 'http://www.zencart-pro.com', 'banners/b_468x60_a.gif', 'Wide-Banners', '', 0, NULL, NULL, now(), NULL, 1, 1, 1, 0),
(4, 'Zen Cart Pro - by bigmouse Inc.', 'http://www.bigmouse.jp', 'banners/b_468x60_b.gif', 'Wide-Banners', '', 0, NULL, NULL, now(), NULL, 1, 1, 1, 0),
(5, 'Zen Cart Pro ヘルプサイト', 'http://www.zencart-pro.com/help/', 'banners/go-help.gif', 'SideBox-Banners', '', 0, NULL, NULL, now(), NULL, 1, 1, 1, 0);


<?php
/**
 * @package Installer
 * @access private
 * @copyright Copyright 2003-2007 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: inspect.php 17 2008-02-14 03:43:21Z bigmouse-sugimoto $
 */
/**
 * defining language components for the page
 */
  define('TEXT_PAGE_HEADING', 'Zen Cart; セットアップ　-　システム検査');
  define('INSTALL_BUTTON', ' インストール '); // this comes before TEXT_MAIN
  define('UPGRADE_BUTTON', 'アップグレード'); // this comes before TEXT_MAIN
  define('DB_UPGRADE_BUTTON', 'データベースのアップグレード'); // this comes before TEXT_MAIN

//Button meanings: (to be made into help-text for future version):
// "Install" = make new configure.php files, regardless of existing contents.  Load new database by dropping old tables.
// "Upgrade" = read old configure.php files, and write new ones using new structure. Upgrade database, instead of wiping and new install
// "Database Upgrade" = don't write the configure.php files -- simply jump to the database-upgrade page. Only displayed if detected database version is new enough to not require configure.php file updates.

  define('TITLE_DOCUMENTATION', '関連情報');
  define('TEXT_DOCUMENTATION', '<h3>インストールの手引きはお読みになりましたか？</h3>もしまだお読みでないなら、<a href="%s" target="_blank">インストールの手引き</a> は大変役に立ちます。<br />さまざまなフォルダやファイルに対するパミッション設定やその他のインストールに不可欠なだけではなく、インストール後に行わなければならない事柄に関する情報が記載されています。また、<a href="http://tutorials.zen-cart.com/" target="_blank">online FAQs</a> や、その他の役立つ情報へのリンクがあります。');

  define('TEXT_MAIN', 'お使いのWebサーバーでZen Cartが動作するための機能をサポートしているかチェックを行っています。 先へ進むために、全てのエラーを修正してから「<em>'.INSTALL_BUTTON.'&nbsp;</em>」を押して作業を続行してください。');
  define('SYSTEM_INSPECTION_RESULTS', 'システムの検査結果');
  define('OTHER_INFORMATION', 'その他のシステム情報(参照のみ)');
  define('OTHER_INFORMATION_DESCRIPTION', '以下の情報は必ずしも問題点や、修正すべき事項を示すわけではありません。 簡単に見つけることの出来る場所を表示するために存在します。');

  define('NOT_EXIST','見つかりません');
  define('WRITABLE','書き込めます');
  define('UNWRITABLE',"<span class='errors'>書き込めません</span>");
  define('UNKNOWN','不明');
  define('ON','ON');
  define('OFF','OFF');
  define('OK','OK');

  define('UPGRADE_DETECTION','アップグレードモードが利用できます');
  define('LABEL_PREVIOUS_INSTALL_FOUND','以前インストールされたZen Cartが見つかりました');
  define('LABEL_PREVIOUS_VERSION_NUMBER','Zen Cart v%s用のデータベースが存在します。');
  define('LABEL_PREVIOUS_VERSION_NUMBER_UNKNOWN','<em>しかしながら、データベースのバージョンを特定することができません。おそらくデータベーステーブルのプレフィックスの間違いや、その他のデータベース設定が誤っているものと思われます。 <br /><br />警告: 現在のconfigure.php設定が正しいと確信がある場合は、単にアップグレードオプションを使用してください。</em>');
  define('LABEL_UPGRADE_VS_INSTALL', '新規インストールですか、それともアップグレードですか？');
  define('LABEL_INSTALL', 'インストールの準備はできましたか?  <br />※既存のデータはすべて削除されます。 アップグレードモードではありません!!!');

  define('IMAGE_STOP_BEFORE_UPGRADING', '<div class="center"><img src="includes/templates/template_default/images/stop.gif" border="0" alt="警告：以下のオプションよりふさわしいものを選んでください。" /></div>');

  define('LABEL_ACTION_SELECTION_INSTRUCTIONS','<p class="errors extralarge"><span class="center">NOTE:</span><br />もし、アップグレードを行うのであれば、以下の"<span style="text-decoration: underline;">データベースアップグレード</span>" を必ず選択し、データを保存するようにしてください。</p><p class="extralarge">もし、"インストール" を選んだ場合は、データベース内のすべての情報は削除されることになります。</p>');

  define('DISPLAY_PHP_INFO','PHP情報へのリンク: ');
  define('VIEW_PHP_INFO_LINK_TEXT','あなたのサーバの PHP の情報を見る');
  define('LABEL_WEBSERVER','Web サーバー');
  define('LABEL_MYSQL_AVAILABLE','MySQL のサポート');
  define('LABEL_MYSQL_VER','MySQL のバージョン');
  define('LABEL_DB_PRIVS','データベース権限');
  define('LABEL_POSTGRES_AVAILABLE','PostgreSQL のサポート');
  define('LABEL_PHP_VER','PHP のバージョン');
  define('LABEL_PHP_OS','PHP O/S');
  define('LABEL_REGISTER_GLOBALS','Register Globals');
  define('LABEL_SET_TIME_LIMIT','PHP の実行時間のリミット');
  define('LABEL_DISABLED_FUNCTIONS','利用できない PHP の機能');
  define('LABEL_SAFE_MODE','PHP セーフモード');
  define('LABEL_CURRENT_CACHE_PATH','現在の SQL キャッシュフォルダー');
  define('LABEL_SUGGESTED_CACHE_PATH','推奨されるSQL キャッシュフォルダー');
  define('LABEL_HTTP_HOST','HTTP ホスト');
  define('LABEL_PATH_TRANLSATED','Path_Translated');
  define('LABEL_REALPATH', 'Real Path');
  define('LABEL_PHP_API_MODE','PHP API モード');
  define('LABEL_PHP_MODULES','実行可能になっているPHP モジュール');
  define('LABEL_PHP_EXT_SESSIONS','PHP セッションのサポート');
  define('LABEL_PHP_SESSION_AUTOSTART','PHP セッション オートスタート');
  define('LABEL_PHP_EXT_SAVE_PATH','PHP セッション 保存用パス');
  define('LABEL_PHP_EXT_FTP','PHP FTP サポート');
  define('LABEL_PHP_EXT_CURL','PHP cURL サポート');
  define('LABEL_CURL_NONSSL','CURL NON-SSL 対応');
  define('LABEL_CURL_SSL','CURL SSL 対応');
  define('LABEL_CURL_NONSSL_PROXY','プロキシ経由でのCURL NON-SSL 対応');
  define('LABEL_CURL_SSL_PROXY','プロキシ経由でのCURL SSL 対応');
  define('LABEL_PHP_MAG_QT_RUN','PHP magic_quotes_runtime の設定');
  define('LABEL_PHP_MAG_QT_SYBASE','PHP magic_quotes_sybase 設定');
  define('LABEL_PHP_EXT_GD','PHP GD サポート');
  define('LABEL_GD_VER','GD バージョン');
  define('LABEL_PHP_EXT_OPENSSL','PHP OpenSSL サポート');
  define('LABEL_PHP_UPLOAD_STATUS','PHP Upload サポート');
  define('LABEL_PHP_EXT_PFPRO','PHP Payflow Pro サポート');
  define('LABEL_PHP_EXT_ZLIB','PHP ZLIB Compression サポート');
  define('LABEL_PHP_SESSION_TRANS_SID','PHP session.use_trans_sid');
  define('LABEL_DISK_FREE_SPACE','サーバー内の空きディスク容量');
  define('LABEL_XML_SUPPORT','PHP XML サポート');
  define('LABEL_OPEN_BASEDIR','PHP open_basedir の制限');
  define('LABEL_UPLOAD_TMP_DIR','PHP Upload TMP ディレクトリ');
  define('LABEL_SENDMAIL_FROM','PHP sendmail \'from\'');
  define('LABEL_SENDMAIL_PATH','PHP sendmail パス');
  define('LABEL_SMTP_MAIL','PHP SMTP destination');
  define('LABEL_GZIP', 'PHP Output Buffering (gzip)');
  define('LABEL_INCLUDE_PATH','PHP include_path');

  define('LABEL_CRITICAL','致命的なアイテム');
  define('LABEL_RECOMMENDED','オススメのアイテム');
  define('LABEL_OPTIONAL','オプションのアイテム');

  define('LABEL_EXPLAIN',' 詳細情報...');
  define('LABEL_FOLDER_PERMISSIONS','ファイルとフォルダーのパーミッション');
  define('LABEL_WRITABLE_FILE_INFO', 'インストーラーが入力された設定情報を保存するためには、以下に表示されている configure.php ファイル"書き込み可"になっている必要があります。');
  define('LABEL_WRITABLE_FOLDER_INFO','Zen Cartの管理と日々追加される新機能を正しく作動させるために、いくつかのファイルやフォルダーを編集可能にセットしておく必要があります。以下に挙げるのは、「読み込み/書き込み可能」にしておくべきフォルダーの一覧です。
推奨されるCHMODのセッティングを参考にしてください。インストール作業を続ける前にこの設定を正しく行ってください。
設定が正しく行われたか確認するためには、このページを再読み込みしてください。<br /><br />
ホスティングサービスによってはCHMOD 777ではなく、666しか許可していないかもしれません。まずは777で試してみて、できないようであれば666で設定してみてください。');
?>
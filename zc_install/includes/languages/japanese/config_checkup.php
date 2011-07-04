<?php
/**
 * @package Installer
 * @access private
 * @copyright Copyright 2003-2007 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: config_checkup.php 17 2008-02-14 03:43:21Z bigmouse-sugimoto $
 */
/**
 * defining language components for the page
 */
  define('TEXT_MAIN', '<h2>configuration ファイルの設定を見直してください</h2><p>configure.php ファイルの設定が正しくありません。おそらく設定内容が正しく記述されていません。</p>');
  define('TEXT_EXPLANATION2', '<p>入力された情報を元にサーバー内の configure.php ファイルに情報を書き込もうとしました。この画面が表示されているという事は、configure.php への書き込みに失敗したことを意味します。しかし、手動で configure.php の情報を編集する事ができるでしょう。</p>');
  define('TEXT_PAGE_HEADING', 'ZenCart - 設定情報チェック');
  define('TEXT_CONFIG_FILES', '設定情報ファイル - configure.php files');
  define('TEXT_CONFIG_INSTRUCTIONS', '以下のボックスを利用し、正しい情報をコピーアンドペーストしてください。　ボックスをクリックし、パソコンのクリップボードに記憶させ、目的の configure.php ファイルをテキストエディタで開きクリップボードの内容をファイルにペーストした後、保存しサーバーにアップロードしてください。他のファイルも同様に修正後アップロードします。<br /><br />作業が終了したら下の"ファイルを再チェック" ボタンで再検査してください。');

  define('TEXT_CATALOG_CONFIGFILE', '/includes/configure.php');
  define('TEXT_ADMIN_CONFIGFILE', '/admin/includes/configure.php');

  define('CONTINUE_BUTTON', '無視して進める');
  define('RECHECK', 'ファイルを再チェック');
?>
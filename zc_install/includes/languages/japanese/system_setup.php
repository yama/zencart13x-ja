<?php
/**
 * @package Installer
 * @access private
 * @copyright Copyright 2003-2007 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: system_setup.php 17 2008-02-14 03:43:21Z bigmouse-sugimoto $
 */
/**
 * defining language components for the page
 */
  define('SAVE_SYSTEM_SETTINGS', 'システム設定の変更を保存'); //this comes before TEXT_MAIN
  define('TEXT_MAIN', 'Zen Cartのシステム環境を変更します。それぞれの設定についてよく検証して、ご自身のサイトのディレクトリ配置に合うように変更を行ってください。その後 <em>システム設定の変更を保存</em> を押してください');
  define('TEXT_PAGE_HEADING', 'Zen Cartの設定　- システム設定');
  define('SERVER_SETTINGS', 'サーバ設定');
  define('PHYSICAL_PATH', '物理パス');
  define('PHYSICAL_PATH_INSTRUCTION', 'あなたのサイト内のZen Cartディレクトリまでの物理パス。最後尾のスラッシュ記号「/」は取り除いてください。');
  define('VIRTUAL_HTTP_PATH', '仮想HTTPパス');
  define('VIRTUAL_HTTP_PATH_INSTRUCTION', 'あなたのサイト内のZen Cartディレクトリまでの仮想パス。最後尾のスラッシュ記号「/」は取り除いてください。');
  define('VIRTUAL_HTTPS_PATH', '仮想HTTPSパス');
  define('VIRTUAL_HTTPS_PATH_INSTRUCTION', 'あなたのサイト内のZen Cartディレクトリまでの仮想HTTPSパス。最後尾のスラッシュ記号「/」は取り除いてください。');
  define('VIRTUAL_HTTPS_SERVER', '仮想HTTPSサーバ');
  define('VIRTUAL_HTTPS_SERVER_INSTRUCTION', 'Zen Cartディレクトリ用仮想HTTPSサーバ。最後尾のスラッシュ記号「/」は取り除いてください。');
  define('TEXT_SSL_INTRO', '<strong>SSL証明書はお持ちですか？ もしそうであれば以下に詳細を入力してください。</strong> もし、これが初めてのインストールである場合は、入力された値はおそらく正しくありません。もし正確な詳細情報に関して不明であれば、ホスティング業者に情報をご確認ください。');
  define('TEXT_SSL_WARNING', 'もしお持ちのSSL証明書がすでに有効であれば、以下の項目からSSL設定を選択してください。<br /><strong>もしまだホスティングアカウントでSSLが利用可能になっていないなら、決してここでSSLを有効にしないでください。</strong> もし、SSLを有効にしたにも関わらず指定されたSSLアドレスが利用可能でない場合、管理画面へアクセスする事もショップでログインする事も出来なくなります。SSL設定は後で configure.php ファイルの設定内容を修正する事で有効化する事もできます。');
  define('SSL_OPTIONS', 'SSL 詳細');
  define('ENABLE_SSL', 'ショップでSSLを有効にする');
  define('ENABLE_SSL_INSTRUCTION', 'ショップでSSLを有効にしますか?<br />SSLが確実に動くことを確認できるまでこの設定は「いいえ」にしておいてください。');
  define('ENABLE_SSL_ADMIN', '管理画面でSSLを有効にする');
  define('ENABLE_SSL_ADMIN_INSTRUCTION', '管理画面でSSLを有効にしますか?<br />SSLが確実に動くことを確認できるまでこの設定は「いいえ」にしておいてください。');
  define('REDISCOVER', 'このホストのデフォルト設定を再検索する');

?>
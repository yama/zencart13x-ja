<?php
/**
 * @package Installer
 * @access private
 * @copyright Copyright 2003-2007 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: time_out.php 17 2008-02-14 03:43:21Z bigmouse-sugimoto $
 */
/**
 * defining language components for the page
 */
  define('TEXT_PAGE_HEADING', 'Zen Cart初期設定 - タイムアウト');
  define('TEXT_MAIN','<h2>問題が発見されました</h2><h3>残念ながら問題が発見されました。</h3>
<p>このインストーラーは、インストールを完了させるために PHP セッションをスタートさせる必要があります。</p>
<p><strong>この画面が表示される原因として考えられるのは:</strong>
<ul>
<li><h3>おそらくタイムアウトが生じました</h3>もしインストール作業を20分以上中断していた場合、前の画面で入力していた情報はすでに失われています。 その場合、インストール作業を初めからやり直す必要があるでしょう。<br />
<br />
インストール作業を長い間中断しない様にしてください。通常の環境であればインストールは5分ほどで完了します。<br /><br /></li>
<li><h3>サーバーにセッションファイルを記述する場所がありません。</h3>もし、まだ "cache" フォルダを書き込み可能にしていないなら、インストールを続けるためには変更を行ってください。ファイルに書き込み権限を与える方法に関しては、 <a href="../docs/index.html" target="_blank">Installation Instructions</a> もしくは <a href="http://tutorials.zen-cart.com/index.php?article=9" target="_blank">online FAQs</a>に説明されています。<br /><br /></li>
<li><h3>PHP セッションがサーバーで利用可能になっていません</h3>Zen Cart を利用するためには、PHP のセッション機能を利用する必要があります。ご利用のサーバーでは、現在PHPセッション情報の処理を行えるよう設定されていません。また、もしお使いのブラウザでセッションクッキーを無効にしている場合、PHPセッション機能を利用する事ができません。ブラウザのクッキー遮断ツールを停止させ、念のためファイアーウォールも停止させておいてください。<br /><br />サイトでPHPのセッション機能を利用できるように設定するためには、サーバー管理者に相談する必要があるかもしれません。<br /><br /></li>
</ul>
</p>');
  define('START_INSTALL', 'インストールを始める');
?>
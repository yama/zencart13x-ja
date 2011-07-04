<?php
/**
 * @package Installer
 * @access private
 * @copyright Copyright 2003-2007 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: finished.php 17 2008-02-14 03:43:21Z bigmouse-sugimoto $
 */
/**
 * defining language components for the page
 */
  define('TEXT_MAIN',"<h2>おめでとうございます！</h2>
<h3>Zen Cartのインストールが正しく行われました。</h3>
<h2>次のステップ</h2>
セキュリティ対策として、あなたの店舗を公開する前に、<strong>/admin/includes/</strong> および <strong>/includes/</strong> フォルダにある<strong>configure.php</strong>を read-onlyモードに戻す必要があります。<br /><br />
また、<strong>/zc_install</strong>ディレクトリをサーバー上から削除するかリネームしておくことで他人がZen Cart を再インストールしたり、データベースを削除することを防ぐことができます。
また、この警告はディレクトリが削除されるか、リネームされるまで表示され続けます。

<h2>設定</h2>
あなたのショップを望みどおりのものとするためにまず最初に<a href=\"http://tutorials.zen-cart.com\"><strong>reading the FAQ's</strong>のオンラインサポートフォーラム</a>に目を通すことをお薦めします。
もし疑問点がある場合はオフィシャルサイトを最初に覗いてください。そして自由に質問を投げてください。ZenCartコミュニティは皆の知識と知恵が集まるべき場所です。<br /><br />
また、 <strong><a href=\"../docs\" target=\"_blank\">/docs </a> </strong>内にあるドキュメントを熟読することも<strong>重要</strong>です。

<a href=\"../docs\" target=\"_blank\">ここを押すとリスト表示されます。</a>

<h2>重要事項</h2>あなたが設置したショップをカスタマイズするために一番重要なツールは<strong>開発者用ツール</strong>です。これは<strong>管理者エリアの「追加設定・ツール」</strong>にあります。
これを使用することで変更をかけたいテキストをほとんどどこでも変更することができます。
<br /><br />
カスタマイズを行うために慣れていただかなくてはならない概念は<em><strong>テンプレートシステム</strong></em>です。
<a href=\"http://www.zen-cart.com\">Zen Cart.com</a>のオンラインFAQにはテンプレートシステムの記事が多く寄せられています。
 <h2>追記</h2>
<p><a href=\"http://www.zen-cart.com/wiki\" target=\"_blank\">Zen Cart&trade; Wiki</a> では、有用なTipsや一般的な使い方の情報が載っています。 </p>
<p> <a href=\"http://www.zen-cart.com\" target=\"_blank\">Zen Cartフォーラム</a>には, '<strong>ダウンロード</strong>'と呼ばれるセクションがあります。
その中に'<strong>ドキュメント</strong>'と呼ばれるセクションがあります。 ここに最新のマニュアルがありますので、ご自身のサイト作成にお役立てください<br />
  <br />
  あなたがご自身のe-コマースソリューションにZen Cartを選ばれたことを光栄に思います！<br />
  <br />
" .
'このZencart' . PROJECT_VERSION_MAJOR . '.' . PROJECT_VERSION_MINOR . '日本語化は、多くの方のサポートをいただきながら bigmouse が行ったものです。日本語化に伴う問題点やバグのご報告・相談は<a href="http://www.bigmouse.jp">www.bigmouse.jp</a>にお願いします。' . '
</p>
' .
'<p>設置したZen Cartのテストを行うには、下の<em>ショップへ</em> ボタンを、ショップのカスタマイズを始めるには<em>管理画面へ</em> ボタンを押してください。</p>');
  define('TEXT_PAGE_HEADING', 'Zen Cart; 設置完了');
  define('STORE', 'ショップへ');
  define('ADMIN', '管理画面へ');
?>
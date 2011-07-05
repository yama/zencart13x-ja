<?php

$relPath = (file_exists('includes/templates/template_default/images/logo.gif')) ? '' : '../';
$instPath = (file_exists('zc_install/index.php')) ? 'zc_install/index.php' : (file_exists('../zc_install/index.php') ? '../zc_install/index.php' : '');
$docsPath = (file_exists('docs/index.html')) ? 'docs/index.html' : (file_exists('../docs/index.html') ? '../docs/index.html' : '');
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="ja">
<head>
<title>System Setup Required</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="keywords" content="" />
<meta name="description" content="" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="authors" content="The Zen Cart&trade; Team and others" />
<meta name="generator" content="shopping cart program by Zen Cart&trade;, http://www.zen-cart.com" />
<meta name="robots" content="noindex, nofollow" />
<style type="text/css">
<!--
html {font-size:100.01%;}
body {font-size:82.5%;font-color:#333;}
p, li {line-height:1.6;}

.systemError {color: #FFFFFF}
-->
</style>


</head>

<body style="margin: 20px">
<div style="width: 730px; background-color: #ffffff; margin: auto; padding: 10px; border: 1px solid #cacaca;">
<div>
<img src="<?php echo $relPath; ?>includes/templates/template_default/images/logo.gif" alt="Zen Cart&trade;" title=" Zen Cart&trade; " width="192" height="64" border="0" />
</div>
<h1>Zen Cart へようこそ。</h1>
<h2>このページが表示される場合はいくつかの原因があります。</h2>
<ol>
<li><strong>Zen Cartを初めて</strong>作動させ、まだ通常のインストールの手順が済んでいない場合。<br />
もし、そうであれば...
<?php if ($instPath) { ?>
<a href="<?php echo $instPath; ?>">ここをクリック</a>してインストールを開始してください。
<?php } else { ?>
"zc_install" フォルダを FTP でアップロードさせてから、ブラウザで <a href="<?php echo $instPath; ?>">zc_install/index.php</a> を実行する(もしくはこのページをリロードさせてください)必要があるかもしれません。
<?php } ?>
<br /><br />
</li>
<li>現在の <tt><strong>/includes/configure.php</strong></tt> および <tt><strong>/admin/includes/configure.php</strong></tt> の両方、もしくはどちらかのファイルに、間違った<strong>パスの設定</strong>、あるいは間違った<strong>データベース接続設定</strong>が含まれています。<br />
もし最近サイトを別のフォルダや別のサーバーに移動するなど、なんらかの理由があって configure.php ファイルを変更していた場合、すべての項目に関して再度設定内容の確認を行い、サーバーに合わせて正しく情報を更新してください。<br />
zen-cart.com サイトの<a href="http://tutorials.zen-cart.com" target="_blank">Online FAQ and Tutorials</a>は助けになるでしょう。</li>
</ol>
<h2>インストールを始めるには。</h2>
<ol>
<?php if ($docsPath) { ?>
<li><a href="<?php echo $docsPath; ?>">インストールドキュメント</a>はここをクリックすれば見ることができます： <a href="<?php echo $docsPath; ?>">Documentation</a></li>
<?php } else { ?>
<li>インストールドキュメントは通常Zencartディストリビューションの /docs フォルダ内にあります。また、<a href="http://tutorials.zen-cart.com" target="_blank">Online FAQs</a>からも参考資料をみつけることができます。</li>
<?php } ?>
<?php if ($instPath) { ?>
<li><a href="<?php echo $instPath; ?>">zc_install/index.php</a>をブラウザで起動。</li>
<?php } else { ?>
"zc_install" フォルダを FTP でアップロードさせてから、ブラウザで <a href="<?php echo $instPath; ?>">zc_install/index.php</a> を実行する(もしくはこのページをリロードさせてください)必要があるかもしれません。
<?php } ?>
<li>もし問題が発生した場合には、zen-cart.com サイトの<a href="http://tutorials.zen-cart.com" target="_blank">Online FAQ and Tutorials</a> ページの情報が役に立つでしょう。</li>
</ol>

</div>
    <p style="text-align: center; font-size: small;">Copyright &copy; 2003-<?php echo date('Y'); ?> <a href="http://www.zen-cart.com" target="_blank">Zen Cart&trade;</a></p>
</body></html>

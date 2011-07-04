<?php
/**
 * @package admin
 * @copyright Copyright 2003-2010 Zen Cart Development Team
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: alert_page.php 429 2010-12-07 00:15:26Z bigmouse-sugimoto $
 */
require ('includes/application_top.php');
$adminDirectoryExists = $installDirectoryExists = FALSE;
if (substr(DIR_WS_ADMIN, -7) == '/admin/' || substr(DIR_WS_HTTPS_ADMIN, -7) == '/admin/') $adminDirectoryExists = TRUE;
$check_path = dirname($_SERVER['SCRIPT_FILENAME']) . '/../zc_install';
if (is_dir($check_path)) $installDirectoryExists = TRUE;
?>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>セキュリティエラー</title>
<meta name="robot" content="noindex, nofollow" />
</head>
<body>
<div style="width:400px;margin:auto;margin-top:10%;border:5px red solid;padding:20px 50px 50px 50px;background-color:#FFAFAF;">
<h1 style="text-align: center;font-size:40px;color:red;margin:0;">セキュリティエラー</h1>
<p style="">管理画面の設定を正しく行ってください</p>
<ul style="">
<?php if ($installDirectoryExists) { ?>
<li>インストールディレクトリが残っています。<br />セキュリティ上のリスクが有りますのでインストールディレクトリは必ず削除してください。<br /><br /></li>
<?php }
 if ($adminDirectoryExists) { ?>
<li>管理画面のディレクトリ名がデフォルトの admin のままです。<br />悪意のあるユーザーが管理画面ディレクトリにアクセスすることが可能となりますので必ず変更してください。<br /><a href="http://zencart-pro.com/help/node/202" target="_blank">設定変更方法（外部サイト）</a></li>
<?php  } ?>
</ul>
上記内容を正しく変更しない限り管理画面へのアクセスは出来ません。
</div>
</body>
</html>
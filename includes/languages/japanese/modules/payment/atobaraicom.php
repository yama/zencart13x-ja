<?php
/**
 * @copyright Copyright 2006-2008 Bigmouse, Inc
 * @copyright Portions Copyright 2003-2007 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: atobaraicom.php 645 2009-10-05 11:42:23Z bigmouse-sugimoto $
**/
$error_check = false;
  $atobaraicom_desc = '後払い.comを利用した後払い決済です。';
  if (IS_ADMIN_FLAG === true && MODULE_PAYMENT_ATOBARAICOM_STATUS == 'True') {
	if (MODULE_PAYMENT_ATOBARAICOM_SITE_ID == '') {
		$atobaraicom_desc .= '<br /><span style="color:red">*サイトIDが登録されていません。</span><br /><a href="http://www.ato-barai.com/" target="_blank">こちら</a>より登録を行ってください。';
		$error_check = true;
  	}
  	if (MODULE_PAYMENT_ATOBARAICOM_API_STATUS == 'True') {
		if (!function_exists('curl_init')) {
			$atobaraicom_desc .= '<br /><span style="color:red;font-size: 150%;">*注文登録APIを使う場合、curlを使いますのでcurlを有効にして下さい。</span><br />サーバーの環境等によりcurlを使えない場合はFalseを選択して下さい。';
			$error_check = true;
	  	}
		if (MODULE_PAYMENT_ATOBARAICOM_API_URL == '') {
			$atobaraicom_desc .= '<br /><span style="color:red;font-size: 150%;">*注文登録APIを使う場合、後払い.comより発行されたAPI接続先URLを入力してください。</span>';
			$error_check = true;
	  	}
		if (MODULE_PAYMENT_ATOBARAICOM_API_ZIGYOUSYA_ID == '') {
			$atobaraicom_desc .= '<br /><span style="color:red;font-size: 150%;">*注文登録APIを使う場合、後払い.comより発行された受付事業者IDを入力してください。</span>';
			$error_check = true;
	  	}
		if (MODULE_PAYMENT_ATOBARAICOM_API_USER_ID == '') {
			$atobaraicom_desc .= '<br /><span style="color:red;font-size: 150%;">*注文登録APIを使う場合、後払い.comより発行されたAPIユーザーIDを入力してください。</span>';
			$error_check = true;
	  	}
		if (MODULE_PAYMENT_ATOBARAICOM_API_MAIL == '' ){
			$atobaraicom_desc .= '<br /><span style="color:red;font-size: 150%;">*注文登録APIを使う場合、処理結果を送るメールアドレスは必須です。</span>';
			$error_check = true;
		}
		if (zen_validate_email(MODULE_PAYMENT_ATOBARAICOM_API_MAIL) == false) {
			$atobaraicom_desc .= '<br /><span style="color:red;font-size: 150%;">*このメールアドレスは不正です。</span>';
			$error_check = true;
		}
  	}

  	if ((int)MODULE_PAYMENT_ATOBARAICOM_COST > 0 && MODULE_ORDER_TOTAL_ATOBARAICOM_STATUS != 'true') {
  		$atobaraicom_desc .= '<br /><span style="color:red;font-size: 150%;">*後払い手数料を加算したい時には注文合計モジュールの ot_atobarai を有効にしてください。</span>';
  		$error_check = true;
  	}
  }
  if ($error_check) {
  	define('MODULE_PAYMENT_ATOBARAICOM_TEXT_TITLE', '後払い.com<b><span style="color:red;font-size: 150%;">エラー:設定を見直して下さい</span><b>');
  } else {
  	define('MODULE_PAYMENT_ATOBARAICOM_TEXT_TITLE', '後払い.com（コンビニ・銀行振込・郵便振替での後払い） ： 請求後14日以内にお支払い');
  }
  define('MODULE_PAYMENT_ATOBARAICOM_TEXT_DESCRIPTION', $atobaraicom_desc);
  define('MODULE_PAYMENT_ATOBARAICOM_TEXT_PROCESS', '<a href="http://www.ato-barai.com/r_annai.html" target="_blank"><img src="http://www.ato-barai.com/images/annai/kessai_banner_002.gif" alt="後払い.com【後払いドットコム】コンビニ・銀行・郵便局で後払い決済" width="187" height="55" border="0" /></a>');
  define('MODULE_PAYMENT_ATOBARAICOM_TEXT_FEE', '後払い決済手数料:');
  define('MODULE_PAYMENT_ATOBARAICOM_TEXT_EMAIL_FOOTER','請求書を送付しますので、商品受け取り後14日以内にコンビニ・銀行・郵便局のいずれかでお支払いください。');
  define('MODULE_PAYMENT_ATOBARAICOM_TEXT_FREE', '無料');
  define('MODULE_PAYMENT_ATOBARAICOM_TEXT_API_HTTP_ERROR', '後払い.comとの通信エラーが起きました。HTTPコード:');
  define('MODULE_PAYMENT_ATOBARAICOM_TEXT_API_ERROR1', '後払い.comとの通信中に不明なエラーがおきました。詳しくはショップ管理者へお問い合わせ下さい。');
  define('MODULE_PAYMENT_ATOBARAICOM_TEXT_API_OK', '後払い.comとの通信を正常に行いました。');
  define('MODULE_PAYMENT_ATOBARAICOM_TEXT_API_OK_ID', '後払い.comシステムオーダーID:');
  define('MODULE_PAYMENT_ATOBARAICOM_TEXT_API_OK_ORDER_ID', 'オーダーID:');
  define('MODULE_PAYMENT_ATOBARAICOM_EMAIL_TEXT_SUBJECT', '後払い.com　API　売上登録結果');
  
  
  define('MODULE_PAYMENT_ATOBARAICOM_TEXT_INFO', '<div style="padding: 0.5em;border: 1px solid #cccccc;">

<font color="red"><strong>※まだ注文は完了していません！</strong></font>

<b>以下の内容をお読みの上同意頂けましたら、最下部にある『注文の確定』ボタンをクリックしてください</b>

<strong>【後払い.comサービス内容】</strong>

<strong>決済手数料：%s</strong>

●商品はお支払い前に発送されます
●ご利用になれるコンビニエンスストア（全15社、全国40,000店舗以上）
　セブン・イレブン／ローソン／ファミリーマート／ampm／サークルK／サンクス／
ミニストップ／デイリー・ヤマザキ／ポプラ／セイコーマート／コミュニティストア／
セーブオン／スリーエフ／ココストア／HOT SPAR
●銀行・郵便局でもお支払いいただけます。
●当店にかわり、後払い決済運営会社の株式会社キャッチボールより請求書が送られます。
●商品到着と請求書の到着は別になります。
●請求書発行から14日後までに、上記コンビニ、金融機関でお支払い下さい。
●お支払い代金は「商品代金＋送料%s＋決済手数料%s（＋銀行振込みご利用の場合はお振込み手数料）」となります。
●配送先が注文者住所と異なる場合（ギフト等）でもご利用になれます
●後払い.comの払込み受領票（コンビニ払い・郵便振替）、銀行振込み受領票を領収書としてご利用いただけます。

<strong>【後払い.comご利用の方は必ずお読み下さい】</strong>
●当サービスは株式会社キャッチボールの運営する「後払い.com(ドットコム)」により提供されます。 下記同意事項および「サービスご利用時の流れ」をよくお読みの上、ご同意の上、当決済方法をご選択下さい。
●法人でご利用の方は、「ご住所」に法人名を含め、「購入者氏名」に担当者のお名前を入れてください。
●期日以内にお支払いがない場合、消費者契約法に基づく遅延損害金及び、再度の請求ごとに￥300の再請求発行手数料がかかりますのでご注意下さい。
●当サービスには与信が必要となります。返答は10:00～18:00の間は約5分～2時間、それ以外の時間帯 のご注文では翌日午前中のご回答となります（お客様側でしていただく作業はございません）。
●ご本人様確認のためにお電話にてご連絡させていただく場合がございます。
●お客様が当サイトにおいて登録された個人情報および発注内容は、後払い.comのサービスに必要な 範囲のみで株式会社キャッチボールに提供させていただきます。
●与信結果によっては当サービスをご利用いただけない場合もございますので、予めご了承下さい。与信結果がNGだった場合は、他の決済方法で再注文いただくことになります。
●商品の配送先を配送業者の営業所止め（営業所来店引取り）にすることはできません。
●サービスをご利用いただいた場合は、上記注意事項及び下記サービスの流れにご同意いただいたものと みなさせていただきます。


<strong>【後払い.comご利用時の流れ】</strong>
１．「後払い」の決済方法を選択し、注文をします
２．株式会社キャッチボールにて与信を行い、結果をお伝えいたします（通常1～3時間、夜間のご注文には翌日回答となります）。
３．商品を発送いたします
４．商品到着／請求書到着（商品は当店・請求書は株式会社キャッチボールから送られるため、それぞれ別々に届きます）
５．請求書発行日より14日間以内に上記コンビニ・金融機関でお支払い下さい。

<font color="red"><b>上記内容を良くお読みの上同意頂けましたら、下記の『注文の確定』ボタンをクリックしてください</b></font>
</div>');
?>
<?php
/**
 * @copyright Copyright 2006-2008 Bigmouse, Inc
 * @copyright Portions Copyright 2003-2007 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: atobaraicom_csv.php 639 2009-10-02 05:45:52Z makiya $
**/

define('HEADING_TITLE', '後払い.com　管理');
define('HEADING_TITLE_SEARCH', '注文ID:');
define('HEADING_TITLE_STATUS', 'ステータス:');
define('TABLE_HEADING_SHIPPING_METHOD', '配送方法');
define('TABLE_HEADING_ORDERS_ID','ID');

define('TEXT_BILLING_SHIPPING_MISMATCH','請求先と配送先が違います');

define('TABLE_HEADING_COMMENTS', 'コメント');
define('TABLE_HEADING_CUSTOMERS', '顧客名');
define('TABLE_HEADING_ORDER_TOTAL', '注文合計');
define('TABLE_HEADING_DATE_PURCHASED', '注文日');
define('TABLE_HEADING_STATUS', 'ステータス');
define('TEXT_ALL_ORDERS', '全ての注文');
define('TEXT_NOT_STATUS', '変更しない');
define('TEXT_CSV_EXPLODE', 'CSV出力');
define('TEXT_CSV_EXPLODE2', 'CSV出力');
define('TEXT_VP_CSV', '一括注文登録用CSV');
define('TEXT_VP_CSV2', '配送伝票登録用');
define('TEXT_VP_CSV_INFO', '絞込んで出力する場合は<br>画面右上のステータスプルダウンを<br>選択してください。');
define('TEXT_IMPORT_CSV', '配送伝票登録CSVインポート');
define('TEXT_IMPORT_CSV_DESC', '配送伝票登録用の注文を全て、設定したステータスに変更します。');
define('TEXT_IMPORT_CSV_SUBMIT', 'インポート開始');
define('TEXT_IMPORT_CSV_ERROR_ORDER', '注文番号が存在しません。');
define('TEXT_IMPORT_CSV_ERROR_ORDER_PAYMENT', 'この注文番号は後払い.comで決済していません。');
define('TEXT_IMPORT_CSV_UPDATE_OK', '更新しました。');
define('TEXT_IMPORT_CSV_ERROR_ORDER_STATUS', 'ステータスが一緒かコメントが空でしたので、何も処理はしていません。');
define('TEXT_IMPORT_CSV_YOSIN', '与信結果CSVインポート');
define('TEXT_IMPORT_CSV_DESC_YOSIN', '与信結果CSVを読み込み自動的にステータスを変更します。');
define('HEADING_TITLE_STATUS_YOSIN_OK', 'OKの時のステータス');
define('HEADING_TITLE_STATUS_YOSIN_NG', 'NGの時のステータス');
define('TEXT_IMPORT_CSV_ERROR_ORDER_ID_COLUMN', 'CSVに任意注文番号のカラムが見当たりません。後払い.comの管理画面の設定を見直して下さい。');
define('TEXT_IMPORT_CSV_ERROR_SINSA_KEKKA_COLUMN', 'CSVに審査結果のカラムが見当たりません。後払い.comの管理画面の設定を見直して下さい。');
define('CSV_HEADER_ORDER_ID', '任意注文番号');
define('CSV_HEADER_SINSA_KEKKA', '審査結果');
define('CSV_HEADER_SINSA_KEKKA_OK', '後払い.comの審査が通りました。商品発送まで今しばらくお待ち下さい。');
define('CSV_HEADER_SINSA_KEKKA_NG', '誠に残念ではございますが、後払い.comで今回は審査が通りませんでした。');


define('EMAIL_SEPARATOR', '------------------------------------------------------');
define('EMAIL_TEXT_SUBJECT', 'ご注文受付状況のお知らせ');
define('EMAIL_TEXT_ORDER_NUMBER', 'ご注文受付番号:');
define('EMAIL_TEXT_INVOICE_URL', "<br />" . 'ご注文受付状況詳細:');
define('EMAIL_TEXT_DATE_ORDERED', "<br />" . 'ご注文日:');
define('EMAIL_TEXT_COMMENTS_UPDATE', "<br />" . '<strong>[ご連絡事項]</strong>' . "<br />\n");
define('EMAIL_TEXT_STATUS_UPDATED', 'ご注文状況は次のようになっております。' . "<br /><br />\n\n");
define('EMAIL_TEXT_STATUS_LABEL', '<strong>現在の受付状況: %s' . "</strong><br /><br /><br />\n\n\n");
define('EMAIL_TEXT_STATUS_PLEASE_REPLY', 'ご質問などがございましたら、このメールにご返信ください。' . "\n");
define('ENTRY_NOTIFY_CUSTOMER', '処理状況を顧客に通知:');
define('ENTRY_NOTIFY_COMMENTS', '追加コメント:');
define('ENTRY_AUTO_SHIPPING_COMMENTS', '配送伝票番号追記:');
define('ENTRY_AUTO_SHIPPING_COMMENTS_KOME1', '<font color="red">*1</font>');
define('ENTRY_AUTO_SHIPPING_COMMENTS_INFO', '<font color="red">*1</font> CSVに後払い.comが対応する運送会社名が有り、配送伝票番号があるレコードは、お荷物お問い合わせURL等とともに自動的にコメントの最後に追加されます。');

define('ENTRY_NOTIFY_COMMENTS_AUTO_SHIPPING_TEXT1', '配送会社：');
define('ENTRY_NOTIFY_COMMENTS_AUTO_SHIPPING_TEXT2', '伝票番号：');
define('ENTRY_NOTIFY_COMMENTS_AUTO_SHIPPING_TEXT3', 'お荷物お問い合わせURL：');



	$csv_torihiki_header = array(
			'注文日',
			'郵便番号',
			'住所',
			'氏名',
			'氏名かな',
			'電話番号',
			'メールアドレス',
			'職業',
			'別配送先郵便番号',
			'別配送先住所',
			'別配送先氏名',
			'別配送先氏名かな',
			'別配送先電話番号',
			'購入品目(複数商品の場合は縦に列記)',
			'単価',
			'数量',
			'送料(複数商品がある場合は最後の行にあわせて入力)',
			'店舗手数料(複数商品がある場合は最後の行にあわせて入力)',
			'請求金額合計(複数商品がある場合は最後の行にあわせて入力)',
			'受付サイト',
			'任意注文番号',
			'備考',
	);
	
	$csv_shipping_header = array(
			'注文ID(このデータは書き換えないでください)',
			'配送会社名',
			'配送伝票番号',
			'注文日(表示用データ。編集不可)',
			'購入者名(表示用データ。編集不可)',
			'購入者電話番号(表示用データ。編集不可)',
			'購入金額(表示用データ。編集不可)',
			'配送先住所(表示用データ。編集不可)',
			'任意注文番号(このデータは書き換えないでください)',
	);

	/*↓配送伝票登録CSVファイル仕様書に従い変更して下さい。↓*/
	/*送会社お荷物お問い合わせURLは各社変更する可能性がありますので、実稼動する前に充分に確認を行って下さい。*/
	$csv_shipping_code = array(
				'クロネコヤマト' => 'http://toi.kuronekoyamato.co.jp/cgi-bin/tneko',
				'クロネコ' => 'http://toi.kuronekoyamato.co.jp/cgi-bin/tneko',
				'佐川急便' => 'http://k2k.sagawa-exp.co.jp/p/sagawa/web/okurijoinput.jsp',
				'佐川' => 'http://k2k.sagawa-exp.co.jp/p/sagawa/web/okurijoinput.jsp',
				'日本通運' => 'http://www19.nittsu.co.jp/confirm/index.php',
				'日通' => 'http://www19.nittsu.co.jp/confirm/index.php',
				'ゆうパック' => 'http://tracking.post.japanpost.jp/service/jsp/refi/DP311-00100.jsp',
				'西濃運輸' => 'http://www.seino.co.jp/seino/',
				'西濃' => 'http://www.seino.co.jp/seino/',
				'福山通運' => 'http://www4.fukutsu.co.jp/inq/INQJJ120.html',
				'福山' => 'http://www4.fukutsu.co.jp/inq/INQJJ120.html',
				'名鉄運輸' => 'http://ap.meitetsuunyu.co.jp/group/gyomu/webtsuiseki.jsp',
				'名鉄' => 'http://ap.meitetsuunyu.co.jp/group/gyomu/webtsuiseki.jsp',
				'新潟運輸' => 'http://www.niigataunyu.co.jp/nimotsu/index_nim.html',
				'新潟' => 'http://www.niigataunyu.co.jp/nimotsu/index_nim.html',
				'トナミ運輸' => 'http://www.tonami.co.jp/',
				'トナミ' => 'http://www.tonami.co.jp/',
				'西武運輸' => 'http://inquire.trc.seibu-unyu.co.jp/inquire/Main.jsp',
				'西武' => 'http://inquire.trc.seibu-unyu.co.jp/inquire/Main.jsp',
				'フットワーク' => 'http://www.footwork.co.jp/fwexphp/inquiry/chase/init.do',
				'物流工作' => 'http://210.196.161.103/kamotsu/test.php',
				'物流' => 'http://210.196.161.103/kamotsu/test.php',
				'メール便' => 'http://toi.kuronekoyamato.co.jp/cgi-bin/tneko',
				'EMS' => 'http://tracking.post.japanpost.jp/service/numberSearch.do?searchKind=S004',
				'近物レックス' => 'http://boxtoi.jitbox.co.jp/boxtoi/inquiry',
				'近物' => 'http://boxtoi.jitbox.co.jp/boxtoi/inquiry',
				'その他' => '',
				'久留米運送' => 'http://www4.kisc.co.jp/kurume-trans/toiawase.html',
				'久留米' => 'http://www4.kisc.co.jp/kurume-trans/toiawase.html',
				'書留' => 'http://tracking.post.japanpost.jp/service/mobile_num_search.do?searchKind=S001',
				'DHL' => 'http://www.dhl.co.jp/publish/jp/ja/eshipping/track.high.html',
				'ヤマトホームコンビニエンス' => 'http://www.e-moving.jp/Manage',
				'王子運送' => 'http://www.ojitrn.co.jp/tracing/sts00.asp',
				'王子' => 'http://www.ojitrn.co.jp/tracing/sts00.asp',
				'札幌通運' => 'http://www.sattsu.co.jp/kamotsu/ewebLogin.aspx',
				'札幌' => 'http://www.sattsu.co.jp/kamotsu/ewebLogin.aspx',
	);

?>
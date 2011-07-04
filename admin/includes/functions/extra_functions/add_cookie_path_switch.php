<?php
/**
 * @package patches
 * @copyright Copyright 2003-2010 Zen Cart Development Team
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: add_cookie_path_switch.php 429 2010-12-07 00:15:26Z bigmouse-sugimoto $
 */
if (!defined('SESSION_USE_ROOT_COOKIE_PATH') || !defined('SESSION_ADD_PERIOD_PREFIX'))
{
  $sql = "SELECT configuration_group_id FROM " . TABLE_CONFIGURATION_GROUP . "
          WHERE configuration_group_title = 'Sessions'";
  $result = $db->execute($sql);
  if ($result->RecordCount() > 0)
  {
    $id = $result->fields['configuration_group_id'];
  } else
  {
    $id = 15;
  }
  if (!defined('SESSION_USE_ROOT_COOKIE_PATH'))
  {
    $sql = "INSERT INTO " . TABLE_CONFIGURATION . "
           SET configuration_key = 'SESSION_USE_ROOT_COOKIE_PATH',
                sort_order =  '999',
                configuration_title = 'Use root path for cookie path',
                configuration_value = 'False',
                configuration_description = '通常Zen Cart では、ショップが利用しているディレクトリをクッキーパスとして利用します。<br />
この方式は幾つかのサーバーにおいて問題が発生する場合があります。<br />
この設定により、ショップのディレクトリでは無く、サーバーのルートにクッキーパスを指定する事ができるようにします。<br />
セッションに問題が発生する場合にのみ利用する様にしてください。<br />
この設定を変更した後、管理画面へログインできなくなるかもしれません。その場合にはブラウザのクッキーを削除する事で対応してください。
' ,
                configuration_group_id = " . (int)$id . ",
                set_function = 'zen_cfg_select_option(array(\'True\', \'False\'), '
                 " ;
    $result = $db->execute($sql);
  }
  if (!defined('SESSION_ADD_PERIOD_PREFIX'))
  {
    $sql = "INSERT INTO " . TABLE_CONFIGURATION . "
           SET configuration_key = 'SESSION_ADD_PERIOD_PREFIX',
                sort_order =  '999',
                configuration_title = 'Add period prefix to cookie domain',
                configuration_value = 'True',
                configuration_description = '通常Zen Cart は、クッキードメインに対して、接頭辞を追加します。（例： .www.mydomain.com.）<br />
これにより幾つかのサーバーの設定によっては、問題が発生する場合があります。<br />
もし、セッションに問題が発生するようであれば、この設定を False にしてお試しください。<br />
デフォルトは True です。
',
                configuration_group_id = " . (int)$id . ",
                set_function = 'zen_cfg_select_option(array(\'True\', \'False\'), '
                 " ;
    $result = $db->execute($sql);
  }
}
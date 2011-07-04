<?php
/**
 * Checkout Process Page
 *
 * @package page
 * @copyright Copyright 2003-2006 Zen Cart Development Team
 * @copyright Portions Copyright 2003 osCommerce
 * @license http://www.zen-cart.com/license/2_0.txt GNU Public License V2.0
 * @version $Id: header_php.php 4276 2006-08-26 03:18:28Z drbyte $
 */
// This should be first line of the script:
  $zco_notifier->notify('NOTIFY_HEADER_START_CHECKOUT_PROCESS');

  require(DIR_WS_MODULES . zen_get_module_directory('checkout_process.php'));

// load the after_process function from the payment modules
  $payment_modules->after_process();

  $_SESSION['cart']->reset(true);

// unregister session variables used during checkout
  unset($_SESSION['sendto']);
  unset($_SESSION['billto']);
  unset($_SESSION['shipping']);
  unset($_SESSION['payment']);
  unset($_SESSION['comments']);
  if (REPETITION_CHECK_ENABLED == 'true') {
    $db->Execute("delete from " . TABLE_REPETITION_CHECK . "
                        where customers_id = '" . (int)$_SESSION['customer_id'] . "'
                        and check_hash = '" . $_SESSION['repetition_check'] . "'
                        ");
    unset($_SESSION['repetition_check']);
  }
  $order_total_modules->clear_posts();//ICW ADDED FOR CREDIT CLASS SYSTEM

  // This should be before the zen_redirect:
  $zco_notifier->notify('NOTIFY_HEADER_END_CHECKOUT_PROCESS');

  zen_redirect(zen_href_link(FILENAME_CHECKOUT_SUCCESS, '', 'SSL'));

  require(DIR_WS_INCLUDES . 'application_bottom.php');
?>
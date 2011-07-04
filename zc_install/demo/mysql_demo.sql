UPDATE configuration SET configuration_value='true' WHERE configuration_key='DOWNLOAD_ENABLED';
#
# Dumping data for table address_book
#

INSERT INTO address_book (address_book_id, customers_id, entry_gender, entry_company, entry_firstname, entry_lastname, entry_street_address, entry_suburb, entry_postcode, entry_city, entry_state, entry_country_id, entry_zone_id) VALUES (1, 1, 'm', 'ACME Inc.', 'John', 'Doe', '1 Way Street', '', '12345', 'NeverNever', '', 223, 12);

#
# Dumping data for table categories
#

INSERT INTO categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified, categories_status) VALUES (1, 'categories/category_hardware.gif', 0, 1, '2004-06-23 12:37:09', NULL, 1);
INSERT INTO categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified, categories_status) VALUES (2, 'categories/category_software.gif', 0, 2, '2004-06-23 12:38:55', NULL, 1);
INSERT INTO categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified, categories_status) VALUES (3, 'categories/category_dvd_movies.gif', 0, 3, '2004-06-23 12:39:42', '2004-06-23 12:40:48', 1);
INSERT INTO categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified, categories_status) VALUES (4, 'categories/subcategory_keyboards.gif', 1, 1, '2004-06-23 12:42:31', NULL, 1);
INSERT INTO categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified, categories_status) VALUES (5, 'categories/subcategory_mice.gif', 1, 2, '2004-06-23 12:43:54', NULL, 1);
INSERT INTO categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified, categories_status) VALUES (6, 'categories/subcategory_printers.gif', 1, 3, '2004-06-23 12:45:03', NULL, 1);
INSERT INTO categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified, categories_status) VALUES (7, 'categories/subcategory_action.gif', 3, 1, '2004-06-23 12:46:50', NULL, 1);
INSERT INTO categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified, categories_status) VALUES (8, 'categories/subcategory_cartoons.gif', 3, 2, '2004-06-23 12:47:36', NULL, 1);
INSERT INTO categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified, categories_status) VALUES (9, 'categories/subcategory_comedy.gif', 3, 3, '2004-06-23 12:48:10', NULL, 1);
INSERT INTO categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified, categories_status) VALUES (10, 'categories/gift1000.gif', 0, 4, '2004-06-23 14:00:13', '2004-06-23 21:25:33', 1);

#
# Dumping data for table categories_description
#

INSERT INTO categories_description (categories_id, language_id, categories_name, categories_description) VALUES (1, 1, 'Hardware', '');
INSERT INTO categories_description (categories_id, language_id, categories_name, categories_description) VALUES (1, 2, 'ハードウェア', '');
INSERT INTO categories_description (categories_id, language_id, categories_name, categories_description) VALUES (2, 1, 'Software', '');
INSERT INTO categories_description (categories_id, language_id, categories_name, categories_description) VALUES (2, 2, 'ソフトウェア', '');
INSERT INTO categories_description (categories_id, language_id, categories_name, categories_description) VALUES (3, 1, 'DVD Movies', '');
INSERT INTO categories_description (categories_id, language_id, categories_name, categories_description) VALUES (3, 2, 'DVDムービー', '');
INSERT INTO categories_description (categories_id, language_id, categories_name, categories_description) VALUES (4, 1, 'Keyboards', '');
INSERT INTO categories_description (categories_id, language_id, categories_name, categories_description) VALUES (4, 2, 'キーボード', '');
INSERT INTO categories_description (categories_id, language_id, categories_name, categories_description) VALUES (5, 1, 'Mice', '');
INSERT INTO categories_description (categories_id, language_id, categories_name, categories_description) VALUES (5, 2, 'マウス', '');
INSERT INTO categories_description (categories_id, language_id, categories_name, categories_description) VALUES (6, 1, 'Printers', '');
INSERT INTO categories_description (categories_id, language_id, categories_name, categories_description) VALUES (6, 2, 'プリンター', '');
INSERT INTO categories_description (categories_id, language_id, categories_name, categories_description) VALUES (7, 1, 'Action', '');
INSERT INTO categories_description (categories_id, language_id, categories_name, categories_description) VALUES (7, 2, 'アクション', '');
INSERT INTO categories_description (categories_id, language_id, categories_name, categories_description) VALUES (8, 1, 'Cartoons', '');
INSERT INTO categories_description (categories_id, language_id, categories_name, categories_description) VALUES (8, 2, 'アニメ', '');
INSERT INTO categories_description (categories_id, language_id, categories_name, categories_description) VALUES (9, 1, 'Comedy', '');
INSERT INTO categories_description (categories_id, language_id, categories_name, categories_description) VALUES (9, 2, 'コメディ', '');
INSERT INTO categories_description (categories_id, language_id, categories_name, categories_description) VALUES (10, 1, 'Gift Certificates', '');
INSERT INTO categories_description (categories_id, language_id, categories_name, categories_description) VALUES (10, 2, 'ギフト券', '');


# Dumping data for table customers
#

INSERT INTO customers (customers_id, customers_gender, customers_firstname, customers_lastname, customers_dob, customers_email_address, customers_nick, customers_default_address_id, customers_telephone, customers_fax, customers_password, customers_newsletter, customers_group_pricing, customers_email_format) VALUES (1, 'm', 'John', 'doe', '2001-01-01 00:00:00', 'root@localhost', '', 1, '12345', '', 'd95e8fa7f20a009372eb3477473fcd34:1c', '0', 0, 'TEXT');

#
# Dumping data for table customers_info
#

INSERT INTO customers_info (customers_info_id, customers_info_date_of_last_logon, customers_info_number_of_logons, customers_info_date_account_created, customers_info_date_account_last_modified, global_product_notifications) VALUES (1, '0001-01-01 00:00:00', 0, '2004-01-21 01:35:28', '0001-01-01 00:00:00', 0);

#
# Dumping data for table group_pricing
#

INSERT INTO group_pricing (group_id, group_name, group_percentage, last_modified, date_added) VALUES (1, 'Group 10', '10.00', NULL, '2004-04-29 00:21:04');


#
# Dumping data for table manufacturers
#


INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (1, 'マイクロソフト', 'manufacturers/manufacturer_microsoft.gif', '2004-06-23 12:51:21', NULL);
INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (2, 'ヒューレットパッカード', 'manufacturers/manufacturer_hewlett_packard.gif', '2004-06-23 13:04:42', '2004-06-23 13:05:19');
INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (3, 'GT インタラクティブ', 'manufacturers/manufacturer_gt_interactive.gif', '2004-06-23 13:11:15', NULL);
INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (4, 'フォックス', 'manufacturers/manufacturer_fox.gif', '2004-06-23 13:32:49', '2004-06-23 13:34:11');
INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (5, 'ワーナー', 'manufacturers/manufacturer_warner.gif', '2004-06-23 13:33:47', NULL);

#
# Dumping data for table manufacturers_info
#

INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (1, 1, 'http://www.microsoft.com', 0, NULL);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (1, 2, 'http://www.microsoft.com/japan/', 0, NULL);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (2, 1, 'http://www.hewlettpackard.com', 0, NULL);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (2, 2, 'http://www.hp.com/jp/', 0, NULL);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (3, 1, 'http://www.infogrames.com', 0, NULL);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (3, 2, 'http://www.infogrames.com', 0, NULL);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (4, 1, 'http://www.fox.com', 0, NULL);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (4, 2, 'http://www.foxjapan.com', 2, '2004-08-02 12:15:28');
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (5, 1, 'http://www.warner.com', 0, NULL);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (5, 2, 'http://www.warnerbros.co.jp', 3, '2004-08-08 14:16:14');

#
# Dumping data for table media_clips
#

INSERT INTO media_clips (clip_id, media_id, clip_type, clip_filename, date_added, last_modified) VALUES (1, 1, 1, 'thehunter.mp3', '2004-06-01 20:57:43', '0000-00-00 00:00:00'),
(6, 2, 1, 'thehunter.mp3', '2004-07-13 00:45:09', '0000-00-00 00:00:00');

#
# Dumping data for table media_manager
#

INSERT INTO media_manager (media_id, media_name, last_modified, date_added) VALUES (1, 'Russ Tippins - The Hunter', '2004-06-01 20:57:43', '2004-06-01 20:42:53'),
(2, 'Help!', '2004-07-13 01:01:14', '2004-07-12 17:57:45');

#
# Dumping data for table media_to_products
#

INSERT INTO media_to_products (media_id, product_id) VALUES (1, 166),
(2, 169);

#
# Dumping data for table media_types
#

INSERT INTO media_types (type_id, type_name, type_ext) VALUES (1, 'MP3', '.mp3');

#
# Dumping data for table music_genre
#

INSERT INTO music_genre (music_genre_id, music_genre_name, date_added, last_modified) VALUES (1, 'Rock', '2004-06-01 20:53:26', NULL),
(2, 'Jazz', '2004-06-01 20:53:45', NULL);

#
# Dumping data for table product_music_extra
#

INSERT INTO product_music_extra (products_id, artists_id, record_company_id, music_genre_id) VALUES (166, 1, 0, 1),
(169, 1, 1, 2);

#
# Dumping data for table product_types_to_category
#

INSERT INTO product_types_to_category (product_type_id, category_id) VALUES (3, 63),
(4, 63);

#
# Dumping data for table products
#

INSERT INTO products (products_id, products_type, products_quantity, products_model, products_image, products_price, products_virtual, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_quantity_order_min, products_quantity_order_units, products_priced_by_attribute, product_is_free, product_is_call, products_quantity_mixed, product_is_always_free_shipping, products_qty_box_status, products_quantity_order_max, products_sort_order, products_discount_type, products_discount_type_from, products_price_sorter, master_categories_id, products_mixed_discount_quantity) VALUES (1, 1, 99, 'MSINTKB', 'microsoft/intkeyboardps2.gif', '6990.0000', 0, '2004-06-23 12:56:42', '2004-08-01 15:30:35', NULL, '8.00', 1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, '0.0000', 0, 1);
INSERT INTO products (products_id, products_type, products_quantity, products_model, products_image, products_price, products_virtual, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_quantity_order_min, products_quantity_order_units, products_priced_by_attribute, product_is_free, product_is_call, products_quantity_mixed, product_is_always_free_shipping, products_qty_box_status, products_quantity_order_max, products_sort_order, products_discount_type, products_discount_type_from, products_price_sorter, master_categories_id, products_mixed_discount_quantity) VALUES (2, 1, 97, 'MSIMEXP', 'microsoft/imexplorer.gif', '6490.0000', 0, '2004-06-23 12:59:46', NULL, NULL, '1.00', 1, 2, 1, 3, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, '0.0000', 0, 1);
INSERT INTO products (products_id, products_type, products_quantity, products_model, products_image, products_price, products_virtual, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_quantity_order_min, products_quantity_order_units, products_priced_by_attribute, product_is_free, product_is_call, products_quantity_mixed, product_is_always_free_shipping, products_qty_box_status, products_quantity_order_max, products_sort_order, products_discount_type, products_discount_type_from, products_price_sorter, master_categories_id, products_mixed_discount_quantity) VALUES (3, 1, 99, 'MSIMPRO', 'microsoft/msimpro.gif', '4990.0000', 0, '2004-06-23 13:01:50', NULL, NULL, '1.00', 1, 2, 1, 1, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, '0.0000', 0, 1);
INSERT INTO products (products_id, products_type, products_quantity, products_model, products_image, products_price, products_virtual, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_quantity_order_min, products_quantity_order_units, products_priced_by_attribute, product_is_free, product_is_call, products_quantity_mixed, product_is_always_free_shipping, products_qty_box_status, products_quantity_order_max, products_sort_order, products_discount_type, products_discount_type_from, products_price_sorter, master_categories_id, products_mixed_discount_quantity) VALUES (4, 1, 99, 'HPLJ1100XI', 'hewlett_packard/lj1100xi.gif', '49990.0000', 0, '2004-06-23 13:07:56', NULL, NULL, '45.00', 1, 2, 2, 1, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, '0.0000', 0, 1);
INSERT INTO products (products_id, products_type, products_quantity, products_model, products_image, products_price, products_virtual, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_quantity_order_min, products_quantity_order_units, products_priced_by_attribute, product_is_free, product_is_call, products_quantity_mixed, product_is_always_free_shipping, products_qty_box_status, products_quantity_order_max, products_sort_order, products_discount_type, products_discount_type_from, products_price_sorter, master_categories_id, products_mixed_discount_quantity) VALUES (5, 1, 100, 'PC-DISC', 'gt_interactive/disciples.gif', '9000.0000', 0, '2004-06-23 13:13:53', NULL, NULL, '2.00', 1, 2, 0, 0, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, '0.0000', 2, 1);
INSERT INTO products (products_id, products_type, products_quantity, products_model, products_image, products_price, products_virtual, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_quantity_order_min, products_quantity_order_units, products_priced_by_attribute, product_is_free, product_is_call, products_quantity_mixed, product_is_always_free_shipping, products_qty_box_status, products_quantity_order_max, products_sort_order, products_discount_type, products_discount_type_from, products_price_sorter, master_categories_id, products_mixed_discount_quantity) VALUES (6, 1, 99, 'PC-TWOF', 'gt_interactive/wheel_of_time.gif', '9990.0000', 0, '2004-06-23 13:16:10', NULL, NULL, '2.50', 1, 2, 3, 1, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, '0.0000', 2, 1);
INSERT INTO products (products_id, products_type, products_quantity, products_model, products_image, products_price, products_virtual, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_quantity_order_min, products_quantity_order_units, products_priced_by_attribute, product_is_free, product_is_call, products_quantity_mixed, product_is_always_free_shipping, products_qty_box_status, products_quantity_order_max, products_sort_order, products_discount_type, products_discount_type_from, products_price_sorter, master_categories_id, products_mixed_discount_quantity) VALUES (7, 1, 98, 'PC-UNTM', 'gt_interactive/unreal_tournament.gif', '8990.0000', 0, '2004-06-23 13:18:50', NULL, NULL, '2.00', 1, 2, 3, 2, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, '0.0000', 2, 1);
INSERT INTO products (products_id, products_type, products_quantity, products_model, products_image, products_price, products_virtual, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_quantity_order_min, products_quantity_order_units, products_priced_by_attribute, product_is_free, product_is_call, products_quantity_mixed, product_is_always_free_shipping, products_qty_box_status, products_quantity_order_max, products_sort_order, products_discount_type, products_discount_type_from, products_price_sorter, master_categories_id, products_mixed_discount_quantity) VALUES (8, 1, 98, 'DVD-LTWP', 'dvd/lethal_weapon.gif', '3490.0000', 0, '2004-06-23 13:37:38', NULL, NULL, '3.00', 1, 2, 5, 2, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, '0.0000', 7, 1);
INSERT INTO products (products_id, products_type, products_quantity, products_model, products_image, products_price, products_virtual, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_quantity_order_min, products_quantity_order_units, products_priced_by_attribute, product_is_free, product_is_call, products_quantity_mixed, product_is_always_free_shipping, products_qty_box_status, products_quantity_order_max, products_sort_order, products_discount_type, products_discount_type_from, products_price_sorter, master_categories_id, products_mixed_discount_quantity) VALUES (9, 1, 93, 'DVD-SPEED', 'dvd/speed.gif', '3990.0000', 0, '2004-06-23 13:39:23', NULL, NULL, '2.00', 1, 2, 4, 7, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, '0.0000', 0, 1);
INSERT INTO products (products_id, products_type, products_quantity, products_model, products_image, products_price, products_virtual, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_quantity_order_min, products_quantity_order_units, products_priced_by_attribute, product_is_free, product_is_call, products_quantity_mixed, product_is_always_free_shipping, products_qty_box_status, products_quantity_order_max, products_sort_order, products_discount_type, products_discount_type_from, products_price_sorter, master_categories_id, products_mixed_discount_quantity) VALUES (10, 1, 100, 'DVD-SPEED2', 'dvd/speed_2.gif', '4200.0000', 0, '2004-06-23 13:41:27', NULL, NULL, '2.00', 1, 2, 4, 0, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, '0.0000', 0, 1);
INSERT INTO products (products_id, products_type, products_quantity, products_model, products_image, products_price, products_virtual, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_quantity_order_min, products_quantity_order_units, products_priced_by_attribute, product_is_free, product_is_call, products_quantity_mixed, product_is_always_free_shipping, products_qty_box_status, products_quantity_order_max, products_sort_order, products_discount_type, products_discount_type_from, products_price_sorter, master_categories_id, products_mixed_discount_quantity) VALUES (11, 1, 100, 'DVD-MATR', 'dvd/the_matrix.gif', '3990.0000', 0, '2004-06-23 13:43:20', '2004-08-06 09:55:15', NULL, '2.50', 1, 2, 5, 0, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, '0.0000', 0, 1);
INSERT INTO products (products_id, products_type, products_quantity, products_model, products_image, products_price, products_virtual, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_quantity_order_min, products_quantity_order_units, products_priced_by_attribute, product_is_free, product_is_call, products_quantity_mixed, product_is_always_free_shipping, products_qty_box_status, products_quantity_order_max, products_sort_order, products_discount_type, products_discount_type_from, products_price_sorter, master_categories_id, products_mixed_discount_quantity) VALUES (12, 1, 96, 'DVD-ABUG', 'dvd/a_bugs_life.gif', '3590.0000', 0, '2004-06-23 13:45:51', NULL, NULL, '2.00', 1, 2, 5, 4, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, '0.0000', 8, 1);
INSERT INTO products (products_id, products_type, products_quantity, products_model, products_image, products_price, products_virtual, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_quantity_order_min, products_quantity_order_units, products_priced_by_attribute, product_is_free, product_is_call, products_quantity_mixed, product_is_always_free_shipping, products_qty_box_status, products_quantity_order_max, products_sort_order, products_discount_type, products_discount_type_from, products_price_sorter, master_categories_id, products_mixed_discount_quantity) VALUES (13, 1, 0, 'DVD-TSAB', 'dvd/theres_something_about_mary.gif', '4990.0000', 0, '2004-06-23 13:48:17', NULL, NULL, '2.30', 0, 2, 4, 0, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, '0.0000', 0, 1);
INSERT INTO products (products_id, products_type, products_quantity, products_model, products_image, products_price, products_virtual, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_quantity_order_min, products_quantity_order_units, products_priced_by_attribute, product_is_free, product_is_call, products_quantity_mixed, product_is_always_free_shipping, products_qty_box_status, products_quantity_order_max, products_sort_order, products_discount_type, products_discount_type_from, products_price_sorter, master_categories_id, products_mixed_discount_quantity) VALUES (14, 1, 99, 'DVD-YGEM', 'dvd/youve_got_mail.gif', '3490.0000', 0, '2004-06-23 13:50:05', NULL, NULL, '2.00', 1, 2, 5, 1, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, '0.0000', 0, 1);
INSERT INTO products (products_id, products_type, products_quantity, products_model, products_image, products_price, products_virtual, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_quantity_order_min, products_quantity_order_units, products_priced_by_attribute, product_is_free, product_is_call, products_quantity_mixed, product_is_always_free_shipping, products_qty_box_status, products_quantity_order_max, products_sort_order, products_discount_type, products_discount_type_from, products_price_sorter, master_categories_id, products_mixed_discount_quantity) VALUES (15, 1, 99, 'GIFT500', 'gift_certificates/gv_500.gif', '500.0000', 1, '2004-06-23 21:20:31', NULL, NULL, '0.00', 1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, '0.0000', 0, 1);
INSERT INTO products (products_id, products_type, products_quantity, products_model, products_image, products_price, products_virtual, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_quantity_order_min, products_quantity_order_units, products_priced_by_attribute, product_is_free, product_is_call, products_quantity_mixed, product_is_always_free_shipping, products_qty_box_status, products_quantity_order_max, products_sort_order, products_discount_type, products_discount_type_from, products_price_sorter, master_categories_id, products_mixed_discount_quantity) VALUES (16, 1, 100, 'GIFT1000', 'gift_certificates/gv_1000.gif', '1000.0000', 1, '2004-06-23 21:22:22', '2004-06-23 21:22:47', NULL, '0.00', 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, '0.0000', 0, 1);

#
# Dumping data for table products_attributes
#

INSERT INTO products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix, products_options_sort_order, product_attribute_is_free, products_attributes_weight, products_attributes_weight_prefix, attributes_display_only, attributes_default, attributes_discounted, attributes_image, attributes_price_base_included, attributes_price_onetime, attributes_price_factor, attributes_price_factor_offset, attributes_price_factor_onetime, attributes_price_factor_onetime_offset, attributes_qty_prices, attributes_qty_prices_onetime, attributes_price_words, attributes_price_words_free, attributes_price_letters, attributes_price_letters_free, attributes_required) VALUES (4, 1, 1, 1, '0000.0000', '+', 1, 0, '0.0000', '+', 0, 1, 0, '', 1, '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', NULL, NULL, '0.0000', 0, '0.0000', 0, 0);
INSERT INTO products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix, products_options_sort_order, product_attribute_is_free, products_attributes_weight, products_attributes_weight_prefix, attributes_display_only, attributes_default, attributes_discounted, attributes_image, attributes_price_base_included, attributes_price_onetime, attributes_price_factor, attributes_price_factor_offset, attributes_price_factor_onetime, attributes_price_factor_onetime_offset, attributes_qty_prices, attributes_qty_prices_onetime, attributes_price_words, attributes_price_words_free, attributes_price_letters, attributes_price_letters_free, attributes_required) VALUES (5, 1, 2, 3, '0.0000', '+', 2, 0, '0.0000', '+', 1, 0, 1, '', 0, '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', NULL, NULL, '0.0000', 0, '0.0000', 0, 0);
INSERT INTO products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix, products_options_sort_order, product_attribute_is_free, products_attributes_weight, products_attributes_weight_prefix, attributes_display_only, attributes_default, attributes_discounted, attributes_image, attributes_price_base_included, attributes_price_onetime, attributes_price_factor, attributes_price_factor_offset, attributes_price_factor_onetime, attributes_price_factor_onetime_offset, attributes_qty_prices, attributes_qty_prices_onetime, attributes_price_words, attributes_price_words_free, attributes_price_letters, attributes_price_letters_free, attributes_required) VALUES (6, 1, 2, 4, '0.0000', '+', 3, 0, '0.0000', '+', 0, 0, 1, '', 1, '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', NULL, NULL, '0.0000', 0, '0.0000', 0, 0);
INSERT INTO products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix, products_options_sort_order, product_attribute_is_free, products_attributes_weight, products_attributes_weight_prefix, attributes_display_only, attributes_default, attributes_discounted, attributes_image, attributes_price_base_included, attributes_price_onetime, attributes_price_factor, attributes_price_factor_offset, attributes_price_factor_onetime, attributes_price_factor_onetime_offset, attributes_qty_prices, attributes_qty_prices_onetime, attributes_price_words, attributes_price_words_free, attributes_price_letters, attributes_price_letters_free, attributes_required) VALUES (7, 1, 1, 2, '2000.0000', '-', 2, 0, '0.0000', '+', 0, 0, 1, '', 1, '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', NULL, NULL, '0.0000', 0, '0.0000', 0, 0);
INSERT INTO products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix, products_options_sort_order, product_attribute_is_free, products_attributes_weight, products_attributes_weight_prefix, attributes_display_only, attributes_default, attributes_discounted, attributes_image, attributes_price_base_included, attributes_price_onetime, attributes_price_factor, attributes_price_factor_offset, attributes_price_factor_onetime, attributes_price_factor_onetime_offset, attributes_qty_prices, attributes_qty_prices_onetime, attributes_price_words, attributes_price_words_free, attributes_price_letters, attributes_price_letters_free, attributes_required) VALUES (8, 2, 3, 5, '0.0000', '+', 0, 0, '0.0000', '+', 0, 0, 1, '', 1, '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', NULL, NULL, '0.0000', 0, '0.0000', 0, 0);
INSERT INTO products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix, products_options_sort_order, product_attribute_is_free, products_attributes_weight, products_attributes_weight_prefix, attributes_display_only, attributes_default, attributes_discounted, attributes_image, attributes_price_base_included, attributes_price_onetime, attributes_price_factor, attributes_price_factor_offset, attributes_price_factor_onetime, attributes_price_factor_onetime_offset, attributes_qty_prices, attributes_qty_prices_onetime, attributes_price_words, attributes_price_words_free, attributes_price_letters, attributes_price_letters_free, attributes_required) VALUES (9, 2, 3, 6, '0.0000', '+', 0, 0, '0.0000', '+', 0, 0, 1, '', 1, '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', NULL, NULL, '0.0000', 0, '0.0000', 0, 0);
INSERT INTO products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix, products_options_sort_order, product_attribute_is_free, products_attributes_weight, products_attributes_weight_prefix, attributes_display_only, attributes_default, attributes_discounted, attributes_image, attributes_price_base_included, attributes_price_onetime, attributes_price_factor, attributes_price_factor_offset, attributes_price_factor_onetime, attributes_price_factor_onetime_offset, attributes_qty_prices, attributes_qty_prices_onetime, attributes_price_words, attributes_price_words_free, attributes_price_letters, attributes_price_letters_free, attributes_required) VALUES (10, 13, 3, 5, '0.0000', '+', 0, 0, '0.0000', '+', 0, 0, 1, '', 1, '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', NULL, NULL, '0.0000', 0, '0.0000', 0, 0);
INSERT INTO products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix, products_options_sort_order, product_attribute_is_free, products_attributes_weight, products_attributes_weight_prefix, attributes_display_only, attributes_default, attributes_discounted, attributes_image, attributes_price_base_included, attributes_price_onetime, attributes_price_factor, attributes_price_factor_offset, attributes_price_factor_onetime, attributes_price_factor_onetime_offset, attributes_qty_prices, attributes_qty_prices_onetime, attributes_price_words, attributes_price_words_free, attributes_price_letters, attributes_price_letters_free, attributes_required) VALUES (11, 13, 3, 6, '0.0000', '+', 0, 0, '0.0000', '+', 0, 0, 1, '', 1, '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', NULL, NULL, '0.0000', 0, '0.0000', 0, 0);
INSERT INTO products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix, products_options_sort_order, product_attribute_is_free, products_attributes_weight, products_attributes_weight_prefix, attributes_display_only, attributes_default, attributes_discounted, attributes_image, attributes_price_base_included, attributes_price_onetime, attributes_price_factor, attributes_price_factor_offset, attributes_price_factor_onetime, attributes_price_factor_onetime_offset, attributes_qty_prices, attributes_qty_prices_onetime, attributes_price_words, attributes_price_words_free, attributes_price_letters, attributes_price_letters_free, attributes_required) VALUES (12, 12, 3, 5, '0.0000', '+', 0, 0, '0.0000', '+', 0, 0, 1, '', 1, '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', NULL, NULL, '0.0000', 0, '0.0000', 0, 0);
INSERT INTO products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix, products_options_sort_order, product_attribute_is_free, products_attributes_weight, products_attributes_weight_prefix, attributes_display_only, attributes_default, attributes_discounted, attributes_image, attributes_price_base_included, attributes_price_onetime, attributes_price_factor, attributes_price_factor_offset, attributes_price_factor_onetime, attributes_price_factor_onetime_offset, attributes_qty_prices, attributes_qty_prices_onetime, attributes_price_words, attributes_price_words_free, attributes_price_letters, attributes_price_letters_free, attributes_required) VALUES (13, 12, 3, 6, '0.0000', '+', 0, 0, '0.0000', '+', 0, 0, 1, '', 1, '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', NULL, NULL, '0.0000', 0, '0.0000', 0, 0);


#
# Dumping data for table products_description
#

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (1, 1, 'Microsoft Internet Keyboard PS/2', 'The Internet Keyboard has 10 Hot Keys on a comfortable standard keyboard design that also includes a detachable palm rest. The Hot Keys allow you to browse the web, or check e-mail directly from your keyboard. The IntelliType Pro software also allows you to customize your hot keys - make the Internet Keyboard work the way you want it to!', '', 6);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (1, 2, 'マイクロソフト Internet Keyboard PS/2', 'インターネット・キーボードには、分離可能なパームレストのついた快適な標準キーボードの上に、10個のホットキーがついています。ホットキーを押して、キーボードからウェブをブラウズしたり、電子メールを直接チェックすることができます。さらに IntelliType Pro ソフトウェアは、あなたがホットキーをカスタマイズすることを可能にします。あなたがよく利用する作業をインターネット・キーボードに設定しよう!', '', 82);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (2, 1, 'Microsoft IntelliMouse Explorer', 'Microsoft introduces its most advanced mouse, the IntelliMouse Explorer! IntelliMouse Explorer features a sleek design, an industrial-silver finish, a glowing red underside and taillight, creating a style and look unlike any other mouse. IntelliMouse Explorer combines the accuracy and reliability of Microsoft IntelliEye optical tracking technology, the convenience of two new customizable function buttons, the efficiency of the scrolling wheel and the comfort of expert ergonomic design. All these great features make this the best mouse for the PC!', '', 9);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (2, 2, 'マイクロソフト IntelliMouse Explorer', 'マイクロソフトはその最も高度なマウス、インテリマウス・エクスプローラを紹介します! なめらかなデザインが特徴のインテリマウス・エクスプローラは、シルバー・カラーで、底面と後部のライトは鮮烈な赤という、従来のマウスとはまったく違うスタイルです。インテリマウス・エクスプローラは、マイクロソフトの「インテリアイ」光学トラッキング技術により、正確さに信頼性を兼ね備えており、2個の新しいボタンはカスタマイズ可能です。スクロール・ホイールは効率的な操作をもたらし、エルゴノミックス（人間工学）設計は快適さをもたらします。これらの特徴のすべてが、このマウスをPCのための最良のマウスとしています!', '', 69);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (3, 1, 'Microsoft IntelliMouse Pro', 'Every element of IntelliMouse Pro - from its unique arched shape to the texture of the rubber grip around its base - is the product of extensive customer and ergonomic research. Microsoft\'s popular wheel control, which now allows zooming and universal scrolling functions, gives IntelliMouse Pro outstanding comfort and efficiency.', '', 8);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (3, 2, 'マイクロソフト インテリマウス Pro', 'インテリマウス・プロのすべての要素(そのユニークな弓形の形状から、ボディのまわりのラバーグリップの質感まで)は、広範囲のユーザと人間工学(エルゴノミクス)を研究した成果です。マイクロソフトの人気のあるホイール・コントロールは素早く移動してスクロールする機能を実現し、インテリマウス・プロに顕著な快適さと効率性を与えます。', '', 47);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (4, 1, 'Hewlett Packard LaserJet 1100Xi', 'HP has always set the pace in laser printing technology. The new generation HP LaserJet 1100 series sets another impressive pace, delivering a stunning 8 pages per minute print speed. The 600 dpi print resolution with HP\'s Resolution Enhancement technology (REt) makes every document more professional.<br><br>Enhanced print speed and laser quality results are just the beginning. With 2MB standard memory, HP LaserJet 1100xi users will be able to print increasingly complex pages. Memory can be increased to 18MB to tackle even more complex documents with ease. The HP LaserJet 1100xi supports key operating systems including Windows 3.1, 3.11, 95, 98, NT 4.0, OS/2 and DOS. Network compatibility available via the optional HP JetDirect External Print Servers.<br><br>HP LaserJet 1100xi also features The Document Builder for the Web Era from Trellix Corp. (featuring software to create Web documents).', 'www.pandi.hp.com/pandi-db/prodinfo.main?product=laserjet1100', 4);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (4, 2, 'ヒューレットパッカード LaserJet 1100Xi', 'レーザー印刷技術において、常に先端を歩んできたHP。新世代のHP LaserJet 1100シリーズは、これまでになく印象的な成果であり、毎分8ページを超える、驚くべき印刷速度を実現します。HPの高解像度技術(REt)による600dpiの印刷解像度は、あらゆるドキュメントをプロフェッショナル品質で作成します。<br><br>高められた印刷速度とレーザー品質は始まりに過ぎません。標準の2MBメモリにより、HP LaserJet 1100xiユーザはますます複雑なページを印刷することができます。また、より複雑なドキュメントに取り組むために、メモリは容易に18MBまで増設することができます。HP LaserJet 1100xiは、ウインドウズ3.1、3.11、95、98、NT 4.0、OS/2およびDOSなどの重要なオペレーティング・システムをサポートしています。オプションのHP JetDirect外部プリント・サーバーによってネットワーク互換性も実現します。<br><br>HP LaserJet 1100xiは、さらにTrellix社の「The Document Builder for the Web Era」をバンドルしています。(ウェブドキュメントを作成するソフトウェア)。', 'www.pandi.hp.com/pandi-db/prodinfo.main?product=laserjet1100', 44);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (5, 1, 'Disciples: Sacred Lands', 'A new age is dawning...<br><br>Enter the realm of the Sacred Lands, where the dawn of a New Age has set in motion the most momentous of wars. As the prophecies long foretold, four races now clash with swords and sorcery in a desperate bid to control the destiny of their gods. Take on the quest as a champion of the Empire, the Mountain Clans, the Legions of the Damned, or the Undead Hordes and test your faith in battles of brute force, spellbinding magic and acts of guile. Slay demons, vanquish giants and combat merciless forces of the dead and undead. But to ensure the salvation of your god, the hero within must evolve.<br><br>The day of reckoning has come... and only the chosen will survive.', '', 4);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (5, 2, 'ディサイプルズ Sacred Lands', '新たな時代が始まった...<br><br>新たな時代の夜明けが最も重大な戦争を始める、その聖地の領域に入りなさい。長い間言い伝えられた予言のように、神の運命をコントロールしようと必死に企てながら、4つの種族が剣と魔法をもって衝突する。The Empire(帝国)、Mountain Clans(山の民)、Legion of the Damned(地獄の軍団)や、Undead Hordes(亡者の奔流)の戦士として遠征し、魔法をかけたり策略をめぐらすなどして、獣のような力との戦いであなたの闘志を試します。デーモン達を滅ぼし、巨人達を征服し、死者や亡者の無慈悲な力と格闘しなさい。しかし、あなたが勇者の救済を保証することで、領土は発展するに違いありません。<br> <br>さあ、報いを受ける日は来た...選ばれた者のみ、生き残ることができるだろう。', '', 36);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (6, 1, 'The Wheel Of Time', 'The world in which The Wheel of Time takes place is lifted directly out of Jordan\'s pages; it\'s huge and consists of many different environments. How you navigate the world will depend largely on which game - single player or multipayer - you\'re playing. The single player experience, with a few exceptions, will see Elayna traversing the world mainly by foot (with a couple notable exceptions). In the multiplayer experience, your character will have more access to travel via Ter\'angreal, Portal Stones, and the Ways. However you move around, though, you\'ll quickly discover that means of locomotion can easily become the least of the your worries...<br><br>During your travels, you quickly discover that four locations are crucial to your success in the game. Not surprisingly, these locations are the homes of The Wheel of Time\'s main characters. Some of these places are ripped directly from the pages of Jordan\'s books, made flesh with Legend\'s unparalleled pixel-pushing ways. Other places are specific to the game, conceived and executed with the intent of expanding this game world even further. Either way, they provide a backdrop for some of the most intense first person action and strategy you\'ll have this year.', 'www.wheeloftime.com', 8);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (6, 2, 'The Wheel Of Time', 'ジョーダンのページがそのまま展開されるウィール・オブ・タイムの世界。それは巨大で、様々な環境で構成されています。あなたがシングルプレーヤーとマルチプレーヤーのどちらでゲームをプレイするかによって、どのように世界を進んでいくかが大きくちがってきます。シングルプレーヤーは、わずかの例外を除いて、Elayna(エレイナ)が主に歩いて(2、3の顕著な例外はあるが)この世界を横断しながら見ていくことを体験することができます。マルチプレーヤーは、キャラクターが旅を続ける中で、多くのTer\'Angreal(テル＝アングリアル)や、Portal Stonesを使いながらやその方法を体験をすることになります。どれほど動き回るのかという心配は必要ありません。移動がとても簡単になる方法を、速く見つけることができるでしょう。しかし...<br><br>旅をしていく中で、あなたがゲームで成功するためには、4つの場所が重大であることを発見するでしょう。驚くことはありません、これらの場所は、ウィール・オブ・タイムの主要なキャラクターの本拠地となります。これらの場所のうちのいくつかは、ジョーダンの本のページをそのまま再現しており、伝説を比類のないピクセル表現で表すことにより、生き生きと描いています。それ以外の場所は、ゲームの世界をさらに拡張するために作り出した、このゲームに特有のものです。どちらにしても、あなたが今年出会う中で最も強烈な一人称形式のアクション・戦略ゲームの背景となります。', 'www.wheeloftime.com', 58);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (7, 1, 'Unreal Tournament', 'From the creators of the best-selling Unreal, comes Unreal Tournament. A new kind of single player experience. A ruthless multiplayer revolution.<br><br>This stand-alone game showcases completely new team-based gameplay, groundbreaking multi-faceted single player action or dynamic multi-player mayhem. It\'s a fight to the finish for the title of Unreal Grand Master in the gladiatorial arena. A single player experience like no other! Guide your team of \'bots\' (virtual teamates) against the hardest criminals in the galaxy for the ultimate title - the Unreal Grand Master.', '', 10);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (7, 2, 'Unreal Tournament', '製作されて以来ベストセラーのUnrealから、Unreal Tournamentが登場。新しい種類のシングルプレーヤー経験。無慈悲なマルチプレーヤーの革命。<br><br>このスタンド・アロンのゲームは新しいチームベースのゲームプレイを展開します。多様なアクションの先駆けであるシングルプレーヤーや、マルチプレイヤーによるダイナミックな破壊行為。アリーナの剣闘士が、Unrealのグランドマスターというタイトルを得るまで終わらない戦い。他に類をみないであろうシングルプレーヤー経験! 究極のタイトルであるUnrealのグランドマスターのために、Bot（バーチャル・チームメート）がガイドするあなたのチームと、もっとも凶悪な犯罪者は、銀河で対決する。', '', 37);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (8, 1, 'Lethal Weapon', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r\n\r\n<br>\r\n\r\nLanguages: English, Deutsch.\r\n\r\n<br>\r\n\r\nSubtitles: English, Deutsch, Spanish.\r\n\r\n<br>\r\n\r\nAudio: Dolby Surround 5.1.\r\n\r\n<br>\r\n\r\nPicture Format: 16:9 Wide-Screen.\r\n\r\n<br>\r\n\r\nLength: (approx) 100 minutes.\r\n\r\n<br>\r\n\r\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).', '', 12);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (8, 2, 'リーサルウェポン', '地域コード:2(日本、ヨーロッパ、中東、南アフリカ)<br> 言語:英語、ドイツ語<br>サブタイトル：英語、ドイツ語、スペイン語<br>オーディオ:ドルビー・サラウンド 5.1<br>スクリーン：16：9LB シネマスコープ<br>時間：100分<br>その他:対話型メニュー、チャプター・セレクション、サブタイトル(その他の言語)', '', 86);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (9, 1, 'Speed', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r\n\r\n<br>\r\n\r\nLanguages: English, Deutsch.\r\n\r\n<br>\r\n\r\nSubtitles: English, Deutsch, Spanish.\r\n\r\n<br>\r\n\r\nAudio: Dolby Surround 5.1.\r\n\r\n<br>\r\n\r\nPicture Format: 16:9 Wide-Screen.\r\n\r\n<br>\r\n\r\nLength: (approx) 112 minutes.\r\n\r\n<br>\r\n\r\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).', '', 7);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (9, 2, 'スピード', '地域コード:2(日本、ヨーロッパ、中東、南アフリカ)<br> 言語:英語、ドイツ語<br>サブタイトル：英語、ドイツ語、スペイン語<br>オーディオ:ドルビー・サラウンド 5.1<br>スクリーン：16：9LB シネマスコープ<br>時間：112分<br>その他:対話型メニュー、チャプター・セレクション、サブタイトル(その他の言語)', '', 83);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (10, 1, 'Speed 2: Cruise Control', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r\n\r\n<br>\r\n\r\nLanguages: English, Deutsch.\r\n\r\n<br>\r\n\r\nSubtitles: English, Deutsch, Spanish.\r\n\r\n<br>\r\n\r\nAudio: Dolby Surround 5.1.\r\n\r\n<br>\r\n\r\nPicture Format: 16:9 Wide-Screen.\r\n\r\n<br>\r\n\r\nLength: (approx) 120 minutes.\r\n\r\n<br>\r\n\r\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).', '', 6);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (10, 2, 'スピード２', '地域コード:2(日本、ヨーロッパ、中東、南アフリカ)<br> 言語:英語、ドイツ語<br>サブタイトル：英語、ドイツ語、スペイン語<br>オーディオ:ドルビー・サラウンド 5.1<br>スクリーン：16：9LB シネマスコープ<br>時間：120分<br>その他:対話型メニュー、チャプター・セレクション、サブタイトル(その他の言語)', '', 73);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (11, 1, 'The Matrix', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r\n\r\n<br>\r\n\r\nLanguages: English, Deutsch.\r\n\r\n<br>\r\n\r\nSubtitles: English, Deutsch.\r\n\r\n<br>\r\n\r\nAudio: Dolby Surround.\r\n\r\n<br>\r\n\r\nPicture Format: 16:9 Wide-Screen.\r\n\r\n<br>\r\n\r\nLength: (approx) 131 minutes.\r\n\r\n<br>\r\n\r\nOther: Interactive Menus, Chapter Selection, Making Of.', 'www.thematrix.com', 3);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (11, 2, 'マトリックス', '地域コード:2(日本、ヨーロッパ、中東、南アフリカ)<br> 言語:英語、ドイツ語<br>サブタイトル：英語、ドイツ語<br>オーディオ:ドルビー・サラウンド<br>スクリーン：16：9LB シネマスコープ<br>時間：131分<br>その他:対話型メニュー、チャプター・セレクション、メーキング', 'www.thematrix.com', 88);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (12, 1, 'A Bug\'s Life', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r\n\r\n<br>\r\n\r\nLanguages: English, Deutsch.\r\n\r\n<br>\r\n\r\nSubtitles: English, Deutsch, Spanish.\r\n\r\n<br>\r\n\r\nAudio: Dolby Digital 5.1 / Dobly Surround Stereo.\r\n\r\n<br>\r\n\r\nPicture Format: 16:9 Wide-Screen.\r\n\r\n<br>\r\n\r\nLength: (approx) 91 minutes.\r\n\r\n<br>\r\n\r\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).', 'www.abugslife.com', 6);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (12, 2, 'バグズライフ', '地域コード:2(日本、ヨーロッパ、中東、南アフリカ)<br> 言語:英語、ドイツ語<br>サブタイトル：英語、ドイツ語、スペイン語<br>オーディオ:ドルビー・デジタル 5.1 / ドルビー・サラウンド・ステレオ<br>スクリーン：16：9LB シネマスコープ<br>時間：91分<br>その他:対話型メニュー、チャプター・セレクション、サブタイトル(その他の言語)', 'www.abugslife.com', 90);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (13, 1, 'There\'s Something About Mary', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r\n\r\n<br>\r\n\r\nLanguages: English, Deutsch.\r\n\r\n<br>\r\n\r\nSubtitles: English, Deutsch, Spanish.\r\n\r\n<br>\r\n\r\nAudio: Dolby Surround 5.1.\r\n\r\n<br>\r\n\r\nPicture Format: 16:9 Wide-Screen.\r\n\r\n<br>\r\n\r\nLength: (approx) 114 minutes.\r\n\r\n<br>\r\n\r\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).', '', 0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (13, 2, 'メリーに首ったけ', '地域コード:2(日本、ヨーロッパ、中東、南アフリカ)<br> 言語:英語、ドイツ語<br>サブタイトル：英語、ドイツ語、スペイン語<br>オーディオ:ドルビー・サラウンド 5.1<br>スクリーン：16：9LB シネマスコープ<br>時間：114分<br>その他:対話型メニュー、チャプター・セレクション、サブタイトル(その他の言語)', '', 0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (14, 1, 'You\'ve Got Mail', 'Regional Code: 2 (Japan, Europe, Middle East, South Africa).\r\n\r\n<br>\r\n\r\nLanguages: English, Deutsch, Spanish.\r\n\r\n<br>\r\n\r\nSubtitles: English, Deutsch, Spanish, French, Nordic, Polish.\r\n\r\n<br>\r\n\r\nAudio: Dolby Digital 5.1.\r\n\r\n<br>\r\n\r\nPicture Format: 16:9 Wide-Screen.\r\n\r\n<br>\r\n\r\nLength: (approx) 115 minutes.\r\n\r\n<br>\r\n\r\nOther: Interactive Menus, Chapter Selection, Subtitles (more languages).', 'www.youvegotmail.com', 10);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (14, 2, 'ユー・ガット・メール', '地域コード:2(日本、ヨーロッパ、中東、南アフリカ)<br> 言語:英語、ドイツ語、スペイン語<br>サブタイトル：英語、ドイツ語、スペイン語、フランス語、ノルウェー語、ポーランド語<br>オーディオ:ドルビー・デジタル 5.1<br>スクリーン：16：9LB シネマスコープ<br>時間：115分<br>その他:対話型メニュー、チャプター・セレクション、サブタイトル(その他の言語)', 'www.youvegotmail.com', 83);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (15, 1, 'Gift Certificate　500yen', 'Purchase a Gift Certificate today to share with your family, friends or business associates!', '', 5);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (15, 2, 'ギフト券 500円', '当店のみで利用できる500円分の商品券です。お客様自身が、利用するのはもちろん、家族や友達にメールでプレゼントすることもできます。またオンライン上の手続きのみなので配送料は不要です。', '', 69);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (16, 1, 'Gift Certificate 1000yen', 'Purchase a Gift Certificate today to share with your family, friends or business associates!', '', 6);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (16, 2, 'ギフト券 1000円', '当店のみで利用できる1000円分の商品券です。お客様自身が、利用するのはもちろん、家族や友達にメールでプレゼントすることもできます。またオンライン上の手続きのみなので配送料は不要です。', '', 71);



#
# Dumping data for table products_options
#

INSERT INTO products_options (products_options_id, language_id, products_options_name, products_options_sort_order, products_options_type, products_options_length, products_options_comment, products_options_size, products_options_images_per_row, products_options_images_style) VALUES (1, 1, 'statas', 1, 2, 32, '', 32, 5, 0);
INSERT INTO products_options (products_options_id, language_id, products_options_name, products_options_sort_order, products_options_type, products_options_length, products_options_comment, products_options_size, products_options_images_per_row, products_options_images_style) VALUES (1, 2, '状態', 1, 2, 32, '', 32, 5, 0);
INSERT INTO products_options (products_options_id, language_id, products_options_name, products_options_sort_order, products_options_type, products_options_length, products_options_comment, products_options_size, products_options_images_per_row, products_options_images_style) VALUES (2, 1, 'color', 2, 0, 32, '', 32, 5, 0);
INSERT INTO products_options (products_options_id, language_id, products_options_name, products_options_sort_order, products_options_type, products_options_length, products_options_comment, products_options_size, products_options_images_per_row, products_options_images_style) VALUES (2, 2, '色', 2, 0, 32, '', 32, 5, 0);
INSERT INTO products_options (products_options_id, language_id, products_options_name, products_options_sort_order, products_options_type, products_options_length, products_options_comment, products_options_size, products_options_images_per_row, products_options_images_style) VALUES (3, 1, 'size', 0, 0, 32, NULL, 32, 5, 0);
INSERT INTO products_options (products_options_id, language_id, products_options_name, products_options_sort_order, products_options_type, products_options_length, products_options_comment, products_options_size, products_options_images_per_row, products_options_images_style) VALUES (3, 2, 'サイズ', 0, 0, 32, NULL, 32, 5, 0);

#
# Dumping data for table products_options_values
#

INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, products_options_values_sort_order) VALUES (1, 1, 'new', 1);
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, products_options_values_sort_order) VALUES (1, 2, '新品', 1);
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, products_options_values_sort_order) VALUES (2, 1, 'used', 2);
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, products_options_values_sort_order) VALUES (2, 2, '中古', 2);
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, products_options_values_sort_order) VALUES (3, 1, 'white', 3);
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, products_options_values_sort_order) VALUES (3, 2, 'ホワイト', 3);
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, products_options_values_sort_order) VALUES (4, 1, 'black', 4);
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, products_options_values_sort_order) VALUES (4, 2, 'ブラック', 4);
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, products_options_values_sort_order) VALUES (5, 1, '', 10);
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, products_options_values_sort_order) VALUES (5, 2, '20P', 10);
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, products_options_values_sort_order) VALUES (6, 1, '', 11);
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, products_options_values_sort_order) VALUES (6, 2, '21P', 11);


#
# Dumping data for table products_options_values_to_products_options
#

INSERT INTO products_options_values_to_products_options (products_options_values_to_products_options_id, products_options_id, products_options_values_id) VALUES (1, 1, 1);
INSERT INTO products_options_values_to_products_options (products_options_values_to_products_options_id, products_options_id, products_options_values_id) VALUES (2, 1, 2);
INSERT INTO products_options_values_to_products_options (products_options_values_to_products_options_id, products_options_id, products_options_values_id) VALUES (3, 2, 3);
INSERT INTO products_options_values_to_products_options (products_options_values_to_products_options_id, products_options_id, products_options_values_id) VALUES (4, 2, 4);
INSERT INTO products_options_values_to_products_options (products_options_values_to_products_options_id, products_options_id, products_options_values_id) VALUES (5, 3, 5);
INSERT INTO products_options_values_to_products_options (products_options_values_to_products_options_id, products_options_id, products_options_values_id) VALUES (6, 3, 6);


#
# Dumping data for table products_to_categories
#

INSERT INTO products_to_categories (products_id, categories_id) VALUES (1, 4);
INSERT INTO products_to_categories (products_id, categories_id) VALUES (2, 5);
INSERT INTO products_to_categories (products_id, categories_id) VALUES (3, 5);
INSERT INTO products_to_categories (products_id, categories_id) VALUES (4, 6);
INSERT INTO products_to_categories (products_id, categories_id) VALUES (5, 2);
INSERT INTO products_to_categories (products_id, categories_id) VALUES (6, 2);
INSERT INTO products_to_categories (products_id, categories_id) VALUES (7, 2);
INSERT INTO products_to_categories (products_id, categories_id) VALUES (8, 7);
INSERT INTO products_to_categories (products_id, categories_id) VALUES (9, 7);
INSERT INTO products_to_categories (products_id, categories_id) VALUES (10, 7);
INSERT INTO products_to_categories (products_id, categories_id) VALUES (11, 7);
INSERT INTO products_to_categories (products_id, categories_id) VALUES (12, 8);
INSERT INTO products_to_categories (products_id, categories_id) VALUES (13, 9);
INSERT INTO products_to_categories (products_id, categories_id) VALUES (14, 9);
INSERT INTO products_to_categories (products_id, categories_id) VALUES (15, 10);
INSERT INTO products_to_categories (products_id, categories_id) VALUES (16, 10);


#
# Dumping data for table record_artists
#

INSERT INTO record_artists (artists_id, artists_name, artists_image, date_added, last_modified) VALUES (1, 'The Russ Tippins Band', 'sooty.jpg', '2004-06-01 20:53:00', NULL);

#
# Dumping data for table record_artists_info
#

INSERT INTO record_artists_info (artists_id, languages_id, artists_url, url_clicked, date_last_click) VALUES (1, 1, 'russtippinsband.users.btopenworld.com/', 0, NULL);

#
# Dumping data for table record_company
#

INSERT INTO record_company (record_company_id, record_company_name, record_company_image, date_added, last_modified) VALUES (1, 'HMV Group', NULL, '2004-07-09 14:11:52', NULL);

#
# Dumping data for table record_company_info
#

INSERT INTO record_company_info (record_company_id, languages_id, record_company_url, url_clicked, date_last_click) VALUES (1, 1, 'www.hmvgroup.com', 0, NULL);


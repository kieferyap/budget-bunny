DROP DATABASE budget_bunny;
CREATE DATABASE budget_bunny;

DROP TABLE features;
DROP TABLE localizable_words;

CREATE SEQUENCE features_seq;
CREATE SEQUENCE localizable_words_seq;

CREATE TABLE features (
	feature_id integer DEFAULT nextval('features_seq'::regclass) PRIMARY KEY,
	requirement_key character varying(8) NOT NULL,
	description text NOT NULL,
	is_bug boolean DEFAULT false,
	inserted_on timestamp without time zone DEFAULT now()
);

CREATE TABLE localizable_words (
	localizable_word_id integer DEFAULT nextval('localizable_words_seq'::regclass) PRIMARY KEY,
	wording_key character varying(64) NOT NULL,
	localization_en text NOT NULL,
	localization_jp text,
	localization_zh text,
	inserted_on timestamp without time zone DEFAULT now()
);


INSERT INTO features (requirement_key, description) VALUES ('GEN-0001', 'Create single view app, project structure.');
INSERT INTO features (requirement_key, description) VALUES ('GEN-0002', 'Core data');
INSERT INTO features (requirement_key, description) VALUES ('GEN-0003', 'Scripts for localization, images, screen constants, cell identifiers');
INSERT INTO features (requirement_key, description) VALUES ('GEN-0004', 'Application icon');
INSERT INTO features (requirement_key, description) VALUES ('GEN-0005', 'LaTeX document');
INSERT INTO features (requirement_key, description) VALUES ('GEN-0006', 'Unit testing and UI testing on Git');
INSERT INTO features (requirement_key, description) VALUES ('GEN-0007', 'Storyboard - tabs and screens');
-- Tag master as 0.1

INSERT INTO features (requirement_key, description) VALUES ('ACC-0001', 'Add new account screen');
INSERT INTO features (requirement_key, description) VALUES ('ACC-0002', 'Account display screen');
INSERT INTO features (requirement_key, description) VALUES ('ACC-0003', 'Edit account screen');

INSERT INTO features (requirement_key, description) VALUES ('BUD-0001', 'Add new budget screen');
INSERT INTO features (requirement_key, description) VALUES ('BUD-0002', 'Budget display screen');
INSERT INTO features (requirement_key, description) VALUES ('BUD-0003', 'Budget calculation - monthly, weekly, daily');
INSERT INTO features (requirement_key, description) VALUES ('BUD-0004', 'Budget editing');
INSERT INTO features (requirement_key, description) VALUES ('BUD-0005', 'Budget category editing');
-- Tag master as 0.2

INSERT INTO features (requirement_key, description) VALUES ('DSH-0001', 'Posting a new transaction (Post, Amount, Notes)');
INSERT INTO features (requirement_key, description) VALUES ('DSH-0002', 'Posting a new transaction (Type, Category/Subcategory)');
INSERT INTO features (requirement_key, description) VALUES ('DSH-0003', 'Dashboard Account Display, Spent Today, and Transaction List');

INSERT INTO features (requirement_key, description) VALUES ('STN-0001', 'Settings screen');
-- Tag master as 0.3

INSERT INTO features (requirement_key, description) VALUES ('RCD-0001', 'Calendar Display');
INSERT INTO features (requirement_key, description) VALUES ('RCD-0002', 'Calendar Monthly Navigation');
INSERT INTO features (requirement_key, description) VALUES ('RCD-0003', 'Calendar Yearly/Monthly Switching');
INSERT INTO features (requirement_key, description) VALUES ('RCD-0004', 'Calendar Yearly Navigation');
INSERT INTO features (requirement_key, description) VALUES ('RCD-0005', 'Data: Total');
INSERT INTO features (requirement_key, description) VALUES ('RCD-0006', 'Data: Transactions');
INSERT INTO features (requirement_key, description) VALUES ('RCD-0007', 'Data: Graphs');
INSERT INTO features (requirement_key, description) VALUES ('RCD-0008', 'Targets: New Target');
INSERT INTO features (requirement_key, description) VALUES ('RCD-0009', 'Targets: Display Target');
-- Tag master as 0.4

-- Tag master as 1.0

-- Wording
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('MENULABEL_ACCOUNT', 'Account', 'アカウント', '帐户');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('MENULABEL_ADD_ACCOUNT', 'Add New Account', '追加', '新帐户');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('MENULABEL_CURRENCY_PICKER', 'Currency', '通貨', '货币');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_NAME', 'Account Name', 'アカウント名', '货币的名称');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('TEXTFIELD_NAME_PLACEHOLDER', 'My Wallet', '私の財布', '我的钱包');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_CURRENCY', 'Currency', '通貨', '货币');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_STARTING_BALANCE', 'Starting Balance', '開始残高', '起始余额');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('TEXTFIELD_STARTING_BALANCE_PLACEHOLDER', '100', '1000', '600');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_IS_DEFAULT_ACCOUNT', 'Default Account', 'デフォルトのアカウント', '默认帐户');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_IS_DEFAULT_ACCOUNT_DESCRIPTION', 'The default account to use for everyday transactions', '毎日に使うアカウント', '毎天用的帐户');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_LOADING', 'Loading...', 'ローディング中...', '加載...');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('BUTTON_DONE', 'Done', '完了', '完成');

INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('ERRORLABEL_NAME_CURRENCY_NOT_EMPTY', 'Error: the name and currency must not be left blank.', '[Not localizaed yet]', '[Not localizaed yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('ERRORLABEL_INTERNAL_ERROR', 'Error: an internal error has occured. Please try again later', '[Not localizaed yet]', '[Not localizaed yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('ERRORLABEL_ERROR_TITLE', 'Error', '[Not localizaed yet]', '[Not localizaed yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_OK', 'OK', 'OK', 'OK');

-- 5/10/2016
UPDATE localizable_words SET localization_en = 'The name and initial amount must not be left blank.' WHERE wording_key = 'ERRORLABEL_NAME_CURRENCY_NOT_EMPTY';
UPDATE localizable_words SET localization_en = 'An internal error has occured. Please try again later.' WHERE wording_key = 'ERRORLABEL_INTERNAL_ERROR';

-- 5/15/2016
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('BUTTON_DELETE', 'Delete', '削除', '[Not localized yet]');

-- 5/16/2016
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_DEFAULT', 'DEFAULT', 'デフォルト', '[Not localized yet]');

-- 5/21/2016
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_NO_ACCOUNTS', 'There are no accounts yet.\n\nTo add a new account, tap the + sign located at the upper right corner of the screen.', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('BUTTON_SAVE', 'Save', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('BUTTON_SET_AS_DEFAULT', 'Set as default', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('BUTTON_DELETE_ACCOUNT', 'Delete account', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_ACCOUNT_INFO', 'Information', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_ACCOUNT_ACTIONS', 'Actions', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_CURRENT_AMOUNT', 'Current amount', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('ERRORLABEL_DUPLICATE_ACCOUNT_NAME', 'The account name already exists.', '[Not localized yet]', '[Not localized yet]');

-- 5/28/2016
UPDATE localizable_words SET localization_en = 'Set\nDefault' WHERE wording_key = 'BUTTON_SET_AS_DEFAULT';
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('BUTTON_VIEW', 'View', '[Not localized yet]', '[Not localized yet]');

-- 5/30/2016
UPDATE localizable_words SET localization_en = 'Set as Default' WHERE wording_key = 'BUTTON_SET_AS_DEFAULT';
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('BUTTON_SET_DEFAULT', 'Set\ndefault', '[Not localized yet]', '[Not localized yet]');

-- 5/31/2016
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_WARNING_DELETE_ACCOUNT_TITLE', 'Warning: This action cannot be undone.', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_WARNING_DELETE_ACCOUNT_MESSAGE', 'The account, and all its associated transactions will be deleted. Are you sure?', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('BUTTON_CANCEL', 'Cancel', '[Not localized yet]', '[Not localized yet]');

-- 6/1/2016
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('BUTTON_DEFAULT_ACCOUNT_MESSAGE', 'This is the default account.', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('BUTTON_DEFAULT_ACCOUNT_DESCRIPTION', 'Default accounts cannot be deleted.', '[Not localized yet]', '[Not localized yet]');

UPDATE localizable_words SET localization_en = 'Set\nDefault' WHERE wording_key = 'BUTTON_SET_DEFAULT';

-- 6/6/2016
UPDATE localizable_words SET localization_en = 'Current Balance' WHERE wording_key = 'LABEL_CURRENT_AMOUNT';
UPDATE localizable_words SET localization_en = 'Delete Account' WHERE wording_key = 'BUTTON_DELETE_ACCOUNT';

-- 6/7/2016
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('MENULABEL_EDIT_ACCOUNT', 'Edit Account', '[Not localized yet]', '[Not localized yet]');

-- 6/10/2016
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('MENULABEL_BUDGETS', 'Budgets', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('MENULABEL_DASHBOARD', 'Dashboard', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('MENULABEL_RECORDS', 'Records', '[Not localized yet]', '[Not localized yet]');

-- 6/11/2016
UPDATE localizable_words SET wording_key = 'BUTTON_DELETE_ACCOUNT_DISABLED' WHERE localizable_word_id = 31;
UPDATE localizable_words SET wording_key = 'BUTTON_SET_AS_DEFAULT_DISABLED' WHERE localizable_word_id = 30;
UPDATE localizable_words SET wording_key = 'BUTTON_EDIT' WHERE localizable_word_id = 28;
UPDATE localizable_words SET localization_en = 'Edit' WHERE localizable_word_id = 28;
DELETE FROM localizable_words WHERE localizable_word_id = 13;
UPDATE localizable_words SET wording_key = 'GUIDELABEL_LOADING' WHERE localizable_word_id = 11;
UPDATE localizable_words SET wording_key = 'GUIDELABEL_NO_ACCOUNTS' WHERE localizable_word_id = 20;
UPDATE localizable_words SET wording_key = 'LABEL_CURRENT_BALANCE' WHERE localizable_word_id = 26;

-- 6/23/2016
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('ERRORLABEL_TOO_MANY_ACCOUNTS', 'The number of accounts created has been exceeded.\nKindly delete an account before proceeding.', '[Not localized yet]', '[Not localized yet]');

-- 6/23/2016
UPDATE localizable_words SET localization_jp = 'アカウント' WHERE wording_key = 'MENULABEL_ACCOUNT';
UPDATE localizable_words SET localization_jp = '追加' WHERE wording_key = 'MENULABEL_ADD_ACCOUNT';
UPDATE localizable_words SET localization_jp = '通貨' WHERE wording_key = 'MENULABEL_CURRENCY_PICKER';
UPDATE localizable_words SET localization_jp = 'アカウント名' WHERE wording_key = 'LABEL_NAME';
UPDATE localizable_words SET localization_jp = '私の財布' WHERE wording_key = 'TEXTFIELD_NAME_PLACEHOLDER';
UPDATE localizable_words SET localization_jp = '通貨' WHERE wording_key = 'LABEL_CURRENCY';
UPDATE localizable_words SET localization_jp = '開始残高' WHERE wording_key = 'LABEL_STARTING_BALANCE';
UPDATE localizable_words SET localization_jp = '1000' WHERE wording_key = 'TEXTFIELD_STARTING_BALANCE_PLACEHOLDER';
UPDATE localizable_words SET localization_jp = 'デフォルトのアカウント' WHERE wording_key = 'LABEL_IS_DEFAULT_ACCOUNT';
UPDATE localizable_words SET localization_jp = '毎日に使うアカウント' WHERE wording_key = 'LABEL_IS_DEFAULT_ACCOUNT_DESCRIPTION';
UPDATE localizable_words SET localization_jp = '完了' WHERE wording_key = 'BUTTON_DONE';
UPDATE localizable_words SET localization_jp = 'OK' WHERE wording_key = 'LABEL_OK';
UPDATE localizable_words SET localization_jp = 'エラー' WHERE wording_key = 'ERRORLABEL_ERROR_TITLE';
UPDATE localizable_words SET localization_jp = 'アカウントの名前とアカウントの残高を入力してください。' WHERE wording_key = 'ERRORLABEL_NAME_CURRENCY_NOT_EMPTY';
UPDATE localizable_words SET localization_jp = '内部エラーが発生しました。' WHERE wording_key = 'ERRORLABEL_INTERNAL_ERROR';
UPDATE localizable_words SET localization_jp = '削除' WHERE wording_key = 'BUTTON_DELETE';
UPDATE localizable_words SET localization_jp = 'デフォルト' WHERE wording_key = 'LABEL_DEFAULT';
UPDATE localizable_words SET localization_jp = '保存' WHERE wording_key = 'BUTTON_SAVE';
UPDATE localizable_words SET localization_jp = 'ローディング中...' WHERE wording_key = 'GUIDELABEL_LOADING';
UPDATE localizable_words SET localization_jp = '[アカウントがありません。\n\n新しいアカウントを追加するには、+ をタップしてください。' WHERE wording_key = 'GUIDELABEL_NO_ACCOUNTS';
UPDATE localizable_words SET localization_jp = '[Not localized yet]' WHERE wording_key = 'LABEL_ACCOUNT_INFO';
UPDATE localizable_words SET localization_jp = '[Not localized yet]' WHERE wording_key = 'LABEL_ACCOUNT_ACTIONS';
UPDATE localizable_words SET localization_jp = 'アカウントの名前が既に存在します。' WHERE wording_key = 'ERRORLABEL_DUPLICATE_ACCOUNT_NAME';
UPDATE localizable_words SET localization_jp = 'デフォルトとして設定' WHERE wording_key = 'BUTTON_SET_AS_DEFAULT';
UPDATE localizable_words SET localization_jp = 'このアクションは元に戻すことはできません' WHERE wording_key = 'LABEL_WARNING_DELETE_ACCOUNT_TITLE';
UPDATE localizable_words SET localization_jp = 'アカウントとアカウントの取引を削除します。' WHERE wording_key = 'LABEL_WARNING_DELETE_ACCOUNT_MESSAGE';
UPDATE localizable_words SET localization_jp = 'キャンセル' WHERE wording_key = 'BUTTON_CANCEL';
UPDATE localizable_words SET localization_jp = 'アカウントを削除' WHERE wording_key = 'BUTTON_DELETE_ACCOUNT';
UPDATE localizable_words SET localization_jp = 'デフォルト\nとして設定' WHERE wording_key = 'BUTTON_SET_DEFAULT';
UPDATE localizable_words SET localization_jp = '編集' WHERE wording_key = 'MENULABEL_EDIT_ACCOUNT';
UPDATE localizable_words SET localization_jp = 'バジェット' WHERE wording_key = 'MENULABEL_BUDGETS';
UPDATE localizable_words SET localization_jp = 'ダッシュボード' WHERE wording_key = 'MENULABEL_DASHBOARD';
UPDATE localizable_words SET localization_jp = '記録' WHERE wording_key = 'MENULABEL_RECORDS';
UPDATE localizable_words SET localization_jp = 'このアカウントはデフォルトです' WHERE wording_key = 'BUTTON_DELETE_ACCOUNT_DISABLED';
UPDATE localizable_words SET localization_jp = 'デフォルトアカウントは削除することができません' WHERE wording_key = 'BUTTON_SET_AS_DEFAULT_DISABLED';
UPDATE localizable_words SET localization_jp = '編集' WHERE wording_key = 'BUTTON_EDIT';
UPDATE localizable_words SET localization_jp = '経常収支' WHERE wording_key = 'LABEL_CURRENT_BALANCE';
UPDATE localizable_words SET localization_jp = 'アカウント数の上限を超えています。' WHERE wording_key = 'ERRORLABEL_TOO_MANY_ACCOUNTS';
UPDATE localizable_words SET localization_en = 'The name and amount must not be left blank.' WHERE wording_key = 'ERRORLABEL_NAME_CURRENCY_NOT_EMPTY';
DELETE FROM localizable_words WHERE wording_key = 'LABEL_ACCOUNT_INFO';
DELETE FROM localizable_words WHERE wording_key = 'LABEL_ACCOUNT_ACTIONS';

UPDATE localizable_words SET localization_jp = 'このアカウントはデフォルトです' WHERE wording_key = 'BUTTON_SET_AS_DEFAULT_DISABLED';
UPDATE localizable_words SET localization_jp = '削除できません' WHERE wording_key = 'BUTTON_DELETE_ACCOUNT_DISABLED';

-- 6/26/2016
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('MENULABEL_ADD_BUDGET', 'Add Budget', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_BUDGET', 'Budget', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_BUDGET_NAME', 'Budget Name', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('TEXTFIELD_BUDGET_PLACEHOLDER', 'Food and Groceries', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_MONTHLY_BUDGET', 'Monthly Budget', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_WEEKLY_BUDGET', 'Weekly Budget', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_DAILY_BUDGET', 'Daily Budget', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_MONTHLY', 'Monthly', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_WEEKLY', 'Weekly', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_DAILY', 'Daily', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('TEXTFIELD_XLY_BUDGET_PLACEHOLDER', '1000', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('TEXTFIELD_NEW_CATEGORY_PLACEHOLDER', 'Add New Category', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('ERRORLABEL_DUPLICATE_CATEGORY_NAME', 'The category name already exists in this budget.', '[Not localized yet]', '[Not localized yet]');

-- 6/28/2016
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('ERRORLABEL_TOO_MANY_CATEGORIES', 'The number of categories created has been exceeded.\nKindly delete an category before proceeding.', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('ERRORLABEL_DUPLICATE_BUDGET_NAME', 'The budget name already exists.', '[Not localized yet]', '[Not localized yet]');
UPDATE localizable_words SET wording_key = 'ERRORLABEL_NAME_AMOUNT_NOT_EMPTY' where wording_key = 'ERRORLABEL_NAME_CURRENCY_NOT_EMPTY';

-- 6/30/2016
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('ERRORLABEL_CATEGORY_NOT_EMPTY', 'The category name must not be left blank.', '[Not localized yet]', '[Not localized yet]');

-- 7/1/2016
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('ERRORLABEL_NO_CATEGORIES', 'Please add at least one category.', '[Not localized yet]', '[Not localized yet]');

-- 7/16/2016
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('TEXTFIELD_NEW_INCOME', 'Add Income Category', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('ERRORLABEL_TOO_MANY_INCOME_CATEGORIES', 'The number of income categories created has been exceeded.\nKindly delete an income category before proceeding.', '[Not localized yet]', '[Not localized yet]');
UPDATE localizable_words SET localization_en = 'The number of categories created has been exceeded.\nKindly delete a category before proceeding.' WHERE wording_key = 'ERRORLABEL_TOO_MANY_CATEGORIES';
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('ERRORLABEL_INCOME_CATEGORY_NOT_EMPTY', 'The income category name must not be left blank.', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('ERRORLABEL_DUPLICATE_INCOME_CATEGORY_NAME', 'The income category name already exists.', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_NO_BUDGETS', 'There are no budgets yet.\n\nTo add a new budget, tap the + sign located at the upper right corner of the screen.', '[Not localized yet]', '[Not localized yet]');

-- 9/8/2016
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_INCOME_ACTIONS', 'Income Category Actions', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_RENAME', 'Rename', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('ERRORLABEL_TOO_MANY_BUDGETS', 'The number of budgets created has been exceeded.\nKindly delete a budget before proceeding.', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('ERRORLABEL_NO_DEFAULT_ACCOUNT', 'There are no default accounts available.\nKindly create a default account before proceeding.', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_ADD_NEW_INCOME_CATEGORY', 'Add New Income Category', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_ADD_NEW_INCOME_CATEGORY_MESSAGE', 'Please enter the name of the new income category.', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_ADD_NEW_INCOME_CATEGORY_PLACEHOLDER', 'New Category Name', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_RENAME_MESSAGE', 'Please enter the new name.', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('TEXTFIELD_RENAME_MESSAGE_PLACEHOLDER', 'New Name', '[Not localized yet]', '[Not localized yet]');
UPDATE localizable_words SET wording_key = 'TEXTFIELD_ADD_NEW_INCOME_CATEGORY_PLACEHOLDER' WHERE wording_key = 'LABEL_ADD_NEW_INCOME_CATEGORY_PLACEHOLDER';
UPDATE localizable_words SET wording_key = 'TEXTFIELD_RENAME_PLACEHOLDER' WHERE wording_key = 'TEXTFIELD_RENAME_MESSAGE_PLACEHOLDER';
UPDATE localizable_words SET localization_en = 'The number of categories created has been exceeded.\n\nKindly delete a category before proceeding.' WHERE wording_key = 'ERRORLABEL_TOO_MANY_CATEGORIES';
UPDATE localizable_words SET localization_en = 'The number of budgets created has been exceeded.\n\nKindly delete a budget before proceeding.' WHERE wording_key = 'ERRORLABEL_TOO_MANY_BUDGETS';
UPDATE localizable_words SET localization_en = 'There are no default accounts available.\n\nKindly create a default account before proceeding.' WHERE wording_key = 'ERRORLABEL_NO_DEFAULT_ACCOUNT';

UPDATE localizable_words SET localization_en = 'The number of categories created has been exceeded.\n\nKindly delete a category before proceeding.' WHERE wording_key = 'ERRORLABEL_TOO_MANY_INCOME_CATEGORIES';
UPDATE localizable_words SET localization_en = 'The number of accounts created has been exceeded.\n\nKindly delete an account before proceeding.' WHERE wording_key = 'ERRORLABEL_TOO_MANY_ACCOUNTS';

-- 9/14/2016
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('ERRORLABEL_INCOME_CATEGORY_NAME_TOO_LONG', 'The name of the Income Category is too long. Please specify a shorter name.', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('ERRORLABEL_BUDGET_CATEGORY_NAME_TOO_LONG', 'The name of the Budget Category is too long. Please specify a shorter name.', '[Not localized yet]', '[Not localized yet]');

INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_DELETE_CATEGORY_TITLE', 'Delete Category', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_DELETE_INCOME_CATEGORY_MESSAGE', 'The selected income category and its associated transactions will be deleted. This action cannot be undone. Are you sure?', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_DELETE_INCOME_CATEGORY_BUTTON', 'Delete Income Category', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_DELETE_BUDGET_CATEGORY_MESSAGE', 'The selected budget category and its associated transactions will be deleted. This action cannot be undone. Are you sure?', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_DELETE_BUDGET_CATEGORY_BUTTON', 'Delete Budget Category', '[Not localized yet]', '[Not localized yet]');

INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_DELETE_BUDGET_TITLE', 'Delete Budget', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_DELETE_BUDGET_BUTTON', 'Delete Budget', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_DELETE_BUDGET_MESSAGE', 'The selected budget, its associated categories, and the transactions associated with them will all be deleted. This action cannot be undone. Are you sure?', '[Not localized yet]', '[Not localized yet]');

INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('ERRORLABEL_BUDGET_CATEGORY_NOT_EMPTY', 'The budget category name must not be left blank.', '[Not localized yet]', '[Not localized yet]');
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('LABEL_BUDGET_CATEGORY_ACTIONS', 'Budget Category Actions', '[Not localized yet]', '[Not localized yet]');
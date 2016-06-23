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

/*
The name and AMOUNT must not be left blank.
REMOVE LABEL_ACCOUNT_INFO and LABEL_ACCOUNT_ACTIONS

"MENULABEL_ACCOUNT" = "アカウント";
"MENULABEL_ADD_ACCOUNT" = "追加";
"MENULABEL_CURRENCY_PICKER" = "通貨";
"LABEL_NAME" = "アカウント名";
"TEXTFIELD_NAME_PLACEHOLDER" = "私の財布";
"LABEL_CURRENCY" = "通貨";
"LABEL_STARTING_BALANCE" = "開始残高";
"TEXTFIELD_STARTING_BALANCE_PLACEHOLDER" = "1000";
"LABEL_IS_DEFAULT_ACCOUNT" = "デフォルトのアカウント";
"LABEL_IS_DEFAULT_ACCOUNT_DESCRIPTION" = "毎日に使うアカウント";
"BUTTON_DONE" = "完了";
"LABEL_OK" = "OK";
"ERRORLABEL_ERROR_TITLE" = "エラー";
"ERRORLABEL_NAME_CURRENCY_NOT_EMPTY" = "アカウントの名前とアカウントの残高を入力してください。";
"ERRORLABEL_INTERNAL_ERROR" = "内部エラーが発生しました。";
"BUTTON_DELETE" = "削除";
"LABEL_DEFAULT" = "デフォルト";
"BUTTON_SAVE" = "保存";
"GUIDELABEL_LOADING" = "ローディング中...";
"GUIDELABEL_NO_ACCOUNTS" = "[アカウントがありません。\n\n新しいアカウントを追加するには、+ をタップしてください。";
"LABEL_ACCOUNT_INFO" = "[Not localized yet]";
"LABEL_ACCOUNT_ACTIONS" = "[Not localized yet]";
"ERRORLABEL_DUPLICATE_ACCOUNT_NAME" = "アカウントの名前が既に存在します。";
"BUTTON_SET_AS_DEFAULT" = "デフォルトとして設定";
"LABEL_WARNING_DELETE_ACCOUNT_TITLE" = "このアクションは元に戻すことはできません";
"LABEL_WARNING_DELETE_ACCOUNT_MESSAGE" = "アカウントとアカウントの取引を削除します。";
"BUTTON_CANCEL" = "キャンセル";
"BUTTON_DELETE_ACCOUNT" = "アカウントを削除";
"BUTTON_SET_DEFAULT" = "デフォルト\nとして設定";
"MENULABEL_EDIT_ACCOUNT" = "編集";
"MENULABEL_BUDGETS" = "バジェット";
"MENULABEL_DASHBOARD" = "ダッシュボード";
"MENULABEL_RECORDS" = "記録";
"BUTTON_DELETE_ACCOUNT_DISABLED" = "このアカウントはデフォルトです";
"BUTTON_SET_AS_DEFAULT_DISABLED" = "デフォルトアカウントは削除することができません";
"BUTTON_EDIT" = "編集";
"LABEL_CURRENT_BALANCE" = "経常収支";
"ERRORLABEL_TOO_MANY_ACCOUNTS" = "アカウント数の上限を超えています。";
*/


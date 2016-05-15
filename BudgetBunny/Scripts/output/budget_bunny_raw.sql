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

UPDATE localizable_words SET localization_en = 'The name and initial amount must not be left blank.' WHERE wording_key = 'ERRORLABEL_NAME_CURRENCY_NOT_EMPTY';
UPDATE localizable_words SET localization_en = 'An internal error has occured. Please try again later.' WHERE wording_key = 'ERRORLABEL_INTERNAL_ERROR';
INSERT INTO localizable_words (wording_key, localization_en, localization_jp, localization_zh) VALUES ('BUTTON_DELETE', 'Delete', '削除', '[Not localized yet]');

-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 26, 2022 at 12:49 PM
-- Server version: 5.7.17
-- PHP Version: 7.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `biweekly`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(254) DEFAULT NULL,
  `ofx_cat_memo_to_name` tinyint(1) DEFAULT NULL,
  `vault_creds_path` varchar(254) DEFAULT NULL,
  `ofxgetter_config_json` text,
  `negate_ofx_amounts` tinyint(1) DEFAULT NULL,
  `reconcile_trans` tinyint(1) NOT NULL,
  `acct_type` enum('Bank','Credit','Investment','Cash','Other') DEFAULT NULL,
  `credit_limit` decimal(10,4) DEFAULT NULL,
  `apr` decimal(5,4) DEFAULT NULL,
  `prime_rate_margin` decimal(5,4) DEFAULT NULL,
  `interest_class_name` varchar(70) DEFAULT NULL,
  `min_payment_class_name` varchar(70) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `re_interest_charge` varchar(254) DEFAULT NULL,
  `re_interest_paid` varchar(254) DEFAULT NULL,
  `re_payment` varchar(254) DEFAULT NULL,
  `re_late_fee` varchar(254) DEFAULT NULL,
  `re_other_fee` varchar(254) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `account_balances`
--

CREATE TABLE `account_balances` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `ledger` decimal(10,4) DEFAULT NULL,
  `ledger_date` datetime DEFAULT NULL,
  `avail` decimal(10,4) DEFAULT NULL,
  `avail_date` datetime DEFAULT NULL,
  `overall_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `alembic_version`
--

CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `alembic_version`
--

INSERT INTO `alembic_version` (`version_num`) VALUES
('073142f641b3');

-- --------------------------------------------------------

--
-- Table structure for table `bom_items`
--

CREATE TABLE `bom_items` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `name` varchar(254) DEFAULT NULL,
  `notes` varchar(254) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `unit_cost` decimal(10,4) DEFAULT NULL,
  `url` varchar(254) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `budgets`
--

CREATE TABLE `budgets` (
  `id` int(11) NOT NULL,
  `is_periodic` tinyint(1) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(254) DEFAULT NULL,
  `starting_balance` decimal(10,4) DEFAULT NULL,
  `current_balance` decimal(10,4) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `is_income` tinyint(1) DEFAULT NULL,
  `omit_from_graphs` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `budget_transactions`
--

CREATE TABLE `budget_transactions` (
  `id` int(11) NOT NULL,
  `amount` decimal(10,4) NOT NULL,
  `trans_id` int(11) DEFAULT NULL,
  `budget_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `fuellog`
--

CREATE TABLE `fuellog` (
  `id` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `vehicle_id` int(11) DEFAULT NULL,
  `odometer_miles` int(11) DEFAULT NULL,
  `reported_miles` smallint(6) DEFAULT NULL,
  `calculated_miles` smallint(6) DEFAULT NULL,
  `level_before` smallint(6) DEFAULT NULL,
  `level_after` smallint(6) DEFAULT NULL,
  `fill_location` varchar(254) DEFAULT NULL,
  `cost_per_gallon` decimal(10,4) DEFAULT NULL,
  `total_cost` decimal(10,4) DEFAULT NULL,
  `gallons` decimal(10,4) DEFAULT NULL,
  `reported_mpg` decimal(10,4) DEFAULT NULL,
  `calculated_mpg` decimal(10,4) DEFAULT NULL,
  `notes` varchar(254) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ofx_statements`
--

CREATE TABLE `ofx_statements` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `filename` varchar(254) DEFAULT NULL,
  `file_mtime` datetime DEFAULT NULL,
  `currency` varchar(10) DEFAULT NULL,
  `bankid` varchar(20) DEFAULT NULL,
  `routing_number` varchar(20) DEFAULT NULL,
  `acct_type` varchar(32) DEFAULT NULL,
  `brokerid` varchar(30) DEFAULT NULL,
  `acctid` varchar(30) DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `as_of` datetime DEFAULT NULL,
  `ledger_bal` decimal(10,4) DEFAULT NULL,
  `ledger_bal_as_of` datetime DEFAULT NULL,
  `avail_bal` decimal(10,4) DEFAULT NULL,
  `avail_bal_as_of` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ofx_trans`
--

CREATE TABLE `ofx_trans` (
  `account_id` int(11) NOT NULL,
  `statement_id` int(11) NOT NULL,
  `fitid` varchar(255) NOT NULL,
  `trans_type` varchar(50) DEFAULT NULL,
  `date_posted` datetime DEFAULT NULL,
  `amount` decimal(10,4) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `sic` varchar(255) DEFAULT NULL,
  `mcc` varchar(255) DEFAULT NULL,
  `checknum` varchar(32) DEFAULT NULL,
  `description` varchar(254) DEFAULT NULL,
  `notes` text,
  `is_payment` tinyint(1) DEFAULT NULL,
  `is_late_fee` tinyint(1) DEFAULT NULL,
  `is_interest_charge` tinyint(1) DEFAULT NULL,
  `is_other_fee` tinyint(1) DEFAULT NULL,
  `is_interest_payment` tinyint(1) DEFAULT NULL,
  `reconcile_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `id` int(11) NOT NULL,
  `name` varchar(40) DEFAULT NULL,
  `notes` varchar(254) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `reconcile_rules`
--

CREATE TABLE `reconcile_rules` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `scheduled_transactions`
--

CREATE TABLE `scheduled_transactions` (
  `id` int(11) NOT NULL,
  `amount` decimal(10,4) NOT NULL,
  `description` varchar(254) NOT NULL,
  `notes` varchar(254) DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `budget_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `day_of_month` smallint(6) DEFAULT NULL,
  `num_per_period` smallint(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `name` varchar(80) NOT NULL,
  `value` text,
  `default_value` text,
  `is_json` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `budgeted_amount` decimal(10,4) DEFAULT NULL,
  `description` varchar(254) NOT NULL,
  `notes` varchar(254) DEFAULT NULL,
  `account_id` int(11) DEFAULT NULL,
  `scheduled_trans_id` int(11) DEFAULT NULL,
  `planned_budget_id` int(11) DEFAULT NULL,
  `transfer_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `txn_reconciles`
--

CREATE TABLE `txn_reconciles` (
  `id` int(11) NOT NULL,
  `txn_id` int(11) DEFAULT NULL,
  `ofx_fitid` varchar(255) DEFAULT NULL,
  `ofx_account_id` int(11) DEFAULT NULL,
  `rule_id` int(11) DEFAULT NULL,
  `note` varchar(254) DEFAULT NULL,
  `reconciled_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

CREATE TABLE `vehicles` (
  `id` int(11) NOT NULL,
  `name` varchar(254) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ix_accounts_name` (`name`);

--
-- Indexes for table `account_balances`
--
ALTER TABLE `account_balances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_account_balances_account_id_accounts` (`account_id`);

--
-- Indexes for table `alembic_version`
--
ALTER TABLE `alembic_version`
  ADD PRIMARY KEY (`version_num`);

--
-- Indexes for table `bom_items`
--
ALTER TABLE `bom_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_bom_items_project_id_projects` (`project_id`);

--
-- Indexes for table `budgets`
--
ALTER TABLE `budgets`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ix_budgets_name` (`name`);

--
-- Indexes for table `budget_transactions`
--
ALTER TABLE `budget_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_budget_transactions_budget_id_budgets` (`budget_id`),
  ADD KEY `fk_budget_transactions_trans_id_transactions` (`trans_id`);

--
-- Indexes for table `fuellog`
--
ALTER TABLE `fuellog`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_fuellog_vehicle_id_vehicles` (`vehicle_id`);

--
-- Indexes for table `ofx_statements`
--
ALTER TABLE `ofx_statements`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_ofx_statements_account_id` (`account_id`,`filename`);

--
-- Indexes for table `ofx_trans`
--
ALTER TABLE `ofx_trans`
  ADD PRIMARY KEY (`account_id`,`fitid`),
  ADD KEY `ix_ofx_trans_memo` (`memo`),
  ADD KEY `ix_ofx_trans_name` (`name`),
  ADD KEY `ix_ofx_trans_description` (`description`),
  ADD KEY `fk_ofx_trans_statement_id_ofx_statements` (`statement_id`),
  ADD KEY `fk_ofx_trans_reconcile_id_txn_reconciles` (`reconcile_id`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reconcile_rules`
--
ALTER TABLE `reconcile_rules`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_reconcile_rules_name` (`name`);

--
-- Indexes for table `scheduled_transactions`
--
ALTER TABLE `scheduled_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix_scheduled_transactions_description` (`description`),
  ADD KEY `fk_scheduled_transactions_account_id_accounts` (`account_id`),
  ADD KEY `fk_scheduled_transactions_budget_id_budgets` (`budget_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix_transactions_description` (`description`),
  ADD KEY `fk_transactions_planned_budget_id_budgets` (`planned_budget_id`),
  ADD KEY `fk_transactions_transfer_id_transactions` (`transfer_id`),
  ADD KEY `fk_transactions_account_id_accounts` (`account_id`),
  ADD KEY `fk_transactions_scheduled_trans_id_scheduled_transactions` (`scheduled_trans_id`);

--
-- Indexes for table `txn_reconciles`
--
ALTER TABLE `txn_reconciles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_txn_reconciles_txn_id` (`txn_id`),
  ADD UNIQUE KEY `uq_txn_reconciles_ofx_account_id` (`ofx_account_id`,`ofx_fitid`),
  ADD KEY `fk_txn_reconciles_ofx_account_id_ofx_trans` (`ofx_account_id`,`ofx_fitid`),
  ADD KEY `fk_txn_reconciles_txn_id_transactions` (`txn_id`),
  ADD KEY `fk_txn_reconciles_rule_id_reconcile_rules` (`rule_id`);

--
-- Indexes for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `account_balances`
--
ALTER TABLE `account_balances`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bom_items`
--
ALTER TABLE `bom_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `budgets`
--
ALTER TABLE `budgets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `budget_transactions`
--
ALTER TABLE `budget_transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `fuellog`
--
ALTER TABLE `fuellog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ofx_statements`
--
ALTER TABLE `ofx_statements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reconcile_rules`
--
ALTER TABLE `reconcile_rules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `scheduled_transactions`
--
ALTER TABLE `scheduled_transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `txn_reconciles`
--
ALTER TABLE `txn_reconciles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `account_balances`
--
ALTER TABLE `account_balances`
  ADD CONSTRAINT `fk_account_balances_account_id_accounts` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`);

--
-- Constraints for table `bom_items`
--
ALTER TABLE `bom_items`
  ADD CONSTRAINT `fk_bom_items_project_id_projects` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`);

--
-- Constraints for table `budget_transactions`
--
ALTER TABLE `budget_transactions`
  ADD CONSTRAINT `fk_budget_transactions_budget_id_budgets` FOREIGN KEY (`budget_id`) REFERENCES `budgets` (`id`),
  ADD CONSTRAINT `fk_budget_transactions_trans_id_transactions` FOREIGN KEY (`trans_id`) REFERENCES `transactions` (`id`);

--
-- Constraints for table `fuellog`
--
ALTER TABLE `fuellog`
  ADD CONSTRAINT `fk_fuellog_vehicle_id_vehicles` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`id`);

--
-- Constraints for table `ofx_statements`
--
ALTER TABLE `ofx_statements`
  ADD CONSTRAINT `fk_ofx_statements_account_id_accounts` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`);

--
-- Constraints for table `ofx_trans`
--
ALTER TABLE `ofx_trans`
  ADD CONSTRAINT `fk_ofx_trans_account_id_accounts` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  ADD CONSTRAINT `fk_ofx_trans_reconcile_id_txn_reconciles` FOREIGN KEY (`reconcile_id`) REFERENCES `txn_reconciles` (`id`),
  ADD CONSTRAINT `fk_ofx_trans_statement_id_ofx_statements` FOREIGN KEY (`statement_id`) REFERENCES `ofx_statements` (`id`);

--
-- Constraints for table `scheduled_transactions`
--
ALTER TABLE `scheduled_transactions`
  ADD CONSTRAINT `fk_scheduled_transactions_account_id_accounts` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  ADD CONSTRAINT `fk_scheduled_transactions_budget_id_budgets` FOREIGN KEY (`budget_id`) REFERENCES `budgets` (`id`);

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `fk_transactions_account_id_accounts` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`),
  ADD CONSTRAINT `fk_transactions_planned_budget_id_budgets` FOREIGN KEY (`planned_budget_id`) REFERENCES `budgets` (`id`),
  ADD CONSTRAINT `fk_transactions_scheduled_trans_id_scheduled_transactions` FOREIGN KEY (`scheduled_trans_id`) REFERENCES `scheduled_transactions` (`id`),
  ADD CONSTRAINT `fk_transactions_transfer_id_transactions` FOREIGN KEY (`transfer_id`) REFERENCES `transactions` (`id`);

--
-- Constraints for table `txn_reconciles`
--
ALTER TABLE `txn_reconciles`
  ADD CONSTRAINT `fk_txn_reconciles_ofx_account_id_ofx_trans` FOREIGN KEY (`ofx_account_id`,`ofx_fitid`) REFERENCES `ofx_trans` (`account_id`, `fitid`),
  ADD CONSTRAINT `fk_txn_reconciles_rule_id_reconcile_rules` FOREIGN KEY (`rule_id`) REFERENCES `reconcile_rules` (`id`),
  ADD CONSTRAINT `fk_txn_reconciles_txn_id_transactions` FOREIGN KEY (`txn_id`) REFERENCES `transactions` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

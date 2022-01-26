Hi, thank you for buying my script, I'm very grateful!

If you need help contact me on discord: okok#3488
Discord server: https://discord.gg/FauTgGRUku

1. First of all add the required tables to your database, executing the following code:

CREATE TABLE `okokBanking_transactions`	(
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`receiver_identifier` varchar(255) NOT NULL,
	`receiver_name` varchar(255) NOT NULL,
	`sender_identifier` varchar(255) NOT NULL,
	`sender_name` varchar(255) NOT NULL,
	`date` varchar(255) NOT NULL,
	`value` int(50) NOT NULL,
	`type` varchar(255) NOT NULL,
	PRIMARY KEY (`id`)
);

CREATE TABLE `okokBanking_societies`	(
  `society` varchar(255) NULL DEFAULT NULL,
	`society_name` varchar(255) NULL DEFAULT NULL,
	`value` int(50) NULL DEFAULT NULL,
	`iban` varchar(255) NOT NULL,
	`is_withdrawing` int(1) NULL DEFAULT NULL
);

ALTER TABLE `users` ADD COLUMN `iban` varchar(255) NULL DEFAULT NULL;

ALTER TABLE `users` ADD COLUMN `pincode` int(50) NULL DEFAULT NULL;

2. To add salary/paycheck transactions navigate to 'es_extended/server' and open 'paycheck.lua'.

2.1. Add the following code (just like in the example below).

TriggerEvent('okokBanking:AddTransferTransactionFromSocietyToP', salary, "salary", "Salary", xPlayer.identifier, xPlayer.getName())

Example:

if salary > 0 then
	if job == 'unemployed' then -- unemployed
		xPlayer.addAccountMoney('bank', salary)
		TriggerEvent('okokBanking:AddTransferTransactionFromSocietyToP', salary, "salary", "Salary", xPlayer.identifier, xPlayer.getName())
		TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_help', salary), 'CHAR_BANK_MAZE', 9)
	elseif Config.EnableSocietyPayouts then -- possibly a society
		TriggerEvent('esx_society:getSociety', xPlayer.job.name, function (society)
			if society ~= nil then -- verified society
				TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function (account)
					if account.money >= salary then -- does the society money to pay its employees?
						xPlayer.addAccountMoney('bank', salary)
						account.removeMoney(salary)
						TriggerEvent('okokBanking:AddTransferTransactionFromSocietyToP', salary, "salary", "Salary", xPlayer.identifier, xPlayer.getName())
						TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_salary', salary), 'CHAR_BANK_MAZE', 9)
					else
						TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), '', _U('company_nomoney'), 'CHAR_BANK_MAZE', 1)
					end
				end)
			else -- not a society
				xPlayer.addAccountMoney('bank', salary)
				TriggerEvent('okokBanking:AddTransferTransactionFromSocietyToP', salary, "salary", "Salary", xPlayer.identifier, xPlayer.getName())
				TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_salary', salary), 'CHAR_BANK_MAZE', 9)
			end
		end)
	else -- generic job
		xPlayer.addAccountMoney('bank', salary)
		TriggerEvent('okokBanking:AddTransferTransactionFromSocietyToP', salary, "salary", "Salary", xPlayer.identifier, xPlayer.getName())
		TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_salary', salary), 'CHAR_BANK_MAZE', 9)
	end
end

3. To replace the "okokBanking" logo, simply replace it with yours on the 'web' folder.
global class AccountBatchApex implements Database.Batchable<sObject>, Database.Stateful
{
    global integer numOfRecs = 0;
    global  Database.QueryLocator start(Database.BatchableContext BC)
    {
        String query = 'SELECT Id, Name, AccountNumber, Type FROM Account';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Account> accList)
    {
        for(Account acc: accList)
        {
            if(acc.type.equals('Customer - Direct'))
            {
                numOfRecs++;
            }
        }
    }

    global void finish(Database.BatchableContext BC)
    {
        System.debug('numOfRecs = ' + numOfRecs);
    }
}
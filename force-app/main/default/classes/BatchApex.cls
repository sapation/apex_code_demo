global class BatchApex implements Database.Batchable<sObject>
{
    global Database.QueryLocator start(Database.BatchableContext BC)
    {   String query = 'select id, name from account';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<Account> accList) 
    {
        System.debug('accList.size()='+accList.size());
        for(Account ac: accList)
        {
            ac.name += 'BatchApex';
        }
        try {
            update accList;
        } catch(Exception e) {
            System.debug(e);
        }
    }

    global void finish(Database.BatchableContext BC) 
    {
    }
}
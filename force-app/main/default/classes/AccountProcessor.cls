public class AccountProcessor {
    @future
    public static void countContacts(List<Id> accountIds) {
        List<Account> accountList = new List<Account>();

        for(Id accId : accountIds) {
            Account acc = [SELECT name FROM account WHERE id=:accId];
            acc.Number_of_Contacts__c = [SELECT count() FROM contact WHERE accountId=:accId];
            accountList.add(acc);
        }

        update accountList;
    }


    public AccountProcessor() {
        List<Account> accList = [SELECT id FROM account];
        List<Id> accountIds = new List<Id>();
        for(Account acc: accList) {
            accountIds.add(acc.id);
        }

        AccountProcessor.countContacts(accountIds);
    }
}
https://youtube.googleapis.com/youtube/v3/videos?part=statistics&id={VIDEO_ID}&key={API_KEY}
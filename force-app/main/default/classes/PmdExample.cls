public with sharing class PmdExample {

    public void runMe() {
        List<Account> a = [Select Id, Name from Account];
        for (integer i=0;i<4;i++ )
        {
            System.debug('Hello')
        }
    }
}
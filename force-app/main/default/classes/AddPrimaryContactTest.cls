@isTest
public class AddPrimaryContactTest {
    @isTest
    static void testAddPrimaryContact() {
        // Insert 50 Accounts for NY and 50 for CA
        List<Account> nyAccounts = new List<Account>();
        List<Account> caAccounts = new List<Account>();

        for (Integer i = 0; i < 50; i++) {
            nyAccounts.add(new Account(Name = 'NY Account ' + i, BillingState = 'NY'));
            caAccounts.add(new Account(Name = 'CA Account ' + i, BillingState = 'CA'));
        }

        insert nyAccounts;
        insert caAccounts;

        // Create a test Contact template
        Contact testContact = new Contact(FirstName = 'Test', LastName = 'Contact');

        // Enqueue the AddPrimaryContact job
        Test.startTest();
        System.enqueueJob(new AddPrimaryContact(testContact, 'CA'));
        Test.stopTest();

        // Verify Contacts were created for CA accounts only
        List<Contact> caContactsCreated = [SELECT Id, AccountId FROM Contact WHERE Account.BillingState = 'CA'];
        System.assertEquals(50, caContactsCreated.size(), 'There should be 50 contacts created for CA accounts.');

        // Verify no Contacts were created for NY accounts
        List<Contact> nyContactsCreated = [SELECT Id, AccountId FROM Contact WHERE Account.BillingState = 'NY'];
        System.assertEquals(0, nyContactsCreated.size(), 'There should be no contacts created for NY accounts.');
    }
}

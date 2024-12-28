@isTest
public class LeadProcessorTest {
    @isTest
    static void testLeadProcessor() {
        // Insert 200 test Lead records
        List<Lead> testLeads = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            testLeads.add(new Lead(LastName = 'Test Lead ' + i, Company = 'Test Company ' + i));
        }
        insert testLeads;

        // Execute the batch class
        Test.startTest();
            LeadProcessor batch = new LeadProcessor();
            Database.executeBatch(batch);
        Test.stopTest();

        // Verify that all Lead records were updated
        for (Lead lead : [SELECT LeadSource FROM Lead]) {
            System.assertEquals('Dreamforce', lead.LeadSource, 'LeadSource should be updated to Dreamforce');
        }
    }
}
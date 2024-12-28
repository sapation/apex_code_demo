@isTest
public class DailyLeadProcessorTest {
    @isTest
    static void testDailyLeadProcessor() {
        // Insert 200 Lead records
        List<Lead> leads = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            leads.add(new Lead(LastName = 'Test Lead ' + i, Company = 'Test Company ' + i));
        }
        insert leads;

        // Schedule the DailyLeadProcessor class
        String cronExpression = '0 0 12 * * ?'; // Executes at 12:00 PM every day
        Test.startTest();
        String jobId = System.schedule('Test DailyLeadProcessor', cronExpression, new DailyLeadProcessor());
        Test.stopTest();

        // Verify that all Leads were updated
        List<Lead> updatedLeads = [SELECT LeadSource FROM Lead];
        for (Lead lead : updatedLeads) {
            System.assertEquals('Dreamforce', lead.LeadSource, 'LeadSource should be updated to Dreamforce');
        }
    }
}
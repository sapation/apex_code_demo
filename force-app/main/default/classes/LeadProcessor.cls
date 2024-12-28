public class LeadProcessor implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT ID, LeadSource FROM Lead'
        );
    }

    public void execute(Database.BatchableContext bc, List<Lead> scope){
        List<Lead> updatedLeads = new List<Lead>();
        for (Lead lead : scope){
            lead.LeadSource = 'Dreamforce'; 
            updatedLeads.add(lead);
        }

        if (!updatedLeads.isEmpty()) {
            update updatedLeads;
        }
    }

    public void finish(Database.BatchableContext bc){
        System.debug('Succcefully');
    }
}
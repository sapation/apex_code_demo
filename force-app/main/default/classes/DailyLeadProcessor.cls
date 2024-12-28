public class DailyLeadProcessor implements Schedulable {
    public void execute(SchedulableContext ctx) {
        List<Lead> leadList = [SELECT Id, LeadSource FROM Lead LIMIT 200]; 

        for(Lead lead: leadList) {
            lead.LeadSource = 'Dreamforce';
        }

       update leadList;
    }
}
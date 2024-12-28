public class AddPrimaryContact implements Queueable {
    private Contact newContact;
    private String state;
    
    public AddPrimaryContact(Contact newContact, String state) {
        this.newContact = newContact;
        this.state = state;
    }

    public void execute(QueueableContext context) {
        List<Contact> contacts = new List<Contact>();
        for (Account account : [SELECT Id FROM Account WHERE BillingState = :state LIMIT 200]) {
            Contact contact = new Contact();
            contact.FirstName = newContact.FirstName;
            contact.LastName = newContact.LastName;
            contact.AccountId = account.Id;
            contacts.add(contact);
        }

        insert contacts;

    }
}
public class ContactTriggerService {

    public static void updateTotalAmount(Set<Id> updatedAccounts) {

        List<Account> accounts = [SELECT ID, Name, Total_Amount__c, (SELECT ID, Name, Amount__c FROM Contacts) FROM Account WHERE ID IN :updatedAccounts];
        List<Account> updateAccounts = new List<Account>();
        for(Account account:accounts) {
            System.debug('Account >> '+account);
                account.Total_Amount__c = 0;
                for(Contact contact:account.Contacts) {
                    System.debug('contact related with above accoutn is '+contact);
                    account.Total_Amount__c+=contact.Amount__c;
                }
                updateAccounts.add(account);
        }
        update updateAccounts;
    }
}
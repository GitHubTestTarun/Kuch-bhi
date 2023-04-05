public class AccountCalculatorFuture {
	
    @future
    public static void countContacts(List<Id> accountIds) {
        List<account> accountsList  = [SELECT ID, Name, (SELECT Id, Name FROM Contacts) FROM Account WHERE Id IN:accountIds];
        System.debug('accounts camed are based on ids given '+accountsList);
        for(Account account : accountsList) {
            account.Number_Of_Contacts__c = account.Contacts.size();
        }
        if(!accountsList.isEmpty()) {
            	 update accountsList;
        }
       
    }
}
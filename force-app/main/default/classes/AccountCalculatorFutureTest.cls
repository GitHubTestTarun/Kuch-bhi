@isTest
public class AccountCalculatorFutureTest {

    @isTest
    private static void countContactsTest() {
        
        	List<Account> AccountsList = new List<Account>();
        
        for(Integer i=0; i<250; i++) {
            AccountsList.add(new Account(Name = 'Test-'+i));
        }
        insert AccountsList;
        
        List<Contact> contactsList = new List<Contact>();
        List<Id> accountIds = new List<Id>();
       // List<Id> myids = [SELECT ID FROM Account WHERE Name LIKE 'Test-%'];
        System.debug([SELECT ID FROM Account WHERE Name LIKE 'Test-%']);
        for(Account account : AccountsList ) {
            contactsList.add(new Contact(FirstName = 'Test', LastName = account.Name, AccountId = account.Id));
            accountIds.add(account.Id);
        }
		insert contactsList;
        	System.debug('Actual list of ids is '+accountIds);
	        Test.startTest();
        	AccountCalculatorFuture.countContacts(accountIds);
        	Test.stopTest();
        
        	List<Account> accounts = [SELECT ID, Number_Of_Contacts__c FROM Account];
        	
        	System.assertEquals(1, accounts[0].Number_Of_Contacts__c,'COntacts are not counted  successfully');
    }
    
    
}
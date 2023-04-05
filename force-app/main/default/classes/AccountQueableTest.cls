@isTest
public class AccountQueableTest {

    @testSetup
    static void Setup() {
        List<Account> accounts = new List<Account>();
        accounts.add(new Account(Name = 'Parent Account'));
       
        for(Integer i=1; i<=100; i++) {
            accounts.add(new Account(Name = 'Test Account'));
        }
        insert accounts;
    }
    @isTest
    private static void TestQueueableAccounts() {
       
        Id ParentId = [SELECT Id FROM Account WHERE Name = 'Parent Account'][0].Id;
         System.debug('Id  = '+ParentId);
        List<Account> accounts = [SELECT Id, Name FROM Account WHERE Name='Test Account'];
        
        AccountQueable UpdateParentAccount = new AccountQueable(accounts, ParentId);
        Test.startTest();
       	
        Id JobId = System.enqueueJob(UpdateParentAccount);//Always remember if you don't write Test.startTest() and Test.stopTest() methods in case of queueable jobs
        											//your test class will not run 
        Test.stopTest();
       
       System.assertEquals(100, [SELECT COUNT() FROM Account WHERE ParentId= :ParentId]);
        
    }//ALWAYS Remember if you are writing System.assertEquals() 
    
    @isTest 
    private static void ValueofiTest() {
         Id ParentId = [SELECT Id FROM Account WHERE Name = 'Parent Account'][0].Id;
        System.debug('Id  = '+ParentId);
       // Test.startTest();
        //Test.stopTest();
        System.assertEquals(100 ,[SELECT COUNT() FROM Account WHERE Name='Test Account']);
    }
}
@isTest
private class AccountTriggerHandlerTest {
    @TestSetup
    static void setupData(){
        List<Account> accounts = new List<Account>();
        Account account;
        for(Integer i=1; i<=5; i++) {
            account = new Account(Name = 'TestAccount-'+i, Status__c = 'InActive');
            accounts.add(account);
        }
        insert accounts;
        List<Opportunity> opportunities = new List<Opportunity>();
        Opportunity opportunity = new Opportunity();

        for(Account acc : accounts) {
            for(Integer i=1; i<=3; i++) {
                opportunity = new Opportunity(Name = 'Test-op1', AccountId =acc.Id, CloseDate = System.today()+2, StageName = 'Closed Won');
                opportunities.add(opportunity);
            }
        }
        insert opportunities;
    }
    
    @isTest
    static void singleUpdation() {
        Account account = new Account(Name = 'Test-1', Status__c = 'InActive');
        insert account;
        Opportunity opportunity = new Opportunity(Name = 'Test-op1', CloseDate = System.today()+2, StageName = 'Closed Won', AccountId = account.Id);
        insert opportunity;
        System.assertEquals('InActive', account.Status__c);
        account.Status__c = 'Active';
        Test.startTest();
        update account;
        account.Status__c = 'InActive';
        update account;
        Test.stopTest();
        System.assertEquals('InActive', account.Status__c);
    }

    @isTest
    static void bulkUpdation() {
        List<Account> accounts = [SELECT ID, Name, Status__c FROM Account];
        List<Account> updatedAccounts = new List<Account>();
        for(Account account : accounts) {
            System.assertEquals('InActive', account.Status__c);
            account.Status__c = 'Active';
            updatedAccounts.add(account);
            System.assertEquals('Active', account.Status__c);
        }
        update updatedAccounts;
        updatedAccounts = new List<Account>();
        for(Account account : accounts) {
            System.assertEquals('Active', account.Status__c);
            account.Status__c = 'InActive';
            updatedAccounts.add(account);
            System.assertEquals('InActive', account.Status__c);
        }
        update updatedAccounts;
    }
}
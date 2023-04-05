@isTest
private class OpportunityTriggerHandlerTest {
    
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
                opportunity = new Opportunity(Name = 'Test-op1', AccountId =acc.Id, CloseDate = System.today()+2, StageName = 'Qualification');
                opportunities.add(opportunity);
            }
        }
        insert opportunities;
    }

    @isTest 
    static void singleUpdation() {
        Account account = new Account(Name = 'Test-1', Status__c = 'InActive');
        insert account;
        Opportunity opportunity = new Opportunity(Name = 'Test_OP', AccountId = account.Id, StageName = 'Qualification', CloseDate = System.today()+22);
        insert opportunity;
        System.assertEquals('Qualification', opportunity.StageName, 'StageName not equals to Qualification ');
        opportunity.StageName = 'Needs Analysis';
        update opportunity;
        System.assertEquals('Needs Analysis', opportunity.StageName, 'StageName not equals to Needs Analysis ');

        opportunity.StageName = 'Closed Won';
        update opportunity;
        System.assertEquals('Closed Won', opportunity.StageName, 'StageName not equals to Closed Won ');

        account = new Account(Name = 'Test-1', Status__c = 'Active');
        insert account;
        opportunity.AccountId = account.Id;
        update opportunity;
        System.assertEquals(account.Id, opportunity.AccountId);
    }

    @isTest
    static void bulkUpdation() {
        List<Account> accounts = [SELECT Id, Name, Status__c FROM Account];
        List<Opportunity> updatedOpportunities = new List<Opportunity>();

        for(Account account : accounts) {
            for(Opportunity opportunity : [SELECT ID, Name, StageName, AccountId FROM Opportunity WHERE AccountId =:account.Id]) {
                System.assertEquals('Qualification', opportunity.StageName);
                opportunity.StageName = 'Needs Analysis';
                System.assertEquals('Needs Analysis', opportunity.StageName);
                updatedOpportunities.add(opportunity);
            }
        }
        update updatedOpportunities;
        updatedOpportunities = new List<Opportunity>();
        for(Account account : accounts) {
            for(Opportunity opportunity : [SELECT ID, Name, StageName, AccountId FROM Opportunity WHERE AccountId =:account.Id]) {
                System.assertEquals('Needs Analysis', opportunity.StageName);
                opportunity.StageName = 'Closed Won';
                System.assertEquals('Closed Won', opportunity.StageName);
                updatedOpportunities.add(opportunity);
            }
        }
        update updatedOpportunities;
     }
}
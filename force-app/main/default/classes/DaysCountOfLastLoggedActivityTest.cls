@isTest
private class DaysCountOfLastLoggedActivityTest {
   
    @TestSetup
    static void setupData(){
        
        Account account = new Account(Name = 'Test-1');
        insert account;

        Opportunity op = new Opportunity(name = 'Test-Op', StageName = 'Qualification', CloseDate = System.today()+22, AccountId = account.Id);
        insert op;

        // [Select ID, AccountId, (select LastModifiedDate from ActivityHistories order by LastModifiedDate DESC limit 1), 
        // (select id,LastModifiedDate from events order by LastModifiedDate DESC limit 1), 
        // (select id, LastModifiedDate from tasks order by LastModifiedDate DESC limit 1)
        // From Opportunity where AccountId= :accountId];
    }

    @isTest
    static void LatestModifiedDate_ActivityHistoryTest() {
        DaysCountOfLastLoggedActivity obj1 = new DaysCountOfLastLoggedActivity();
        Account account = [SELECT ID, Name FROM Account];
        Test.startTest();
        obj1.LatestModifiedDate_ActivityHistory(account.Id);
        Test.stopTest();
    }
}
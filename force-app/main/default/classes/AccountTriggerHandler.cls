public class AccountTriggerHandler {

    public static void afterUpdate(Map<Id, Account> newAccounts, Map<Id, Account> oldAccounts) {
        handler(newAccounts, oldAccounts);
    }
   
    private static void handler(Map<Id, Account> newAccounts, Map<Id, Account> oldAccounts) {

        Set<Id> accountIds = new Set<Id>();
        List<Account> accounts = new List<Account>();
        List<Opportunity> opportunities = new List<Opportunity>();

        accounts = (Trigger.isInsert || Trigger.isUpdate ) ? newAccounts.values() : oldAccounts.values();

        for(Account account : accounts) {
            System.debug('Account camed is  '+account);
            System.debug('And status is  '+account.Status__c);
           // List<Opportunity> opps = [SELECT ID, Name, StageName FROM Opportunity WHERE AccountId=:account.Id];

            // for(Opportunity op : opps) {
            //     if(op.StageName == 'Closed Won' && account.Status__c == 'InActive') {
            //         accountIds.add(account.Id);
            //         opportunities.add(op);
            //     }
            // }
            
            if(account.status__c == 'Active') {
                accountIds.add(account.Id);
            }
        }
        // if(opportunities.size()>0) {
        //     update opportunities;
        // }
        if(!accountIds.isEmpty()) {
            
            AccountTriggerService.updateOpportunity(accountIds);
        }
    }
}
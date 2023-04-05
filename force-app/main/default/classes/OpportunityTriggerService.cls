public class OpportunityTriggerService {
   public static void updateRelatedAccount(Set<Id> accountIds) {

      System.debug('Inside OppoTriggerService classs ');

         List<Account> accounts = [SELECT Id, Name, Status__c FROM Account WHERE ID IN :accountIds];
         List<Account> updatedAccounts = new List<Account>();
         for(Account account : accounts) {
            account.Status__c = 'Active';
            updatedAccounts.add(account);
         }
         update updatedAccounts;
   }
}
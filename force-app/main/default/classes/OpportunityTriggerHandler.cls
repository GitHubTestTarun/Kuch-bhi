public class OpportunityTriggerHandler {
    
    public static void afterUpdate(Map<Id, Opportunity> newOpportunites, Map<Id, Opportunity> oldOpportunites) {
        System.debug('Inside afterUpdate of OPPO ');
        opportunityHandler(newOpportunites, oldOpportunites);
    }

    private static void opportunityHandler(Map<Id, Opportunity> newOpportunites, Map<Id, Opportunity> oldOpportunites) {

        System.debug('Inside opportunityHandler ');
        Set<Id> updatedAccounts = new Set<Id>();
        Set<Id> updatedOpportunities = new Set<Id>();
        Map<Id, Opportunity> opportunites = new Map<Id, Opportunity>();

        for(Opportunity opportunity : newOpportunites.values()) {

            // Account account = [SELECT ID, Status__c, Name FROM Account WHERE ID =:opportunity.AccountId];

            // List<Opportunity> opps = [SELECT ID, Name, AccountId, StageName FROM opportunity WHERE AccountId =:account.Id];

            // for(Opportunity op : opps) {
            //     if(op.StageName == 'Closed Won') {
            //         updatedAccounts.add(op.AccountId);
            //     }
            // }
            
            // if(account.Status__c == 'Active') {
            //     updatedAccounts.add(opportunity.AccountId);
            // }

            System.debug('opportunity.StageName >> '+opportunity.StageName);
            if(opportunity.StageName == 'Closed Won') {
                updatedAccounts.add(opportunity.AccountId);
            }
           // updatedAccounts.add(opportunity.AccountId);
        }
        System.debug('updatedAccounts>>>  '+updatedAccounts);
        if(!updatedAccounts.isEmpty()) {
            
            OpportunityTriggerService.updateRelatedAccount(updatedAccounts);
        }
    }
}
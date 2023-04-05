public class loginAccountHandler {

    public static void beforeInsert(List<loginAccount__c> newLoginAccounts) {
        mainLogic(null, newLoginAccounts);
    }
    
    private static void mainLogic(Map<Id, loginAccount__c> oldLoginAccounts, List<loginAccount__c> newLoginAccounts) {
    
        for(loginAccount__c loginAccount : newLoginAccounts) {
            
            if(loginAccount.Name == 'Tarun') {
                loginAccount.Name = 'Varun';
            }
        }
       
    }
}
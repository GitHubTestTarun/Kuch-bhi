trigger loginAccount on loginAccount__c (before insert, after insert) {

    if(Trigger.isBefore) {
        if(Trigger.isInsert) {
            loginAccountHandler.beforeInsert(Trigger.new);
        }
    }
}
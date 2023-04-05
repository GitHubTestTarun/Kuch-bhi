public class NewCaseListController {
	
    public List<Case> getNewCases1() {
        List<Case> results = Database.query(
            'SELECT Id, CaseNumber FROM Case ');
        return results;
    }
}
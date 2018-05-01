component {

	function getQuestionService() { return variables.questionService; }
	function setQuestionService(any questionservice) {
		variables.questionService = arguments.questionservice;
	}

	function init(fw) {
		variables.fw = arguments.fw;
	}
	
	function startDefault(any rc) {		
		rc.questions = getQuestionService().list(perpage=5);
	}
		
}
component {

	function getQuestionService() { return variables.questionService; }
	function setQuestionService(any questionservice) {
		variables.questionService = arguments.questionservice;
	}

	function init(fw) {
		variables.fw = arguments.fw;
	}

	//Used by a few methods to validate/load a question
	private function loadQuestion(any rc) {
		if(!structKeyExists(rc, "questionid") || !isNumeric(rc.questionid) || rc.questionid <= 0) variables.fw.redirect("main.default");
		rc.question = getQuestionService().get(rc.questionid);
	}
	
	function startList(any rc) {
		if(structKeyExists(rc, "start") && (!isNumeric(rc.start) || rc.start <= 0 || round(rc.start) != rc.start)) rc.start = 1;
	}
		
	function startPost(any rc) {		
		rc.errors = [];
		if(!len(trim(rc.title))) arrayAppend(rc.errors, "You must include a title for your question.");
		if(!len(trim(rc.text))) arrayAppend(rc.errors, "You must include text for your question.");
		
		if(arrayLen(rc.errors)) {
			variables.fw.redirect("question.new", "title,text,errors");
		} 
	}

	function endPost(any rc) {
		//Right now we assume the post just worked
		rc.questionid = rc.data.getId();
		variables.fw.redirect("question.view","none","questionid");
	}

	function startPostAnswer(any rc) {
		loadQuestion(rc);
		
		rc.answer = trim(htmlEditFormat(rc.answer));
	
	}
	
	function endPostAnswer(any rc) {
		//Right now we assume the post just worked
		rc.questionid = rc.question.getId();
		variables.fw.redirect("question.view","none","questionid");
	}

	function startSelectAnswer(any rc) {
		loadQuestion(rc);
		
		if(!structKeyExists(rc, "user") || rc.user.getId() != rc.question.getUser().getID()) variables.fw.redirect("main.default");	
	}

	function endSelectAnswer(any rc) {
		rc.questionid = rc.question.getId();
		variables.fw.redirect("question.view","none","questionid");	
	}
	
	function startView(any rc) {
		loadQuestion(rc);
	}

	function startVoteAnswerDown(any rc) {
		loadQuestion(rc);
	}
			
	function endVoteAnswerDown(any rc) {
		rc.questionid = rc.question.getId();
		variables.fw.redirect("question.view","none","questionid");		
	}

	function startVoteAnswerUp(any rc) {
		loadQuestion(rc);
	}
			
	function endVoteAnswerUp(any rc) {
		rc.questionid = rc.question.getId();
		variables.fw.redirect("question.view","none","questionid");		
	}

}
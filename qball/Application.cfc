component extends="fw1.framework" {

	this.name = "qball";
	this.sessionManagement = true;
	this.dataSource = this.name;
	this.ormEnabled = true;
	this.ormsettings = {
		cfclocation="./model",
		dbcreate="update",
		eventhandling="true",
		eventhandler="root.model.eventHandler",
		logsql="true"
	};

	this.mappings["/root"] = getDirectoryFromPath(getCurrentTemplatePath());

	variables.framework = {
		reloadApplicationOnEveryRequest=false
	};
	
	public function setupApplication() {
		var bf = createObject('component','coldspring.beans.DefaultXmlBeanFactory').init();
		bf.loadBeans( expandPath('config/coldspring.xml') );
		setBeanFactory(bf);
	}
	
	public function setupRequest() {
		if(structKeyExists(url, "init")) {
			setupApplication();
			ormReload();
			location(url="index.cfm",addToken=false);
		}
		var userController = getController("user");
		doController(userController, "checkAuthorization");		
	}

}
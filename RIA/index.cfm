<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>RIA Demo</title>
<script type="text/javascript" >

	function initGrid(){
	var grid = ColdFusion.Grid.getGridObject("userGrid");
	grid.on("rowdblclick", showUserForm);
	}
	
	function showUserForm(){
		var userId = ColdFusion.getElementValue("userGrid","userGridForm","userId");
		var url = "userForm.cfm?UserId="+userId ;
		ColdFusion.navigate(url, "userWin");		
		ColdFusion.Window.show("userWin");
	}
	
	function newUser(){
		var url = "userForm.cfm" ;
		ColdFusion.navigate(url, "userWin");		
		ColdFusion.Window.show("userWin");
	}
	
	function submitForm() {
		clearErrors();
        ColdFusion.Ajax.submitForm("userForm", "userForm_submit.cfm", submitCallback, errorHandler);
    }
    
    function submitCallback(response){
    	var errors = ColdFusion.JSON.decode(response);
    	var valid = true;
    	
    	for(i in errors){
				document.getElementById(i+"Error").innerHTML = errors[i];
				valid = false;
			}
		if(valid){
			ColdFusion.Window.hide("userWin");
    		ColdFusion.Grid.refresh("userGrid", true);
		}
    	
    }
    
    function errorHandler(code, msg)
    {
        alert("Error!!! " + code + ": " + msg);
    }
    
    function clearErrors(){
    	document.getElementById("firstNameError").innerHTML = "";
    	document.getElementById("lastNameError").innerHTML = "";
    	document.getElementById("emailAddressError").innerHTML = "";
    	document.getElementById("phoneError").innerHTML = "";
    }
	
	
</script>
<link rel="stylesheet" type="text/css" href="styles.css" />
<cfset ajaxOnLoad("initGrid") />
<cfajaximport tags="cfform" />
</head>

<body>
	<h1>RIAs with ColdFusion 8 Demo</h1>
	<h2>Users</h2>
	<cfform name="userGridForm" method="post">
	<div>
		<div style="float:left;"><cfinput type="button" name="newUSerBtn" id="newUserBtn" value="New User" onclick="javascript:newUser();"></div>
		<div style="clear:both;"></div>
	</div>
	
	<cfgrid name="userGrid" 
			format="html" 
			pagesize="5"
			preservePageOnSort="true" 
			bind="cfc:com.user.UserService.getAllUsers({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection})" 
			stripeRows="true">
		<cfgridcolumn name="userId" header="ID" display="false" />
		<cfgridcolumn name="firstName" header="First Name" width="200" />
		<cfgridcolumn name="lastName" header="Last Name" width="300" />
		<cfgridcolumn name="emailAddress" header="Email" width="220" />
		<cfgridcolumn name="phone" header="Phone" />
	</cfgrid>
	</cfform>

<cfwindow name="userWin" title="User Information" initShow="false" modal="true" center="true"></cfwindow>

	
	
</body>
</html>
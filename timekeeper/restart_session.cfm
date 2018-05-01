<cfinclude template="header.cfm" >

<div class="container">
	<div class="row">
		<div class="col-md-4 col-md-offset-4">
			<div class="login-panel panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">Time Keeper</h3>
				</div>
				<div class="panel-body">
					<cfoutput> 
					<!---<form action="#CGI.script_name#?#CGI.query_string#" role="form" method="Post">--->
					<form action="#CGI.script_name#" role="form" method="Post">
					<fieldset>
					<div class="form-group">
						<input class="form-control" placeholder="login id" name="j_username" autofocus>
					</div>
					<div class="form-group">
						<input class="form-control" placeholder="password" name="j_password" type="password" value="">
					</div>
					<div class="checkbox">
						<label>
							<input name="remember" type="checkbox" value="Remember Me">Remember Me
						</label>
					</div>
					
					<input type="submit" value="Log In" class="btn btn-lg btn-success btn-block">
					
					</fieldset>
					</form>
					</cfoutput>
				</div>
			</div>
		</div>
	</div>
</div>

<!---<cfinclude template="footer.cfm" >--->
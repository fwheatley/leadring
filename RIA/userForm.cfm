<cfparam name="url.userId" default="" />

<cfset user = createObject("component","com.user.UserService").getUser(url.userid) />


<cfform name="userForm">
	<cfinput type="hidden" name="userId"  value="#url.userId#" />
	<div class="formElement">
	<label for="firstName">First Name</label>
	<cfinput id="firstName" name="firstName"  value="#user.firstName#" />
	<div id="firstNameError" class="error"></div>
	</div>
	<div class="formElement">
	<label for="lastName">Last Name</label>
	<cfinput id="lastName" name="lastName" value="#user.lastName#" />
	<div id="lastNameError" class="error"></div>
	</div>
	<div class="formElement">
	<label for="emailAddress">Email Address</label>
	<cfinput id="emailAddress" name="emailAddress" value="#user.emailAddress#"  />
	<div id="emailAddressError" class="error"></div>
	</div>
	<div class="formElement">
	<label for="phone">Phone</label>
	<cfinput id="phone" name="phone"  value="#user.phone#"  />
	<div id="phoneError" class="error"></div>
	</div>
	<div style="text-align:center"><cfinput name="submit" type="button" value="Save User" onclick="submitForm()"><cfinput type="button" name="cancel" value="Cancel" onclick="ColdFusion.Window.hide('userWin')"></div>
</cfform>

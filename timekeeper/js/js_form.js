
// Declare Global Variables

	var formAlertMessage='There were Errors!';
	var formSubmit=1;

/*
	throwError gets called each time there is an error in the
	validation routines.
*/
function throwError (theField,theMessage) {
	formAlertMessage=formAlertMessage + "\n - " + theMessage;
	formSubmit=0;
	switchStyle(theField);
}
function switchStyle (theField) {
	theSwitch=new Function("this.style.backgroundColor='FFFFFF';this.style.color='000000';if(this.type=='text') this.select();")
	theField.style.backgroundColor='FF0000';
	theField.style.color='White';
	theField.onfocus=theSwitch;
}

/*
	formAlert displays the alert message and clears necessary variables to start
	the validation over.
*/

function formAlert() {
	alert(formAlertMessage);
	formAlertMessage='There were Errors!';
	formSubmit=1;
}


/*
	formRequired makes sure a field has been completed by the user.   In order
	for this function to work with select boxes the empty value must be set to 0
	in the form.
*/

function formRequired(theField,theMessage) {
	theField.value = theField.value.replace(/\s+$|^\s*/gi, "");
	if(theField.value == '' || theField.value == '-1' || theField.value == '0') {
		throwError(theField,theMessage);
	}
}

// form field must be composed only of numbers and letters.
function formIsAlphaNumeric(theField,theMessage) {
	theField.value = theField.value.replace(/\s+$|^\s*/gi, "");
	isAlphaNum = new RegExp ("[^0-9a-zA-Z \(\)\-\.\/]");
	if (isAlphaNum.test(theField.value)) {
		throwError(theField,theMessage);
	}
}

// form field must be composed only of numbers and letters.
function formIsSame(field1,field2,theMessage) {

	if(field1.value != field2.value) {
		throwError(field2,theMessage);
		switchStyle(field1);
	}
}

function formIsEmail (theField,theMessage) {
	var email = /^[a-zA-Z0-9._-]+@([a-zA-Z0-9.-]+\.)+[a-zA-Z0-9.-]{2,4}$/;
 	if(!email.test(theField.value)) {
		throwError(theField,theMessage);
	}
 }

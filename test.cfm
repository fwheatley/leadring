<!---<!--- Store the ColdFusion version. --->
<cfset strVersion = SERVER.ColdFusion.ProductVersion />
<cfoutput>#strVersion#</cfoutput><br />


<cfscript>
x = now().add( 'd', -5 ).dateTimeFormat( 'yyyy-mm-dd HH:nn:ss' );
writeOutput(x);
writeOutput("<br />");

qOracleTime = queryExecute("select sysdate from dual",
    {}, 
    {datasource="TST1CIS"}
);
writeDump(qOracleTime);

myArray = ArrayNew(1);
myArray.append("frank");
writeDump(myArray);

writeDump(request);

s = "The";
s = s.append("quick brown fox", " ")
	//.append("jumps over the lazy dog", " ")
	.ucase()
	.reverse();
writeOutput(s);
    
//The old way
myArray = ArrayNew(1);
//ArrayAppend(myArray, "objec_new");
//ArraySort(myArray, "ASC");

 // The new way
 myArray.append("objec_new");
 myArray.sort("ASC");

 // The new way
// var myProductObject = createObject("java", "myJavaclass");
// myjavaList = myProductObject.getProductList();
// myjavaList.add("newProduct"); // Java API

// myjavaList.append("newProduct"); // CF API
// myjavaList.sort("ASC");
 </cfscript>
--->

<cfset todayDateTime = Now()> 
<body> 
<h3>DateTimeFormat Example</h3> 
<p>Today's date and time are <cfoutput>#todayDateTime#</cfoutput>. 
<p>Using DateTimeFormat, we can display that date and time in different ways: 
<cfoutput> 
<ul>
<li>#DateTimeFormat(todayDateTime)# 
<li>#DateTimeFormat(todayDateTime, "yyyy.MM.dd G 'at' HH:nn:ss z")# 
<li>#DateTimeFormat(todayDateTime, "EEE, MMM d, ''yy")# 
<li>#DateTimeFormat(todayDateTime, "h:nn a")# 
<li>#DateTimeFormat(todayDateTime, "hh 'o''clock' a, zzzz")# 
<li>#DateTimeFormat(todayDateTime, "K:nn a, z")# 
<li>#DateTimeFormat(todayDateTime, "yyyyy.MMMMM.dd GGG hh:nn aaa")# 
<li>#DateTimeFormat(todayDateTime, "EEE, d MMM yyyy HH:nn:ss Z")# 
<li>#DateTimeFormat(todayDateTime, "yyMMddHHnnssZ", "GMT")# 
</ul>
</cfoutput>
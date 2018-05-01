<cfset variables.page = "gate.cfm">

<cfinclude template="header.cfm" >

<cfscript>
oGym = createObject("component","com.gym");
qGate = oGym.getItemByType("gatecsaa");

//if ( isdefined("form.btnSaveGate") ) {
//	if ( isdefined("form.homeid") AND len(form.homeid) EQ 0 ) {
//		form.homeid = 0;
//	}
//	strAddCitation = oCitation.addCitation(form.actiondate, form.homeid, form.license, form.citationtypeid, 1, session.nPersonID, form.correctiondate);
//}

//qAllCitations = oCitation.getAllCitations(1);
//qHomeList = oHome.getHomeList();
</cfscript>

<div id="wrapper">
	<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
		<cfinclude template="topnav.cfm" >
		<cfinclude template="sidenav.cfm" >
	</nav>

	<div id="page-wrapper">
		<div class="row">
			<div class="col-lg-12">
				<h1 class="page-header">Gate</h1>
			</div>
		</div>
	<!---<cfdump var="#qGate#">--->
	
		<div class="row">
			<div class="col-lg-10">
				<div class="panel panel-default">
					<div class="panel-heading">
						Gate Options
					</div>

					<div class="panel-body">
						<form id="myform" method="POST" action="gate.cfm">
						<cfoutput query="#qGate#">
							<div class="menuitem">
								<button type="button" class="dec btn-danger btn-circle btn" id='ffishDec' field='ffishQty'><i class="fa fa-minus"></i></button>
								<input type='text' name='ffishQty' id='ffishQty' value='0' class='qty' />
								<button type="button" class="inc btn btn-success btn-circle btn" id='ffishInc' field='ffishQty'><i class="fa fa-plus"></i></button>
								#qGate.itemdesc# - #dollarformat(qGate.itemprice)#
							</div>
							<br />
						</cfoutput>
						</form>
					</div>
	
				</div>
	
			</div>
	
			<div class="row">
	
				<div class="col-md-4 menucontainer">
					<div class="menuitem">
						<input type='button' value='-' id='ffishDec' field='ffishQty' class='dec' />
						<input type='text' name='ffishQty' id='ffishQty' value='0' class='qty' />
						<input type='button' value='+' id='ffishInc' field='ffishQty' class='inc' />
						Fried Fish
					</div>
				</div>
	
				<div class="col-md-4 menucontainer">
					<div class="menuitem">
						<input type='button' value='-' id='slawDec' field='slawQty' class='dec' />
						<input type='text' name='slawQty' id='slawQty' value='0' class='qty' />
						<input type='button' value='+' id='slawInc' field='slawQty' class='inc' />
						Slaw
					</div>
				</div>
	
				<div class="col-md-4 menucontainer">
					<div align="center">
						<input type='submit' value='Clear' id='clear' style="color:grey;" />
						<!---<input type='submit' value='Next' name="next" id="next" <cfif NOT client.bLoggedIn>disabled="disabled" style="color:grey;"</cfif> id='complete' />--->
					</div>
					<br />
	
					<div id='total'>Total:&nbsp;&nbsp;&nbsp;$0.00</div>
	
					<div id="ffishSub" class="subtotal"></div>
					<div id="slawSub" class="subtotal"></div>
				</div>
			</div>
	
	    </div>
	
	 	<div class="aboutus">
	
			<div class="row">
				<div class="col-md-8 menucontainer" align="center">
					<br />
					<input type='submit' value='Next' name="next" id="next" <cfif NOT session.bLoggedIn>disabled="disabled" style="color:grey;"<cfelse>class="submit-button"</cfif> id='complete' />
	
					<br /><br />
				</div>
			</div>
		</div>
	
		<cfset dtToday = CreateDate( Year(Now()), Month(Now()), Day(Now()) )>
		<cfset dtToday = dateadd("d", -1, dtToday)>
		<hr />
<!---	
		<cfquery name="qOrders" datasource="fishfry">
		select a.itemid, sum(a.qty) as total, c.itemdesc
		from ordersdet a, orders b, items c
		where a.orderid = b.orderid
		  and a.itemid = c.itemid
		  and orderdate ><cfqueryparam value="#dtToday#" cfsqltype="cf_sql_timestamp">
		group by a.itemid, c.itemdesc
		order by total desc
		</cfquery>
	
		<div class="row">
			<div class="col-md-8">
				<table>
					<tr>
						<th>Item</th>
						<th>Sold Today</th>
					</tr>
					<cfoutput query="qOrders">
						<tr>
							<td>#itemdesc#</td>
							<td align="right">#total#</td>
						</tr>
					</cfoutput>
				</table>
			</div>
		</div>
--->	
	</div>
	
</div>

<script>
$(document).ready(function() {
	
	$('.nav li.dropdown').hover(function() {
        $(this).addClass('open');
    }, function() {
        $(this).removeClass('open');
    });

	$("tr:odd").addClass("odd");

	$('#clear').click(function(e){
		e.preventDefault();
		$('.inc').css("color","black");
		$('.dec').css("color","black");
		$('#ffishQty').val(0);
		$('#slawQty').val(0);
		
		$('.subtotal').hide();
		$("#total").html('Total:&nbsp;&nbsp;&nbsp;$0.00');

	});

	$('.inc').click(function(e){
		e.preventDefault();
		$('.inc').css("color","black");
		$('.dec').css("color","black");
		$(this).css("color","red");
		fieldName = $(this).attr('field');		
		var currentVal = parseInt($('input[name='+fieldName+']').val());
		if (!isNaN(currentVal)) {
			$('input[name='+fieldName+']').val(currentVal + 1);
		} else {
			$('input[name='+fieldName+']').val(0);
		}
		calc();
	});	
			
	$(".dec").click(function(e) {
		e.preventDefault();
		$('.inc').css("color","black");
		$('.dec').css("color","black");
		$(this).css("color","red");
		fieldName = $(this).attr('field');
		var currentVal = parseInt($('input[name='+fieldName+']').val());
		if (!isNaN(currentVal) && currentVal > 0) {
			$('input[name='+fieldName+']').val(currentVal - 1);
		} else {
			$('input[name='+fieldName+']').val(0);
		}
		calc();
	});

function calc(){
	var nTotal = 0;
	var ffishQty =  parseInt($('#ffishQty').val());
	var slawQty =  parseInt($('#slawQty').val());
	
	$('.subtotal').hide();
	if (ffishQty > 0) {
		$("#ffishSub").html(ffishQty+' Fried Fish');
		$("#ffishSub").show();
	}
	if (slawQty > 0) {
		$("#slawSub").html(slawQty+' Slaw');
		$("#slawSub").show();
	}
	
	nTotal = ffishQty*5+slawQty*1.5;
	nTotal = parseFloat(Math.round(nTotal * 100) / 100).toFixed(2);
	
	$("#total").html('Total:&nbsp;&nbsp;&nbsp;$'+nTotal);   
}

});
</script>

<cfinclude template="footer.cfm" >

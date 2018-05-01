<!DOCTYPE html>
<html lang="en">

<cfparam name="request.sCpyName" default="Jefferson National" />
<cfparam name="request.sPageTitle" default="TimeKeeper" />

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

	<cfoutput>
	    <title>#request.sCpyName# - #request.sPageTitle#</title>
	
	    <!-- Bootstrap Core CSS -->
	    <link href="#request.sSiteUrl#css/bootstrap.min.css" rel="stylesheet">
	
	    <!-- MetisMenu CSS -->
	    <link href="#request.sSiteUrl#css/plugins/metisMenu/metisMenu.min.css" rel="stylesheet">
	
	    <!-- Timeline CSS -->
	    <link href="#request.sSiteUrl#css/plugins/timeline.css" rel="stylesheet">
	
	    <!-- Custom CSS -->
	    <link href="#request.sSiteUrl#css/sb-admin-2.css" rel="stylesheet">
	
	    <!-- Morris Charts CSS -->
	    <link href="#request.sSiteUrl#css/plugins/morris.css" rel="stylesheet">
	
	    <!-- Custom Fonts -->
	    <link href="#request.sSiteUrl#font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
	    
	    <link href="#request.sSiteUrl#/css/jquery-ui.min.css" rel="stylesheet" type="text/css">
	    	
	    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
	    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	    <!--[if lt IE 9]>
	        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
	        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
	    <![endif]-->
		
		<script language='JavaScript' src='#request.sSiteUrl#js/js_form.js'></script>
	</cfoutput>
	
	<style>
	
	.sprintsub {
		/*letter-spacing: 1px;*/
	    padding: 5px 2px 5px 0px;
	    font-family: OpenSans,Arial,sans-serif;
    	font-size: 10px;
    	font-style: normal;
    	text-transform: uppercase;
	}
		
	.project {
	    color: #6296da;
	    background-color: white;
		border-style: solid;
	    border-width: 0px;
	    border-color:white;
	}

	.userstory {
	    color: #6296da;
	    background-color: rgba(98, 150, 218, 0.2);
		border-style: solid;
	    border-width: 1px;
	    border-color:white;
	}

	.tasks {
		color: #130c90;
		background-color: rgba(19,12,92,0.20);
	}
	
	.bugs {
		color: #da5868;
		background-color: rgba(217,88,104,0.20);
	}
	
	.projecthead {
	    cursor:pointer;
	    /*color:white;*/
	}

	.storyhead {
	    cursor:pointer;
	}
	
	.panel-body {
	 	padding: 6px;
	}
	
	.page-header {
    	border-bottom: 1px solid #eee;
    	margin: 20px 0 10px;
    	padding-bottom: 9px;
	}
	
	.entityTime {
		text-align:right;
	}
	
	.timedata {
		width:8%;
		text-align:center;
	}

	#table-time tr.rowheader td {background-color:#E0E3E5;}
	#table-time tr.projectheader td {
		background-color:#888A93;
		/*border-top: 3px solid #BEC1C4;*/
	}


	#table-time tr.storyheader td {background-color:#F8F8F8;}
	
	#table-time td {
		border-color:#C6CCD1;
		vertical-align: middle;
		padding: 7px;	
	}

	
	</style>	
</head>

<cfif NOT isdefined("oTime")>
	<cfset oTime = createObject("component","com.timekeeper")>
</cfif>

<body>
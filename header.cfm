<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <title>Easy Start - Grid</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">


    <link href="scripts/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->


    <link href="styles/custom.css" rel="stylesheet" type="text/css" />

    <!-- Icons -->
    <link href="scripts/fonts/foundation-icons-general/stylesheets/foundation-icons-general.css" rel="stylesheet" type="text/css" />
    <link href="scripts/fonts/foundation-icons-social/stylesheets/foundation-icons-social.css" rel="stylesheet" type="text/css" />  
	<link href="scripts/camera/css/camera.css" rel="stylesheet" type="text/css" />
	<link href="scripts/wookmark/css/style.css" rel="stylesheet" type="text/css" />
    <link href="http://fonts.googleapis.com/css?family=Chewy" rel="stylesheet" type="text/css">
    <link href="http://fonts.googleapis.com/css?family=Abel" rel="stylesheet" type="text/css">
    <link href="http://fonts.googleapis.com/css?family=Terminal+Dosis+Light" rel="stylesheet" type="text/css">

</head>

<body id="pageBody">

<div id="divBoxed" class="container">

<div class="transparent-bg" style="position: absolute;top: 0;left: 0;width: 100%;height: 100%;z-index: -1;zoom: 1;"></div>

<div class="divPanel notop nobottom">
	<div class="row-fluid">
		<div class="span5">					
			<div id="divLogo">
				<a href="index.cfm" id="divSiteTitle">Leadring</a><br />
				<a href="index.cfm" id="divTagLine">Clean HTML5 Template..</a>
			</div>
		</div>

		<div class="span7">
			<div id="divMenuRight" class="pull-right">
				<div class="navbar">
					<button type="button" class="btn btn-navbar-highlight btn-large btn-primary" data-toggle="collapse" data-target=".nav-collapse">
					NAVIGATION <span class="icon-chevron-down icon-white"></span>
					</button>

					<div class="nav-collapse collapse">
						<ul class="nav nav-pills ddmenu">
							<li class="dropdown <cfif navItem EQ 'home'>active</cfif>"><a href="index.cfm">Home</a></li>
							<li class="dropdown <cfif navItem EQ 'page'>active</cfif>">
								<a href="page.cfm" class="dropdown-toggle">Page <b class="caret"></b></a>
								<ul class="dropdown-menu">
									<li><a href="#" class="dropdown-toggle">Dropdown Item</a></li>
									<li><a href="#">Dropdown Item</a></li>
									<li><a href="#">Dropdown Item</a></li>
								</ul>
							</li>
							<li class="dropdown <cfif navItem EQ 'grid'>active</cfif>"><a href="grid.cfm">Grid</a></li>
							<li class="dropdown <cfif navItem EQ 'simple'>active</cfif>"><a href="simple.cfm">Simple</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>

	<cfif navItem EQ "home">
		<div class="row-fluid">
			<div class="span12">
				<div id="headerSeparator"></div>
				<div class="row-fluid">
					<div class="span6">
	
						<div id="divHeaderText" class="page-content">
							<div id="divHeaderLine1">Header Text Here!</div>
							<div id="divHeaderLine2">2nd Line Header Text for calling extra attention to featured content or information.</div>
							<div id="divHeaderLine3"><a class="btn btn-large btn-secondary" href="#">Secondary Button</a>    <a class="btn btn-large btn-primary" href="#">Primary Button</a></div>
						</div>
					</div>
						
					<div class="span6">
						<div id="camera_wrap">
							<div data-src="styles/working-on-keyboard.JPG" >
								<div style="position:absolute;bottom:10%;left:3%;padding:10px;width:50%;" class="fadeIn camera_effected camera_caption cap1">
									Lorem Ipsum is simply dummy text of the printing and typesetting industry.
								</div>
							</div>
							<div data-src="styles/two-businessmen.jpg" >
								<div class="camera_caption fadeFromBottom cap2">
									Lorem Ipsum is simply dummy text of the printing and typesetting industry.
								</div>
							</div>
						</div>
					</div>
				</div>
	
				<div id="headerSeparator2"></div>
			</div>
		</div>
	</cfif>

	<div class="row-fluid">
		<div class="span12">
			<div id="contentInnerSeparator"></div>
		</div>
	</div>
</div>
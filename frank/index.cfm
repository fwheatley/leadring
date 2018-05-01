<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html>
	<head>
		<title>Custom RSS 2.0 Feed</title>
		
		<!-- Meta Data. -->
		<meta name="Keywords" content="blog,web log,Ben Nadel,Nadel,ColdFusion,Cold Fusion,CFMX,CF7,web applications,development,SQL,learning,scripting,SQL,blog,snippets,javascript,dhtml,help," />
		<meta name="Description" content="Frank Wheatley" />
		
		<!-- Linked Files. -->
		<link rel="shortcut icon" href="favicon.ico" type="image/ico"></link>
		<link rel="alternate" type="application/rss+xml" title="Ben Nadel's ColdFusion And Web Development RSS" href="index.cfm?dax=blog.rss">
		<link rel="stylesheet" type="text/css" href="default.css"></link>
		<!--[if lt IE 7]>
		<link rel="stylesheet" type="text/css" href="linked/css/ie6.css?v=1"></link>
		<![endif]-->

		<script type="text/javascript">	
			var strWebRoot = "";
		</script>
		<script type="text/javascript" src="http://jqueryjs.googlecode.com/files/jquery-1.3.1.min.js"></script>
		<script type="text/javascript" src="jquery.jtwitter.min.js"></script>

    <script language="javascript" src="jquery.tweet.js" type="text/javascript"></script>
    <script type='text/javascript'>
      jQuery(document).ready(function($) {
        $(".tweet").tweet({
          join_text: "auto",
          username: "frankwheatley",
          avatar_size: 48,
          count: 1,
          auto_join_text_default: "we said,", 
          auto_join_text_ed: "I",
          auto_join_text_ing: "I was",
          auto_join_text_reply: "I replied",
          auto_join_text_url: "I was checking out",
          loading_text: "loading tweets..."
        });
      })      
    </script>

	</head>
	<body>
		<div id="site-header">
			<div id="social">
				<div class="mini-bio">
					I am the web application architect for Jefferson National Financial in Louisville, KY.
					(&nbsp;<a href="about/about-ben-nadel.htm">more</a>&nbsp;)
				</div>
					
				<div class="find-me-links">
					<strong>Find me on:</strong>
					<a href="http://www.linkedin.com/pub/frank-wheatley/4/702/749" target="linkedin" rel="no-follow">LinkedIn</a> -
					<a href="http://www.facebook.com/profile.php?id=626778766&ref=name" target="facebook" rel="no-follow">Facebook</a> -
					<a href="http://www.twitter.com/frankwheatley" target="twitter" rel="no-follow">Twitter</a>
				</div>
				
				<a id="recent-twitter-status" href="http://www.twitter.com/frankwheatley" target="twitter" rel="no-follow" class="recent-twitter-status">
					<div class='tweet'></div>
				</a>
					
			</div>
		</div>

	</body>
	</html>

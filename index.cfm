
<cfset navItem = "home">

<cfinclude template="header.cfm" >

<div class="contentArea">
	<div class="divPanel notop page-content">
		<div class="row-fluid">
			<div class="span12" id="divMain">
				<h1>Full Width Frank Wheatley</h1>

				<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. 
				Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.
				Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus leo ante, consectetur sit amet vulputate vel, dapibus sit amet lectus. </p>

				<div class="row-fluid">
					<div class="span4"> 
						<h2>1/3 Column</h2>
						<p>Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. <a href="#">Read More &raquo;</a></p>
					</div>
					<div class="span4">
						<h2>1/3 Column</h2>
						<p>Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. <a href="#">Read More &raquo;</a></p>
					</div>
					<div class="span4">
						<h2>1/3 Column</h2>
						<p>Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. <a href="#">Read More &raquo;</a></p>
					</div>
				</div>

				<div class="row-fluid">
					<div class="span8">
						<h2>2/3 Column</h2>
						<p>
						<img src="http://farm4.static.flickr.com/3216/5712560271_abf0043fb1_t.jpg" alt="" style="border: 7px solid rgb(255, 255, 255); box-shadow: 0pt 1px 4px rgba(0, 0, 0, 0.3); float: left; margin: 5px 15px 5px 0px;" />
						Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Maecenas sed diam eget risus varius blandit sit amet non magna. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.
						<a href="#">Read More &raquo;</a>
						</p>
					</div>
					<div class="span4">
						<div class="sidebox">
							<h3 class="sidebox-title">Sample Sidebar Content</h3>
							<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. <a href="#">Lorem Ipsum</a> has been the industry’s standard dummy text ever since the 1500s.</p>   
						</div>
					</div>
				</div>

			</div>

		</div>

		<div id="footerInnerSeparator"></div>
	</div>
</div>

<cfinclude template="footer.cfm" >

<!---additional script --->
<script src="scripts/camera/scripts/camera.min.js" type="text/javascript"></script>
<script src="scripts/easing/jquery.easing.1.3.js" type="text/javascript"></script>
<script src="scripts/camera/scripts/jquery.mobile.customized.min.js" type="text/javascript"></script>
<script type="text/javascript">
	function startCamera() {
		$('#camera_wrap').camera({ 
			fx: 'scrollLeft', time: 2000, loader: 'none', playPause: false, height: '65%', pagination: true 
		});
	}
		
	$(function(){startCamera()});
</script>



	


<cfset navItem = "simple">

<cfinclude template="header.cfm" >

<div class="transparent-bg" style="position: absolute;top: 0;left: 0;width: 100%;height: 100%;z-index: -1;zoom: 1;"></div>

<div class="contentArea">
	<div class="divPanel notop page-content">
		<div class="row-fluid">
			<div class="span8" id="divMain">
				<div class="breadcrumbs">
					<a href="index.cfm">Home</a> &nbsp;/&nbsp; <span>Simple</span>
				</div> 

				<h1>Simple</h1>
				<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.</p> 
				<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus leo ante, consectetur sit amet vulputate vel, dapibus sit amet lectus. Etiam varius dui eget lorem elementum eget mattis sapien interdum. In hac habitasse platea dictumst. </p>
			</div>
			
			<div class="span4 sidebar">
				<div class="sidebox">
					<h3 class="sidebox-title">Sample Sidebar Content</h3>
					<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s.</p> 
					<p>
						<a href="#" class="btn btn-primary">Read More</a>
					</p>
				</div>
			</div>
		</div>

		<div id="footerInnerSeparator"></div>
	</div>
</div>

<cfinclude template="footer.cfm" >
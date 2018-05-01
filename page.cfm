<cfset navItem = "page">

<cfinclude template="header.cfm" >

<div class="contentArea">
	<div class="divPanel notop page-content">
		<div class="row-fluid">
			<div class="span8">
				<div class="breadcrumbs">
					<a href="index.cfm">Home</a> &nbsp;/&nbsp; <span>Page</span>
				</div> 

				<h1>Page Components</h1>

				<div class="accordion" id="accordion2">
					<div class="accordion-group">
						<div class="accordion-heading">
							<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseOne">
							Collapsible Group Item #1
							</a>
						</div>
						<div id="collapseOne" class="accordion-body collapse in">
							<div class="accordion-inner">
								Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.
							</div>
						</div>
					</div>
	
					<div class="accordion-group">
						<div class="accordion-heading">
							<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseTwo">
							Collapsible Group Item #2
							</a>
						</div>
						<div id="collapseTwo" class="accordion-body collapse">
							<div class="accordion-inner">
								Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.
							</div>
						</div>
					</div>
		
					<div class="accordion-group">
						<div class="accordion-heading">
							<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseThree">
							Collapsible Group Item #3
							</a>
						</div>
						<div id="collapseThree" class="accordion-body collapse">
							<div class="accordion-inner">
								Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.
							</div>
						</div>
					</div>
				</div>

				<h2>Buttons</h2>
				<p>
					<a class="btn btn-large" href="#">Large button</a>
					<a class="btn" href="#">Default button</a>
					<a class="btn btn-small" href="#">Small button</a>
					<a class="btn btn-mini" href="#">Mini button</a>
				</p>
				<p>
					<a class="btn btn-primary" href="#">Primary</a>
					<a class="btn btn-secondary" href="#">Secondary</a>
					<a class="btn btn-info" href="#">Info</a>
					<a class="btn btn-success" href="#">Success</a>
					<a class="btn btn-warning" href="#">Warning</a>
					<a class="btn btn-danger" href="#">Danger</a>
					<a class="btn btn-inverse" href="#">Inverse</a>
				</p>
				
				<br />

				<h2>Form</h2>
				
				<form>
				
				<label>This is a label.</label>
				<input type="text" placeholder="Standard Input">
				
				<br /><br />
				
				<label class="checkbox">
				<input type="checkbox"> Check me out
				</label>
				
				<br />
				
				<input class="input-mini" type="text" placeholder=".input-mini">
				<input class="input-small" type="text" placeholder=".input-small">
				<input class="input-medium" type="text" placeholder=".input-medium">
				<input class="input-large" type="text" placeholder=".input-large">
				<input class="input-xlarge" type="text" placeholder=".input-xlarge">
				<input class="input-xxlarge" type="text" placeholder=".input-xxlarge">
				
				</form>

				<h2>Modal</h2>
				
				<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h3 id="myModalLabel">Modal Heading</h3>
					</div>
		
					<div class="modal-body">
						<h4>Text in a modal</h4>
						<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.</p>
					</div>

					<div class="modal-footer">
						<button class="btn" data-dismiss="modal">Close</button>
						<button class="btn btn-primary">Save changes</button>
					</div>	
				</div>
				
				<a data-toggle="modal" href="#myModal" class="btn btn-primary btn-large">Launch demo modal</a>
				
				<br /><br />

				<h2>Video</h2>
				
				<article class="flex-video">
					<iframe width="560" height="315" src="http://www.youtube.com/embed/e7OYeIXsW60"></iframe>
				</article>
				<br />
				
				<article class="flex-video">
					<iframe width="560" height="315" src="http://player.vimeo.com/video/2203727"></iframe>
				</article>
				<br />
		
			</div>

			<div class="span4">
				<div class="input-append">
					<input class="span9" id="appendedInputButton" size="16" type="text"><button class="btn" type="button">Go!</button>
				</div>

				<br />

				<h2>Quote / Testimonial</h2>
				<br />
				
				<blockquote>
					<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s.</p>
					<small>by Albert Einstein</small>
				</blockquote>

				<h1>H1</h1>
				<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry.</p>
				
				<h2>H2</h2>
				<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry.</p>
				
				<h3>H3</h3>
				<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry.</p>
				
				<h4>H4</h4>
				<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry.</p>
				
				<h5>H5</h5>
				<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry.</p>
				
				<h6>H6</h6>
				<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry.</p>
				
				<br />
				
				<h2>Unordered List</h2>
				<ul>
					<li>Lorem Ipsum is simply dummy text of the printing and typesetting industry.</li>
					<li>Lorem Ipsum is simply dummy text of the printing and typesetting industry.</li>
				</ul> 
				
				<h2>Ordered List</h2>
				<ol>
					<li>Lorem Ipsum is simply dummy text of the printing and typesetting industry.</li>
					<li>Lorem Ipsum is simply dummy text of the printing and typesetting industry.</li>
					<li>Lorem Ipsum is simply dummy text of the printing and typesetting industry.</li>
				</ol>
				
			</div>
		</div>

		<div id="footerInnerSeparator"></div>
	</div>
</div>

<cfinclude template="footer.cfm" >
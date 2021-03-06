<%@ page session="false" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.NetworkAnalysis.rsc.User" %>
<%@page import="java.util.Map.Entry"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!--
	Photon by HTML5 UP
	html5up.net | @n33co
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<head>

<title>Network Analysis</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />

<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
<link rel="stylesheet" href="assets/css/main.css" />
<script type="text/javascript"
	src="//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.7/angular.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<!--<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.1/jquery-ui.min.js"></script>-->
<!-- Scripts -->
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/jquery.scrolly.min.js"></script>
<script src="assets/js/skel.min.js"></script>
<script src="assets/js/util.js"></script>
<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
<script src="assets/js/main.js"></script>

<script src="magic.js" type="text/javascript"></script>
<!-- load our javascript file -->
<!--[if lte IE 8]><link rel="stylesheet" href="assets/css/ie8.css" /><![endif]-->
<!--[if lte IE 9]><link rel="stylesheet" href="assets/css/ie9.css" /><![endif]-->
<!-- code -->
<script type="text/javascript" src="js/twitter-login.js"></script>
</head>
<body>
<%

	HttpSession sessionUser = request.getSession(false);// don't create if it doesn't exist
	if(sessionUser != null && sessionUser.getAttribute("user")!=null) {//&& !sessionUser.isNew()
		User user = (User)sessionUser.getAttribute("user");
		if (user == null || user.getName()== null )
			response.sendRedirect("Login.jsp");			
%>
	<!-- Header -->
	<section id="header">
	<div class="inner">
		<span class="icon major fa-twitter"></span>
		<h1>
			Análisis de redes sociales <br />
		</h1>
		<p>Bienvenid@ <%=user.getName() + " " + user.getLastname() %></p>
		<br /> <br /> <br /> <br /> <br />
		<ul class="actions">
			<li><a href="#one" class="button scrolly">Búsquedas</a></li>
			<li><a href="#two" class="button scrolly">Historial</a></li>
			<li><a href="LogOutServlet" class="button scrolly">Salir</a></li>
		</ul>
	</div>
	</section>

	<!-- One -->
	<section id="one" class="main style1">
	<div class="container">
		<div class="row 150%">
			<div class="6u 12u$(medium)">
				<form action="${pageContext.request.contextPath}/SearchTweetsServlet" method="POST">					
					<header class="major">
					<h2>¿Que deseas buscar hoy?</h2>
					</header>
					Nombre de la búsqueda
					<input type="text" name="SearchName" placeholder="EleccionesUSA2016" required>									
					</br>
					Tipo de búsqueda
					<div class="12u$">
						<div class="select-wrapper">
							<select name="SearchType" id="SearchType">
								<option value="Stream">Stream</option>
								<option value="Search">Search</option>
							</select>
						</div>
					</div>
					</br>
					Palabra clave
					<br>
					 
					<input type="text" name="keywords" placeholder="Ejemplo: Facebook fb face ó Hillary,Trump" required>
					<h6>
						Escribe las palabras clave separadas por espacio (AND) o coma (OR).<br>						
					</h6>
					<br id="raro"> 
					 
					<input type="submit" value="Iniciar Búsqueda" id="StartSearch">
				</form>


			</div>
			<div class="6u$ 12u$(medium) important(medium)">
				<span class="image fit"><img src="images/pic01.jpg" alt="" /></span>
			</div>
		</div>
		
	</section>

	<!-- Two -->
	<section id="two" class="main style2">
	<div class="container">
	<input type="button" value="Mostrar Historial" id="showTable" />

		<div id="tablediv" class="table-wrapper">
		</br>
				<div class="row">
				<div class="6u 12u$(medium)"  >
					<input type="checkbox" id="cTweets" name="cTweets">
					<label for="cTweets" style="color:white">Tweets</label>
					
					<input type="checkbox" id="cNormalNodes" name="cNormalNodes" checked>
					<label for="cNormalNodes" style="color:white">Relaciones por Retweet/Mencionado/Contestado</label>
					
					<input type="checkbox" id="cHashtagNodes" name="cHashtagNodes" >
					<label for="cHashtagNodes" style="color:white">Relaciones por Hashtag</label>
				</div>
				<div class="6u 12u$(medium)" style="color:white">

					<input type="checkbox" id="cFavorito" name="cFavorito" onclick="showSelectNumber()" >
					<label for="cFavorito" style="color:white">+ Favorito</label>
					
					<input type="checkbox" id="cRetweeted" name="cRetweeted" onclick="showSelectNumber()" >
					<label for="cRetweeted" style="color:white">+ Retweeted</label>
					<div id="selectNumber">
						Límite de tweets
						<input type="text" id="txtNumber" name="txtNumber" style="background: white;color:black" required >
					</div>
				</div>
			</div>
			
			<table cellspacing="0" id="searchtable" >
				    
				<thead >
					<tr >					        
						<th scope="col" style="color:white">Nombre</th> 
						<th scope="col" style="color:white">Palabras</th> 					                
						<th scope="col" style="color:white">Inicio</th>         
						<th scope="col" style="color:white">Final</th>         
						<!-- <th scope="col" style="color:white">Última Actualización</th>  -->
						<th scope="col" style="color:white">#Tweets</th>        
						<th scope="col" style="color:white">Tipo</th>              
						<th scope="col" style="color:white">Buscando</th>  
						<th scope="col" style="color:white">Exportar</th>  
					</tr>
				</thead>
			</table>
		</div>
		<!--  
		<div class="row 150%">
			<div class="6u 12u$(medium)">
				<ul class="major-icons">
					<li><span class="icon style1 major fa-code"></span></li>
					<li><span class="icon style2 major fa-bolt"></span></li>
					<li><span class="icon style3 major fa-camera-retro"></span></li>
					<li><span class="icon style4 major fa-cog"></span></li>
					<li><span class="icon style5 major fa-desktop"></span></li>
					<li><span class="icon style6 major fa-calendar"></span></li>
				</ul>
			</div>
			<div class="6u$ 12u$(medium)">
				<header class="major">
				<h2>Buscar Chicos Malos</h2>
				</header>
				<form action="${pageContext.request.contextPath}/GetTheWords"
					method="POST">
					<header class="major">
					<h2>¿Que deseas buscar hoy?</h2>
					</header>

					<p>Selecciona la busqueda en el historial</p>
					Busqueda <br> <input type="text" name="tabla"> <br
						id="raro"> <br> <input type="submit" value="Submit">
				</form>
			</div>
		</div>
		-->
	</div>
	</section>

	<!-- Three -->
	<!-- 
	<section id="three" class="main style1 special">
	<div class="container">
		<header class="major">
		<h2>Reportes</h2>
		</header>
		<p>Ante nunc accumsan et aclacus nascetur ac ante amet sapien sed.</p>
		<div class="row 150%">
			<div class="4u 12u$(medium)">
				<span class="image fit"><img src="images/pic02.jpg" alt="" /></span>
				<h3>Magna feugiat lorem</h3>
				<p>Adipiscing a commodo ante nunc magna lorem et interdum mi
					ante nunc lobortis non amet vis sed volutpat et nascetur.</p>
				<ul class="actions">
					<li><a href="#" class="button">More</a></li>
				</ul>
			</div>
			<div class="4u 12u$(medium)">
				<span class="image fit"><img src="images/pic03.jpg" alt="" /></span>
				<h3>Magna feugiat lorem</h3>
				<p>Adipiscing a commodo ante nunc magna lorem et interdum mi
					ante nunc lobortis non amet vis sed volutpat et nascetur.</p>
				<ul class="actions">
					<li><a href="#" class="button">More</a></li>
				</ul>
			</div>
			<div class="4u$ 12u$(medium)">
				<span class="image fit"><img src="images/pic04.jpg" alt="" /></span>
				<h3>Magna feugiat lorem</h3>
				<p>Adipiscing a commodo ante nunc magna lorem et interdum mi
					ante nunc lobortis non amet vis sed volutpat et nascetur.</p>
				<ul class="actions">
					<li><a href="#" class="button">More</a></li>
				</ul>
			</div>
		</div>
	</div>
	</section>
 -->
	<!-- Four -->
	<!--  
	<section id="four" class="main style2 special">
	<div class="container">
		<header class="major">
		<h2>Ipsum feugiat consequat?</h2>
		</header>
		<p>Sed lacus nascetur ac ante amet sapien.</p>
		<ul class="actions uniform">
			<li><a href="#" class="button special">Sign Up</a></li>
			<li><a href="#" class="button">Learn More</a></li>
		</ul>
	</div>
	</section>

	<!-- Five -->
	<!--
			<section id="five" class="main style1">
				<div class="container">
					<header class="major special">
						<h2>Elements</h2>
					</header>

					<section>
						<h4>Text</h4>
						<p>This is <b>bold</b> and this is <strong>strong</strong>. This is <i>italic</i> and this is <em>emphasized</em>.
						This is <sup>superscript</sup> text and this is <sub>subscript</sub> text.
						This is <u>underlined</u> and this is code: <code>for (;;) { ... }</code>. Finally, <a href="#">this is a link</a>.</p>
						<hr />
						<header>
							<h4>Heading with a Subtitle</h4>
							<p>Lorem ipsum dolor sit amet nullam id egestas urna aliquam</p>
						</header>
						<p>Nunc lacinia ante nunc ac lobortis. Interdum adipiscing gravida odio porttitor sem non mi integer non faucibus ornare mi ut ante amet placerat aliquet. Volutpat eu sed ante lacinia sapien lorem accumsan varius montes viverra nibh in adipiscing blandit tempus accumsan.</p>
						<header>
							<h5>Heading with a Subtitle</h5>
							<p>Lorem ipsum dolor sit amet nullam id egestas urna aliquam</p>
						</header>
						<p>Nunc lacinia ante nunc ac lobortis. Interdum adipiscing gravida odio porttitor sem non mi integer non faucibus ornare mi ut ante amet placerat aliquet. Volutpat eu sed ante lacinia sapien lorem accumsan varius montes viverra nibh in adipiscing blandit tempus accumsan.</p>
						<hr />
						<h2>Heading Level 2</h2>
						<h3>Heading Level 3</h3>
						<h4>Heading Level 4</h4>
						<h5>Heading Level 5</h5>
						<h6>Heading Level 6</h6>
						<hr />
						<h5>Blockquote</h5>
						<blockquote>Fringilla nisl. Donec accumsan interdum nisi, quis tincidunt felis sagittis eget tempus euismod. Vestibulum ante ipsum primis in faucibus vestibulum. Blandit adipiscing eu felis iaculis volutpat ac adipiscing accumsan faucibus. Vestibulum ante ipsum primis in faucibus lorem ipsum dolor sit amet nullam adipiscing eu felis.</blockquote>
						<h5>Preformatted</h5>
						<pre><code>i = 0;

while (!deck.isInOrder()) {
print 'Iteration ' + i;
deck.shuffle();
i++;
}

print 'It took ' + i + ' iterations to sort the deck.';</code></pre>
					</section>

					<section>
						<h4>Lists</h4>
						<div class="row">
							<div class="6u 12u$(medium)">
								<h5>Unordered</h5>
								<ul>
									<li>Dolor pulvinar etiam.</li>
									<li>Sagittis adipiscing.</li>
									<li>Felis enim feugiat.</li>
								</ul>
								<h5>Alternate</h5>
								<ul class="alt">
									<li>Dolor pulvinar etiam.</li>
									<li>Sagittis adipiscing.</li>
									<li>Felis enim feugiat.</li>
								</ul>
							</div>
							<div class="6u$ 12u$(medium)">
								<h5>Ordered</h5>
								<ol>
									<li>Dolor pulvinar etiam.</li>
									<li>Etiam vel felis viverra.</li>
									<li>Felis enim feugiat.</li>
									<li>Dolor pulvinar etiam.</li>
									<li>Etiam vel felis lorem.</li>
									<li>Felis enim et feugiat.</li>
								</ol>
								<h5>Icons</h5>
								<ul class="icons">
									<li><a href="#" class="icon fa-twitter"><span class="label">Twitter</span></a></li>
									<li><a href="#" class="icon fa-facebook"><span class="label">Facebook</span></a></li>
									<li><a href="#" class="icon fa-instagram"><span class="label">Instagram</span></a></li>
									<li><a href="#" class="icon fa-github"><span class="label">Github</span></a></li>
								</ul>
							</div>
						</div>
						<h5>Actions</h5>
						<div class="row">
							<div class="6u 12u$(medium)">
								<ul class="actions">
									<li><a href="#" class="button special">Default</a></li>
									<li><a href="#" class="button">Default</a></li>
								</ul>
								<ul class="actions small">
									<li><a href="#" class="button special small">Small</a></li>
									<li><a href="#" class="button small">Small</a></li>
								</ul>
								<ul class="actions vertical">
									<li><a href="#" class="button special">Default</a></li>
									<li><a href="#" class="button">Default</a></li>
								</ul>
								<ul class="actions vertical small">
									<li><a href="#" class="button special small">Small</a></li>
									<li><a href="#" class="button small">Small</a></li>
								</ul>
							</div>
							<div class="6u 12u$(medium)">
								<ul class="actions vertical">
									<li><a href="#" class="button special fit">Default</a></li>
									<li><a href="#" class="button fit">Default</a></li>
								</ul>
								<ul class="actions vertical small">
									<li><a href="#" class="button special small fit">Small</a></li>
									<li><a href="#" class="button small fit">Small</a></li>
								</ul>
							</div>
						</div>
					</section>
--><!--  
					<section>
						<h4>Table</h4>
						<h5>Default</h5>
						<div class="table-wrapper">
							<table>
								<thead>
									<tr>
										<th>Name</th>
										<th>Description</th>
										<th>Price</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>Item One</td>
										<td>Ante turpis integer aliquet porttitor.</td>
										<td>29.99</td>
									</tr>
									<tr>
										<td>Item Two</td>
										<td>Vis ac commodo adipiscing arcu aliquet.</td>
										<td>19.99</td>
									</tr>
									<tr>
										<td>Item Three</td>
										<td> Morbi faucibus arcu accumsan lorem.</td>
										<td>29.99</td>
									</tr>
									<tr>
										<td>Item Four</td>
										<td>Vitae integer tempus condimentum.</td>
										<td>19.99</td>
									</tr>
									<tr>
										<td>Item Five</td>
										<td>Ante turpis integer aliquet porttitor.</td>
										<td>29.99</td>
									</tr>
								</tbody>
								<tfoot>
									<tr>
										<td colspan="2"></td>
										<td>100.00</td>
									</tr>
								</tfoot>
							</table>
						</div>

						<h5>Alternate</h5>
						<div class="table-wrapper">
							<table class="alt">
								<thead>
									<tr>
										<th>Name</th>
										<th>Description</th>
										<th>Price</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>Item One</td>
										<td>Ante turpis integer aliquet porttitor.</td>
										<td>29.99</td>
									</tr>
									<tr>
										<td>Item Two</td>
										<td>Vis ac commodo adipiscing arcu aliquet.</td>
										<td>19.99</td>
									</tr>
									<tr>
										<td>Item Three</td>
										<td> Morbi faucibus arcu accumsan lorem.</td>
										<td>29.99</td>
									</tr>
									<tr>
										<td>Item Four</td>
										<td>Vitae integer tempus condimentum.</td>
										<td>19.99</td>
									</tr>
									<tr>
										<td>Item Five</td>
										<td>Ante turpis integer aliquet porttitor.</td>
										<td>29.99</td>
									</tr>
								</tbody>
								<tfoot>
									<tr>
										<td colspan="2"></td>
										<td>100.00</td>
									</tr>
								</tfoot>
							</table>
						</div>
					</section>
--><!--  
					<section>
						<h4>Buttons</h4>
						<ul class="actions">
							<li><a href="#" class="button special">Special</a></li>
							<li><a href="#" class="button">Default</a></li>
						</ul>
						<ul class="actions">
							<li><a href="#" class="button big">Big</a></li>
							<li><a href="#" class="button">Default</a></li>
							<li><a href="#" class="button small">Small</a></li>
						</ul>
						<ul class="actions fit">
							<li><a href="#" class="button fit">Fit</a></li>
							<li><a href="#" class="button special fit">Fit</a></li>
							<li><a href="#" class="button fit">Fit</a></li>
						</ul>
						<ul class="actions fit small">
							<li><a href="#" class="button special fit small">Fit + Small</a></li>
							<li><a href="#" class="button fit small">Fit + Small</a></li>
							<li><a href="#" class="button special fit small">Fit + Small</a></li>
						</ul>
						<ul class="actions">
							<li><a href="#" class="button special icon fa-download">Icon</a></li>
							<li><a href="#" class="button icon fa-download">Icon</a></li>
						</ul>
						<ul class="actions">
							<li><span class="button special disabled">Disabled</span></li>
							<li><span class="button disabled">Disabled</span></li>
						</ul>
					</section>

					<section>
						<h4>Form</h4>
						<form method="post" action="#">
							<div class="row uniform 50%">
								<div class="6u 12u$(xsmall)">
									<input type="text" name="demo-name" id="demo-name" value="" placeholder="Name" />
								</div>
								<div class="6u$ 12u$(xsmall)">
									<input type="email" name="demo-email" id="demo-email" value="" placeholder="Email" />
								</div>
								<div class="12u$">
									<div class="select-wrapper">
										<select name="demo-category" id="demo-category">
											<option value="">- Category -</option>
											<option value="1">Manufacturing</option>
											<option value="1">Shipping</option>
											<option value="1">Administration</option>
											<option value="1">Human Resources</option>
										</select>
									</div>
								</div>
								<div class="4u 12u$(small)">
									<input type="radio" id="demo-priority-low" name="demo-priority" checked>
									<label for="demo-priority-low">Low</label>
								</div>
								<div class="4u 12u$(small)">
									<input type="radio" id="demo-priority-normal" name="demo-priority">
									<label for="demo-priority-normal">Normal</label>
								</div>
								<div class="4u$ 12u$(small)">
									<input type="radio" id="demo-priority-high" name="demo-priority">
									<label for="demo-priority-high">High</label>
								</div>
								<div class="6u 12u$(small)">
									<input type="checkbox" id="demo-copy" name="demo-copy">
									<label for="demo-copy">Email me a copy</label>
								</div>
								<div class="6u$ 12u$(small)">
									<input type="checkbox" id="demo-human" name="demo-human" checked>
									<label for="demo-human">Not a robot</label>
								</div>
								<div class="12u$">
									<textarea name="demo-message" id="demo-message" placeholder="Enter your message" rows="6"></textarea>
								</div>
								<div class="12u$">
									<ul class="actions">
										<li><input type="submit" value="Send Message" class="special" /></li>
										<li><input type="reset" value="Reset" /></li>
									</ul>
								</div>
							</div>
						</form>
					</section>

					<section>
						<h4>Image</h4>
						<h5>Fit</h5>
						<div class="box alt">
							<div class="row uniform 50%">
								<div class="12u"><span class="image fit"><img src="images/pic06.jpg" alt="" /></span></div>
								<div class="4u"><span class="image fit"><img src="images/pic02.jpg" alt="" /></span></div>
								<div class="4u"><span class="image fit"><img src="images/pic03.jpg" alt="" /></span></div>
								<div class="4u"><span class="image fit"><img src="images/pic04.jpg" alt="" /></span></div>
								<div class="4u"><span class="image fit"><img src="images/pic03.jpg" alt="" /></span></div>
								<div class="4u"><span class="image fit"><img src="images/pic04.jpg" alt="" /></span></div>
								<div class="4u"><span class="image fit"><img src="images/pic02.jpg" alt="" /></span></div>
								<div class="4u"><span class="image fit"><img src="images/pic04.jpg" alt="" /></span></div>
								<div class="4u"><span class="image fit"><img src="images/pic02.jpg" alt="" /></span></div>
								<div class="4u"><span class="image fit"><img src="images/pic03.jpg" alt="" /></span></div>
							</div>
						</div>
						<h5>Left &amp; Right</h5>
						<p><span class="image left"><img src="images/pic05.jpg" alt="" /></span>Fringilla nisl. Donec accumsan interdum nisi, quis tincidunt felis sagittis eget. tempus euismod. Vestibulum ante ipsum primis in faucibus vestibulum. Blandit adipiscing eu felis iaculis volutpat ac adipiscing accumsan eu faucibus. Integer ac pellentesque praesent tincidunt felis sagittis eget. tempus euismod. Vestibulum ante ipsum primis in faucibus vestibulum. Blandit adipiscing eu felis iaculis volutpat ac adipiscing accumsan eu faucibus. Integer ac pellentesque praesent. Donec accumsan interdum nisi, quis tincidunt felis sagittis eget. tempus euismod. Vestibulum ante ipsum primis in faucibus vestibulum. Blandit adipiscing eu felis iaculis volutpat ac adipiscing accumsan eu faucibus. Integer ac pellentesque praesent tincidunt felis sagittis eget. tempus euismod. Vestibulum ante ipsum primis in faucibus vestibulum. Blandit adipiscing eu felis iaculis volutpat ac adipiscing accumsan eu faucibus. Integer ac pellentesque praesent. Blandit adipiscing eu felis iaculis volutpat ac adipiscing accumsan eu faucibus. Integer ac pellentesque praesent tincidunt felis sagittis eget. tempus euismod. Vestibulum ante ipsum primis in faucibus vestibulum. Blandit adipiscing eu felis iaculis volutpat ac adipiscing accumsan eu faucibus. Integer ac pellentesque praesent.</p>
						<p><span class="image right"><img src="images/pic05.jpg" alt="" /></span>Fringilla nisl. Donec accumsan interdum nisi, quis tincidunt felis sagittis eget. tempus euismod. Vestibulum ante ipsum primis in faucibus vestibulum. Blandit adipiscing eu felis iaculis volutpat ac adipiscing accumsan eu faucibus. Integer ac pellentesque praesent tincidunt felis sagittis eget. tempus euismod. Vestibulum ante ipsum primis in faucibus vestibulum. Blandit adipiscing eu felis iaculis volutpat ac adipiscing accumsan eu faucibus. Integer ac pellentesque praesent. Donec accumsan interdum nisi, quis tincidunt felis sagittis eget. tempus euismod. Vestibulum ante ipsum primis in faucibus vestibulum. Blandit adipiscing eu felis iaculis volutpat ac adipiscing accumsan eu faucibus. Integer ac pellentesque praesent tincidunt felis sagittis eget. tempus euismod. Vestibulum ante ipsum primis in faucibus vestibulum. Blandit adipiscing eu felis iaculis volutpat ac adipiscing accumsan eu faucibus. Integer ac pellentesque praesent. Blandit adipiscing eu felis iaculis volutpat ac adipiscing accumsan eu faucibus. Integer ac pellentesque praesent tincidunt felis sagittis eget. tempus euismod. Vestibulum ante ipsum primis in faucibus vestibulum. Blandit adipiscing eu felis iaculis volutpat ac adipiscing accumsan eu faucibus. Integer ac pellentesque praesent.</p>
					</section>

				</div>
			</section>
		-->

	<!-- Footer -->
	<section id="footer">
	<ul class="icons">
		<!--  <li><a href="#" class="icon alt fa-twitter"><span
				class="label">Twitter</span></a></li>
		<li><a href="#" class="icon alt fa-facebook"><span
				class="label">Facebook</span></a></li>
		<li><a href="#" class="icon alt fa-instagram"><span
				class="label">Instagram</span></a></li>-->
		<li><a href="https://github.com/xmaryposax/NetworkAnalysis" class="icon alt fa-github"><span
				class="label">GitHub</span></a></li>
		<!-- 
		<li><a href="#" class="icon alt fa-envelope"><span
				class="label">Email</span></a></li> -->
	</ul>
	<ul class="copyright">
		<li>&copy; ITESO</li>
		<!-- <li>Design: <a href="http://html5up.net">HTML5 UP</a></li> -->
	</ul>
	</section>
	<%} 
	else {
	    response.sendRedirect("Login.jsp");
	} 
	%>
</body>
</html>
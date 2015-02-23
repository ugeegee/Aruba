<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<title>Aruba</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/font-awesome.min.css" rel="stylesheet">
<link href="css/prettyPhoto.css" rel="stylesheet">
<link href="css/animate.css" rel="stylesheet">
<link href="css/main.css" rel="stylesheet">
<!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
<link rel="shortcut icon" href="images/ico/favicon.ico">
<link rel="apple-touch-icon-precomposed" sizes="144x144"
	href="images/ico/apple-touch-icon-144-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="114x114"
	href="images/ico/apple-touch-icon-114-precomposed.png">
<link rel="apple-touch-icon-precomposed" sizes="72x72"
	href="images/ico/apple-touch-icon-72-precomposed.png">
<link rel="apple-touch-icon-precomposed"
	href="images/ico/apple-touch-icon-57-precomposed.png">
</head>
<body>
	<header class="navbar navbar-inverse navbar-fixed-top wet-asphalt"
		role="banner">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="index.html"><img
					src="images/logo.png" alt="logo"></a>
			</div>
			<div class="collapse navbar-collapse">
				<ul class="nav navbar-nav navbar-right">


					<li><a class="active" class="active"
						href="<%=request.getContextPath()%>/index">Home</a></li>

					<!-- 비로그인 경우 -->
					<c:if test="${empty addUser }">

						<!-- 로그인 버튼 -->
						<c:url value="/login" var="url"></c:url>
						<li><a href="${url }">Log In</a></li>

						<!-- 회원가입 버튼 -->
						<c:url value="/join" var="url"></c:url>
						<li><a href="${url }">Sign Up</a></li>

					</c:if>


					<!-- 로그인 경우 -->
					<c:if test="${!empty addUser }">
						<!-- MY PAGE 버튼 -->
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown">My Page <i class="icon-angle-down"></i></a>
							<ul class="dropdown-menu">
								<li><a href="<%=request.getContextPath()%>/myInfo">Modify Account</a></li>
								<li><a href="<%=request.getContextPath()%>/modifyPass">Change Password</a></li>
								<li><a href="<%=request.getContextPath()%>/leaveAruba">Delete Account</a></li>
							</ul>
						</li>

						<!-- 사장인 경우 -->
						<c:if test="${addUser.grade=='사장' }">
							<!-- 로그아웃 버튼 -->
							<c:url value="/logout" var="url" />
							<li><a href="${url }">Log Out</a></li>

							<!-- MY PAGE 버튼 -->
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown">My Store <i class="icon-angle-down"></i></a>
								<ul class="dropdown-menu">
									<li><a href="<%=request.getContextPath()%>/myCompany">Store Control</a></li>
									<li><a href="<%=request.getContextPath()%>/staff">Staff Control</a></li>
									<li><a href="<%=request.getContextPath()%>/wage">Wage Control</a></li>
									<li><a href="<%=request.getContextPath()%>/alert_employer">Alert</a></li>
								</ul>
							</li>

							<!-- 근무표 버튼 -->
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown">Shift Table <i class="icon-angle-down"></i></a>
								<ul class="dropdown-menu">
									<li><a href="<%=request.getContextPath()%>/registerSchedule">Register Shift</a></li>
									<li><a href="<%=request.getContextPath()%>/modifySchedule">Modify Shift</a></li>
									<li><a href="<%=request.getContextPath()%>/allSchedule">Show Shift</a></li>
								</ul>
							</li>
						</c:if>

						<!-- 직원인 경우 -->
						<c:if test="${addUser.grade=='직원' }">
							<!-- 로그아웃 버튼 -->
							<c:url value="/logout" var="url" />
							<li><a href="${url }">Log Out</a></li>

							<!-- MY PAGE 버튼 -->
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown">My Job <i class="icon-angle-down"></i></a>
								<ul class="dropdown-menu">
									<li><a href="<%=request.getContextPath()%>/myJob">My Job</a></li>
									<li><a href="<%=request.getContextPath()%>/salary">My Wage</a></li>
									<li><a href="<%=request.getContextPath()%>/alert_employee">Alert</a></li>
								</ul></li>

							<!-- 근무표 버튼 -->
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown">Shift Table <i class="icon-angle-down"></i></a>
								<ul class="dropdown-menu">
									<c:url value="/mySchedule" var="url" />
									<li><a href="${url }">My Shift</a></li>
								</ul>
							</li>
						</c:if>

						<!-- 게시판 버튼 -->
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown">Board <i class="icon-angle-down"></i></a>
							<ul class="dropdown-menu">
								<li><a href="<%=request.getContextPath()%>/notice">Notice
										Board</a></li>
								<li><a href="<%=request.getContextPath()%>/free">Free
										Board</a></li>
								<li><a href="<%=request.getContextPath()%>/qna">Q&A
										Board</a></li>
							</ul></li>
					</c:if>


					<c:url value="/contact" var="url"></c:url>
					<li><a href="${url }">Contact</a></li>
				</ul>
			</div>
		</div>
	</header>
	<!--/header-->
	<section id="main-slider" class="no-margin">
		<div class="carousel slide wet-asphalt">
			<ol class="carousel-indicators">
				<li data-target="#main-slider" data-slide-to="0" class="active"></li>
				<li data-target="#main-slider" data-slide-to="1"></li>
				<li data-target="#main-slider" data-slide-to="2"></li>
			</ol>
			<div class="carousel-inner">
				<div class="item active"
					style="background-image: url(images/slider/bg1.jpg)">
					<div class="container">
						<div class="row">
							<div class="col-sm-12">
								<div class="carousel-content centered">
									<h1 class="animation animated-item-1">Convenient and Easy Shift Table</h1>
									<h4 class="animation animated-item-2">
									We manage high quality of shift table when you provide shifts to your employees. 
									You can register/log-in and enjoy our service.
									</h4>
										
									<br> <a class="btn btn-md animation animated-item-3"
										href="<%=request.getContextPath()%>/join">Sign Up</a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!--/.item-->
				<div class="item"
					style="background-image: url(images/slider/bg2.jpg)">
					<div class="container">
						<div class="row">
							<div class="col-sm-12">
								<div class="carousel-content center centered">
									<h1 class="boxed animation animated-item-1">Easy Catched-up Wage Chart with Visual Effects</h1>
									<h4 class="boxed animation animated-item-2">It helps you visualize monthly staffs' wage on illustrated charts and graphs at a glance.</h4>
									<br><br><a class="btn btn-md animation animated-item-3"
										href="<%=request.getContextPath()%>/join">Sign Up</a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!--/.item-->
				<div class="item"
					style="background-image: url(images/slider/bg3.jpg)">
					<div class="container">
						<div class="row">
							<div class="col-sm-6">
								<div class="carousel-content centered">
									<h1 class="boxed animation animated-item-1">Communication via Aruba</h1>
									<h4 class="boxed animation animated-item-2">Share information and your difficulties with others by posting and commenting.</h4>
									<br> <a class="btn btn-md animation animated-item-3"
										href="<%=request.getContextPath()%>/join">Sign Up</a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!--/.item-->
			</div>
			<!--/.carousel-inner-->
		</div>
		<!--/.carousel-->
		<a class="prev hidden-xs" href="#main-slider" data-slide="prev"> <i
			class="icon-angle-left"></i>
		</a> <a class="next hidden-xs" href="#main-slider" data-slide="next">
			<i class="icon-angle-right"></i>
		</a>
	</section>
	<!--/#main-slider-->

	<section id="services" class="emerald">
		<div class="container">
			<div class="row">
				<div class="col-md-4 col-sm-6">
					<div class="media">
						<div class="pull-left">
							<i class="icon-user icon-md"></i>
						</div>
						<div class="media-body">
							<h3 class="media-heading">My Store and Job</h3>
							<p>Pellentesque habitant morbi tristique senectus et netus et
								malesuada fames ac turpis egestas. Vestibulum tortor quam,
								feugiat vitae.</p>
						</div>
					</div>
				</div>
				<!--/.col-md-4-->
				<div class="col-md-4 col-sm-6">
					<div class="media">
						<div class="pull-left">
							<i class="icon-calendar icon-md"></i>
						</div>
						<div class="media-body">
							<h3 class="media-heading">Shift Table</h3>
							<p>Pellentesque habitant morbi tristique senectus et netus et
								malesuada fames ac turpis egestas. Vestibulum tortor quam,
								feugiat vitae.</p>
						</div>
					</div>
				</div>
				<!--/.col-md-4-->
				<div class="col-md-4 col-sm-6">
					<div class="media">
						<div class="pull-left">
							<i class="icon-edit-sign icon-md"></i>
						</div>
						<div class="media-body">
							<h3 class="media-heading">Board</h3>
							<p>Pellentesque habitant morbi tristique senectus et netus et
								malesuada fames ac turpis egestas. Vestibulum tortor quam,
								feugiat vitae.</p>
						</div>
					</div>
				</div>
				<!--/.col-md-4-->
			</div>
		</div>
	</section>
	<!--/#services-->

	<section id="recent-works">
		<div class="container">
			<div class="row">
				<div class="col-md-3">
					<h3>Our Latest Project</h3>
					<p>Pellentesque habitant morbi tristique senectus et netus et
						malesuada fames ac turpis egestas.</p>
					<div class="btn-group">
						<a class="btn btn-danger" href="#scroller" data-slide="prev"><i
							class="icon-angle-left"></i></a> <a class="btn btn-danger"
							href="#scroller" data-slide="next"><i
							class="icon-angle-right"></i></a>
					</div>
					<p class="gap"></p>
				</div>
				<div class="col-md-9">
					<div id="scroller" class="carousel slide">
						<div class="carousel-inner">
							<div class="item active">
								<div class="row">
									<div class="col-xs-4">
										<div class="portfolio-item">
											<div class="item-inner">
												<img class="img-responsive"
													src="images/portfolio/recent/item1.png" alt="">
												<h5>Nova - Corporate site template</h5>
												<div class="overlay">
													<a class="preview btn btn-danger"
														title="Malesuada fames ac turpis egestas"
														href="images/portfolio/full/item1.jpg" rel="prettyPhoto"><i
														class="icon-eye-open"></i></a>
												</div>
											</div>
										</div>
									</div>
									<div class="col-xs-4">
										<div class="portfolio-item">
											<div class="item-inner">
												<img class="img-responsive"
													src="images/portfolio/recent/item3.png" alt="">
												<h5>Fornax - Apps site template</h5>
												<div class="overlay">
													<a class="preview btn btn-danger"
														title="Malesuada fames ac turpis egestas"
														href="images/portfolio/full/item1.jpg" rel="prettyPhoto"><i
														class="icon-eye-open"></i></a>
												</div>
											</div>
										</div>
									</div>
									<div class="col-xs-4">
										<div class="portfolio-item">
											<div class="item-inner">
												<img class="img-responsive"
													src="images/portfolio/recent/item2.png" alt="">
												<h5>Flat Theme - Business Theme</h5>
												<div class="overlay">
													<a class="preview btn btn-danger"
														title="Malesuada fames ac turpis egestas"
														href="images/portfolio/full/item1.jpg" rel="prettyPhoto"><i
														class="icon-eye-open"></i></a>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!--/.row-->
							</div>
							<!--/.item-->
							<div class="item">
								<div class="row">
									<div class="col-xs-4">
										<div class="portfolio-item">
											<div class="item-inner">
												<img class="img-responsive"
													src="images/portfolio/recent/item2.png" alt="">
												<h5>Flat Theme - Business Theme</h5>
												<div class="overlay">
													<a class="preview btn btn-danger"
														title="Malesuada fames ac turpis egestas"
														href="images/portfolio/full/item1.jpg" rel="prettyPhoto"><i
														class="icon-eye-open"></i></a>
												</div>
											</div>
										</div>
									</div>
									<div class="col-xs-4">
										<div class="portfolio-item">
											<div class="item-inner">
												<img class="img-responsive"
													src="images/portfolio/recent/item1.png" alt="">
												<h5>Nova - Corporate site template</h5>
												<div class="overlay">
													<a class="preview btn btn-danger"
														title="Malesuada fames ac turpis egestas"
														href="images/portfolio/full/item1.jpg" rel="prettyPhoto"><i
														class="icon-eye-open"></i></a>
												</div>
											</div>
										</div>
									</div>
									<div class="col-xs-4">
										<div class="portfolio-item">
											<div class="item-inner">
												<img class="img-responsive"
													src="images/portfolio/recent/item3.png" alt="">
												<h5>Fornax - Apps site template</h5>
												<div class="overlay">
													<a class="preview btn btn-danger"
														title="Malesuada fames ac turpis egestas"
														href="images/portfolio/full/item1.jpg" rel="prettyPhoto"><i
														class="icon-eye-open"></i></a>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!--/.item-->
						</div>
					</div>
				</div>
			</div>
			<!--/.row-->
		</div>
	</section>
	<!--/#recent-works-->

	<section id="testimonial" class="alizarin">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="center">
						<h2>What our clients say</h2>
						<p>Pellentesque habitant morbi tristique senectus et netus et
							malesuada fames ac turpis egestas.</p>
					</div>
					<div class="gap"></div>
					<div class="row">
						<div class="col-md-6">
							<blockquote>
								<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
									Integer posuere erat a ante.</p>
								<small>Someone famous in <cite title="Source Title">Source
										Title</cite></small>
							</blockquote>
							<blockquote>
								<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
									Integer posuere erat a ante.</p>
								<small>Someone famous in <cite title="Source Title">Source
										Title</cite></small>
							</blockquote>
						</div>
						<div class="col-md-6">
							<blockquote>
								<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
									Integer posuere erat a ante.</p>
								<small>Someone famous in <cite title="Source Title">Source
										Title</cite></small>
							</blockquote>
							<blockquote>
								<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.
									Integer posuere erat a ante.</p>
								<small>Someone famous in <cite title="Source Title">Source
										Title</cite></small>
							</blockquote>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--/#testimonial-->

	<section id="bottom" class="wet-asphalt">
		<div class="container">
			<div class="row">
				<div class="col-md-3 col-sm-6">
					<h4>About Us</h4>
					<p>Pellentesque habitant morbi tristique senectus et netus et
						malesuada fames ac turpis egestas. Vestibulum tortor quam, feugiat
						vitae, ultricies eget, tempor sit amet, ante.</p>
					<p>Pellentesque habitant morbi tristique senectus.</p>
				</div>
				<!--/.col-md-3-->

				<div class="col-md-3 col-sm-6">
					<h4>Company</h4>
					<div>
						<ul class="arrow">
							<li><a href="#">Company Overview</a></li>
							<li><a href="#">Meet The Team</a></li>
							<li><a href="#">Our Awesome Partners</a></li>
							<li><a href="#">Our Services</a></li>
							<li><a href="#">Frequently Asked Questions</a></li>
							<li><a href="#">Conatct Us</a></li>
							<li><a href="#">Privacy Policy</a></li>
							<li><a href="#">Terms of Use</a></li>
							<li><a href="#">Copyright</a></li>
						</ul>
					</div>
				</div>
				<!--/.col-md-3-->

				<div class="col-md-3 col-sm-6">
					<h4>Latest Blog</h4>
					<div>
						<div class="media">
							<div class="pull-left">
								<img src="images/blog/thumb1.jpg" alt="">
							</div>
							<div class="media-body">
								<span class="media-heading"><a href="#">Pellentesque
										habitant morbi tristique senectus</a></span> <small class="muted">Posted
									17 Aug 2013</small>
							</div>
						</div>
						<div class="media">
							<div class="pull-left">
								<img src="images/blog/thumb2.jpg" alt="">
							</div>
							<div class="media-body">
								<span class="media-heading"><a href="#">Pellentesque
										habitant morbi tristique senectus</a></span> <small class="muted">Posted
									13 Sep 2013</small>
							</div>
						</div>
						<div class="media">
							<div class="pull-left">
								<img src="images/blog/thumb3.jpg" alt="">
							</div>
							<div class="media-body">
								<span class="media-heading"><a href="#">Pellentesque
										habitant morbi tristique senectus</a></span> <small class="muted">Posted
									11 Jul 2013</small>
							</div>
						</div>
					</div>
				</div>
				<!--/.col-md-3-->

				<div class="col-md-3 col-sm-6">
					<h4>Address</h4>
					<address>
						<strong>Twitter, Inc.</strong><br> 795 Folsom Ave, Suite 600<br>
						San Francisco, CA 94107<br> <abbr title="Phone">P:</abbr>
						(123) 456-7890
					</address>
					<h4>Newsletter</h4>
					<form role="form">
						<div class="input-group">
							<input type="text" class="form-control" autocomplete="off"
								placeholder="Enter your email"> <span
								class="input-group-btn">
								<button class="btn btn-danger" type="button">Go!</button>
							</span>
						</div>
					</form>
				</div>
				<!--/.col-md-3-->
			</div>
		</div>
	</section>
	<!--/#bottom-->

	<footer id="footer" class="midnight-blue">
		<div class="container">
			<div class="row">
				<div class="col-sm-6">
					&copy; 2015 <a target="_blank" href="#">MALSIKIZIMARAZO</a>
				</div>
				<div class="col-sm-6">
					<ul class="pull-right">
						<li><a href="#">Home</a></li>
						<li><a href="#">About Us</a></li>
						<li><a href="#">Contact Us</a></li>
						<li><a id="gototop" class="gototop" href="#"><i
								class="icon-chevron-up"></i></a></li>
						<!--#gototop-->
					</ul>
				</div>
			</div>
		</div>
	</footer>
	<!--/#footer-->

	<script src="js/jquery.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.prettyPhoto.js"></script>
	<script src="js/main.js"></script>
</body>
</html>

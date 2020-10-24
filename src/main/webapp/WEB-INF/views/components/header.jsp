<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>


    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Pom  Retain</title>
        <link rel="icon" type="image/x-icon" href="assets/img/favicon.ico" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v5.13.0/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Varela+Round" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="static/css/style1.css" rel="stylesheet" />
        
    
        
        
        
    </head>
    
    
    <%--   <c:choose>
            <c:when test="${empty loggedInuser}">
              <!-- <div class="login"><a href="login"><span class="hidden-xs">Log In</span></a></div>
              <div class="login"><a href="signup"><span class="hidden-xs">Register</span></a></div> -->
            </c:when>
            <c:otherwise>
            
             <c:if test="${fn:contains(role, 'ADMIN')}">
            <c:if test="${role eq 'ADMIN' || role eq 'DBA'}">
              <div class="login"><a href="admin"><span class="hidden-xs">admin</span></a></div>
            </c:if>
              <div class="myaccount"><a title="My Account" href="profile"><span class="hidden-xs">My Account</span></a></div>
              <div class="myaccount"><a title="My Account" href="logout"><span class="hidden-xs">Logout</span></a></div>
            </c:otherwise>
            </c:choose> --%>
            
    <body id="page-top">
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
            <div class="container">
                <a class="navbar-brand js-scroll-trigger" href="#page-top"></a>
                <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    Menu
                    <i class="fas fa-bars"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="home">Home</a></li>
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="about">About</a></li>
                        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="contact">Contact</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        
        <header class="masthead">
            <div class="container d-flex h-100 align-items-center">
                <div class="mx-auto text-center">
                    <h1 class="mx-auto my-0 text-uppercase">Pom Retain</h1>
                    <a class="btn btn-primary js-scroll-trigger" href="signup">Get Started</a>
                </div>
            </div>
        </header>
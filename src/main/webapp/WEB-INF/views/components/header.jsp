<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

 <header>
    <div class="header-container">
      <div class="header-top">
        <div class="container">
          <div class="row"> 
            <!-- Header Language -->
            <div class="col-xs-7 col-sm-6">
              <div class="dropdown block-language-wrapper hidden-xs"> <a role="button" data-toggle="dropdown" data-target="#" class="block-language dropdown-toggle" href="#"> <img src="static/images/english.png" alt="language"> English <span class="caret"></span> </a>
                <ul class="dropdown-menu" role="menu">
                  <li role="presentation"><a role="menuitem" tabindex="-1" href="#"><img src="static/images/english.png" alt="language"> English </a></li>
                  <li role="presentation"><a role="menuitem" tabindex="-1" href="#"><img src="static/images/francais.png" alt="language"> French </a></li>
                  <li role="presentation"><a role="menuitem" tabindex="-1" href="#"><img src="static/images/german.png" alt="language"> German </a></li>
                </ul>
              </div>
              <!-- End Header Language --> 
              
              <!-- Header Currency -->
              <div class="dropdown block-currency-wrapper hidden-xs"> <a role="button" data-toggle="dropdown" data-target="#" class="block-currency dropdown-toggle" href="#"> USD <span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li role="presentation"><a role="menuitem" tabindex="-1" href="#"> $ - Dollar </a></li>
                  <li role="presentation"><a role="menuitem" tabindex="-1" href="#"> £ - Pound </a></li>
                  <li role="presentation"><a role="menuitem" tabindex="-1" href="#"> € - Euro </a></li>
                </ul>
              </div>
              <!-- End Header Currency -->
              
              <div class="welcome-msg hidden-xs"> Default welcome msg! </div>
            </div>
            <div class="col-xs-5 col-sm-6"> 
              
              <div class="top-cart-contain pull-right"> 
            <!-- Top Cart -->
            <div class="mini-cart">
              <div data-toggle="dropdown" data-hover="dropdown" class="basket dropdown-toggle"><a href="#">  My Cart <span class="cart_count">2</span></a></div>
              <div>
                <div class="top-cart-content" style="display: none;">
                  <div class="actions">
                    <button class="btn-checkout" title="Checkout" type="button"><span>Checkout</span></button>
                    <a href="#" class="view-cart" ><span>View Cart</span></a> </div>
                  <!--block-subtitle-->
                  <ul class="mini-products-list" id="cart-sidebar">
                    <li class="item first">
                      <div class="item-inner"><a class="product-image" title="timi &amp; leslie Sophia Diaper Bag, Lemon Yellow/Shadow White" href="#l"><img alt="timi &amp; leslie Sophia Diaper Bag, Lemon Yellow/Shadow White" src="products-images/p4.jpg"></a>
                        <div class="product-details">
                          <div class="access"><a class="btn-remove1" title="Remove This Item" href="#">Remove</a> <a class="btn-edit" title="Edit item" href="#"><i class="icon-pencil"></i><span class="hidden">Edit item</span></a> </div>
                          <!--access--> <strong>1</strong> x <span class="price">$179.99</span>
                          <p class="product-name"><a href="#">timi &amp; leslie Sophia Diaper Bag...</a></p>
                        </div>
                      </div>
                    </li>
                    <li class="item last">
                      <div class="item-inner"><a class="product-image" title="JP Lizzy Satchel Designer Diaper Bag - Slate Citron" href="#"><img alt="JP Lizzy Satchel Designer Diaper Bag - Slate Citron" src="products-images/p3.jpg"></a>
                        <div class="product-details">
                          <div class="access"><a class="btn-remove1" title="Remove This Item" href="#">Remove</a> <a class="btn-edit" title="Edit item" href="#"><i class="icon-pencil"></i><span class="hidden">Edit item</span></a> </div>
                          <!--access--> <strong>1</strong> x <span class="price">$80.00</span>
                          <p class="product-name"><a href="#">JP Lizzy Satchel Designer Diaper Ba...</a></p>
                        </div>
                      </div>
                    </li>
                  </ul>
                  <!--actions--> 
                </div>
              </div>
            </div>
            <!-- Top Cart -->
            <div id="ajaxconfig_info" style="display:none"><a href="#/"></a>
              <input value="" type="hidden">
              <input id="enable_module" value="1" type="hidden">
              <input class="effect_to_cart" value="1" type="hidden">
              <input class="title_shopping_cart" value="Go to shopping cart" type="hidden">
            </div>
          </div>
          
          <div class="top-search">
            <div class="block-icon pull-right"> <a data-target=".bs-example-modal-lg" data-toggle="modal" class="search-focus dropdown-toggle links"> <i class="fa fa-search"></i> </a>
              <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                  <div class="modal-content">
                    <div class="modal-header">
                      <button aria-label="Close" data-dismiss="modal" class="close" type="button"><img src="static/images/interstitial-close.png" alt="close"> </button>
                    </div>
                    <div class="modal-body">
                      <form class="navbar-form" action="search" method="post">
                        <div id="search">
                          <div class="input-group">
                            <input name="keyword" placeholder="Search" class="form-control" type="text">
                            <button type="submit" class="btn-search"><i class="fa fa-search"></i></button>
                          </div>
                        </div>
                      </form>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          
            
            
              <!-- Header Top Links -->
              <div class="toplinks">
                <div class="links">
                
                  <c:choose>
            <c:when test="${empty loggedInuser}">
              <div class="login"><a href="login"><span class="hidden-xs">Log In</span></a></div>
              <div class="login"><a href="signup"><span class="hidden-xs">Register</span></a></div>
            </c:when>
            <c:otherwise>
            
            
            <c:if test="${fn:contains(role, 'ADMIN')}">
            <%-- <c:if test="${role eq 'ADMIN' || role eq 'DBA'}"> --%>
              <div class="login"><a href="admin"><span class="hidden-xs">admin</span></a></div>
            </c:if>
              <div class="myaccount"><a title="My Account" href="profile"><span class="hidden-xs">My Account</span></a></div>
              <div class="myaccount"><a title="My Account" href="logout"><span class="hidden-xs">Logout</span></a></div>
            </c:otherwise>
            </c:choose>
                  
                </div>
                
              </div>
              <!-- End Header Top Links --> 
              
            </div>
          </div>
        </div>
      </div>
    </div>
  </header>
  
  <nav>
    <div class="container">
          <!-- Header Logo -->
          <div class="logo"><a title="Datson" href="home"><img alt="Datson" src="static/images/logo.png"></a></div>
          <!-- End Header Logo --> 

        <div class="mm-toggle-wrap">
          <div class="mm-toggle"><i class="fa fa-reorder"></i><span class="mm-label">Menu</span> </div>
        </div>
     
          <ul class="nav hidden-xs menu-item menu-item-left">
            <li class="level0 parent drop-menu active"><a href="home"><span>Home</span></a>
              
            </li>
            <li class="mega-menu"><a class="level-top" href="about"><span>About</span></a></li>
            <li class="level0 nav-8 level-top"><a href="contact" class="level-top"><span>Contact</span></a></li>
          
            
            
            </ul>
            <ul class="nav hidden-xs menu-item menu-item-right">
            <li class="mega-menu ${shop}"><a class="level-top" href="shop"><span>Shop</span></a></li>
            <li class="mega-menu"><a href="#" class="level-top"><span>Electronics</span></a>
            
           
              <div style="left: 0px; display: none;" class="level0-wrapper dropdown-6col">
                <div class="container">
                  <div class="level0-wrapper2">
                    <div class="nav-block nav-block-center">
                      <ul class="level0">
                        <li class="level1 nav-6-1 parent item"><a href="#/mobiles.html"><span>Mobiles</span></a>
                          <ul class="level1">
                            <li class="level2 nav-6-1-1"><a href="#/mobiles/samsung.html"><span>Samsung</span></a></li>
                            <li class="level2 nav-6-1-1"><a href="#/mobiles/nokia.html"><span>Nokia</span></a></li>
                            <li class="level2 nav-6-1-1"><a href="#/mobiles/iphone.html"><span>IPhone</span></a></li>
                            <li class="level2 nav-6-1-1"><a href="#/mobiles/sony.html"><span>Sony</span></a></li>
                          </ul>
                        </li>
                        <li class="level1 nav-6-1 parent item"><a href="#.html" class=""><span>Accesories</span></a>
                          <ul class="level1">
                            <li class="level2 nav-6-1-1"><a href="#/mobile-memory-cards.html"><span>Mobile Memory Cards</span></a></li>
                            <li class="level2 nav-6-1-1"><a href="#/cases-covers.html"><span>Cases &amp; Covers</span></a></li>
                            <li class="level2 nav-6-1-1"><a href="#/mobile-haedphones.html"><span>Mobile Headphones</span></a></li>
                            <li class="level2 nav-6-1-1"><a href="#/bluetooth-headsets.html"><span>Bluetooth Headsets</span></a></li>
                          </ul>
                        </li>
                        <li class="level1 nav-6-1 parent item"><a href="#/cameras.html"><span>Cameras</span></a>
                          <ul class="level1">
                            <li class="level2 nav-6-1-1"><a href="#/cameras/camcorders.html"><span>Camcorders</span></a></li>
                            <li class="level2 nav-6-1-1"><a href="#/cameras/point-shoot.html"><span>Point &amp; Shoot</span></a></li>
                            <li class="level2 nav-6-1-1"><a href="#/cameras/digital-slr.html"><span>Digital SLR</span></a></li>
                            <li class="level2 nav-6-1-1"><a href="#camera-accesories.html"><span>Camera Accesories</span></a></li>
                          </ul>
                        </li>
                        <li class="level1 nav-6-1 parent item"><a href="#/audio-video.html"><span>Audio &amp; Video</span></a>
                          <ul class="level1">
                            <li class="level2 nav-6-1-1"><a href="#/audio-video/mp3-players.html"><span>MP3 Players</span></a></li>
                            <li class="level2 nav-6-1-1"><a href="#/audio-video/ipods.html"><span>IPods</span></a></li>
                            <li class="level2 nav-6-1-1"><a href="#/audio-video/speakers.html"><span>Speakers</span></a></li>
                            <li class="level2 nav-6-1-1"><a href="#/audio-video/video-players.html"><span>Video Players</span></a></li>
                          </ul>
                        </li>
                        <li class="level1 nav-6-1 parent item"><a href="#/computer.html"><span>Computer</span></a>
                          <ul class="level1">
                            <li class="level2 nav-6-1-1"><a href="#/external-hard-disk.html"><span>External Hard Disk</span></a></li>
                            <li class="level2 nav-6-1-1"><a href="#/computer/pendrives.html"><span>Pendrives</span></a></li>
                            <li class="level2 nav-6-1-1"><a href="#/computer/headphones.html"><span>Headphones</span></a></li>
                            <li class="level2 nav-6-1-1"><a href="#/computer/pc-components.html"><span>PC Components</span></a></li>
                          </ul>
                        </li>
                        <li class="level1 nav-6-1 parent item"><a href="#/home-appliances.html"><span>Appliances</span></a>
                          <ul class="level1">
                            <li class="level2 nav-6-1-1"><a href="#/vaccum-cleaners.html"><span>Vaccum Cleaners</span></a></li>
                            <li class="level2 nav-6-1-1"><a href="#/indoor-lighting.html"><span>Indoor Lighting</span></a></li>
                            <li class="level2 nav-6-1-1"><a href="#/kitchen-tools.html"><span>Kitchen Tools</span></a></li>
                            <li class="level2 nav-6-1-1"><a href="#/water-purifier.html"><span>Water Purifier</span></a></li>
                          </ul>
                        </li>
                      </ul>
                    </div>
                  </div>
                  <!--level0-wrapper2--> 
                  
                </div>
              </div>
            </li>
            
          </ul>
      </div>
  </nav>
  <!-- end nav --> 
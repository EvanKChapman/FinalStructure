
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page import = "java.util.*" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<c:if test="${empty loggedInuser}">
<c:redirect url="/login?expired=Session expired please login"/>
</c:if>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8"><meta http-equiv="refresh"  CONTENT="<%= session.getMaxInactiveInterval() %>;URL='${pageContext.request.contextPath}/expired'" />
<!--[if IE]>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<![endif]-->
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">

<!-- Favicons Icon -->

<title>My Account</title>

<!-- Mobile Specific -->
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

<!-- CSS Style -->
<link rel="stylesheet" type="text/css"href="static/css/internal.css">
<link rel="stylesheet" type="text/css"href="static/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"href="static/css/font-awesome.css" media="all">
<link rel="stylesheet" type="text/css"href="static/css/simple-line-icons.css" media="all">
<link rel="stylesheet" type="text/css"href="static/css/style.css" media="all">
<link rel="stylesheet" type="text/css"href="static/css/revslider.css" >
<link rel="stylesheet" type="text/css"href="static/css/owl.carousel.css">
<link rel="stylesheet" type="text/css"href="static/css/owl.theme.css">
<link rel="stylesheet" type="text/css"href="static/css/flexslider.css">
<link rel="stylesheet" type="text/css"href="static/css/jquery.mobile-menu.css">

<!-- Google Fonts -->
<link href='https://fonts.googleapis.com/css?family=Raleway:400,100,200,300,500,600,700,800,900' rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300italic,300,600,600italic,400italic,700,700italic,800,800italic' rel='stylesheet' type='text/css'>
</head>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"/>
 
 
<body class="customer-account-index customer-account inner-page">
<div id="page"> 
  
  <!-- Header -->
  <jsp:include page="components/header.jsp"/>
  <!-- end header --> 
 
  
  <!-- Main Container -->
  <section class="main-container col2-right-layout">
    <div class="main container">
      <div class="row">
      
          <aside class="col-left sidebar col-sm-3 animated" style="visibility: visible;">
          <div class="page-title">
              <h1>My Account </h1>
            </div>
          <div class="block block-account">
            <br>
            
             <div class="col-md-12 col-md-offset-1">
             <c:if test="${not empty user_account.image}">
		     <img src="static/img/users/${user_account.id}/profile/${user_account.image}"
		      style="width:200px; height:200px; border-radius: 50%;" class="img-responsive">		    
			 </c:if>
			 <a href="#" data-toggle="modal" data-target="#add-images" class="col-md-12 col-md-offset-3">
				<c:choose>
					<c:when test="${not empty user_account.image}">
						Edit <i class="fa fa-image"></i> <i class="fa fa-pencil"></i>
					</c:when>
					<c:otherwise>
						Add <i class="fa fa-image"></i><i class="fa fa-plus"></i>
					</c:otherwise>
				</c:choose>			 
				</a>
		     </div>
             <div class="block-content ">
              <ul id="product-detail-tab" class="product-tabs">               
                <li class="active"><a href="#acc_info" data-toggle="tab" aria-expanded="true">Account Information</a></li>
                <li><a href="#acc_update" data-toggle="tab" aria-expanded="false"><span> Address </span></a></li>
                <li class=""> <a href="#acc_cards" data-toggle="tab" aria-expanded="false">Cards</a> </li>
                <li class=""> <a href="#acc_password" data-toggle="tab" aria-expanded="false">Change Password</a> </li>
                <li class=""> <a href="#acc_products" data-toggle="tab" aria-expanded="false">My Products</a> </li>
                <li><a href="logout"><span> Logout</span></a></li>  
              </ul>
            </div>
            <!--block-content--> 
          </div>
          <!--block block-account--> 
          
        </aside>
        
        <div class="col-main col-sm-9 animated" style="visibility: visible;">
          <div class="my-account">
            <div class="page-title">
              <h1>Welcome back ${user_account.fname}  ${msg}<a href="#" data-toggle="modal" data-target="#edits"> <i class="fa fa-pencil"></i></a>
              <br><span class="text-danger">${error}</span></h1>
            </div>
            <div class="product-collateral col-lg-12 col-sm-12 col-xs-12 bounceInUp animated">
                <ul id="product-detail-tab" class="nav nav-tabs product-tabs">
                  <li class="active"> <a href="#acc_info" data-toggle="tab" aria-expanded="true"> Account Detail </a> </li>
                  <li class=""> <a href="#acc_update" data-toggle="tab" aria-expanded="false">Update Address</a></li>
                  <li class=""> <a href="#acc_cards" data-toggle="tab" aria-expanded="false">Cards</a> </li>
                  <li class=""> <a href="#acc_password" data-toggle="tab" aria-expanded="false">Change Password</a> </li>
                  <li class=""> <a href="#acc_products" data-toggle="tab" aria-expanded="false">My Products</a> </li>
                </ul>
                <div id="productTabContent" class="tab-content">
                  <div class="tab-pane fade active in" id="acc_info">
                    <div class="row">
				        
				         <div class="col-main col-sm-8 animated" style="visibility: visible;">
				          <div class="my-account">
				            <div class="page-title">
				              <h1> Account Information</h1>
				            </div>
				            <div class="line"></div>
				            <div class="dashboard">
				              <div class="panel-group accordion-faq" id="faq-accordion">
				                 <div class="panel">
						            <div class="panel-heading"> <a data-toggle="collapse" data-parent="#faq-accordion" href="#question1"> 
						            <span class="arrow-down">+</span> <span class="arrow-up">&#8211;</span> 
						            Contact
						            </a> </div>
						            <div id="question1" class="panel-collapse collapse in">
						              <div class="panel-body">
						              <table class="table">
						                <tr class="text-success">
											 <th>Item</th>
											 <th>Detail</th>
									    </tr>
										<tr class="text-success">
											 <td>Name <i class="fa fa-user" aria-hidden="true"></i></td>
											 <td>${user_account.fname} ${user_account.lname}</td>
											 
										</tr>
										<tr class="text-success">
											 <td>Email <i class="fa fa-envelope" aria-hidden="true"></i></td>
											 <td>${user_account.email}</td>
											 
										</tr>
										<tr class="text-success">
											 <td>Phone <i class="fa fa-phone" aria-hidden="true"></i></td>
											 <td>${user_account.getAddress().phone}</td>
											 
										</tr>
										<tr class="text-success">
											 <td>Address <i class="fa fa-home" aria-hidden="true"></i></td>
											 <td>${user_account.getAddress().street} ${user_account.getAddress().city} ${user_account.getAddress().zip}</td>
											 
										</tr>
									<tbody>
								</tbody>
							    </table>
						              
						          </div>
						          </div>
						          </div>
						          <div class="panel">
						            <div class="panel-heading"> <a data-toggle="collapse" data-parent="#faq-accordion" href="#question3" class="collapsed"> 
						            <span class="arrow-down">+</span> <span class="arrow-up">&#8211;</span>  Cards.</a> </div>
						            <div id="question3" class="panel-collapse collapse">
						              <div class="panel-body"> 
						             <c:if test="${not empty user_account.getPaymentMethod()}">
					                    <table class="table ">
										 <tr class="text-success">
										 <th>#</th>
										 <th>Card Number</th>
										 <th>Expiry</th>
										 <th>Type</th>
										 </tr>
										 <tbody>
					                    <c:set var="count" value="0"/>
					                    <c:forEach var="cards" items="${user_account.getPaymentMethod()}">
									    <c:set var="count" value="${count+1}"/>
									     <tr>
									       <td> ${count}.</td>
									       <td> ${cards.cardno}</td>
									       <td>
									        ${cards.expiry}
									        </td>
									       <td> Visa
									       <a href="deletecard?id=${cards.id}" onclick="confirmed(); return false;" class="btn btn-default"> <i class="fa fa-trash"></i></a>
									       </td>			              
									     </tr>
									    </c:forEach>
									    </tbody> 
									    </table>
									    </c:if>
						              </div>
						            </div>
						          </div>				          
						          <div class="panel">
						            <div class="panel-heading"> <a data-toggle="collapse" data-parent="#faq-accordion" href="#question6" class="collapsed">
						             <span class="arrow-down">+</span> <span class="arrow-up">&#8211;</span>
									 Phone Numbers</a> </div>
						            <div id="question6" class="panel-collapse collapse">
						              <div class="panel-body">
						               <p class="text-secondary">	
										  <c:forEach var="fone" items="${user_account.getPhoneBook()}">
								    		<i class="fa fa-check"></i>
								    		${fone.type} ${fone.tel} 
								    	 </c:forEach> 
										</p>
						               </div>
						            </div>
						          </div>
						        </div>
				            </div>
				            <!--dashboard--> 
				          </div>
				        </div>
				        
				        <div class="col-main col-sm-4 animated" style="visibility: visible;">
				          <div class="my-account">
				            <div class="page-title">
				              <h1>Add Phone</h1>
				            </div>
				            <div class="line"></div>
				            <div class="dashboard">
				              <form action="addphone" method="post" role="form">
			              	  <input type="hidden" name="id" value="${user_account.id}">
			                  <div class="form-list">
			                  <input type="text" name="tel" class="input-text" placeholder="Phone Number">
			                  </div>
			                  <div class="form-list">
			                  <select name="type" class="input-text"  class="col-md-12">
								<option value="Select">Select Telephone Type</option>
								<option value="Mobile">Mobile </option>
								<option value="Home">Home</option>
								<option value="Work">Work</option>												  
							 </select>
							 </div>
			                  <div class="text-left">
			                    <button class="btn btn-info" type="submit">Add Phone</button>
			                   
			                  </div>
			                
			                </form>
				            </div>
				            <!--dashboard--> 
				          </div>
				        </div>
				      
				      </div>
				  
                  </div>
                  <div class="tab-pane fade" id="acc_update">
                    <div class="box-collateral box-tags">
                      <div class="col-main col-sm-12 animated" style="visibility: visible;">
			          <div class="my-account">			            
			            
			            <form:form action="updatecontact" modelAttribute="address" method="post" id="form-validate">
			              <div class="fieldset group-select">
			                 <h2 class="legend">Contact Information</h2>
			                <ul class="">
			                  <li class="fields">
			                      <div class="customer-name">
			                        <div class="input-box name-firstname">
			                          <label for="firstname">First Name<span class="required">*</span></label>
			                          <div class="input-box1">
			                            <form:input type="text" id="firstname" path="user.fname" value="${user_account.fname}"  class="input-text required-entry"/>
			                          </div>
			                        </div>
			                        <div class="input-box name-lastname">
			                          <label for="lastname">Last Name<span class="required">*</span></label>
			                          <div class="input-box1">
			                            <form:input type="text" id="lastname" path="user.lname" value="${user_account.lname}"   class="input-text required-entry"/>
			                          </div>
			                        </div>
			                      </div>
			                    </li>
			                    <li class="">
			                      <label for="phone">Telephone<em class="required">*</em></label>
			                      <br>
			                       <form:input type="hidden" path="id" value="${user_account.id}"/>	
			                       <form:input type="hidden" path="user.id" value="${user_account.id}"/>	                   
			                       			            
			                       <form:input  class="input-text required-entry"  path="phone" value="" placeholder="Enter phone" />
			                  </li>
			                  
			                </ul>
			              </div>
			              <div class="fieldset group-select">
			                <h2 class="legend">Address</h2>
			                <ul class="">
			                  
			                  <li class="">
			                  <div class="field">
			                    <div class="input-box">
			                    <label for="street">Street Address<em class="required">*</em></label>
			                    <br>
			                    <form:input class="input-text required-entry" path="street" value="" placeholder="Enter Address"/>
						      </div>
						      </div>
						      <div class="field">
			                      <div class="input-box">
			                        <label for="city">City<em class="required">*</em></label>
			                        <br>
			                        <form:input class="input-text required-entry"  path="city" value="" placeholder="Enter City" />				   	
						        </div>
			                    </div>
						     </li>
			                 
			                  <li class="">
			                    
			                   <div class="field">
			                      <div class="input-box">
			                        <label for="zip">Zip/Postal Code<em class="required">*</em></label>
			                        <br>
			                        <form:input class="input-text required-entry"  path="zip" value="" placeholder="Enter ZIP" />				   	
						         </div>
			                    </div>	
			                    <div class="field">
			                      <div class="input-box">
			                        <label for="region_id">State/Province<em class="required">*</em></label>
			                        <br>
			                        <form:select class="input-text" id="region_id" path="state" required="true">
				                    <c:choose>
				                      <c:when test="${empty user_account.getAddress().state}">
				                      <option value="">Select State</option>
				                      </c:when>
				                      <c:otherwise>
				                      <option value="${user_account.getAddress().state}">
				                      ${user_account.getAddress().state}
				                      </option> 
				                      </c:otherwise>
				                      </c:choose>                                 
									  <c:forEach items="${states}" var="state">
									  <option value="${state}">${state.id}</option>
									  </c:forEach>
									</form:select>
						            </div>
			                    </div>
			                  </li>
			                  		                 
			                </ul>
			              </div>
			              <div class="buttons-set">
			                <p class="required">* Required Fields</p>
			                <button type="submit" title="" class="button"><span>Save </span></button>
			              </div>
			            </form:form>			            
			           
			          </div>
			        </div>
                     
                    </div>
                  </div>
                  
                  <div class="tab-pane fade" id="acc_cards">
                    <div class="product-tabs-content-inner clearfix">
                     
                    <div class="row">
				            
				        <div class="col-main col-sm-4 animated" style="visibility: visible;">
				         <div class="page-title">
				              <h1 class="text center">Add new Card</h1>
				          </div>
				          <div class="my-account">				            
				            <div class="line"></div>
				            <div class="dashboard">
				               <form:form action="addcard" modelAttribute="card" method="post" role="form"  >		                 
		                  <ul class="form-list">
		                    <li>
		                      <label for="cardno">Card Number<em class="required">*</em></label>
		                      <div class="input-box">
		                        <form:input type="number" class="input-text" path="cardno" placeholder="Card Number" min="14" />
		                      </div>
		                    </li>
		                    <li class="fields">
		                      <div class="field">
		                        <label for="expiry">Expiry Date<em class="required">*</em></label>
		                        <div class="input-box">
		                          <form:input type="month" class="form-control"  path="expiry" placeholder="Expiry Date"/>		                    
		                        </div>
		                      </div>
		                      <div class="field">
		                        <label for="secode">Card Security<em class="required">*</em></label>
		                        <div class="input-box">
		                          <form:input type="number" class="input-text" path="secode" placeholder="Card Security" min="3" />
							
		                        </div>
		                      </div>
		                    </li>
		                  </ul>
		                <%-- <form:input type="hidden" path="id" value="${user_account.id}"/> --%>
		                <form:input type="hidden" path="user" value="${user_account.id}"/>
		                <div class="buttons-set">
		                  <p class="required">* Required Fields</p>
		                  <button type="submit" title="Save" class="btn btn-default"><span>Save</span></button>
		                  <button type="reset" class="btn btn-danger" >Reset</button>
		                </div>
		              </form:form>
				             
				            </div>
				            <!--dashboard--> 
				          </div>
				        </div>
				        <div class="col-main col-sm-6 animated" style="visibility: visible;">
				         <div class="page-title">
				              <h1 class="text center">My Credit Cards</h1>
				          </div>
				          
				        <c:if test="${not empty user_account.getPaymentMethod()}">
	                    <table class="table ">
						 <tr class="text-success">
						 <th>#</th>
						 <th>Card Number</th>
						 <th>Expiry</th>
						 <th>Type</th>
						 </tr>
						 <tbody>
	                    <c:set var="count" value="0"/>
	                    <c:forEach var="cards" items="${user_account.getPaymentMethod()}">
					    <c:set var="count" value="${count+1}"/>
					     <tr>
					       <td> ${count}.</td>
					       <td> ${cards.cardno}</td>
					       <td>
					        ${cards.expiry}
					        </td>
					       <td> Visa
					       <a href="deletecard?id=${cards.id}" onclick="confirmed(); return false;" class="btn btn-default"> <i class="fa fa-trash"></i></a>
					       </td>			              
					     </tr>
					    </c:forEach>
					    </tbody> 
					    </table>
					    </c:if>

				        </div>
				        <!--col-right sidebar col-sm-3--> 
				      </div>
	                 </div>
                  </div>
                  <div class="tab-pane fade" id="acc_password">
                    <div class="product-tabs-content-inner clearfix">
                      <div  class="col-md-6 fieldset">
                      <form:form action="changepassword" modelAttribute="user" method="post" >
			            <div class="content">  
			              <ul class="form-list">			              
			                <li>
			                 <form:input type="hidden" path="id" value="${user_account.id}" />
			                  <label for="password">Old Password <span class="required">*</span></label>
			                  <br>
			                  <form:input type="password" path="password" class="input-text" placeholder="Password" required="true"/>					          
			                </li>
			                <li>
			                  <label for="password">Create New Password <span class="required">*</span></label>
			                  <br>
			                  <form:input type="password" path="password2" class="input-text"  placeholder="Retype Password" required="true"/>					          
			                </li>
			              </ul>
			              <p class="required">* Required Fields</p>
			              <div class="buttons-set">
			                <button id="send2" name="" type="submit" class="button login"><span>Reset</span></button>
			               </div> 
			            </div>
			            </form:form>
		              </div>
                    </div>
                  </div>
                  
                  <div class="tab-pane fade" id="acc_products">
                      <div class="product-tabs-content-inner clearfix">
                       <div class="page-title">
				           <h1 class="text center">My Products <a  href="#" data-toggle="modal" data-target="#edit" 
                            class="btn btn-default btn-md">Add Product <i class="fa fa-plus" aria-hidden="true"></i>
                     		</a>
                     		</h1>
				       </div>
                       <div class="col-main col-sm-12 animated" style="visibility: visible;">				         
				          			            
				            <div class="line"></div>
				            <div class="dashboard">
				              Table
				            </div>				            
				         
				        </div>
	                 </div>
                  </div>
                </div>
            </div>
            
          </div>
        </div>
     
      </div>
    </div>
  </section>
  <!-- Main Container End --> 
 
  <hr>
 
  <jsp:include page="components/footer.jsp"/>
  						<div class="modal fade" id="edit">
  					    <div class="modal-dialog modal-lg">
						<div class="modal-content">	
						<div class="modal-header">
			                <h5 class="modal-">
			                Add New product
			                <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true">×</span></button>
			                </h5>
			              </div>      
						<!-- Modal body -->
						<div class="modal-body">			    		
			    		  <form:form action="saveproduct" modelAttribute="product" method="post" role="form" enctype="multipart/form-data" > 
			    		  <fieldset class="group-select">
			              <ul>
			                <li id="billing-new-address-form">
			                  <fieldset>
			                    <ul>
			                    
			                      <li class="">
				                    <div class="">
			                          <label for="name">Name</label>
			                          <br>
			                          <form:input path="name" placeholder="Product Name" class="input-text" />
			                        </div>
				                  </li>
				                  
			                      <li>
			                        <div class="">
			                          <div class="input-box ">
			                            <label for="type"> Section <span class="required">*</span></label>
			                            <br>
			                            <form:input path="type" placeholder="Section like electronics etc" class="input-text" />
			                          </div>
			                          <div class="input-box">
			                            <label for="price"> Price<span class="required">*</span> </label>
			                            <br>
			                            <form:input path="price" placeholder="product Price" class="input-text" />
			                          </div>
			                          
			                        </div>
			                      </li>
			                      
				                  <li>
			                        <div class="">
			                          <div class="input-box">
			                            <label for="type"> Size <span class="required">*</span></label>
			                            <br>
			                            <form:select path="size" id="size" multiple="true" class="validate-select required-entry" required="required" > 
						                    <option value="" >Select</option>
						                    <c:forEach items="${sizes}" var="item">
				                            <option value="${item}" > ${item}</option>
				                            </c:forEach>
				                      </form:select>
			                          </div>
			                          <div class="input-box">
			                            <label for="name"> Color<span class="required">*</span> </label>
			                            <br>
			                            <form:select path="color" id="color" multiple="true" class="input-text"  required="required" > 
					                    <option value="" >Select</option>
					                    <c:forEach items="${cols}" var="item">			                        
				                        <option value="${item}" > ${item}</option>
					                    </c:forEach>
					                    </form:select>
			                          </div>
			                          
			                        </div>
			                      </li>
			                      <li class="">
			                        <label for="des">Description<em class="required">*</em></label>
			                        <br>
			                        <div style="float:none" class="">
			                          <form:textarea path="des"  placeholder="Description" class="input-text" cols="5" rows="4"  required="required"/>
			                         </div>
			                      </li>
			                      <li class="">
				                   <div class="input-box">
			                           <form:input path="file" type="file" class="input-text"  required="true"/>
			                       </div>
			                       <div class="input-box">
			                           <form:input path="file" type="file" class="input-text"  />
			                       </div>
			                       <div class="input-box">
			                           <form:input path="file" type="file" class="input-text"  />
			                       </div>
			                       <div class="input-box">
			                           <form:input path="file" type="file" class="input-text"  />
			                       </div>   
				                  </li>
			                    </ul>
			                  </fieldset>
			                </li>
			                    <form:input type="hidden" path="id"/> 
			                    <form:input type="hidden" path="users_id" value="${user_account.id}"/>
			                    <form:input type="hidden" path="img" />
			                    <form:input type="hidden" path="email" value="${user_account.email}" />
			                <li class="buttons-set">
			                  <button type="submit" title="Submit" class="button submit"> <span> Submit </span> </button>
			                   <button type="button" data-dismiss="modal" aria-label="Close" class="btn btn-danger"><span aria-hidden="true">Close</span></button>
			                  
			                </li>
			              </ul>
			            </fieldset>
			            </form:form>
	                      
	                     </div>
					    </div>	
				      </div>
					  </div>
					  
					  
					  <div class="tab-pane fade" id="acc_products">
                     <a  href="#" data-toggle="modal" data-target="#edit" 
                        class="btn btn-default btn-md">Add Product <i class="fa fa-plus" aria-hidden="true"></i>
                     </a><br><br>
                    <div class="col-md-10">
                     
                    <c:if test="${not empty user_account.getProducts()}">
                    <table class="table ">
					 <tr class="text-success">
					 <th>#</th>
					 <th>Product</th>
					 <th></th>					 
					 <th>Department</th>
					 <th>Action</th>
					 </tr>
					 <tbody>
                    <c:set var="count" value="0"/>
                    <c:forEach var="pi" items="${user_account.getProducts()}">
				    <c:set var="count" value="${count+1}"/>
				     <tr>
				       <td> ${count}.</td>
				       <td class="">
                        <div class="product-info">
                        <a href="productdetails?id=${pi.id}">
                          <img width="80" src="static/img/products/${pi.id}/${pi.img}" alt="" />
                         </a>
                        </div>
                        
                      </td>
                      <td>
				        ${pi.name} <br> ${pi.color} <br> $<fmt:formatNumber value="${pi.price}" maxFractionDigits="2" minFractionDigits="2"/>
				       </td>				       
				       <td>
				        ${pi.type}
				       </td>
				       <td>
				       <a href="deleteproduct?id=${pi.id}" onclick="confirmed(); return false;" class="btn btn-default"> <i class="fa fa-trash"></i></a>
				       
                      </td>			              
				     </tr>
				    </c:forEach>
				    </tbody> 
				    </table>
				    </c:if>
               
                    </div>
                  </div>
					  
					  
					  
  
  
  
  
   
				      <div class="modal fade" id="edits">
					    <div class="modal-dialog modal-md">
						<div class="modal-content">	
						<div class="modal-header">
			                <h5 class="modal-">Update Info
			                <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true">×</span></button>
			                </h5>
			              </div>      
						<!-- Modal body -->
						<div class="modal-body">			    		
			    		  
	                      <form:form action="updatemyinfo" modelAttribute="user" method="post" id="form-validate" >
			               
			                  <input name="id" type="hidden" value="${user_account.id}" >
			                  <h2 class="legend">Edit Information</h2>
			                  <ul class="form-list">
			                    <li class="fields">
			                      <div class="customer-name">
			                        <div class="input-box name-firstname">
			                          <label for="firstname">First Name<span class="required">*</span></label>
			                          <div class="input-box1">
			                            <input type="text" id="firstname" name="fname" value="${user_account.fname}"  title="" maxlength="255" class="input-text required-entry">
			                          </div>
			                        </div>
			                        <div class="input-box name-lastname">
			                          <label for="lastname">Last Name<span class="required">*</span></label>
			                          <div class="input-box1">
			                            <input type="text" id="lastname" name="lname" value="${user_account.lname}"  title="" maxlength="255" class="input-text required-entry">
			                          </div>
			                        </div>
			                      </div>
			                    </li>
			                  </ul>
			                	                
			                <div class="buttons-set">
			                  <p class="required">* Required Fields</p>
			                  <button type="submit" title="Save" class="btn btn-info"><span>Save</span></button>
			                  <button type="button" data-dismiss="modal" aria-label="Close" class="btn btn-danger">Close</button>
			                </div>
			              </form:form>
		             
			    		  
	                     </div>
					    </div>	
				      </div>
					  </div>
					  
					 <div class="modal fade" id="add-images">
					  <div class="modal-dialog modal-sm">
					   <div class="modal-content">	
					   <div class="modal-header">
			                <h3 class="modal-">Add Image
			                <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true">×</span></button>
			                </h3>
			              </div>       
					   <!-- Modal body -->
						<div class="modal-body">	
						
						<form method="POST" action="addimages" enctype="multipart/form-data" id="form-validate" >
			               
			                  <input name="id" type="hidden" value="${user_account.id}" >
			                  <h5 class="legend">Select Photo</h5>
			                  <ul class="form-list">
			                    <li class="fields">
			                      <div class="customer-name">
			                        <div class="input-box name-firstname">
			                          <img id="output_image" class="col-md-8"/>
			                        </div>
			                         
			                        <div class="input-box">
			                           <div class="input-box1">
			                            <input type="file" name="file" class="input-text"  onchange="preview_image(event)" required>					                             
							            					
			                          </div>
			                        </div>
			                      </div>
			                    </li>
			                  </ul>
			                	                
			                <div class="buttons-set">
			                  <p class="required">* Required Fields</p>
			                  <button type="submit" title="Save" class="btn btn-info"><span>Save</span></button>
			                  <button type="button" data-dismiss="modal" aria-label="Close" class="btn btn-danger">Close</button>
			                </div>
			             </form>
			              
			    		 
		                  </div>
					  </div>	        
				   
				    </div>
					</div> 

					
					  
					  
					  	
</div>					  
<!-- JavaScript --> 
<script type="text/javascript" src="static/js/jquery.min.js"></script> 
<script type="text/javascript" src="static/js/bootstrap.min.js"></script> 
<script type="text/javascript" src="static/js/parallax.js"></script> 
<script type="text/javascript" src="static/js/common.js"></script> 
<script type="text/javascript" src="static/js/jquery.flexslider.js"></script> 
<script type="text/javascript" src="static/js/owl.carousel.min.js"></script> 
<script type="text/javascript" src="static/js/jquery.mobile-menu.min.js"></script> 
<script type="text/javascript" src="static/js/cloud-zoom.js"></script>
  <script type="text/javascript">
    function preview_image(event) 
    {
     var reader = new FileReader();
     reader.onload = function()
     {
      var output = document.getElementById('output_image');
      output.classList.add("preview");
      output.src = reader.result;
     }
     reader.readAsDataURL(event.target.files[0]);
    }
    
    function confirmed(){
        if (confirm('You are about to delete, Do you want to proceed?')) {
              document.getElementById("del").submit();
              return true;
            } else {
               return false;
            }
     }
    
</script> 
</body>
</html>
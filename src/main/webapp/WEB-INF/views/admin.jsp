<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
 
 <c:if test="${empty role or role ==null}">
 <c:redirect url="/login?error=Unauthorised Access for protected resource"/>
 </c:if>
  <c:if test="${role != 'DBA' and role != 'ADMIN'}">
    <c:redirect url="/profile?error=Access Denied"/>
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

<title>Capstone | Admin </title>

<!-- Mobile Specific -->
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

<!-- CSS Style -->
<link rel="stylesheet" type="text/css" href="static/css/internal.css">
<link rel="stylesheet" type="text/css" href="static/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="static/css/font-awesome.css" media="all">
<link rel="stylesheet" type="text/css" href="static/css/simple-line-icons.css" media="all">
<link rel="stylesheet" type="text/css" href="static/css/style.css" media="all">
<link rel="stylesheet" type="text/css" href="static/css/animate.css" media="all">
<link rel="stylesheet" type="text/css" href="static/css/revslider.css" >
<link rel="stylesheet" type="text/css" href="static/css/owl.carousel.css">
<link rel="stylesheet" type="text/css" href="static/css/owl.theme.css">
<link rel="stylesheet" type="text/css" href="static/css/flexslider.css">
<link rel="stylesheet" type="text/css" href="static/css/jquery.mobile-menu.css">

<!-- Google Fonts -->
<link href='https://fonts.googleapis.com/css?family=Raleway:400,100,200,300,500,600,700,800,900' rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,300italic,300,600,600italic,400italic,700,700italic,800,800italic' rel='stylesheet' type='text/css'>
</head>

<body class="inner-page">
<div id="page"> 
  
  <!-- Header -->
  <jsp:include page="components/header.jsp"/>
  <!-- end header --> 
  
  
  <!-- Main Container -->
  <section class="main-container col1-layout">
    <div class="main container">
      <div class="col-main">
        <div class="cart">
          <div class="page-title">
           
            <h1>Page ${list.getNumber()+1} of ${list.totalPages} showing ${list.content.size()} of all ${list.getTotalElements()} Users  ${success} <span class="text-danger">${error}</span></h1>
             <form action="seachByemailOrlastname" method="post">
              <input id="searchnow" type="text" class="input-text" name="lname"  placeholder="Last name">
              <input type="email" name="email" class="input-text" placeholder="E-mail">
              <button type="submit" class="btn btn-danger btn-md">Search</button>
              </form>
          </div>
           <br>
                 <table class="data-table table-responsive" >
                  <thead>
                    <tr>
                      <th></th>
                      <th><h2><i class="fa fa-users"></i> Users</h2></th>
                      <th><h2> <i class="fa fa-envelope"></i> Email</h2></th>
                      <th><h2><i class="fa fa-key"></i> Role</h2></th>
                      <th class="a-center " rowspan="1"><h2> <i class="fa fa-edit"></i> Action</h2> </th>                      
                    </tr>
                  </thead>
                  
                  <tbody>
                    <c:forEach var="item" items="${list.content}">
                    <tr>
                      <td class="image">
                      <c:if test="${not empty item.image}"> 
                      <img width="75" height="75" alt="" src="static/img/users/${item.id}/profile/${item.image}">
                      </c:if>
                      </td>
                      <td><h2 class="product-name"> <a  href="#" data-toggle="modal" data-target="#about${item.id}" ><i class="fa fa-user"></i>  ${item.fname} ${item.lname}</a>
                       </h2></td>
                       <td class="a-center hidden-table">
                       <h2 class="text-info">${item.email} <a href="deleteByemail?email=${item.email}"><i class="fa fa-times"></i></a></h2>
                       </td>
                      <td class="a-center hidden-table">
                      <h2>
                      <form method="POST" action="editrole" >    
<input type="hidden" name="id" value="${item.id}" />      
<select onchange="this.form.submit()" name="role"  class="validate-select required-entry">
<option value="${item.role}">
<c:forEach var="r" items="${item.getRoles()}">
  ${r.role}
</c:forEach>
</option>
<option value="USER">USER </option>
<option value="DBA">DBA</option>
<option value="ADMIN">ADMIN</option>  
</select>
  </form>
  </h2>
  </td>
                      <td><h2>
                      <a href="#" data-toggle="modal" data-target="#edits${item.id}"  title="Edit User" class="edit-bnt" href="#"></a>
                      <a class="button remove-item" title="Remove item" href="deleteUser?id=${item.id}" onclick="confirmed(); return false;" class="btn btn-default"><span class="fa fa-times"></span></a>
                      </h2>
                      </td>
                   
                    </tr>
                    </c:forEach>
                  </tbody>
                </table>
             
                        
                         <br>
             <c:if test="${list.hasContent()}">
                 <div class="pages">
                  <ul class="pagination">
                        <c:set var="prev" value="0"/>
                        <c:if test="${list.hasContent()}">
                           <c:set var="prev" value="${list.getNumber()-1}"/>
                        </c:if>
                        <c:if test="${list.hasPrevious()}">
                             <li class='page-item'>
                                <a class="page-link" href="admin?page=0&size=${list.getSize()}">
                                <i class="fa fa-angle-double-left margin-5px-left xs-display-none "></i></a>
                            </li>
                            <li class='page-item'>                                 
                                <a class="page-link"href="admin?page=${prev}&size=${list.getSize()}">
                                <i class="fa fa-long-arrow-alt-left margin-5px-right xs-display-none"></i> Prev</a>
                            </li>
                        </c:if>
                        
                        <c:forEach var="i" begin="0" end="${list.totalPages -1}">
                            <li class='page-item <c:if test="${list.getNumber() eq i || (empty list.getNumber() && i eq 0)}">active</c:if>'>
                                <a class="page-link" href="admin?page=${i}&size=${list.getSize()}">${i+1} </a>
                            </li>
                     
                        </c:forEach>
                        <c:if test="${list.hasNext()}">
                            <li class='page-item'>
                                <a class="page-link" href="admin?page=${list.getNumber() + 1}&size=${list.getSize()}">Next
                                <i class="fa fa-long-arrow-alt-right margin-5px-left xs-display-none "></i></a>
                            </li>
                            <li class='page-item'>
                                <a class="page-link" href="admin?page=${list.totalPages -1}&size=${list.getSize()}">
                                <i class="fa fa-angle-double-right margin-5px-left xs-display-none "></i></a>
                            </li>
                        </c:if>
                     </ul>
                </div>
            </c:if>
          
        </div>
      </div>
    </div>
  </section>
 
  
  <c:forEach var="item" items="${list.content}">
            <div class="modal fade" id="edits${item.id}">
    <div class="modal-dialog modal-sm">
<div class="modal-content">
<div class="modal-header">
                <h5 class="modal-">Update Info
                <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true">×</span></button>
                </h5>
              </div>     
<!-- Modal body -->
<div class="modal-body">
<form:form action="updateUsers" modelAttribute="user" method="post" id="form-validate" >
               
                  <input name="id" type="hidden" value="${item.id}" >
                 
                  <ul class="form-list">
                    <li class="fields">
                      <div class="customer-name">
                        <div class="input-box name-firstname">
                          <label for="firstname">First Name<span class="required">*</span></label>
                          <div class="input-box1">
                            <form:input path="fname"  value="${item.fname}" class="input-text" placeholder="First Name"/>
                          </div>
                        </div>
                        <div class="input-box name-lastname">
                          <label for="lastname">Last Name <span class="required">*</span></label>
                          <div class="input-box1">
                            <form:input path="lname"  value="${item.lname}" class="input-text" placeholder="Last Name"/>
                          </div>
                          <form:input type="hidden" path="email" value="${item.email}" class="input-text" />
                        </div>
                        <div class="input-box name-lastname">
                          <label for="lastname">Please select Roles <span class="required">*</span></label>
                         <br>
                          <form:select path="role" defaultvalue="${item.role}"  class="col-md-12">
                    <option value="${item.role}">${item.role}</option>
                    <option value="USER">USER</option>
<option value="DBA">DBA</option>
<option value="ADMIN">ADMIN</option>
  </form:select>
 
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
            </c:forEach>
             
               <c:forEach var="item" items="${list.content}">
               <div class="modal fade" id="about${item.id}">
    <div class="modal-dialog modal-md">
<div class="modal-content">
<div class="modal-header">
                <h2 class="modal-"><b>${item.fname} ${item.lname}</b>
                <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true">×</span></button>
                </h2> 
              </div>      
<!-- Modal body -->
<div class="modal-body">    
     
                      <div class="text-secondary">
     
      <h3>
         <c:if test="${not empty item.getAddress()}">            
             <i class="fa fa-home text-success"> </i>
             ${item.getAddress().street},
${item.getAddress().city},
${item.getAddress().state}<br>
</c:if>
<i class="fa fa-envelope"></i> ${item.email}
<hr><i class="fa fa-key"></i>
<c:forEach var="r" items="${item.getRoles()}">
     ${r.role}<i class="fa fa-check"></i>
    </c:forEach>
<br>
       </h3>   
      </div>
             
      <div class="buttons-set">
                  <button type="button" data-dismiss="modal" aria-label="Close" class="btn btn-danger">Close</button>
                </div>
                     </div>
    </div>
      </div>
     </div>    
            </c:forEach>
  <hr>
  <!-- Footer -->  
  <jsp:include page="components/footer.jsp"/>
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

<script>
        function confirmed(){
            if (confirm('You are about to delete, Do you want to proceed?')) {
                  document.getElementById("del").submit();
                  return true;
            } else {
               return false;
            }
         }
            
    $("#searchnow").keyup(function () {
        var value = this.value.toLowerCase().trim();

        $("table tr").each(function (index) {
            if (!index) return;
            $(this).find("td").each(function () {
                var id = $(this).text().toLowerCase().trim();
                var not_found = (id.indexOf(value) == -1);
                $(this).closest('tr').toggle(!not_found);
                return not_found;
            });
        });
    });
    </script>
</body>
</html>
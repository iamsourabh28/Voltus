<%-- 
    Document   : Admin_Home
    Created on : Feb 25, 2016, 12:03:29 PM
    Author     : admin
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,javacode.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib  uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Voltus</title>
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <style>
            #header {
                background-color:black;
                color:white;
                text-align:center;
                padding:5px;
            }
            #side {
                line-height:30px;
                background-color:#eeeeee;
                height:300px;
                width:100px;
                float:left;
                padding:5px;	      
            }
            #section {
                width:350px;
                float:left;
                padding:10px;	 	 
            }
            #footer {
                background-color:black;
                color:white;
                clear:both;
                text-align:center;
                padding:5px;	 	 
            }
            .row
            {
                display: table;
                width: 100%; /*Optional*/
                /*table-layout: fixed; Optional*/
                border-spacing: 10px; /*Optional*/
            }
            .column
            {   
                display: table-cell;
                /*background-color: red; Optional*/
            }
            .btn-info{
                background-color: #8cc63f;
                border-color: #8cc63f;
            }
            .btn-info:hover{
                background-color: #8cc63f;border-color: #8cc63f;
            }
        </style>
        <script>
            function myfun()
            {
                var chk = document.getElementById('profilepassword').value;
                $.post('QuickStats', {passwordcheck: chk},
                        function (returnedData)
                        {
                            if (returnedData === 'No') {
                                $('#wrong').text('Wrong Password');
                                $('#wrong').css('color', 'red');
                            } else {
                                $('#wrong').text('Correct Password');
                                $('#wrong').css('color', 'green');
                            }


                        });
            }


        </script>
        <script type="text/javascript">
            function utilinfo() {
                location.href = "Admin_UtilityInfo.jsp";
            }
            var row;
            function edit(uid, id) {
                row = $(id).parent().parent().parent();
//                //alert(row.children().eq(0).text());
//                document.getElementById("epfilepic").value = row.children().eq(3).attr('src',)
        var shortlevel="";
        var level=row.children().eq(5).text().trim();        
        if(level==="Voltus_Admin"){
            shortlevel="VA";
                    
             }else if(level==="Kamal_Admin"){
                  shortlevel="KA";  
             }else if(level==="Voltus_Analyst"){
                    shortlevel="VE";
             }else{
                    shortlevel="KE";
             }

                document.getElementById("epnameid").value = row.children().eq(0).text();
                document.getElementById("epemailid").value = row.children().eq(1).text();
                document.getElementById("eppwdid").value = row.children().eq(2).text();
                document.getElementById("epuid").value = row.children().eq(4).text();
                  document.getElementById("eplevelid").value =shortlevel;
         
//        $("#eplevelid").val(row.children().eq(5).text());
                $('#edit-modal').modal('show');
//                location.href = "VoltusAdd.jsp?edit=" + id;
            }
            function removeUser(uid, id) {

                row = $(id).parent().parent().parent();

                document.getElementById("lbdeluid").innerHTML = uid;
                document.getElementById("inhidedeluid").value = uid;
                $('#userdelete-modal').modal('show');
//                location.href = "VoltusAdd.jsp?del=" + id;
            }
            function deleteUser() {
////                var reqids = $('inhidecommautilid').text();
                var uids = document.getElementById("inhidedeluid").value;
                $.post('UserDelete', {idDelUser: uids},
                        function (returnedData) {
                            $('#userdelete-modal').modal('hide');
                            row.remove();
                        });
            }
            function signout()
            {<%session.setAttribute("session", "FALSE");%>
                location.href = "index.htm";
            }
        </script>
    </head>
    <body>
        <!-- Establish Connection with database -->
        <sql:setDataSource var="snapshot" driver="org.postgresql.Driver"
                           url="jdbc:postgresql://localhost:5432/utilityportal"
                           user="postgres"  password="root_123"/>

        <div class="vid-container" style="background:none;">
            <video id="Video1" class="bgvid back" autoplay="" muted="muted" preload="auto" loop>
                <!--<source src="http://shortcodelic1.manuelmasiacsasi.netdna-cdn.com/themes/geode/wp-content/uploads/2014/04/milky-way-river-1280hd.mp4.mp4" type="video/mp4">-->
            </video>
            <div class="navigation_bar">
                <nav class="navbar navbar-default" style="border-radius: 0px;">
                    <div class="container-fluid">
                        <!-- Brand and toggle get grouped for better mobile display -->
                        <div class="navbar-header">
                            <img src="resource/image/voltus_logo.png" alt="Logo" style="margin-top: 5px;width:125px;height:39px;">
                        </div>

                        <!-- Collect the nav links, forms, and other content for toggling -->
                        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                            <!--                                <div class="navbar-form navbar-right" style="background-color: #246db4;border-radius: 50px;">
                                                                <label style="font-size:18px;color: white;margin-left:0;  ">A</label>
                                                            </div>-->
                            <ul class="nav navbar-nav navbar-right">
                                <li><a href="Admin_Home.jsp">Home</a></li>
                                    <c:set var="uid" value='<%=session.getAttribute("uid")%>' />
                                <!--                                <p></p>-->
                                <li class="dropdown">
                                    <%
                                        String name = (String) session.getAttribute("name");
                                        String nameAlpha = "";
                                        System.out.println(name.split(" "));
                                        if (name.split(" ").equals(null)) {
                                            nameAlpha = name;
                                        } else {
                                            String[] nameSplit = name.split(" ");

                                            if (nameSplit.length == 1) {
                                                nameAlpha = nameSplit[0].substring(0, 1);
                                            } else {
                                                nameAlpha = nameSplit[0].substring(0, 1).concat(nameSplit[1].substring(0, 1));
                                            }
                                        }
                                    %>
                                    <c:set var="name" value="<%=nameAlpha%>"/>
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"><label style="background-color: #8cc63f;border-radius: 20px;padding-left: 5px;padding-right: 5px;color: white;"><c:out value="${name}"/></label></a>
                                    <ul class="dropdown-menu" style="width:450px;">
                                        <li>
                                            <div class="row">
                                                <div class="column" >
                                                    <div style="text-align: center;font-size: 30px;width: 50px;height: 50px;background-color: gray;margin-top: 20px;">
                                                        <c:set var="uid" value='<%=session.getAttribute("uid")%>'/>
                                                        <sql:query dataSource="${snapshot}" var="resultprofile">
                                                            select * from logindetail where uid = '${uid}';
                                                        </sql:query>
                                                        <c:if test="${fn:length(resultprofile.rows)!=0}">
                                                            <c:forEach var="profile" items="${resultprofile.rows}">
                                                                <img src='getprofilepic.jsp?uid=<%=session.getAttribute("uid")%>' alt="Logo" style="width:50px;height:50px;">

                                                            </c:forEach>
                                                        </c:if>
                                                        <c:if test="${fn:length(resultprofile.rows)==0}">
                                                            <c:out value="${name}"/>
                                                        </c:if>
                                                    </div>
                                                </div>
                                                <div class="column" style="margin-left: 55px;">
                                                    <label style="color: #174674;font-size: 15px;"><c:out value='<%=session.getAttribute("name")%>'/></label><br>
                                                    <label style="color: gray;"><c:out value='<%=session.getAttribute("email")%>'/></label><br>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="column" >
                                                    <button onclick="signout()" class="btn btn-info btn-sm" style="background-color: #8cc63f;border-color: #8cc63f;">
                                                        <span class="glyphicon glyphicon-log-out"></span> Log out</button>
                                                </div>
                                                <div class="column" >
                                                    <button type="button" data-toggle="modal" data-target="#setting-modal" class="btn btn-default btn-sm" >
                                                        <span class="glyphicon glyphicon-cog" aria-hidden="true"></span>
                                                        Settings</button>
                                                </div>
                                            </div>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </div><!-- /.navbar-collapse -->
                    </div><!-- /.container-fluid -->
                </nav>
            </div>

            <div class="buttons" style=" background-color: #e7e7e7;">
                <!--<div class="portfolio">-->
                <!-- Buttons bar this div covers all remaining area -->
                <div class="buttons" id="contentbox" style="width: 100%; background-color: #e7e7e7;">
                    <!-- Buttons bar on top right side [New][Previous] -->
                    <div class="buttons-right">
                        <!-- [Button]Finish : To finish request and redirect page to home  -->
                        <!--                        <button type="button"  class="btn btn-success" onclick="viewHome();">
                                                    Finish Request
                                                </button>-->
                        <!-- [Button]New : To Create a new request, opens popup modal window  -->
                        <button type="button" data-toggle="modal" data-target="#user-modal" class="btn btn-default navbar-btn" >
                            <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
                            New
                        </button>
                        <button type="button" class="btn btn-default navbar-btn" onclick="utilinfo();" >
                            <span class="glyphicon glyphicon-th" aria-hidden="true"></span>
                            UtilityInfo
                        </button>
                        <!-- [Button]Previous : To Open all previous request records -->
                        <!--                        <button type="button" id="previous" class="btn btn-default navbar-btn" onclick="viewPrevious();" >
                                                    <span class="glyphicon glyphicon-th-list" aria-hidden="true"></span>
                                                    Previous
                                                </button>-->
                    </div><!-- .buttons-right -->

                    <!-- request Id Container -->
                    <div class="info-request-left">
                        <!-- [Button]New : To Create a new request, opens popup modal window  -->
                        <!--<label class="color : red;">request ID</label>-->
                        <!-- [Button]Previous : To Open all previous request records -->
                        <!--<label class="color : red;">BKJBH786KN98BKG</label>-->
                        <!-- Show Request ID -->

                        <h4 style="color: #a0a0a0;">
                            <c:out value="List of users"/>
                        </h4>
                        <!--<h4 style="color: #a0a0a0;">Request ID : BKJBH786KN98BKG</h4>-->
                    </div><!-- .info-request-leftt -->

                    <!-- Contains table which record all utility for newly created request -->
                    <div class="table-container" style="background-color:#e7e7e7;">
                        <!-- Contains table and padding from left and right side 100px -->
                        <div class="table-d" style="background: none;"> 
                            <!-- Add a scroll bar in table with fixing size of table -->
                            <div class="ScrollStyle"> 
                                <!-- Table for showing Utility data for generated request -->
                                <table class="table table-bordered table-condensed table-hover" style="border-color:rgba(255,255,255,0.4);background-color: rgba(255,255,255,0.4);max-height: 10px;overflow-y: scroll; ">
                                    <thead style="background-color: #8cc63f;color: white; ">

                                        <%--<sql:query dataSource="${snapshot}" var="resultreqcomm">--%>
                                            <!--SELECT * from commentdb where commentdb.commid='${sessionScope.requestID}';-->
                                        <%--</sql:query>--%>
                                        <!--                                        <tr style="border-color:rgba(74,96,138,0.4);" >
                                                                                    <th style="border-color:rgba(74,96,138,0.4);">Name</th>
                                                                                    <th style="border-color:rgba(74,96,138,0.4);">Email</th>
                                                                                    <th style="border-color:rgba(74,96,138,0.4);">Password</th>
                                                                                    <th style="border-color:rgba(74,96,138,0.4);">Profile</th>
                                                                                    <th style="border-color:rgba(74,96,138,0.4);">Username</th>
                                                                                    <th style="border-color:rgba(74,96,138,0.4);">Level</th>
                                                                                    <th style="border-color:rgba(74,96,138,0.4);">Edit/Remove</th>
                                                                                </tr>-->
                                        <tr style="border-color:rgba(74,96,138,0.4);" >
                                            <th style="border-color:rgba(74,96,138,0.4);">Name</th>
                                            <th style="border-color:rgba(74,96,138,0.4);">Email</th>
                                            <th style="border-color:rgba(74,96,138,0.4);">Password</th>
                                            <th style="border-color:rgba(74,96,138,0.4);">Profile</th>
                                            <th style="border-color:rgba(74,96,138,0.4);">Username</th>
                                            <th style="border-color:rgba(74,96,138,0.4);">Level</th>
                                            <th style="border-color:rgba(74,96,138,0.4);">Edit/Remove</th>
                                        </tr>
                                    </thead>
                                    <tbody class="ScrollStyle">
                                        <sql:query dataSource="${snapshot}" var="result">
                                            SELECT * FROM public.logindetail where level!='A';
                                        </sql:query>

                                        <c:forEach var="row" items="${result.rows}">

                                            <tr style="border-color:rgba(74,96,138,0.4);" >

                                                <td style="border-color:rgba(74,96,138,0.4);"><c:out value="${row.uname}"/>    </td><!-- Name -->

                                                <td style="border-color:rgba(74,96,138,0.4);" ><c:out value="${row.email}"/>  </td><!-- Email -->

                                                <td style="border-color:rgba(74,96,138,0.4);"><c:out value="${row.pwd}"/>   </td><!--  password -->

                                                <td style="border-color:rgba(74,96,138,0.4);"><img src="getprofilepic.jsp?uid=${row.uid}" alt="Not" style="width: 50px;height: 50px;"/> </td><!-- profileImage -->

                                                <td style="border-color:rgba(74,96,138,0.4);"><c:out value="${row.uid}"/></td><!-- Username -->

                                                <td style="border-color:rgba(74,96,138,0.4);">
                                                    <c:choose>
                                                        <c:when test="${row.level=='KE'}">Kamal_Analyst</c:when>
                                                        <c:when test="${row.level=='KA'}">Kamal_Admin  </c:when>
                                                        <c:when test="${row.level=='VE'}">Voltus_Analyst</c:when>
                                                        <c:when test="${row.level=='VA'}">Voltus_Admin  </c:when>
                                                    </c:choose>
                                                </td><!-- Level -->

                                                <td style="border-color:rgba(74,96,138,0.4);align-content: center;">
                                                    <!-- Contains Edit / Remove utility Buttons -->
                                                    <div style="text-align: center;">
                                                        <!-- Edit utility -->
                                                        <button type="button" class="btn btn-default btn-xs" id="<c:out value='${row.uid}'/>" onclick="edit(this.id, this);">
                                                            <span class ="glyphicon glyphicon-edit" aria-hidden="true"></span>
                                                        </button>
                                                        <!-- Remove utility in modal window -->
                                                        <!--<button type="button" data-toggle="modal" data-target="#loa-modal" class="btn btn-default btn-xs" >-->
                                                        <button type="button" id="<c:out value="${row.uid}"/>" class="btn btn-default btn-xs" onclick="removeUser(this.id, this);" >
                                                            <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                                        </button>
                                                    </div>
                                                </td><!-- Edit/ Remove-->
                                            </tr>

                                        </c:forEach>

                                    </tbody>
                                </table>
                            </div> <!--/.scrollstyle-->  
                        </div><!-- /.table-d -->
                    </div><!-- /.table-container -->
                </div><!-- /.Buttons -->
                <div style="display: none;position: absolute;right: 0;top:0;width: 250px;height: 80%;background: gray;">
                    <!-- <di-->
                </div>
            </div>
        </div>
        <!-- Modal -->
        <!-- Open to edit profile -->
        <div class="modal fade" id="setting-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-keyboard="false" data-backdrop="static">
            <form method="post" action="Settings" enctype="multipart/form-data">
                <div class="modal-dialog" >
                    <div class="modal-content">
                        <div class="modal-header" style="border-bottom:1.5px solid #8cc63f;" >
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="myModalLabel">Settings</h4>
                        </div>
                        <div class="modal-body">
                            <table class="table table-bordered" style="background-color: rgba(255,255,255,0.4);">
                                <thead>
                                    <tr>
                                        <td colspan="2">
                                            <label>Update Profile</label>
                                            <!--<label id="lbeditutil"></label>-->
                                        </td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%--<c:forEach var="row" items="${resultEditUtil.rows}" >--%>
                                    <tr>
                                        <td>
                                            Profile picture:
                                        </td>
                                        <td>
                                            <table  class="table" style="background-color: rgba(255,255,255,0.4);">
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <input type="file" name="profilepic"/>
                                                        </td>
                                                        <td>
                                                            <img src='getprofilepic.jsp?uid=<%=session.getAttribute("uid")%>' style="width: 50px;height: 50px;"/>
                                                            <input type="hidden" name="returnsettings" value="Admin_Home.jsp"/>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Email:
                                        </td>
                                        <td>
                                            <input type="text" name="profileemail" value='<%=session.getAttribute("email")%>'/>
                                            <input type="hidden" name="returnsettings" value="Admin_Home.jsp"/>

                                        </td>
                                    </tr>

                                    <tr>

                                        <sql:setDataSource var="snapshot" driver="org.postgresql.Driver"
                                                           url="jdbc:postgresql://localhost:5432/utilityportal"
                                                           user="postgres"  password="root_123"/>
                                        <sql:query dataSource="${snapshot}" var="pass">
                                            select pwd from logindetail where uid = '${uid}';
                                        </sql:query>
                                        <td>
                                            Current Password:
                                        </td>
                                        <td>
                                            <input type="text" name="profilepassword" onchange="myfun()" id="profilepassword"/><p id="wrong"></p>

                                        </td>
                                    </tr>
                                    <tr>

                                        <td>
                                            New Password:
                                        </td>
                                        <td>
                                            <input type="text" name="profilenewpassword"/>

                                        </td>
                                    </tr>
                                    <%--</c:forEach>--%>
                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer" style="background-color: #8cc63f;">
                            <input type="submit" id="submit" class="login loginmodal" value="Save Changes" >
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <!-- Modal -->
        <!-- Open to add user  profile -->
        <div class="modal fade" id="user-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-keyboard="false" data-backdrop="static">
            <form method="post" action="Settings" enctype="multipart/form-data">
                <div class="modal-dialog" >
                    <div class="modal-content">
                        <div class="modal-header" style="border-bottom:1.5px solid #8cc63f;" >
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="myModalLabel">Add New User</h4>
                        </div>
                        <div class="modal-body">
                            <table class="table table-bordered" style="background-color: rgba(255,255,255,0.4);">
                                <!--<input type="hidden" name="hideaprofileuid" id="epuid" value=""/>-->
                                <thead>
                                    <tr>
                                        <td colspan="2">
                                            <label>Create Profile</label>
                                            <!--<label id="lbeditutil"></label>-->
                                        </td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%--<c:forEach var="row" items="${resultEditUtil.rows}" >--%>
                                    <tr>
                                        <td>
                                            User Name:
                                        </td>
                                        <td>
                                            <input type="text" name="eprofileuname" value=""/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Name:
                                        </td>
                                        <td>
                                            <input type="text" name="eprofilename" value=""/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Profile picture:
                                        </td>
                                        <td>
                                            <input type="file" name="eprofilepic" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Email:
                                        </td>
                                        <td>
                                            <input type="text" name="eprofileemail" value=""/>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Password:
                                        </td>
                                        <td>
                                            <input type="text" name="eprofilepassword" value=""/>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Level:
                                        </td>
                                        <td>
                                            <select id="eplevelid1" name="eplevel">
                                                <option value="KE" name="eprofilelevel" >Kamal_Analyst</option>
                                                <option value="KA" name="eprofilelevel" >Kamal_Admin</option>
                                                <option value="VE" name="eprofilelevel" >Voltus_Analyst</option>
                                                <option value="VA" name="eprofilelevel" >Voltus_Admin</option>
                                            </select>

                                        </td>
                                    </tr>
                                    <%--</c:forEach>--%>
                                </tbody>
                            </table>

                        </div>
                        <div class="modal-footer" style="background-color: #8cc63f;">
                            <input type="submit" id="CreateProfile" class="login loginmodal" value="Create" >
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <!-- Modal -->
        <!-- Open to user edit profile -->
        <div class="modal fade" id="edit-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" data-keyboard="false" data-backdrop="static">
            <form method="post" action="Settings" enctype="multipart/form-data">
                <div class="modal-dialog" >
                    <div class="modal-content">
                        <div class="modal-header" style="border-bottom:1.5px solid #8cc63f;" >
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="myModalLabel">Settings</h4>
                        </div>
                        <div class="modal-body">
                            <table class="table table-bordered" style="background-color: rgba(255,255,255,0.4);">
                                <input type="hidden" name="hideeprofileuid" id="epuid" value=""/>
                                <thead>
                                    <tr>
                                        <td colspan="2">
                                            <label>Update Profile</label>
                                            <!--<label id="lbeditutil"></label>-->
                                        </td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%--<c:forEach var="row" items="${resultEditUtil.rows}" >--%>
                                    <tr>
                                        <td>
                                            Name:
                                        </td>
                                        <td>
                                            <input type="text" name="eprofilename" id="epnameid" value=""/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Profile picture:
                                        </td>
                                        <td>
                                            <input type="file" id="epfilepic" name="eprofilepic" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Email:
                                        </td>
                                        <td>
                                            <input type="text" name="eprofileemail" id="epemailid" value=""/>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Password:
                                        </td>
                                        <td>
                                            <input type="text" name="eprofilepassword" id="eppwdid" value=""/>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            Level:
                                        </td>
                                        <td>
                                            <select id="eplevelid" name="eplevel">
                                                <option value="KE" name="eprofilelevel" >Kamal_Analyst</option>
                                                <option value="KA" name="eprofilelevel" >Kamal_Admin</option>
                                                <option value="VE" name="eprofilelevel" >Voltus_Analyst</option>
                                                <option value="VA" name="eprofilelevel" >Voltus_Admin</option>
                                            </select>

                                        </td>
                                    </tr>
                                    <%--</c:forEach>--%>
                                </tbody>
                            </table>

                        </div>
                        <div class="modal-footer" style="background-color: #8cc63f;">

                            <input type="submit" id="UpdateProfile" class="login loginmodal" value="Update Changes" >
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <!-- Modal -->
        <!-- Open a window to show confirmation modal for delete User -->
        <div class="modal fade" id="userdelete-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
            <!--<form method="POST" action="DeleteUtility">-->
            <div class="modal-dialog" >
                <div class="modal-content">
                    <div class=" modal-header" style="border-bottom:1.5px solid #8cc63f;">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">Delete User</h4>
                        <label> User: </label>
                        <!--<label ><span>
                        <%--<c:out value="${utilDelID}"/>--%>
                        </span></label>-->
                        <label id="lbdeluid"></label>
                        <!--<input type="hidden" name="idDelUtil" value="${utilDelID}" >-->
                        <input type="hidden" id="inhidedeluid" name="idDelUser" value="" >
                    </div>

                    <div class="modal-body">
                        <label ><span>Do you want to delete this user ?</span></label>
                    </div>
                    <div class="modal-footer" style="background-color: #8cc63f;">
                        <input type="button" name="deleteUser" class="login loginmodal" value="Yes" onclick="deleteUser();">
                        <input type="button" class="login loginmodal" data-dismiss="modal" value="No" >
                    </div>
                </div>
            </div>
            <!--</form>-->
        </div> 
    </body>
</html>

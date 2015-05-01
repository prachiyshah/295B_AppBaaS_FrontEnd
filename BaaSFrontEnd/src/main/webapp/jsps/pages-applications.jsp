<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="org.json.JSONException"%>
<%@ page import="org.json.JSONObject"%>
<%@ page import="org.json.JSONArray"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="metaAndCss.jsp"%>
</head>
<body>
	<!-- START PAGE CONTAINER -->
	<div class="page-container">
		<!-- START PAGE SIDEBAR -->
		<%@ include file="sidebar.jsp"%>
		<!-- END PAGE SIDEBAR -->
		<!-- PAGE CONTENT -->
		<div class="page-content">

			<%@ include file="header.jsp"%>


			<!-- PAGE CONTENT WRAPPER -->
			<div class="page-content-wrap">
				<div class="row">
					<div class="col-md-12">

						<div class="panel panel-default">
							<div class="panel-body">
								<p>Create a new application by clicking the create
									application button below.</p>
								<form class="form-horizontal"
									action="pages-create-application.jsp">
									<div class="form-group">

										<div class="col-md-4">
											<button class="btn btn-success btn-block">
												<span class="fa fa-plus"></span> Create new application
											</button>
										</div>
									</div>
								</form>
							</div>
						</div>

					</div>
				</div>

				<div class="row">
					<%
                       		JSONObject jsonResponse = (JSONObject) session.getAttribute("applicationsJson");
                       		JSONArray jsonApp = new JSONArray();
                       		
                       		try{
                       		jsonApp = jsonResponse.getJSONArray("applications");
							int no_of_app = jsonApp.length();
                       		
                       		for(int i = 0; i < no_of_app ; i++){
                       		JSONObject app = new JSONObject();
                       		app = jsonApp.getJSONObject(i);
                       		JSONArray appServices = new JSONArray();
                       		appServices = app.getJSONArray("services");
                       		int no_of_services = appServices.length();			
                       		%>

					<div class="col-md-4">
						<!-- CONTACT ITEM -->
						<div class="panel panel-default">
							<div class="panel-body profile">
								<div class="profile-image">
									<img src="../assets/images/users/no-image.jpg" alt="Nadia Ali" />
								</div>
								<div class="profile-data">
									<div class="profile-data-name">
										Name:
										<%= app.getString("appName")  %></div>
									<div class="profile-data-title">
										Version:
										<%= app.getString("appVersion") %>
									</div>
									<div class="profile-data-title">
										Type:
										<%= app.getString("appType") %>
									</div>
								</div>

							</div>
							<div class="panel-body" style="font-size: 13px">
								<div class="contact-info">

									<p>
										<small>Description</small><br /><%=app.getString("appDesc") %></p>
									<% HashMap<String, String> map = new HashMap<String, String>() ; %>
									<%for(int j = 0; j < no_of_services; j++){
                                        	JSONObject service = new JSONObject();
                                        	service = appServices.getJSONObject(j);
                                        	map.put(service.getString("service_name").toString(),service.getString("service_name").toString());
                                        	System.out.println(service.getString("service_name").toString());
                                        	
                                        %>
									<p>
										<% }
									System.out.println("map size:"+map.size());
									
									 for(int x = 0; x < 4; x++){
										
										if(map.containsKey("UserManager"))
										{ %>
										<small>Service:</small> <%= map.get("UserManager") %></p>
										
											<% System.out.println(map.get("UserManager"));
											map.remove("UserManager");
										}
										else if(map.containsKey("ObjManager"))
										{ %>
										<small>Service:</small> <%= map.get("ObjManager") %></p>
										
											<% System.out.println(map.get("ObjManager"));
											map.remove("ObjManager");
										}
										else if(map.containsKey("AppManager"))
										{ %>
										<small>Service:</small> <%= map.get("AppManager") %></p>
										
											<% System.out.println(map.get("AppManager"));
											map.remove("AppManager");
										}
										else if(map.containsKey("NotificationManager"))
										{ %>
										<small>Service:</small> <%= map.get("NotificationManager") %></p>
										
											<% System.out.println(map.get("NotificationManager"));
											map.remove("NotificationManager");
										}
										else
										{ %>
										<small>Service:</small> not registered </p>
										<%
											System.out.println("Not Registered.");
										}	
										
									} %>
										
									
									<form name="appKey" method="get">
										<p>
											<small>App Key*:</small><br /><%= app.getString("appKey").toString() %></p>
										<%String value = app.getString("appKey").toString();
										session.setAttribute("appKey", value);
										%>
										<p>
											<small>App Data:</small><br /> *click <a
												href="
                          					 <c:url value="../UtilityServlet">
       										 <c:param name="action" value="<%=value%>"/>
        									 </c:url>">HERE:
												Data</a> to navigate application data
										</p>
										<p>
											<small>App Data:</small><br /> Click <a href = "pages-notification.jsp">HERE: Notification</a> to send notifications to registered users.
										</p>




									</form>
								</div>
							</div>
						</div>
						<!-- END CONTACT ITEM -->
					</div>

					<% }
                       		}
                       		catch(JSONException e){
                       			e.getStackTrace();
                       		}
                       		%>




				</div>
				
			</div>
			<!-- END PAGE CONTENT WRAPPER -->
		</div>
		<!-- END PAGE CONTENT -->
	</div>
	<!-- END PAGE CONTAINER -->

	<%@ include file="MessageBoxAndPreloads.jsp"%>
	<%@ include file="scripts.jsp"%>
</body>
</html>

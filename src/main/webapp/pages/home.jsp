<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.io.IOException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="java.sql.*, java.util.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%



%>

<%

String jdbcUrl = "jdbc:mysql://51.132.137.223:3306/isec_assessment2";
String dbUsername = "isec";
String dbPassword = "EUHHaYAmtzbv";
// Initialize variables
Connection conn = null;
PreparedStatement selectStmt = null;
PreparedStatement insertStmt = null;
PreparedStatement deleteStmt = null;
ResultSet rs = null;



try {
    // Database connection setup
 

    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);

    if (conn != null) {
        // SELECT query
        String selectQuery = "SELECT * FROM vehicle_service WHERE username=?";
        selectStmt = conn.prepareStatement(selectQuery);
        selectStmt.setString(1, "hello@gmail.com ");
        rs = selectStmt.executeQuery();

        // Handle the SELECT results here

        // INSERT query
        if (request.getParameter("submit") != null) {
    if (request.getSession().getAttribute("dataSubmitted") == null) {
        // ... (your existing code to add data to the database)
        String vehicleNo = request.getParameter("vehicleNo");
        String mileageString = request.getParameter("mileage");
        String location = request.getParameter("location");
        String message = request.getParameter("message");
        String username = request.getParameter("nameField");
        String timeString = request.getParameter("time");
        String dateInput = request.getParameter("date");

        java.util.Date userDate = null;
        Time time = null;

        try {
            SimpleDateFormat timeFormat = new SimpleDateFormat("hh a");
            java.util.Date parsedTime = timeFormat.parse(timeString);
            time = new Time(parsedTime.getTime());
        } catch (java.text.ParseException e) {
            // Handle parsing error if the input is not in the expected format
            e.printStackTrace();
        }

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        int mileage = 0; // Default value if mileageString is empty or invalid

        if (mileageString != null && !mileageString.isEmpty()) {
            try {
                userDate = dateFormat.parse(dateInput);
                mileage = Integer.parseInt(mileageString);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        // INSERT query
        String insertQuery = "INSERT INTO vehicle_service (date, time,location , vehicle_no,mileage , message, username) VALUES (?, ?, ?, ?, ?, ?, ?)";
        insertStmt = conn.prepareStatement(insertQuery);
        insertStmt.setDate(1, new java.sql.Date(userDate.getTime())); // User-provided date
        insertStmt.setTime(2, time); // Current time
        insertStmt.setString(3, location);
        insertStmt.setString(4, vehicleNo);
        insertStmt.setInt(5, mileage);
        insertStmt.setString(6, message);
        insertStmt.setString(7, username);

        System.out.println("Debug: SQL Query: " + insertQuery);

        System.out.println("Debug: Before executing INSERT query");

        int rowsAffected = insertStmt.executeUpdate();

        System.out.println("Debug: After executing INSERT query");

        if (rowsAffected > 0) {
            // Mark that data has been submitted in this session
            request.getSession().setAttribute("dataSubmitted", true);

            // After successfully adding data, perform a redirect to the same page
            response.sendRedirect(request.getContextPath() + "/pages/home.jsp");
            return; // Terminate the current request/response
        } else {
            // Handle the case where the insertion failed
            // You can add an error message here if needed
        }
    } else {
        // Handle the case where data has already been submitted in this session
        // You can add a message or redirect as needed
    }
}


        // DELETE query
        

        
        
       String deleteBookingId = request.getParameter("deleteBookingId");

		if (deleteBookingId != null && !deleteBookingId.isEmpty()) {
		    int bookingIdToDelete = Integer.parseInt(deleteBookingId);
		
		    String deleteQuery = "DELETE FROM vehicle_service WHERE booking_id=?";
		    deleteStmt = conn.prepareStatement(deleteQuery);
		    deleteStmt.setInt(1, bookingIdToDelete);
		
		    int rowsDeleted = deleteStmt.executeUpdate();
		
		    if (rowsDeleted > 0) {
		    	%>
		    	<script>
					alert("deteted");
					setTimeout(function() {
			            window.location.reload(); // Reload the page
			        }, 1000);
		
				</script>
				<% 
		    } else {
		    	%>
		    	<script>
					alert("failed");
				</script>
				<% 
		    }
		}

            
            
    }
    
} catch (ClassNotFoundException | SQLException e) {
    e.printStackTrace();
} 
%>
 
    
<%
        // Retrieve access_token and id_token from session attributes

        String access_token = (String) request.getSession().getAttribute("access_token");
        String id_token = (String) request.getSession().getAttribute("id_token");
        String jsonDataString = ""; // Initialize jsonDataString here


        // Check if the tokens exist in the session
         if (access_token != null && id_token != null) {
        	    String apiUrl = "https://api.asgardeo.io/t/projectwheelxgo/oauth2/userinfo";

        try {
            // Create a URL object
            URL url = new URL(apiUrl);

            // Open a connection to the URL
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();

            // Set the request method to GET
            connection.setRequestMethod("GET");

            // Set the "Authorization" header with the Bearer token
            connection.setRequestProperty("Authorization", "Bearer " + access_token);

            // Get the response code
            int responseCode = connection.getResponseCode();

            // Check if the response code indicates success (HTTP 200 OK)
            if (responseCode == HttpURLConnection.HTTP_OK) {
                // Create a BufferedReader to read the response
                BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                String inputLine;
                StringBuilder responseStringBuilder = new StringBuilder();

                // Read the response line by line
                while ((inputLine = in.readLine()) != null) {
                    responseStringBuilder.append(inputLine);
                }
                in.close();

                // Parse the JSON response
                JSONObject jsonResponse = new JSONObject(responseStringBuilder.toString());

                // Retrieve the desired data
                               

                String username = jsonResponse.getString("username");
                String givenName = jsonResponse.getString("given_name");
                String phone = jsonResponse.getString("phone_number");
                String email = jsonResponse.getString("email");                

                // Now you have the username, given_name, phone, and email data
                // You can use these values as needed
                

               %>
			 <script>
			 document.addEventListener("DOMContentLoaded", function() {
				    var username = '<%= username %> ' ;
				    var givenName = '<%= givenName %> ';
				    var phone = '<%= phone %> ';
				    var email = '<%= email %> ';
				

				    // Now you can use these JavaScript variables to update your HTML elements
				    document.getElementById("given_Name").textContent =   givenName;
				    document.getElementById("username").textContent = username;
				    document.getElementById("phone").textContent =  phone;
				    document.getElementById("email").textContent =  email;
				    
				    document.getElementById('submit').addEventListener('click', function () {
						 console.log("Button clicked");
		                 // Set the username as a hidden field value in the form
		                 document.getElementById('nameField').value = username;
		                 
		                 
		             });
				});
			 
			
			</script>
          <%       
         

            } else {
                // Handle error responses here
                out.println("HTTP Error: " + responseCode);
            }

            // Close the connection
            connection.disconnect();
        } catch (IOException e) {
            // Handle exceptions here
            e.printStackTrace();
        }
    } else {
        // Handle the case when either accessToken or idToken is null
        response.sendRedirect("../index.jsp");

    }
    %>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	
    <script src="https://use.fontawesome.com/3903c9d7fd.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.2/css/all.css" rel="stylesheet">
    

<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css	" rel="stylesheet">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js	"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js		"></script>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css	" rel="stylesheet">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js	"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js		"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
	<title>Home</title>
	<link rel="stylesheet" type="text/css" href="../Styles/home.css">
	<link rel="stylesheet" type="text/css" href="../Styles/nav.css">
	
	
	
</head>
<body>

<nav class="navbar">
  <div class="">

    <div class="navbar-header">
      <button class="navbar-toggler" data-toggle="open-navbar1">
        <span></span>
        <span></span>
        <span></span>
      </button>
      <a href="#">
        <div class="main-container">
	<img alt="" src="../Images/logo.png">
		</a>
	</div>
	</div>
 
    </div>

    <div class="navbar-menu" id="open-navbar1">
      <ul class="navbar-nav">
        <li class="active"><a href="#">Home</a></li>      
        <li><a href="#profile">Profile</a></li>
        <li><a href="#service">Service</a></li>
        <li><a href="#list">Info</a></li>
        <li><a href="#contact">Contact</a></li>
       <li><a href="#" id="logoutLink">Log out</a></li>
        
      </ul>
    </div>
  </div>
  </nav>

<div class="wrapper-menu">
<div class="menu-list">
<ul class="menu">
    <li class="menu_list">
        <a href="#text" class="side">home</a>
        <span class="front fas fa-home"></span>
    </li>
    <li class="menu_list">
        <span class="front fas fa-taxi"></span>
        <a href="#service" class="side">services</a>
    </li>
    <li class="menu_list">
        <span class="front fas fa-user"></span>
        <a href="#profile" class="side">profile</a>
    </li>
    <li class="menu_list">
        <span class="front fas fa-list"></span>
        <a href="#list" class="side">info</a>
    </li>
    <li class="menu_list">
        <span class="front fas fa-phone"></span>
        <a href="#contact" class="side">contact</a>
    </li>
</ul>
</div>

</div>
<section class="sec" id="text">

    <div class="card">
  <input type="radio" name="select" id="slide_1" checked>
    <input type="radio" name="select" id="slide_2" checked>
      <input type="radio" name="select" id="slide_3" checked>
     

       <input type="checkbox" id="slideImg">
       <div class="slider">
        <label for="slide_1" class="slide slide_1"></label>
        <label for="slide_2" class="slide slide_2"></label>
        <label for="slide_3" class="slide slide_3"></label>
      </div>

      <div class="inner_part">
        <label for="slideImg" class="img">
           <img class="img_1" src="https://c4.wallpaperflare.com/wallpaper/978/131/617/kiz-kulesi-turkey-istanbul-maiden-s-tower-wallpaper-preview.jpg">
  
        </label>
        <div class="content content_1">
          <div class="title">
            Hello!
            <h2 id="givenName"></h2>
          </div>
          <div class="text">
            Have a great journey with us!
            We ensure your safety

          </div>

        </div>
      </div>

       <div class="inner_part">
        <label for="slideImg" class="img">
           <img class="img_2" src="https://c4.wallpaperflare.com/wallpaper/649/96/56/ankara-cityscape-night-night-sky-wallpaper-preview.jpg">
 
        </label>
        <div class="content content_2">
          <div class="title">
            Save your ride here...
          </div>
          <div class="text">
           Make your reservation here.
            We give you the best experience

          </div>
          <button>Reserve</button>

        </div>
      </div>

       <div class="inner_part">
        <label for="slideImg" class="img">
           <img class="img_3" src="https://c4.wallpaperflare.com/wallpaper/620/34/558/turkey-izmir-mountains-wallpaper-preview.jpg">
 
        </label>
        <div class="content content_3">
          <div class="title">
            This is your choice...
          </div>
          <div class="text">
            Make your choice according to your preference...

          </div>
          <button>View</button>

        </div>
      </div>


    </div>

</section>
<section class="" id="profile">
	<div class="card-container">	
	<img class="round" src="https://randomuser.me/api/portraits/women/79.jpg" alt="user" />
	<h3>@<span id="given_Name"></span></h3>
	<h6>Username: <span id="username"></span></h6>
	<p> Email: <span id = "email"></span><br/> Phone: <span id = "phone"></span> <br/><span id = "country"></span></p>	
</div>
</section>
<div class="list" id="list">
    <div class="container table">
        <h2>Your Reservations </h2>

        <ul class="responsive-table">
            <li class="table-header">
                <div class="col col-1">Booking ID</div>
                <div class="col col-2">Date</div>
                <div class="col col-1">Time</div>
                <div class="col col-2">Location</div>
                <div class="col col-1">Vehicle No</div>
                <div class="col col-2">Mileage</div>
                <div class="col col-2">Message</div>
                <div class="col col-1">Action</div>
            </li>
           
            <%
                if (conn != null) {
                    java.util.Date currentDate = new java.util.Date(); // Get the current date

                    while (rs.next()) {
                        int bookingId = rs.getInt("booking_id");
                        Date date = rs.getDate("date");
                        Time time = rs.getTime("time");
                        String location = rs.getString("location");
                        String vehicleNo = rs.getString("vehicle_no");
                        int mileage = rs.getInt("mileage");
                        String message = rs.getString("message");

                        // Compare the reservation date with the current date
                        if (date.after(currentDate)) {
                            // Reservation is after the current date, show the delete button
            %>
                            <li class="table-row">
                                <div class="col col-1" data-label="BookinID"><%= bookingId %></div>
                                <div class="col col-2" data-label="Date"><%= date %></div>
                                <div class="col col-1" data-label="Time"><%= time %></div>
                                <div class="col col-2" data-label="Location"><%= location  %></div>
                                <div class="col col-1" data-label="Vehicle_no"><%= vehicleNo %></div>
                                <div class="col col-2" data-label="Mileage"><%= mileage %></div>
                                <div class="col col-2" data-label="Message"><%= message %></div>
                                <div class="col col-1" data-label="Action">
                                <form action="" method="POST">
								    <input type="hidden" name="deleteBookingId" id="bookingID" value="">
								    <button type="button" class="deleteButton" onclick="setBookingId(<%= bookingId %>);" name="deleteButton">
								        <span class="front fas fa-trash"></span>
								    </button>
								</form>
								<script>
								    function setBookingId(bookingId) {
								        document.getElementById('bookingID').value = bookingId;
								        if (confirm("Are you sure you want to delete this reservation?")) {
								            // Submit the form when the user confirms
								            document.forms[0].submit();
								        }
								    }
								</script>

                                </div>
                            </li>
            <%
                        } else {
                            // Reservation is on or before the current date, show the "eye" icon
            %>
                            <li class="table-row">
                                <div class="col col-1" data-label="BookinID"><%= bookingId %></div>
                                <div class="col col-2" data-label="Date"><%= date %></div>
                                <div class="col col-1" data-label="Time"><%= time %></div>
                                <div class="col col-2" data-label="Location"><%= location  %></div>
                                <div class="col col-1" data-label="Vehicle_no"><%= vehicleNo %></div>
                                <div class="col col-2" data-label="Mileage"><%= mileage %></div>
                                <div class="col col-2" data-label="Message"><%= message %></div>
                                <div class="col col-1" data-label="Action">
                                    <span class="front fas fa-eye"></span>
                                </div>
                            </li>
            <%
                        }
                    }
                }
            %>
        </ul>
    </div>
</section>


<section class="sec" id="service">

	<div class="register">
    <div class="row">
     
        <div class="col-md-9 register-container">
            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                    <h3 class="register-heading">Make Your Reservation Here</h3>
                    <form action="" method="POST">
                    <div class="row register-form">
                        <div class="col-md-6">
                            <div class="form-group">
                                <input type="date" class="form-control"   name="date" required/>
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" placeholder="Vehicle Registration Number *"  name="vehicleNo" required/>
                            </div>
                            <div class="form-group">
                                <input type="number" class="form-control" placeholder="Current Mileage *"  name="mileage" required/>
                            </div>
                            <div class="form-group">
                                <select class="form-control" id="location" name="location"  required>
								    <option selected>Preferred Location*</option>
								    <option value="Colombo">Colombo</option>
						            <option value="Gampaha">Gampaha</option>
						            <option value="Kalutara">Kalutara</option>
						            <option value="Kandy">Kandy</option>
						            <option value="Matale">Matale</option>
						            <option value="Nuwara Eliya">Nuwara Eliya</option>
						            <option value="Galle">Galle</option>
						            <option value="Matara">Matara</option>
						            <option value="Hambantota">Hambantota</option>
						            <option value="Jaffna">Jaffna</option>
						            <option value="Kilinochchi">Kilinochchi</option>
						            <option value="Mannar">Mannar</option>
						            <option value="Vavuniya">Vavuniya</option>
						            <option value="Mullaitivu">Mullaitivu</option>
						            <option value="Batticaloa">Batticaloa</option>
						            <option value="Ampara">Ampara</option>
						            <option value="Trincomalee">Trincomalee</option>
						            <option value="Kurunegala">Kurunegala</option>
						            <option value="Puttalam">Puttalam</option>
						            <option value="Anuradhapura">Anuradhapura</option>
						            <option value="Polonnaruwa">Polonnaruwa</option>
						            <option value="Badulla">Badulla</option>
						            <option value="Monaragala">Monaragala</option>
						            <option value="Ratnapura">Ratnapura</option>
						            <option value="Kegalle">Kegalle</option>
								  </select>
                                
                            </div>
                        </div>
                        <div class="col-md-6">
                            
                            <div class="form-group">
                                <select class="form-control" id="time" name="time" type="time" required>
								    <option selected>Preferred Time*</option>
								    <option value="10 AM">10 AM</option>
						            <option value="11 AM">11 AM</option>
						            <option value="12 AM">12 AM</option>
						            
								  </select>
                                
                            </div>
                            
                            <div class="form-group">
                                <textarea  class="form-control" placeholder="Enter Your Message "  name="message"></textarea>
                            </div>
                            <input type="hidden" id="nameField" name="nameField" value="">
                            
                            <button class="btnRegister"  id="submit" name="submit" >ADD</button>
                        </div>
                    </div>
                    </form>
                </div>
            </div>
        </div>
    

</div>
</div>

</section>


<section class="sec" id="contact">
	   
</section>
<footer>
	<p>
		Created with <i class="fa fa-heart"></i> by
		<a  href="">Ishini Hettiarachchi</a>
		- Read how I created this
		<a target="#" href="">here</a>
		- Design made by
		<a  href="">HD Creations</a>
	</p>
</footer>

</body>
</html>
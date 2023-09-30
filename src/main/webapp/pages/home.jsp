<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.io.IOException" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="java.sql.*, java.util.Date" %>
<%
// Database connection variables
String jdbcUrl = "jdbc:mysql://51.132.137.223:3306/isec_assessment2";
String dbUsername = "isec";
String dbPassword = "EUHHaYAmtzbv";
Connection conn = null;

// SQL query to retrieve data from the vehicle_service table
String sqlQuery = "SELECT * FROM vehicle_service WHERE username= ?";


boolean isConnected = false; // Initialize a flag to check the connection status

try {
    // Register the JDBC driver (This is optional in modern JDBC drivers)
		Class.forName("com.mysql.cj.jdbc.Driver");

    // Create a database connection
    conn = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);

    // Check if the connection is successful
    if (conn != null) {
        isConnected = true;
    }

} catch (SQLException e) {
    e.printStackTrace();
    // Handle any database connection errors here
} finally {
    try {
        if (conn != null) {
            conn.close(); // Close the database connection when done
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
}

	

%>    
    
    
<%
        // Retrieve access_token and id_token from session attributes
        String introUrl = "https://api.asgardeo.io/t/projectwheelxgo/oauth2/introspect";

        String access_token = (String) request.getSession().getAttribute("access_token");
        String id_token = (String) request.getSession().getAttribute("id_token");
        String jsonDataString = ""; // Initialize jsonDataString here


        // Check if the tokens exist in the session
         if (access_token != null && id_token != null) {
        	    String apiUrl = "https://api.asgardeo.io/t/learnmasith/oauth2/userinfo";

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
                String phone = jsonResponse.optString("phone", "N/A");
                String email = jsonResponse.getString("email");

                // Now you have the username, given_name, phone, and email data
                // You can use these values as needed
               %>
			 <script>
			 document.addEventListener("DOMContentLoaded", function() {
				    var username = '<%= username %>';
				    var givenName = '<%= givenName %>';
				    var phone = '<%= phone %>';
				    var email = '<%= email %>';

				    // Now you can use these JavaScript variables to update your HTML elements
				    document.getElementById("username").textContent =  username;
				    document.getElementById("givenName").textContent =  givenName;
				    document.getElementById("phone").textContent =  phone;
				    document.getElementById("email").textContent =  email;
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
    	out.println("Access token or ID token is missing.");
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

    

</head>

<body>
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
<div class="main-container">
	<img alt="" src="../Images/logo.png">
</div>
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

<section class="sec" id="list">
	<div class="container">
  <h2>Your Reservations <small></small></h2>
  <ul class="responsive-table">
    <li class="table-header">
      <div class="col col-1">Job Id</div>
      <div class="col col-2">Customer Name</div>
      <div class="col col-3">Amount Due</div>
     
    </li>
    <li class="table-row">
      <div class="col col-1" data-label="Job Id">42235</div>
      <div class="col col-2" data-label="Customer Name">John Doe</div>
      <div class="col col-3" data-label="Amount">$350</div>
      <div class="col col-3" data-label="Amount"><span class="front fas fa-trash"></span></div>
     
    </li>
    <li class="table-row">
      <div class="col col-1" data-label="Job Id">42442</div>
      <div class="col col-2" data-label="Customer Name">Jennifer Smith</div>
      <div class="col col-3" data-label="Amount">$220</div>
      <div class="col col-3" data-label="Amount"><span class="front fas fa-trash"></div>
      
    </li>
    <li class="table-row">
      <div class="col col-1" data-label="Job Id">42257</div>
      <div class="col col-2" data-label="Customer Name">John Smith</div>
      <div class="col col-3" data-label="Amount">$341</div>
      <div class="col col-3" data-label="Amount"><span class="front fas fa-trash"></div>
      
    </li>
    <li class="table-row">
      <div class="col col-1" data-label="Job Id">42311</div>
      <div class="col col-2" data-label="Customer Name">John Carpenter</div>
      <div class="col col-3" data-label="Amount">$115</div>
      <div class="col col-3" data-label="Amount"><span class="front fas fa-trash"></div>
      
    </li>
    
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
                    <div class="row register-form">
                        <div class="col-md-6">
                            
                            <div class="form-group">
                                <input type="text" class="form-control" placeholder="Date of the service reservation *" value="" />
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" placeholder="Vehicle Registration Number *" value="" />
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" placeholder="Current Mileage *" value="" />
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" placeholder="Preferred Location*" value="" />
                                
                            </div>
                        </div>
                        <div class="col-md-6">
                            
                            <div class="form-group">
                                <select class="form-control">
                                    <option class="hidden" selected disabled>Please select your Time</option>
                                    <option>10 AM</option>
                                    <option>11 AM</option>
                                    <option>12 PM</option>
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <textarea  class="form-control" placeholder="Enter Your Message *" value="" ></textarea>
                            </div>
                            <button class="btnRegister">ADD</button>
                        </div>
                    </div>
                </div>
             
            </div>
        </div>
    

</div>
</div>

</section>

<section class="sec" id="profile">
	<div class="card-container">
	
	<img class="round" src="https://randomuser.me/api/portraits/women/79.jpg" alt="user" />
	<h3>@<span id="givenName"></span></h3>
	<h6><span id="username"></h6>
	<p> <span id = 'email'><br/> <span id = 'phone'> <br/>Sri Lanka</p>
	
	
</div>
</section>
<section class="sec" id="contact">
	   
</section>
<footer>
	<p>
		Created with <i class="fa fa-heart"></i> by
		<a target="_blank" href="https://florin-pop.com">Florin Pop</a>
		- Read how I created this
		<a target="_blank" href="https://florin-pop.com/blog/2019/04/profile-card-design">here</a>
		- Design made by
		<a target="_blank" href="https://dribbble.com/shots/6276930-Profile-Card-UI-Design">Ildiesign</a>
	</p>
</footer>

</body>
</html>
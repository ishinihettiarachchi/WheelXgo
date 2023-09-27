<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="../Styles/service.css">

<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css	" rel="stylesheet">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js	"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js		"></script>
</head>
<body>
<div class="register">
    <div class="row">
     
        <div class="col-md-9 register-container">
            
            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                    <h3 class="register-heading">Make Your Reservation Here</h3>
                    <div class="row register-form">
                        <div class="col-md-6">
                            <div class="form-group">
                                <input type="text" class="form-control" placeholder="Name *" value="" />
                            </div>
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
                                <input type="email" class="form-control" placeholder="Your Email *" value="" />
                            </div>
                            <div class="form-group">
                                <input type="text" minlength="10" maxlength="10" name="txtEmpPhone" class="form-control" placeholder="Your Phone *" value="" />
                            </div>
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
</body>
</html>
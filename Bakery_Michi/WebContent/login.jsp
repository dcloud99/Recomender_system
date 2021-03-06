<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Bakery Michi</title>

<!-- Font Awesome  -->
  <script defer src="https://use.fontawesome.com/releases/v5.8.1/js/all.js"
    integrity="sha384-g5uSoOSBd7KkhAMlnQILrecXvzst9TdC09/VM+pjDTCM+1il8RHz5fKANTFFb+gQ"
    crossorigin="anonymous"></script>

<!-- Bootstrap core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/shop-homepage.css" rel="stylesheet">

</head>

<body>
	<!-- Navigation -->
	<jsp:include page="navbar.jsp"></jsp:include>

	<!-- Page Content -->
	<div class="container py-5 ">
		<div class="row ">
			<div class="col-md-12">
				<h2 class="text-center text-white mb-4">Bootstrap 4 Login Form</h2>
				<div class="row">
					<div class="col-md-6 mx-auto" style="margin-bottom: 7em !important;">

						<!-- form card login -->
						<div class="card rounded-0 ">
							<div class="card-header">
								<h3 class="mb-0">Login</h3>
							</div>
							<div class="card-body">
								<form action="Login" class="form" role="form" autocomplete="off"
									id="formLogin" novalidate="" method="POST">
									<div class="form-group">
										<label for="uname1">Username</label> <input type="text"
											class="form-control form-control-lg rounded-0"
											name="username" id="username" required="">
										<div class="invalid-feedback">Oops, you missed this one.</div>
									</div>
									<div class="form-group">
										<label>Password</label> <input type="password"
											class="form-control form-control-lg rounded-0" id="password"
											name="password" required="" autocomplete="new-password">
											<br/>${message}
										<div class="invalid-feedback">Enter your password too!</div>
									</div>
									<button type="submit"
										class="btn btn-success btn-lg float-right" id="btnLogin">Login</button>
								</form>
							</div>
							<!--/card-block-->
						</div>
						<!-- /form card login -->

					</div>
				</div>
				<!--/row-->

			</div>
			<!--/col-->
		</div>
		<!--/row-->
	</div>
	<!-- /.container -->

	<!-- Footer -->
	<jsp:include page="footer.jsp"></jsp:include>
	

	<!-- Bootstrap core JavaScript -->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="js/ecommerce.js"></script>
	
	<script
  	src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script type="text/javascript"
    src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.0/dist/jquery.validate.min.js"></script>
	
	<script type="text/javascript">
		$(document).ready(function() {
			updateItemsCount();
		});
	</script>
	
	<script type="text/javascript">
 
    $(document).ready(function() {
        $("#formLogin").validate({
            rules: {
                email: {
                    required: true,
                    username: true
                },
         
                password: "required",
            },
             
            messages: {
                username: {
                    required: "Please enter email",
                    username: "Please enter a valid email address"
                },
                 
                password: "Please enter password"
            }
        });
 
    });
</script>
	
</body>
</html>
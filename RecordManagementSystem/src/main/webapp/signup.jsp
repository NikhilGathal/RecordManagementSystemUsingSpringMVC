<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Signup Page</title>
<link rel="icon" type="image/png" href="https://static.thenounproject.com/png/117741-200.png">

<style>
body {
	font-family: sans-serif;
	margin: 0;
	padding: 10px;
}

.container {
	width: 400px;
	margin: 0 auto;
	border: 1px solid #ccc;
	padding: 20px;
	border-radius: 5px;
}

h1 {
	text-align: center;
}

label {
	display: block;
	margin-bottom: 5px;
}

input[type="text"], input[type="email"], input[type="password"], input[type="number"]
	{
	width: 90%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 3px;
	margin-bottom: 10px;
}

#button {
	background-color: #4CAF50;
	color: white;
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

#button:hover {
	opacity: 0.8;
}

.checkbox-container {
	display: inline-block; /* Places checkboxes side by side */
	margin-right: 45px; /* Adds space between checkboxes */
	margin-bottom: 0px; /* Adds some spacing for better appearance */
	margin-top: 10px;
}

.checkbox-container label {
	margin-left: 5px; /* Adds space between checkbox and label */
}
</style>

</head>


<script>
function validateForm(event) {
    // Prevent form submission for validation
    event.preventDefault();

    // Get form elements
    const name = document.getElementById("name").value.trim();
    const email = document.getElementById("email").value.trim();
    const address = document.getElementById("address").value.trim();
    const phone = document.getElementById("phone").value.trim();
    const fees = parseFloat(document.getElementById("fees").value.trim());
    const courses = document.querySelectorAll("input[type='checkbox']:checked");

    // Check if any field is empty or no course is selected
    if (!name || !email || !address || !phone || isNaN(fees) || courses.length === 0) {
        alert("All fields are mandatory. Please fill out all fields.");
        return false; // Prevent form submission
    }

    // Calculate total course fees based on selected checkboxes
    let totalCourseFees = 0;
    courses.forEach(course => {
        const courseFee = parseFloat(course.getAttribute("data-fee"));
        if (!isNaN(courseFee)) {
            totalCourseFees += courseFee;
        }
    });

    // Validate if entered fees are greater than the total course fees
    if (fees > totalCourseFees) {
        alert(`The entered fees (${fees} INR) exceed the total selected course fees (${totalCourseFees} INR).`);
        return false; // Prevent form submission
    }

    // Submit the form if validation passes
    event.target.submit();
}
</script>


<body>


	<%
	String message = (String) request.getAttribute("message");
	%>
	<%
	if (message != null) {
	%>
	<h1><%=message%></h1>
	<%
	} else {
	%>
	<h1 align="center"><%="Please fill the details"%></h1>
	<%
	}
	%>


	<div class="container">

		<form action="signup" method="post" onsubmit="validateForm(event)">
			<label for="name">Name:</label> <input type="text" id="name"
				name="name" placeholder="Enter name"> <br> 
				<label for="email">Email: </label> 
				<input type="email" id="email"
				name="email" placeholder="Enter email"> <br> 
				
				<label for="address">Address:</label> <input type="text" id="address"
				name="address" placeholder="Enter address"> <br>


<div>
    <div class="checkbox-container">
        <input type="checkbox" id="course1" name="course1" value="Java" data-fee="<%= application.getInitParameter("Java") %>">
        <label for="course1">Java</label>
        <span class="fees">Fees: 
            <%= application.getInitParameter("Java") %> INR
        </span>
    </div>
    <div class="checkbox-container">
        <input type="checkbox" id="course2" name="course2" value="Python" data-fee="<%= application.getInitParameter("Python") %>">
        <label for="course2">Python</label>
        <span class="fees">Fees: 
            <%= application.getInitParameter("Python") %> INR
        </span>
    </div>
    <div class="checkbox-container">
        <input type="checkbox" id="course3" name="course3" value="MERN" data-fee="<%= application.getInitParameter("MERN") %>">
        <label for="course3">MERN</label>
        <span class="fees">Fees: 
            <%= application.getInitParameter("MERN") %> INR
        </span>
    </div>
    <div class="checkbox-container">
        <input type="checkbox" id="course4" name="course4" value="Devops" data-fee="<%= application.getInitParameter("Devops") %>">
        <label for="course4">Devops</label>
        <span class="fees">Fees: 
            <%= application.getInitParameter("Devops") %> INR
        </span>
    </div>
</div>


			<br> <label for="phone">Phone:</label> <input type="number"
				id="phone" name="phone" placeholder="Enter phoneno"> <br>
			<br> <label for="fees">Fees:</label> <input type="number"
				id="fees" name="fees" placeholder="Enter fees paid"> <br>
			<br> <input id="button" type="submit" value="Submit">
		</form>
	</div>

</body>
</html>
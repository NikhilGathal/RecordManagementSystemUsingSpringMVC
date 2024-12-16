<%@page import="RecordManagementSystem.dto.*"%>
<%@page import="java.util.List"%>
<%@ page isELIgnored="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Page</title>

    <style>

body {
  font-family: sans-serif;
  margin: 0;
  padding: 20px;
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
  position:relative;
  left : 10px;
}

.checkbox-group {
    display: flex;
    flex-wrap: wrap; /* Ensures they wrap to the next line if the screen width is too small */
    gap: 15px; /* Space between items */
}

.checkbox-group label {
    margin-left: 5px;
}

input[type="text"],
input[type="email"],
input[type="password"] {
  width: 90%;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 3px;
  margin-bottom: 10px;
}

button {
  background-color: #4CAF50;
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

button:hover {
  opacity: 0.8;
}

    </style>



</head>






<body>
	<%
		String message = (String) request.getAttribute("message");
		%>
		<h1 align="center"> <%=message %>  </h1>
		<%Student student = (Student) request.getAttribute("student");  %>
		
		
				<div class="container">
			<form action="edit" method="post" onsubmit="return validateForm()"> 
				<label>Id:</label>
				<input type="text" name="id" value="<%=student.getId()%>" readonly="readonly">
				<br>

				<label for="name">Name:</label>
				<input type="text" id="name" name="name" value="<%=student.getName()%>" placeholder="Enter name" required>
				<br>

				<label for="email">Email: </label> 
				<input type="email" id="email" name="email" value="<%=student.getEmail() != null ? student.getEmail() : "" %>" placeholder="Enter email" required>
				<br>

				<label for="course">Course:</label>
				<input type="text" id="course" name="course" value="<%=student.getCourse()%>" required>
				<br>

				<div class="checkbox-group">
					<div>
						<input type="checkbox" id="course1" name="course1" value="Java" 
							<%= student.getCourse().contains("Java") ? "checked readonly" : "" %> />
						<label for="course1">Java</label>
					</div>
					<div>
						<input type="checkbox" id="course2" name="course2" value="Python" 
							<%= student.getCourse().contains("Python") ? "checked readonly" : "" %> />
						<label for="course2">Python</label>
					</div>
					<div>
						<input type="checkbox" id="course3" name="course3" value="MERN" 
							<%= student.getCourse().contains("MERN") ? "checked readonly" : "" %> />
						<label for="course3">MERN</label>
					</div>
					<div>
						<input type="checkbox" id="course4" name="course4" value="Devops" 
							<%= student.getCourse().contains("Devops") ? "checked readonly" : "" %> />
						<label for="course4">Devops</label>
					</div>
				</div>

				<br>
				<label for="fees">Total Fees:</label>
				<input type="text" id="fees" value="<%=student.getFees()%>" name="fees" placeholder="Enter fees" readonly="readonly">
				<br>

				<label for="address">Address:</label>
				<input type="text" id="address" value="<%=student.getAddress()%>" name="address" placeholder="Enter address" required>
				<br>

				<label for="phone">Phone:</label>
				<input type="text" id="phone" value="<%=student.getPhone()%>" name="phone" placeholder="Enter phoneno" required>
				<br>

				<label for="paid">Paidfees:</label>
				<input type="text" id="paid" value="<%=student.getPaidfees()%>" name="paidfees" placeholder="Enter Paidfees" required>
				<br>

				<label for="remain">Remainfees:</label>
				<input type="text" id="remain" value="<%=student.getRemainfees()%>" name="remainfees" placeholder="Enter remainfees" readonly="readonly">
				<br><br>

				<button type="submit">Save</button>
			</form>
		</div>

<script>





function validateForm() {
	// Get all required fields
	const requiredFields = document.querySelectorAll('input[required]');
	let isValid = true;

	// Check if any required field is empty
	requiredFields.forEach(function(field) {
		if (field.value.trim() === "") {
			isValid = false;
			field.style.border = "2px solid red";  // Optional: Add red border to indicate error
		} else {
			field.style.border = "";  // Remove error border if field is filled
		}
	});

	if (!isValid) {
		alert("Please fill in all required fields.");
	}

	// Return false if validation fails, preventing form submission
	return isValid;
}
const courseFees = {
	    "Java": 40000,
	    "Python": 50000,
	    "MERN": 60000,
	    "Devops": 70000
	};

	let previousPaidFees = parseFloat(document.getElementById("paid").value) || 0;  // Example: already paid fees (This will come from the "paid" input or DB)
	let selectedFees = 0;  // This will track the fees of newly selected courses

	// Update the total fees and remaining fees when checkboxes change
	function updateFees() {
	    selectedFees = 0;

	    // Check which courses are selected and update the fees
	    if (document.getElementById("course1").checked) {
	        selectedFees += courseFees["Java"];
	    }
	    if (document.getElementById("course2").checked) {
	        selectedFees += courseFees["Python"];
	    }
	    if (document.getElementById("course3").checked) {
	        selectedFees += courseFees["MERN"];
	    }
	    if (document.getElementById("course4").checked) {
	        selectedFees += courseFees["Devops"];
	    }

	    // Update the total fees as the sum of previously paid fees and newly selected course fees
	    const totalFees = selectedFees ;
	    document.getElementById("fees").value = totalFees;

	    // Update remaining fees after recalculating total fees
	    updateRemainFees();
	}

	// Update the remaining fees based on total fees and paid fees
	function updateRemainFees() {
	    const totalFees = parseFloat(document.getElementById("fees").value) || 0;
	    const paidFees = parseFloat(document.getElementById("paid").value) || 0;
	    const remainFees = totalFees - paidFees;

	    // Update the remainfees field with the calculated value
	    document.getElementById("remain").value = remainFees;
	}

	// Validate the paid fees to ensure they do not exceed the remaining balance
	function validatePaidFees() {
	    const totalFees = parseFloat(document.getElementById("fees").value) || 0;
	    const paidFees = parseFloat(document.getElementById("paid").value) || 0;

	    // Calculate the remaining balance by subtracting already paid fees from the total course fees
	    const remainingFees = totalFees - previousPaidFees;

	    // Check if the paid fees are greater than the allowed remaining fees (course fee - already paid fees)
	if (paidFees > remainingFees) {
		
		console.log(  paidFees , remainingFees  )  
	  alert(`Paid fees \${paidFees} cannot exceed the remaining fees \${remainingFees}.`);
        document.getElementById("paid").value = "";  // Clear the paid fees field
        return false;  
				}
	    return true;  // Allow form submission
	}
	
	document.addEventListener('DOMContentLoaded', function() {
	    const checkboxes = document.querySelectorAll('input[type="checkbox"]');

	    checkboxes.forEach(function(checkbox) {
	        // If the course is selected (checked), make it readonly (non-interactive)
	        if (checkbox.checked) {
	            checkbox.addEventListener('click', function(event) {
	                event.preventDefault(); // Prevent unchecking
	            });
	        }
	    });
	});


	window.onload = function() {
	    // Initialize total fees and remaining fees on page load based on selected courses
	    updateFees();

	    // Add event listeners for checkbox changes
	    const checkboxes = document.querySelectorAll('input[type="checkbox"]');
	    checkboxes.forEach(function(checkbox) {
	        checkbox.addEventListener('change', updateFees);
	    });

	    // Add event listener for paidfees field change
	    document.getElementById("paid").addEventListener('input', updateRemainFees);

	    // Form submission event
	    const form = document.querySelector('form');  // Select the form
	    form.onsubmit = function(event) {
	        // Run validation on form submit
	        if (!validatePaidFees()) {
	            event.preventDefault();  // Stop form submission if validation fails
	        }
	    };
	};

</script>
</body>
</html>
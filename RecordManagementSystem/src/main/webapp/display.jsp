<%@page import="RecordManagementSystem.dto.*"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home Page</title>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<style>
.students {
    width: 100%;
    margin: 20px auto;
    font-family: Arial, sans-serif;
    box-sizing: border-box;
}

/* Header row styling */
.header-row {
    display: flex;
    font-weight: bold;
    background-color: #f4f4f4;
    padding: 10px;
    border-bottom: 2px solid #ccc;
}

/* Data row styling */
.data-row {
    display: flex;
    padding: 10px;
    border-bottom: 1px solid #ddd;
    align-items: center; /* Vertical alignment */
}

/* Columns (both header and data) */
.header-row div,
.data-row div {
    padding: 5px 10px; /* Add space inside cells */
    text-align: left; /* Align content to the left */
    overflow: hidden; /* Prevent content overflow */
    text-overflow: ellipsis; /* Show ellipsis for long text */
    white-space: nowrap; /* Prevent wrapping */
}

/* Explicit column widths for better alignment */
.header-row div:nth-child(1),
.data-row div:nth-child(1) {
    flex: 0 0 5%; /* ID column */
}

.data-row div:nth-child(1) 
{
margin-left :10px;
}


.header-row div:nth-child(2),
.data-row div:nth-child(2) {
    flex: 0 0 15%; /* Name column */
}

.header-row div:nth-child(3),
.data-row div:nth-child(3) {
    flex: 0 0 20%; /* Address column */
}

.header-row div:nth-child(4),
.data-row div:nth-child(4) {
    flex: 0 0 15%; /* Email column */
}
.data-row div:nth-child(4) ,.data-row div:nth-child(5)
{
flex: 0 0 30%;
} 
.header-row div:nth-child(4),
.data-row div:nth-child(4) {
    flex: 0 0 15%; /* Email column width */
    white-space: normal; /* Allow text wrapping */
    overflow: visible; /* Ensure text is not cut off */
    text-overflow: unset; /* Remove ellipsis truncation */
    word-break: break-word; /* Break long email addresses if needed */
}


.header-row div:nth-child(5),
.data-row div:nth-child(5) {
    flex: 0 0 10%; /* Course column */
}

.header-row div:nth-child(6),
.data-row div:nth-child(6) {
 text-align: center; 
    flex: 0 0 10%; /* Phone column */
}

.header-row div:nth-child(7),
.data-row div:nth-child(7),
.header-row div:nth-child(8),
.data-row div:nth-child(8),
.header-row div:nth-child(9),
.data-row div:nth-child(9) {

    flex: 0 0 10%; /* Fees columns */
}
.header-row div:nth-child(7),
.header-row div:nth-child(8),
.header-row div:nth-child(9)
 { text-align: center;

   
}

/* Actions column */
.header-row div:nth-child(10),
.data-row div:nth-child(10) {
    flex: 0 0 15%;
    text-align: center; /* Center-align the content */
}

/* Styling for action links */
.data-row a {
    text-decoration: none;
    margin-right: 10px;
}

.data-row a:first-of-type {
    color: red; /* Delete link */
}

.data-row a:last-of-type {
    color: blue; /* Update link */
}

h1 {
    color: brown;
}


.header-row div,
.data-row div {
    padding: 5px 10px;
    text-align: left;
    overflow: visible;  /* Allow overflow of content */
    text-overflow: unset;  /* Disable ellipsis truncation */
    white-space: normal;  /* Allow text wrapping */
}

/* Button styling */
button {
    padding: 10px 20px;
    margin: 5px;
    background-color: #4CAF50; /* Green background */
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
}

button:hover {
    background-color: #45a049; /* Darker green when hovering */
}

#l {
    background-color: #f44336; /* Red background for Logout */
}

#l:hover {
    background-color: #e53935; /* Darker red when hovering */
}

#s {
    background-color: #008CBA; /* Blue background for Add New Student */
}

#s:hover {
    background-color: #006994; /* Darker blue when hovering */
}
</style>
</head>
<body>

	<div class="container">
		<h1>Student List</h1>

		<button id="l" onclick="redirectToFirstPage()">Logout</button>
		<button id="s" onclick="redirectToSecondPage()">Add New
			Student</button>

		<br>
		<br>

		<!-- JavaScript function to redirect -->
		<script>
			function redirectToSecondPage() {
				window.location.href = 'signup.jsp';
			}

			function redirectToFirstPage() {
				window.location.href = 'login.jsp';
			}
		</script>

		<%
    List<Student> students = (List<Student>) request.getAttribute("list");
    if (students != null && !students.isEmpty()) {
%>
    <div class="header-row" style="display: flex; font-weight: bold; margin-bottom: 10px;">
        <div style="flex: 1;">ID</div>
        <div style="flex: 2;">Name</div>
        <div style="flex: 2;">Address</div>
        <div style="flex: 2;">Email</div>
        <div style="flex: 1.5;">Course</div>
        <div style="flex: 1.5;">Phone</div>
        <div style="flex: 1.5;">Total Fees</div>
        <div style="flex: 1.5;">Paid Fees</div>
        <div style="flex: 1.5;">Remaining Fees</div>
        <div style="flex: 2;">Actions</div>
    </div>

    <% for (Student student : students) { %>
        <div class="data-row" style="display: flex; border-bottom: 1px solid #ccc; padding: 5px 0;">
            <div style="flex: 1;"><%= student.getId() %></div>
            <div style="flex: 2;"><%= student.getName() %></div>
            <div style="flex: 2;"><%= student.getAddress() %></div>
            <div style="flex: 2;"><%= student.getEmail() %></div>
            <div style="flex: 1.5;"><%= student.getCourse() %></div>
            <div style="flex: 1.5;"><%= student.getPhone() %></div>
            <div style="flex: 1.5;"><%= student.getFees() %></div>
            <div style="flex: 1.5;"><%= student.getPaidfees() %></div>
            <div style="flex: 1.5;"><%= student.getRemainfees() %></div>
            <div style="flex: 2;">
                <a href="delete?id=<%= student.getId() %>" style="margin-right: 10px; color: red;">Delete</a>
                <a href="update?id=<%= student.getId() %>" style="color: blue;">Update</a>
            </div>
        </div>
    <% } %>
<%
    } else {
%>
    <h1 style="text-align: center;">No students found.</h1>
<%
    }
%>

</body>
</html>

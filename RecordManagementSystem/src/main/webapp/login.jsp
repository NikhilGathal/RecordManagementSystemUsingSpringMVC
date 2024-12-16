<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>

<style>
    body {
  font-family: sans-serif;
  margin: 0;
  padding: 20px;
  background-color: #f2f2f2;
}

.container {
  width: 400px;
  margin: 0 auto;
  border: 1px solid #ccc;
  padding: 20px;
  border-radius: 5px;
  background-color: #fff;
}

h1 {
  text-align: center;
}

label {
  display: block;
  margin-bottom: 5px;
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

.remember {
  display: flex;
  align-items: center;
  margin-bottom: 10px;
}

.new-user {
  text-align: center;
  font-size: smaller;
}

  </style>


</head>
<body>


	
<%
    // Retrieve the "message" attribute from the request scope
    String message = (String) request.getAttribute("message");
%>

<% 
    // Check if "message" is not null and display it
    if (message != null) { 
%>
    <h1><%= message %></h1>
<% 
    } else { 
%>
    <h1><%= "Please Login" %></h1>
<% 
    } 
%>



 <div class="container">
  
    <form action="login" method="post">
      <label for="email">Email:</label>
      <input type="email" id="email" name="email" placeholder="Enter your email" required>
      <br>
      <label for="password">Password:</label>
      <input type="password" id="password" name="password" placeholder="Enter your password" required>
      <br>
      <br>
     
      <br>
      <button type="submit">Log In</button>
      <br>
      
    </form>
  </div>




</body>
</html>
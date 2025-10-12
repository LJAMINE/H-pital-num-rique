<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Register as Patient</title></head>
<body>
<h2>Patient Registration</h2>
<form method="post" action="register-patient">
    Email: <input type="email" name="email" required><br>
    Password: <input type="text" name="password" required><br>
    First Name: <input type="text" name="prenom" required><br>
    Last Name: <input type="text" name="nom" required><br>
    Weight: <input type="number" name="poids" step="0.1"><br>
    Height: <input type="number" name="taille" step="0.1"><br>
    <input type="submit" value="Register">
</form>
</body>
</html>
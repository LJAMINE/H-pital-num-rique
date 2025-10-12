<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register as Patient</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f6fa;
            display: flex;
            height: 100vh;
            align-items: center;
            justify-content: center;
        }
        .register-container {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            padding: 32px 24px;
            min-width: 320px;
        }
        h2 {
            text-align: center;
            margin-bottom: 18px;
            color: #2d3436;
        }
        label {
            display: block;
            margin-bottom: 10px;
        }
        input[type="text"], input[type="email"], input[type="password"], input[type="number"] {
            width: 100%;
            padding: 8px 10px;
            margin-top: 4px;
            margin-bottom: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"] {
            width: 100%;
            background: #00b894;
            color: #fff;
            border: none;
            padding: 10px 0;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="register-container">
    <h2>Patient Registration</h2>
    <form method="post" action="register-patient">
        <label>Email:
            <input type="email" name="email" required>
        </label>
        <label>Password:
            <input type="password" name="password" required>
        </label>
        <label>First Name:
            <input type="text" name="prenom" required>
        </label>
        <label>Last Name:
            <input type="text" name="nom" required>
        </label>
        <label>Weight:
            <input type="number" name="poids" step="0.1">
        </label>
        <label>Height:
            <input type="number" name="taille" step="0.1">
        </label>
        <input type="submit" value="Register">
    </form>
</div>
</body>
</html>
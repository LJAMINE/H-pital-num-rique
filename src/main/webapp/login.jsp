<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f6fa;
            display: flex;
            height: 100vh;
            align-items: center;
            justify-content: center;
        }
        .login-container {
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
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 8px 10px;
            margin-top: 4px;
            margin-bottom: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            width: 100%;
            background: #0984e3;
            color: #fff;
            border: none;
            padding: 10px 0;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }
        .error {
            color: #d63031;
            margin-bottom: 10px;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="login-container">
    <h2>Login</h2>
    <% String error = request.getParameter("error"); %>
    <% if ("invalid".equals(error)) { %>
    <div class="error">Invalid email or password.</div>
    <% } else if ("unknownrole".equals(error)) { %>
    <div class="error">Unknown user role.</div>
    <% } %>
    <form action="login" method="post">
        <label>Email:
            <input type="text" name="email" required />
        </label>
        <label>Password:
            <input type="password" name="password" required />
        </label>
        <button type="submit">Login</button>
    </form>
</div>
</body>
</html>
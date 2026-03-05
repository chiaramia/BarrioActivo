<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page isErrorPage="true" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error en la aplicación</title>
    <style>
        body {
            margin: 0;
            font-family: 'Trebuchet MS', sans-serif;
            background-color: rgb(7, 102, 78);
            color: #f0f8f0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .error-container {
            background: rgba(0,0,0,0.5);
            padding: 40px;
            border-radius: 15px;
            text-align: center;
            border: 2px solid #a2d5c6;
            box-shadow: 0 0 20px rgba(0,0,0,0.6);
            max-width: 500px;
        }
        h1 {
            color: #ff6b6b;
            font-size: 2em;
            margin-bottom: 20px;
        }
        p {
            color: #e0f0e9;
            font-size: 1.1em;
            margin-bottom: 25px;
        }
        a {
            text-decoration: none;
            padding: 10px 20px;
            background-color: #a2d5c6;
            color: #074c3f;
            border-radius: 5px;
            font-weight: bold;
        }
        a:hover {
            background-color: #74b49b;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h1>⚠ Ha ocurrido un error</h1>
        <p><%= request.getAttribute("error") != null ? request.getAttribute("error") : "Error desconocido" %></p>
        <a href="chat.jsp">Volver al Chat</a>
    </div>
</body>
</html>

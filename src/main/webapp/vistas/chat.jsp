<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.*, java.text.SimpleDateFormat" %> <!-- Import correcto -->

<%
String nombre = (String) session.getAttribute("nombre");

//login: solo cuando viene desde el formulario inicial
if ("POST".equalsIgnoreCase(request.getMethod())
     && request.getParameter("nombre") != null) {

 nombre = request.getParameter("nombre");
 session.setAttribute("nombre", nombre);

 response.sendRedirect(request.getContextPath() + "/vistas/chat.jsp");
 return;
}

//cerrar sesión
if (request.getParameter("cerrarSesion") != null) {
 session.invalidate();
 response.sendRedirect(request.getContextPath() + "/vistas/chat.jsp");
 return;
}

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chat del Barrio</title>
<style>
body {
	margin: 0;
	font-family: 'Trebuchet MS', sans-serif;
	background-color: rgb(7, 102, 78);
	color: #f0f8f0;
}

.login-container {
	width: 350px;
	margin: 100px auto;
	padding: 25px;
	background: rgba(0, 0, 0, 0.5);
	border-radius: 12px;
	text-align: center;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.6);
}

.login-container input {
	width: 80%;
	padding: 10px;
	margin: 10px 0;
	border: 2px solid #a2d5c6;
	border-radius: 5px;
	background-color: #e0f0e9;
	color: #074c3f;
	font-size: 16px;
}

.login-container button {
	padding: 10px 20px;
	background-color: #a2d5c6;
	color: #074c3f;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-weight: bold;
}

.login-container button:hover {
	background-color: #74b49b;
}

.chat-container {
	width: 500px;
	margin: 50px auto;
	padding: 20px;
	background: rgba(0, 0, 0, 0.4);
	border-radius: 15px;
	border: 2px solid #a2d5c6;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.6);
}

.chat-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 15px;
}

.chat-header h2 {
	color: #e0f0e9;
	font-weight: bold;
}

.user-name {
	font-style: italic;
	font-size: 0.9em;
	color: #cce3dc;
}

.logout-btn {
	padding: 5px 10px;
	background-color: #a2d5c6;
	color: #074c3f;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.logout-btn:hover {
	background-color: #74b49b;
}

chat-messages {
	height: 300px;
	overflow-y: auto;
	padding: 10px;
	background: rgba(0, 0, 0, 0.2);
	border: 2px solid #a2d5c6;
	border-radius: 10px;
	margin-bottom: 15px;
	display: flex;
	flex-direction: column-reverse;
}


.chat-messages p {
	margin: 5px 0;
	padding: 8px 12px;
	background-color: rgba(162, 213, 198, 0.6);
	border-left: 4px solid #74b49b;
	border-radius: 5px;
	color: #074c3f;
}

.chat-messages p:hover {
	background-color: rgba(162, 213, 198, 0.8);
}

.chat-form {
	display: flex;
}

.chat-form input {
	flex: 1;
	padding: 10px;
	border: 2px solid #a2d5c6;
	border-radius: 5px 0 0 5px;
	font-size: 16px;
	background-color: #e0f0e9;
	color: #074c3f;
}

.chat-form button {
	padding: 10px;
	background-color: #a2d5c6;
	color: #074c3f;
	border: none;
	border-radius: 0 5px 5px 0;
	cursor: pointer;
	font-weight: bold;
}

.chat-form button:hover {
	background-color: #74b49b;
}

.chat-messages::-webkit-scrollbar {
	width: 10px;
}

.chat-messages::-webkit-scrollbar-track {
	background: rgba(224, 240, 233, 0.5);
}

.chat-messages::-webkit-scrollbar-thumb {
	background-color: #74b49b;
	border-radius: 5px;
}
</style>
</head>
<body>

	<%
	if (nombre == null || nombre.isEmpty()) {
	%>
	<div class="login-container">
		<h2>Bienvenido al Chat del Barrio</h2>
		<form action="${pageContext.request.contextPath}/vistas/chat.jsp"
			method="post">
			<input type="text" name="nombre" placeholder="Escribe tu nombre..."
				required>
			<button type="submit">Entrar al chat</button>
		</form>
		  <!-- Botón para volver al index -->
    <form action="${pageContext.request.contextPath}/vistas/index.jsp" method="get" style="margin-top: 10px;">
        <button type="submit" style="
            padding: 10px 20px;
            background-color: #a2d5c6;
            color: #074c3f;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;">
            Volver al inicio
        </button>
        </form>
	</div>
	<%
	} else {
	%>

	<%
	// Capturar el nombre como atributo para usarlo en el formulario
	request.setAttribute("nombre", nombre);
	%>
	<div class="chat-container">
		<div class="chat-header">
			<h2>💬 Chat del Barrio</h2>
			<span class="user-name">Conectado como <strong><%=nombre%></strong></span>
			  <form method="post" action="${pageContext.request.contextPath}/vistas/chat.jsp" style="display: inline;">
      <button type="submit" name="cerrarSesion" value="true" class="logout-btn">
        Salir
      </button>
    </form>
		</div>

		<div class="chat-messages"></div>

		<form action="${pageContext.request.contextPath}/Alta" method="post"
			class="chat-form">
			<!-- Pasamos el nombre como campo oculto -->
			<input type="hidden" name="nombre" value="<%=nombre%>"> <input
				type="text" name="comentario" placeholder="Escribí tu mensaje..."
				required>
			<button type="submit">Enviar</button>
		</form>

		<form action="${pageContext.request.contextPath}/Leer" method="get"
			style="display: inline;">
			<button type="submit" class="logout-btn">Actualizar chat</button>
		</form>
		
		<div class="chat-messages">
    <%
        // Recuperamos la lista de mensajes del servlet
        List<String[]> mensajes = (List<String[]>) request.getAttribute("conjuntoResultados");
        if (mensajes != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
            for (String[] m : mensajes) {
                String nombreMsg = m[0];
                String comentario = m[1];
                String fecha = m[2];
    %>
        <p><strong><%=nombreMsg%></strong> [<%=fecha%>]: <%=comentario%></p>
    <%
            }
        }
    %>
</div>
		
	</div>
	<%
	}
	%>

</body>
</html>

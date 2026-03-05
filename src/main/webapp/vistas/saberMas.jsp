<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>🌱 Saber más de nosotros</title>

<style>
body {
    margin: 0;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(to bottom, #e8f5e9, #c8e6c9);
    color: #2e7d32;
}

/* Contenedor principal */
.container {
    width: 80%;
    max-width: 800px;
    margin: 60px auto;
    padding: 30px;
    background: rgba(255, 255, 255, 0.9);
    border-radius: 15px;
    box-shadow: 0 8px 20px rgba(0, 100, 0, 0.2);
}

/* Título */
h1 {
    text-align: center;
    color: #1b5e20;
    margin-bottom: 10px;
}

/* Subtítulo */
h2 {
    color: #388e3c;
    border-left: 5px solid #81c784;
    padding-left: 10px;
    margin-top: 25px;
}

/* Texto general */
p {
    line-height: 1.6;
    font-size: 1.1em;
}

/* Listas */
ul {
    list-style-type: "🌿 ";
    margin-left: 25px;
}

/* Botón para volver */
.volver-btn {
    display: inline-block;
    margin-top: 30px;
    padding: 12px 25px;
    background-color: #81c784;
    color: #1b5e20;
    text-decoration: none;
    font-weight: bold;
    border-radius: 8px;
    transition: background-color 0.3s ease;
}

.volver-btn:hover {
    background-color: #66bb6a;
}

/* Pie */
footer {
    margin-top: 50px;
    text-align: center;
    color: #558b2f;
    font-size: 0.9em;
}

.volver-btn {
    display: inline-block;
    margin: 10px;
    padding: 12px 25px;
    background-color: #81c784;
    color: #1b5e20;
    text-decoration: none;
    font-weight: bold;
    border-radius: 8px;
    transition: background-color 0.3s ease;
}

.volver-btn:hover {
    background-color: #66bb6a;
}

</style>
</head>

<body>
    <div class="container">
        <h1>🌿 Barrio Activo</h1>
        <p>
            Bienvenido a <strong>a nuestro proyecto</strong>, un espacio pensado para fomentar la comunicación entre vecinos, 
            fortalecer la comunidad y promover un entorno más sostenible.
        </p>

        <h2>💬 ¿Qué podés hacer aquí?</h2>
        <ul>
            <li>Compartir tus pensamientos, noticias o ideas con tus vecinos.</li>
            <li>Informarte sobre eventos, actividades y novedades locales.</li>
            <li>Fomentar la participación comunitaria y el respeto mutuo.</li>
        </ul>

        <h2>🌎 Nuestro compromiso ambiental</h2>
        <p>
            Este proyecto promueve el uso consciente de la tecnología. 
            Buscamos reducir la suciedad en barrio, para vivir en comodidad y tener la calles limpias
             y accesible, inspirado en la naturaleza.
        </p>

        <h2>👩‍💻 Sobre el proyecto</h2>
        <p>
            Desarrollado en <strong>Java (JSP + Servlets)</strong> como parte de un ejercicio educativo para aprender 
            sobre aplicaciones web dinámicas y conexión con bases de datos.
        </p>

        <div style="text-align:center; margin-top:30px;">
    <a href="${pageContext.request.contextPath}/vistas/chat.jsp" class="volver-btn">⬅️ Ir al chat</a>
    <a href="${pageContext.request.contextPath}/vistas/index.jsp" class="volver-btn">🏠 Volver al inicio</a>
</div>
        
    </div>

    <footer>
        © 2025 Barrio Activo — Proyecto educativo con propósito verde 🌱
    </footer>
</body>
</html>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<title>Barrio Activo</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

<style>
/* ===== GENERAL ===== */
body {
    margin: 0;
    font-family: Poppins, sans-serif;
    background: #f3fbf4;
    color: #2f3e2f;
    scroll-behavior: smooth;
}

section {
    opacity: 0;
    transform: translateY(40px) scale(0.95); /* inicio ligeramente más pequeño */
    animation: fadeZoom 0.8s ease forwards;
}

@keyframes fadeZoom {
    to { opacity: 1; transform: translateY(0) scale(1); } /* fade + zoom-in */
}

/* ===== HEADER ===== */
header {
    background: #ffffffd9;
    backdrop-filter: blur(10px);
    border-bottom: 1px solid #d7edd7;
    padding: 15px 45px;
    position: sticky;
    top: 0;
    z-index: 20;
}

.nav {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.logo { width: 50px; }

.nav-list {
    list-style: none;
    display: flex;
    gap: 24px;
}

.nav-list a {
    position: relative;
    text-decoration: none;
    color: #2a5b2a;
    font-weight: 500;
    padding-bottom: 4px;
    transition: color .25s ease, transform .3s ease; /* añadido transform */
}

.nav-list a:hover {
    color: #1e7c1e;
    text-shadow: 0 0 6px #4caf50;
    transform: scale(1.1); /* Zoom ligero */
}

/* LÍNEA DESLIZANTE EN HOVER */
.nav-list a::after {
    content: "";
    position: absolute;
    left: 0;
    bottom: 0;
    height: 2px;
    width: 0%;
    background-color: #4caf50;
    transition: width .3s ease;
}

.nav-list a:hover::after {
    width: 100%;
}

/* ===== HERO ===== */
.hero {
    text-align: center;
    padding: 150px 20px;
}

.hero h1 { font-size: 62px; margin: 0; font-weight: 400; }
.hero p { margin-top: 10px; font-size: 18px; }

.btn {
    display: inline-block;
    margin-top: 22px;
    padding: 12px 30px;
    background: #4caf50;
    color: white;
    text-decoration: none;
    font-weight: 500;
    border-radius: 40px;
    transition: 0.25s;
}

.btn:hover { background: #3d9941; transform: translateY(-2px); }

/* ===== INFO (Imagen tacho) ===== */
.info {
    display: flex;
    flex-wrap: wrap;
    padding: 70px 60px;
    gap: 40px;
    align-items: center;
    justify-content: center;
}

.info-img {
    width: 50%;
    border-radius: 15px;
    box-shadow: 0 4px 15px #00000018;
}

.info-text h2 { margin-top: 0; font-size: 28px; color: #2d5a2d; }
.info-text p { font-size: 16px; line-height: 1.6; }

/* ===== ABOUT ===== */
.about {
    padding: 70px 50px;
    text-align: center;
}

.about h2 { font-size: 32px; color: #2d5a2d; }
.about p { width: 70%; margin: auto; line-height: 1.7; font-size: 17px; }

/* ===== SERVICES ===== */
.services {
    padding: 70px 40px;
    background: #eafbeb;
    text-align: center;
}

.services h2 { font-size: 30px; color: #2d5a2d; margin-bottom: 40px; }

.cards {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 35px;
}

.card {
    background: #fff;
    width: 260px;
    padding: 25px;
    border-radius: 15px;
    text-align: center;
    box-shadow: 0 4px 15px #00000015;
    transition: transform 0.25s, box-shadow 0.25s;
}

.card:hover {
    transform: scale(1.05); /* zoom cards */
    box-shadow: 0 8px 20px #00000025;
}

.card-icon { font-size: 45px; margin-bottom: 15px; }

/* ===== BENEFITS ===== */
.benefits {
    padding: 70px 50px;
    text-align: center;
}

.benefits h2 { font-size: 32px; color: #2d5a2d; margin-bottom: 30px; }

.benefits-grid {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 50px;
}

.benefit {
    width: 250px;
    text-align: center;
}

.benefit svg {
    width: 60px;
    height: 60px;
    fill: #4caf50;
    margin-bottom: 10px;
}

/* ===== FOOTER ===== */
footer {
    text-align: center;
    padding: 40px;
    background: #2d5a2d;
    color: white;
    margin-top: 50px;
}

/* ===== RESPONSIVE ===== */
@media (max-width: 900px) {
    .info-img { width: 100%; }
    .cards, .benefits-grid { flex-direction: column; align-items: center; }
    .hero { padding: 100px 20px; }
}

</style>
</head>

<body>

<header>
    <nav class="nav">
        <img src="imagenes/logobarrioactivo.png" class="logo">
       <ul class="nav-list">
    <li><a href="#">Inicio</a></li>
    <li><a href="${pageContext.request.contextPath}/vistas/chat.jsp">Chat</a></li>
    <li><a href="#nosotros">Nosotros</a></li>
    <li><a href="${pageContext.request.contextPath}/vistas/gestionResiduos.jsp">
        Gestion de Residuos
    </a></li>
</ul>

    </nav>
</header>

<!-- HERO simple -->
<section class="hero">
    <h1>Barrio Activo</h1>
    <p>"Cuidando el entorno, construimos comunidad"</p>
    <a href="${pageContext.request.contextPath}/vistas/saberMas.jsp" class="btn">Saber mas</a>
</section>

<!-- INFO sección tacho -->
<section class="info">
    <img src="imagenes/tachito.jpg" class="info-img">
    <div class="info-text">
        <h2>Comprometidos con un futuro sostenible 🌿</h2>
        <p>Promovemos la separación de residuos, el reciclaje responsable y el cuidado del ambiente.</p>
    </div>
</section>

<!-- ABOUT -->
<section class="about" id="nosotros">
    <h2>Sobre Nosotros 🌎</h2>
    <p>Somos una comunidad organizada que trabaja para cuidar el medio ambiente a través de acciones sostenibles y educativas.</p>
</section>

<!-- SERVICES -->
<section class="services" id="servicios">
    <h2>Nuestros Servicios</h2>
    <div class="cards">
        <div class="card"><div class="card-icon">🌍</div><h3>Reciclaje</h3></div>
        <div class="card"><div class="card-icon">🌱</div><h3>Talleres</h3></div>
        <div class="card"><div class="card-icon">🚮</div><h3>Limpieza</h3></div>
    </div>
</section>

<!-- BENEFITS -->
<section class="benefits" id="beneficios">
    <h2>Beneficios</h2>
    <div class="benefits-grid">
        <div class="benefit">
            <svg viewBox="0 0 24 24"><path d="M12 2L15 8H9L12 2Z"/></svg>
            <h3>Educación</h3>
        </div>
        <div class="benefit">
            <svg viewBox="0 0 24 24"><path d="M12 2L15 8H9L12 2Z"/></svg>
            <h3>Menos contaminación</h3>
        </div>
        <div class="benefit">
            <svg viewBox="0 0 24 24"><path d="M12 2L15 8H9L12 2Z"/></svg>
            <h3>Comunidad</h3>
        </div>
    </div>
</section>

<!-- FOOTER -->
<footer>
    <p>&copy; 2025 Barrio Activo — Todos los derechos reservados</p>
</footer>

</body>
</html>
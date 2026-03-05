<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="utf-8" />
  <title>Gestión de Residuos</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <!-- Estilos de Leaflet -->
  <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
  <link rel="icon" type="image/png" href="img/Logo.baa.png">

  <style>
    body {
      margin: 0;
      font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
      background-color: rgb(7, 102, 78); /* 🎨 Fondo liso verde */
      color: #f5f5f5;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }

    header {
      display: flex;
      align-items: center;
      justify-content: center;
      background-color: rgba(255, 255, 255, 0.9);
      color: #073c2d;
      padding: 15px 20px;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
      border-radius: 0 0 10px 10px;
      flex-wrap: wrap;
      text-align: center;
    }

    header h1 {
      font-size: 1.8rem;
      font-weight: 700;
    }

    main {
      display: flex;
      flex: 1;
      flex-wrap: wrap;
      padding: 20px;
      gap: 15px;
      justify-content: center;
    }

    aside {
      width: 250px;
      background: rgba(255, 255, 255, 0.9);
      border-radius: 10px;
      padding: 20px;
      box-shadow: 0 0 10px rgba(0,0,0,0.2);
      flex-shrink: 0;
      color: #073c2d;
    }

    aside h3 {
      margin-top: 0;
      text-align: center;
      font-weight: 700;
    }

    aside ul {
      list-style: none;
      padding: 0;
      margin: 0;
    }

    aside li {
      margin-bottom: 8px;
      padding: 6px 10px;
      border-radius: 6px;
      color: #fff;
      font-weight: 600;
    }

    .ultra-lleno { background-color: #800000; }
    .lleno { background-color: #d32f2f; }
    .medio { background-color: #f57c00; }
    .vacio { background-color: #388e3c; }

    #map {
      flex: 1;
      height: 80vh;
      border-radius: 10px;
      box-shadow: 0 0 15px rgba(0,0,0,0.3);
      background: rgba(255, 255, 255, 0.9);
      min-width: 300px;
    }

    footer {
      text-align: center;
      padding: 15px;
      background: rgba(255,255,255,0.9);
      color: #073c2d;
      margin-top: 10px;
      box-shadow: 0 -2px 5px rgba(0,0,0,0.2);
      border-radius: 10px 10px 0 0;
      font-size: 0.9rem;
    }

    @media (max-width: 768px) {
      header {
        flex-direction: column;
      }

      main {
        flex-direction: column;
        align-items: stretch;
        padding: 10px;
      }

      aside {
        width: 100%;
        margin-bottom: 10px;
        text-align: center;
      }

      #map {
        width: 100%;
        height: 65vh;
      }

      footer {
        font-size: 0.8rem;
      }
    }
  </style>
</head>

<body>
  <header>
    <h1>Mapa Visual de Gestión Residual</h1>
  </header>

  <main>
    <aside>
      <h3>Estado del tacho</h3>
      <ul>
        <li class="ultra-lleno">Ultra lleno</li>
        <li class="lleno">Lleno</li>
        <li class="medio">Medio</li>
        <li class="vacio">Vacío</li>
      </ul>
    </aside>
    <div id="map"></div>
  </main>

  <footer>
    © <%= new SimpleDateFormat("yyyy").format(new Date()) %> Instituto Técnico Nuestra Señora de Fátima
  </footer>

  <!-- Leaflet -->
  <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>

  <script>
    // Inicializar mapa
    var map = L.map('map').setView([-34.6037, -58.3816], 12);

    // Capa base
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '© OpenStreetMap contributors'
    }).addTo(map);

    // --- Datos de los tachos desde Java ---
    const tachos = [
      <% 
        class Tacho {
          public int id; public double lat; public double lng; public int nivel;
          public Tacho(int id, double lat, double lng, int nivel){ this.id=id; this.lat=lat; this.lng=lng; this.nivel=nivel; }
        }

        // Datos de ejemplo (puedes reemplazarlos por los de tu base de datos)
        List<Tacho> lista = new ArrayList<>();
        lista.add(new Tacho(1, -34.68, -58.47, 90));
        lista.add(new Tacho(2, -34.65, -58.46, 60));
        lista.add(new Tacho(3, -34.6561, -58.4573, 20));

        for (Iterator<Tacho> it = lista.iterator(); it.hasNext();) {
          Tacho t = it.next();
      %>
        { id: <%= t.id %>, lat: <%= t.lat %>, lng: <%= t.lng %>, nivel: <%= t.nivel %> }<%= it.hasNext() ? "," : "" %>
      <% } %>
    ];

    // --- Función para obtener el estado según nivel ---
    function getEstado(nivel) {
      if (nivel >= 90) return 'Ultra lleno';
      if (nivel >= 70) return 'Lleno';
      if (nivel >= 40) return 'Medio';
      return 'Vacío';
    }

    // --- Íconos personalizados ---
    const iconos = {
      'Vacío': L.icon({
        iconUrl: 'img/tachoubi.png',
        iconSize: [70, 70],
        iconAnchor: [30, 30],
        popupAnchor: [0, -35]
      }),
      'Medio': L.icon({
        iconUrl: 'img/tachoubi.png',
        iconSize: [70, 70],
        iconAnchor: [30, 30],
        popupAnchor: [0, -35]
      }),
      'Lleno': L.icon({
        iconUrl: 'img/tachoubi.png',
        iconSize: [70, 70],
        iconAnchor: [30, 30],
        popupAnchor: [0, -35]
      }),
      'Ultra lleno': L.icon({
        iconUrl: 'img/tachoubi.png',
        iconSize: [70, 70],
        iconAnchor: [30, 30],
        popupAnchor: [0, -35]
      })
    };

    // --- Crear marcadores ---
    const marcadores = {};

    tachos.forEach(tacho => {
      const estado = getEstado(tacho.nivel);
      const marcador = L.marker([tacho.lat, tacho.lng], { icon: iconos[estado] })
        .addTo(map)
        .bindPopup(`<b>Tacho ${tacho.id}</b><br>Estado: ${estado}<br>Nivel: ${tacho.nivel}%`);
      marcadores[tacho.id] = marcador;
    });

    // --- Simulación de actualización automática ---
    setInterval(() => {
      tachos.forEach(tacho => {
        tacho.nivel = Math.floor(Math.random() * 100);
        const nuevoEstado = getEstado(tacho.nivel);
        const marcador = marcadores[tacho.id];
        marcador.setIcon(iconos[nuevoEstado]);
        marcador.setPopupContent(`<b>Tacho ${tacho.id}</b><br>Estado: ${nuevoEstado}<br>Nivel: ${tacho.nivel}%`);
      });
    }, 5000);
  </script>
</body>
</html>

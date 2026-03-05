package com.app;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet implementation class LeerServlet
 */
@WebServlet("/Leer")
public class LeerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conexion = null;
        Statement declaracion = null;
        ResultSet resultados = null;

        try {
            // Conectarse a la base de datos
            conexion = ConexionBD.obtenerConexion();

            // Crear Statement y ejecutar consulta
            declaracion = conexion.createStatement();
            String sql = "SELECT id, nombre, comentario, fecha_hora FROM datoschat";
            resultados = declaracion.executeQuery(sql);

            // Convertir ResultSet a lista de arrays
            List<String[]> listaMensajes = new ArrayList<>();
            while (resultados.next()) {
                String nombre = resultados.getString("nombre");
                String comentario = resultados.getString("comentario");
                Timestamp fecha_hora = resultados.getTimestamp("fecha_hora");
                String fechaStr = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(fecha_hora);

                listaMensajes.add(new String[]{nombre, comentario, fechaStr});
            }

            // Enviar la lista a la JSP-
            request.setAttribute("conjuntoResultados", listaMensajes);
            request.getRequestDispatcher("/vistas/chat.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.getRequestDispatcher("/vistas/error.jsp").forward(request, response);

        } finally {
            // Cerrar recursos
            try {
                if (resultados != null) resultados.close();
                if (declaracion != null) declaracion.close();
                if (conexion != null) conexion.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

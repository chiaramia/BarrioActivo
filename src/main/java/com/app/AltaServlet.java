package com.app;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.*;

@WebServlet("/Alta")
public class AltaServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	
		String nombre = request.getParameter("nombre");
		String comentario = request.getParameter("comentario");
	
		
		if (nombre == null || nombre.isBlank() || comentario == null && comentario.isBlank()) {
			return;
		} 
		// 3. Subir datos a la BD.
		// Paso 1: conectar con la base de datos
		try (Connection conexion = ConexionBD.obtenerConexion()) {

		    // Paso 2: preparar la consulta SQL (con ? para los valores dinámicos)
		    String sql = "INSERT INTO datoschat (nombre, comentario) VALUES (?, ?)";

		    // Paso 3: crear el PreparedStatement
		    try (PreparedStatement declaracionPreparada = conexion.prepareStatement(sql)) {

		        // Paso 4: reemplazar los ? con los valores recibidos
		    	declaracionPreparada.setString(1, nombre);
		    	declaracionPreparada.setString(2, comentario);

		        // Paso 5: ejecutar el INSERT.
		    	// la variable entera "filas" será igual a 1 si se creó un dato, o 0 si no se creó nada.
		        int filas = declaracionPreparada.executeUpdate();

		        // Paso 6: verificar si se insertó correctamente
		        if (filas > 0) {
		            request.setAttribute("mensajeExito", "¡Datos guardados correctamente!");
		            System.out.println("Datos guardados correctamente!");
		            request.getRequestDispatcher("/vistas/chat.jsp").forward(request, response);
		        } else {
		        	System.out.println("No se cargaron los datos");
		            response.sendRedirect(request.getContextPath() + "/vistas/error.jsp");
		        }
		    }

		} catch (SQLException e) {
		    // Paso 7: manejo de errores
		    e.printStackTrace();
		    request.setAttribute("error", e.getMessage());
		    request.getRequestDispatcher("/vistas/error.jsp").forward(request, response);
		}

	
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}
}

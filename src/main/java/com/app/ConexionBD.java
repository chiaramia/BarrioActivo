package com.app;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Scanner;

/**
 * Clase encargada de manejar la conexión con la base de datos MySQL y realizar
 * operaciones básicas como alta y lectura de registros.
 */
public class ConexionBD {

	// Conexión estática para que pueda ser reutilizada
	static Connection conexion = null;
	static Scanner entrada = new Scanner(System.in);

	/**
	 * Método que establece la conexión con la base de datos.
	 * 
	 * @return objeto Connection que representa la conexión abierta.
	 * @throws SQLException si ocurre un error en la conexión.
	 */
	public static Connection obtenerConexion() throws SQLException {

		// Parámetros de conexión
		String url = "jdbc:mysql://localhost:3306/chatdebarrio";
		String user = "root";
		String password = "";

		try {
			// 1️⃣ Cargar el driver JDBC de MySQL
			Class.forName("com.mysql.cj.jdbc.Driver");

			// 2️⃣ Establecer la conexión con la base
			conexion = DriverManager.getConnection(url, user, password);

			System.out.println("✅ Conexión exitosa a MySQL");

		} catch (ClassNotFoundException e) {
			// Error si el driver JDBC no está disponible
			throw new SQLException("❌ Driver JDBC de MySQL no encontrado", e);

		} catch (SQLException e) {
			// Error si no se puede conectar
			throw new SQLException("❌ Error al conectar a la base de datos", e);
		}

		return conexion;
	}

	/**
	 * Método de ejemplo que inserta un registro en la tabla 'datosmuro'.
	 * 
	 * @throws SQLException si ocurre un error al ejecutar la consulta.
	 */
	public static void alta() throws SQLException {

		// 1️⃣ Conectarse a la base de datos
		obtenerConexion();

		// 2️⃣ Preparar la consulta SQL (con ? para los valores dinámicos)
		String sql = "INSERT INTO datoschat (nombre, comentario) VALUES (?, ?)";

		// 3️⃣ Crear el PreparedStatement
		try (PreparedStatement declaracionPreparada = conexion.prepareStatement(sql)) {

			// Valores de ejemplo a insertar
			String nombre = "Daniel";
			String comentario = "¡Los quiero!";

			// 4️⃣ Reemplazar los ? con los valores reales
			declaracionPreparada.setString(1, nombre);
			declaracionPreparada.setString(2, comentario);

			// 5️⃣ Ejecutar el INSERT.
			// La variable "filas" devuelve cuántos registros se insertaron.
			int filas = declaracionPreparada.executeUpdate();

			// 6️⃣ Verificar el resultado
			if (filas > 0) {
				System.out.println("✅ Datos guardados correctamente en la base de datos.");
			} else {
				System.out.println("⚠️ No se insertó ningún registro.");
			}
		}
	}

	/**
	 * Método para realizar la lectura de datos desde la base. Se implementa con una
	 * consulta SELECT.
	 */
	public static void lectura() {
		// Declaramos las variables necesarias para la conexión y la consulta
		Connection conexion = null; // Representa la conexión con la base de datos
		Statement declaracion = null; // Sirve para enviar instrucciones SQL
		ResultSet resultados = null; // Guarda los datos que devuelve una consulta SELECT desde la BD

		try {
			// 1️⃣ Conectarse a la base de datos (usando nuestra funcion obtenerConexion() )
			conexion = obtenerConexion();

			// 2️⃣ Crear un "Statement" para ejecutar la consulta SQL
			declaracion = conexion.createStatement();

			// 3️⃣ Escribir la consulta SQL que queremos ejecutar
			String sql = "SELECT id, nombre, comentario, fecha_hora FROM datoschat";

			// 4️⃣ Ejecutar la consulta y guardar los datos obtenidos en el ResultSet
			resultados = declaracion.executeQuery(sql);

			// 5️⃣ Recorrer los resultados fila por fila
			System.out.println("\n=== 📋 LISTA DE COMENTARIOS ===");
			while (resultados.next()) {
				int id = resultados.getInt("id");
				String nombre = resultados.getString("nombre");
				String comentario = resultados.getString("comentario");
				Timestamp fechaHora = resultados.getTimestamp("fecha_hora");

				// Formatear fecha legible
				String fechaFormateada = "";
				if (fechaHora != null) {
					SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy HH:mm");
					fechaFormateada = formato.format(fechaHora);
				}

				// Mostrar en consola
				System.out.println("ID: " + id);
				System.out.println("👤 " + nombre);
				System.out.println("💬 " + comentario);
				System.out.println("🕒 " + fechaFormateada);
				System.out.println("-------------------------------");
			}

		} catch (SQLException e) {
			// Si ocurre un error en cualquier paso, lo mostramos por consola
			e.printStackTrace();

		} finally {
			// 6️⃣ Cerramos los recursos para liberar memoria y evitar errores de conexión

			try {
				if (resultados != null)
					resultados.close(); // Cierra el ResultSet
				if (declaracion != null)
					declaracion.close(); // Cierra el Statement
				if (conexion != null)
					conexion.close(); // Cierra la conexión con la base
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public static void eliminar() throws SQLException {

		// 1️⃣ Conectarse a la base de datos
		obtenerConexion();

		System.out.println("Qué comentario desea eliminar?");
		lectura();
		int id = entrada.nextInt();

		// 2️⃣ Consulta SQL con parámetro dinámico
		String sql = "DELETE FROM datoscaht WHERE id = ?";

		// 3️⃣ Crear el PreparedStatement
		try (PreparedStatement declaracionPreparada = conexion.prepareStatement(sql)) {

			// 4️⃣ Reemplazar el ? con el valor real
			declaracionPreparada.setInt(1, id);

			// 5️⃣ Ejecutar la eliminación
			int filas = declaracionPreparada.executeUpdate();

			// 6️⃣ Confirmar resultado
			if (filas > 0) {
				System.out.println("✅ Registro con ID " + id + " eliminado correctamente.");
			} else {
				System.out.println("⚠️ No se encontró ningún registro con ID " + id + ".");
			}
		} finally {
			// 7️⃣ Cerrar la conexión
			if (conexion != null)
				conexion.close();
		}
	}

	public static void editar() throws SQLException {
		// Se llama a lectura, para obtener datos existentes.
	    lectura();

	    // Después de lectura(), la conexión se cierra. Reconectamos:
	    obtenerConexion();

	    System.out.println("Ingrese el ID del registro que desea editar:");
	    int id = entrada.nextInt();
	    entrada.nextLine(); // limpiar buffer

	    System.out.println("¿Qué desea editar?\nA: Autor\nB: Comentario");
	    char opcion = entrada.next().charAt(0);
	    entrada.nextLine(); // limpiar buffer

	    String sql = "";
	    String nuevoValor = "";

	    switch (opcion) {
	        case 'a':
	        case 'A':
	            System.out.println("Ingrese el nuevo autor:");
	            nuevoValor = entrada.nextLine();
	            sql = "UPDATE datoschat SET autor = ? WHERE id = ?";
	            break;
	        case 'b':
	        case 'B':
	            System.out.println("Ingrese el nuevo comentario:");
	            nuevoValor = entrada.nextLine();
	            sql = "UPDATE datoschat SET comentario = ? WHERE id = ?";
	            break;
	        default:
	            System.out.println("Opción incorrecta");
	            return;
	    }

	    try (PreparedStatement ps = conexion.prepareStatement(sql)) {
	        ps.setString(1, nuevoValor);
	        ps.setInt(2, id);

	        int filas = ps.executeUpdate();
	        if (filas > 0)
	            System.out.println("✅ Registro con ID " + id + " actualizado correctamente.");
	        else
	            System.out.println("⚠️ No se encontró ningún registro con ID " + id + ".");
	    } finally {
	        if (conexion != null) conexion.close();
	    }
	}


	/**
	 * Método principal de prueba. Permite comprobar la conexión.
	 */
	public static void main(String[] args) throws SQLException {
		// alta(); // Descomentar para probar la carga de datos
		//lectura(); // Descomentar para probar la lectura de datos
		//eliminar();
		editar();
	}
}
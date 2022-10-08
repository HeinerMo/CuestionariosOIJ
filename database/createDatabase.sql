/*
	Crear base de datos y tablas.
	Autor: Heiner Monge
	fecha creacion: 25 de septiembre 2022
	modificiacion: 08 de agosto 2022
*/

USE master
GO

BEGIN TRY
	PRINT('Verificando si la base de datos ya existe...')
	DROP DATABASE cuestionarios
	PRINT('Base de datos preexistente eliminada!')
END TRY
BEGIN CATCH
	PRINT('La base de datos no exist�a. Saltando paso de borrar...')
END CATCH

PRINT('Creando la base de datos...')
CREATE DATABASE cuestionarios
GO
PRINT('Base de datos creada!')

BEGIN TRY
	PRINT('Poblando la base de datos con las tablas...')
	USE cuestionarios
	BEGIN TRANSACTION
		-- tipoCuestionario
		CREATE TABLE tb_tipo_Cuestionario
			(id INT IDENTITY(1, 1) PRIMARY KEY
			,nombre VARCHAR(40))

		-- cuestionario
		CREATE TABLE tb_cuestionario
			(id INT IDENTITY(1, 1) PRIMARY KEY
			,nombre NVARCHAR(100) NOT NULL
			,activo BIT NOT NULL DEFAULT 1
			,vencimiento DATE NOT NULL
			,decripcion NVARCHAR(200) NOT NULL
			,idTipoCuestionario INT NOT NULL
			,fechaCreacion DATE DEFAULT GETDATE()
			, FOREIGN KEY (idTipoCuestionario) REFERENCES tb_tipo_Cuestionario (id))

		-- historico cuestionario
		CREATE TABLE tb_historico_Cuestionario
			(id INT IDENTITY (1, 1) PRIMARY KEY
			,idCuestionario INT NOT NULL
			,fechaInicio DATE DEFAULT GETDATE()
			,fechaFinal DATE NOT NULL)

		-- revisaCuestionario
		CREATE TABLE tb_revisa_Cuestionario
			(idUsuario INT NOT NULL
			,idCuestionario INT NOT NULL
			,eliminado BIT NOT NULL DEFAULT 0
			,FOREIGN KEY (idCuestionario) REFERENCES tb_cuestionario (id))

		-- cuestionario_usuarios
		CREATE TABLE tb_cuestionario_usuario
			(idCuestionario INT NOT NULL
			,idUsuario INT NOT NULL
			,eliminado BIT NOT NULL DEFAULT 0
			,FOREIGN KEY (idCuestionario) REFERENCES tb_cuestionario (id)) 

		-- tipoPregunta
		CREATE TABLE tb_tipo_pregunta
			(id INT IDENTITY(1, 1) PRIMARY KEY
			,nombre NVARCHAR(100))

		-- Categor�a pregunta
		CREATE TABLE tb_categoria_pregunta
			(id INT IDENTITY(1, 1) PRIMARY KEY
			,nombre NVARCHAR(100))
	
		-- Categor�a pregunta
		CREATE TABLE tb_subcategoria_pregunta
			(id INT IDENTITY(1, 1) PRIMARY KEY
			,nombre NVARCHAR(100)
			,idCategoria INT NOT NULL
			,FOREIGN KEY (idCategoria) REFERENCES tb_categoria_pregunta (id))

		-- pregunta
		CREATE TABLE tb_pregunta
			(id INT IDENTITY(1, 1) PRIMARY KEY
			,enunciado NVARCHAR(200) NOT NULL
			,etiqueta NVARCHAR(100) NOT NULL
			,posicion INT NOT NULL
			,idCategoria INT NOT NULL
			,idSubcategoria INT NOT NULL
			,idCuestionario INT NOT NULL
			,idTipo INT NOT NULL
			,opcional BIT NOT NULL DEFAULT 0
			,FOREIGN KEY (idCategoria) REFERENCES tb_categoria_pregunta (id)
			,FOREIGN KEY (idSubcategoria) REFERENCES tb_subcategoria_pregunta (id)
			,FOREIGN KEY (idCuestionario) REFERENCES tb_cuestionario (id)
			,FOREIGN KEY (idTipo) REFERENCES tb_tipo_pregunta (id))

		-- Opcion

		CREATE TABLE tb_opcion
			(id INT IDENTITY(1, 1) PRIMARY KEY
			,opcion NVARCHAR(200) NOT NULL
			,idPregunta INT NULL --Puede que esta opci�n sea est�tica por lo que no tiene una ID de pregunta como tal.
			,idTipoPregunta INT NOT NULL --Es importante espeficicar el tipo de pregunta al que pertenece esta opci�n.
			,FOREIGN KEY (idPregunta) REFERENCES tb_pregunta (id)
			,FOREIGN KEY (idTipoPregunta) REFERENCES tb_tipo_pregunta (id))

		-- Respuesta

		CREATE TABLE tb_respuesta
			(id INT IDENTITY(1, 1) PRIMARY KEY
			,fecha DATETIME NOT NULL DEFAULT GETDATE()
			,idPregunta INT NOT NULL
			,respuesta NVARCHAR(200) NULL
			,FOREIGN KEY (idPregunta) REFERENCES tb_pregunta (id))
	
		-- Respuesta_opci�n

		CREATE TABLE tb_respuesta_opcion
			(idRespuesta INT NOT NULL
			,idOpcion INT NOT NULL
			,FOREIGN KEY (idOpcion) REFERENCES tb_Opcion (id)
			,FOREIGN KEY (idRespuesta) REFERENCES tb_respuesta (id))


		/*
			Esta secci�n se encarga de llenar los valores est�ticos para las tablas que lo necesiten.
		*/
		PRINT('Tablas creadas!')
		PRINT('Poblando los datos est�ticos de la base de datos...')
		-- tipos de preguntas
		INSERT INTO tb_tipo_pregunta
			(nombre)
		VALUES
			('Selecci�n �nica')
			,('Selecci�n M�ltiple')
			,('Respuesta Larga')
			,('Num�rica')
			,('Escala')

		-- Opciones est�ticas para preguntas
		INSERT INTO tb_opcion
			([opcion]
			,[idTipoPregunta]) 
		VALUES
			('Muy malo', 5)
			,('Malo', 5)
			,('Regular', 5)
			,('Bueno', 5)
			,('Muy bueno', 5)
	COMMIT
	PRINT('Base de datos lista!')
END TRY
BEGIN CATCH
	ROLLBACK
	PRINT ERROR_MESSAGE()
END CATCH
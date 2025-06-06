
CREATE TABLE [dbo].[autores](
	[id] [int] NOT NULL,
	[nombre] [nvarchar](255) NOT NULL,
	[biografia] [nvarchar](max) NULL,
	[imagen_perfil] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[libros]    Script Date: 21/03/2025 13:44:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[libros](
	[id] [int] NOT NULL,
	[titulo] [nvarchar](255) NOT NULL,
	[autor_id] [int] NULL,
	[saga] [nvarchar](255) NULL,
	[posicion_saga] [int] NULL,
	[fecha_publicacion] [date] NULL,
	[paginas] [int] NULL,
	[sinopsis] [nvarchar](max) NULL,
	[imagen] [nvarchar](max) NULL,
	[calificacion] [decimal](3, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usuario_lista_predefinida_libro]    Script Date: 21/03/2025 13:44:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usuario_lista_predefinida_libro](
	[usuario_id] [int] NOT NULL,
	[lista_predefinida_id] [int] NOT NULL,
	[libro_id] [int] NOT NULL,
	[fecha_agregado] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[usuario_id] ASC,
	[lista_predefinida_id] ASC,
	[libro_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_LIBROS_CON_LISTA]    Script Date: 21/03/2025 13:44:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[V_LIBROS_CON_LISTA] AS
SELECT 
    l.id AS LibroId,
    l.titulo AS TituloLibro,
    l.saga AS SagaLibro,
    l.posicion_saga AS PosicionEnSaga,
    l.fecha_publicacion AS FechaPublicacionLibro,
    l.paginas AS NumeroPaginasLibro,
    l.sinopsis AS SinopsisLibro,
    l.imagen AS ImagenPortadaLibro,
    l.calificacion AS CalificacionPromedioLibro,
    a.id AS AutorId,
    a.nombre AS NombreAutor,
    COALESCE(ulpl.lista_predefinida_id, 0) AS ListaId, -- Si no está en una lista, poner 0
    ulpl.usuario_id AS UsuarioID
FROM 
    libros l
JOIN 
    autores a ON l.autor_id = a.id
LEFT JOIN 
    usuario_lista_predefinida_libro ulpl 
    ON l.id = ulpl.libro_id;
GO
/****** Object:  View [dbo].[V_LIBROS]    Script Date: 21/03/2025 13:44:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   VIEW [dbo].[V_LIBROS] AS
SELECT 
    l.id AS LibroId,
    l.titulo AS TituloLibro,
    l.saga AS SagaLibro,
    l.posicion_saga AS PosicionEnSaga,
    l.fecha_publicacion AS FechaPublicacionLibro,
    l.paginas AS NumeroPaginasLibro,
    l.sinopsis AS SinopsisLibro,
    l.imagen AS ImagenPortadaLibro,
    l.calificacion AS CalificacionPromedioLibro,
    a.id AS AutorId,
    a.nombre AS NombreAutor
FROM 
    libros l
JOIN 
    autores a ON l.autor_id = a.id;
GO
/****** Object:  View [dbo].[V_AUTORES_LIBROS]    Script Date: 21/03/2025 13:44:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_AUTORES_LIBROS] AS
SELECT 
    a.id AS AutorId,
    l.id AS LibroId,
    l.titulo AS TituloLibro,
    l.saga AS SagaLibro,
    l.posicion_saga AS PosicionEnSaga,
    l.fecha_publicacion AS FechaPublicacionLibro,
    l.paginas AS NumeroPaginasLibro,
    l.sinopsis AS SinopsisLibro,
    l.imagen AS ImagenPortadaLibro,
    l.calificacion AS CalificacionPromedioLibro
FROM 
    autores a
JOIN 
    libros l ON a.id = l.autor_id;
GO
/****** Object:  Table [dbo].[objetivos_lectura]    Script Date: 21/03/2025 13:44:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[objetivos_lectura](
	[id] [int] NOT NULL,
	[usuario_id] [int] NULL,
	[titulo] [nvarchar](255) NOT NULL,
	[fecha_inicio] [date] NOT NULL,
	[fecha_fin] [date] NOT NULL,
	[tipo] [nvarchar](10) NOT NULL,
	[meta] [int] NOT NULL,
	[progreso] [int] NULL,
	[estado] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_OBJETIVOS_LECTURA]    Script Date: 21/03/2025 13:44:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_OBJETIVOS_LECTURA] AS
SELECT 
    o.id AS ObjetivoId,
    o.usuario_id AS UsuarioId,
    o.titulo AS NombreObjetivo,
    o.fecha_inicio AS FechaInicio,
    o.fecha_fin AS FechaFin,
    o.tipo AS TipoObjetivo,  -- 'libros' o 'paginas'
    o.meta AS MetaTotal,
    o.progreso AS ProgresoActual,
    o.estado AS EstadoObjetivo  -- 'activo' o 'archivado'
FROM objetivos_lectura o;
GO
/****** Object:  Table [dbo].[etiquetas]    Script Date: 21/03/2025 13:44:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[etiquetas](
	[id] [int] NOT NULL,
	[nombre] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[libros_etiquetas]    Script Date: 21/03/2025 13:44:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[libros_etiquetas](
	[libro_id] [int] NOT NULL,
	[etiqueta_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[libro_id] ASC,
	[etiqueta_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_DETALLES_LIBRO]    Script Date: 21/03/2025 13:44:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_DETALLES_LIBRO] AS
SELECT 
    l.id AS LibroId,
    l.titulo AS TituloLibro,
    l.saga AS SagaLibro,
    l.posicion_saga AS PosicionEnSaga,
    l.fecha_publicacion AS FechaPublicacion,
    l.paginas AS Paginas,
    l.sinopsis AS Sinopsis,
    l.imagen AS ImagenPortada,
    l.calificacion AS CalificacionPromedio,
    a.id AS AutorId,
    a.nombre AS NombreAutor,
    STRING_AGG(e.nombre, ', ') AS Etiquetas
FROM libros l
JOIN autores a ON l.autor_id = a.id
LEFT JOIN libros_etiquetas le ON l.id = le.libro_id
LEFT JOIN etiquetas e ON le.etiqueta_id = e.id
GROUP BY l.id, l.titulo, l.saga, l.posicion_saga, l.fecha_publicacion, 
         l.paginas, l.sinopsis, l.imagen, l.calificacion, a.id, a.nombre;
GO
/****** Object:  Table [dbo].[listas_predefinidas]    Script Date: 21/03/2025 13:44:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[listas_predefinidas](
	[id] [int] NOT NULL,
	[nombre] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_LIBROS_LEIDOS]    Script Date: 21/03/2025 13:44:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_LIBROS_LEIDOS] AS
SELECT 
    ulpl.usuario_id AS UsuarioId,
    l.id AS LibroId,
    l.titulo AS TituloLibro,
    l.imagen AS ImagenLibro,
    a.id AS AutorId,
    a.nombre AS NombreAutor,
    l.fecha_publicacion AS FechaPublicacion
FROM usuario_lista_predefinida_libro ulpl
JOIN listas_predefinidas lp ON ulpl.lista_predefinida_id = lp.id
JOIN libros l ON ulpl.libro_id = l.id
JOIN autores a ON l.autor_id = a.id 
WHERE lp.nombre = 'Leído';
GO
/****** Object:  Table [dbo].[usuarios]    Script Date: 21/03/2025 13:44:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usuarios](
	[id] [int] NOT NULL,
	[nombre] [nvarchar](255) NOT NULL,
	[email] [nvarchar](255) NOT NULL,
	[imagen_perfil] [nvarchar](max) NULL,
	[password_hash] [varbinary](max) NOT NULL,
	[password_salt] [nvarchar](50) NOT NULL,
	[password] [nvarchar](max) NULL,
	[tipo_usuario] [nvarchar](10) NULL,
	[fecha_registro] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[V_COUNT_PREDEFINIDAS]    Script Date: 21/03/2025 13:44:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_COUNT_PREDEFINIDAS] AS
SELECT 
    u.id AS usuario_id,
    u.nombre AS nombre_usuario,
    lp.id AS lista_id,
    lp.nombre AS nombre_lista,
    COUNT(ulpl.libro_id) AS cantidad_libros
FROM 
    usuarios u
CROSS JOIN 
    listas_predefinidas lp
LEFT JOIN 
    usuario_lista_predefinida_libro ulpl ON u.id = ulpl.usuario_id AND lp.id = ulpl.lista_predefinida_id
GROUP BY 
    u.id, u.nombre, lp.id, lp.nombre;
GO
/****** Object:  View [dbo].[V_LIBROS_PREDEFINIDAS]    Script Date: 21/03/2025 13:44:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_LIBROS_PREDEFINIDAS] AS
SELECT 
    u.id AS usuario_id,
    u.nombre AS nombre_usuario,
    lp.id AS lista_id,
    lp.nombre AS nombre_lista,
    l.id AS libro_id,
    l.titulo AS titulo_libro,
    l.autor_id,  -- Incluimos el ID del autor
    a.nombre AS autor_nombre, -- Apellido del autor
    l.imagen AS portada_libro,
    ulpl.fecha_agregado
FROM 
    usuarios u
JOIN 
    usuario_lista_predefinida_libro ulpl ON u.id = ulpl.usuario_id
JOIN 
    listas_predefinidas lp ON ulpl.lista_predefinida_id = lp.id
JOIN 
    libros l ON ulpl.libro_id = l.id
JOIN 
    autores a ON l.autor_id = a.id;  
GO
/****** Object:  View [dbo].[V_LIBROS_LEYENDO]    Script Date: 21/03/2025 13:44:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_LIBROS_LEYENDO] AS
SELECT 
    ulpl.usuario_id AS UsuarioId,
    l.id AS LibroId,
    l.titulo AS TituloLibro,
    l.imagen AS ImagenLibro,
	l.paginas AS NumeroPaginas,
    a.id AS AutorId,
    a.nombre AS NombreAutor,
    l.fecha_publicacion AS FechaPublicacion,
    lp.id AS ListaId  -- Agregar el ID de la lista
FROM usuario_lista_predefinida_libro ulpl
JOIN listas_predefinidas lp ON ulpl.lista_predefinida_id = lp.id
JOIN libros l ON ulpl.libro_id = l.id
JOIN autores a ON l.autor_id = a.id 
WHERE lp.nombre = 'Leyendo';
GO
/****** Object:  Table [dbo].[listas_personalizadas]    Script Date: 21/03/2025 13:44:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[listas_personalizadas](
	[id] [int] NOT NULL,
	[usuario_id] [int] NOT NULL,
	[nombre] [nvarchar](255) NOT NULL,
	[descripcion] [nvarchar](255) NULL,
	[fecha_creacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[progreso_lectura]    Script Date: 21/03/2025 13:44:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[progreso_lectura](
	[id] [int] NOT NULL,
	[usuario_id] [int] NOT NULL,
	[libro_id] [int] NOT NULL,
	[porcentaje_leido] [decimal](5, 2) NULL,
	[pagina_actual] [int] NULL,
	[estado_lectura] [varchar](20) NOT NULL,
	[fecha_inicio] [date] NULL,
	[fecha_ultima_actualizacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[resenas]    Script Date: 21/03/2025 13:44:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[resenas](
	[id] [int] NOT NULL,
	[usuario_id] [int] NULL,
	[libro_id] [int] NULL,
	[calificacion] [int] NULL,
	[texto] [nvarchar](max) NULL,
	[fecha_publicacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[autores] ([id], [nombre], [biografia], [imagen_perfil]) VALUES (1, N'J.K. Rowling', N'Escritora británica nacida en 1965, conocida por crear la exitosa serie de novelas de Harry Potter, que ha vendido más de 500 millones de copias en todo el mundo y ha sido adaptada al cine con gran éxito.', N'rowling.jpg')
INSERT [dbo].[autores] ([id], [nombre], [biografia], [imagen_perfil]) VALUES (2, N'George R.R. Martin', N'Escritor estadounidense nacido en 1948, famoso por su serie de novelas "Canción de Hielo y Fuego", adaptada a la exitosa serie de televisión "Juego de Tronos". Su obra se caracteriza por su complejidad narrativa y personajes moralmente ambiguos.', N'martin.jpg')
INSERT [dbo].[autores] ([id], [nombre], [biografia], [imagen_perfil]) VALUES (3, N'Brandon Sanderson', N'Escritor estadounidense nacido en 1975, reconocido por su serie de fantasía "Nacidos de la Bruma" y por completar la saga "La Rueda del Tiempo" tras el fallecimiento de Robert Jordan. Su obra destaca por sistemas de magia innovadores y tramas complejas.', N'sanderson.jpg')
INSERT [dbo].[autores] ([id], [nombre], [biografia], [imagen_perfil]) VALUES (4, N'J.R.R. Tolkien', N'Filólogo y escritor británico (1892-1973), conocido por ser el autor de "El Hobbit" y "El Señor de los Anillos", obras que sentaron las bases de la literatura de fantasía moderna.', N'tolkien.jpg')
INSERT [dbo].[autores] ([id], [nombre], [biografia], [imagen_perfil]) VALUES (5, N'Frank Herbert', N'Escritor estadounidense (1920-1986), famoso por su novela "Dune", considerada una de las obras más importantes de la ciencia ficción, que explora temas de política, religión y ecología en un universo complejo.', N'herbert.jpg')
INSERT [dbo].[autores] ([id], [nombre], [biografia], [imagen_perfil]) VALUES (6, N'Patrick Rothfuss', N'Escritor estadounidense nacido en 1973, conocido por su serie "Crónica del Asesino de Reyes", que comienza con "El Nombre del Viento". Su estilo narrativo se caracteriza por una prosa lírica y una construcción detallada del mundo.', N'rothfuss.jpg')
INSERT [dbo].[autores] ([id], [nombre], [biografia], [imagen_perfil]) VALUES (7, N'Shaara J. Maas', N'Autora conocida por su serie de fantasía "Una corte de rosas y espinas".', N'shaara_maas.jpg')
INSERT [dbo].[autores] ([id], [nombre], [biografia], [imagen_perfil]) VALUES (8, N'Ali Hazelwood', N'Autora de comedias románticas ambientadas en el mundo científico, como "La hipótesis del amor".', N'ali_hazelwood.jpg')
INSERT [dbo].[autores] ([id], [nombre], [biografia], [imagen_perfil]) VALUES (9, N'Rebeca Yarros', N'Autora de la saga "Dragones", una serie de fantasía épica.', N'rebeca_yarros.jpg')
GO
INSERT [dbo].[etiquetas] ([id], [nombre]) VALUES (4, N'Aventura')
INSERT [dbo].[etiquetas] ([id], [nombre]) VALUES (6, N'Ciencia Ficción')
INSERT [dbo].[etiquetas] ([id], [nombre]) VALUES (5, N'Clásico')
INSERT [dbo].[etiquetas] ([id], [nombre]) VALUES (3, N'Épico')
INSERT [dbo].[etiquetas] ([id], [nombre]) VALUES (1, N'Fantasía')
INSERT [dbo].[etiquetas] ([id], [nombre]) VALUES (7, N'Fantasía Oscura')
INSERT [dbo].[etiquetas] ([id], [nombre]) VALUES (2, N'Magia')
INSERT [dbo].[etiquetas] ([id], [nombre]) VALUES (8, N'Mitología')
GO
INSERT [dbo].[libros] ([id], [titulo], [autor_id], [saga], [posicion_saga], [fecha_publicacion], [paginas], [sinopsis], [imagen], [calificacion]) VALUES (1, N'Harry Potter y la Piedra Filosofal', 1, N'Harry Potter', 1, CAST(N'1997-06-26' AS Date), 320, N'Harry Potter, un niño huérfano que vive con sus tíos, descubre en su undécimo cumpleaños que es un mago y es invitado a asistir al Colegio Hogwarts de Magia y Hechicería. Allí, hace amigos y enemigos, y comienza a desentrañar los misterios de su pasado y su conexión con el oscuro mago Voldemort.', N'hp1.jpg', CAST(4.90 AS Decimal(3, 2)))
INSERT [dbo].[libros] ([id], [titulo], [autor_id], [saga], [posicion_saga], [fecha_publicacion], [paginas], [sinopsis], [imagen], [calificacion]) VALUES (2, N'Juego de Tronos', 2, N'Canción de Hielo y Fuego', 1, CAST(N'1996-08-06' AS Date), 694, N'En el continente de Westeros, varias casas nobles compiten por el control del Trono de Hierro. Mientras tanto, en el norte, una antigua amenaza resurge. La novela entrelaza intriga política, guerra y elementos sobrenaturales en un mundo de fantasía compleja.', N'got.jpg', CAST(4.70 AS Decimal(3, 2)))
INSERT [dbo].[libros] ([id], [titulo], [autor_id], [saga], [posicion_saga], [fecha_publicacion], [paginas], [sinopsis], [imagen], [calificacion]) VALUES (3, N'El Imperio Final', 3, N'Nacidos de la Bruma', 1, CAST(N'2006-07-17' AS Date), 541, N'En un mundo donde las cenizas caen del cielo y la niebla domina las noches, un grupo de rebeldes liderados por Kelsier busca derrocar al Lord Legislador, un tirano inmortal. Vin, una joven ladrona, descubre sus poderes alománticos y se une a la lucha por la liberación.', N'mistborn.jpg', CAST(4.80 AS Decimal(3, 2)))
INSERT [dbo].[libros] ([id], [titulo], [autor_id], [saga], [posicion_saga], [fecha_publicacion], [paginas], [sinopsis], [imagen], [calificacion]) VALUES (4, N'Harry Potter y la Cámara Secreta', 1, N'Harry Potter', 2, CAST(N'1998-07-02' AS Date), 341, N'Harry Potter regresa a su segundo año en Hogwarts, donde descubre la Cámara Secreta, un lugar misterioso lleno de peligros. Un ser maligno amenaza a los estudiantes, y Harry debe resolver el misterio antes de que sea demasiado tarde.', N'hp2.jpg', CAST(4.80 AS Decimal(3, 2)))
INSERT [dbo].[libros] ([id], [titulo], [autor_id], [saga], [posicion_saga], [fecha_publicacion], [paginas], [sinopsis], [imagen], [calificacion]) VALUES (5, N'Choque de Reyes', 2, N'Canción de Hielo y Fuego', 2, CAST(N'1998-11-16' AS Date), 768, N'En el segundo libro de "Canción de Hielo y Fuego", las casas nobles de Westeros luchan por el Trono de Hierro mientras las fuerzas oscuras se agitan en el Norte y en el mar. La lucha por el poder es más violenta que nunca.', N'got2.jpg', CAST(4.70 AS Decimal(3, 2)))
INSERT [dbo].[libros] ([id], [titulo], [autor_id], [saga], [posicion_saga], [fecha_publicacion], [paginas], [sinopsis], [imagen], [calificacion]) VALUES (6, N'El Pozo de la Ascensión', 3, N'Nacidos de la Bruma', 2, CAST(N'2007-08-21' AS Date), 590, N'Tras la caída del Lord Legislador, Vin y Elend luchan por restaurar el orden en un mundo caótico. El Pozo de la Ascensión es la clave para salvar su mundo, pero sus enemigos también quieren aprovecharlo para sus propios fines.', N'mistborn2.jpg', CAST(4.80 AS Decimal(3, 2)))
INSERT [dbo].[libros] ([id], [titulo], [autor_id], [saga], [posicion_saga], [fecha_publicacion], [paginas], [sinopsis], [imagen], [calificacion]) VALUES (7, N'Harry Potter y el Prisionero de Azkaban', 1, N'Harry Potter', 3, CAST(N'1999-07-08' AS Date), 435, N'En su tercer año en Hogwarts, Harry Potter se enfrenta a nuevos peligros. Un prisionero fugitivo, Sirius Black, escapa de Azkaban y parece tener una conexión personal con Harry. La batalla por la verdad comienza.', N'hp3.jpg', CAST(4.90 AS Decimal(3, 2)))
INSERT [dbo].[libros] ([id], [titulo], [autor_id], [saga], [posicion_saga], [fecha_publicacion], [paginas], [sinopsis], [imagen], [calificacion]) VALUES (8, N'Tormenta de Espadas', 2, N'Canción de Hielo y Fuego', 3, CAST(N'2000-08-08' AS Date), 973, N'En el tercer libro de "Canción de Hielo y Fuego", las batallas por el Trono de Hierro se intensifican, con alianzas rotas y traiciones inesperadas. La llamada "Boda Roja" sacude los cimientos de la nobleza, y todo Westeros está al borde de la guerra.', N'got3.jpg', CAST(4.90 AS Decimal(3, 2)))
INSERT [dbo].[libros] ([id], [titulo], [autor_id], [saga], [posicion_saga], [fecha_publicacion], [paginas], [sinopsis], [imagen], [calificacion]) VALUES (9, N'El Héroe de las Eras', 3, N'Nacidos de la Bruma', 3, CAST(N'2008-10-14' AS Date), 724, N'Vin y Elend enfrentan una amenaza aún mayor en este libro, mientras luchan por establecer una nueva sociedad tras la caída del Lord Legislador. El mundo está en sus manos, pero los enemigos se multiplican y el fin parece inevitable.', N'mistborn3.jpg', CAST(4.90 AS Decimal(3, 2)))
INSERT [dbo].[libros] ([id], [titulo], [autor_id], [saga], [posicion_saga], [fecha_publicacion], [paginas], [sinopsis], [imagen], [calificacion]) VALUES (10, N'El Hobbit', 4, NULL, NULL, CAST(N'1937-09-21' AS Date), 310, N'Bilbo Bolsón, un hobbit tranquilo, se ve arrastrado a una aventura inesperada con un grupo de enanos y el mago Gandalf. Juntos viajan hacia la Montaña Solitaria para recuperar un tesoro robado y enfrentarse a un dragón temible.', N'hobbit.jpg', CAST(4.80 AS Decimal(3, 2)))
INSERT [dbo].[libros] ([id], [titulo], [autor_id], [saga], [posicion_saga], [fecha_publicacion], [paginas], [sinopsis], [imagen], [calificacion]) VALUES (11, N'El Silmarillion', 4, NULL, NULL, CAST(N'1977-09-15' AS Date), 365, N'El Silmarillion relata los eventos más antiguos de la Tierra Media, desde la creación del mundo hasta las primeras grandes guerras. Es una obra que explora la lucha entre el bien y el mal, con los Elfos, los Hombres y otras razas en el centro de la historia.', N'silmarillion.jpg', CAST(4.70 AS Decimal(3, 2)))
INSERT [dbo].[libros] ([id], [titulo], [autor_id], [saga], [posicion_saga], [fecha_publicacion], [paginas], [sinopsis], [imagen], [calificacion]) VALUES (12, N'Dune', 5, N'Dune', 1, CAST(N'1965-08-01' AS Date), 412, N'Paul Atreides, heredero de la Casa Atreides, se enfrenta a su destino en el planeta desértico Arrakis. En este lugar, donde se extrae la especia más valiosa del universo, Paul descubrirá su rol en un conflicto que cambiará el curso de la historia.', N'dune.jpg', CAST(4.80 AS Decimal(3, 2)))
INSERT [dbo].[libros] ([id], [titulo], [autor_id], [saga], [posicion_saga], [fecha_publicacion], [paginas], [sinopsis], [imagen], [calificacion]) VALUES (13, N'El Nombre del Viento', 6, N'Crónica del Asesino de Reyes', 1, CAST(N'2007-03-27' AS Date), 662, N'Kvothe, el hombre legendario, narra su vida desde su infancia hasta su ascenso como mago prodigio. A lo largo de su historia, se enfrenta a misterios, a la magia y a los secretos de su propio pasado mientras busca venganza por la tragedia que destruyó su vida.', N'nombre_viento.jpg', CAST(4.90 AS Decimal(3, 2)))
INSERT [dbo].[libros] ([id], [titulo], [autor_id], [saga], [posicion_saga], [fecha_publicacion], [paginas], [sinopsis], [imagen], [calificacion]) VALUES (14, N'Una corte de rosas y espinas', 7, N'Una corte de rosas y espinas', 1, CAST(N'2015-05-05' AS Date), 432, N'Cuando Feyre, una cazadora mortal, mata a un lobo en el bosque, arrastra a su familia a una vida de servidumbre en la tierra de las hadas.', N'acotar1.jpg', CAST(4.80 AS Decimal(3, 2)))
INSERT [dbo].[libros] ([id], [titulo], [autor_id], [saga], [posicion_saga], [fecha_publicacion], [paginas], [sinopsis], [imagen], [calificacion]) VALUES (15, N'Una corte de niebla y furia', 7, N'Una corte de rosas y espinas', 2, CAST(N'2016-05-03' AS Date), 624, N'Feyre enfrenta las consecuencias de sus acciones y descubre secretos que cambiarán su destino y el de las tierras de las hadas.', N'acotar2.jpg', CAST(4.70 AS Decimal(3, 2)))
INSERT [dbo].[libros] ([id], [titulo], [autor_id], [saga], [posicion_saga], [fecha_publicacion], [paginas], [sinopsis], [imagen], [calificacion]) VALUES (16, N'Una corte de alas y ruina', 7, N'Una corte de rosas y espinas', 3, CAST(N'2017-05-02' AS Date), 700, N'La batalla por el trono de las hadas se intensifica, y Feyre debe tomar decisiones que afectarán a todos los reinos.', N'acotar3.jpg', CAST(4.90 AS Decimal(3, 2)))
INSERT [dbo].[libros] ([id], [titulo], [autor_id], [saga], [posicion_saga], [fecha_publicacion], [paginas], [sinopsis], [imagen], [calificacion]) VALUES (17, N'La hipótesis del amor', 8, NULL, NULL, CAST(N'2021-06-15' AS Date), 368, N'Olive Smith, una estudiante de doctorado, se ve envuelta en una relación falsa con el profesor Adam Carlsen, lo que desencadena una serie de eventos inesperados.', N'hipotesis_amor.jpg', CAST(4.80 AS Decimal(3, 2)))
INSERT [dbo].[libros] ([id], [titulo], [autor_id], [saga], [posicion_saga], [fecha_publicacion], [paginas], [sinopsis], [imagen], [calificacion]) VALUES (18, N'La química del amor', 8, NULL, NULL, CAST(N'2022-03-10' AS Date), 400, N'Bee Königswasser, una ingeniera de la NASA, se encuentra trabajando en un proyecto junto a su antiguo compañero Levi Ward, reviviendo viejas rivalidades y sentimientos.', N'quimica_amor.jpg', CAST(4.70 AS Decimal(3, 2)))
INSERT [dbo].[libros] ([id], [titulo], [autor_id], [saga], [posicion_saga], [fecha_publicacion], [paginas], [sinopsis], [imagen], [calificacion]) VALUES (19, N'Del odio al amor', 8, NULL, NULL, CAST(N'2023-09-05' AS Date), 450, N'Tres ingenieras enfrentan desafíos profesionales y personales en el mundo de la ciencia, descubriendo que el amor puede surgir en los lugares más inesperados.', N'odio_amor.jpg', CAST(4.90 AS Decimal(3, 2)))
INSERT [dbo].[libros] ([id], [titulo], [autor_id], [saga], [posicion_saga], [fecha_publicacion], [paginas], [sinopsis], [imagen], [calificacion]) VALUES (20, N'Alas de sangre', 9, N'Empíreo', 1, CAST(N'2023-04-12' AS Date), 450, N'Violet Sorrengail, con una enfermedad crónica, es obligada a ingresar en una academia militar de jinetes de dragones, donde descubre su verdadera fuerza.', N'alas_sangre.jpg', CAST(4.80 AS Decimal(3, 2)))
INSERT [dbo].[libros] ([id], [titulo], [autor_id], [saga], [posicion_saga], [fecha_publicacion], [paginas], [sinopsis], [imagen], [calificacion]) VALUES (21, N'Alas de hierro', 9, N'Empíreo', 2, CAST(N'2023-11-07' AS Date), 470, N'La lucha de Violet continúa mientras enfrenta desafíos aún mayores en un mundo lleno de magia, dragones y secretos.', N'alas_hierro.jpg', CAST(4.90 AS Decimal(3, 2)))
INSERT [dbo].[libros] ([id], [titulo], [autor_id], [saga], [posicion_saga], [fecha_publicacion], [paginas], [sinopsis], [imagen], [calificacion]) VALUES (22, N'Alas de ónix', 9, N'Empíreo', 3, CAST(N'2025-01-21' AS Date), 490, N'Violet y sus aliados se enfrentan a nuevas amenazas en su misión por salvar su mundo, mientras exploran territorios desconocidos.', N'alas_onix.jpg', CAST(5.00 AS Decimal(3, 2)))
GO
INSERT [dbo].[libros_etiquetas] ([libro_id], [etiqueta_id]) VALUES (1, 1)
INSERT [dbo].[libros_etiquetas] ([libro_id], [etiqueta_id]) VALUES (1, 2)
INSERT [dbo].[libros_etiquetas] ([libro_id], [etiqueta_id]) VALUES (2, 3)
INSERT [dbo].[libros_etiquetas] ([libro_id], [etiqueta_id]) VALUES (3, 4)
INSERT [dbo].[libros_etiquetas] ([libro_id], [etiqueta_id]) VALUES (4, 1)
INSERT [dbo].[libros_etiquetas] ([libro_id], [etiqueta_id]) VALUES (4, 2)
INSERT [dbo].[libros_etiquetas] ([libro_id], [etiqueta_id]) VALUES (5, 3)
INSERT [dbo].[libros_etiquetas] ([libro_id], [etiqueta_id]) VALUES (5, 4)
INSERT [dbo].[libros_etiquetas] ([libro_id], [etiqueta_id]) VALUES (6, 3)
INSERT [dbo].[libros_etiquetas] ([libro_id], [etiqueta_id]) VALUES (6, 4)
INSERT [dbo].[libros_etiquetas] ([libro_id], [etiqueta_id]) VALUES (7, 1)
INSERT [dbo].[libros_etiquetas] ([libro_id], [etiqueta_id]) VALUES (7, 2)
INSERT [dbo].[libros_etiquetas] ([libro_id], [etiqueta_id]) VALUES (7, 7)
INSERT [dbo].[libros_etiquetas] ([libro_id], [etiqueta_id]) VALUES (8, 3)
INSERT [dbo].[libros_etiquetas] ([libro_id], [etiqueta_id]) VALUES (8, 4)
INSERT [dbo].[libros_etiquetas] ([libro_id], [etiqueta_id]) VALUES (8, 7)
INSERT [dbo].[libros_etiquetas] ([libro_id], [etiqueta_id]) VALUES (9, 3)
INSERT [dbo].[libros_etiquetas] ([libro_id], [etiqueta_id]) VALUES (9, 4)
INSERT [dbo].[libros_etiquetas] ([libro_id], [etiqueta_id]) VALUES (10, 1)
INSERT [dbo].[libros_etiquetas] ([libro_id], [etiqueta_id]) VALUES (10, 4)
INSERT [dbo].[libros_etiquetas] ([libro_id], [etiqueta_id]) VALUES (10, 5)
INSERT [dbo].[libros_etiquetas] ([libro_id], [etiqueta_id]) VALUES (11, 1)
INSERT [dbo].[libros_etiquetas] ([libro_id], [etiqueta_id]) VALUES (11, 3)
INSERT [dbo].[libros_etiquetas] ([libro_id], [etiqueta_id]) VALUES (11, 8)
INSERT [dbo].[libros_etiquetas] ([libro_id], [etiqueta_id]) VALUES (12, 3)
INSERT [dbo].[libros_etiquetas] ([libro_id], [etiqueta_id]) VALUES (12, 4)
INSERT [dbo].[libros_etiquetas] ([libro_id], [etiqueta_id]) VALUES (12, 6)
INSERT [dbo].[libros_etiquetas] ([libro_id], [etiqueta_id]) VALUES (13, 1)
INSERT [dbo].[libros_etiquetas] ([libro_id], [etiqueta_id]) VALUES (13, 2)
INSERT [dbo].[libros_etiquetas] ([libro_id], [etiqueta_id]) VALUES (13, 4)
GO
INSERT [dbo].[listas_predefinidas] ([id], [nombre]) VALUES (1, N'Leyendo')
INSERT [dbo].[listas_predefinidas] ([id], [nombre]) VALUES (2, N'Leído')
INSERT [dbo].[listas_predefinidas] ([id], [nombre]) VALUES (3, N'A leer')
INSERT [dbo].[listas_predefinidas] ([id], [nombre]) VALUES (4, N'No terminado')
GO
INSERT [dbo].[objetivos_lectura] ([id], [usuario_id], [titulo], [fecha_inicio], [fecha_fin], [tipo], [meta], [progreso], [estado]) VALUES (1, 1, N'Leer 10 libros este año', CAST(N'2025-03-08' AS Date), CAST(N'2025-12-31' AS Date), N'libros', 10, 25, N'activo')
INSERT [dbo].[objetivos_lectura] ([id], [usuario_id], [titulo], [fecha_inicio], [fecha_fin], [tipo], [meta], [progreso], [estado]) VALUES (2, 1, N'Leer 5000 páginas', CAST(N'2025-03-08' AS Date), CAST(N'2025-12-31' AS Date), N'paginas', 5000, 120, N'activo')
INSERT [dbo].[objetivos_lectura] ([id], [usuario_id], [titulo], [fecha_inicio], [fecha_fin], [tipo], [meta], [progreso], [estado]) VALUES (3, 1, N'Prueba12', CAST(N'2025-03-14' AS Date), CAST(N'2025-03-25' AS Date), N'paginas', 150, 0, N'activo')
GO
INSERT [dbo].[progreso_lectura] ([id], [usuario_id], [libro_id], [porcentaje_leido], [pagina_actual], [estado_lectura], [fecha_inicio], [fecha_ultima_actualizacion]) VALUES (3, 1, 10, CAST(0.00 AS Decimal(5, 2)), 0, N'leyendo', CAST(N'2025-03-13' AS Date), CAST(N'2025-03-13T13:39:53.323' AS DateTime))
INSERT [dbo].[progreso_lectura] ([id], [usuario_id], [libro_id], [porcentaje_leido], [pagina_actual], [estado_lectura], [fecha_inicio], [fecha_ultima_actualizacion]) VALUES (4, 1, 1, CAST(0.00 AS Decimal(5, 2)), 120, N'leyendo', CAST(N'2025-03-13' AS Date), CAST(N'2025-03-13T18:41:27.183' AS DateTime))
INSERT [dbo].[progreso_lectura] ([id], [usuario_id], [libro_id], [porcentaje_leido], [pagina_actual], [estado_lectura], [fecha_inicio], [fecha_ultima_actualizacion]) VALUES (5, 1, 2, CAST(0.00 AS Decimal(5, 2)), 20, N'leyendo', CAST(N'2025-03-13' AS Date), CAST(N'2025-03-13T19:02:37.047' AS DateTime))
INSERT [dbo].[progreso_lectura] ([id], [usuario_id], [libro_id], [porcentaje_leido], [pagina_actual], [estado_lectura], [fecha_inicio], [fecha_ultima_actualizacion]) VALUES (6, 1, 3, CAST(0.00 AS Decimal(5, 2)), 0, N'leyendo', CAST(N'2025-03-14' AS Date), CAST(N'2025-03-14T09:08:32.693' AS DateTime))
GO
INSERT [dbo].[resenas] ([id], [usuario_id], [libro_id], [calificacion], [texto], [fecha_publicacion]) VALUES (1, 1, 1, 5, N'Una historia increíble y mágica. Recomiendo mucho', CAST(N'2025-03-13T09:57:39.240' AS DateTime))
INSERT [dbo].[resenas] ([id], [usuario_id], [libro_id], [calificacion], [texto], [fecha_publicacion]) VALUES (2, 1, 2, 5, N'Muy bueno, pero un poco largo.', CAST(N'2025-03-13T10:03:31.910' AS DateTime))
INSERT [dbo].[resenas] ([id], [usuario_id], [libro_id], [calificacion], [texto], [fecha_publicacion]) VALUES (3, 1, 3, 5, N'Brandon Sanderson es un genio.', CAST(N'2025-03-08T21:37:07.807' AS DateTime))
INSERT [dbo].[resenas] ([id], [usuario_id], [libro_id], [calificacion], [texto], [fecha_publicacion]) VALUES (4, 1, 4, 5, N'Este libro es increíble, lo disfruté mucho ', CAST(N'2025-03-13T10:03:55.633' AS DateTime))
INSERT [dbo].[resenas] ([id], [usuario_id], [libro_id], [calificacion], [texto], [fecha_publicacion]) VALUES (5, 2, 1, 3, N'Este libro es increíble, lo disfruté mucho y lo recomiendo ampliamente.', CAST(N'2025-03-12T20:34:44.197' AS DateTime))
INSERT [dbo].[resenas] ([id], [usuario_id], [libro_id], [calificacion], [texto], [fecha_publicacion]) VALUES (6, 1, 8, 4, N'Genial', CAST(N'2025-03-13T10:18:46.457' AS DateTime))
INSERT [dbo].[resenas] ([id], [usuario_id], [libro_id], [calificacion], [texto], [fecha_publicacion]) VALUES (7, 1, 7, 4, N'Recomendado', CAST(N'2025-03-13T14:07:40.697' AS DateTime))
GO
INSERT [dbo].[usuario_lista_predefinida_libro] ([usuario_id], [lista_predefinida_id], [libro_id], [fecha_agregado]) VALUES (1, 1, 1, CAST(N'2025-03-13T17:49:39.793' AS DateTime))
INSERT [dbo].[usuario_lista_predefinida_libro] ([usuario_id], [lista_predefinida_id], [libro_id], [fecha_agregado]) VALUES (1, 1, 2, CAST(N'2025-03-13T18:38:47.187' AS DateTime))
INSERT [dbo].[usuario_lista_predefinida_libro] ([usuario_id], [lista_predefinida_id], [libro_id], [fecha_agregado]) VALUES (1, 1, 3, CAST(N'2025-03-14T09:08:32.673' AS DateTime))
INSERT [dbo].[usuario_lista_predefinida_libro] ([usuario_id], [lista_predefinida_id], [libro_id], [fecha_agregado]) VALUES (1, 2, 4, CAST(N'2025-03-12T11:46:19.803' AS DateTime))
INSERT [dbo].[usuario_lista_predefinida_libro] ([usuario_id], [lista_predefinida_id], [libro_id], [fecha_agregado]) VALUES (1, 2, 5, CAST(N'2025-03-12T20:51:31.483' AS DateTime))
INSERT [dbo].[usuario_lista_predefinida_libro] ([usuario_id], [lista_predefinida_id], [libro_id], [fecha_agregado]) VALUES (1, 2, 13, CAST(N'2025-03-12T11:46:04.120' AS DateTime))
INSERT [dbo].[usuario_lista_predefinida_libro] ([usuario_id], [lista_predefinida_id], [libro_id], [fecha_agregado]) VALUES (1, 3, 7, CAST(N'2025-03-12T10:17:33.640' AS DateTime))
INSERT [dbo].[usuario_lista_predefinida_libro] ([usuario_id], [lista_predefinida_id], [libro_id], [fecha_agregado]) VALUES (1, 3, 8, CAST(N'2025-03-12T11:42:46.970' AS DateTime))
INSERT [dbo].[usuario_lista_predefinida_libro] ([usuario_id], [lista_predefinida_id], [libro_id], [fecha_agregado]) VALUES (1, 3, 12, CAST(N'2025-03-11T18:27:09.473' AS DateTime))
INSERT [dbo].[usuario_lista_predefinida_libro] ([usuario_id], [lista_predefinida_id], [libro_id], [fecha_agregado]) VALUES (1, 4, 6, CAST(N'2025-03-12T20:51:47.330' AS DateTime))
INSERT [dbo].[usuario_lista_predefinida_libro] ([usuario_id], [lista_predefinida_id], [libro_id], [fecha_agregado]) VALUES (2, 1, 2, CAST(N'2025-03-11T18:25:41.950' AS DateTime))
INSERT [dbo].[usuario_lista_predefinida_libro] ([usuario_id], [lista_predefinida_id], [libro_id], [fecha_agregado]) VALUES (2, 2, 5, CAST(N'2025-03-11T18:35:54.837' AS DateTime))
INSERT [dbo].[usuario_lista_predefinida_libro] ([usuario_id], [lista_predefinida_id], [libro_id], [fecha_agregado]) VALUES (2, 3, 1, CAST(N'2025-03-11T18:35:27.893' AS DateTime))
GO
INSERT [dbo].[usuarios] ([id], [nombre], [email], [imagen_perfil], [password_hash], [password_salt], [password], [tipo_usuario], [fecha_registro]) VALUES (1, N'Bárbara', N'barby.jimenez17@gmail.com', N'default.jpg', 0x0FC7B467D716A0B69EDFF55499F7BBB1DE83ED8530C35E4CC6E6CC97BFBD2574, N'oð?	KÌt½sßàÉ3 &;*ÖV<Ô´ð<zb5µº
E©4:cu	]ü!¼¢â#ïa', N'123', N'lector', CAST(N'2025-03-08T21:36:33.313' AS DateTime))
INSERT [dbo].[usuarios] ([id], [nombre], [email], [imagen_perfil], [password_hash], [password_salt], [password], [tipo_usuario], [fecha_registro]) VALUES (2, N'Prueba', N'prueba@prueba.com', N'default.jpg', 0x0FC7B467D716A0B69EDFF55499F7BBB1DE83ED8530C35E4CC6E6CC97BFBD2574, N'oð?	KÌt½sßàÉ3 &;*ÖV<Ô´ð<zb5µº
E©4:cu	]ü!¼¢â#ïa', N'123', N'lector', CAST(N'2025-03-11T18:23:51.230' AS DateTime))
INSERT [dbo].[usuarios] ([id], [nombre], [email], [imagen_perfil], [password_hash], [password_salt], [password], [tipo_usuario], [fecha_registro]) VALUES (3, N'A', N'correo@correo.com', N'default.jpg', 0x0FC7B467D716A0B69EDFF55499F7BBB1DE83ED8530C35E4CC6E6CC97BFBD2574, N'oð?	KÌt½sßàÉ3 &;*ÖV<Ô´ð<zb5µº
E©4:cu	]ü!¼¢â#ïa', N'123', N'lector', CAST(N'2025-03-14T14:10:04.073' AS DateTime))
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__etiqueta__72AFBCC619A9B5A2]    Script Date: 21/03/2025 13:44:09 ******/
ALTER TABLE [dbo].[etiquetas] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__etiqueta__72AFBCC6E9065A49]    Script Date: 21/03/2025 13:44:09 ******/
ALTER TABLE [dbo].[etiquetas] ADD UNIQUE NONCLUSTERED 
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_libro_titulo]    Script Date: 21/03/2025 13:44:09 ******/
CREATE NONCLUSTERED INDEX [idx_libro_titulo] ON [dbo].[libros]
(
	[titulo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_objetivos_usuario]    Script Date: 21/03/2025 13:44:09 ******/
CREATE NONCLUSTERED INDEX [idx_objetivos_usuario] ON [dbo].[objetivos_lectura]
(
	[usuario_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_progreso_usuario_libro]    Script Date: 21/03/2025 13:44:09 ******/
ALTER TABLE [dbo].[progreso_lectura] ADD  CONSTRAINT [UQ_progreso_usuario_libro] UNIQUE NONCLUSTERED 
(
	[usuario_id] ASC,
	[libro_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [idx_reseñas_libro]    Script Date: 21/03/2025 13:44:09 ******/
CREATE NONCLUSTERED INDEX [idx_reseñas_libro] ON [dbo].[resenas]
(
	[libro_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__usuarios__AB6E6164326016C3]    Script Date: 21/03/2025 13:44:09 ******/
ALTER TABLE [dbo].[usuarios] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__usuarios__AB6E61649841812D]    Script Date: 21/03/2025 13:44:09 ******/
ALTER TABLE [dbo].[usuarios] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [idx_usuario_email]    Script Date: 21/03/2025 13:44:09 ******/
CREATE NONCLUSTERED INDEX [idx_usuario_email] ON [dbo].[usuarios]
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[libros] ADD  DEFAULT ((0)) FOR [calificacion]
GO
ALTER TABLE [dbo].[listas_personalizadas] ADD  DEFAULT (getdate()) FOR [fecha_creacion]
GO
ALTER TABLE [dbo].[objetivos_lectura] ADD  DEFAULT (getdate()) FOR [fecha_inicio]
GO
ALTER TABLE [dbo].[objetivos_lectura] ADD  DEFAULT ((0)) FOR [progreso]
GO
ALTER TABLE [dbo].[objetivos_lectura] ADD  DEFAULT ('activo') FOR [estado]
GO
ALTER TABLE [dbo].[progreso_lectura] ADD  DEFAULT ((0)) FOR [porcentaje_leido]
GO
ALTER TABLE [dbo].[progreso_lectura] ADD  DEFAULT ((0)) FOR [pagina_actual]
GO
ALTER TABLE [dbo].[progreso_lectura] ADD  DEFAULT (getdate()) FOR [fecha_ultima_actualizacion]
GO
ALTER TABLE [dbo].[resenas] ADD  DEFAULT (getdate()) FOR [fecha_publicacion]
GO
ALTER TABLE [dbo].[usuario_lista_predefinida_libro] ADD  DEFAULT (getdate()) FOR [fecha_agregado]
GO
ALTER TABLE [dbo].[usuarios] ADD  DEFAULT ('lector') FOR [tipo_usuario]
GO
ALTER TABLE [dbo].[usuarios] ADD  DEFAULT (getdate()) FOR [fecha_registro]
GO
ALTER TABLE [dbo].[libros]  WITH CHECK ADD FOREIGN KEY([autor_id])
REFERENCES [dbo].[autores] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[libros_etiquetas]  WITH CHECK ADD FOREIGN KEY([etiqueta_id])
REFERENCES [dbo].[etiquetas] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[libros_etiquetas]  WITH CHECK ADD FOREIGN KEY([libro_id])
REFERENCES [dbo].[libros] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[listas_personalizadas]  WITH CHECK ADD FOREIGN KEY([usuario_id])
REFERENCES [dbo].[usuarios] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD FOREIGN KEY([usuario_id])
REFERENCES [dbo].[usuarios] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[progreso_lectura]  WITH CHECK ADD FOREIGN KEY([libro_id])
REFERENCES [dbo].[libros] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[progreso_lectura]  WITH CHECK ADD FOREIGN KEY([usuario_id])
REFERENCES [dbo].[usuarios] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[resenas]  WITH CHECK ADD FOREIGN KEY([libro_id])
REFERENCES [dbo].[libros] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[resenas]  WITH CHECK ADD FOREIGN KEY([usuario_id])
REFERENCES [dbo].[usuarios] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[usuario_lista_predefinida_libro]  WITH CHECK ADD FOREIGN KEY([libro_id])
REFERENCES [dbo].[libros] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[usuario_lista_predefinida_libro]  WITH CHECK ADD FOREIGN KEY([lista_predefinida_id])
REFERENCES [dbo].[listas_predefinidas] ([id])
GO
ALTER TABLE [dbo].[usuario_lista_predefinida_libro]  WITH CHECK ADD FOREIGN KEY([lista_predefinida_id])
REFERENCES [dbo].[listas_predefinidas] ([id])
GO
ALTER TABLE [dbo].[usuario_lista_predefinida_libro]  WITH CHECK ADD FOREIGN KEY([lista_predefinida_id])
REFERENCES [dbo].[listas_predefinidas] ([id])
GO
ALTER TABLE [dbo].[usuario_lista_predefinida_libro]  WITH CHECK ADD FOREIGN KEY([lista_predefinida_id])
REFERENCES [dbo].[listas_predefinidas] ([id])
GO
ALTER TABLE [dbo].[usuario_lista_predefinida_libro]  WITH CHECK ADD FOREIGN KEY([lista_predefinida_id])
REFERENCES [dbo].[listas_predefinidas] ([id])
GO
ALTER TABLE [dbo].[usuario_lista_predefinida_libro]  WITH CHECK ADD FOREIGN KEY([lista_predefinida_id])
REFERENCES [dbo].[listas_predefinidas] ([id])
GO
ALTER TABLE [dbo].[usuario_lista_predefinida_libro]  WITH CHECK ADD FOREIGN KEY([lista_predefinida_id])
REFERENCES [dbo].[listas_predefinidas] ([id])
GO
ALTER TABLE [dbo].[usuario_lista_predefinida_libro]  WITH CHECK ADD FOREIGN KEY([lista_predefinida_id])
REFERENCES [dbo].[listas_predefinidas] ([id])
GO
ALTER TABLE [dbo].[usuario_lista_predefinida_libro]  WITH CHECK ADD FOREIGN KEY([usuario_id])
REFERENCES [dbo].[usuarios] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[libros]  WITH CHECK ADD CHECK  (([calificacion]>=(0) AND [calificacion]<=(5)))
GO
ALTER TABLE [dbo].[libros]  WITH CHECK ADD CHECK  (([calificacion]>=(0) AND [calificacion]<=(5)))
GO
ALTER TABLE [dbo].[libros]  WITH CHECK ADD CHECK  (([calificacion]>=(0) AND [calificacion]<=(5)))
GO
ALTER TABLE [dbo].[libros]  WITH CHECK ADD CHECK  (([calificacion]>=(0) AND [calificacion]<=(5)))
GO
ALTER TABLE [dbo].[libros]  WITH CHECK ADD CHECK  (([calificacion]>=(0) AND [calificacion]<=(5)))
GO
ALTER TABLE [dbo].[libros]  WITH CHECK ADD CHECK  (([calificacion]>=(0) AND [calificacion]<=(5)))
GO
ALTER TABLE [dbo].[libros]  WITH CHECK ADD CHECK  (([calificacion]>=(0) AND [calificacion]<=(5)))
GO
ALTER TABLE [dbo].[libros]  WITH CHECK ADD CHECK  (([calificacion]>=(0) AND [calificacion]<=(5)))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([meta]>(0)))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([meta]>(0)))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([meta]>(0)))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([meta]>(0)))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([meta]>(0)))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([meta]>(0)))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([meta]>(0)))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([meta]>(0)))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([tipo]='paginas' OR [tipo]='libros'))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([tipo]='paginas' OR [tipo]='libros'))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([tipo]='paginas' OR [tipo]='libros'))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([tipo]='paginas' OR [tipo]='libros'))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([tipo]='paginas' OR [tipo]='libros'))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([tipo]='paginas' OR [tipo]='libros'))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([tipo]='paginas' OR [tipo]='libros'))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([tipo]='paginas' OR [tipo]='libros'))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([estado]='archivado' OR [estado]='activo'))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([estado]='archivado' OR [estado]='activo'))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([estado]='archivado' OR [estado]='activo'))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([estado]='archivado' OR [estado]='activo'))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([estado]='archivado' OR [estado]='activo'))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([estado]='archivado' OR [estado]='activo'))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([estado]='archivado' OR [estado]='activo'))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([estado]='archivado' OR [estado]='activo'))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([progreso]>=(0)))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([progreso]>=(0)))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([progreso]>=(0)))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([progreso]>=(0)))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([progreso]>=(0)))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([progreso]>=(0)))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([progreso]>=(0)))
GO
ALTER TABLE [dbo].[objetivos_lectura]  WITH CHECK ADD CHECK  (([progreso]>=(0)))
GO
ALTER TABLE [dbo].[progreso_lectura]  WITH CHECK ADD CHECK  (([estado_lectura]='abandonado' OR [estado_lectura]='leído' OR [estado_lectura]='leyendo' OR [estado_lectura]='por leer'))
GO
ALTER TABLE [dbo].[progreso_lectura]  WITH CHECK ADD CHECK  (([estado_lectura]='abandonado' OR [estado_lectura]='leído' OR [estado_lectura]='leyendo' OR [estado_lectura]='por leer'))
GO
ALTER TABLE [dbo].[progreso_lectura]  WITH CHECK ADD CHECK  (([estado_lectura]='abandonado' OR [estado_lectura]='leído' OR [estado_lectura]='leyendo' OR [estado_lectura]='por leer'))
GO
ALTER TABLE [dbo].[progreso_lectura]  WITH CHECK ADD CHECK  (([estado_lectura]='abandonado' OR [estado_lectura]='leído' OR [estado_lectura]='leyendo' OR [estado_lectura]='por leer'))
GO
ALTER TABLE [dbo].[progreso_lectura]  WITH CHECK ADD CHECK  (([estado_lectura]='abandonado' OR [estado_lectura]='leído' OR [estado_lectura]='leyendo' OR [estado_lectura]='por leer'))
GO
ALTER TABLE [dbo].[progreso_lectura]  WITH CHECK ADD CHECK  (([estado_lectura]='abandonado' OR [estado_lectura]='leído' OR [estado_lectura]='leyendo' OR [estado_lectura]='por leer'))
GO
ALTER TABLE [dbo].[progreso_lectura]  WITH CHECK ADD CHECK  (([estado_lectura]='abandonado' OR [estado_lectura]='leído' OR [estado_lectura]='leyendo' OR [estado_lectura]='por leer'))
GO
ALTER TABLE [dbo].[progreso_lectura]  WITH CHECK ADD CHECK  (([estado_lectura]='abandonado' OR [estado_lectura]='leído' OR [estado_lectura]='leyendo' OR [estado_lectura]='por leer'))
GO
ALTER TABLE [dbo].[progreso_lectura]  WITH CHECK ADD CHECK  (([porcentaje_leido]>=(0) AND [porcentaje_leido]<=(100)))
GO
ALTER TABLE [dbo].[progreso_lectura]  WITH CHECK ADD CHECK  (([porcentaje_leido]>=(0) AND [porcentaje_leido]<=(100)))
GO
ALTER TABLE [dbo].[progreso_lectura]  WITH CHECK ADD CHECK  (([porcentaje_leido]>=(0) AND [porcentaje_leido]<=(100)))
GO
ALTER TABLE [dbo].[progreso_lectura]  WITH CHECK ADD CHECK  (([porcentaje_leido]>=(0) AND [porcentaje_leido]<=(100)))
GO
ALTER TABLE [dbo].[progreso_lectura]  WITH CHECK ADD CHECK  (([porcentaje_leido]>=(0) AND [porcentaje_leido]<=(100)))
GO
ALTER TABLE [dbo].[progreso_lectura]  WITH CHECK ADD CHECK  (([porcentaje_leido]>=(0) AND [porcentaje_leido]<=(100)))
GO
ALTER TABLE [dbo].[progreso_lectura]  WITH CHECK ADD CHECK  (([porcentaje_leido]>=(0) AND [porcentaje_leido]<=(100)))
GO
ALTER TABLE [dbo].[progreso_lectura]  WITH CHECK ADD CHECK  (([porcentaje_leido]>=(0) AND [porcentaje_leido]<=(100)))
GO
ALTER TABLE [dbo].[resenas]  WITH CHECK ADD CHECK  (([calificacion]>=(1) AND [calificacion]<=(5)))
GO
ALTER TABLE [dbo].[resenas]  WITH CHECK ADD CHECK  (([calificacion]>=(1) AND [calificacion]<=(5)))
GO
ALTER TABLE [dbo].[resenas]  WITH CHECK ADD CHECK  (([calificacion]>=(1) AND [calificacion]<=(5)))
GO
ALTER TABLE [dbo].[resenas]  WITH CHECK ADD CHECK  (([calificacion]>=(1) AND [calificacion]<=(5)))
GO
ALTER TABLE [dbo].[resenas]  WITH CHECK ADD CHECK  (([calificacion]>=(1) AND [calificacion]<=(5)))
GO
ALTER TABLE [dbo].[resenas]  WITH CHECK ADD CHECK  (([calificacion]>=(1) AND [calificacion]<=(5)))
GO
ALTER TABLE [dbo].[resenas]  WITH CHECK ADD CHECK  (([calificacion]>=(1) AND [calificacion]<=(5)))
GO
ALTER TABLE [dbo].[resenas]  WITH CHECK ADD CHECK  (([calificacion]>=(1) AND [calificacion]<=(5)))
GO
ALTER TABLE [dbo].[usuarios]  WITH CHECK ADD CHECK  (([tipo_usuario]='lector' OR [tipo_usuario]='admin'))
GO
ALTER TABLE [dbo].[usuarios]  WITH CHECK ADD CHECK  (([tipo_usuario]='lector' OR [tipo_usuario]='admin'))
GO
ALTER TABLE [dbo].[usuarios]  WITH CHECK ADD CHECK  (([tipo_usuario]='lector' OR [tipo_usuario]='admin'))
GO
ALTER TABLE [dbo].[usuarios]  WITH CHECK ADD CHECK  (([tipo_usuario]='lector' OR [tipo_usuario]='admin'))
GO
ALTER TABLE [dbo].[usuarios]  WITH CHECK ADD CHECK  (([tipo_usuario]='lector' OR [tipo_usuario]='admin'))
GO
ALTER TABLE [dbo].[usuarios]  WITH CHECK ADD CHECK  (([tipo_usuario]='lector' OR [tipo_usuario]='admin'))
GO
ALTER TABLE [dbo].[usuarios]  WITH CHECK ADD CHECK  (([tipo_usuario]='lector' OR [tipo_usuario]='admin'))
GO
ALTER TABLE [dbo].[usuarios]  WITH CHECK ADD CHECK  (([tipo_usuario]='lector' OR [tipo_usuario]='admin'))
GO
/****** Object:  StoredProcedure [dbo].[INSERT_OBJETIVO]    Script Date: 21/03/2025 13:44:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[INSERT_OBJETIVO]
    @usuario_id INT,
    @titulo NVARCHAR(255),
    @fecha_fin DATE,
    @tipo NVARCHAR(10),
    @meta INT
AS
BEGIN
    DECLARE @nuevo_id INT;

    -- Obtenemos el ID máximo actual y sumamos 1
    SELECT @nuevo_id = ISNULL(MAX(id), 0) + 1 FROM objetivos_lectura;

    -- Verificamos que el tipo de objetivo sea válido
    IF @tipo NOT IN ('libros', 'paginas')
    BEGIN
        RAISERROR('El tipo de objetivo debe ser "libros" o "paginas".', 16, 1);
        RETURN;
    END

    -- Insertamos el nuevo objetivo en la tabla
    INSERT INTO objetivos_lectura (id, usuario_id, titulo, fecha_inicio, fecha_fin, tipo, meta, progreso, estado)
    VALUES (@nuevo_id, @usuario_id, @titulo, GETDATE(), @fecha_fin, @tipo, @meta, 0, 'activo');
    
    -- Confirmamos que el objetivo se ha insertado correctamente
    PRINT 'Objetivo insertado correctamente con ID: ' + CAST(@nuevo_id AS NVARCHAR);
END;
GO
/****** Object:  StoredProcedure [dbo].[INSERT_RESENA]    Script Date: 21/03/2025 13:44:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[INSERT_RESENA]
    @usuario_id INT,
    @libro_id INT,
    @calificacion INT,
    @texto NVARCHAR(MAX) = NULL
AS
BEGIN
    -- Declaramos la variable para el nuevo ID
    DECLARE @nuevo_id INT;

    -- Obtenemos el nuevo ID (máximo actual + 1)
    SELECT @nuevo_id = ISNULL(MAX(id), 0) + 1 FROM resenas;

    -- Insertamos la nueva reseña
    INSERT INTO resenas (id, usuario_id, libro_id, calificacion, texto)
    VALUES (@nuevo_id, @usuario_id, @libro_id, @calificacion, @texto);
END;
GO
/****** Object:  StoredProcedure [dbo].[InsertarProgresoLectura]    Script Date: 21/03/2025 13:44:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertarProgresoLectura]
    @UsuarioId INT,
    @LibroId INT
	AS
	BEGIN
		DECLARE @nuevo_id INT;
		DECLARE @time DATETIME = GetDate();

    -- Obtenemos el nuevo ID (máximo actual + 1)
		SELECT @nuevo_id = ISNULL(MAX(id), 0) + 1 FROM progreso_lectura;
        INSERT INTO progreso_lectura (id, usuario_id, libro_id, porcentaje_leido, pagina_actual, estado_lectura, fecha_inicio, fecha_ultima_actualizacion)
        VALUES (@nuevo_id, @UsuarioId, @LibroId, 0,0,'leyendo', @time,@time)
	END;
GO
/****** Object:  StoredProcedure [dbo].[sp_MoverLibroEntreListas]    Script Date: 21/03/2025 13:44:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_MoverLibroEntreListas]
    @UsuarioID INT,
    @LibroID INT,
    @ListaOrigenID INT,
    @ListaDestinoID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @ResultCode INT = 0;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Si el libro está en CUALQUIER lista (no solo la de origen), eliminarlo
        DELETE FROM usuario_lista_predefinida_libro
        WHERE usuario_id = @UsuarioID 
        AND libro_id = @LibroID;
        
        -- Si el ListaDestinoID no es 0 (0 podría ser un código para "quitar de todas las listas"), 
        -- entonces agregamos a la lista destino
        IF @ListaDestinoID > 0
        BEGIN
            -- Insertar en la lista de destino
            INSERT INTO usuario_lista_predefinida_libro (usuario_id, lista_predefinida_id, libro_id, fecha_agregado)
            VALUES (@UsuarioID, @ListaDestinoID, @LibroID, GETDATE());
            SET @ResultCode = 1;
        END
        ELSE
        BEGIN
            -- Solo eliminamos el libro de todas las listas
            SET @ResultCode = 2;
        END
        
        COMMIT TRANSACTION;
        SELECT @ResultCode AS ResultCode;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        SELECT ERROR_NUMBER() AS ErrorNumber,
               ERROR_MESSAGE() AS ErrorMessage,
               -1 AS ResultCode;
    END CATCH;
END;

CREATE TABLE Producto (
    CodigoProducto VARCHAR(13) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(500) NOT NULL,
    PrecioCompra DECIMAL(10, 3) NOT NULL CHECK (PrecioCompra >= 0),
    PrecioVenta DECIMAL(10, 2) NOT NULL CHECK (PrecioVenta >= 0),
    Stock INT NOT NULL CHECK (Stock >= 0),
    StockMinimo INT NOT NULL CHECK (StockMinimo >= 0),
    Categoria VARCHAR(50),
    Estado NUMBER(1) DEFAULT 1 CHECK (Estado IN(0,1))
);

CREATE TABLE Alerta (
    CodigoAlerta INT PRIMARY KEY,
    CodigoProducto VARCHAR(13) NOT NULL,
    FechaHoraAlerta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CodigoProducto) REFERENCES Producto(CodigoProducto) ON DELETE CASCADE
);

CREATE TABLE Venta (
    CodigoVenta VARCHAR(13) PRIMARY KEY,
    FechaHoraVenta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    EstadoVenta VARCHAR(10) CHECK (EstadoVenta IN ('Finalizado', 'Devuelto')),
    CodigoCliente VARCHAR(15) NOT NULL,
    FOREIGN KEY (CodigoCliente) REFERENCES Cliente(CodigoCliente) ON DELETE CASCADE
);

CREATE TABLE DetalleVenta (
    CodigoDetalleVenta VARCHAR(13) PRIMARY KEY,
    CodigoVenta VARCHAR(13) NOT NULL,
    CodigoProducto VARCHAR(13) NOT NULL,
    Cantidad INT NOT NULL CHECK (Cantidad > 0),
    PrecioVentaFinal DECIMAL(10, 2) NOT NULL CHECK (PrecioVentaFinal >= 0),
    FOREIGN KEY (CodigoVenta) REFERENCES Venta(CodigoVenta) ON DELETE CASCADE,
    FOREIGN KEY (CodigoProducto) REFERENCES Producto(CodigoProducto) ON DELETE CASCADE
);

CREATE TABLE Cliente (
	CodigoCliente VARCHAR(15) PRIMARY KEY,
	Nombre VARCHAR(80) NOT NULL,
	Correo VARCHAR(50) NOT NULL,
	Telefono VARCHAR(20) NOT NULL,
	Direccion VARCHAR(100) NOT NULL,
	PreferenciaContacto NUMBER(1) DEFAULT 0 CHECK (PreferenciaContacto IN (0, 1)),
	Estado NUMBER(1) DEFAULT 1 CHECK (Estado IN (0, 1))
);

CREATE TABLE Notificacion (
	CodigoNotificacion VARCHAR(10) PRIMARY KEY,
	Mensaje VARCHAR(300) NOT NULL
);

CREATE TABLE ClienteNotificacion (
	CodigoCliente VARCHAR(15) NOT NULL,
	CodigoNotificacion VARCHAR(10) NOT NULL,
	FechaHoraMensaje TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (CodigoCliente, CodigoNotificacion),
	FOREIGN KEY (CodigoCliente) REFERENCES Cliente(CodigoCliente) ON DELETE CASCADE,
	FOREIGN KEY (CodigoNotificacion) REFERENCES Notificacion(CodigoNotificacion) ON DELETE CASCADE
);

CREATE TABLE Proveedor (
    CodigoProveedor VARCHAR(10) PRIMARY KEY,
    Nombre VARCHAR(40) NOT NULL,
    Telefono VARCHAR(15) NOT NULL,
    Correo VARCHAR(50) NOT NULL,
    DireccionSocial VARCHAR(100) NOT NULL,
    Estado NUMBER(1) DEFAULT 1 CHECK (Estado IN (0, 1))
);

CREATE TABLE Pedido (
    CodigoPedido VARCHAR(20) PRIMARY KEY,
    FechaSolicitud TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    EstadoPedido VARCHAR(15) DEFAULT 'Pendiente' CHECK (EstadoPedido IN ('Pendiente', 'Cancelado', 'Completado')),
    CodigoProveedor VARCHAR(10) NOT NULL,
    FOREIGN KEY (CodigoProveedor) REFERENCES Proveedor(CodigoProveedor) ON DELETE CASCADE
);

CREATE TABLE DetallePedido (
    CodigoDetallePedido VARCHAR(20) PRIMARY KEY,
    CodigoPedido VARCHAR(20),
    CodigoProducto VARCHAR(13) NOT NULL,
    Cantidad NUMBER(10) CHECK (Cantidad > 0),
    FOREIGN KEY (CodigoPedido) REFERENCES Pedido(CodigoPedido) ON DELETE CASCADE,
    FOREIGN KEY (CodigoProducto) REFERENCES Producto(CodigoProducto) ON DELETE CASCADE
);


CREATE TABLE PedidosCancelados (
    CodigoCancelacion VARCHAR(20) PRIMARY KEY,  
    CodigoPedido VARCHAR(20) NOT NULL,
    FechaCancelacion DATE NOT NULL,
    MotivoCancelacion VARCHAR(100),
    FOREIGN KEY (CodigoPedido) REFERENCES Pedido(CodigoPedido) ON DELETE CASCADE
);


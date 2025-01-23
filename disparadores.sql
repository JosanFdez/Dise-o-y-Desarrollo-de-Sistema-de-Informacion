CREATE OR REPLACE TRIGGER generar_alerta_bajo_stock
AFTER UPDATE ON Producto
FOR EACH ROW
DECLARE
    v_codigo_alerta VARCHAR2(10);
BEGIN
    IF :NEW.Stock < :NEW.StockMinimo THEN
        SELECT CONCAT('N', LPAD(SEQ_ALERTA.NEXTVAL, 9, '0'))
        INTO v_codigo_alerta
        FROM DUAL;

        INSERT INTO Alerta (CodigoAlerta, CodigoProducto)
        VALUES (v_codigo_alerta, :NEW.CodigoProducto);
    END IF;
END;

----------------------------------------------------------------

CREATE OR REPLACE TRIGGER validar_precio_venta
BEFORE INSERT OR UPDATE OF PrecioVenta
ON Producto
FOR EACH ROW
BEGIN
    IF :NEW.PrecioVenta < :NEW.PrecioCompra THEN
        RAISE_APPLICATION_ERROR(-20001, 'El precio de venta no puede ser inferior al precio de compra.');
    END IF;
END;

----------------------------------------------------------------

CREATE OR REPLACE TRIGGER ActualizarEstadoVenta
AFTER INSERT ON DetalleVenta
FOR EACH ROW
DECLARE
TotalDevuelto INT;
BEGIN
SELECT COUNT(*)
INTO TotalDevuelto
FROM DetalleVenta
WHERE CodigoVenta = :NEW.CodigoVenta;
IF TotalDevuelto > 0 THEN
UPDATE Venta
SET EstadoVenta = 'Devuelto'
WHERE CodigoVenta = :NEW.CodigoVenta;
END IF;
END;

----------------------------------------------------------------

CREATE OR REPLACE TRIGGER ControlarStockMinimo
BEFORE INSERT ON DetalleVenta
FOR EACH ROW
DECLARE
	StockActual INT;
BEGIN
	SELECT Stock
	INTO StockActual
	FROM Producto
	WHERE CodigoProducto = :NEW.CodigoProducto;

	IF StockActual - :NEW.Cantidad < 0 THEN
    	RAISE_APPLICATION_ERROR(-20001, 'Error: Stock insuficiente para realizar la venta.');
	ELSE
    	UPDATE Producto
    	SET Stock = Stock - :NEW.Cantidad
    	WHERE CodigoProducto = :NEW.CodigoProducto;
	END IF;
END;

----------------------------------------------------------------

CREATE OR REPLACE TRIGGER NumerarNotificacion
BEFORE INSERT ON Notificacion
FOR EACH ROW
BEGIN
	:NEW.CodigoNotificacion := CONCAT('N', LPAD(SEQ_NOTIFICACION.NEXTVAL, 9, '0'));
END;

----------------------------------------------------------------

CREATE OR REPLACE TRIGGER VerificarProveedorActivo
BEFORE INSERT ON Pedido
FOR EACH ROW
DECLARE
    EstadoProveedor INT;
BEGIN
    SELECT Estado
    INTO EstadoProveedor
    FROM Proveedor
    WHERE CodigoProveedor = :NEW.CodigoProveedor;

    IF EstadoProveedor != 1 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El proveedor no está activo. No se puede realizar el pedido.');
    END IF;
END;

----------------------------------------------------------------

CREATE OR REPLACE TRIGGER actualizar_stock_completado
AFTER UPDATE OF EstadoPedido ON Pedido
FOR EACH ROW
BEGIN
    IF :NEW.EstadoPedido = 'Completado' THEN
        FOR detalle IN (
            SELECT CodigoProducto, Cantidad
            FROM DetallePedido
            WHERE CodigoPedido = :NEW.CodigoPedido
        ) LOOP
            UPDATE Producto
            SET Stock = Stock + detalle.Cantidad
            WHERE CodigoProducto = detalle.CodigoProducto;
        END LOOP;
    END IF;
END;

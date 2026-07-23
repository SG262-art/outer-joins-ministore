-- ══════════════════════════════════════════
-- MiniStore — Soluciones con Outer JOINs
-- Autor: Estudiante
-- Fecha: 2026
-- ══════════════════════════════════════════

-- ── CONSULTA 1: LEFT JOIN ─────────────────
-- Pregunta de negocio: ¿Qué productos del catálogo nunca fueron vendidos?
-- Muestra todos los productos del catálogo y aísla aquellos que no registran ventas (venta_id IS NULL).

SELECT 
    p.producto_id,
    p.nombre,
    p.categoria,
    p.precio,
    v.venta_id,
    v.fecha_venta
FROM productos p
LEFT JOIN ventas v ON p.producto_id = v.producto_id
WHERE v.venta_id IS NULL;


-- ── CONSULTA 2: RIGHT JOIN ────────────────
-- Pregunta de negocio: ¿Existen ventas registradas con productos que no figuran en nuestro catálogo?
-- Preserva todas las transacciones de ventas e identifica registros huérfanos (p.producto_id IS NULL).

SELECT 
    v.venta_id,
    v.producto_id AS producto_id_venta,
    v.cliente_id,
    v.cantidad,
    v.fecha_venta,
    p.nombre AS nombre_producto_catalogo
FROM productos p
RIGHT JOIN ventas v ON p.producto_id = v.producto_id
WHERE p.producto_id IS NULL;


-- ── CONSULTA 3: FULL OUTER JOIN ───────────
-- Pregunta de negocio: Vista completa de auditoría que muestre todos los productos y todas las ventas sin perder ninguna fila.
-- Compatible con PostgreSQL y SQL Server (en MySQL se simula mediante UNION de LEFT y RIGHT JOIN).

SELECT 
    p.producto_id AS id_producto_catalogo,
    p.nombre AS producto_nombre,
    p.categoria,
    p.precio,
    v.venta_id,
    v.producto_id AS id_producto_venta,
    v.cantidad,
    v.fecha_venta
FROM productos p
FULL OUTER JOIN ventas v ON p.producto_id = v.producto_id
ORDER BY p.producto_id, v.venta_id;

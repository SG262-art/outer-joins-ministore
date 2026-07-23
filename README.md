# MiniStore 
# MODULO 5 - UNIDAD 3: Práctica LEFT, RIGHT y FULL OUTER JOIN: analizando inventario y ventas de una tienda minorista

Auditoría de calidad de datos e integración de catálogo vs. ventas.

---

## Estructura del Repositorio

outer-joins-ministore/
├── schema.sql
├── soluciones.sql
└── README.md

---

## Preguntas Técnicas

### 1. ¿Por qué se usó LEFT JOIN para la Consulta 1 y no INNER JOIN? ¿Qué se perdería con INNER JOIN?

LEFT JOIN, para ubicar la tabla `productos` a la izquierda, el objetivo del negocio es conservar la totalidad del catálogo de productos, sin importar si tienen o no transacciones registradas. 

Si utilizamos un `INNER JOIN`, la base de datos habría descartado los productos `108`  y `109`, por no tener coincidencias en la tabla `ventas` y se habría perdido la visibilidad del stock sin rotación, imposibilitando responder la pregunta sobre qué artículos nunca han sido vendidos.

---

### 2. ¿Por qué se usó RIGHT JOIN para la Consulta 2? ¿Qué tabla está a la izquierda y cuál a la derecha?

RIGHT JOIN, para garantizar la revisión de todas las transacciones de la tabla `ventas`, a la derecha del JOIN.

* Tabla izquierda: `productos`
* Tabla derecha:** `ventas`

Priorizando la tabla `ventas`, permitiendo detectar inconsistencias operativas donde una transacción fue procesada en el sistema pero que no cuenta con un producto asociado dentro del catálogo general.

---

### 3. ¿Qué representan los valores NULL en cada resultado?


* En la Consulta 1 (`v.venta_id IS NULL`): significa que dichos artículos existen formalmente en el inventario, pero jamás han registrado una transacción de compra en la tabla `ventas`. Columna `venta_id` sea `NULL` para los productos `108` y `109`
* En la Consulta 2 (`p.producto_id IS NULL`): significa que existe una venta registrada en el sistema cuyo código de producto no corresponde a ningún ítem. Representa un mal registro o un error en la carga de datos. Columnas desde `productos` sean `NULL` para la transacción `venta_id = 10`

---

### 4. ¿Cuándo usarías FULL OUTER JOIN en un caso real de negocio?

FULL OUTER JOIN, para escenarios de: auditoría integral de datos, conciliaciones contables o migraciones de sistemas. 

Para cuando se requiere comparar dos fuentes de datos para identificar:
1. Registros que coinciden en ambas fuentes.
2. Registros que existen únicamente en el origen T1.
3. Registros que existen únicamente en el origen T2.

---

## Tecnologías Utilizadas

* **Gestor de Base de Datos:** PostgreSQL
* **SQL Client:** VS Code / PostgreSQL (por Chris Kolkman)
* **Control de Versiones:** Git & GitHub

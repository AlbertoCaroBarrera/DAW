SELECT * 
FROM CLIENTES C,DETALLEPEDIDOS D,EMPLEADOS E,GAMASPRODUCTOS G,OFICINAS O,PAGOS PA,PEDIDOS PE,PRODUCTOS PR;

--1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.

SELECT CODIGOOFICINA, CIUDAD
FROM OFICINAS;

--2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.

SELECT CIUDAD, TELEFONO
FROM OFICINAS;

--3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.

SELECT NOMBRE,APELLIDO1,APELLIDO2,EMAIL
FROM EMPLEADOS
WHERE CODIGOJEFE=7;

--4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.

SELECT PUESTO, APELLIDO1, APELLIDO2,EMAIL
FROM EMPLEADOS
WHERE CODIGOJEFE IS NULL; 

--5. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.

SELECT NOMBRE,APELLIDO1,APELLIDO2,PUESTO
FROM EMPLEADOS
WHERE UPPER(PUESTO) NOT IN UPPER('Representante Ventas');

--6. Devuelve un listado con el nombre de los todos los clientes españoles.

SELECT * 
FROM CLIENTES
WHERE UPPER(PAIS) NOT IN ('SPAIN');

--7. Devuelve un listado con los distintos estados por los que puede pasar un pedido.

SELECT DISTINCT(ESTADO)
FROM PEDIDOS;

--8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar
--aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:


SELECT codigocliente, fechapago
FROM PAGOS 
WHERE fechapago >=  TO_DATE('01/01/2008','DD/MM/YYYY') 
AND fechapago <=  TO_DATE('31/12/2008','DD/MM/YYYY');

--9. Devuelve un listado con el código de pedido, código de cliente, fecha
--esperada y fecha de entrega de los pedidos que no han sido entregados a                   DUDA
--tiempo.

SELECT codigopedido ,codigocliente,fechaesperada,fechaentrega
FROM PEDIDOS
WHERE fechaesperada < fechaentrega
OR UPPER(ESTADO) = UPPER('Pendiente');

--10.Devuelve un listado con el código de pedido, código de cliente, fecha
--esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al
--menos dos días antes de la fecha esperada.

SELECT codigopedido ,codigocliente,fechaesperada,fechaentrega
FROM PEDIDOS
WHERE fechaentrega <= fechaesperada-2;

--11.Devuelve un listado de todos los pedidos que fueron rechazados en 2009                        DUDA

SELECT * 
FROM PEDIDOS
WHERE UPPER(ESTADO) = UPPER('Rechazado')                      
AND FECHAPEDIDO >=  TO_DATE('01/01/2009','DD/MM/YYYY') 
AND FECHAPEDIDO <=  TO_DATE('31/12/2009','DD/MM/YYYY') ;

--12.Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.

SELECT *
FROM PEDIDOS
WHERE TO_CHAR(FECHAENTREGA,'MM') = '01' ;

--13.Devuelve un listado con todos los pagos que se realizaron en el año 2008
--mediante Paypal. Ordene el resultado de mayor a menor.

SELECT *
FROM PAGOS
WHERE UPPER(FORMAPAGO) = 'PAYPAL'
AND TO_CHAR(FECHAPAGO,'YYYY') = '2008';

--14.Devuelve un listado con todas las formas de pago que aparecen en la tabla
--pago. Tenga en cuenta que no deben aparecer formas de pago repetidas.

SELECT DISTINCT(FORMAPAGO)
FROM PAGOS;

--15.Devuelve un listado con todos los productos que pertenecen a la gama
--Ornamentales y que tienen más de 100 unidades en stock. El listado deberá
--estar ordenado por su precio de venta, mostrando en primer lugar los de
--mayor precio.

SELECT *
FROM PRODUCTOS
WHERE UPPER(GAMA) = UPPER('Ornamentales')
AND cantidadenstock > 100
ORDER BY precioventa DESC;

--16.Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y
--cuyo representante de ventas tenga el código de empleado 11 o 30.

SELECT *
FROM CLIENTES
WHERE UPPER(CIUDAD)='MADRID'
AND codigoempleadorepventas IN (11,30);

--17.Obtén un listado con el nombre de cada cliente y el nombre y apellido de su
--representante de ventas.

SELECT c.nombrecliente,e.nombre,e.apellido1,e.apellido2
FROM CLIENTES C, EMPLEADOS E
WHERE C.codigoempleadorepventas = e.codigoempleado;

--18.Muestra el nombre de los clientes que hayan realizado pagos junto con el
--nombre de sus representantes de ventas.

SELECT c.nombrecliente,e.nombre
FROM CLIENTES C,PAGOS P,EMPLEADOS E
WHERE c.codigocliente = p.codigocliente
AND C.codigoempleadorepventas = e.codigoempleado;

--19.Muestra el nombre de los clientes que no hayan realizado pagos junto con el
--nombre de sus representantes de ventas.

SELECT c.nombrecliente,e.nombre
FROM CLIENTES C,PAGOS P,EMPLEADOS E
WHERE c.codigocliente = p.codigocliente(+)
AND C.codigoempleadorepventas = e.codigoempleado
AND p.codigocliente IS NULL;

--20.Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus
--representantes junto con la ciudad de la oficina a la que pertenece el
--representante.

SELECT c.nombrecliente,e.nombre,o.ciudad
FROM CLIENTES C,PAGOS P,EMPLEADOS E,OFICINAS O
WHERE c.codigocliente = p.codigocliente
AND C.codigoempleadorepventas = e.codigoempleado
AND o.codigooficina = e.codigooficina;

--21.Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre
--de sus representantes junto con la ciudad de la oficina a la que pertenece el
--representante.


SELECT c.nombrecliente,e.nombre,o.ciudad
FROM CLIENTES C,PAGOS P,EMPLEADOS E,OFICINAS O
WHERE c.codigocliente = p.codigocliente(+)
AND C.codigoempleadorepventas = e.codigoempleado
AND o.codigooficina = e.codigooficina
AND p.codigocliente IS NULL;

--22.Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.

SELECT o.lineadireccion1,o.lineadireccion2
FROM CLIENTES C,EMPLEADOS E,OFICINAS O
WHERE C.codigoempleadorepventas = e.codigoempleado
AND o.codigooficina = e.codigooficina
AND UPPER(C.CIUDAD) = 'FUENLABRADA';

--23.Devuelve el nombre de los clientes y el nombre de sus representantes junto
--con la ciudad de la oficina a la que pertenece el representante.

SELECT c.nombrecliente,e.nombre,o.ciudad
FROM CLIENTES C,EMPLEADOS E,OFICINAS O
WHERE C.codigoempleadorepventas = e.codigoempleado
AND o.codigooficina = e.codigooficina;

--24.Devuelve un listado con el nombre de los empleados junto con el nombre de
--sus jefes.

SELECT e.nombre AS EMPLEADO , NVL(J.NOMBRE,'NO TIENE JEFE') AS JEFE
FROM EMPLEADOS E,EMPLEADOS J
WHERE E.CODIGOJEFE = j.codigoempleado(+);

--25.Devuelve un listado que muestre el nombre de cada empleado, el nombre de
--su jefe y el nombre del jefe de su jefe.

SELECT e.nombre AS EMPLEADO , NVL(J.NOMBRE,'NO TIENE JEFE') AS JEFE, NVL(JJ.NOMBRE,'NO TIENE JEFE') AS JEFE_DEL_JEFE
FROM EMPLEADOS E,EMPLEADOS J, EMPLEADOS JJ
WHERE E.CODIGOJEFE = j.codigoempleado(+)
AND J.CODIGOJEFE = JJ.CODIGOEMPLEADO(+);

--26.Devuelve el nombre de los clientes a los que no se les ha entregado a
--tiempo un pedido.

SELECT DISTINCT(c.nombrecliente)
FROM CLIENTES C, PEDIDOS P
WHERE C.CODIGOCLIENTE = P.CODIGOCLIENTE
AND p.fechaesperada < p.fechaentrega;

--27.Devuelve un listado de las diferentes gamas de producto que ha comprado            DUDA
--cada cliente.

SELECT DISTINCT(c.nombrecliente),pr.gama
FROM CLIENTES C, PEDIDOS P, DETALLEPEDIDOS D, PRODUCTOS PR
WHERE C.CODIGOCLIENTE = P.CODIGOCLIENTE
AND P.CODIGOPEDIDO = D.CODIGOPEDIDO
AND D.CODIGOPRODUCTO = PR.CODIGOPRODUCTO;


--28.Devuelve un listado que muestre solamente los clientes que no han realizado
--ningún pago.

SELECT *
FROM CLIENTES C, PAGOS P
WHERE  C.CODIGOCLIENTE = P.CODIGOCLIENTE(+)
AND p.codigocliente IS NULL;

--29.Devuelve un listado que muestre solamente los clientes que no han realizado
--ningún pedido.

SELECT *
FROM CLIENTES C, PEDIDOS P
WHERE  C.CODIGOCLIENTE = P.CODIGOCLIENTE(+)
AND p.codigocliente IS NULL;

--30.Devuelve un listado que muestre los clientes que no han realizado ningún
--pago y los que no han realizado ningún pedido.

SELECT *
FROM CLIENTES C, PAGOS P,PEDIDOS PE
WHERE  C.CODIGOCLIENTE = P.CODIGOCLIENTE(+)
AND  C.CODIGOCLIENTE = PE.CODIGOCLIENTE(+)
AND p.codigocliente IS NULL
AND PE.codigocliente IS NULL;

--31.Devuelve un listado que muestre solamente los empleados que no tienen
--una oficina asociada.

SELECT *
FROM EMPLEADOS E
WHERE E.CODIGOOFICINA IS NULL;

--32.Devuelve un listado que muestre solamente los empleados que no tienen un                                    ÑE
--cliente asociado.

SELECT COUNT(c.codigoempleadorepventas),E.NOMBRE
FROM CLIENTES C,EMPLEADOS E
WHERE c.codigoempleadorepventas(+) = E.CODIGOEMPLEADO
group by e.nombre
HAVING COUNT(c.codigoempleadorepventas)=0;

--33.Devuelve un listado que muestre solamente los empleados que no tienen un                                 ÑE
--cliente asociado junto con los datos de la oficina donde trabajan.

SELECT COUNT(c.codigoempleadorepventas),E.NOMBRE,o.ciudad,o.codigooficina,o.lineadireccion1,o.lineadireccion2,o.pais,o.region,o.telefono
FROM CLIENTES C,EMPLEADOS E,OFICINAS O
WHERE c.codigoempleadorepventas(+) = E.CODIGOEMPLEADO
AND E.CODIGOOFICINA = O.CODIGOOFICINA
group by e.nombre,o.ciudad,o.codigooficina,o.lineadireccion1,o.lineadireccion2,o.pais,o.region,o.telefono
HAVING COUNT(c.codigoempleadorepventas)=0;

--34.Devuelve un listado que muestre los empleados que no tienen una oficina
--asociada y los que no tienen un cliente asociado.

SELECT E.NOMBRE
FROM CLIENTES C,EMPLEADOS E,OFICINAS O
WHERE c.codigoempleadorepventas(+) = E.CODIGOEMPLEADO
AND E.CODIGOOFICINA = O.CODIGOOFICINA(+)
group by e.nombre
HAVING COUNT(c.codigoempleadorepventas)=0
AND COUNT(O.CIUDAD)=0;

--35.Devuelve un listado de los productos que nunca han aparecido en un pedido.

SELECT COUNT(d.codigopedido),p.nombre
FROM detallepedidos D, productos P
WHERE D.CODIGOPRODUCTO(+) = P.CODIGOPRODUCTO
GROUP BY p.nombre
HAVING COUNT(d.codigopedido)=0;

--36.Devuelve un listado de los productos que nunca han aparecido en un pedido.
--El resultado debe mostrar el nombre, la descripción y la imagen del
--producto.

SELECT COUNT(d.codigopedido),p.nombre,p.descripcion,g.imagen
FROM detallepedidos D, productos P,GAMASPRODUCTOS G
WHERE D.CODIGOPRODUCTO(+) = P.CODIGOPRODUCTO
AND P.GAMA = G.GAMA
GROUP BY p.nombre,p.descripcion,g.imagen
HAVING COUNT(d.codigopedido)=0;

--37.Devuelve las oficinas donde no trabajan ninguno de los empleados que
--hayan sido los representantes de ventas de algún cliente que haya realizado
--la compra de algún producto de la gama Frutales.

SELECT O.*
FROM EMPLEADOS E,OFICINAS O
WHERE o.codigooficina=e.codigooficina
AND E.NOMBRE NOT IN
                    (SELECT E.NOMBRE
                    FROM EMPLEADOS E, CLIENTES C, PEDIDOS P, DETALLEPEDIDOS D, PRODUCTOS PR
                    WHERE e.codigoempleado = c.codigoempleadorepventas
                    AND c.codigocliente = p.codigocliente
                    AND p.codigopedido = d.codigopedido
                    AND d.codigoproducto = pr.codigoproducto
                    AND UPPER(e.puesto)='REPRESENTANTE VENTAS'
                    AND UPPER(PR.GAMA)='FRUTALES');
                    
--38.Devuelve un listado con los clientes que han realizado algún pedido, pero no
--han realizado ningún pago.

SELECT DISTINCT(c.nombrecliente)
FROM CLIENTES C,PEDIDOS P, PAGOS PA
WHERE PA.codigocliente(+) = c.codigocliente
AND c.codigocliente = p.codigocliente
AND pa.codigocliente IS NULL;

--39.Devuelve un listado con los datos de los empleados que no tienen clientes
--asociados y el nombre de su jefe asociado.

SELECT E.NOMBRE AS EMPLEADO,J.NOMBRE AS JEFE
FROM EMPLEADOS E, CLIENTES C, EMPLEADOS J
WHERE c.codigoempleadorepventas(+) = e.codigoempleado
AND e.codigojefe = J.codigoempleado
AND c.codigoempleadorepventas IS NULL;

--40.¿Cuántos empleados hay en la compañía?

SELECT COUNT(codigoempleado)
FROM EMPLEADOS;

--41.¿Cuántos clientes tiene cada país?

SELECT COUNT(CODIGOCLIENTE) AS CLIENTES,PAIS
FROM CLIENTES
GROUP BY PAIS;

--42.¿Cuál fue el pago medio en 2009?

SELECT AVG(CANTIDAD) AS PAGO_MEDIO
FROM PAGOS
WHERE TO_CHAR(FECHAPAGO,'YYYY')='2009';

--43.¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma
--descendente por el número de pedidos.

SELECT COUNT(CODIGOPEDIDO),ESTADO
FROM PEDIDOS
GROUP BY ESTADO
ORDER BY COUNT(CODIGOPEDIDO) DESC;

--44.Calcula el precio de venta del producto más caro y más barato en una
--misma consulta.

SELECT MAX(PRECIOVENTA),MIN(PRECIOVENTA)
FROM PRODUCTOS;

--45.Calcula el número de clientes que tiene la empresa.

SELECT COUNT(CODIGOCLIENTE)
FROM CLIENTES;

--46.¿Cuantos clientes existen con domicilio en la ciudad de Madrid?

SELECT COUNT(CODIGOCLIENTE)
FROM CLIENTES
GROUP BY CIUDAD
HAVING UPPER(CIUDAD)='MADRID';

--47.¿Calcula cuantos clientes tiene cada una de las ciudades que empiezan por M?

SELECT COUNT(CODIGOCLIENTE),CIUDAD
FROM CLIENTES
GROUP BY CIUDAD
HAVING UPPER(CIUDAD)LIKE 'M%';

--48.Devuelve el nombre de los representantes de ventas y el número de clientes
--al que atiende cada uno.

SELECT COUNT(C.CODIGOCLIENTE) AS CLIENTES,E.NOMBRE
FROM EMPLEADOS E, CLIENTES C
WHERE C.CODIGOEMPLEADOREPVENTAS=e.codigoempleado
AND UPPER(e.puesto)=UPPER('Representante Ventas')
GROUP BY E.NOMBRE;

--49.Calcula el número de clientes que no tiene asignado representante de ventas.

SELECT COUNT(codigocliente) AS CLIENTES_SIN_REPRESENTANTES
FROM CLIENTES 
WHERE CODIGOEMPLEADOREPVENTAS IS NULL;

--50.Calcula la fecha del primer y último pago realizado por cada uno de los
--clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.

SELECT c.nombrecontacto,c.apellidocontacto,MIN(FECHAPAGO) AS PRIMER_PAGO,MAX(FECHAPAGO) AS ULTIMO_PAGO
FROM CLIENTES C, PAGOS P
WHERE C.CODIGOCLIENTE = P.CODIGOCLIENTE
GROUP BY c.nombrecontacto,c.apellidocontacto;


--51.Calcula el número de productos diferentes que hay en cada uno de los pedidos.          SIN DIFERENTES?

SELECT pe.codigopedido AS PEDIDOS, COUNT(P.CODIGOPRODUCTO) AS CANTIDAD_PRODUCTOS
FROM PRODUCTOS P, DETALLEPEDIDOS D,PEDIDOS PE
WHERE p.codigoproducto=d.codigoproducto 
AND d.codigopedido = pe.codigopedido
GROUP BY pe.codigopedido;

--52.Calcula la suma de la cantidad total de todos los productos que aparecen en
--cada uno de los pedidos.

SELECT SUM(D.CANTIDAD)AS SUMA,pe.codigopedido AS PEDIDO
FROM PEDIDOS PE, DETALLEPEDIDOS D,PRODUCTOS P
WHERE p.codigoproducto=d.codigoproducto
AND d.codigopedido = pe.codigopedido
GROUP BY pe.codigopedido;

--53.Devuelve un listado de los 20 productos más vendidos y el número total de
--unidades que se han vendido de cada uno. El listado deberá estar ordenado
--por el número total de unidades vendidas.
SELECT * 
FROM
        (SELECT P.NOMBRE, COUNT(pe.codigopedido)
        FROM PRODUCTOS P,  DETALLEPEDIDOS D,PEDIDOS PE
        WHERE p.codigoproducto=d.codigoproducto
        AND d.codigopedido = pe.codigopedido
        GROUP BY p.nombre
        ORDER BY COUNT(pe.codigopedido) DESC)
WHERE ROWNUM <= 20;

--54.La facturación que ha tenido la empresa en toda la historia, indicando la
--base imponible, el IVA y el total facturado. La base imponible se calcula                                        ?
--sumando el coste del producto por el número de unidades vendidas de la
--tabla detalle pedido. El IVA es el 21 % de la base imponible, y el total la
--suma de los dos campos anteriores.

SELECT SUM(P.PRECIOPROVEEDOR*D.CANTIDAD) AS BASE_IMPONIBLE,SUM(P.PRECIOPROVEEDOR*D.CANTIDAD)*0.21 AS IVA, SUM(P.PRECIOPROVEEDOR*D.CANTIDAD)*1.21 AS TOTAL
FROM PRODUCTOS P,  DETALLEPEDIDOS D
WHERE p.codigoproducto=d.codigoproducto
GROUP BY p.codigoproducto;

--55.La misma información que en la pregunta anterior, pero agrupada por código
--de producto.

SELECT p.codigoproducto ,SUM(P.PRECIOPROVEEDOR*D.CANTIDAD) AS BASE_IMPONIBLE,SUM(P.PRECIOPROVEEDOR*D.CANTIDAD)*0.21 AS IVA, SUM(P.PRECIOPROVEEDOR*D.CANTIDAD)*1.21 AS TOTAL
FROM PRODUCTOS P,  DETALLEPEDIDOS D
WHERE p.codigoproducto=d.codigoproducto
GROUP BY p.codigoproducto
ORDER BY  p.codigoproducto ASC;

--56.La misma información que en la pregunta anterior, pero agrupada por código
--de producto filtrada por los códigos que empiecen por OR.

SELECT p.codigoproducto ,SUM(P.PRECIOPROVEEDOR*D.CANTIDAD) AS BASE_IMPONIBLE,SUM(P.PRECIOPROVEEDOR*D.CANTIDAD)*0.21 AS IVA, SUM(P.PRECIOPROVEEDOR*D.CANTIDAD)*1.21 AS TOTAL
FROM PRODUCTOS P,  DETALLEPEDIDOS D
WHERE p.codigoproducto=d.codigoproducto
AND UPPER(p.codigoproducto) LIKE 'OR%'
GROUP BY p.codigoproducto
ORDER BY  p.codigoproducto ASC;


--57.Lista las ventas totales de los productos que hayan facturado más de 3000
--euros. Se mostrará el nombre, unidades vendidas, total facturado y total
--facturado con impuestos (21% IVA).


--58.Muestre la suma total de todos los pagos que se realizaron para cada uno de
--los años que aparecen en la tabla pagos.













SELECT * 
FROM CLIENTES C,DETALLEPEDIDOS D,EMPLEADOS E,GAMASPRODUCTOS G,OFICINAS O,PAGOS PA,PEDIDOS PE,PRODUCTOS PR;

--1. Devuelve un listado con el c�digo de oficina y la ciudad donde hay oficinas.

SELECT CODIGOOFICINA, CIUDAD
FROM OFICINAS;

--2. Devuelve un listado con la ciudad y el tel�fono de las oficinas de Espa�a.

SELECT CIUDAD, TELEFONO
FROM OFICINAS;

--3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un c�digo de jefe igual a 7.

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

--6. Devuelve un listado con el nombre de los todos los clientes espa�oles.

SELECT * 
FROM CLIENTES
WHERE UPPER(PAIS) NOT IN ('SPAIN');

--7. Devuelve un listado con los distintos estados por los que puede pasar un pedido.

SELECT DISTINCT(ESTADO)
FROM PEDIDOS;

--8. Devuelve un listado con el c�digo de cliente de aquellos clientes que realizaron alg�n pago en 2008. Tenga en cuenta que deber� eliminar
--aquellos c�digos de cliente que aparezcan repetidos. Resuelva la consulta:


SELECT codigocliente, fechapago
FROM PAGOS 
WHERE fechapago >=  TO_DATE('01/01/2008','DD/MM/YYYY') 
AND fechapago <=  TO_DATE('31/12/2008','DD/MM/YYYY');

--9. Devuelve un listado con el c�digo de pedido, c�digo de cliente, fecha
--esperada y fecha de entrega de los pedidos que no han sido entregados a                   DUDA
--tiempo.

SELECT codigopedido ,codigocliente,fechaesperada,fechaentrega
FROM PEDIDOS
WHERE fechaesperada < fechaentrega
OR UPPER(ESTADO) = UPPER('Pendiente');

--10.Devuelve un listado con el c�digo de pedido, c�digo de cliente, fecha
--esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al
--menos dos d�as antes de la fecha esperada.

SELECT codigopedido ,codigocliente,fechaesperada,fechaentrega
FROM PEDIDOS
WHERE fechaentrega <= fechaesperada-2;

--11.Devuelve un listado de todos los pedidos que fueron rechazados en 2009                        DUDA

SELECT * 
FROM PEDIDOS
WHERE UPPER(ESTADO) = UPPER('Rechazado')                      
AND FECHAPEDIDO >=  TO_DATE('01/01/2009','DD/MM/YYYY') 
AND FECHAPEDIDO <=  TO_DATE('31/12/2009','DD/MM/YYYY') ;

--12.Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier a�o.

SELECT *
FROM PEDIDOS
WHERE TO_CHAR(FECHAENTREGA,'MM') = '01' ;

--13.Devuelve un listado con todos los pagos que se realizaron en el a�o 2008
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
--Ornamentales y que tienen m�s de 100 unidades en stock. El listado deber�
--estar ordenado por su precio de venta, mostrando en primer lugar los de
--mayor precio.

SELECT *
FROM PRODUCTOS
WHERE UPPER(GAMA) = UPPER('Ornamentales')
AND cantidadenstock > 100
ORDER BY precioventa DESC;

--16.Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y
--cuyo representante de ventas tenga el c�digo de empleado 11 o 30.

SELECT *
FROM CLIENTES
WHERE UPPER(CIUDAD)='MADRID'
AND codigoempleadorepventas IN (11,30);

--17.Obt�n un listado con el nombre de cada cliente y el nombre y apellido de su
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

--22.Lista la direcci�n de las oficinas que tengan clientes en Fuenlabrada.

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
--ning�n pago.

SELECT *
FROM CLIENTES C, PAGOS P
WHERE  C.CODIGOCLIENTE = P.CODIGOCLIENTE(+)
AND p.codigocliente IS NULL;

--29.Devuelve un listado que muestre solamente los clientes que no han realizado
--ning�n pedido.

SELECT *
FROM CLIENTES C, PEDIDOS P
WHERE  C.CODIGOCLIENTE = P.CODIGOCLIENTE(+)
AND p.codigocliente IS NULL;

--30.Devuelve un listado que muestre los clientes que no han realizado ning�n
--pago y los que no han realizado ning�n pedido.

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

--32.Devuelve un listado que muestre solamente los empleados que no tienen un                                    �E
--cliente asociado.

SELECT COUNT(c.codigoempleadorepventas),E.NOMBRE
FROM CLIENTES C,EMPLEADOS E
WHERE c.codigoempleadorepventas(+) = E.CODIGOEMPLEADO
group by e.nombre
HAVING COUNT(c.codigoempleadorepventas)=0;

--33.Devuelve un listado que muestre solamente los empleados que no tienen un                                 �E
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
--El resultado debe mostrar el nombre, la descripci�n y la imagen del
--producto.

SELECT COUNT(d.codigopedido),p.nombre,p.descripcion,g.imagen
FROM detallepedidos D, productos P,GAMASPRODUCTOS G
WHERE D.CODIGOPRODUCTO(+) = P.CODIGOPRODUCTO
AND P.GAMA = G.GAMA
GROUP BY p.nombre,p.descripcion,g.imagen
HAVING COUNT(d.codigopedido)=0;

--37.Devuelve las oficinas donde no trabajan ninguno de los empleados que
--hayan sido los representantes de ventas de alg�n cliente que haya realizado
--la compra de alg�n producto de la gama Frutales.

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
                    
--38.Devuelve un listado con los clientes que han realizado alg�n pedido, pero no
--han realizado ning�n pago.

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

--40.�Cu�ntos empleados hay en la compa��a?

SELECT COUNT(codigoempleado)
FROM EMPLEADOS;

--41.�Cu�ntos clientes tiene cada pa�s?

SELECT COUNT(CODIGOCLIENTE) AS CLIENTES,PAIS
FROM CLIENTES
GROUP BY PAIS;

--42.�Cu�l fue el pago medio en 2009?

SELECT AVG(CANTIDAD) AS PAGO_MEDIO
FROM PAGOS
WHERE TO_CHAR(FECHAPAGO,'YYYY')='2009';

--43.�Cu�ntos pedidos hay en cada estado? Ordena el resultado de forma
--descendente por el n�mero de pedidos.

SELECT COUNT(CODIGOPEDIDO),ESTADO
FROM PEDIDOS
GROUP BY ESTADO
ORDER BY COUNT(CODIGOPEDIDO) DESC;

--44.Calcula el precio de venta del producto m�s caro y m�s barato en una
--misma consulta.

SELECT MAX(PRECIOVENTA),MIN(PRECIOVENTA)
FROM PRODUCTOS;

--45.Calcula el n�mero de clientes que tiene la empresa.

SELECT COUNT(CODIGOCLIENTE)
FROM CLIENTES;

--46.�Cuantos clientes existen con domicilio en la ciudad de Madrid?

SELECT COUNT(CODIGOCLIENTE)
FROM CLIENTES
GROUP BY CIUDAD
HAVING UPPER(CIUDAD)='MADRID';

--47.�Calcula cuantos clientes tiene cada una de las ciudades que empiezan por M?

SELECT COUNT(CODIGOCLIENTE),CIUDAD
FROM CLIENTES
GROUP BY CIUDAD
HAVING UPPER(CIUDAD)LIKE 'M%';

--48.Devuelve el nombre de los representantes de ventas y el n�mero de clientes
--al que atiende cada uno.

SELECT COUNT(C.CODIGOCLIENTE) AS CLIENTES,E.NOMBRE
FROM EMPLEADOS E, CLIENTES C
WHERE C.CODIGOEMPLEADOREPVENTAS=e.codigoempleado
AND UPPER(e.puesto)=UPPER('Representante Ventas')
GROUP BY E.NOMBRE;

--49.Calcula el n�mero de clientes que no tiene asignado representante de ventas.

SELECT COUNT(codigocliente) AS CLIENTES_SIN_REPRESENTANTES
FROM CLIENTES 
WHERE CODIGOEMPLEADOREPVENTAS IS NULL;

--50.Calcula la fecha del primer y �ltimo pago realizado por cada uno de los
--clientes. El listado deber� mostrar el nombre y los apellidos de cada cliente.

SELECT c.nombrecontacto,c.apellidocontacto,MIN(FECHAPAGO) AS PRIMER_PAGO,MAX(FECHAPAGO) AS ULTIMO_PAGO
FROM CLIENTES C, PAGOS P
WHERE C.CODIGOCLIENTE = P.CODIGOCLIENTE
GROUP BY c.nombrecontacto,c.apellidocontacto;


--51.Calcula el n�mero de productos diferentes que hay en cada uno de los pedidos.          SIN DIFERENTES?

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

--53.Devuelve un listado de los 20 productos m�s vendidos y el n�mero total de
--unidades que se han vendido de cada uno. El listado deber� estar ordenado
--por el n�mero total de unidades vendidas.
SELECT * 
FROM
        (SELECT P.NOMBRE, COUNT(pe.codigopedido)
        FROM PRODUCTOS P,  DETALLEPEDIDOS D,PEDIDOS PE
        WHERE p.codigoproducto=d.codigoproducto
        AND d.codigopedido = pe.codigopedido
        GROUP BY p.nombre
        ORDER BY COUNT(pe.codigopedido) DESC)
WHERE ROWNUM <= 20;

--54.La facturaci�n que ha tenido la empresa en toda la historia, indicando la
--base imponible, el IVA y el total facturado. La base imponible se calcula                                        ?
--sumando el coste del producto por el n�mero de unidades vendidas de la
--tabla detalle pedido. El IVA es el 21 % de la base imponible, y el total la
--suma de los dos campos anteriores.

SELECT SUM(P.PRECIOPROVEEDOR*D.CANTIDAD) AS BASE_IMPONIBLE,SUM(P.PRECIOPROVEEDOR*D.CANTIDAD)*0.21 AS IVA, SUM(P.PRECIOPROVEEDOR*D.CANTIDAD)*1.21 AS TOTAL
FROM PRODUCTOS P,  DETALLEPEDIDOS D
WHERE p.codigoproducto=d.codigoproducto
GROUP BY p.codigoproducto;

--55.La misma informaci�n que en la pregunta anterior, pero agrupada por c�digo
--de producto.

SELECT p.codigoproducto ,SUM(P.PRECIOPROVEEDOR*D.CANTIDAD) AS BASE_IMPONIBLE,SUM(P.PRECIOPROVEEDOR*D.CANTIDAD)*0.21 AS IVA, SUM(P.PRECIOPROVEEDOR*D.CANTIDAD)*1.21 AS TOTAL
FROM PRODUCTOS P,  DETALLEPEDIDOS D
WHERE p.codigoproducto=d.codigoproducto
GROUP BY p.codigoproducto
ORDER BY  p.codigoproducto ASC;

--56.La misma informaci�n que en la pregunta anterior, pero agrupada por c�digo
--de producto filtrada por los c�digos que empiecen por OR.

SELECT p.codigoproducto ,SUM(P.PRECIOPROVEEDOR*D.CANTIDAD) AS BASE_IMPONIBLE,SUM(P.PRECIOPROVEEDOR*D.CANTIDAD)*0.21 AS IVA, SUM(P.PRECIOPROVEEDOR*D.CANTIDAD)*1.21 AS TOTAL
FROM PRODUCTOS P,  DETALLEPEDIDOS D
WHERE p.codigoproducto=d.codigoproducto
AND UPPER(p.codigoproducto) LIKE 'OR%'
GROUP BY p.codigoproducto
ORDER BY  p.codigoproducto ASC;


--57.Lista las ventas totales de los productos que hayan facturado m�s de 3000
--euros. Se mostrar� el nombre, unidades vendidas, total facturado y total              ?
--facturado con impuestos (21% IVA).


SELECT p.codigoproducto ,SUM(P.PRECIOPROVEEDOR*D.CANTIDAD) AS BASE_IMPONIBLE,SUM(P.PRECIOPROVEEDOR*D.CANTIDAD)*0.21 AS IVA, SUM(P.PRECIOPROVEEDOR*D.CANTIDAD)*1.21 AS TOTAL
FROM PRODUCTOS P,  DETALLEPEDIDOS D
WHERE p.codigoproducto=d.codigoproducto
AND UPPER(p.codigoproducto) LIKE 'OR%'
GROUP BY p.codigoproducto
HAVING SUM(P.PRECIOPROVEEDOR*D.CANTIDAD)*1.21 > 3000
ORDER BY  p.codigoproducto ASC;


--58.Muestre la suma total de todos los pagos que se realizaron para cada uno de
--los años que aparecen en la tabla pagos.

SELECT EXTRACT(YEAR FROM FECHAPAGO), SUM(CANTIDAD)
FROM PAGOS
GROUP BY EXTRACT(YEAR FROM FECHAPAGO);

--59.Devuelve el nombre del cliente con mayor límite de crédito.
SELECT *
FROM (
        SELECT NOMBRECLIENTE, LIMITECREDITO
        FROM CLIENTES
        ORDER BY LIMITECREDITO DESC)
WHERE ROWNUM = 1;

--60.Devuelve el nombre del producto que tenga el precio de venta más caro.

SELECT *
FROM (
        SELECT NOMBRE, PRECIOVENTA
        FROM PRODUCTOS
        ORDER BY PRECIOVENTA DESC)
WHERE ROWNUM = 1;

--61.Devuelve el nombre del producto del que se han vendido más unidades.
--(Tenga en cuenta que tendrá que calcular cuál es el número total de
--unidades que se han vendido de cada producto a partir de los datos de la
--tabla detalle_pedido)
SELECT *
FROM(
        SELECT P.NOMBRE, D.CANTIDAD
        FROM PRODUCTOS P, DETALLEPEDIDOS D
        WHERE P.CODIGOPRODUCTO = D.CODIGOPRODUCTO
        ORDER BY D.CANTIDAD DESC)
WHERE ROWNUM = 1;

--62.Los clientes cuyo límite de crédito sea mayor que los pagos que haya
--realizado.
SELECT NOMBRECLIENTE
FROM CLIENTES
WHERE NOMBRECLIENTE NOT IN (    SELECT C.NOMBRECLIENTE
                                FROM CLIENTES C, PAGOS P
                                WHERE C.CODIGOCLIENTE = P.CODIGOCLIENTE
                                AND C.LIMITECREDITO < P.CANTIDAD);


--63.Devuelve el producto que más unidades tiene en stock.

SELECT NOMBRE
FROM PRODUCTOS
WHERE CANTIDADENSTOCK = (SELECT MAX(CANTIDADENSTOCK) FROM PRODUCTOS);

-- 64.Devuelve el producto que menos unidades tiene en stock.

SELECT NOMBRE
FROM PRODUCTOS
WHERE CANTIDADENSTOCK = (SELECT MIN(CANTIDADENSTOCK) FROM PRODUCTOS);

-- 65.Devuelve el nombre, los apellidos y el email de los empleados que están a
--cargo de Alberto Soria.

SELECT NOMBRE, APELLIDO1, APELLIDO2,EMAIL
FROM EMPLEADOS
WHERE CODIGOJEFE = (
                        SELECT CODIGOEMPLEADO
                        FROM EMPLEADOS
                        WHERE UPPER(NOMBRE) = 'ALBERTO'
                        AND UPPER(APELLIDO1) = 'SORIA');

-- 66.Devuelve el nombre del cliente con mayor límite de crédito.

SELECT NOMBRECLIENTE
FROM CLIENTES
WHERE LIMITECREDITO = (
                        SELECT MAX(LIMITECREDITO)
                        FROM CLIENTES);

-- 67.Devuelve el nombre del producto que tenga el precio de venta más caro.

SELECT NOMBRE
FROM PRODUCTOS
WHERE PRECIOVENTA = (
                        SELECT MAX(PRECIOVENTA)
                        FROM PRODUCTOS);

--68.Devuelve el producto que menos unidades tiene en stock.

SELECT NOMBRE
FROM PRODUCTOS
WHERE CANTIDADENSTOCK = (
                        SELECT MIN(CANTIDADENSTOCK)
                        FROM PRODUCTOS);

--69.Devuelve el nombre, apellido1 y cargo de los empleados que no representen
--a ningún cliente.

                --32.Devuelve un listado que muestre solamente los empleados que no tienen un                                    �E
                --cliente asociado.

                SELECT E.NOMBRE, E.apellido1 , E.PUESTO
                FROM CLIENTES C,EMPLEADOS E
                WHERE c.codigoempleadorepventas(+) = E.CODIGOEMPLEADO
                group by e.nombre, E.apellido1, E.PUESTO
                HAVING COUNT(c.codigoempleadorepventas)=0;

--70.Devuelve un listado que muestre solamente los clientes que no han realizado
--ningún pago.

SELECT C.NOMBRECLIENTE
FROM CLIENTES C,PAGOS P
WHERE C.CODIGOCLIENTE = P.CODIGOCLIENTE(+)
AND P.CODIGOCLIENTE IS NULL;

--71.Devuelve un listado que muestre solamente los clientes que sí han realizado
--algún pago.


SELECT DISTINCT(C.NOMBRECLIENTE) 
FROM CLIENTES C,PAGOS P
WHERE C.CODIGOCLIENTE = P.CODIGOCLIENTE;

--72.Devuelve un listado de los productos que nunca han aparecido en un pedido.

SELECT P.NOMBRE
FROM PRODUCTOS P, DETALLEPEDIDOS D
WHERE P.CODIGOPRODUCTO = D.CODIGOPRODUCTO(+)
AND D.CODIGOPEDIDO IS NULL;

--73.Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos                 ?
--empleados que no sean representante de ventas de ningún cliente.

SELECT *
FROM CLIENTES C,EMPLEADOS E
WHERE c.codigoempleadorepventas(+) = E.CODIGOEMPLEADO
AND C.CODIGOEMPLEADOREPVENTAS IS NULL
AND UPPER(E.PUESTO) = 'REPRESENTANTES DE VENTAS';

--74.Devuelve las oficinas donde no trabajan ninguno de los empleados que
--hayan sido los representantes de ventas de algún cliente que haya realizado                    WTF
--la compra de algún producto de la gama Frutales.

        SELECT *
        FROM OFICINAS O, EMPLEADOS E, CLIENTES C, PEDIDOS P, DETALLEPEDIDOS D, PRODUCTOS PR
        WHERE O.CODIGOOFICINA = E.CODIGOOFICINA
        AND E.CODIGOEMPLEADO = C.CODIGOEMPLEADOREPVENTAS
        AND C.CODIGOCLIENTE = P.CODIGOCLIENTE
        AND P.CODIGOPEDIDO = D.CODIGOPEDIDO
        AND D.CODIGOPRODUCTO = PR.CODIGOPRODUCTO;

        --PRODUCTOS GAMAS FRUTALES
        SELECT PR.CODIGOPRODUCTO
        FROM PRODUCTOS PR
        WHERE UPPER(PR.GAMA) = 'FRUTALES';

        --CLIENTES QUE HAN REALIZADO LA COMPRA DE FRUTALES
        SELECT DISTINCT(C.CODIGOCLIENTE)
        FROM CLIENTES C, PEDIDOS P, DETALLEPEDIDOS D, PRODUCTOS PR
        WHERE C.CODIGOCLIENTE = P.CODIGOCLIENTE
        AND P.CODIGOPEDIDO = D.CODIGOPEDIDO
        AND D.CODIGOPRODUCTO = PR.CODIGOPRODUCTO
        AND UPPER(PR.CODIGOPRODUCTO) IN (SELECT PR.CODIGOPRODUCTO
                                        FROM PRODUCTOS PR
                                        WHERE UPPER(PR.GAMA) = 'FRUTALES');

        --los empleados que
        --hayan sido los representantes de ventas de algún cliente que haya realizado
        --la compra de algún producto de la gama Frutales.

        SELECT DISTINCT(E.CODIGOEMPLEADO)
        FROM EMPLEADOS E, CLIENTES C
        WHERE E.CODIGOEMPLEADO = C.CODIGOEMPLEADOREPVENTAS
        AND C.CODIGOCLIENTE IN (
                                SELECT DISTINCT(C.CODIGOCLIENTE)
                                FROM CLIENTES C, PEDIDOS P, DETALLEPEDIDOS D, PRODUCTOS PR
                                WHERE C.CODIGOCLIENTE = P.CODIGOCLIENTE
                                AND P.CODIGOPEDIDO = D.CODIGOPEDIDO
                                AND D.CODIGOPRODUCTO = PR.CODIGOPRODUCTO
                                AND UPPER(PR.CODIGOPRODUCTO) IN (SELECT PR.CODIGOPRODUCTO
                                                                FROM PRODUCTOS PR
                                                                WHERE UPPER(PR.GAMA) = 'FRUTALES'));


        --FINAL
        
        SELECT DISTINCT(O.CODIGOOFICINA)
        FROM EMPLEADOS E, OFICINAS O
        WHERE O.CODIGOOFICINA = E.CODIGOOFICINA
        AND E.CODIGOEMPLEADO NOT IN (
                                        SELECT DISTINCT(E.CODIGOEMPLEADO)
                                        FROM EMPLEADOS E, CLIENTES C
                                        WHERE E.CODIGOEMPLEADO = C.CODIGOEMPLEADOREPVENTAS
                                        AND C.CODIGOCLIENTE IN (
                                                                SELECT DISTINCT(C.CODIGOCLIENTE)
                                                                FROM CLIENTES C, PEDIDOS P, DETALLEPEDIDOS D, PRODUCTOS PR
                                                                WHERE C.CODIGOCLIENTE = P.CODIGOCLIENTE
                                                                AND P.CODIGOPEDIDO = D.CODIGOPEDIDO
                                                                AND D.CODIGOPRODUCTO = PR.CODIGOPRODUCTO
                                                                AND UPPER(PR.CODIGOPRODUCTO) IN (SELECT PR.CODIGOPRODUCTO
                                                                                                FROM PRODUCTOS PR
                                                                                                WHERE UPPER(PR.GAMA) = 'FRUTALES')));



--75.Devuelve un listado con los clientes que han realizado algún pedido, pero no
--han realizado ningún pago.

SELECT DISTINCT(C.NOMBRECLIENTE)
FROM CLIENTES C, PEDIDOS P, PAGOS PA
WHERE C.CODIGOCLIENTE = P.CODIGOCLIENTE
AND C.CODIGOCLIENTE = PA.CODIGOCLIENTE(+)
AND PA.CODIGOCLIENTE IS NULL;

--76.Devuelve un listado que muestre solamente los clientes que no han realizado
--ningún pago.


SELECT DISTINCT(C.NOMBRECLIENTE)
FROM CLIENTES C, PAGOS PA
WHERE C.CODIGOCLIENTE = PA.CODIGOCLIENTE(+)
AND PA.CODIGOCLIENTE IS NULL;

--77.Devuelve un listado que muestre solamente los clientes que sí han realizado
--algún pago.

SELECT DISTINCT(C.NOMBRECLIENTE)
FROM CLIENTES C, PAGOS PA
WHERE C.CODIGOCLIENTE = PA.CODIGOCLIENTE;

--78.Devuelve un listado de los productos que nunca han aparecido en un pedido.

        --72.Devuelve un listado de los productos que nunca han aparecido en un pedido.

        SELECT P.NOMBRE
        FROM PRODUCTOS P, DETALLEPEDIDOS D
        WHERE P.CODIGOPRODUCTO = D.CODIGOPRODUCTO(+)
        AND D.CODIGOPEDIDO IS NULL;

--79.Devuelve un listado de los productos que han aparecido en un pedido alguna vez.

SELECT DISTINCT(P.NOMBRE)
FROM PRODUCTOS P, DETALLEPEDIDOS D
WHERE P.CODIGOPRODUCTO = D.CODIGOPRODUCTO;

--80.Devuelve el listado de clientes indicando el nombre del cliente y cuantos
--pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no
--han realizado ningún pedido.

SELECT C.NOMBRECLIENTE, COUNT(P.CODIGOCLIENTE)
FROM CLIENTES C, PEDIDOS P
WHERE C.CODIGOCLIENTE = P.CODIGOCLIENTE(+)
GROUP BY C.NOMBRECLIENTE;

--81.Devuelve un listado con los nombres de los clientes y el total pagado por
--cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han
--realizado ningún pago.

SELECT C.NOMBRECLIENTE, NVL(SUM(P.CANTIDAD),0) AS TOTAL_PAGADO
FROM CLIENTES C, PAGOS P
WHERE C.CODIGOCLIENTE = P.CODIGOCLIENTE(+)
GROUP BY C.NOMBRECLIENTE;

--82.Devuelve el nombre de los clientes que hayan hecho pedidos en 2008
--ordenados alfabéticamente de menor a mayor.

SELECT DISTINCT(C.NOMBRECLIENTE)
FROM CLIENTES C, PEDIDOS P
WHERE C.CODIGOCLIENTE = P.CODIGOCLIENTE
AND TO_CHAR(P.FECHAPEDIDO,'YYYY') = '2008'
ORDER BY C.NOMBRECLIENTE ASC;

--83.Devuelve el nombre del cliente, el nombre y primer apellido de su
--representante de ventas y el número de teléfono de la oficina del
--representante de ventas, de aquellos clientes que no hayan realizado ningún                      ?
--pago.

        --CLIENTES QUE NO HAN REALIZADO PAGOS
        SELECT DISTINCT(C.CODIGOCLIENTE)
        FROM CLIENTES C, PAGOS P
        WHERE C.CODIGOCLIENTE = P.CODIGOCLIENTE(+)
        AND P.CODIGOCLIENTE IS NULL;

        --FINAL

        SELECT C.NOMBRECLIENTE, E.NOMBRE, E.APELLIDO1, O.CODIGOOFICINA
        FROM CLIENTES C, PAGOS P, EMPLEADOS E, OFICINAS O
        WHERE C.CODIGOCLIENTE = P.CODIGOCLIENTE
        AND C.CODIGOEMPLEADOREPVENTAS = E.CODIGOEMPLEADO
        AND E.CODIGOOFICINA = O.CODIGOOFICINA
        AND UPPER(E.PUESTO) = 'REPRESENTANTE VENTAS'
        AND C.CODIGOCLIENTE IN (
                                        SELECT DISTINCT(C.CODIGOCLIENTE)
                                        FROM CLIENTES C, PAGOS P
                                        WHERE C.CODIGOCLIENTE = P.CODIGOCLIENTE(+)
                                        AND P.CODIGOCLIENTE IS NULL) ;


--84.Devuelve el listado de clientes donde aparezca el nombre del cliente, el
--nombre y primer apellido de su representante de ventas y la ciudad donde
--está su oficina.

SELECT C.NOMBRECLIENTE, E.NOMBRE, E.APELLIDO1, O.CIUDAD
FROM CLIENTES C, EMPLEADOS E, OFICINAS O
WHERE C.CODIGOEMPLEADOREPVENTAS = E.CODIGOEMPLEADO
AND E.CODIGOOFICINA = O.CODIGOOFICINA
AND UPPER(E.PUESTO) = 'REPRESENTANTE VENTAS';

--85.Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos
--empleados que no sean representante de ventas de ningún cliente.


        --73.Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos                 ?
        --empleados que no sean representante de ventas de ningún cliente.

        SELECT *
        FROM CLIENTES C,EMPLEADOS E
        WHERE c.codigoempleadorepventas(+) = E.CODIGOEMPLEADO
        AND C.CODIGOEMPLEADOREPVENTAS IS NULL
        AND UPPER(E.PUESTO) = 'REPRESENTANTES DE VENTAS';


--86.Devuelve un listado indicando todas las ciudades donde hay oficinas y el                       ?
--número de empleados que tienen ningún curso escolar.

SELECT *
FROM EMPLEADOS;
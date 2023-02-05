DROP TABLE EMPLEADOS CASCADE CONSTRAINT;
CREATE TABLE EMPLEADOS(
 NIFEMP NUMBER(8) NOT NULL,
 NOMBRE VARCHAR2(25),
 DEPART NUMBER(2),
 FECNAC DATE,
 FECCON DATE,
 SALARIO NUMBER(3),
 EXTRAS NUMBER(2),
 HIJOS NUMBER(1),
 CONSTRAINT PK_EMPLEADOS PRIMARY KEY (NIFEMP)
);
INSERT INTO EMPLEADOS VALUES (24131221,'MENA SALAZAR,
RAMON',51,'30/03/68','1/01/88',180,6,0);
INSERT INTO EMPLEADOS VALUES (24181260,'SANCHEZ TORO,
JESUS',52,'14/07/68','13/10/88',175,4,0);
INSERT INTO EMPLEADOS VALUES (24433498,'BENITEZ RAMIREZ,
RAFAEL',51,'22/06/67','20/01/87',190,7,1);
INSERT INTO EMPLEADOS VALUES (24460989,'LARIOS GIRON,
MARTIN',51,'19/02/66','8/10/86',215,9,1);
INSERT INTO EMPLEADOS VALUES (24567867,'PADILLA MUÑOZ,
ROSARIO',51,'18/08/69','1/11/87',185,5,0);
INSERT INTO EMPLEADOS VALUES (24569156,'CABELLO NAVARRO,
PAULA',32,'12/09/69','1/01/87',160,null,0);
INSERT INTO EMPLEADOS VALUES (25170901,'JIMENEZ SAEZ,
MARIANO',40,'7/01/56','10/07/79',240,null,1);
INSERT INTO EMPLEADOS VALUES (25181104,'PEREZ ARREBOLA,
ESTEBAN',40,'9/10/61','15/04/84',220,null,3);
INSERT INTO EMPLEADOS VALUES (25191307,'ANDRADE GARCIA
,ANDRES',20,'10/03/45','11/10/70',180,11,2);
INSERT INTO EMPLEADOS VALUES (25250392,'SANCHEZ VEGA,
JULIA',20,'12/05/32','2/11/72',200,null,4);
INSERT INTO EMPLEADOS VALUES (25267292,'MARTINEZ LOPERA,
INES',20,'27/08/51','18/07/83',190,5,2);
INSERT INTO EMPLEADOS VALUES (25310392,'FERNANDEZ PARRADO,
LUIS',20,'8/10/50','15/06/76',340,null,0);
INSERT INTO EMPLEADOS VALUES (25412319,'TRUJILLO GONZALEZ,
PEDRO',52,'22/10/66','19/11/88',200,6,0);
INSERT INTO EMPLEADOS VALUES (25423221,'TORRES SANCHEZ,
JOSE',40,'9/06/49','1/02/74',210,null,2);
INSERT INTO EMPLEADOS VALUES (25556437,'MORALES GIL,
MARIA',32,'10/01/70','21/01/88',160,null,0);
INSERT INTO EMPLEADOS VALUES (25665792,'MARIN PALOMO,
PABLO',52,'26/10/67','19/11/88',190,3,1);
INSERT INTO EMPLEADOS VALUES (25776123,'PANADERO DURAN,
JOSEFA',52,'27/09/66','28/02/86',210,2,0);
COMMIT;

--1. Nif_Empleado y salario de los empleados que pertenezcan departamento 52

SELECT NIFEMP,SALARIO 
FROM EMPLEADOS
WHERE DEPART = 52;

--2. Nombre, Departamento y salario de los empleados que ganen menos de 200 €

SELECT NOMBRE,DEPART,SALARIO
FROM EMPLEADOS
WHERE SALARIO<200;

--3. Empleados cuya fecha de contratación sea posterior al año 80. Todos los campos

SELECT *
FROM EMPLEADOS 
WHERE FECCON>=TO_DATE('1980','YYYY');


--4. Empleados cuyo apellido empiece por P y ganen entre 200 y 300 €

SELECT NOMBRE
FROM EMPLEADOS
WHERE SUBSTR(NOMBRE,1,1)='P'
AND SALARIO>=200
AND SALARIO<=300;

--5. Numero de hijos de los empleados cuyo nombre contenga una letra n

SELECT NOMBRE,HIJOS
FROM EMPLEADOS
WHERE NOMBRE LIKE '%N%';

--6. Empleados que pertenezcan al departamento 40 o 52 y que tengan un sueldo inferior a 200


SELECT *
FROM EMPLEADOS
WHERE (DEPART=40
OR DEPART = 52)
AND SALARIO<200;

--7. Empleados cuyo nombre empiece por P, que no tengan hijos y que hayan realizado horas
--extras.

SELECT* FROM EMPLEADOS;
SELECT *
FROM EMPLEADOS
WHERE NOMBRE LIKE '%,P%';
AND HIJOS=0
AND EXTRAS > 0;


--8. Empleados que tengan mas de 5 extras, con un hijo y que pertenezcan al departamento 51 o 52.
--Ordenados por nombre



--9. Empleados que tengan entre 2 y 4 hijos y que no sean del departamento 52 ni del 40 ni del 32



--10. Obtener una lista con el nombre, el salario y el número de horas extraordinarias trabajadas de
--aquellos empleados que tienen algún hijo.



--11. Obtener un listado alfabético de los empleados cuyo salario sea igual o superior a 200 € y sea
--igual o inferior a las 300€.



--12. Obtener un listado con los nombres de los empleados que no cobran horas extra.



--13. Idem con los empleados que sí las cobran ordenados de más horas extras a menos.



--14. Obtener los nombres de los empleados cuyo número de horas extra trabajadas sea 4 o 6.



--15. Obtener los nombres y salarios de los empleados que pertenezcan a los departamentos 51 o 52 y
--que tengan algún hijo.



--16. Obtener un listado con los empleados que tengan un salario igual o superior a 200€ y con 2 o 3
--hijos.



--17. Obtener un listado de los empleados que hayan ingresado en la empresa entre los años 1975 y
--1987, ambos inclusive



--18. Obtener los empleados que no tienen familia numerosa (menos de 3 hijos) y que ingresaron en
--la empresa antes del 1 de enero de 1987 



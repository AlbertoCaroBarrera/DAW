# INICIAR LA BASE DE DATOS

```
ALTER SESSION SET NLS_LANGUAGE= 'SPANISH'; 

alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';

alter session set "_ORACLE_SCRIPT"=true;

create user EMPLEADOS identified BY  EMPLEADOS;

grant all privileges  to EMPLEADOS;
```

**REGLA GENERAL PARA LAS QUERIES**
1. EXISTE ALGUN PRECALCULO -- UTILIZO SUBCONSULTAS
2. ME ENCUENTRO EN LA SUBCONSULTA. EXISTE ALGUN PRECALCULO --VUELVO AL PUNTO UNO
3. DONDE ESTA LA INFORMACIÓN -- ESTO LO PONGO EN EL FROM
4. QUE INFORMACION QUIERO MOSTRAR.
5. EXISTE ALGUNA FUNCION DE AGREGACION -- SI ES ASI, TODO LO QUE ESTA FUERA DE LA FUNCION DE AGREGACIÓN VA AL GROUP BY
6. EXISTE ALGUNA CONDICION SOBRE LAS COLUMNAS DE LAS TABLAS --ESTO VA AL WHERE   
7. EXISTE ALGUNA CONDICION SOBRE LAS FUNCIONES DE AGREGACION -- ESTO VA AL HAVING   
8. EXISTE ALGUNA ORDENACION -- ESTO VA EN EL ORDER BY.


# BASICO

```
SELECT * 
FROM TABLA 
WHERE CONDICION_1 
AND CONDICION_2
```

# FUNCIONES

## Aritmeticas

| funcion     | que hace?                      |
| ----------- | ------------------------------ |
| abs(n)      | valor absoluto                 |
| ceil(n)     | valor int superior a n         |
| floor(n)    | valor int inferior a n         |
| mod(m,n)    | modulo m base n                |
| NVL(a,b)    | Si a es nulo pone b            |
| power(a,b)  | a^b                            |
| round(x,y)  | Se redondea x a y decimales    |
| sign(x)     | signo de x                     |
| sqrt(x)     | devuelve la raiz cuadrada de x |
| trunc(x,y)  | trunca x a y decimales         |
| variance(x) | varianza de x                  |

## Funciones de columnas (el resto necesitarian agruparse)

| funcion  | que hace?                                    |
| -------- | -------------------------------------------- |
| avg(x)   | hace el valor medio de x ignorando los nulos |
| count(*) | cuenta la cantidad de filas no nulas         |
| max(x)   | maximo valor de la columna x                 |
| min(x)   | minimo valor de la columna x                 |
| sum(x)   | suma todos los valores de la columna x       |

## Funciones de listas

| funcion         | que hace?         |
| --------------- | ----------------- |
| greates(x,y...) | valor mas grande  |
| least(x,y..)    | valor mas pequeño |

## Funciones de cadenas

| funcion | que hace?                             |
| ------- | ------------------------------------- |
| chr(n)  | Caracter cuyo valor en binario vale n |

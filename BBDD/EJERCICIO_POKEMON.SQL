--1. Mostrar el nombre de todos los pokemon.

SELECT NOMBRE
FROM POKEMON;

--2. mostrar los pokemon que pesen menos de 10k.

SELECT * 
FROM POKEMON
WHERE PESO <10;

--3. mostrar los pokemon de tipo agua.

SELECT *
FROM POKEMON P,POKEMON_TIPO PT,TIPO T
WHERE P.NUMERO_POKEDEX= PT.NUMERO_POKEDEX
AND PT.ID_TIPO = T.ID_TIPO
AND UPPER(T.NOMBRE)='AGUA';

--4. Mostrar los pokemon que son de tipo fuego y volador.

SELECT *
FROM POKEMON P,POKEMON_TIPO PT,TIPO T
WHERE P.NUMERO_POKEDEX = PT.NUMERO_POKEDEX
AND PT.ID_TIPO = T.ID_TIPO
AND UPPER(T.NOMBRE) ='FUEGO'
AND UPPER(T.NOMBRE) ='VOLADOR';  --MAL

--5. mostrar los pokemon con una estadística base de ps mayor que 200.

SELECT *
FROM POKEMON P, ESTADISTICAS_BASE E
WHERE E.NUMERO_POKEDEX = P.NUMERO_POKEDEX
AND PS > 200;

--6. mostrar los datos(nombre, peso, altura) de la prevolucion de Arbok.

SELECT NOMBRE, PESO,ALTURA
FROM POKEMON
WHERE NUMERO_POKEDEX IN(SELECT POKEMON_ORIGEN
                        FROM EVOLUCIONA_DE
                        WHERE POKEMON_EVOLUCIONADO = (SELECT P.NUMERO_POKEDEX
                                                    FROM POKEMON P
                                                    WHERE UPPER(NOMBRE) = 'ARBOK'))
;

--7. Mostrar aquellos pokemon que evolucionan por intercambio.


SELECT *
FROM POKEMON P, POKEMON_FORMA_EVOLUCION PFE, FORMA_EVOLUCION FE,TIPO_EVOLUCION TE
WHERE P.NUMERO_POKEDEX = PFE.NUMERO_POKEDEX
AND PFE.ID_FORMA_EVOLUCION = FE.ID_FORMA_EVOLUCION
AND FE.ID_FORMA_EVOLUCION = TE.ID_TIPO_EVOLUCION
AND UPPER(TE.TIPO_EVOLUCION) = 'INTERCAMBIO';              --hay error?

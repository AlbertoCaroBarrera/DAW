def hanoi(n, origen, medio, destino):
  if n == 1:

    # Si sólo hay un disco, mueva ese disco directamente a la varilla destino

    print("Mueva el disco 1 desde la varilla", origen, "a la varilla", destino)
    return hanoi(n - 1, origen, destino, medio)

  # De lo contrario, mueva todos los discos menos el último a la varilla auxiliar


  # Luego, mueva el último disco a la varilla destino

    print("Mueva el disco", n, "desde la varilla", origen, "a la varilla", destino)

  # Por último, mueva los discos de la varilla auxiliar a la varilla destino
hanoi (5, "medio", "origen", "destino")

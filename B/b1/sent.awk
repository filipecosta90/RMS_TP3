BEGIN {
  received_f = "sent"   ;# nome da output file...
  intervalo = 1   ;# eixo dos x: intervalos de tempo...
  proximo_dump = intervalo
}
{
  if ($1 == "r") {
    total_enviados++
                  enviados[$9"_"$10]++
                  }
    if ( $2 >= proximo_dump ) {
      print $2, " , " , total_enviados/intervalo > received_f".gr"
      total_enviados = 0
      for ( v in enviados ) { 
        print $2, " , " ,enviados[v]/intervalo > received_f"_"v".gr" 
        enviados[v] = 0 
      }
      proximo_dump += intervalo
    }
    last = $2
  }
  END {
    last_intervalo = intervalo - proximo_dump + last
    print last, " , " , total_enviados/intervalo > received_f".gr"
    for ( v in enviados ) { 
      print $2, " , " ,enviados[v]/intervalo > received_f"_"v".gr" 
      enviados[v] = 0 
    }

  }

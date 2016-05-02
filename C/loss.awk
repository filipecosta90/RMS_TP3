BEGIN {
  outf = "loss"   ;# nome da output file...
  out_received_f = "sent"   ;# nome da output file...
  intervalo = 1   ;# eixo dos x: intervalos de tempo...
  proximo_dump = intervalo
}
{
  if ( $1 == "d" ) {
    total_perdas++
                perdas[$9"_"$10]++
                }
    if ($1 == "r") {
      total_enviados++
                    enviados[$9"_"$10]++
                    }
      if ( $2 >= proximo_dump ) {
        print $2, " , " , total_perdas/intervalo > outf".gr"
        print $2, " , " , total_enviados/intervalo > outf_received_f".gr"
        total_perdas = 0
        total_enviados = 0
        for ( v in perdas ) { 
          print $2, " , " ,perdas[v]/intervalo > outf"_"v".gr" 
          perdas[v] = 0 
        }
        for ( v in enviados ) { 
          print $2, " , " ,enviados[v]/intervalo > outf_received_f"_"v".gr" 
          enviados[v] = 0 
        }
        proximo_dump += intervalo
      }
      last = $2
    }
    END {
      last_intervalo = intervalo - proximo_dump + last
      print last, " , ",  total_perdas/intervalo > outf".gr"
      print last, " , " , total_enviados/intervalo > outf_received_f".gr"
      for ( v in perdas ) { 
        print last, " , ", perdas[v]/intervalo > outf"_"v".gr" 
      }
      for ( v in enviados ) { 
        print $2, " , " ,enviados[v]/intervalo > outf_received_f"_"v".gr" 
        enviados[v] = 0 
      }

    }

#!/bin/bash
for((i=1;i<10;i++));do
  for((j=0;j<10;j++));do
    for((k=0;k<10;k++));do
      form=$[$i**3+$j**3+$k**3]
      if (( $i$j$k == $form ));then
        let count+=1
        echo "the daffodils $count is : $i$j$k"
      fi
    done
  done
done

# bash daffodils.sh
the daffodils 1 is : 153
the daffodils 2 is : 370
the daffodils 3 is : 371
the daffodils 4 is : 407

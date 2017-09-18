scrap()	{
	echo $1
	local i=$1
	if [ ! -f scrap/$i ]; then
		xpath_descricao="//*[@id=\"itemMaterial\"]/tbody/tr/td[3]/text()"
	        descricao=$(
	                cat dump/$i | tr -d "\n" | grep -oP "<table id=\"itemMaterial\".*?/table>" | xmlstarlet sel -t -c "$xpath_descricao" 2>/dev/null 
	        )
		if [ ! -z "$descricao" ]; then
			xpath_item="//*[@id=\"itemMaterial\"]/tbody/tr/td[1]/text()"
		        xpath_pdm="//*[@id=\"itemMaterial\"]/tbody/tr/td[2]/text()"
		        xpath_descricao_detalhada="//*[@id=\"itemMaterial\"]/tbody/tr/td[4]/text()"
		        xpath_situacao="//*[@id=\"itemMaterial\"]/tbody/tr/td[5]/text()"
		
		        item=$(
		                cat dump/$i | tr -d "\n" | grep -oP "<table id=\"itemMaterial\".*?/table>" | xmlstarlet sel -t -c "$xpath_item"
		        )
		        pdm=$(
		                cat dump/$i | tr -d "\n" | grep -oP "<table id=\"itemMaterial\".*?/table>" | xmlstarlet sel -t -c "$xpath_pdm"
		        )
		        descricao=$(
		                cat dump/$i | tr -d "\n" | grep -oP "<table id=\"itemMaterial\".*?/table>" | xmlstarlet sel -t -c "$xpath_descricao"
		        )
		        descricao_detalhada=$(
		                cat dump/$i | tr -d "\n" | grep -oP "<table id=\"itemMaterial\".*?/table>" | xmlstarlet sel -t -c "$xpath_descricao_detalhada"
		        )
		        situacao=$(
		                cat dump/$i | tr -d "\n" | grep -oP "<table id=\"itemMaterial\".*?/table>" | xmlstarlet sel -t -c "$xpath_situacao" | xargs
		        )
	
			echo "$item,$pdm,\"$descricao\",\"$descricao_detalhada\",$situacao" > scrap/$1
	        
		else
			touch scrap/$1
		fi
	fi
}

ids=$(seq $(ls scrap/| sort -n | tail -n1) 1000000)
for id in $ids; do scrap "$id" & done

find scrap | xargs cat > csv


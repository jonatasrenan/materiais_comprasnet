#!/bin/sh
for i in $(seq 1 1000000)
do
	if [ ! -f dump/$i ]; then
		curl 'https://www2.comprasnet.gov.br/siasgnet-atasrp/public/pesquisarCatalogoMaterial.do?method=pesquisarMaterial' -s -k -H 'Host: www2.comprasnet.gov.br' -H 'User-Agent: Mozilla/5.0 (X11; Fedora; Linux x86_64; rv:55.0) Gecko/20100101 Firefox/55.0' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8' -H 'Accept-Language: en-US,en;q=0.5' --compressed -H 'Content-Type: application/x-www-form-urlencoded' -H 'Referer: https://www2.comprasnet.gov.br/siasgnet-atasrp/public/pesquisarCatalogoMaterial.do?method=pesquisarMaterial' -H 'Cookie: JSESSIONID=A0D2C2FBE938AD9FCA37068A9A3C56CB' -H 'Connection: keep-alive' -H 'Upgrade-Insecure-Requests: 1' --data "funcaoRetorno=consultarItemCatalogoRetorno&readOnly=false&parametro.tipoItem=&parametro.codigoItemCatalogo=$i&parametro.codigoPDM=&parametro.descricao=" > dump/$i
	fi
done

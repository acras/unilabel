Unilabel
========

Uma dor histórica, recorrente e que gera muito trabalho é a emissão de etiquetas.
Históricamente enviávamos a impressão pelo PDV através do Report Builder. Isso sempre deu problema mas não tinha muito o que fazer pois a maior parte das pessoas usava impressora comum (laser e jato) para imprimir as etiquetas.

Hoje, cada vez mais as empresas estão usando impressoras de etiquetas especializadas, como a Argox ou a Zebra.

Estas impressoras possuem uma linguagem nativa de impressão, que faz com que as impressões saiam mais rapidamente e com melhor qualidade.

Projeto Unilabel
O projeto Unilabel será um programa Delphi nativo Windows que terá o objetivo de comunicar diretamente com as impressoras. Ele receberá de entrada um arquivo no formato Unilabel (XML especializado) e então fará a impressão.

Arquivo Unilabel
O arquivo Unilabel será um arquivo XML como exemplo abaixo:

<xml>
  <configuration>
    <columns>3</columns>
    <label-dimension>
      <height>60</height> 
      <width>101</width>
    </label-dimension>
    <margin>
      <left>2</left>
      <right>2</right>
      <horizontal-gap>3</horizontal-gap>
    </margin>
  </configuration>
  <labels>
    <label copies="1">
    <element type='text' 
            value='Estopim - Blusa'
      x='2' y='30'
	    font-name='Verdana' 
            font-size='28'/>
    <element type='text' 
            value='09542'
	    x='2' y='27'
	    font-name='Verdana' 
            font-size='28'/>
    <element type='barcode' 
            value='09542'
	    x='2' y='21'
            height='6'
            narrow='2'
            wide='6' />
    <element type='text' 
            value='Estopim - Blusa'
	    x='2' y='15'
	    font-name='Verdana' 
            font-size='28'/>
    <element type='text' 
            value='09542'
	    x='2' y='12'
	    font-name='Verdana' 
            font-size='28'/>
    <element type='barcode' 
            value='09542'
	    x='2' y='6' />
    <element type='text' 
            value='R$98,90'
	    x='2' y='0'
	    font-name='Verdana' 
            font-size='45'/>
    </label>
  </labels>
</xml>

Unilabel
========

```Propósito

Uma dor histórica, recorrente e que gera muito trabalho é a emissão de etiquetas.
Históricamente enviávamos a impressão pelo PDV através do Report Builder. Isso sempre deu problema mas não tinha muito o que fazer pois a maior parte das pessoas usava impressora comum (laser e jato) para imprimir as etiquetas.

Hoje, cada vez mais as empresas estão usando impressoras de etiquetas especializadas, como a Argox ou a Zebra.

Estas impressoras possuem uma linguagem nativa de impressão, que faz com que as impressões saiam mais rapidamente e com melhor qualidade.

Projeto Unilabel
O projeto Unilabel será um programa Delphi nativo Windows que terá o objetivo de comunicar diretamente com as impressoras. Ele receberá de entrada um arquivo no formato Unilabel (XML especializado) e então fará a impressão.

Arquivo Unilabel
O arquivo Unilabel será um arquivo XML como exemplo abaixo:

```XML
<xml>
  <configuration>
    <columns>3</columns>
    <label-dimension>
      <height>63</height> 
      <width>34</width>
    </label-dimension>
    <margin>
      <left>2</left>
      <right>2</right>
      <bottom>2</bottom>
      <horizontal-gap>0</horizontal-gap>
    </margin>
    <layout>
      <element type='text' field='description' x='2' y='30' font-name='Verdana' font-size='28'/>
      <element type='text' field='code' x='2' y='27' font-name='Verdana' font-size='28'/>
      <element type='barcode' field='barcode' x='2' y='21' />
      <element type='text' field='description' x='2' y='15' font-name='Verdana' font-size='28'/>
      <element type='text' field='code' x='2' y='12' font-name='Verdana' font-size='28'/>
      <element type='barcode' field='barcode' x='2' y='6' />
      <element type='text' field='price' x='2' y='0' font-name='Verdana' font-size='45'/>
    </layout>
  </configuration>
  <data>
    <record copies="4" description='Anel de diamantes' code='05987' barcode='05987' price='R$48.918,99'>
    <record copies="2" description="Le Lis Blanc - Calça" code='22578' barcode='22578' price='R$129,90' />
    <record copies="7" description="Alphorria - Sapato" code='12242' barcode='22345' price='R$114,90' />
    <record copies="1" description="Estopim - Short" code='548752' barcode='22547' price='R$321,90' />
  </data>
</xml>
```

Unilabel
========

Uma dor histórica, recorrente e que gera muito trabalho é a emissão de etiquetas.
Históricamente enviávamos a impressão pelo PDV através do Report Builder. Isso sempre deu problema mas não tinha muito o que fazer pois a maior parte das pessoas usava impressora comum (laser e jato) para imprimir as etiquetas.

Hoje, cada vez mais as empresas estão usando impressoras de etiquetas especializadas, como a Argox ou a Zebra.

Estas impressoras possuem uma linguagem nativa de impressão, que faz com que as impressões saiam mais rapidamente e com melhor qualidade.

Projeto Unilabel
O projeto Unilabel será um programa Delphi nativo Windows que terá o objetivo de comunicar diretamente com as impressoras. Ele receberá de entrada um arquivo no formato Unilabel (XML especializado) e então fará a impressão.

Arquivo Unilabel
O arquivo Unilabel será um arquivo XML que deverá permitir as seguintes configurações:

Altura das etiquetas
Largura de cada etiqueta
Número de colunas
Margem esquerda
Gap lateral entre etiquetas
*Etiquetas
Quantidade
*Elementos
Propriedades do elemento
Type: (texto, barras, imagem, linha, retangulo)
x
y
height
width
data
font
name
syze
bold
italic
underline
strike
bar_code
type
show_text
narrow_width
wide_width
image
filename
Funcionamento
O unilabel irá efetuar as seguintes operações:

1 - Localizar a impressora
2 - Enviar comandos de impressão com base nas etiquetas que deve imprimir da seguinte forma

  colAtual = 1
  PARA cada Etiqueta
    n = quantidade a imprimir desta etiqueta
    ENQUANTO (n > 0) E (colAtual > 1)
      gerarColuna
      n--
    FIMENQUANTO
    SE n > numColunas
      imprimirLinha(n mod numColunas)
      gerarNColunas(n div numColunas)
    SENAO
      gerarNColunas(n)
    FIMSE
  FIMPARA

O gerarLinha deve chamar o gerarColuna n vezes, onde n é o número de colunas e então mandar imprimir n/numColunas cópias.
O gerarColuna deve gerar uma coluna em memória, sem mandar pra impressora, conforme esquema abaixo.
O gerarNColunas deve chamar N vezese se chegou ao final das colunas zerar a coluna atual e mandar imprimir a linha.

O gerarColuna deve:

receber uma instância de ILabelPrinter, a coluna e os dados do papel e da etiqueta.
Aplicar um offset lateral necessário sendo ele = margemEsquerda + ((numColuna-1)*gapEntreColunas)
Chamar as funções conforme os dados uma coluna com o offset necessário
Geração de etiquetas para o uniLabel
Do lado do FocusLojas teremos que ter a geração do arquivo formato Unilabel. Basicamente teremos o modelo que será um arquivo equivalente. A seção de informações do papel será hard coded no arquivo do modelo e a parte da etiqueta poderá ser gerada de outras formas a se estudar.

Problemas a serem resolvidos
Word wrap: http://stackoverflow.com/questions/13652950/word-wrap-text-in-argox-os214-ppla

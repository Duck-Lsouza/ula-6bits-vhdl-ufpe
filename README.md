

<div align="center">

🧮 ULA 6-Bits VHDL



Unidade Lógica e Aritmética Estrutural para Kit FPGA Altera DE-2



</div>



&nbsp;   Implementação em VHDL de uma Unidade Lógica e Aritmética (ULA) de 6 bits. O projeto adota uma abordagem estrutural rigorosa, instanciando e interligando blocos funcionais modulares para formar o caminho de dados completo da unidade.



⚙️ Arquitetura e Componentes



A ULA foi desenhada de forma modular para facilitar a manutenção e o entendimento do hardware. O módulo principal gerencia a comunicação entre as entradas (operandos A e B de 6 bits, além de um seletor de operação) e os seguintes submódulos dedicados:



&nbsp;   ➕ Unidade Aritmética: Responsável pelas operações de soma (A+B), subtração (A-B), incremento (A+1) e decremento (A-1).



&nbsp;   🧠 Unidade Lógica: Executa operações bit a bit, incluindo OR, AND, NOT A e NOT B.



&nbsp;   ⏩ Unidade de Deslocamento: Realiza operações de deslocamento direcional (Shift Left e Shift Right).



&nbsp;   ⚖️ Unidade de Comparadores: Gera as flags de status baseadas nos resultados do processamento, indicando condições como Zero, Negativo, Igualdade (A=B) e Menor que (A<B).



&nbsp;   🔀 Multiplexador Principal: Um MUX 16:1 que recebe os resultados de todas as unidades de processamento e roteia a resposta correta para a saída, guiado pelo código de seleção da operação.



&nbsp;   📟 Decodificadores de Display: Conversores dedicados para exibir os resultados binários nos displays de 7 segmentos da placa DE-2.



📂 Estrutura do Repositório



A organização dos arquivos reflete a hierarquia estrutural do hardware:

Plaintext



📦 ula-vhdl

&nbsp;┣ 📜 ula\_top.vhd              # Top-Level: interliga todos os módulos

&nbsp;┣ 📜 arithmetic\_unit.vhd      # Bloco de operações aritméticas

&nbsp;┣ 📜 logic\_unit.vhd           # Bloco de operações lógicas

&nbsp;┣ 📜 shifter\_unit.vhd         # Bloco de operações de deslocamento

&nbsp;┣ 📜 comparators\_unit.vhd     # Bloco de geração de flags e comparações

&nbsp;┣ 📜 mux\_16to1.vhd            # MUX 16:1 para seleção da operação final

&nbsp;┣ 📜 seg7\_ab.vhd              # Decodificador 7 segmentos (Entradas)

&nbsp;┗ 📜 seg7\_s.vhd               # Decodificador 7 segmentos (Saída)



🛠️ Ferramentas e Ambiente



&nbsp;   Linguagem: VHDL (IEEE 1164)



&nbsp;   Alvo de Síntese: Kit FPGA Altera DE-2



<div align="center">

Desenvolvido por <b>Lúcio Vagner</b> • Engenharia de Computação (UFPel)

</div>


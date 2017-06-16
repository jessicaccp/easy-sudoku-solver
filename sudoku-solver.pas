{ Universidade Federal do Ceará }
{ Centro de Ciências }
{ Curso de Computação }
{ Fundamentos de Programação (CK108) 2012.1 - Trabalho Prático }
{ Desenvolvido por Jessica Cacau }

program sudoku;

{ Declaração das variáveis }
var
	a, b, c, d, e, f, g, contador: integer; { Auxiliares }
	auxiliar: integer; { Auxiliar para repetição dos cálculos }
	completo: integer; { Número de células preenchidas }
	opcao: integer; { Usado para usuário responder sim ou não }
	p, pp, linha, coluna, valor: integer; { Valores relacionados às pistas do sudoku }
	matriz: array [1..9, 1..9] of integer; { Matriz do sudoku }
	possibilidades: array [1..9, 1..9, 1..9] of integer; { Matriz com todas as possibilidades }
	fim: char; { Auxiliar }
	
{ Começo do programa }
begin

	{ Instruções para o funcionamento correto do programa }
	writeln('SOLUCIONADOR DE SUDOKU');
	writeln('');
	writeln('Siga as regras abaixo e seja feliz:');
	writeln('- O número de pistas deve variar de 1 a 81');
	writeln('- Os valores para o sudoku devem ser de 1 a 9');
	writeln('- Use apenas números inteiros');
	writeln('- Pressione a tecla Enter após fornecer cada valor pedido');
	writeln('');
	writeln('');
	writeln('Se leu e concorda com as regras:');
	write('Digite 1 para começar ou 2 para sair: ');
	readln(opcao);
	writeln('');
	
	{ Começo do programa de verdade }
	if opcao=1 then
	begin
	
		{ Zerar a matriz do sudoku }
		a := 0; b := 0;
		for a := 1 to 9 do
		begin
			for b := 1 to 9 do
				matriz [a,b] := 0;
		end;
		
		{ Atribuir todas as possibilidades à matriz das possibilidades }
		a := 0; b := 0; c := 0;
		for a := 1 to 9 do
		begin
			for b := 1 to 9 do
			begin
				for c := 1 to 9 do
					possibilidades [a,b,c] := c;
			end;
		end;
	
		{ Receber o número de pistas que serão utilizadas/editadas }
		repeat
		begin
			repeat
			begin
				write('Informe a quantidade de pistas que você quer utilizar/editar: ');
				readln(p);
				if ((p<1) or (p>81)) then
				begin
					writeln('Valor inválido. Digite novamente.');
					writeln('');
				end;
			end;
			until ((p>=1) and (p<=81));
			writeln('');
	
			{ Preencher a matriz do sudoku com as pistas }
			a := 0;
			for a := 1 to p do
			begin
				writeln('Pista ', a);
				repeat
				begin
					write('Linha: ');
					readln(linha);
					if ((linha<1) or (linha>9)) then
					begin
						writeln('Valor inválido. Digite novamente.');
						writeln('');
					end;
				end;
				until ((linha>=1) and (linha<=9));
				repeat
				begin
					write('Coluna: ');
					readln(coluna);
					if ((coluna<1) or (coluna>9)) then
					begin
						writeln('Valor inválido. Digite novamente.');
						writeln('');
					end;
				end;
				until ((coluna>=1) and (coluna<=9));
				repeat
				begin
					write('Valor: ');
					readln(valor);
					if ((valor<1) or (valor>9)) then
					begin
						writeln('Valor inválido. Digite novamente.');
						writeln('');
					end;
				end;
				until ((valor>=1) and (valor<=9));
				writeln('');
				matriz [linha,coluna] := valor;
			end;
			writeln('');
			
			{ Mostrar a matriz com as pistas fornecidas e perguntar se é a correta }
			writeln('Seu atual sudoku:');
			writeln('');
			a := 0; b := 0;
			for a := 1 to 9 do
			begin
				for b := 1 to 9 do
				begin
					if ((a=3) and (b=9)) or ((a=6) and (b=9)) then
					begin
						writeln(matriz[a,b]);
						writeln('');
					end
					else
					begin
						if b=9 then
							writeln(matriz[a,b])
						else
						begin
							if (b=3) or (b=6) then
								write(matriz[a,b], '   ')
							else
								write(matriz[a,b], ' ');
						end;
					end;
				end;
			end;
			writeln('');
			writeln('O sudoku acima é o que você deseja resolver?');
			write('Digite 1 para sim ou 2 pra não: ');
			readln(opcao);
		end;
		until opcao=1;
		
		writeln('');
		writeln('Calculando. Aguarde...');
		writeln('');
		
		{ Faz os cálculos para preencher a matriz com a possibilidade correta }
		for auxiliar := 1 to 1000 do
		begin
		
			{ Zerar as possibilidades para as células com pistas }
			a := 0; b := 0; c := 0;
			for a := 1 to 9 do
			begin
				for b := 1 to 9 do
				begin
					for c := 1 to 9 do
					begin
						if (matriz[a,b]<>0) then
							possibilidades [a,b,c] := 0;
					end;
				end;
			end;
		
			{ Se uma célula já estiver preenchida, zerar essa possibilidade para a LINHA }
			a := 0; b := 0; c := 0; d := 0;
			for a := 1 to 9 do
			begin
				for b := 1 to 9 do
				begin
					if (matriz[a,b]<>0) then
					begin
						for c := 1 to 9 do
						begin
							for d := 1 to 9 do
							begin
								if (possibilidades[a,c,d]=matriz[a,b]) then
									possibilidades [a,c,d] := 0;
							end;
						end;
					end;
				end;
			end;
			
			{ Se uma célula já estiver preenchida, zerar essa possibilidade para a COLUNA }
			a := 0; b := 0; c := 0; d := 0;
			for a := 1 to 9 do
			begin
				for b := 1 to 9 do
				begin
					if (matriz[a,b]<>0) then
					begin
						for c := 1 to 9 do
						begin
							for d := 1 to 9 do
							begin
								if (possibilidades[c,b,d]=matriz[a,b]) then
									possibilidades [c,b,d] := 0;
							end;
						end;
					end;
				end;
			end;
		
			{ Se uma célula já estiver preenchida, zerar essa possibilidade para sua respectiva ÁREA 3X3 }
			a := 0; b := 0; c := 0; d := 0; e := 0;
			for a := 1 to 9 do
			begin
				for b := 1 to 9 do
				begin
					if (matriz[a,b]<>0) then
					begin
				
						{ 1-3 áreas 3x3 }
						if (a<=3) then
						begin
							for c := 1 to 3 do
							begin
								
								{ Primeira área 3x3 }
								if (b<=3) then
								begin
									for d := 1 to 3 do
									begin
										for e := 1 to 9 do
										begin
											if (possibilidades[c,d,e]=matriz[a,b]) then
												possibilidades [c,d,e] := 0;
										end;
									end;
								end;
						
								{ Segunda área 3x3 }
								if ((b>3) and (b<7)) then
								begin
									for d := 4 to 6 do
									begin
										for e := 1 to 9 do
										begin
											if (possibilidades[c,d,e]=matriz[a,b]) then
												possibilidades [c,d,e] := 0;
										end;
									end;
								end;
							
								{ Terceira área 3x3 }
								if (b>=7) then
								begin
									for d := 7 to 9 do
									begin
										for e := 1 to 9 do
										begin
											if (possibilidades[c,d,e]=matriz[a,b]) then
												possibilidades [c,d,e] := 0;
										end;
									end;
								end;
							end;
						end;
						
						{ 4-6 áreas 3x3 }
						if ((a>3) and (a<7)) then
						begin
							for c := 4 to 6 do
							begin
								
								{ Quarta área 3x3 }
								if (b<=3) then
								begin
									for d := 1 to 3 do
									begin
										for e := 1 to 9 do
										begin
											if (possibilidades[c,d,e]=matriz[a,b]) then
												possibilidades [c,d,e] := 0;
										end;
									end;
								end;
								
								{ Quinta área 3x3 }
								if ((b>3) and (b<7)) then
								begin
									for d := 4 to 6 do
									begin
										for e := 1 to 9 do
										begin
											if (possibilidades[c,d,e]=matriz[a,b]) then
												possibilidades [c,d,e] := 0;
										end;
									end;
								end;
							
								{ Sexta área 3x3 }
								if (b>=7) then
								begin
									for d := 7 to 9 do
									begin
										for e := 1 to 9 do
										begin
											if (possibilidades[c,d,e]=matriz[a,b]) then
												possibilidades [c,d,e] := 0;
										end;
									end;
								end;					
							end;
						end;
					
						{ 7-9 áreas 3x3 }
						if (a>=7) then
						begin
							for c := 7 to 9 do
							begin
							
								{ Sétima área 3x3 }
								if (b<=3) then
								begin
									for d := 1 to 3 do
									begin
										for e := 1 to 9 do
										begin
											if (possibilidades[c,d,e]=matriz[a,b]) then
												possibilidades [c,d,e] := 0;
										end;
									end;
								end;
								
								{ Oitava área 3x3 }
								if ((b>3) and (b<7)) then
								begin
									for d := 4 to 6 do
									begin
										for e := 1 to 9 do
										begin
											if (possibilidades[c,d,e]=matriz[a,b]) then
												possibilidades [c,d,e] := 0;
										end;
									end;
								end;
							
								{ Nona área 3x3 }
								if (b>=7) then
								begin
									for d := 7 to 9 do
									begin
										for e := 1 to 9 do
										begin
											if (possibilidades[c,d,e]=matriz[a,b]) then
												possibilidades [c,d,e] := 0;
										end;
									end;
								end;					
							end;
						end;
					end;
				end;
			end;
		
			{ Ver se a célula possui apenas uma possibilidade e, se sim, atribuí-la à matriz do sudoku }
			a := 0; b := 0; c := 0; d := 0; contador := 0;
			for a := 1 to 9 do
			begin
				for b := 1 to 9 do
				begin
					for c := 1 to 9 do
					begin
						if (possibilidades[a,b,c]<>0) then
							contador := contador+1;
					end;
					if contador=1 then
					begin
						for d := 1 to 9 do
						begin
							if (possibilidades[a,b,d]<>0) then
								matriz[a,b] := possibilidades [a,b,d];
						end;
					end;
					contador := 0;
				end;
			end;
			
			{ Se existir uma possibilidade que se encaixe em apenas uma célula da LINHA, atribuí-la à matriz }
			a := 0; b := 0; c := 0; d := 0; contador := 0; 
			for a :=  1 to 9 do
			begin
				for b := 1 to 9 do
				begin
					for c := 1 to 9 do
					begin
						if (possibilidades[a,c,b]<>0) then
							contador := contador+1
					end;
					if (contador=1) then
					begin
						for d := 1 to 9 do
						begin
							if possibilidades[a,d,b]<>0 then
								matriz [a,d] := b;
						end;
					end;
					contador := 0;
				end;
			end;
			
			{ Se existir uma possibilidade que se encaixe em apenas uma célula da COLUNA, atribuí-la à matriz }
			a := 0; b := 0; c := 0; d := 0; contador := 0; 
			for a :=  1 to 9 do
			begin
				for b := 1 to 9 do
				begin
					for c := 1 to 9 do
					begin
						if (possibilidades[c,a,b]<>0) then
							contador := contador+1
					end;
					if (contador=1) then
					begin
						for d := 1 to 9 do
						begin
							if possibilidades[d,a,b]<>0 then
								matriz [d,a] := b;
						end;
					end;
					contador := 0;
				end;
			end;
			
			{ Se existir uma possibilidade que se encaixe em apenas uma célula da ÁREA 3X3, atribuí-la à matriz }
			a := 0; b := 0; c := 0; d := 0; contador := 0; 
			for a :=  1 to 9 do
			begin
		
				{ Primeira área 3x3 }
				for b := 1 to 3 do
				begin
					for c := 1 to 3 do
					begin
						if (possibilidades[b,c,a]<>0) then
							contador := contador+1
					end;
				end;
				if (contador=1) then
				begin
					for d := 1 to 3 do
					begin
						for e := 1 to 3 do
						begin
							if possibilidades[d,e,a]<>0 then
								matriz [d,e] := a;
						end;
					end;
				end;
	
				{ Segunda área 3x3 }
				for b := 1 to 3 do
				begin
					for c := 4 to 6 do
					begin
						if (possibilidades[b,c,a]<>0) then
							contador := contador+1
					end;
				end;
				if (contador=1) then
				begin
					for d := 1 to 3 do
					begin
						for e := 4 to 6 do
						begin
							if possibilidades[d,e,a]<>0 then
								matriz [d,e] := a;
						end;
					end;
				end;
		
				{ Terceira área 3x3 }
				for b := 1 to 3 do
				begin
					for c := 7 to 9 do
					begin
						if (possibilidades[b,c,a]<>0) then
							contador := contador+1
					end;
				end;
				if (contador=1) then
				begin
					for d := 1 to 3 do
					begin
						for e := 7 to 9 do
						begin
							if possibilidades[d,e,a]<>0 then
								matriz [d,e] := a;
						end;
					end;
				end;
		
				{ Quarta área 3x3 }
				for b := 4 to 6 do
				begin
					for c := 1 to 3 do
					begin
						if (possibilidades[b,c,a]<>0) then
							contador := contador+1
					end;
				end;
				if (contador=1) then
				begin
					for d := 4 to 6 do
					begin
						for e := 1 to 3 do
						begin
							if possibilidades[d,e,a]<>0 then
								matriz [d,e] := a;
						end;
					end;
				end;
		
				{ Quinta área 3x3 }
				for b := 4 to 6 do
				begin
					for c := 4 to 6 do
					begin
						if (possibilidades[b,c,a]<>0) then
							contador := contador+1
					end;
				end;
				if (contador=1) then
				begin
					for d := 4 to 6 do
					begin
						for e := 4 to 6 do
						begin
							if possibilidades[d,e,a]<>0 then
								matriz [d,e] := a;
						end;
					end;
				end;
		
				{ Sexta área 3x3 }
				for b := 4 to 6 do
				begin
					for c := 7 to 9 do
					begin
						if (possibilidades[b,c,a]<>0) then
							contador := contador+1
					end;
				end;
				if (contador=1) then
				begin
					for d := 4 to 6 do
					begin
						for e := 7 to 9 do
						begin
							if possibilidades[d,e,a]<>0 then
								matriz [d,e] := a;
						end;
					end;
				end;	
		
				{ Sétima área 3x3 }
				for b := 7 to 9 do
				begin
					for c := 1 to 3 do
					begin
						if (possibilidades[b,c,a]<>0) then
							contador := contador+1
					end;
				end;
				if (contador=1) then
				begin
					for d := 7 to 9 do
					begin
						for e := 1 to 3 do
						begin
							if possibilidades[d,e,a]<>0 then
								matriz [d,e] := a;
						end;
					end;
				end;
		
				{ Oitava área 3x3 }
				for b := 7 to 9 do
				begin
					for c := 4 to 6 do
					begin
						if (possibilidades[b,c,a]<>0) then
							contador := contador+1
					end;
				end;
				if (contador=1) then
				begin
					for d := 7 to 9 do
					begin
						for e := 4 to 6 do
						begin
							if possibilidades[d,e,a]<>0 then
								matriz [d,e] := a;
						end;
					end;
				end;
				
				{ Nona área 3x3 }
				for b := 7 to 9 do
				begin
					for c := 7 to 9 do
					begin
						if (possibilidades[b,c,a]<>0) then
							contador := contador+1
					end;
				end;
				if (contador=1) then
				begin
					for d := 7 to 9 do
					begin
						for e := 7 to 9 do
						begin
							if possibilidades[d,e,a]<>0 then
								matriz [d,e] := a;
						end;
					end;
				end;	
				contador := 0;
			end;
		end;
	
		{ Checa quantas células da matriz do sudoku estão preenchidas }
		a := 0; b := 0; completo := 0;
		for a := 1 to 9 do
		begin
			for b := 1 to 9 do
			begin
				if (matriz[a,b]<>0) then
					completo := completo+1;
			end;
		end;
	
		{ Se a matriz não foi resolvida, avisa que a solução é impossível }
		if completo<81 then
		begin
			writeln('');
			writeln('Solução impossível');
		end
		else
		begin
		
			{ Mostra a matriz final, com todas as células preenchidas }
			writeln('');
			writeln('Solução:');
			writeln('');
			a := 0; b := 0;
			for a := 1 to 9 do
			begin
				for b := 1 to 9 do
				begin
					if ((a=3) and (b=9)) or ((a=6) and (b=9)) then
					begin
						writeln(matriz[a,b]);
						writeln('');
					end
					else
					begin
						if b=9 then
							writeln(matriz[a,b])
						else
						begin
							if (b=3) or (b=6) then
								write(matriz[a,b], '   ')
							else
								write(matriz[a,b], ' ');
						end;
					end;
				end;
			end;
		end;
	end;
	read(fim);
end.

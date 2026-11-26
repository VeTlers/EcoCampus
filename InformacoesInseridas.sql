INSERT INTO CURSOS (nome, area, turno, campus) 
VALUES ('Sistemas de Informação', 'Tecnologia', 'Noturno', 'Mooca');

INSERT INTO CURSOS (nome, area, turno, campus) 
VALUES ('Engenharia de Software', 'Exatas', 'Matutino', 'Mooca');

INSERT INTO MATERIAIS (nome, nivel_nociv, pontos_por_kg, unidade) 
VALUES ('Garrafa PET', 'Baixo', 10.00, 'kg');

INSERT INTO MATERIAIS (nome, nivel_nociv, pontos_por_kg, unidade) 
VALUES ('Alumínio (Latas)', 'Médio', 25.50, 'kg');

INSERT INTO MATERIAIS (nome, nivel_nociv, pontos_por_kg, unidade) 
VALUES ('Papelão', 'Baixo', 5.00, 'kg');

INSERT INTO CICLOS (nome, data_inicio_coleta, data_fim_coleta, status) 
VALUES ('Ciclo 2026/1', TO_DATE('2026-03-01', 'YYYY-MM-DD'), TO_DATE('2026-06-30', 'YYYY-MM-DD'), 'Em Andamento');

INSERT INTO LIXEIRAS (codigo_identificacao, localizacao, status) 
VALUES ('LIX-MOOCA-01', 'Bloco A - Térreo', 'Ativa');

INSERT INTO LIXEIRAS (codigo_identificacao, localizacao, status) 
VALUES ('LIX-MOOCA-01', 'Entrada Principal', 'Ativa');

INSERT INTO ALUNOS (id_curso, nome, email, matricula) 
VALUES (1, 'Ana Silva', 'ana.silva@aluno.edu', '20260101');

INSERT INTO ALUNOS (id_curso, nome, email, matricula) 
VALUES (2, 'Carlos Souza', 'carlos.souza@aluno.edu', '20260102');

INSERT INTO RESPONSAVEIS (nome, email, senha_hash, tipo, id_curso) 
VALUES ('Prof. Roberto Carlos', 'roberto.carlos@univ.edu', 'hash_senha_segura_123', 'Professor', 1);

INSERT INTO ENTREGAS (id_aluno, id_material, id_ciclo, id_lixeira, url_foto, quantidade_kg, status, observacao) 
VALUES (1, 1, 1, 1, 'https://drive.google.com/uc?id=exemplo_foto_pet_01', 1.500, 'Pendente', 'Garrafas amassadas limpas');

INSERT INTO ENTREGAS (id_aluno, id_material, id_ciclo, id_lixeira, url_foto, quantidade_kg, status, observacao) 
VALUES (2, 2, 1, 2, 'https://drive.google.com/uc?id=exemplo_foto_lata_02', 0.800, 'Pendente', 'Latas de alumínio');

COMMIT;
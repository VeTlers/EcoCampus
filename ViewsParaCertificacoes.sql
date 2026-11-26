CREATE OR REPLACE VIEW VW_DASH_CURSOS AS
SELECT 
    ci.id_ciclo,
    ci.nome AS semestre,
    ci.status AS status_semestre,
    cu.campus,
    cu.area,
    cu.nome AS curso,
    cu.turno,
    COUNT(DISTINCT e.id_aluno) AS alunos_participantes,
    COUNT(e.id_entrega) AS total_entregas_aprovadas,
    NVL(SUM(e.quantidade_kg), 0) AS total_kg_reciclados,
    NVL(SUM(e.quantidade_kg * m.pontos_por_kg), 0) AS total_pontos_curso
FROM CICLOS ci
CROSS JOIN CURSOS cu
LEFT JOIN ALUNOS a ON a.id_curso = cu.id_curso
LEFT JOIN ENTREGAS e ON e.id_aluno = a.id_aluno 
                    AND e.id_ciclo = ci.id_ciclo 
                    AND e.status = 'Aprovado'
LEFT JOIN MATERIAIS m ON m.id_material = e.id_material
GROUP BY ci.id_ciclo, ci.nome, ci.status, cu.campus, cu.area, cu.nome, cu.turno;


CREATE OR REPLACE VIEW VW_DASH_ALUNOS_SEMESTRE AS
SELECT 
    ci.id_ciclo,
    ci.nome AS semestre,
    ci.status AS status_semestre,
    a.matricula,
    a.nome AS aluno,
    cu.nome AS curso,
    cu.campus,
    NVL(pc.total_entregas, 0) AS entregas_no_semestre,
    NVL(pc.total_pontos, 0) AS pontos_no_semestre,
    RANK() OVER (PARTITION BY ci.id_ciclo, cu.id_curso ORDER BY NVL(pc.total_pontos, 0) DESC) AS ranking_no_curso,
    RANK() OVER (PARTITION BY ci.id_ciclo ORDER BY NVL(pc.total_pontos, 0) DESC) AS ranking_geral_universidade
FROM CICLOS ci
CROSS JOIN ALUNOS a
JOIN CURSOS cu ON cu.id_curso = a.id_curso
LEFT JOIN PONTUACOES_CICLO pc ON pc.id_aluno = a.id_aluno AND pc.id_ciclo = ci.id_ciclo;

CREATE OR REPLACE VIEW VW_DASH_MATERIAIS_LIXEIRAS AS
SELECT 
    ci.nome AS semestre,
    l.codigo_identificacao AS lixeira,
    l.localizacao,
    m.nome AS material,
    m.nivel_nociv,
    COUNT(e.id_entrega) AS qtd_depositos,
    SUM(e.quantidade_kg) AS peso_total_kg
FROM ENTREGAS e
JOIN CICLOS ci ON ci.id_ciclo = e.id_ciclo
JOIN LIXEIRAS l ON l.id_lixeira = e.id_lixeira
JOIN MATERIAIS m ON m.id_material = e.id_material
WHERE e.status = 'Aprovado'
GROUP BY ci.nome, l.codigo_identificacao, l.localizacao, m.nome, m.nivel_nociv;
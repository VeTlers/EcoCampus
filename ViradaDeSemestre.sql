CREATE OR REPLACE PROCEDURE VIRAR_SEMESTRE (
    p_id_ciclo_atual    IN NUMBER,
    p_nome_novo_ciclo   IN VARCHAR2,
    p_inicio_coleta     IN DATE,
    p_fim_coleta        IN DATE,
    p_top_ganhadores    IN NUMBER DEFAULT 3, 
    p_horas_certificado IN NUMBER DEFAULT 80
) AS
BEGIN
   
    INSERT INTO RANKING_HISTORICO (id_aluno, id_ciclo, posicao, total_pontos, data_calculo)
    SELECT 
        id_aluno,
        p_id_ciclo_atual,
        ROW_NUMBER() OVER (ORDER BY total_pontos DESC, total_entregas DESC) AS posicao,
        total_pontos,
        SYSDATE
    FROM PONTUACOES_CICLO
    WHERE id_ciclo = p_id_ciclo_atual;

    INSERT INTO GANHADORES_CERTIFICADO (
        id_aluno, id_ciclo, total_pontos, posicao_final, horas_complementares, certificado_emitido
    )
    SELECT 
        id_aluno,
        id_ciclo,
        total_pontos,
        posicao,
        p_horas_certificado,
        'N'
    FROM RANKING_HISTORICO
    WHERE id_ciclo = p_id_ciclo_atual
      AND posicao <= p_top_ganhadores;

 
    UPDATE CICLOS 
    SET status = 'Finalizado',
        data_finaliz = SYSDATE
    WHERE id_ciclo = p_id_ciclo_atual;

    INSERT INTO CICLOS (nome, data_inicio_coleta, data_fim_coleta, status)
    VALUES (p_nome_novo_ciclo, p_inicio_coleta, p_fim_coleta, 'Em Andamento');

    COMMIT;
END;
/

-- Comando que utilizarei para virar o semestre:--

EXEC VIRAR_SEMESTRE(1, 'Ciclo 2026/2', TO_DATE('2026-08-01', 'YYYY-MM-DD'), TO_DATE('2026-11-30', 'YYYY-MM-DD'), 3, 80);
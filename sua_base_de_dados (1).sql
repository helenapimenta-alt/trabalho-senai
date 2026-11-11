-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Tempo de geração: 11/11/2026 às 14:13
-- Versão do servidor: 8.0.42-0ubuntu0.24.04.1
-- Versão do PHP: 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `sua_base_de_dados`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `COMPONENTES_MAQ`
--

CREATE TABLE `COMPONENTES_MAQ` (
  `id_componente` int NOT NULL,
  `id_maquina` int NOT NULL,
  `nome_componente` varchar(100) NOT NULL,
  `horas_uso_acumulado` int NOT NULL DEFAULT '0',
  `limite_horas_alerta` int NOT NULL
) ;

--
-- Despejando dados para a tabela `COMPONENTES_MAQ`
--

INSERT INTO `COMPONENTES_MAQ` (`id_componente`, `id_maquina`, `nome_componente`, `horas_uso_acumulado`, `limite_horas_alerta`) VALUES
(1, 1, 'Lente Focal do Laser', 640, 2000),
(2, 2, 'Motor de Tração', 1500, 8000),
(3, 3, 'Resistência Térmica', 7200, 8000),
(4, 4, 'Servomotor do Eixo 3', 210, 6000),
(5, 5, 'Rosca de Plastificação', 11800, 12000);

-- --------------------------------------------------------

--
-- Estrutura para tabela `ESTOQUE_PECAS`
--

CREATE TABLE `ESTOQUE_PECAS` (
  `id_peca` int NOT NULL,
  `codigo_part_number` varchar(50) NOT NULL,
  `descricao` varchar(150) NOT NULL,
  `qtd_estoque` int NOT NULL,
  `preco_unitario` decimal(10,2) NOT NULL
) ;

--
-- Despejando dados para a tabela `ESTOQUE_PECAS`
--

INSERT INTO `ESTOQUE_PECAS` (`id_peca`, `codigo_part_number`, `descricao`, `qtd_estoque`, `preco_unitario`) VALUES
(1, 'SKU-A210', 'Lente de foco ZnSe 63,5mm', 8, 450.00),
(2, 'SKU-B330', 'Rolete de esteira 50mm', 40, 28.75),
(3, 'SKU-C415', 'Resistência cerâmica 2000W', 12, 195.90),
(4, 'SKU-D508', 'Cabo de encoder blindado 5m', 25, 64.30),
(5, 'SKU-E619', 'Graxa industrial EP2 (1kg)', 60, 22.40);

-- --------------------------------------------------------

--
-- Estrutura para tabela `HISTORICO_SENSORES`
--

CREATE TABLE `HISTORICO_SENSORES` (
  `id_leitura` int NOT NULL,
  `id_ordem` int NOT NULL,
  `temperatura_medida` decimal(5,2) NOT NULL,
  `vibracao_mm_s` decimal(5,2) NOT NULL,
  `data_hora_leitura` datetime NOT NULL,
  `prompt_geracao_ia` varchar(100) DEFAULT 'GERADO_POR_LLM'
) ;

--
-- Despejando dados para a tabela `HISTORICO_SENSORES`
--

INSERT INTO `HISTORICO_SENSORES` (`id_leitura`, `id_ordem`, `temperatura_medida`, `vibracao_mm_s`, `data_hora_leitura`, `prompt_geracao_ia`) VALUES
(1, 1, 48.20, 1.45, '2026-08-05 08:15:00', 'GERADO_POR_LLM'),
(2, 2, 61.90, 3.10, '2026-08-22 14:00:00', 'GERADO_POR_LLM'),
(3, 3, 215.40, 5.75, '2026-09-18 08:40:00', 'GERADO_POR_LLM'),
(4, 4, 52.30, 2.05, '2026-10-07 16:00:00', 'GERADO_POR_LLM'),
(5, 5, 95.60, 6.30, '2026-10-28 10:45:00', 'GERADO_POR_LLM');

-- --------------------------------------------------------

--
-- Estrutura para tabela `LINHAS_PRODUCAO`
--

CREATE TABLE `LINHAS_PRODUCAO` (
  `id_linha` int NOT NULL,
  `id_unidade` int NOT NULL,
  `nome_linha` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Despejando dados para a tabela `LINHAS_PRODUCAO`
--

INSERT INTO `LINHAS_PRODUCAO` (`id_linha`, `id_unidade`, `nome_linha`) VALUES
(1, 1, 'Linha de Corte a Laser'),
(2, 1, 'Linha de Embalagem'),
(3, 2, 'Linha de Fundição'),
(4, 3, 'Linha de Eletrônica Embarcada'),
(5, 5, 'Linha de Estamparia');

-- --------------------------------------------------------

--
-- Estrutura para tabela `MAQUINAS_SENAI`
--

CREATE TABLE `MAQUINAS_SENAI` (
  `id_maquina` int NOT NULL,
  `id_linha` int NOT NULL,
  `id_tipo` int NOT NULL,
  `tag_patrimonio` varchar(30) NOT NULL,
  `data_aquisicao` date NOT NULL,
  `status_operacao` varchar(20) NOT NULL
) ;

--
-- Despejando dados para a tabela `MAQUINAS_SENAI`
--

INSERT INTO `MAQUINAS_SENAI` (`id_maquina`, `id_linha`, `id_tipo`, `tag_patrimonio`, `data_aquisicao`, `status_operacao`) VALUES
(1, 1, 1, 'SNI-2024-001', '2024-02-12', 'ATIVA'),
(2, 2, 3, 'SNI-2023-014', '2023-08-25', 'ATIVA'),
(3, 3, 4, 'SNI-2021-032', '2021-04-18', 'MANUTENCAO'),
(4, 4, 5, 'SNI-2025-007', '2025-01-30', 'ATIVA'),
(5, 5, 2, 'SNI-2018-045', '2018-09-09', 'DESATIVADA');

-- --------------------------------------------------------

--
-- Estrutura para tabela `ORDENS_SERVICO`
--

CREATE TABLE `ORDENS_SERVICO` (
  `id_ordem` int NOT NULL,
  `id_maquina` int NOT NULL,
  `id_tecnico` int NOT NULL,
  `data_abertura` datetime NOT NULL,
  `tipo_manutencao` varchar(20) NOT NULL,
  `status_os` varchar(20) NOT NULL
) ;

--
-- Despejando dados para a tabela `ORDENS_SERVICO`
--

INSERT INTO `ORDENS_SERVICO` (`id_ordem`, `id_maquina`, `id_tecnico`, `data_abertura`, `tipo_manutencao`, `status_os`) VALUES
(1, 1, 2, '2026-08-05 07:45:00', 'PREVENTIVA', 'CONCLUIDA'),
(2, 2, 3, '2026-08-22 13:20:00', 'CORRETIVA', 'CONCLUIDA'),
(3, 3, 4, '2026-09-18 08:00:00', 'PREDITIVA', 'EM_ANDAMENTO'),
(4, 4, 5, '2026-10-07 15:30:00', 'PREVENTIVA', 'ABERTA'),
(5, 5, 1, '2026-10-28 10:10:00', 'CORRETIVA', 'CANCELADA');

-- --------------------------------------------------------

--
-- Estrutura para tabela `PECAS_OS`
--

CREATE TABLE `PECAS_OS` (
  `id_ordem` int NOT NULL,
  `id_peca` int NOT NULL,
  `qtd_utilizada` int NOT NULL,
  `preco_aplicado` decimal(10,2) NOT NULL
) ;

--
-- Despejando dados para a tabela `PECAS_OS`
--

INSERT INTO `PECAS_OS` (`id_ordem`, `id_peca`, `qtd_utilizada`, `preco_aplicado`) VALUES
(1, 1, 1, 450.00),
(2, 2, 6, 28.75),
(3, 3, 2, 195.90),
(4, 4, 1, 64.30),
(5, 5, 3, 22.40);

-- --------------------------------------------------------

--
-- Estrutura para tabela `TECNICOS`
--

CREATE TABLE `TECNICOS` (
  `id_tecnico` int NOT NULL,
  `nome_tecnico` varchar(100) NOT NULL,
  `especialidade` varchar(50) NOT NULL,
  `nivel_certificacao` varchar(30) NOT NULL
) ;

--
-- Despejando dados para a tabela `TECNICOS`
--

INSERT INTO `TECNICOS` (`id_tecnico`, `nome_tecnico`, `especialidade`, `nivel_certificacao`) VALUES
(1, 'Marcos Vinícius Alves', 'Mecatrônica', 'PLENO'),
(2, 'Juliana Ferreira', 'Eletrônica', 'SENIOR'),
(3, 'Pedro Henrique Santos', 'Manutenção Geral', 'JUNIOR'),
(4, 'Luciana Barbosa', 'Termodinâmica', 'SPECIALIST'),
(5, 'Ricardo Oliveira', 'Robótica', 'SENIOR');

-- --------------------------------------------------------

--
-- Estrutura para tabela `TIPOS_MAQUINA`
--

CREATE TABLE `TIPOS_MAQUINA` (
  `id_tipo` int NOT NULL,
  `nome_tipo` varchar(50) NOT NULL,
  `horas_revisao_padrao` int NOT NULL
) ;

--
-- Despejando dados para a tabela `TIPOS_MAQUINA`
--

INSERT INTO `TIPOS_MAQUINA` (`id_tipo`, `nome_tipo`, `horas_revisao_padrao`) VALUES
(1, 'Cortadora a Laser', 450),
(2, 'Injetora de Plástico', 700),
(3, 'Esteira Transportadora', 350),
(4, 'Forno Industrial', 900),
(5, 'Braço Robótico', 550);

-- --------------------------------------------------------

--
-- Estrutura para tabela `UNIDADES_SENAI`
--

CREATE TABLE `UNIDADES_SENAI` (
  `id_unidade` int NOT NULL,
  `nome_unidade` varchar(100) NOT NULL,
  `cidade` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Despejando dados para a tabela `UNIDADES_SENAI`
--

INSERT INTO `UNIDADES_SENAI` (`id_unidade`, `nome_unidade`, `cidade`) VALUES
(1, 'SENAI Paranavaí', 'Paranavaí'),
(2, 'SENAI Ponta Grossa', 'Ponta Grossa'),
(3, 'SENAI Foz do Iguaçu', 'Foz do Iguaçu'),
(4, 'SENAI Guarapuava', 'Guarapuava'),
(5, 'SENAI Joinville', 'Joinville');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `COMPONENTES_MAQ`
--
ALTER TABLE `COMPONENTES_MAQ`
  ADD PRIMARY KEY (`id_componente`),
  ADD KEY `fk_componentes_maquina` (`id_maquina`);

--
-- Índices de tabela `ESTOQUE_PECAS`
--
ALTER TABLE `ESTOQUE_PECAS`
  ADD PRIMARY KEY (`id_peca`),
  ADD UNIQUE KEY `uk_estoque_part_number` (`codigo_part_number`);

--
-- Índices de tabela `HISTORICO_SENSORES`
--
ALTER TABLE `HISTORICO_SENSORES`
  ADD PRIMARY KEY (`id_leitura`),
  ADD KEY `fk_historico_ordem` (`id_ordem`);

--
-- Índices de tabela `LINHAS_PRODUCAO`
--
ALTER TABLE `LINHAS_PRODUCAO`
  ADD PRIMARY KEY (`id_linha`),
  ADD KEY `fk_linhas_unidade` (`id_unidade`);

--
-- Índices de tabela `MAQUINAS_SENAI`
--
ALTER TABLE `MAQUINAS_SENAI`
  ADD PRIMARY KEY (`id_maquina`),
  ADD UNIQUE KEY `uk_maquinas_tag` (`tag_patrimonio`),
  ADD KEY `fk_maquinas_linha` (`id_linha`),
  ADD KEY `fk_maquinas_tipo` (`id_tipo`);

--
-- Índices de tabela `ORDENS_SERVICO`
--
ALTER TABLE `ORDENS_SERVICO`
  ADD PRIMARY KEY (`id_ordem`),
  ADD KEY `fk_ordens_maquina` (`id_maquina`),
  ADD KEY `fk_ordens_tecnico` (`id_tecnico`);

--
-- Índices de tabela `PECAS_OS`
--
ALTER TABLE `PECAS_OS`
  ADD PRIMARY KEY (`id_ordem`,`id_peca`),
  ADD KEY `fk_pecas_os_peca` (`id_peca`);

--
-- Índices de tabela `TECNICOS`
--
ALTER TABLE `TECNICOS`
  ADD PRIMARY KEY (`id_tecnico`);

--
-- Índices de tabela `TIPOS_MAQUINA`
--
ALTER TABLE `TIPOS_MAQUINA`
  ADD PRIMARY KEY (`id_tipo`);

--
-- Índices de tabela `UNIDADES_SENAI`
--
ALTER TABLE `UNIDADES_SENAI`
  ADD PRIMARY KEY (`id_unidade`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `COMPONENTES_MAQ`
--
ALTER TABLE `COMPONENTES_MAQ`
  MODIFY `id_componente` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `ESTOQUE_PECAS`
--
ALTER TABLE `ESTOQUE_PECAS`
  MODIFY `id_peca` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `HISTORICO_SENSORES`
--
ALTER TABLE `HISTORICO_SENSORES`
  MODIFY `id_leitura` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `LINHAS_PRODUCAO`
--
ALTER TABLE `LINHAS_PRODUCAO`
  MODIFY `id_linha` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `MAQUINAS_SENAI`
--
ALTER TABLE `MAQUINAS_SENAI`
  MODIFY `id_maquina` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `ORDENS_SERVICO`
--
ALTER TABLE `ORDENS_SERVICO`
  MODIFY `id_ordem` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `TECNICOS`
--
ALTER TABLE `TECNICOS`
  MODIFY `id_tecnico` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `TIPOS_MAQUINA`
--
ALTER TABLE `TIPOS_MAQUINA`
  MODIFY `id_tipo` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `UNIDADES_SENAI`
--
ALTER TABLE `UNIDADES_SENAI`
  MODIFY `id_unidade` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `COMPONENTES_MAQ`
--
ALTER TABLE `COMPONENTES_MAQ`
  ADD CONSTRAINT `fk_componentes_maquina` FOREIGN KEY (`id_maquina`) REFERENCES `MAQUINAS_SENAI` (`id_maquina`);

--
-- Restrições para tabelas `HISTORICO_SENSORES`
--
ALTER TABLE `HISTORICO_SENSORES`
  ADD CONSTRAINT `fk_historico_ordem` FOREIGN KEY (`id_ordem`) REFERENCES `ORDENS_SERVICO` (`id_ordem`);

--
-- Restrições para tabelas `LINHAS_PRODUCAO`
--
ALTER TABLE `LINHAS_PRODUCAO`
  ADD CONSTRAINT `fk_linhas_unidade` FOREIGN KEY (`id_unidade`) REFERENCES `UNIDADES_SENAI` (`id_unidade`);

--
-- Restrições para tabelas `MAQUINAS_SENAI`
--
ALTER TABLE `MAQUINAS_SENAI`
  ADD CONSTRAINT `fk_maquinas_linha` FOREIGN KEY (`id_linha`) REFERENCES `LINHAS_PRODUCAO` (`id_linha`),
  ADD CONSTRAINT `fk_maquinas_tipo` FOREIGN KEY (`id_tipo`) REFERENCES `TIPOS_MAQUINA` (`id_tipo`);

--
-- Restrições para tabelas `ORDENS_SERVICO`
--
ALTER TABLE `ORDENS_SERVICO`
  ADD CONSTRAINT `fk_ordens_maquina` FOREIGN KEY (`id_maquina`) REFERENCES `MAQUINAS_SENAI` (`id_maquina`),
  ADD CONSTRAINT `fk_ordens_tecnico` FOREIGN KEY (`id_tecnico`) REFERENCES `TECNICOS` (`id_tecnico`);

--
-- Restrições para tabelas `PECAS_OS`
--
ALTER TABLE `PECAS_OS`
  ADD CONSTRAINT `fk_pecas_os_ordem` FOREIGN KEY (`id_ordem`) REFERENCES `ORDENS_SERVICO` (`id_ordem`),
  ADD CONSTRAINT `fk_pecas_os_peca` FOREIGN KEY (`id_peca`) REFERENCES `ESTOQUE_PECAS` (`id_peca`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

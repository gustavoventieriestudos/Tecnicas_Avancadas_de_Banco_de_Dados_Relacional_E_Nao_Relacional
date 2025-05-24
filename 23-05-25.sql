CREATE DATABASE LivrariaDB;
USE LivrariaDB;

-- Tabela Autores
CREATE TABLE Autores (
AutorID INT IDENTITY(1,1) PRIMARY KEY,
Nome VARCHAR(100) NOT NULL,
Nacionalidade VARCHAR(50)
);

-- Tabela Livros
CREATE TABLE Livros (
LivroID INT IDENTITY(1,1) PRIMARY KEY,
Titulo VARCHAR(150) NOT NULL,
AnoPublicacao INT,
Preco DECIMAL(8,2),
AutorID INT,
FOREIGN KEY (AutorID) REFERENCES Autores(AutorID)
);

-- Tabela Vendas
CREATE TABLE Vendas (
VendaID INT IDENTITY(1,1) PRIMARY KEY,
LivroID INT,
DataVenda DATE,
Quantidade INT,
FOREIGN KEY (LivroID) REFERENCES Livros(LivroID)
);

-- Autores
INSERT INTO Autores (Nome, Nacionalidade) VALUES
('J.K. Rowling', 'Brit�nica'), 
('George R.R. Martin', 'Americano'), 
('Machado de Assis', 'Brasileiro'),
('Stephen King', 'Americano'), 
('Agatha Christie', 'Brit�nica'), 
('Paulo Coelho', 'Brasileiro'),
('J. R. R. Tolkien', 'Brit�nico'), 
('Dan Brown', 'Americano'), 
('Clarice Lispector', 'Brasileira'),
('Neil Gaiman', 'Brit�nico'), 
('Isabel Allende', 'Chilena'), 
('Haruki Murakami', 'Japon�s'),
('Cecelia Ahern', 'Irlandesa'), 
('Suzanne Collins', 'Americana'), 
('Rick Riordan', 'Americano');

-- Livros
INSERT INTO Livros (Titulo, AnoPublicacao, Preco, AutorID) VALUES
('Harry Potter e a Pedra Filosofal', 1997, 59.90, 1), 
('Harry Potter e a C�mara Secreta', 1998, 62.50, 1),
('A Game of Thrones', 1996, 70.00, 2), 
('Dom Casmurro', 1899, 29.99, 3),
('It', 1986, 45.00, 4),
('Assassinato no Expresso Oriente', 1934, 39.90, 5), 
('O Alquimista', 1988, 31.50, 6),
('O Senhor dos An�is', 1954, 85.00, 7), 
('O C�digo Da Vinci', 2003, 54.90, 8),
('A Hora da Estrela', 1977, 27.00, 9), 
('Deuses Americanos', 2001, 42.00, 10),
('A Casa dos Esp�ritos', 1982, 47.80, 11), 
('Kafka � Beira-Mar', 2002, 53.50, 12),
('P.S. I Love You', 2004, 37.00, 13), 
('Jogos Vorazes', 2008, 46.00, 14);

-- Vendas
INSERT INTO Vendas (LivroID, DataVenda, Quantidade) VALUES
(1, '2025-05-01', 3), 
(2, '2025-05-03', 2), 
(3, '2025-05-02', 1), 
(4, '2025-05-01', 4),
(5, '2025-05-04', 2), 
(6, '2025-05-04', 5), 
(7, '2025-05-05', 2), 
(8, '2025-05-06', 3),
(9, '2025-05-07', 2), 
(10, '2025-05-08', 3), 
(11, '2025-05-09', 1), 
(12, '2025-05-10', 4),
(13, '2025-05-11', 2), 
(14, '2025-05-11', 5), 
(15, '2025-05-12', 3);

-- M�dia (AVG)
SELECT AVG(Preco) AS MediaPreco FROM Livros;

-- Exemplo usando ROUND()
SELECT ROUND(AVG(Preco), 2) AS MediaPrecoFormatada FROM Livros;

-- Contagem (COUNT)
SELECT COUNT(*) AS TotalVendas FROM Vendas;

-- Soma (SUM)
SELECT SUM(Quantidade) AS TotalLivrosVendidos FROM Vendas;

-- Maior pre�o (MAX)
SELECT MAX(Preco) AS MaiorPreco FROM Livros;

-- Valores distintos (DISTINCT)
SELECT DISTINCT Nacionalidade FROM Autores;

-- LIKE (com o caractere de escape correto)
SELECT * FROM Livros WHERE Titulo LIKE 'O%';

-- BETWEEN (intervalo de datas correto)
SELECT * FROM Vendas WHERE DataVenda BETWEEN '2025-05-03' AND '2025-05-08';

-- EXISTS (verificando se o livro foi vendido)
SELECT Titulo 
FROM Livros l 
WHERE EXISTS (
    SELECT 1 
    FROM Vendas v 
    WHERE v.LivroID = l.LivroID
);

-- Subconsulta
SELECT Nome
FROM Autores
WHERE AutorID IN (
SELECT AutorID FROM Livros WHERE Preco > (SELECT AVG(Preco) FROM Livros)
);

-- Concat
SELECT CONCAT(L.titulo, ' - ', A.nome) as Livro_Author
FROM Livros L
JOIN Autores A ON L.AutorID = A.AutorID;

-- View 

-- Create
CREATE VIEW vw_VendasDetalhadas AS
SELECT V.VendaID, L.titulo, A.nome As Autor, V.DataVenda, V.Quantidade
FROM Vendas V
JOIN Livros L ON V.LivroID = L.LivroID
JOIN Autores A ON L.AutorID = A.AutorID

-- Alter

CREATE OR REPLACE VIEW vw_VendasDetalhadas AS
SELECT V.VendaID, L.titulo, A.nome As Autor, V.DataVenda, V.Quantidade
FROM Vendas V
JOIN Livros L ON V.LivroID = L.LivroID
JOIN Autores A ON L.AutorID = A.AutorID


-- Select

SELECT * FROM vw_VendasDetalhadas;



-- Delete

DROP VIEW vw_VendasDetalhadas;




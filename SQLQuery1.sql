CREATE DATABASE OBS;
GO
USE OBS;
GO

CREATE TABLE OgretimElemani(
ElemanID INT PRIMARY KEY IDENTITY(1,1),
    ElemanAdi VARCHAR(100) NOT NULL,
    DanismanMail VARCHAR(100)
);

CREATE TABLE ogrenci(
OgrNo INT PRIMARY KEY,
OgrAdi VARCHAR(30) NOT NULL,
   Bolum VARCHAR (50) NOT NULL,
    DANISMANID INT,
    FOREIGN KEY (DANISMANID) REFERENCES OgretimElemani (ElemanID)
    );
    

CREATE TABLE DERS(
DERSID INT PRIMARY KEY IDENTITY(1,1),
 DersKodu VARCHAR(10) NOT NULL,
    DersAdi VARCHAR(100) NOT NULL,
    Kredi INT
);

CREATE TABLE OgrenciDers (
    OgrNo INT,
    DersID INT,
    Notu VARCHAR(2),
    PRIMARY KEY (OgrNo, DersID),
    FOREIGN KEY (OgrNo) REFERENCES Ogrenci(OgrNo),
    FOREIGN KEY (DersID) REFERENCES Ders(DersID),
);

CREATE TABLE DersOgretimElemani (
    DersID INT,
    ElemanID INT,
    PRIMARY KEY (DersID, ElemanID),
    FOREIGN KEY (DersID) REFERENCES Ders(DersID),
    FOREIGN KEY (ElemanID) REFERENCES OgretimElemani(ElemanID),
);
INSERT INTO OgretimElemani (ElemanAdi, DanismanMail) VALUES
('Dr. Kaya', 'kaya@uni.edu.tr'),
('Dr. Demir', 'demir@uni.edu.tr'),
('Dr. Þahin', 'sahin@uni.edu.tr');

INSERT INTO Ders (DersKodu, DersAdi, Kredi) VALUES
('VTY101', 'Veritabaný Yönetimi', 3),
('IST102', 'Ýstatistik', 4),
('JAVA103', 'Java Programlama', 4);

INSERT INTO Ogrenci (OgrNo, OgrAdi, Bolum, DANISMANID) VALUES
(1001, 'Ayþe Yýlmaz', 'Yazýlým', 1),
(1002, 'Mehmet Demir', 'Yazýlým', 1),
(1003, 'Zeynep Kara', 'Bilgisayar', 2);

INSERT INTO OgrenciDers (OgrNo, DersID, Notu) VALUES
(1001, 1, 'AA'), (1001, 2, 'BA'), (1001, 3, 'BB'),
(1002, 1, 'BB'), (1003, 2, 'CB');

INSERT INTO DersOgretimElemani (DersID, ElemanID) VALUES
(1, 1), (1, 3), (2, 2), (3, 1);
SELECT* FROM ogrenci;
SELECT* FROM OgrenciDers;
UPDATE OgretimElemani SET DanismanMail = 'kaya.yeni@uni.edu.tr' WHERE ElemanID = 1;
UPDATE Ders SET Kredi = 4 WHERE DersKodu = 'VTY101';
UPDATE OgrenciDers SET Notu = 'AA' WHERE OgrNo = 1002 AND DersID = 1;
SELECT * FROM Ogrenci;
SELECT o.OgrAdi, d.DersAdi, od.Notu
FROM OgrenciDers od
JOIN Ogrenci o ON od.OgrNo = o.OgrNo
JOIN Ders   d ON od.DersID = d.DersID;
SELECT o.OgrAdi, SUM(d.Kredi) AS ToplamKredi
FROM OgrenciDers od
JOIN Ogrenci o ON od.OgrNo = o.OgrNo
JOIN Ders   d ON od.DersID = d.DersID
GROUP BY o.OgrAdi;
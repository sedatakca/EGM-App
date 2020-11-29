If Not Exists(Select * From sys.databases where name='EGM_Otomasyon')
Create Database EGM_Otomasyon
Go
Use EGM_Otomasyon

Go


If Not Exists(Select * From INFORMATION_SCHEMA.TABLES where TABLE_NAME='DaireBaskanliklari')
Create Table DaireBaskanliklari (
DaireId Int Identity Primary Key,
DaireName Nvarchar (100),
DaireAddress Nvarchar(250),
DaireTel Nvarchar(11),
DaireFax Nvarchar(10),
Constraint AN_DaireName Unique (DaireName)
)
Go



If Not Exists(Select * From INFORMATION_SCHEMA.TABLES where TABLE_NAME='Subeler')
Create Table Subeler(
SubeId Int Identity Primary Key,
DaireId Int,
SubeName Nvarchar (100),
SubeAddress Nvarchar(250),
SubeTel Nvarchar(11),
SubeFax Nvarchar(10),
Constraint AN_SubeName Unique (SubeName),
Constraint FK_Subeler_DaireId Foreign Key (DaireId)
	References DaireBaskanliklari (DaireId)

)
Go

If Not Exists(Select * From INFORMATION_SCHEMA.TABLES where TABLE_NAME='Burolar')
Create Table Burolar (
BuroId Int Identity Primary Key,
SubeId Int,
BuroName Nvarchar (100),
BuroAddress Nvarchar(250),
BuroTel Nvarchar(11),
BuroFax Nvarchar(10),

Constraint FK_Burolar_SubeId Foreign Key (SubeId)
	References Subeler (SubeId)
)
Go

If Not Exists(Select * From INFORMATION_SCHEMA.TABLES where TABLE_NAME='Rutbeler')
Create Table Rutbeler (
RutbeId Int Identity Primary Key,
RutbeName Nvarchar (100)

)
Go

If Not Exists(Select * From INFORMATION_SCHEMA.TABLES where TABLE_NAME='MemurTur')
Create Table MemurTur (
MemurTurId Int Identity Primary Key,
MemurTurName Nvarchar (100)
)
Go

If Not Exists(Select * From INFORMATION_SCHEMA.TABLES where TABLE_NAME='Memurlar')
Create Table Memurlar (
MemurTc Int Identity Primary Key,
BuroId Int,
RutbeId Int,
MemurTurId Int,
MemurName Nvarchar (100),
MemurAddress Nvarchar(250),
MemurTel Nvarchar(11),
MemurGorevB Datetime,
MemurGorevS Datetime,
MemurCinsiyet Nvarchar(20),

Constraint FK_Memurlar_BuroId Foreign Key (BuroId)
	References Burolar (BuroId),
Constraint FK_Memurlar_RutbeId Foreign Key (RutbeId)
	References Rutbeler (RutbeId),
Constraint FK_Memurlar_MemurTurId Foreign Key (MemurTurId)
	References MemurTur (MemurTurId)

)
--https://polisnoktasi.com/emniyet-genel-mudurlugu-rutbeler/

Go

If Not Exists(Select * From INFORMATION_SCHEMA.TABLES where TABLE_NAME='UserTypes')
Create table UserTypes
(
	UTypeId Int Identity Primary Key,
	TypeName Nvarchar(50) Unique
)
Go

If Not Exists(Select * From INFORMATION_SCHEMA.TABLES where TABLE_NAME='Users')
Create Table Users
(
	UTypeId Int,
	UserId Int Identity Primary Key,
	Password Nvarchar(50) Not Null,
	Constraint AN_Users_UserId Unique(UserId),
	Constraint FK_Users_UserId Foreign Key(UserId) 
	References Memurlar(MemurTc),
	Constraint FK_Users_UTypeId Foreign Key(UTypeId)
	 References UserTypes(UTypeId)

)
Go



If Not Exists(Select * From INFORMATION_SCHEMA.TABLES where TABLE_NAME='SucTur')
Create Table SucTur (
SucId Int Identity Primary Key,
SucTurName Nvarchar (100)
)
Go

If Not Exists(Select * From INFORMATION_SCHEMA.TABLES where TABLE_NAME='Kan')
Create Table Kan (
KanDna Int Identity Primary Key,
KanName Nvarchar (50)
)
Go

If Not Exists(Select * From INFORMATION_SCHEMA.TABLES where TABLE_NAME='Supheli')
Create Table Supheli (
SupheliTc Int Identity Primary Key,
SupheliName Nvarchar (100),
SupheliAddress Nvarchar(250),
SupheliTel Nvarchar(11),
SupheliTarihi Datetime,
SupheliYas Datetime,
SupheliCinsiyet bit,
KanDna Int,
Suclumu bit


Constraint FK_Supheli_KanDna Foreign Key (KanDna)
	References Kan (KanDna)

)
Go

If Not Exists(Select * From INFORMATION_SCHEMA.TABLES where TABLE_NAME='IfadeTur')
Create Table IfadeTur (
IfadeTurId Int Identity Primary Key,
IfadeTurName Nvarchar (100)
)
Go

If Not Exists(Select * From INFORMATION_SCHEMA.TABLES where TABLE_NAME='IfadesiAlinan')
Create Table IfadesiAlinan (
IfadesiAlinanId Int Identity Primary Key,
IfadesiAlinanName Nvarchar (100),
IfadesiAlinanAddress Nvarchar(250),
IfadesiAlinanTel Nvarchar(11),
IfadesiAlinanYas Datetime,
IfadesiAlinanCinsiyet bit ,
)
Go

If Not Exists(Select * From INFORMATION_SCHEMA.TABLES where TABLE_NAME='IfadeDetaylari')
Create Table IfadeDetaylari (
IfadeId Int Identity Primary Key,
IfadesiAlinanId Int,
SucId Int,
IfadeTurId Int,
BuroId Int,
IfadesiAlinanTarihi Datetime,
IfadeAciklamasi Nvarchar (250),

Constraint FK_IfadesiAlinan_SucId Foreign Key (SucId)
	References SucTur (SucId),
Constraint FK_IfadesiAlinan_IfadeTurId Foreign Key (IfadeTurId)
	References IfadeTur (IfadeTurId),
Constraint FK_IfadeDetaylari_IfadesiAlinanId Foreign Key (IfadesiAlinanId)
	References IfadesiAlinan (IfadesiAlinanId),
Constraint FK_IfadeDetaylari_BuroId Foreign Key (BuroId)
	References Burolar (BuroId)
)
Go

If Not Exists(Select * From INFORMATION_SCHEMA.TABLES where TABLE_NAME='Sorgulanan')
Create Table Sorgulanan (
SorgulananId Int Identity Primary Key,
SubeId Int,
SupheliTc Int,
MemurTc Int,
SucId Int,

Constraint FK_Sorgulanan_SupheliTc Foreign Key (SupheliTc)
	References Supheli (SupheliTc),
Constraint FK_Sorgulanan_MemurTc Foreign Key (MemurTc)
	References Memurlar (MemurTc),
Constraint FK_Sorgulanan_SubeId Foreign Key (SubeId)
	References Subeler (SubeId),
Constraint FK_Sorgulanan_SucId Foreign Key (SucId)
	References SucTur (SucId),

)
Go

If Not Exists(Select * From INFORMATION_SCHEMA.TABLES where TABLE_NAME='SorguDetaylari')
Create Table SorguDetaylari (
SorguId Int Identity Primary Key,
SorgulananId Int,
SorguMemurDetayý Nvarchar(300),
Constraint FK_SorguDetaylari_SorgulananId Foreign Key (SorgulananId)
	References Sorgulanan (SorgulananId)
)
Go

If Not Exists(Select * From INFORMATION_SCHEMA.TABLES where TABLE_NAME='Nezarethaneler')
Create Table Nezarethaneler (
NezarethaneId Int Identity Primary Key,
NezarethaneName Nvarchar(60),
SubeId Int,

Constraint FK_Nezarethaneler_SubeId Foreign Key (SubeId)
	References Subeler (SubeId),
)
Go



If Not Exists(Select * From INFORMATION_SCHEMA.TABLES where TABLE_NAME='NezarethaneGirisi')
Create Table NezarethaneGirisi (
GirisId Int Identity Primary Key,
NezarethaneId Int,
SupheliTc Int,
NezarethaneGiris Datetime,

Constraint FK_NezarethaneGirisi_SupheliTc Foreign Key (SupheliTc)
	References Supheli (SupheliTc),
Constraint FK_NezarethaneGirisi_NezarethaneId Foreign Key (NezarethaneId)
	References Nezarethaneler (NezarethaneId)
)
Go

If Not Exists(Select * From INFORMATION_SCHEMA.TABLES where TABLE_NAME='OlayYeri')
Create Table OlayYeri(
OlayId Int Identity Primary Key,
MemurTc Int,
SubeId Int,
OlayName Nvarchar(100),
OlayTarih Datetime,
OlayAddress Nvarchar(250),


Constraint FK_OlayYeri_MemurTc Foreign Key (MemurTc)
	References Memurlar (MemurTc),
Constraint FK_OlayYeri_SubeId Foreign Key (SubeId)
	References Subeler (SubeId)

)
Go

If Not Exists(Select * From INFORMATION_SCHEMA.TABLES where TABLE_NAME='OtopsiyeGiden')
Create Table OtopsiyeGiden (
GidenId Int Identity Primary Key,
OlayId Int,
GidenName Nvarchar(50),
GidenParmakizi Nvarchar (20),
KanDna Int,
GidenYas Datetime,
GidenCinsiyet bit,
GidenAciklama Nvarchar(250),

Constraint FK_OtopsiyeGiden_KanDna Foreign Key (KanDna)
	References Kan (KanDna),
Constraint FK_OtopsiyeGiden_OlayId Foreign Key (OlayId)
	References OlayYeri (OlayId)

)

Go

If Not Exists(Select * From INFORMATION_SCHEMA.TABLES where TABLE_NAME='Otopsi')
Create Table Otopsi (
OtopsiId Int Identity Primary Key,
SupheliTc Int,
GidenId Int,
OtopsiName Nvarchar(50),
OtopsiAciklama Nvarchar(250),
OtopsiSonuc bit,


Constraint FK_Otopsi_SupheliTc Foreign Key (SupheliTc)
	References Supheli (SupheliTc),
Constraint FK_Otopsi_GidenId Foreign Key (GidenId)
	References OtopsiyeGiden (GidenId)


)
Go


If Not Exists(Select * From INFORMATION_SCHEMA.TABLES where TABLE_NAME='Depolar')
Create Table Depolar (
DepoId Int Identity Primary Key,
SubeId Int,
DepoName Nvarchar(50),
DepoAddres Nvarchar(50),

Constraint FK_Depolar_SubeId Foreign Key (SubeId)
	References Subeler (SubeId)
)
Go

If Not Exists(Select * From INFORMATION_SCHEMA.TABLES where TABLE_NAME='Urunler')
Create Table Urunler (
UrunId Int Identity Primary Key,
DepoId Int,
UrunName Nvarchar(50),
UrunTur Nvarchar(50),
UrunAdKg Nvarchar(50),
UrunTarih Datetime,
UrunAddress Nvarchar(100),

Constraint FK_Urunler_DepoId Foreign Key (DepoId)
	References Depolar (DepoId)
)
Go

If Not Exists(Select * From INFORMATION_SCHEMA.TABLES where TABLE_NAME='GorevTur')
Create Table GorevTur (
GorevTurId Int Identity Primary Key,
GorevTurName Nvarchar(50),
)
Go


If Not Exists(Select * From INFORMATION_SCHEMA.TABLES where TABLE_NAME='GörevDetaylarý')
Create Table GorevDetaylari (
GorevId Int Identity Primary Key,
GorevTurId Int,
MemurTc Int,
GorevName Nvarchar(50),
GorevTarihi Datetime,
GorevAddres Nvarchar(50),

Constraint FK_GorevDetaylari_GorevTurId Foreign Key (GorevTurId)
	References GorevTur (GorevTurId),
Constraint FK_GorevDetaylari_MemurTc Foreign Key (MemurTc)
	References Memurlar (MemurTc)
)

Go
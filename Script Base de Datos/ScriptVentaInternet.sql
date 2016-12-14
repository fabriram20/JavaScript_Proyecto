/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     13/12/2016 23:59:11                          */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DETALLES_ORDEN') and o.name = 'FK_DETALLES_CONTENER_ORDEN')
alter table DETALLES_ORDEN
   drop constraint FK_DETALLES_CONTENER_ORDEN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DETALLES_ORDEN') and o.name = 'FK_DETALLES_GENERAR_PRODUCTO')
alter table DETALLES_ORDEN
   drop constraint FK_DETALLES_GENERAR_PRODUCTO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ORDEN') and o.name = 'FK_ORDEN_REALIZAR_CLIENTE')
alter table ORDEN
   drop constraint FK_ORDEN_REALIZAR_CLIENTE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PRODUCTO') and o.name = 'FK_PRODUCTO_TENER_MARCA')
alter table PRODUCTO
   drop constraint FK_PRODUCTO_TENER_MARCA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CLIENTE')
            and   type = 'U')
   drop table CLIENTE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DETALLES_ORDEN')
            and   name  = 'CONTENER_FK'
            and   indid > 0
            and   indid < 255)
   drop index DETALLES_ORDEN.CONTENER_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DETALLES_ORDEN')
            and   name  = 'GENERAR_FK'
            and   indid > 0
            and   indid < 255)
   drop index DETALLES_ORDEN.GENERAR_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DETALLES_ORDEN')
            and   type = 'U')
   drop table DETALLES_ORDEN
go

if exists (select 1
            from  sysobjects
           where  id = object_id('MARCA')
            and   type = 'U')
   drop table MARCA
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ORDEN')
            and   name  = 'REALIZAR_FK'
            and   indid > 0
            and   indid < 255)
   drop index ORDEN.REALIZAR_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ORDEN')
            and   type = 'U')
   drop table ORDEN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PRODUCTO')
            and   name  = 'TENER_FK'
            and   indid > 0
            and   indid < 255)
   drop index PRODUCTO.TENER_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PRODUCTO')
            and   type = 'U')
   drop table PRODUCTO
go

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE (
   ID_CLIENTE           int                  not null,
   NOMBRE_CLIENTE       varchar(60)          not null,
   APELLIDO_CLIENTE     varchar(60)          not null,
   TELEFONO             varchar(60)          not null,
   DIRECCION            varchar(60)          not null,
   CIUDAD               varchar(20)          not null,
   PROVINCIA            varchar(20)          not null,
   PAIS                 varchar(20)          not null,
   constraint PK_CLIENTE primary key (ID_CLIENTE)
)
go

/*==============================================================*/
/* Table: DETALLES_ORDEN                                        */
/*==============================================================*/
create table DETALLES_ORDEN (
   ID_PRODUCTO          int                  not null,
   ID_ORDEN             int                  not null,
   CANTIDAD             int                  not null
)
go

/*==============================================================*/
/* Index: GENERAR_FK                                            */
/*==============================================================*/
create index GENERAR_FK on DETALLES_ORDEN (
ID_PRODUCTO ASC
)
go

/*==============================================================*/
/* Index: CONTENER_FK                                           */
/*==============================================================*/
create index CONTENER_FK on DETALLES_ORDEN (
ID_ORDEN ASC
)
go

/*==============================================================*/
/* Table: MARCA                                                 */
/*==============================================================*/
create table MARCA (
   ID_MARCA             int                  not null,
   DESCRIPCION          varchar(1024)        null,
   IMAGEN               image                null,
   constraint PK_MARCA primary key (ID_MARCA)
)
go

/*==============================================================*/
/* Table: ORDEN                                                 */
/*==============================================================*/
create table ORDEN (
   ID_ORDEN             int                  not null,
   ID_CLIENTE           int                  not null,
   FECHA_ORDEN          datetime             not null,
   FECHA_SOLICITUD      datetime             not null,
   FECHA_ENVIO          datetime             not null,
   constraint PK_ORDEN primary key (ID_ORDEN)
)
go

/*==============================================================*/
/* Index: REALIZAR_FK                                           */
/*==============================================================*/
create index REALIZAR_FK on ORDEN (
ID_CLIENTE ASC
)
go

/*==============================================================*/
/* Table: PRODUCTO                                              */
/*==============================================================*/
create table PRODUCTO (
   ID_PRODUCTO          int                  not null,
   ID_MARCA             int                  not null,
   NOMBRE_PRODUCTO      varchar(1024)        not null,
   TALLA                float                not null,
   DESCRIPCION          varchar(1024)        not null,
   STOCK                int                  not null,
   PRECIO               float                not null,
   CATEGORIA            varchar(1024)        not null,
   constraint PK_PRODUCTO primary key (ID_PRODUCTO)
)
go

/*==============================================================*/
/* Index: TENER_FK                                              */
/*==============================================================*/
create index TENER_FK on PRODUCTO (
ID_MARCA ASC
)
go

alter table DETALLES_ORDEN
   add constraint FK_DETALLES_CONTENER_ORDEN foreign key (ID_ORDEN)
      references ORDEN (ID_ORDEN)
go

alter table DETALLES_ORDEN
   add constraint FK_DETALLES_GENERAR_PRODUCTO foreign key (ID_PRODUCTO)
      references PRODUCTO (ID_PRODUCTO)
go

alter table ORDEN
   add constraint FK_ORDEN_REALIZAR_CLIENTE foreign key (ID_CLIENTE)
      references CLIENTE (ID_CLIENTE)
go

alter table PRODUCTO
   add constraint FK_PRODUCTO_TENER_MARCA foreign key (ID_MARCA)
      references MARCA (ID_MARCA)
go


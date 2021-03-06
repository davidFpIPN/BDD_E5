	/* DICCIONARIO DE FRAGMENTACI�N */
-- se debe almacenar en cada fragmento o en cada servidor
USE America;
USE RMundo;
USE PersonInfo;

drop table diccionario_dist
drop table val_col_frag
CREATE TABLE diccionario_dist (
  id_fragmento	tinyint primary key, -- identificador del fragmento
  servidor		varchar(100), -- nombre del servidor vinculado
  bd			varchar(100), -- nombre de la base que aloja al fragmento
)

CREATE TABLE val_col_frag (
  id_fragmento tinyint,
  val_col varchar(100),
  primary key (id_fragmento, val_col),
  foreign KEY (id_fragmento) REFERENCES diccionario_dist (id_fragmento)
)

delete diccionario_dist
delete val_col_frag
/* Fragmentos de la BDD */
insert into diccionario_dist values (1,'LSERVER','America');  -- Instancia 1 SQL Server para America
insert into diccionario_dist values (2,'LSERVER1','RMundo'); -- Instancia 2 SQL Server para RMundo
insert into diccionario_dist values (3,'LSERVER1','PersonInfo'); -- Instancia 3 SQL Server para PersonInfo


insert into val_col_frag values (1,'1');
insert into val_col_frag values (1,'2');
insert into val_col_frag values (1,'3');
insert into val_col_frag values (1,'4');
insert into val_col_frag values (1,'5');
insert into val_col_frag values (1,'6');

/*AQUI SERIA LA QUE NO ESTA FRAGMENTADA, SERIAN TODOS LOS TERRITORIOS ID O NINGUNO?*/
insert into val_col_frag values (2,'7');
insert into val_col_frag values (2,'8');
insert into val_col_frag values (2,'9');
insert into val_col_frag values (2,'10');

select * from diccionario_dist;
select * from val_col_frag;


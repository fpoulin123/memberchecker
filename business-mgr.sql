CREATE SEQUENCE IF NOT EXISTS public.customer_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    
CREATE SEQUENCE IF NOT EXISTS public.subscription_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;
    
CREATE TABLE IF NOT EXISTS public.customer
(
    id bigint NOT NULL DEFAULT nextval('customer_id_seq'::regclass),
    firstname character varying(255) COLLATE pg_catalog."default" NOT NULL,
    lastname character varying(255) COLLATE pg_catalog."default" NOT NULL,
    address character varying(255) COLLATE pg_catalog."default" NOT NULL,
    city character varying(255) COLLATE pg_catalog."default" NOT NULL,
    phonenumber character varying(20) COLLATE pg_catalog."default",
    picture character varying(255) COLLATE pg_catalog."default",
    barcodevalue character varying(50) COLLATE pg_catalog."default",
    email character varying(100) COLLATE pg_catalog."default",
    CONSTRAINT customer_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.customer
    OWNER to postgres; 
    
CREATE TABLE IF NOT EXISTS public.subscription
(
    id bigint NOT NULL DEFAULT nextval('subscription_id_seq'::regclass),
    customer_id bigint NOT NULL,
    duration integer NOT NULL,
    taekwondo boolean,
    kickboxing boolean,
    taekibodo boolean,
    amount double precision,
    subscription_date date,
    CONSTRAINT subscription_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.subscription
    OWNER to postgres;

ALTER SEQUENCE public.subscription_id_seq
    OWNED BY public.subscription.id;

ALTER SEQUENCE public.subscription_id_seq
    OWNER TO postgres;

ALTER SEQUENCE public.customer_id_seq
    OWNED BY public.customer.id;

ALTER SEQUENCE public.customer_id_seq
    OWNER TO postgres;

CREATE OR REPLACE FUNCTION public.isvalidsubscription(
	subscriptiondate date,
	duration integer)
    RETURNS boolean
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$

DECLARE expirationdate date;
BEGIN
	expirationdate = subscriptiondate + duration;

	RETURN expirationdate > now();

END;
$BODY$;

ALTER FUNCTION public.isvalidsubscription(date, integer)
    OWNER TO postgres;
    
CREATE OR REPLACE VIEW public.valid_subscription_view
 AS
 SELECT s.id,
    s.customer_id,
    s.duration,
    s.taekwondo,
    s.kickboxing,
    s.taekibodo,
    s.amount,
    s.subscription_date
   FROM subscription s
  WHERE isvalidsubscription(s.subscription_date, s.duration) IS TRUE;

ALTER TABLE public.valid_subscription_view
    OWNER TO postgres;

CREATE SEQUENCE IF NOT EXISTS public.alldata_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

CREATE TABLE IF NOT EXISTS public.alldata
(
    id bigint NOT NULL DEFAULT nextval('alldata_id_seq'::regclass),
    firstname character varying(255) COLLATE pg_catalog."default" NOT NULL,
    lastname character varying(255) COLLATE pg_catalog."default" NOT NULL,
    address character varying(255) COLLATE pg_catalog."default" NOT NULL,
    city character varying(255) COLLATE pg_catalog."default" NOT NULL,
    phonenumber character varying(50) COLLATE pg_catalog."default",
    course character varying(255),
	inscriptionDate date,
	duration integer,
	amount double precision,
	account1 double precision,
	solde1 double precision, 
	account2 double precision, 
	solde2 double precision, 
	account3 double precision, 
	solde3 double precision,
	soldItems character varying(255),
	email character varying(100) COLLATE pg_catalog."default",
    CONSTRAINT alldata_pkey PRIMARY KEY (id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.alldata
    OWNER to postgres; 

ALTER SEQUENCE public.alldata_id_seq
    OWNED BY public.alldata.id;

ALTER SEQUENCE public.alldata_id_seq
    OWNER TO postgres;
-- Constraint: partic_pkey

-- ALTER TABLE public.partic DROP CONSTRAINT partic_pkey;

ALTER TABLE public.partic
    ADD CONSTRAINT partic_pkey PRIMARY KEY (partic_id);

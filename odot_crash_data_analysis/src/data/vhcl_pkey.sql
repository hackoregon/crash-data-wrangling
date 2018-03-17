-- Constraint: vhcl_pkey

-- ALTER TABLE public.vhcl DROP CONSTRAINT vhcl_pkey;

ALTER TABLE public.vhcl
    ADD CONSTRAINT vhcl_pkey PRIMARY KEY (vhcl_id);

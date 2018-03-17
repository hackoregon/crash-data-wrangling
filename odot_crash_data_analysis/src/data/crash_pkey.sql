-- Constraint: crash_pkey

-- ALTER TABLE public.crash DROP CONSTRAINT crash_pkey;

ALTER TABLE public.crash
    ADD CONSTRAINT crash_pkey PRIMARY KEY (crash_id);

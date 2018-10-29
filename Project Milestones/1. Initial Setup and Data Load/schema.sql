--
-- PostgreSQL database dump
--

-- Dumped from database version 10.4
-- Dumped by pg_dump version 10.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: guest; Type: TABLE; Schema: public; Owner: masterusername
--

CREATE TABLE public.guest (
    guestid integer NOT NULL,
    firstname character varying(80),
    lastname character varying(80),
    address character varying(80),
    city character varying(80),
    zipcode integer
);


ALTER TABLE public.guest OWNER TO masterusername;

--
-- Name: hotel; Type: TABLE; Schema: public; Owner: masterusername
--

CREATE TABLE public.hotel (
    hotelid integer NOT NULL,
    hotelname character varying(80),
    address character varying(80),
    city character varying(80),
    zipcode integer
);


ALTER TABLE public.hotel OWNER TO masterusername;

--
-- Name: reservation; Type: TABLE; Schema: public; Owner: masterusername
--

CREATE TABLE public.reservation (
    reservationid integer NOT NULL,
    roomid integer,
    guestid integer,
    checkindate date,
    numberofdays integer
);


ALTER TABLE public.reservation OWNER TO masterusername;

--
-- Name: room; Type: TABLE; Schema: public; Owner: masterusername
--

CREATE TABLE public.room (
    roomid integer NOT NULL,
    roomnumber integer,
    hotelid integer,
    roomtype character varying(30) DEFAULT 'Classic'::character varying
);


ALTER TABLE public.room OWNER TO masterusername;

--
-- Name: guest guest_pkey; Type: CONSTRAINT; Schema: public; Owner: masterusername
--

ALTER TABLE ONLY public.guest
    ADD CONSTRAINT guest_pkey PRIMARY KEY (guestid);


--
-- Name: hotel hotel_pkey; Type: CONSTRAINT; Schema: public; Owner: masterusername
--

ALTER TABLE ONLY public.hotel
    ADD CONSTRAINT hotel_pkey PRIMARY KEY (hotelid);


--
-- Name: reservation reservation_pkey; Type: CONSTRAINT; Schema: public; Owner: masterusername
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_pkey PRIMARY KEY (reservationid);


--
-- Name: room room_pkey; Type: CONSTRAINT; Schema: public; Owner: masterusername
--

ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_pkey PRIMARY KEY (roomid);


--
-- Name: reservation reservation_guestid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: masterusername
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_guestid_fkey FOREIGN KEY (guestid) REFERENCES public.guest(guestid);


--
-- Name: reservation reservation_roomid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: masterusername
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_roomid_fkey FOREIGN KEY (roomid) REFERENCES public.room(roomid);


--
-- Name: room room_hotelid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: masterusername
--

ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_hotelid_fkey FOREIGN KEY (hotelid) REFERENCES public.hotel(hotelid);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: masterusername
--

REVOKE ALL ON SCHEMA public FROM rdsadmin;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO masterusername;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--


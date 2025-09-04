--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5 (Debian 17.5-1.pgdg120+1)
-- Dumped by pg_dump version 17.5 (Debian 17.5-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: enum_deal_access_invites_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_deal_access_invites_status AS ENUM (
    'Pending',
    'Accepted',
    'Rejected',
    'Withdrawn'
);


ALTER TYPE public.enum_deal_access_invites_status OWNER TO postgres;

--
-- Name: enum_deal_milestone_statuses_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_deal_milestone_statuses_status AS ENUM (
    'Pending',
    'Completed'
);


ALTER TYPE public.enum_deal_milestone_statuses_status OWNER TO postgres;

--
-- Name: enum_deal_type_preferences_deal_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_deal_type_preferences_deal_type AS ENUM (
    'Equity',
    'Debt',
    'Equity and Debt'
);


ALTER TYPE public.enum_deal_type_preferences_deal_type OWNER TO postgres;

--
-- Name: enum_deals_deal_stage; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_deals_deal_stage AS ENUM (
    'Due Diligence',
    'Term Sheet',
    'Closed'
);


ALTER TYPE public.enum_deals_deal_stage OWNER TO postgres;

--
-- Name: enum_deals_deal_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_deals_deal_type AS ENUM (
    'Equity',
    'Debt',
    'Equity and Debt'
);


ALTER TYPE public.enum_deals_deal_type OWNER TO postgres;

--
-- Name: enum_deals_has_information_memorandum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_deals_has_information_memorandum AS ENUM (
    'Yes',
    'No'
);


ALTER TYPE public.enum_deals_has_information_memorandum OWNER TO postgres;

--
-- Name: enum_deals_has_vdr; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_deals_has_vdr AS ENUM (
    'Yes',
    'No'
);


ALTER TYPE public.enum_deals_has_vdr OWNER TO postgres;

--
-- Name: enum_deals_maximum_selling_stake; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_deals_maximum_selling_stake AS ENUM (
    'Minority',
    'Majority',
    'Open',
    'Full'
);


ALTER TYPE public.enum_deals_maximum_selling_stake OWNER TO postgres;

--
-- Name: enum_deals_model; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_deals_model AS ENUM (
    'Yes',
    'No'
);


ALTER TYPE public.enum_deals_model OWNER TO postgres;

--
-- Name: enum_deals_region; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_deals_region AS ENUM (
    'North America',
    'Africa',
    'Europe',
    'Asia',
    'South America',
    'Australia',
    'Antarctica'
);


ALTER TYPE public.enum_deals_region OWNER TO postgres;

--
-- Name: enum_deals_sector; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_deals_sector AS ENUM (
    'Tech',
    'Finance',
    'Healthcare',
    'Energy',
    'Consumer Goods',
    'Industrial',
    'Real Estate',
    'Telecommunications',
    'Utilities',
    'Materials',
    'Agriculture',
    'Aviation',
    'FMCG',
    'Hospitality',
    'Leasing',
    'Water & Sanitation',
    'Technology',
    'Services',
    'Manufacturing',
    'Construction',
    'Education',
    'Financial Services',
    'Bar and Restaurant',
    'Housing',
    'Retail'
);


ALTER TYPE public.enum_deals_sector OWNER TO postgres;

--
-- Name: enum_deals_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_deals_status AS ENUM (
    'Active',
    'Pending',
    'Open',
    'On Hold',
    'Inactive',
    'Closed',
    'Closed & Reopened',
    'Archived'
);


ALTER TYPE public.enum_deals_status OWNER TO postgres;

--
-- Name: enum_deals_teaser; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_deals_teaser AS ENUM (
    'Yes',
    'No'
);


ALTER TYPE public.enum_deals_teaser OWNER TO postgres;

--
-- Name: enum_deals_visibility; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_deals_visibility AS ENUM (
    'Public',
    'Private'
);


ALTER TYPE public.enum_deals_visibility OWNER TO postgres;

--
-- Name: enum_document_share_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_document_share_status AS ENUM (
    'Pending',
    'Accepted',
    'Rejected'
);


ALTER TYPE public.enum_document_share_status OWNER TO postgres;

--
-- Name: enum_document_shares_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_document_shares_status AS ENUM (
    'Pending',
    'Accepted',
    'Rejected'
);


ALTER TYPE public.enum_document_shares_status OWNER TO postgres;

--
-- Name: enum_documents_file_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_documents_file_type AS ENUM (
    'pdf',
    'docx',
    'xlsx'
);


ALTER TYPE public.enum_documents_file_type OWNER TO postgres;

--
-- Name: enum_folder_access_invites_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_folder_access_invites_status AS ENUM (
    'Pending',
    'Accepted',
    'Rejected'
);


ALTER TYPE public.enum_folder_access_invites_status OWNER TO postgres;

--
-- Name: enum_investor_milestone_statuses_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_investor_milestone_statuses_status AS ENUM (
    'Pending',
    'Completed'
);


ALTER TYPE public.enum_investor_milestone_statuses_status OWNER TO postgres;

--
-- Name: enum_invoices_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_invoices_status AS ENUM (
    'Pending',
    'Paid'
);


ALTER TYPE public.enum_invoices_status OWNER TO postgres;

--
-- Name: enum_milestones_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_milestones_status AS ENUM (
    'Pending',
    'Completed'
);


ALTER TYPE public.enum_milestones_status OWNER TO postgres;

--
-- Name: enum_primary_location_preferences_continent; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_primary_location_preferences_continent AS ENUM (
    'North America',
    'Africa',
    'Europe',
    'Asia',
    'South America',
    'Australia',
    'Antarctica'
);


ALTER TYPE public.enum_primary_location_preferences_continent OWNER TO postgres;

--
-- Name: enum_primary_location_preferences_region; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_primary_location_preferences_region AS ENUM (
    'Northern Africa',
    'Sub-Saharan Africa',
    'Western Africa',
    'Eastern Africa',
    'Central Africa',
    'Southern Africa',
    'East Asia',
    'Southeast Asia',
    'South Asia',
    'Central Asia',
    'Western Asia (Middle East)',
    'Northern Europe',
    'Southern Europe',
    'Eastern Europe',
    'Western Europe',
    'North America',
    'Central America',
    'Caribbean',
    'South America',
    'Australasia',
    'Melanesia',
    'Micronesia',
    'Polynesia',
    'Antarctica'
);


ALTER TYPE public.enum_primary_location_preferences_region OWNER TO postgres;

--
-- Name: enum_subfolder_access_invites_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_subfolder_access_invites_status AS ENUM (
    'Pending',
    'Accepted',
    'Rejected'
);


ALTER TYPE public.enum_subfolder_access_invites_status OWNER TO postgres;

--
-- Name: enum_tasks_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_tasks_status AS ENUM (
    'Pending',
    'In Progress',
    'Completed'
);


ALTER TYPE public.enum_tasks_status OWNER TO postgres;

--
-- Name: enum_transactions_payment_method; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_transactions_payment_method AS ENUM (
    'Credit Card',
    'Bank Transfer',
    'Mobile Money'
);


ALTER TYPE public.enum_transactions_payment_method OWNER TO postgres;

--
-- Name: enum_transactions_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_transactions_status AS ENUM (
    'Pending',
    'Completed',
    'Failed'
);


ALTER TYPE public.enum_transactions_status OWNER TO postgres;

--
-- Name: enum_transactions_transaction_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_transactions_transaction_type AS ENUM (
    'Commission',
    'Milestone Payment',
    'Subscription Fee'
);


ALTER TYPE public.enum_transactions_transaction_type OWNER TO postgres;

--
-- Name: enum_user_reviews_relationship; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_user_reviews_relationship AS ENUM (
    'I contacted them',
    'I previously worked with them',
    'I received a term sheet',
    'I heard about them anecdotally',
    'They invested in my company',
    'He/She is a personal friend',
    'I got into diliogence with them',
    'I pitched them'
);


ALTER TYPE public.enum_user_reviews_relationship OWNER TO postgres;

--
-- Name: enum_users_kyc_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_users_kyc_status AS ENUM (
    'Pending',
    'Verified',
    'Rejected'
);


ALTER TYPE public.enum_users_kyc_status OWNER TO postgres;

--
-- Name: enum_users_role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_users_role AS ENUM (
    'Investor',
    'Administrator',
    'Target Company'
);


ALTER TYPE public.enum_users_role OWNER TO postgres;

--
-- Name: enum_users_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_users_status AS ENUM (
    'On Hold',
    'Open',
    'Closed',
    'Archived'
);


ALTER TYPE public.enum_users_status OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: SequelizeMeta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."SequelizeMeta" (
    name character varying(255) NOT NULL
);


ALTER TABLE public."SequelizeMeta" OWNER TO postgres;

--
-- Name: audit_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.audit_logs (
    log_id uuid NOT NULL,
    user_id integer NOT NULL,
    action character varying(255) NOT NULL,
    ip_address character varying(255) NOT NULL,
    geo_location character varying(255),
    details text,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.audit_logs OWNER TO postgres;

--
-- Name: contact_people; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contact_people (
    contact_id uuid NOT NULL,
    user_id integer NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(255),
    "position" character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.contact_people OWNER TO postgres;

--
-- Name: contact_persons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.contact_persons (
    contact_id uuid NOT NULL,
    user_id integer NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(255),
    "position" character varying(255),
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.contact_persons OWNER TO postgres;

--
-- Name: continent_preferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.continent_preferences (
    preference_id uuid NOT NULL,
    user_id integer NOT NULL,
    continent_id uuid NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.continent_preferences OWNER TO postgres;

--
-- Name: continents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.continents (
    continent_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.continents OWNER TO postgres;

--
-- Name: countries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.countries (
    country_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    code character varying(255) NOT NULL,
    continent_id uuid,
    region_id uuid,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.countries OWNER TO postgres;

--
-- Name: country_preferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.country_preferences (
    preference_id uuid NOT NULL,
    user_id integer NOT NULL,
    country_id uuid NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.country_preferences OWNER TO postgres;

--
-- Name: deal_access_invites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deal_access_invites (
    invite_id uuid NOT NULL,
    investor_id integer NOT NULL,
    deal_id uuid NOT NULL,
    status public.enum_deal_access_invites_status DEFAULT 'Pending'::public.enum_deal_access_invites_status,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    withdraw_reason text
);


ALTER TABLE public.deal_access_invites OWNER TO postgres;

--
-- Name: deal_continents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deal_continents (
    id uuid NOT NULL,
    deal_id uuid NOT NULL,
    continent_id uuid NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.deal_continents OWNER TO postgres;

--
-- Name: deal_countries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deal_countries (
    id uuid NOT NULL,
    deal_id uuid NOT NULL,
    country_id uuid NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.deal_countries OWNER TO postgres;

--
-- Name: deal_leads; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deal_leads (
    id uuid NOT NULL,
    deal_id uuid NOT NULL,
    user_id integer NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.deal_leads OWNER TO postgres;

--
-- Name: deal_meetings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deal_meetings (
    meeting_id uuid NOT NULL,
    deal_id uuid NOT NULL,
    subject character varying(255) NOT NULL,
    start timestamp with time zone NOT NULL,
    "end" timestamp with time zone NOT NULL,
    attendees json NOT NULL,
    meeting_link character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.deal_meetings OWNER TO postgres;

--
-- Name: deal_milestone_statuses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deal_milestone_statuses (
    id uuid NOT NULL,
    deal_milestone_id uuid NOT NULL,
    deal_id uuid NOT NULL,
    status public.enum_deal_milestone_statuses_status DEFAULT 'Pending'::public.enum_deal_milestone_statuses_status,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.deal_milestone_statuses OWNER TO postgres;

--
-- Name: deal_milestones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deal_milestones (
    milestone_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.deal_milestones OWNER TO postgres;

--
-- Name: deal_regions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deal_regions (
    id uuid NOT NULL,
    deal_id uuid NOT NULL,
    region_id uuid NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.deal_regions OWNER TO postgres;

--
-- Name: deal_stages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deal_stages (
    stage_id uuid NOT NULL,
    user_id integer NOT NULL,
    name character varying(255) NOT NULL,
    "order" integer NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.deal_stages OWNER TO postgres;

--
-- Name: deal_type_preferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deal_type_preferences (
    preference_id uuid NOT NULL,
    user_id integer NOT NULL,
    deal_type public.enum_deal_type_preferences_deal_type NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.deal_type_preferences OWNER TO postgres;

--
-- Name: deals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deals (
    deal_id uuid NOT NULL,
    title character varying(255) NOT NULL,
    project character varying(255),
    description text NOT NULL,
    image_url character varying(255),
    deal_stage_id uuid,
    status public.enum_deals_status DEFAULT 'Open'::public.enum_deals_status NOT NULL,
    ticket_size integer,
    deal_size numeric NOT NULL,
    sector_id uuid,
    subsector_id uuid,
    target_company_id integer NOT NULL,
    key_investors text,
    created_by integer NOT NULL,
    visibility public.enum_deals_visibility DEFAULT 'Public'::public.enum_deals_visibility,
    deal_type public.enum_deals_deal_type,
    maximum_selling_stake public.enum_deals_maximum_selling_stake,
    teaser public.enum_deals_teaser DEFAULT 'Yes'::public.enum_deals_teaser NOT NULL,
    model public.enum_deals_model DEFAULT 'No'::public.enum_deals_model,
    has_information_memorandum public.enum_deals_has_information_memorandum,
    has_vdr public.enum_deals_has_vdr,
    consultant_name character varying(255),
    retainer_amount numeric,
    success_fee_percentage numeric,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    deal_lead integer
);


ALTER TABLE public.deals OWNER TO postgres;

--
-- Name: document_share; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.document_share (
    share_id uuid NOT NULL,
    document_id uuid NOT NULL,
    user_email character varying(255) NOT NULL,
    status public.enum_document_share_status DEFAULT 'Pending'::public.enum_document_share_status,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.document_share OWNER TO postgres;

--
-- Name: document_shares; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.document_shares (
    share_id uuid NOT NULL,
    document_id uuid NOT NULL,
    user_email character varying(255) NOT NULL,
    status public.enum_document_shares_status DEFAULT 'Pending'::public.enum_document_shares_status,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    shared_by integer
);


ALTER TABLE public.document_shares OWNER TO postgres;

--
-- Name: document_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.document_types (
    type_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.document_types OWNER TO postgres;

--
-- Name: documents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.documents (
    document_id uuid NOT NULL,
    deal_id uuid NOT NULL,
    uploaded_by integer NOT NULL,
    file_name character varying(255) NOT NULL,
    file_path character varying(255) NOT NULL,
    folder_id uuid,
    subfolder_id uuid,
    file_type public.enum_documents_file_type,
    version_number integer DEFAULT 1 NOT NULL,
    upload_date timestamp with time zone NOT NULL,
    access_permissions json,
    watermark_details json,
    docusign_envelope_id character varying(255),
    requires_signature boolean DEFAULT false NOT NULL,
    archived boolean DEFAULT false,
    document_type_id uuid,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.documents OWNER TO postgres;

--
-- Name: folder_access_invites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.folder_access_invites (
    invite_id uuid NOT NULL,
    folder_id uuid NOT NULL,
    user_email character varying(255) NOT NULL,
    status public.enum_folder_access_invites_status DEFAULT 'Pending'::public.enum_folder_access_invites_status,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.folder_access_invites OWNER TO postgres;

--
-- Name: folders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.folders (
    folder_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    created_by integer NOT NULL,
    created_for integer,
    archived boolean DEFAULT false,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.folders OWNER TO postgres;

--
-- Name: investor_deal_stages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.investor_deal_stages (
    id uuid NOT NULL,
    investor_id integer NOT NULL,
    deal_id uuid NOT NULL,
    stage_id uuid NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.investor_deal_stages OWNER TO postgres;

--
-- Name: investor_milestone_statuses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.investor_milestone_statuses (
    id uuid NOT NULL,
    investor_milestone_id uuid NOT NULL,
    user_id integer NOT NULL,
    deal_id uuid NOT NULL,
    status public.enum_investor_milestone_statuses_status DEFAULT 'Pending'::public.enum_investor_milestone_statuses_status,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.investor_milestone_statuses OWNER TO postgres;

--
-- Name: investor_milestones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.investor_milestones (
    milestone_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.investor_milestones OWNER TO postgres;

--
-- Name: investors_deals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.investors_deals (
    investor_id integer NOT NULL,
    deal_id uuid NOT NULL,
    investment_amount numeric NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.investors_deals OWNER TO postgres;

--
-- Name: invoices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invoices (
    invoice_id uuid NOT NULL,
    deal_id uuid NOT NULL,
    milestone_id uuid,
    amount numeric NOT NULL,
    status public.enum_invoices_status DEFAULT 'Pending'::public.enum_invoices_status,
    due_date timestamp with time zone NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.invoices OWNER TO postgres;

--
-- Name: milestones; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.milestones (
    milestone_id uuid NOT NULL,
    deal_id uuid NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    status public.enum_milestones_status DEFAULT 'Pending'::public.enum_milestones_status,
    due_date timestamp with time zone,
    commission_amount numeric,
    invoice_generated boolean DEFAULT false,
    deal_stage_id uuid,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.milestones OWNER TO postgres;

--
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notifications (
    notification_id uuid NOT NULL,
    user_id integer NOT NULL,
    title character varying(255) NOT NULL,
    message text NOT NULL,
    read boolean DEFAULT false,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.notifications OWNER TO postgres;

--
-- Name: permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permissions (
    permission_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.permissions OWNER TO postgres;

--
-- Name: pipeline_stages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pipeline_stages (
    stage_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    pipeline_id uuid NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.pipeline_stages OWNER TO postgres;

--
-- Name: pipelines; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pipelines (
    pipeline_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    target_amount numeric NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.pipelines OWNER TO postgres;

--
-- Name: primary_location_preferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.primary_location_preferences (
    preference_id uuid NOT NULL,
    user_id integer NOT NULL,
    continent public.enum_primary_location_preferences_continent NOT NULL,
    country_id uuid NOT NULL,
    region public.enum_primary_location_preferences_region NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.primary_location_preferences OWNER TO postgres;

--
-- Name: region_preferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.region_preferences (
    preference_id uuid NOT NULL,
    user_id integer NOT NULL,
    region_id uuid NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.region_preferences OWNER TO postgres;

--
-- Name: regions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.regions (
    region_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    continent_id uuid NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.regions OWNER TO postgres;

--
-- Name: role_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_permissions (
    role_permission_id uuid NOT NULL,
    role_id uuid NOT NULL,
    permission_id uuid NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.role_permissions OWNER TO postgres;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    role_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: sector_preferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sector_preferences (
    preference_id uuid NOT NULL,
    user_id integer NOT NULL,
    sector_id uuid NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.sector_preferences OWNER TO postgres;

--
-- Name: sectors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sectors (
    sector_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.sectors OWNER TO postgres;

--
-- Name: settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.settings (
    id uuid NOT NULL,
    title character varying(255),
    timezone character varying(255),
    phone character varying(255),
    email character varying(255),
    country character varying(255),
    city character varying(255),
    location character varying(255),
    address character varying(255),
    logo character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.settings OWNER TO postgres;

--
-- Name: signature_records; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.signature_records (
    record_id uuid NOT NULL,
    document_id uuid NOT NULL,
    deal_id uuid NOT NULL,
    user_id integer NOT NULL,
    signed_date timestamp with time zone NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.signature_records OWNER TO postgres;

--
-- Name: social_account_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.social_account_types (
    type_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.social_account_types OWNER TO postgres;

--
-- Name: social_media_accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.social_media_accounts (
    account_id uuid NOT NULL,
    user_id integer NOT NULL,
    social_account_type_id uuid NOT NULL,
    link character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.social_media_accounts OWNER TO postgres;

--
-- Name: stage_cards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stage_cards (
    card_id uuid NOT NULL,
    pipeline_stage_id uuid NOT NULL,
    user_id integer NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.stage_cards OWNER TO postgres;

--
-- Name: sub_sector_preferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sub_sector_preferences (
    preference_id uuid NOT NULL,
    user_id integer NOT NULL,
    sub_sector_id uuid NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.sub_sector_preferences OWNER TO postgres;

--
-- Name: subfolder_access_invites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subfolder_access_invites (
    invite_id uuid NOT NULL,
    subfolder_id uuid NOT NULL,
    user_email character varying(255) NOT NULL,
    status public.enum_subfolder_access_invites_status DEFAULT 'Pending'::public.enum_subfolder_access_invites_status,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.subfolder_access_invites OWNER TO postgres;

--
-- Name: subfolders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subfolders (
    subfolder_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    created_by integer NOT NULL,
    created_for integer,
    parent_folder_id uuid NOT NULL,
    parent_subfolder_id uuid,
    archived boolean DEFAULT false,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.subfolders OWNER TO postgres;

--
-- Name: subsectors; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subsectors (
    subsector_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    sector_id uuid NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.subsectors OWNER TO postgres;

--
-- Name: tasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tasks (
    task_id uuid NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    status public.enum_tasks_status DEFAULT 'Pending'::public.enum_tasks_status,
    assigned_to integer NOT NULL,
    created_by integer NOT NULL,
    deal_id uuid NOT NULL,
    deal_stage_id uuid,
    due_date timestamp with time zone,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.tasks OWNER TO postgres;

--
-- Name: transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactions (
    transaction_id uuid NOT NULL,
    deal_id uuid NOT NULL,
    user_id integer NOT NULL,
    amount numeric NOT NULL,
    payment_method public.enum_transactions_payment_method NOT NULL,
    transaction_type public.enum_transactions_transaction_type NOT NULL,
    status public.enum_transactions_status DEFAULT 'Pending'::public.enum_transactions_status NOT NULL,
    transaction_date timestamp with time zone,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.transactions OWNER TO postgres;

--
-- Name: user_preferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_preferences (
    preference_id uuid NOT NULL,
    user_id integer NOT NULL,
    sector_id uuid NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.user_preferences OWNER TO postgres;

--
-- Name: user_reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_reviews (
    review_id uuid NOT NULL,
    user_id integer NOT NULL,
    rating integer NOT NULL,
    review_note text,
    relationship public.enum_user_reviews_relationship NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.user_reviews OWNER TO postgres;

--
-- Name: user_ticket_preferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_ticket_preferences (
    preference_id uuid NOT NULL,
    user_id integer NOT NULL,
    ticket_size_min numeric,
    ticket_size_max numeric,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.user_ticket_preferences OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    profile_image character varying(255),
    kyc_status public.enum_users_kyc_status DEFAULT 'Pending'::public.enum_users_kyc_status,
    preference_sector json,
    preference_region json,
    password character varying(255) NOT NULL,
    role public.enum_users_role DEFAULT 'Investor'::public.enum_users_role NOT NULL,
    role_id uuid NOT NULL,
    status public.enum_users_status DEFAULT 'Open'::public.enum_users_status,
    total_investments integer,
    average_check_size numeric,
    successful_exits integer,
    portfolio_ipr numeric,
    description text,
    addressable_market character varying(255),
    current_market character varying(255),
    total_assets character varying(255),
    ebitda character varying(255),
    gross_margin character varying(255),
    cac_payback_period character varying(255),
    tam character varying(255),
    sam character varying(255),
    som character varying(255),
    year_founded character varying(255),
    location character varying(255),
    phone character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    deleted_at timestamp with time zone,
    parent_user_id integer
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: verification_codes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.verification_codes (
    id integer NOT NULL,
    user_id integer NOT NULL,
    code character varying(255) NOT NULL,
    already_used boolean DEFAULT false NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.verification_codes OWNER TO postgres;

--
-- Name: verification_codes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.verification_codes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.verification_codes_id_seq OWNER TO postgres;

--
-- Name: verification_codes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.verification_codes_id_seq OWNED BY public.verification_codes.id;


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: verification_codes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.verification_codes ALTER COLUMN id SET DEFAULT nextval('public.verification_codes_id_seq'::regclass);


--
-- Data for Name: SequelizeMeta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."SequelizeMeta" (name) FROM stdin;
20231114181100-create-users-migration.js
20231114181103-create-folders.js
20231114181224-create-deals.js
20231114181356-create-documents.js
20241114174832-add-folder-id-to-documents.js
20241118061334-create-deal-meetings.js
20241118063103-create-notifications.js
20241118063958-create-tasks.js
20241118064238-create-signature-records.js
20241127072055-create-user-reviews.js
20241127154036-create-social-account-types.js
20241202130549-add-deal-type-to-deals.js
20241202131245-add-maximum-selling-stake-to-deals.js
20241202131742-add-teaser-to-deals.js
20241203094517-alter-deals-add-additional_columns.js
20241203104335-add-sectors-to-enum.js
20241203104555-add-sectors.js
20241203105417-add-status-enum-values.js
20241204080447-create-contact-persons.js
20241204084743-create-deal-stages.js
20241216064244-create-investor-deal-stages.js
20250107091723-create-countries.js
20250109080818-create-roles.js
20250109080819-create-permissions.js
20250109080819-create-role-permissions.js
20250109082200-add-role-id-to-users.js
20250109190104-add-closed-reopened-to-deal-status.js
20250113070118-create-sectors.js
20250113072349-add-sector-id-to-deals.js
20250113073119-create-subsectors.js
20250113082049-add-subsector-id-to-deals.js
20250113084655-update-deal-lead-to-foreign-key.js
20250114062701-add-additional-columns-to-deals.js
20250114072146-add-created-for-to-folders.js
20250114080855-create-folder-access-invites.js
20250116082311-remove-region-from-user-preferences.js
20250116092756-create-user-ticket-preferences.js
20250116120818-create-deal-type-preferences.js
20250116123956-create-primary-location-preferences.js
20250117071301-create-document-share.js
20250120063917-create-continents.js
20250120065856-create-deal-continents.js
20250120071120-create-regions.js
20250120080012-create-deal-regions.js
20250120081618-create-deal-countries.js
20250121075209-add-deal-stage-id-to-milestones.js
20250121094406-create-subfolders-table.js
20250121102304-add-subfolder-id-to-documents.js
20250121121929-add-deal-stage-id-to-tasks.js
20250122060715-create-pipelines.js
20250122063933-create-pipeline-stages.js
20250122081249-create-stage-cards.js
20250124074523-add-retainer-and-access-fee-to-deals.js
20250127120222-add-parent-subfolder-id-to-subfolders.js
20250128073103-create-subfolder-access-invites.js
20250128141859-create-deal-access-invite.js
20250129135653-add-deal-stage-id-to-deals.js
20250130065253-remove-sector-region-deal-stage-from-deals.js
20250130072445-rename-access-fee-to-success-fee.js
20250131032744-add-archived-to-deal-status.js
20250131035933-add-archived-to-folders.js
20250131040452-add-archived-to-subfolders.js
20250131041011-add-archived-to-documents.js
20250203124755-create-social-media-accounts.js
20250206074135-create-investor-milestones.js
20250206081420-create-investor-milestone-statuses.js
20250206105101-create-deal-milestones.js
20250206111530-create-deal-milestone-statuses.js
20250210073350-create-document-types.js
20250210075536-add-document-type-id-to-documents.js
20250210095441-add-open-to-maximum-selling-stake.js
20250210120227-add-status-to-users.js
20250217082353-add-investment-fields-to-users.js
20250217084929-create-sector-preferences.js
20250217091022-create-sub-sector-preferences.js
20250217092909-create-continent-preferences.js
20250217094130-create-region-preferences.js
20250217100835-create-country-preferences.js
20250217114320-create-user-additional-columns.js
20250224083924-create-deal-lead.js
20250313104606-add-image-url-to-deals.js
20250402085203-add-continent-id-to-countries.js
20250402093821-add-region-id-to-countries.js
20250403141126-create-settings.js
20250404075430-add-parent-user-id-to-users.js
20250407055553-add-full-stake-to-maximum-selling-stake.js
20250407062100-add-phone-to-users.js
20250416075454-add-withdraw-reason-to-deal-access-invites.js
20250416080118-add-withdrawn-to-deal-access-invite-status.js
20250423113252-add-deleted-at-to-users.js
\.


--
-- Data for Name: audit_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.audit_logs (log_id, user_id, action, ip_address, geo_location, details, "createdAt", "updatedAt") FROM stdin;
3927384d-d669-441d-a280-8a49d5c0b510	1	GET_ALL_DEALS	::1	\N	Fetched all deals with pagination - Page: 1, Limit: 10	2025-07-31 14:18:41.184+00	2025-07-31 14:18:41.184+00
8a83bc76-9118-49e3-abf4-e24c74598403	1	GET_ALL_DEALS	::1	\N	Fetched all deals with pagination - Page: 1, Limit: 10	2025-07-31 14:18:41.225+00	2025-07-31 14:18:41.225+00
c2582301-b186-4cf3-9275-0c8a4051bdd5	1	GET_ALL_DOCUMENTS	::1	\N	\N	2025-07-31 14:19:12.947+00	2025-07-31 14:19:12.947+00
7a5f2ba9-6a06-4bfa-9c8a-7b742b869b70	1	GET_ALL_DOCUMENTS	::1	\N	\N	2025-07-31 14:19:12.968+00	2025-07-31 14:19:12.968+00
8f4eec43-6e94-494f-b10e-89c98941840b	1	GET_FOLDERS_BY_USER	::1	\N	\N	2025-07-31 14:19:15.079+00	2025-07-31 14:19:15.079+00
610c6169-c406-42fc-9175-d64c85231a74	1	GET_FOLDERS_BY_USER	::1	\N	\N	2025-07-31 14:19:15.093+00	2025-07-31 14:19:15.093+00
50c5adc7-29c5-4068-b360-461a729eebec	1	GET_ALL_DEALS	::1	\N	Fetched all deals with pagination - Page: 1, Limit: 10	2025-07-31 14:19:15.172+00	2025-07-31 14:19:15.172+00
0ef0f512-a66b-42a9-b8c1-afd974fd2b67	1	GET_ALL_DEALS	::1	\N	Fetched all deals with pagination - Page: 1, Limit: 10	2025-07-31 14:19:15.199+00	2025-07-31 14:19:15.199+00
b9b38d6f-4022-4a3b-aeeb-e4e77dc54856	1	GET_ALL_DOCUMENTS	::1	\N	\N	2025-07-31 14:19:18.273+00	2025-07-31 14:19:18.273+00
7cd47549-c351-49cc-a0ed-0b1558f5b8c8	1	GET_ALL_DOCUMENTS	::1	\N	\N	2025-07-31 14:19:18.281+00	2025-07-31 14:19:18.281+00
e365fb34-b3f0-4b67-a5b9-e71bc52aa448	1	GET_ALL_DOCUMENTS	::1	\N	\N	2025-07-31 14:21:47.214+00	2025-07-31 14:21:47.214+00
870e75a8-5684-404b-b28e-05a50821028e	1	GET_ALL_DOCUMENTS	::1	\N	\N	2025-07-31 14:21:47.224+00	2025-07-31 14:21:47.224+00
796ea4e4-d4da-43d0-9598-746df196c5e9	1	GET_ALL_DOCUMENTS	::1	\N	\N	2025-07-31 14:22:53.715+00	2025-07-31 14:22:53.715+00
c30833d9-ace4-4a16-950a-41fba1b85229	1	GET_ALL_DOCUMENTS	::1	\N	\N	2025-07-31 14:22:53.731+00	2025-07-31 14:22:53.731+00
44b38ab6-402c-4f56-80c7-3baaf52ba251	1	GET_USER_NOTIFICATIONS	::1	\N	\N	2025-07-31 14:25:42.187+00	2025-07-31 14:25:42.187+00
78430206-c3ac-4181-b883-4d8a3b99ae4b	1	GET_USER_NOTIFICATIONS	::1	\N	\N	2025-07-31 14:25:42.205+00	2025-07-31 14:25:42.205+00
6cd664b6-e3d5-417c-a049-0387bcc012a4	1	Get_All_Deal_Stages	::1	\N	All deal stages retrieved	2025-07-31 14:26:48.048+00	2025-07-31 14:26:48.048+00
f9b3a8cf-575b-41e8-b11d-809f46db2585	1	Get_All_Deal_Stages	::1	\N	All deal stages retrieved	2025-07-31 14:26:48.065+00	2025-07-31 14:26:48.065+00
29620a6b-8132-4e43-9bb2-49c4f5ad2809	1	GET_ALL_TASKS	::1	\N	\N	2025-07-31 14:27:09.53+00	2025-07-31 14:27:09.53+00
6485a2e9-87b6-45af-9e09-9c41146efb7d	1	GET_ALL_TASKS	::1	\N	\N	2025-07-31 14:27:09.546+00	2025-07-31 14:27:09.546+00
b0882d44-10c1-4dce-bee3-da599b619f88	1	GET_ALL_DEALS	::1	\N	Fetched all deals with pagination - Page: 1, Limit: 10	2025-07-31 14:27:09.58+00	2025-07-31 14:27:09.58+00
a16acef3-fc38-4df9-87b3-f554d2711a80	1	GET_ALL_DEALS	::1	\N	Fetched all deals with pagination - Page: 1, Limit: 10	2025-07-31 14:27:09.594+00	2025-07-31 14:27:09.594+00
f2b91a8d-b194-416f-a456-e6b84b337caf	1	GET_ALL_TASKS	::1	\N	\N	2025-08-02 16:53:48.498+00	2025-08-02 16:53:48.498+00
34b66751-5856-4822-a257-0f2dfe196f67	1	GET_ALL_TASKS	::1	\N	\N	2025-08-02 16:53:48.564+00	2025-08-02 16:53:48.564+00
7f4de00e-73b8-49f2-8662-b1120ea82a88	1	GET_ALL_DEALS	::1	\N	Fetched all deals with pagination - Page: 1, Limit: 10	2025-08-02 16:53:48.718+00	2025-08-02 16:53:48.718+00
09220e37-3cc2-4159-87ad-b9043d42a9a1	1	GET_ALL_DEALS	::1	\N	Fetched all deals with pagination - Page: 1, Limit: 10	2025-08-02 16:53:48.74+00	2025-08-02 16:53:48.74+00
\.


--
-- Data for Name: contact_people; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contact_people (contact_id, user_id, name, email, phone, "position", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: contact_persons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contact_persons (contact_id, user_id, name, email, phone, "position", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: continent_preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.continent_preferences (preference_id, user_id, continent_id, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: continents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.continents (continent_id, name, "createdAt", "updatedAt") FROM stdin;
ec721d71-0191-46cc-acd2-dc9c4e9aa164	Africa	2025-07-31 14:05:55.12+00	2025-07-31 14:05:55.12+00
c19253f4-be2e-499c-ab44-9835e0ce2442	Asia	2025-07-31 14:05:55.12+00	2025-07-31 14:05:55.12+00
5eac21cd-04d0-4747-a460-cd68ab0dba83	Europe	2025-07-31 14:05:55.12+00	2025-07-31 14:05:55.12+00
3a14f479-87f6-489d-af3e-08175f7fc2a6	North America	2025-07-31 14:05:55.12+00	2025-07-31 14:05:55.12+00
47122c45-c3c1-4088-91a2-956f2dc9472d	South America	2025-07-31 14:05:55.12+00	2025-07-31 14:05:55.12+00
4e78c3d7-9446-4ea6-8b2c-68944f89f3b3	Australia	2025-07-31 14:05:55.12+00	2025-07-31 14:05:55.12+00
70719469-ad03-4060-9e2e-202f91a02d46	Antarctica	2025-07-31 14:05:55.12+00	2025-07-31 14:05:55.12+00
\.


--
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.countries (country_id, name, code, continent_id, region_id, "createdAt", "updatedAt") FROM stdin;
2c3d7d3d-daa2-4b32-89e0-e8e620a2ce41	Afghanistan	AF	\N	\N	2025-07-31 14:05:55.088+00	2025-07-31 14:05:55.088+00
72920819-99bc-425f-95fd-b299238027da	Albania	AL	\N	\N	2025-07-31 14:05:55.088+00	2025-07-31 14:05:55.088+00
4692ae91-d25c-479f-b7f6-8033b4a7ba4d	Algeria	DZ	\N	\N	2025-07-31 14:05:55.088+00	2025-07-31 14:05:55.088+00
fa3f037d-e4b3-4a29-9d16-eaaf99a8a517	Andorra	AD	\N	\N	2025-07-31 14:05:55.088+00	2025-07-31 14:05:55.088+00
92497221-f9a4-476e-8aa9-7e52eca93902	Angola	AO	\N	\N	2025-07-31 14:05:55.088+00	2025-07-31 14:05:55.088+00
608158ac-34f2-4566-aa97-f8d4bd77215d	Antigua and Barbuda	AG	\N	\N	2025-07-31 14:05:55.088+00	2025-07-31 14:05:55.088+00
5a4b661c-c9d7-4f9a-8e87-7092b6d6a872	Argentina	AR	\N	\N	2025-07-31 14:05:55.088+00	2025-07-31 14:05:55.088+00
20f28119-ee7d-464c-9e04-5436163eb125	Armenia	AM	\N	\N	2025-07-31 14:05:55.088+00	2025-07-31 14:05:55.088+00
9dcdd4f4-b7cc-4fe1-8818-ce5d18a754ab	Austria	AT	\N	\N	2025-07-31 14:05:55.088+00	2025-07-31 14:05:55.088+00
fb485362-1c98-4701-af39-06c561e17e80	Azerbaijan	AZ	\N	\N	2025-07-31 14:05:55.088+00	2025-07-31 14:05:55.088+00
ae02dd36-2dea-4f48-8f66-4029cdb9ae0d	Bahamas	BS	\N	\N	2025-07-31 14:05:55.088+00	2025-07-31 14:05:55.088+00
21e618b0-bd37-4407-9d5d-5c2773dd9fc4	Bahrain	BH	\N	\N	2025-07-31 14:05:55.088+00	2025-07-31 14:05:55.088+00
873ef7ff-13a8-48e3-9160-1b4617d6cb4d	Bangladesh	BD	\N	\N	2025-07-31 14:05:55.088+00	2025-07-31 14:05:55.088+00
0dbc0556-6b24-4f87-b395-5cd065a98484	Barbados	BB	\N	\N	2025-07-31 14:05:55.088+00	2025-07-31 14:05:55.088+00
7f196282-4ec5-453a-ab54-2d568cf3b47c	Belarus	BY	\N	\N	2025-07-31 14:05:55.088+00	2025-07-31 14:05:55.088+00
402aa347-99cd-4c98-9d86-ff6699fffecb	Belgium	BE	\N	\N	2025-07-31 14:05:55.088+00	2025-07-31 14:05:55.088+00
8bc0cfc0-5401-430c-bb1d-961d500d45cf	Belize	BZ	\N	\N	2025-07-31 14:05:55.088+00	2025-07-31 14:05:55.088+00
0de645d5-8fed-4652-ab2b-2f53f6389176	Benin	BJ	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
8e592c4f-4036-4076-8824-2ace93f15f5c	Bhutan	BT	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
7f6dc218-6a08-4557-ba26-9b26690219a2	Bolivia	BO	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
0eb61278-d1d0-47c4-ad37-ace22ea85e23	Bosnia and Herzegovina	BA	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
deb9375a-a491-49d8-9cfa-fa5b6b11f704	Botswana	BW	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
a5d103a9-9b72-4898-a139-e5541c7cd1fc	Brazil	BR	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
7c8bb8e1-bf48-4d67-983a-6a965671f9af	Brunei	BN	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
b7786811-e6e8-4fdf-b4cb-1ebe67166cd8	Bulgaria	BG	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
bb580b01-ee8b-462b-be42-8c37b581cb4f	Burkina Faso	BF	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
f022c95c-3dd8-46dd-8e69-52860a13bd59	Burundi	BI	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
31f87f4e-b08c-4adb-a13c-74a505735609	Cabo Verde	CV	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
9e01cd1c-20e8-4903-adbc-7c13d8ead552	Cambodia	KH	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
de129102-3c52-49bf-9775-c7241ff059d5	Cameroon	CM	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
e356802e-2c4b-4fcc-ad4a-36cca804fa41	Canada	CA	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
d6b1a2b4-d4ad-4c14-8fbb-484be33a692d	Central African Republic	CF	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
2a97ea56-4799-4e3d-99a3-a43730650e86	Chad	TD	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
af4bf493-4a16-4916-a11d-83cfa9c3280c	Chile	CL	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
f27c3a36-0cd8-4102-b5d6-6e582785e0b6	China	CN	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
9c0c2a2a-f128-4f15-9f8f-1831640afbec	Colombia	CO	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
521ab3d1-edfa-437d-8666-08dd0c5cbf52	Comoros	KM	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
37e24548-aa2c-4ea3-9670-6f1c27fdc303	Congo, Democratic Republic of the	CD	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
56461a66-a0e1-46d4-9d9a-f16a5997bae0	Congo, Republic of the	CG	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
68e5063a-12fd-49db-8e60-a4648f414123	Costa Rica	CR	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
2250ae0d-f871-4993-b303-2f6b17516702	Croatia	HR	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
c37e589d-9159-42b2-9a66-a14427371789	C	CU	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
58a35d9d-f1f7-415a-9256-84a39c7d42cb	Cyprus	CY	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
a8abef17-c426-4d33-bbdb-260255af4539	Czech Republic	CZ	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
f2a85bd9-2125-49d4-a14f-f02f55fe93b8	Denmark	DK	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
75f846f7-43b7-4fe8-9ec3-7ee7726a1f2a	Djibouti	DJ	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
cac5c07d-94a7-4654-bb44-a7780ccef7ae	Dominica	DM	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
00811ecd-5291-4f92-a8fb-22c569c9f8e4	Dominican Republic	DO	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
4a296bdf-ecc1-45a5-94de-caffd4216fc6	Ecuador	EC	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
181d2e3b-3823-45d0-b46d-daccb99b3ecc	Egypt	EG	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
678d1c46-d8a4-4402-8e14-b9805f461542	El Salvador	SV	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
1e1d775b-1a44-42be-9c9d-2d8e8f1863d2	Equatorial Guinea	GQ	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
daf51202-e0ee-419e-b679-88a5446eedd3	Eritrea	ER	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
91077789-230c-4855-b2c1-4a41aaf61743	Estonia	EE	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
32374f26-04ea-4ea4-92a8-5c1266753509	Eswatini	SZ	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
3a4eecc5-178a-4f83-9c5d-181f74bce0f8	Ethiopia	ET	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
473e3143-0197-4278-a9f5-5133b3223d36	Fiji	FJ	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
159a34de-1b85-408e-9a11-440d27ea4916	Finland	FI	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
a09e197e-1988-4658-ad95-50a8141df0f7	France	FR	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
ddec5acd-4c32-4eca-be4f-b74ed13cf90a	Gabon	GA	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
743bfb20-d7c8-4c77-a4ee-0da6144d5cac	Gambia	GM	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
274759c1-21c7-4fbe-aab4-7d8b8c3dd987	Georgia	GE	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
5797cf46-9f60-4621-ac4d-342552dfc3c4	Germany	DE	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
e604e4d8-0b0e-4d8f-b93a-a30ac1222c87	Ghana	GH	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
b383360c-790f-41e9-9e79-6ea6d107776c	Greece	GR	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
8622efd6-3ac2-4666-8a88-1df8c906f0af	Grenada	GD	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
0e49041a-0057-49c5-a6bb-50c7a20e3b27	Guatemala	GT	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
ff35bf40-240a-4409-a003-4315b3f34ef3	Guinea	GN	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
bfc2e7bc-88b5-4b9c-a47e-f5024b327f6c	Guinea-Bissau	GW	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
c46bc97b-52ab-46c8-94ad-b871962103a2	Guyana	GY	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
c1ae1c93-4552-45f9-a27f-ed83878c3e96	Haiti	HT	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
1c34d2b3-f113-4c6b-8186-da460ac2bda9	Honduras	HN	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
956ff4ac-3a0f-4fcd-afe9-ba58288608d3	Hungary	HU	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
a99aa919-c50c-4cbf-aa89-e27f9f1bf245	Iceland	IS	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
8c6058f7-ba20-4124-86f1-b1d847bdc3de	India	IN	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
003cc2db-c5b9-496b-b648-3400a2992176	Indonesia	ID	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
188cdb4d-c6fc-4f36-b084-c4d71b4dc9a5	Iran	IR	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
5b514f27-6db8-4bdb-bb10-442942b82b87	Iraq	IQ	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
b2242ab9-3e08-4feb-a312-0d7312a5edcf	Ireland	IE	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
5a7bf50b-2cd4-4ac0-b7aa-3b96921c3215	Israel	IL	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
f1e2768e-7cfe-4aed-b3e4-09bb4682e6a7	Italy	IT	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
c92db109-49fa-4fd7-aeaf-ccd439e47f6f	Jamaica	JM	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
3692b8f1-b052-4ed0-8a67-38f46bd8b4bb	Japan	JP	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
29c7a490-328a-4215-8ba5-f4fd30be10dc	Jordan	JO	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
59af1457-0b1d-403f-889c-63bbe44ad48a	Kazakhstan	KZ	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
aad4ef84-829b-464d-aee0-3c0ca90b7e60	Kenya	KE	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
57a60193-e8a6-4b4a-9c4b-bed8becdfcbb	Kiribati	KI	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
e8eb2e40-53d9-472c-98e0-390a436a0377	Kuwait	KW	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
b0d8bbc0-368c-43e2-8b7f-677b4935ad9e	Kyrgyzstan	KG	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
9690b266-142b-43ca-a9e3-ead2789ce5ef	Laos	LA	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
8d69ffba-ca85-41ec-acc7-94254f9764f9	Latvia	LV	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
4af4b81c-543e-4abf-a839-45b43dfc9178	Lebanon	LB	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
5515a3e9-1cad-44a4-9774-3f97fb6086d9	Lesotho	LS	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
f6015364-c766-43a9-a079-f41b1ebf98f5	Liberia	LR	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
4d0cc504-2c53-4b90-b391-fecf01528786	Libya	LY	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
04fbf28c-c560-4977-a9e0-1e69a8a45e6f	Liechtenstein	LI	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
fb722127-c1e1-43f0-a3cc-a6860a0d0771	Lithuania	LT	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
88c3f678-b08c-45e0-ab75-5abeb3dd82d4	Luxembourg	LU	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
6fc36685-3d03-45ed-8a9c-8d158f69d9bd	Madagascar	MG	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
4fa663f5-5a75-4fb4-95f0-878866b6a9ba	Malawi	MW	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
da8e105c-3e28-4227-a56d-a726cd9b5ed7	Malaysia	MY	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
ee9d480a-b401-4087-853e-b5114e291e1f	Maldives	MV	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
45fb3ec2-0a87-48cc-a690-8443702c6022	Mali	ML	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
25829b98-bb84-43db-bbf6-a1bb4673ea9c	Malta	MT	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
b90d2c2d-0776-4948-8643-1ebc607edfa3	Marshall Islands	MH	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
254f23f5-0f6a-4332-b52a-a088ffb34880	Mauritania	MR	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
80ac2033-06df-43bc-a084-02a422ee2a04	Mauritius	MU	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
2c648f14-b6b3-46b1-971e-8f5bb76339dd	Mexico	MX	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
065b9947-d71e-4ced-a6c1-9dcd69133db5	Micronesia	FM	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
b71a886b-c18d-47c4-98ee-37c5cb8641d3	Moldova	MD	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
7f1079e7-c608-496e-b0a4-786b548ecf56	Monaco	MC	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
31f0eacf-c36c-48bf-a4a6-56607f6de1f3	Mongolia	MN	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
9c137256-931f-4c5f-9b7b-45d4cf71b7f3	Montenegro	ME	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
82cf584e-2f56-457d-b488-b1156e62319b	Morocco	MA	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
641c5e51-4075-4271-bd42-621894020181	Mozambique	MZ	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
671415c3-ba6f-4a02-a200-adaba8c8ceec	Myanmar	MM	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
9a8b17a1-c0ad-466b-a9f1-4744cbd332b0	Namibia	NA	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
61cd097a-89da-4e68-a72c-5b5b35f905d4	Nauru	NR	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
ed01d58b-52a0-4492-ba7d-fa98db3cc0b2	Nepal	NP	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
1a29e37a-66c1-4da2-845f-a457a8a5acd0	Netherlands	NL	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
10b16137-aa11-4964-8e9d-5d30db73dcd0	New Zealand	NZ	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
d603ceb5-7da5-4a8e-a633-6f30a08395cd	Nicaragua	NI	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
9ce8479d-4aa8-4e36-b331-be723f816e48	Niger	NE	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
5b1c8c5a-196b-4b45-94cf-0eb3e2947a4c	Nigeria	NG	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
e2f02d3a-e03d-4938-9d29-3855488fa8ee	North Korea	KP	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
90ed7e59-7f6f-41d0-b346-d560e953997e	North Macedonia	MK	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
6241347c-d1b0-47d7-a979-0e8dce2fc32f	Norway	NO	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
6985e8bd-ade2-488b-9f52-88f40415e958	Oman	OM	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
cf0602fb-76bb-4a3c-ac10-68a157a3bb2a	Pakistan	PK	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
a4c8fb9f-b501-4089-86e5-b56ebec041c5	Palau	PW	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
f21d373b-e67e-4915-8b21-cfb136499881	Palestine	PS	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
e5bde4c6-3649-4130-bba7-6df6647a40d4	Panama	PA	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
2c240e9e-df88-42d9-8627-f9033b00dee9	Papua New Guinea	PG	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
1128b1e3-9b61-4125-b7bc-718f0d1122ef	Paraguay	PY	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
9b4d3f58-70e2-490e-8db1-a2fd6156c263	Peru	PE	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
6444e388-fb8d-4b30-abac-282b72a517fe	Philippines	PH	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
9e9f5607-3118-4e43-ba13-d91c9b9d3d6c	Poland	PL	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
b62ce815-c9b7-41a8-8a8a-49b1ecf5b0cc	Portugal	PT	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
73c933aa-e427-442c-92ba-503e9d2c7903	Qatar	QA	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
2b40ec86-8c33-44fc-80de-300f8a210e4b	Romania	RO	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
0fb6fd5c-8c81-4d38-9ae1-281ceb1d18c2	Russia	RU	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
4e0d37bf-4ed4-4e1e-8893-e7c7245fb39b	Rwanda	RW	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
2032ef8c-4dcf-42c4-ae37-353f7c51f7ea	Saint Kitts and Nevis	KN	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
5137a1e1-8c35-4a1b-adec-807eac1b4e41	Saint Lucia	LC	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
0c686e44-bae7-4db9-b627-49d2aa1b4033	Saint Vincent and the Grenadines	VC	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
63671474-0f0c-4f3a-bc8f-a03ffdf6d68c	Samoa	WS	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
5d12b554-8b50-48a3-ac0e-13fa081ce91c	San Marino	SM	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
ac66321b-ba01-4ecd-9ad5-9dec4343fae2	Sao Tome and Principe	ST	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
35c54240-2531-4d78-8dfa-c35ad9db1185	Saudi Arabia	SA	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
9d400d7b-3516-49fe-8bc8-4edc80d01f2c	Senegal	SN	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
edac3ebf-184d-4eb9-97b4-af6d513bd70a	Serbia	RS	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
80ceed9b-fb1b-46a3-acc6-bca93dc95b05	Seychelles	SC	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
91023542-8aaf-4713-bbf4-3c0d83188cdf	Sierra Leone	SL	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
4ea8595c-48d9-4a37-9db5-a49259c0a1c4	Singapore	SG	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
f6a16488-fb30-4cfa-a773-c7357664ff06	Slovakia	SK	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
49e8fcee-06cb-43b1-a53d-dfbd19819cfe	Slovenia	SI	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
883b6818-f24d-4fe3-82c3-cda5ce2274b7	Solomon Islands	SB	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
889312f3-f241-48b1-87c5-2389c4d75843	Somalia	SO	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
7c11b516-2cc6-4544-88de-0bdfee8dbd75	South Africa	ZA	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
8a969bba-e611-4949-96ae-1029d1bfaf32	South Korea	KR	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
96f4a6e4-1982-4c99-bf38-683adcdefd9f	South Sudan	SS	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
4ad96df5-6bee-4844-aafd-5b99bd389afb	Spain	ES	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
2eb41955-460a-44cd-ae96-fd0c3fb73751	Sri Lanka	LK	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
d011a84d-7e24-4aff-b1ab-fa9b25207fe8	Sudan	SD	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
e6272cfb-240e-4f5c-87cb-92493d9c22af	Suriname	SR	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
2a479cc5-dbdd-41dd-9ff1-07f385b9cf03	Sweden	SE	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
e0f13267-ba96-445b-8066-88e14fa83c12	Switzerland	CH	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
66925725-d1fe-463c-ace2-c089ac7c6a47	Syria	SY	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
ebaf89e9-e957-4960-9c06-357991ecfeb2	Taiwan	TW	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
1a0d5df1-dd90-44ef-9245-e6eb62a23a32	Tajikistan	TJ	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
4ec48e8b-af66-4ec1-909f-b9f4005be42c	Tanzania	TZ	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
50235f43-156f-4499-9983-12f829204629	Thailand	TH	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
12df6b47-db2a-4d8c-9e9d-952df63ba6c1	Timor-Leste	TL	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
8d613ead-fcd9-4e91-bf86-f5db2ac3310c	Togo	TG	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
c7097780-a965-4a95-8104-79941932be66	Tonga	TO	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
95f93cc2-6117-4cda-8e34-5e35918b1dcb	Trinidad and Tobago	TT	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
2ae9b6b1-acca-4753-b2b3-c7704f35caf1	Tunisia	TN	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
272db4f3-5030-492d-8ecb-d5925894e496	Turkey	TR	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
c4563e35-4251-4b6a-aa59-c947d916435b	Turkmenistan	TM	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
1571e835-d061-4ab9-8d8a-390c3b588d33	Tuvalu	TV	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
930355bc-d25a-426b-bd0c-bd7cf0dddb70	Uganda	UG	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
a89adfc6-19a4-4bde-a33c-82e92d4b14c5	Ukraine	UA	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
0ca30c9a-5275-453b-a929-297a28636031	United Arab Emirates	AE	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
1cced395-e63c-463f-865d-647c9f62befa	United Kingdom	GB	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
30548e68-ffdf-49f9-b0d4-1a059e74e433	United States	US	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
e064f536-2d75-4d17-abeb-f4a185df0116	Uruguay	UY	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
8a550348-409b-4cf3-8b07-f29dd38ff28d	Uzbekistan	UZ	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
84c16686-b138-40d9-ab8d-6b9b989c49a2	Vanuatu	VU	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
6bfe6dd7-51c8-46c8-b272-5326abc170e7	Vatican City	VA	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
200a3da3-ca60-4bcd-b90d-1de871b7054b	Venezuela	VE	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
eef6fdf6-9fcf-455f-832a-38b08f6c75fb	Vietnam	VN	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
24ff6632-5e15-4654-8ead-42cdc076f98c	Yemen	YE	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
7ed93a5d-5b14-412a-ad80-6da917ab5a17	Zambia	ZM	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
e7f41781-e698-44e4-bd01-aabfac812c45	Zimbabwe	ZW	\N	\N	2025-07-31 14:05:55.089+00	2025-07-31 14:05:55.089+00
9984c8d7-ea48-40b5-82ff-0cfae25c7ff5	Australia	AU	\N	\N	2025-08-01 06:59:06.635+00	2025-08-01 06:59:06.635+00
48d9ad23-f94e-4d1f-92e8-0926c1add2eb	Cuba	CU	\N	\N	2025-08-01 06:59:06.635+00	2025-08-01 06:59:06.635+00
\.


--
-- Data for Name: country_preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.country_preferences (preference_id, user_id, country_id, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: deal_access_invites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deal_access_invites (invite_id, investor_id, deal_id, status, "createdAt", "updatedAt", withdraw_reason) FROM stdin;
\.


--
-- Data for Name: deal_continents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deal_continents (id, deal_id, continent_id, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: deal_countries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deal_countries (id, deal_id, country_id, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: deal_leads; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deal_leads (id, deal_id, user_id, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: deal_meetings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deal_meetings (meeting_id, deal_id, subject, start, "end", attendees, meeting_link, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: deal_milestone_statuses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deal_milestone_statuses (id, deal_milestone_id, deal_id, status, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: deal_milestones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deal_milestones (milestone_id, name, description, "createdAt", "updatedAt") FROM stdin;
ec3a2e10-5833-4c62-8e9d-52db5f249e4a	Preparation of a teaser	Initial contact with the potential investor.	2025-07-31 14:05:55.118+00	2025-07-31 14:05:55.118+00
f792b927-0d30-43cc-957a-e4420e7cafee	Preparation of financial model.	Conducting due diligence on the deal.	2025-07-31 14:05:55.118+00	2025-07-31 14:05:55.118+00
bedbd743-e529-4091-8c02-85a3f0635a35	Preparation of information memorandum	Issuance of the term sheet.	2025-07-31 14:05:55.118+00	2025-07-31 14:05:55.118+00
33af86a2-3368-406a-8712-0cbbeff2ac39	Preparation of valuation report (for equity investments)	Signing of the final agreement.	2025-07-31 14:05:55.118+00	2025-07-31 14:05:55.118+00
97b4d369-4127-4972-93c4-804f3f80d361	Preparation of business plan (Optional)	Signing of the final agreement.	2025-07-31 14:05:55.118+00	2025-07-31 14:05:55.118+00
\.


--
-- Data for Name: deal_regions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deal_regions (id, deal_id, region_id, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: deal_stages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deal_stages (stage_id, user_id, name, "order", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: deal_type_preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deal_type_preferences (preference_id, user_id, deal_type, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: deals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deals (deal_id, title, project, description, image_url, deal_stage_id, status, ticket_size, deal_size, sector_id, subsector_id, target_company_id, key_investors, created_by, visibility, deal_type, maximum_selling_stake, teaser, model, has_information_memorandum, has_vdr, consultant_name, retainer_amount, success_fee_percentage, "createdAt", "updatedAt", deal_lead) FROM stdin;
\.


--
-- Data for Name: document_share; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.document_share (share_id, document_id, user_email, status, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: document_shares; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.document_shares (share_id, document_id, user_email, status, "createdAt", "updatedAt", shared_by) FROM stdin;
\.


--
-- Data for Name: document_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.document_types (type_id, name, "createdAt", "updatedAt") FROM stdin;
e0f70082-07d9-4e57-982f-642177be354d	Information Memorandum	2025-07-31 14:05:55.131+00	2025-07-31 14:05:55.131+00
3d4d9c6f-22a5-4c57-9206-641065feb659	NDA	2025-07-31 14:05:55.131+00	2025-07-31 14:05:55.131+00
7ed59461-3e04-447c-ad5d-44bc6632a7dd	Financial Model	2025-07-31 14:05:55.131+00	2025-07-31 14:05:55.131+00
\.


--
-- Data for Name: documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.documents (document_id, deal_id, uploaded_by, file_name, file_path, folder_id, subfolder_id, file_type, version_number, upload_date, access_permissions, watermark_details, docusign_envelope_id, requires_signature, archived, document_type_id, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: folder_access_invites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.folder_access_invites (invite_id, folder_id, user_email, status, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: folders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.folders (folder_id, name, created_by, created_for, archived, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: investor_deal_stages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.investor_deal_stages (id, investor_id, deal_id, stage_id, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: investor_milestone_statuses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.investor_milestone_statuses (id, investor_milestone_id, user_id, deal_id, status, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: investor_milestones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.investor_milestones (milestone_id, name, description, "createdAt", "updatedAt") FROM stdin;
9246ba4e-5804-4ae0-8d95-b9ccc7936a1d	Receipt and review of the teaser		2025-07-31 14:05:55.116+00	2025-07-31 14:05:55.116+00
1119f4fe-8aca-4225-a628-5f48cc47b643	Execution of the NDA		2025-07-31 14:05:55.116+00	2025-07-31 14:05:55.116+00
8a2d7b6b-8a58-4c8b-8887-73b2eed8a797	Issuance of an Expression of interest or letter of intent or email confirming interest in the deal and requesting additional information.		2025-07-31 14:05:55.116+00	2025-07-31 14:05:55.116+00
b057af8f-eddc-4c46-85c1-9204453cce17	Data room access		2025-07-31 14:05:55.116+00	2025-07-31 14:05:55.116+00
8358a58d-82fa-492b-80b1-f782b904253d	Conduct preliminary due diligence		2025-07-31 14:05:55.116+00	2025-07-31 14:05:55.116+00
83cd479d-15bb-4218-afca-ca5130ab9af8	Preparation of internal IC paper		2025-07-31 14:05:55.116+00	2025-07-31 14:05:55.116+00
a930dc28-6485-4570-ac1f-a0c7dab008c2	First IC approval		2025-07-31 14:05:55.116+00	2025-07-31 14:05:55.116+00
c71adfc6-da08-406b-b077-d6a707da8cb5	Issuance of non-binding term sheet.		2025-07-31 14:05:55.116+00	2025-07-31 14:05:55.116+00
992d5357-5c56-46e3-b905-f92b41c18fae	Execution of the term sheet.		2025-07-31 14:05:55.116+00	2025-07-31 14:05:55.116+00
a8fd21ff-aed4-4bea-bced-88871fa6e453	Onsite detailed due diligence – this may be undertaken internally, or they may hire external consultants such as big 4 audit firms to undertake financial, tax, commercial, ESG, Legal DD etc		2025-07-31 14:05:55.116+00	2025-07-31 14:05:55.116+00
f3d4a82c-a930-4a9c-a07d-7a34d3aadc41	Second IC Approval		2025-07-31 14:05:55.116+00	2025-07-31 14:05:55.116+00
ef2d2447-5104-4204-baee-d14afe02f012	Issuance of a binding offer.		2025-07-31 14:05:55.116+00	2025-07-31 14:05:55.116+00
90ff2c96-faa9-42eb-909b-473a3909af3c	Issuance of loan agreement of Share purchase agreement.		2025-07-31 14:05:55.116+00	2025-07-31 14:05:55.116+00
74a883ea-9135-45df-ae39-a80de14c5924	Seeking approval from competition authority – i.e notifying CAK or COMESA		2025-07-31 14:05:55.116+00	2025-07-31 14:05:55.116+00
\.


--
-- Data for Name: investors_deals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.investors_deals (investor_id, deal_id, investment_amount, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: invoices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.invoices (invoice_id, deal_id, milestone_id, amount, status, due_date, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: milestones; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.milestones (milestone_id, deal_id, title, description, status, due_date, commission_amount, invoice_generated, deal_stage_id, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications (notification_id, user_id, title, message, read, "createdAt", "updatedAt") FROM stdin;
bde0c902-bb5e-4a5b-bdb8-9e891fa0f661	1	Deal stages retrieved	All deal stages have been retrieved	f	2025-07-31 14:26:48.04+00	2025-07-31 14:26:48.04+00
01c68fa2-7c1e-4c0c-94df-68a7a3b816e6	1	Deal stages retrieved	All deal stages have been retrieved	f	2025-07-31 14:26:48.061+00	2025-07-31 14:26:48.061+00
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permissions (permission_id, name, "createdAt", "updatedAt") FROM stdin;
dd68a6ad-6b27-4843-b03e-28dea2b5aa1f	CREATE_AUDIT_LOG	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
67a1494b-b8f6-48a1-a764-d9649c0f3783	VIEW_ALL_AUDIT_LOGS	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
e645a1dd-768d-4d5c-9e02-b005ff0a30f7	VIEW_AUDIT_LOG_BY_ID	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
ee6fd51c-bf1c-4a26-b066-f19518006e5a	CREATE_CONTACT_PERSON	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
fc66884c-54ff-4188-b2f9-56194459a49f	VIEW_CONTACT_PERSONS	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
3c47fffb-636c-4da6-bb7b-2729a08663c6	VIEW_CONTACT_PERSON_BY_ID	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
9ac181b2-53d8-4d5d-a54a-c08d1f2dfa50	UPDATE_CONTACT_PERSON	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
4a7911dd-020e-41fb-b34e-b1f2ed8f854e	DELETE_CONTACT_PERSON	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
6245a7a2-fc86-406d-a16f-c92b19fa279c	VIEW_CONTACT_PERSONS_BY_USER	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
8fd3190a-451a-4a76-9119-03c60611d1fa	CREATE_CONTINENT	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
6af6c818-a94c-4b92-8fbc-c15796f30fe9	VIEW_ALL_CONTINENTS	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
1be8f31a-bc50-422d-8890-841013ece9db	VIEW_CONTINENT_BY_ID	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
37811c78-6c96-47b4-991b-19c8f01f407f	UPDATE_CONTINENT	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
72216a6c-d313-4949-9cc3-6340ae3e7383	DELETE_CONTINENT	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
f1f490bb-eb9a-4d52-9173-907ffcb8da3a	CREATE_CONTINENT_PREFERENCE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
b52962e8-72a6-4da6-a672-85924d3ca517	VIEW_CONTINENT_PREFERENCES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
00221a93-ae04-4dbd-ad3d-66e5f0f0ad7f	VIEW_USER_CONTINENT_PREFERENCES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
5fa329d4-0e3f-40e0-b0bd-a88309692482	UPDATE_CONTINENT_PREFERENCE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
c9b96532-ec16-4f2c-8511-8d2e46263729	DELETE_CONTINENT_PREFERENCE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
4bc4c4fe-4498-46a3-94ba-6088a0aeab50	BULK_CREATE_CONTINENT_PREFERENCES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
e29c9fa3-0867-482c-b8ad-663a3c6051fc	CREATE_COUNTRY	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
bac80351-7ace-41e2-8283-12c6b9ee4c79	VIEW_ALL_COUNTRIES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
abb165aa-916c-4da0-869c-dfce091fd079	VIEW_COUNTRY_BY_ID	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
c81fb6a0-f677-4574-8ff8-70ad58c1a03e	UPDATE_COUNTRY	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
44c559c6-b69d-4e7c-91d8-838ebb13a35d	DELETE_COUNTRY	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
bd58218d-163a-4cd6-a9b2-1fddf2078122	FILTER_COUNTRIES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
3d61f3ee-d721-4fd9-ac39-daea7e10b32d	CREATE_COUNTRY_PREFERENCE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
9a55f7fc-ac6f-40a6-a81c-37eb10d2b05a	VIEW_COUNTRY_PREFERENCES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
a8739bdc-8fa2-43a4-b425-9f57185533e0	UPDATE_COUNTRY_PREFERENCE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
a78f7fc0-9e1e-47a6-b717-c1fdfbec5f01	DELETE_COUNTRY_PREFERENCE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
aafe4a91-0245-4ae3-a1d9-9a5a20ef4337	BULK_CREATE_COUNTRY_PREFERENCES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
a492ec8a-705d-4b1b-9288-a3267a55487b	ADD_CONTINENT_TO_DEAL	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
38c4a73f-dc69-4cc1-863f-78937c9d4fe4	REMOVE_CONTINENT_FROM_DEAL	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
9faf4c9c-1798-41af-a4ae-2edff1add3ea	VIEW_DEAL_CONTINENTS	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
7c1a8152-dbab-4517-81a6-a5796bd0883d	FILTER_DEALS	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
608fd1e0-1474-475d-9eb6-57a820fe48c5	MARK_DEAL_AS_ACTIVE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
97e0b1b3-0bd4-4e83-bf54-fcdfdd17a505	MARK_DEAL_AS_CLOSED	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
ec438ad1-b038-4730-931e-8bb7929df53d	MARK_DEAL_AS_ARCHIVED	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
816c2c48-d9f8-4749-9f62-70d06d49be21	GET_DEALS_BY_USER_PREFERENCES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
619fd554-7221-4c27-85a7-1d2eef10ef4d	GET_TARGET_COMPANY_DEALS	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
cc17b67e-65bd-4a50-9cf6-89aa0a6891eb	GET_DEAL_MILESTONES_AND_TASKS	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
0a578751-796b-4d6e-a658-72b2abb81838	MARK_DEAL_AS_ON_HOLD	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
1cc468d9-a393-47eb-a315-da2bfb8e636e	MARK_DEAL_AS_PENDING	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
ac087f9a-052f-47eb-99ce-3bd58f29b65b	MARK_DEAL_AS_CLOSED_AND_REOPENED	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
0edc227a-16f7-4849-b2a7-7b9615266403	FILTER_DEALS_BY_LOCATION	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
145a3c1e-c04a-4b65-994a-4ab443995ae5	ADD_COUNTRY_TO_DEAL	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
8f2fad0d-c656-4f1d-9955-bff6ff4c5f8d	REMOVE_COUNTRY_FROM_DEAL	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
043082ad-2102-4e83-8f03-7e2d858596fa	VIEW_COUNTRIES_FOR_DEAL	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
89381402-6166-48a5-b458-c32ef9499ccf	CREATE_DEAL_MILESTONE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
6376a537-f7cd-477a-9ff2-dabe501d67f4	VIEW_ALL_DEAL_MILESTONES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
adac3162-e203-4340-b925-f40042789949	VIEW_DEAL_MILESTONE_BY_ID	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
53b4ee31-ea23-4ddc-be7b-f405e93d5357	UPDATE_DEAL_MILESTONE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
1c7b1828-4ac7-4387-b726-798d1567f23a	DELETE_DEAL_MILESTONE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
f7914745-7151-4c04-a045-70504763bf85	CREATE_DEAL_MILESTONE_STATUS	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
34d2e167-cc73-46d9-8e08-e9eeeed8f9d1	VIEW_ALL_DEAL_MILESTONE_STATUSES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
c3c6412a-52bf-4d27-be79-05e157a516f6	VIEW_DEAL_MILESTONE_STATUS_BY_ID	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
3ed5a333-5b0c-45fe-97bf-96a33746776c	UPDATE_DEAL_MILESTONE_STATUS	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
0ea1fd0d-6156-486d-b306-36df2c93b2fe	DELETE_DEAL_MILESTONE_STATUS	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
1510b9cd-808d-4fd2-957b-b481deee2b08	ADD_REGION_TO_DEAL	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
4188630b-a3fa-4667-8f23-aaf00433c6cb	REMOVE_REGION_FROM_DEAL	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
ccb0b710-da32-43e2-add1-dedbc7f82560	VIEW_REGIONS_FOR_DEAL	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
ffacfa91-1124-434b-93cb-77599e02683b	CREATE_DEAL_STAGE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
491b818e-f02f-40da-a12d-0ff9c97a6afc	VIEW_ALL_DEAL_STAGES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
eafc1940-f04a-4bbe-97ed-63a1cf8d1def	VIEW_DEAL_STAGE_BY_ID	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
6c7eed87-fce3-4f6b-90f2-4a91763291e7	UPDATE_DEAL_STAGE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
8d03e867-c231-4ef3-aff8-df0be63e9574	DELETE_DEAL_STAGE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
9d698c18-8617-4a84-a010-a8950e52fe4f	CREATE_DEAL_TYPE_PREFERENCE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
969ec421-ad2b-4f57-a604-7e59a202a353	VIEW_DEAL_TYPE_PREFERENCES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
75b0977e-5142-4743-9baa-7c111a82f5fe	UPDATE_DEAL_TYPE_PREFERENCE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
ee53b4b2-1d4f-4dea-b6a6-3dd6abcc02e0	DELETE_DEAL_TYPE_PREFERENCE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
08a67a2f-42e1-4e71-aea3-214808a79abe	CREATE_MULTIPLE_DEAL_TYPE_PREFERENCES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
fa9ee2e8-83be-447f-9d9b-d70507484ed4	VIEW_UNIQUE_DEAL_TYPE_PREFERENCES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
ef9ba3f6-2e72-4c3d-8008-e6bcabfd5098	CREATE_DOCUMENT	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
a2e84e82-9c5f-471b-a8ac-3be3e0389199	VIEW_ALL_DOCUMENTS	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
060d925f-a979-492d-a106-751aa0766ef8	VIEW_DOCUMENT_BY_ID	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
7a2181ff-5d36-46a2-8a01-bba5cd79fd9f	UPDATE_DOCUMENT	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
fcd412a5-7a46-4145-a920-a9229e1e76a1	DELETE_DOCUMENT	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
dc807bc8-abd1-48a9-ae4b-749933645b8f	ARCHIVE_DOCUMENT	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
5e8984ae-86d5-4ef9-9212-aeb90d8b87ec	FILTER_DOCUMENTS	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
083bba3b-b5fa-4306-aee3-7aed62aa96c1	GET_DOCUMENTS_BY_USER_DEALS	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
7a1aa511-f3ac-483c-b355-e90a8584ffec	GET_DOCUMENTS_FOR_USER_WITH_SHARE_STATUS	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
7d757869-5b79-4cf3-a4aa-9c9ce135e493	GET_DOCUMENT_SIGNING_URL	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
a5c232c7-11f0-4e84-a0f8-d280956f0716	SHARE_DOCUMENT	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
3a9297b7-9d95-4443-baaf-56ebe7ef6f4e	ACCEPT_DOCUMENT_SHARE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
3ecf61b3-a918-4531-942c-ac28a18b1555	REJECT_DOCUMENT_SHARE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
ab2330f0-3e58-4f12-98f2-cfd662be83ae	VIEW_DOCUMENT_SHARES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
086758d6-c928-4cf6-bda6-1d5d8f4ed422	CREATE_DOCUMENT_TYPE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
5a3e665a-9b99-49c9-9976-0d4f7c54f952	VIEW_ALL_DOCUMENT_TYPES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
8625e3c5-d549-4a10-ac9e-c21cd6266800	VIEW_DOCUMENT_TYPE_BY_ID	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
0a030e35-3d8e-4eb5-ae94-d33ec5fab2dc	UPDATE_DOCUMENT_TYPE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
53dddf02-aa58-4ff8-99a8-6932d53bc9f2	DELETE_DOCUMENT_TYPE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
5a43d369-aa04-437b-9dcb-97ce99351e94	CREATE_FOLDER	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
d3bcff32-8c91-4a96-8470-1e1c4b6ba997	VIEW_ALL_FOLDERS	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
ea970d1b-d6fc-49ab-b9d7-dd65d4295e21	VIEW_FOLDER_BY_ID	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
4f579637-4cb9-45e9-99af-64d0e4700c19	UPDATE_FOLDER	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
037998f9-73a5-4d76-ac1e-0a9fbbd366b4	DELETE_FOLDER	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
6103c3f2-10ed-46ba-b43b-fd04e89e10c2	ARCHIVE_FOLDER	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
701d5e18-a685-415d-a9ce-858fcf136dcf	FILTER_FOLDERS	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
925e51a0-a41f-48f5-96e7-e7e6d76930f8	GET_FOLDERS_BY_USER	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
a134fa26-f78b-4c6e-ad47-f975fb009b90	GET_ACCEPTED_AND_PENDING_FOLDER_INVITES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
66d2de9d-effb-4d41-89e7-b267fd4b9a90	ADD_INVESTOR_TO_DEAL_STAGE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
b3b65372-b5e4-4158-b45f-1d3133fa311f	UPDATE_INVESTOR_DEAL_STAGE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
61dd9887-771a-4a13-b4f6-4a2ac1c78e1f	VIEW_INVESTOR_DEAL_STAGES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
fd5b47a8-5af7-4e64-9046-1747b788880b	REMOVE_INVESTOR_FROM_DEAL_STAGE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
efb182e0-e1c9-420e-8da6-7c6953f828e0	CREATE_INVESTOR_MILESTONE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
2fd5f281-1c17-4565-b460-69e5bff3f5a5	VIEW_ALL_INVESTOR_MILESTONES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
460b12a0-1517-4e2c-a723-baa59477f910	VIEW_INVESTOR_MILESTONE_BY_ID	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
13ff0317-6011-4bd4-bec2-6c91964db545	UPDATE_INVESTOR_MILESTONE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
22b8dda8-e545-4aaa-8fab-cabfc5f12a2e	DELETE_INVESTOR_MILESTONE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
99a8d1b0-16ea-4c0a-a0cd-775ecafc9e15	CREATE_INVESTOR_MILESTONE_STATUS	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
5a32e493-9b1d-40d4-bf6e-232162b03a5b	VIEW_ALL_INVESTOR_MILESTONE_STATUSES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
94a2a2c0-a326-4405-9f94-7d27a5cb58e1	VIEW_INVESTOR_MILESTONE_STATUS_BY_ID	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
715f5541-99ee-496d-a6d3-df6034321655	UPDATE_INVESTOR_MILESTONE_STATUS	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
65c3d249-345f-43ae-9413-901d70c87dcf	DELETE_INVESTOR_MILESTONE_STATUS	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
f9abdcf7-ffdb-4395-88f0-997501446e8b	MARK_INVESTOR_MILESTONE_STATUS_AS_COMPLETED	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
21dcca0b-8704-4d22-bd18-95f72e3f4774	MARK_INVESTOR_MILESTONE_STATUS_AS_PENDING	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
09b56ef0-73e3-4f93-b451-37aac7912afd	VIEW_INVESTOR_MILESTONE_STATUSES_BY_USER_AND_DEAL	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
f87a8df0-3036-417b-9b9c-3477c0c69137	VIEW_INVESTOR_MILESTONE_STATUSES_BY_USER	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
47615008-d29d-477a-9ed9-48c52ca472b5	CREATE_INVESTMENT	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
f8d6f0f4-c446-4868-b494-31cece393298	VIEW_ALL_INVESTMENTS	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
4deedfe3-44a2-4c2e-b896-e4e5e30f7a3a	VIEW_INVESTMENT_BY_ID	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
c9369dd4-b233-4e56-9e03-338118327b37	UPDATE_INVESTMENT	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
ba66d6de-71d1-454a-88eb-f91bf917ece9	DELETE_INVESTMENT	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
0bb89773-2904-4094-b13d-d44f8e88b20e	TRACK_INVESTOR_BEHAVIOR	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
7e5aacb1-c7e9-4db9-a2aa-31b2fb886c32	CREATE_MILESTONE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
2a6d263d-9333-49f3-b50b-7d52b5b70deb	VIEW_ALL_MILESTONES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
685bfebf-bf27-4142-b884-a78484931585	VIEW_MILESTONE_BY_ID	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
06a9e914-a6bb-496a-b6ad-9e8b124bfc69	UPDATE_MILESTONE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
9864a13f-9495-47eb-b1f7-6271acf71a00	DELETE_MILESTONE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
8d69cc20-f15d-4e1b-9479-e4b7aad81f37	FILTER_MILESTONES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
8d20e50a-9e97-4d68-9eb7-f5e327526742	GET_MILESTONES_BY_DEAL_ID	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
06ea01bf-60d7-4720-90fd-0e6780dcc932	GET_MILESTONES_FOR_USER	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
be6aed22-812a-40a6-a66b-57111e5b75b6	CREATE_NOTIFICATION	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
c1b8aafb-aa8f-4dcb-9a71-5708a7ea4ffe	VIEW_USER_NOTIFICATIONS	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
40fb83ab-bd6b-43fb-b0ae-d19da5538121	MARK_NOTIFICATION_AS_READ	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
ad559d99-ae96-4089-91ea-0b627d6f94c6	SEND_PREDICTIVE_NOTIFICATIONS	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
a81dc5fd-f365-447d-931c-154d150a67b1	CREATE_PERMISSION	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
1b883705-1ab4-4513-9535-034898d6b9eb	VIEW_ALL_PERMISSIONS	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
df23876a-0002-4604-b845-1250c54d1cb4	VIEW_PERMISSION_BY_ID	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
91dfc165-4d73-4461-8a4b-845c11f2cbaa	UPDATE_PERMISSION	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
856c6025-eb0d-478b-921b-64c7d7e60e78	DELETE_PERMISSION	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
97081bdb-3caf-493c-9388-7c76dbd82c3f	CREATE_PIPELINE_STAGE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
b22e2a3e-29f2-471b-b8ed-d6a1fa62203a	VIEW_ALL_PIPELINE_STAGES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
3d96dda4-ac29-4d0e-89a3-c9ad6cd87924	VIEW_PIPELINE_STAGE_BY_ID	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
560675ce-875d-4ea4-a429-fd9552c4d0d9	UPDATE_PIPELINE_STAGE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
0ff93edb-d5e6-41a3-86f7-f00e01436ffa	DELETE_PIPELINE_STAGE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
eac4e215-8bbd-4609-be70-5fddb005fa76	GET_PIPELINE_STAGES_BY_PIPELINE_ID	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
4679b094-f589-4a1c-ab38-f8d5e0a5fe98	CREATE_PRIMARY_LOCATION_PREFERENCE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
cbadfd38-f37c-4e72-a81c-3c9059620763	VIEW_PRIMARY_LOCATION_PREFERENCES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
e8d518d5-e230-4d12-9597-023f7b70203f	UPDATE_PRIMARY_LOCATION_PREFERENCE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
e8574725-c9ff-4958-999c-5d6f985568f3	DELETE_PRIMARY_LOCATION_PREFERENCE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
3408af21-5834-4f0a-9732-02ddb1ecf692	CREATE_REGION	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
3c4ffe31-d092-4520-b915-b1a88d71c5dc	VIEW_ALL_REGIONS	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
d8d0f221-6758-4ffc-8015-7b4d772d7237	VIEW_REGION_BY_ID	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
0bcc3e79-3f80-4c04-a9f0-9882efa58fd8	UPDATE_REGION	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
983d0eeb-8645-49e0-8261-7faac024e300	DELETE_REGION	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
3101c040-9840-429d-96c9-ec7af6fc960a	CREATE_REGION_PREFERENCE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
e706872b-5905-49a3-afcb-230f21facfe1	VIEW_REGION_PREFERENCES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
87102a66-db67-4b0a-8387-f5d6b133add6	UPDATE_REGION_PREFERENCE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
d0fd40b8-4d8a-463b-bc10-48c44debfd4a	DELETE_REGION_PREFERENCE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
e1bd53a4-fd09-4bf0-badc-f4d7511c566d	BULK_CREATE_REGION_PREFERENCES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
48e673b0-fdca-411c-86cf-7e52031ca665	CREATE_ROLE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
bcb8141c-a294-4b7e-ad96-b33558bf2309	VIEW_ALL_ROLES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
f4f2fb53-2d02-402b-870c-80cc1f28b6ae	VIEW_ROLE_BY_ID	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
e9221480-9467-4bab-9055-0dbc2b8385be	UPDATE_ROLE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
65515f22-f2b8-40d2-ad55-d474f9e8c41b	DELETE_ROLE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
43de63a7-398d-45cb-848d-9036a8834368	ASSIGN_PERMISSIONS_TO_ROLE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
2273ea9c-eaf6-49c0-8bc0-700a7cd6b894	CREATE_SECTOR	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
fc364692-2f4a-412c-a802-fd7997a9324a	VIEW_ALL_SECTORS	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
34e4bc5f-8f37-4f85-b93f-88718af0cbf6	VIEW_SECTOR_BY_ID	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
bc6f01a0-63cc-45a0-ab20-c3bd51f82a0f	UPDATE_SECTOR	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
107303f1-10ae-4aeb-b42e-15de5fbb4c80	DELETE_SECTOR	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
5dc2060b-4e77-4275-84d9-faf9b2041397	BULK_UPLOAD_SECTORS_AND_SUBSECTORS	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
55be49fc-815d-4153-a70c-c9831ce40ca3	CREATE_SECTOR_PREFERENCE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
a92ff050-57ef-4d29-b0a9-062c366f3c31	VIEW_SECTOR_PREFERENCES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
1d683926-0662-4450-a701-729acf0be8f7	UPDATE_SECTOR_PREFERENCE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
a6bcdc07-0734-498c-b5b4-e86cba4e08e2	DELETE_SECTOR_PREFERENCE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
feef0d1e-b8f6-44ff-9a7b-2c317fbcd233	BULK_CREATE_SECTOR_PREFERENCES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
680b8bca-bd7d-4289-a665-790a00750f7a	CREATE_SOCIAL_ACCOUNT_TYPE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
4668d916-10fc-40b1-8c91-3794793f60ea	VIEW_ALL_SOCIAL_ACCOUNT_TYPES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
387c4ec1-dfa0-49de-9021-6cb44dd428c9	VIEW_SOCIAL_ACCOUNT_TYPE_BY_ID	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
d2bb659c-242c-44d7-8004-c8e491b7fa93	UPDATE_SOCIAL_ACCOUNT_TYPE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
b8d393c7-2963-41d6-8e7d-e90f9596691c	DELETE_SOCIAL_ACCOUNT_TYPE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
fc5f498e-ab9d-4557-afdb-6ddd73af8458	BULK_UPLOAD_SOCIAL_ACCOUNT_TYPES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
3963f57d-f499-458c-9f7f-4e1b9611c090	CREATE_SOCIAL_MEDIA_ACCOUNT	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
450683b9-e955-410f-9664-2b8963e3e184	VIEW_SOCIAL_MEDIA_ACCOUNTS_BY_USER	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
01654d5a-6002-4e11-95c5-cd7568dd374f	UPDATE_SOCIAL_MEDIA_ACCOUNT	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
b6721473-6672-4984-932b-0b79da84e698	DELETE_SOCIAL_MEDIA_ACCOUNT	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
ee16d97f-f435-48ce-bd75-93438ca18968	CREATE_STAGE_CARD	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
a2b9c461-a08c-4775-a6b8-279ec965dda8	VIEW_ALL_STAGE_CARDS	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
d6fd90ee-b8ff-4bc3-806c-2622a2efa91b	VIEW_STAGE_CARD_BY_ID	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
db73d383-b1ed-4119-adaf-6db043661e90	UPDATE_STAGE_CARD	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
f22a7f3f-a4b5-4d6b-bb3a-728ea61b63b8	DELETE_STAGE_CARD	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
05f45fa4-d907-42d2-b98e-00a5da734102	SEND_SUBFOLDER_ACCESS_INVITE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
a7ac26dc-3977-4a0f-a009-9d4ce724e7e4	ACCEPT_SUBFOLDER_ACCESS_INVITE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
b2955dc5-3a8d-4825-91d6-0979d0b4d47a	REJECT_SUBFOLDER_ACCESS_INVITE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
d7502517-2b87-4020-a4fa-593877cdd7b6	GET_SUBFOLDER_INVITES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
727f0000-5fb2-4ff6-b676-5c21a207de18	CREATE_SUBFOLDER	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
3f685964-b351-495a-bd50-04386b8fec00	VIEW_SUBFOLDER_BY_ID	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
fa2de613-a941-4bb0-a3cd-1b9efca01826	VIEW_ALL_SUBFOLDERS_FOR_PARENT_FOLDER	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
aa98817c-6f5c-4dc1-919e-037907666f9d	UPDATE_SUBFOLDER	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
e5d04572-81bd-4986-8c47-cb6d32e19a12	DELETE_SUBFOLDER	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
623afeb6-6f6b-4aa3-9eb1-b0cbe836819e	CREATE_SUBSECTOR	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
9751b216-fcfa-47ba-b2d5-0d64b7e9187c	VIEW_ALL_SUBSECTORS	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
03bd237b-fbca-4a94-88ff-87229a387d79	VIEW_SUBSECTOR_BY_ID	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
68d26897-534f-48f0-b4bf-632a8071b90e	UPDATE_SUBSECTOR	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
1424b294-f5ab-4991-9a5d-68dd415891f2	DELETE_SUBSECTOR	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
c7900d9c-3c65-4476-94c4-133b5310015d	CREATE_SUBSECTOR_PREFERENCE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
90decc25-2d4f-4fc4-ab8a-151353407b0e	VIEW_SUBSECTOR_PREFERENCES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
be5721a0-d08b-40b3-bcf7-e64a6689f4d9	UPDATE_SUBSECTOR_PREFERENCE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
c03f8cc4-e8a4-4178-a124-bc0d0510eae0	DELETE_SUBSECTOR_PREFERENCE	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
b910637d-cfc7-4a5b-9884-e2fc919c4b1a	BULK_CREATE_SUBSECTOR_PREFERENCES	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
5ee90b3a-e073-414f-a672-7a5cc7640058	CREATE_TASK	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
7d4bcae2-327b-4e41-b79d-7043501e6ee9	VIEW_ALL_TASKS	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
9e84afcc-f0b4-41ea-b10b-1b74cd430a91	VIEW_TASK_BY_ID	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
791f7f3f-7d9e-462d-a551-4e4482008517	UPDATE_TASK	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
d5feab89-7039-48f9-bcaa-2287b3565f39	DELETE_TASK	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
9fdd0730-8773-4cf4-a3ee-bf80cdd3654e	ASSIGN_TASK_TO_USER	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
7742eab4-652f-439f-987e-829c7617c9ff	MARK_TASK_AS_COMPLETED	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
f14f056e-40a1-4d93-9c76-9a59203f9b44	FILTER_TASKS	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
88396358-deaf-4b75-a046-064e96000b24	SCHEDULE_DEAL_MEETING	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
47230183-b02c-4c96-82c7-423bd5da4806	VIEW_DEAL_MEETINGS	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
6b4084be-60b9-4db5-8670-57b8a010f368	UPDATE_DEAL_MEETING	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
d8cccff4-7088-40ce-b129-42a4d7625db8	DELETE_DEAL_MEETING	2025-07-31 14:05:55.1+00	2025-07-31 14:05:55.1+00
1c9bfc25-39e2-4282-a0b0-a6f309fc400f	CREATE_DEAL	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
67ff1f2e-dabb-4855-8037-0f306346afca	UPDATE_DEAL	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
986b5388-7076-4578-9505-79bdc5fe9685	DELETE_DEAL	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
f654b72e-b1e0-4e57-b4e2-a61380828b39	VIEW_DEAL	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
dc625837-65c0-498f-8697-7cf538688bc6	UPDATE_MILESTONE_STATUS	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
4ed62d72-4a80-4178-922e-1fe18599cc3f	GET_INVOICES_BY_DEAL_ID	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
cae553fd-a310-4fc1-9ec4-90e48d95893b	SEND_DEAL_ACCESS_INVITE	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
b23068a4-db69-48c6-aab9-ff2e710010a9	GET_INVESTOR_INVITES	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
7c2b63f4-7366-4b08-92ad-73920894c016	GET_DEAL_INVITES	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
5f6276ad-654c-4b73-9231-904f02df3569	REJECT_DEAL_INVITE	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
a493a055-e386-4c5c-8fbb-8279566f1596	ACCEPT_DEAL_INVITE	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
57297194-d0e1-48e7-895d-0adc0139a047	EXPRESS_DEAL_INTEREST	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
dcab2eb1-19b2-458d-8a6e-999537ac2ff7	CHECK_ACCEPTED_DEAL_ACCESS_INVITE	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
d03d046a-aa9d-49a9-9352-3e8a6fe994be	WITHDRAW_DEAL_INTEREST	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
8bb21e9e-ebe7-4e65-ad94-fbdabbb9b558	GET_DASHBOARD_DEAL_STATUS_DATA	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
86445233-7c98-412c-a706-d1342558252a	GET_DASHBOARD_DEAL_TYPE_DATA	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
ee6b7714-6838-4c64-bbce-7c818d09ccc5	GET_DASHBOARD_DEAL_SECTOR_DATA	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
996b7c7b-71c4-486b-8f8e-4f2b805d9ae5	GET_DASHBOARD_DEAL_SIZE_DATA	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
cf260538-0500-4616-9f0b-0197817670ff	GET_DASHBOARD_DEAL_CONSULTANT_STATUS_DATA	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
0f349ee1-43da-40e0-a9c4-79f270db587f	SEND_FOLDER_ACCESS_INVITE	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
2b6da277-72e7-41cb-9356-2ea3b7142346	ACCEPT_FOLDER_ACCESS_INVITE	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
e9036ef2-8012-4fdc-9daf-7034bd91228e	REJECT_FOLDER_ACCESS_INVITE	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
864d911a-5a26-42da-9c19-9b1a23499e96	GET_FOLDER_INVITES	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
14f89ae5-37e8-4adf-b3bd-a28b39af7cf1	GET_REGION_WITH_COUNTRIES	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
d1fb0bf4-2c17-4d52-bcb6-cbe2e950d343	GET_CONTINENT_WITH_REGIONS	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
3b7ee867-b4cb-4cee-9d05-14439e23c75b	GET_CONTINENT_WITH_COUNTRIES	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
1b821070-a9fc-4350-9a7c-4f371eeb2255	GET_SUBSECTOR_BY_SECTOR_ID	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
0c2daa37-9a80-4c14-98b2-d255abb86f26	GET_TASKS_BY_DUE_DATE_RANGE	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
485f3c3c-f7f2-4c9e-87b3-80bff05a8c01	GET_TASKS_FOR_USER_DEALS	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
f999a8f8-3913-46ff-af1c-c4d890a11020	GET_USER_TASKS_BY_DEAL_ID	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
1f08b2f5-889c-4426-b751-927fb22e8db5	GET_MEETINGS_BY_DEAL_ID	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
7b2254f5-a4b7-433e-bf2c-3213d969f21b	FILTER_DEAL_MEETINGS	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
f6e9999a-6e7a-4388-9c41-0ad4c572d3c6	CREATE_TRANSACTION	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
7e36fad9-0c09-4678-8f9e-eae616eeb75c	GET_ALL_TRANSACTIONS	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
fb79b27e-b326-433b-b217-5b2ea19c9860	GET_TRANSACTION_BY_ID	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
4b4f8c6b-d5cf-4c61-9f9c-99caaf156f13	UPDATE_TRANSACTION	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
d56da81a-d0d0-4c93-8d84-f160dabc9379	DELETE_TRANSACTION	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
df215466-2b59-4db7-a685-5f9062b718f1	CREATE_USER_PREFERENCE	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
2497aea2-7f48-451f-9586-cd365e94dd73	GET_USER_PREFERENCES	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
75d1a275-174f-4d96-8e31-d18b629ad030	UPDATE_USER_PREFERENCE	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
2dbf6232-d965-4600-aee8-1ab7c441cb07	DELETE_USER_PREFERENCE	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
4b1dcd08-cf7e-4c51-bd7a-f9e7eaf25b7b	CREATE_USER_REVIEW	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
7931315f-c9d6-4f62-82bc-ca76547e5a69	GET_USER_REVIEWS	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
2e67b43d-3e3a-469f-9a54-dd8ca2be0344	GET_USER_REVIEW_BY_ID	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
4d8f1dc9-ddeb-4709-8c5e-8b8c6d688429	UPDATE_USER_REVIEW	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
35d56902-d291-4f67-bca2-a6b75ec396b8	DELETE_USER_REVIEW	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
7c3d647e-c9a6-4a9d-88f5-95cb532f4315	GET_USERS_BY_TYPE	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
aba68394-68dc-4cd1-a760-99f3cb7548ea	BULK_UPLOAD_USERS	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
d3d8d575-a28f-43e0-824e-07ea89b029b1	GET_USER_BY_ID	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
0923a64f-2d8c-4b10-a9ea-01d06ec403ac	DELETE_USER	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
9235d5c0-cd87-4b72-9b59-faf6bc99202d	GET_PROFILE	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
5fdb9b49-b73b-4bfc-9f65-08d69a5e9bee	GET_EMPLOYEES	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
35014ddb-86bf-4a5a-bf94-8ce3f275e42f	UPDATE_USER_STATUS	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
6f8b6cde-2581-4507-9468-3109106e3fa5	MARK_USER_AS_ARCHIVED	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
315c8848-bf89-45c1-aa19-f4afd9903dc3	MARK_USER_AS_OPEN	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
bfccae2f-6363-4513-b47b-6e7fab172fac	MARK_USER_AS_ON_HOLD	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
88f269a0-09da-4dab-8daf-e336e584feb5	UPDATE_TOTAL_INVESTMENTS	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
a53d0341-5e0d-4a11-9bb7-9d77aa2edb48	UPDATE_AVERAGE_CHECK_SIZE	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
4fc8f49f-087d-40fe-a7b4-1762d565d577	UPDATE_SUCCESSFUL_EXITS	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
e39a62e2-7f54-42fc-8949-59a66acd45d9	UPDATE_PORTFOLIO_IPR	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
758d187b-1bff-455a-b616-c0afe296322e	UPDATE_DESCRIPTION	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
4df3b1bb-5546-4ac2-a6cd-e08bdb315bbb	UPDATE_ADDRESSABLE_MARKET	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
76ccaabb-cc3c-471d-9e24-c02354e3a3c0	UPDATE_CURRENT_MARKET	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
9b37da4d-8dde-418b-bbf7-572dec6692a2	UPDATE_TAM	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
4e238a28-d555-431d-b106-76e2f5f5839d	UPDATE_SAM	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
5dfb8dab-1be5-4b5b-bae9-556b5ecb6f45	UPDATE_LOCATION	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
6ca6345e-12c6-4204-99d6-ab62342f444e	UPDATE_YEAR_FOUNDED	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
435b345c-ae03-46fd-8a1e-4fcb791b982f	UPDATE_SOM	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
285adf6b-b89b-473d-9e35-b688f0b03109	UPDATE_CAC	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
492012e9-21a5-4016-9052-e0014faa69e2	UPDATE_EBITDA	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
386164cb-cd39-40bb-97ff-f5d5d24e115a	UPDATE_TOTAL_ASSETS	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
9942dff2-16bb-4c51-a06e-1efaa3f961ec	UPDATE_GROSS_MARGIN	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
596b2d88-76eb-4256-865b-a0608159f7fa	UPDATE_USER_PROFILE	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
dd0f2293-b61b-4d4a-9ba1-17ae928f8047	ADMIN_UPDATE_USER_PROFILE	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
f7f61b23-eec2-4978-b57f-19131c064679	ONBOARD_INVESTOR	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
a16d0e0e-501d-4a5c-ba65-2e8d3f57d3a6	UPLOAD_PROFILE_IMAGE	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
b954b6de-0e07-42b1-98bb-f1e13c29ff32	ONBOARD_TARGET_COMPANY	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
5d14ad6e-d328-467d-a8c9-0f9809cdec08	ADD_EMPLOYEE	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
169494a1-cf41-4648-9266-717187789e1f	UPDATE_EMPLOYEE	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
6e31cb6a-007e-437f-9a8e-dece789a37ae	DELETE_EMPLOYEE	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
e7a968c4-0999-43ad-9778-5c6e8d5fadad	CREATE_EMPLOYEE_FOR_INVESTMENT_FIRM	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
211fae87-0d1a-4eca-9425-40652fa8b8ad	GET_EMPLOYEES_FOR_INVESTMENT_FIRM	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
36c64f0b-45cb-4ab8-87d2-d9b8470b9be5	CREATE_USER_TICKET_PREFERENCE	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
214e6952-2994-49fe-b9c2-1aa99aa06a6f	GET_USER_TICKET_PREFERENCES	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
818e69cc-84d9-4a98-94ba-cf1307b1bdc9	UPDATE_USER_TICKET_PREFERENCE	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
bccd2fc0-22b1-4ec1-8901-9657192ef507	DELETE_USER_TICKET_PREFERENCE	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
f13f3dac-59ad-4bf3-84d5-9bf4f0397e3a	GET_SETTINGS	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
2246f616-7f40-47aa-b46e-e4a5a5390408	UPDATE_SETTINGS	2025-08-01 06:34:47.135+00	2025-08-01 06:34:47.135+00
\.


--
-- Data for Name: pipeline_stages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pipeline_stages (stage_id, name, pipeline_id, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: pipelines; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pipelines (pipeline_id, name, target_amount, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: primary_location_preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.primary_location_preferences (preference_id, user_id, continent, country_id, region, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: region_preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.region_preferences (preference_id, user_id, region_id, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: regions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.regions (region_id, name, continent_id, "createdAt", "updatedAt") FROM stdin;
ac4f040e-959f-479d-a1b1-0f3a126c9553	Northern Africa	ec721d71-0191-46cc-acd2-dc9c4e9aa164	2025-07-31 14:05:55.122+00	2025-07-31 14:05:55.122+00
445a8b3e-ed7c-4cf6-9823-7017a60420f3	West Africa	ec721d71-0191-46cc-acd2-dc9c4e9aa164	2025-07-31 14:05:55.122+00	2025-07-31 14:05:55.122+00
4b8a40f2-e3fb-4aed-91ef-5d37d719ece9	Central Africa	ec721d71-0191-46cc-acd2-dc9c4e9aa164	2025-07-31 14:05:55.122+00	2025-07-31 14:05:55.122+00
70a058d0-52f6-4528-8f66-a12782b27bf5	East Africa	ec721d71-0191-46cc-acd2-dc9c4e9aa164	2025-07-31 14:05:55.122+00	2025-07-31 14:05:55.122+00
99fc6031-5894-4430-854d-dc176c3f5cc6	South Africa	ec721d71-0191-46cc-acd2-dc9c4e9aa164	2025-07-31 14:05:55.122+00	2025-07-31 14:05:55.122+00
473a11bc-3bab-47b2-aa0d-897bf49f4dc8	Eastern Asia	c19253f4-be2e-499c-ab44-9835e0ce2442	2025-07-31 14:05:55.122+00	2025-07-31 14:05:55.122+00
f7ae9b35-7d38-4495-bef5-7d8ca0d2840c	Central Asia	c19253f4-be2e-499c-ab44-9835e0ce2442	2025-07-31 14:05:55.122+00	2025-07-31 14:05:55.122+00
c655d889-6934-471e-992d-c882854da1fa	Southern Asia	c19253f4-be2e-499c-ab44-9835e0ce2442	2025-07-31 14:05:55.122+00	2025-07-31 14:05:55.122+00
9f5ab8a5-8bd1-47ea-becb-97ef30fc165a	Western Asia	c19253f4-be2e-499c-ab44-9835e0ce2442	2025-07-31 14:05:55.122+00	2025-07-31 14:05:55.122+00
273a7a8f-c61a-4553-b19a-a9b7b540d24f	Eastern Europe	5eac21cd-04d0-4747-a460-cd68ab0dba83	2025-07-31 14:05:55.122+00	2025-07-31 14:05:55.122+00
99cee066-c464-4b8a-b5c9-9aa3995cb3ee	Northern Europe	5eac21cd-04d0-4747-a460-cd68ab0dba83	2025-07-31 14:05:55.122+00	2025-07-31 14:05:55.122+00
2634ca3c-3512-470a-80a0-287731743525	Southern Europe	5eac21cd-04d0-4747-a460-cd68ab0dba83	2025-07-31 14:05:55.122+00	2025-07-31 14:05:55.122+00
804d56fa-3b0d-4177-9b61-dad08381331d	Western Europe	5eac21cd-04d0-4747-a460-cd68ab0dba83	2025-07-31 14:05:55.122+00	2025-07-31 14:05:55.122+00
54adf2ef-32c9-4eee-b014-ec0303062eec	Caribbean	3a14f479-87f6-489d-af3e-08175f7fc2a6	2025-07-31 14:05:55.122+00	2025-07-31 14:05:55.122+00
3fcb77e2-7211-4715-8ca3-bd7b05196829	Central America	3a14f479-87f6-489d-af3e-08175f7fc2a6	2025-07-31 14:05:55.122+00	2025-07-31 14:05:55.122+00
5b258c2b-6755-401f-9dcd-a86146891342	Northern America	3a14f479-87f6-489d-af3e-08175f7fc2a6	2025-07-31 14:05:55.122+00	2025-07-31 14:05:55.122+00
508ee4e6-5b0b-4340-9d49-1c0df1a08058	South America	47122c45-c3c1-4088-91a2-956f2dc9472d	2025-07-31 14:05:55.122+00	2025-07-31 14:05:55.122+00
26e322d1-803f-47f6-8666-04b9d26bd162	Australia and New Zealand	4e78c3d7-9446-4ea6-8b2c-68944f89f3b3	2025-07-31 14:05:55.122+00	2025-07-31 14:05:55.122+00
090182c2-a7f0-49cd-b36b-0d5e5b24e93d	Melanesia	4e78c3d7-9446-4ea6-8b2c-68944f89f3b3	2025-07-31 14:05:55.122+00	2025-07-31 14:05:55.122+00
38e7869c-629a-42a1-8278-44ec716b69e9	Micronesia	4e78c3d7-9446-4ea6-8b2c-68944f89f3b3	2025-07-31 14:05:55.122+00	2025-07-31 14:05:55.122+00
67b13164-2be4-4a85-ac32-8c80bc994190	Polynesia	4e78c3d7-9446-4ea6-8b2c-68944f89f3b3	2025-07-31 14:05:55.122+00	2025-07-31 14:05:55.122+00
c603ddfd-9d54-4c44-932c-9aabe1d36a1b	Antarctica	70719469-ad03-4060-9e2e-202f91a02d46	2025-07-31 14:05:55.122+00	2025-07-31 14:05:55.122+00
\.


--
-- Data for Name: role_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_permissions (role_permission_id, role_id, permission_id, "createdAt", "updatedAt") FROM stdin;
6a137b9b-23a9-4053-b94c-829b7c830aa3	d70d00b3-de2e-43f3-ab8a-bb607f6d421a	dd68a6ad-6b27-4843-b03e-28dea2b5aa1f	2025-08-02 14:20:03.749+00	2025-08-02 14:20:03.749+00
d29c570e-bd17-4ad1-b18a-b25b4dfa9e42	d70d00b3-de2e-43f3-ab8a-bb607f6d421a	67a1494b-b8f6-48a1-a764-d9649c0f3783	2025-08-02 14:20:03.749+00	2025-08-02 14:20:03.749+00
f3883961-3cbf-45f3-b076-87fd528a41d1	d70d00b3-de2e-43f3-ab8a-bb607f6d421a	e645a1dd-768d-4d5c-9e02-b005ff0a30f7	2025-08-02 14:20:03.749+00	2025-08-02 14:20:03.749+00
a3924196-3403-4d54-9f3a-095d2cc125e6	d70d00b3-de2e-43f3-ab8a-bb607f6d421a	4a7911dd-020e-41fb-b34e-b1f2ed8f854e	2025-08-02 14:20:03.749+00	2025-08-02 14:20:03.749+00
10457b19-ef21-4f9e-9ac9-abd04a92406f	d70d00b3-de2e-43f3-ab8a-bb607f6d421a	8fd3190a-451a-4a76-9119-03c60611d1fa	2025-08-02 14:20:03.749+00	2025-08-02 14:20:03.749+00
c614bf33-a300-4b0d-ae0b-b7aacffa6acd	d70d00b3-de2e-43f3-ab8a-bb607f6d421a	3c47fffb-636c-4da6-bb7b-2729a08663c6	2025-08-02 14:20:03.749+00	2025-08-02 14:20:03.749+00
39004a32-2051-4839-b339-27fad572a86b	d70d00b3-de2e-43f3-ab8a-bb607f6d421a	fc66884c-54ff-4188-b2f9-56194459a49f	2025-08-02 14:20:03.749+00	2025-08-02 14:20:03.749+00
b9d68e91-f1db-4502-9775-cea29fc4a180	d70d00b3-de2e-43f3-ab8a-bb607f6d421a	9ac181b2-53d8-4d5d-a54a-c08d1f2dfa50	2025-08-02 14:20:03.749+00	2025-08-02 14:20:03.749+00
33f6e39d-fb41-41da-9c13-294053e76423	21d4489c-c819-494b-8280-5509f3a9f609	67ff1f2e-dabb-4855-8037-0f306346afca	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
3c19d7c2-f319-408d-8032-d6d127d34224	21d4489c-c819-494b-8280-5509f3a9f609	3b7ee867-b4cb-4cee-9d05-14439e23c75b	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
f99839e8-13de-4a12-af66-9c9d38c7fa54	21d4489c-c819-494b-8280-5509f3a9f609	864d911a-5a26-42da-9c19-9b1a23499e96	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
e787e051-d8ed-4c60-8d01-0dab9c4c04a6	21d4489c-c819-494b-8280-5509f3a9f609	5a43d369-aa04-437b-9dcb-97ce99351e94	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
cf5e4a2b-430d-47a7-b843-ee23f6bf24e3	21d4489c-c819-494b-8280-5509f3a9f609	485f3c3c-f7f2-4c9e-87b3-80bff05a8c01	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
5eccb227-4b6f-42ea-9883-c2cfe798268f	21d4489c-c819-494b-8280-5509f3a9f609	ba66d6de-71d1-454a-88eb-f91bf917ece9	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
d5781098-47b8-4335-bcef-4242d0b3fb96	21d4489c-c819-494b-8280-5509f3a9f609	eac4e215-8bbd-4609-be70-5fddb005fa76	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
36b6252d-e9dd-407c-b23a-e34429119849	21d4489c-c819-494b-8280-5509f3a9f609	c3c6412a-52bf-4d27-be79-05e157a516f6	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
bb159b97-230d-4ddc-b8c1-d3eb6f497c27	21d4489c-c819-494b-8280-5509f3a9f609	e7a968c4-0999-43ad-9778-5c6e8d5fadad	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
e5d60fda-2c8c-4f37-ba03-61055d7cd296	21d4489c-c819-494b-8280-5509f3a9f609	c03f8cc4-e8a4-4178-a124-bc0d0510eae0	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
22bfdae9-8084-44a9-a7d6-07721525b6e9	21d4489c-c819-494b-8280-5509f3a9f609	be5721a0-d08b-40b3-bcf7-e64a6689f4d9	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
37c338fd-1907-412a-8658-ebe3e8f9925f	21d4489c-c819-494b-8280-5509f3a9f609	596b2d88-76eb-4256-865b-a0608159f7fa	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
add8a26c-4e0c-483e-8e20-ed7238205fd3	21d4489c-c819-494b-8280-5509f3a9f609	cbadfd38-f37c-4e72-a81c-3c9059620763	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
f3d37f79-9cbe-4529-8687-99f145ccd491	21d4489c-c819-494b-8280-5509f3a9f609	0c2daa37-9a80-4c14-98b2-d255abb86f26	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
a926d0f6-1c14-4679-acf4-49f89021d399	21d4489c-c819-494b-8280-5509f3a9f609	43de63a7-398d-45cb-848d-9036a8834368	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
ea05ec77-251b-4979-b249-df3a04c5fcb5	21d4489c-c819-494b-8280-5509f3a9f609	285adf6b-b89b-473d-9e35-b688f0b03109	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
bdba9477-ecee-4511-b35e-f806551b88a1	21d4489c-c819-494b-8280-5509f3a9f609	a8739bdc-8fa2-43a4-b425-9f57185533e0	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
726b2447-e044-443c-b9ab-8aff583f09a1	21d4489c-c819-494b-8280-5509f3a9f609	d3d8d575-a28f-43e0-824e-07ea89b029b1	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
e3baf2f1-14d6-44b8-81f2-f49a01434744	21d4489c-c819-494b-8280-5509f3a9f609	4668d916-10fc-40b1-8c91-3794793f60ea	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
6c60b951-7958-4fd9-b25f-4d85682c1b48	21d4489c-c819-494b-8280-5509f3a9f609	169494a1-cf41-4648-9266-717187789e1f	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
1664e0c9-9f5d-4504-8ea8-6f94a91f59c6	21d4489c-c819-494b-8280-5509f3a9f609	f6e9999a-6e7a-4388-9c41-0ad4c572d3c6	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
3f8216b3-ed7e-4fba-9362-c01486a67fef	21d4489c-c819-494b-8280-5509f3a9f609	460b12a0-1517-4e2c-a723-baa59477f910	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
2e95ba1d-5fa6-4747-96c5-d7df94193663	21d4489c-c819-494b-8280-5509f3a9f609	f7914745-7151-4c04-a045-70504763bf85	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
eb6a3e48-1f38-4706-b1c3-14e967f09832	21d4489c-c819-494b-8280-5509f3a9f609	47230183-b02c-4c96-82c7-423bd5da4806	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
1c8e0686-9f67-49ad-861e-9335d0e07a41	21d4489c-c819-494b-8280-5509f3a9f609	dd68a6ad-6b27-4843-b03e-28dea2b5aa1f	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
ab001e45-ed54-4eaf-b738-b2210494871a	21d4489c-c819-494b-8280-5509f3a9f609	ee6fd51c-bf1c-4a26-b066-f19518006e5a	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
427e0f8f-c4b3-48e9-a7f1-37abef4d6d9b	21d4489c-c819-494b-8280-5509f3a9f609	7d757869-5b79-4cf3-a4aa-9c9ce135e493	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
e226ada4-b10b-45cb-b0a2-b8dd4817c415	21d4489c-c819-494b-8280-5509f3a9f609	450683b9-e955-410f-9664-2b8963e3e184	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
926d270c-6cb9-45bd-95a2-a25e0e36de99	21d4489c-c819-494b-8280-5509f3a9f609	22b8dda8-e545-4aaa-8fab-cabfc5f12a2e	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
e11f7fd1-8e5b-42fd-a38b-ebef65f7f06d	21d4489c-c819-494b-8280-5509f3a9f609	608fd1e0-1474-475d-9eb6-57a820fe48c5	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
8341b5c2-767f-4ef7-9d79-4c0ca3315a62	21d4489c-c819-494b-8280-5509f3a9f609	8f2fad0d-c656-4f1d-9955-bff6ff4c5f8d	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
fffda85d-71c1-4c6e-af4c-262bb4b0b603	21d4489c-c819-494b-8280-5509f3a9f609	856c6025-eb0d-478b-921b-64c7d7e60e78	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
035bc8ff-ba95-4530-bb3f-06b66b23a956	21d4489c-c819-494b-8280-5509f3a9f609	b23068a4-db69-48c6-aab9-ff2e710010a9	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
68a6e301-e2c8-4530-a305-d5cb51001a61	21d4489c-c819-494b-8280-5509f3a9f609	d7502517-2b87-4020-a4fa-593877cdd7b6	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
5eaaaee8-df7e-4995-9a87-b082fd9cf04f	21d4489c-c819-494b-8280-5509f3a9f609	060d925f-a979-492d-a106-751aa0766ef8	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
39cd5bd8-c83f-4d0c-9448-a6a79a906e40	21d4489c-c819-494b-8280-5509f3a9f609	66d2de9d-effb-4d41-89e7-b267fd4b9a90	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
29b23e7c-add8-46f6-9df3-7c0656cd5563	21d4489c-c819-494b-8280-5509f3a9f609	c7900d9c-3c65-4476-94c4-133b5310015d	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
912ed73b-e2e7-4757-b762-d06ea844b38e	21d4489c-c819-494b-8280-5509f3a9f609	925e51a0-a41f-48f5-96e7-e7e6d76930f8	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
17dffafe-5db2-4637-b7be-3b4fcf780fdf	21d4489c-c819-494b-8280-5509f3a9f609	b910637d-cfc7-4a5b-9884-e2fc919c4b1a	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
c4045a2b-cb78-42d0-972b-97927c575877	21d4489c-c819-494b-8280-5509f3a9f609	3a9297b7-9d95-4443-baaf-56ebe7ef6f4e	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
f15e6d81-47b3-4032-bdac-ef70d16d4d84	21d4489c-c819-494b-8280-5509f3a9f609	5fdb9b49-b73b-4bfc-9f65-08d69a5e9bee	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
617b73a7-675b-4321-87b8-053f249c4da2	21d4489c-c819-494b-8280-5509f3a9f609	2dbf6232-d965-4600-aee8-1ab7c441cb07	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
f863a96d-6c92-47f3-a40f-6fe154bb8e4a	21d4489c-c819-494b-8280-5509f3a9f609	a493a055-e386-4c5c-8fbb-8279566f1596	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
4af3d513-275d-4ec0-bb22-4b086036c1ff	21d4489c-c819-494b-8280-5509f3a9f609	5ee90b3a-e073-414f-a672-7a5cc7640058	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
afd6e653-2296-4804-848b-26ed553c2900	21d4489c-c819-494b-8280-5509f3a9f609	dd0f2293-b61b-4d4a-9ba1-17ae928f8047	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
da51c009-97b5-4b7c-ba82-e0de6e4a79ae	21d4489c-c819-494b-8280-5509f3a9f609	0f349ee1-43da-40e0-a9c4-79f270db587f	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
4da9c343-e9d5-4d41-8efe-b6f7c1107cb1	21d4489c-c819-494b-8280-5509f3a9f609	5dfb8dab-1be5-4b5b-bae9-556b5ecb6f45	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
07f9ee82-82fa-4c2f-9f66-dae3b5012039	21d4489c-c819-494b-8280-5509f3a9f609	b2955dc5-3a8d-4825-91d6-0979d0b4d47a	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
77c88076-cbeb-4f83-b3f9-c77d0ff8a022	21d4489c-c819-494b-8280-5509f3a9f609	aafe4a91-0245-4ae3-a1d9-9a5a20ef4337	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
19fe46fe-adfc-4dcb-b561-2138bf4d055c	21d4489c-c819-494b-8280-5509f3a9f609	816c2c48-d9f8-4749-9f62-70d06d49be21	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
4f76fe71-758b-4552-8cfc-2afaac677d1b	21d4489c-c819-494b-8280-5509f3a9f609	f4f2fb53-2d02-402b-870c-80cc1f28b6ae	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
d07a4f04-1332-4abd-92b1-5dc2650bb491	21d4489c-c819-494b-8280-5509f3a9f609	f8d6f0f4-c446-4868-b494-31cece393298	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
eea3cdb4-a495-4ca3-978e-30dce86d1089	21d4489c-c819-494b-8280-5509f3a9f609	7e36fad9-0c09-4678-8f9e-eae616eeb75c	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
bdcb4264-6f41-4504-b5d2-ce7d3094a767	21d4489c-c819-494b-8280-5509f3a9f609	1c9bfc25-39e2-4282-a0b0-a6f309fc400f	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
019c3253-c701-4d2e-8081-e6152d8d6201	21d4489c-c819-494b-8280-5509f3a9f609	a53d0341-5e0d-4a11-9bb7-9d77aa2edb48	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
d7ba3ad0-f148-4bba-89ea-ab66ccbb808f	21d4489c-c819-494b-8280-5509f3a9f609	f13f3dac-59ad-4bf3-84d5-9bf4f0397e3a	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
afca1d44-38bf-4d7f-9ca6-dd2b6a528b7a	21d4489c-c819-494b-8280-5509f3a9f609	7742eab4-652f-439f-987e-829c7617c9ff	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
a2389587-04a1-4483-867d-56ce231c6a16	21d4489c-c819-494b-8280-5509f3a9f609	55be49fc-815d-4153-a70c-c9831ce40ca3	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
ce986b43-b92f-43f5-98fa-33bccd76f716	21d4489c-c819-494b-8280-5509f3a9f609	57297194-d0e1-48e7-895d-0adc0139a047	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
8f1566fb-a37b-4229-894e-f65eea621bde	21d4489c-c819-494b-8280-5509f3a9f609	e9036ef2-8012-4fdc-9daf-7034bd91228e	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
7925bd72-b0a1-426e-b0bb-95d289da0d20	21d4489c-c819-494b-8280-5509f3a9f609	7c3d647e-c9a6-4a9d-88f5-95cb532f4315	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
b8303d9b-9a84-4154-bb7c-ae45e89159d4	21d4489c-c819-494b-8280-5509f3a9f609	386164cb-cd39-40bb-97ff-f5d5d24e115a	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
8953db94-4850-4482-8718-3fec92453364	21d4489c-c819-494b-8280-5509f3a9f609	0bcc3e79-3f80-4c04-a9f0-9882efa58fd8	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
46abfab6-3704-4d8a-81b9-796fc2f9d67e	21d4489c-c819-494b-8280-5509f3a9f609	fcd412a5-7a46-4145-a920-a9229e1e76a1	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
ae19610d-ee82-40dc-b948-e6d81ba8e7ce	21d4489c-c819-494b-8280-5509f3a9f609	e29c9fa3-0867-482c-b8ad-663a3c6051fc	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
8e2b51a0-7cbe-4d1e-8f7b-ddaa1476f249	21d4489c-c819-494b-8280-5509f3a9f609	560675ce-875d-4ea4-a429-fd9552c4d0d9	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
0097d770-1503-48cc-b0bf-24a3398d1d0d	21d4489c-c819-494b-8280-5509f3a9f609	6af6c818-a94c-4b92-8fbc-c15796f30fe9	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
a1412f95-3f93-4d57-a5e0-9d65cd040263	21d4489c-c819-494b-8280-5509f3a9f609	b52962e8-72a6-4da6-a672-85924d3ca517	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
27d61fec-753c-40ae-92bd-ccf126e5e86b	21d4489c-c819-494b-8280-5509f3a9f609	619fd554-7221-4c27-85a7-1d2eef10ef4d	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
951f6c99-f9ec-449d-bd23-9bfe462f2603	21d4489c-c819-494b-8280-5509f3a9f609	a92ff050-57ef-4d29-b0a9-062c366f3c31	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
56351fb7-95bf-4e89-a83d-8b6a2534163c	21d4489c-c819-494b-8280-5509f3a9f609	2e67b43d-3e3a-469f-9a54-dd8ca2be0344	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
137b601b-d75c-4d8a-93db-b99829177aee	21d4489c-c819-494b-8280-5509f3a9f609	d2bb659c-242c-44d7-8004-c8e491b7fa93	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
d471479f-88d1-4ff4-b34d-bf9011288ec7	21d4489c-c819-494b-8280-5509f3a9f609	87102a66-db67-4b0a-8387-f5d6b133add6	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
b95e24cb-8f60-457d-819e-e22771a865c3	21d4489c-c819-494b-8280-5509f3a9f609	fc5f498e-ab9d-4557-afdb-6ddd73af8458	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
ab7da559-6542-491c-b65e-ecc5f6ca6278	21d4489c-c819-494b-8280-5509f3a9f609	40fb83ab-bd6b-43fb-b0ae-d19da5538121	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
e1a08e6a-64b6-4747-aaf9-7a9945ca5d78	21d4489c-c819-494b-8280-5509f3a9f609	05f45fa4-d907-42d2-b98e-00a5da734102	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
dd0d0ad1-ef4d-4391-bb4a-654cc63b4f24	21d4489c-c819-494b-8280-5509f3a9f609	13ff0317-6011-4bd4-bec2-6c91964db545	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
a0deff78-8618-4455-a43b-0fc25e3b7f44	21d4489c-c819-494b-8280-5509f3a9f609	7931315f-c9d6-4f62-82bc-ca76547e5a69	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
ec1aee7f-cef2-4551-874e-e88d2f2bfb34	21d4489c-c819-494b-8280-5509f3a9f609	ee53b4b2-1d4f-4dea-b6a6-3dd6abcc02e0	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
8e8845a3-a08e-4dd7-9e7f-981b75643b2a	21d4489c-c819-494b-8280-5509f3a9f609	2fd5f281-1c17-4565-b460-69e5bff3f5a5	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
03ed3620-23dc-4a4b-b7ec-258596630845	21d4489c-c819-494b-8280-5509f3a9f609	0ff93edb-d5e6-41a3-86f7-f00e01436ffa	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
ea1f05cb-fda1-4a76-bdfd-7e4ca698ce8d	21d4489c-c819-494b-8280-5509f3a9f609	6e31cb6a-007e-437f-9a8e-dece789a37ae	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
81a37bc0-6b45-41a3-90fa-ed8a12e01e60	21d4489c-c819-494b-8280-5509f3a9f609	35d56902-d291-4f67-bca2-a6b75ec396b8	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
7b0c2fc4-7c05-402f-a577-8e20c842f97d	21d4489c-c819-494b-8280-5509f3a9f609	a16d0e0e-501d-4a5c-ba65-2e8d3f57d3a6	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
6c595743-1579-45ea-b02e-e2efbbc92359	21d4489c-c819-494b-8280-5509f3a9f609	ad559d99-ae96-4089-91ea-0b627d6f94c6	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
647099f1-03d8-484a-ad1b-cff51044e691	21d4489c-c819-494b-8280-5509f3a9f609	4188630b-a3fa-4667-8f23-aaf00433c6cb	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
a66ee533-ce5c-4c42-96ca-f78041ce36c6	21d4489c-c819-494b-8280-5509f3a9f609	bac80351-7ace-41e2-8283-12c6b9ee4c79	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
78c91522-fc59-40c4-b7c9-ab306650f36e	21d4489c-c819-494b-8280-5509f3a9f609	d5feab89-7039-48f9-bcaa-2287b3565f39	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
70398ba5-7bcd-439f-8a71-3a949c0f9ba2	21d4489c-c819-494b-8280-5509f3a9f609	14f89ae5-37e8-4adf-b3bd-a28b39af7cf1	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
9be883ee-12e2-49da-901e-b7df697d327c	21d4489c-c819-494b-8280-5509f3a9f609	315c8848-bf89-45c1-aa19-f4afd9903dc3	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
ebc8296f-f9e7-4907-b413-fc357ae2301e	21d4489c-c819-494b-8280-5509f3a9f609	dc625837-65c0-498f-8697-7cf538688bc6	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
342d6aa3-443f-4d1b-972a-834178ab75d5	21d4489c-c819-494b-8280-5509f3a9f609	ea970d1b-d6fc-49ab-b9d7-dd65d4295e21	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
fd60d0d0-c178-4bb7-835d-2ba644f01bc3	21d4489c-c819-494b-8280-5509f3a9f609	f999a8f8-3913-46ff-af1c-c4d890a11020	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
0bbb8126-4a36-4897-b0dc-d2cfc804a681	21d4489c-c819-494b-8280-5509f3a9f609	f1f490bb-eb9a-4d52-9173-907ffcb8da3a	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
9296a063-eb4b-4eb6-ae37-0667562e6b7d	21d4489c-c819-494b-8280-5509f3a9f609	97081bdb-3caf-493c-9388-7c76dbd82c3f	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
99843f71-bbe2-4a4c-8aca-76516e860422	21d4489c-c819-494b-8280-5509f3a9f609	44c559c6-b69d-4e7c-91d8-838ebb13a35d	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
83a2b2e6-154d-4ce9-9d8c-aed64ed93cf4	21d4489c-c819-494b-8280-5509f3a9f609	2497aea2-7f48-451f-9586-cd365e94dd73	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
e7957231-f7cb-4f11-9399-119e9b08c736	21d4489c-c819-494b-8280-5509f3a9f609	4e238a28-d555-431d-b106-76e2f5f5839d	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
07c034df-3488-447f-9283-72e9cf328df3	21d4489c-c819-494b-8280-5509f3a9f609	b8d393c7-2963-41d6-8e7d-e90f9596691c	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
14556925-81f3-4470-8e6e-4e231ee5b575	21d4489c-c819-494b-8280-5509f3a9f609	bccd2fc0-22b1-4ec1-8901-9657192ef507	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
d90a1d1a-9aff-46c7-aea3-19b0090b508a	21d4489c-c819-494b-8280-5509f3a9f609	ccb0b710-da32-43e2-add1-dedbc7f82560	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
4a419d41-2318-4d82-a736-c98224431dab	21d4489c-c819-494b-8280-5509f3a9f609	3d61f3ee-d721-4fd9-ac39-daea7e10b32d	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
96043ee0-cec7-4d53-9c6f-67280aec6d3b	21d4489c-c819-494b-8280-5509f3a9f609	7c1a8152-dbab-4517-81a6-a5796bd0883d	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
5c690414-6091-4ac6-81cc-75f897e8a501	21d4489c-c819-494b-8280-5509f3a9f609	35014ddb-86bf-4a5a-bf94-8ce3f275e42f	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
69839e9b-76a7-471a-933a-1ec74abadf64	21d4489c-c819-494b-8280-5509f3a9f609	3c4ffe31-d092-4520-b915-b1a88d71c5dc	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
b0e929ca-8c38-4f34-a5f2-cd7d984b5d6f	21d4489c-c819-494b-8280-5509f3a9f609	3963f57d-f499-458c-9f7f-4e1b9611c090	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
f960ee80-425a-4d6f-b5ec-e74a54b575ad	21d4489c-c819-494b-8280-5509f3a9f609	7a2181ff-5d36-46a2-8a01-bba5cd79fd9f	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
42f9ddf4-4703-441c-9a0e-52a04c5286f4	21d4489c-c819-494b-8280-5509f3a9f609	a2b9c461-a08c-4775-a6b8-279ec965dda8	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
620098be-460a-4214-b359-3845fc23e2cb	21d4489c-c819-494b-8280-5509f3a9f609	ee6b7714-6838-4c64-bbce-7c818d09ccc5	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
ca1d3233-f20d-406c-8d44-957bd779b221	21d4489c-c819-494b-8280-5509f3a9f609	969ec421-ad2b-4f57-a604-7e59a202a353	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
a43d5c01-a9ad-4235-b4de-8544c3dd4a2f	21d4489c-c819-494b-8280-5509f3a9f609	f14f056e-40a1-4d93-9c76-9a59203f9b44	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
2c45b931-b7e2-44ce-b583-6da8a7c2c209	21d4489c-c819-494b-8280-5509f3a9f609	aa98817c-6f5c-4dc1-919e-037907666f9d	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
9d0d87d5-0b63-466f-8779-cc85891ec9c1	21d4489c-c819-494b-8280-5509f3a9f609	d03d046a-aa9d-49a9-9352-3e8a6fe994be	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
9d837949-595d-4770-9a96-369e32d939a8	21d4489c-c819-494b-8280-5509f3a9f609	1d683926-0662-4450-a701-729acf0be8f7	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
74ef1c02-3a4d-4d9a-b267-0178536179f8	21d4489c-c819-494b-8280-5509f3a9f609	5a3e665a-9b99-49c9-9976-0d4f7c54f952	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
0c440d38-4f43-4c7e-9bb3-22e0dd7e7758	21d4489c-c819-494b-8280-5509f3a9f609	cc17b67e-65bd-4a50-9cf6-89aa0a6891eb	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
1a093ce1-19cd-4432-8931-be67f04982b6	21d4489c-c819-494b-8280-5509f3a9f609	e8574725-c9ff-4958-999c-5d6f985568f3	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
47330db4-09d7-41c5-9496-85bfd1144e0c	21d4489c-c819-494b-8280-5509f3a9f609	34d2e167-cc73-46d9-8e08-e9eeeed8f9d1	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
17d5cc8a-bfbd-4d6e-b194-79af45481af5	21d4489c-c819-494b-8280-5509f3a9f609	cae553fd-a310-4fc1-9ec4-90e48d95893b	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
e4be2b77-c577-4688-9cb6-d8e3ad8fa34a	21d4489c-c819-494b-8280-5509f3a9f609	fc66884c-54ff-4188-b2f9-56194459a49f	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
43a41584-853e-45e3-ab29-5922d3484b00	21d4489c-c819-494b-8280-5509f3a9f609	387c4ec1-dfa0-49de-9021-6cb44dd428c9	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
9740bed8-891f-4b04-b7e1-38ba4131b33b	21d4489c-c819-494b-8280-5509f3a9f609	9ac181b2-53d8-4d5d-a54a-c08d1f2dfa50	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
7fec5a8a-f0b5-4713-b074-b79e4e558aef	21d4489c-c819-494b-8280-5509f3a9f609	01654d5a-6002-4e11-95c5-cd7568dd374f	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
f1e92697-c06c-4e79-9562-d75fdd2f527a	21d4489c-c819-494b-8280-5509f3a9f609	f7f61b23-eec2-4978-b57f-19131c064679	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
5e2be2c5-109d-4086-9eb4-6494b14c60e6	21d4489c-c819-494b-8280-5509f3a9f609	5a32e493-9b1d-40d4-bf6e-232162b03a5b	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
acf1ece6-37d4-4c87-a52b-9bef668106c1	21d4489c-c819-494b-8280-5509f3a9f609	3c47fffb-636c-4da6-bb7b-2729a08663c6	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
9dc4e65a-81bb-45d3-86f4-b989aad3afc1	21d4489c-c819-494b-8280-5509f3a9f609	791f7f3f-7d9e-462d-a551-4e4482008517	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
b95453d4-f307-44e6-aa41-c4d08c0b2b96	21d4489c-c819-494b-8280-5509f3a9f609	48e673b0-fdca-411c-86cf-7e52031ca665	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
360c8d5a-4617-4e06-b973-8388c142a000	21d4489c-c819-494b-8280-5509f3a9f609	38c4a73f-dc69-4cc1-863f-78937c9d4fe4	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
5e909aad-bdc7-4bea-b16f-b3f412e84f7e	21d4489c-c819-494b-8280-5509f3a9f609	bcb8141c-a294-4b7e-ad96-b33558bf2309	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
6cb5e633-9acd-4600-bbd2-2e4bc34b3b9e	21d4489c-c819-494b-8280-5509f3a9f609	ab2330f0-3e58-4f12-98f2-cfd662be83ae	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
15eb2cab-19e3-4d7a-bc89-f139444a58e6	21d4489c-c819-494b-8280-5509f3a9f609	a7ac26dc-3977-4a0f-a009-9d4ce724e7e4	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
449ff503-dc62-4938-b00b-1c923f9b33c8	21d4489c-c819-494b-8280-5509f3a9f609	1b883705-1ab4-4513-9535-034898d6b9eb	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
cc79333e-5cfb-4e03-8e7a-4c199079e9c2	21d4489c-c819-494b-8280-5509f3a9f609	0bb89773-2904-4094-b13d-d44f8e88b20e	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
0db00dc3-873c-4fcf-bcf2-956e2462a272	21d4489c-c819-494b-8280-5509f3a9f609	1c7b1828-4ac7-4387-b726-798d1567f23a	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
0c2b307e-cd61-4272-b333-a1858a801aa2	21d4489c-c819-494b-8280-5509f3a9f609	a492ec8a-705d-4b1b-9288-a3267a55487b	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
bf70e24b-9650-4009-a948-9a1adbd098d7	21d4489c-c819-494b-8280-5509f3a9f609	8bb21e9e-ebe7-4e65-ad94-fbdabbb9b558	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
3d818fb0-0411-4398-89aa-a9ff51c510bb	21d4489c-c819-494b-8280-5509f3a9f609	06a9e914-a6bb-496a-b6ad-9e8b124bfc69	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
3b20a612-b3fd-4619-a5d5-90c990bad2e6	21d4489c-c819-494b-8280-5509f3a9f609	5fa329d4-0e3f-40e0-b0bd-a88309692482	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
998076d7-18e3-40f0-8608-95924f9f4d06	21d4489c-c819-494b-8280-5509f3a9f609	758d187b-1bff-455a-b616-c0afe296322e	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
349058a2-5d6f-4017-b694-4ddc8834f0e4	21d4489c-c819-494b-8280-5509f3a9f609	36c64f0b-45cb-4ab8-87d2-d9b8470b9be5	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
0d4efd36-4c71-4995-a2e8-250dc05b61f1	21d4489c-c819-494b-8280-5509f3a9f609	3f685964-b351-495a-bd50-04386b8fec00	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
e082e879-c237-47a3-a529-09f7354a889a	21d4489c-c819-494b-8280-5509f3a9f609	b6721473-6672-4984-932b-0b79da84e698	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
512e6d5b-5ba7-499e-9098-471465a3c9b4	21d4489c-c819-494b-8280-5509f3a9f609	6b4084be-60b9-4db5-8670-57b8a010f368	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
8cd69772-ac2f-4798-913e-ae6d2483c142	21d4489c-c819-494b-8280-5509f3a9f609	a5c232c7-11f0-4e84-a0f8-d280956f0716	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
fac33b55-801d-448e-b2c7-7bbaa5f36cd5	21d4489c-c819-494b-8280-5509f3a9f609	6376a537-f7cd-477a-9ff2-dabe501d67f4	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
5aaa3d6f-cf3f-497b-9a6e-04c002e90a07	21d4489c-c819-494b-8280-5509f3a9f609	996b7c7b-71c4-486b-8f8e-4f2b805d9ae5	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
d4a5bbf7-a367-468a-8038-8e142b449752	21d4489c-c819-494b-8280-5509f3a9f609	492012e9-21a5-4016-9052-e0014faa69e2	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
cc9d3eb4-3838-4707-84ae-9a2a977c1615	21d4489c-c819-494b-8280-5509f3a9f609	b954b6de-0e07-42b1-98bb-f1e13c29ff32	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
63f5c6d6-1b59-4072-8a2c-31420f610807	21d4489c-c819-494b-8280-5509f3a9f609	bc6f01a0-63cc-45a0-ab20-c3bd51f82a0f	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
381470b1-61d9-4b1c-924b-9bedc5e79c84	21d4489c-c819-494b-8280-5509f3a9f609	e5d04572-81bd-4986-8c47-cb6d32e19a12	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
a9273d75-3e7b-4c68-ab0f-dad2b5a47c9b	21d4489c-c819-494b-8280-5509f3a9f609	53dddf02-aa58-4ff8-99a8-6932d53bc9f2	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
8ff3ed9a-04a0-45ad-9799-3a5faa966960	21d4489c-c819-494b-8280-5509f3a9f609	34e4bc5f-8f37-4f85-b93f-88718af0cbf6	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
6e927dc9-cbba-43a4-81dd-a57569bced07	21d4489c-c819-494b-8280-5509f3a9f609	88f269a0-09da-4dab-8daf-e336e584feb5	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
93e78d95-806d-43f2-a529-1a91670085d1	21d4489c-c819-494b-8280-5509f3a9f609	9e84afcc-f0b4-41ea-b10b-1b74cd430a91	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
efdcd1a4-39a3-4676-a2b7-f2982c4cf3e6	21d4489c-c819-494b-8280-5509f3a9f609	61dd9887-771a-4a13-b4f6-4a2ac1c78e1f	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
b19864e4-702e-4f8c-92db-dfa7de433f81	21d4489c-c819-494b-8280-5509f3a9f609	fa9ee2e8-83be-447f-9d9b-d70507484ed4	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
07290a91-4a93-42a0-b992-4a0185de9859	21d4489c-c819-494b-8280-5509f3a9f609	7e5aacb1-c7e9-4db9-a2aa-31b2fb886c32	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
00eaa53b-42b3-48ef-85de-f757b4e8b799	21d4489c-c819-494b-8280-5509f3a9f609	7b2254f5-a4b7-433e-bf2c-3213d969f21b	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
2497a958-5747-4a0a-92fe-a6b784495271	21d4489c-c819-494b-8280-5509f3a9f609	b3b65372-b5e4-4158-b45f-1d3133fa311f	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
3458baca-13a8-4e1a-b5f2-cc8bf0f6f197	21d4489c-c819-494b-8280-5509f3a9f609	7a1aa511-f3ac-483c-b355-e90a8584ffec	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
78435530-e7f9-4b9e-a3a8-346331b07a59	21d4489c-c819-494b-8280-5509f3a9f609	727f0000-5fb2-4ff6-b676-5c21a207de18	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
f95f3660-3217-409b-ad2a-9d9f351f9f70	21d4489c-c819-494b-8280-5509f3a9f609	d0fd40b8-4d8a-463b-bc10-48c44debfd4a	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
68632c36-0290-4e6e-9a89-5ba5572c2416	21d4489c-c819-494b-8280-5509f3a9f609	1cc468d9-a393-47eb-a315-da2bfb8e636e	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
1af672f1-e7f7-41b7-8958-fdd9b819dd2d	21d4489c-c819-494b-8280-5509f3a9f609	4b4f8c6b-d5cf-4c61-9f9c-99caaf156f13	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
10bac86f-1e22-40e4-a306-5e71b3022e0c	21d4489c-c819-494b-8280-5509f3a9f609	e1bd53a4-fd09-4bf0-badc-f4d7511c566d	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
df581a01-de0f-4b0f-a4a7-286b84f20070	21d4489c-c819-494b-8280-5509f3a9f609	5dc2060b-4e77-4275-84d9-faf9b2041397	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
f66c9e46-af3e-480d-8f81-93b67c0c94fc	21d4489c-c819-494b-8280-5509f3a9f609	df215466-2b59-4db7-a685-5f9062b718f1	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
157bc4c9-f95d-4bc4-864c-59fd56534206	21d4489c-c819-494b-8280-5509f3a9f609	d6fd90ee-b8ff-4bc3-806c-2622a2efa91b	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
440dbccd-080f-4699-a6e5-2e603608a122	21d4489c-c819-494b-8280-5509f3a9f609	dc807bc8-abd1-48a9-ae4b-749933645b8f	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
b5f7ae40-bad5-4e6d-8f77-43e0ef923747	21d4489c-c819-494b-8280-5509f3a9f609	08a67a2f-42e1-4e71-aea3-214808a79abe	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
19c69c0f-a25c-4f89-83b4-9438c5fbfe88	21d4489c-c819-494b-8280-5509f3a9f609	68d26897-534f-48f0-b4bf-632a8071b90e	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
6806ec7d-39f5-4f93-a898-fb1a2b47651b	21d4489c-c819-494b-8280-5509f3a9f609	67a1494b-b8f6-48a1-a764-d9649c0f3783	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
5fa50aef-1d3a-4b78-99a0-8ca69e69b84c	21d4489c-c819-494b-8280-5509f3a9f609	00221a93-ae04-4dbd-ad3d-66e5f0f0ad7f	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
8422ada6-561d-450e-804b-d2d45f111d18	21d4489c-c819-494b-8280-5509f3a9f609	e9221480-9467-4bab-9055-0dbc2b8385be	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
e9d2c50c-1a6c-400d-8e83-ce615cb650b1	21d4489c-c819-494b-8280-5509f3a9f609	feef0d1e-b8f6-44ff-9a7b-2c317fbcd233	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
414e66ea-fc88-439d-a5ab-8bc2d84a2c16	21d4489c-c819-494b-8280-5509f3a9f609	623afeb6-6f6b-4aa3-9eb1-b0cbe836819e	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
2dae9a49-bac0-4387-aa89-ca2f78fd9055	21d4489c-c819-494b-8280-5509f3a9f609	8d20e50a-9e97-4d68-9eb7-f5e327526742	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
1b847ca3-d739-462b-9512-a6b7631ddb8f	21d4489c-c819-494b-8280-5509f3a9f609	e39a62e2-7f54-42fc-8949-59a66acd45d9	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
80d9bbce-7a78-45e2-bfcc-562bfdb06c9a	21d4489c-c819-494b-8280-5509f3a9f609	680b8bca-bd7d-4289-a665-790a00750f7a	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
944b5513-6a59-4a8b-9f93-327ef52e203d	21d4489c-c819-494b-8280-5509f3a9f609	ef9ba3f6-2e72-4c3d-8008-e6bcabfd5098	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
ac5915d4-22f5-492e-854d-7b75b36f9a49	21d4489c-c819-494b-8280-5509f3a9f609	2246f616-7f40-47aa-b46e-e4a5a5390408	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
91f043d4-aaf8-4d85-99b7-9c1fd11d325c	21d4489c-c819-494b-8280-5509f3a9f609	7c2b63f4-7366-4b08-92ad-73920894c016	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
2452a7a2-0213-4888-8e74-7384dfb76d05	21d4489c-c819-494b-8280-5509f3a9f609	4bc4c4fe-4498-46a3-94ba-6088a0aeab50	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
cfa49169-e4f9-4eb2-b8d4-32b8dbe012b9	21d4489c-c819-494b-8280-5509f3a9f609	043082ad-2102-4e83-8f03-7e2d858596fa	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
dc0d334b-d80c-4d8e-9a65-4b57fe387a58	21d4489c-c819-494b-8280-5509f3a9f609	fa2de613-a941-4bb0-a3cd-1b9efca01826	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
7bfa2378-cac8-496a-be61-89c306ebc00b	21d4489c-c819-494b-8280-5509f3a9f609	8d69cc20-f15d-4e1b-9479-e4b7aad81f37	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
cd78c0dc-96ae-4d15-a1a2-d5757c2590c5	21d4489c-c819-494b-8280-5509f3a9f609	90decc25-2d4f-4fc4-ab8a-151353407b0e	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
7ac08395-173a-45d1-a7a4-88670ac5de0a	21d4489c-c819-494b-8280-5509f3a9f609	6f8b6cde-2581-4507-9468-3109106e3fa5	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
d0857581-de69-4178-a772-f18126540e1b	21d4489c-c819-494b-8280-5509f3a9f609	c9369dd4-b233-4e56-9e03-338118327b37	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
912d0987-6077-4314-8239-459fb5759052	21d4489c-c819-494b-8280-5509f3a9f609	9a55f7fc-ac6f-40a6-a81c-37eb10d2b05a	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
f612aa9c-f1d7-450e-b4ae-275b41f9bc35	21d4489c-c819-494b-8280-5509f3a9f609	3408af21-5834-4f0a-9732-02ddb1ecf692	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
12f4c7d5-a05e-4334-9082-3a228d4b0efe	21d4489c-c819-494b-8280-5509f3a9f609	4b1dcd08-cf7e-4c51-bd7a-f9e7eaf25b7b	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
20ac112d-85b8-48ec-a95a-5d09f8ad7e40	21d4489c-c819-494b-8280-5509f3a9f609	214e6952-2994-49fe-b9c2-1aa99aa06a6f	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
df264cc0-f155-4e07-af07-167161830c2a	21d4489c-c819-494b-8280-5509f3a9f609	2a6d263d-9333-49f3-b50b-7d52b5b70deb	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
b7534d30-2e00-430b-be5b-3f4fe478d08f	21d4489c-c819-494b-8280-5509f3a9f609	c9b96532-ec16-4f2c-8511-8d2e46263729	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
650b21fe-ceba-44b8-8436-b35e67850a9a	21d4489c-c819-494b-8280-5509f3a9f609	06ea01bf-60d7-4720-90fd-0e6780dcc932	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
853b6039-687d-40e9-8eff-a2d1c080c51a	21d4489c-c819-494b-8280-5509f3a9f609	a6bcdc07-0734-498c-b5b4-e86cba4e08e2	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
88ea7ad8-7c17-497f-9267-cb07cab4cb78	21d4489c-c819-494b-8280-5509f3a9f609	1be8f31a-bc50-422d-8890-841013ece9db	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
baf6734a-fa36-4dce-8f5a-7b83fd357c74	21d4489c-c819-494b-8280-5509f3a9f609	f9abdcf7-ffdb-4395-88f0-997501446e8b	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
faf7bd05-de3a-48f5-b1cd-d0953a8c1a22	21d4489c-c819-494b-8280-5509f3a9f609	1510b9cd-808d-4fd2-957b-b481deee2b08	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
7b0333e0-af27-49c1-bbdd-0604f7752a9c	21d4489c-c819-494b-8280-5509f3a9f609	75b0977e-5142-4743-9baa-7c111a82f5fe	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
65b771cd-6566-4329-a738-59bf549893c5	21d4489c-c819-494b-8280-5509f3a9f609	0a578751-796b-4d6e-a658-72b2abb81838	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
5ab3bda3-e8db-4d0f-bbd9-43895d32315d	21d4489c-c819-494b-8280-5509f3a9f609	72216a6c-d313-4949-9cc3-6340ae3e7383	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
62c27cb7-e407-496e-b019-1d42c46d6bee	21d4489c-c819-494b-8280-5509f3a9f609	3ecf61b3-a918-4531-942c-ac28a18b1555	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
ea364c54-8679-44f1-80dc-349ded861bed	21d4489c-c819-494b-8280-5509f3a9f609	983d0eeb-8645-49e0-8261-7faac024e300	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
3d3ece50-e8df-4dfe-9fcb-89a104360aa2	21d4489c-c819-494b-8280-5509f3a9f609	89381402-6166-48a5-b458-c32ef9499ccf	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
854d7d83-07ee-40ef-964a-250f0a109d4b	21d4489c-c819-494b-8280-5509f3a9f609	5d14ad6e-d328-467d-a8c9-0f9809cdec08	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
560e8893-9021-4af9-ae8c-5bdd04a93b39	21d4489c-c819-494b-8280-5509f3a9f609	37811c78-6c96-47b4-991b-19c8f01f407f	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
5c0c9640-a10a-428b-b3ab-3b783ee544fb	21d4489c-c819-494b-8280-5509f3a9f609	e645a1dd-768d-4d5c-9e02-b005ff0a30f7	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
455fec36-14d5-4741-b572-f56a3a117fd7	21d4489c-c819-494b-8280-5509f3a9f609	eafc1940-f04a-4bbe-97ed-63a1cf8d1def	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
77f4216d-a8df-4db4-b7f5-5a7e7358f111	21d4489c-c819-494b-8280-5509f3a9f609	a2e84e82-9c5f-471b-a8ac-3be3e0389199	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
70105b44-2168-435d-8c59-37919303272f	21d4489c-c819-494b-8280-5509f3a9f609	e706872b-5905-49a3-afcb-230f21facfe1	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
d0c284f3-ec3d-412b-b587-085f10cc1706	21d4489c-c819-494b-8280-5509f3a9f609	6c7eed87-fce3-4f6b-90f2-4a91763291e7	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
275549f3-959c-4df4-bb82-3c15c8d0e8bf	21d4489c-c819-494b-8280-5509f3a9f609	9faf4c9c-1798-41af-a4ae-2edff1add3ea	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
d778fda0-9b80-41e6-9fa7-d82d987d7d58	21d4489c-c819-494b-8280-5509f3a9f609	65515f22-f2b8-40d2-ad55-d474f9e8c41b	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
128b82ba-2790-48f3-9b82-95ea83d84fdc	21d4489c-c819-494b-8280-5509f3a9f609	03bd237b-fbca-4a94-88ff-87229a387d79	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
cab722a8-66a3-433c-bb5c-f5b3fa6ccec5	21d4489c-c819-494b-8280-5509f3a9f609	6245a7a2-fc86-406d-a16f-c92b19fa279c	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
3a668382-8835-4436-915f-889c65ed9322	21d4489c-c819-494b-8280-5509f3a9f609	5e8984ae-86d5-4ef9-9212-aeb90d8b87ec	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
4f6703f5-0027-435c-b844-9262762d4dd7	21d4489c-c819-494b-8280-5509f3a9f609	ee16d97f-f435-48ce-bd75-93438ca18968	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
8fb6b734-210d-4a3a-b4b5-b8516dde6dfb	21d4489c-c819-494b-8280-5509f3a9f609	bfccae2f-6363-4513-b47b-6e7fab172fac	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
b9017e84-e023-4d19-b688-863d60959bcd	21d4489c-c819-494b-8280-5509f3a9f609	086758d6-c928-4cf6-bda6-1d5d8f4ed422	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
655be6da-b0bb-4158-b444-512ef33b4a4e	21d4489c-c819-494b-8280-5509f3a9f609	6ca6345e-12c6-4204-99d6-ab62342f444e	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
3b341374-510a-4e0e-bc2b-5f5166f970f4	21d4489c-c819-494b-8280-5509f3a9f609	0923a64f-2d8c-4b10-a9ea-01d06ec403ac	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
26b0015e-4e6f-4df4-a866-59f253cce084	21d4489c-c819-494b-8280-5509f3a9f609	4d8f1dc9-ddeb-4709-8c5e-8b8c6d688429	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
bca1c37a-f2d5-4f5e-b49a-44519a4daf8b	21d4489c-c819-494b-8280-5509f3a9f609	d56da81a-d0d0-4c93-8d84-f160dabc9379	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
89007508-769b-47e7-92c8-e56754d59829	21d4489c-c819-494b-8280-5509f3a9f609	f87a8df0-3036-417b-9b9c-3477c0c69137	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
aa5cbdc5-fc54-482a-8757-840cf2cf136c	21d4489c-c819-494b-8280-5509f3a9f609	037998f9-73a5-4d76-ac1e-0a9fbbd366b4	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
7af97764-8f80-48ac-8a20-82c19744f4ad	21d4489c-c819-494b-8280-5509f3a9f609	efb182e0-e1c9-420e-8da6-7c6953f828e0	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
b7ca946a-6521-4b6e-8377-b41a1f3744fd	21d4489c-c819-494b-8280-5509f3a9f609	a78f7fc0-9e1e-47a6-b717-c1fdfbec5f01	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
6bfc217d-0cd1-4c65-8409-883e6d097d3d	21d4489c-c819-494b-8280-5509f3a9f609	fc364692-2f4a-412c-a802-fd7997a9324a	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
05481c35-993f-40b9-94e7-56943d282169	21d4489c-c819-494b-8280-5509f3a9f609	d3bcff32-8c91-4a96-8470-1e1c4b6ba997	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
f90ced55-856a-4d8c-b7dd-bf40f174275e	21d4489c-c819-494b-8280-5509f3a9f609	21dcca0b-8704-4d22-bd18-95f72e3f4774	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
a8b887f6-c4a4-4df5-9088-faf1c10b7583	21d4489c-c819-494b-8280-5509f3a9f609	c81fb6a0-f677-4574-8ff8-70ad58c1a03e	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
443d9299-5ce0-4e15-8e0b-756cb5c5cc8b	21d4489c-c819-494b-8280-5509f3a9f609	fd5b47a8-5af7-4e64-9046-1747b788880b	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
0c21f15f-9836-4a50-b65d-c177456d0fd0	21d4489c-c819-494b-8280-5509f3a9f609	d8cccff4-7088-40ce-b129-42a4d7625db8	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
5f303f6e-890a-43c5-b0af-2250ee86291b	21d4489c-c819-494b-8280-5509f3a9f609	2b6da277-72e7-41cb-9356-2ea3b7142346	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
27e2d61f-d4b4-4434-875d-e9e5377828fc	21d4489c-c819-494b-8280-5509f3a9f609	a81dc5fd-f365-447d-931c-154d150a67b1	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
67188387-c4b2-4ca0-a2f8-b2183b792c78	21d4489c-c819-494b-8280-5509f3a9f609	ec438ad1-b038-4730-931e-8bb7929df53d	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
d59a1207-0b5c-4b9b-b17b-5199732f085d	21d4489c-c819-494b-8280-5509f3a9f609	4deedfe3-44a2-4c2e-b896-e4e5e30f7a3a	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
dcea9cab-7f4b-450e-bf10-ecc88f46726a	21d4489c-c819-494b-8280-5509f3a9f609	adac3162-e203-4340-b925-f40042789949	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
a0d0ed87-3837-4a95-ba08-071c64fc688f	21d4489c-c819-494b-8280-5509f3a9f609	4df3b1bb-5546-4ac2-a6cd-e08bdb315bbb	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
7fa5a8a1-be01-4dce-9c59-beb9168fc65d	21d4489c-c819-494b-8280-5509f3a9f609	e8d518d5-e230-4d12-9597-023f7b70203f	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
b88be4c5-8be1-4965-afc6-91e4d57e1208	21d4489c-c819-494b-8280-5509f3a9f609	4fc8f49f-087d-40fe-a7b4-1762d565d577	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
1b9fd363-a14e-40c9-aed1-df3d2bd7029c	21d4489c-c819-494b-8280-5509f3a9f609	4ed62d72-4a80-4178-922e-1fe18599cc3f	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
a391d321-c389-4e1c-84b5-f56993fab71d	21d4489c-c819-494b-8280-5509f3a9f609	47615008-d29d-477a-9ed9-48c52ca472b5	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
d4d0d51a-2641-4406-9cc1-bcd3e62f2846	21d4489c-c819-494b-8280-5509f3a9f609	986b5388-7076-4578-9505-79bdc5fe9685	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
72b9f5b6-1dc6-4b95-b7b6-cf904a02a9ac	21d4489c-c819-494b-8280-5509f3a9f609	3101c040-9840-429d-96c9-ec7af6fc960a	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
047c1f57-fbb0-421e-b7e1-e08c1e088f1c	21d4489c-c819-494b-8280-5509f3a9f609	7d4bcae2-327b-4e41-b79d-7043501e6ee9	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
7ef17391-c4c5-4d22-b45a-a73c972ff119	21d4489c-c819-494b-8280-5509f3a9f609	9942dff2-16bb-4c51-a06e-1efaa3f961ec	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
c835e6fe-3e77-49a7-b3e6-e59acfbbb92d	21d4489c-c819-494b-8280-5509f3a9f609	9235d5c0-cd87-4b72-9b59-faf6bc99202d	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
b23e3e30-5bb5-44ae-b8e0-4603f0e30952	21d4489c-c819-494b-8280-5509f3a9f609	4a7911dd-020e-41fb-b34e-b1f2ed8f854e	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
9300aa06-4cbf-43b4-b39e-283e7f8a5a79	21d4489c-c819-494b-8280-5509f3a9f609	5f6276ad-654c-4b73-9231-904f02df3569	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
f62dea70-e679-46bf-addb-af50cea48785	21d4489c-c819-494b-8280-5509f3a9f609	aba68394-68dc-4cd1-a760-99f3cb7548ea	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
a0d30101-b6a9-4ce8-a373-2c25f3e31456	21d4489c-c819-494b-8280-5509f3a9f609	8625e3c5-d549-4a10-ac9e-c21cd6266800	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
6791e7aa-7195-458a-ad5d-2829e4664ab7	21d4489c-c819-494b-8280-5509f3a9f609	3d96dda4-ac29-4d0e-89a3-c9ad6cd87924	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
d5a3b5d1-d9e5-4fc7-be8d-af5fe1305291	21d4489c-c819-494b-8280-5509f3a9f609	1b821070-a9fc-4350-9a7c-4f371eeb2255	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
e084de45-bcfc-4f69-8cdb-fd94b8947d9f	21d4489c-c819-494b-8280-5509f3a9f609	d8d0f221-6758-4ffc-8015-7b4d772d7237	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
a368f429-e6b4-486d-bb57-6ffb674baaa6	21d4489c-c819-494b-8280-5509f3a9f609	76ccaabb-cc3c-471d-9e24-c02354e3a3c0	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
264b2206-a4cc-43f7-8ed8-ddd7586027ba	21d4489c-c819-494b-8280-5509f3a9f609	0a030e35-3d8e-4eb5-ae94-d33ec5fab2dc	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
1f7649d3-366c-4093-957d-5e1854739288	21d4489c-c819-494b-8280-5509f3a9f609	083bba3b-b5fa-4306-aee3-7aed62aa96c1	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
c1188b71-fd43-4f73-b79d-e2d3521df58e	21d4489c-c819-494b-8280-5509f3a9f609	0edc227a-16f7-4849-b2a7-7b9615266403	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
c1346f34-ec25-49ac-826f-2c9fae6fccfc	21d4489c-c819-494b-8280-5509f3a9f609	99a8d1b0-16ea-4c0a-a0cd-775ecafc9e15	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
e2f4d50c-65d8-4438-8bac-019aa144b91e	21d4489c-c819-494b-8280-5509f3a9f609	4f579637-4cb9-45e9-99af-64d0e4700c19	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
04e466b0-5e3d-44d6-8eab-0b34c0b3978f	21d4489c-c819-494b-8280-5509f3a9f609	9fdd0730-8773-4cf4-a3ee-bf80cdd3654e	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
47d1604e-fbdd-4ab0-a99b-6ea20ec0cb99	21d4489c-c819-494b-8280-5509f3a9f609	701d5e18-a685-415d-a9ce-858fcf136dcf	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
cf8cb295-1519-44d1-ad66-fd4b96598d76	21d4489c-c819-494b-8280-5509f3a9f609	86445233-7c98-412c-a706-d1342558252a	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
a460a4bb-e6ea-4a34-b938-15f1b292936b	21d4489c-c819-494b-8280-5509f3a9f609	ac087f9a-052f-47eb-99ce-3bd58f29b65b	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
a3b1daf4-2021-4a66-8157-faa086883c0a	21d4489c-c819-494b-8280-5509f3a9f609	8fd3190a-451a-4a76-9119-03c60611d1fa	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
da6981f1-5082-4195-99de-fbda71e22aad	21d4489c-c819-494b-8280-5509f3a9f609	75d1a275-174f-4d96-8e31-d18b629ad030	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
01d851ff-d290-4177-993b-ecba1500d673	21d4489c-c819-494b-8280-5509f3a9f609	2273ea9c-eaf6-49c0-8bc0-700a7cd6b894	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
52232ee2-4f05-49b8-aefe-88f7d80e25be	21d4489c-c819-494b-8280-5509f3a9f609	be6aed22-812a-40a6-a66b-57111e5b75b6	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
5521c166-bc8e-4439-ab16-13ada8991bc1	21d4489c-c819-494b-8280-5509f3a9f609	65c3d249-345f-43ae-9413-901d70c87dcf	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
c50643ad-8f0e-4553-be02-5ef21a0194e0	21d4489c-c819-494b-8280-5509f3a9f609	bd58218d-163a-4cd6-a9b2-1fddf2078122	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
ec71e1d7-f6cc-476b-85f8-984ffd375605	21d4489c-c819-494b-8280-5509f3a9f609	8d03e867-c231-4ef3-aff8-df0be63e9574	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
d82475a6-a61f-4e74-ad12-733c9ed6df7d	21d4489c-c819-494b-8280-5509f3a9f609	a134fa26-f78b-4c6e-ad47-f975fb009b90	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
bf4ab6b2-3ed5-452a-8da8-25bc288e6149	21d4489c-c819-494b-8280-5509f3a9f609	107303f1-10ae-4aeb-b42e-15de5fbb4c80	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
f424b2de-2ea2-4d0f-a66d-16fafd1887bf	21d4489c-c819-494b-8280-5509f3a9f609	cf260538-0500-4616-9f0b-0197817670ff	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
5349c66c-35d3-4020-a823-4d0ffec11321	21d4489c-c819-494b-8280-5509f3a9f609	3ed5a333-5b0c-45fe-97bf-96a33746776c	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
2e8ff9bc-922e-43b2-be50-e78bbea854e2	21d4489c-c819-494b-8280-5509f3a9f609	4679b094-f589-4a1c-ab38-f8d5e0a5fe98	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
1d3d0bcd-4e3f-40ca-899b-c056d036ba32	21d4489c-c819-494b-8280-5509f3a9f609	fb79b27e-b326-433b-b217-5b2ea19c9860	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
3b0a4f28-12e0-430a-b3b1-187c178ec547	21d4489c-c819-494b-8280-5509f3a9f609	dcab2eb1-19b2-458d-8a6e-999537ac2ff7	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
7cad3d1b-e5ac-43ec-8802-4500c5ecc3cb	21d4489c-c819-494b-8280-5509f3a9f609	818e69cc-84d9-4a98-94ba-cf1307b1bdc9	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
cf93bac4-e877-4644-87aa-7b297be350c2	21d4489c-c819-494b-8280-5509f3a9f609	0ea1fd0d-6156-486d-b306-36df2c93b2fe	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
c5bfc3f1-4408-4a5e-8326-0a551d684e30	21d4489c-c819-494b-8280-5509f3a9f609	9864a13f-9495-47eb-b1f7-6271acf71a00	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
28d91b6e-f19d-488b-bec3-4577c8ae97a6	21d4489c-c819-494b-8280-5509f3a9f609	715f5541-99ee-496d-a6d3-df6034321655	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
9ae817b0-10f5-4801-9c8c-5661c89c34e5	21d4489c-c819-494b-8280-5509f3a9f609	91dfc165-4d73-4461-8a4b-845c11f2cbaa	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
cbbcfad8-5a3d-4ea7-9b9e-ccbf5586698e	21d4489c-c819-494b-8280-5509f3a9f609	9b37da4d-8dde-418b-bbf7-572dec6692a2	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
9c5f6e46-9ece-4d5f-9c4d-548f296c5c5f	21d4489c-c819-494b-8280-5509f3a9f609	1424b294-f5ab-4991-9a5d-68dd415891f2	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
6e5acf14-6958-4012-a943-5613bf3c60cb	21d4489c-c819-494b-8280-5509f3a9f609	145a3c1e-c04a-4b65-994a-4ab443995ae5	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
09a2bf4a-777c-4b8c-844d-dc4c8c132a20	21d4489c-c819-494b-8280-5509f3a9f609	abb165aa-916c-4da0-869c-dfce091fd079	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
4ca8f655-5747-4ea4-bbd9-aab24a43caab	21d4489c-c819-494b-8280-5509f3a9f609	211fae87-0d1a-4eca-9425-40652fa8b8ad	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
7c1018e9-d494-4a44-8350-cfebb14ad2ab	21d4489c-c819-494b-8280-5509f3a9f609	db73d383-b1ed-4119-adaf-6db043661e90	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
1c259ee7-cea6-4621-b160-efdc7d57f491	21d4489c-c819-494b-8280-5509f3a9f609	d1fb0bf4-2c17-4d52-bcb6-cbe2e950d343	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
93446a61-0a52-48d9-8348-5267be719e8f	21d4489c-c819-494b-8280-5509f3a9f609	df23876a-0002-4604-b845-1250c54d1cb4	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
535fb48c-8408-4308-aeef-e842872d07b9	21d4489c-c819-494b-8280-5509f3a9f609	f22a7f3f-a4b5-4d6b-bb3a-728ea61b63b8	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
cc322828-cf9b-4289-81a1-b5688f850488	21d4489c-c819-494b-8280-5509f3a9f609	685bfebf-bf27-4142-b884-a78484931585	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
e80f6a75-d94c-4e80-b525-cb26a75f9501	21d4489c-c819-494b-8280-5509f3a9f609	09b56ef0-73e3-4f93-b451-37aac7912afd	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
8db1bfa3-4d16-4a05-b0c8-9921a7aa0cac	21d4489c-c819-494b-8280-5509f3a9f609	6103c3f2-10ed-46ba-b43b-fd04e89e10c2	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
4130a7fb-d52a-4b9b-a655-8ea4274f65d6	21d4489c-c819-494b-8280-5509f3a9f609	491b818e-f02f-40da-a12d-0ff9c97a6afc	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
43f99221-bb99-4ec6-9716-fe17aff17f3c	21d4489c-c819-494b-8280-5509f3a9f609	1f08b2f5-889c-4426-b751-927fb22e8db5	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
9475f9c9-dfb4-4971-9707-db619ba5bd63	21d4489c-c819-494b-8280-5509f3a9f609	9751b216-fcfa-47ba-b2d5-0d64b7e9187c	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
69224391-5e64-479a-bf27-f860423e08c9	21d4489c-c819-494b-8280-5509f3a9f609	88396358-deaf-4b75-a046-064e96000b24	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
aeae9b2d-e9f9-4344-a034-2d3215a30383	21d4489c-c819-494b-8280-5509f3a9f609	94a2a2c0-a326-4405-9f94-7d27a5cb58e1	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
66d0a689-b331-409b-a90c-bc64cd5d5393	21d4489c-c819-494b-8280-5509f3a9f609	9d698c18-8617-4a84-a010-a8950e52fe4f	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
cf9ab0a0-3324-4f50-95bd-439e9c0d297a	21d4489c-c819-494b-8280-5509f3a9f609	53b4ee31-ea23-4ddc-be7b-f405e93d5357	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
ccb88e3e-c713-46ba-95d0-36745d8a08c5	21d4489c-c819-494b-8280-5509f3a9f609	c1b8aafb-aa8f-4dcb-9a71-5708a7ea4ffe	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
88e20def-56c4-4c7b-8595-3190359e46cc	21d4489c-c819-494b-8280-5509f3a9f609	b22e2a3e-29f2-471b-b8ed-d6a1fa62203a	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
9c462e72-381f-40a0-91d3-c289442e9535	21d4489c-c819-494b-8280-5509f3a9f609	f654b72e-b1e0-4e57-b4e2-a61380828b39	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
2cfb103a-4549-4f9d-a4cf-3ffae2850201	21d4489c-c819-494b-8280-5509f3a9f609	97e0b1b3-0bd4-4e83-bf54-fcdfdd17a505	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
7c458fbd-176e-456f-894d-32ad44654a35	21d4489c-c819-494b-8280-5509f3a9f609	ffacfa91-1124-434b-93cb-77599e02683b	2025-08-02 14:16:46.237+00	2025-08-02 14:16:46.237+00
672c7357-5a48-4287-834f-c8dc5a513e4e	4c08114c-8c8d-499c-90d6-8857f90e13d6	dd68a6ad-6b27-4843-b03e-28dea2b5aa1f	2025-08-02 16:45:16.722+00	2025-08-02 16:45:16.722+00
d5a24353-faf5-4fcb-b6e4-c0d97078d865	4c08114c-8c8d-499c-90d6-8857f90e13d6	67a1494b-b8f6-48a1-a764-d9649c0f3783	2025-08-02 16:45:16.722+00	2025-08-02 16:45:16.722+00
adb43a19-ac94-4d9d-8c78-fdcf7b7103e5	4c08114c-8c8d-499c-90d6-8857f90e13d6	e645a1dd-768d-4d5c-9e02-b005ff0a30f7	2025-08-02 16:45:16.722+00	2025-08-02 16:45:16.722+00
f3b6ff7b-57e6-4697-9871-25e060304add	4c08114c-8c8d-499c-90d6-8857f90e13d6	ee6fd51c-bf1c-4a26-b066-f19518006e5a	2025-08-02 16:45:16.722+00	2025-08-02 16:45:16.722+00
bf753bc7-7e7f-4b1d-a254-c8efa5a60e94	4c08114c-8c8d-499c-90d6-8857f90e13d6	fc66884c-54ff-4188-b2f9-56194459a49f	2025-08-02 16:45:16.722+00	2025-08-02 16:45:16.722+00
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (role_id, name, "createdAt", "updatedAt") FROM stdin;
21d4489c-c819-494b-8280-5509f3a9f609	Administrator	2025-07-31 14:05:55.111+00	2025-07-31 14:05:55.111+00
b63b41f4-e0a8-4767-addd-a5b99c4e9b19	Investor	2025-07-31 14:05:55.111+00	2025-07-31 14:05:55.111+00
7ec75893-52c9-4a48-b165-bef37d49fb30	Target Company	2025-07-31 14:05:55.111+00	2025-07-31 14:05:55.111+00
d70d00b3-de2e-43f3-ab8a-bb607f6d421a	Manager	2025-08-02 12:02:35.38+00	2025-08-02 12:02:35.38+00
4c08114c-8c8d-499c-90d6-8857f90e13d6	Drip Emporium	2025-08-02 12:42:51.129+00	2025-08-02 12:42:51.129+00
\.


--
-- Data for Name: sector_preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sector_preferences (preference_id, user_id, sector_id, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: sectors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sectors (sector_id, name, "createdAt", "updatedAt") FROM stdin;
9a2f968d-4cfb-439c-a7d8-c78da1d14d28	Tech	2025-07-31 14:05:55.113+00	2025-07-31 14:05:55.113+00
29017fb1-9b8a-4781-a3ec-45a0092be8c4	Finance	2025-07-31 14:05:55.113+00	2025-07-31 14:05:55.113+00
b2723177-2ae3-4c89-a46e-32a90f1d6e1f	Healthcare	2025-07-31 14:05:55.113+00	2025-07-31 14:05:55.113+00
b12d23e2-c0fc-4682-b809-d744da6f5459	Energy	2025-07-31 14:05:55.113+00	2025-07-31 14:05:55.113+00
e4d62811-9912-4382-983a-642401627a57	Consumer Goods	2025-07-31 14:05:55.113+00	2025-07-31 14:05:55.113+00
ed74e669-92a3-4a02-ba71-6dcca451db6b	Industrial	2025-07-31 14:05:55.113+00	2025-07-31 14:05:55.113+00
ef2f5179-7d69-4908-8929-8269fb349085	Real Estate	2025-07-31 14:05:55.113+00	2025-07-31 14:05:55.113+00
398d96d2-a82f-4da6-91d2-91563bf0b281	Telecommunications	2025-07-31 14:05:55.113+00	2025-07-31 14:05:55.113+00
99e8033b-b97c-426f-bbf0-84962a34cc7e	Utilities	2025-07-31 14:05:55.113+00	2025-07-31 14:05:55.113+00
3b404265-a3b5-4113-af7e-a0c0811a038c	Materials	2025-07-31 14:05:55.113+00	2025-07-31 14:05:55.113+00
\.


--
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.settings (id, title, timezone, phone, email, country, city, location, address, logo, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: signature_records; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.signature_records (record_id, document_id, deal_id, user_id, signed_date, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: social_account_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.social_account_types (type_id, name, "createdAt", "updatedAt") FROM stdin;
d9299f77-f0d0-4da8-847f-2b4b540256e5	X	2025-07-31 14:05:55.079+00	2025-07-31 14:05:55.079+00
08b8e325-3494-4998-91d1-5a8925f67d88	LinkedIn	2025-07-31 14:05:55.079+00	2025-07-31 14:05:55.079+00
9936504e-c282-4904-9a47-77df027c92f7	Facebook	2025-07-31 14:05:55.079+00	2025-07-31 14:05:55.079+00
9749f85d-c4c2-4657-ab1f-defd514becd2	Instagram	2025-07-31 14:05:55.079+00	2025-07-31 14:05:55.079+00
\.


--
-- Data for Name: social_media_accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.social_media_accounts (account_id, user_id, social_account_type_id, link, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: stage_cards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stage_cards (card_id, pipeline_stage_id, user_id, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: sub_sector_preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sub_sector_preferences (preference_id, user_id, sub_sector_id, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: subfolder_access_invites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subfolder_access_invites (invite_id, subfolder_id, user_email, status, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: subfolders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subfolders (subfolder_id, name, created_by, created_for, parent_folder_id, parent_subfolder_id, archived, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: subsectors; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subsectors (subsector_id, name, sector_id, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tasks (task_id, title, description, status, assigned_to, created_by, deal_id, deal_stage_id, due_date, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions (transaction_id, deal_id, user_id, amount, payment_method, transaction_type, status, transaction_date, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: user_preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_preferences (preference_id, user_id, sector_id, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: user_reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_reviews (review_id, user_id, rating, review_note, relationship, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: user_ticket_preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_ticket_preferences (preference_id, user_id, ticket_size_min, ticket_size_max, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, profile_image, kyc_status, preference_sector, preference_region, password, role, role_id, status, total_investments, average_check_size, successful_exits, portfolio_ipr, description, addressable_market, current_market, total_assets, ebitda, gross_margin, cac_payback_period, tam, sam, som, year_founded, location, phone, "createdAt", "updatedAt", deleted_at, parent_user_id) FROM stdin;
2	Peal Agro	pealagro@example.com	https://example.com/images/pealagro.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
3	ABNO Softwares	abnosoftwares@example.com	https://example.com/images/abnosoftwares.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
4	AirDuka	airduka@example.com	https://example.com/images/airduka.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
5	Bethel Consult	bethelconsult@example.com	https://example.com/images/bethelconsult.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
6	666*	666@example.com	https://example.com/images/666.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
7	Six Squares Ltd	sixsquaresltd@example.com	https://example.com/images/sixsquaresltd.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
8	Eldo Tea	eldotea@example.com	https://example.com/images/eldotea.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
9	Machakos Millers	machakosmillers@example.com	https://example.com/images/machakosmillers.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
10	ALS	als@example.com	https://example.com/images/als.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
11	Amotech Africa	amotechafrica@example.com	https://example.com/images/amotechafrica.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
12	CIBO Industries Limited	ciboindustrieslimited@example.com	https://example.com/images/ciboindustrieslimited.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
13	Busia Chicken	busiachicken@example.com	https://example.com/images/busiachicken.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
14	Camino Ruiz	caminoruiz@example.com	https://example.com/images/caminoruiz.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
15	Babu Babu Commodities	babubabucommodities@example.com	https://example.com/images/babubabucommodities.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
16	The Big Thunder Nut	thebigthundernut@example.com	https://example.com/images/thebigthundernut.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
17	Jarine Limited	jarinelimited@example.com	https://example.com/images/jarinelimited.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
18	Harvest Berry Avocado	harvestberryavocado@example.com	https://example.com/images/harvestberryavocado.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
19	Kwalito	kwalito@example.com	https://example.com/images/kwalito.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
20	KK Foods	kkfoods@example.com	https://example.com/images/kkfoods.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
21	Arch Ventures	archventures@example.com	https://example.com/images/archventures.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
22	Gilfilian Airconditining	gilfilianairconditining@example.com	https://example.com/images/gilfilianairconditining.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
23	Kisumu Concrete Products Ltd	kisumuconcreteproductsltd@example.com	https://example.com/images/kisumuconcreteproductsltd.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
24	Thika School of Medical and Health Sciences	thikaschoolofmedicalandhealthsciences@example.com	https://example.com/images/thikaschoolofmedicalandhealthsciences.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
25	NWH College	nwhcollege@example.com	https://example.com/images/nwhcollege.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
26	St. Lawrence University	stlawrenceuniversity@example.com	https://example.com/images/stlawrenceuniversity.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
27	Lakewood Group of Schools	lakewoodgroupofschools@example.com	https://example.com/images/lakewoodgroupofschools.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
28	BrazAfric Group of Companies	brazafricgroupofcompanies@example.com	https://example.com/images/brazafricgroupofcompanies.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
29	All in Trade	allintrade@example.com	https://example.com/images/allintrade.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
30	Zonful Energy	zonfulenergy@example.com	https://example.com/images/zonfulenergy.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
31	MobileMart	mobilemart@example.com	https://example.com/images/mobilemart.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
32	3KM Energy Systems Ltd	3kmenergysystemsltd@example.com	https://example.com/images/3kmenergysystemsltd.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
33	Country Energy (Uganda) Limited	countryenergyugandalimited@example.com	https://example.com/images/countryenergyugandalimited.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
34	Victoria Commercial Bank	victoriacommercialbank@example.com	https://example.com/images/victoriacommercialbank.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
35	Brisk Credit	briskcredit@example.com	https://example.com/images/briskcredit.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
36	KWFT	kwft@example.com	https://example.com/images/kwft.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
37	Chicken Basket	chickenbasket@example.com	https://example.com/images/chickenbasket.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
38	SUMAC MFB	sumacmfb@example.com	https://example.com/images/sumacmfb.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
39	Octagon	octagon@example.com	https://example.com/images/octagon.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
40	Jijenge Credit Ltd	jijengecreditltd@example.com	https://example.com/images/jijengecreditltd.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
41	Musoni MFI	musonimfi@example.com	https://example.com/images/musonimfi.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
42	Rafode	rafode@example.com	https://example.com/images/rafode.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
43	Middle East Bank Kenya	middleeastbankkenya@example.com	https://example.com/images/middleeastbankkenya.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
44	Credit Bank	creditbank@example.com	https://example.com/images/creditbank.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
45	Edenbridge	edenbridge@example.com	https://example.com/images/edenbridge.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
46	Development Bank	developmentbank@example.com	https://example.com/images/developmentbank.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
47	Family Bank	familybank@example.com	https://example.com/images/familybank.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
48	Paramount Bank	paramountbank@example.com	https://example.com/images/paramountbank.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
49	DigiTax	digitax@example.com	https://example.com/images/digitax.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
50	Madison Insurance	madisoninsurance@example.com	https://example.com/images/madisoninsurance.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
51	Yako Bank Uganda Ltd	yakobankugandaltd@example.com	https://example.com/images/yakobankugandaltd.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
52	Tip-point Capital	tippointcapital@example.com	https://example.com/images/tippointcapital.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
53	Kuza Factors Ltd	kuzafactorsltd@example.com	https://example.com/images/kuzafactorsltd.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
54	Huduma Credit Ltd	hudumacreditltd@example.com	https://example.com/images/hudumacreditltd.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
55	4G Capital	4gcapital@example.com	https://example.com/images/4gcapital.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
56	Asante Financial	asantefinancial@example.com	https://example.com/images/asantefinancial.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
57	Bowip Agencies	bowipagencies@example.com	https://example.com/images/bowipagencies.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
58	Kanini Haraka	kaniniharaka@example.com	https://example.com/images/kaniniharaka.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
59	Africa Inuka Hospital	africainukahospital@example.com	https://example.com/images/africainukahospital.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
60	Philmed	philmed@example.com	https://example.com/images/philmed.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
61	Faida Marketplace	faidamarketplace@example.com	https://example.com/images/faidamarketplace.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
62	Flame Tree Group	flametreegroup@example.com	https://example.com/images/flametreegroup.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
63	Valley Hospital	valleyhospital@example.com	https://example.com/images/valleyhospital.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
64	Kenark Healthcare	kenarkhealthcare@example.com	https://example.com/images/kenarkhealthcare.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
65	LaFemme Healthcare	lafemmehealthcare@example.com	https://example.com/images/lafemmehealthcare.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
66	Inspire Wellness Center	inspirewellnesscenter@example.com	https://example.com/images/inspirewellnesscenter.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
67	Ruai Family Hospital	ruaifamilyhospital@example.com	https://example.com/images/ruaifamilyhospital.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
68	Nairobi Radiotherapy and Cancer Center	nairobiradiotherapyandcancercenter@example.com	https://example.com/images/nairobiradiotherapyandcancercenter.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
69	Imperio Medical Group	imperiomedicalgroup@example.com	https://example.com/images/imperiomedicalgroup.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
70	NWH Hospital	nwhhospital@example.com	https://example.com/images/nwhhospital.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
71	Huruma Nursing Homes	hurumanursinghomes@example.com	https://example.com/images/hurumanursinghomes.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
72	Scanlab Center	scanlabcenter@example.com	https://example.com/images/scanlabcenter.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
73	Reale Medical Center	realemedicalcenter@example.com	https://example.com/images/realemedicalcenter.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
74	Mediheal Group of Hospitals	medihealgroupofhospitals@example.com	https://example.com/images/medihealgroupofhospitals.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
75	South B Hospital	southbhospital@example.com	https://example.com/images/southbhospital.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
76	Langata Hospital	langatahospital@example.com	https://example.com/images/langatahospital.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
77	Diani Beach Hospital	dianibeachhospital@example.com	https://example.com/images/dianibeachhospital.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
78	Kisumu Specialists Hospital	kisumuspecialistshospital@example.com	https://example.com/images/kisumuspecialistshospital.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
79	Pine Hospital	pinehospital@example.com	https://example.com/images/pinehospital.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
80	Kiambu Diagnostic Imaging Center	kiambudiagnosticimagingcenter@example.com	https://example.com/images/kiambudiagnosticimagingcenter.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
81	Apicalmed Limited	apicalmedlimited@example.com	https://example.com/images/apicalmedlimited.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
82	St. Bridget Hospital	stbridgethospital@example.com	https://example.com/images/stbridgethospital.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
83	Mwanainchi Bakery	mwanainchibakery@example.com	https://example.com/images/mwanainchibakery.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
84	Emeraude Kivu Resort Hotel Rwanda	emeraudekivuresorthotelrwanda@example.com	https://example.com/images/emeraudekivuresorthotelrwanda.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
85	Sun and Sand Beach	sunandsandbeach@example.com	https://example.com/images/sunandsandbeach.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
86	Le Petit Village Kampala	lepetitvillagekampala@example.com	https://example.com/images/lepetitvillagekampala.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
87	Rosslyn House Limited	rosslynhouselimited@example.com	https://example.com/images/rosslynhouselimited.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
88	Number 7	number7@example.com	https://example.com/images/number7.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
89	Acorn Holdings	acornholdings@example.com	https://example.com/images/acornholdings.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
90	Classic Mouldings	classicmouldings@example.com	https://example.com/images/classicmouldings.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
91	Kocela	kocela@example.com	https://example.com/images/kocela.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
92	Proteq Automation	proteqautomation@example.com	https://example.com/images/proteqautomation.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
93	Gas Africa	gasafrica@example.com	https://example.com/images/gasafrica.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
94	Kutuma Kenya Ltd	kutumakenyaltd@example.com	https://example.com/images/kutumakenyaltd.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
95	HighChem East Africa Group	highchemeastafricagroup@example.com	https://example.com/images/highchemeastafricagroup.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
96	Unified Chemicals	unifiedchemicals@example.com	https://example.com/images/unifiedchemicals.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
97	Auto Springs	autosprings@example.com	https://example.com/images/autosprings.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
98	LinePlast Group	lineplastgroup@example.com	https://example.com/images/lineplastgroup.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
99	United Paints Ltd	unitedpaintsltd@example.com	https://example.com/images/unitedpaintsltd.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
100	Marini Naturals	marininaturals@example.com	https://example.com/images/marininaturals.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
101	Metro Concepts EA	metroconceptsea@example.com	https://example.com/images/metroconceptsea.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
102	Melchizedek Hospital	melchizedekhospital@example.com	https://example.com/images/melchizedekhospital.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
103	DnR Studios	dnrstudios@example.com	https://example.com/images/dnrstudios.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
104	Waterfront Karen	waterfrontkaren@example.com	https://example.com/images/waterfrontkaren.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
105	BestLady Cosmetics	bestladycosmetics@example.com	https://example.com/images/bestladycosmetics.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
106	Kinde Engineering	kindeengineering@example.com	https://example.com/images/kindeengineering.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
107	Mukurweini Wakulima Dairy Ltd	mukurweiniwakulimadairyltd@example.com	https://example.com/images/mukurweiniwakulimadairyltd.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
108	Xado East Africa	xadoeastafrica@example.com	https://example.com/images/xadoeastafrica.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
109	MyCredit Limited	mycreditlimited@example.com	https://example.com/images/mycreditlimited.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
110	Quipbank	quipbank@example.com	https://example.com/images/quipbank.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
111	Vivid Gold	vividgold@example.com	https://example.com/images/vividgold.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
112	SympliFi Ltd	symplifiltd@example.com	https://example.com/images/symplifiltd.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
113	Raka Milk Processors	rakamilkprocessors@example.com	https://example.com/images/rakamilkprocessors.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
114	Skillsasa	skillsasa@example.com	https://example.com/images/skillsasa.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
115	Taraji School	tarajischool@example.com	https://example.com/images/tarajischool.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
116	Enabling Finance Uganda	enablingfinanceuganda@example.com	https://example.com/images/enablingfinanceuganda.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
117	Kelsoko	kelsoko@example.com	https://example.com/images/kelsoko.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
118	Okolea Fintech	okoleafintech@example.com	https://example.com/images/okoleafintech.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
119	UMBA Inc	umbainc@example.com	https://example.com/images/umbainc.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
120	Cyber Security Africa	cybersecurityafrica@example.com	https://example.com/images/cybersecurityafrica.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
121	Sunrise Virtual	sunrisevirtual@example.com	https://example.com/images/sunrisevirtual.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
122	Malipo Circles	malipocircles@example.com	https://example.com/images/malipocircles.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
123	Unumed	unumed@example.com	https://example.com/images/unumed.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
124	Westlands Medical	westlandsmedical@example.com	https://example.com/images/westlandsmedical.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
125	TransAfrica Water Systems	transafricawatersystems@example.com	https://example.com/images/transafricawatersystems.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
126	Country Energy (Uganda) Ltd	countryenergyugandaltd@example.com	https://example.com/images/countryenergyugandaltd.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
127	Project Mocha Limited	projectmochalimited@example.com	https://example.com/images/projectmochalimited.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
128	Davu AI	davuai@example.com	https://example.com/images/davuai.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
129	Interconsumer Products Limited(ICPL)	interconsumerproductslimitedicpl@example.com	https://example.com/images/interconsumerproductslimitedicpl.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
130	Umoja Microfiance- Uganda	umojamicrofianceuganda@example.com	https://example.com/images/umojamicrofianceuganda.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
131	Godai Limited	godailimited@example.com	https://example.com/images/godailimited.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
132	Clinical Research Health Network	clinicalresearchhealthnetwork@example.com	https://example.com/images/clinicalresearchhealthnetwork.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
133	Jeen Mata Microfinance	jeenmatamicrofinance@example.com	https://example.com/images/jeenmatamicrofinance.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
134	Truesales Credit	truesalescredit@example.com	https://example.com/images/truesalescredit.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
135	ECLOF Uganda	eclofuganda@example.com	https://example.com/images/eclofuganda.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
136	Geviton	geviton@example.com	https://example.com/images/geviton.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
137	Pabit HPP	pabithpp@example.com	https://example.com/images/pabithpp.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
138	Resus Energy	resusenergy@example.com	https://example.com/images/resusenergy.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
139	ZenDawa	zendawa@example.com	https://example.com/images/zendawa.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
140	Eden Care Healthcare	edencarehealthcare@example.com	https://example.com/images/edencarehealthcare.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
141	Mwendo Delivery	mwendodelivery@example.com	https://example.com/images/mwendodelivery.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
142	AKM Glitters Limited	akmglitterslimited@example.com	https://example.com/images/akmglitterslimited.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
143	Eco foods & cereals Ltd	ecofoodscerealsltd@example.com	https://example.com/images/ecofoodscerealsltd.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
144	Ed Partners	edpartners@example.com	https://example.com/images/edpartners.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
145	RhoKIT	rhokit@example.com	https://example.com/images/rhokit.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
146	Blue Waters Hotel	bluewatershotel@example.com	https://example.com/images/bluewatershotel.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
147	Ranalo Credit	ranalocredit@example.com	https://example.com/images/ranalocredit.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
148	Khetia Drapers Ltd (KDL)	khetiadrapersltdkdl@example.com	https://example.com/images/khetiadrapersltdkdl.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	7ec75893-52c9-4a48-b165-bef37d49fb30	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
1	Alicia Bakers & Confectioners Ltd	aliciabakersconfectionersltd@example.com	https://example.com/images/aliciabakersconfectionersltd.jpg	Verified	["Tech","Finance"]	["North America","Europe"]	$2b$10$raeEOCY.7csBHxfQqCIdTuqTzaufBDbR3L4.JvT0Ec2Cle3SAZ6o.	Target Company	21d4489c-c819-494b-8280-5509f3a9f609	Open	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 14:05:55.321+00	2025-07-31 14:05:55.321+00	\N	\N
\.


--
-- Data for Name: verification_codes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.verification_codes (id, user_id, code, already_used, "createdAt", "updatedAt") FROM stdin;
1	1	932542	t	2025-07-31 14:14:37.132+00	2025-07-31 14:14:39.47+00
2	1	192630	t	2025-07-31 19:28:36.432+00	2025-07-31 19:29:07.538+00
3	1	727226	t	2025-07-31 19:41:22.423+00	2025-07-31 19:41:33.263+00
4	1	592742	t	2025-08-01 09:02:42.344+00	2025-08-01 09:02:45.261+00
5	1	166893	t	2025-08-01 09:12:20.867+00	2025-08-01 09:12:23.536+00
6	1	359227	t	2025-08-01 09:19:46.29+00	2025-08-01 09:19:47.775+00
7	1	696340	t	2025-08-01 09:20:08.442+00	2025-08-01 09:20:09.694+00
8	1	201856	t	2025-08-01 09:25:18.106+00	2025-08-01 09:25:19.491+00
9	1	514896	t	2025-08-01 09:31:57.629+00	2025-08-01 09:31:59.058+00
10	1	218412	t	2025-08-01 09:40:47.788+00	2025-08-01 09:40:49.874+00
11	1	205455	f	2025-08-01 10:22:02.84+00	2025-08-01 10:22:02.84+00
12	1	428677	f	2025-08-01 10:29:10.344+00	2025-08-01 10:29:10.344+00
13	1	132728	t	2025-08-01 10:59:18.516+00	2025-08-01 11:02:06.543+00
14	1	313529	t	2025-08-01 11:03:41.798+00	2025-08-01 11:03:43.34+00
15	1	362413	t	2025-08-01 11:16:49.151+00	2025-08-01 11:16:50.216+00
16	1	125129	t	2025-08-01 11:17:06.482+00	2025-08-01 11:17:07.765+00
17	1	309408	t	2025-08-01 11:54:02.393+00	2025-08-01 11:54:03.95+00
18	1	930585	t	2025-08-01 12:09:59.382+00	2025-08-01 12:10:00.537+00
19	1	457476	t	2025-08-01 12:10:09.629+00	2025-08-01 12:10:11.221+00
20	1	995606	t	2025-08-01 12:11:01.167+00	2025-08-01 12:11:02.168+00
21	1	123114	t	2025-08-01 12:18:56.099+00	2025-08-01 12:18:57.303+00
22	1	211856	t	2025-08-01 12:20:56.625+00	2025-08-01 12:20:58.136+00
23	1	570942	t	2025-08-02 11:04:43.493+00	2025-08-02 11:04:44.862+00
24	1	613296	t	2025-08-02 11:31:36.54+00	2025-08-02 11:31:39.421+00
25	1	467965	t	2025-08-02 11:32:10.098+00	2025-08-02 11:32:12.145+00
26	1	510922	t	2025-08-02 12:02:07.518+00	2025-08-02 12:02:08.672+00
27	1	415461	t	2025-08-02 12:15:25.205+00	2025-08-02 12:15:26.753+00
28	1	112955	t	2025-08-02 12:22:22.647+00	2025-08-02 12:22:23.933+00
29	1	418008	t	2025-08-02 12:23:26.698+00	2025-08-02 12:23:27.853+00
30	1	285459	t	2025-08-02 12:28:11.841+00	2025-08-02 12:28:12.991+00
31	1	265551	t	2025-08-02 12:42:18.108+00	2025-08-02 12:42:19.423+00
32	1	867213	t	2025-08-02 12:50:54.151+00	2025-08-02 12:50:55.347+00
33	1	659818	t	2025-08-02 12:54:06.223+00	2025-08-02 12:54:07.331+00
34	1	388741	t	2025-08-02 12:56:43.864+00	2025-08-02 12:56:44.867+00
35	1	455909	t	2025-08-02 12:57:02.669+00	2025-08-02 12:57:03.736+00
36	1	865032	t	2025-08-02 12:59:53.979+00	2025-08-02 12:59:55.061+00
37	1	440372	t	2025-08-02 13:02:33.733+00	2025-08-02 13:02:34.759+00
38	1	488809	t	2025-08-02 13:10:35.82+00	2025-08-02 13:10:37.12+00
39	1	437227	t	2025-08-02 13:16:57.914+00	2025-08-02 13:16:59.197+00
40	1	521396	t	2025-08-02 13:27:24.897+00	2025-08-02 13:27:26.025+00
41	1	585333	t	2025-08-02 13:30:08.459+00	2025-08-02 13:30:09.593+00
42	1	239344	t	2025-08-02 13:32:39.044+00	2025-08-02 13:32:40.174+00
43	1	226403	t	2025-08-02 13:33:26.256+00	2025-08-02 13:33:27.423+00
44	1	249078	t	2025-08-02 13:39:32.883+00	2025-08-02 13:39:34.105+00
45	1	244824	t	2025-08-02 13:40:32.838+00	2025-08-02 13:40:34.055+00
46	1	307449	t	2025-08-02 13:47:42.391+00	2025-08-02 13:47:43.35+00
47	1	688751	t	2025-08-02 13:50:13.425+00	2025-08-02 13:50:15.399+00
48	1	392004	t	2025-08-02 13:50:58.938+00	2025-08-02 13:51:00.051+00
49	1	740159	t	2025-08-02 13:51:27.676+00	2025-08-02 13:51:28.51+00
50	1	871787	t	2025-08-02 13:52:16.699+00	2025-08-02 13:52:18.419+00
51	1	294840	t	2025-08-02 13:55:00.198+00	2025-08-02 13:55:01.138+00
52	1	333386	t	2025-08-02 13:57:49.913+00	2025-08-02 13:57:50.918+00
53	1	471141	t	2025-08-02 14:01:39.985+00	2025-08-02 14:01:41.075+00
54	1	122466	t	2025-08-02 14:03:24.216+00	2025-08-02 14:03:25.148+00
55	1	279885	t	2025-08-02 14:14:51.6+00	2025-08-02 14:14:52.692+00
56	1	175458	t	2025-08-02 14:22:52.08+00	2025-08-02 14:22:53.156+00
57	1	367303	t	2025-08-02 14:26:26.088+00	2025-08-02 14:26:27.043+00
58	1	858078	t	2025-08-02 14:27:06.526+00	2025-08-02 14:27:07.561+00
59	1	786080	t	2025-08-02 14:27:46.02+00	2025-08-02 14:27:47.177+00
60	1	781648	t	2025-08-02 14:30:30.125+00	2025-08-02 14:30:31.613+00
61	1	800566	t	2025-08-02 14:32:43.19+00	2025-08-02 14:32:44.665+00
62	1	989960	t	2025-08-02 14:34:57.434+00	2025-08-02 14:34:58.452+00
63	1	868582	t	2025-08-02 14:35:20.887+00	2025-08-02 14:35:21.871+00
64	1	627210	t	2025-08-02 14:42:51.424+00	2025-08-02 14:43:10.784+00
65	1	227783	t	2025-08-02 14:51:09.372+00	2025-08-02 15:16:18.313+00
66	1	626914	t	2025-08-02 15:24:00.008+00	2025-08-02 15:24:01.148+00
67	1	388308	t	2025-08-02 15:24:11.872+00	2025-08-02 15:24:12.929+00
68	1	960260	t	2025-08-02 15:25:35.368+00	2025-08-02 15:25:41.558+00
69	1	964624	t	2025-08-02 15:29:00.969+00	2025-08-02 15:31:13.271+00
70	1	202322	t	2025-08-02 15:32:16.472+00	2025-08-02 15:32:18.3+00
71	1	526986	t	2025-08-02 15:33:40.392+00	2025-08-02 15:33:41.852+00
72	1	825031	t	2025-08-02 15:36:57.403+00	2025-08-02 15:36:58.773+00
73	1	158498	t	2025-08-02 15:40:12.748+00	2025-08-02 15:40:16.455+00
74	1	334323	t	2025-08-02 15:41:30.213+00	2025-08-02 15:41:31.691+00
75	1	909422	t	2025-08-02 15:47:30.028+00	2025-08-02 15:47:31.563+00
76	1	148852	t	2025-08-02 15:49:26.671+00	2025-08-02 15:49:27.574+00
77	1	325524	t	2025-08-02 15:51:16.025+00	2025-08-02 15:51:19.788+00
78	1	485695	t	2025-08-02 15:55:18.657+00	2025-08-02 15:55:19.888+00
79	1	344338	t	2025-08-02 15:59:20.028+00	2025-08-02 15:59:21.101+00
80	1	740521	t	2025-08-02 16:01:20.132+00	2025-08-02 16:01:21.292+00
81	1	610321	t	2025-08-02 16:01:24.123+00	2025-08-02 16:01:25.113+00
82	1	705321	t	2025-08-02 16:01:52.298+00	2025-08-02 16:01:53.149+00
83	1	766839	t	2025-08-02 16:01:55.751+00	2025-08-02 16:01:56.556+00
84	1	519941	t	2025-08-02 16:02:17.119+00	2025-08-02 16:02:18.142+00
85	1	866944	t	2025-08-02 16:02:38.897+00	2025-08-02 16:02:39.923+00
86	1	959025	t	2025-08-02 16:02:42.896+00	2025-08-02 16:02:43.67+00
87	1	815703	t	2025-08-02 16:02:48.711+00	2025-08-02 16:02:49.521+00
88	1	800569	t	2025-08-02 16:02:59.309+00	2025-08-02 16:03:00.19+00
89	1	558949	t	2025-08-02 16:03:04.868+00	2025-08-02 16:03:05.553+00
90	1	742418	t	2025-08-02 16:03:07.567+00	2025-08-02 16:03:08.369+00
91	1	683816	t	2025-08-02 16:03:13.585+00	2025-08-02 16:03:14.372+00
92	1	324012	t	2025-08-02 16:03:32.848+00	2025-08-02 16:03:33.786+00
93	1	211132	t	2025-08-02 16:03:35.849+00	2025-08-02 16:03:36.564+00
94	1	237788	t	2025-08-02 16:03:41.927+00	2025-08-02 16:03:42.759+00
95	1	907284	t	2025-08-02 16:04:27.231+00	2025-08-02 16:04:28.042+00
96	1	651609	t	2025-08-02 16:04:38.203+00	2025-08-02 16:04:39.251+00
97	1	900237	t	2025-08-02 16:07:24.225+00	2025-08-02 16:07:25.135+00
98	1	442979	t	2025-08-02 16:07:39.953+00	2025-08-02 16:07:40.832+00
99	1	363414	t	2025-08-02 16:08:00.562+00	2025-08-02 16:08:01.498+00
100	1	882442	t	2025-08-02 16:08:34.616+00	2025-08-02 16:08:35.913+00
101	1	319482	t	2025-08-02 16:20:14.665+00	2025-08-02 16:20:24.005+00
102	1	577622	t	2025-08-02 16:20:33.83+00	2025-08-02 16:20:35.243+00
103	1	624251	t	2025-08-02 16:20:46.158+00	2025-08-02 16:20:49.256+00
104	1	957305	t	2025-08-02 16:20:58.486+00	2025-08-02 16:21:00.125+00
105	1	556078	t	2025-08-02 16:21:11.529+00	2025-08-02 16:21:12.96+00
106	1	332236	t	2025-08-02 16:21:23.267+00	2025-08-02 16:21:24.164+00
107	1	751405	t	2025-08-02 16:21:26.942+00	2025-08-02 16:21:27.893+00
108	1	407935	t	2025-08-02 16:21:33.058+00	2025-08-02 16:21:33.948+00
109	1	567438	t	2025-08-02 16:21:46.902+00	2025-08-02 16:21:47.81+00
110	1	551872	t	2025-08-02 16:22:04.281+00	2025-08-02 16:22:05.407+00
111	1	358613	t	2025-08-02 16:22:14.315+00	2025-08-02 16:22:15.553+00
112	1	786695	t	2025-08-02 16:23:30.928+00	2025-08-02 16:23:31.709+00
113	1	392514	t	2025-08-02 16:23:33.917+00	2025-08-02 16:23:34.829+00
114	1	138472	t	2025-08-02 16:23:39.194+00	2025-08-02 16:23:40.526+00
115	1	346293	t	2025-08-02 16:24:22.007+00	2025-08-02 16:24:23.307+00
116	1	619140	t	2025-08-02 16:34:45.057+00	2025-08-02 16:34:46.186+00
117	1	370053	t	2025-08-02 16:34:48.944+00	2025-08-02 16:34:49.898+00
118	1	931502	t	2025-08-02 16:36:14.43+00	2025-08-02 16:36:15.659+00
119	1	555828	t	2025-08-02 16:36:20.004+00	2025-08-02 16:36:20.733+00
120	1	292526	t	2025-08-02 16:37:25.514+00	2025-08-02 16:37:26.522+00
121	1	266052	t	2025-08-02 16:55:08.126+00	2025-08-02 16:55:09.171+00
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 148, true);


--
-- Name: verification_codes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.verification_codes_id_seq', 121, true);


--
-- Name: SequelizeMeta SequelizeMeta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SequelizeMeta"
    ADD CONSTRAINT "SequelizeMeta_pkey" PRIMARY KEY (name);


--
-- Name: audit_logs audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (log_id);


--
-- Name: contact_people contact_people_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_people
    ADD CONSTRAINT contact_people_email_key UNIQUE (email);


--
-- Name: contact_people contact_people_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_people
    ADD CONSTRAINT contact_people_pkey PRIMARY KEY (contact_id);


--
-- Name: contact_persons contact_persons_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_persons
    ADD CONSTRAINT contact_persons_email_key UNIQUE (email);


--
-- Name: contact_persons contact_persons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_persons
    ADD CONSTRAINT contact_persons_pkey PRIMARY KEY (contact_id);


--
-- Name: continent_preferences continent_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.continent_preferences
    ADD CONSTRAINT continent_preferences_pkey PRIMARY KEY (preference_id);


--
-- Name: continents continents_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.continents
    ADD CONSTRAINT continents_name_key UNIQUE (name);


--
-- Name: continents continents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.continents
    ADD CONSTRAINT continents_pkey PRIMARY KEY (continent_id);


--
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (country_id);


--
-- Name: country_preferences country_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country_preferences
    ADD CONSTRAINT country_preferences_pkey PRIMARY KEY (preference_id);


--
-- Name: deal_access_invites deal_access_invites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_access_invites
    ADD CONSTRAINT deal_access_invites_pkey PRIMARY KEY (invite_id);


--
-- Name: deal_continents deal_continents_deal_id_continent_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_continents
    ADD CONSTRAINT deal_continents_deal_id_continent_id_key UNIQUE (deal_id, continent_id);


--
-- Name: deal_continents deal_continents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_continents
    ADD CONSTRAINT deal_continents_pkey PRIMARY KEY (id);


--
-- Name: deal_countries deal_countries_deal_id_country_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_countries
    ADD CONSTRAINT deal_countries_deal_id_country_id_key UNIQUE (deal_id, country_id);


--
-- Name: deal_countries deal_countries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_countries
    ADD CONSTRAINT deal_countries_pkey PRIMARY KEY (id);


--
-- Name: deal_leads deal_leads_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_leads
    ADD CONSTRAINT deal_leads_pkey PRIMARY KEY (id);


--
-- Name: deal_meetings deal_meetings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_meetings
    ADD CONSTRAINT deal_meetings_pkey PRIMARY KEY (meeting_id);


--
-- Name: deal_milestone_statuses deal_milestone_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_milestone_statuses
    ADD CONSTRAINT deal_milestone_statuses_pkey PRIMARY KEY (id);


--
-- Name: deal_milestones deal_milestones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_milestones
    ADD CONSTRAINT deal_milestones_pkey PRIMARY KEY (milestone_id);


--
-- Name: deal_regions deal_regions_deal_id_region_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_regions
    ADD CONSTRAINT deal_regions_deal_id_region_id_key UNIQUE (deal_id, region_id);


--
-- Name: deal_regions deal_regions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_regions
    ADD CONSTRAINT deal_regions_pkey PRIMARY KEY (id);


--
-- Name: deal_stages deal_stages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_stages
    ADD CONSTRAINT deal_stages_pkey PRIMARY KEY (stage_id);


--
-- Name: deal_type_preferences deal_type_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_type_preferences
    ADD CONSTRAINT deal_type_preferences_pkey PRIMARY KEY (preference_id);


--
-- Name: deals deals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deals
    ADD CONSTRAINT deals_pkey PRIMARY KEY (deal_id);


--
-- Name: document_share document_share_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_share
    ADD CONSTRAINT document_share_pkey PRIMARY KEY (share_id);


--
-- Name: document_shares document_shares_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_shares
    ADD CONSTRAINT document_shares_pkey PRIMARY KEY (share_id);


--
-- Name: document_types document_types_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_types
    ADD CONSTRAINT document_types_name_key UNIQUE (name);


--
-- Name: document_types document_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_types
    ADD CONSTRAINT document_types_pkey PRIMARY KEY (type_id);


--
-- Name: documents documents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (document_id);


--
-- Name: folder_access_invites folder_access_invites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.folder_access_invites
    ADD CONSTRAINT folder_access_invites_pkey PRIMARY KEY (invite_id);


--
-- Name: folders folders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.folders
    ADD CONSTRAINT folders_pkey PRIMARY KEY (folder_id);


--
-- Name: investor_deal_stages investor_deal_stages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.investor_deal_stages
    ADD CONSTRAINT investor_deal_stages_pkey PRIMARY KEY (id);


--
-- Name: investor_milestone_statuses investor_milestone_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.investor_milestone_statuses
    ADD CONSTRAINT investor_milestone_statuses_pkey PRIMARY KEY (id);


--
-- Name: investor_milestones investor_milestones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.investor_milestones
    ADD CONSTRAINT investor_milestones_pkey PRIMARY KEY (milestone_id);


--
-- Name: investors_deals investors_deals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.investors_deals
    ADD CONSTRAINT investors_deals_pkey PRIMARY KEY (investor_id, deal_id);


--
-- Name: invoices invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_pkey PRIMARY KEY (invoice_id);


--
-- Name: milestones milestones_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.milestones
    ADD CONSTRAINT milestones_pkey PRIMARY KEY (milestone_id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (notification_id);


--
-- Name: permissions permissions_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_name_key UNIQUE (name);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (permission_id);


--
-- Name: pipeline_stages pipeline_stages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pipeline_stages
    ADD CONSTRAINT pipeline_stages_pkey PRIMARY KEY (stage_id);


--
-- Name: pipelines pipelines_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pipelines
    ADD CONSTRAINT pipelines_name_key UNIQUE (name);


--
-- Name: pipelines pipelines_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pipelines
    ADD CONSTRAINT pipelines_pkey PRIMARY KEY (pipeline_id);


--
-- Name: primary_location_preferences primary_location_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.primary_location_preferences
    ADD CONSTRAINT primary_location_preferences_pkey PRIMARY KEY (preference_id);


--
-- Name: region_preferences region_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.region_preferences
    ADD CONSTRAINT region_preferences_pkey PRIMARY KEY (preference_id);


--
-- Name: regions regions_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_name_key UNIQUE (name);


--
-- Name: regions regions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (region_id);


--
-- Name: role_permissions role_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_pkey PRIMARY KEY (role_permission_id);


--
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (role_id);


--
-- Name: sector_preferences sector_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sector_preferences
    ADD CONSTRAINT sector_preferences_pkey PRIMARY KEY (preference_id);


--
-- Name: sectors sectors_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sectors
    ADD CONSTRAINT sectors_name_key UNIQUE (name);


--
-- Name: sectors sectors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sectors
    ADD CONSTRAINT sectors_pkey PRIMARY KEY (sector_id);


--
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);


--
-- Name: signature_records signature_records_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.signature_records
    ADD CONSTRAINT signature_records_pkey PRIMARY KEY (record_id);


--
-- Name: social_account_types social_account_types_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.social_account_types
    ADD CONSTRAINT social_account_types_name_key UNIQUE (name);


--
-- Name: social_account_types social_account_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.social_account_types
    ADD CONSTRAINT social_account_types_pkey PRIMARY KEY (type_id);


--
-- Name: social_media_accounts social_media_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.social_media_accounts
    ADD CONSTRAINT social_media_accounts_pkey PRIMARY KEY (account_id);


--
-- Name: stage_cards stage_cards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stage_cards
    ADD CONSTRAINT stage_cards_pkey PRIMARY KEY (card_id);


--
-- Name: sub_sector_preferences sub_sector_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sub_sector_preferences
    ADD CONSTRAINT sub_sector_preferences_pkey PRIMARY KEY (preference_id);


--
-- Name: subfolder_access_invites subfolder_access_invites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subfolder_access_invites
    ADD CONSTRAINT subfolder_access_invites_pkey PRIMARY KEY (invite_id);


--
-- Name: subfolders subfolders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subfolders
    ADD CONSTRAINT subfolders_pkey PRIMARY KEY (subfolder_id);


--
-- Name: subsectors subsectors_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subsectors
    ADD CONSTRAINT subsectors_name_key UNIQUE (name);


--
-- Name: subsectors subsectors_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subsectors
    ADD CONSTRAINT subsectors_pkey PRIMARY KEY (subsector_id);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (task_id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (transaction_id);


--
-- Name: user_preferences user_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_preferences
    ADD CONSTRAINT user_preferences_pkey PRIMARY KEY (preference_id);


--
-- Name: user_reviews user_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_reviews
    ADD CONSTRAINT user_reviews_pkey PRIMARY KEY (review_id);


--
-- Name: user_ticket_preferences user_ticket_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_ticket_preferences
    ADD CONSTRAINT user_ticket_preferences_pkey PRIMARY KEY (preference_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: verification_codes verification_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.verification_codes
    ADD CONSTRAINT verification_codes_pkey PRIMARY KEY (id);


--
-- Name: audit_logs audit_logs_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: contact_people contact_people_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_people
    ADD CONSTRAINT contact_people_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: contact_persons contact_persons_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_persons
    ADD CONSTRAINT contact_persons_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: continent_preferences continent_preferences_continent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.continent_preferences
    ADD CONSTRAINT continent_preferences_continent_id_fkey FOREIGN KEY (continent_id) REFERENCES public.continents(continent_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: continent_preferences continent_preferences_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.continent_preferences
    ADD CONSTRAINT continent_preferences_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: countries countries_continent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_continent_id_fkey FOREIGN KEY (continent_id) REFERENCES public.continents(continent_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: countries countries_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_region_id_fkey FOREIGN KEY (region_id) REFERENCES public.regions(region_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: country_preferences country_preferences_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country_preferences
    ADD CONSTRAINT country_preferences_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.countries(country_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: country_preferences country_preferences_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.country_preferences
    ADD CONSTRAINT country_preferences_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- Name: deal_access_invites deal_access_invites_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_access_invites
    ADD CONSTRAINT deal_access_invites_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deals(deal_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: deal_access_invites deal_access_invites_investor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_access_invites
    ADD CONSTRAINT deal_access_invites_investor_id_fkey FOREIGN KEY (investor_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: deal_continents deal_continents_continent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_continents
    ADD CONSTRAINT deal_continents_continent_id_fkey FOREIGN KEY (continent_id) REFERENCES public.continents(continent_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: deal_continents deal_continents_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_continents
    ADD CONSTRAINT deal_continents_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deals(deal_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: deal_countries deal_countries_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_countries
    ADD CONSTRAINT deal_countries_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.countries(country_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: deal_countries deal_countries_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_countries
    ADD CONSTRAINT deal_countries_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deals(deal_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: deal_leads deal_leads_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_leads
    ADD CONSTRAINT deal_leads_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deals(deal_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: deal_leads deal_leads_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_leads
    ADD CONSTRAINT deal_leads_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: deal_meetings deal_meetings_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_meetings
    ADD CONSTRAINT deal_meetings_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deals(deal_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: deal_milestone_statuses deal_milestone_statuses_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_milestone_statuses
    ADD CONSTRAINT deal_milestone_statuses_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deals(deal_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: deal_milestone_statuses deal_milestone_statuses_deal_milestone_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_milestone_statuses
    ADD CONSTRAINT deal_milestone_statuses_deal_milestone_id_fkey FOREIGN KEY (deal_milestone_id) REFERENCES public.deal_milestones(milestone_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: deal_regions deal_regions_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_regions
    ADD CONSTRAINT deal_regions_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deals(deal_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: deal_regions deal_regions_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_regions
    ADD CONSTRAINT deal_regions_region_id_fkey FOREIGN KEY (region_id) REFERENCES public.regions(region_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: deal_stages deal_stages_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_stages
    ADD CONSTRAINT deal_stages_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: deal_type_preferences deal_type_preferences_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deal_type_preferences
    ADD CONSTRAINT deal_type_preferences_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: deals deals_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deals
    ADD CONSTRAINT deals_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: deals deals_deal_lead_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deals
    ADD CONSTRAINT deals_deal_lead_fkey FOREIGN KEY (deal_lead) REFERENCES public.users(id);


--
-- Name: deals deals_deal_stage_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deals
    ADD CONSTRAINT deals_deal_stage_id_fkey FOREIGN KEY (deal_stage_id) REFERENCES public.deal_stages(stage_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: deals deals_sector_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deals
    ADD CONSTRAINT deals_sector_id_fkey FOREIGN KEY (sector_id) REFERENCES public.sectors(sector_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: deals deals_subsector_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deals
    ADD CONSTRAINT deals_subsector_id_fkey FOREIGN KEY (subsector_id) REFERENCES public.subsectors(subsector_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: deals deals_target_company_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deals
    ADD CONSTRAINT deals_target_company_id_fkey FOREIGN KEY (target_company_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: document_share document_share_document_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_share
    ADD CONSTRAINT document_share_document_id_fkey FOREIGN KEY (document_id) REFERENCES public.documents(document_id);


--
-- Name: document_shares document_shares_document_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_shares
    ADD CONSTRAINT document_shares_document_id_fkey FOREIGN KEY (document_id) REFERENCES public.documents(document_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: document_shares document_shares_shared_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_shares
    ADD CONSTRAINT document_shares_shared_by_fkey FOREIGN KEY (shared_by) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: documents documents_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deals(deal_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: documents documents_document_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_document_type_id_fkey FOREIGN KEY (document_type_id) REFERENCES public.document_types(type_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: documents documents_folder_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_folder_id_fkey FOREIGN KEY (folder_id) REFERENCES public.folders(folder_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: documents documents_subfolder_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_subfolder_id_fkey FOREIGN KEY (subfolder_id) REFERENCES public.subfolders(subfolder_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: documents documents_uploaded_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_uploaded_by_fkey FOREIGN KEY (uploaded_by) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: folder_access_invites folder_access_invites_folder_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.folder_access_invites
    ADD CONSTRAINT folder_access_invites_folder_id_fkey FOREIGN KEY (folder_id) REFERENCES public.folders(folder_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: folders folders_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.folders
    ADD CONSTRAINT folders_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: folders folders_created_for_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.folders
    ADD CONSTRAINT folders_created_for_fkey FOREIGN KEY (created_for) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: investor_deal_stages investor_deal_stages_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.investor_deal_stages
    ADD CONSTRAINT investor_deal_stages_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deals(deal_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: investor_deal_stages investor_deal_stages_investor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.investor_deal_stages
    ADD CONSTRAINT investor_deal_stages_investor_id_fkey FOREIGN KEY (investor_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: investor_deal_stages investor_deal_stages_stage_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.investor_deal_stages
    ADD CONSTRAINT investor_deal_stages_stage_id_fkey FOREIGN KEY (stage_id) REFERENCES public.deal_stages(stage_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: investor_milestone_statuses investor_milestone_statuses_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.investor_milestone_statuses
    ADD CONSTRAINT investor_milestone_statuses_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deals(deal_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: investor_milestone_statuses investor_milestone_statuses_investor_milestone_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.investor_milestone_statuses
    ADD CONSTRAINT investor_milestone_statuses_investor_milestone_id_fkey FOREIGN KEY (investor_milestone_id) REFERENCES public.investor_milestones(milestone_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: investor_milestone_statuses investor_milestone_statuses_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.investor_milestone_statuses
    ADD CONSTRAINT investor_milestone_statuses_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: investors_deals investors_deals_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.investors_deals
    ADD CONSTRAINT investors_deals_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deals(deal_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: investors_deals investors_deals_investor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.investors_deals
    ADD CONSTRAINT investors_deals_investor_id_fkey FOREIGN KEY (investor_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: invoices invoices_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deals(deal_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: invoices invoices_milestone_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_milestone_id_fkey FOREIGN KEY (milestone_id) REFERENCES public.milestones(milestone_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: milestones milestones_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.milestones
    ADD CONSTRAINT milestones_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deals(deal_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: milestones milestones_deal_stage_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.milestones
    ADD CONSTRAINT milestones_deal_stage_id_fkey FOREIGN KEY (deal_stage_id) REFERENCES public.deal_stages(stage_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: notifications notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: pipeline_stages pipeline_stages_pipeline_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pipeline_stages
    ADD CONSTRAINT pipeline_stages_pipeline_id_fkey FOREIGN KEY (pipeline_id) REFERENCES public.pipelines(pipeline_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: primary_location_preferences primary_location_preferences_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.primary_location_preferences
    ADD CONSTRAINT primary_location_preferences_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.countries(country_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: primary_location_preferences primary_location_preferences_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.primary_location_preferences
    ADD CONSTRAINT primary_location_preferences_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: region_preferences region_preferences_region_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.region_preferences
    ADD CONSTRAINT region_preferences_region_id_fkey FOREIGN KEY (region_id) REFERENCES public.regions(region_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: region_preferences region_preferences_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.region_preferences
    ADD CONSTRAINT region_preferences_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: regions regions_continent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.regions
    ADD CONSTRAINT regions_continent_id_fkey FOREIGN KEY (continent_id) REFERENCES public.continents(continent_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: role_permissions role_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES public.permissions(permission_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: role_permissions role_permissions_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(role_id) ON UPDATE CASCADE;


--
-- Name: sector_preferences sector_preferences_sector_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sector_preferences
    ADD CONSTRAINT sector_preferences_sector_id_fkey FOREIGN KEY (sector_id) REFERENCES public.sectors(sector_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sector_preferences sector_preferences_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sector_preferences
    ADD CONSTRAINT sector_preferences_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: signature_records signature_records_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.signature_records
    ADD CONSTRAINT signature_records_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deals(deal_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: signature_records signature_records_document_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.signature_records
    ADD CONSTRAINT signature_records_document_id_fkey FOREIGN KEY (document_id) REFERENCES public.documents(document_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: signature_records signature_records_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.signature_records
    ADD CONSTRAINT signature_records_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: social_media_accounts social_media_accounts_social_account_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.social_media_accounts
    ADD CONSTRAINT social_media_accounts_social_account_type_id_fkey FOREIGN KEY (social_account_type_id) REFERENCES public.social_account_types(type_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: social_media_accounts social_media_accounts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.social_media_accounts
    ADD CONSTRAINT social_media_accounts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: stage_cards stage_cards_pipeline_stage_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stage_cards
    ADD CONSTRAINT stage_cards_pipeline_stage_id_fkey FOREIGN KEY (pipeline_stage_id) REFERENCES public.pipeline_stages(stage_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: stage_cards stage_cards_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stage_cards
    ADD CONSTRAINT stage_cards_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- Name: sub_sector_preferences sub_sector_preferences_sub_sector_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sub_sector_preferences
    ADD CONSTRAINT sub_sector_preferences_sub_sector_id_fkey FOREIGN KEY (sub_sector_id) REFERENCES public.subsectors(subsector_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sub_sector_preferences sub_sector_preferences_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sub_sector_preferences
    ADD CONSTRAINT sub_sector_preferences_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: subfolder_access_invites subfolder_access_invites_subfolder_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subfolder_access_invites
    ADD CONSTRAINT subfolder_access_invites_subfolder_id_fkey FOREIGN KEY (subfolder_id) REFERENCES public.subfolders(subfolder_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: subfolders subfolders_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subfolders
    ADD CONSTRAINT subfolders_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- Name: subfolders subfolders_created_for_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subfolders
    ADD CONSTRAINT subfolders_created_for_fkey FOREIGN KEY (created_for) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: subfolders subfolders_parent_folder_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subfolders
    ADD CONSTRAINT subfolders_parent_folder_id_fkey FOREIGN KEY (parent_folder_id) REFERENCES public.folders(folder_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: subfolders subfolders_parent_subfolder_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subfolders
    ADD CONSTRAINT subfolders_parent_subfolder_id_fkey FOREIGN KEY (parent_subfolder_id) REFERENCES public.subfolders(subfolder_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: subsectors subsectors_sector_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subsectors
    ADD CONSTRAINT subsectors_sector_id_fkey FOREIGN KEY (sector_id) REFERENCES public.sectors(sector_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: tasks tasks_assigned_to_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_assigned_to_fkey FOREIGN KEY (assigned_to) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: tasks tasks_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: tasks tasks_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deals(deal_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: tasks tasks_deal_stage_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_deal_stage_id_fkey FOREIGN KEY (deal_stage_id) REFERENCES public.deal_stages(stage_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: transactions transactions_deal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_deal_id_fkey FOREIGN KEY (deal_id) REFERENCES public.deals(deal_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: transactions transactions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_preferences user_preferences_sector_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_preferences
    ADD CONSTRAINT user_preferences_sector_id_fkey FOREIGN KEY (sector_id) REFERENCES public.sectors(sector_id) ON UPDATE CASCADE;


--
-- Name: user_preferences user_preferences_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_preferences
    ADD CONSTRAINT user_preferences_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_reviews user_reviews_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_reviews
    ADD CONSTRAINT user_reviews_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_ticket_preferences user_ticket_preferences_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_ticket_preferences
    ADD CONSTRAINT user_ticket_preferences_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users users_parent_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_parent_user_id_fkey FOREIGN KEY (parent_user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: users users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(role_id) ON UPDATE CASCADE;


--
-- Name: verification_codes verification_codes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.verification_codes
    ADD CONSTRAINT verification_codes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--


--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

-- Started on 2025-04-15 15:26:15 CST

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
-- TOC entry 2 (class 3079 OID 16404)
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- TOC entry 4588 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 219 (class 1259 OID 16415)
-- Name: account_integrates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_integrates (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    account_id uuid NOT NULL,
    provider character varying(16) NOT NULL,
    open_id character varying(255) NOT NULL,
    encrypted_token character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.account_integrates OWNER TO postgres;

--
-- TOC entry 294 (class 1259 OID 17400)
-- Name: account_plugin_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_plugin_permissions (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    install_permission character varying(16) DEFAULT 'everyone'::character varying NOT NULL,
    debug_permission character varying(16) DEFAULT 'noone'::character varying NOT NULL
);


ALTER TABLE public.account_plugin_permissions OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16429)
-- Name: accounts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounts (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255),
    password_salt character varying(255),
    avatar character varying(255),
    interface_language character varying(255),
    interface_theme character varying(255),
    timezone character varying(255),
    last_login_at timestamp without time zone,
    last_login_ip character varying(255),
    status character varying(16) DEFAULT 'active'::character varying NOT NULL,
    initialized_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    last_active_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.accounts OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16399)
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 16965)
-- Name: api_based_extensions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.api_based_extensions (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    api_endpoint character varying(255) NOT NULL,
    api_key text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.api_based_extensions OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16441)
-- Name: api_requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.api_requests (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    api_token_id uuid NOT NULL,
    path character varying(255) NOT NULL,
    request text,
    response text,
    ip character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.api_requests OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16451)
-- Name: api_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.api_tokens (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid,
    type character varying(16) NOT NULL,
    token character varying(255) NOT NULL,
    last_used_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    tenant_id uuid
);


ALTER TABLE public.api_tokens OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 16988)
-- Name: app_annotation_hit_histories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.app_annotation_hit_histories (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    annotation_id uuid NOT NULL,
    source text NOT NULL,
    question text NOT NULL,
    account_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    score double precision DEFAULT 0 NOT NULL,
    message_id uuid NOT NULL,
    annotation_question text NOT NULL,
    annotation_content text NOT NULL
);


ALTER TABLE public.app_annotation_hit_histories OWNER TO postgres;

--
-- TOC entry 267 (class 1259 OID 17004)
-- Name: app_annotation_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.app_annotation_settings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    score_threshold double precision DEFAULT 0 NOT NULL,
    collection_binding_id uuid NOT NULL,
    created_user_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_user_id uuid NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.app_annotation_settings OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16460)
-- Name: app_dataset_joins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.app_dataset_joins (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    dataset_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.app_dataset_joins OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16468)
-- Name: app_model_configs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.app_model_configs (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    provider character varying(255),
    model_id character varying(255),
    configs json,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    opening_statement text,
    suggested_questions text,
    suggested_questions_after_answer text,
    more_like_this text,
    model text,
    user_input_form text,
    pre_prompt text,
    agent_mode text,
    speech_to_text text,
    sensitive_word_avoidance text,
    retriever_resource text,
    dataset_query_variable character varying(255),
    prompt_type character varying(255) DEFAULT 'simple'::character varying NOT NULL,
    chat_prompt_config text,
    completion_prompt_config text,
    dataset_configs text,
    external_data_tools text,
    file_upload text,
    text_to_speech text,
    created_by uuid,
    updated_by uuid
);


ALTER TABLE public.app_model_configs OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16479)
-- Name: apps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.apps (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    mode character varying(255) NOT NULL,
    icon character varying(255),
    icon_background character varying(255),
    app_model_config_id uuid,
    status character varying(255) DEFAULT 'normal'::character varying NOT NULL,
    enable_site boolean NOT NULL,
    enable_api boolean NOT NULL,
    api_rpm integer DEFAULT 0 NOT NULL,
    api_rph integer DEFAULT 0 NOT NULL,
    is_demo boolean DEFAULT false NOT NULL,
    is_public boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    is_universal boolean DEFAULT false NOT NULL,
    workflow_id uuid,
    description text DEFAULT ''::character varying NOT NULL,
    tracing text,
    max_active_requests integer,
    icon_type character varying(255),
    created_by uuid,
    updated_by uuid,
    use_icon_as_answer_icon boolean DEFAULT false NOT NULL
);


ALTER TABLE public.apps OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16493)
-- Name: task_id_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.task_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.task_id_sequence OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16495)
-- Name: celery_taskmeta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.celery_taskmeta (
    id integer DEFAULT nextval('public.task_id_sequence'::regclass) NOT NULL,
    task_id character varying(155),
    status character varying(50),
    result bytea,
    date_done timestamp without time zone,
    traceback text,
    name character varying(155),
    args bytea,
    kwargs bytea,
    worker character varying(155),
    retries integer,
    queue character varying(155)
);


ALTER TABLE public.celery_taskmeta OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16494)
-- Name: taskset_id_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.taskset_id_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.taskset_id_sequence OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16505)
-- Name: celery_tasksetmeta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.celery_tasksetmeta (
    id integer DEFAULT nextval('public.taskset_id_sequence'::regclass) NOT NULL,
    taskset_id character varying(155),
    result bytea,
    date_done timestamp without time zone
);


ALTER TABLE public.celery_tasksetmeta OWNER TO postgres;

--
-- TOC entry 292 (class 1259 OID 17366)
-- Name: child_chunks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.child_chunks (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    dataset_id uuid NOT NULL,
    document_id uuid NOT NULL,
    segment_id uuid NOT NULL,
    "position" integer NOT NULL,
    content text NOT NULL,
    word_count integer NOT NULL,
    index_node_id character varying(255),
    index_node_hash character varying(255),
    type character varying(255) DEFAULT 'automatic'::character varying NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_by uuid,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    indexing_at timestamp without time zone,
    completed_at timestamp without time zone,
    error text
);


ALTER TABLE public.child_chunks OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16515)
-- Name: conversations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conversations (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    app_model_config_id uuid,
    model_provider character varying(255),
    override_model_configs text,
    model_id character varying(255),
    mode character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    summary text,
    inputs json NOT NULL,
    introduction text,
    system_instruction text,
    system_instruction_tokens integer DEFAULT 0 NOT NULL,
    status character varying(255) NOT NULL,
    from_source character varying(255) NOT NULL,
    from_end_user_id uuid,
    from_account_id uuid,
    read_at timestamp without time zone,
    read_account_id uuid,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    is_deleted boolean DEFAULT false NOT NULL,
    invoke_from character varying(255),
    dialogue_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.conversations OWNER TO postgres;

--
-- TOC entry 284 (class 1259 OID 17237)
-- Name: data_source_api_key_auth_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.data_source_api_key_auth_bindings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    category character varying(255) NOT NULL,
    provider character varying(255) NOT NULL,
    credentials text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    disabled boolean DEFAULT false
);


ALTER TABLE public.data_source_api_key_auth_bindings OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 16845)
-- Name: data_source_oauth_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.data_source_oauth_bindings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    access_token character varying(255) NOT NULL,
    provider character varying(255) NOT NULL,
    source_info jsonb NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    disabled boolean DEFAULT false
);


ALTER TABLE public.data_source_oauth_bindings OWNER TO postgres;

--
-- TOC entry 293 (class 1259 OID 17378)
-- Name: dataset_auto_disable_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dataset_auto_disable_logs (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    dataset_id uuid NOT NULL,
    document_id uuid NOT NULL,
    notified boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.dataset_auto_disable_logs OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 16955)
-- Name: dataset_collection_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dataset_collection_bindings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    provider_name character varying(255) NOT NULL,
    model_name character varying(255) NOT NULL,
    collection_name character varying(64) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    type character varying(40) DEFAULT 'dataset'::character varying NOT NULL
);


ALTER TABLE public.dataset_collection_bindings OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16527)
-- Name: dataset_keyword_tables; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dataset_keyword_tables (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    dataset_id uuid NOT NULL,
    keyword_table text NOT NULL,
    data_source_type character varying(255) DEFAULT 'database'::character varying NOT NULL
);


ALTER TABLE public.dataset_keyword_tables OWNER TO postgres;

--
-- TOC entry 296 (class 1259 OID 17430)
-- Name: dataset_metadata_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dataset_metadata_bindings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    dataset_id uuid NOT NULL,
    metadata_id uuid NOT NULL,
    document_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    created_by uuid NOT NULL
);


ALTER TABLE public.dataset_metadata_bindings OWNER TO postgres;

--
-- TOC entry 297 (class 1259 OID 17441)
-- Name: dataset_metadatas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dataset_metadatas (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    dataset_id uuid NOT NULL,
    type character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    created_by uuid NOT NULL,
    updated_by uuid
);


ALTER TABLE public.dataset_metadatas OWNER TO postgres;

--
-- TOC entry 286 (class 1259 OID 17277)
-- Name: dataset_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dataset_permissions (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    dataset_id uuid NOT NULL,
    account_id uuid NOT NULL,
    has_permission boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    tenant_id uuid NOT NULL
);


ALTER TABLE public.dataset_permissions OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16538)
-- Name: dataset_process_rules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dataset_process_rules (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    dataset_id uuid NOT NULL,
    mode character varying(255) DEFAULT 'automatic'::character varying NOT NULL,
    rules text,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.dataset_process_rules OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16549)
-- Name: dataset_queries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dataset_queries (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    dataset_id uuid NOT NULL,
    content text NOT NULL,
    source character varying(255) NOT NULL,
    source_app_id uuid,
    created_by_role character varying NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.dataset_queries OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 16945)
-- Name: dataset_retriever_resources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dataset_retriever_resources (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    message_id uuid NOT NULL,
    "position" integer NOT NULL,
    dataset_id uuid NOT NULL,
    dataset_name text NOT NULL,
    document_id uuid,
    document_name text NOT NULL,
    data_source_type text,
    segment_id uuid,
    score double precision,
    content text NOT NULL,
    hit_count integer,
    word_count integer,
    segment_position integer,
    index_node_hash text,
    retriever_from text NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.dataset_retriever_resources OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16559)
-- Name: datasets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.datasets (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    provider character varying(255) DEFAULT 'vendor'::character varying NOT NULL,
    permission character varying(255) DEFAULT 'only_me'::character varying NOT NULL,
    data_source_type character varying(255),
    indexing_technique character varying(255),
    index_struct text,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_by uuid,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    embedding_model character varying(255) DEFAULT 'text-embedding-ada-002'::character varying,
    embedding_model_provider character varying(255) DEFAULT 'openai'::character varying,
    collection_binding_id uuid,
    retrieval_model jsonb,
    built_in_field_enabled boolean DEFAULT false NOT NULL
);


ALTER TABLE public.datasets OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16572)
-- Name: dify_setups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dify_setups (
    version character varying(255) NOT NULL,
    setup_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.dify_setups OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16578)
-- Name: document_segments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.document_segments (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    dataset_id uuid NOT NULL,
    document_id uuid NOT NULL,
    "position" integer NOT NULL,
    content text NOT NULL,
    word_count integer NOT NULL,
    tokens integer NOT NULL,
    keywords json,
    index_node_id character varying(255),
    index_node_hash character varying(255),
    hit_count integer NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    disabled_at timestamp without time zone,
    disabled_by uuid,
    status character varying(255) DEFAULT 'waiting'::character varying NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    indexing_at timestamp without time zone,
    completed_at timestamp without time zone,
    error text,
    stopped_at timestamp without time zone,
    answer text,
    updated_by uuid,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.document_segments OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16594)
-- Name: documents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.documents (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    dataset_id uuid NOT NULL,
    "position" integer NOT NULL,
    data_source_type character varying(255) NOT NULL,
    data_source_info text,
    dataset_process_rule_id uuid,
    batch character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    created_from character varying(255) NOT NULL,
    created_by uuid NOT NULL,
    created_api_request_id uuid,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    processing_started_at timestamp without time zone,
    file_id text,
    word_count integer,
    parsing_completed_at timestamp without time zone,
    cleaning_completed_at timestamp without time zone,
    splitting_completed_at timestamp without time zone,
    tokens integer,
    indexing_latency double precision,
    completed_at timestamp without time zone,
    is_paused boolean DEFAULT false,
    paused_by uuid,
    paused_at timestamp without time zone,
    error text,
    stopped_at timestamp without time zone,
    indexing_status character varying(255) DEFAULT 'waiting'::character varying NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    disabled_at timestamp without time zone,
    disabled_by uuid,
    archived boolean DEFAULT false NOT NULL,
    archived_reason character varying(255),
    archived_by uuid,
    archived_at timestamp without time zone,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    doc_type character varying(40),
    doc_metadata jsonb,
    doc_form character varying(255) DEFAULT 'text_model'::character varying NOT NULL,
    doc_language character varying(255)
);


ALTER TABLE public.documents OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16610)
-- Name: embeddings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.embeddings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    hash character varying(64) NOT NULL,
    embedding bytea NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    model_name character varying(255) DEFAULT 'text-embedding-ada-002'::character varying NOT NULL,
    provider_name character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.embeddings OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16621)
-- Name: end_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.end_users (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    app_id uuid,
    type character varying(255) NOT NULL,
    external_user_id character varying(255),
    name character varying(255),
    is_anonymous boolean DEFAULT true NOT NULL,
    session_id character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.end_users OWNER TO postgres;

--
-- TOC entry 288 (class 1259 OID 17313)
-- Name: external_knowledge_apis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.external_knowledge_apis (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255) NOT NULL,
    tenant_id uuid NOT NULL,
    settings text,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_by uuid,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.external_knowledge_apis OWNER TO postgres;

--
-- TOC entry 289 (class 1259 OID 17325)
-- Name: external_knowledge_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.external_knowledge_bindings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    external_knowledge_api_id uuid NOT NULL,
    dataset_id uuid NOT NULL,
    external_knowledge_id text NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_by uuid,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.external_knowledge_bindings OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 16634)
-- Name: installed_apps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.installed_apps (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    app_id uuid NOT NULL,
    app_owner_tenant_id uuid NOT NULL,
    "position" integer NOT NULL,
    is_pinned boolean DEFAULT false NOT NULL,
    last_used_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.installed_apps OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 16647)
-- Name: invitation_codes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invitation_codes (
    id integer NOT NULL,
    batch character varying(255) NOT NULL,
    code character varying(32) NOT NULL,
    status character varying(16) DEFAULT 'unused'::character varying NOT NULL,
    used_at timestamp without time zone,
    used_by_tenant_id uuid,
    used_by_account_id uuid,
    deprecated_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.invitation_codes OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16646)
-- Name: invitation_codes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.invitation_codes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.invitation_codes_id_seq OWNER TO postgres;

--
-- TOC entry 4589 (class 0 OID 0)
-- Dependencies: 241
-- Name: invitation_codes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.invitation_codes_id_seq OWNED BY public.invitation_codes.id;


--
-- TOC entry 282 (class 1259 OID 17201)
-- Name: load_balancing_model_configs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.load_balancing_model_configs (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    provider_name character varying(255) NOT NULL,
    model_name character varying(255) NOT NULL,
    model_type character varying(40) NOT NULL,
    name character varying(255) NOT NULL,
    encrypted_config text,
    enabled boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.load_balancing_model_configs OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 16657)
-- Name: message_agent_thoughts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.message_agent_thoughts (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    message_id uuid NOT NULL,
    message_chain_id uuid,
    "position" integer NOT NULL,
    thought text,
    tool text,
    tool_input text,
    observation text,
    tool_process_data text,
    message text,
    message_token integer,
    message_unit_price numeric,
    answer text,
    answer_token integer,
    answer_unit_price numeric,
    tokens integer,
    total_price numeric,
    currency character varying,
    latency double precision,
    created_by_role character varying NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    message_price_unit numeric(10,7) DEFAULT 0.001 NOT NULL,
    answer_price_unit numeric(10,7) DEFAULT 0.001 NOT NULL,
    message_files text,
    tool_labels_str text DEFAULT '{}'::text NOT NULL,
    tool_meta_str text DEFAULT '{}'::text NOT NULL
);


ALTER TABLE public.message_agent_thoughts OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 16807)
-- Name: message_annotations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.message_annotations (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    conversation_id uuid,
    message_id uuid,
    content text NOT NULL,
    account_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    question text,
    hit_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.message_annotations OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 16668)
-- Name: message_chains; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.message_chains (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    message_id uuid NOT NULL,
    type character varying(255) NOT NULL,
    input text,
    output text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.message_chains OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 16678)
-- Name: message_feedbacks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.message_feedbacks (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    conversation_id uuid NOT NULL,
    message_id uuid NOT NULL,
    rating character varying(255) NOT NULL,
    content text,
    from_source character varying(255) NOT NULL,
    from_end_user_id uuid,
    from_account_id uuid,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.message_feedbacks OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 16975)
-- Name: message_files; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.message_files (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    message_id uuid NOT NULL,
    type character varying(255) NOT NULL,
    transfer_method character varying(255) NOT NULL,
    url text,
    upload_file_id uuid,
    created_by_role character varying(255) NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    belongs_to character varying(255)
);


ALTER TABLE public.message_files OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 16820)
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    model_provider character varying(255),
    model_id character varying(255),
    override_model_configs text,
    conversation_id uuid NOT NULL,
    inputs json NOT NULL,
    query text NOT NULL,
    message json NOT NULL,
    message_tokens integer DEFAULT 0 NOT NULL,
    message_unit_price numeric(10,4) NOT NULL,
    answer text NOT NULL,
    answer_tokens integer DEFAULT 0 NOT NULL,
    answer_unit_price numeric(10,4) NOT NULL,
    provider_response_latency double precision DEFAULT 0 NOT NULL,
    total_price numeric(10,7),
    currency character varying(255) NOT NULL,
    from_source character varying(255) NOT NULL,
    from_end_user_id uuid,
    from_account_id uuid,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    agent_based boolean DEFAULT false NOT NULL,
    message_price_unit numeric(10,7) DEFAULT 0.001 NOT NULL,
    answer_price_unit numeric(10,7) DEFAULT 0.001 NOT NULL,
    workflow_run_id uuid,
    status character varying(255) DEFAULT 'normal'::character varying NOT NULL,
    error text,
    message_metadata text,
    invoke_from character varying(255),
    parent_message_id uuid
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 16691)
-- Name: operation_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.operation_logs (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    account_id uuid NOT NULL,
    action character varying(255) NOT NULL,
    content json,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    created_ip character varying(255) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.operation_logs OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 16702)
-- Name: pinned_conversations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pinned_conversations (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    conversation_id uuid NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    created_by_role character varying(255) DEFAULT 'end_user'::character varying NOT NULL
);


ALTER TABLE public.pinned_conversations OWNER TO postgres;

--
-- TOC entry 283 (class 1259 OID 17213)
-- Name: provider_model_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.provider_model_settings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    provider_name character varying(255) NOT NULL,
    model_name character varying(255) NOT NULL,
    model_type character varying(40) NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    load_balancing_enabled boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.provider_model_settings OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 16875)
-- Name: provider_models; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.provider_models (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    provider_name character varying(255) NOT NULL,
    model_name character varying(255) NOT NULL,
    model_type character varying(40) NOT NULL,
    encrypted_config text,
    is_valid boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.provider_models OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 16923)
-- Name: provider_orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.provider_orders (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    provider_name character varying(255) NOT NULL,
    account_id uuid NOT NULL,
    payment_product_id character varying(191) NOT NULL,
    payment_id character varying(191),
    transaction_id character varying(191),
    quantity integer DEFAULT 1 NOT NULL,
    currency character varying(40),
    total_amount integer,
    payment_status character varying(40) DEFAULT 'wait_pay'::character varying NOT NULL,
    paid_at timestamp without time zone,
    pay_failed_at timestamp without time zone,
    refunded_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.provider_orders OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 16710)
-- Name: providers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.providers (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    provider_name character varying(255) NOT NULL,
    provider_type character varying(40) DEFAULT 'custom'::character varying NOT NULL,
    encrypted_config text,
    is_valid boolean DEFAULT false NOT NULL,
    last_used timestamp without time zone,
    quota_type character varying(40) DEFAULT ''::character varying,
    quota_limit bigint,
    quota_used bigint,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.providers OWNER TO postgres;

--
-- TOC entry 295 (class 1259 OID 17419)
-- Name: rate_limit_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rate_limit_logs (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    subscription_plan character varying(255) NOT NULL,
    operation character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.rate_limit_logs OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 16726)
-- Name: recommended_apps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recommended_apps (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    description json NOT NULL,
    copyright character varying(255) NOT NULL,
    privacy_policy character varying(255) NOT NULL,
    category character varying(255) NOT NULL,
    "position" integer NOT NULL,
    is_listed boolean NOT NULL,
    install_count integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    language character varying(255) DEFAULT 'en-US'::character varying NOT NULL,
    custom_disclaimer text NOT NULL
);


ALTER TABLE public.recommended_apps OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 16738)
-- Name: saved_messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.saved_messages (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    message_id uuid NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    created_by_role character varying(255) DEFAULT 'end_user'::character varying NOT NULL
);


ALTER TABLE public.saved_messages OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 16757)
-- Name: sites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sites (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    title character varying(255) NOT NULL,
    icon character varying(255),
    icon_background character varying(255),
    description text,
    default_language character varying(255) NOT NULL,
    copyright character varying(255),
    privacy_policy character varying(255),
    customize_domain character varying(255),
    customize_token_strategy character varying(255) NOT NULL,
    prompt_public boolean DEFAULT false NOT NULL,
    status character varying(255) DEFAULT 'normal'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    code character varying(255),
    custom_disclaimer text NOT NULL,
    show_workflow_steps boolean DEFAULT true NOT NULL,
    chat_color_theme character varying(255),
    chat_color_theme_inverted boolean DEFAULT false NOT NULL,
    icon_type character varying(255),
    created_by uuid,
    updated_by uuid,
    use_icon_as_answer_icon boolean DEFAULT false NOT NULL
);


ALTER TABLE public.sites OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 17156)
-- Name: tag_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tag_bindings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid,
    tag_id uuid,
    target_id uuid,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.tag_bindings OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 17165)
-- Name: tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tags (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid,
    type character varying(16) NOT NULL,
    name character varying(255) NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.tags OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 16771)
-- Name: tenant_account_joins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tenant_account_joins (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    account_id uuid NOT NULL,
    role character varying(16) DEFAULT 'normal'::character varying NOT NULL,
    invited_by uuid,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    current boolean DEFAULT false NOT NULL
);


ALTER TABLE public.tenant_account_joins OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 16889)
-- Name: tenant_default_models; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tenant_default_models (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    provider_name character varying(255) NOT NULL,
    model_name character varying(255) NOT NULL,
    model_type character varying(40) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.tenant_default_models OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 16898)
-- Name: tenant_preferred_model_providers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tenant_preferred_model_providers (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    provider_name character varying(255) NOT NULL,
    preferred_provider_type character varying(40) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.tenant_preferred_model_providers OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 16784)
-- Name: tenants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tenants (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL,
    encrypt_public_key text,
    plan character varying(255) DEFAULT 'basic'::character varying NOT NULL,
    status character varying(255) DEFAULT 'normal'::character varying NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    custom_config text
);


ALTER TABLE public.tenants OWNER TO postgres;

--
-- TOC entry 290 (class 1259 OID 17339)
-- Name: tidb_auth_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tidb_auth_bindings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid,
    cluster_id character varying(255) NOT NULL,
    cluster_name character varying(255) NOT NULL,
    active boolean DEFAULT false NOT NULL,
    status character varying(255) DEFAULT 'CREATING'::character varying NOT NULL,
    account character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.tidb_auth_bindings OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 17016)
-- Name: tool_api_providers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tool_api_providers (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL,
    schema text NOT NULL,
    schema_type_str character varying(40) NOT NULL,
    user_id uuid NOT NULL,
    tenant_id uuid NOT NULL,
    tools_str text NOT NULL,
    icon character varying(255) NOT NULL,
    credentials_str text NOT NULL,
    description text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    privacy_policy character varying(255),
    custom_disclaimer text NOT NULL
);


ALTER TABLE public.tool_api_providers OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 17024)
-- Name: tool_builtin_providers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tool_builtin_providers (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid,
    user_id uuid NOT NULL,
    provider character varying(256) NOT NULL,
    encrypted_credentials text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.tool_builtin_providers OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 17069)
-- Name: tool_conversation_variables; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tool_conversation_variables (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    tenant_id uuid NOT NULL,
    conversation_id uuid NOT NULL,
    variables_str text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.tool_conversation_variables OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 17085)
-- Name: tool_files; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tool_files (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    tenant_id uuid NOT NULL,
    conversation_id uuid,
    file_key character varying(255) NOT NULL,
    mimetype character varying(255) NOT NULL,
    original_url character varying(2048),
    name character varying NOT NULL,
    size integer NOT NULL
);


ALTER TABLE public.tool_files OWNER TO postgres;

--
-- TOC entry 281 (class 1259 OID 17189)
-- Name: tool_label_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tool_label_bindings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tool_id character varying(64) NOT NULL,
    tool_type character varying(40) NOT NULL,
    label_name character varying(40) NOT NULL
);


ALTER TABLE public.tool_label_bindings OWNER TO postgres;

--
-- TOC entry 271 (class 1259 OID 17055)
-- Name: tool_model_invokes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tool_model_invokes (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    tenant_id uuid NOT NULL,
    provider character varying(255) NOT NULL,
    tool_type character varying(40) NOT NULL,
    tool_name character varying(40) NOT NULL,
    model_parameters text NOT NULL,
    prompt_messages text NOT NULL,
    model_response text NOT NULL,
    prompt_tokens integer DEFAULT 0 NOT NULL,
    answer_tokens integer DEFAULT 0 NOT NULL,
    answer_unit_price numeric(10,4) NOT NULL,
    answer_price_unit numeric(10,7) DEFAULT 0.001 NOT NULL,
    provider_response_latency double precision DEFAULT 0 NOT NULL,
    total_price numeric(10,7),
    currency character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.tool_model_invokes OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 17036)
-- Name: tool_published_apps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tool_published_apps (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    user_id uuid NOT NULL,
    description text NOT NULL,
    llm_description text NOT NULL,
    query_description text NOT NULL,
    query_name character varying(40) NOT NULL,
    tool_name character varying(40) NOT NULL,
    author character varying(40) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.tool_published_apps OWNER TO postgres;

--
-- TOC entry 280 (class 1259 OID 17174)
-- Name: tool_workflow_providers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tool_workflow_providers (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(255) NOT NULL,
    app_id uuid NOT NULL,
    user_id uuid NOT NULL,
    tenant_id uuid NOT NULL,
    description text NOT NULL,
    parameter_configuration text DEFAULT '[]'::text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    privacy_policy character varying(255) DEFAULT ''::character varying,
    version character varying(255) DEFAULT ''::character varying NOT NULL,
    label character varying(255) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.tool_workflow_providers OWNER TO postgres;

--
-- TOC entry 285 (class 1259 OID 17264)
-- Name: trace_app_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.trace_app_config (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    app_id uuid NOT NULL,
    tracing_provider character varying(255),
    tracing_config json,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    is_active boolean DEFAULT true NOT NULL
);


ALTER TABLE public.trace_app_config OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 16796)
-- Name: upload_files; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.upload_files (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    storage_type character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    size integer NOT NULL,
    extension character varying(255) NOT NULL,
    mime_type character varying(255),
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    used boolean DEFAULT false NOT NULL,
    used_by uuid,
    used_at timestamp without time zone,
    hash character varying(255),
    created_by_role character varying(255) DEFAULT 'account'::character varying NOT NULL,
    source_url text DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.upload_files OWNER TO postgres;

--
-- TOC entry 291 (class 1259 OID 17354)
-- Name: whitelists; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.whitelists (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid,
    category character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.whitelists OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 17106)
-- Name: workflow_app_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.workflow_app_logs (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    app_id uuid NOT NULL,
    workflow_id uuid NOT NULL,
    workflow_run_id uuid NOT NULL,
    created_from character varying(255) NOT NULL,
    created_by_role character varying(255) NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL
);


ALTER TABLE public.workflow_app_logs OWNER TO postgres;

--
-- TOC entry 287 (class 1259 OID 17297)
-- Name: workflow_conversation_variables; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.workflow_conversation_variables (
    id uuid NOT NULL,
    conversation_id uuid NOT NULL,
    app_id uuid NOT NULL,
    data text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.workflow_conversation_variables OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 17116)
-- Name: workflow_node_executions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.workflow_node_executions (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    app_id uuid NOT NULL,
    workflow_id uuid NOT NULL,
    triggered_from character varying(255) NOT NULL,
    workflow_run_id uuid,
    index integer NOT NULL,
    predecessor_node_id character varying(255),
    node_id character varying(255) NOT NULL,
    node_type character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    inputs text,
    process_data text,
    outputs text,
    status character varying(255) NOT NULL,
    error text,
    elapsed_time double precision DEFAULT 0 NOT NULL,
    execution_metadata text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    created_by_role character varying(255) NOT NULL,
    created_by uuid NOT NULL,
    finished_at timestamp without time zone,
    node_execution_id character varying(255)
);


ALTER TABLE public.workflow_node_executions OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 17128)
-- Name: workflow_runs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.workflow_runs (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    app_id uuid NOT NULL,
    sequence_number integer NOT NULL,
    workflow_id uuid NOT NULL,
    type character varying(255) NOT NULL,
    triggered_from character varying(255) NOT NULL,
    version character varying(255) NOT NULL,
    graph text,
    inputs text,
    status character varying(255) NOT NULL,
    outputs text,
    error text,
    elapsed_time double precision DEFAULT 0 NOT NULL,
    total_tokens bigint DEFAULT 0 NOT NULL,
    total_steps integer DEFAULT 0,
    created_by_role character varying(255) NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    finished_at timestamp without time zone,
    exceptions_count integer DEFAULT 0
);


ALTER TABLE public.workflow_runs OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 17141)
-- Name: workflows; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.workflows (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tenant_id uuid NOT NULL,
    app_id uuid NOT NULL,
    type character varying(255) NOT NULL,
    version character varying(255) NOT NULL,
    graph text NOT NULL,
    features text NOT NULL,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP(0) NOT NULL,
    updated_by uuid,
    updated_at timestamp without time zone NOT NULL,
    environment_variables text DEFAULT '{}'::text NOT NULL,
    conversation_variables text DEFAULT '{}'::text NOT NULL,
    marked_name character varying DEFAULT ''::character varying NOT NULL,
    marked_comment character varying DEFAULT ''::character varying NOT NULL
);


ALTER TABLE public.workflows OWNER TO postgres;

--
-- TOC entry 3844 (class 2604 OID 16650)
-- Name: invitation_codes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invitation_codes ALTER COLUMN id SET DEFAULT nextval('public.invitation_codes_id_seq'::regclass);


--
-- TOC entry 4504 (class 0 OID 16415)
-- Dependencies: 219
-- Data for Name: account_integrates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_integrates (id, account_id, provider, open_id, encrypted_token, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4579 (class 0 OID 17400)
-- Dependencies: 294
-- Data for Name: account_plugin_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_plugin_permissions (id, tenant_id, install_permission, debug_permission) FROM stdin;
\.


--
-- TOC entry 4505 (class 0 OID 16429)
-- Dependencies: 220
-- Data for Name: accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounts (id, name, email, password, password_salt, avatar, interface_language, interface_theme, timezone, last_login_at, last_login_ip, status, initialized_at, created_at, updated_at, last_active_at) FROM stdin;
cc67c45e-e65e-4177-94d6-1af3d06342f5	admin88@qq.com	admin88@qq.com	YTljMDhhMGZkZjc1MDQ0ZWU4YzI0NTAxMDY4ZDU1YjcxM2ZjODgzMmQzZTQyZGRiMjBkMGNiYjVjMTJkMWFkZg==	PVeyds5xTXc5fo0TLYpWKA==	\N	en-US	light	America/New_York	2025-04-11 03:30:22.931409	127.0.0.1	active	2025-04-09 06:50:11.120771	2025-04-09 06:50:11	2025-04-09 06:50:11	2025-04-15 02:01:04.586235
\.


--
-- TOC entry 4503 (class 0 OID 16399)
-- Dependencies: 218
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alembic_version (version_num) FROM stdin;
d20049ed0af6
\.


--
-- TOC entry 4549 (class 0 OID 16965)
-- Dependencies: 264
-- Data for Name: api_based_extensions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_based_extensions (id, tenant_id, name, api_endpoint, api_key, created_at) FROM stdin;
\.


--
-- TOC entry 4506 (class 0 OID 16441)
-- Dependencies: 221
-- Data for Name: api_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_requests (id, tenant_id, api_token_id, path, request, response, ip, created_at) FROM stdin;
\.


--
-- TOC entry 4507 (class 0 OID 16451)
-- Dependencies: 222
-- Data for Name: api_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.api_tokens (id, app_id, type, token, last_used_at, created_at, tenant_id) FROM stdin;
79d54558-23f0-43f6-9ae7-354c4f6eca08	c84265cd-993f-4287-acc4-d82660a43e42	app	app-1uRt3E1GkPdqyg5EyCrrMZRx	2025-04-11 09:52:57.127249	2025-04-11 09:51:38	358a104c-8954-4063-beb6-e7bb3ae5de0f
\.


--
-- TOC entry 4551 (class 0 OID 16988)
-- Dependencies: 266
-- Data for Name: app_annotation_hit_histories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.app_annotation_hit_histories (id, app_id, annotation_id, source, question, account_id, created_at, score, message_id, annotation_question, annotation_content) FROM stdin;
\.


--
-- TOC entry 4552 (class 0 OID 17004)
-- Dependencies: 267
-- Data for Name: app_annotation_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.app_annotation_settings (id, app_id, score_threshold, collection_binding_id, created_user_id, created_at, updated_user_id, updated_at) FROM stdin;
\.


--
-- TOC entry 4508 (class 0 OID 16460)
-- Dependencies: 223
-- Data for Name: app_dataset_joins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.app_dataset_joins (id, app_id, dataset_id, created_at) FROM stdin;
\.


--
-- TOC entry 4509 (class 0 OID 16468)
-- Dependencies: 224
-- Data for Name: app_model_configs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.app_model_configs (id, app_id, provider, model_id, configs, created_at, updated_at, opening_statement, suggested_questions, suggested_questions_after_answer, more_like_this, model, user_input_form, pre_prompt, agent_mode, speech_to_text, sensitive_word_avoidance, retriever_resource, dataset_query_variable, prompt_type, chat_prompt_config, completion_prompt_config, dataset_configs, external_data_tools, file_upload, text_to_speech, created_by, updated_by) FROM stdin;
\.


--
-- TOC entry 4510 (class 0 OID 16479)
-- Dependencies: 225
-- Data for Name: apps; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.apps (id, tenant_id, name, mode, icon, icon_background, app_model_config_id, status, enable_site, enable_api, api_rpm, api_rph, is_demo, is_public, created_at, updated_at, is_universal, workflow_id, description, tracing, max_active_requests, icon_type, created_by, updated_by, use_icon_as_answer_icon) FROM stdin;
3e96b986-3124-4fd2-93bd-26a45a194dd9	358a104c-8954-4063-beb6-e7bb3ae5de0f	Deep Research 	advanced-chat	🔍	#D1E9FF	\N	normal	t	t	0	0	f	f	2025-04-11 09:19:45	2025-04-11 09:24:31.851396	f	\N	Deep Research 	\N	\N	emoji	cc67c45e-e65e-4177-94d6-1af3d06342f5	cc67c45e-e65e-4177-94d6-1af3d06342f5	f
c84265cd-993f-4287-acc4-d82660a43e42	358a104c-8954-4063-beb6-e7bb3ae5de0f	MOBA游戏推荐	workflow	🤖	#FFEAD5	\N	normal	t	t	0	0	f	f	2025-04-11 09:24:52	2025-04-11 09:24:52	f	493c773d-d312-4efd-9193-edf1bb4fdc3a	MOBA游戏推荐	\N	\N	emoji	cc67c45e-e65e-4177-94d6-1af3d06342f5	cc67c45e-e65e-4177-94d6-1af3d06342f5	f
\.


--
-- TOC entry 4513 (class 0 OID 16495)
-- Dependencies: 228
-- Data for Name: celery_taskmeta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.celery_taskmeta (id, task_id, status, result, date_done, traceback, name, args, kwargs, worker, retries, queue) FROM stdin;
\.


--
-- TOC entry 4514 (class 0 OID 16505)
-- Dependencies: 229
-- Data for Name: celery_tasksetmeta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.celery_tasksetmeta (id, taskset_id, result, date_done) FROM stdin;
\.


--
-- TOC entry 4577 (class 0 OID 17366)
-- Dependencies: 292
-- Data for Name: child_chunks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.child_chunks (id, tenant_id, dataset_id, document_id, segment_id, "position", content, word_count, index_node_id, index_node_hash, type, created_by, created_at, updated_by, updated_at, indexing_at, completed_at, error) FROM stdin;
\.


--
-- TOC entry 4515 (class 0 OID 16515)
-- Dependencies: 230
-- Data for Name: conversations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conversations (id, app_id, app_model_config_id, model_provider, override_model_configs, model_id, mode, name, summary, inputs, introduction, system_instruction, system_instruction_tokens, status, from_source, from_end_user_id, from_account_id, read_at, read_account_id, created_at, updated_at, is_deleted, invoke_from, dialogue_count) FROM stdin;
\.


--
-- TOC entry 4569 (class 0 OID 17237)
-- Dependencies: 284
-- Data for Name: data_source_api_key_auth_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.data_source_api_key_auth_bindings (id, tenant_id, category, provider, credentials, created_at, updated_at, disabled) FROM stdin;
\.


--
-- TOC entry 4542 (class 0 OID 16845)
-- Dependencies: 257
-- Data for Name: data_source_oauth_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.data_source_oauth_bindings (id, tenant_id, access_token, provider, source_info, created_at, updated_at, disabled) FROM stdin;
\.


--
-- TOC entry 4578 (class 0 OID 17378)
-- Dependencies: 293
-- Data for Name: dataset_auto_disable_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dataset_auto_disable_logs (id, tenant_id, dataset_id, document_id, notified, created_at) FROM stdin;
\.


--
-- TOC entry 4548 (class 0 OID 16955)
-- Dependencies: 263
-- Data for Name: dataset_collection_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dataset_collection_bindings (id, provider_name, model_name, collection_name, created_at, type) FROM stdin;
\.


--
-- TOC entry 4516 (class 0 OID 16527)
-- Dependencies: 231
-- Data for Name: dataset_keyword_tables; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dataset_keyword_tables (id, dataset_id, keyword_table, data_source_type) FROM stdin;
\.


--
-- TOC entry 4581 (class 0 OID 17430)
-- Dependencies: 296
-- Data for Name: dataset_metadata_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dataset_metadata_bindings (id, tenant_id, dataset_id, metadata_id, document_id, created_at, created_by) FROM stdin;
\.


--
-- TOC entry 4582 (class 0 OID 17441)
-- Dependencies: 297
-- Data for Name: dataset_metadatas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dataset_metadatas (id, tenant_id, dataset_id, type, name, created_at, updated_at, created_by, updated_by) FROM stdin;
\.


--
-- TOC entry 4571 (class 0 OID 17277)
-- Dependencies: 286
-- Data for Name: dataset_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dataset_permissions (id, dataset_id, account_id, has_permission, created_at, tenant_id) FROM stdin;
\.


--
-- TOC entry 4517 (class 0 OID 16538)
-- Dependencies: 232
-- Data for Name: dataset_process_rules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dataset_process_rules (id, dataset_id, mode, rules, created_by, created_at) FROM stdin;
\.


--
-- TOC entry 4518 (class 0 OID 16549)
-- Dependencies: 233
-- Data for Name: dataset_queries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dataset_queries (id, dataset_id, content, source, source_app_id, created_by_role, created_by, created_at) FROM stdin;
\.


--
-- TOC entry 4547 (class 0 OID 16945)
-- Dependencies: 262
-- Data for Name: dataset_retriever_resources; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dataset_retriever_resources (id, message_id, "position", dataset_id, dataset_name, document_id, document_name, data_source_type, segment_id, score, content, hit_count, word_count, segment_position, index_node_hash, retriever_from, created_by, created_at) FROM stdin;
\.


--
-- TOC entry 4519 (class 0 OID 16559)
-- Dependencies: 234
-- Data for Name: datasets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.datasets (id, tenant_id, name, description, provider, permission, data_source_type, indexing_technique, index_struct, created_by, created_at, updated_by, updated_at, embedding_model, embedding_model_provider, collection_binding_id, retrieval_model, built_in_field_enabled) FROM stdin;
\.


--
-- TOC entry 4520 (class 0 OID 16572)
-- Dependencies: 235
-- Data for Name: dify_setups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dify_setups (version, setup_at) FROM stdin;
1.1.3	2025-04-09 06:50:12
\.


--
-- TOC entry 4521 (class 0 OID 16578)
-- Dependencies: 236
-- Data for Name: document_segments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.document_segments (id, tenant_id, dataset_id, document_id, "position", content, word_count, tokens, keywords, index_node_id, index_node_hash, hit_count, enabled, disabled_at, disabled_by, status, created_by, created_at, indexing_at, completed_at, error, stopped_at, answer, updated_by, updated_at) FROM stdin;
\.


--
-- TOC entry 4522 (class 0 OID 16594)
-- Dependencies: 237
-- Data for Name: documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.documents (id, tenant_id, dataset_id, "position", data_source_type, data_source_info, dataset_process_rule_id, batch, name, created_from, created_by, created_api_request_id, created_at, processing_started_at, file_id, word_count, parsing_completed_at, cleaning_completed_at, splitting_completed_at, tokens, indexing_latency, completed_at, is_paused, paused_by, paused_at, error, stopped_at, indexing_status, enabled, disabled_at, disabled_by, archived, archived_reason, archived_by, archived_at, updated_at, doc_type, doc_metadata, doc_form, doc_language) FROM stdin;
\.


--
-- TOC entry 4523 (class 0 OID 16610)
-- Dependencies: 238
-- Data for Name: embeddings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.embeddings (id, hash, embedding, created_at, model_name, provider_name) FROM stdin;
\.


--
-- TOC entry 4524 (class 0 OID 16621)
-- Dependencies: 239
-- Data for Name: end_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.end_users (id, tenant_id, app_id, type, external_user_id, name, is_anonymous, session_id, created_at, updated_at) FROM stdin;
729d3247-1c31-402d-8743-7059de037d0d	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	browser	\N	\N	t	23774cc8-88d3-4c97-ab39-ee9535a8d78b	2025-04-11 09:49:41	2025-04-11 09:49:41
e170fafb-a95c-4237-9245-e44bfb69c33e	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	service_api	\N	\N	f	abc-123	2025-04-11 09:52:57	2025-04-11 09:52:57
\.


--
-- TOC entry 4573 (class 0 OID 17313)
-- Dependencies: 288
-- Data for Name: external_knowledge_apis; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.external_knowledge_apis (id, name, description, tenant_id, settings, created_by, created_at, updated_by, updated_at) FROM stdin;
\.


--
-- TOC entry 4574 (class 0 OID 17325)
-- Dependencies: 289
-- Data for Name: external_knowledge_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.external_knowledge_bindings (id, tenant_id, external_knowledge_api_id, dataset_id, external_knowledge_id, created_by, created_at, updated_by, updated_at) FROM stdin;
\.


--
-- TOC entry 4525 (class 0 OID 16634)
-- Dependencies: 240
-- Data for Name: installed_apps; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.installed_apps (id, tenant_id, app_id, app_owner_tenant_id, "position", is_pinned, last_used_at, created_at) FROM stdin;
a2182f47-8908-46e7-86b9-9e86f3ece805	358a104c-8954-4063-beb6-e7bb3ae5de0f	3e96b986-3124-4fd2-93bd-26a45a194dd9	358a104c-8954-4063-beb6-e7bb3ae5de0f	0	f	\N	2025-04-11 09:19:42
bd16d3f5-abbe-4e92-8536-5c4badf92632	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	358a104c-8954-4063-beb6-e7bb3ae5de0f	0	f	\N	2025-04-11 09:24:52
\.


--
-- TOC entry 4527 (class 0 OID 16647)
-- Dependencies: 242
-- Data for Name: invitation_codes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.invitation_codes (id, batch, code, status, used_at, used_by_tenant_id, used_by_account_id, deprecated_at, created_at) FROM stdin;
\.


--
-- TOC entry 4567 (class 0 OID 17201)
-- Dependencies: 282
-- Data for Name: load_balancing_model_configs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.load_balancing_model_configs (id, tenant_id, provider_name, model_name, model_type, name, encrypted_config, enabled, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4528 (class 0 OID 16657)
-- Dependencies: 243
-- Data for Name: message_agent_thoughts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.message_agent_thoughts (id, message_id, message_chain_id, "position", thought, tool, tool_input, observation, tool_process_data, message, message_token, message_unit_price, answer, answer_token, answer_unit_price, tokens, total_price, currency, latency, created_by_role, created_by, created_at, message_price_unit, answer_price_unit, message_files, tool_labels_str, tool_meta_str) FROM stdin;
\.


--
-- TOC entry 4540 (class 0 OID 16807)
-- Dependencies: 255
-- Data for Name: message_annotations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.message_annotations (id, app_id, conversation_id, message_id, content, account_id, created_at, updated_at, question, hit_count) FROM stdin;
\.


--
-- TOC entry 4529 (class 0 OID 16668)
-- Dependencies: 244
-- Data for Name: message_chains; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.message_chains (id, message_id, type, input, output, created_at) FROM stdin;
\.


--
-- TOC entry 4530 (class 0 OID 16678)
-- Dependencies: 245
-- Data for Name: message_feedbacks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.message_feedbacks (id, app_id, conversation_id, message_id, rating, content, from_source, from_end_user_id, from_account_id, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4550 (class 0 OID 16975)
-- Dependencies: 265
-- Data for Name: message_files; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.message_files (id, message_id, type, transfer_method, url, upload_file_id, created_by_role, created_by, created_at, belongs_to) FROM stdin;
\.


--
-- TOC entry 4541 (class 0 OID 16820)
-- Dependencies: 256
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.messages (id, app_id, model_provider, model_id, override_model_configs, conversation_id, inputs, query, message, message_tokens, message_unit_price, answer, answer_tokens, answer_unit_price, provider_response_latency, total_price, currency, from_source, from_end_user_id, from_account_id, created_at, updated_at, agent_based, message_price_unit, answer_price_unit, workflow_run_id, status, error, message_metadata, invoke_from, parent_message_id) FROM stdin;
\.


--
-- TOC entry 4531 (class 0 OID 16691)
-- Dependencies: 246
-- Data for Name: operation_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.operation_logs (id, tenant_id, account_id, action, content, created_at, created_ip, updated_at) FROM stdin;
\.


--
-- TOC entry 4532 (class 0 OID 16702)
-- Dependencies: 247
-- Data for Name: pinned_conversations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pinned_conversations (id, app_id, conversation_id, created_by, created_at, created_by_role) FROM stdin;
\.


--
-- TOC entry 4568 (class 0 OID 17213)
-- Dependencies: 283
-- Data for Name: provider_model_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.provider_model_settings (id, tenant_id, provider_name, model_name, model_type, enabled, load_balancing_enabled, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4543 (class 0 OID 16875)
-- Dependencies: 258
-- Data for Name: provider_models; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.provider_models (id, tenant_id, provider_name, model_name, model_type, encrypted_config, is_valid, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4546 (class 0 OID 16923)
-- Dependencies: 261
-- Data for Name: provider_orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.provider_orders (id, tenant_id, provider_name, account_id, payment_product_id, payment_id, transaction_id, quantity, currency, total_amount, payment_status, paid_at, pay_failed_at, refunded_at, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4533 (class 0 OID 16710)
-- Dependencies: 248
-- Data for Name: providers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.providers (id, tenant_id, provider_name, provider_type, encrypted_config, is_valid, last_used, quota_type, quota_limit, quota_used, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4580 (class 0 OID 17419)
-- Dependencies: 295
-- Data for Name: rate_limit_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rate_limit_logs (id, tenant_id, subscription_plan, operation, created_at) FROM stdin;
\.


--
-- TOC entry 4534 (class 0 OID 16726)
-- Dependencies: 249
-- Data for Name: recommended_apps; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recommended_apps (id, app_id, description, copyright, privacy_policy, category, "position", is_listed, install_count, created_at, updated_at, language, custom_disclaimer) FROM stdin;
\.


--
-- TOC entry 4535 (class 0 OID 16738)
-- Dependencies: 250
-- Data for Name: saved_messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.saved_messages (id, app_id, message_id, created_by, created_at, created_by_role) FROM stdin;
\.


--
-- TOC entry 4536 (class 0 OID 16757)
-- Dependencies: 251
-- Data for Name: sites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sites (id, app_id, title, icon, icon_background, description, default_language, copyright, privacy_policy, customize_domain, customize_token_strategy, prompt_public, status, created_at, updated_at, code, custom_disclaimer, show_workflow_steps, chat_color_theme, chat_color_theme_inverted, icon_type, created_by, updated_by, use_icon_as_answer_icon) FROM stdin;
747b61dd-661f-44e2-9b3a-8c15a5cca1bf	3e96b986-3124-4fd2-93bd-26a45a194dd9	MOBA游戏推荐	🔍	#D1E9FF	\N	en-US	\N	\N	\N	not_allow	f	normal	2025-04-11 09:19:45	2025-04-11 09:19:45	sXqk9rdravayxtMj		t	\N	f	emoji	cc67c45e-e65e-4177-94d6-1af3d06342f5	cc67c45e-e65e-4177-94d6-1af3d06342f5	f
7a0abe72-d839-4e80-9fba-23a0613063bd	c84265cd-993f-4287-acc4-d82660a43e42	MOBA游戏推荐	🤖	#FFEAD5	\N	en-US	\N	\N	\N	not_allow	f	normal	2025-04-11 09:24:52	2025-04-11 09:24:52	hgUEmQHu4dX2jSSM		t	\N	f	emoji	cc67c45e-e65e-4177-94d6-1af3d06342f5	cc67c45e-e65e-4177-94d6-1af3d06342f5	f
\.


--
-- TOC entry 4563 (class 0 OID 17156)
-- Dependencies: 278
-- Data for Name: tag_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tag_bindings (id, tenant_id, tag_id, target_id, created_by, created_at) FROM stdin;
\.


--
-- TOC entry 4564 (class 0 OID 17165)
-- Dependencies: 279
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tags (id, tenant_id, type, name, created_by, created_at) FROM stdin;
\.


--
-- TOC entry 4537 (class 0 OID 16771)
-- Dependencies: 252
-- Data for Name: tenant_account_joins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tenant_account_joins (id, tenant_id, account_id, role, invited_by, created_at, updated_at, current) FROM stdin;
9848b299-444a-4189-bad4-4841fd2518a8	358a104c-8954-4063-beb6-e7bb3ae5de0f	cc67c45e-e65e-4177-94d6-1af3d06342f5	owner	\N	2025-04-09 06:50:12	2025-04-09 06:50:12	t
\.


--
-- TOC entry 4544 (class 0 OID 16889)
-- Dependencies: 259
-- Data for Name: tenant_default_models; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tenant_default_models (id, tenant_id, provider_name, model_name, model_type, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4545 (class 0 OID 16898)
-- Dependencies: 260
-- Data for Name: tenant_preferred_model_providers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tenant_preferred_model_providers (id, tenant_id, provider_name, preferred_provider_type, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4538 (class 0 OID 16784)
-- Dependencies: 253
-- Data for Name: tenants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tenants (id, name, encrypt_public_key, plan, status, created_at, updated_at, custom_config) FROM stdin;
358a104c-8954-4063-beb6-e7bb3ae5de0f	admin88@qq.com's Workspace	-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxSNfjvFsmDaem/NptivX\nxf2vpEmkYAd2bpng7vG/jIdCfGM38r2oiVWS/CrNm9wdq0i40I4vJ9KQSC3HVYin\nJj+TlWgPC7Mafr8ni+4VlnPr9dnuEZJS78L3nPXfSin99qe/3RqPFv1lHaNnx32T\n1DGw7sHIMVjwTltyQ3SaymotRUIGhfONNMYPPZ0SH5W6ZI0MdmBcbui9uxHw3F7F\ncfd1jGOqwd96vzlg09P59v6YKS5A54iweCsZfNO/iQ26qMNaWW/wEMYDta0jR2VZ\nFYNOy9pRyiftjJXwqYSzYHNXO3OYDmjsJ6BLVKAT43I+YIV5mTipQo2bkvDEMO9I\nCQIDAQAB\n-----END PUBLIC KEY-----	basic	normal	2025-04-09 06:50:11	2025-04-09 06:50:11	\N
\.


--
-- TOC entry 4575 (class 0 OID 17339)
-- Dependencies: 290
-- Data for Name: tidb_auth_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tidb_auth_bindings (id, tenant_id, cluster_id, cluster_name, active, status, account, password, created_at) FROM stdin;
\.


--
-- TOC entry 4553 (class 0 OID 17016)
-- Dependencies: 268
-- Data for Name: tool_api_providers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tool_api_providers (id, name, schema, schema_type_str, user_id, tenant_id, tools_str, icon, credentials_str, description, created_at, updated_at, privacy_policy, custom_disclaimer) FROM stdin;
\.


--
-- TOC entry 4554 (class 0 OID 17024)
-- Dependencies: 269
-- Data for Name: tool_builtin_providers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tool_builtin_providers (id, tenant_id, user_id, provider, encrypted_credentials, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4557 (class 0 OID 17069)
-- Dependencies: 272
-- Data for Name: tool_conversation_variables; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tool_conversation_variables (id, user_id, tenant_id, conversation_id, variables_str, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4558 (class 0 OID 17085)
-- Dependencies: 273
-- Data for Name: tool_files; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tool_files (id, user_id, tenant_id, conversation_id, file_key, mimetype, original_url, name, size) FROM stdin;
\.


--
-- TOC entry 4566 (class 0 OID 17189)
-- Dependencies: 281
-- Data for Name: tool_label_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tool_label_bindings (id, tool_id, tool_type, label_name) FROM stdin;
\.


--
-- TOC entry 4556 (class 0 OID 17055)
-- Dependencies: 271
-- Data for Name: tool_model_invokes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tool_model_invokes (id, user_id, tenant_id, provider, tool_type, tool_name, model_parameters, prompt_messages, model_response, prompt_tokens, answer_tokens, answer_unit_price, answer_price_unit, provider_response_latency, total_price, currency, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4555 (class 0 OID 17036)
-- Dependencies: 270
-- Data for Name: tool_published_apps; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tool_published_apps (id, app_id, user_id, description, llm_description, query_description, query_name, tool_name, author, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4565 (class 0 OID 17174)
-- Dependencies: 280
-- Data for Name: tool_workflow_providers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tool_workflow_providers (id, name, icon, app_id, user_id, tenant_id, description, parameter_configuration, created_at, updated_at, privacy_policy, version, label) FROM stdin;
\.


--
-- TOC entry 4570 (class 0 OID 17264)
-- Dependencies: 285
-- Data for Name: trace_app_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.trace_app_config (id, app_id, tracing_provider, tracing_config, created_at, updated_at, is_active) FROM stdin;
\.


--
-- TOC entry 4539 (class 0 OID 16796)
-- Dependencies: 254
-- Data for Name: upload_files; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.upload_files (id, tenant_id, storage_type, key, name, size, extension, mime_type, created_by, created_at, used, used_by, used_at, hash, created_by_role, source_url) FROM stdin;
\.


--
-- TOC entry 4576 (class 0 OID 17354)
-- Dependencies: 291
-- Data for Name: whitelists; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.whitelists (id, tenant_id, category, created_at) FROM stdin;
\.


--
-- TOC entry 4559 (class 0 OID 17106)
-- Dependencies: 274
-- Data for Name: workflow_app_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.workflow_app_logs (id, tenant_id, app_id, workflow_id, workflow_run_id, created_from, created_by_role, created_by, created_at) FROM stdin;
26d4a4ea-8c85-4ab4-aa0a-03a93e76bb2e	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	9019723c-49bb-40ca-9cd1-3dec6ff7ec69	6cf5f266-34b3-4842-ab42-47713a13275b	web-app	end_user	729d3247-1c31-402d-8743-7059de037d0d	2025-04-11 09:49:57
8f1c336d-cab3-4602-8ddd-65ecaafd7928	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	9019723c-49bb-40ca-9cd1-3dec6ff7ec69	7a9ff971-ebee-4777-95a2-5ac0cb9181c4	web-app	end_user	729d3247-1c31-402d-8743-7059de037d0d	2025-04-11 09:50:23
ec1a389f-fe49-42f7-a8ea-4c39647a2065	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	9d7731c1-972f-414a-ba17-48efb60862ac	027b3626-f8cf-4f95-af12-b9bce48d52cc	service-api	end_user	e170fafb-a95c-4237-9245-e44bfb69c33e	2025-04-11 09:52:57
\.


--
-- TOC entry 4572 (class 0 OID 17297)
-- Dependencies: 287
-- Data for Name: workflow_conversation_variables; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.workflow_conversation_variables (id, conversation_id, app_id, data, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4560 (class 0 OID 17116)
-- Dependencies: 275
-- Data for Name: workflow_node_executions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.workflow_node_executions (id, tenant_id, app_id, workflow_id, triggered_from, workflow_run_id, index, predecessor_node_id, node_id, node_type, title, inputs, process_data, outputs, status, error, elapsed_time, execution_metadata, created_at, created_by_role, created_by, finished_at, node_execution_id) FROM stdin;
c598d567-de05-425f-96b3-91b97fa00854	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	54d1bbfc-6bb3-4439-962e-c19dee46a769	single-step	\N	1	\N	1744363805879	http-request	HTTP 请求	null	{"request": "GET /query/type?type=test HTTP/1.1\\r\\nHost: localhost:7860\\r\\n\\r\\n"}	{"status_code": 200, "body": "{\\"message\\":\\"type is:test\\"}", "headers": {"date": "Fri, 11 Apr 2025 09:37:11 GMT", "server": "uvicorn", "content-length": "26", "content-type": "application/json"}, "files": []}	succeeded	\N	0.01290683398838155	\N	2025-04-11 09:37:11.478801	account	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-11 09:37:11.478805	\N
de10edd8-fd33-43d9-a66e-5a3b00d61812	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	54d1bbfc-6bb3-4439-962e-c19dee46a769	single-step	\N	1	\N	1744363805879	http-request	HTTP 请求	null	{"request": "GET /query/type?type=%E8%8B%B1%E9%9B%84%E8%81%94%E7%9B%9F HTTP/1.1\\r\\nHost: localhost:7860\\r\\n\\r\\n"}	{"status_code": 200, "body": "{\\"message\\":\\"type is:\\u82f1\\u96c4\\u8054\\u76df\\"}", "headers": {"date": "Fri, 11 Apr 2025 09:44:10 GMT", "server": "uvicorn", "content-length": "34", "content-type": "application/json"}, "files": []}	succeeded	\N	0.011187208001501858	\N	2025-04-11 09:44:10.947769	account	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-11 09:44:10.947772	\N
77fecda2-e743-4e2f-b919-3e81a3e32e06	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	54d1bbfc-6bb3-4439-962e-c19dee46a769	single-step	\N	1	\N	1744363805879	http-request	HTTP 请求	null	{"request": "GET /query/type?type=test HTTP/1.1\\r\\nHost: localhost:7860\\r\\n\\r\\n"}	{"status_code": 200, "body": "{\\"message\\":\\"type is:test\\"}", "headers": {"date": "Fri, 11 Apr 2025 09:45:52 GMT", "server": "uvicorn", "content-length": "26", "content-type": "application/json"}, "files": []}	succeeded	\N	0.01211354200495407	\N	2025-04-11 09:45:52.921266	account	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-11 09:45:52.92127	\N
1540b3d6-ea13-4f6e-8214-6c6b5562c11c	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	54d1bbfc-6bb3-4439-962e-c19dee46a769	single-step	\N	1	\N	1744364785698	http-request	HTTP 请求 2	null	{"request": "GET / HTTP/1.1\\r\\nHost: localhost:7860\\r\\n\\r\\n"}	{"status_code": 200, "body": "{\\"message\\":\\"Hello from Backend!!!!\\"}", "headers": {"date": "Fri, 11 Apr 2025 09:47:09 GMT", "server": "uvicorn", "content-length": "36", "content-type": "application/json"}, "files": []}	succeeded	\N	0.012094459001673386	\N	2025-04-11 09:47:10.183893	account	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-11 09:47:10.183897	\N
f7e1c572-0ae6-445b-af2f-7f258fae4b86	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	54d1bbfc-6bb3-4439-962e-c19dee46a769	workflow-run	6b0773b6-2f61-4119-a663-93cb4154d3e6	1	\N	1744363492188	start	开始	{"interface_type": "\\u6258\\u5c14\\u65af\\u6cf0", "date": null, "sys.files": [], "sys.user_id": "cc67c45e-e65e-4177-94d6-1af3d06342f5", "sys.app_id": "c84265cd-993f-4287-acc4-d82660a43e42", "sys.workflow_id": "54d1bbfc-6bb3-4439-962e-c19dee46a769", "sys.workflow_run_id": "6b0773b6-2f61-4119-a663-93cb4154d3e6"}	\N	{"interface_type": "\\u6258\\u5c14\\u65af\\u6cf0", "date": null, "sys.files": [], "sys.user_id": "cc67c45e-e65e-4177-94d6-1af3d06342f5", "sys.app_id": "c84265cd-993f-4287-acc4-d82660a43e42", "sys.workflow_id": "54d1bbfc-6bb3-4439-962e-c19dee46a769", "sys.workflow_run_id": "6b0773b6-2f61-4119-a663-93cb4154d3e6"}	succeeded	\N	0.01644	\N	2025-04-11 09:47:59.336386	account	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-11 09:47:59.340849	1c7dcea8-9095-42cd-88bd-78d847aaf87e
141c8f04-7c5d-48de-8000-662633dc1b5e	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	54d1bbfc-6bb3-4439-962e-c19dee46a769	workflow-run	6b0773b6-2f61-4119-a663-93cb4154d3e6	2	1744363492188	1744363664951	if-else	条件分支	{"conditions": [{"actual_value": "\\u6258\\u5c14\\u65af\\u6cf0", "expected_value": "\\"draft\\"", "comparison_operator": "contains"}]}	{"condition_results": [{"group": {"case_id": "true", "logical_operator": "and", "conditions": [{"variable_selector": ["1744363492188", "interface_type"], "comparison_operator": "contains", "value": "\\"draft\\"", "sub_variable_condition": null}]}, "results": [false], "final_result": false}]}	{"result": false, "selected_case_id": null}	succeeded	\N	0.020948	\N	2025-04-11 09:47:59.344077	account	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-11 09:47:59.346574	18e21951-c0f4-47cd-934a-c7275d10831a
5a3713d2-2055-4d52-8538-57448afdcdbe	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	54d1bbfc-6bb3-4439-962e-c19dee46a769	workflow-run	6b0773b6-2f61-4119-a663-93cb4154d3e6	3	1744363664951	1744364785698	http-request	HTTP 请求 2	\N	{"request": "GET / HTTP/1.1\\r\\nHost: localhost:7860\\r\\n\\r\\n"}	{"status_code": 200, "body": "{\\"message\\":\\"Hello from Backend!!!!\\"}", "headers": {"date": "Fri, 11 Apr 2025 09:47:58 GMT", "server": "uvicorn", "content-length": "36", "content-type": "application/json"}, "files": []}	succeeded	\N	0.02456	\N	2025-04-11 09:47:59.349174	account	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-11 09:47:59.35099	3d8f9bc5-f60b-473c-b904-27c193d7e6cd
617c2ece-c138-4ae3-bf33-736185975919	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	54d1bbfc-6bb3-4439-962e-c19dee46a769	workflow-run	6b0773b6-2f61-4119-a663-93cb4154d3e6	4	1744364785698	1744364683467	end	结束	{"body.message": null}	\N	{"body.message": null}	succeeded	\N	0.021492	\N	2025-04-11 09:47:59.353457	account	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-11 09:47:59.356284	6fafcf44-cb77-4801-b94a-cd3a3695ef11
57df5cf8-314f-4dfd-ad68-34b20fa656fb	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	54d1bbfc-6bb3-4439-962e-c19dee46a769	workflow-run	77ef469d-0ea2-4e06-874c-3527c6ac911c	1	\N	1744363492188	start	开始	{"interface_type": "\\u6258\\u5c14\\u65af\\u6cf0", "date": null, "sys.files": [], "sys.user_id": "cc67c45e-e65e-4177-94d6-1af3d06342f5", "sys.app_id": "c84265cd-993f-4287-acc4-d82660a43e42", "sys.workflow_id": "54d1bbfc-6bb3-4439-962e-c19dee46a769", "sys.workflow_run_id": "77ef469d-0ea2-4e06-874c-3527c6ac911c"}	\N	{"interface_type": "\\u6258\\u5c14\\u65af\\u6cf0", "date": null, "sys.files": [], "sys.user_id": "cc67c45e-e65e-4177-94d6-1af3d06342f5", "sys.app_id": "c84265cd-993f-4287-acc4-d82660a43e42", "sys.workflow_id": "54d1bbfc-6bb3-4439-962e-c19dee46a769", "sys.workflow_run_id": "77ef469d-0ea2-4e06-874c-3527c6ac911c"}	succeeded	\N	0.015166	\N	2025-04-11 09:49:07.247533	account	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-11 09:49:07.250224	3114065f-65e2-46e1-9333-bec8b2b04c01
25698931-7f46-4595-b6b6-9b0bdc637000	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	54d1bbfc-6bb3-4439-962e-c19dee46a769	workflow-run	77ef469d-0ea2-4e06-874c-3527c6ac911c	2	1744363492188	1744363664951	if-else	条件分支	{"conditions": [{"actual_value": "\\u6258\\u5c14\\u65af\\u6cf0", "expected_value": "\\"draft\\"", "comparison_operator": "contains"}]}	{"condition_results": [{"group": {"case_id": "true", "logical_operator": "and", "conditions": [{"variable_selector": ["1744363492188", "interface_type"], "comparison_operator": "contains", "value": "\\"draft\\"", "sub_variable_condition": null}]}, "results": [false], "final_result": false}]}	{"result": false, "selected_case_id": null}	succeeded	\N	0.021481	\N	2025-04-11 09:49:07.254162	account	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-11 09:49:07.257338	44401556-fd9a-43db-a4cf-5b8b2aba4f05
1d0525cf-317a-4b7f-982e-a8c46df3a8bc	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	54d1bbfc-6bb3-4439-962e-c19dee46a769	workflow-run	77ef469d-0ea2-4e06-874c-3527c6ac911c	3	1744363664951	1744364785698	http-request	HTTP 请求 2	\N	{"request": "GET / HTTP/1.1\\r\\nHost: localhost:7860\\r\\n\\r\\n"}	{"status_code": 200, "body": "{\\"message\\":\\"Hello from Backend!!!!\\"}", "headers": {"date": "Fri, 11 Apr 2025 09:49:07 GMT", "server": "uvicorn", "content-length": "36", "content-type": "application/json"}, "files": []}	succeeded	\N	0.026214	\N	2025-04-11 09:49:07.260052	account	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-11 09:49:07.2628	75857e2f-4dfc-49ce-adf3-51243816071d
e007ad53-ab6c-425d-9ee5-faa6ac0cce37	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	54d1bbfc-6bb3-4439-962e-c19dee46a769	workflow-run	77ef469d-0ea2-4e06-874c-3527c6ac911c	4	1744364785698	1744364922394	end	结束 2	{"body.message": "{\\"message\\":\\"Hello from Backend!!!!\\"}"}	\N	{"body.message": "{\\"message\\":\\"Hello from Backend!!!!\\"}"}	succeeded	\N	0.020348	\N	2025-04-11 09:49:07.265589	account	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-11 09:49:07.267594	4295ec63-43e5-438c-8d7e-8362173e0d96
aadb5025-82d4-4a90-a64a-130a818ea891	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	9019723c-49bb-40ca-9cd1-3dec6ff7ec69	workflow-run	6cf5f266-34b3-4842-ab42-47713a13275b	4	1744364785698	1744364922394	end	结束 2	{"body.message": "{\\"message\\":\\"Hello from Backend!!!!\\"}"}	\N	{"body.message": "{\\"message\\":\\"Hello from Backend!!!!\\"}"}	succeeded	\N	0.018159	\N	2025-04-11 09:49:56.694606	end_user	729d3247-1c31-402d-8743-7059de037d0d	2025-04-11 09:49:56.696741	3dab4903-0910-4469-8646-ea5697588760
ee957164-b5e1-4019-b00b-17d746d8b804	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	9019723c-49bb-40ca-9cd1-3dec6ff7ec69	workflow-run	6cf5f266-34b3-4842-ab42-47713a13275b	1	\N	1744363492188	start	开始	{"interface_type": "draft", "date": null, "sys.files": [], "sys.user_id": "23774cc8-88d3-4c97-ab39-ee9535a8d78b", "sys.app_id": "c84265cd-993f-4287-acc4-d82660a43e42", "sys.workflow_id": "9019723c-49bb-40ca-9cd1-3dec6ff7ec69", "sys.workflow_run_id": "6cf5f266-34b3-4842-ab42-47713a13275b"}	\N	{"interface_type": "draft", "date": null, "sys.files": [], "sys.user_id": "23774cc8-88d3-4c97-ab39-ee9535a8d78b", "sys.app_id": "c84265cd-993f-4287-acc4-d82660a43e42", "sys.workflow_id": "9019723c-49bb-40ca-9cd1-3dec6ff7ec69", "sys.workflow_run_id": "6cf5f266-34b3-4842-ab42-47713a13275b"}	succeeded	\N	0.013107	\N	2025-04-11 09:49:56.679577	end_user	729d3247-1c31-402d-8743-7059de037d0d	2025-04-11 09:49:56.682331	6bdb0ef0-9a94-4fcf-a585-7285fc9fdc84
5830878b-673a-42cd-af05-ad03cc65804e	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	9d7731c1-972f-414a-ba17-48efb60862ac	workflow-run	027b3626-f8cf-4f95-af12-b9bce48d52cc	2	1744363492188	1744363664951	if-else	条件分支	{"conditions": [{"actual_value": "draft", "expected_value": "draft", "comparison_operator": "contains"}]}	{"condition_results": [{"group": {"case_id": "true", "logical_operator": "and", "conditions": [{"variable_selector": ["1744363492188", "interface_type"], "comparison_operator": "contains", "value": "draft", "sub_variable_condition": null}]}, "results": [true], "final_result": true}]}	{"result": true, "selected_case_id": "true"}	succeeded	\N	0.023413	\N	2025-04-11 09:52:57.177933	end_user	e170fafb-a95c-4237-9245-e44bfb69c33e	2025-04-11 09:52:57.18038	2f357c76-03c9-4e74-a314-de42cc6275c8
9d5963a3-73d1-42e4-906a-75dc94c6bf2a	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	9019723c-49bb-40ca-9cd1-3dec6ff7ec69	workflow-run	6cf5f266-34b3-4842-ab42-47713a13275b	2	1744363492188	1744363664951	if-else	条件分支	{"conditions": [{"actual_value": "draft", "expected_value": "\\"draft\\"", "comparison_operator": "contains"}]}	{"condition_results": [{"group": {"case_id": "true", "logical_operator": "and", "conditions": [{"variable_selector": ["1744363492188", "interface_type"], "comparison_operator": "contains", "value": "\\"draft\\"", "sub_variable_condition": null}]}, "results": [false], "final_result": false}]}	{"result": false, "selected_case_id": null}	succeeded	\N	0.01605	\N	2025-04-11 09:49:56.685049	end_user	729d3247-1c31-402d-8743-7059de037d0d	2025-04-11 09:49:56.686947	deb8270b-3f4c-4d63-a4d8-0cf4d8592145
3feb488f-053f-48be-8f89-9ec629accd9c	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	9d7731c1-972f-414a-ba17-48efb60862ac	workflow-run	027b3626-f8cf-4f95-af12-b9bce48d52cc	3	1744363664951	1744363805879	http-request	HTTP 请求	\N	{"request": "GET /query/type?type=draft HTTP/1.1\\r\\nHost: localhost:7860\\r\\n\\r\\n"}	{"status_code": 200, "body": "{\\"message\\":\\"type is:draft\\"}", "headers": {"date": "Fri, 11 Apr 2025 09:52:56 GMT", "server": "uvicorn", "content-length": "27", "content-type": "application/json"}, "files": []}	succeeded	\N	0.027776	\N	2025-04-11 09:52:57.182857	end_user	e170fafb-a95c-4237-9245-e44bfb69c33e	2025-04-11 09:52:57.186987	9a8ff73e-61b5-4470-8f16-ece7638e5c55
920286eb-e035-49b5-b126-1822a7bd8753	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	9019723c-49bb-40ca-9cd1-3dec6ff7ec69	workflow-run	6cf5f266-34b3-4842-ab42-47713a13275b	3	1744363664951	1744364785698	http-request	HTTP 请求 2	\N	{"request": "GET / HTTP/1.1\\r\\nHost: localhost:7860\\r\\n\\r\\n"}	{"status_code": 200, "body": "{\\"message\\":\\"Hello from Backend!!!!\\"}", "headers": {"date": "Fri, 11 Apr 2025 09:49:56 GMT", "server": "uvicorn", "content-length": "36", "content-type": "application/json"}, "files": []}	succeeded	\N	0.020039	\N	2025-04-11 09:49:56.689087	end_user	729d3247-1c31-402d-8743-7059de037d0d	2025-04-11 09:49:56.691809	98403439-79a3-4236-b686-2ad262efe335
7f58080c-8fac-4352-a765-1e4f529685a1	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	9019723c-49bb-40ca-9cd1-3dec6ff7ec69	workflow-run	7a9ff971-ebee-4777-95a2-5ac0cb9181c4	1	\N	1744363492188	start	开始	{"interface_type": "\\"draft\\"", "date": null, "sys.files": [], "sys.user_id": "23774cc8-88d3-4c97-ab39-ee9535a8d78b", "sys.app_id": "c84265cd-993f-4287-acc4-d82660a43e42", "sys.workflow_id": "9019723c-49bb-40ca-9cd1-3dec6ff7ec69", "sys.workflow_run_id": "7a9ff971-ebee-4777-95a2-5ac0cb9181c4"}	\N	{"interface_type": "\\"draft\\"", "date": null, "sys.files": [], "sys.user_id": "23774cc8-88d3-4c97-ab39-ee9535a8d78b", "sys.app_id": "c84265cd-993f-4287-acc4-d82660a43e42", "sys.workflow_id": "9019723c-49bb-40ca-9cd1-3dec6ff7ec69", "sys.workflow_run_id": "7a9ff971-ebee-4777-95a2-5ac0cb9181c4"}	succeeded	\N	0.022494	\N	2025-04-11 09:50:22.889467	end_user	729d3247-1c31-402d-8743-7059de037d0d	2025-04-11 09:50:22.895293	490467f5-c4df-40a0-ac22-100d9a6ca4da
f1e38878-22e1-4ed9-b7ae-8b04d76ee5d2	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	9019723c-49bb-40ca-9cd1-3dec6ff7ec69	workflow-run	7a9ff971-ebee-4777-95a2-5ac0cb9181c4	2	1744363492188	1744363664951	if-else	条件分支	{"conditions": [{"actual_value": "\\"draft\\"", "expected_value": "\\"draft\\"", "comparison_operator": "contains"}]}	{"condition_results": [{"group": {"case_id": "true", "logical_operator": "and", "conditions": [{"variable_selector": ["1744363492188", "interface_type"], "comparison_operator": "contains", "value": "\\"draft\\"", "sub_variable_condition": null}]}, "results": [true], "final_result": true}]}	{"result": true, "selected_case_id": "true"}	succeeded	\N	0.027996	\N	2025-04-11 09:50:22.898882	end_user	729d3247-1c31-402d-8743-7059de037d0d	2025-04-11 09:50:22.902618	d8e9fb9a-079a-4128-a68b-8731fe722569
58f23abd-52d0-476b-99b2-54e68f0a0307	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	9d7731c1-972f-414a-ba17-48efb60862ac	workflow-run	027b3626-f8cf-4f95-af12-b9bce48d52cc	1	\N	1744363492188	start	开始	{"interface_type": "draft", "date": null, "sys.files": [], "sys.user_id": "abc-123", "sys.app_id": "c84265cd-993f-4287-acc4-d82660a43e42", "sys.workflow_id": "9d7731c1-972f-414a-ba17-48efb60862ac", "sys.workflow_run_id": "027b3626-f8cf-4f95-af12-b9bce48d52cc"}	\N	{"interface_type": "draft", "date": null, "sys.files": [], "sys.user_id": "abc-123", "sys.app_id": "c84265cd-993f-4287-acc4-d82660a43e42", "sys.workflow_id": "9d7731c1-972f-414a-ba17-48efb60862ac", "sys.workflow_run_id": "027b3626-f8cf-4f95-af12-b9bce48d52cc"}	succeeded	\N	0.020938	\N	2025-04-11 09:52:57.172175	end_user	e170fafb-a95c-4237-9245-e44bfb69c33e	2025-04-11 09:52:57.175511	b6a98c89-15fb-4819-bb44-8f8d096c7894
5c62e309-a3d9-40a0-8fc2-89982abe9d61	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	9019723c-49bb-40ca-9cd1-3dec6ff7ec69	workflow-run	7a9ff971-ebee-4777-95a2-5ac0cb9181c4	3	1744363664951	1744363805879	http-request	HTTP 请求	\N	{"request": "GET /query/type?type=%22draft%22 HTTP/1.1\\r\\nHost: localhost:7860\\r\\n\\r\\n"}	{"status_code": 200, "body": "{\\"message\\":\\"type is:\\\\\\"draft\\\\\\"\\"}", "headers": {"date": "Fri, 11 Apr 2025 09:50:22 GMT", "server": "uvicorn", "content-length": "31", "content-type": "application/json"}, "files": []}	succeeded	\N	0.031003	\N	2025-04-11 09:50:22.904978	end_user	729d3247-1c31-402d-8743-7059de037d0d	2025-04-11 09:50:22.907919	b5c9042f-9bdf-4402-a5ee-0a7661a78a7a
b7cc4523-a961-4301-a08e-73b02b1b5f6c	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	9019723c-49bb-40ca-9cd1-3dec6ff7ec69	workflow-run	7a9ff971-ebee-4777-95a2-5ac0cb9181c4	4	1744363805879	1744364683467	end	结束	{"body.message": "{\\"message\\":\\"type is:\\\\\\"draft\\\\\\"\\"}"}	\N	{"body.message": "{\\"message\\":\\"type is:\\\\\\"draft\\\\\\"\\"}"}	succeeded	\N	0.02035	\N	2025-04-11 09:50:22.910258	end_user	729d3247-1c31-402d-8743-7059de037d0d	2025-04-11 09:50:22.912718	2d2bad17-f2d6-4333-8a20-15a710ac9717
02801da7-feae-4515-8fb0-aa198bc27e67	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	9d7731c1-972f-414a-ba17-48efb60862ac	workflow-run	027b3626-f8cf-4f95-af12-b9bce48d52cc	4	1744363805879	1744364683467	end	结束	{"body.message": "{\\"message\\":\\"type is:draft\\"}"}	\N	{"body.message": "{\\"message\\":\\"type is:draft\\"}"}	succeeded	\N	0.018579	\N	2025-04-11 09:52:57.189846	end_user	e170fafb-a95c-4237-9245-e44bfb69c33e	2025-04-11 09:52:57.192369	cf8f3fda-313b-46ed-8e20-254078d5ef04
5a4374db-066c-4847-bedd-143c80777366	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	54d1bbfc-6bb3-4439-962e-c19dee46a769	workflow-run	82d6d05f-46df-4d21-82be-e3c5616c4e1f	1	\N	1744363492188	start	开始	{"sys.files": [], "sys.user_id": "cc67c45e-e65e-4177-94d6-1af3d06342f5", "sys.app_id": "c84265cd-993f-4287-acc4-d82660a43e42", "sys.workflow_id": "54d1bbfc-6bb3-4439-962e-c19dee46a769", "sys.workflow_run_id": "82d6d05f-46df-4d21-82be-e3c5616c4e1f"}	\N	{"sys.files": [], "sys.user_id": "cc67c45e-e65e-4177-94d6-1af3d06342f5", "sys.app_id": "c84265cd-993f-4287-acc4-d82660a43e42", "sys.workflow_id": "54d1bbfc-6bb3-4439-962e-c19dee46a769", "sys.workflow_run_id": "82d6d05f-46df-4d21-82be-e3c5616c4e1f"}	succeeded	\N	0.020769	\N	2025-04-14 08:01:25.391095	account	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-14 08:01:25.399172	ae8ba730-1474-474e-8524-39540d7a4d09
9a737867-54e4-4ac0-aa16-1f4d7e9ace12	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	54d1bbfc-6bb3-4439-962e-c19dee46a769	workflow-run	82d6d05f-46df-4d21-82be-e3c5616c4e1f	2	1744363492188	1744363664951	if-else	条件分支	{"conditions": []}	{"condition_results": []}	\N	failed	Variable ['1744363492188', 'interface_type'] not found	0.02878	\N	2025-04-14 08:01:25.403875	account	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-14 08:01:25.409552	952f811e-76b8-412e-9421-d82b5ae10cc1
15555a5b-197c-439a-932f-e6acdc1507a0	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	54d1bbfc-6bb3-4439-962e-c19dee46a769	single-step	\N	1	\N	1744363805879	http-request	HTTP 请求	\N	\N	\N	failed	[Errno 61] Connection refused	0.010891375000937842	\N	2025-04-14 08:08:53.274407	account	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-14 08:08:53.274411	\N
f3016790-fc74-4b1e-aeeb-66d887126bc0	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	54d1bbfc-6bb3-4439-962e-c19dee46a769	single-step	\N	1	\N	1744363805879	http-request	HTTP 请求	null	{"request": "GET /query/type?type=%7B%7Binterface_type%7D%7D HTTP/1.1\\r\\nHost: localhost:7860\\r\\n\\r\\n"}	{"status_code": 200, "body": "{\\"message\\":\\"type is:{{interface_type}}\\"}", "headers": {"date": "Mon, 14 Apr 2025 08:09:17 GMT", "server": "uvicorn", "content-length": "40", "content-type": "application/json"}, "files": []}	succeeded	\N	0.014047290998860262	\N	2025-04-14 08:09:18.605149	account	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-14 08:09:18.605153	\N
678708a6-b94b-4aa4-9fc2-8725607091b7	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	54d1bbfc-6bb3-4439-962e-c19dee46a769	single-step	\N	1	\N	1744363805879	http-request	HTTP 请求	null	{"request": "GET /query/type?type=%7Binterface_type%7D HTTP/1.1\\r\\nHost: localhost:7860\\r\\n\\r\\n"}	{"status_code": 200, "body": "{\\"message\\":\\"type is:{interface_type}\\"}", "headers": {"date": "Mon, 14 Apr 2025 08:14:58 GMT", "server": "uvicorn", "content-length": "38", "content-type": "application/json"}, "files": []}	succeeded	\N	0.01636425000106101	\N	2025-04-14 08:14:59.289187	account	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-14 08:14:59.289196	\N
1ba9940a-22bd-408a-9644-3cb3bd756bc3	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	54d1bbfc-6bb3-4439-962e-c19dee46a769	single-step	\N	1	\N	1744363805879	http-request	HTTP 请求	null	{"request": "GET /query/type?type=%7Binterface_type%7D HTTP/1.1\\r\\nHost: localhost:7860\\r\\n\\r\\n"}	{"status_code": 200, "body": "{\\"message\\":\\"type is:{interface_type}\\"}", "headers": {"date": "Mon, 14 Apr 2025 08:22:08 GMT", "server": "uvicorn", "content-length": "38", "content-type": "application/json"}, "files": []}	succeeded	\N	0.010643583998898976	\N	2025-04-14 08:22:09.215066	account	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-14 08:22:09.215072	\N
bcb21e94-f2ae-4ed1-bcec-fad02439611f	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	54d1bbfc-6bb3-4439-962e-c19dee46a769	workflow-run	d4e74850-5765-496d-8f9d-2dbc27370951	1	\N	1744363492188	start	开始	{"interface_type": "draft", "sys.files": [], "sys.user_id": "cc67c45e-e65e-4177-94d6-1af3d06342f5", "sys.app_id": "c84265cd-993f-4287-acc4-d82660a43e42", "sys.workflow_id": "54d1bbfc-6bb3-4439-962e-c19dee46a769", "sys.workflow_run_id": "d4e74850-5765-496d-8f9d-2dbc27370951"}	\N	{"interface_type": "draft", "sys.files": [], "sys.user_id": "cc67c45e-e65e-4177-94d6-1af3d06342f5", "sys.app_id": "c84265cd-993f-4287-acc4-d82660a43e42", "sys.workflow_id": "54d1bbfc-6bb3-4439-962e-c19dee46a769", "sys.workflow_run_id": "d4e74850-5765-496d-8f9d-2dbc27370951"}	succeeded	\N	0.025844	\N	2025-04-14 09:06:42.816545	account	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-14 09:06:42.822947	8f2875a5-9b77-4770-b139-0fc6215eef97
91d409ca-05d2-497d-a6b8-d8c677c2f03e	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	54d1bbfc-6bb3-4439-962e-c19dee46a769	workflow-run	d4e74850-5765-496d-8f9d-2dbc27370951	2	1744363492188	1744363664951	if-else	条件分支	{"conditions": [{"actual_value": "draft", "expected_value": "draft", "comparison_operator": "contains"}]}	{"condition_results": [{"group": {"case_id": "true", "logical_operator": "and", "conditions": [{"variable_selector": ["1744363492188", "interface_type"], "comparison_operator": "contains", "value": "draft", "sub_variable_condition": null}]}, "results": [true], "final_result": true}]}	{"result": true, "selected_case_id": "true"}	succeeded	\N	0.035089	\N	2025-04-14 09:06:42.82832	account	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-14 09:06:42.834308	f8d487e5-36c2-4a7d-b0c3-7716bcef65bd
9bd5c592-25e2-4355-bc7e-aedbfc57e3c4	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	54d1bbfc-6bb3-4439-962e-c19dee46a769	workflow-run	d4e74850-5765-496d-8f9d-2dbc27370951	3	1744363664951	1744363805879	http-request	HTTP 请求	\N	{"request": "GET /query/type?type=draft HTTP/1.1\\r\\nHost: localhost:7860\\r\\n\\r\\n"}	{"status_code": 200, "body": "{\\"message\\":\\"type is:draft\\"}", "headers": {"date": "Mon, 14 Apr 2025 09:06:42 GMT", "server": "uvicorn", "content-length": "27", "content-type": "application/json"}, "files": []}	succeeded	\N	0.041545	\N	2025-04-14 09:06:42.837721	account	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-14 09:06:42.842401	62158ef8-c2b1-4c29-91ab-27de08bb9e77
11ef1784-b731-4b61-bd8c-4123fd692b87	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	54d1bbfc-6bb3-4439-962e-c19dee46a769	workflow-run	d4e74850-5765-496d-8f9d-2dbc27370951	4	1744363805879	1744364683467	end	结束	{"body.message": "{\\"message\\":\\"type is:draft\\"}"}	\N	{"body.message": "{\\"message\\":\\"type is:draft\\"}"}	succeeded	\N	0.033842	\N	2025-04-14 09:06:42.846817	account	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-14 09:06:42.849923	691f62d6-3a4b-4f3e-8999-079f350424ab
202c1be8-1e69-470b-876c-c30630499bb7	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	54d1bbfc-6bb3-4439-962e-c19dee46a769	workflow-run	ad959009-a8b9-4160-8d3b-58d1a8e1788a	1	\N	1744363492188	start	开始	{"interface_type": "draft", "sys.files": [], "sys.user_id": "cc67c45e-e65e-4177-94d6-1af3d06342f5", "sys.app_id": "c84265cd-993f-4287-acc4-d82660a43e42", "sys.workflow_id": "54d1bbfc-6bb3-4439-962e-c19dee46a769", "sys.workflow_run_id": "ad959009-a8b9-4160-8d3b-58d1a8e1788a"}	\N	{"interface_type": "draft", "sys.files": [], "sys.user_id": "cc67c45e-e65e-4177-94d6-1af3d06342f5", "sys.app_id": "c84265cd-993f-4287-acc4-d82660a43e42", "sys.workflow_id": "54d1bbfc-6bb3-4439-962e-c19dee46a769", "sys.workflow_run_id": "ad959009-a8b9-4160-8d3b-58d1a8e1788a"}	succeeded	\N	0.020724	\N	2025-04-14 09:48:04.948058	account	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-14 09:48:04.953629	35a74a5e-3ab6-4f7d-ba76-4af6a73fff8b
06102058-0998-4f83-8688-2925d8a9fb64	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	54d1bbfc-6bb3-4439-962e-c19dee46a769	workflow-run	ad959009-a8b9-4160-8d3b-58d1a8e1788a	2	1744363492188	1744363664951	if-else	条件分支	{"conditions": [{"actual_value": "draft", "expected_value": "draft", "comparison_operator": "contains"}]}	{"condition_results": [{"group": {"case_id": "true", "logical_operator": "and", "conditions": [{"variable_selector": ["1744363492188", "interface_type"], "comparison_operator": "contains", "value": "draft", "sub_variable_condition": null}]}, "results": [true], "final_result": true}]}	{"result": true, "selected_case_id": "true"}	succeeded	\N	0.024705	\N	2025-04-14 09:48:04.956456	account	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-14 09:48:04.959069	61c184bd-2bdd-486c-a9c4-327500350945
5fb2cb71-4cf7-4aa5-89d9-0b26498139d0	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	54d1bbfc-6bb3-4439-962e-c19dee46a769	workflow-run	ad959009-a8b9-4160-8d3b-58d1a8e1788a	3	1744363664951	1744363805879	http-request	HTTP 请求	\N	{"request": "GET /query/type?type=draft HTTP/1.1\\r\\nHost: localhost:7860\\r\\n\\r\\n"}	{"status_code": 200, "body": "{\\"message\\":\\"type is:draft\\"}", "headers": {"date": "Mon, 14 Apr 2025 09:48:04 GMT", "server": "uvicorn", "content-length": "27", "content-type": "application/json"}, "files": []}	succeeded	\N	0.028672	\N	2025-04-14 09:48:04.961537	account	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-14 09:48:04.96483	68c829be-d0d1-4f61-a436-b8c48ecbca01
1b5af183-0a62-410f-b4e4-ef2fe9c0029a	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	54d1bbfc-6bb3-4439-962e-c19dee46a769	workflow-run	ad959009-a8b9-4160-8d3b-58d1a8e1788a	4	1744363805879	1744364683467	end	结束	{"body.message": "{\\"message\\":\\"type is:draft\\"}"}	\N	{"body.message": "{\\"message\\":\\"type is:draft\\"}"}	succeeded	\N	0.01963	\N	2025-04-14 09:48:04.967444	account	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-14 09:48:04.970304	69b3b161-68cf-4326-8167-8480bafcaff6
\.


--
-- TOC entry 4561 (class 0 OID 17128)
-- Dependencies: 276
-- Data for Name: workflow_runs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.workflow_runs (id, tenant_id, app_id, sequence_number, workflow_id, type, triggered_from, version, graph, inputs, status, outputs, error, elapsed_time, total_tokens, total_steps, created_by_role, created_by, created_at, finished_at, exceptions_count) FROM stdin;
6b0773b6-2f61-4119-a663-93cb4154d3e6	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	1	54d1bbfc-6bb3-4439-962e-c19dee46a769	workflow	debugging	draft	{"nodes": [{"id": "1744363492188", "type": "custom", "data": {"type": "start", "title": "\\u5f00\\u59cb", "desc": "", "variables": [{"variable": "interface_type", "label": "interface_type", "type": "text-input", "max_length": 48, "required": true, "options": []}, {"variable": "date", "label": "\\u65e5\\u671f", "type": "number", "max_length": 48, "required": false, "options": []}], "selected": false}, "position": {"x": -120, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": -120, "y": 242.61904761904765}, "width": 244, "height": 116, "selected": false}, {"id": "1744363664951", "type": "custom", "data": {"type": "if-else", "title": "\\u6761\\u4ef6\\u5206\\u652f", "desc": "", "cases": [{"id": "true", "case_id": "true", "logical_operator": "and", "conditions": [{"id": "1fac2023-ad5c-4a25-ac74-5d3164fd8a3c", "varType": "string", "variable_selector": ["1744363492188", "interface_type"], "comparison_operator": "contains", "value": "\\"draft\\""}]}], "selected": false}, "position": {"x": 184, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 184, "y": 242.61904761904765}, "width": 244, "height": 126, "selected": false}, {"id": "1744363805879", "type": "custom", "data": {"type": "http-request", "title": "HTTP \\u8bf7\\u6c42", "desc": "", "variables": [], "method": "get", "url": "http://localhost:7860/query/type", "authorization": {"type": "no-auth", "config": null}, "headers": "", "params": "type:{{#1744363492188.interface_type#}}", "body": {"type": "none", "data": []}, "timeout": {"max_connect_timeout": 0, "max_read_timeout": 0, "max_write_timeout": 0}, "retry_config": {"retry_enabled": true, "max_retries": 3, "retry_interval": 100}, "selected": false}, "position": {"x": 488, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 488, "y": 242.61904761904765}, "width": 244, "height": 135, "selected": false}, {"id": "1744364683467", "type": "custom", "data": {"type": "end", "title": "\\u7ed3\\u675f", "desc": "", "outputs": [{"variable": "body.message", "value_selector": ["1744363805879", "body"]}], "selected": false}, "position": {"x": 792, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 792, "y": 242.61904761904765}, "width": 244, "height": 90, "selected": false}, {"id": "1744364785698", "type": "custom", "data": {"type": "http-request", "title": "HTTP \\u8bf7\\u6c42 2", "desc": "", "variables": [], "method": "get", "url": "http://localhost:7860/", "authorization": {"type": "no-auth", "config": null}, "headers": "", "params": "", "body": {"type": "none", "data": []}, "timeout": {"max_connect_timeout": 0, "max_read_timeout": 0, "max_write_timeout": 0}, "retry_config": {"retry_enabled": true, "max_retries": 3, "retry_interval": 100}, "selected": false}, "position": {"x": 488, "y": 416.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 488, "y": 416.61904761904765}, "width": 244, "height": 119, "selected": true}], "edges": [{"id": "1744363492188-source-1744363664951-target", "type": "custom", "source": "1744363492188", "sourceHandle": "source", "target": "1744363664951", "targetHandle": "target", "data": {"sourceType": "start", "targetType": "if-else", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363664951-true-1744363805879-target", "type": "custom", "source": "1744363664951", "sourceHandle": "true", "target": "1744363805879", "targetHandle": "target", "data": {"sourceType": "if-else", "targetType": "http-request", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363805879-source-1744364683467-target", "type": "custom", "source": "1744363805879", "sourceHandle": "source", "target": "1744364683467", "targetHandle": "target", "data": {"sourceType": "http-request", "targetType": "end", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363664951-false-1744364785698-target", "type": "custom", "source": "1744363664951", "sourceHandle": "false", "target": "1744364785698", "targetHandle": "target", "data": {"sourceType": "if-else", "targetType": "http-request", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744364785698-source-1744364683467-target", "type": "custom", "source": "1744364785698", "target": "1744364683467", "sourceHandle": "source", "targetHandle": "target", "data": {"sourceType": "http-request", "targetType": "end", "isInLoop": false}, "zIndex": 0}], "viewport": {"x": -52.96666666666687, "y": 196.8, "zoom": 0.8400000000000001}}	{"interface_type": "\\u6258\\u5c14\\u65af\\u6cf0", "date": null, "sys.files": [], "sys.user_id": "cc67c45e-e65e-4177-94d6-1af3d06342f5", "sys.app_id": "c84265cd-993f-4287-acc4-d82660a43e42", "sys.workflow_id": "54d1bbfc-6bb3-4439-962e-c19dee46a769", "sys.workflow_run_id": "6b0773b6-2f61-4119-a663-93cb4154d3e6"}	succeeded	{"body.message": null}	\N	0.035061666974797845	0	4	account	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-11 09:47:59.331199	2025-04-11 09:47:59.359033	0
77ef469d-0ea2-4e06-874c-3527c6ac911c	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	2	54d1bbfc-6bb3-4439-962e-c19dee46a769	workflow	debugging	draft	{"nodes": [{"id": "1744363492188", "type": "custom", "data": {"type": "start", "title": "\\u5f00\\u59cb", "desc": "", "variables": [{"variable": "interface_type", "label": "interface_type", "type": "text-input", "max_length": 48, "required": true, "options": []}, {"variable": "date", "label": "\\u65e5\\u671f", "type": "number", "max_length": 48, "required": false, "options": []}], "selected": false}, "position": {"x": -120, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": -120, "y": 242.61904761904765}, "width": 244, "height": 116, "selected": false}, {"id": "1744363664951", "type": "custom", "data": {"type": "if-else", "title": "\\u6761\\u4ef6\\u5206\\u652f", "desc": "", "cases": [{"id": "true", "case_id": "true", "logical_operator": "and", "conditions": [{"id": "1fac2023-ad5c-4a25-ac74-5d3164fd8a3c", "varType": "string", "variable_selector": ["1744363492188", "interface_type"], "comparison_operator": "contains", "value": "\\"draft\\""}]}], "selected": false}, "position": {"x": 184, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 184, "y": 242.61904761904765}, "width": 244, "height": 126, "selected": false}, {"id": "1744363805879", "type": "custom", "data": {"type": "http-request", "title": "HTTP \\u8bf7\\u6c42", "desc": "", "variables": [], "method": "get", "url": "http://localhost:7860/query/type", "authorization": {"type": "no-auth", "config": null}, "headers": "", "params": "type:{{#1744363492188.interface_type#}}", "body": {"type": "none", "data": []}, "timeout": {"max_connect_timeout": 0, "max_read_timeout": 0, "max_write_timeout": 0}, "retry_config": {"retry_enabled": true, "max_retries": 3, "retry_interval": 100}, "selected": false}, "position": {"x": 488, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 488, "y": 242.61904761904765}, "width": 244, "height": 135, "selected": false}, {"id": "1744364683467", "type": "custom", "data": {"type": "end", "title": "\\u7ed3\\u675f", "desc": "", "outputs": [{"variable": "body.message", "value_selector": ["1744363805879", "body"]}], "selected": false}, "position": {"x": 792, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 792, "y": 242.61904761904765}, "width": 244, "height": 90, "selected": false}, {"id": "1744364785698", "type": "custom", "data": {"type": "http-request", "title": "HTTP \\u8bf7\\u6c42 2", "desc": "", "variables": [], "method": "get", "url": "http://localhost:7860/", "authorization": {"type": "no-auth", "config": null}, "headers": "", "params": "", "body": {"type": "none", "data": []}, "timeout": {"max_connect_timeout": 0, "max_read_timeout": 0, "max_write_timeout": 0}, "retry_config": {"retry_enabled": true, "max_retries": 3, "retry_interval": 100}, "selected": false}, "position": {"x": 488, "y": 416.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 488, "y": 416.61904761904765}, "width": 244, "height": 119, "selected": false}, {"id": "1744364922394", "type": "custom", "data": {"type": "end", "title": "\\u7ed3\\u675f 2", "desc": "", "outputs": [{"variable": "body.message", "value_selector": ["1744364785698", "body"]}], "selected": false}, "position": {"x": 792, "y": 416.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 792, "y": 416.61904761904765}, "width": 244, "height": 90, "selected": true}], "edges": [{"id": "1744363492188-source-1744363664951-target", "type": "custom", "source": "1744363492188", "sourceHandle": "source", "target": "1744363664951", "targetHandle": "target", "data": {"sourceType": "start", "targetType": "if-else", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363664951-true-1744363805879-target", "type": "custom", "source": "1744363664951", "sourceHandle": "true", "target": "1744363805879", "targetHandle": "target", "data": {"sourceType": "if-else", "targetType": "http-request", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363805879-source-1744364683467-target", "type": "custom", "source": "1744363805879", "sourceHandle": "source", "target": "1744364683467", "targetHandle": "target", "data": {"sourceType": "http-request", "targetType": "end", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363664951-false-1744364785698-target", "type": "custom", "source": "1744363664951", "sourceHandle": "false", "target": "1744364785698", "targetHandle": "target", "data": {"sourceType": "if-else", "targetType": "http-request", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744364785698-source-1744364922394-target", "type": "custom", "source": "1744364785698", "sourceHandle": "source", "target": "1744364922394", "targetHandle": "target", "data": {"sourceType": "http-request", "targetType": "end", "isInIteration": false, "isInLoop": false}, "zIndex": 0}], "viewport": {"x": -282.7600000000001, "y": 118.89999999999998, "zoom": 0.8400000000000001}}	{"interface_type": "\\u6258\\u5c14\\u65af\\u6cf0", "date": null, "sys.files": [], "sys.user_id": "cc67c45e-e65e-4177-94d6-1af3d06342f5", "sys.app_id": "c84265cd-993f-4287-acc4-d82660a43e42", "sys.workflow_id": "54d1bbfc-6bb3-4439-962e-c19dee46a769", "sys.workflow_run_id": "77ef469d-0ea2-4e06-874c-3527c6ac911c"}	succeeded	{"body.message": "{\\"message\\":\\"Hello from Backend!!!!\\"}"}	\N	0.03639783398830332	0	4	account	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-11 09:49:07.236278	2025-04-11 09:49:07.270067	0
6cf5f266-34b3-4842-ab42-47713a13275b	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	3	9019723c-49bb-40ca-9cd1-3dec6ff7ec69	workflow	app-run	2025-04-11 09:49:17.811816	{"nodes": [{"id": "1744363492188", "type": "custom", "data": {"type": "start", "title": "\\u5f00\\u59cb", "desc": "", "variables": [{"variable": "interface_type", "label": "interface_type", "type": "text-input", "max_length": 48, "required": true, "options": []}, {"variable": "date", "label": "\\u65e5\\u671f", "type": "number", "max_length": 48, "required": false, "options": []}], "selected": false}, "position": {"x": -120, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": -120, "y": 242.61904761904765}, "width": 244, "height": 116, "selected": false}, {"id": "1744363664951", "type": "custom", "data": {"type": "if-else", "title": "\\u6761\\u4ef6\\u5206\\u652f", "desc": "", "cases": [{"id": "true", "case_id": "true", "logical_operator": "and", "conditions": [{"id": "1fac2023-ad5c-4a25-ac74-5d3164fd8a3c", "varType": "string", "variable_selector": ["1744363492188", "interface_type"], "comparison_operator": "contains", "value": "\\"draft\\""}]}], "selected": false}, "position": {"x": 184, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 184, "y": 242.61904761904765}, "width": 244, "height": 126, "selected": false}, {"id": "1744363805879", "type": "custom", "data": {"type": "http-request", "title": "HTTP \\u8bf7\\u6c42", "desc": "", "variables": [], "method": "get", "url": "http://localhost:7860/query/type", "authorization": {"type": "no-auth", "config": null}, "headers": "", "params": "type:{{#1744363492188.interface_type#}}", "body": {"type": "none", "data": []}, "timeout": {"max_connect_timeout": 0, "max_read_timeout": 0, "max_write_timeout": 0}, "retry_config": {"retry_enabled": true, "max_retries": 3, "retry_interval": 100}, "selected": false}, "position": {"x": 488, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 488, "y": 242.61904761904765}, "width": 244, "height": 135, "selected": false}, {"id": "1744364683467", "type": "custom", "data": {"type": "end", "title": "\\u7ed3\\u675f", "desc": "", "outputs": [{"variable": "body.message", "value_selector": ["1744363805879", "body"]}], "selected": false}, "position": {"x": 792, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 792, "y": 242.61904761904765}, "width": 244, "height": 90, "selected": false}, {"id": "1744364785698", "type": "custom", "data": {"type": "http-request", "title": "HTTP \\u8bf7\\u6c42 2", "desc": "", "variables": [], "method": "get", "url": "http://localhost:7860/", "authorization": {"type": "no-auth", "config": null}, "headers": "", "params": "", "body": {"type": "none", "data": []}, "timeout": {"max_connect_timeout": 0, "max_read_timeout": 0, "max_write_timeout": 0}, "retry_config": {"retry_enabled": true, "max_retries": 3, "retry_interval": 100}, "selected": false}, "position": {"x": 488, "y": 416.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 488, "y": 416.61904761904765}, "width": 244, "height": 119, "selected": false}, {"id": "1744364922394", "type": "custom", "data": {"type": "end", "title": "\\u7ed3\\u675f 2", "desc": "", "outputs": [{"variable": "body.message", "value_selector": ["1744364785698", "body"]}], "selected": false}, "position": {"x": 792, "y": 416.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 792, "y": 416.61904761904765}, "width": 244, "height": 90, "selected": true}], "edges": [{"id": "1744363492188-source-1744363664951-target", "type": "custom", "source": "1744363492188", "sourceHandle": "source", "target": "1744363664951", "targetHandle": "target", "data": {"sourceType": "start", "targetType": "if-else", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363664951-true-1744363805879-target", "type": "custom", "source": "1744363664951", "sourceHandle": "true", "target": "1744363805879", "targetHandle": "target", "data": {"sourceType": "if-else", "targetType": "http-request", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363805879-source-1744364683467-target", "type": "custom", "source": "1744363805879", "sourceHandle": "source", "target": "1744364683467", "targetHandle": "target", "data": {"sourceType": "http-request", "targetType": "end", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363664951-false-1744364785698-target", "type": "custom", "source": "1744363664951", "sourceHandle": "false", "target": "1744364785698", "targetHandle": "target", "data": {"sourceType": "if-else", "targetType": "http-request", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744364785698-source-1744364922394-target", "type": "custom", "source": "1744364785698", "sourceHandle": "source", "target": "1744364922394", "targetHandle": "target", "data": {"sourceType": "http-request", "targetType": "end", "isInIteration": false, "isInLoop": false}, "zIndex": 0}], "viewport": {"x": -472.7600000000001, "y": -4.260000000000048, "zoom": 0.8400000000000001}}	{"interface_type": "draft", "date": null, "sys.files": [], "sys.user_id": "23774cc8-88d3-4c97-ab39-ee9535a8d78b", "sys.app_id": "c84265cd-993f-4287-acc4-d82660a43e42", "sys.workflow_id": "9019723c-49bb-40ca-9cd1-3dec6ff7ec69", "sys.workflow_run_id": "6cf5f266-34b3-4842-ab42-47713a13275b"}	succeeded	{"body.message": "{\\"message\\":\\"Hello from Backend!!!!\\"}"}	\N	0.030800374981481582	0	4	end_user	729d3247-1c31-402d-8743-7059de037d0d	2025-04-11 09:49:56.672131	2025-04-11 09:49:56.69928	0
7a9ff971-ebee-4777-95a2-5ac0cb9181c4	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	4	9019723c-49bb-40ca-9cd1-3dec6ff7ec69	workflow	app-run	2025-04-11 09:49:17.811816	{"nodes": [{"id": "1744363492188", "type": "custom", "data": {"type": "start", "title": "\\u5f00\\u59cb", "desc": "", "variables": [{"variable": "interface_type", "label": "interface_type", "type": "text-input", "max_length": 48, "required": true, "options": []}, {"variable": "date", "label": "\\u65e5\\u671f", "type": "number", "max_length": 48, "required": false, "options": []}], "selected": false}, "position": {"x": -120, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": -120, "y": 242.61904761904765}, "width": 244, "height": 116, "selected": false}, {"id": "1744363664951", "type": "custom", "data": {"type": "if-else", "title": "\\u6761\\u4ef6\\u5206\\u652f", "desc": "", "cases": [{"id": "true", "case_id": "true", "logical_operator": "and", "conditions": [{"id": "1fac2023-ad5c-4a25-ac74-5d3164fd8a3c", "varType": "string", "variable_selector": ["1744363492188", "interface_type"], "comparison_operator": "contains", "value": "\\"draft\\""}]}], "selected": false}, "position": {"x": 184, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 184, "y": 242.61904761904765}, "width": 244, "height": 126, "selected": false}, {"id": "1744363805879", "type": "custom", "data": {"type": "http-request", "title": "HTTP \\u8bf7\\u6c42", "desc": "", "variables": [], "method": "get", "url": "http://localhost:7860/query/type", "authorization": {"type": "no-auth", "config": null}, "headers": "", "params": "type:{{#1744363492188.interface_type#}}", "body": {"type": "none", "data": []}, "timeout": {"max_connect_timeout": 0, "max_read_timeout": 0, "max_write_timeout": 0}, "retry_config": {"retry_enabled": true, "max_retries": 3, "retry_interval": 100}, "selected": false}, "position": {"x": 488, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 488, "y": 242.61904761904765}, "width": 244, "height": 135, "selected": false}, {"id": "1744364683467", "type": "custom", "data": {"type": "end", "title": "\\u7ed3\\u675f", "desc": "", "outputs": [{"variable": "body.message", "value_selector": ["1744363805879", "body"]}], "selected": false}, "position": {"x": 792, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 792, "y": 242.61904761904765}, "width": 244, "height": 90, "selected": false}, {"id": "1744364785698", "type": "custom", "data": {"type": "http-request", "title": "HTTP \\u8bf7\\u6c42 2", "desc": "", "variables": [], "method": "get", "url": "http://localhost:7860/", "authorization": {"type": "no-auth", "config": null}, "headers": "", "params": "", "body": {"type": "none", "data": []}, "timeout": {"max_connect_timeout": 0, "max_read_timeout": 0, "max_write_timeout": 0}, "retry_config": {"retry_enabled": true, "max_retries": 3, "retry_interval": 100}, "selected": false}, "position": {"x": 488, "y": 416.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 488, "y": 416.61904761904765}, "width": 244, "height": 119, "selected": false}, {"id": "1744364922394", "type": "custom", "data": {"type": "end", "title": "\\u7ed3\\u675f 2", "desc": "", "outputs": [{"variable": "body.message", "value_selector": ["1744364785698", "body"]}], "selected": false}, "position": {"x": 792, "y": 416.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 792, "y": 416.61904761904765}, "width": 244, "height": 90, "selected": true}], "edges": [{"id": "1744363492188-source-1744363664951-target", "type": "custom", "source": "1744363492188", "sourceHandle": "source", "target": "1744363664951", "targetHandle": "target", "data": {"sourceType": "start", "targetType": "if-else", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363664951-true-1744363805879-target", "type": "custom", "source": "1744363664951", "sourceHandle": "true", "target": "1744363805879", "targetHandle": "target", "data": {"sourceType": "if-else", "targetType": "http-request", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363805879-source-1744364683467-target", "type": "custom", "source": "1744363805879", "sourceHandle": "source", "target": "1744364683467", "targetHandle": "target", "data": {"sourceType": "http-request", "targetType": "end", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363664951-false-1744364785698-target", "type": "custom", "source": "1744363664951", "sourceHandle": "false", "target": "1744364785698", "targetHandle": "target", "data": {"sourceType": "if-else", "targetType": "http-request", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744364785698-source-1744364922394-target", "type": "custom", "source": "1744364785698", "sourceHandle": "source", "target": "1744364922394", "targetHandle": "target", "data": {"sourceType": "http-request", "targetType": "end", "isInIteration": false, "isInLoop": false}, "zIndex": 0}], "viewport": {"x": -472.7600000000001, "y": -4.260000000000048, "zoom": 0.8400000000000001}}	{"interface_type": "\\"draft\\"", "date": null, "sys.files": [], "sys.user_id": "23774cc8-88d3-4c97-ab39-ee9535a8d78b", "sys.app_id": "c84265cd-993f-4287-acc4-d82660a43e42", "sys.workflow_id": "9019723c-49bb-40ca-9cd1-3dec6ff7ec69", "sys.workflow_run_id": "7a9ff971-ebee-4777-95a2-5ac0cb9181c4"}	succeeded	{"body.message": "{\\"message\\":\\"type is:\\\\\\"draft\\\\\\"\\"}"}	\N	0.044496666989289224	0	4	end_user	729d3247-1c31-402d-8743-7059de037d0d	2025-04-11 09:50:22.875528	2025-04-11 09:50:22.91458	0
027b3626-f8cf-4f95-af12-b9bce48d52cc	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	5	9d7731c1-972f-414a-ba17-48efb60862ac	workflow	app-run	2025-04-11 09:50:42.699254	{"nodes": [{"id": "1744363492188", "type": "custom", "data": {"type": "start", "title": "\\u5f00\\u59cb", "desc": "", "variables": [{"variable": "interface_type", "label": "interface_type", "type": "text-input", "max_length": 48, "required": true, "options": []}, {"variable": "date", "label": "\\u65e5\\u671f", "type": "number", "max_length": 48, "required": false, "options": []}], "selected": false}, "position": {"x": -120, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": -120, "y": 242.61904761904765}, "width": 244, "height": 116, "selected": false}, {"id": "1744363664951", "type": "custom", "data": {"type": "if-else", "title": "\\u6761\\u4ef6\\u5206\\u652f", "desc": "", "cases": [{"id": "true", "case_id": "true", "logical_operator": "and", "conditions": [{"id": "1fac2023-ad5c-4a25-ac74-5d3164fd8a3c", "varType": "string", "variable_selector": ["1744363492188", "interface_type"], "comparison_operator": "contains", "value": "draft"}]}], "selected": true}, "position": {"x": 184, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 184, "y": 242.61904761904765}, "width": 244, "height": 126, "selected": true}, {"id": "1744363805879", "type": "custom", "data": {"type": "http-request", "title": "HTTP \\u8bf7\\u6c42", "desc": "", "variables": [], "method": "get", "url": "http://localhost:7860/query/type", "authorization": {"type": "no-auth", "config": null}, "headers": "", "params": "type:{{#1744363492188.interface_type#}}", "body": {"type": "none", "data": []}, "timeout": {"max_connect_timeout": 0, "max_read_timeout": 0, "max_write_timeout": 0}, "retry_config": {"retry_enabled": true, "max_retries": 3, "retry_interval": 100}, "selected": false}, "position": {"x": 488, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 488, "y": 242.61904761904765}, "width": 244, "height": 135, "selected": false}, {"id": "1744364683467", "type": "custom", "data": {"type": "end", "title": "\\u7ed3\\u675f", "desc": "", "outputs": [{"variable": "body.message", "value_selector": ["1744363805879", "body"]}], "selected": false}, "position": {"x": 792, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 792, "y": 242.61904761904765}, "width": 244, "height": 90, "selected": false}, {"id": "1744364785698", "type": "custom", "data": {"type": "http-request", "title": "HTTP \\u8bf7\\u6c42 2", "desc": "", "variables": [], "method": "get", "url": "http://localhost:7860/", "authorization": {"type": "no-auth", "config": null}, "headers": "", "params": "", "body": {"type": "none", "data": []}, "timeout": {"max_connect_timeout": 0, "max_read_timeout": 0, "max_write_timeout": 0}, "retry_config": {"retry_enabled": true, "max_retries": 3, "retry_interval": 100}, "selected": false}, "position": {"x": 488, "y": 416.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 488, "y": 416.61904761904765}, "width": 244, "height": 119, "selected": false}, {"id": "1744364922394", "type": "custom", "data": {"type": "end", "title": "\\u7ed3\\u675f 2", "desc": "", "outputs": [{"variable": "body.message", "value_selector": ["1744364785698", "body"]}], "selected": false}, "position": {"x": 792, "y": 416.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 792, "y": 416.61904761904765}, "width": 244, "height": 90, "selected": false}], "edges": [{"id": "1744363492188-source-1744363664951-target", "type": "custom", "source": "1744363492188", "sourceHandle": "source", "target": "1744363664951", "targetHandle": "target", "data": {"sourceType": "start", "targetType": "if-else", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363664951-true-1744363805879-target", "type": "custom", "source": "1744363664951", "sourceHandle": "true", "target": "1744363805879", "targetHandle": "target", "data": {"sourceType": "if-else", "targetType": "http-request", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363805879-source-1744364683467-target", "type": "custom", "source": "1744363805879", "sourceHandle": "source", "target": "1744364683467", "targetHandle": "target", "data": {"sourceType": "http-request", "targetType": "end", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363664951-false-1744364785698-target", "type": "custom", "source": "1744363664951", "sourceHandle": "false", "target": "1744364785698", "targetHandle": "target", "data": {"sourceType": "if-else", "targetType": "http-request", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744364785698-source-1744364922394-target", "type": "custom", "source": "1744364785698", "sourceHandle": "source", "target": "1744364922394", "targetHandle": "target", "data": {"sourceType": "http-request", "targetType": "end", "isInIteration": false, "isInLoop": false}, "zIndex": 0}], "viewport": {"x": -16.760000000000105, "y": -1.2600000000000477, "zoom": 0.8400000000000001}}	{"interface_type": "draft", "date": null, "sys.files": [], "sys.user_id": "abc-123", "sys.app_id": "c84265cd-993f-4287-acc4-d82660a43e42", "sys.workflow_id": "9d7731c1-972f-414a-ba17-48efb60862ac", "sys.workflow_run_id": "027b3626-f8cf-4f95-af12-b9bce48d52cc"}	succeeded	{"body.message": "{\\"message\\":\\"type is:draft\\"}"}	\N	0.04072379198623821	0	4	end_user	e170fafb-a95c-4237-9245-e44bfb69c33e	2025-04-11 09:52:57.15989	2025-04-11 09:52:57.194198	0
82d6d05f-46df-4d21-82be-e3c5616c4e1f	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	6	54d1bbfc-6bb3-4439-962e-c19dee46a769	workflow	debugging	draft	{"nodes": [{"id": "1744363492188", "type": "custom", "data": {"type": "start", "title": "\\u5f00\\u59cb", "desc": "", "variables": [], "selected": false}, "position": {"x": 7.857142857142833, "y": 428.33333333333337}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 7.857142857142833, "y": 428.33333333333337}, "width": 244, "height": 54, "selected": true}, {"id": "1744363664951", "type": "custom", "data": {"type": "if-else", "title": "\\u6761\\u4ef6\\u5206\\u652f", "desc": "", "cases": [{"id": "true", "case_id": "true", "logical_operator": "and", "conditions": [{"id": "1fac2023-ad5c-4a25-ac74-5d3164fd8a3c", "varType": "string", "variable_selector": ["1744363492188", "interface_type"], "comparison_operator": "contains", "value": "draft"}]}], "selected": false}, "position": {"x": 305.42857142857144, "y": 383.09523809523813}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 305.42857142857144, "y": 383.09523809523813}, "width": 244, "height": 126, "selected": false}, {"id": "1744363805879", "type": "custom", "data": {"type": "http-request", "title": "HTTP \\u8bf7\\u6c42", "desc": "", "variables": [], "method": "get", "url": "http://localhost:7860/query/type", "authorization": {"type": "no-auth", "config": null}, "headers": "", "params": "type:{{#1744363492188.interface_type#}}", "body": {"type": "none", "data": []}, "timeout": {"max_connect_timeout": 0, "max_read_timeout": 0, "max_write_timeout": 0}, "retry_config": {"retry_enabled": true, "max_retries": 3, "retry_interval": 100}, "selected": false}, "position": {"x": 664.1904761904761, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 664.1904761904761, "y": 242.61904761904765}, "width": 244, "height": 135, "selected": false}, {"id": "1744364683467", "type": "custom", "data": {"type": "end", "title": "\\u7ed3\\u675f", "desc": "", "outputs": [{"variable": "body.message", "value_selector": ["1744363805879", "body"]}], "selected": false}, "position": {"x": 1008.6666666666667, "y": 235.47619047619048}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 1008.6666666666667, "y": 235.47619047619048}, "width": 244, "height": 90, "selected": false}, {"id": "1744364785698", "type": "custom", "data": {"type": "http-request", "title": "HTTP \\u8bf7\\u6c42 2", "desc": "", "variables": [], "method": "get", "url": "http://localhost:7860/", "authorization": {"type": "no-auth", "config": null}, "headers": "", "params": "", "body": {"type": "none", "data": []}, "timeout": {"max_connect_timeout": 0, "max_read_timeout": 0, "max_write_timeout": 0}, "retry_config": {"retry_enabled": true, "max_retries": 3, "retry_interval": 100}, "selected": false}, "position": {"x": 695.142857142857, "y": 428.33333333333337}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 695.142857142857, "y": 428.33333333333337}, "width": 244, "height": 119, "selected": false}, {"id": "1744364922394", "type": "custom", "data": {"type": "end", "title": "\\u7ed3\\u675f 2", "desc": "", "outputs": [{"variable": "body.message", "value_selector": ["1744364785698", "body"]}], "selected": false}, "position": {"x": 1088.4285714285713, "y": 411.8571428571429}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 1088.4285714285713, "y": 411.8571428571429}, "width": 244, "height": 90, "selected": false}], "edges": [{"id": "1744363492188-source-1744363664951-target", "type": "custom", "source": "1744363492188", "sourceHandle": "source", "target": "1744363664951", "targetHandle": "target", "data": {"sourceType": "start", "targetType": "if-else", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363664951-true-1744363805879-target", "type": "custom", "source": "1744363664951", "sourceHandle": "true", "target": "1744363805879", "targetHandle": "target", "data": {"sourceType": "if-else", "targetType": "http-request", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363805879-source-1744364683467-target", "type": "custom", "source": "1744363805879", "sourceHandle": "source", "target": "1744364683467", "targetHandle": "target", "data": {"sourceType": "http-request", "targetType": "end", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363664951-false-1744364785698-target", "type": "custom", "source": "1744363664951", "sourceHandle": "false", "target": "1744364785698", "targetHandle": "target", "data": {"sourceType": "if-else", "targetType": "http-request", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744364785698-source-1744364922394-target", "type": "custom", "source": "1744364785698", "sourceHandle": "source", "target": "1744364922394", "targetHandle": "target", "data": {"sourceType": "http-request", "targetType": "end", "isInIteration": false, "isInLoop": false}, "zIndex": 0}], "viewport": {"x": -3.1600000000001045, "y": -1.2600000000000477, "zoom": 0.8400000000000001}}	{"sys.files": [], "sys.user_id": "cc67c45e-e65e-4177-94d6-1af3d06342f5", "sys.app_id": "c84265cd-993f-4287-acc4-d82660a43e42", "sys.workflow_id": "54d1bbfc-6bb3-4439-962e-c19dee46a769", "sys.workflow_run_id": "82d6d05f-46df-4d21-82be-e3c5616c4e1f"}	failed	{}	Variable ['1744363492188', 'interface_type'] not found	0.03672762499991222	0	2	account	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-14 08:01:25.383847	2025-04-14 08:01:25.413202	0
d4e74850-5765-496d-8f9d-2dbc27370951	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	7	54d1bbfc-6bb3-4439-962e-c19dee46a769	workflow	debugging	draft	{"nodes": [{"id": "1744363492188", "type": "custom", "data": {"type": "start", "title": "\\u5f00\\u59cb", "desc": "", "variables": [{"variable": "interface_type", "label": "interface_type", "type": "text-input", "max_length": 48, "required": true, "options": []}], "selected": false}, "position": {"x": -67.46044449089487, "y": 404.52380952380946}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": -67.46044449089487, "y": 404.52380952380946}, "width": 244, "height": 90, "selected": false}, {"id": "1744363664951", "type": "custom", "data": {"type": "if-else", "title": "\\u6761\\u4ef6\\u5206\\u652f", "desc": "", "cases": [{"id": "true", "case_id": "true", "logical_operator": "and", "conditions": [{"id": "65cf6a4e-b0b3-4b84-b9d3-c454c90abc33", "varType": "string", "variable_selector": ["1744363492188", "interface_type"], "comparison_operator": "contains", "value": "draft"}]}], "selected": false}, "position": {"x": 261.3809523809522, "y": 387.8571428571429}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 261.3809523809522, "y": 387.8571428571429}, "width": 244, "height": 126, "selected": false}, {"id": "1744363805879", "type": "custom", "data": {"type": "http-request", "title": "HTTP \\u8bf7\\u6c42", "desc": "", "variables": [], "method": "get", "url": "http://localhost:7860/query/type", "authorization": {"type": "no-auth", "config": null}, "headers": "", "params": "type:{{#1744363492188.interface_type#}}", "body": {"type": "none", "data": []}, "timeout": {"max_connect_timeout": 0, "max_read_timeout": 0, "max_write_timeout": 0}, "retry_config": {"retry_enabled": true, "max_retries": 3, "retry_interval": 100}, "selected": false}, "position": {"x": 664.1904761904761, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 664.1904761904761, "y": 242.61904761904765}, "width": 244, "height": 135, "selected": false}, {"id": "1744364683467", "type": "custom", "data": {"type": "end", "title": "\\u7ed3\\u675f", "desc": "", "outputs": [{"variable": "body.message", "value_selector": ["1744363805879", "body"]}], "selected": false}, "position": {"x": 1008.6666666666667, "y": 235.47619047619048}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 1008.6666666666667, "y": 235.47619047619048}, "width": 244, "height": 90, "selected": false}, {"id": "1744364785698", "type": "custom", "data": {"type": "http-request", "title": "HTTP \\u8bf7\\u6c42 2", "desc": "", "variables": [], "method": "get", "url": "http://localhost:7860/", "authorization": {"type": "no-auth", "config": null}, "headers": "", "params": "", "body": {"type": "none", "data": []}, "timeout": {"max_connect_timeout": 0, "max_read_timeout": 0, "max_write_timeout": 0}, "retry_config": {"retry_enabled": true, "max_retries": 3, "retry_interval": 100}, "selected": false}, "position": {"x": 695.142857142857, "y": 428.33333333333337}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 695.142857142857, "y": 428.33333333333337}, "width": 244, "height": 119, "selected": false}, {"id": "1744364922394", "type": "custom", "data": {"type": "end", "title": "\\u7ed3\\u675f 2", "desc": "", "outputs": [{"variable": "body.message", "value_selector": ["1744364785698", "body"]}], "selected": false}, "position": {"x": 1088.4285714285713, "y": 411.8571428571429}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 1088.4285714285713, "y": 411.8571428571429}, "width": 244, "height": 90, "selected": true}], "edges": [{"id": "1744363492188-source-1744363664951-target", "type": "custom", "source": "1744363492188", "sourceHandle": "source", "target": "1744363664951", "targetHandle": "target", "data": {"sourceType": "start", "targetType": "if-else", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363664951-true-1744363805879-target", "type": "custom", "source": "1744363664951", "sourceHandle": "true", "target": "1744363805879", "targetHandle": "target", "data": {"sourceType": "if-else", "targetType": "http-request", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363805879-source-1744364683467-target", "type": "custom", "source": "1744363805879", "sourceHandle": "source", "target": "1744364683467", "targetHandle": "target", "data": {"sourceType": "http-request", "targetType": "end", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363664951-false-1744364785698-target", "type": "custom", "source": "1744363664951", "sourceHandle": "false", "target": "1744364785698", "targetHandle": "target", "data": {"sourceType": "if-else", "targetType": "http-request", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744364785698-source-1744364922394-target", "type": "custom", "source": "1744364785698", "sourceHandle": "source", "target": "1744364922394", "targetHandle": "target", "data": {"sourceType": "http-request", "targetType": "end", "isInIteration": false, "isInLoop": false}, "zIndex": 0}], "viewport": {"x": -72.64375330564826, "y": 60.13522785431172, "zoom": 0.6414029017418869}}	{"interface_type": "draft", "sys.files": [], "sys.user_id": "cc67c45e-e65e-4177-94d6-1af3d06342f5", "sys.app_id": "c84265cd-993f-4287-acc4-d82660a43e42", "sys.workflow_id": "54d1bbfc-6bb3-4439-962e-c19dee46a769", "sys.workflow_run_id": "d4e74850-5765-496d-8f9d-2dbc27370951"}	succeeded	{"body.message": "{\\"message\\":\\"type is:draft\\"}"}	\N	0.057357041998329805	0	4	account	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-14 09:06:42.810337	2025-04-14 09:06:42.85351	0
ad959009-a8b9-4160-8d3b-58d1a8e1788a	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	8	54d1bbfc-6bb3-4439-962e-c19dee46a769	workflow	debugging	draft	{"nodes": [{"id": "1744363492188", "type": "custom", "data": {"type": "start", "title": "\\u5f00\\u59cb", "desc": "", "variables": [{"variable": "interface_type", "label": "interface_type", "type": "text-input", "max_length": 48, "required": true, "options": []}], "selected": false}, "position": {"x": -67.46044449089487, "y": 404.52380952380946}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": -67.46044449089487, "y": 404.52380952380946}, "width": 244, "height": 90, "selected": false}, {"id": "1744363664951", "type": "custom", "data": {"type": "if-else", "title": "\\u6761\\u4ef6\\u5206\\u652f", "desc": "", "cases": [{"id": "true", "case_id": "true", "logical_operator": "and", "conditions": [{"id": "65cf6a4e-b0b3-4b84-b9d3-c454c90abc33", "varType": "string", "variable_selector": ["1744363492188", "interface_type"], "comparison_operator": "contains", "value": "draft"}]}], "selected": false}, "position": {"x": 261.3809523809522, "y": 387.8571428571429}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 261.3809523809522, "y": 387.8571428571429}, "width": 244, "height": 126, "selected": false}, {"id": "1744363805879", "type": "custom", "data": {"type": "http-request", "title": "HTTP \\u8bf7\\u6c42", "desc": "", "variables": [], "method": "get", "url": "http://localhost:7860/query/type", "authorization": {"type": "no-auth", "config": null}, "headers": "", "params": "type:{{#1744363492188.interface_type#}}", "body": {"type": "none", "data": []}, "timeout": {"max_connect_timeout": 0, "max_read_timeout": 0, "max_write_timeout": 0}, "retry_config": {"retry_enabled": true, "max_retries": 3, "retry_interval": 100}, "selected": false}, "position": {"x": 664.1904761904761, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 664.1904761904761, "y": 242.61904761904765}, "width": 244, "height": 135, "selected": false}, {"id": "1744364683467", "type": "custom", "data": {"type": "end", "title": "\\u7ed3\\u675f", "desc": "", "outputs": [{"variable": "body.message", "value_selector": ["1744363805879", "body"]}], "selected": false}, "position": {"x": 1008.6666666666667, "y": 235.47619047619048}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 1008.6666666666667, "y": 235.47619047619048}, "width": 244, "height": 90, "selected": false}, {"id": "1744364785698", "type": "custom", "data": {"type": "http-request", "title": "HTTP \\u8bf7\\u6c42 2", "desc": "", "variables": [], "method": "get", "url": "http://localhost:7860/", "authorization": {"type": "no-auth", "config": null}, "headers": "", "params": "", "body": {"type": "none", "data": []}, "timeout": {"max_connect_timeout": 0, "max_read_timeout": 0, "max_write_timeout": 0}, "retry_config": {"retry_enabled": true, "max_retries": 3, "retry_interval": 100}, "selected": false}, "position": {"x": 695.142857142857, "y": 428.33333333333337}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 695.142857142857, "y": 428.33333333333337}, "width": 244, "height": 119, "selected": false}, {"id": "1744364922394", "type": "custom", "data": {"type": "end", "title": "\\u7ed3\\u675f 2", "desc": "", "outputs": [{"variable": "body.message", "value_selector": ["1744364785698", "body"]}], "selected": false}, "position": {"x": 1088.4285714285713, "y": 411.8571428571429}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 1088.4285714285713, "y": 411.8571428571429}, "width": 244, "height": 90, "selected": true}], "edges": [{"id": "1744363492188-source-1744363664951-target", "type": "custom", "source": "1744363492188", "sourceHandle": "source", "target": "1744363664951", "targetHandle": "target", "data": {"sourceType": "start", "targetType": "if-else", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363664951-true-1744363805879-target", "type": "custom", "source": "1744363664951", "sourceHandle": "true", "target": "1744363805879", "targetHandle": "target", "data": {"sourceType": "if-else", "targetType": "http-request", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363805879-source-1744364683467-target", "type": "custom", "source": "1744363805879", "sourceHandle": "source", "target": "1744364683467", "targetHandle": "target", "data": {"sourceType": "http-request", "targetType": "end", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363664951-false-1744364785698-target", "type": "custom", "source": "1744363664951", "sourceHandle": "false", "target": "1744364785698", "targetHandle": "target", "data": {"sourceType": "if-else", "targetType": "http-request", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744364785698-source-1744364922394-target", "type": "custom", "source": "1744364785698", "sourceHandle": "source", "target": "1744364922394", "targetHandle": "target", "data": {"sourceType": "http-request", "targetType": "end", "isInIteration": false, "isInLoop": false}, "zIndex": 0}], "viewport": {"x": -445.21288090282684, "y": 196.10175755906124, "zoom": 0.6414029017418869}}	{"interface_type": "draft", "sys.files": [], "sys.user_id": "cc67c45e-e65e-4177-94d6-1af3d06342f5", "sys.app_id": "c84265cd-993f-4287-acc4-d82660a43e42", "sys.workflow_id": "54d1bbfc-6bb3-4439-962e-c19dee46a769", "sys.workflow_run_id": "ad959009-a8b9-4160-8d3b-58d1a8e1788a"}	succeeded	{"body.message": "{\\"message\\":\\"type is:draft\\"}"}	\N	0.0421824579971144	0	4	account	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-14 09:48:04.935538	2025-04-14 09:48:04.973545	0
\.


--
-- TOC entry 4562 (class 0 OID 17141)
-- Dependencies: 277
-- Data for Name: workflows; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.workflows (id, tenant_id, app_id, type, version, graph, features, created_by, created_at, updated_by, updated_at, environment_variables, conversation_variables, marked_name, marked_comment) FROM stdin;
611d1b38-8952-4865-9275-a53e27485ca4	358a104c-8954-4063-beb6-e7bb3ae5de0f	3e96b986-3124-4fd2-93bd-26a45a194dd9	chat	draft	{"nodes": [{"data": {"desc": "", "selected": false, "title": "Start", "type": "start", "variables": [{"label": "depth", "max_length": 48, "options": [], "required": false, "type": "number", "variable": "depth"}]}, "height": 90, "id": "1739229221219", "position": {"x": 366.31402428155843, "y": 451.3953252394805}, "positionAbsolute": {"x": 366.31402428155843, "y": 451.3953252394805}, "selected": false, "sourcePosition": "right", "targetPosition": "left", "type": "custom", "width": 244}, {"data": {"answer": "\\n{{#1739246156652.text#}}", "desc": "", "selected": false, "title": "Answer", "type": "answer", "variables": []}, "height": 105, "id": "answer", "position": {"x": 1858.4472130110016, "y": 676.2043901579685}, "positionAbsolute": {"x": 1858.4472130110016, "y": 676.2043901579685}, "selected": false, "sourcePosition": "right", "targetPosition": "left", "type": "custom", "width": 244}, {"data": {"desc": "", "error_handle_mode": "terminated", "height": 1042, "is_parallel": false, "iterator_selector": ["1739245548624", "array"], "output_selector": ["1739254296073", "output"], "output_type": "array[string]", "parallel_nums": 10, "selected": false, "start_node_id": "1739244888446start", "title": "Iteration", "type": "iteration", "width": 1186}, "height": 1042, "id": "1739244888446", "position": {"x": 650.8824354561594, "y": 550.399123970737}, "positionAbsolute": {"x": 650.8824354561594, "y": 550.399123970737}, "selected": false, "sourcePosition": "right", "targetPosition": "left", "type": "custom", "width": 1186, "zIndex": 1}, {"data": {"desc": "", "isInIteration": true, "selected": false, "title": "", "type": "iteration-start"}, "draggable": false, "height": 48, "id": "1739244888446start", "parentId": "1739244888446", "position": {"x": 24, "y": 68}, "positionAbsolute": {"x": 674.8824354561594, "y": 618.399123970737}, "selectable": false, "sourcePosition": "right", "targetPosition": "left", "type": "custom-iteration-start", "width": 44, "zIndex": 1002}, {"data": {"context": {"enabled": false, "variable_selector": []}, "desc": "", "isInIteration": true, "iteration_id": "1739244888446", "memory": {"query_prompt_template": "## Topic\\n{{#sys.query#}}\\n\\n## Findings\\n{{#conversation.findings#}}\\n\\n## Searched Topics\\n{{#conversation.topics#}}", "role_prefix": {"assistant": "", "user": ""}, "window": {"enabled": false, "size": 50}}, "model": {"completion_params": {"response_format": "json_object", "temperature": 0.7}, "mode": "chat", "name": "gpt-4o", "provider": "langgenius/openai/openai"}, "prompt_template": [{"id": "2acdb5a9-823a-4ce3-8dbe-401540a61bc5", "role": "system", "text": "You are a research agent investigating the following topic.\\nWhat have you found? What questions remain unanswered? What specific aspects should be investigated next?\\n\\n## Output\\n- Do not output topics that are exactly the same as already searched topics.\\n- If further information search is needed, set nextSearchTopic.\\n- If sufficient information has been obtained, set shouldContinue to false.\\n- Please output in json format\\n\\n```json\\nnextSearchTopic: str | None\\nshouldContinue: bool \\n```\\n\\n\\n"}], "selected": false, "title": "LLM", "type": "llm", "variables": [], "vision": {"enabled": false}}, "height": 96, "id": "1739245286499", "parentId": "1739244888446", "position": {"x": 128, "y": 67.17608171067138}, "positionAbsolute": {"x": 778.8824354561594, "y": 617.5752056814084}, "selected": false, "sourcePosition": "right", "targetPosition": "left", "type": "custom", "width": 244, "zIndex": 1002}, {"data": {"desc": "", "isInIteration": true, "iteration_id": "1739244888446", "provider_id": "tavily", "provider_name": "tavily", "provider_type": "builtin", "selected": false, "title": "Tavily Search", "tool_configurations": {"days": 3, "exclude_domains": null, "include_answer": 0, "include_domains": null, "include_image_descriptions": 0, "include_images": 0, "include_raw_content": 0, "max_results": 5, "search_depth": "advanced", "topic": "general"}, "tool_label": "Tavily Search", "tool_name": "tavily_search", "tool_parameters": {"query": {"type": "mixed", "value": "{{#conversation.nextSearchTopic#}}"}}, "type": "tool"}, "height": 324, "id": "1739245424964", "parentId": "1739244888446", "position": {"x": 326.22599578713334, "y": 498.438562962014}, "positionAbsolute": {"x": 977.1084312432928, "y": 1048.837686932751}, "selected": false, "sourcePosition": "right", "targetPosition": "left", "type": "custom", "width": 244, "zIndex": 1002}, {"data": {"desc": "", "isInIteration": true, "iteration_id": "1739244888446", "provider_id": "json_process", "provider_name": "json_process", "provider_type": "builtin", "selected": false, "title": "Extract nextSearchTopic", "tool_configurations": {"ensure_ascii": 1}, "tool_label": "JSON Parse", "tool_name": "parse", "tool_parameters": {"content": {"type": "mixed", "value": "{{#1739245286499.text#}}"}, "json_filter": {"type": "mixed", "value": "nextSearchTopic"}}, "type": "tool"}, "height": 90, "id": "1739245446901", "parentId": "1739244888446", "position": {"x": 47.75538842320191, "y": 247.82584481078118}, "positionAbsolute": {"x": 698.6378238793613, "y": 798.2249687815182}, "selected": false, "sourcePosition": "right", "targetPosition": "left", "type": "custom", "width": 244, "zIndex": 1002}, {"data": {"desc": "", "isInIteration": true, "iteration_id": "1739244888446", "provider_id": "json_process", "provider_name": "json_process", "provider_type": "builtin", "selected": false, "title": "Extract shouldContinue", "tool_configurations": {"ensure_ascii": 1}, "tool_label": "JSON Parse", "tool_name": "parse", "tool_parameters": {"content": {"type": "mixed", "value": "{{#1739245286499.text#}}"}, "json_filter": {"type": "mixed", "value": "shouldContinue"}}, "type": "tool"}, "height": 90, "id": "1739245524260", "parentId": "1739244888446", "position": {"x": 49.19865333377197, "y": 358.53359239733356}, "positionAbsolute": {"x": 700.0810887899314, "y": 908.9327163680706}, "selected": false, "sourcePosition": "right", "targetPosition": "left", "type": "custom", "width": 244, "zIndex": 1002}, {"data": {"code": "\\ndef main(depth: int) -> dict:\\n    depth = depth or 3\\n    array = list(range(depth))\\n    return {\\n        \\"array\\": array,\\n        \\"depth\\": depth\\n    }\\n", "code_language": "python3", "desc": "", "outputs": {"array": {"children": null, "type": "array[number]"}, "depth": {"children": null, "type": "number"}}, "selected": false, "title": "Create Array", "type": "code", "variables": [{"value_selector": ["1739229221219", "depth"], "variable": "depth"}]}, "height": 54, "id": "1739245548624", "position": {"x": 371.36822492017325, "y": 563.5}, "positionAbsolute": {"x": 371.36822492017325, "y": 563.5}, "selected": false, "sourcePosition": "right", "targetPosition": "left", "type": "custom", "width": 244}, {"data": {"cases": [{"case_id": "true", "conditions": [{"comparison_operator": "is", "id": "b3169e80-3090-4a5b-8df4-3148d7afcb4d", "value": "True", "varType": "string", "variable_selector": ["1739245524260", "text"]}], "id": "true", "logical_operator": "and"}], "desc": "", "isInIteration": true, "iteration_id": "1739244888446", "selected": false, "title": "IF/ELSE", "type": "if-else"}, "height": 126, "id": "1739245723720", "parentId": "1739244888446", "position": {"x": 48.74608363090499, "y": 534.403100663696}, "positionAbsolute": {"x": 699.6285190870644, "y": 1084.802224634433}, "selected": false, "sourcePosition": "right", "targetPosition": "left", "type": "custom", "width": 244, "zIndex": 1002}, {"data": {"desc": "", "isInIteration": true, "items": [{"input_type": "variable", "operation": "over-write", "value": ["1739245446901", "text"], "variable_selector": ["conversation", "nextSearchTopic"], "write_mode": "over-write"}, {"input_type": "variable", "operation": "over-write", "value": ["1739245524260", "text"], "variable_selector": ["conversation", "shouldContinue"], "write_mode": "over-write"}, {"input_type": "variable", "operation": "append", "value": ["conversation", "nextSearchTopic"], "variable_selector": ["conversation", "topics"], "write_mode": "over-write"}], "iteration_id": "1739244888446", "selected": false, "title": "Assign Variables", "type": "assigner", "version": "2"}, "height": 144, "id": "1739245826988", "parentId": "1739244888446", "position": {"x": 751.8559564663802, "y": 65}, "positionAbsolute": {"x": 1402.7383919225397, "y": 615.399123970737}, "selected": false, "sourcePosition": "right", "targetPosition": "left", "type": "custom", "width": 244, "zIndex": 1002}, {"data": {"desc": "", "isInIteration": true, "items": [{"input_type": "variable", "operation": "append", "value": ["1739245424964", "text"], "variable_selector": ["conversation", "findings"], "write_mode": "over-write"}], "iteration_id": "1739244888446", "selected": false, "title": "Assign Variables", "type": "assigner", "version": "2"}, "height": 88, "id": "1739246085820", "parentId": "1739244888446", "position": {"x": 606.0088891085952, "y": 628.4868835893722}, "positionAbsolute": {"x": 1256.8913245647545, "y": 1178.8860075601092}, "selected": false, "sourcePosition": "right", "targetPosition": "left", "type": "custom", "width": 244, "zIndex": 1002}, {"data": {"context": {"enabled": false, "variable_selector": []}, "desc": "", "memory": {"query_prompt_template": "## topic\\n{{#sys.query#}}\\n\\n# findings \\n{{#conversation.findings#}}\\n", "role_prefix": {"assistant": "", "user": ""}, "window": {"enabled": false, "size": 50}}, "model": {"completion_params": {"temperature": 0.7}, "mode": "chat", "name": "deepseek-reasoner", "provider": "langgenius/deepseek/deepseek"}, "prompt_template": [{"id": "89c17d58-6a63-4f4f-98fe-f6534ec1ecb0", "role": "system", "text": "  Based on the investigation results, create a comprehensive analysis of the topic.\\\\nProvide important insights, conclusions, and remaining uncertainties. Cite sources where appropriate. This analysis should be very comprehensive and detailed. It is expected to be a long text.\\\\n\\\\n## Topic\\\\n{{#sys.query#}}\\\\n\\\\n## Findings \\\\n{{#conversation.findings#}}\\\\n"}], "selected": false, "title": "Reasoning Model", "type": "llm", "variables": [], "vision": {"enabled": false}}, "height": 96, "id": "1739246156652", "position": {"x": 1858.4472130110016, "y": 563.5}, "positionAbsolute": {"x": 1858.4472130110016, "y": 563.5}, "selected": false, "sourcePosition": "right", "targetPosition": "left", "type": "custom", "width": 244}, {"data": {"answer": "{{#1739254296073.output#}}", "desc": "", "isInIteration": true, "iteration_id": "1739244888446", "selected": false, "title": "Answer", "type": "answer", "variables": []}, "height": 105, "id": "1739253994297", "parentId": "1739244888446", "position": {"x": 906.5415537904462, "y": 878.1347002855746}, "positionAbsolute": {"x": 1557.4239892466057, "y": 1428.5338242563116}, "selected": false, "sourcePosition": "right", "targetPosition": "left", "type": "custom", "width": 244, "zIndex": 1002}, {"data": {"desc": "", "isInIteration": true, "iteration_id": "1739244888446", "selected": false, "template": "{{ index + 1 }}/{{ depth }}th search executed.\\n\\n", "title": "Intermediate Output Format", "type": "template-transform", "variables": [{"value_selector": ["1739244888446", "index"], "variable": "index"}, {"value_selector": ["1739229221219", "depth"], "variable": "depth"}]}, "height": 54, "id": "1739254060247", "parentId": "1739244888446", "position": {"x": 867.6964657330811, "y": 631.2310099968581}, "positionAbsolute": {"x": 1518.5789011892407, "y": 1181.6301339675952}, "selected": false, "sourcePosition": "right", "targetPosition": "left", "type": "custom", "width": 244, "zIndex": 1002}, {"data": {"desc": "", "isInIteration": true, "iteration_id": "1739244888446", "output_type": "string", "selected": false, "title": "Variable Aggregator", "type": "variable-aggregator", "variables": [["1739254060247", "output"], ["1739254516383", "output"]]}, "height": 131, "id": "1739254296073", "parentId": "1739244888446", "position": {"x": 640.0246481283732, "y": 876.3796107886387}, "positionAbsolute": {"x": 1290.9070835845328, "y": 1426.7787347593758}, "selected": false, "sourcePosition": "right", "targetPosition": "left", "type": "custom", "width": 244, "zIndex": 1002}, {"data": {"desc": "", "isInIteration": true, "iteration_id": "1739244888446", "selected": false, "template": " ", "title": "Empty", "type": "template-transform", "variables": []}, "height": 54, "id": "1739254516383", "parentId": "1739244888446", "position": {"x": 325.67632971971057, "y": 879.2385925098547}, "positionAbsolute": {"x": 976.55876517587, "y": 1429.6377164805917}, "selected": false, "sourcePosition": "right", "targetPosition": "left", "type": "custom", "width": 244, "zIndex": 1002}, {"data": {"author": "stvlynn", "desc": "", "height": 371, "selected": false, "showAuthor": true, "text": "{\\"root\\":{\\"children\\":[{\\"children\\":[{\\"detail\\":0,\\"format\\":0,\\"mode\\":\\"normal\\",\\"style\\":\\"\\",\\"text\\":\\"Deep Research  \\",\\"type\\":\\"text\\",\\"version\\":1}],\\"direction\\":\\"ltr\\",\\"format\\":\\"\\",\\"indent\\":0,\\"type\\":\\"paragraph\\",\\"version\\":1,\\"textFormat\\":0,\\"textStyle\\":\\"\\"},{\\"children\\":[{\\"detail\\":0,\\"format\\":0,\\"mode\\":\\"normal\\",\\"style\\":\\"\\",\\"text\\":\\"Author: Takashi Kishida  https://x.com/omluc_ai\\",\\"type\\":\\"text\\",\\"version\\":1}],\\"direction\\":\\"ltr\\",\\"format\\":\\"\\",\\"indent\\":0,\\"type\\":\\"paragraph\\",\\"version\\":1,\\"textFormat\\":0,\\"textStyle\\":\\"\\"},{\\"children\\":[{\\"detail\\":0,\\"format\\":0,\\"mode\\":\\"normal\\",\\"style\\":\\"\\",\\"text\\":\\"Simply input what you want to search for, and it will repeatedly execute searches to create a report.  \\",\\"type\\":\\"text\\",\\"version\\":1}],\\"direction\\":\\"ltr\\",\\"format\\":\\"\\",\\"indent\\":0,\\"type\\":\\"paragraph\\",\\"version\\":1,\\"textFormat\\":0,\\"textStyle\\":\\"\\"},{\\"children\\":[{\\"detail\\":0,\\"format\\":0,\\"mode\\":\\"normal\\",\\"style\\":\\"\\",\\"text\\":\\"User Input Reception: The user inputs an initial question (sys.query) and the depth of research (depth).  \\",\\"type\\":\\"text\\",\\"version\\":1}],\\"direction\\":\\"ltr\\",\\"format\\":\\"\\",\\"indent\\":0,\\"type\\":\\"paragraph\\",\\"version\\":1,\\"textFormat\\":0,\\"textStyle\\":\\"\\"},{\\"children\\":[],\\"direction\\":null,\\"format\\":\\"\\",\\"indent\\":0,\\"type\\":\\"paragraph\\",\\"version\\":1,\\"textFormat\\":0,\\"textStyle\\":\\"\\"},{\\"children\\":[{\\"detail\\":0,\\"format\\":0,\\"mode\\":\\"normal\\",\\"style\\":\\"\\",\\"text\\":\\"Search Initialization: Using GPT-4o, the initial question is analyzed to extract the search theme and determine whether further searches are necessary.  \\",\\"type\\":\\"text\\",\\"version\\":1}],\\"direction\\":\\"ltr\\",\\"format\\":\\"\\",\\"indent\\":0,\\"type\\":\\"paragraph\\",\\"version\\":1,\\"textFormat\\":0,\\"textStyle\\":\\"\\"},{\\"children\\":[],\\"direction\\":null,\\"format\\":\\"\\",\\"indent\\":0,\\"type\\":\\"paragraph\\",\\"version\\":1,\\"textFormat\\":0,\\"textStyle\\":\\"\\"},{\\"children\\":[{\\"detail\\":0,\\"format\\":0,\\"mode\\":\\"normal\\",\\"style\\":\\"\\",\\"text\\":\\"Iterative Search: Based on the specified depth, multiple rounds of iterative searches are conducted.  \\",\\"type\\":\\"text\\",\\"version\\":1}],\\"direction\\":\\"ltr\\",\\"format\\":\\"\\",\\"indent\\":0,\\"type\\":\\"paragraph\\",\\"version\\":1,\\"textFormat\\":0,\\"textStyle\\":\\"\\"},{\\"children\\":[],\\"direction\\":null,\\"format\\":\\"\\",\\"indent\\":0,\\"type\\":\\"paragraph\\",\\"version\\":1,\\"textFormat\\":0,\\"textStyle\\":\\"\\"},{\\"children\\":[{\\"detail\\":0,\\"format\\":0,\\"mode\\":\\"normal\\",\\"style\\":\\"\\",\\"text\\":\\"In each iteration, the Tavily search engine is used to conduct searches based on the previously extracted search themes and to collect search results.  \\",\\"type\\":\\"text\\",\\"version\\":1}],\\"direction\\":\\"ltr\\",\\"format\\":\\"\\",\\"indent\\":0,\\"type\\":\\"paragraph\\",\\"version\\":1,\\"textFormat\\":0,\\"textStyle\\":\\"\\"},{\\"children\\":[],\\"direction\\":null,\\"format\\":\\"\\",\\"indent\\":0,\\"type\\":\\"paragraph\\",\\"version\\":1,\\"textFormat\\":0,\\"textStyle\\":\\"\\"},{\\"children\\":[{\\"detail\\":0,\\"format\\":0,\\"mode\\":\\"normal\\",\\"style\\":\\"\\",\\"text\\":\\"It assesses whether further searches are needed through the LLM and controls the iterative process.  \\",\\"type\\":\\"text\\",\\"version\\":1}],\\"direction\\":\\"ltr\\",\\"format\\":\\"\\",\\"indent\\":0,\\"type\\":\\"paragraph\\",\\"version\\":1,\\"textFormat\\":0,\\"textStyle\\":\\"\\"},{\\"children\\":[],\\"direction\\":null,\\"format\\":\\"\\",\\"indent\\":0,\\"type\\":\\"paragraph\\",\\"version\\":1,\\"textFormat\\":0,\\"textStyle\\":\\"\\"},{\\"children\\":[{\\"detail\\":0,\\"format\\":0,\\"mode\\":\\"normal\\",\\"style\\":\\"\\",\\"text\\":\\"Analysis and Summary: When the iterative search concludes (or when it is determined that further searches are unnecessary), the deepseek-reasoner model is used to comprehensively analyze and summarize all collected search results.  \\",\\"type\\":\\"text\\",\\"version\\":1}],\\"direction\\":\\"ltr\\",\\"format\\":\\"\\",\\"indent\\":0,\\"type\\":\\"paragraph\\",\\"version\\":1,\\"textFormat\\":0,\\"textStyle\\":\\"\\"},{\\"children\\":[],\\"direction\\":null,\\"format\\":\\"\\",\\"indent\\":0,\\"type\\":\\"paragraph\\",\\"version\\":1,\\"textFormat\\":0,\\"textStyle\\":\\"\\"},{\\"children\\":[{\\"detail\\":0,\\"format\\":0,\\"mode\\":\\"normal\\",\\"style\\":\\"\\",\\"text\\":\\"Report Generation: The analysis results are generated and output as a final report in Markdown format.\\",\\"type\\":\\"text\\",\\"version\\":1}],\\"direction\\":\\"ltr\\",\\"format\\":\\"\\",\\"indent\\":0,\\"type\\":\\"paragraph\\",\\"version\\":1,\\"textFormat\\":0,\\"textStyle\\":\\"\\"}],\\"direction\\":\\"ltr\\",\\"format\\":\\"\\",\\"indent\\":0,\\"type\\":\\"root\\",\\"version\\":1}}", "theme": "blue", "title": "", "type": "", "width": 798}, "height": 371, "id": "1739283628844", "position": {"x": 342.95357738991356, "y": 24.07121075782824}, "positionAbsolute": {"x": 342.95357738991356, "y": 24.07121075782824}, "selected": true, "sourcePosition": "right", "targetPosition": "left", "type": "custom-note", "width": 798}, {"data": {"author": "stvlynn", "desc": "", "height": 227, "selected": false, "showAuthor": true, "text": "{\\"root\\":{\\"children\\":[{\\"children\\":[{\\"detail\\":0,\\"format\\":0,\\"mode\\":\\"normal\\",\\"style\\":\\"\\",\\"text\\":\\"The main function takes an integer representing depth and returns a dictionary containing a list and the final depth value.\\",\\"type\\":\\"text\\",\\"version\\":1}],\\"direction\\":\\"ltr\\",\\"format\\":\\"\\",\\"indent\\":0,\\"type\\":\\"paragraph\\",\\"version\\":1,\\"textFormat\\":0},{\\"children\\":[{\\"children\\":[{\\"detail\\":0,\\"format\\":0,\\"mode\\":\\"normal\\",\\"style\\":\\"\\",\\"text\\":\\"array = list(range(depth)): range(depth) creates a sequence of integers from 0 to depth-1. list() converts this sequence to a list. For example, if depth is 3, array becomes [0, 1, 2].\\",\\"type\\":\\"text\\",\\"version\\":1}],\\"direction\\":\\"ltr\\",\\"format\\":\\"\\",\\"indent\\":0,\\"type\\":\\"listitem\\",\\"version\\":1,\\"value\\":1}],\\"direction\\":\\"ltr\\",\\"format\\":\\"\\",\\"indent\\":0,\\"type\\":\\"list\\",\\"version\\":1,\\"listType\\":\\"bullet\\",\\"start\\":1,\\"tag\\":\\"ul\\"}],\\"direction\\":\\"ltr\\",\\"format\\":\\"\\",\\"indent\\":0,\\"type\\":\\"root\\",\\"version\\":1}}", "theme": "blue", "title": "", "type": "", "width": 265}, "height": 227, "id": "1739283923251", "position": {"x": 85.35900567854111, "y": 550.399123970737}, "positionAbsolute": {"x": 85.35900567854111, "y": 550.399123970737}, "selected": false, "sourcePosition": "right", "targetPosition": "left", "type": "custom-note", "width": 265}, {"data": {"author": "stvlynn", "desc": "", "height": 122, "selected": false, "showAuthor": true, "text": "{\\"root\\":{\\"children\\":[{\\"children\\":[{\\"detail\\":0,\\"format\\":0,\\"mode\\":\\"normal\\",\\"style\\":\\"\\",\\"text\\":\\"The GPT-4o model is used to analyze the user\\u2019s initial query, extract search keywords and topics, and determine whether further search is needed. The output is a JSON-formatted text.\\",\\"type\\":\\"text\\",\\"version\\":1}],\\"direction\\":\\"ltr\\",\\"format\\":\\"\\",\\"indent\\":0,\\"type\\":\\"paragraph\\",\\"version\\":1,\\"textFormat\\":0}],\\"direction\\":\\"ltr\\",\\"format\\":\\"\\",\\"indent\\":0,\\"type\\":\\"root\\",\\"version\\":1}}", "theme": "blue", "title": "", "type": "", "width": 350}, "height": 122, "id": "1739285077334", "position": {"x": 788.6385688481537, "y": 416.30802094190165}, "positionAbsolute": {"x": 788.6385688481537, "y": 416.30802094190165}, "selected": false, "sourcePosition": "right", "targetPosition": "left", "type": "custom-note", "width": 350}, {"data": {"author": "stvlynn", "desc": "", "height": 88, "selected": false, "showAuthor": true, "text": "{\\"root\\":{\\"children\\":[{\\"children\\":[{\\"detail\\":0,\\"format\\":0,\\"mode\\":\\"normal\\",\\"style\\":\\"\\",\\"text\\":\\"Extracts the value of the nextSearchTopic field from the JSON text output by the \\u201cLLM\\u201d node.\\",\\"type\\":\\"text\\",\\"version\\":1}],\\"direction\\":\\"ltr\\",\\"format\\":\\"\\",\\"indent\\":0,\\"type\\":\\"paragraph\\",\\"version\\":1,\\"textFormat\\":0}],\\"direction\\":\\"ltr\\",\\"format\\":\\"\\",\\"indent\\":0,\\"type\\":\\"root\\",\\"version\\":1}}", "theme": "blue", "title": "", "type": "", "width": 240}, "height": 88, "id": "1739285156227", "position": {"x": 392.6233739231274, "y": 790.0751712082184}, "positionAbsolute": {"x": 392.6233739231274, "y": 790.0751712082184}, "selected": false, "sourcePosition": "right", "targetPosition": "left", "type": "custom-note", "width": 240}, {"data": {"author": "stvlynn", "desc": "", "height": 88, "selected": false, "showAuthor": true, "text": "{\\"root\\":{\\"children\\":[{\\"children\\":[{\\"detail\\":0,\\"format\\":0,\\"mode\\":\\"normal\\",\\"style\\":\\"\\",\\"text\\":\\"Extracts the value of the shouldContinue field from the JSON text output by the \\u201cLLM\\u201d node.\\",\\"type\\":\\"text\\",\\"version\\":1}],\\"direction\\":\\"ltr\\",\\"format\\":\\"\\",\\"indent\\":0,\\"type\\":\\"paragraph\\",\\"version\\":1,\\"textFormat\\":0}],\\"direction\\":\\"ltr\\",\\"format\\":\\"\\",\\"indent\\":0,\\"type\\":\\"root\\",\\"version\\":1}}", "theme": "blue", "title": "", "type": "", "width": 240}, "height": 88, "id": "1739285211334", "position": {"x": 385.9489605255146, "y": 921.3386346946035}, "positionAbsolute": {"x": 385.9489605255146, "y": 921.3386346946035}, "sourcePosition": "right", "targetPosition": "left", "type": "custom-note", "width": 240}, {"data": {"author": "stvlynn", "desc": "", "height": 140, "selected": false, "showAuthor": true, "text": "{\\"root\\":{\\"children\\":[{\\"children\\":[{\\"children\\":[{\\"detail\\":0,\\"format\\":0,\\"mode\\":\\"normal\\",\\"style\\":\\"\\",\\"text\\":\\"Overwrites the values extracted from the \\u201cEXTRACT NEXTSEARCHTOPIC\\u201d and \\u201cEXTRACT SHOULDCONTINUE\\u201d nodes to the nextSearchTopic and shouldContinue variables, respectively.\\",\\"type\\":\\"text\\",\\"version\\":1}],\\"direction\\":\\"ltr\\",\\"format\\":\\"\\",\\"indent\\":0,\\"type\\":\\"listitem\\",\\"version\\":1,\\"value\\":1},{\\"children\\":[{\\"detail\\":0,\\"format\\":0,\\"mode\\":\\"normal\\",\\"style\\":\\"\\",\\"text\\":\\"Adds the value of nextSearchTopic to the topics array, forming a list of search topics.\\",\\"type\\":\\"text\\",\\"version\\":1}],\\"direction\\":\\"ltr\\",\\"format\\":\\"\\",\\"indent\\":0,\\"type\\":\\"listitem\\",\\"version\\":1,\\"value\\":2}],\\"direction\\":\\"ltr\\",\\"format\\":\\"\\",\\"indent\\":0,\\"type\\":\\"list\\",\\"version\\":1,\\"listType\\":\\"bullet\\",\\"start\\":1,\\"tag\\":\\"ul\\"}],\\"direction\\":\\"ltr\\",\\"format\\":\\"\\",\\"indent\\":0,\\"type\\":\\"root\\",\\"version\\":1}}", "theme": "blue", "title": "", "type": "", "width": 433}, "height": 140, "id": "1739285254837", "position": {"x": 1330.3784562877254, "y": 402.9591941466761}, "positionAbsolute": {"x": 1330.3784562877254, "y": 402.9591941466761}, "selected": false, "sourcePosition": "right", "targetPosition": "left", "type": "custom-note", "width": 433}], "edges": [{"data": {"isInIteration": true, "iteration_id": "1739244888446", "sourceType": "iteration-start", "targetType": "llm"}, "id": "1739244888446start-source-1739245286499-target", "selected": false, "source": "1739244888446start", "sourceHandle": "source", "target": "1739245286499", "targetHandle": "target", "type": "custom", "zIndex": 1002}, {"data": {"isInIteration": true, "iteration_id": "1739244888446", "sourceType": "llm", "targetType": "tool"}, "id": "1739245286499-source-1739245446901-target", "selected": false, "source": "1739245286499", "sourceHandle": "source", "target": "1739245446901", "targetHandle": "target", "type": "custom", "zIndex": 1002}, {"data": {"isInIteration": true, "iteration_id": "1739244888446", "sourceType": "llm", "targetType": "tool"}, "id": "1739245286499-source-1739245524260-target", "selected": false, "source": "1739245286499", "sourceHandle": "source", "target": "1739245524260", "targetHandle": "target", "type": "custom", "zIndex": 1002}, {"data": {"isInIteration": false, "sourceType": "start", "targetType": "code"}, "id": "1739229221219-source-1739245548624-target", "selected": false, "source": "1739229221219", "sourceHandle": "source", "target": "1739245548624", "targetHandle": "target", "type": "custom", "zIndex": 0}, {"data": {"isInIteration": false, "sourceType": "code", "targetType": "iteration"}, "id": "1739245548624-source-1739244888446-target", "selected": false, "source": "1739245548624", "sourceHandle": "source", "target": "1739244888446", "targetHandle": "target", "type": "custom", "zIndex": 0}, {"data": {"isInIteration": true, "iteration_id": "1739244888446", "sourceType": "if-else", "targetType": "tool"}, "id": "1739245723720-true-1739245424964-target", "selected": false, "source": "1739245723720", "sourceHandle": "true", "target": "1739245424964", "targetHandle": "target", "type": "custom", "zIndex": 1002}, {"data": {"isInIteration": true, "iteration_id": "1739244888446", "sourceType": "tool", "targetType": "assigner"}, "id": "1739245446901-source-1739245826988-target", "selected": false, "source": "1739245446901", "sourceHandle": "source", "target": "1739245826988", "targetHandle": "target", "type": "custom", "zIndex": 1002}, {"data": {"isInIteration": true, "iteration_id": "1739244888446", "sourceType": "tool", "targetType": "assigner"}, "id": "1739245424964-source-1739246085820-target", "selected": false, "source": "1739245424964", "sourceHandle": "source", "target": "1739246085820", "targetHandle": "target", "type": "custom", "zIndex": 1002}, {"data": {"isInIteration": false, "sourceType": "iteration", "targetType": "llm"}, "id": "1739244888446-source-1739246156652-target", "selected": false, "source": "1739244888446", "sourceHandle": "source", "target": "1739246156652", "targetHandle": "target", "type": "custom", "zIndex": 0}, {"data": {"isInIteration": false, "sourceType": "llm", "targetType": "answer"}, "id": "1739246156652-source-answer-target", "selected": false, "source": "1739246156652", "sourceHandle": "source", "target": "answer", "targetHandle": "target", "type": "custom", "zIndex": 0}, {"data": {"isInIteration": true, "iteration_id": "1739244888446", "sourceType": "tool", "targetType": "assigner"}, "id": "1739245524260-source-1739245826988-target", "selected": false, "source": "1739245524260", "sourceHandle": "source", "target": "1739245826988", "targetHandle": "target", "type": "custom", "zIndex": 1002}, {"data": {"isInIteration": true, "iteration_id": "1739244888446", "sourceType": "assigner", "targetType": "if-else"}, "id": "1739245826988-source-1739245723720-target", "selected": false, "source": "1739245826988", "sourceHandle": "source", "target": "1739245723720", "targetHandle": "target", "type": "custom", "zIndex": 1002}, {"data": {"isInIteration": true, "iteration_id": "1739244888446", "sourceType": "assigner", "targetType": "template-transform"}, "id": "1739246085820-source-1739254060247-target", "selected": false, "source": "1739246085820", "sourceHandle": "source", "target": "1739254060247", "targetHandle": "target", "type": "custom", "zIndex": 1002}, {"data": {"isInIteration": true, "iteration_id": "1739244888446", "sourceType": "template-transform", "targetType": "variable-aggregator"}, "id": "1739254060247-source-1739254296073-target", "selected": false, "source": "1739254060247", "sourceHandle": "source", "target": "1739254296073", "targetHandle": "target", "type": "custom", "zIndex": 1002}, {"data": {"isInIteration": true, "iteration_id": "1739244888446", "sourceType": "variable-aggregator", "targetType": "answer"}, "id": "1739254296073-source-1739253994297-target", "selected": false, "source": "1739254296073", "sourceHandle": "source", "target": "1739253994297", "targetHandle": "target", "type": "custom", "zIndex": 1002}, {"data": {"isInIteration": true, "iteration_id": "1739244888446", "sourceType": "if-else", "targetType": "template-transform"}, "id": "1739245723720-false-1739254516383-target", "selected": false, "source": "1739245723720", "sourceHandle": "false", "target": "1739254516383", "targetHandle": "target", "type": "custom", "zIndex": 1002}, {"data": {"isInIteration": true, "iteration_id": "1739244888446", "sourceType": "template-transform", "targetType": "variable-aggregator"}, "id": "1739254516383-source-1739254296073-target", "selected": false, "source": "1739254516383", "sourceHandle": "source", "target": "1739254296073", "targetHandle": "target", "type": "custom", "zIndex": 1002}], "viewport": {"x": 135.60770310626322, "y": 55.92024856617593, "zoom": 0.6705166179563755}}	{"opening_statement": "", "suggested_questions": [], "suggested_questions_after_answer": {"enabled": false}, "text_to_speech": {"enabled": false, "language": "", "voice": ""}, "speech_to_text": {"enabled": false}, "retriever_resource": {"enabled": true}, "sensitive_word_avoidance": {"enabled": false}, "file_upload": {"image": {"enabled": false, "number_limits": 3, "transfer_methods": ["local_file", "remote_url"]}, "enabled": false, "allowed_file_types": ["image"], "allowed_file_extensions": [".JPG", ".JPEG", ".PNG", ".GIF", ".WEBP", ".SVG"], "allowed_file_upload_methods": ["local_file", "remote_url"], "number_limits": 3, "fileUploadConfig": {"file_size_limit": 15, "batch_count_limit": 5, "image_file_size_limit": 10, "video_file_size_limit": 100, "audio_file_size_limit": 50, "workflow_file_upload_limit": 10}}}	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-11 09:19:45	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-11 09:24:22.521324	{}	{"topics": {"value_type": "array[string]", "value": [], "id": "07ea9b5b-edf2-471d-8206-50e95e7ab87e", "name": "topics", "description": "", "selector": ["conversation", "topics"]}, "nextSearchTopic": {"value_type": "string", "value": "", "id": "a9049588-f66f-4c3a-a30e-5952a677baa9", "name": "nextSearchTopic", "description": "", "selector": ["conversation", "nextSearchTopic"]}, "findings": {"value_type": "array[string]", "value": [], "id": "2e0a2539-345c-4723-8b1b-b653e1a0caef", "name": "findings", "description": "", "selector": ["conversation", "findings"]}, "shouldContinue": {"value_type": "string", "value": "true", "id": "23d208d1-a50d-468c-8757-ad49da0886e1", "name": "shouldContinue", "description": "", "selector": ["conversation", "shouldContinue"]}}		
9019723c-49bb-40ca-9cd1-3dec6ff7ec69	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	workflow	2025-04-11 09:49:17.811816	{"nodes": [{"id": "1744363492188", "type": "custom", "data": {"type": "start", "title": "\\u5f00\\u59cb", "desc": "", "variables": [{"variable": "interface_type", "label": "interface_type", "type": "text-input", "max_length": 48, "required": true, "options": []}, {"variable": "date", "label": "\\u65e5\\u671f", "type": "number", "max_length": 48, "required": false, "options": []}], "selected": false}, "position": {"x": -120, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": -120, "y": 242.61904761904765}, "width": 244, "height": 116, "selected": false}, {"id": "1744363664951", "type": "custom", "data": {"type": "if-else", "title": "\\u6761\\u4ef6\\u5206\\u652f", "desc": "", "cases": [{"id": "true", "case_id": "true", "logical_operator": "and", "conditions": [{"id": "1fac2023-ad5c-4a25-ac74-5d3164fd8a3c", "varType": "string", "variable_selector": ["1744363492188", "interface_type"], "comparison_operator": "contains", "value": "\\"draft\\""}]}], "selected": false}, "position": {"x": 184, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 184, "y": 242.61904761904765}, "width": 244, "height": 126, "selected": false}, {"id": "1744363805879", "type": "custom", "data": {"type": "http-request", "title": "HTTP \\u8bf7\\u6c42", "desc": "", "variables": [], "method": "get", "url": "http://localhost:7860/query/type", "authorization": {"type": "no-auth", "config": null}, "headers": "", "params": "type:{{#1744363492188.interface_type#}}", "body": {"type": "none", "data": []}, "timeout": {"max_connect_timeout": 0, "max_read_timeout": 0, "max_write_timeout": 0}, "retry_config": {"retry_enabled": true, "max_retries": 3, "retry_interval": 100}, "selected": false}, "position": {"x": 488, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 488, "y": 242.61904761904765}, "width": 244, "height": 135, "selected": false}, {"id": "1744364683467", "type": "custom", "data": {"type": "end", "title": "\\u7ed3\\u675f", "desc": "", "outputs": [{"variable": "body.message", "value_selector": ["1744363805879", "body"]}], "selected": false}, "position": {"x": 792, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 792, "y": 242.61904761904765}, "width": 244, "height": 90, "selected": false}, {"id": "1744364785698", "type": "custom", "data": {"type": "http-request", "title": "HTTP \\u8bf7\\u6c42 2", "desc": "", "variables": [], "method": "get", "url": "http://localhost:7860/", "authorization": {"type": "no-auth", "config": null}, "headers": "", "params": "", "body": {"type": "none", "data": []}, "timeout": {"max_connect_timeout": 0, "max_read_timeout": 0, "max_write_timeout": 0}, "retry_config": {"retry_enabled": true, "max_retries": 3, "retry_interval": 100}, "selected": false}, "position": {"x": 488, "y": 416.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 488, "y": 416.61904761904765}, "width": 244, "height": 119, "selected": false}, {"id": "1744364922394", "type": "custom", "data": {"type": "end", "title": "\\u7ed3\\u675f 2", "desc": "", "outputs": [{"variable": "body.message", "value_selector": ["1744364785698", "body"]}], "selected": false}, "position": {"x": 792, "y": 416.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 792, "y": 416.61904761904765}, "width": 244, "height": 90, "selected": true}], "edges": [{"id": "1744363492188-source-1744363664951-target", "type": "custom", "source": "1744363492188", "sourceHandle": "source", "target": "1744363664951", "targetHandle": "target", "data": {"sourceType": "start", "targetType": "if-else", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363664951-true-1744363805879-target", "type": "custom", "source": "1744363664951", "sourceHandle": "true", "target": "1744363805879", "targetHandle": "target", "data": {"sourceType": "if-else", "targetType": "http-request", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363805879-source-1744364683467-target", "type": "custom", "source": "1744363805879", "sourceHandle": "source", "target": "1744364683467", "targetHandle": "target", "data": {"sourceType": "http-request", "targetType": "end", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363664951-false-1744364785698-target", "type": "custom", "source": "1744363664951", "sourceHandle": "false", "target": "1744364785698", "targetHandle": "target", "data": {"sourceType": "if-else", "targetType": "http-request", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744364785698-source-1744364922394-target", "type": "custom", "source": "1744364785698", "sourceHandle": "source", "target": "1744364922394", "targetHandle": "target", "data": {"sourceType": "http-request", "targetType": "end", "isInIteration": false, "isInLoop": false}, "zIndex": 0}], "viewport": {"x": -472.7600000000001, "y": -4.260000000000048, "zoom": 0.8400000000000001}}	{"opening_statement": "", "suggested_questions": [], "suggested_questions_after_answer": {"enabled": false}, "text_to_speech": {"enabled": false, "voice": "", "language": ""}, "speech_to_text": {"enabled": false}, "retriever_resource": {"enabled": true}, "sensitive_word_avoidance": {"enabled": false}, "file_upload": {"image": {"enabled": false, "number_limits": 3, "transfer_methods": ["local_file", "remote_url"]}, "enabled": false, "allowed_file_types": ["image"], "allowed_file_extensions": [".JPG", ".JPEG", ".PNG", ".GIF", ".WEBP", ".SVG"], "allowed_file_upload_methods": ["local_file", "remote_url"], "number_limits": 3, "fileUploadConfig": {"file_size_limit": 15, "batch_count_limit": 5, "image_file_size_limit": 10, "video_file_size_limit": 100, "audio_file_size_limit": 50, "workflow_file_upload_limit": 10}}}	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-11 09:49:17.811942	\N	2025-04-11 09:49:17.811942	{}	{}		
9d7731c1-972f-414a-ba17-48efb60862ac	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	workflow	2025-04-11 09:50:42.699254	{"nodes": [{"id": "1744363492188", "type": "custom", "data": {"type": "start", "title": "\\u5f00\\u59cb", "desc": "", "variables": [{"variable": "interface_type", "label": "interface_type", "type": "text-input", "max_length": 48, "required": true, "options": []}, {"variable": "date", "label": "\\u65e5\\u671f", "type": "number", "max_length": 48, "required": false, "options": []}], "selected": false}, "position": {"x": -120, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": -120, "y": 242.61904761904765}, "width": 244, "height": 116, "selected": false}, {"id": "1744363664951", "type": "custom", "data": {"type": "if-else", "title": "\\u6761\\u4ef6\\u5206\\u652f", "desc": "", "cases": [{"id": "true", "case_id": "true", "logical_operator": "and", "conditions": [{"id": "1fac2023-ad5c-4a25-ac74-5d3164fd8a3c", "varType": "string", "variable_selector": ["1744363492188", "interface_type"], "comparison_operator": "contains", "value": "draft"}]}], "selected": true}, "position": {"x": 184, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 184, "y": 242.61904761904765}, "width": 244, "height": 126, "selected": true}, {"id": "1744363805879", "type": "custom", "data": {"type": "http-request", "title": "HTTP \\u8bf7\\u6c42", "desc": "", "variables": [], "method": "get", "url": "http://localhost:7860/query/type", "authorization": {"type": "no-auth", "config": null}, "headers": "", "params": "type:{{#1744363492188.interface_type#}}", "body": {"type": "none", "data": []}, "timeout": {"max_connect_timeout": 0, "max_read_timeout": 0, "max_write_timeout": 0}, "retry_config": {"retry_enabled": true, "max_retries": 3, "retry_interval": 100}, "selected": false}, "position": {"x": 488, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 488, "y": 242.61904761904765}, "width": 244, "height": 135, "selected": false}, {"id": "1744364683467", "type": "custom", "data": {"type": "end", "title": "\\u7ed3\\u675f", "desc": "", "outputs": [{"variable": "body.message", "value_selector": ["1744363805879", "body"]}], "selected": false}, "position": {"x": 792, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 792, "y": 242.61904761904765}, "width": 244, "height": 90, "selected": false}, {"id": "1744364785698", "type": "custom", "data": {"type": "http-request", "title": "HTTP \\u8bf7\\u6c42 2", "desc": "", "variables": [], "method": "get", "url": "http://localhost:7860/", "authorization": {"type": "no-auth", "config": null}, "headers": "", "params": "", "body": {"type": "none", "data": []}, "timeout": {"max_connect_timeout": 0, "max_read_timeout": 0, "max_write_timeout": 0}, "retry_config": {"retry_enabled": true, "max_retries": 3, "retry_interval": 100}, "selected": false}, "position": {"x": 488, "y": 416.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 488, "y": 416.61904761904765}, "width": 244, "height": 119, "selected": false}, {"id": "1744364922394", "type": "custom", "data": {"type": "end", "title": "\\u7ed3\\u675f 2", "desc": "", "outputs": [{"variable": "body.message", "value_selector": ["1744364785698", "body"]}], "selected": false}, "position": {"x": 792, "y": 416.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 792, "y": 416.61904761904765}, "width": 244, "height": 90, "selected": false}], "edges": [{"id": "1744363492188-source-1744363664951-target", "type": "custom", "source": "1744363492188", "sourceHandle": "source", "target": "1744363664951", "targetHandle": "target", "data": {"sourceType": "start", "targetType": "if-else", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363664951-true-1744363805879-target", "type": "custom", "source": "1744363664951", "sourceHandle": "true", "target": "1744363805879", "targetHandle": "target", "data": {"sourceType": "if-else", "targetType": "http-request", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363805879-source-1744364683467-target", "type": "custom", "source": "1744363805879", "sourceHandle": "source", "target": "1744364683467", "targetHandle": "target", "data": {"sourceType": "http-request", "targetType": "end", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363664951-false-1744364785698-target", "type": "custom", "source": "1744363664951", "sourceHandle": "false", "target": "1744364785698", "targetHandle": "target", "data": {"sourceType": "if-else", "targetType": "http-request", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744364785698-source-1744364922394-target", "type": "custom", "source": "1744364785698", "sourceHandle": "source", "target": "1744364922394", "targetHandle": "target", "data": {"sourceType": "http-request", "targetType": "end", "isInIteration": false, "isInLoop": false}, "zIndex": 0}], "viewport": {"x": -16.760000000000105, "y": -1.2600000000000477, "zoom": 0.8400000000000001}}	{"opening_statement": "", "suggested_questions": [], "suggested_questions_after_answer": {"enabled": false}, "text_to_speech": {"enabled": false, "voice": "", "language": ""}, "speech_to_text": {"enabled": false}, "retriever_resource": {"enabled": true}, "sensitive_word_avoidance": {"enabled": false}, "file_upload": {"image": {"enabled": false, "number_limits": 3, "transfer_methods": ["local_file", "remote_url"]}, "enabled": false, "allowed_file_types": ["image"], "allowed_file_extensions": [".JPG", ".JPEG", ".PNG", ".GIF", ".WEBP", ".SVG"], "allowed_file_upload_methods": ["local_file", "remote_url"], "number_limits": 3, "fileUploadConfig": {"file_size_limit": 15, "batch_count_limit": 5, "image_file_size_limit": 10, "video_file_size_limit": 100, "audio_file_size_limit": 50, "workflow_file_upload_limit": 10}}}	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-11 09:50:42.699454	\N	2025-04-11 09:50:42.699454	{}	{}		
3664f25b-3c34-44b7-ae38-ccf544d67e8a	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	workflow	2025-04-14 08:00:43.264838	{"nodes": [{"id": "1744363492188", "type": "custom", "data": {"type": "start", "title": "\\u5f00\\u59cb", "desc": "", "variables": [{"variable": "date", "label": "\\u65e5\\u671f", "type": "number", "max_length": 48, "required": false, "options": []}], "selected": true}, "position": {"x": 7.857142857142833, "y": 428.33333333333337}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 7.857142857142833, "y": 428.33333333333337}, "width": 244, "height": 90, "selected": true}, {"id": "1744363664951", "type": "custom", "data": {"type": "if-else", "title": "\\u6761\\u4ef6\\u5206\\u652f", "desc": "", "cases": [{"id": "true", "case_id": "true", "logical_operator": "and", "conditions": [{"id": "1fac2023-ad5c-4a25-ac74-5d3164fd8a3c", "varType": "string", "variable_selector": ["1744363492188", "interface_type"], "comparison_operator": "contains", "value": "draft"}]}], "selected": false}, "position": {"x": 305.42857142857144, "y": 383.09523809523813}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 305.42857142857144, "y": 383.09523809523813}, "width": 244, "height": 126, "selected": false}, {"id": "1744363805879", "type": "custom", "data": {"type": "http-request", "title": "HTTP \\u8bf7\\u6c42", "desc": "", "variables": [], "method": "get", "url": "http://localhost:7860/query/type", "authorization": {"type": "no-auth", "config": null}, "headers": "", "params": "type:{{#1744363492188.interface_type#}}", "body": {"type": "none", "data": []}, "timeout": {"max_connect_timeout": 0, "max_read_timeout": 0, "max_write_timeout": 0}, "retry_config": {"retry_enabled": true, "max_retries": 3, "retry_interval": 100}, "selected": false}, "position": {"x": 664.1904761904761, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 664.1904761904761, "y": 242.61904761904765}, "width": 244, "height": 135, "selected": false}, {"id": "1744364683467", "type": "custom", "data": {"type": "end", "title": "\\u7ed3\\u675f", "desc": "", "outputs": [{"variable": "body.message", "value_selector": ["1744363805879", "body"]}], "selected": false}, "position": {"x": 1008.6666666666667, "y": 235.47619047619048}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 1008.6666666666667, "y": 235.47619047619048}, "width": 244, "height": 90, "selected": false}, {"id": "1744364785698", "type": "custom", "data": {"type": "http-request", "title": "HTTP \\u8bf7\\u6c42 2", "desc": "", "variables": [], "method": "get", "url": "http://localhost:7860/", "authorization": {"type": "no-auth", "config": null}, "headers": "", "params": "", "body": {"type": "none", "data": []}, "timeout": {"max_connect_timeout": 0, "max_read_timeout": 0, "max_write_timeout": 0}, "retry_config": {"retry_enabled": true, "max_retries": 3, "retry_interval": 100}, "selected": false}, "position": {"x": 695.142857142857, "y": 428.33333333333337}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 695.142857142857, "y": 428.33333333333337}, "width": 244, "height": 119, "selected": false}, {"id": "1744364922394", "type": "custom", "data": {"type": "end", "title": "\\u7ed3\\u675f 2", "desc": "", "outputs": [{"variable": "body.message", "value_selector": ["1744364785698", "body"]}], "selected": false}, "position": {"x": 1088.4285714285713, "y": 411.8571428571429}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 1088.4285714285713, "y": 411.8571428571429}, "width": 244, "height": 90, "selected": false}], "edges": [{"id": "1744363492188-source-1744363664951-target", "type": "custom", "source": "1744363492188", "sourceHandle": "source", "target": "1744363664951", "targetHandle": "target", "data": {"sourceType": "start", "targetType": "if-else", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363664951-true-1744363805879-target", "type": "custom", "source": "1744363664951", "sourceHandle": "true", "target": "1744363805879", "targetHandle": "target", "data": {"sourceType": "if-else", "targetType": "http-request", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363805879-source-1744364683467-target", "type": "custom", "source": "1744363805879", "sourceHandle": "source", "target": "1744364683467", "targetHandle": "target", "data": {"sourceType": "http-request", "targetType": "end", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363664951-false-1744364785698-target", "type": "custom", "source": "1744363664951", "sourceHandle": "false", "target": "1744364785698", "targetHandle": "target", "data": {"sourceType": "if-else", "targetType": "http-request", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744364785698-source-1744364922394-target", "type": "custom", "source": "1744364785698", "sourceHandle": "source", "target": "1744364922394", "targetHandle": "target", "data": {"sourceType": "http-request", "targetType": "end", "isInIteration": false, "isInLoop": false}, "zIndex": 0}], "viewport": {"x": -3.1600000000001045, "y": -1.2600000000000477, "zoom": 0.8400000000000001}}	{"opening_statement": "", "suggested_questions": [], "suggested_questions_after_answer": {"enabled": false}, "text_to_speech": {"enabled": false, "voice": "", "language": ""}, "speech_to_text": {"enabled": false}, "retriever_resource": {"enabled": true}, "sensitive_word_avoidance": {"enabled": false}, "file_upload": {"image": {"enabled": false, "number_limits": 3, "transfer_methods": ["local_file", "remote_url"]}, "enabled": false, "allowed_file_types": ["image"], "allowed_file_extensions": [".JPG", ".JPEG", ".PNG", ".GIF", ".WEBP", ".SVG"], "allowed_file_upload_methods": ["local_file", "remote_url"], "number_limits": 3, "fileUploadConfig": {"file_size_limit": 15, "batch_count_limit": 5, "image_file_size_limit": 10, "video_file_size_limit": 100, "audio_file_size_limit": 50, "workflow_file_upload_limit": 10}}}	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-14 08:00:43.26502	\N	2025-04-14 08:00:43.26502	{}	{}		
493c773d-d312-4efd-9193-edf1bb4fdc3a	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	workflow	2025-04-14 08:01:17.436007	{"nodes": [{"id": "1744363492188", "type": "custom", "data": {"type": "start", "title": "\\u5f00\\u59cb", "desc": "", "variables": [], "selected": true}, "position": {"x": 7.857142857142833, "y": 428.33333333333337}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 7.857142857142833, "y": 428.33333333333337}, "width": 244, "height": 54, "selected": true}, {"id": "1744363664951", "type": "custom", "data": {"type": "if-else", "title": "\\u6761\\u4ef6\\u5206\\u652f", "desc": "", "cases": [{"id": "true", "case_id": "true", "logical_operator": "and", "conditions": [{"id": "1fac2023-ad5c-4a25-ac74-5d3164fd8a3c", "varType": "string", "variable_selector": ["1744363492188", "interface_type"], "comparison_operator": "contains", "value": "draft"}]}], "selected": false}, "position": {"x": 305.42857142857144, "y": 383.09523809523813}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 305.42857142857144, "y": 383.09523809523813}, "width": 244, "height": 126, "selected": false}, {"id": "1744363805879", "type": "custom", "data": {"type": "http-request", "title": "HTTP \\u8bf7\\u6c42", "desc": "", "variables": [], "method": "get", "url": "http://localhost:7860/query/type", "authorization": {"type": "no-auth", "config": null}, "headers": "", "params": "type:{{#1744363492188.interface_type#}}", "body": {"type": "none", "data": []}, "timeout": {"max_connect_timeout": 0, "max_read_timeout": 0, "max_write_timeout": 0}, "retry_config": {"retry_enabled": true, "max_retries": 3, "retry_interval": 100}, "selected": false}, "position": {"x": 664.1904761904761, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 664.1904761904761, "y": 242.61904761904765}, "width": 244, "height": 135, "selected": false}, {"id": "1744364683467", "type": "custom", "data": {"type": "end", "title": "\\u7ed3\\u675f", "desc": "", "outputs": [{"variable": "body.message", "value_selector": ["1744363805879", "body"]}], "selected": false}, "position": {"x": 1008.6666666666667, "y": 235.47619047619048}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 1008.6666666666667, "y": 235.47619047619048}, "width": 244, "height": 90, "selected": false}, {"id": "1744364785698", "type": "custom", "data": {"type": "http-request", "title": "HTTP \\u8bf7\\u6c42 2", "desc": "", "variables": [], "method": "get", "url": "http://localhost:7860/", "authorization": {"type": "no-auth", "config": null}, "headers": "", "params": "", "body": {"type": "none", "data": []}, "timeout": {"max_connect_timeout": 0, "max_read_timeout": 0, "max_write_timeout": 0}, "retry_config": {"retry_enabled": true, "max_retries": 3, "retry_interval": 100}, "selected": false}, "position": {"x": 695.142857142857, "y": 428.33333333333337}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 695.142857142857, "y": 428.33333333333337}, "width": 244, "height": 119, "selected": false}, {"id": "1744364922394", "type": "custom", "data": {"type": "end", "title": "\\u7ed3\\u675f 2", "desc": "", "outputs": [{"variable": "body.message", "value_selector": ["1744364785698", "body"]}], "selected": false}, "position": {"x": 1088.4285714285713, "y": 411.8571428571429}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 1088.4285714285713, "y": 411.8571428571429}, "width": 244, "height": 90, "selected": false}], "edges": [{"id": "1744363492188-source-1744363664951-target", "type": "custom", "source": "1744363492188", "sourceHandle": "source", "target": "1744363664951", "targetHandle": "target", "data": {"sourceType": "start", "targetType": "if-else", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363664951-true-1744363805879-target", "type": "custom", "source": "1744363664951", "sourceHandle": "true", "target": "1744363805879", "targetHandle": "target", "data": {"sourceType": "if-else", "targetType": "http-request", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363805879-source-1744364683467-target", "type": "custom", "source": "1744363805879", "sourceHandle": "source", "target": "1744364683467", "targetHandle": "target", "data": {"sourceType": "http-request", "targetType": "end", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363664951-false-1744364785698-target", "type": "custom", "source": "1744363664951", "sourceHandle": "false", "target": "1744364785698", "targetHandle": "target", "data": {"sourceType": "if-else", "targetType": "http-request", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744364785698-source-1744364922394-target", "type": "custom", "source": "1744364785698", "sourceHandle": "source", "target": "1744364922394", "targetHandle": "target", "data": {"sourceType": "http-request", "targetType": "end", "isInIteration": false, "isInLoop": false}, "zIndex": 0}], "viewport": {"x": -3.1600000000001045, "y": -1.2600000000000477, "zoom": 0.8400000000000001}}	{"opening_statement": "", "suggested_questions": [], "suggested_questions_after_answer": {"enabled": false}, "text_to_speech": {"enabled": false, "voice": "", "language": ""}, "speech_to_text": {"enabled": false}, "retriever_resource": {"enabled": true}, "sensitive_word_avoidance": {"enabled": false}, "file_upload": {"image": {"enabled": false, "number_limits": 3, "transfer_methods": ["local_file", "remote_url"]}, "enabled": false, "allowed_file_types": ["image"], "allowed_file_extensions": [".JPG", ".JPEG", ".PNG", ".GIF", ".WEBP", ".SVG"], "allowed_file_upload_methods": ["local_file", "remote_url"], "number_limits": 3, "fileUploadConfig": {"file_size_limit": 15, "batch_count_limit": 5, "image_file_size_limit": 10, "video_file_size_limit": 100, "audio_file_size_limit": 50, "workflow_file_upload_limit": 10}}}	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-14 08:01:17.436288	\N	2025-04-14 08:01:17.436288	{}	{}		
54d1bbfc-6bb3-4439-962e-c19dee46a769	358a104c-8954-4063-beb6-e7bb3ae5de0f	c84265cd-993f-4287-acc4-d82660a43e42	workflow	draft	{"nodes": [{"id": "1744363492188", "type": "custom", "data": {"type": "start", "title": "\\u5f00\\u59cb", "desc": "", "variables": [{"variable": "interface_type", "label": "interface_type", "type": "text-input", "max_length": 48, "required": true, "options": []}], "selected": false}, "position": {"x": -67.46044449089487, "y": 404.52380952380946}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": -67.46044449089487, "y": 404.52380952380946}, "width": 244, "height": 90, "selected": false}, {"id": "1744363664951", "type": "custom", "data": {"type": "if-else", "title": "\\u6761\\u4ef6\\u5206\\u652f", "desc": "", "cases": [{"id": "true", "case_id": "true", "logical_operator": "and", "conditions": [{"id": "65cf6a4e-b0b3-4b84-b9d3-c454c90abc33", "varType": "string", "variable_selector": ["1744363492188", "interface_type"], "comparison_operator": "contains", "value": "draft"}]}], "selected": false}, "position": {"x": 261.3809523809522, "y": 387.8571428571429}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 261.3809523809522, "y": 387.8571428571429}, "width": 244, "height": 126, "selected": false}, {"id": "1744363805879", "type": "custom", "data": {"type": "http-request", "title": "HTTP \\u8bf7\\u6c42", "desc": "", "variables": [], "method": "get", "url": "http://localhost:7860/query/type", "authorization": {"type": "no-auth", "config": null}, "headers": "", "params": "type:{{#1744363492188.interface_type#}}", "body": {"type": "none", "data": []}, "timeout": {"max_connect_timeout": 0, "max_read_timeout": 0, "max_write_timeout": 0}, "retry_config": {"retry_enabled": true, "max_retries": 3, "retry_interval": 100}, "selected": false}, "position": {"x": 664.1904761904761, "y": 242.61904761904765}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 664.1904761904761, "y": 242.61904761904765}, "width": 244, "height": 110, "selected": false}, {"id": "1744364683467", "type": "custom", "data": {"type": "end", "title": "\\u7ed3\\u675f", "desc": "", "outputs": [{"variable": "body.message", "value_selector": ["1744363805879", "body"]}], "selected": false}, "position": {"x": 1008.6666666666667, "y": 235.47619047619048}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 1008.6666666666667, "y": 235.47619047619048}, "width": 244, "height": 90, "selected": false}, {"id": "1744364785698", "type": "custom", "data": {"type": "http-request", "title": "HTTP \\u8bf7\\u6c42 2", "desc": "", "variables": [], "method": "get", "url": "http://localhost:7860/", "authorization": {"type": "no-auth", "config": null}, "headers": "", "params": "", "body": {"type": "none", "data": []}, "timeout": {"max_connect_timeout": 0, "max_read_timeout": 0, "max_write_timeout": 0}, "retry_config": {"retry_enabled": true, "max_retries": 3, "retry_interval": 100}, "selected": false}, "position": {"x": 695.142857142857, "y": 428.33333333333337}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 695.142857142857, "y": 428.33333333333337}, "width": 244, "height": 119, "selected": false}, {"id": "1744364922394", "type": "custom", "data": {"type": "end", "title": "\\u7ed3\\u675f 2", "desc": "", "outputs": [{"variable": "body.message", "value_selector": ["1744364785698", "body"]}], "selected": false}, "position": {"x": 1088.4285714285713, "y": 411.8571428571429}, "targetPosition": "left", "sourcePosition": "right", "positionAbsolute": {"x": 1088.4285714285713, "y": 411.8571428571429}, "width": 244, "height": 90, "selected": true}], "edges": [{"id": "1744363492188-source-1744363664951-target", "type": "custom", "source": "1744363492188", "sourceHandle": "source", "target": "1744363664951", "targetHandle": "target", "data": {"sourceType": "start", "targetType": "if-else", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363664951-true-1744363805879-target", "type": "custom", "source": "1744363664951", "sourceHandle": "true", "target": "1744363805879", "targetHandle": "target", "data": {"sourceType": "if-else", "targetType": "http-request", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363805879-source-1744364683467-target", "type": "custom", "source": "1744363805879", "sourceHandle": "source", "target": "1744364683467", "targetHandle": "target", "data": {"sourceType": "http-request", "targetType": "end", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744363664951-false-1744364785698-target", "type": "custom", "source": "1744363664951", "sourceHandle": "false", "target": "1744364785698", "targetHandle": "target", "data": {"sourceType": "if-else", "targetType": "http-request", "isInIteration": false, "isInLoop": false}, "zIndex": 0}, {"id": "1744364785698-source-1744364922394-target", "type": "custom", "source": "1744364785698", "sourceHandle": "source", "target": "1744364922394", "targetHandle": "target", "data": {"sourceType": "http-request", "targetType": "end", "isInIteration": false, "isInLoop": false}, "zIndex": 0}], "viewport": {"x": 53.28711909717322, "y": 451.10175755906124, "zoom": 0.6414029017418869}}	{"opening_statement": "", "suggested_questions": [], "suggested_questions_after_answer": {"enabled": false}, "text_to_speech": {"enabled": false, "voice": "", "language": ""}, "speech_to_text": {"enabled": false}, "retriever_resource": {"enabled": true}, "sensitive_word_avoidance": {"enabled": false}, "file_upload": {"image": {"enabled": false, "number_limits": 3, "transfer_methods": ["local_file", "remote_url"]}, "enabled": false, "allowed_file_types": ["image"], "allowed_file_extensions": [".JPG", ".JPEG", ".PNG", ".GIF", ".WEBP", ".SVG"], "allowed_file_upload_methods": ["local_file", "remote_url"], "number_limits": 3, "fileUploadConfig": {"file_size_limit": 15, "batch_count_limit": 5, "image_file_size_limit": 10, "video_file_size_limit": 100, "audio_file_size_limit": 50, "workflow_file_upload_limit": 10}}}	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-11 09:24:52	cc67c45e-e65e-4177-94d6-1af3d06342f5	2025-04-14 09:48:31.186832	{}	{}		
\.


--
-- TOC entry 4590 (class 0 OID 0)
-- Dependencies: 241
-- Name: invitation_codes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.invitation_codes_id_seq', 1, false);


--
-- TOC entry 4591 (class 0 OID 0)
-- Dependencies: 226
-- Name: task_id_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.task_id_sequence', 1, false);


--
-- TOC entry 4592 (class 0 OID 0)
-- Dependencies: 227
-- Name: taskset_id_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.taskset_id_sequence', 1, false);


--
-- TOC entry 4052 (class 2606 OID 16424)
-- Name: account_integrates account_integrate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_integrates
    ADD CONSTRAINT account_integrate_pkey PRIMARY KEY (id);


--
-- TOC entry 4059 (class 2606 OID 16439)
-- Name: accounts account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- TOC entry 4340 (class 2606 OID 17407)
-- Name: account_plugin_permissions account_plugin_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_plugin_permissions
    ADD CONSTRAINT account_plugin_permission_pkey PRIMARY KEY (id);


--
-- TOC entry 4050 (class 2606 OID 16403)
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- TOC entry 4221 (class 2606 OID 16973)
-- Name: api_based_extensions api_based_extension_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_based_extensions
    ADD CONSTRAINT api_based_extension_pkey PRIMARY KEY (id);


--
-- TOC entry 4061 (class 2606 OID 16449)
-- Name: api_requests api_request_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_requests
    ADD CONSTRAINT api_request_pkey PRIMARY KEY (id);


--
-- TOC entry 4065 (class 2606 OID 16457)
-- Name: api_tokens api_token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.api_tokens
    ADD CONSTRAINT api_token_pkey PRIMARY KEY (id);


--
-- TOC entry 4232 (class 2606 OID 16996)
-- Name: app_annotation_hit_histories app_annotation_hit_histories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_annotation_hit_histories
    ADD CONSTRAINT app_annotation_hit_histories_pkey PRIMARY KEY (id);


--
-- TOC entry 4235 (class 2606 OID 17012)
-- Name: app_annotation_settings app_annotation_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_annotation_settings
    ADD CONSTRAINT app_annotation_settings_pkey PRIMARY KEY (id);


--
-- TOC entry 4070 (class 2606 OID 16466)
-- Name: app_dataset_joins app_dataset_join_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_dataset_joins
    ADD CONSTRAINT app_dataset_join_pkey PRIMARY KEY (id);


--
-- TOC entry 4073 (class 2606 OID 16477)
-- Name: app_model_configs app_model_config_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_model_configs
    ADD CONSTRAINT app_model_config_pkey PRIMARY KEY (id);


--
-- TOC entry 4075 (class 2606 OID 16491)
-- Name: apps app_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.apps
    ADD CONSTRAINT app_pkey PRIMARY KEY (id);


--
-- TOC entry 4078 (class 2606 OID 16502)
-- Name: celery_taskmeta celery_taskmeta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.celery_taskmeta
    ADD CONSTRAINT celery_taskmeta_pkey PRIMARY KEY (id);


--
-- TOC entry 4080 (class 2606 OID 16504)
-- Name: celery_taskmeta celery_taskmeta_task_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.celery_taskmeta
    ADD CONSTRAINT celery_taskmeta_task_id_key UNIQUE (task_id);


--
-- TOC entry 4082 (class 2606 OID 16512)
-- Name: celery_tasksetmeta celery_tasksetmeta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.celery_tasksetmeta
    ADD CONSTRAINT celery_tasksetmeta_pkey PRIMARY KEY (id);


--
-- TOC entry 4084 (class 2606 OID 16514)
-- Name: celery_tasksetmeta celery_tasksetmeta_taskset_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.celery_tasksetmeta
    ADD CONSTRAINT celery_tasksetmeta_taskset_id_key UNIQUE (taskset_id);


--
-- TOC entry 4333 (class 2606 OID 17376)
-- Name: child_chunks child_chunk_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.child_chunks
    ADD CONSTRAINT child_chunk_pkey PRIMARY KEY (id);


--
-- TOC entry 4087 (class 2606 OID 16525)
-- Name: conversations conversation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversation_pkey PRIMARY KEY (id);


--
-- TOC entry 4297 (class 2606 OID 17247)
-- Name: data_source_api_key_auth_bindings data_source_api_key_auth_binding_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_source_api_key_auth_bindings
    ADD CONSTRAINT data_source_api_key_auth_binding_pkey PRIMARY KEY (id);


--
-- TOC entry 4337 (class 2606 OID 17385)
-- Name: dataset_auto_disable_logs dataset_auto_disable_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dataset_auto_disable_logs
    ADD CONSTRAINT dataset_auto_disable_log_pkey PRIMARY KEY (id);


--
-- TOC entry 4218 (class 2606 OID 16961)
-- Name: dataset_collection_bindings dataset_collection_bindings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dataset_collection_bindings
    ADD CONSTRAINT dataset_collection_bindings_pkey PRIMARY KEY (id);


--
-- TOC entry 4090 (class 2606 OID 16534)
-- Name: dataset_keyword_tables dataset_keyword_table_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dataset_keyword_tables
    ADD CONSTRAINT dataset_keyword_table_pkey PRIMARY KEY (id);


--
-- TOC entry 4092 (class 2606 OID 16536)
-- Name: dataset_keyword_tables dataset_keyword_tables_dataset_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dataset_keyword_tables
    ADD CONSTRAINT dataset_keyword_tables_dataset_id_key UNIQUE (dataset_id);


--
-- TOC entry 4351 (class 2606 OID 17436)
-- Name: dataset_metadata_bindings dataset_metadata_binding_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dataset_metadata_bindings
    ADD CONSTRAINT dataset_metadata_binding_pkey PRIMARY KEY (id);


--
-- TOC entry 4355 (class 2606 OID 17450)
-- Name: dataset_metadatas dataset_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dataset_metadatas
    ADD CONSTRAINT dataset_metadata_pkey PRIMARY KEY (id);


--
-- TOC entry 4304 (class 2606 OID 17284)
-- Name: dataset_permissions dataset_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dataset_permissions
    ADD CONSTRAINT dataset_permission_pkey PRIMARY KEY (id);


--
-- TOC entry 4100 (class 2606 OID 16570)
-- Name: datasets dataset_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.datasets
    ADD CONSTRAINT dataset_pkey PRIMARY KEY (id);


--
-- TOC entry 4095 (class 2606 OID 16547)
-- Name: dataset_process_rules dataset_process_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dataset_process_rules
    ADD CONSTRAINT dataset_process_rule_pkey PRIMARY KEY (id);


--
-- TOC entry 4098 (class 2606 OID 16557)
-- Name: dataset_queries dataset_query_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dataset_queries
    ADD CONSTRAINT dataset_query_pkey PRIMARY KEY (id);


--
-- TOC entry 4216 (class 2606 OID 16953)
-- Name: dataset_retriever_resources dataset_retriever_resource_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dataset_retriever_resources
    ADD CONSTRAINT dataset_retriever_resource_pkey PRIMARY KEY (id);


--
-- TOC entry 4104 (class 2606 OID 16577)
-- Name: dify_setups dify_setup_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dify_setups
    ADD CONSTRAINT dify_setup_pkey PRIMARY KEY (version);


--
-- TOC entry 4117 (class 2606 OID 16607)
-- Name: documents document_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT document_pkey PRIMARY KEY (id);


--
-- TOC entry 4109 (class 2606 OID 16588)
-- Name: document_segments document_segment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_segments
    ADD CONSTRAINT document_segment_pkey PRIMARY KEY (id);


--
-- TOC entry 4121 (class 2606 OID 17296)
-- Name: embeddings embedding_hash_idx; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.embeddings
    ADD CONSTRAINT embedding_hash_idx UNIQUE (model_name, hash, provider_name);


--
-- TOC entry 4123 (class 2606 OID 16618)
-- Name: embeddings embedding_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.embeddings
    ADD CONSTRAINT embedding_pkey PRIMARY KEY (id);


--
-- TOC entry 4125 (class 2606 OID 16631)
-- Name: end_users end_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.end_users
    ADD CONSTRAINT end_user_pkey PRIMARY KEY (id);


--
-- TOC entry 4314 (class 2606 OID 17322)
-- Name: external_knowledge_apis external_knowledge_apis_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.external_knowledge_apis
    ADD CONSTRAINT external_knowledge_apis_pkey PRIMARY KEY (id);


--
-- TOC entry 4320 (class 2606 OID 17334)
-- Name: external_knowledge_bindings external_knowledge_bindings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.external_knowledge_bindings
    ADD CONSTRAINT external_knowledge_bindings_pkey PRIMARY KEY (id);


--
-- TOC entry 4130 (class 2606 OID 16641)
-- Name: installed_apps installed_app_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.installed_apps
    ADD CONSTRAINT installed_app_pkey PRIMARY KEY (id);


--
-- TOC entry 4135 (class 2606 OID 16654)
-- Name: invitation_codes invitation_code_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invitation_codes
    ADD CONSTRAINT invitation_code_pkey PRIMARY KEY (id);


--
-- TOC entry 4291 (class 2606 OID 17211)
-- Name: load_balancing_model_configs load_balancing_model_config_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.load_balancing_model_configs
    ADD CONSTRAINT load_balancing_model_config_pkey PRIMARY KEY (id);


--
-- TOC entry 4141 (class 2606 OID 16665)
-- Name: message_agent_thoughts message_agent_thought_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message_agent_thoughts
    ADD CONSTRAINT message_agent_thought_pkey PRIMARY KEY (id);


--
-- TOC entry 4187 (class 2606 OID 16816)
-- Name: message_annotations message_annotation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message_annotations
    ADD CONSTRAINT message_annotation_pkey PRIMARY KEY (id);


--
-- TOC entry 4144 (class 2606 OID 16676)
-- Name: message_chains message_chain_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message_chains
    ADD CONSTRAINT message_chain_pkey PRIMARY KEY (id);


--
-- TOC entry 4149 (class 2606 OID 16687)
-- Name: message_feedbacks message_feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message_feedbacks
    ADD CONSTRAINT message_feedback_pkey PRIMARY KEY (id);


--
-- TOC entry 4226 (class 2606 OID 16983)
-- Name: message_files message_file_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.message_files
    ADD CONSTRAINT message_file_pkey PRIMARY KEY (id);


--
-- TOC entry 4194 (class 2606 OID 16833)
-- Name: messages message_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT message_pkey PRIMARY KEY (id);


--
-- TOC entry 4152 (class 2606 OID 16700)
-- Name: operation_logs operation_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operation_logs
    ADD CONSTRAINT operation_log_pkey PRIMARY KEY (id);


--
-- TOC entry 4155 (class 2606 OID 16708)
-- Name: pinned_conversations pinned_conversation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pinned_conversations
    ADD CONSTRAINT pinned_conversation_pkey PRIMARY KEY (id);


--
-- TOC entry 4201 (class 2606 OID 16885)
-- Name: provider_models provider_model_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provider_models
    ADD CONSTRAINT provider_model_pkey PRIMARY KEY (id);


--
-- TOC entry 4294 (class 2606 OID 17224)
-- Name: provider_model_settings provider_model_setting_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provider_model_settings
    ADD CONSTRAINT provider_model_setting_pkey PRIMARY KEY (id);


--
-- TOC entry 4212 (class 2606 OID 16934)
-- Name: provider_orders provider_order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provider_orders
    ADD CONSTRAINT provider_order_pkey PRIMARY KEY (id);


--
-- TOC entry 4157 (class 2606 OID 16722)
-- Name: providers provider_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.providers
    ADD CONSTRAINT provider_pkey PRIMARY KEY (id);


--
-- TOC entry 4245 (class 2606 OID 17045)
-- Name: tool_published_apps published_app_tool_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_published_apps
    ADD CONSTRAINT published_app_tool_pkey PRIMARY KEY (id);


--
-- TOC entry 4345 (class 2606 OID 17427)
-- Name: rate_limit_logs rate_limit_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rate_limit_logs
    ADD CONSTRAINT rate_limit_log_pkey PRIMARY KEY (id);


--
-- TOC entry 4164 (class 2606 OID 16735)
-- Name: recommended_apps recommended_app_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recommended_apps
    ADD CONSTRAINT recommended_app_pkey PRIMARY KEY (id);


--
-- TOC entry 4167 (class 2606 OID 16744)
-- Name: saved_messages saved_message_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved_messages
    ADD CONSTRAINT saved_message_pkey PRIMARY KEY (id);


--
-- TOC entry 4171 (class 2606 OID 16768)
-- Name: sites site_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sites
    ADD CONSTRAINT site_pkey PRIMARY KEY (id);


--
-- TOC entry 4197 (class 2606 OID 16855)
-- Name: data_source_oauth_bindings source_binding_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_source_oauth_bindings
    ADD CONSTRAINT source_binding_pkey PRIMARY KEY (id);


--
-- TOC entry 4275 (class 2606 OID 17162)
-- Name: tag_bindings tag_binding_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tag_bindings
    ADD CONSTRAINT tag_binding_pkey PRIMARY KEY (id);


--
-- TOC entry 4278 (class 2606 OID 17171)
-- Name: tags tag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- TOC entry 4174 (class 2606 OID 16779)
-- Name: tenant_account_joins tenant_account_join_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tenant_account_joins
    ADD CONSTRAINT tenant_account_join_pkey PRIMARY KEY (id);


--
-- TOC entry 4206 (class 2606 OID 16896)
-- Name: tenant_default_models tenant_default_model_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tenant_default_models
    ADD CONSTRAINT tenant_default_model_pkey PRIMARY KEY (id);


--
-- TOC entry 4179 (class 2606 OID 16795)
-- Name: tenants tenant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tenants
    ADD CONSTRAINT tenant_pkey PRIMARY KEY (id);


--
-- TOC entry 4209 (class 2606 OID 16905)
-- Name: tenant_preferred_model_providers tenant_preferred_model_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tenant_preferred_model_providers
    ADD CONSTRAINT tenant_preferred_model_provider_pkey PRIMARY KEY (id);


--
-- TOC entry 4325 (class 2606 OID 17349)
-- Name: tidb_auth_bindings tidb_auth_bindings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tidb_auth_bindings
    ADD CONSTRAINT tidb_auth_bindings_pkey PRIMARY KEY (id);


--
-- TOC entry 4237 (class 2606 OID 17023)
-- Name: tool_api_providers tool_api_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_api_providers
    ADD CONSTRAINT tool_api_provider_pkey PRIMARY KEY (id);


--
-- TOC entry 4241 (class 2606 OID 17033)
-- Name: tool_builtin_providers tool_builtin_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_builtin_providers
    ADD CONSTRAINT tool_builtin_provider_pkey PRIMARY KEY (id);


--
-- TOC entry 4252 (class 2606 OID 17078)
-- Name: tool_conversation_variables tool_conversation_variables_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_conversation_variables
    ADD CONSTRAINT tool_conversation_variables_pkey PRIMARY KEY (id);


--
-- TOC entry 4256 (class 2606 OID 17092)
-- Name: tool_files tool_file_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_files
    ADD CONSTRAINT tool_file_pkey PRIMARY KEY (id);


--
-- TOC entry 4287 (class 2606 OID 17194)
-- Name: tool_label_bindings tool_label_bind_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_label_bindings
    ADD CONSTRAINT tool_label_bind_pkey PRIMARY KEY (id);


--
-- TOC entry 4249 (class 2606 OID 17068)
-- Name: tool_model_invokes tool_model_invoke_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_model_invokes
    ADD CONSTRAINT tool_model_invoke_pkey PRIMARY KEY (id);


--
-- TOC entry 4281 (class 2606 OID 17184)
-- Name: tool_workflow_providers tool_workflow_provider_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_workflow_providers
    ADD CONSTRAINT tool_workflow_provider_pkey PRIMARY KEY (id);


--
-- TOC entry 4302 (class 2606 OID 17274)
-- Name: trace_app_config trace_app_config_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.trace_app_config
    ADD CONSTRAINT trace_app_config_pkey PRIMARY KEY (id);


--
-- TOC entry 4054 (class 2606 OID 16426)
-- Name: account_integrates unique_account_provider; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_integrates
    ADD CONSTRAINT unique_account_provider UNIQUE (account_id, provider);


--
-- TOC entry 4239 (class 2606 OID 17414)
-- Name: tool_api_providers unique_api_tool_provider; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_api_providers
    ADD CONSTRAINT unique_api_tool_provider UNIQUE (name, tenant_id);


--
-- TOC entry 4243 (class 2606 OID 17399)
-- Name: tool_builtin_providers unique_builtin_tool_provider; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_builtin_providers
    ADD CONSTRAINT unique_builtin_tool_provider UNIQUE (tenant_id, provider);


--
-- TOC entry 4204 (class 2606 OID 17227)
-- Name: provider_models unique_provider_model_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provider_models
    ADD CONSTRAINT unique_provider_model_name UNIQUE (tenant_id, provider_name, model_name, model_type);


--
-- TOC entry 4160 (class 2606 OID 17231)
-- Name: providers unique_provider_name_type_quota; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.providers
    ADD CONSTRAINT unique_provider_name_type_quota UNIQUE (tenant_id, provider_name, provider_type, quota_type);


--
-- TOC entry 4056 (class 2606 OID 16428)
-- Name: account_integrates unique_provider_open_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_integrates
    ADD CONSTRAINT unique_provider_open_id UNIQUE (provider, open_id);


--
-- TOC entry 4247 (class 2606 OID 17047)
-- Name: tool_published_apps unique_published_app_tool; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_published_apps
    ADD CONSTRAINT unique_published_app_tool UNIQUE (app_id, user_id);


--
-- TOC entry 4177 (class 2606 OID 16781)
-- Name: tenant_account_joins unique_tenant_account_join; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tenant_account_joins
    ADD CONSTRAINT unique_tenant_account_join UNIQUE (tenant_id, account_id);


--
-- TOC entry 4133 (class 2606 OID 16643)
-- Name: installed_apps unique_tenant_app; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.installed_apps
    ADD CONSTRAINT unique_tenant_app UNIQUE (tenant_id, app_id);


--
-- TOC entry 4342 (class 2606 OID 17409)
-- Name: account_plugin_permissions unique_tenant_plugin; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_plugin_permissions
    ADD CONSTRAINT unique_tenant_plugin UNIQUE (tenant_id);


--
-- TOC entry 4289 (class 2606 OID 17198)
-- Name: tool_label_bindings unique_tool_label_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_label_bindings
    ADD CONSTRAINT unique_tool_label_bind UNIQUE (tool_id, label_name);


--
-- TOC entry 4283 (class 2606 OID 17416)
-- Name: tool_workflow_providers unique_workflow_tool_provider; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_workflow_providers
    ADD CONSTRAINT unique_workflow_tool_provider UNIQUE (name, tenant_id);


--
-- TOC entry 4285 (class 2606 OID 17188)
-- Name: tool_workflow_providers unique_workflow_tool_provider_app_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_workflow_providers
    ADD CONSTRAINT unique_workflow_tool_provider_app_id UNIQUE (tenant_id, app_id);


--
-- TOC entry 4181 (class 2606 OID 16805)
-- Name: upload_files upload_file_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.upload_files
    ADD CONSTRAINT upload_file_pkey PRIMARY KEY (id);


--
-- TOC entry 4329 (class 2606 OID 17360)
-- Name: whitelists whitelists_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.whitelists
    ADD CONSTRAINT whitelists_pkey PRIMARY KEY (id);


--
-- TOC entry 4309 (class 2606 OID 17305)
-- Name: workflow_conversation_variables workflow__conversation_variables_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workflow_conversation_variables
    ADD CONSTRAINT workflow__conversation_variables_pkey PRIMARY KEY (id, conversation_id);


--
-- TOC entry 4259 (class 2606 OID 17114)
-- Name: workflow_app_logs workflow_app_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workflow_app_logs
    ADD CONSTRAINT workflow_app_log_pkey PRIMARY KEY (id);


--
-- TOC entry 4263 (class 2606 OID 17125)
-- Name: workflow_node_executions workflow_node_execution_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workflow_node_executions
    ADD CONSTRAINT workflow_node_execution_pkey PRIMARY KEY (id);


--
-- TOC entry 4270 (class 2606 OID 17149)
-- Name: workflows workflow_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workflows
    ADD CONSTRAINT workflow_pkey PRIMARY KEY (id);


--
-- TOC entry 4266 (class 2606 OID 17139)
-- Name: workflow_runs workflow_run_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.workflow_runs
    ADD CONSTRAINT workflow_run_pkey PRIMARY KEY (id);


--
-- TOC entry 4057 (class 1259 OID 16440)
-- Name: account_email_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_email_idx ON public.accounts USING btree (email);


--
-- TOC entry 4222 (class 1259 OID 16974)
-- Name: api_based_extension_tenant_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_based_extension_tenant_idx ON public.api_based_extensions USING btree (tenant_id);


--
-- TOC entry 4062 (class 1259 OID 16450)
-- Name: api_request_token_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_request_token_idx ON public.api_requests USING btree (tenant_id, api_token_id);


--
-- TOC entry 4063 (class 1259 OID 16458)
-- Name: api_token_app_id_type_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_token_app_id_type_idx ON public.api_tokens USING btree (app_id, type);


--
-- TOC entry 4066 (class 1259 OID 16963)
-- Name: api_token_tenant_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_token_tenant_idx ON public.api_tokens USING btree (tenant_id, type);


--
-- TOC entry 4067 (class 1259 OID 16459)
-- Name: api_token_token_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX api_token_token_idx ON public.api_tokens USING btree (token, type);


--
-- TOC entry 4227 (class 1259 OID 16997)
-- Name: app_annotation_hit_histories_account_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX app_annotation_hit_histories_account_idx ON public.app_annotation_hit_histories USING btree (account_id);


--
-- TOC entry 4228 (class 1259 OID 16998)
-- Name: app_annotation_hit_histories_annotation_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX app_annotation_hit_histories_annotation_idx ON public.app_annotation_hit_histories USING btree (annotation_id);


--
-- TOC entry 4229 (class 1259 OID 16999)
-- Name: app_annotation_hit_histories_app_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX app_annotation_hit_histories_app_idx ON public.app_annotation_hit_histories USING btree (app_id);


--
-- TOC entry 4230 (class 1259 OID 17003)
-- Name: app_annotation_hit_histories_message_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX app_annotation_hit_histories_message_idx ON public.app_annotation_hit_histories USING btree (message_id);


--
-- TOC entry 4233 (class 1259 OID 17013)
-- Name: app_annotation_settings_app_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX app_annotation_settings_app_idx ON public.app_annotation_settings USING btree (app_id);


--
-- TOC entry 4071 (class 1259 OID 16478)
-- Name: app_app_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX app_app_id_idx ON public.app_model_configs USING btree (app_id);


--
-- TOC entry 4068 (class 1259 OID 16467)
-- Name: app_dataset_join_app_dataset_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX app_dataset_join_app_dataset_idx ON public.app_dataset_joins USING btree (dataset_id, app_id);


--
-- TOC entry 4076 (class 1259 OID 16492)
-- Name: app_tenant_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX app_tenant_id_idx ON public.apps USING btree (tenant_id);


--
-- TOC entry 4331 (class 1259 OID 17377)
-- Name: child_chunk_dataset_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX child_chunk_dataset_id_idx ON public.child_chunks USING btree (tenant_id, dataset_id, document_id, segment_id, index_node_id);


--
-- TOC entry 4085 (class 1259 OID 16526)
-- Name: conversation_app_from_user_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX conversation_app_from_user_idx ON public.conversations USING btree (app_id, from_source, from_end_user_id);


--
-- TOC entry 4250 (class 1259 OID 17093)
-- Name: conversation_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX conversation_id_idx ON public.tool_conversation_variables USING btree (conversation_id);


--
-- TOC entry 4119 (class 1259 OID 17288)
-- Name: created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX created_at_idx ON public.embeddings USING btree (created_at);


--
-- TOC entry 4298 (class 1259 OID 17248)
-- Name: data_source_api_key_auth_binding_provider_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX data_source_api_key_auth_binding_provider_idx ON public.data_source_api_key_auth_bindings USING btree (provider);


--
-- TOC entry 4299 (class 1259 OID 17249)
-- Name: data_source_api_key_auth_binding_tenant_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX data_source_api_key_auth_binding_tenant_id_idx ON public.data_source_api_key_auth_bindings USING btree (tenant_id);


--
-- TOC entry 4334 (class 1259 OID 17386)
-- Name: dataset_auto_disable_log_created_atx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_auto_disable_log_created_atx ON public.dataset_auto_disable_logs USING btree (created_at);


--
-- TOC entry 4335 (class 1259 OID 17387)
-- Name: dataset_auto_disable_log_dataset_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_auto_disable_log_dataset_idx ON public.dataset_auto_disable_logs USING btree (dataset_id);


--
-- TOC entry 4338 (class 1259 OID 17388)
-- Name: dataset_auto_disable_log_tenant_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_auto_disable_log_tenant_idx ON public.dataset_auto_disable_logs USING btree (tenant_id);


--
-- TOC entry 4088 (class 1259 OID 16537)
-- Name: dataset_keyword_table_dataset_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_keyword_table_dataset_id_idx ON public.dataset_keyword_tables USING btree (dataset_id);


--
-- TOC entry 4347 (class 1259 OID 17437)
-- Name: dataset_metadata_binding_dataset_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_metadata_binding_dataset_idx ON public.dataset_metadata_bindings USING btree (dataset_id);


--
-- TOC entry 4348 (class 1259 OID 17438)
-- Name: dataset_metadata_binding_document_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_metadata_binding_document_idx ON public.dataset_metadata_bindings USING btree (document_id);


--
-- TOC entry 4349 (class 1259 OID 17439)
-- Name: dataset_metadata_binding_metadata_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_metadata_binding_metadata_idx ON public.dataset_metadata_bindings USING btree (metadata_id);


--
-- TOC entry 4352 (class 1259 OID 17440)
-- Name: dataset_metadata_binding_tenant_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_metadata_binding_tenant_idx ON public.dataset_metadata_bindings USING btree (tenant_id);


--
-- TOC entry 4353 (class 1259 OID 17451)
-- Name: dataset_metadata_dataset_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_metadata_dataset_idx ON public.dataset_metadatas USING btree (dataset_id);


--
-- TOC entry 4356 (class 1259 OID 17452)
-- Name: dataset_metadata_tenant_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_metadata_tenant_idx ON public.dataset_metadatas USING btree (tenant_id);


--
-- TOC entry 4093 (class 1259 OID 16548)
-- Name: dataset_process_rule_dataset_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_process_rule_dataset_id_idx ON public.dataset_process_rules USING btree (dataset_id);


--
-- TOC entry 4096 (class 1259 OID 16558)
-- Name: dataset_query_dataset_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_query_dataset_id_idx ON public.dataset_queries USING btree (dataset_id);


--
-- TOC entry 4214 (class 1259 OID 16954)
-- Name: dataset_retriever_resource_message_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_retriever_resource_message_id_idx ON public.dataset_retriever_resources USING btree (message_id);


--
-- TOC entry 4101 (class 1259 OID 16571)
-- Name: dataset_tenant_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX dataset_tenant_idx ON public.datasets USING btree (tenant_id);


--
-- TOC entry 4113 (class 1259 OID 16608)
-- Name: document_dataset_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX document_dataset_id_idx ON public.documents USING btree (dataset_id);


--
-- TOC entry 4114 (class 1259 OID 16609)
-- Name: document_is_paused_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX document_is_paused_idx ON public.documents USING btree (is_paused);


--
-- TOC entry 4115 (class 1259 OID 17463)
-- Name: document_metadata_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX document_metadata_idx ON public.documents USING gin (doc_metadata);


--
-- TOC entry 4105 (class 1259 OID 16589)
-- Name: document_segment_dataset_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX document_segment_dataset_id_idx ON public.document_segments USING btree (dataset_id);


--
-- TOC entry 4106 (class 1259 OID 16590)
-- Name: document_segment_dataset_node_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX document_segment_dataset_node_idx ON public.document_segments USING btree (dataset_id, index_node_id);


--
-- TOC entry 4107 (class 1259 OID 16591)
-- Name: document_segment_document_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX document_segment_document_id_idx ON public.document_segments USING btree (document_id);


--
-- TOC entry 4110 (class 1259 OID 16592)
-- Name: document_segment_tenant_dataset_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX document_segment_tenant_dataset_idx ON public.document_segments USING btree (dataset_id, tenant_id);


--
-- TOC entry 4111 (class 1259 OID 16593)
-- Name: document_segment_tenant_document_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX document_segment_tenant_document_idx ON public.document_segments USING btree (document_id, tenant_id);


--
-- TOC entry 4112 (class 1259 OID 17100)
-- Name: document_segment_tenant_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX document_segment_tenant_idx ON public.document_segments USING btree (tenant_id);


--
-- TOC entry 4118 (class 1259 OID 17101)
-- Name: document_tenant_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX document_tenant_idx ON public.documents USING btree (tenant_id);


--
-- TOC entry 4126 (class 1259 OID 16632)
-- Name: end_user_session_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX end_user_session_id_idx ON public.end_users USING btree (session_id, type);


--
-- TOC entry 4127 (class 1259 OID 16633)
-- Name: end_user_tenant_session_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX end_user_tenant_session_id_idx ON public.end_users USING btree (tenant_id, session_id, type);


--
-- TOC entry 4312 (class 1259 OID 17323)
-- Name: external_knowledge_apis_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX external_knowledge_apis_name_idx ON public.external_knowledge_apis USING btree (name);


--
-- TOC entry 4315 (class 1259 OID 17324)
-- Name: external_knowledge_apis_tenant_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX external_knowledge_apis_tenant_idx ON public.external_knowledge_apis USING btree (tenant_id);


--
-- TOC entry 4316 (class 1259 OID 17335)
-- Name: external_knowledge_bindings_dataset_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX external_knowledge_bindings_dataset_idx ON public.external_knowledge_bindings USING btree (dataset_id);


--
-- TOC entry 4317 (class 1259 OID 17336)
-- Name: external_knowledge_bindings_external_knowledge_api_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX external_knowledge_bindings_external_knowledge_api_idx ON public.external_knowledge_bindings USING btree (external_knowledge_api_id);


--
-- TOC entry 4318 (class 1259 OID 17337)
-- Name: external_knowledge_bindings_external_knowledge_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX external_knowledge_bindings_external_knowledge_idx ON public.external_knowledge_bindings USING btree (external_knowledge_id);


--
-- TOC entry 4321 (class 1259 OID 17338)
-- Name: external_knowledge_bindings_tenant_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX external_knowledge_bindings_tenant_idx ON public.external_knowledge_bindings USING btree (tenant_id);


--
-- TOC entry 4305 (class 1259 OID 17285)
-- Name: idx_dataset_permissions_account_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dataset_permissions_account_id ON public.dataset_permissions USING btree (account_id);


--
-- TOC entry 4306 (class 1259 OID 17286)
-- Name: idx_dataset_permissions_dataset_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dataset_permissions_dataset_id ON public.dataset_permissions USING btree (dataset_id);


--
-- TOC entry 4307 (class 1259 OID 17287)
-- Name: idx_dataset_permissions_tenant_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dataset_permissions_tenant_id ON public.dataset_permissions USING btree (tenant_id);


--
-- TOC entry 4128 (class 1259 OID 16644)
-- Name: installed_app_app_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX installed_app_app_id_idx ON public.installed_apps USING btree (app_id);


--
-- TOC entry 4131 (class 1259 OID 16645)
-- Name: installed_app_tenant_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX installed_app_tenant_id_idx ON public.installed_apps USING btree (tenant_id);


--
-- TOC entry 4136 (class 1259 OID 16655)
-- Name: invitation_codes_batch_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX invitation_codes_batch_idx ON public.invitation_codes USING btree (batch);


--
-- TOC entry 4137 (class 1259 OID 16656)
-- Name: invitation_codes_code_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX invitation_codes_code_idx ON public.invitation_codes USING btree (code, status);


--
-- TOC entry 4292 (class 1259 OID 17212)
-- Name: load_balancing_model_config_tenant_provider_model_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX load_balancing_model_config_tenant_provider_model_idx ON public.load_balancing_model_configs USING btree (tenant_id, provider_name, model_type);


--
-- TOC entry 4188 (class 1259 OID 16834)
-- Name: message_account_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_account_idx ON public.messages USING btree (app_id, from_source, from_account_id);


--
-- TOC entry 4138 (class 1259 OID 16666)
-- Name: message_agent_thought_message_chain_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_agent_thought_message_chain_id_idx ON public.message_agent_thoughts USING btree (message_chain_id);


--
-- TOC entry 4139 (class 1259 OID 16667)
-- Name: message_agent_thought_message_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_agent_thought_message_id_idx ON public.message_agent_thoughts USING btree (message_id);


--
-- TOC entry 4183 (class 1259 OID 16817)
-- Name: message_annotation_app_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_annotation_app_idx ON public.message_annotations USING btree (app_id);


--
-- TOC entry 4184 (class 1259 OID 16818)
-- Name: message_annotation_conversation_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_annotation_conversation_idx ON public.message_annotations USING btree (conversation_id);


--
-- TOC entry 4185 (class 1259 OID 16819)
-- Name: message_annotation_message_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_annotation_message_idx ON public.message_annotations USING btree (message_id);


--
-- TOC entry 4189 (class 1259 OID 16835)
-- Name: message_app_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_app_id_idx ON public.messages USING btree (app_id, created_at);


--
-- TOC entry 4142 (class 1259 OID 16677)
-- Name: message_chain_message_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_chain_message_id_idx ON public.message_chains USING btree (message_id);


--
-- TOC entry 4190 (class 1259 OID 16836)
-- Name: message_conversation_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_conversation_id_idx ON public.messages USING btree (conversation_id);


--
-- TOC entry 4191 (class 1259 OID 17364)
-- Name: message_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_created_at_idx ON public.messages USING btree (created_at);


--
-- TOC entry 4192 (class 1259 OID 16837)
-- Name: message_end_user_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_end_user_idx ON public.messages USING btree (app_id, from_source, from_end_user_id);


--
-- TOC entry 4145 (class 1259 OID 16688)
-- Name: message_feedback_app_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_feedback_app_idx ON public.message_feedbacks USING btree (app_id);


--
-- TOC entry 4146 (class 1259 OID 16689)
-- Name: message_feedback_conversation_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_feedback_conversation_idx ON public.message_feedbacks USING btree (conversation_id, from_source, rating);


--
-- TOC entry 4147 (class 1259 OID 16690)
-- Name: message_feedback_message_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_feedback_message_idx ON public.message_feedbacks USING btree (message_id, from_source);


--
-- TOC entry 4223 (class 1259 OID 16984)
-- Name: message_file_created_by_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_file_created_by_idx ON public.message_files USING btree (created_by);


--
-- TOC entry 4224 (class 1259 OID 16985)
-- Name: message_file_message_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_file_message_idx ON public.message_files USING btree (message_id);


--
-- TOC entry 4195 (class 1259 OID 17276)
-- Name: message_workflow_run_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX message_workflow_run_id_idx ON public.messages USING btree (conversation_id, workflow_run_id);


--
-- TOC entry 4150 (class 1259 OID 16701)
-- Name: operation_log_account_action_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX operation_log_account_action_idx ON public.operation_logs USING btree (tenant_id, account_id, action);


--
-- TOC entry 4153 (class 1259 OID 16839)
-- Name: pinned_conversation_conversation_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pinned_conversation_conversation_idx ON public.pinned_conversations USING btree (app_id, conversation_id, created_by_role, created_by);


--
-- TOC entry 4219 (class 1259 OID 17410)
-- Name: provider_model_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX provider_model_name_idx ON public.dataset_collection_bindings USING btree (provider_name, model_name);


--
-- TOC entry 4295 (class 1259 OID 17225)
-- Name: provider_model_setting_tenant_provider_model_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX provider_model_setting_tenant_provider_model_idx ON public.provider_model_settings USING btree (tenant_id, provider_name, model_type);


--
-- TOC entry 4202 (class 1259 OID 17228)
-- Name: provider_model_tenant_id_provider_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX provider_model_tenant_id_provider_idx ON public.provider_models USING btree (tenant_id, provider_name);


--
-- TOC entry 4213 (class 1259 OID 17229)
-- Name: provider_order_tenant_provider_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX provider_order_tenant_provider_idx ON public.provider_orders USING btree (tenant_id, provider_name);


--
-- TOC entry 4158 (class 1259 OID 17232)
-- Name: provider_tenant_id_provider_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX provider_tenant_id_provider_idx ON public.providers USING btree (tenant_id, provider_name);


--
-- TOC entry 4343 (class 1259 OID 17428)
-- Name: rate_limit_log_operation_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX rate_limit_log_operation_idx ON public.rate_limit_logs USING btree (operation);


--
-- TOC entry 4346 (class 1259 OID 17429)
-- Name: rate_limit_log_tenant_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX rate_limit_log_tenant_idx ON public.rate_limit_logs USING btree (tenant_id);


--
-- TOC entry 4161 (class 1259 OID 16736)
-- Name: recommended_app_app_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX recommended_app_app_id_idx ON public.recommended_apps USING btree (app_id);


--
-- TOC entry 4162 (class 1259 OID 16843)
-- Name: recommended_app_is_listed_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX recommended_app_is_listed_idx ON public.recommended_apps USING btree (is_listed, language);


--
-- TOC entry 4102 (class 1259 OID 16987)
-- Name: retrieval_model_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX retrieval_model_idx ON public.datasets USING gin (retrieval_model);


--
-- TOC entry 4165 (class 1259 OID 16841)
-- Name: saved_message_message_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX saved_message_message_idx ON public.saved_messages USING btree (app_id, message_id, created_by_role, created_by);


--
-- TOC entry 4168 (class 1259 OID 16769)
-- Name: site_app_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX site_app_id_idx ON public.sites USING btree (app_id);


--
-- TOC entry 4169 (class 1259 OID 16770)
-- Name: site_code_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX site_code_idx ON public.sites USING btree (code, status);


--
-- TOC entry 4198 (class 1259 OID 17250)
-- Name: source_binding_tenant_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX source_binding_tenant_id_idx ON public.data_source_oauth_bindings USING btree (tenant_id);


--
-- TOC entry 4199 (class 1259 OID 17251)
-- Name: source_info_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX source_info_idx ON public.data_source_oauth_bindings USING gin (source_info);


--
-- TOC entry 4272 (class 1259 OID 17163)
-- Name: tag_bind_tag_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tag_bind_tag_id_idx ON public.tag_bindings USING btree (tag_id);


--
-- TOC entry 4273 (class 1259 OID 17164)
-- Name: tag_bind_target_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tag_bind_target_id_idx ON public.tag_bindings USING btree (target_id);


--
-- TOC entry 4276 (class 1259 OID 17172)
-- Name: tag_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tag_name_idx ON public.tags USING btree (name);


--
-- TOC entry 4279 (class 1259 OID 17173)
-- Name: tag_type_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tag_type_idx ON public.tags USING btree (type);


--
-- TOC entry 4172 (class 1259 OID 16782)
-- Name: tenant_account_join_account_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tenant_account_join_account_id_idx ON public.tenant_account_joins USING btree (account_id);


--
-- TOC entry 4175 (class 1259 OID 16783)
-- Name: tenant_account_join_tenant_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tenant_account_join_tenant_id_idx ON public.tenant_account_joins USING btree (tenant_id);


--
-- TOC entry 4207 (class 1259 OID 17233)
-- Name: tenant_default_model_tenant_id_provider_type_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tenant_default_model_tenant_id_provider_type_idx ON public.tenant_default_models USING btree (tenant_id, provider_name, model_type);


--
-- TOC entry 4210 (class 1259 OID 17236)
-- Name: tenant_preferred_model_provider_tenant_provider_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tenant_preferred_model_provider_tenant_provider_idx ON public.tenant_preferred_model_providers USING btree (tenant_id, provider_name);


--
-- TOC entry 4322 (class 1259 OID 17350)
-- Name: tidb_auth_bindings_active_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tidb_auth_bindings_active_idx ON public.tidb_auth_bindings USING btree (active);


--
-- TOC entry 4323 (class 1259 OID 17352)
-- Name: tidb_auth_bindings_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tidb_auth_bindings_created_at_idx ON public.tidb_auth_bindings USING btree (created_at);


--
-- TOC entry 4326 (class 1259 OID 17351)
-- Name: tidb_auth_bindings_status_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tidb_auth_bindings_status_idx ON public.tidb_auth_bindings USING btree (status);


--
-- TOC entry 4327 (class 1259 OID 17353)
-- Name: tidb_auth_bindings_tenant_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tidb_auth_bindings_tenant_idx ON public.tidb_auth_bindings USING btree (tenant_id);


--
-- TOC entry 4254 (class 1259 OID 17097)
-- Name: tool_file_conversation_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tool_file_conversation_id_idx ON public.tool_files USING btree (conversation_id);


--
-- TOC entry 4300 (class 1259 OID 17275)
-- Name: trace_app_config_app_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX trace_app_config_app_id_idx ON public.trace_app_config USING btree (app_id);


--
-- TOC entry 4182 (class 1259 OID 16806)
-- Name: upload_file_tenant_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX upload_file_tenant_idx ON public.upload_files USING btree (tenant_id);


--
-- TOC entry 4253 (class 1259 OID 17094)
-- Name: user_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_id_idx ON public.tool_conversation_variables USING btree (user_id);


--
-- TOC entry 4330 (class 1259 OID 17361)
-- Name: whitelists_tenant_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX whitelists_tenant_idx ON public.whitelists USING btree (tenant_id);


--
-- TOC entry 4257 (class 1259 OID 17115)
-- Name: workflow_app_log_app_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX workflow_app_log_app_idx ON public.workflow_app_logs USING btree (tenant_id, app_id);


--
-- TOC entry 4310 (class 1259 OID 17306)
-- Name: workflow_conversation_variables_app_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX workflow_conversation_variables_app_id_idx ON public.workflow_conversation_variables USING btree (app_id);


--
-- TOC entry 4311 (class 1259 OID 17307)
-- Name: workflow_conversation_variables_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX workflow_conversation_variables_created_at_idx ON public.workflow_conversation_variables USING btree (created_at);


--
-- TOC entry 4260 (class 1259 OID 17312)
-- Name: workflow_node_execution_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX workflow_node_execution_id_idx ON public.workflow_node_executions USING btree (tenant_id, app_id, workflow_id, triggered_from, node_execution_id);


--
-- TOC entry 4261 (class 1259 OID 17126)
-- Name: workflow_node_execution_node_run_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX workflow_node_execution_node_run_idx ON public.workflow_node_executions USING btree (tenant_id, app_id, workflow_id, triggered_from, node_id);


--
-- TOC entry 4264 (class 1259 OID 17127)
-- Name: workflow_node_execution_workflow_run_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX workflow_node_execution_workflow_run_idx ON public.workflow_node_executions USING btree (tenant_id, app_id, workflow_id, triggered_from, workflow_run_id);


--
-- TOC entry 4267 (class 1259 OID 17200)
-- Name: workflow_run_tenant_app_sequence_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX workflow_run_tenant_app_sequence_idx ON public.workflow_runs USING btree (tenant_id, app_id, sequence_number);


--
-- TOC entry 4268 (class 1259 OID 17140)
-- Name: workflow_run_triggerd_from_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX workflow_run_triggerd_from_idx ON public.workflow_runs USING btree (tenant_id, app_id, triggered_from);


--
-- TOC entry 4271 (class 1259 OID 17150)
-- Name: workflow_version_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX workflow_version_idx ON public.workflows USING btree (tenant_id, app_id, version);


--
-- TOC entry 4357 (class 2606 OID 17048)
-- Name: tool_published_apps tool_published_apps_app_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tool_published_apps
    ADD CONSTRAINT tool_published_apps_app_id_fkey FOREIGN KEY (app_id) REFERENCES public.apps(id);


-- Completed on 2025-04-15 15:26:15 CST

--
-- PostgreSQL database dump complete
--


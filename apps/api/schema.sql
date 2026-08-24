CREATE TABLE IF NOT EXISTS launch_states (
  state TEXT PRIMARY KEY,
  iss TEXT NOT NULL,
  launch TEXT,
  patient_fhir_id TEXT,
  user_fhir_id TEXT,
  expires_at TEXT NOT NULL,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS sessions (
  id TEXT PRIMARY KEY,
  role TEXT NOT NULL,
  patient_internal_id TEXT,
  clinician_fhir_id TEXT,
  expires_at TEXT NOT NULL,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS token_vault (
  id TEXT PRIMARY KEY,
  patient_fhir_id TEXT,
  encrypted_access_token TEXT NOT NULL,
  encrypted_refresh_token TEXT,
  scopes TEXT,
  token_type TEXT,
  expires_at TEXT,
  revoked_at TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS consents (
  id TEXT PRIMARY KEY,
  patient_internal_id TEXT NOT NULL,
  consent_type TEXT NOT NULL,
  status TEXT NOT NULL,
  granted_at TEXT,
  revoked_at TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS patients (
  id TEXT PRIMARY KEY,
  fhir_patient_id TEXT UNIQUE,
  given_name TEXT,
  family_name TEXT,
  birth_date TEXT,
  diabetes_type TEXT,
  diagnosis_date TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS conditions (
  id TEXT PRIMARY KEY,
  patient_internal_id TEXT NOT NULL,
  fhir_condition_id TEXT,
  code TEXT,
  display TEXT,
  clinical_status TEXT,
  recorded_date TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS medications (
  id TEXT PRIMARY KEY,
  patient_internal_id TEXT NOT NULL,
  fhir_medication_request_id TEXT,
  medication_name TEXT,
  medication_class TEXT,
  risk_flag TEXT,
  status TEXT,
  start_date TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS medication_reconciliation (
  id TEXT PRIMARY KEY,
  patient_internal_id TEXT NOT NULL,
  medication_id TEXT,
  patient_status TEXT,
  side_effect_reported INTEGER DEFAULT 0,
  note TEXT,
  confirmed_at TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS observations_normalized (
  id TEXT PRIMARY KEY,
  patient_internal_id TEXT NOT NULL,
  category TEXT NOT NULL,
  loinc_code TEXT,
  display_name TEXT,
  value_numeric REAL,
  value_text TEXT,
  unit TEXT,
  effective_date TEXT,
  source TEXT,
  raw_fhir_json TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS care_gap_readiness (
  id TEXT PRIMARY KEY,
  patient_internal_id TEXT NOT NULL,
  gap_type TEXT NOT NULL,
  status TEXT NOT NULL,
  last_value TEXT,
  last_date TEXT,
  due_date TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS audit_events (
  id TEXT PRIMARY KEY,
  event_type TEXT NOT NULL,
  actor_type TEXT,
  actor_id TEXT,
  patient_internal_id TEXT,
  metadata_json TEXT,
  created_at TEXT DEFAULT CURRENT_TIMESTAMP
);
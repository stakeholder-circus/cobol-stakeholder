       >>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. STAKEHOLDER.
DATA DIVISION.
WORKING-STORAGE SECTION.
01 ARG-C PIC 9(4).
01 I PIC 9(4).
01 ARG PIC X(120).
01 NEXT-ARG PIC X(120).
01 FOCUS PIC X(80) VALUE SPACES.
01 FORMAT-OUT PIC X(10) VALUE "text".
01 FAM PIC X(64) VALUE SPACES.
01 REND PIC X(80) VALUE SPACES.
01 TRANCHE PIC X(40) VALUE SPACES.
01 CKEY PIC X(40) VALUE SPACES.
01 CVAL PIC X(80) VALUE SPACES.
01 IDX PIC 9(4) VALUE 1000.
01 LIST-FLAG PIC X VALUE "N".
PROCEDURE DIVISION.
MAIN-PARA.
  ACCEPT ARG-C FROM ARGUMENT-NUMBER
  PERFORM VARYING I FROM 1 BY 1 UNTIL I > ARG-C
    ACCEPT ARG FROM ARGUMENT-VALUE
    EVALUATE FUNCTION TRIM(ARG)
      WHEN "--list-values"
        MOVE "Y" TO LIST-FLAG
      WHEN "--focus-family"
        ADD 1 TO I
        ACCEPT NEXT-ARG FROM ARGUMENT-VALUE
        MOVE FUNCTION LOWER-CASE(FUNCTION TRIM(NEXT-ARG)) TO FOCUS
      WHEN "--seed"
        ADD 1 TO I
        ACCEPT NEXT-ARG FROM ARGUMENT-VALUE
      WHEN "--output-format"
        ADD 1 TO I
        ACCEPT NEXT-ARG FROM ARGUMENT-VALUE
        MOVE FUNCTION LOWER-CASE(FUNCTION TRIM(NEXT-ARG)) TO FORMAT-OUT
      WHEN "--experimental-provider"
        DISPLAY "experimental provider is not enabled in the deterministic first tranche" UPON STDERR
        MOVE 2 TO RETURN-CODE
        STOP RUN
      WHEN OTHER
        IF FUNCTION TRIM(ARG) = "--experimental-demo"
          DISPLAY "experimental flags require --experimental-provider" UPON STDERR
          MOVE 2 TO RETURN-CODE
          STOP RUN
        END-IF
    END-EVALUATE
  END-PERFORM
  IF FORMAT-OUT NOT = "text" AND FORMAT-OUT NOT = "json"
    DISPLAY "invalid --output-format: " FUNCTION TRIM(FORMAT-OUT) UPON STDERR
    MOVE 2 TO RETURN-CODE
    STOP RUN
  END-IF
  IF LIST-FLAG = "Y"
    PERFORM PRINT-REGISTRY
    STOP RUN
  END-IF
  IF FOCUS = SPACES
    DISPLAY "focus-family is required and must be a known generator family" UPON STDERR
    MOVE 2 TO RETURN-CODE
    STOP RUN
  END-IF
  PERFORM RESOLVE-FAMILY
  IF FAM = SPACES
    DISPLAY "invalid --focus-family" UPON STDERR
    MOVE 2 TO RETURN-CODE
    STOP RUN
  END-IF
  IF FORMAT-OUT = "json"
    PERFORM PRINT-JSON
  ELSE
    PERFORM PRINT-TEXT
  END-IF
  STOP RUN.

PRINT-REGISTRY.
  DISPLAY '{"outputFormats":["text","json"],"flags":["list-values","focus-family","output-format","seed","experimental-provider"],"generatorFamilies":[{"id":"code_analyzer","registryId":"code' WITH NO ADVANCING
  DISPLAY '-analyzer","rendererKey":"classic-six.code_analyzer","tranche":"classic-six"},{"id":"data_processing","registryId":"data-processing","rendererKey":"classic-six.data_processing","tr' WITH NO ADVANCING
  DISPLAY 'anche":"classic-six"},{"id":"jargon","registryId":"jargon","rendererKey":"classic-six.jargon","tranche":"classic-six"},{"id":"metrics","registryId":"metrics","rendererKey":"classic' WITH NO ADVANCING
  DISPLAY '-six.metrics","tranche":"classic-six"},{"id":"network_activity","registryId":"network-activity","rendererKey":"classic-six.network_activity","tranche":"classic-six"},{"id":"system_' WITH NO ADVANCING
  DISPLAY 'monitoring","registryId":"system-monitoring","rendererKey":"classic-six.system_monitoring","tranche":"classic-six"},{"id":"agent_workflows","registryId":"agent-workflows","renderer' WITH NO ADVANCING
  DISPLAY 'Key":"modern-core.agent_workflows","tranche":"modern-core"},{"id":"platform_engineering","registryId":"platform-engineering","rendererKey":"modern-core.platform_engineering","tranc' WITH NO ADVANCING
  DISPLAY 'he":"modern-core"},{"id":"observability_ai_runtime","registryId":"observability-ai-runtime","rendererKey":"modern-core.observability_ai_runtime","tranche":"modern-core"},{"id":"del' WITH NO ADVANCING
  DISPLAY 'ivery_preview_ops","registryId":"delivery-preview-ops","rendererKey":"modern-core.delivery_preview_ops","tranche":"modern-core"},{"id":"supply_chain_security","registryId":"supply-' WITH NO ADVANCING
  DISPLAY 'chain-security","rendererKey":"modern-core.supply_chain_security","tranche":"modern-core"},{"id":"ai_inference_ops","registryId":"ai-inference-ops","rendererKey":"fallback.ai_gover' WITH NO ADVANCING
  DISPLAY 'nance","tranche":"fallback-ai_governance"},{"id":"evaluation_and_guardrails","registryId":"evaluation-and-guardrails","rendererKey":"fallback.ai_governance","tranche":"fallback-ai_' WITH NO ADVANCING
  DISPLAY 'governance"},{"id":"knowledge_retrieval","registryId":"knowledge-retrieval","rendererKey":"fallback.ai_governance","tranche":"fallback-ai_governance"},{"id":"edge_client_runtime","' WITH NO ADVANCING
  DISPLAY 'registryId":"edge-client-runtime","rendererKey":"fallback.ai_governance","tranche":"fallback-ai_governance"},{"id":"identity_and_trust","registryId":"identity-and-trust","rendererK' WITH NO ADVANCING
  DISPLAY 'ey":"fallback.ai_governance","tranche":"fallback-ai_governance"},{"id":"aibom_provenance","registryId":"aibom-provenance","rendererKey":"fallback.ai_governance","tranche":"fallback' WITH NO ADVANCING
  DISPLAY '-ai_governance"},{"id":"agent_boundary_security","registryId":"agent-boundary-security","rendererKey":"fallback.ai_governance","tranche":"fallback-ai_governance"},{"id":"embedded_a' WITH NO ADVANCING
  DISPLAY 'gentic_pipeline","registryId":"embedded-agentic-pipeline","rendererKey":"fallback.ai_governance","tranche":"fallback-ai_governance"},{"id":"data_governance_compliance","registryId"' WITH NO ADVANCING
  DISPLAY ':"data-governance-compliance","rendererKey":"fallback.ai_governance","tranche":"fallback-ai_governance"},{"id":"finops_capacity","registryId":"finops-capacity","rendererKey":"fallb' WITH NO ADVANCING
  DISPLAY 'ack.ai_governance","tranche":"fallback-ai_governance"},{"id":"blockchain_protocol_ops","registryId":"blockchain-protocol-ops","rendererKey":"fallback.security_blockchain","tranche"' WITH NO ADVANCING
  DISPLAY ':"fallback-security_blockchain"},{"id":"cross_chain_interop","registryId":"cross-chain-interop","rendererKey":"fallback.security_blockchain","tranche":"fallback-security_blockchain' WITH NO ADVANCING
  DISPLAY '"},{"id":"proof_and_sequencer_ops","registryId":"proof-and-sequencer-ops","rendererKey":"fallback.security_blockchain","tranche":"fallback-security_blockchain"},{"id":"hybrid_runti' WITH NO ADVANCING
  DISPLAY 'me_ops","registryId":"hybrid-runtime-ops","rendererKey":"fallback.overlay_quantum","tranche":"fallback-overlay_quantum"},{"id":"capacity_cost_controller","registryId":"capacity-cos' WITH NO ADVANCING
  DISPLAY 't-controller","rendererKey":"fallback.overlay_quantum","tranche":"fallback-overlay_quantum"},{"id":"batch_execution_tuner","registryId":"batch-execution-tuner","rendererKey":"fallb' WITH NO ADVANCING
  DISPLAY 'ack.overlay_quantum","tranche":"fallback-overlay_quantum"},{"id":"compiler_maintainer","registryId":"compiler-maintainer","rendererKey":"fallback.overlay_quantum","tranche":"fallba' WITH NO ADVANCING
  DISPLAY 'ck-overlay_quantum"},{"id":"interop_adapter_engineer","registryId":"interop-adapter-engineer","rendererKey":"fallback.overlay_quantum","tranche":"fallback-overlay_quantum"},{"id":"' WITH NO ADVANCING
  DISPLAY 'preflight_capacity_planner","registryId":"preflight-capacity-planner","rendererKey":"fallback.overlay_quantum","tranche":"fallback-overlay_quantum"},{"id":"simulator_performance_en' WITH NO ADVANCING
  DISPLAY 'gineer","registryId":"simulator-performance-engineer","rendererKey":"fallback.overlay_quantum","tranche":"fallback-overlay_quantum"},{"id":"fhir_profile_generator","registryId":"fh' WITH NO ADVANCING
  DISPLAY 'ir-profile-generator","rendererKey":"fallback.health_protocol","tranche":"fallback-health_protocol"},{"id":"smart_launch_oauth","registryId":"smart-launch-oauth","rendererKey":"fal' WITH NO ADVANCING
  DISPLAY 'lback.health_protocol","tranche":"fallback-health_protocol"},{"id":"bulk_fhir_population_ops","registryId":"bulk-fhir-population-ops","rendererKey":"fallback.health_protocol","tran' WITH NO ADVANCING
  DISPLAY 'che":"fallback-health_protocol"},{"id":"hl7v2_feed_ops","registryId":"hl7v2-feed-ops","rendererKey":"fallback.health_protocol","tranche":"fallback-health_protocol"},{"id":"clinical' WITH NO ADVANCING
  DISPLAY '_workflow_events","registryId":"clinical-workflow-events","rendererKey":"fallback.health_protocol","tranche":"fallback-health_protocol"},{"id":"dicomweb_imaging_ops","registryId":"' WITH NO ADVANCING
  DISPLAY 'dicomweb-imaging-ops","rendererKey":"fallback.health_protocol","tranche":"fallback-health_protocol"},{"id":"openehr_semantic_record_ops","registryId":"openehr-semantic-record-ops",' WITH NO ADVANCING
  DISPLAY '"rendererKey":"fallback.health_protocol","tranche":"fallback-health_protocol"},{"id":"device_telemetry_clinical","registryId":"device-telemetry-clinical","rendererKey":"fallback.he' WITH NO ADVANCING
  DISPLAY 'alth_protocol","tranche":"fallback-health_protocol"},{"id":"emr_vendor_adapter","registryId":"emr-vendor-adapter","rendererKey":"fallback.health_protocol","tranche":"fallback-healt' WITH NO ADVANCING
  DISPLAY 'h_protocol"},{"id":"ocpp_chargepoint_ops","registryId":"ocpp-chargepoint-ops","rendererKey":"fallback.health_protocol","tranche":"fallback-health_protocol"},{"id":"ocpi_roaming_ops' WITH NO ADVANCING
  DISPLAY '","registryId":"ocpi-roaming-ops","rendererKey":"fallback.health_protocol","tranche":"fallback-health_protocol"},{"id":"mcp_a2a_ops","registryId":"mcp-a2a-ops","rendererKey":"fallb' WITH NO ADVANCING
  DISPLAY 'ack.health_protocol","tranche":"fallback-health_protocol"},{"id":"streaming_bus_ops","registryId":"streaming-bus-ops","rendererKey":"fallback.health_protocol","tranche":"fallback-h' WITH NO ADVANCING
  DISPLAY 'ealth_protocol"},{"id":"service_mesh_rpc_ops","registryId":"service-mesh-rpc-ops","rendererKey":"fallback.health_protocol","tranche":"fallback-health_protocol"}],"classicSix":["cod' WITH NO ADVANCING
  DISPLAY 'e-analyzer","data-processing","jargon","metrics","network-activity","system-monitoring"],"modernCore":["agent-workflows","platform-engineering","observability-ai-runtime","delivery' WITH NO ADVANCING
  DISPLAY '-preview-ops","supply-chain-security"],"fallbackFamilies":["ai-inference-ops","evaluation-and-guardrails","knowledge-retrieval","edge-client-runtime","identity-and-trust","aibom-pr' WITH NO ADVANCING
  DISPLAY 'ovenance","agent-boundary-security","embedded-agentic-pipeline","data-governance-compliance","finops-capacity","blockchain-protocol-ops","cross-chain-interop","proof-and-sequencer-' WITH NO ADVANCING
  DISPLAY 'ops","hybrid-runtime-ops","capacity-cost-controller","batch-execution-tuner","compiler-maintainer","interop-adapter-engineer","preflight-capacity-planner","simulator-performance-en' WITH NO ADVANCING
  DISPLAY 'gineer","fhir-profile-generator","smart-launch-oauth","bulk-fhir-population-ops","hl7v2-feed-ops","clinical-workflow-events","dicomweb-imaging-ops","openehr-semantic-record-ops","d' WITH NO ADVANCING
  DISPLAY 'evice-telemetry-clinical","emr-vendor-adapter","ocpp-chargepoint-ops","ocpi-roaming-ops","mcp-a2a-ops","streaming-bus-ops","service-mesh-rpc-ops"],"implementationMode":"family-focu' WITH NO ADVANCING
  DISPLAY 's-deterministic"}' WITH NO ADVANCING
  DISPLAY ""
  EXIT.

RESOLVE-FAMILY.
  IF FUNCTION TRIM(FOCUS) = "code_analyzer" OR FUNCTION TRIM(FOCUS) = "code-analyzer"
    MOVE "code_analyzer" TO FAM
    MOVE "classic-six.code_analyzer" TO REND
    MOVE "classic-six" TO TRANCHE
    MOVE "analysisFocus" TO CKEY
    MOVE "cobol-paragraph-audit" TO CVAL
    MOVE 1001 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "data_processing" OR FUNCTION TRIM(FOCUS) = "data-processing"
    MOVE "data_processing" TO FAM
    MOVE "classic-six.data_processing" TO REND
    MOVE "classic-six" TO TRANCHE
    MOVE "dataWindow" TO CKEY
    MOVE "record-stream-reconciliation" TO CVAL
    MOVE 1002 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "jargon" OR FUNCTION TRIM(FOCUS) = "jargon"
    MOVE "jargon" TO FAM
    MOVE "classic-six.jargon" TO REND
    MOVE "classic-six" TO TRANCHE
    MOVE "languagePolicy" TO CKEY
    MOVE "cobol-glossary" TO CVAL
    MOVE 1003 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "metrics" OR FUNCTION TRIM(FOCUS) = "metrics"
    MOVE "metrics" TO FAM
    MOVE "classic-six.metrics" TO REND
    MOVE "classic-six" TO TRANCHE
    MOVE "signalBlend" TO CKEY
    MOVE "batch-runtime-latency" TO CVAL
    MOVE 1004 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "network_activity" OR FUNCTION TRIM(FOCUS) = "network-activity"
    MOVE "network_activity" TO FAM
    MOVE "classic-six.network_activity" TO REND
    MOVE "classic-six" TO TRANCHE
    MOVE "transportMix" TO CKEY
    MOVE "socket-http-sse" TO CVAL
    MOVE 1005 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "system_monitoring" OR FUNCTION TRIM(FOCUS) = "system-monitoring"
    MOVE "system_monitoring" TO FAM
    MOVE "classic-six.system_monitoring" TO REND
    MOVE "classic-six" TO TRANCHE
    MOVE "telemetryScope" TO CKEY
    MOVE "gnucobol-runtime-host" TO CVAL
    MOVE 1006 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "agent_workflows" OR FUNCTION TRIM(FOCUS) = "agent-workflows"
    MOVE "agent_workflows" TO FAM
    MOVE "modern-core.agent_workflows" TO REND
    MOVE "modern-core" TO TRANCHE
    MOVE "coordinationMode" TO CKEY
    MOVE "paragraph-dispatch-handshake" TO CVAL
    MOVE 1007 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "platform_engineering" OR FUNCTION TRIM(FOCUS) = "platform-engineering"
    MOVE "platform_engineering" TO FAM
    MOVE "modern-core.platform_engineering" TO REND
    MOVE "modern-core" TO TRANCHE
    MOVE "platformSurface" TO CKEY
    MOVE "gnucobol-native-validation-lane" TO CVAL
    MOVE 1008 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "observability_ai_runtime" OR FUNCTION TRIM(FOCUS) = "observability-ai-runtime"
    MOVE "observability_ai_runtime" TO FAM
    MOVE "modern-core.observability_ai_runtime" TO REND
    MOVE "modern-core" TO TRANCHE
    MOVE "runtimeSignals" TO CKEY
    MOVE "logs-metrics-provider-boundary" TO CVAL
    MOVE 1009 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "delivery_preview_ops" OR FUNCTION TRIM(FOCUS) = "delivery-preview-ops"
    MOVE "delivery_preview_ops" TO FAM
    MOVE "modern-core.delivery_preview_ops" TO REND
    MOVE "modern-core" TO TRANCHE
    MOVE "deliveryGuardrail" TO CKEY
    MOVE "compiled-preview-checkpoints" TO CVAL
    MOVE 1010 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "supply_chain_security" OR FUNCTION TRIM(FOCUS) = "supply-chain-security"
    MOVE "supply_chain_security" TO FAM
    MOVE "modern-core.supply_chain_security" TO REND
    MOVE "modern-core" TO TRANCHE
    MOVE "supplyChainPosture" TO CKEY
    MOVE "source-binary-attestation" TO CVAL
    MOVE 1011 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "ai_inference_ops" OR FUNCTION TRIM(FOCUS) = "ai-inference-ops"
    MOVE "ai_inference_ops" TO FAM
    MOVE "fallback.ai_governance" TO REND
    MOVE "fallback-ai_governance" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "ai_governance" TO CVAL
    MOVE 1012 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "evaluation_and_guardrails" OR FUNCTION TRIM(FOCUS) = "evaluation-and-guardrails"
    MOVE "evaluation_and_guardrails" TO FAM
    MOVE "fallback.ai_governance" TO REND
    MOVE "fallback-ai_governance" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "ai_governance" TO CVAL
    MOVE 1013 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "knowledge_retrieval" OR FUNCTION TRIM(FOCUS) = "knowledge-retrieval"
    MOVE "knowledge_retrieval" TO FAM
    MOVE "fallback.ai_governance" TO REND
    MOVE "fallback-ai_governance" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "ai_governance" TO CVAL
    MOVE 1014 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "edge_client_runtime" OR FUNCTION TRIM(FOCUS) = "edge-client-runtime"
    MOVE "edge_client_runtime" TO FAM
    MOVE "fallback.ai_governance" TO REND
    MOVE "fallback-ai_governance" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "ai_governance" TO CVAL
    MOVE 1015 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "identity_and_trust" OR FUNCTION TRIM(FOCUS) = "identity-and-trust"
    MOVE "identity_and_trust" TO FAM
    MOVE "fallback.ai_governance" TO REND
    MOVE "fallback-ai_governance" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "ai_governance" TO CVAL
    MOVE 1016 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "aibom_provenance" OR FUNCTION TRIM(FOCUS) = "aibom-provenance"
    MOVE "aibom_provenance" TO FAM
    MOVE "fallback.ai_governance" TO REND
    MOVE "fallback-ai_governance" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "ai_governance" TO CVAL
    MOVE 1017 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "agent_boundary_security" OR FUNCTION TRIM(FOCUS) = "agent-boundary-security"
    MOVE "agent_boundary_security" TO FAM
    MOVE "fallback.ai_governance" TO REND
    MOVE "fallback-ai_governance" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "ai_governance" TO CVAL
    MOVE 1018 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "embedded_agentic_pipeline" OR FUNCTION TRIM(FOCUS) = "embedded-agentic-pipeline"
    MOVE "embedded_agentic_pipeline" TO FAM
    MOVE "fallback.ai_governance" TO REND
    MOVE "fallback-ai_governance" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "ai_governance" TO CVAL
    MOVE 1019 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "data_governance_compliance" OR FUNCTION TRIM(FOCUS) = "data-governance-compliance"
    MOVE "data_governance_compliance" TO FAM
    MOVE "fallback.ai_governance" TO REND
    MOVE "fallback-ai_governance" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "ai_governance" TO CVAL
    MOVE 1020 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "finops_capacity" OR FUNCTION TRIM(FOCUS) = "finops-capacity"
    MOVE "finops_capacity" TO FAM
    MOVE "fallback.ai_governance" TO REND
    MOVE "fallback-ai_governance" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "ai_governance" TO CVAL
    MOVE 1021 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "blockchain_protocol_ops" OR FUNCTION TRIM(FOCUS) = "blockchain-protocol-ops"
    MOVE "blockchain_protocol_ops" TO FAM
    MOVE "fallback.security_blockchain" TO REND
    MOVE "fallback-security_blockchain" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "security_blockchain" TO CVAL
    MOVE 1022 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "cross_chain_interop" OR FUNCTION TRIM(FOCUS) = "cross-chain-interop"
    MOVE "cross_chain_interop" TO FAM
    MOVE "fallback.security_blockchain" TO REND
    MOVE "fallback-security_blockchain" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "security_blockchain" TO CVAL
    MOVE 1023 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "proof_and_sequencer_ops" OR FUNCTION TRIM(FOCUS) = "proof-and-sequencer-ops"
    MOVE "proof_and_sequencer_ops" TO FAM
    MOVE "fallback.security_blockchain" TO REND
    MOVE "fallback-security_blockchain" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "security_blockchain" TO CVAL
    MOVE 1024 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "hybrid_runtime_ops" OR FUNCTION TRIM(FOCUS) = "hybrid-runtime-ops"
    MOVE "hybrid_runtime_ops" TO FAM
    MOVE "fallback.overlay_quantum" TO REND
    MOVE "fallback-overlay_quantum" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "overlay_quantum" TO CVAL
    MOVE 1025 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "capacity_cost_controller" OR FUNCTION TRIM(FOCUS) = "capacity-cost-controller"
    MOVE "capacity_cost_controller" TO FAM
    MOVE "fallback.overlay_quantum" TO REND
    MOVE "fallback-overlay_quantum" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "overlay_quantum" TO CVAL
    MOVE 1026 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "batch_execution_tuner" OR FUNCTION TRIM(FOCUS) = "batch-execution-tuner"
    MOVE "batch_execution_tuner" TO FAM
    MOVE "fallback.overlay_quantum" TO REND
    MOVE "fallback-overlay_quantum" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "overlay_quantum" TO CVAL
    MOVE 1027 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "compiler_maintainer" OR FUNCTION TRIM(FOCUS) = "compiler-maintainer"
    MOVE "compiler_maintainer" TO FAM
    MOVE "fallback.overlay_quantum" TO REND
    MOVE "fallback-overlay_quantum" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "overlay_quantum" TO CVAL
    MOVE 1028 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "interop_adapter_engineer" OR FUNCTION TRIM(FOCUS) = "interop-adapter-engineer"
    MOVE "interop_adapter_engineer" TO FAM
    MOVE "fallback.overlay_quantum" TO REND
    MOVE "fallback-overlay_quantum" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "overlay_quantum" TO CVAL
    MOVE 1029 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "preflight_capacity_planner" OR FUNCTION TRIM(FOCUS) = "preflight-capacity-planner"
    MOVE "preflight_capacity_planner" TO FAM
    MOVE "fallback.overlay_quantum" TO REND
    MOVE "fallback-overlay_quantum" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "overlay_quantum" TO CVAL
    MOVE 1030 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "simulator_performance_engineer" OR FUNCTION TRIM(FOCUS) = "simulator-performance-engineer"
    MOVE "simulator_performance_engineer" TO FAM
    MOVE "fallback.overlay_quantum" TO REND
    MOVE "fallback-overlay_quantum" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "overlay_quantum" TO CVAL
    MOVE 1031 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "fhir_profile_generator" OR FUNCTION TRIM(FOCUS) = "fhir-profile-generator"
    MOVE "fhir_profile_generator" TO FAM
    MOVE "fallback.health_protocol" TO REND
    MOVE "fallback-health_protocol" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "health_protocol" TO CVAL
    MOVE 1032 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "smart_launch_oauth" OR FUNCTION TRIM(FOCUS) = "smart-launch-oauth"
    MOVE "smart_launch_oauth" TO FAM
    MOVE "fallback.health_protocol" TO REND
    MOVE "fallback-health_protocol" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "health_protocol" TO CVAL
    MOVE 1033 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "bulk_fhir_population_ops" OR FUNCTION TRIM(FOCUS) = "bulk-fhir-population-ops"
    MOVE "bulk_fhir_population_ops" TO FAM
    MOVE "fallback.health_protocol" TO REND
    MOVE "fallback-health_protocol" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "health_protocol" TO CVAL
    MOVE 1034 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "hl7v2_feed_ops" OR FUNCTION TRIM(FOCUS) = "hl7v2-feed-ops"
    MOVE "hl7v2_feed_ops" TO FAM
    MOVE "fallback.health_protocol" TO REND
    MOVE "fallback-health_protocol" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "health_protocol" TO CVAL
    MOVE 1035 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "clinical_workflow_events" OR FUNCTION TRIM(FOCUS) = "clinical-workflow-events"
    MOVE "clinical_workflow_events" TO FAM
    MOVE "fallback.health_protocol" TO REND
    MOVE "fallback-health_protocol" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "health_protocol" TO CVAL
    MOVE 1036 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "dicomweb_imaging_ops" OR FUNCTION TRIM(FOCUS) = "dicomweb-imaging-ops"
    MOVE "dicomweb_imaging_ops" TO FAM
    MOVE "fallback.health_protocol" TO REND
    MOVE "fallback-health_protocol" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "health_protocol" TO CVAL
    MOVE 1037 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "openehr_semantic_record_ops" OR FUNCTION TRIM(FOCUS) = "openehr-semantic-record-ops"
    MOVE "openehr_semantic_record_ops" TO FAM
    MOVE "fallback.health_protocol" TO REND
    MOVE "fallback-health_protocol" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "health_protocol" TO CVAL
    MOVE 1038 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "device_telemetry_clinical" OR FUNCTION TRIM(FOCUS) = "device-telemetry-clinical"
    MOVE "device_telemetry_clinical" TO FAM
    MOVE "fallback.health_protocol" TO REND
    MOVE "fallback-health_protocol" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "health_protocol" TO CVAL
    MOVE 1039 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "emr_vendor_adapter" OR FUNCTION TRIM(FOCUS) = "emr-vendor-adapter"
    MOVE "emr_vendor_adapter" TO FAM
    MOVE "fallback.health_protocol" TO REND
    MOVE "fallback-health_protocol" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "health_protocol" TO CVAL
    MOVE 1040 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "ocpp_chargepoint_ops" OR FUNCTION TRIM(FOCUS) = "ocpp-chargepoint-ops"
    MOVE "ocpp_chargepoint_ops" TO FAM
    MOVE "fallback.health_protocol" TO REND
    MOVE "fallback-health_protocol" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "health_protocol" TO CVAL
    MOVE 1041 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "ocpi_roaming_ops" OR FUNCTION TRIM(FOCUS) = "ocpi-roaming-ops"
    MOVE "ocpi_roaming_ops" TO FAM
    MOVE "fallback.health_protocol" TO REND
    MOVE "fallback-health_protocol" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "health_protocol" TO CVAL
    MOVE 1042 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "mcp_a2a_ops" OR FUNCTION TRIM(FOCUS) = "mcp-a2a-ops"
    MOVE "mcp_a2a_ops" TO FAM
    MOVE "fallback.health_protocol" TO REND
    MOVE "fallback-health_protocol" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "health_protocol" TO CVAL
    MOVE 1043 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "streaming_bus_ops" OR FUNCTION TRIM(FOCUS) = "streaming-bus-ops"
    MOVE "streaming_bus_ops" TO FAM
    MOVE "fallback.health_protocol" TO REND
    MOVE "fallback-health_protocol" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "health_protocol" TO CVAL
    MOVE 1044 TO IDX
  END-IF
  IF FUNCTION TRIM(FOCUS) = "service_mesh_rpc_ops" OR FUNCTION TRIM(FOCUS) = "service-mesh-rpc-ops"
    MOVE "service_mesh_rpc_ops" TO FAM
    MOVE "fallback.health_protocol" TO REND
    MOVE "fallback-health_protocol" TO TRANCHE
    MOVE "fallbackFamily" TO CKEY
    MOVE "health_protocol" TO CVAL
    MOVE 1045 TO IDX
  END-IF
  EXIT.

PRINT-JSON.
  DISPLAY '{"eventType":"stakeholder.generator.output","sequence":' WITH NO ADVANCING
  DISPLAY IDX WITH NO ADVANCING
  DISPLAY ',"family":"' WITH NO ADVANCING
  DISPLAY FUNCTION TRIM(FAM) WITH NO ADVANCING
  DISPLAY '","message":"Deterministic cobol tranche for ' WITH NO ADVANCING
  DISPLAY FUNCTION TRIM(FAM) WITH NO ADVANCING
  DISPLAY '","timestamp":"2026-01-01T00:00:00Z","context":{"rendererKey":"' WITH NO ADVANCING
  DISPLAY FUNCTION TRIM(REND) WITH NO ADVANCING
  DISPLAY '","' WITH NO ADVANCING
  DISPLAY FUNCTION TRIM(CKEY) WITH NO ADVANCING
  DISPLAY '":"' WITH NO ADVANCING
  DISPLAY FUNCTION TRIM(CVAL) WITH NO ADVANCING
  DISPLAY '","seedFingerprint":"' WITH NO ADVANCING
  DISPLAY FUNCTION TRIM(FAM) WITH NO ADVANCING
  DISPLAY '-cobol","tranche":"' WITH NO ADVANCING
  DISPLAY FUNCTION TRIM(TRANCHE) WITH NO ADVANCING
  DISPLAY '","cobolProfile":"gnucobol-compiled-table"},"generationProvenance":{"sourceRepo":"cobol-stakeholder","baseline":"local-small-tranche-family-focus","experimental":false,"adapterType":"static-table-catalog","promptVersion":null},"outputFormat":"json"}'
  EXIT.

PRINT-TEXT.
  DISPLAY "family: " FUNCTION TRIM(FAM)
  DISPLAY "renderer: " FUNCTION TRIM(REND)
  DISPLAY "tranche: " FUNCTION TRIM(TRANCHE)
  DISPLAY "sequence: " IDX
  DISPLAY "timestamp: 2026-01-01T00:00:00Z"
  DISPLAY "message: Deterministic cobol tranche for " FUNCTION TRIM(FAM)
  EXIT.

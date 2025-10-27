Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0AE30C626
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579267; cv=none; b=o+CCNXaI0kCjlfUIwRAfL3Rpxek3R4LF401e5s2usR4BObiWEotc/fK4kws1pDmzWbWZNi+lAYFWNsYnHngJ0TRBP+NaS5SEEpf24RIvZdL43KDuPu1zyB7xY1tKBBFz4pFmeFTbWctWCGqTgPmaOBFWER2VvAzF2JDPtWZANYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579267; c=relaxed/simple;
	bh=DrtTcPaaONlvitINNzOtl7+O4J1J7ACmIWmosPpDBoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HwMS7YUjsjvSBmGZKWRoyYGeoega8fmdnO0f8z/k/YzAqzSevExveen0zoudGgyQgwhSoQITvxbaqFEInjp4b+ygO3GhvzgETTRsjCv0zJglabx3iqKK0SGKE9n26YWRK+X1oO9Bi/OWfQVk6pKcV+sr201tlB5MDBvX3ycVVjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FpcqSJAA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FpcqSJAA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761579263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qn9DAbDJZJluNE63oWsS31K29+gHzG8u9dg7ZIjAzuc=;
	b=FpcqSJAApBN5YkQzCZBGMF19e9KZcZmX3qgZwv/LwhW795n7/daioNNHjgAkCLx8EDsy5E
	RHil6UU4pW0Hfi+f0eUo9eI5EDrI3DnpeVXXPCP64SCfhtBdTi5Rqj40YAG3mXQYCxUiGU
	ODaoYITcFXNDyBBp5NzF2uO5v4QUKhc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-ZCuYrMX4OZuAiwV1GG7Yfg-1; Mon,
 27 Oct 2025 11:34:19 -0400
X-MC-Unique: ZCuYrMX4OZuAiwV1GG7Yfg-1
X-Mimecast-MFC-AGG-ID: ZCuYrMX4OZuAiwV1GG7Yfg_1761579258
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 983421800D88;
	Mon, 27 Oct 2025 15:34:18 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7EE6319540EB;
	Mon, 27 Oct 2025 15:34:15 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v3 2/7] rtla/timerlat: Add --bpf-action option
Date: Mon, 27 Oct 2025 16:33:56 +0100
Message-ID: <20251027153401.1039217-3-tglozar@redhat.com>
In-Reply-To: <20251027153401.1039217-1-tglozar@redhat.com>
References: <20251027153401.1039217-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add option --bpf-action that allows the user to attach an external BPF
program that will be executed via BPF tail call on latency threshold
overflow.

Executing additional BPF code on latency threshold overflow allows doing
doing low-latency and in-kernel troubleshooting of the cause of the
overflow.

The option takes an argument, which is a path to a BPF ELF file
expected to contain a function named "action_handler" in a section named
"tp/timerlat_action" (the section is necessary for libbpf to assign the
correct BPF program type to it).

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat.c      | 11 ++++++
 tools/tracing/rtla/src/timerlat.h      |  2 +-
 tools/tracing/rtla/src/timerlat_bpf.c  | 53 ++++++++++++++++++++++++++
 tools/tracing/rtla/src/timerlat_bpf.h  |  6 ++-
 tools/tracing/rtla/src/timerlat_hist.c |  5 +++
 tools/tracing/rtla/src/timerlat_top.c  |  5 +++
 6 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index b69212874127..6907a323f9ec 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -48,6 +48,17 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 		}
 	}
 
+	/* Check if BPF action program is requested but BPF is not available */
+	if (params->bpf_action_program) {
+		if (params->mode == TRACING_MODE_TRACEFS) {
+			err_msg("BPF actions are not supported in tracefs-only mode\n");
+			goto out_err;
+		}
+
+		if (timerlat_load_bpf_action_program(params->bpf_action_program))
+			goto out_err;
+	}
+
 	if (params->mode != TRACING_MODE_BPF) {
 		/*
 		 * In tracefs and mixed mode, timerlat tracer handles stopping
diff --git a/tools/tracing/rtla/src/timerlat.h b/tools/tracing/rtla/src/timerlat.h
index fd6065f48bb7..8dd5d134ce08 100644
--- a/tools/tracing/rtla/src/timerlat.h
+++ b/tools/tracing/rtla/src/timerlat.h
@@ -27,6 +27,7 @@ struct timerlat_params {
 	int			dump_tasks;
 	int			deepest_idle_state;
 	enum timerlat_tracing_mode mode;
+	const char		*bpf_action_program;
 };
 
 #define to_timerlat_params(ptr) container_of(ptr, struct timerlat_params, common)
@@ -36,4 +37,3 @@ int timerlat_main(int argc, char *argv[]);
 int timerlat_enable(struct osnoise_tool *tool);
 void timerlat_analyze(struct osnoise_tool *tool, bool stopped);
 void timerlat_free(struct osnoise_tool *tool);
-
diff --git a/tools/tracing/rtla/src/timerlat_bpf.c b/tools/tracing/rtla/src/timerlat_bpf.c
index 1d619e502c65..05adf18303df 100644
--- a/tools/tracing/rtla/src/timerlat_bpf.c
+++ b/tools/tracing/rtla/src/timerlat_bpf.c
@@ -7,6 +7,10 @@
 
 static struct timerlat_bpf *bpf;
 
+/* BPF object and program for action program */
+static struct bpf_object *obj;
+static struct bpf_program *prog;
+
 /*
  * timerlat_bpf_init - load and initialize BPF program to collect timerlat data
  */
@@ -96,6 +100,11 @@ void timerlat_bpf_detach(void)
 void timerlat_bpf_destroy(void)
 {
 	timerlat_bpf__destroy(bpf);
+	bpf = NULL;
+	if (obj)
+		bpf_object__close(obj);
+	obj = NULL;
+	prog = NULL;
 }
 
 static int handle_rb_event(void *ctx, void *data, size_t data_sz)
@@ -190,4 +199,48 @@ int timerlat_bpf_get_summary_value(enum summary_field key,
 			 bpf->maps.summary_user,
 			 key, value_irq, value_thread, value_user, cpus);
 }
+
+/*
+ * timerlat_load_bpf_action_program - load and register a BPF action program
+ */
+int timerlat_load_bpf_action_program(const char *program_path)
+{
+	int err;
+
+	obj = bpf_object__open_file(program_path, NULL);
+	if (!obj) {
+		err_msg("Failed to open BPF action program: %s\n", program_path);
+		goto out_err;
+	}
+
+	err = bpf_object__load(obj);
+	if (err) {
+		err_msg("Failed to load BPF action program: %s\n", program_path);
+		goto out_obj_err;
+	}
+
+	prog = bpf_object__find_program_by_name(obj, "action_handler");
+	if (!prog) {
+		err_msg("BPF action program must have 'action_handler' function: %s\n",
+			program_path);
+		goto out_obj_err;
+	}
+
+	err = timerlat_bpf_set_action(prog);
+	if (err) {
+		err_msg("Failed to register BPF action program: %s\n", program_path);
+		goto out_prog_err;
+	}
+
+	return 0;
+
+out_prog_err:
+	prog = NULL;
+out_obj_err:
+	bpf_object__close(obj);
+	obj = NULL;
+out_err:
+	return 1;
+}
+
 #endif /* HAVE_BPF_SKEL */
diff --git a/tools/tracing/rtla/src/timerlat_bpf.h b/tools/tracing/rtla/src/timerlat_bpf.h
index b5009092c7a3..169abeaf4363 100644
--- a/tools/tracing/rtla/src/timerlat_bpf.h
+++ b/tools/tracing/rtla/src/timerlat_bpf.h
@@ -30,7 +30,7 @@ int timerlat_bpf_get_summary_value(enum summary_field key,
 				   long long *value_thread,
 				   long long *value_user,
 				   int cpus);
-
+int timerlat_load_bpf_action_program(const char *program_path);
 static inline int have_libbpf_support(void) { return 1; }
 #else
 static inline int timerlat_bpf_init(struct timerlat_params *params)
@@ -58,6 +58,10 @@ static inline int timerlat_bpf_get_summary_value(enum summary_field key,
 {
 	return -1;
 }
+static inline int timerlat_load_bpf_action_program(const char *program_path)
+{
+	return -1;
+}
 static inline int have_libbpf_support(void) { return 0; }
 #endif /* HAVE_BPF_SKEL */
 #endif /* __bpf__ */
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 606c1688057b..5e639cc34f64 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -763,6 +763,7 @@ static void timerlat_hist_usage(char *usage)
 		"	     --deepest-idle-state n: only go down to idle state n on cpus used by timerlat to reduce exit from idle latency",
 		"	     --on-threshold <action>: define action to be executed at latency threshold, multiple are allowed",
 		"	     --on-end <action>: define action to be executed at measurement end, multiple are allowed",
+		"	     --bpf-action <program>: load and execute BPF program when latency threshold is exceeded",
 		NULL,
 	};
 
@@ -853,6 +854,7 @@ static struct common_params
 			{"deepest-idle-state",	required_argument,	0, '\4'},
 			{"on-threshold",	required_argument,	0, '\5'},
 			{"on-end",		required_argument,	0, '\6'},
+			{"bpf-action",		required_argument,	0, '\7'},
 			{0, 0, 0, 0}
 		};
 
@@ -1062,6 +1064,9 @@ static struct common_params
 				exit(EXIT_FAILURE);
 			}
 			break;
+		case '\7':
+			params->bpf_action_program = optarg;
+			break;
 		default:
 			timerlat_hist_usage("Invalid option");
 		}
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index fc479a0dcb59..da5d5db1bc17 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -521,6 +521,7 @@ static void timerlat_top_usage(char *usage)
 		"	     --deepest-idle-state n: only go down to idle state n on cpus used by timerlat to reduce exit from idle latency",
 		"	     --on-threshold <action>: define action to be executed at latency threshold, multiple are allowed",
 		"	     --on-end: define action to be executed at measurement end, multiple are allowed",
+		"	     --bpf-action <program>: load and execute BPF program when latency threshold is exceeded",
 		NULL,
 	};
 
@@ -603,6 +604,7 @@ static struct common_params
 			{"deepest-idle-state",	required_argument,	0, '8'},
 			{"on-threshold",	required_argument,	0, '9'},
 			{"on-end",		required_argument,	0, '\1'},
+			{"bpf-action",		required_argument,	0, '\2'},
 			{0, 0, 0, 0}
 		};
 
@@ -798,6 +800,9 @@ static struct common_params
 				exit(EXIT_FAILURE);
 			}
 			break;
+		case '\2':
+			params->bpf_action_program = optarg;
+			break;
 		default:
 			timerlat_top_usage("Invalid option");
 		}
-- 
2.51.0


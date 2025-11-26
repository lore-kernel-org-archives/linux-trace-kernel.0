Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1064E3043B5
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 14:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168154; cv=none; b=p5s0ZqpYdsXeNB26YPaOfkdXZDh+94jxWBm5jmYTMQpBf9OVFhb12SBSSevJIdYP+TyIbedG/59KrU50Gp18jgVGdK1FLfndspcxobM6F9/mwLvBwp7r12+UBbG40suA15c+sVTaB475q9yKxr5bog+oT4SaS77p/bawplXpqmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168154; c=relaxed/simple;
	bh=t7/GlfB5RjmxI0Eh9DvXg/5lltUD0Z85NktjdO7C3j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rojQFppYU5P5WLeMdfIQHQTWurKW34jUzYraOCXxhYn5YX3OgxOzRMwTYHh3mUWa8GRbW6ZZG7RZ8PbZW6+xPuo5hg4yi8f49IBt6Aax6ruKh0/OJwF0pnN1LBnKWTy/GtCe5+AwhJZ/IokpuL0w7gcDtM8ddQ7biJtqjnQkMSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J+8BL9ey; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+8BL9ey"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764168152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vox3Hvn7Vbza5K8BeWQiNTOH0yOX/HWBB67A574ATkk=;
	b=J+8BL9eyl3UXkh9Gd61mUDG3Fqlxw4k46/uEz2+2WcoTINo4Gp+RsX41PsDFr03gGkZjCo
	zyPyymWtJ3vKdZUnbmFkogy3YUFZynGQ7k81Q4tfoGIMruzZbaI+LP2nc+01HbL7qwF0G6
	JnKLYBNqo9AlH4D20cdxguV673t+Qtw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-J7FLAN53Ptms8oFNKcXWlQ-1; Wed,
 26 Nov 2025 09:42:28 -0500
X-MC-Unique: J7FLAN53Ptms8oFNKcXWlQ-1
X-Mimecast-MFC-AGG-ID: J7FLAN53Ptms8oFNKcXWlQ_1764168147
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAF4319541AF;
	Wed, 26 Nov 2025 14:42:27 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.33.141])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C1E7030044E0;
	Wed, 26 Nov 2025 14:42:24 +0000 (UTC)
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
Subject: [PATCH v4 2/7] rtla/timerlat: Add --bpf-action option
Date: Wed, 26 Nov 2025 15:42:00 +0100
Message-ID: <20251126144205.331954-3-tglozar@redhat.com>
In-Reply-To: <20251126144205.331954-1-tglozar@redhat.com>
References: <20251126144205.331954-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add option --bpf-action that allows the user to attach an external BPF
program that will be executed via BPF tail call on latency threshold
overflow.

Executing additional BPF code on latency threshold overflow allows doing
low-latency and in-kernel troubleshooting of the cause of the overflow.

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
index df4f9bfe3433..991136fffe6b 100644
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
index 1fb471a787b7..9d5f1f2a07c7 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -747,6 +747,7 @@ static void timerlat_hist_usage(void)
 		"	     --deepest-idle-state n: only go down to idle state n on cpus used by timerlat to reduce exit from idle latency",
 		"	     --on-threshold <action>: define action to be executed at latency threshold, multiple are allowed",
 		"	     --on-end <action>: define action to be executed at measurement end, multiple are allowed",
+		"	     --bpf-action <program>: load and execute BPF program when latency threshold is exceeded",
 		NULL,
 	};
 
@@ -831,6 +832,7 @@ static struct common_params
 			{"deepest-idle-state",	required_argument,	0, '\4'},
 			{"on-threshold",	required_argument,	0, '\5'},
 			{"on-end",		required_argument,	0, '\6'},
+			{"bpf-action",		required_argument,	0, '\7'},
 			{0, 0, 0, 0}
 		};
 
@@ -1012,6 +1014,9 @@ static struct common_params
 			if (retval)
 				fatal("Invalid action %s", optarg);
 			break;
+		case '\7':
+			params->bpf_action_program = optarg;
+			break;
 		default:
 			fatal("Invalid option");
 		}
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 29c2c1f717ed..ad5eb7cfff93 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -519,6 +519,7 @@ static void timerlat_top_usage(void)
 		"	     --deepest-idle-state n: only go down to idle state n on cpus used by timerlat to reduce exit from idle latency",
 		"	     --on-threshold <action>: define action to be executed at latency threshold, multiple are allowed",
 		"	     --on-end: define action to be executed at measurement end, multiple are allowed",
+		"	     --bpf-action <program>: load and execute BPF program when latency threshold is exceeded",
 		NULL,
 	};
 
@@ -595,6 +596,7 @@ static struct common_params
 			{"deepest-idle-state",	required_argument,	0, '8'},
 			{"on-threshold",	required_argument,	0, '9'},
 			{"on-end",		required_argument,	0, '\1'},
+			{"bpf-action",		required_argument,	0, '\2'},
 			{0, 0, 0, 0}
 		};
 
@@ -762,6 +764,9 @@ static struct common_params
 			if (retval)
 				fatal("Invalid action %s", optarg);
 			break;
+		case '\2':
+			params->bpf_action_program = optarg;
+			break;
 		default:
 			fatal("Invalid option");
 		}
-- 
2.51.1


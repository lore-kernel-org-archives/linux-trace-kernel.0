Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDCD522EF5
	for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Sep 2026 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790692220; cv=none; b=pp4jy+RrbGhFpKvmaJO6uscwx/NKqhgMx3H2Xr5vkdgeFpzghao8K5aK+POHvSzNiz8Jv/4Rlk/mwXGiFQ8TQuOKsRLpyEk3n4IcpmmvgRmrpa9o0nPlrW/+iT/q47VtEA91xukA2NxFYMzeAKHtLVqiaCTdM8ruxnyap5956DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790692220; c=relaxed/simple;
	bh=iL8mcZM73RHoFsetlCp5yFYyL2h2o3aQRLlnTK20otY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=GBghczYWyrc7k6HL105yfbSc9RTjxWwcpvDDfHcV3yR3JhTz6XQVi7TQGIu4Zd8Xn8Jdh80kqaUcIfHcUhCjop4Yv72zePabsoVEAZ1uqzIwERns3rsVRIckUaA9Z3p45QGEp3eqpF3wd1yIFYlBrlv+BT7ZWeqoTmp/zWUt6qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M9jHEp8Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M9jHEp8Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790692206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Haq3s0dsah0OIhrsyGaC9Jn0YhAlyB7yNu/590OYPNI=;
	b=M9jHEp8Y4omYb7qbJTXokBgyDmUcsCPJku1Rbxi9PJNmhY6u07JKrHgwzeSu/CqO+n5u48
	9SyxtjTygcG+VccGXUvJSVsFC0Cxl1lQDAGbpwyop+3W1I8Sfz/3+b5bBwmmu2NqB+OmU4
	rchfTRsSbdHhMAiva+K5+YicwEAe2IE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-zbTK4scbNl-OMpwJD7BhgA-1; Tue,
 29 Sep 2026 10:30:03 -0400
X-MC-Unique: zbTK4scbNl-OMpwJD7BhgA-1
X-Mimecast-MFC-AGG-ID: zbTK4scbNl-OMpwJD7BhgA_1790692201
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EFC9619792EA;
	Tue, 29 Sep 2026 14:30:00 +0000 (UTC)
Received: from tglozar-thinkpadt14gen5.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 258591800576;
	Tue, 29 Sep 2026 14:29:57 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH v4] rtla: Simplify osnoise tracer option setting code
Date: Tue, 29 Sep 2026 16:29:44 +0200
Message-ID: <20260929142944.1841462-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: w4iNR5cUQgh5copg4bcgm31nfiJDHi0gcHcO3vFpLfY_1790692201
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Each osnoise tracer option (in /sys/kernel/tracing/osnoise) used by RTLA
requires four functions to be defined:

- static osnoise_get_<opt>() - to get the current value of the option
  and save it into struct osnoise_context's orig_<opt> field,
- osnoise_set_<opt>() - to set the value of the option requested by the
  user after reading and saving the original with osnoise_get_<opt>(),
  and save it into <opt> field of struct osnoise_context,
- osnoise_restore_<opt>() - restore the value recorded in orig_<opt>,
- static osnoise_put_<opt>() - restore the value recorded in orig_<opt>
  and update <opt> to reflect that.

The logic is duplicated for all the options, except for cpus (which is
the only string option) and period/runtime (which are handled together
and feature extra checks).

Deduplicate by moving the common code in get/set/restore/put into common
helper functions local to osnoise.c. The original set/restore/put
functions are reduced to wrappers generated using a set of X macros:

- OSNOISE_LL_OPTIONS, which invokes the OSNOISE_LL_OPTION macro for all
  "long long" options,
- OSNOISE_FLAG_OPTIONS, which invokes the OSNOISE_FLAG_OPTION macro for
  all flag options (boolean values in osnoise/options file).

Those are also used to auto-generate the corresponding fields in struct
osnoise_context, plus initialization and restoration code for them.

There are a few minor changes in the refactored code:

- osnoise_set_<opt>() now distinguishes between -2 (option cannot be
  set) and -1 (option not present in kernel) for all options.
- OSNOISE_OPTION_INIT_VAL and OSNOISE_TIME_INIT_VAL are removed and
  replaced with a plain -1; all unsigned long long fields are changed to
  signed long long, consistent with pre-existing "%lld" format string in
  osnoise_write_ll_config().
- osnoise_restore_<opt>() now correctly resets the <opt> field (not
  orig_<opt>) for all options.

The change is intended to simplify adding and modifying tracer options.
It also makes the code shorter by a bit over 500 lines.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
v3: https://lore.kernel.org/linux-trace-kernel/20260904085500.488905-1-tglozar@redhat.com/

v4 changes:
- Rebase on top of patchset "rtla: Implement more robust nr_cpus handling" [1]
[1] https://lore.kernel.org/linux-trace-kernel/20260814135511.2207190-1-tglozar@redhat.com/T/#u

v2: https://lore.kernel.org/linux-trace-kernel/20260708083017.162824-1-tglozar@redhat.com/

v3 changes:
- Rename second argument of osnoise_set_##name() for long long options from
  "name" to "value" to mirror "onoff" in the same function pattern for boolean
  options. 

v1: https://lore.kernel.org/linux-trace-kernel/20260612115121.54862-1-tglozar@redhat.com/T

v2 changes (mostly suggestions from Crystal Wood):
- Reduce code inside macros by moving as much code as possible into helper
  functions (new or existing) that take the struct field pointers as arguments.
- Remove "get" functions from the macro, as they are no longer used anywhere.
- Replace OSNOISE_OPTION_INIT_VAL and OSNOISE_TIME_INIT_VAL with a unified -1
  value for "unset" (values > INT64_MAX never worked anyway, as
  osnoise_write_ll_config() always used "%lld" to format the value).
- Add detailed comments to the helper functions, as one of the issues of the
  code was the logic being hard to understand.
- Move some details about the macros from the commit message into a comment.

 tools/tracing/rtla/src/common.h  |   96 +--
 tools/tracing/rtla/src/osnoise.c | 1079 +++++++++---------------------
 tools/tracing/rtla/src/osnoise.h |   34 +-
 3 files changed, 374 insertions(+), 835 deletions(-)

diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
index 9bc3c2c47aacd..ec2f6f86ec3a0 100644
--- a/tools/tracing/rtla/src/common.h
+++ b/tools/tracing/rtla/src/common.h
@@ -6,9 +6,42 @@
 #include "trace.h"
 #include "utils.h"
 
+/*
+ * OSNOISE_LL_OPTIONS - list of long long options backed by tracefs files.
+ *   OSNOISE_LL_OPTION(field_name, tracefs_path)
+ *
+ * OSNOISE_FLAG_OPTIONS - list of boolean options backed by osnoise/options.
+ *   OSNOISE_FLAG_OPTION(field_name, option_string)
+ *
+ * These X-macro lists are invoked in four places:
+ *  - struct osnoise_context field declarations (common.h),
+ *  - function declarations for osnoise_set_<opt>/osnoise_restore_<opt> (common.h),
+ *  - function definitions for set/restore/put (osnoise.c),
+ *  - context initialization and teardown in osnoise_context_alloc() and
+ *    osnoise_put_context() (osnoise.c).
+ */
+#define OSNOISE_LL_OPTIONS \
+	OSNOISE_LL_OPTION(stop_us,		"osnoise/stop_tracing_us")		\
+	OSNOISE_LL_OPTION(stop_total_us,	"osnoise/stop_tracing_total_us")	\
+	OSNOISE_LL_OPTION(print_stack,		"osnoise/print_stack")			\
+	OSNOISE_LL_OPTION(tracing_thresh,	"tracing_thresh")			\
+	OSNOISE_LL_OPTION(timerlat_period_us,	"osnoise/timerlat_period_us")		\
+	OSNOISE_LL_OPTION(timerlat_align_us,	"osnoise/timerlat_align_us")
+
+#define OSNOISE_FLAG_OPTIONS \
+	OSNOISE_FLAG_OPTION(irq_disable,	"OSNOISE_IRQ_DISABLE")	\
+	OSNOISE_FLAG_OPTION(workload,		"OSNOISE_WORKLOAD")	\
+	OSNOISE_FLAG_OPTION(timerlat_align,	"TIMERLAT_ALIGN")
+
 /*
  * osnoise_context - read, store, write, restore osnoise configs.
  */
+#define OSNOISE_LL_OPTION(name, path)			\
+	long long		orig_##name;		\
+	long long		name;
+#define OSNOISE_FLAG_OPTION(name, option_str)		\
+	int			orig_opt_##name;	\
+	int			opt_##name;
 struct osnoise_context {
 	int			flags;
 	int			ref;
@@ -16,50 +49,17 @@ struct osnoise_context {
 	char			*curr_cpus;
 	char			*orig_cpus;
 
-	/* 0 as init value */
-	unsigned long long	orig_runtime_us;
-	unsigned long long	runtime_us;
-
-	/* 0 as init value */
-	unsigned long long	orig_period_us;
-	unsigned long long	period_us;
-
-	/* 0 as init value */
-	long long		orig_timerlat_period_us;
-	long long		timerlat_period_us;
-
-	/* 0 as init value */
-	long long		orig_tracing_thresh;
-	long long		tracing_thresh;
-
-	/* -1 as init value because 0 is disabled */
-	long long		orig_stop_us;
-	long long		stop_us;
-
-	/* -1 as init value because 0 is disabled */
-	long long		orig_stop_total_us;
-	long long		stop_total_us;
-
-	/* -1 as init value because 0 is disabled */
-	long long		orig_print_stack;
-	long long		print_stack;
-
-	/* -1 as init value because 0 is off */
-	int			orig_opt_irq_disable;
-	int			opt_irq_disable;
-
-	/* -1 as init value because 0 is off */
-	int			orig_opt_workload;
-	int			opt_workload;
+	long long		orig_runtime_us;
+	long long		runtime_us;
 
-	/* -1 as init value because 0 is off */
-	int			orig_opt_timerlat_align;
-	int			opt_timerlat_align;
+	long long		orig_period_us;
+	long long		period_us;
 
-	/* 0 as init value */
-	unsigned long long	orig_timerlat_align_us;
-	unsigned long long	timerlat_align_us;
+	OSNOISE_LL_OPTIONS
+	OSNOISE_FLAG_OPTIONS
 };
+#undef OSNOISE_LL_OPTION
+#undef OSNOISE_FLAG_OPTION
 
 extern volatile int stop_tracing;
 
@@ -173,15 +173,21 @@ int osnoise_get_cpu_count(void);
 int osnoise_set_cpus(struct osnoise_context *context, char *cpus);
 void osnoise_restore_cpus(struct osnoise_context *context);
 
-int osnoise_set_workload(struct osnoise_context *context, bool onoff);
+#define OSNOISE_LL_OPTION(name, path)							\
+	int osnoise_set_##name(struct osnoise_context *context, long long name);	\
+	void osnoise_restore_##name(struct osnoise_context *context);
+#define OSNOISE_FLAG_OPTION(name, option_str)					\
+	int osnoise_set_##name(struct osnoise_context *context, bool onoff);	\
+	void osnoise_restore_##name(struct osnoise_context *context);
+OSNOISE_LL_OPTIONS
+OSNOISE_FLAG_OPTIONS
+#undef OSNOISE_LL_OPTION
+#undef OSNOISE_FLAG_OPTION
 
 void osnoise_destroy_tool(struct osnoise_tool *top);
 struct osnoise_tool *osnoise_init_tool(char *tool_name);
 struct osnoise_tool *osnoise_init_trace_tool(struct common_params *params, const char *tracer);
 bool osnoise_trace_is_off(struct osnoise_tool *tool, struct osnoise_tool *record);
-int osnoise_set_stop_us(struct osnoise_context *context, long long stop_us);
-int osnoise_set_stop_total_us(struct osnoise_context *context,
-			      long long stop_total_us);
 
 int common_apply_config(struct osnoise_tool *tool, struct common_params *params);
 int top_main_loop(struct osnoise_tool *tool);
diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index 9d9828b7692a7..19b22a65fe72c 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -168,16 +168,40 @@ int osnoise_get_cpu_count(void)
 	return max_cpu + 1;
 }
 
-/*
- * osnoise_read_ll_config - read a long long value from a config
+/**
+ * osnoise_read_ll_config - read a long long value from a tracefs config
+ * @rel_path: tracefs-relative path to the config file
+ * @set_value: pointer to the cached value set by RTLA, or -1 if unset
+ * @orig_value: pointer to the cached original value read from tracefs, or -1 if unread
+ *
+ * Returns the current effective value for the config at @rel_path. If RTLA has
+ * already written a value (@set_value != -1), that value is returned. If the
+ * original has already been read (@orig_value != -1), that cached value is
+ * returned. Otherwise, reads the value from tracefs, caches it in @orig_value
+ * (so it can later be restored), and returns it.
  *
- * returns -1 on error.
+ * This is the shared read primitive used by both the manually implemented
+ * get functions (osnoise_get_runtime, osnoise_get_period) and the
+ * OSNOISE_LL_OPTION-generated set/restore/put functions.
+ *
+ * Returns the config value on success, -1 on error.
  */
-static long long osnoise_read_ll_config(char *rel_path)
+static long long osnoise_read_ll_config(char *rel_path,
+					long long *set_value,
+					long long *orig_value)
 {
 	long long retval;
 	char *buffer;
 
+	if (*set_value != -1)
+		/* option has been set by RTLA already */
+		return *set_value;
+
+	if (*orig_value != -1)
+		/* RTLA has already read the option */
+		return *orig_value;
+
+	/* current value is not known to RTLA yet, read it from tracefs */
 	buffer = tracefs_instance_file_read(NULL, rel_path, NULL);
 	if (!buffer)
 		return -1;
@@ -189,51 +213,110 @@ static long long osnoise_read_ll_config(char *rel_path)
 
 	free(buffer);
 
+	if (retval < 0)
+		goto out_err;
+
+	/* save the value and return it */
+	*orig_value = retval;
 	return retval;
+
+out_err:
+	return -1;
 }
 
-/*
- * osnoise_write_ll_config - write a long long value to a config in rel_path
+/**
+ * osnoise_write_ll_config - write a long long value to a tracefs config
+ * @rel_path: tracefs-relative path to the config file
+ * @value: the value to write
+ * @set_value: pointer to the cached value set by RTLA, or -1 if unset
+ * @orig_value: pointer to the cached original value read from tracefs, or -1 if unread
  *
- * returns -1 on error.
+ * Writes @value to the config at @rel_path. Before writing, calls
+ * osnoise_read_ll_config() to ensure the original value is cached in
+ * @orig_value (enabling later restoration). On successful write, records
+ * the new value in @set_value.
+ *
+ * This is the shared write primitive used by both the manually implemented
+ * write functions (__osnoise_write_runtime, __osnoise_write_period) and the
+ * OSNOISE_LL_OPTION-generated set/restore/put functions.
+ *
+ * Returns 0 on success, -1 on read error (option likely unknown to kernel),
+ * or -2 on write error.
  */
-static long long osnoise_write_ll_config(char *rel_path, long long value)
+static int osnoise_write_ll_config(char *rel_path,
+				   long long value,
+				   long long *set_value,
+				   long long *orig_value)
 {
-	char buffer[BUFF_U64_STR_SIZE];
+	long long curr = osnoise_read_ll_config(rel_path, set_value, orig_value);
 	long long retval;
+	char buffer[BUFF_U64_STR_SIZE];
+
+	if (curr == -1)
+		/* read failed, option likely unknown to kernel */
+		return -1;
 
 	snprintf(buffer, sizeof(buffer), "%lld\n", value);
 
 	debug_msg("setting %s to %lld\n", rel_path, value);
 
 	retval = tracefs_instance_file_write(NULL, rel_path, buffer);
-	return retval;
+
+	if (retval < 0)
+		/* write failed, hard error */
+		return -2;
+
+	/* record the set value and return success */
+	*set_value = value;
+	return 0;
 }
 
-/*
- * osnoise_get_runtime - return the original "osnoise/runtime_us" value
+/**
+ * osnoise_restore_ll_config - restore a long long config to its original value
+ * @rel_path: tracefs-relative path to the config file
+ * @set_value: pointer to the cached value set by RTLA, or -1 if unset
+ * @orig_value: pointer to the cached original value read from tracefs, or -1 if unread
  *
- * It also saves the value to be restored.
+ * Restores the config at @rel_path to the value cached in @orig_value (which
+ * was saved by a prior osnoise_read_ll_config() or osnoise_write_ll_config()
+ * call). If the original was never read, or if the current set value already
+ * matches the original, no write is performed. After restoring, clears
+ * @set_value to -1 to indicate RTLA no longer overrides this config.
+ *
+ * This is the shared restore primitive used by both the manually implemented
+ * restore function (osnoise_restore_runtime_period) and the
+ * OSNOISE_LL_OPTION-generated restore/put functions.
  */
-unsigned long long osnoise_get_runtime(struct osnoise_context *context)
+static void osnoise_restore_ll_config(char *rel_path,
+				      long long *set_value,
+				      long long *orig_value)
 {
-	long long runtime_us;
+	int retval;
 
-	if (context->runtime_us != OSNOISE_TIME_INIT_VAL)
-		return context->runtime_us;
+	if (*orig_value == -1)
+		return;
 
-	if (context->orig_runtime_us != OSNOISE_TIME_INIT_VAL)
-		return context->orig_runtime_us;
+	if (*orig_value == *set_value)
+		goto out_done;
 
-	runtime_us = osnoise_read_ll_config("osnoise/runtime_us");
-	if (runtime_us < 0)
-		goto out_err;
+	retval = osnoise_write_ll_config(rel_path, *orig_value, set_value, orig_value);
+	if (retval < 0)
+		err_msg("Could not restore original value for %s\n", rel_path);
 
-	context->orig_runtime_us = runtime_us;
-	return runtime_us;
+out_done:
+	*set_value = -1;
+}
 
-out_err:
-	return OSNOISE_TIME_INIT_VAL;
+/*
+ * osnoise_get_runtime - return the original "osnoise/runtime_us" value
+ *
+ * It also saves the value to be restored.
+ */
+long long osnoise_get_runtime(struct osnoise_context *context)
+{
+	return osnoise_read_ll_config("osnoise/runtime_us",
+				      &context->runtime_us,
+				      &context->orig_runtime_us);
 }
 
 /*
@@ -241,57 +324,29 @@ unsigned long long osnoise_get_runtime(struct osnoise_context *context)
  *
  * It also saves the value to be restored.
  */
-unsigned long long osnoise_get_period(struct osnoise_context *context)
+long long osnoise_get_period(struct osnoise_context *context)
 {
-	long long period_us;
-
-	if (context->period_us != OSNOISE_TIME_INIT_VAL)
-		return context->period_us;
-
-	if (context->orig_period_us != OSNOISE_TIME_INIT_VAL)
-		return context->orig_period_us;
-
-	period_us = osnoise_read_ll_config("osnoise/period_us");
-	if (period_us < 0)
-		goto out_err;
-
-	context->orig_period_us = period_us;
-	return period_us;
-
-out_err:
-	return OSNOISE_TIME_INIT_VAL;
+	return osnoise_read_ll_config("osnoise/period_us",
+				      &context->period_us,
+				      &context->orig_period_us);
 }
 
 static int __osnoise_write_runtime(struct osnoise_context *context,
-				   unsigned long long runtime)
+				   long long runtime)
 {
-	int retval;
-
-	if (context->orig_runtime_us == OSNOISE_TIME_INIT_VAL)
-		return -1;
-
-	retval = osnoise_write_ll_config("osnoise/runtime_us", runtime);
-	if (retval < 0)
-		return -1;
-
-	context->runtime_us = runtime;
-	return 0;
+	return osnoise_write_ll_config("osnoise/runtime_us",
+				       runtime,
+				       &context->runtime_us,
+				       &context->orig_runtime_us);
 }
 
 static int __osnoise_write_period(struct osnoise_context *context,
-				  unsigned long long period)
+				  long long period)
 {
-	int retval;
-
-	if (context->orig_period_us == OSNOISE_TIME_INIT_VAL)
-		return -1;
-
-	retval = osnoise_write_ll_config("osnoise/period_us", period);
-	if (retval < 0)
-		return -1;
-
-	context->period_us = period;
-	return 0;
+	return osnoise_write_ll_config("osnoise/period_us",
+				       period,
+				       &context->period_us,
+				       &context->orig_period_us);
 }
 
 /*
@@ -302,11 +357,11 @@ static int __osnoise_write_period(struct osnoise_context *context,
  * to set the runtime and period if they are != 0.
  */
 int osnoise_set_runtime_period(struct osnoise_context *context,
-			       unsigned long long runtime,
-			       unsigned long long period)
+			       long long runtime,
+			       long long period)
 {
-	unsigned long long curr_runtime_us;
-	unsigned long long curr_period_us;
+	long long curr_runtime_us;
+	long long curr_period_us;
 	int retval;
 
 	if (!period && !runtime)
@@ -316,7 +371,7 @@ int osnoise_set_runtime_period(struct osnoise_context *context,
 	curr_period_us = osnoise_get_period(context);
 
 	/* error getting any value? */
-	if (curr_period_us == OSNOISE_TIME_INIT_VAL || curr_runtime_us == OSNOISE_TIME_INIT_VAL)
+	if (curr_period_us == -1 || curr_runtime_us == -1)
 		return -1;
 
 	if (!period) {
@@ -353,13 +408,13 @@ int osnoise_set_runtime_period(struct osnoise_context *context,
  */
 void osnoise_restore_runtime_period(struct osnoise_context *context)
 {
-	unsigned long long orig_runtime = context->orig_runtime_us;
-	unsigned long long orig_period = context->orig_period_us;
-	unsigned long long curr_runtime = context->runtime_us;
-	unsigned long long curr_period = context->period_us;
+	long long orig_runtime = context->orig_runtime_us;
+	long long orig_period = context->orig_period_us;
+	long long curr_runtime = context->runtime_us;
+	long long curr_period = context->period_us;
 	int retval;
 
-	if ((orig_runtime == OSNOISE_TIME_INIT_VAL) && (orig_period == OSNOISE_TIME_INIT_VAL))
+	if ((orig_runtime == -1) && (orig_period == -1))
 		return;
 
 	if ((orig_period == curr_period) && (orig_runtime == curr_runtime))
@@ -370,8 +425,8 @@ void osnoise_restore_runtime_period(struct osnoise_context *context)
 		err_msg("Could not restore original osnoise runtime/period\n");
 
 out_done:
-	context->runtime_us = OSNOISE_TIME_INIT_VAL;
-	context->period_us = OSNOISE_TIME_INIT_VAL;
+	context->runtime_us = -1;
+	context->period_us = -1;
 }
 
 /*
@@ -381,498 +436,81 @@ void osnoise_put_runtime_period(struct osnoise_context *context)
 {
 	osnoise_restore_runtime_period(context);
 
-	if (context->orig_runtime_us != OSNOISE_TIME_INIT_VAL)
-		context->orig_runtime_us = OSNOISE_TIME_INIT_VAL;
-
-	if (context->orig_period_us != OSNOISE_TIME_INIT_VAL)
-		context->orig_period_us = OSNOISE_TIME_INIT_VAL;
-}
-
-/*
- * osnoise_get_timerlat_period_us - read and save the original "timerlat_period_us"
- */
-static long long
-osnoise_get_timerlat_period_us(struct osnoise_context *context)
-{
-	long long timerlat_period_us;
-
-	if (context->timerlat_period_us != OSNOISE_TIME_INIT_VAL)
-		return context->timerlat_period_us;
-
-	if (context->orig_timerlat_period_us != OSNOISE_TIME_INIT_VAL)
-		return context->orig_timerlat_period_us;
-
-	timerlat_period_us = osnoise_read_ll_config("osnoise/timerlat_period_us");
-	if (timerlat_period_us < 0)
-		goto out_err;
-
-	context->orig_timerlat_period_us = timerlat_period_us;
-	return timerlat_period_us;
-
-out_err:
-	return OSNOISE_TIME_INIT_VAL;
-}
-
-/*
- * osnoise_set_timerlat_period_us - set "timerlat_period_us"
- */
-int osnoise_set_timerlat_period_us(struct osnoise_context *context, long long timerlat_period_us)
-{
-	long long curr_timerlat_period_us = osnoise_get_timerlat_period_us(context);
-	int retval;
-
-	if (curr_timerlat_period_us == OSNOISE_TIME_INIT_VAL)
-		return -1;
-
-	retval = osnoise_write_ll_config("osnoise/timerlat_period_us", timerlat_period_us);
-	if (retval < 0)
-		return -1;
-
-	context->timerlat_period_us = timerlat_period_us;
-
-	return 0;
-}
-
-/*
- * osnoise_restore_timerlat_period_us - restore "timerlat_period_us"
- */
-void osnoise_restore_timerlat_period_us(struct osnoise_context *context)
-{
-	int retval;
-
-	if (context->orig_timerlat_period_us == OSNOISE_TIME_INIT_VAL)
-		return;
-
-	if (context->orig_timerlat_period_us == context->timerlat_period_us)
-		goto out_done;
-
-	retval = osnoise_write_ll_config("osnoise/timerlat_period_us", context->orig_timerlat_period_us);
-	if (retval < 0)
-		err_msg("Could not restore original osnoise timerlat_period_us\n");
-
-out_done:
-	context->timerlat_period_us = OSNOISE_TIME_INIT_VAL;
-}
-
-/*
- * osnoise_put_timerlat_period_us - restore original values and cleanup data
- */
-void osnoise_put_timerlat_period_us(struct osnoise_context *context)
-{
-	osnoise_restore_timerlat_period_us(context);
-
-	if (context->orig_timerlat_period_us == OSNOISE_TIME_INIT_VAL)
-		return;
-
-	context->orig_timerlat_period_us = OSNOISE_TIME_INIT_VAL;
-}
-
-/*
- * osnoise_get_timerlat_align_us - read and save the original "timerlat_align_us"
- */
-static long long
-osnoise_get_timerlat_align_us(struct osnoise_context *context)
-{
-	long long timerlat_align_us;
-
-	if (context->timerlat_align_us != OSNOISE_OPTION_INIT_VAL)
-		return context->timerlat_align_us;
-
-	if (context->orig_timerlat_align_us != OSNOISE_OPTION_INIT_VAL)
-		return context->orig_timerlat_align_us;
-
-	timerlat_align_us = osnoise_read_ll_config("osnoise/timerlat_align_us");
-	if (timerlat_align_us < 0)
-		goto out_err;
-
-	context->orig_timerlat_align_us = timerlat_align_us;
-	return timerlat_align_us;
-
-out_err:
-	return OSNOISE_OPTION_INIT_VAL;
-}
-
-/*
- * osnoise_set_timerlat_align_us - set "timerlat_align_us"
- */
-int osnoise_set_timerlat_align_us(struct osnoise_context *context, long long timerlat_align_us)
-{
-	long long curr_timerlat_align_us = osnoise_get_timerlat_align_us(context);
-	int retval;
-
-	if (curr_timerlat_align_us == OSNOISE_OPTION_INIT_VAL)
-		return -1;
-
-	retval = osnoise_write_ll_config("osnoise/timerlat_align_us", timerlat_align_us);
-	if (retval < 0)
-		return -1;
-
-	context->timerlat_align_us = timerlat_align_us;
-
-	return 0;
-}
-
-/*
- * osnoise_restore_timerlat_align_us - restore "timerlat_align_us"
- */
-void osnoise_restore_timerlat_align_us(struct osnoise_context *context)
-{
-	int retval;
-
-	if (context->orig_timerlat_align_us == OSNOISE_OPTION_INIT_VAL)
-		return;
-
-	if (context->orig_timerlat_align_us == context->timerlat_align_us)
-		goto out_done;
-
-	retval = osnoise_write_ll_config("osnoise/timerlat_align_us",
-				   context->orig_timerlat_align_us);
-	if (retval < 0)
-		err_msg("Could not restore original osnoise timerlat_align_us\n");
-
-out_done:
-	context->timerlat_align_us = OSNOISE_OPTION_INIT_VAL;
-}
-
-/*
- * osnoise_put_timerlat_align_us - restore original values and cleanup data
- */
-void osnoise_put_timerlat_align_us(struct osnoise_context *context)
-{
-	osnoise_restore_timerlat_align_us(context);
-
-	if (context->orig_timerlat_align_us == OSNOISE_OPTION_INIT_VAL)
-		return;
-
-	context->orig_timerlat_align_us = OSNOISE_OPTION_INIT_VAL;
-}
-
-/*
- * osnoise_get_stop_us - read and save the original "stop_tracing_us"
- */
-static long long
-osnoise_get_stop_us(struct osnoise_context *context)
-{
-	long long stop_us;
-
-	if (context->stop_us != OSNOISE_OPTION_INIT_VAL)
-		return context->stop_us;
-
-	if (context->orig_stop_us != OSNOISE_OPTION_INIT_VAL)
-		return context->orig_stop_us;
-
-	stop_us = osnoise_read_ll_config("osnoise/stop_tracing_us");
-	if (stop_us < 0)
-		goto out_err;
-
-	context->orig_stop_us = stop_us;
-	return stop_us;
-
-out_err:
-	return OSNOISE_OPTION_INIT_VAL;
-}
-
-/*
- * osnoise_set_stop_us - set "stop_tracing_us"
- */
-int osnoise_set_stop_us(struct osnoise_context *context, long long stop_us)
-{
-	long long curr_stop_us = osnoise_get_stop_us(context);
-	int retval;
-
-	if (curr_stop_us == OSNOISE_OPTION_INIT_VAL)
-		return -1;
-
-	retval = osnoise_write_ll_config("osnoise/stop_tracing_us", stop_us);
-	if (retval < 0)
-		return -1;
-
-	context->stop_us = stop_us;
-
-	return 0;
-}
-
-/*
- * osnoise_restore_stop_us - restore the original "stop_tracing_us"
- */
-void osnoise_restore_stop_us(struct osnoise_context *context)
-{
-	int retval;
-
-	if (context->orig_stop_us == OSNOISE_OPTION_INIT_VAL)
-		return;
-
-	if (context->orig_stop_us == context->stop_us)
-		goto out_done;
-
-	retval = osnoise_write_ll_config("osnoise/stop_tracing_us", context->orig_stop_us);
-	if (retval < 0)
-		err_msg("Could not restore original osnoise stop_us\n");
-
-out_done:
-	context->stop_us = OSNOISE_OPTION_INIT_VAL;
-}
-
-/*
- * osnoise_put_stop_us - restore original values and cleanup data
- */
-void osnoise_put_stop_us(struct osnoise_context *context)
-{
-	osnoise_restore_stop_us(context);
-
-	if (context->orig_stop_us == OSNOISE_OPTION_INIT_VAL)
-		return;
-
-	context->orig_stop_us = OSNOISE_OPTION_INIT_VAL;
-}
-
-/*
- * osnoise_get_stop_total_us - read and save the original "stop_tracing_total_us"
- */
-static long long
-osnoise_get_stop_total_us(struct osnoise_context *context)
-{
-	long long stop_total_us;
-
-	if (context->stop_total_us != OSNOISE_OPTION_INIT_VAL)
-		return context->stop_total_us;
-
-	if (context->orig_stop_total_us != OSNOISE_OPTION_INIT_VAL)
-		return context->orig_stop_total_us;
-
-	stop_total_us = osnoise_read_ll_config("osnoise/stop_tracing_total_us");
-	if (stop_total_us < 0)
-		goto out_err;
-
-	context->orig_stop_total_us = stop_total_us;
-	return stop_total_us;
-
-out_err:
-	return OSNOISE_OPTION_INIT_VAL;
-}
-
-/*
- * osnoise_set_stop_total_us - set "stop_tracing_total_us"
- */
-int osnoise_set_stop_total_us(struct osnoise_context *context, long long stop_total_us)
-{
-	long long curr_stop_total_us = osnoise_get_stop_total_us(context);
-	int retval;
-
-	if (curr_stop_total_us == OSNOISE_OPTION_INIT_VAL)
-		return -1;
-
-	retval = osnoise_write_ll_config("osnoise/stop_tracing_total_us", stop_total_us);
-	if (retval < 0)
-		return -1;
-
-	context->stop_total_us = stop_total_us;
-
-	return 0;
-}
-
-/*
- * osnoise_restore_stop_total_us - restore the original "stop_tracing_total_us"
- */
-void osnoise_restore_stop_total_us(struct osnoise_context *context)
-{
-	int retval;
-
-	if (context->orig_stop_total_us == OSNOISE_OPTION_INIT_VAL)
-		return;
-
-	if (context->orig_stop_total_us == context->stop_total_us)
-		goto out_done;
-
-	retval = osnoise_write_ll_config("osnoise/stop_tracing_total_us",
-			context->orig_stop_total_us);
-	if (retval < 0)
-		err_msg("Could not restore original osnoise stop_total_us\n");
-
-out_done:
-	context->stop_total_us = OSNOISE_OPTION_INIT_VAL;
-}
-
-/*
- * osnoise_put_stop_total_us - restore original values and cleanup data
- */
-void osnoise_put_stop_total_us(struct osnoise_context *context)
-{
-	osnoise_restore_stop_total_us(context);
-
-	if (context->orig_stop_total_us == OSNOISE_OPTION_INIT_VAL)
-		return;
-
-	context->orig_stop_total_us = OSNOISE_OPTION_INIT_VAL;
-}
-
-/*
- * osnoise_get_print_stack - read and save the original "print_stack"
- */
-static long long
-osnoise_get_print_stack(struct osnoise_context *context)
-{
-	long long print_stack;
-
-	if (context->print_stack != OSNOISE_OPTION_INIT_VAL)
-		return context->print_stack;
-
-	if (context->orig_print_stack != OSNOISE_OPTION_INIT_VAL)
-		return context->orig_print_stack;
-
-	print_stack = osnoise_read_ll_config("osnoise/print_stack");
-	if (print_stack < 0)
-		goto out_err;
-
-	context->orig_print_stack = print_stack;
-	return print_stack;
-
-out_err:
-	return OSNOISE_OPTION_INIT_VAL;
-}
-
-/*
- * osnoise_set_print_stack - set "print_stack"
- */
-int osnoise_set_print_stack(struct osnoise_context *context, long long print_stack)
-{
-	long long curr_print_stack = osnoise_get_print_stack(context);
-	int retval;
-
-	if (curr_print_stack == OSNOISE_OPTION_INIT_VAL)
-		return -1;
-
-	retval = osnoise_write_ll_config("osnoise/print_stack", print_stack);
-	if (retval < 0)
-		return -1;
-
-	context->print_stack = print_stack;
-
-	return 0;
-}
-
-/*
- * osnoise_restore_print_stack - restore the original "print_stack"
- */
-void osnoise_restore_print_stack(struct osnoise_context *context)
-{
-	int retval;
-
-	if (context->orig_print_stack == OSNOISE_OPTION_INIT_VAL)
-		return;
-
-	if (context->orig_print_stack == context->print_stack)
-		goto out_done;
-
-	retval = osnoise_write_ll_config("osnoise/print_stack", context->orig_print_stack);
-	if (retval < 0)
-		err_msg("Could not restore original osnoise print_stack\n");
-
-out_done:
-	context->print_stack = OSNOISE_OPTION_INIT_VAL;
-}
-
-/*
- * osnoise_put_print_stack - restore original values and cleanup data
- */
-void osnoise_put_print_stack(struct osnoise_context *context)
-{
-	osnoise_restore_print_stack(context);
-
-	if (context->orig_print_stack == OSNOISE_OPTION_INIT_VAL)
-		return;
-
-	context->orig_print_stack = OSNOISE_OPTION_INIT_VAL;
-}
-
-/*
- * osnoise_get_tracing_thresh - read and save the original "tracing_thresh"
- */
-static long long
-osnoise_get_tracing_thresh(struct osnoise_context *context)
-{
-	long long tracing_thresh;
-
-	if (context->tracing_thresh != OSNOISE_OPTION_INIT_VAL)
-		return context->tracing_thresh;
-
-	if (context->orig_tracing_thresh != OSNOISE_OPTION_INIT_VAL)
-		return context->orig_tracing_thresh;
-
-	tracing_thresh = osnoise_read_ll_config("tracing_thresh");
-	if (tracing_thresh < 0)
-		goto out_err;
-
-	context->orig_tracing_thresh = tracing_thresh;
-	return tracing_thresh;
+	if (context->orig_runtime_us != -1)
+		context->orig_runtime_us = -1;
 
-out_err:
-	return OSNOISE_OPTION_INIT_VAL;
+	if (context->orig_period_us != -1)
+		context->orig_period_us = -1;
 }
 
 /*
- * osnoise_set_tracing_thresh - set "tracing_thresh"
+ * Long long option set/restore/put functions, generated from OSNOISE_LL_OPTIONS.
  */
-int osnoise_set_tracing_thresh(struct osnoise_context *context, long long tracing_thresh)
-{
-	long long curr_tracing_thresh = osnoise_get_tracing_thresh(context);
-	int retval;
-
-	if (curr_tracing_thresh == OSNOISE_OPTION_INIT_VAL)
-		return -1;
-
-	retval = osnoise_write_ll_config("tracing_thresh", tracing_thresh);
-	if (retval < 0)
-		return -1;
-
-	context->tracing_thresh = tracing_thresh;
-
-	return 0;
-}
-
-/*
- * osnoise_restore_tracing_thresh - restore the original "tracing_thresh"
- */
-void osnoise_restore_tracing_thresh(struct osnoise_context *context)
-{
-	int retval;
-
-	if (context->orig_tracing_thresh == OSNOISE_OPTION_INIT_VAL)
-		return;
-
-	if (context->orig_tracing_thresh == context->tracing_thresh)
-		goto out_done;
-
-	retval = osnoise_write_ll_config("tracing_thresh", context->orig_tracing_thresh);
-	if (retval < 0)
-		err_msg("Could not restore original tracing_thresh\n");
-
-out_done:
-	context->tracing_thresh = OSNOISE_OPTION_INIT_VAL;
-}
-
-/*
- * osnoise_put_tracing_thresh - restore original values and cleanup data
+#define OSNOISE_LL_OPTION(name, path)						\
+int osnoise_set_##name(struct osnoise_context *context, long long value)	\
+{										\
+	return osnoise_write_ll_config(path,					\
+				       value,					\
+				       &context->name,				\
+				       &context->orig_##name);			\
+}										\
+										\
+void osnoise_restore_##name(struct osnoise_context *context)			\
+{										\
+	osnoise_restore_ll_config(path, &context->name, &context->orig_##name);	\
+}										\
+										\
+static void osnoise_put_##name(struct osnoise_context *context)			\
+{										\
+	osnoise_restore_##name(context);					\
+										\
+	if (context->orig_##name == -1)						\
+		return;								\
+										\
+	context->orig_##name = -1;						\
+}
+OSNOISE_LL_OPTIONS
+#undef OSNOISE_LL_OPTION
+
+/**
+ * osnoise_get_option - read a boolean flag from osnoise/options
+ * @option: the option name string to look for (e.g. "OSNOISE_IRQ_DISABLE")
+ * @set_value: pointer to the cached value set by RTLA, or -1 if unset
+ * @orig_value: pointer to the cached original value read from tracefs, or -1 if unread
+ *
+ * Returns the current state of the flag @option. If RTLA has already written a
+ * value (@set_value != -1), that value is returned. If the original has already
+ * been read (@orig_value != -1), that cached value is returned. Otherwise, reads
+ * the "osnoise/options" file from tracefs, checks whether @option appears with or
+ * without a "NO_" prefix, caches the result in @orig_value (so it can later be
+ * restored), and returns it.
+ *
+ * This is the shared read primitive used by the OSNOISE_FLAG_OPTION-generated
+ * set/restore/put functions.
+ *
+ * Returns 1 if enabled, 0 if disabled, or -1 on error (option unknown to kernel).
  */
-void osnoise_put_tracing_thresh(struct osnoise_context *context)
+static int osnoise_get_option(char *option,
+			      int *set_value,
+			      int *orig_value)
 {
-	osnoise_restore_tracing_thresh(context);
-
-	if (context->orig_tracing_thresh == OSNOISE_OPTION_INIT_VAL)
-		return;
-
-	context->orig_tracing_thresh = OSNOISE_OPTION_INIT_VAL;
-}
-
-static int osnoise_options_get_option(char *option)
-{
-	char *options = tracefs_instance_file_read(NULL, "osnoise/options", NULL);
+	char *options;
 	char no_option[128];
 	int retval = 0;
 	char *opt;
 
+	if (*set_value != -1)
+		/* option has been set by RTLA already */
+		return *set_value;
+
+	if (*orig_value != -1)
+		/* RTLA has already read the option */
+		return *orig_value;
+
+	/* current value is not known to RTLA yet, read it from tracefs */
+	options = tracefs_instance_file_read(NULL, "osnoise/options", NULL);
 	if (!options)
-		return OSNOISE_OPTION_INIT_VAL;
+		return -1;
 
 	/*
 	 * Check first if the option is disabled.
@@ -891,207 +529,138 @@ static int osnoise_options_get_option(char *option)
 	if (opt)
 		retval = 1;
 	else
-		retval = OSNOISE_OPTION_INIT_VAL;
+		retval = -1;
 
 out_free:
 	free(options);
-	return retval;
-}
-
-static int osnoise_options_set_option(char *option, bool onoff)
-{
-	char no_option[128];
-
-	if (onoff)
-		return tracefs_instance_file_write(NULL, "osnoise/options", option);
-
-	snprintf(no_option, sizeof(no_option), "NO_%s", option);
-
-	return tracefs_instance_file_write(NULL, "osnoise/options", no_option);
-}
-
-static int osnoise_get_irq_disable(struct osnoise_context *context)
-{
-	if (context->opt_irq_disable != OSNOISE_OPTION_INIT_VAL)
-		return context->opt_irq_disable;
-
-	if (context->orig_opt_irq_disable != OSNOISE_OPTION_INIT_VAL)
-		return context->orig_opt_irq_disable;
 
-	context->orig_opt_irq_disable = osnoise_options_get_option("OSNOISE_IRQ_DISABLE");
-
-	return context->orig_opt_irq_disable;
-}
-
-int osnoise_set_irq_disable(struct osnoise_context *context, bool onoff)
-{
-	int opt_irq_disable = osnoise_get_irq_disable(context);
-	int retval;
-
-	if (opt_irq_disable == OSNOISE_OPTION_INIT_VAL)
-		return -1;
-
-	if (opt_irq_disable == onoff)
-		return 0;
-
-	retval = osnoise_options_set_option("OSNOISE_IRQ_DISABLE", onoff);
 	if (retval < 0)
-		return -1;
-
-	context->opt_irq_disable = onoff;
-
-	return 0;
-}
-
-static void osnoise_restore_irq_disable(struct osnoise_context *context)
-{
-	int retval;
-
-	if (context->orig_opt_irq_disable == OSNOISE_OPTION_INIT_VAL)
-		return;
-
-	if (context->orig_opt_irq_disable == context->opt_irq_disable)
-		goto out_done;
-
-	retval = osnoise_options_set_option("OSNOISE_IRQ_DISABLE", context->orig_opt_irq_disable);
-	if (retval < 0)
-		err_msg("Could not restore original OSNOISE_IRQ_DISABLE option\n");
-
-out_done:
-	context->orig_opt_irq_disable = OSNOISE_OPTION_INIT_VAL;
-}
-
-static void osnoise_put_irq_disable(struct osnoise_context *context)
-{
-	osnoise_restore_irq_disable(context);
-
-	if (context->orig_opt_irq_disable == OSNOISE_OPTION_INIT_VAL)
-		return;
-
-	context->orig_opt_irq_disable = OSNOISE_OPTION_INIT_VAL;
-}
-
-static int osnoise_get_workload(struct osnoise_context *context)
-{
-	if (context->opt_workload != OSNOISE_OPTION_INIT_VAL)
-		return context->opt_workload;
-
-	if (context->orig_opt_workload != OSNOISE_OPTION_INIT_VAL)
-		return context->orig_opt_workload;
+		goto out_err;
 
-	context->orig_opt_workload = osnoise_options_get_option("OSNOISE_WORKLOAD");
+	/* save the value and return it */
+	*orig_value = retval;
+	return retval;
 
-	return context->orig_opt_workload;
+out_err:
+	return -1;
 }
 
-int osnoise_set_workload(struct osnoise_context *context, bool onoff)
+/**
+ * osnoise_set_option - write a boolean flag to osnoise/options
+ * @option: the option name string (e.g. "OSNOISE_IRQ_DISABLE")
+ * @onoff: the desired state (true to enable, false to disable)
+ * @set_value: pointer to the cached value set by RTLA, or -1 if unset
+ * @orig_value: pointer to the cached original value read from tracefs, or -1 if unread
+ *
+ * Sets the flag @option to the state @onoff. Before writing, calls
+ * osnoise_get_option() to ensure the original value is cached in @orig_value
+ * (enabling later restoration). If the current value already matches @onoff,
+ * no write is performed. On successful write, records the new state in
+ * @set_value.
+ *
+ * This is the shared write primitive used by the OSNOISE_FLAG_OPTION-generated
+ * set/restore/put functions.
+ *
+ * Returns 0 on success, -1 on read error (option likely unknown to kernel),
+ * or -2 on write error.
+ */
+static int osnoise_set_option(char *option,
+			      bool onoff,
+			      int *set_value,
+			      int *orig_value)
 {
-	int opt_workload = osnoise_get_workload(context);
+	int curr = osnoise_get_option(option, set_value, orig_value);
+	char no_option[128];
 	int retval;
 
-	if (opt_workload == OSNOISE_OPTION_INIT_VAL)
+	if (curr == -1)
+		/* read failed, option likely unknown to kernel */
 		return -1;
 
-	if (opt_workload == onoff)
+	if (curr == onoff)
 		return 0;
 
-	retval = osnoise_options_set_option("OSNOISE_WORKLOAD", onoff);
-	if (retval < 0)
-		return -2;
-
-	context->opt_workload = onoff;
-
-	return 0;
-}
-
-static void osnoise_restore_workload(struct osnoise_context *context)
-{
-	int retval;
-
-	if (context->orig_opt_workload == OSNOISE_OPTION_INIT_VAL)
-		return;
-
-	if (context->orig_opt_workload == context->opt_workload)
-		goto out_done;
-
-	retval = osnoise_options_set_option("OSNOISE_WORKLOAD", context->orig_opt_workload);
-	if (retval < 0)
-		err_msg("Could not restore original OSNOISE_WORKLOAD option\n");
-
-out_done:
-	context->orig_opt_workload = OSNOISE_OPTION_INIT_VAL;
-}
-
-static void osnoise_put_workload(struct osnoise_context *context)
-{
-	osnoise_restore_workload(context);
-
-	if (context->orig_opt_workload == OSNOISE_OPTION_INIT_VAL)
-		return;
-
-	context->orig_opt_workload = OSNOISE_OPTION_INIT_VAL;
-}
-
-static int osnoise_get_timerlat_align(struct osnoise_context *context)
-{
-	if (context->opt_timerlat_align != OSNOISE_OPTION_INIT_VAL)
-		return context->opt_timerlat_align;
-
-	if (context->orig_opt_timerlat_align != OSNOISE_OPTION_INIT_VAL)
-		return context->orig_opt_timerlat_align;
-
-	context->orig_opt_timerlat_align = osnoise_options_get_option("TIMERLAT_ALIGN");
-
-	return context->orig_opt_timerlat_align;
-}
-
-int osnoise_set_timerlat_align(struct osnoise_context *context, bool onoff)
-{
-	int opt_timerlat_align = osnoise_get_timerlat_align(context);
-	int retval;
-
-	if (opt_timerlat_align == OSNOISE_OPTION_INIT_VAL)
-		return -1;
-
-	if (opt_timerlat_align == onoff)
-		return 0;
+	if (onoff) {
+		retval = tracefs_instance_file_write(NULL, "osnoise/options", option);
+	} else {
+		snprintf(no_option, sizeof(no_option), "NO_%s", option);
+		retval = tracefs_instance_file_write(NULL, "osnoise/options", no_option);
+	}
 
-	retval = osnoise_options_set_option("TIMERLAT_ALIGN", onoff);
 	if (retval < 0)
+		/* write failed, hard error */
 		return -2;
 
-	context->opt_timerlat_align = onoff;
-
+	/* record the set value and return success */
+	*set_value = onoff;
 	return 0;
 }
 
-static void osnoise_restore_timerlat_align(struct osnoise_context *context)
+/**
+ * osnoise_restore_option - restore a boolean flag to its original value
+ * @option: the option name string (e.g. "OSNOISE_IRQ_DISABLE")
+ * @set_value: pointer to the cached value set by RTLA, or -1 if unset
+ * @orig_value: pointer to the cached original value read from tracefs, or -1 if unread
+ *
+ * Restores the flag @option to the state cached in @orig_value (which was saved
+ * by a prior osnoise_get_option() or osnoise_set_option() call). If the original
+ * was never read, or if the current set value already matches the original, no
+ * write is performed. After restoring, clears @set_value to -1 to indicate RTLA
+ * no longer overrides this option.
+ *
+ * This is the shared restore primitive used by the OSNOISE_FLAG_OPTION-generated
+ * restore/put functions.
+ */
+static void osnoise_restore_option(char *option,
+				   int *set_value,
+				   int *orig_value)
 {
 	int retval;
 
-	if (context->orig_opt_timerlat_align == OSNOISE_OPTION_INIT_VAL)
+	if (*orig_value == -1)
 		return;
 
-	if (context->orig_opt_timerlat_align == context->opt_timerlat_align)
+	if (*orig_value == *set_value)
 		goto out_done;
 
-	retval = osnoise_options_set_option("TIMERLAT_ALIGN", context->orig_opt_timerlat_align);
+	retval = osnoise_set_option(option, *orig_value, set_value, orig_value);
 	if (retval < 0)
-		err_msg("Could not restore original TIMERLAT_ALIGN option\n");
+		err_msg("Could not restore original %s option\n", option);
 
 out_done:
-	context->orig_opt_timerlat_align = OSNOISE_OPTION_INIT_VAL;
+	*set_value = -1;
 }
 
-static void osnoise_put_timerlat_align(struct osnoise_context *context)
-{
-	osnoise_restore_timerlat_align(context);
-
-	if (context->orig_opt_timerlat_align == OSNOISE_OPTION_INIT_VAL)
-		return;
-
-	context->orig_opt_timerlat_align = OSNOISE_OPTION_INIT_VAL;
-}
+/*
+ * Flag option set/restore/put functions, generated from OSNOISE_FLAG_OPTIONS.
+ */
+#define OSNOISE_FLAG_OPTION(name, option_str)				\
+int osnoise_set_##name(struct osnoise_context *context, bool onoff)	\
+{									\
+	return osnoise_set_option(option_str,				\
+				  onoff,				\
+				  &context->opt_##name,			\
+				  &context->orig_opt_##name);		\
+}									\
+									\
+void osnoise_restore_##name(struct osnoise_context *context)		\
+{									\
+	osnoise_restore_option(option_str,				\
+			       &context->opt_##name,			\
+			       &context->orig_opt_##name);		\
+}									\
+									\
+static void osnoise_put_##name(struct osnoise_context *context)		\
+{									\
+	osnoise_restore_##name(context);				\
+									\
+	if (context->orig_opt_##name == -1)				\
+		return;							\
+									\
+	context->orig_opt_##name = -1;					\
+}
+OSNOISE_FLAG_OPTIONS
+#undef OSNOISE_FLAG_OPTION
 
 enum {
 	FLAG_CONTEXT_NEWLY_CREATED	= (1 << 0),
@@ -1127,29 +696,23 @@ struct osnoise_context *osnoise_context_alloc(void)
 
 	context = calloc_fatal(1, sizeof(*context));
 
-	context->orig_stop_us		= OSNOISE_OPTION_INIT_VAL;
-	context->stop_us		= OSNOISE_OPTION_INIT_VAL;
-
-	context->orig_stop_total_us	= OSNOISE_OPTION_INIT_VAL;
-	context->stop_total_us		= OSNOISE_OPTION_INIT_VAL;
-
-	context->orig_print_stack	= OSNOISE_OPTION_INIT_VAL;
-	context->print_stack		= OSNOISE_OPTION_INIT_VAL;
-
-	context->orig_tracing_thresh	= OSNOISE_OPTION_INIT_VAL;
-	context->tracing_thresh		= OSNOISE_OPTION_INIT_VAL;
-
-	context->orig_opt_irq_disable	= OSNOISE_OPTION_INIT_VAL;
-	context->opt_irq_disable	= OSNOISE_OPTION_INIT_VAL;
-
-	context->orig_opt_workload	= OSNOISE_OPTION_INIT_VAL;
-	context->opt_workload		= OSNOISE_OPTION_INIT_VAL;
-
-	context->orig_opt_timerlat_align	= OSNOISE_OPTION_INIT_VAL;
-	context->opt_timerlat_align		= OSNOISE_OPTION_INIT_VAL;
-
-	context->orig_timerlat_align_us	= OSNOISE_OPTION_INIT_VAL;
-	context->timerlat_align_us	= OSNOISE_OPTION_INIT_VAL;
+	/* First allocate manually implemented options... */
+	context->orig_runtime_us = -1;
+	context->runtime_us	 = -1;
+	context->orig_period_us	 = -1;
+	context->period_us	 = -1;
+
+	/* ...then the automatically generated ones. */
+#define OSNOISE_LL_OPTION(name, path)		\
+	context->orig_##name	 = -1;		\
+	context->name		 = -1;
+#define OSNOISE_FLAG_OPTION(name, option_str)	\
+	context->orig_opt_##name = -1;		\
+	context->opt_##name	 = -1;
+	OSNOISE_LL_OPTIONS
+	OSNOISE_FLAG_OPTIONS
+#undef OSNOISE_LL_OPTION
+#undef OSNOISE_FLAG_OPTION
 
 	osnoise_get_context(context);
 
@@ -1170,17 +733,17 @@ void osnoise_put_context(struct osnoise_context *context)
 	if (!(context->flags & FLAG_CONTEXT_DELETED))
 		return;
 
+	/* First restore the original values of the options... */
 	osnoise_put_cpus(context);
 	osnoise_put_runtime_period(context);
-	osnoise_put_stop_us(context);
-	osnoise_put_stop_total_us(context);
-	osnoise_put_timerlat_period_us(context);
-	osnoise_put_print_stack(context);
-	osnoise_put_tracing_thresh(context);
-	osnoise_put_irq_disable(context);
-	osnoise_put_workload(context);
-	osnoise_put_timerlat_align(context);
-	osnoise_put_timerlat_align_us(context);
+
+	/* ...then the automatically generated ones. */
+#define OSNOISE_LL_OPTION(name, path)		osnoise_put_##name(context);
+#define OSNOISE_FLAG_OPTION(name, option_str)	osnoise_put_##name(context);
+	OSNOISE_LL_OPTIONS
+	OSNOISE_FLAG_OPTIONS
+#undef OSNOISE_LL_OPTION
+#undef OSNOISE_FLAG_OPTION
 
 	free(context);
 }
diff --git a/tools/tracing/rtla/src/osnoise.h b/tools/tracing/rtla/src/osnoise.h
index 297c26102c58f..32f0555bc166f 100644
--- a/tools/tracing/rtla/src/osnoise.h
+++ b/tools/tracing/rtla/src/osnoise.h
@@ -18,45 +18,15 @@ struct osnoise_params {
 
 #define to_osnoise_params(ptr) container_of(ptr, struct osnoise_params, common)
 
-/*
- * *_INIT_VALs are also invalid values, they are used to
- * communicate errors.
- */
-#define OSNOISE_OPTION_INIT_VAL	(-1)
-#define OSNOISE_TIME_INIT_VAL	(0)
-
 struct osnoise_context *osnoise_context_alloc(void);
 int osnoise_get_context(struct osnoise_context *context);
 void osnoise_put_context(struct osnoise_context *context);
 
 int osnoise_set_runtime_period(struct osnoise_context *context,
-			       unsigned long long runtime,
-			       unsigned long long period);
+			       long long runtime,
+			       long long period);
 void osnoise_restore_runtime_period(struct osnoise_context *context);
 
-void osnoise_restore_stop_us(struct osnoise_context *context);
-void osnoise_restore_stop_total_us(struct osnoise_context *context);
-
-int osnoise_set_timerlat_period_us(struct osnoise_context *context,
-				   long long timerlat_period_us);
-void osnoise_restore_timerlat_period_us(struct osnoise_context *context);
-
-int osnoise_set_tracing_thresh(struct osnoise_context *context,
-			       long long tracing_thresh);
-void osnoise_restore_tracing_thresh(struct osnoise_context *context);
-
-void osnoise_restore_print_stack(struct osnoise_context *context);
-int osnoise_set_print_stack(struct osnoise_context *context,
-			    long long print_stack);
-
-int osnoise_set_timerlat_align_us(struct osnoise_context *context,
-				  long long timerlat_align_us);
-void osnoise_restore_timerlat_align_us(struct osnoise_context *context);
-
-int osnoise_set_timerlat_align(struct osnoise_context *context, bool onoff);
-
-int osnoise_set_irq_disable(struct osnoise_context *context, bool onoff);
-
 void osnoise_report_invalid_events(struct osnoise_tool *tool);
 void osnoise_report_missed_events(struct osnoise_tool *tool);
 int osnoise_apply_config(struct osnoise_tool *tool, struct osnoise_params *params);
-- 
2.55.0


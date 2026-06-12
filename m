Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008933803D3
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Jun 2026 11:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781265094; cv=none; b=Pgwd7mPr6qgQ6GH5UjfXHm8BnJhSmW/vAIQg0HyD00+YdoYQtT2P0DJb04RGFusxBfUyFnybbrWhi903r/OIemyO4HCCSh5/0PvGajHT0MD1jwP/vVfUVFnUd8YIZDXqTwdeSPET+v4DhfC2XaA8gzO6ycsV62fmFeGSzXnPkuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781265094; c=relaxed/simple;
	bh=Zp8pSIWrtVuit5qgCYGg84WPDVT9ge4No/iuJOwL1Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=jNJvQXmjPn3HslMRACA2E8Lt4IdqZ3ERG27LQz9O7LKNbt596dK/3iOuUWVMzG9dHpv8Yb8yiTvtuKaxLXe49Hpl/RS/2fRai66TcnAQVI5N5LJI4qPsfzG7e4DTtQPJJnjdH793/8u3Z3VNx69I92D2yBFKKCDVifvDAs4OC6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XW3Od5Ux; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XW3Od5Ux"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781265091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KXTFeHSiThC1ENGX6irgzZK6bIF0wMy1DHwPx8Aceys=;
	b=XW3Od5UxEFSovTiVeBBh+UcL8knpHTnh6djiCbZ1n9U3RTbLY9rBmmPr3I7JtDsEjPfwIo
	8GS67bOsMxksccRssGFHoroG8XwVMtBchwAhRlTpWQ91ZilATo2DKQyJ2RSsOuOu3wEesC
	+0tpSPJChnD9j3KyHnAB01T0mX2BZPA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-Un5F2vQHP5iP4EJCBBS71g-1; Fri,
 12 Jun 2026 07:51:27 -0400
X-MC-Unique: Un5F2vQHP5iP4EJCBBS71g-1
X-Mimecast-MFC-AGG-ID: Un5F2vQHP5iP4EJCBBS71g_1781265087
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DEF0C195DB96;
	Fri, 12 Jun 2026 11:51:26 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.23])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A0C2F3691A;
	Fri, 12 Jun 2026 11:51:23 +0000 (UTC)
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
Subject: [PATCH] rtla: Simplify osnoise tracer option setting code
Date: Fri, 12 Jun 2026 13:51:21 +0200
Message-ID: <20260612115121.54862-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: 4ryuGuwxNoniKMt5L2oNCt-Lc_GDKCB8-bPkcQAUd_4_1781265087
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

Deduplicate the logic using a set of macros featuring the X macro
pattern, defined in src/common.h:

- OSNOISE_LL_OPTIONS, which invokes OSNOISE_LL_OPTION macro for all
  "long long" options,
- OSNOISE_FLAG_OPTIONS, which invokes OSNOISE_FLAG_OPTION macro for all
  flag (boolean values in osnoise/options file) options.

The list macros are then invoked in four places:

- for struct osnoise_context fields in src/common.h,
- for function declarations, moved into src/common.h from
  src/osnoise.h,
- for function definitions in src/osnoise.c,
- for context initialization and restoration, in osnoise_context_alloc()
  and osnoise_put_context(), both in src/osnoise.c.

OSNOISE_LL_OPTIONS takes three options: name - struct osnoise_context
field name (written "<opt>" above), path - filename inside
/sys/kernel/tracing/osnoise passed to libtracefs, and init_val - initial
value of struct fields, corresponding to an otherwise invalid option
(some options use OSNOISE_OPTION_INIT_VAL = -1, some use
OSNOISE_TIME_INIT_VAL = 0).

OSNOISE_FLAG_OPTION is similar, but instead of path, it takes the option
string inside /sys/kernel/tracing/osnoise/options (opt_string), and no
init_val, as it is purely boolean (0 or 1).

Previously, for options timerlat_align and osnoise_workload, the return
value of osnoise_set_<opt>() distinguished between -2 (option cannot be
set) and -1 (option not present). This distinction is expanded for all
options for consistency; for most options, it is currently not used,
only osnoise_workload is implemented to avoid error on -1 on older RTLA
versions.

The change overall has two main benefits: it makes it much simpler to
add a new option, as well as to change existing logic consistently for
all of them. It also makes the code shorter by a bit over 500 lines.

There is no intentional user-visible change coming from the refactoring.
osnoise_restore_<opt>() for flag options now sets <opt> instead of
orig_<opt>. As the latter is also set by osnoise_put_<opt>(), plus long
long options set <opt> in both the old and new implementation, the old
behavior was likely a mistake, and should not matter for now, as the
options are only restored once at the end of tracing and neither <opt>
nor orig_<opt> field is read again.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/common.h  |  79 +--
 tools/tracing/rtla/src/osnoise.c | 836 ++++++-------------------------
 tools/tracing/rtla/src/osnoise.h |  22 -
 3 files changed, 188 insertions(+), 749 deletions(-)

diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
index 04b287a03f6d..47233b0781c7 100644
--- a/tools/tracing/rtla/src/common.h
+++ b/tools/tracing/rtla/src/common.h
@@ -6,9 +6,35 @@
 #include "trace.h"
 #include "utils.h"
 
+/*
+ * OSNOISE_LL_OPTIONS - list of long long options backed by tracefs files.
+ *   OSNOISE_LL_OPTION(field_name, tracefs_path, init_value)
+ *
+ * OSNOISE_FLAG_OPTIONS - list of boolean options backed by osnoise/options.
+ *   OSNOISE_FLAG_OPTION(field_name, option_string)
+ */
+#define OSNOISE_LL_OPTIONS \
+	OSNOISE_LL_OPTION(stop_us,		"osnoise/stop_tracing_us",	 OSNOISE_OPTION_INIT_VAL) \
+	OSNOISE_LL_OPTION(stop_total_us,	"osnoise/stop_tracing_total_us", OSNOISE_OPTION_INIT_VAL) \
+	OSNOISE_LL_OPTION(print_stack,		"osnoise/print_stack",		 OSNOISE_OPTION_INIT_VAL) \
+	OSNOISE_LL_OPTION(tracing_thresh,	"tracing_thresh",		 OSNOISE_OPTION_INIT_VAL) \
+	OSNOISE_LL_OPTION(timerlat_period_us,	"osnoise/timerlat_period_us",	 OSNOISE_TIME_INIT_VAL)   \
+	OSNOISE_LL_OPTION(timerlat_align_us,	"osnoise/timerlat_align_us",	 OSNOISE_OPTION_INIT_VAL)
+
+#define OSNOISE_FLAG_OPTIONS \
+	OSNOISE_FLAG_OPTION(irq_disable,	"OSNOISE_IRQ_DISABLE") \
+	OSNOISE_FLAG_OPTION(workload,		"OSNOISE_WORKLOAD") \
+	OSNOISE_FLAG_OPTION(timerlat_align,	"TIMERLAT_ALIGN")
+
 /*
  * osnoise_context - read, store, write, restore osnoise configs.
  */
+#define OSNOISE_LL_OPTION(name, path, init_val)		\
+	long long		orig_##name;		\
+	long long		name;
+#define OSNOISE_FLAG_OPTION(name, option_str)		\
+	int			orig_opt_##name;	\
+	int			opt_##name;
 struct osnoise_context {
 	int			flags;
 	int			ref;
@@ -24,42 +50,11 @@ struct osnoise_context {
 	unsigned long long	orig_period_us;
 	unsigned long long	period_us;
 
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
-
-	/* -1 as init value because 0 is off */
-	int			orig_opt_timerlat_align;
-	int			opt_timerlat_align;
-
-	/* 0 as init value */
-	unsigned long long	orig_timerlat_align_us;
-	unsigned long long	timerlat_align_us;
+	OSNOISE_LL_OPTIONS
+	OSNOISE_FLAG_OPTIONS
 };
+#undef OSNOISE_LL_OPTION
+#undef OSNOISE_FLAG_OPTION
 
 extern volatile int stop_tracing;
 
@@ -173,15 +168,21 @@ common_threshold_handler(const struct osnoise_tool *tool);
 int osnoise_set_cpus(struct osnoise_context *context, char *cpus);
 void osnoise_restore_cpus(struct osnoise_context *context);
 
-int osnoise_set_workload(struct osnoise_context *context, bool onoff);
+#define OSNOISE_LL_OPTION(name, path, init_val)					\
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
 struct osnoise_tool *osnoise_init_trace_tool(const char *tracer);
 bool osnoise_trace_is_off(struct osnoise_tool *tool, struct osnoise_tool *record);
-int osnoise_set_stop_us(struct osnoise_context *context, long long stop_us);
-int osnoise_set_stop_total_us(struct osnoise_context *context,
-			      long long stop_total_us);
 
 int common_apply_config(struct osnoise_tool *tool, struct common_params *params);
 int top_main_loop(struct osnoise_tool *tool);
diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index 4ff5dad013b1..7f15d00b431e 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -345,480 +345,73 @@ void osnoise_put_runtime_period(struct osnoise_context *context)
 }
 
 /*
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
-
-out_err:
-	return OSNOISE_OPTION_INIT_VAL;
-}
-
-/*
- * osnoise_set_tracing_thresh - set "tracing_thresh"
- */
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
- */
-void osnoise_put_tracing_thresh(struct osnoise_context *context)
-{
-	osnoise_restore_tracing_thresh(context);
-
-	if (context->orig_tracing_thresh == OSNOISE_OPTION_INIT_VAL)
-		return;
-
-	context->orig_tracing_thresh = OSNOISE_OPTION_INIT_VAL;
-}
+ * Long long option get/set/restore/put functions, generated from OSNOISE_LL_OPTIONS.
+ */
+#define OSNOISE_LL_OPTION(name, path, init_val)						\
+static long long									\
+osnoise_get_##name(struct osnoise_context *context)					\
+{											\
+	long long name;									\
+											\
+	if (context->name != (init_val))						\
+		return context->name;							\
+											\
+	if (context->orig_##name != (init_val))						\
+		return context->orig_##name;						\
+											\
+	name = osnoise_read_ll_config(path);						\
+	if (name < 0)									\
+		return (init_val);							\
+											\
+	context->orig_##name = name;							\
+	return name;									\
+}											\
+											\
+int osnoise_set_##name(struct osnoise_context *context, long long name)			\
+{											\
+	long long curr = osnoise_get_##name(context);					\
+	int retval;									\
+											\
+	if (curr == (init_val))								\
+		return -1;								\
+											\
+	retval = osnoise_write_ll_config(path, name);					\
+	if (retval < 0)									\
+		return -2;								\
+											\
+	context->name = name;								\
+	return 0;									\
+}											\
+											\
+void osnoise_restore_##name(struct osnoise_context *context)				\
+{											\
+	int retval;									\
+											\
+	if (context->orig_##name == (init_val))						\
+		return;									\
+											\
+	if (context->orig_##name == context->name)					\
+		goto out_done_##name;							\
+											\
+	retval = osnoise_write_ll_config(path, context->orig_##name);			\
+	if (retval < 0)									\
+		err_msg("Could not restore original " #name "\n");			\
+											\
+out_done_##name:									\
+	context->name = (init_val);							\
+}											\
+											\
+static void osnoise_put_##name(struct osnoise_context *context)				\
+{											\
+	osnoise_restore_##name(context);						\
+											\
+	if (context->orig_##name == (init_val))						\
+		return;									\
+											\
+	context->orig_##name = (init_val);						\
+}
+OSNOISE_LL_OPTIONS
+#undef OSNOISE_LL_OPTION
 
 static int osnoise_options_get_option(char *option)
 {
@@ -866,188 +459,70 @@ static int osnoise_options_set_option(char *option, bool onoff)
 	return tracefs_instance_file_write(NULL, "osnoise/options", no_option);
 }
 
-static int osnoise_get_irq_disable(struct osnoise_context *context)
-{
-	if (context->opt_irq_disable != OSNOISE_OPTION_INIT_VAL)
-		return context->opt_irq_disable;
-
-	if (context->orig_opt_irq_disable != OSNOISE_OPTION_INIT_VAL)
-		return context->orig_opt_irq_disable;
-
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
-	if (retval < 0)
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
-
-	context->orig_opt_workload = osnoise_options_get_option("OSNOISE_WORKLOAD");
-
-	return context->orig_opt_workload;
-}
-
-int osnoise_set_workload(struct osnoise_context *context, bool onoff)
-{
-	int opt_workload = osnoise_get_workload(context);
-	int retval;
-
-	if (opt_workload == OSNOISE_OPTION_INIT_VAL)
-		return -1;
-
-	if (opt_workload == onoff)
-		return 0;
-
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
-
-	retval = osnoise_options_set_option("TIMERLAT_ALIGN", onoff);
-	if (retval < 0)
-		return -2;
-
-	context->opt_timerlat_align = onoff;
-
-	return 0;
-}
-
-static void osnoise_restore_timerlat_align(struct osnoise_context *context)
-{
-	int retval;
-
-	if (context->orig_opt_timerlat_align == OSNOISE_OPTION_INIT_VAL)
-		return;
-
-	if (context->orig_opt_timerlat_align == context->opt_timerlat_align)
-		goto out_done;
-
-	retval = osnoise_options_set_option("TIMERLAT_ALIGN", context->orig_opt_timerlat_align);
-	if (retval < 0)
-		err_msg("Could not restore original TIMERLAT_ALIGN option\n");
-
-out_done:
-	context->orig_opt_timerlat_align = OSNOISE_OPTION_INIT_VAL;
-}
-
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
+ * Flag option get/set/restore/put functions, generated from OSNOISE_FLAG_OPTIONS.
+ */
+#define OSNOISE_FLAG_OPTION(name, option_str)						\
+static int osnoise_get_##name(struct osnoise_context *context)				\
+{											\
+	if (context->opt_##name != OSNOISE_OPTION_INIT_VAL)				\
+		return context->opt_##name;						\
+											\
+	if (context->orig_opt_##name != OSNOISE_OPTION_INIT_VAL)			\
+		return context->orig_opt_##name;					\
+											\
+	context->orig_opt_##name = osnoise_options_get_option(option_str);		\
+	return context->orig_opt_##name;						\
+}											\
+											\
+int osnoise_set_##name(struct osnoise_context *context, bool onoff)			\
+{											\
+	int val = osnoise_get_##name(context);						\
+	int retval;									\
+											\
+	if (val == OSNOISE_OPTION_INIT_VAL)						\
+		return -1;								\
+											\
+	if (val == onoff)								\
+		return 0;								\
+											\
+	retval = osnoise_options_set_option(option_str, onoff);				\
+	if (retval < 0)									\
+		return -2;								\
+											\
+	context->opt_##name = onoff;							\
+	return 0;									\
+}											\
+											\
+void osnoise_restore_##name(struct osnoise_context *context)				\
+{											\
+	int retval;									\
+											\
+	if (context->orig_opt_##name == OSNOISE_OPTION_INIT_VAL)			\
+		return;									\
+											\
+	if (context->orig_opt_##name == context->opt_##name)				\
+		goto out_done_##name;							\
+											\
+	retval = osnoise_options_set_option(option_str, context->orig_opt_##name);	\
+	if (retval < 0)									\
+		err_msg("Could not restore original " option_str " option\n");		\
+											\
+out_done_##name:									\
+	context->opt_##name = OSNOISE_OPTION_INIT_VAL;					\
+}											\
+											\
+static void osnoise_put_##name(struct osnoise_context *context)				\
+{											\
+	osnoise_restore_##name(context);						\
+											\
+	if (context->orig_opt_##name == OSNOISE_OPTION_INIT_VAL)			\
+		return;									\
+											\
+	context->orig_opt_##name = OSNOISE_OPTION_INIT_VAL;				\
+}
+OSNOISE_FLAG_OPTIONS
+#undef OSNOISE_FLAG_OPTION
 
 enum {
 	FLAG_CONTEXT_NEWLY_CREATED	= (1 << 0),
@@ -1083,29 +558,16 @@ struct osnoise_context *osnoise_context_alloc(void)
 
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
+#define OSNOISE_LL_OPTION(name, path, init_val)			\
+	context->orig_##name	 = (init_val);			\
+	context->name		 = (init_val);
+#define OSNOISE_FLAG_OPTION(name, option_str)			\
+	context->orig_opt_##name = OSNOISE_OPTION_INIT_VAL; 	\
+	context->opt_##name	 = OSNOISE_OPTION_INIT_VAL;
+	OSNOISE_LL_OPTIONS
+	OSNOISE_FLAG_OPTIONS
+#undef OSNOISE_LL_OPTION
+#undef OSNOISE_FLAG_OPTION
 
 	osnoise_get_context(context);
 
@@ -1128,15 +590,13 @@ void osnoise_put_context(struct osnoise_context *context)
 
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
+#define OSNOISE_LL_OPTION(name, path, init_val)	osnoise_put_##name(context);
+#define OSNOISE_FLAG_OPTION(name, option_str)	osnoise_put_##name(context);
+	OSNOISE_LL_OPTIONS
+	OSNOISE_FLAG_OPTIONS
+#undef OSNOISE_LL_OPTION
+#undef OSNOISE_FLAG_OPTION
 
 	free(context);
 }
diff --git a/tools/tracing/rtla/src/osnoise.h b/tools/tracing/rtla/src/osnoise.h
index 340ff5a64e6e..3d1852bffed8 100644
--- a/tools/tracing/rtla/src/osnoise.h
+++ b/tools/tracing/rtla/src/osnoise.h
@@ -34,28 +34,6 @@ int osnoise_set_runtime_period(struct osnoise_context *context,
 			       unsigned long long period);
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
 void osnoise_report_missed_events(struct osnoise_tool *tool);
 int osnoise_apply_config(struct osnoise_tool *tool, struct osnoise_params *params);
 
-- 
2.54.0


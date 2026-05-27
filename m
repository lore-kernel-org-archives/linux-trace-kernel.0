Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504C0372EC2
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 14:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893386; cv=none; b=s/eAywTID1vtakNS/NnOPqxNYIcHIblTxLo3s+93Wzt+WVGbRvKx9qFekTz98nxrPW3KgYpKUJOr3/RvSc+gl3Giil2yFro/NTMnhlXCdUqCcJ5NiVedilysad7eWz3dTTxHgKIMLa/P+++36RpySLQ6OD6GGQim49VS0F6WoxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893386; c=relaxed/simple;
	bh=+OTAd2oFka6g1F+aHZqntgCnjMfo6wl3MepB37X+2RM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=jqf227mXyZTmGTX3RHCuomHt9TXs2ELzfvaK03EWDTwaAyhwEBdfs0tIr/A0MzReMAzlBrYxqgG36PPAx7rwluoT3ZHsI7lI/VX4CrrebeY0MqNlio3ZLX3+5N6dk4uNsU31m9DCwxjmqvLG91uoznYfbvFye2h9QHX/efq6OM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M8Zq+YQ/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8Zq+YQ/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779893382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qFBT2F2+rhLK28T4bY48db2PEN1QE/KqSocLDx5/Na8=;
	b=M8Zq+YQ/ajFHH3127mhoDcowZa/K7VJFkgdHyu+pXlXjnUxZj5FwLWxAI9zcnZNcVTcTA2
	iwInYQV7uHqlc//1VJaYwwGnRXFJPqCgqQ2FOwMy/lmcBfNEwYdjEHRJnQwY3orJc1/s/7
	w5GMfQm7ZCVoNwjglPVWEoeW9tnf/kw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-L7OnR_w-PyCtAzpbVR1zvg-1; Wed,
 27 May 2026 10:49:40 -0400
X-MC-Unique: L7OnR_w-PyCtAzpbVR1zvg-1
X-Mimecast-MFC-AGG-ID: L7OnR_w-PyCtAzpbVR1zvg_1779893379
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A35E195609F;
	Wed, 27 May 2026 14:49:39 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.34.21])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C08601800576;
	Wed, 27 May 2026 14:49:35 +0000 (UTC)
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
Subject: [PATCH 1/3] rtla/timerlat: Add -A/--aligned CLI option
Date: Wed, 27 May 2026 16:49:26 +0200
Message-ID: <20260527144928.2944472-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 4CaGOZ-umwdrxAuhzDmuL3uqS2Kwyu9646GKzxPkhAY_1779893379
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add a new option, -A/--aligned, that enables timerlat thread alignment
implemented on the kernel-side in commit 4245bf4dc58f ("tracing/osnoise:
Add option to align tlat threads"). The option takes an argument,
representing alignment between timerlat threads in microseconds.

The feature is modeled after the option of the same name in the
cyclictest tool.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---

This patchset depends on "rtla: Migrate to libsubcmd for command line option parsing"
- https://lore.kernel.org/linux-trace-kernel/20260521141833.2353025-1-tglozar@redhat.com/T/
as it uses the new CLI implementation. That in turn depends on the test patches:
- https://lore.kernel.org/linux-trace-kernel/20260423130558.882022-1-tglozar@redhat.com/T/
- https://lore.kernel.org/linux-trace-kernel/20260424140244.958495-1-tglozar@redhat.com/
as it touches tests, as well as a fix touching the CLI:
- https://lore.kernel.org/linux-trace-kernel/20260414185223.65353-1-costa.shul@redhat.com/

 tools/tracing/rtla/src/cli.c      |   2 +
 tools/tracing/rtla/src/cli_p.h    |  17 ++++
 tools/tracing/rtla/src/common.h   |   8 ++
 tools/tracing/rtla/src/osnoise.c  | 149 ++++++++++++++++++++++++++++++
 tools/tracing/rtla/src/osnoise.h  |   6 ++
 tools/tracing/rtla/src/timerlat.c |  18 ++++
 tools/tracing/rtla/src/timerlat.h |   2 +
 7 files changed, 202 insertions(+)

diff --git a/tools/tracing/rtla/src/cli.c b/tools/tracing/rtla/src/cli.c
index 709219341a56..c5279c987531 100644
--- a/tools/tracing/rtla/src/cli.c
+++ b/tools/tracing/rtla/src/cli.c
@@ -248,6 +248,7 @@ struct common_params *timerlat_top_parse_args(int argc, char **argv)
 		RTLA_OPT_USER_THREADS,
 		RTLA_OPT_KERNEL_THREADS,
 		RTLA_OPT_USER_LOAD,
+		TIMERLAT_OPT_ALIGNED,
 
 	OPT_GROUP("Output:"),
 		TIMERLAT_OPT_NANO,
@@ -362,6 +363,7 @@ struct common_params *timerlat_hist_parse_args(int argc, char **argv)
 		RTLA_OPT_USER_THREADS,
 		RTLA_OPT_KERNEL_THREADS,
 		RTLA_OPT_USER_LOAD,
+		TIMERLAT_OPT_ALIGNED,
 
 	OPT_GROUP("Histogram Options:"),
 		HIST_OPT_BUCKET_SIZE,
diff --git a/tools/tracing/rtla/src/cli_p.h b/tools/tracing/rtla/src/cli_p.h
index 3cea4f6e976e..3c939de9abf0 100644
--- a/tools/tracing/rtla/src/cli_p.h
+++ b/tools/tracing/rtla/src/cli_p.h
@@ -447,6 +447,10 @@ static int opt_osnoise_on_end_cb(const struct option *opt, const char *arg, int
 	"set the stack format (truncate, skip, full)", \
 	opt_stack_format_cb)
 
+#define TIMERLAT_OPT_ALIGNED OPT_CALLBACK('A', "aligned", params, "us", \
+	"align thread wakeups to a specific offset", \
+	opt_timerlat_align_cb)
+
 /*
  * Callback functions for command line options for timerlat tools
  */
@@ -608,6 +612,19 @@ static int opt_stack_format_cb(const struct option *opt, const char *arg, int un
 	return 0;
 }
 
+static int opt_timerlat_align_cb(const struct option *opt, const char *arg, int unset)
+{
+	struct timerlat_params *params = opt->value;
+
+	if (unset || !arg)
+		return -1;
+
+	params->timerlat_align = true;
+	params->timerlat_align_us = get_llong_from_str((char *)arg);
+
+	return 0;
+}
+
 /*
  * Macros for command line options specific to histogram-based tools
  */
diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
index 0dfca83bd726..04b287a03f6d 100644
--- a/tools/tracing/rtla/src/common.h
+++ b/tools/tracing/rtla/src/common.h
@@ -51,6 +51,14 @@ struct osnoise_context {
 	/* -1 as init value because 0 is off */
 	int			orig_opt_workload;
 	int			opt_workload;
+
+	/* -1 as init value because 0 is off */
+	int			orig_opt_timerlat_align;
+	int			opt_timerlat_align;
+
+	/* 0 as init value */
+	unsigned long long	orig_timerlat_align_us;
+	unsigned long long	timerlat_align_us;
 };
 
 extern volatile int stop_tracing;
diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index e1e32898af2d..4ff5dad013b1 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -423,6 +423,86 @@ void osnoise_put_timerlat_period_us(struct osnoise_context *context)
 	context->orig_timerlat_period_us = OSNOISE_TIME_INIT_VAL;
 }
 
+/*
+ * osnoise_get_timerlat_align_us - read and save the original "timerlat_align_us"
+ */
+static long long
+osnoise_get_timerlat_align_us(struct osnoise_context *context)
+{
+	long long timerlat_align_us;
+
+	if (context->timerlat_align_us != OSNOISE_OPTION_INIT_VAL)
+		return context->timerlat_align_us;
+
+	if (context->orig_timerlat_align_us != OSNOISE_OPTION_INIT_VAL)
+		return context->orig_timerlat_align_us;
+
+	timerlat_align_us = osnoise_read_ll_config("osnoise/timerlat_align_us");
+	if (timerlat_align_us < 0)
+		goto out_err;
+
+	context->orig_timerlat_align_us = timerlat_align_us;
+	return timerlat_align_us;
+
+out_err:
+	return OSNOISE_OPTION_INIT_VAL;
+}
+
+/*
+ * osnoise_set_timerlat_align_us - set "timerlat_align_us"
+ */
+int osnoise_set_timerlat_align_us(struct osnoise_context *context, long long timerlat_align_us)
+{
+	long long curr_timerlat_align_us = osnoise_get_timerlat_align_us(context);
+	int retval;
+
+	if (curr_timerlat_align_us == OSNOISE_OPTION_INIT_VAL)
+		return -1;
+
+	retval = osnoise_write_ll_config("osnoise/timerlat_align_us", timerlat_align_us);
+	if (retval < 0)
+		return -1;
+
+	context->timerlat_align_us = timerlat_align_us;
+
+	return 0;
+}
+
+/*
+ * osnoise_restore_timerlat_align_us - restore "timerlat_align_us"
+ */
+void osnoise_restore_timerlat_align_us(struct osnoise_context *context)
+{
+	int retval;
+
+	if (context->orig_timerlat_align_us == OSNOISE_OPTION_INIT_VAL)
+		return;
+
+	if (context->orig_timerlat_align_us == context->timerlat_align_us)
+		goto out_done;
+
+	retval = osnoise_write_ll_config("osnoise/timerlat_align_us",
+				   context->orig_timerlat_align_us);
+	if (retval < 0)
+		err_msg("Could not restore original osnoise timerlat_align_us\n");
+
+out_done:
+	context->timerlat_align_us = OSNOISE_OPTION_INIT_VAL;
+}
+
+/*
+ * osnoise_put_timerlat_align_us - restore original values and cleanup data
+ */
+void osnoise_put_timerlat_align_us(struct osnoise_context *context)
+{
+	osnoise_restore_timerlat_align_us(context);
+
+	if (context->orig_timerlat_align_us == OSNOISE_OPTION_INIT_VAL)
+		return;
+
+	context->orig_timerlat_align_us = OSNOISE_OPTION_INIT_VAL;
+}
+
 /*
  * osnoise_get_stop_us - read and save the original "stop_tracing_us"
  */
@@ -908,6 +988,67 @@ static void osnoise_put_workload(struct osnoise_context *context)
 	context->orig_opt_workload = OSNOISE_OPTION_INIT_VAL;
 }
 
+static int osnoise_get_timerlat_align(struct osnoise_context *context)
+{
+	if (context->opt_timerlat_align != OSNOISE_OPTION_INIT_VAL)
+		return context->opt_timerlat_align;
+
+	if (context->orig_opt_timerlat_align != OSNOISE_OPTION_INIT_VAL)
+		return context->orig_opt_timerlat_align;
+
+	context->orig_opt_timerlat_align = osnoise_options_get_option("TIMERLAT_ALIGN");
+
+	return context->orig_opt_timerlat_align;
+}
+
+int osnoise_set_timerlat_align(struct osnoise_context *context, bool onoff)
+{
+	int opt_timerlat_align = osnoise_get_timerlat_align(context);
+	int retval;
+
+	if (opt_timerlat_align == OSNOISE_OPTION_INIT_VAL)
+		return -1;
+
+	if (opt_timerlat_align == onoff)
+		return 0;
+
+	retval = osnoise_options_set_option("TIMERLAT_ALIGN", onoff);
+	if (retval < 0)
+		return -2;
+
+	context->opt_timerlat_align = onoff;
+
+	return 0;
+}
+
+static void osnoise_restore_timerlat_align(struct osnoise_context *context)
+{
+	int retval;
+
+	if (context->orig_opt_timerlat_align == OSNOISE_OPTION_INIT_VAL)
+		return;
+
+	if (context->orig_opt_timerlat_align == context->opt_timerlat_align)
+		goto out_done;
+
+	retval = osnoise_options_set_option("TIMERLAT_ALIGN", context->orig_opt_timerlat_align);
+	if (retval < 0)
+		err_msg("Could not restore original TIMERLAT_ALIGN option\n");
+
+out_done:
+	context->orig_opt_timerlat_align = OSNOISE_OPTION_INIT_VAL;
+}
+
+static void osnoise_put_timerlat_align(struct osnoise_context *context)
+{
+	osnoise_restore_timerlat_align(context);
+
+	if (context->orig_opt_timerlat_align == OSNOISE_OPTION_INIT_VAL)
+		return;
+
+	context->orig_opt_timerlat_align = OSNOISE_OPTION_INIT_VAL;
+}
+
 enum {
 	FLAG_CONTEXT_NEWLY_CREATED	= (1 << 0),
 	FLAG_CONTEXT_DELETED		= (1 << 1),
@@ -960,6 +1101,12 @@ struct osnoise_context *osnoise_context_alloc(void)
 	context->orig_opt_workload	= OSNOISE_OPTION_INIT_VAL;
 	context->opt_workload		= OSNOISE_OPTION_INIT_VAL;
 
+	context->orig_opt_timerlat_align	= OSNOISE_OPTION_INIT_VAL;
+	context->opt_timerlat_align		= OSNOISE_OPTION_INIT_VAL;
+
+	context->orig_timerlat_align_us	= OSNOISE_OPTION_INIT_VAL;
+	context->timerlat_align_us	= OSNOISE_OPTION_INIT_VAL;
+
 	osnoise_get_context(context);
 
 	return context;
@@ -988,6 +1135,8 @@ void osnoise_put_context(struct osnoise_context *context)
 	osnoise_put_tracing_thresh(context);
 	osnoise_put_irq_disable(context);
 	osnoise_put_workload(context);
+	osnoise_put_timerlat_align(context);
+	osnoise_put_timerlat_align_us(context);
 
 	free(context);
 }
diff --git a/tools/tracing/rtla/src/osnoise.h b/tools/tracing/rtla/src/osnoise.h
index 168669aa7e0d..340ff5a64e6e 100644
--- a/tools/tracing/rtla/src/osnoise.h
+++ b/tools/tracing/rtla/src/osnoise.h
@@ -49,6 +49,12 @@ void osnoise_restore_print_stack(struct osnoise_context *context);
 int osnoise_set_print_stack(struct osnoise_context *context,
 			    long long print_stack);
 
+int osnoise_set_timerlat_align_us(struct osnoise_context *context,
+				  long long timerlat_align_us);
+void osnoise_restore_timerlat_align_us(struct osnoise_context *context);
+
+int osnoise_set_timerlat_align(struct osnoise_context *context, bool onoff);
+
 int osnoise_set_irq_disable(struct osnoise_context *context, bool onoff);
 void osnoise_report_missed_events(struct osnoise_tool *tool);
 int osnoise_apply_config(struct osnoise_tool *tool, struct osnoise_params *params);
diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index f990c8365776..169aa9a6569d 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -77,6 +77,24 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 		goto out_err;
 	}
 
+	retval = osnoise_set_timerlat_align(tool->context, params->timerlat_align);
+	if (retval && params->timerlat_align) {
+		/*
+		 * We might be running on a kernel that does not support timerlat align.
+		 * Unless user requested it explicitly, ignore the error.
+		 */
+		err_msg("Failed to enable timerlat align\n");
+		goto out_err;
+	}
+
+	if (params->timerlat_align) {
+		retval = osnoise_set_timerlat_align_us(tool->context, params->timerlat_align_us);
+		if (retval) {
+			err_msg("Failed to set timerlat align us\n");
+			goto out_err;
+		}
+	}
+
 	/*
 	 * If the user did not specify a type of thread, try user-threads first.
 	 * Fall back to kernel threads otherwise.
diff --git a/tools/tracing/rtla/src/timerlat.h b/tools/tracing/rtla/src/timerlat.h
index 38ab6b41a15e..84ec6d778183 100644
--- a/tools/tracing/rtla/src/timerlat.h
+++ b/tools/tracing/rtla/src/timerlat.h
@@ -31,6 +31,8 @@ struct timerlat_params {
 	enum timerlat_tracing_mode mode;
 	const char		*bpf_action_program;
 	enum stack_format	stack_format;
+	bool			timerlat_align;
+	unsigned long long	timerlat_align_us;
 };
 
 #define to_timerlat_params(ptr) container_of(ptr, struct timerlat_params, common)
-- 
2.54.0


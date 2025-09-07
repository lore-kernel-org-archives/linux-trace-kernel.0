Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FA11A9B58
	for <linux-trace-kernel@vger.kernel.org>; Sun,  7 Sep 2025 02:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757211832; cv=none; b=f9cBSKkWVCoh2PWA0QRTb+pi23s72gpkDDXHGRhntRVPGraxOTvQav6lOoLhxWkdE1BRNh3uO1ptpXODxIQbP5OzjZD0wKlNe+aQSltk+KQwixzJkF+Hs6KvT1UhHllu2gEln5A+bJ+bdBbkSQwFAVAghVclCSzybCw5D09hGTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757211832; c=relaxed/simple;
	bh=fhgQ6vBsp/BNiGFnTvlN92++xwJLCC/TvYqb935/J2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=FQ5CEvJ/uBxuoBAbpcu8iHRgl5oop06mw4ZjPTdsKZc7NbJuY1MSHiLXrCTRfuiU6QMvvlPHVzF27oBKpEkqKpoZ9+q2qkXIvIsx0Mxwriye6y3qgLJ2YbiVwnVRC9g5FuU6cJSiwAC+caYt2vDFqAecxCWl0LNxI1EMer8dh80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E38PUMxu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E38PUMxu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757211829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPARyrwhIqjTH9gMgnev5wKJmUVwYBuJjvMIkNRXvGw=;
	b=E38PUMxuAehLKD5MKsxsDvnJ1R+anB/JLKTxUs9L+OGl1+T9T4S4IbDQTEdIHS0dkZQ938
	WREj5tztG8CIA5MtaSjpE4Hc/cCgKigdOUF2k+6Tv5t4OEL539JB1aYKPWPweh4lzd6Hif
	kMWphSA9+U/91m5gbKaB7yBeWAasdOs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-RDBS6zmrP0qxqIxvBDBw0A-1; Sat, 06 Sep 2025 22:23:48 -0400
X-MC-Unique: RDBS6zmrP0qxqIxvBDBw0A-1
X-Mimecast-MFC-AGG-ID: RDBS6zmrP0qxqIxvBDBw0A_1757211828
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b5fbf0388eso11637141cf.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 06 Sep 2025 19:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757211828; x=1757816628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPARyrwhIqjTH9gMgnev5wKJmUVwYBuJjvMIkNRXvGw=;
        b=p/pK0qkaHHiXObgFAS9y6qON7yLxMbvRrfCRjbxG2j6OuDsWqy1eHH7WCFj+yuOGKu
         7NHoe3LPGah0RIJz8YWQugKLaB6cTk3hjFCb6BHoFn/DwoumZT6bcUke38pjFdxJQNvp
         0j4hhpUyws5iUxUI0gs2WJ8gR310aixYQH8W8lzmocwF6+HKQRM2W2tHhSSI9VIfILz/
         CYACcxg7RBrM3WOuPY1MUCY5DogMvcs6sIYq4Bceb3MzcpElzvk2edaivmbM7QnDxwcW
         /wRWI7c3NejBbQUCnZSOOK1vwZ6P0Sehk2y1hTCn5+EAVWkIqFMbCwXTHO73UciX86qo
         VwkA==
X-Gm-Message-State: AOJu0YzXacQbJGIRNtOfQMJGdWhB9VDBe6khvt8tvytQd8c/+Vo0Wch1
	+BaC/yN80okZiwS+wx7nSlL/fqDu/nEpia0gGJfVVNc5bIkWBFG0xkEgaKmiCAOFSPW97T+mSV9
	cXuk1Xa0hi3mP1vaLNfe43lZJttjBuuRXUygYXzVcXofYqXU5Hgr7vUjChm3wGAeeXEGmsLyuew
	==
X-Gm-Gg: ASbGnctPpdY05b4NYTJKferJqtBBCQLU9lj5DJ8bXYTcOzIeERvpvIfef+TVrGUkgeM
	998ggwMv/TGUq0NuMNw64xuyyyZPQxMBooPxpX9+nWdqpo26F+9DpH68lKZdlrr7stN8q0m5rNu
	hcus6DDXK+Q9LZ+/n7MdFS3E0i11nxb9TdfixTCLQOMgecimcJQlxnGW0SJj/FRlY+C3jFn1z1e
	GxhFbos5Y718WeG7J5ebC+gQOwVpeQ8UfY5BlG3uM8COIKu482/gVjZlLL/Z1vXcgIj6JMYCGj1
	HamO+/srzOyVrPxcU7O9AE19gmmlInj+6eyw8gk5gcBJWM77IhTaHFeYY4yErKGQ/yWyFi0=
X-Received: by 2002:ac8:5f06:0:b0:4b5:dc7c:a6ef with SMTP id d75a77b69052e-4b5f8426159mr43751051cf.50.1757211827348;
        Sat, 06 Sep 2025 19:23:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0o2A+3R7ejlM7n/kGZL3e6Qtnh7yJYh4fz8ntovtzMur1jy4y0S2rbeei3teyXvBJcgtgWg==
X-Received: by 2002:ac8:5f06:0:b0:4b5:dc7c:a6ef with SMTP id d75a77b69052e-4b5f8426159mr43750871cf.50.1757211826747;
        Sat, 06 Sep 2025 19:23:46 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f673fecsm71105401cf.21.2025.09.06.19.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 19:23:46 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v2 3/7] tools/rtla: Create common_apply_config()
Date: Sat,  6 Sep 2025 21:23:21 -0500
Message-ID: <20250907022325.243930-4-crwood@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250907022325.243930-1-crwood@redhat.com>
References: <20250907022325.243930-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _sWsScmopv4Uni0AV8ZRcnDV7o4eHLx6GArBNzAXC_c_1757211828
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Merge the common bits of osnoise_apply_config() and
timerlat_apply_config().  Put the result in a new common.c, and move
enough things to common.h so that common.c does not need to include
osnoise.h.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
v2: Removed blank line after SPDX comment
---
 tools/tracing/rtla/src/Build           |  1 +
 tools/tracing/rtla/src/common.c        | 63 ++++++++++++++++++++++++
 tools/tracing/rtla/src/common.h        | 67 ++++++++++++++++++++++++++
 tools/tracing/rtla/src/osnoise.c       | 37 ++------------
 tools/tracing/rtla/src/osnoise.h       | 64 ------------------------
 tools/tracing/rtla/src/timerlat.c      | 51 ++------------------
 tools/tracing/rtla/src/timerlat.h      |  1 -
 tools/tracing/rtla/src/timerlat_hist.c |  4 +-
 tools/tracing/rtla/src/timerlat_top.c  |  4 +-
 9 files changed, 142 insertions(+), 150 deletions(-)
 create mode 100644 tools/tracing/rtla/src/common.c

diff --git a/tools/tracing/rtla/src/Build b/tools/tracing/rtla/src/Build
index 66631280b75b..329e24a40cf7 100644
--- a/tools/tracing/rtla/src/Build
+++ b/tools/tracing/rtla/src/Build
@@ -1,6 +1,7 @@
 rtla-y += trace.o
 rtla-y += utils.o
 rtla-y += actions.o
+rtla-y += common.o
 rtla-y += osnoise.o
 rtla-y += osnoise_top.o
 rtla-y += osnoise_hist.o
diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
new file mode 100644
index 000000000000..32a6faffc714
--- /dev/null
+++ b/tools/tracing/rtla/src/common.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+
+#include <unistd.h>
+#include "common.h"
+
+/*
+ * common_apply_config - apply common configs to the initialized tool
+ */
+int
+common_apply_config(struct osnoise_tool *tool, struct common_params *params)
+{
+	int retval, i;
+
+	if (!params->sleep_time)
+		params->sleep_time = 1;
+
+	retval = osnoise_set_cpus(tool->context, params->cpus ? params->cpus : "all");
+	if (retval) {
+		err_msg("Failed to apply CPUs config\n");
+		goto out_err;
+	}
+
+	if (!params->cpus) {
+		for (i = 0; i < sysconf(_SC_NPROCESSORS_CONF); i++)
+			CPU_SET(i, &params->monitored_cpus);
+	}
+
+	if (params->hk_cpus) {
+		retval = sched_setaffinity(getpid(), sizeof(params->hk_cpu_set),
+					   &params->hk_cpu_set);
+		if (retval == -1) {
+			err_msg("Failed to set rtla to the house keeping CPUs\n");
+			goto out_err;
+		}
+	} else if (params->cpus) {
+		/*
+		 * Even if the user do not set a house-keeping CPU, try to
+		 * move rtla to a CPU set different to the one where the user
+		 * set the workload to run.
+		 *
+		 * No need to check results as this is an automatic attempt.
+		 */
+		auto_house_keeping(&params->monitored_cpus);
+	}
+
+	/*
+	 * Set workload according to type of thread if the kernel supports it.
+	 * On kernels without support, user threads will have already failed
+	 * on missing fd, and kernel threads do not need it.
+	 */
+	retval = osnoise_set_workload(tool->context, params->kernel_workload);
+	if (retval < -1) {
+		err_msg("Failed to set OSNOISE_WORKLOAD option\n");
+		goto out_err;
+	}
+
+	return 0;
+
+out_err:
+	return -1;
+}
+
diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
index 276dfbc7f955..c306ba502688 100644
--- a/tools/tracing/rtla/src/common.h
+++ b/tools/tracing/rtla/src/common.h
@@ -1,8 +1,67 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #pragma once
 
+#include "trace.h"
 #include "utils.h"
 
+/*
+ * osnoise_context - read, store, write, restore osnoise configs.
+ */
+struct osnoise_context {
+	int			flags;
+	int			ref;
+
+	char			*curr_cpus;
+	char			*orig_cpus;
+
+	/* 0 as init value */
+	unsigned long long	orig_runtime_us;
+	unsigned long long	runtime_us;
+
+	/* 0 as init value */
+	unsigned long long	orig_period_us;
+	unsigned long long	period_us;
+
+	/* 0 as init value */
+	long long		orig_timerlat_period_us;
+	long long		timerlat_period_us;
+
+	/* 0 as init value */
+	long long		orig_tracing_thresh;
+	long long		tracing_thresh;
+
+	/* -1 as init value because 0 is disabled */
+	long long		orig_stop_us;
+	long long		stop_us;
+
+	/* -1 as init value because 0 is disabled */
+	long long		orig_stop_total_us;
+	long long		stop_total_us;
+
+	/* -1 as init value because 0 is disabled */
+	long long		orig_print_stack;
+	long long		print_stack;
+
+	/* -1 as init value because 0 is off */
+	int			orig_opt_irq_disable;
+	int			opt_irq_disable;
+
+	/* -1 as init value because 0 is off */
+	int			orig_opt_workload;
+	int			opt_workload;
+};
+
+/*
+ * osnoise_tool -  osnoise based tool definition.
+ */
+struct osnoise_tool {
+	struct trace_instance		trace;
+	struct osnoise_context		*context;
+	void				*data;
+	void				*params;
+	time_t				start_time;
+};
+
 struct hist_params {
 	char			no_irq;
 	char			no_thread;
@@ -44,4 +103,12 @@ struct common_params {
 	int			output_divisor;
 	int			pretty_output;
 	int			quiet;
+	int			kernel_workload;
 };
+
+int osnoise_set_cpus(struct osnoise_context *context, char *cpus);
+void osnoise_restore_cpus(struct osnoise_context *context);
+
+int osnoise_set_workload(struct osnoise_context *context, bool onoff);
+
+int common_apply_config(struct osnoise_tool *tool, struct common_params *params);
diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index 06ae7437c2c7..4051b21db69a 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -1120,21 +1120,14 @@ osnoise_report_missed_events(struct osnoise_tool *tool)
 }
 
 /*
- * osnoise_apply_config - apply common configs to the initialized tool
+ * osnoise_apply_config - apply osnoise configs to the initialized tool
  */
 int
 osnoise_apply_config(struct osnoise_tool *tool, struct osnoise_params *params)
 {
 	int retval;
 
-	if (!params->common.sleep_time)
-		params->common.sleep_time = 1;
-
-	retval = osnoise_set_cpus(tool->context, params->common.cpus ? params->common.cpus : "all");
-	if (retval) {
-		err_msg("Failed to apply CPUs config\n");
-		goto out_err;
-	}
+	params->common.kernel_workload = true;
 
 	if (params->runtime || params->period) {
 		retval = osnoise_set_runtime_period(tool->context,
@@ -1169,31 +1162,7 @@ osnoise_apply_config(struct osnoise_tool *tool, struct osnoise_params *params)
 		goto out_err;
 	}
 
-	if (params->common.hk_cpus) {
-		retval = sched_setaffinity(getpid(), sizeof(params->common.hk_cpu_set),
-					   &params->common.hk_cpu_set);
-		if (retval == -1) {
-			err_msg("Failed to set rtla to the house keeping CPUs\n");
-			goto out_err;
-		}
-	} else if (params->common.cpus) {
-		/*
-		 * Even if the user do not set a house-keeping CPU, try to
-		 * move rtla to a CPU set different to the one where the user
-		 * set the workload to run.
-		 *
-		 * No need to check results as this is an automatic attempt.
-		 */
-		auto_house_keeping(&params->common.monitored_cpus);
-	}
-
-	retval = osnoise_set_workload(tool->context, true);
-	if (retval < -1) {
-		err_msg("Failed to set OSNOISE_WORKLOAD option\n");
-		goto out_err;
-	}
-
-	return 0;
+	return common_apply_config(tool, &params->common);
 
 out_err:
 	return -1;
diff --git a/tools/tracing/rtla/src/osnoise.h b/tools/tracing/rtla/src/osnoise.h
index b64b39de97b5..25baf46a2520 100644
--- a/tools/tracing/rtla/src/osnoise.h
+++ b/tools/tracing/rtla/src/osnoise.h
@@ -2,7 +2,6 @@
 #pragma once
 
 #include "common.h"
-#include "trace.h"
 
 enum osnoise_mode {
 	MODE_OSNOISE = 0,
@@ -18,53 +17,6 @@ struct osnoise_params {
 	enum osnoise_mode	mode;
 };
 
-/*
- * osnoise_context - read, store, write, restore osnoise configs.
- */
-struct osnoise_context {
-	int			flags;
-	int			ref;
-
-	char			*curr_cpus;
-	char			*orig_cpus;
-
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
-};
-
 /*
  * *_INIT_VALs are also invalid values, they are used to
  * communicate errors.
@@ -76,9 +28,6 @@ struct osnoise_context *osnoise_context_alloc(void);
 int osnoise_get_context(struct osnoise_context *context);
 void osnoise_put_context(struct osnoise_context *context);
 
-int osnoise_set_cpus(struct osnoise_context *context, char *cpus);
-void osnoise_restore_cpus(struct osnoise_context *context);
-
 int osnoise_set_runtime_period(struct osnoise_context *context,
 			       unsigned long long runtime,
 			       unsigned long long period);
@@ -105,19 +54,6 @@ int osnoise_set_print_stack(struct osnoise_context *context,
 			    long long print_stack);
 
 int osnoise_set_irq_disable(struct osnoise_context *context, bool onoff);
-int osnoise_set_workload(struct osnoise_context *context, bool onoff);
-
-/*
- * osnoise_tool -  osnoise based tool definition.
- */
-struct osnoise_tool {
-	struct trace_instance		trace;
-	struct osnoise_context		*context;
-	void				*data;
-	void				*params;
-	time_t				start_time;
-};
-
 void osnoise_destroy_tool(struct osnoise_tool *top);
 struct osnoise_tool *osnoise_init_tool(char *tool_name);
 struct osnoise_tool *osnoise_init_trace_tool(char *tracer);
diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index 0b2f03e1e612..e4bf58db1dd2 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -24,21 +24,7 @@
 int
 timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 {
-	int retval, i;
-
-	if (!params->common.sleep_time)
-		params->common.sleep_time = 1;
-
-	retval = osnoise_set_cpus(tool->context, params->common.cpus ? params->common.cpus : "all");
-	if (retval) {
-		err_msg("Failed to apply CPUs config\n");
-		goto out_err;
-	}
-
-	if (!params->common.cpus) {
-		for (i = 0; i < sysconf(_SC_NPROCESSORS_CONF); i++)
-			CPU_SET(i, &params->common.monitored_cpus);
-	}
+	int retval;
 
 	if (params->mode != TRACING_MODE_BPF) {
 		/*
@@ -75,29 +61,11 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 		goto out_err;
 	}
 
-	if (params->common.hk_cpus) {
-		retval = sched_setaffinity(getpid(), sizeof(params->common.hk_cpu_set),
-					   &params->common.hk_cpu_set);
-		if (retval == -1) {
-			err_msg("Failed to set rtla to the house keeping CPUs\n");
-			goto out_err;
-		}
-	} else if (params->common.cpus) {
-		/*
-		 * Even if the user do not set a house-keeping CPU, try to
-		 * move rtla to a CPU set different to the one where the user
-		 * set the workload to run.
-		 *
-		 * No need to check results as this is an automatic attempt.
-		 */
-		auto_house_keeping(&params->common.monitored_cpus);
-	}
-
 	/*
 	 * If the user did not specify a type of thread, try user-threads first.
 	 * Fall back to kernel threads otherwise.
 	 */
-	if (!params->kernel_workload && !params->user_data) {
+	if (!params->common.kernel_workload && !params->user_data) {
 		retval = tracefs_file_exists(NULL, "osnoise/per_cpu/cpu0/timerlat_fd");
 		if (retval) {
 			debug_msg("User-space interface detected, setting user-threads\n");
@@ -105,22 +73,11 @@ timerlat_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 			params->user_data = 1;
 		} else {
 			debug_msg("User-space interface not detected, setting kernel-threads\n");
-			params->kernel_workload = 1;
+			params->common.kernel_workload = 1;
 		}
 	}
 
-	/*
-	 * Set workload according to type of thread if the kernel supports it.
-	 * On kernels without support, user threads will have already failed
-	 * on missing timerlat_fd, and kernel threads do not need it.
-	 */
-	retval = osnoise_set_workload(tool->context, params->kernel_workload);
-	if (retval < -1) {
-		err_msg("Failed to set OSNOISE_WORKLOAD option\n");
-		goto out_err;
-	}
-
-	return 0;
+	return common_apply_config(tool, &params->common);
 
 out_err:
 	return -1;
diff --git a/tools/tracing/rtla/src/timerlat.h b/tools/tracing/rtla/src/timerlat.h
index 212ee7971bab..86cd9bac8855 100644
--- a/tools/tracing/rtla/src/timerlat.h
+++ b/tools/tracing/rtla/src/timerlat.h
@@ -27,7 +27,6 @@ struct timerlat_params {
 	int			no_aa;
 	int			dump_tasks;
 	int			user_workload;
-	int			kernel_workload;
 	int			user_data;
 	int			deepest_idle_state;
 	int			aa_only;
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 4dc22a749885..d339e2cffae2 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -941,7 +941,7 @@ static struct timerlat_params
 			params->common.stop_us = get_llong_from_str(optarg);
 			break;
 		case 'k':
-			params->kernel_workload = 1;
+			params->common.kernel_workload = 1;
 			break;
 		case 'n':
 			params->common.output_divisor = 1;
@@ -1081,7 +1081,7 @@ static struct timerlat_params
 	if (!params->common.stop_us && !params->common.stop_total_us)
 		params->no_aa = 1;
 
-	if (params->kernel_workload && params->user_workload)
+	if (params->common.kernel_workload && params->user_workload)
 		timerlat_hist_usage("--kernel-threads and --user-threads are mutually exclusive!");
 
 	/*
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 72be083d7d71..bb42697d2575 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -694,7 +694,7 @@ static struct timerlat_params
 			params->common.stop_us = get_llong_from_str(optarg);
 			break;
 		case 'k':
-			params->kernel_workload = true;
+			params->common.kernel_workload = true;
 			break;
 		case 'n':
 			params->common.output_divisor = 1;
@@ -816,7 +816,7 @@ static struct timerlat_params
 	if (params->no_aa && params->aa_only)
 		timerlat_top_usage("--no-aa and --aa-only are mutually exclusive!");
 
-	if (params->kernel_workload && params->user_workload)
+	if (params->common.kernel_workload && params->user_workload)
 		timerlat_top_usage("--kernel-threads and --user-threads are mutually exclusive!");
 
 	/*
-- 
2.48.1


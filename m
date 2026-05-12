Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9459B3672BC
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607483; cv=none; b=S5KkbJV8Di6Tk8Z0jJjD5AKvxomdGbqQB3oiaXSJQAVl1hUVVJDP+CJ6TvAIxj6Jc0GFSv1EhnCVKBB3h1nvfZg8hSDbRkMmYUWHXPi5l6tKrvOCCqvwr5lXE00Ze4QQXmvKvnm9mGZQnG1MD6G7LhkHKgfY7kBKcVz9ktCill0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607483; c=relaxed/simple;
	bh=8ZTemGM09xHdbei5UIZmEPTrAvTDSnDk/bpqCPn9gIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=mP/VCAiCUUEQQEIatLDl1vMewYuC5jqV1SCCAaK0Q8KZFqiIxrstWIZd7QBWQRx6IMpQcIO8UPzIaU14RQaBzGo2O95zT1OKdDMm12fBpJbsyb5/B16dB/4i8dELxA8n7jdTaYomzr1DDM4G8XflSV8BlimWX7yanZZzKyPNOg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SxMZ9uws; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxMZ9uws"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778607481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Jc/PKRQf2dMlCozbkIzIRqz55UfKM3yUhtt+MgcX3nY=;
	b=SxMZ9uwsIZ1KwVa5+X0dz3KwEftuMeCDydZczwRMlFCnlIVXrqcvjMFpQj1+Cv65fmY3jW
	fqb2uY/6dfGtE6RGF/J4I8FOzD+LrHxN8+QK4PdbPhUkqLmYNxO1xA7b0UY47+43p8OEDS
	Stw7h19NLrXTx2E62lw2LcsteQq794M=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-TwZu5gHkObivRFOGip1BZQ-1; Tue, 12 May 2026 13:38:00 -0400
X-MC-Unique: TwZu5gHkObivRFOGip1BZQ-1
X-Mimecast-MFC-AGG-ID: TwZu5gHkObivRFOGip1BZQ_1778607480
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8aca14d1faaso161030206d6.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 10:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778607480; x=1779212280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jc/PKRQf2dMlCozbkIzIRqz55UfKM3yUhtt+MgcX3nY=;
        b=NnH8gxn5J26Iq1kcfTNpYinYgFKb3rG/0XPUtKp7KkEjvzgiQuEoqOQeojsxwLkFL3
         rdj9VeFntlnKMGWhunEqSW4yJMKLAB25lECiktuX8+w9YAR4tqKiIxJ8xugXixseX9z3
         h0dzghxEBbs4/4c4x8Lzh/LxFPAjf1DNJP3AtfgPGamKlm71ZTEYDZKPMEpZNXAh6RyD
         nYN+SmGn8wnYJeHeIrcNW14doeWO+vWLgoyHk9iztoU6X/Yqg00WVd/uF0V/u4UQxQAY
         ZtRzyzDVtKc5zoVt020To0JmzrcwZiSu3YrrJAXp3en1YUlkMs+W142zq04nq7AX5SMx
         rowQ==
X-Forwarded-Encrypted: i=1; AFNElJ85l5bYXKyRnGDMTWWM+JPr/tHYr9ixM6+cEIHM/exnozxORMyFFijTg+AbPc4vb79dP1Aitu8mZyTmwDhs8jiyoII=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKtTgeQRZBe7OgYXi7xr164Y4k55WYo94mu4zT2a/Kc+IHo7lb
	Lh/KXAQ/2DjHFizUsILnYhX1JXypILptQJP18LPNCStyaVfb/mZ76fMP/9mZhJ5tkqg5pn21nRF
	gjG1qXpM6v/9DaL8+HT9RW7cEUy8A4TtdVKtkBJ1LGrQY6VYuqJ5p1uv6CDm9lQxwuJkE2ehCMw
	==
X-Gm-Gg: Acq92OHj/PVJUNr/KQld5VvkbFkEz6p8zFHH1yHufOnsVdD1w7uZkh3SGQe9QEIzKNx
	Rwx66RT/2uucQf1ZTmelI3gSxk5Fh8gYg0aLIhjgFR6ougeJQ3dZjwWfXlMQL0QaeferIvyjfSZ
	Ab89NrTjBrlEyPXI8B2H2RBRdeb27tYc0r/nlXvgr9luvu4TVNr13TySPm3rRNFI2TuUqVAnUro
	K+rJ0bX2EpzcuPkW/ubxovIRAJMnMNhB/U1o+DCRUOxayWzahKrBguzijSL7cxqa2jCc53yvOAU
	RnlJkmZv+VzzjA3BRqU6lCNMYWe3h8g14dI+ZYUTXLO/8lnMHVb4gcPxuJy1W8Ic7ToPYxfDq7Z
	Bqz4X+cPyG4zczuuoo1H0yq7FGMkCoLWJ3qiNLjQbMl8G8mBrl7KpwA==
X-Received: by 2002:a05:6214:f64:b0:8b6:1c72:3597 with SMTP id 6a1803df08f44-8c66399d6bbmr60904666d6.36.1778607480099;
        Tue, 12 May 2026 10:38:00 -0700 (PDT)
X-Received: by 2002:a05:6214:f64:b0:8b6:1c72:3597 with SMTP id 6a1803df08f44-8c66399d6bbmr60903706d6.36.1778607479129;
        Tue, 12 May 2026 10:37:59 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc81:56d0:ab94:b2cb:29a6:7ac0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53cd827c5sm399727646d6.40.2026.05.12.10.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 10:37:58 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v2] rtla: Stop the record trace on interrupt
Date: Tue, 12 May 2026 12:37:31 -0500
Message-ID: <20260512173731.2151841-1-crwood@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Xc0XifRaQKD5bWkpRPEi2Hx2iBxrYcomEYQ2Al32ov8_1778607480
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Before, when rtla got a signal, it stopped the main trace but not the
record trace.  With "--on-end trace", this can lead to
save_trace_to_file() failing to keep up, especially on a debug kernel. 
Plus, it adds post-stoppage noise to the trace file.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
v2: clarify that this matters for --on-end trace

 tools/tracing/rtla/src/common.c   | 19 +++++++++++--------
 tools/tracing/rtla/src/common.h   |  1 -
 tools/tracing/rtla/src/timerlat.c |  2 +-
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index 35e3d3aa922e..effad523e8cf 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -10,7 +10,7 @@
 
 #include "common.h"
 
-struct trace_instance *trace_inst;
+struct osnoise_tool *trace_tool;
 volatile int stop_tracing;
 int nr_cpus;
 
@@ -21,12 +21,16 @@ static void stop_trace(int sig)
 		 * Stop requested twice in a row; abort event processing and
 		 * exit immediately
 		 */
-		tracefs_iterate_stop(trace_inst->inst);
+		if (trace_tool)
+			tracefs_iterate_stop(trace_tool->trace.inst);
 		return;
 	}
 	stop_tracing = 1;
-	if (trace_inst)
-		trace_instance_stop(trace_inst);
+	if (trace_tool) {
+		trace_instance_stop(&trace_tool->trace);
+		if (trace_tool->record)
+			trace_instance_stop(&trace_tool->record->trace);
+	}
 }
 
 /*
@@ -273,11 +277,10 @@ int run_tool(struct tool_ops *ops, int argc, char *argv[])
 	tool->params = params;
 
 	/*
-	 * Save trace instance into global variable so that SIGINT can stop
-	 * the timerlat tracer.
+	 * Expose the tool to signal handlers so they can stop the trace.
 	 * Otherwise, rtla could loop indefinitely when overloaded.
 	 */
-	trace_inst = &tool->trace;
+	trace_tool = tool;
 
 	retval = ops->apply_config(tool);
 	if (retval) {
@@ -285,7 +288,7 @@ int run_tool(struct tool_ops *ops, int argc, char *argv[])
 		goto out_free;
 	}
 
-	retval = enable_tracer_by_name(trace_inst->inst, ops->tracer);
+	retval = enable_tracer_by_name(tool->trace.inst, ops->tracer);
 	if (retval) {
 		err_msg("Failed to enable %s tracer\n", ops->tracer);
 		goto out_free;
diff --git a/tools/tracing/rtla/src/common.h b/tools/tracing/rtla/src/common.h
index 51665db4ffce..eba40b6d9504 100644
--- a/tools/tracing/rtla/src/common.h
+++ b/tools/tracing/rtla/src/common.h
@@ -54,7 +54,6 @@ struct osnoise_context {
 	int			opt_workload;
 };
 
-extern struct trace_instance *trace_inst;
 extern volatile int stop_tracing;
 
 struct hist_params {
diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index f8c057518d22..637f68d684f5 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -202,7 +202,7 @@ void timerlat_analyze(struct osnoise_tool *tool, bool stopped)
 		 * If the trace did not stop with --aa-only, at least print
 		 * the max known latency.
 		 */
-		max_lat = tracefs_instance_file_read(trace_inst->inst, "tracing_max_latency", NULL);
+		max_lat = tracefs_instance_file_read(tool->trace.inst, "tracing_max_latency", NULL);
 		if (max_lat) {
 			printf("  Max latency was %s\n", max_lat);
 			free(max_lat);
-- 
2.54.0


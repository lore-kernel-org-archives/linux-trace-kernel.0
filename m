Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9743101C8
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 22:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778538932; cv=none; b=NLaroztmQDrvohfI+IzrrllBxBspSrwCxE2yH5LjifkA5BSrK3D80+Hh18h9/d1PKkwZBepFby5Qfp+PSl6hR/mswvXrkPZ038fdqg09Dg2hp+0qRWdFfqZXhxGh2l8+g6HBkdLp3LtKCHNelEuJYX/7Lbsmy2wNASQD9suYLGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778538932; c=relaxed/simple;
	bh=HaLY6ML1ne5RcqZx/bRtYmu++P1QgO/zJ5VhJJ73GIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=kUOInE7HBWacXScTl6mCGhLHDGw4xElkYTycFnOGr8Ee181H/zDKomgjasprpfyA3mKMy1C9s3w41obZzQ1Oqu51zRiTXnwKcKCQNDj9/TnZuPbfY8l03YcGdvZdJRnzqE3Q1QpwJshsjC0tvUCCQiQTzGrMrYflzfpaVseSgyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DHlsxRK/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHlsxRK/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778538930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Be5V36Lh9GJ4FofjfR1J3aN/DKRdbZF51YYTGr+iZKw=;
	b=DHlsxRK/XVvXfFTbSFkqwnvcmSYf/lFewwME6qrQOk9KP7HNA5NK9gE23imkpcIVbznQ6I
	aOGsoEm3kjULQsJ2fLp9pbygZpLJLlUIEYdRXzVNltllRXY6nxX3Nk0OgTXnVpOajTM+zF
	cGe4MNtCdpjoFXRyIl+SLfGtCtm9qzs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-zt-xlW5RPwqleCYCAne9zQ-1; Mon, 11 May 2026 18:35:28 -0400
X-MC-Unique: zt-xlW5RPwqleCYCAne9zQ-1
X-Mimecast-MFC-AGG-ID: zt-xlW5RPwqleCYCAne9zQ_1778538928
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8d5d03ae893so815073285a.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 15:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778538928; x=1779143728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Be5V36Lh9GJ4FofjfR1J3aN/DKRdbZF51YYTGr+iZKw=;
        b=rtkV2Zfbsz1K71BdfBPp2We1DQxRMvtbNZiyhAfbzYEYrj6qzGt0b9SxEzfMMdb1Cn
         1l53JSnpaOI7nj24k0qwDM82r90W4KfD/SOvOI+blJ50G0CNo4YF5fmwcVd99o15WaZM
         6hmtULVXrjCNPXufY/xZjsVudeFPwByejjM+KQAgcO/G5PixRIYSimR49h5VYC+fdaVH
         vstZcYsiixVWI/cQ8o6nPmZWVdvgOoePyfh3uDMgdaW12cj7LWPZRTyhM/R6NJrNs6yc
         iqxmOUnNAV5wAE3OhWyDnoELCYMU78QegtPUV6BLtnw8e2mvw8diyBb/56cqUlbwgCfO
         BXDQ==
X-Forwarded-Encrypted: i=1; AFNElJ+tjp5iiH3ibRYnqs0jKLHP2Ykh/KfBz7g7ndd5ofqu1AmEi8DtpgGGrJhyuyaEJKaEzN5eNlQ0iWuNqAoNAlIAkZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKIDsVIHZGOe/IWKz6vaaKQ/Ges5p+0km79Wpug7UqY36FgJIw
	s7mBbgCx70poUS97XLo2T1Cd9F4XxU3FyxZQ9eahNHTNT7QsaBQG0FPYONPhGsssWA3LN1UXg87
	NoMjvLl+mQHkuKco1ckV72/hYfQrR44MPRL8VK19vj3Qgt8a+PUlwJue7Z/5BdfDxN6BDpn31/Q
	==
X-Gm-Gg: Acq92OHCE2zEmU3dvX7UhyUHp9j2FSO1Fa3HDT+6B8a6e/fAcM/GdTODsfRc/yDS8O0
	C+5xkH+dAEpCIJpQ0aBDDCCP5teqb49Bo74keCXfuwvCaakMMnR8hQOnC9LD5bftHZ0+1//68zb
	KpI/TDA3NOhD7YuRh/9EdDWoYeBLj/TDDv3AqVP3NKgr7x4AIS8zo/JFaPoz20ZxnuouNCuIC25
	9khszSttc2oFzoH0KEgGmBXUn19dpvNtNHxezL3hMGj/XPVxmb5Iajfa27OxUGpUqYtYHyDiadn
	LyFk2JoladMdCaNeZbNKByY+NNsFIPFqWVnrWzYckP5MZ52XvVZBK0Q5WT3u/hv8tnKPDSpC6+t
	mu/HKnvMYaWMBuaWii26nkiE46XffCEIb6ukHz7MsBqS71+iUG+7OZw==
X-Received: by 2002:a05:620a:bd3:b0:8fb:1ba7:bdf3 with SMTP id af79cd13be357-904d4679dbemr3870043785a.14.1778538927718;
        Mon, 11 May 2026 15:35:27 -0700 (PDT)
X-Received: by 2002:a05:620a:bd3:b0:8fb:1ba7:bdf3 with SMTP id af79cd13be357-904d4679dbemr3870039785a.14.1778538927247;
        Mon, 11 May 2026 15:35:27 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc81:56d0:ab94:b2cb:29a6:7ac0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b8e98521sm1200855785a.17.2026.05.11.15.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 15:35:26 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH] rtla: Stop the record trace on interrupt
Date: Mon, 11 May 2026 17:35:09 -0500
Message-ID: <20260511223509.1483323-1-crwood@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eyCZ-LTN_C9P-ETPNjs1fZOsS-hwxrNkVVTIuufQJDc_1778538928
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Before, when rtla gets a signal, it stopped the main trace but not the
record trace.  save_trace_to_file() could also fail to keep up on a debug
kernel -- and in any case, it adds post-stoppage noise to the trace file.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
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


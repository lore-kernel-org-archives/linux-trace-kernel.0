Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792702450;
	b=RAy8+JVcPvVTkDf5R8ghwjBGPLfnLWqvBXpfSff1Q2qQENwOQVRJa2L1C+vliuG6sBKj
	 l+pMJndFhilKgUuoOQ8V2xHWwhgj+DiaxecBQo0apLAZKU5hzp9MEnKRHfiQuhPpCs1LM
	 JFBha84KieRlvEq/vJmEadL2PX7Vlgwk+p3O7Dz1+5CnZ5+OxKPKV9dzM8/BgzDonnVyr
	 yXExsAbFpKdyAEkd76cCPa6ktrE59wQkMEcJenP8/tSLI+hfj6j8afxhArl2iqaXO9++0
	 LWkVn1PL7rGoAncDjuiv3HiDevO1amG0a/JBonODDrM9Ap1wCZ/Ozw1rGF4ldxlQeCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792702450;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AE4c8qZkLEuD3bWD68hYum0BC77PeC40PBLBKrUJ+TQ=;
	b=1I5h2tbQDtpbkbHbezty8C57/fgfBzZ7GOtUGt0qir42+3718CIiFL+iNvFxvu1zQMj+
	 yeVdrV7fIn62NDCnHYfVuWrtdCbboVmDbjLNvwGAneKB/SzO4bdHZoGM165X3EZ6TgjDG
	 1ZO77F1Q1Ga71pmJc7f64kRccofUTNvAZkQBH+RH8Vdg5/1uaRUnZXSYlmDySE+cbKRVw
	 YFLYgDSE336sEa9Qt2/v/sJvLmf1xwY/ux/oYmy/qCbg3hubWa2wqimVpsvI8SUy5SeD+
	 AyRe8TdFOiNS6W824tBt55sABcx7RDOINRhcjOziI4ZjjuvZ5SFiWKY3O1k/Jxe4nEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n8WRq1XS;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CDA606A322
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 20:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53CDA606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n8WRq1XS
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so1813805e9.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 13:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792702449; x=1793307249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AE4c8qZkLEuD3bWD68hYum0BC77PeC40PBLBKrUJ+TQ=;
        b=n8WRq1XSfUOhSWeOAVM9FBBn9wnnCTDxt+vRKL19Wv/i1SBQ2McGoHY4n8yI6MOSJd
         lklpME1hgegMqCIDW+BZQqoHllUddxCvRRTetV5ZDxU/aGGO4ocMyaG8aZ4nhK8gDAU9
         mG2TeU+VOnRhjGR+IV3PDyOu5gKa2GYouwWviOefXS+BO9t3lMH/JEsD0YFY3YU+2V40
         3UwudxtvrOXqWEpquXu+5+DOKqmjD96Ewsm5pHtmJqVRHAqOxuAZ2xRA/BBdkuV+1hb9
         16H23SqYF/dCcVz1Lmw9LFaeEM7tYjU4wispXe4aLQI96rAzqiracV9LSPKsnwIXPkTd
         K4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792702449; x=1793307249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AE4c8qZkLEuD3bWD68hYum0BC77PeC40PBLBKrUJ+TQ=;
        b=cPmBDRljKpTJouiW1wQWQGQfLNFoqJclQSila2m7a7rfcagW0lDPqO3Ou0CNBb/atF
         YZAq4GMsIrV6PEym89XExMymzVBji8Cx6LUkwwBOaMNSezX52WaF7jvRc/T8Qh9nhhF+
         cMqBr+DvjVIXId6KN9Mf5CtjBwcoZ8nkqNSCOwDyN1gLTFJ/zfT4FtGzNcYABIPsB6Qy
         9uDlyZFXvMlLJkwFP+FgM951DxWqfFXfExOpGHcMko4RUgpgzDe/7uwuuyuDPL1Cr1LI
         BSkYC6YajCK0J1iQ/pfUciv7tauVKEjFjlueUEjx8iniuHk8dxId8AJOAv8Zv7eIW0+w
         EUGg==
X-Forwarded-Encrypted: i=1; AKwUvBzvbY5wonZLFmvOQvugNHS17COd/937kykurIrJJkvXAfNDwNivT8lxbihB4ketmCeH+fWDQjDbN9UT+SHHEj6JAn0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIJdjhs6KdA0Hv95KApk1XepyOdsW+bON7RBrqOjP4a/pA4R6e9
	EEtP7I6/OYutDSvhZfv3RbyP1JnstS2KikPtlm3GxyEKFPWtjRRZsG3i
X-Gm-Gg: AYBFou22cv+Q/5RW4zUxl9gSCAso0VgbUe4zaDspDonfoF72r9bI4kLee2G2FtvahHV
	AiBH/sEegWhBAkq6aaPW9deCLIhdoj+fIR+eljXpTuBf63QKtn9UoDjwUdSjT2wJG8MJmqpFWB5
	RqrnrY3EtpCGmN0bVqJae8NBIPjRF+PoXBZfdkzZ9iHahc2NNIV3u4pMnZQziXwE+fkbZ0MifEH
	/D4d2KvIARwMHedq0TVHufVuPoauAs7XAID3kRBwNtwmdthhRiW6a92oltpz7x3f9kYs3VttUEC
	54xe34hxpdY+k5B5RoTNRhW11XCk+hwQ69G8wra8mnkHSUwWLj+zv9gX9+2iI8QAJ6dGjzpNF8O
	yaZDRkfBqhZx/Wh+MZ0Ya4WcM3+wzYV3ysOfVbAPTarEwwMMpMym/06DH42L3QvjDeKL4TVsOg0
	e92IZz0QndhQLnO/x4aH/STOQaMZFzNQRDczLiOwhVAsUPUC7bj8BzSym3jplU5WirAPlmKr9lu
	3EGZn5gTypoMzbkJObXZR4P5VgWGHAIPs1mp70MgHFWJv9A/wmStDWlKVvZDejvvEIemNI7dnU0
	IhOOrpRBPkdE2jc+7E1gNnG6doHUE4lsqImAMcdL
X-Received: by 2002:a05:600c:e558:10b0:4a1:d8fc:8165 with SMTP id 5b1f17b1804b1-4a211ce42fdmr2054815e9.20.1792702448539;
        Thu, 22 Oct 2026 13:54:08 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38025d82sm431076f8f.16.2026.10.22.13.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 13:54:08 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lee Jones <lee@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] tracing: Drop the synthetic event ref when clearing hist triggers
Date: Thu, 22 Oct 2026 21:53:16 +0100
Message-ID: <20261022205405.1228742-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clear_event_triggers() frees a hist trigger on a synthetic event without
dropping the se->ref taken by event_hist_trigger_parse(). Removing an
instance with such a trigger leaves the synthetic event busy forever.

Fixes: 4b147936fa50 ("tracing: Add support for 'synthetic' events")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
Applies on trace/for-next, depends on 3403d9bb27eb ("tracing/histograms: Verify event_call identity when updating synth_event refcount").
 kernel/trace/trace.h                |  2 ++
 kernel/trace/trace_events_hist.c    | 20 +++++++++++++-------
 kernel/trace/trace_events_trigger.c |  2 ++
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 0f0786700f99..e108f95fd609 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1915,9 +1915,11 @@ extern const struct file_operations event_inject_fops;
 #ifdef CONFIG_HIST_TRIGGERS
 extern int register_trigger_hist_cmd(void);
 extern int register_trigger_hist_enable_disable_cmds(void);
+extern void hist_put_synth_event(struct trace_event_file *file);
 #else
 static inline int register_trigger_hist_cmd(void) { return 0; }
 static inline int register_trigger_hist_enable_disable_cmds(void) { return 0; }
+static inline void hist_put_synth_event(struct trace_event_file *file) { }
 #endif
 
 extern int register_trigger_cmds(void);
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index f39fa8942673..9419edfd1b67 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6756,6 +6756,17 @@ static bool hist_trigger_check_refs(struct event_trigger_data *data,
 	return false;
 }
 
+void hist_put_synth_event(struct trace_event_file *file)
+{
+	struct synth_event *se;
+
+	lockdep_assert_held(&event_mutex);
+
+	se = find_synth_event_call(file->event_call);
+	if (se)
+		se->ref--;
+}
+
 static void hist_unregister_trigger(char *glob,
 				    struct event_trigger_data *data,
 				    struct trace_event_file *file)
@@ -6811,7 +6822,6 @@ static void hist_unreg_all(struct trace_event_file *file)
 {
 	struct event_trigger_data *test, *n;
 	struct hist_trigger_data *hist_data;
-	struct synth_event *se;
 
 	lockdep_assert_held(&event_mutex);
 
@@ -6824,9 +6834,7 @@ static void hist_unreg_all(struct trace_event_file *file)
 			list_del_rcu(&test->list);
 			trace_event_trigger_enable_disable(file, 0);
 
-			se = find_synth_event_call(file->event_call);
-			if (se)
-				se->ref--;
+			hist_put_synth_event(file);
 
 			update_cond_flag(file);
 			if (hist_data->enable_timestamps)
@@ -6941,9 +6949,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 		}
 
 		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
-		se = find_synth_event_call(file->event_call);
-		if (se)
-			se->ref--;
+		hist_put_synth_event(file);
 		ret = 0;
 		goto out_free;
 	}
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 4d2fde996c0f..a2487ad7fef8 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -643,6 +643,8 @@ clear_event_triggers(struct trace_array *tr)
 		list_for_each_entry_safe(data, n, &file->triggers, list) {
 			trace_event_trigger_enable_disable(file, 0);
 			list_del_rcu(&data->list);
+			if (data->cmd_ops->trigger_type == ETT_EVENT_HIST)
+				hist_put_synth_event(file);
 			if (data->cmd_ops->free)
 				data->cmd_ops->free(data);
 		}
-- 
2.55.0


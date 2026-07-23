Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F033D9DC8
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jul 2026 19:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784834151; cv=none; b=WZaGQDfv4DdHk2fIRS7jhDO/OiSfzNRT0TcHpp83llGkXkmcCxCivBA9RT+ba1wA5fs83YINWWVrQq8gPYwpOgb2aBuL6lwogfsG4h6PjZye0EwdkIUmSscMd5U8t76HhFjTtHgsk8IvS+l5SJhvQSKXKIGBZiqHTkkSZpQ3V34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784834151; c=relaxed/simple;
	bh=hzcE7nxEzBp3cLMwV0r+c/offGQP9mBgrxUzZ7iUJK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j2J1q51SlA9sjlqqhUFirWDog2i23XLzYfVcBv4YLU4jT4+aBt14j30N1JTu0TAU7kfT1iyj73QBGjTGE83cB0seY07HvPiG3IPnIOr5y5R5wxGJb5zgbECiEMq+nSnwgCpcjyqNuAoKKAS/ZjBbZ+8U3gKKafW7szMNAWFaxLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHWOuQWn; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHWOuQWn"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-495635a85d2so8778015e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jul 2026 12:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784834139; x=1785438939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+yCSuLV8w3Ckz/AAJ5HznF73LmC/jd1nssuz5wPUwWA=;
        b=BHWOuQWnwxkCvgQzoagOMt4wGGMv/OwXk9RD80jsyaU5xB9ry+6Zww2xyPeviH/l4R
         yEXThpfyrXXkCiLATvzvZEnmoPXu3lXjhmCVsW0yJUbhVe5QNoot6W+s+mHcrBbJx6lZ
         t6jViSWolc5N4yBHVIayOrDNKEZ+xFBtcPcab2cin5J/c9tf+w+MpsTygNyl6g79PL9A
         tPw5M70EKrXoOXJ91MfmWhE7zU2VP8YMCTdvPYb5s2pYr0TK6d2zuNSR/KxIv3IO/S47
         6GT9Qz6WlqWTuXF5rhKEEnNNpZ7JAaXEU6XL75tOoxnCSUJiQwto8ThnDg3O3j4wI3SD
         7yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784834139; x=1785438939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+yCSuLV8w3Ckz/AAJ5HznF73LmC/jd1nssuz5wPUwWA=;
        b=P64eMbIFM+LbOzU4leAvC+sh2N2eye/DgXwJ8CFBnDYbbzWVnie3lYZsG2QL8YdSpH
         Hv7sVrWzgcq6gQaZ/jpcRZVfkGdm21v9zCCnqlMxn2sU5g2gHpdfItOJpn+Y1BdOoUzR
         xQQgg1WhR3cTWX41aaXzeQonqmawntUrhxRF+/f9iYbvuuD/1MMP3TPaqmCzlNLx2uNJ
         gTYTf5oyzjBmUCgVBmAESw170bUO13cvg2DRKjr0+ucqw9hFjZ36q5oH3DwS0cYe/DY7
         6/3RAca8/BazIsDelpzXJgO3IgDn7IOWG5RoJwsSOrjqr01Q+yFyUIV3XA6YXK7QTGeA
         wSRQ==
X-Forwarded-Encrypted: i=1; AHgh+RqaTUbNuZjFjxCIRFGJmEw52SzLKwiv5CKChJ+CHJXv/GzdcqlkampDk2gpmmI2zpKpo5T7F22BD+TX6UZ7zpRlkUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHjaZAYG6rJIUBEBbpR1aEFV5tcuOQ53hcBPA+mXXVltpZdpkj
	wVO08CQAEIvjkZ0/MPfw02Wxx9t5KXPtu9E3OGTOhuhI1dhsPbrvYAA7
X-Gm-Gg: AR+sD11qc8vYFZnY3OqvlKsp/Swd5zyClzvuXczGESVJt8ce5ilXUxSky7F0loDlpGd
	lh+QCt/h4PgIkKC4OnD5eTupFDv64CRsx3BgWn3mJQIZc8wVkvAQ6qWwbJvAaqxEB8dvk4Iz582
	eQOiwlztGKqS27TXJ8OeZXWp5JMgYLdE4ed/JAs82rrRCLojSV4cHJztWiPeN99/tDNs1QYkEP7
	sbigfoduTK1RE8TVKMNRmLo9+hTTDzkshrO0aGNBUEnHpsx4GLjaAZRFvAb03+FSyyMfTlvg9WU
	bMzYR9aKDQKptFbj7zdl5r+EOXcytpxOSSZMoYgZ47npGZkDhch3v+zCNgCficEVvCYH0zWFeoI
	7pwxJTnFVfo9DAaqadqINByntRAKWv1fclM/gcyfWaKYxYkuuLbMN+fr77vjKqFmyNEPsI4iXrB
	jzDM1jZsH9FX194DtvB/hYojnJOhzAHT/IjyKTvfhVkDgIw3vGsK3K1ZR1qilJeQ==
X-Received: by 2002:a05:600c:c091:b0:495:636b:e519 with SMTP id 5b1f17b1804b1-49573cfd67cmr47504935e9.21.1784834139139;
        Thu, 23 Jul 2026 12:15:39 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957af786e4sm13644855e9.8.2026.07.23.12.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 12:15:38 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v3] tracing: Fix use-after-free freeing trigger private data
Date: Thu, 23 Jul 2026 20:15:26 +0100
Message-ID: <20260723191534.67136-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 61d445af0a7c ("tracing: Add bulk garbage collection of freeing
event_trigger_data") moved the kfree() of event_trigger_data to a kthread
that runs tracepoint_synchronize_unregister() before freeing. That removed
the synchronization the trigger .free callbacks used to get implicitly and
inline from trigger_data_free().

event_hist_trigger_free(), event_hist_trigger_named_free() and
event_enable_trigger_free() free their satellite data (hist_data, cmd_ops,
enable_data) right after trigger_data_free() returns. With the
synchronization now deferred to the kthread, a concurrent tracepoint
handler can still reach that data through the list_del_rcu()'d trigger,
causing a use-after-free.

The histogram teardown must stay synchronous: remove_hist_vars() and
unregister_field_var_hists() have to detach a synthetic event from the
histogram before the trigger-removal write returns, otherwise a following
command races in and the synthetic-event removal fails with -EBUSY, as the
trigger-synthetic-eprobe.tc selftest catches. Make those callbacks wait
with the correct barrier - tracepoint_synchronize_unregister(), matching
the free kthread - before freeing.

The enable trigger has no such synchronous requirement, and a blocking
synchronize there would re-serialize the path that commit deliberately
deferred. Give it an optional free_private() callback that the free kthread
runs after its grace period, and free enable_data from there.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Fixes: 61d445af0a7c ("tracing: Add bulk garbage collection of freeing event_trigger_data")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/trace/trace.h                |  1 +
 kernel/trace/trace_events_hist.c    |  2 ++
 kernel/trace/trace_events_trigger.c | 18 +++++++++++++++---
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 80fe152af1dd..fceef65b9601 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1941,6 +1941,7 @@ struct event_trigger_data {
 	struct list_head		named_list;
 	struct event_trigger_data	*named_data;
 	struct llist_node		llist;
+	void                            (*free_private)(struct event_trigger_data *data);
 };
 
 /* Avoid typos */
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 82ce492ab268..58d28cd1afa3 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6349,6 +6349,7 @@ static void event_hist_trigger_free(struct event_trigger_data *data)
 
 		trigger_data_free(data);
 
+		tracepoint_synchronize_unregister();
 		remove_hist_vars(hist_data);
 
 		unregister_field_var_hists(hist_data);
@@ -6388,6 +6389,7 @@ static void event_hist_trigger_named_free(struct event_trigger_data *data)
 
 		del_named_trigger(data);
 		trigger_data_free(data);
+		tracepoint_synchronize_unregister();
 		kfree(cmd_ops);
 	}
 }
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 655db2e82513..328d9657bcf2 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -38,6 +38,13 @@ static void trigger_create_kthread_locked(void)
 	}
 }
 
+static void trigger_data_free_one(struct event_trigger_data *data)
+{
+	if (data->free_private)
+		data->free_private(data);
+	kfree(data);
+}
+
 static void trigger_data_free_queued_locked(void)
 {
 	struct event_trigger_data *data, *tmp;
@@ -52,7 +59,7 @@ static void trigger_data_free_queued_locked(void)
 	tracepoint_synchronize_unregister();
 
 	llist_for_each_entry_safe(data, tmp, llnodes, llist)
-		kfree(data);
+		trigger_data_free_one(data);
 }
 
 /* Bulk garbage collection of event_trigger_data elements */
@@ -75,7 +82,7 @@ static int trigger_kthread_fn(void *ignore)
 		tracepoint_synchronize_unregister();
 
 		llist_for_each_entry_safe(data, tmp, llnodes, llist)
-			kfree(data);
+			trigger_data_free_one(data);
 	}
 
 	return 0;
@@ -1717,6 +1724,11 @@ int event_enable_trigger_print(struct seq_file *m,
 	return 0;
 }
 
+static void enable_trigger_free_private(struct event_trigger_data *data)
+{
+	kfree(data->private_data);
+}
+
 void event_enable_trigger_free(struct event_trigger_data *data)
 {
 	struct enable_trigger_data *enable_data = data->private_data;
@@ -1728,9 +1740,9 @@ void event_enable_trigger_free(struct event_trigger_data *data)
 	if (!data->ref) {
 		/* Remove the SOFT_MODE flag */
 		trace_event_enable_disable(enable_data->file, 0, 1);
+		data->free_private = enable_trigger_free_private;
 		trace_event_put_ref(enable_data->file->event_call);
 		trigger_data_free(data);
-		kfree(enable_data);
 	}
 }
 
-- 
2.53.0


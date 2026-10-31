Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793469142;
	b=iMNbrq3/q8s/vEEcvPPu5jee7p/CToi0UsG+sSyf8+4tnZOLbXlwQUJHoHsDPRK42b/L
	 O+qSNbCN9KAzerR4lWBVq30oqFxVSPA/DjjMvx7tLwQaHymQW41q7iiRw5FdYIBzmten/
	 0Be2InUXDFSJ80ngyyXkSLBkiYyHF59n+gSn6htHEG414tjoIDhcaQs7er7rAyT13QoDt
	 VBTXso6mTqYH9h8SyzQVfhRRlD3/k0XSJnw37AfBsfCQEawiRRiibji7YmZmO9g9SOyFT
	 1dInrT9XfDJdk/oPqNn1kqDEf7yOzpzdy7P3+1Pk+pR020apYkJJVya0fsY0AmtsgdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793469142;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XKpSNaYPIFBe7psLxXuqPwh0OVaqKktwXLrY4cQL8M4=;
	b=AjdLqgBgUcQ9AYcKYUlopsLb8qSnxKUiEVGbSLnx3nMnTUmaDG4VqNb6lIQrGZp7nRv4
	 wAwOpHvI2S47cmiUKmUtteBRewlON25q8IaKqCFbcqZfJygi+4nS3sOzOmybMq2smvxin
	 SMdTUPWOLjWmBJtzSitLarPbgTjUuy+WkXoBo+TUa9dFQNCiE39D+aIyuLThLgZQtf5W0
	 RSHOBEfFIyeWAhVXhIpT1m2iZGGO2guO0RP9ieSIyl8gKsy0NZNWvExHkl3udw5D4dLSo
	 naDDyxaXZpq7SrMYIEsHvESWdpWaoGQldEwYKiBqZ5g5d4hn+CE5QRl4OIKEjqKlT6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V8SharBF;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A359F606A31A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 17:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A359F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V8SharBF
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso2221797eec.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 10:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793469141; x=1794073941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XKpSNaYPIFBe7psLxXuqPwh0OVaqKktwXLrY4cQL8M4=;
        b=V8SharBFVely1YNWpjJAJpbi4Lsed5zJoHsnaxkpf75vRugMdigswYTrE4M3gDavUZ
         sfQURxveoFLwMYTzerHMCdoNwPY8y+k53/wpjBWDw6Ts3ne3QdWSP7EbKKCchPiMlCJX
         m5on8r2MYmAdszfYnIIqhkAWr65mOGkz5QnrsKDB5IMn1gITF2aj6yrPMetfVb0P3A2R
         8pUZ06Mzl4KoOtt1XNpRr4CAluAnZF0P3OvVER+AF4Boe4J1N2IpnoPZJLKKAfsRe5zl
         Uo6LFR972RfVvy5GSnToD731SYDEFpOB7Xd6gw4iGpaQ3efKmhdoj6tW6IwExEiH2mO2
         f88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793469141; x=1794073941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XKpSNaYPIFBe7psLxXuqPwh0OVaqKktwXLrY4cQL8M4=;
        b=H/R/rwl5MzHbVO631kdkMBv9N7vhq6ZtOQCaZaL6I0NWPWSt7QbirCJS82+dhhW58Z
         YS90rI14dgBGmQsOv48LKOdt9qMzVoXlbPB3hfCYT/ia1FD8YYsNj2Qy2PBuKMjxeIxe
         oMuj509l/J//dN0Retovs5j+wULXw2iPf3o6sWZ0SoJDfacoRophhODXP+VZdVO/oJYS
         gs2Tng4G4EyOBSNtwqxiW1mTwjxFVhaEOJPdr0tv9I3kYVhBvUbw6gbhBoockAO9bQrC
         dk0wqOKvegWMCKbZxmoIQjsKyUnvVeWgqwMWOnWhnxKg0Cj1dOSPKxkX/YXTtYkGiddv
         mDFg==
X-Forwarded-Encrypted: i=1; AKwUvBwd5QOaRaam/X6n359E1HIoj5XzxPYk8P9EWXK21CjR+Vv0oWU/yVjpap/SESypcBS/fQ7qk1eaLTelsqR0xV+Pvc4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ77N1Af2RK3cz1xiYhQ31+lE5HF1N3YbnAzOxZ7KKY4q1U/lHc
	70+m7gqjtGFW7yPpQkW9h19BWEp1eWk0xrLnFZdsVhiuZkC/MTRcsfpV
X-Gm-Gg: AYBFou3Szb33Y2Lrw7j5eySphNWUpvmjiC59MvnkRbsbrynLctP/+DivuSs+8woMqLM
	WZoEI5vIa7HZWFkCHnVnnkx8ojHzgFIaXm7qqCDAW8ea/wAUWonHGIV2u3NdsEwCKo3rZGFn5Ew
	UY/G0jZ8jnVdoTEikNCH64sJkj8E3/q0i8ZvFz0NY56SUSBRWEhuria9m6vT0GxnG1umR2K/dyA
	0bQ2s+oBctrz2F/Yp9Tj116ZHEiwcpaxJ//dE92BaLm8zaaE9YtK9PFSKSegJepbkVsH6w+G1yq
	GHRSFtAmxmyv0+ILZ02p/f1/08qKwsYRk48j0P4Xs1ZelXWxQ0pjAKKqP7RLd1A74TRiIN/X2zz
	qpHzSciwGLHvISq6IiKSTKYEAs65SvqG2F4jD4ilp5tVw7nLQoXqU+fGTXUh6ezIaGsN58UxNN8
	av78R4g2+TOtPmIXGNNA8oIRZqFl9tWpQXzpahTXHq6dPw4/C2byRaMZR1E2dNX0VyoY/ddlewC
	LVSNcv/W+pCgW+zuwWaRiTM7X1rNfFERkzoEZtFrXaSDkMrDUzRqCxueCR8jm0MFF4eHRXHjJCn
	gBxL16n5185J+2xhHbYx7GZXIdCrh3pL72z0h6WxhzF9b86iMoHJdLoOwKER5y5mWWBT1HGZkD7
	DhQ==
X-Received: by 2002:a05:7300:2a91:b0:36a:1bd4:627f with SMTP id 5a478bee46e88-36a423a9d6fmr7991386eec.14.1793469140462;
        Sat, 31 Oct 2026 10:52:20 -0700 (PDT)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42935b4asm27088158eec.16.2026.10.31.10.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 10:52:19 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH v3] ftrace: Complete subops teardown on shutdown failure
Date: Sat, 31 Oct 2026 10:52:13 -0700
Message-ID: <20261031175213.704021-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.56.0
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

ftrace_shutdown_subops() unlinks a subop before rebuilding the manager
hashes, but leaves it enabled and managed when rebuilding or updating
fails. unregister_ftrace_graph() cannot recover from that partial
teardown, and a later registration can corrupt the empty manager state.

Always detach and clear the subop once shutdown begins. Keep conservative
manager hashes behind per-subop filtering when an update fails, and disable
direct graph dispatch until those hashes are exact again. If the last
manager cannot be shut down, disable ftrace and normalize its list, flags,
count, and hashes before the caller releases the graph operation.

Cc: stable@vger.kernel.org
Fixes: 0ae6b8ce200d ("ftrace: Fix accounting of subop hashes")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: OpenAI Codex <noreply@openai.com>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 kernel/trace/fgraph.c          | 35 +++++++++++++++++----
 kernel/trace/ftrace.c          | 57 +++++++++++++++++++++-------------
 kernel/trace/ftrace_internal.h |  3 ++
 3 files changed, 68 insertions(+), 27 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index ed455b535..1a8e092ec 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1306,7 +1306,7 @@ static void ftrace_graph_enable_direct(bool enable_branch, struct fgraph_ops *go
 
 	static_call_update(fgraph_func, func);
 	static_call_update(fgraph_retfunc, retfunc);
-	if (enable_branch)
+	if (enable_branch && !static_key_enabled(&fgraph_do_direct.key))
 		static_branch_enable(&fgraph_do_direct);
 }
 
@@ -1315,13 +1315,27 @@ static void ftrace_graph_disable_direct(bool disable_branch)
 	if (FGRAPH_NO_DIRECT)
 		return;
 
-	if (disable_branch)
+	if (disable_branch && static_key_enabled(&fgraph_do_direct.key))
 		static_branch_disable(&fgraph_do_direct);
 	static_call_update(fgraph_func, ftrace_graph_entry_stub);
 	static_call_update(fgraph_retfunc, ftrace_graph_ret_stub);
 	fgraph_direct_gops = &fgraph_stub;
 }
 
+void fgraph_update_direct_func(struct ftrace_ops *ops, bool enable)
+{
+	struct fgraph_ops *gops;
+
+	if (ftrace_graph_active != 1 || !(ops->flags & FTRACE_OPS_FL_GRAPH))
+		return;
+
+	gops = container_of(ops, struct fgraph_ops, ops);
+	if (enable)
+		ftrace_graph_enable_direct(true, gops);
+	else
+		ftrace_graph_disable_direct(true);
+}
+
 /* The cpu_boot init_task->ret_stack will never be freed */
 static int fgraph_cpu_init(unsigned int cpu)
 {
@@ -1406,16 +1420,24 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 	gops->ops.flags |= FTRACE_OPS_FL_GRAPH;
 
 	ret = ftrace_startup_subops(&graph_ops, &gops->ops, command);
-	if (!ret)
+	if (!ret) {
 		fgraph_array[i] = gops;
+		if (ftrace_graph_active == 1)
+			ftrace_graph_enable_direct(true, gops);
+	}
 
 error:
 	if (ret) {
 		ftrace_graph_active--;
+		gops->ops.flags &= ~FTRACE_OPS_FL_GRAPH;
 		gops->saved_func = NULL;
 		fgraph_lru_release_index(i);
-		if (!ftrace_graph_active)
+		if (ftrace_graph_active == 1) {
+			ftrace_graph_enable_direct(true, NULL);
+		} else if (!ftrace_graph_active) {
+			ftrace_graph_disable_direct(false);
 			unregister_pm_notifier(&ftrace_suspend_notifier);
+		}
 	}
 	return ret;
 }
@@ -1423,6 +1445,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 void unregister_ftrace_graph(struct fgraph_ops *gops)
 {
 	int command = 0;
+	int ret;
 
 	if (WARN_ONCE(!(gops->ops.flags & FTRACE_OPS_FL_GRAPH),
 		      "function graph ops unregistered without registering"))
@@ -1447,9 +1470,9 @@ void unregister_ftrace_graph(struct fgraph_ops *gops)
 	if (!ftrace_graph_active)
 		command = FTRACE_STOP_FUNC_RET;
 
-	ftrace_shutdown_subops(&graph_ops, &gops->ops, command);
+	ret = ftrace_shutdown_subops(&graph_ops, &gops->ops, command);
 
-	if (ftrace_graph_active == 1)
+	if (ftrace_graph_active == 1 && !ret)
 		ftrace_graph_enable_direct(true, NULL);
 	else if (!ftrace_graph_active)
 		ftrace_graph_disable_direct(false);
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 673a54fdf..831f04de6 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3667,6 +3667,8 @@ static int rebuild_hashes(struct ftrace_hash **filter_hash, struct ftrace_hash *
 	bool first = true;
 	int ret;
 
+	*filter_hash = EMPTY_HASH;
+	*notrace_hash = EMPTY_HASH;
 	temp_hash.filter_hash = EMPTY_HASH;
 	temp_hash.notrace_hash = EMPTY_HASH;
 
@@ -3708,7 +3710,13 @@ static int rebuild_hashes(struct ftrace_hash **filter_hash, struct ftrace_hash *
  * will not affect functions that are being traced by other subops that
  * still exist in @ops.
  *
- * If the last subops is removed from @ops, then @ops is shutdown normally.
+ * Once removal starts, @subops is detached even if rebuilding the manager
+ * hashes fails. The old manager hashes are conservative in that case and the
+ * remaining subops continue to filter callbacks. If the last-manager shutdown
+ * fails, ftrace is disabled before the manager state is discarded.
+ *
+ * Return: 0 on success or a negative error code if the manager could not be
+ * updated or shut down.
  */
 int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int command)
 {
@@ -3716,9 +3724,6 @@ int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, in
 	struct ftrace_hash *notrace_hash = EMPTY_HASH;
 	int ret;
 
-	if (unlikely(ftrace_disabled))
-		return -ENODEV;
-
 	if (WARN_ON_ONCE(!(subops->flags & FTRACE_OPS_FL_ENABLED)))
 		return -EINVAL;
 
@@ -3727,36 +3732,45 @@ int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, in
 	if (list_empty(&ops->subop_list)) {
 		/* Last one, just disable the current ops */
 
-		ret = ftrace_shutdown(ops, command);
+		if (unlikely(ftrace_disabled))
+			ret = -ENODEV;
+		else
+			ret = ftrace_shutdown(ops, command);
 		if (ret < 0) {
-			list_add(&subops->list, &ops->subop_list);
-			return ret;
+			bool enabled = ops->flags & FTRACE_OPS_FL_ENABLED;
+
+			FTRACE_WARN_ON_ONCE(!ftrace_disabled);
+			remove_ftrace_ops(&ftrace_ops_list, ops);
+			if (enabled && ftrace_start_up > 0)
+				ftrace_start_up--;
+			ops->flags &= ~(FTRACE_OPS_FL_ENABLED |
+					FTRACE_OPS_FL_ADDING |
+					FTRACE_OPS_FL_REMOVING);
+			ops->func = ops->saved_func;
 		}
 
-		subops->flags &= ~FTRACE_OPS_FL_ENABLED;
-
 		free_ftrace_hash(ops->func_hash->filter_hash);
 		free_ftrace_hash(ops->func_hash->notrace_hash);
 		ops->func_hash->filter_hash = EMPTY_HASH;
 		ops->func_hash->notrace_hash = EMPTY_HASH;
-		subops->flags &= ~(FTRACE_OPS_FL_ENABLED | FTRACE_OPS_FL_SUBOP);
-		subops->managed = NULL;
+		goto out;
+	}
 
-		return 0;
+	if (unlikely(ftrace_disabled)) {
+		ret = -ENODEV;
+		goto out;
 	}
 
 	/* Rebuild the hashes without subops */
 	ret = rebuild_hashes(&filter_hash, &notrace_hash, ops);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	ret = ftrace_update_ops(ops, filter_hash, notrace_hash);
-	if (ret < 0) {
-		list_add(&subops->list, &ops->subop_list);
-	} else {
-		subops->flags &= ~(FTRACE_OPS_FL_ENABLED | FTRACE_OPS_FL_SUBOP);
-		subops->managed = NULL;
-	}
+
+out:
+	subops->flags &= ~(FTRACE_OPS_FL_ENABLED | FTRACE_OPS_FL_SUBOP);
+	subops->managed = NULL;
 	free_ftrace_hash(filter_hash);
 	free_ftrace_hash(notrace_hash);
 	return ret;
@@ -3767,8 +3781,8 @@ static int ftrace_hash_move_and_update_subops(struct ftrace_ops *subops,
 					      struct ftrace_hash *hash)
 {
 	struct ftrace_ops *ops = subops->managed;
-	struct ftrace_hash *notrace_hash;
-	struct ftrace_hash *filter_hash;
+	struct ftrace_hash *notrace_hash = EMPTY_HASH;
+	struct ftrace_hash *filter_hash = EMPTY_HASH;
 	struct ftrace_hash *save_hash;
 	struct ftrace_hash *new_hash;
 	int ret;
@@ -3800,6 +3814,7 @@ static int ftrace_hash_move_and_update_subops(struct ftrace_ops *subops,
 	} else {
 		free_ftrace_hash_rcu(save_hash);
 	}
+	fgraph_update_direct_func(subops, !ret);
 	return ret;
 }
 
diff --git a/kernel/trace/ftrace_internal.h b/kernel/trace/ftrace_internal.h
index 3235470e6..3d5934b1c 100644
--- a/kernel/trace/ftrace_internal.h
+++ b/kernel/trace/ftrace_internal.h
@@ -16,6 +16,7 @@ int ftrace_startup(struct ftrace_ops *ops, int command);
 int ftrace_shutdown(struct ftrace_ops *ops, int command);
 int ftrace_ops_test(struct ftrace_ops *ops, unsigned long ip, void *regs);
 int ftrace_startup_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int command);
+/* Once started, shutdown always detaches @subops, even when it returns an error. */
 int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int command);
 
 #else /* !CONFIG_DYNAMIC_FTRACE */
@@ -52,6 +53,7 @@ static inline int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_o
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 extern int ftrace_graph_active;
+void fgraph_update_direct_func(struct ftrace_ops *ops, bool enable);
 # ifdef CONFIG_DYNAMIC_FTRACE
 extern void fgraph_update_pid_func(void);
 # else
@@ -59,6 +61,7 @@ static inline void fgraph_update_pid_func(void) {}
 # endif
 #else /* !CONFIG_FUNCTION_GRAPH_TRACER */
 # define ftrace_graph_active 0
+static inline void fgraph_update_direct_func(struct ftrace_ops *ops, bool enable) {}
 static inline void fgraph_update_pid_func(void) {}
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
-- 
2.56.0


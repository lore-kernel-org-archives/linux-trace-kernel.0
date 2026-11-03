Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728730;
	b=UI3QRL+qPe5LDP3V0YN2AT/0BHq/ZwohSLkC8Swd1mgw5dzv3d1HYp7JnxBzg4hiRrpm
	 eZQp+Zq6dsrgLQx+0ib5wI/IFqiSZqm1B/hIP4E797ArNYS/UBLIUWR8VT7g0dq8jKRIL
	 3snKC1HAR/fbzZ4mJXPgd6qb9cbSmrYaSz6aPNnSDKFzY4RuKCx4OYB6FwkLF49IMRoMR
	 HhD49TWpAoKlZej7/cqnyh45cNHT2y120k2FDRRz9FNZsSpaikFsNupYRljucTLll4sly
	 RZ/Osqs/S7S5WWYLKPznvP5RGN8Vu5WwrQ7A6c4u2CFPouX3Pkz8Hkghm6R3dykzaHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=p2G0dLEYJa6Qb+n/QzdqL+sRNnPKrQvJpRd+2nxjaFU=;
	b=f72G0q0KQ9lPldEmoDWwOZ0bl+cePtSx9gHAt0GBghL8Rf4GhXFuSfYgt9IqyoMcUTJs
	 Ntyw8+YQzEsEsRDVVw+d4ZQICOAkXKF105YMnwFmvMuYhsLpX44BAznDxa3P4d9KMO0V9
	 DI+H4Ag2Drzt4jWNR5wkxEA/7epfWwKN+csJNn/9aqpOauegyatgH+K62/NjGEhSztXIR
	 6rJAu3E6TCf6Icvm3BGzrF/v0rUCXdHtbBYKfYACNKu4ASOthU71gQojqjfJGqbMD2R/j
	 Ze1sKZ8dWKPse8Pv1TfqX/31SjsADE743VM8Q5cNmDv8ET7fPMc5qOq1Z9uzI3o0h1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wpNy8L96;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC917606A32E
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Nov 2026 17:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC917606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wpNy8L96
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso7443073eec.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Nov 2026 09:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793728729; x=1794333529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p2G0dLEYJa6Qb+n/QzdqL+sRNnPKrQvJpRd+2nxjaFU=;
        b=wpNy8L96hd9X4oCPe4lcJLBsyQJaQOHmtqbiW3hhz1P+7wgXZPIlU1tZQSho/e/w/C
         Cyk2WI/wJhPxv7g6QRuTW1WbgIe2d55m8Uyn1hjVr8/fgRmTLe1jLFemiolNRRpxOH3T
         t/ea84ceN21GWAp/gOCvpyS1nmFl9Dwj+FQ9XoNqqqulQ/U9g+AYd+ijOJGUdkN2cyws
         Iq4CW6CzXUCszRKEhS4RvpYNl5Wknx8EoM4/HWN1BzGt6USqgwVGRxscv4nJhMzMuwgw
         +ENqNAj8WK+p2ZRim1YfSTjl0s1NUI32GCEDZMdjobe2k7lohnrdkblZhs/Fzma34t1Q
         iMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793728729; x=1794333529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p2G0dLEYJa6Qb+n/QzdqL+sRNnPKrQvJpRd+2nxjaFU=;
        b=cJnGjjfSCyHUNnNnOjsuWY1sGVyjTH/Y6ov6rNew8cDUjeelt3KNqiJdwr73c2eA2z
         uYtTAXWp7I21B5GU7p822B3CMbL2Ri2fNXlfMYfw4lKCChVY/xAqrNTdy7u+Qi62VfZB
         2efx6OPW5V3exJCxM1Sn7/wW1o/QOkRAgkocTbdmUAI0sDONe/1WMhRg7wornyppNJNc
         bZpsHFBNoXTdNsh7WbTomZUqcsiuTEP1fGNohb9xb7XfZDIqcJpPt1g9XtsU9rhm9jri
         3BrQ9QwAEGbJnsWiuxTV8nnOqJEZUb2/UWycHWO2ARwGZxyFPWmvgcZYoUz41LPhY2Du
         nN2Q==
X-Forwarded-Encrypted: i=1; AKwUvBzmRetJqOeKGsozaZ6cUM/NQxop2hYZGulcd5HmEtJXVkf1YXVAgrvrSSsKIjgpWYyZSX/uDyWoyP68BS5HpTX8mNc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0DYuLiZtoG9SGEsijQytExdCUAVhSKpnhU51+BDoTcn67YnW3
	xgRL/3uNCWcMyVEptCLdbHCfsnw0F5DtY/23giY3zxjglx3vQotcox1I
X-Gm-Gg: AYBFou29dkZiICvkTUyj3dW/S9szTegqwAhWqKxMC+fDPwqrYWXyia5T6nLLscnEwdu
	7Ak0gM89WuZ4dcXMAwmhBszu5aIZFVpLvYAp73P0bttDXCa06eqZzfRx7HPBHvKbVcfDzcSJdIs
	wVSIsWBLgeLi/1sIkdb2bq6PuMvhCRw0Sw8c4uxxJPoGzDO0jO1yepIcT059LHzF56dPWkMv+xr
	fCi6PEq+LXJJZGyGO6lRgPEXMm/kXwijpnSOdW8/xsHSIgHYRJnzE6JWImxX+7CbiBkmwsFGbVj
	A6EwVa9QYaAtKQ6iqQv7R2nGsd2rcvr0wNU+d19fM360x9xovDqZh14BHhjl5tULdHg/XVssCIt
	uwIHj5dby4tIgudI9sLU/wdYYAo2zj9WiU3aEx7edBgprS9HQx66/4hYr94PsFF+1BvhvZpBCRn
	0eOUym/xfytsLWve0qj0KSuTGvHDnf++9bWz/ZrmOCaUS/0p1VaivPTg1Ih9N/7tzIan1ZQEeUe
	kQUdgH7dHPOO7VfGd3XYTj2tJXpYOypzukHivmaYFc8QZlwWfcDXNvtHS1mna1z3C1+12ucQFg3
	vj6Z0nTWDB9CpGw3HcEvQRsOafIZbWUAazr/tN8vS8AWNFfEZq6Z8nH/BAPNC6R91dVf1rSu4js
	0W6s=
X-Received: by 2002:a05:7300:4f24:b0:368:40c6:3a01 with SMTP id 5a478bee46e88-36a422224d1mr18620493eec.2.1793728728792;
        Tue, 03 Nov 2026 09:58:48 -0800 (PST)
Received: from Terra.tail0ac356.ts.net ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42952e1csm52256902eec.20.2026.11.03.09.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 09:58:48 -0800 (PST)
From: Weiming Shi <bestswngs@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	co+bba0c6b49150bef3@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] ftrace: Complete subops teardown after hash update failure
Date: Tue,  3 Nov 2026 09:58:31 -0800
Message-ID: <20261103175832.3374540-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103175832.3374540-1-bestswngs@gmail.com>
References: <20261103175832.3374540-1-bestswngs@gmail.com>
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

When removing a graph operation while other operations remain,
ftrace_shutdown_subops() rebuilds the manager hashes. Memory allocations
in rebuild_hashes() or ftrace_update_ops() can fail with -ENOMEM.

On a rebuild failure, the subop has been removed from the list but still
has FTRACE_OPS_FL_ENABLED and FTRACE_OPS_FL_SUBOP set. On an update
failure, it is added back to the list. Neither outcome matches
unregister_ftrace_graph(), which has already removed the graph slot.

For example, enable a function_graph tracer with a nonempty filter and a
return fprobe. Fail an allocation in rebuild_hashes() while disabling the
fprobe, disable the tracer, then re-enable the fprobe. The stale SUBOP
state routes its filter update through the now-empty manager list.
rebuild_hashes() leaves its output pointers uninitialized, and ops_equal()
can crash when dereferencing them.

Complete non-final subop removal on both error paths by clearing its
enabled/subop flags and manager pointer without adding it back to the
list. Initialize the rebuild outputs to EMPTY_HASH as well.

A failed manager hash update may leave functions enabled that only the
removed operation traced. Keep per-subop filtering in that case, since
direct graph dispatch skips those checks. Restore direct dispatch after
a successful removal from two graph operations to one, or after a
successful first registration.

This depends on the reader synchronization in the preceding patch.
Clearing the enabled flag after a failure allows the caller to release the
subop filter, while an existing graph callback may still hold it. Backport
both patches together.

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000802: 0000 [#1] SMP KASAN NOPTI
KASAN: probably user-memory-access in range [0x0000000000004010-0x0000000000004017]
RIP: ops_equal (kernel/trace/trace.h:1011 kernel/trace/ftrace.c:3416)
Call Trace:
 ftrace_update_ops (kernel/trace/ftrace.c:3464)
 ftrace_hash_move_and_update_subops.isra.0 (kernel/trace/ftrace.c:3795)
 ftrace_hash_move_and_update_ops (kernel/trace/ftrace.c:5095)
 ftrace_set_hash (kernel/trace/ftrace.c:6006)
 ftrace_set_filter_ips (kernel/trace/ftrace.c:6020 kernel/trace/ftrace.c:6769)
 register_fprobe_ips (kernel/trace/fprobe.c:290 kernel/trace/fprobe.c:1020)
 register_fprobe (kernel/trace/fprobe.c:979)
 enable_trace_fprobe (kernel/trace/trace_fprobe.c:838 kernel/trace/trace_fprobe.c:1480)
 fprobe_register (kernel/trace/trace_fprobe.c:1555)
 __ftrace_event_enable_disable (kernel/trace/trace_events.c:913)
 event_enable_write (kernel/trace/trace_events.c:943 kernel/trace/trace_events.c:1995)
 vfs_write (fs/read_write.c:685)
 ksys_write (fs/read_write.c:739)
 do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:84)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
Kernel panic - not syncing: Fatal exception

Cc: stable@vger.kernel.org
Fixes: 0ae6b8ce200d ("ftrace: Fix accounting of subop hashes")
Reported-by: <co+bba0c6b49150bef3@bugs.sh>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 kernel/trace/fgraph.c | 10 +++++++---
 kernel/trace/ftrace.c | 22 ++++++++++++++--------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 14733f519..48521bc33 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1406,8 +1406,11 @@ int register_ftrace_graph(struct fgraph_ops *gops)
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
@@ -1435,6 +1438,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 bool unregister_ftrace_graph_start(struct fgraph_ops *gops)
 {
 	int command = 0;
+	int ret = -EINVAL;
 	bool removed = false;
 
 	if (WARN_ONCE(!(gops->ops.flags & FTRACE_OPS_FL_GRAPH),
@@ -1461,9 +1465,9 @@ bool unregister_ftrace_graph_start(struct fgraph_ops *gops)
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
index c7d74b33d..7c712d99f 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3672,6 +3672,8 @@ static int rebuild_hashes(struct ftrace_hash **filter_hash, struct ftrace_hash *
 	bool first = true;
 	int ret;
 
+	*filter_hash = EMPTY_HASH;
+	*notrace_hash = EMPTY_HASH;
 	temp_hash.filter_hash = EMPTY_HASH;
 	temp_hash.notrace_hash = EMPTY_HASH;
 
@@ -3713,7 +3715,13 @@ static int rebuild_hashes(struct ftrace_hash **filter_hash, struct ftrace_hash *
  * will not affect functions that are being traced by other subops that
  * still exist in @ops.
  *
- * If the last subops is removed from @ops, then @ops is shutdown normally.
+ * If @subops is the last subop, @ops is shut down normally. Otherwise,
+ * @subops is detached even if the manager hash update fails. The manager
+ * hashes may be partially updated, but still cover all functions required by
+ * the remaining subops.
+ *
+ * Return: 0 on success, or a negative error code on shutdown or hash update
+ * failure.
  */
 int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int command)
 {
@@ -3753,15 +3761,13 @@ int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, in
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
-- 
2.56.0


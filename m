Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E1310A16
	for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705909020; cv=none; b=HMpBNfJiYHUVUh57pio5gGLHJpmKmH4mp4U2DRfbhWm2Hlh1tGRKH5m9tzCudRkHMlB/h73zoKRDXa8PKmXt1FMiwOLytY/kdR1Oa34X9NKP1hK7oN6epFXMhmzewUOr9fLA+s2rRqmxLssyVLQ+ojEYv6iU+BXo0lAD0f71uOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705909020; c=relaxed/simple;
	bh=qy6klsxZk7hzsrK1qWptWRv9/t7/Mr89X7/6RjG3elI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l/fQaff6nEDK5X5UmeTAL5vnFG1tjvhDRl7WWeMGEhKbLNsPvQK6beqJGT2a4H55SZJ2HE0d7x8rVoieSs2S4pVjHaRawWPEBmXeiDhX4B3APPBMR43b3oMKVjMJ9AGaRBwuaYnQ9M+bphYVHRJm5CEeonqKE7ACcqNXv1vb4LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wjt+AKpC; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wjt+AKpC"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705909016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iZwrwM1Ad6JK2YvVtV430bcdms4CvfKkXJdWk7cX5TM=;
	b=Wjt+AKpC8WI7NsljxAg7ANsxEuGl2dxMVtAUBQqPqYa0o7QYCjGdDEh4IJLnXaHzNCg17D
	5nMI2QS71LvrwZiDlCleENlxlGptuL5nTPGVrtxOk6n1xK+GkoInPZt3N3SgZo4nAbmY9R
	ZpSqKD9/4B/jPEoSLlxZvSdAm070AuQ=
From: George Guo <dongtai.guo@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: George Guo <guodongtai@kylinos.cn>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] percpu: improve percpu_alloc_percpu_fail event trace
Date: Mon, 22 Jan 2024 15:36:29 +0800
Message-Id: <20240122073629.2594271-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

Add do_warn, warn_limit fields to the output of the
percpu_alloc_percpu_fail ftrace event.

This is required to percpu_alloc failed with no warning showing.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 include/trace/events/percpu.h | 22 ++++++++++++++--------
 mm/percpu.c                   |  2 +-
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/trace/events/percpu.h b/include/trace/events/percpu.h
index 5b8211ca8950..c5f412e84bb8 100644
--- a/include/trace/events/percpu.h
+++ b/include/trace/events/percpu.h
@@ -75,15 +75,18 @@ TRACE_EVENT(percpu_free_percpu,
 
 TRACE_EVENT(percpu_alloc_percpu_fail,
 
-	TP_PROTO(bool reserved, bool is_atomic, size_t size, size_t align),
+	TP_PROTO(bool reserved, bool is_atomic, size_t size, size_t align,
+		 bool do_warn, int warn_limit),
 
-	TP_ARGS(reserved, is_atomic, size, align),
+	TP_ARGS(reserved, is_atomic, size, align, do_warn, warn_limit),
 
 	TP_STRUCT__entry(
-		__field(	bool,	reserved	)
-		__field(	bool,	is_atomic	)
-		__field(	size_t,	size		)
-		__field(	size_t, align		)
+		__field(bool,	reserved)
+		__field(bool,	is_atomic)
+		__field(size_t,	size)
+		__field(size_t, align)
+		__field(bool,	do_warn)
+		__field(int,	warn_limit)
 	),
 
 	TP_fast_assign(
@@ -91,11 +94,14 @@ TRACE_EVENT(percpu_alloc_percpu_fail,
 		__entry->is_atomic	= is_atomic;
 		__entry->size		= size;
 		__entry->align		= align;
+		__entry->do_warn	= do_warn;
+		__entry->warn_limit	= warn_limit;
 	),
 
-	TP_printk("reserved=%d is_atomic=%d size=%zu align=%zu",
+	TP_printk("reserved=%d is_atomic=%d size=%zu align=%zu do_warn=%d, warn_limit=%d",
 		  __entry->reserved, __entry->is_atomic,
-		  __entry->size, __entry->align)
+		  __entry->size, __entry->align,
+		  __entry->do_warn, __entry->warn_limit)
 );
 
 TRACE_EVENT(percpu_create_chunk,
diff --git a/mm/percpu.c b/mm/percpu.c
index 4e11fc1e6def..ac5b48268c99 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1886,7 +1886,7 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
 fail_unlock:
 	spin_unlock_irqrestore(&pcpu_lock, flags);
 fail:
-	trace_percpu_alloc_percpu_fail(reserved, is_atomic, size, align);
+	trace_percpu_alloc_percpu_fail(reserved, is_atomic, size, align, do_warn, warn_limit);
 
 	if (do_warn && warn_limit) {
 		pr_warn("allocation failed, size=%zu align=%zu atomic=%d, %s\n",
-- 
2.34.1


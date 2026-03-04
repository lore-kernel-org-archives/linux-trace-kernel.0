Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C401E3783AA;
	Wed,  4 Mar 2026 16:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643408; cv=none; b=oW4ymDA+Cv53Dlkt/BHzHJHrixGO+ee2/KYmpVkEXPHbCPSvE2loHLhx9o9bSkfXfdvjvpcnOsmCJvcGgrnSS1Af8x2ziikyo7es6psWMzZnOqHOpfNVk/tQ1vqwJ7YpZvlEZptM5RcPUwaeFT344lfOOPQ1Bf+K7BwHgTTB2h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643408; c=relaxed/simple;
	bh=5JmBbj3g3MdJ8DOStUyRPk5ylIVoyas/K+vIYjHq5sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jue6dYxZpCp8+/CAhbzavL6eA7C9G7+UtU4zN7W3BTXKOSmjlEsWMplc+u7f+7Ztbb3UsmnrcPf3Las7STRF5TBx6qMKz78xQCq6AjfbLB/zHqQSe8xP+VAK7VXbPmWEG9BEUVMsP3d77USed9wE6MQslT0xupVDESxHXDpQ4cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=kqfwZ2GO; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="kqfwZ2GO"
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 95683B31B5;
	Wed, 04 Mar 2026 16:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1772643403;
	bh=p0qelRv5zWXN2gjQ6HBma/MzWG4qFrNJfcUswY7e3Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kqfwZ2GOvHUwq/M+8X7nE6R0fTDZdiiKsHbzqYjxSvL2unY282zlkYx+aQMbunTwU
	 tA/AeImoXoVTxOeMxrb1rIaUpWCrsv2VaVLFktjjNp/lqNEuBP2cbdoVypxbWsZ0aJ
	 uHkSATeP07Do4ZvIorXsgw9xuixyQ2nRUX0SRqD0=
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Dmitry Ilvokhin <d@ilvokhin.com>
Subject: [PATCH RFC 1/3] locking: Add contended_release tracepoint
Date: Wed,  4 Mar 2026 16:56:15 +0000
Message-ID: <f8605471fd84ebff963c011aa98f79ed17f493c7.1772642407.git.d@ilvokhin.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772642407.git.d@ilvokhin.com>
References: <cover.1772642407.git.d@ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the contended_release trace event. This tracepoint fires on the
holder side when a contended lock is released, complementing the
existing contention_begin/contention_end tracepoints which fire on the
waiter side.

This enables correlating lock hold time under contention with waiter
events by lock address. Subsequent patches wire this tracepoint into
the individual lock implementations.

Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 include/trace/events/lock.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/trace/events/lock.h b/include/trace/events/lock.h
index 8e89baa3775f..4f28e41977ec 100644
--- a/include/trace/events/lock.h
+++ b/include/trace/events/lock.h
@@ -138,6 +138,23 @@ TRACE_EVENT(contention_end,
 	TP_printk("%p (ret=%d)", __entry->lock_addr, __entry->ret)
 );
 
+TRACE_EVENT(contended_release,
+
+	TP_PROTO(void *lock),
+
+	TP_ARGS(lock),
+
+	TP_STRUCT__entry(
+		__field(void *, lock_addr)
+	),
+
+	TP_fast_assign(
+		__entry->lock_addr = lock;
+	),
+
+	TP_printk("%p", __entry->lock_addr)
+);
+
 #endif /* _TRACE_LOCK_H */
 
 /* This part must be outside protection */
-- 
2.47.3


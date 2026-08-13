Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B64439015;
	Thu, 13 Aug 2026 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786637781; cv=none; b=SQYBcvBwgVsErbNDqFBCfEsL1atG007E/A0t6SLoBk+Ol7myf5a6xkJ4LLw7Ci1FcHE9va8AypVD++U1zQ5zJC8UUggO2jCSStSJjddi2vv3lWO7fUA7TM5RteckRwAMlVBqL0HOw7fCxSTB1iD9IAsD1k2U2ECN/mnPTOWSl3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786637781; c=relaxed/simple;
	bh=jW+7RMRelg95OvnIcczzObqgnCmPj9sHnOOunOZ0H3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RV3WYAyJ1goDdDQjKHv8sS7agC2GeTpLmg2HEZJ3xQNLCJ9z1lWE3sy8DJWK+2t0wyGDWpT5JoMkxD7QNVXwjntGlfEib/yyQIHzNAYBpdpe9OgK4N9W6gnBfmSYitvqkKXRdErnAcGaUhmU82Jc3+cjJUWLZKwWbfv+vMmRYgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLDmufKm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLDmufKm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686E21F000E9;
	Thu, 13 Aug 2026 16:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786637777;
	bh=zB1vV7ss6sO+5IDUELNHeOSM0TOFNrSJDfHMnU67Y80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JLDmufKmOerDz8o/Q8soto43KoDXNPJj94/wvxlXiqCqf5pz3++NNLBFt3/6eF5a6
	 O1TOrvEPp0jHgTVS4gxrc18V9NaLKJEKbbzlNYFmbqt50+lbv/HHcA+ozEOW4oYYDv
	 Q2QoO4qYaWH6QEpr+E91ofrI/2ANvQ1nF6JIbhi2N1SMiwMseIN/tGMfiNXK4DEgHP
	 aA4URTYFBUJrX4RusnznCk/OU1cY56BK9cFghIN4/5+ndV1AGMCwBOBDB6lVYHA3Re
	 jdxmaNvTp3UZw/+3Yrkr+doKXgDrTntJCs854i62KkZPTJn6tKZBmusFs/cPPrDxrV
	 EDOEa890mEV+w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Vincent Donnefort <vdonnefort@google.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kernel-team@android.com
Subject: [PATCH] ring-buffer: Fix race between ring_buffer_subbuf_order_set() and readers
Date: Fri, 14 Aug 2026 01:16:13 +0900
Message-ID: <178663777320.475864.4716637934003507750.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178663776361.475864.7685868697103378735.stgit@devnote2>
References: <178663776361.475864.7685868697103378735.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

When ring_buffer_subbuf_order_set() updates buffer->subbuf_order, it
previously modified buffer->subbuf_order before clearing the cached
per-CPU free_page entries. Furthermore, clearing cpu_buffer->free_page
was done under cpu_buffer->reader_lock, whereas
ring_buffer_alloc_read_page() protects cpu_buffer->free_page using
arch_spin_lock(&cpu_buffer->lock).

Because ring_buffer_alloc_read_page(), ring_buffer_free_read_page(),
and ring_buffer_read_page() checked buffer->subbuf_order locklessly
before accessing reader resources, a TOCTOU race allowed a concurrent
reader to obtain, cache, or swap a page allocated under an outdated order
while tagging bpage->order with the new order. This allowed undersized
pages to be swapped into the ring buffer, leading to heap buffer overflows,
or caused free_pages() to be called with an invalid order.

Fix this by:
1. Flushing and freeing all per-CPU cached free_page entries under
   arch_spin_lock(&cpu_buffer->lock) using old_order before modifying
   buffer->subbuf_order.
2. Protecting bpage->order assignment under
   arch_spin_lock(&cpu_buffer->lock) in ring_buffer_alloc_read_page().
3. Moving the buffer->subbuf_order validation inside
   arch_spin_lock(&cpu_buffer->lock) in ring_buffer_free_read_page().
4. Re-validating buffer->subbuf_order inside reader_lock in
   ring_buffer_read_page().
5. Protecting cpu_buffer->free_page extraction with
   arch_spin_lock(&cpu_buffer->lock) in ring_buffer_subbuf_order_set().

Fixes: 2808e31ec12e ("ring-buffer: Add interface for configuring trace sub buffer size")
Assisted-by: Antigravity:gemini-3.6-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/ring_buffer.c |   35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 2667992f0aa2..6d180689ad59 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6957,11 +6957,11 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 	if (!bpage)
 		return ERR_PTR(-ENOMEM);
 
-	bpage->order = buffer->subbuf_order;
 	cpu_buffer = buffer->buffers[cpu];
 	local_irq_save(flags);
 	arch_spin_lock(&cpu_buffer->lock);
 
+	bpage->order = buffer->subbuf_order;
 	if (cpu_buffer->free_page) {
 		bpage->data = cpu_buffer->free_page;
 		cpu_buffer->free_page = NULL;
@@ -7010,13 +7010,13 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
 	 * is different from the subbuffer order of the buffer -
 	 * we can't reuse it
 	 */
-	if (page_ref_count(page) > 1 || data_page->order != buffer->subbuf_order)
+	if (page_ref_count(page) > 1)
 		goto out;
 
 	local_irq_save(flags);
 	arch_spin_lock(&cpu_buffer->lock);
 
-	if (!cpu_buffer->free_page) {
+	if (data_page->order == buffer->subbuf_order && !cpu_buffer->free_page) {
 		cpu_buffer->free_page = dpage;
 		dpage = NULL;
 	}
@@ -7094,15 +7094,15 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	if (!data_page || !data_page->data)
 		return -1;
 
-	if (data_page->order != buffer->subbuf_order)
-		return -1;
-
 	dpage = data_page->data;
 	if (!dpage)
 		return -1;
 
 	guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
 
+	if (data_page->order != buffer->subbuf_order)
+		return -1;
+
 	reader = rb_get_reader_page(cpu_buffer);
 	if (!reader)
 		return -1;
@@ -7350,6 +7350,27 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	/* Make sure all commits have finished */
 	synchronize_rcu();
 
+	/* Flush any cached free_page allocated with old_order */
+	for_each_buffer_cpu(buffer, cpu) {
+		struct buffer_data_page *old_free;
+		unsigned long flags;
+
+		if (!cpumask_test_cpu(cpu, buffer->cpumask))
+			continue;
+
+		cpu_buffer = buffer->buffers[cpu];
+
+		local_irq_save(flags);
+		arch_spin_lock(&cpu_buffer->lock);
+		old_free = cpu_buffer->free_page;
+		cpu_buffer->free_page = NULL;
+		arch_spin_unlock(&cpu_buffer->lock);
+		local_irq_restore(flags);
+
+		if (old_free)
+			free_pages((unsigned long)old_free, old_order);
+	}
+
 	buffer->subbuf_order = order;
 	buffer->subbuf_size = psize - BUF_PAGE_HDR_SIZE;
 
@@ -7431,8 +7452,10 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 		cpu_buffer->nr_pages = cpu_buffer->nr_pages_to_update;
 		cpu_buffer->nr_pages_to_update = 0;
 
+		arch_spin_lock(&cpu_buffer->lock);
 		old_free_data_page = cpu_buffer->free_page;
 		cpu_buffer->free_page = NULL;
+		arch_spin_unlock(&cpu_buffer->lock);
 
 		rb_head_page_activate(cpu_buffer);
 


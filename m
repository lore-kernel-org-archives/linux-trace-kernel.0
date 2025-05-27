Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F1C280A35;
	Tue, 27 May 2025 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748372217; cv=none; b=LDVUFwEyfjaT+gQwxApKi4914P5wE0IrpVZFA/YsiYzciWGN4XbNN77irXux7936f9K6cKOyiWzAKk40yMPi2Wh+TmjvqGlr/tr4abJqVbVu1+iTPFByyH8+ne+fixkf7BP5LyQJ+n+usKMn4u5Cf3Sb+CBE6/9We4SqjNE8FOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748372217; c=relaxed/simple;
	bh=UzBD2LFNDaxTf0HiFaUy6eYRVbl/5f/e2WlI2942kQo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=uXiclFTnngGxysmOj+0IOwP3Y5hqrrHO8McadPkTVqonN+wtJYFwErHpfuBqX3158F6+3ClnVOYyBpAmCq4FLxPVWExpVa8D7V1ePgcNQr4OvAbcOw8rrBa6rOawydxzBPVirjGELnWB9b4cGUEQxGjh8B1cLksN0CoEiCU9Hsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12585C4CEEB;
	Tue, 27 May 2025 18:56:55 +0000 (UTC)
Date: Tue, 27 May 2025 14:57:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] ring-buffer: Remove jump to out label in
 ring_buffer_swap_cpu()
Message-ID: <20250527145753.6b45d840@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The function ring_buffer_swap_cpu() has a bunch of jumps to the label out
that simply returns "ret". There's no reason to jump to a label that
simply returns a value. Just return directly from there.

This goes back to almost the beginning when commit 8aabee573dff
("ring-buffer: remove unneeded get_online_cpus") was introduced. That
commit removed a put_online_cpus() from that label, but never updated all
the jumps to it that now no longer needed to do anything but return a
value.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 897ce51d3bbf..e2aa90dc8d9e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6309,37 +6309,33 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
 
 	if (!cpumask_test_cpu(cpu, buffer_a->cpumask) ||
 	    !cpumask_test_cpu(cpu, buffer_b->cpumask))
-		goto out;
+		return -EINVAL;
 
 	cpu_buffer_a = buffer_a->buffers[cpu];
 	cpu_buffer_b = buffer_b->buffers[cpu];
 
 	/* It's up to the callers to not try to swap mapped buffers */
-	if (WARN_ON_ONCE(cpu_buffer_a->mapped || cpu_buffer_b->mapped)) {
-		ret = -EBUSY;
-		goto out;
-	}
+	if (WARN_ON_ONCE(cpu_buffer_a->mapped || cpu_buffer_b->mapped))
+		return -EBUSY;
 
 	/* At least make sure the two buffers are somewhat the same */
 	if (cpu_buffer_a->nr_pages != cpu_buffer_b->nr_pages)
-		goto out;
+		return -EINVAL;
 
 	if (buffer_a->subbuf_order != buffer_b->subbuf_order)
-		goto out;
-
-	ret = -EAGAIN;
+		return -EINVAL;
 
 	if (atomic_read(&buffer_a->record_disabled))
-		goto out;
+		return -EAGAIN;
 
 	if (atomic_read(&buffer_b->record_disabled))
-		goto out;
+		return -EAGAIN;
 
 	if (atomic_read(&cpu_buffer_a->record_disabled))
-		goto out;
+		return -EAGAIN;
 
 	if (atomic_read(&cpu_buffer_b->record_disabled))
-		goto out;
+		return -EAGAIN;
 
 	/*
 	 * We can't do a synchronize_rcu here because this
@@ -6376,7 +6372,6 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
 out_dec:
 	atomic_dec(&cpu_buffer_a->record_disabled);
 	atomic_dec(&cpu_buffer_b->record_disabled);
-out:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(ring_buffer_swap_cpu);
-- 
2.47.2


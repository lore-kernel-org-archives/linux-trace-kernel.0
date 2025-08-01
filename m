Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E862328D821;
	Fri,  1 Aug 2025 20:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754080717; cv=none; b=PHQ9DoEFXrcw20VZTCGgwXN5d9PaBWKkD4pMM5U8DNFGEY5g5pxLIGKEmRTgI309vgpEoSXs6aB9L59fZ9icHDBa53ZajrpOnZ1uV5A9YMxpyaLTpemPS9CpDkHC9+moN1sn+Bo0qicuLASGN5QL8ihqvKxI7GIxmurSOT+l1/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754080717; c=relaxed/simple;
	bh=jeMxIFQt8cB+r45OB46qo/PPW19UaEPLR2jFap9uz5s=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=kb76L8eQCs5fken2HnunJn0hMmCMnTvGmMwjfIRTJ0uyr9XFhZwDn2Vmxwk/lILwSGYp3/grEnsp67c5lH6iCiWsKsh9q4bL4DyP35E5kT9TNutinhiDw+yHplfoKFGiEuFxnCLiCLyA5ZAWyqxFvMBtlPmcknmCwg4ttB85rLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMr5N3WQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMr5N3WQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D80C4CEE7;
	Fri,  1 Aug 2025 20:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754080716;
	bh=jeMxIFQt8cB+r45OB46qo/PPW19UaEPLR2jFap9uz5s=;
	h=Date:From:To:Cc:Subject:References:From;
	b=oMr5N3WQs0siVAlDcZXdHTLZeWEfoq0QyfKIm3WRm+w3zoQKcCE2kKQkNqDiOA7x8
	 EoFCpRQU6T+1aiPobE19iqwKv+olTIbmzD997ckspAMbYdZqMpsU0J9ktXDMZOaWpn
	 NSeR/HBvAmRjwbJt03bq0R/JIbPwqDyG9F/O4FJYS7licRp8aA1wvuZB4R/AuBqlZS
	 IjgAOp2gOwEbr77zA/uESK9UDxT/CcJS+008891mced/071+QFAhUMoRslgHJegJfM
	 IylLg1XnXxXbZHUvS4M4kBuihJIsxxCN+q3iWK04f4bPpC0SjzhrFGztaoCzWYrgqm
	 eHg1wa3YqA5IA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uhwWo-00000007jbY-1THp;
	Fri, 01 Aug 2025 16:38:58 -0400
Message-ID: <20250801203858.205479143@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 01 Aug 2025 16:37:27 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 5/5] ring-buffer: Convert ring_buffer_write() to use
 guard(preempt_notrace)
References: <20250801203722.072085868@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The function ring_buffer_write() has a goto out to only do a
preempt_enable_notrace(). This can be replaced by a guard.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 00fc38d70e86..9d7bf17fbfba 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4714,26 +4714,26 @@ int ring_buffer_write(struct trace_buffer *buffer,
 	int ret = -EBUSY;
 	int cpu;
 
-	preempt_disable_notrace();
+	guard(preempt_notrace)();
 
 	if (atomic_read(&buffer->record_disabled))
-		goto out;
+		return -EBUSY;
 
 	cpu = raw_smp_processor_id();
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
-		goto out;
+		return -EBUSY;
 
 	cpu_buffer = buffer->buffers[cpu];
 
 	if (atomic_read(&cpu_buffer->record_disabled))
-		goto out;
+		return -EBUSY;
 
 	if (length > buffer->max_data_size)
-		goto out;
+		return -EBUSY;
 
 	if (unlikely(trace_recursive_lock(cpu_buffer)))
-		goto out;
+		return -EBUSY;
 
 	event = rb_reserve_next_event(buffer, cpu_buffer, length);
 	if (!event)
@@ -4751,10 +4751,6 @@ int ring_buffer_write(struct trace_buffer *buffer,
 
  out_unlock:
 	trace_recursive_unlock(cpu_buffer);
-
- out:
-	preempt_enable_notrace();
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(ring_buffer_write);
-- 
2.47.2



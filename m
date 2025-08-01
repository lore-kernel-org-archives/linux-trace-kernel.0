Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685D326E158;
	Fri,  1 Aug 2025 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754058306; cv=none; b=iFd1EM6yehbayzPnUpNzFnLfpncHUTvmIwF9OE+6d4XL5X8SbaTwnl0A75J4DzXCF0ENXTJnFsP2hPUqZ4MtKmb0EfksT/zlvBu9kWmPIRzHPWYnmrdj2qF6cGH4a1PmzNb9BOM3VagyieMZXQTaJORHMx4ELApQJ1gSl+tyD8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754058306; c=relaxed/simple;
	bh=jeMxIFQt8cB+r45OB46qo/PPW19UaEPLR2jFap9uz5s=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=OytVkXOrxcAUOggD14omF7MVOsJooB780kU9GqEosAfRcH00mMB0eg3mxa9/tnHOqQw+MPHRuvyXCrh0howpX2Mzi/pk0pVP7nub2c5cIAukum4QqsIKrvw6wwImfQWflA3N9clCPkrjXTv5p33fukdRArBf4ctAnVqZCtTAbDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kxiKpxJi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kxiKpxJi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1500AC4CEE7;
	Fri,  1 Aug 2025 14:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754058306;
	bh=jeMxIFQt8cB+r45OB46qo/PPW19UaEPLR2jFap9uz5s=;
	h=Date:From:To:Cc:Subject:References:From;
	b=kxiKpxJiGFJsp8v2V6Jku1U0xZuetV4A0Pf+HC3Ghe2wxZ3VJz1O5gsQgyJI1Jbd0
	 3R3QMs7hzi3KRcL+a9m1MP9AJ6+1jxq7epaeglCvNdK3bBC/7bBFKlEqu+oBS3WkVt
	 xdC6T0N1wCDLN5WjbhCfuTEJ0vaTjWHECyI0slFyl7D7R4QoZNXbrVYQAvuD7SCO/m
	 +tpYjsV257jslCA+1O0HpDUwx3LeFjntJd5Mt/tdofJEfbmHqENh47q2QBukGMCMIQ
	 e3cMWSKMUyceKIlXsgHe6Z/lfTjxs8fDZdPtXx9vySDP3ko4pW2i2O9HZjWO0BLu7w
	 +eCQmTtvGW+Vg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uhqhL-00000007Uw4-0YYM;
	Fri, 01 Aug 2025 10:25:27 -0400
Message-ID: <20250801142526.984251081@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 01 Aug 2025 10:25:11 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5/5] ring-buffer: Convert ring_buffer_write() to use
 guard(preempt_notrace)
References: <20250801142506.431659758@kernel.org>
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



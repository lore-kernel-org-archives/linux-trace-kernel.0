Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DB527AC41;
	Tue, 27 May 2025 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748362753; cv=none; b=lNt3UZrH+t8zw7mEpFiPx2ole2ec0mqzZfcaCinUbfIf6iO4BNtErfioRN9/QuD4cms4BfLrvwjZ/YBYfo/jw2sNqPbyBFskmdrpXvPZbFlXoGTfGf0ydzUZIrJ/Qq+KIW6zBOEMHAcEb2Fq6AG3vaDk/b4V0iYsElJxqcDiYDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748362753; c=relaxed/simple;
	bh=CNK9CDLZEU0zViCZCA4FkSSlf+DIszoAtFy7fBD5FN0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PBdzHwIAIk9S8Ioi0pYzGchLy18rxoUR7Bok12Pxx0dsctvKJacAqAc+PfcUnyLBgKpeVO6pSMQiO+HtXl+33lgJaIY9CiLWxwV6ZhtL09RP1oiF0GbeL5ml1qB3fl/TZp+kJmrXkRZgEpTol5yOyVdaIwMPZqeTU2GQ09VcIHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D15FC4CEE9;
	Tue, 27 May 2025 16:19:12 +0000 (UTC)
Date: Tue, 27 May 2025 12:20:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort <vdonnefort@google.com>
Subject: [PATCH] ring-buffer: Make ring_buffer_{un}map() simpler with
 guard(mutex)
Message-ID: <20250527122009.267efb72@gandalf.local.home>
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

Convert the taking of the buffer->mutex and the cpu_buffer->mapping_lock
over to guard(mutex) and simplify the ring_buffer_map() and
ring_buffer_unmap() functions.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 35 +++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 508826886a87..f3aa18c89166 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7180,36 +7180,34 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
 	unsigned long flags, *subbuf_ids;
-	int err = 0;
+	int err;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return -EINVAL;
 
 	cpu_buffer = buffer->buffers[cpu];
 
-	mutex_lock(&cpu_buffer->mapping_lock);
+	guard(mutex)(&cpu_buffer->mapping_lock);
 
 	if (cpu_buffer->user_mapped) {
 		err = __rb_map_vma(cpu_buffer, vma);
 		if (!err)
 			err = __rb_inc_dec_mapped(cpu_buffer, true);
-		mutex_unlock(&cpu_buffer->mapping_lock);
 		return err;
 	}
 
 	/* prevent another thread from changing buffer/sub-buffer sizes */
-	mutex_lock(&buffer->mutex);
+	guard(mutex)(&buffer->mutex);
 
 	err = rb_alloc_meta_page(cpu_buffer);
 	if (err)
-		goto unlock;
+		return err;
 
 	/* subbuf_ids include the reader while nr_pages does not */
 	subbuf_ids = kcalloc(cpu_buffer->nr_pages + 1, sizeof(*subbuf_ids), GFP_KERNEL);
 	if (!subbuf_ids) {
 		rb_free_meta_page(cpu_buffer);
-		err = -ENOMEM;
-		goto unlock;
+		return -ENOMEM;
 	}
 
 	atomic_inc(&cpu_buffer->resize_disabled);
@@ -7237,35 +7235,29 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 		atomic_dec(&cpu_buffer->resize_disabled);
 	}
 
-unlock:
-	mutex_unlock(&buffer->mutex);
-	mutex_unlock(&cpu_buffer->mapping_lock);
-
-	return err;
+	return 0;
 }
 
 int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
 	unsigned long flags;
-	int err = 0;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return -EINVAL;
 
 	cpu_buffer = buffer->buffers[cpu];
 
-	mutex_lock(&cpu_buffer->mapping_lock);
+	guard(mutex)(&cpu_buffer->mapping_lock);
 
 	if (!cpu_buffer->user_mapped) {
-		err = -ENODEV;
-		goto out;
+		return -ENODEV;
 	} else if (cpu_buffer->user_mapped > 1) {
 		__rb_inc_dec_mapped(cpu_buffer, false);
-		goto out;
+		return 0;
 	}
 
-	mutex_lock(&buffer->mutex);
+	guard(mutex)(&buffer->mutex);
 	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 
 	/* This is the last user space mapping */
@@ -7280,12 +7272,7 @@ int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
 	rb_free_meta_page(cpu_buffer);
 	atomic_dec(&cpu_buffer->resize_disabled);
 
-	mutex_unlock(&buffer->mutex);
-
-out:
-	mutex_unlock(&cpu_buffer->mapping_lock);
-
-	return err;
+	return 0;
 }
 
 int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
-- 
2.47.2


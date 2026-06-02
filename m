Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19FC3FB044
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jun 2026 17:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420331; cv=none; b=eP2joNpzWcNt8ievXiqLjqfAP/GWMMJ00XmjWfHGUbgejS8wS11avbM4dtuHI7i99NWfIeBw5Z7KMj2TkUoF+fxf2V/eaRVgTOImhbNRAMOIil56QJdQiFP0mfqTrOTs47iu1pla+IwAkGelD3NJeTCBJJYLqzwO/h2a4MT+HZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420331; c=relaxed/simple;
	bh=IK5Sq6bKvY7mH+tM9X/iaLcyl0umf5WYKuSqtUMtOLc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ef+EYsupJHQaYCEXRzi5m8lSzBqWg5ylYEJC0I9xrcsItRpmi5nCSzxEwngGzleEtpNCCzDOtcyTGmyYkoHNaxGlfhEF8zg+yBQzqbslu2WT5fkX9da4/H/NF2RZIy9A1sA9fILQ/UDRcihkhYQyYYIkV6FZPUmmcw4Jipdgno8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OiDI1pcT; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OiDI1pcT"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-49058295985so67730395e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Jun 2026 10:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780420328; x=1781025128; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9u+RU1QEM5sYPoj5hIk8HPDCUYEMr+8BoHWEJxsfabs=;
        b=OiDI1pcThAYeDogp0OHHiCi7n2xl64j5RAQabcY9xH9gCQRXOEsIpeQlzCuC6n34R5
         ZXCw+NQZZaABjOb+hmqGO6y59/z/y4FVlKJmCKEZT5h4IZVCHKX3rJd+vUngQk3RKP6P
         pnZiSDlOHiTJSeh3r8/RuNTg3ORo77m4ySQ9nFL91y2FPTiHoK2f1Uhyo0fgdsC8XhDD
         ln/WFKs7+/X7npSpoTmw+/kXg+HndseinuEbD0P+Cnbshtbmy3/HnfRiqgi6++e8JhoM
         WcFnnb6A+J+1BSc8SU4AdIMAHcmyDoCF4f27B3A8AETHh3gmk4sLQNDGAsirgFqqDPU4
         zB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420328; x=1781025128;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9u+RU1QEM5sYPoj5hIk8HPDCUYEMr+8BoHWEJxsfabs=;
        b=aBfGC6GyDLVIrwnbNnskqXoDi2oatTJbhk6W6MzfAqexMwuITR4jVmTtGFx+hnDytc
         Yu1X4o1GJaC1HrIUT5Vwt/LWBwrVJDjQW83V2c3raq6SPbo7pRqEc5G0cYnJJxTIxyG8
         PBrBbiN86gOnidmhqF2ROK6ze9rpuTXpWxn3Nnyih08mtGXEm8F8kqNR+86YhcQUkUwj
         NKRbQUCNEo8XECLvQQfmE6aWE/HNbjDnaZ1+gBCXpu/uhmFBPNIJpmLXa03jZN1QlypT
         vM/rRcJEgtahkAz8AI8mspPp5BGgE7lgobi1M8P2iNigbKtvK4fmg2LRTbv161q9Bzf9
         PnEQ==
X-Forwarded-Encrypted: i=1; AFNElJ9No35Uo6eExmAk0S8H96/8UmrJPKxR65hnjlU5a1JFJ8VImPnrDO8/2BXQs3+kduzKCNHoGF8qNrw5FtmeG5PqE6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAhlaAZmZye/KYIZxjVNW2Ej3rkYs+6Cvzsrp/coc/AJeX6jRt
	A3MC+L+wLwrgzITx52HQC+BYbMbf9Xc2dJB5Xp3Nk81xC0vnTN4Pej6ftmLcojfvyrLqxnpmQQz
	bqN5hugfUhXz9GR5IQYE18w==
X-Received: from wmbgx19.prod.google.com ([2002:a05:600c:8593:b0:490:7e30:ecfc])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e87:b0:490:44eb:c1e7 with SMTP id 5b1f17b1804b1-490b50a5531mr9717925e9.30.1780420327973;
 Tue, 02 Jun 2026 10:12:07 -0700 (PDT)
Date: Tue,  2 Jun 2026 18:11:40 +0100
In-Reply-To: <20260602171146.2238998-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602171146.2238998-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260602171146.2238998-9-vdonnefort@google.com>
Subject: [PATCH 08/13] ring-buffer: Add ring_buffer_read_remote_meta_page()
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation for the introduction of a panic handler for trace
remotes, add a ring_buffer_read_remote_meta_page(). This is basically
similar to ring_buffer_poll_remote, but it doesn't try to wake-up
readers and, in the !RING_BUFFER_ALL_CPUS case, uses panic-friendly
locks.

While at it, update trace_remote_has_cpu() to use this new function
instead of ring_buffer_poll_remote(), avoiding unnecessary wakeups when
verifying if a CPU buffer is active.

Finally, the distracted engineer who wrote that
ring_buffer_poll_remote() forgot to document it. Add a kerneldoc for
that function too.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 994f52b34344..6e008a548063 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -298,6 +298,7 @@ struct ring_buffer_remote {
 	void				*priv;
 };
 
+int ring_buffer_read_remote_meta_page(struct trace_buffer *buffer, int cpu);
 int ring_buffer_poll_remote(struct trace_buffer *buffer, int cpu);
 
 struct trace_buffer *
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 7b07d2004cc6..88ac346c65ec 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6623,6 +6623,59 @@ bool ring_buffer_empty_cpu(struct trace_buffer *buffer, int cpu)
 }
 EXPORT_SYMBOL_GPL(ring_buffer_empty_cpu);
 
+/**
+ * ring_buffer_read_remote_meta_page - read the meta page of a remote ring buffer
+ * @buffer: The ring buffer
+ * @cpu: The CPU buffer to read (or RING_BUFFER_ALL_CPUS)
+ *
+ * Returns:
+ *  0 on success, or -EINVAL if the CPU is not in the buffer's cpumask.
+ */
+int ring_buffer_read_remote_meta_page(struct trace_buffer *buffer, int cpu)
+{
+	struct ring_buffer_per_cpu *cpu_buffer;
+
+	if (cpu != RING_BUFFER_ALL_CPUS) {
+		unsigned long flags;
+		bool dolock;
+
+		if (!cpumask_test_cpu(cpu, buffer->cpumask))
+			return -EINVAL;
+
+		cpu_buffer = buffer->buffers[cpu];
+
+		local_irq_save(flags);
+		dolock = rb_reader_lock(cpu_buffer);
+		rb_read_remote_meta_page(cpu_buffer);
+		rb_reader_unlock(cpu_buffer, dolock);
+		local_irq_restore(flags);
+		return 0;
+	}
+
+	guard(cpus_read_lock)();
+
+	for_each_buffer_cpu(buffer, cpu) {
+		cpu_buffer = buffer->buffers[cpu];
+
+		guard(raw_spinlock)(&cpu_buffer->reader_lock);
+		rb_read_remote_meta_page(cpu_buffer);
+	}
+
+	return 0;
+}
+
+/**
+ * ring_buffer_poll_remote - poll a remote ring buffer for new data
+ * @buffer: The ring buffer
+ * @cpu: The CPU buffer to poll (or RING_BUFFER_ALL_CPUS)
+ *
+ * This function polls the specified remote CPU buffer (or all of them)
+ * by reading its meta page to update the local reader's view. If new
+ * entries are detected, it triggers wakeups for any waiting readers.
+ *
+ * Returns:
+ *  0 on success, or -EINVAL if the CPU is not in the buffer's cpumask.
+ */
 int ring_buffer_poll_remote(struct trace_buffer *buffer, int cpu)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 1bf0ba159c92..e708dcd7d258 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -291,7 +291,7 @@ static bool trace_remote_has_cpu(struct trace_remote *remote, int cpu)
 	if (cpu == RING_BUFFER_ALL_CPUS)
 		return true;
 
-	return ring_buffer_poll_remote(remote->trace_buffer, cpu) == 0;
+	return ring_buffer_read_remote_meta_page(remote->trace_buffer, cpu) == 0;
 }
 
 static void __free_ring_buffer_iter(struct trace_remote_iterator *iter, int cpu)
-- 
2.54.0.1032.g2f8565e1d1-goog


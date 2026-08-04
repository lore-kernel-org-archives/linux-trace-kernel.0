Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18B146D2C9
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Aug 2026 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852248; cv=none; b=p3Ix+VquDeSyxM3H/CLh6f6tbsI1kvjAL6mvqIP2DDCYrnjLBb0yEedwaleCGSwEy/UDBkFWNdLzmJEfKixxYNX2SvFVrh7aUYw4HfrVKruGnnzD40Z0qKsgQlP1OUCVEsuUcVP2W3h7PrWaMQ3TeUEKhcTIo02gZZgbu2hQKJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852248; c=relaxed/simple;
	bh=4ykr12J+DjdEXXIEP+A4fCL+3wftmetGDkfrdHensTo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RUzkcNpr0ffgkU1PHZLZdeSTHg3aBTDE649J76MkkiFtZg7YoTgGoAjG6HstXzYrJaRenEWLQZZ1JElPqJgYXKeOt1X0yxEKhrDC4Ry7Zsw5EFTZ1zpCEOidZKKO/afr9zO3q9GypumTCwdnrkqkvJTMVuekfQ7nF+wHkdG8Tm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XEr6iQFy; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XEr6iQFy"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49554715277so30342235e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Aug 2026 07:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785852245; x=1786457045; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l1+/wJcPmvAu6E3WJyCfTChbEoVq4yPAHjqItT2NwAs=;
        b=XEr6iQFyWBjqYSbhUHiebmsGDRJqWLpekEmw0AwR/yyBVC3UVwYkpU60EjuLRAkrAt
         qwA3M28MFgxXCuAmu4woyvJIuwi44u+udspI1BNnajolSWWCRjKSZvZViQBQVMYdLDnq
         aZQf3Utc0zSZ5HxRirebQ/sHzJdpTmFektDaY+swCO21fqt/dC+Y/qLLqINXI14+VCvz
         D7PX7hZPA57tG0Da8l3PDGEyL9amNDwUIhC0YGLQ5Pim0oZwoasFkA6RoyhCnnL6L3wh
         4rh2FnybTD+c0QJCyEeEfNwNJaXqTRng5DXlchkG649zjMagJ8fkL8OixE90KdNcn7Ew
         JocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785852245; x=1786457045;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l1+/wJcPmvAu6E3WJyCfTChbEoVq4yPAHjqItT2NwAs=;
        b=K8AjaPNcJQRJVukFBCbA7wTc0Ftoygu4HDS/0i1Xpd1NRSdvEcyrQW5As+8SSiHwYx
         wGIpLxhyal2BGoteBvc3aUAYl6NcKnmBacvxBIuEr+AhcUwjI2ddunFURbfi2obk8AyQ
         WZ1TFD8QVpaUpEX6Bv/paPFxB1FqdtmxkzygvrLwvsNJEsf3tGImoM2AC+lJyvWqlIvv
         Bf398FBW34SKDrnQbAT2mo35qm9vqKNXFis5BGmROgB0TCjytJrB6HYIBZTbPcchYvtk
         n2N54b0L/kStUvpugKZS2+fUDAialuU/jg4DgxhRWq+B/xpSYDBUru4Pyvi98GwgU7Q9
         OyOg==
X-Forwarded-Encrypted: i=1; AHgh+RqcuqEytQ85q/J2dK/Fs8sxkKYbhb68/GXog0fRPUNHVOBm2UT1gZ60ABls0EMd+jshSl5kSSOCViF7+9/c4wgMHTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZYxPiqt2OHS8fLu30XgXBywyyjvqm8ZCTamTQf9zkX0P/wDZo
	nAfDoYujt7YGNA9/C04+GgxWF1uLrqBcSSjfUJK6p05aQFcBYzFZiotFhKvOLbLRvURStqFN+L0
	npKjLJgAemOfhyX0rooIGHg==
X-Received: from wmej10.prod.google.com ([2002:a05:600c:42ca:b0:495:66f2:4250])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3148:b0:498:11b5:3ff7 with SMTP id 5b1f17b1804b1-49811b54490mr251707165e9.18.1785852244620;
 Tue, 04 Aug 2026 07:04:04 -0700 (PDT)
Date: Tue,  4 Aug 2026 15:03:26 +0100
In-Reply-To: <20260804140333.797210-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804140333.797210-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804140333.797210-12-vdonnefort@google.com>
Subject: [PATCH v4 11/18] ring-buffer: Add ring_buffer_read_remote_meta_page()
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation for the introduction of a panic handler for trace
remotes, add ring_buffer_read_remote_meta_page(). This is similar to
ring_buffer_poll_remote, but it doesn't try to wake up readers and, in
the !RING_BUFFER_ALL_CPUS case, uses panic-friendly locks.

While at it, update trace_remote_has_cpu() to use this new function
instead of ring_buffer_poll_remote(), avoiding unnecessary wakeups when
verifying if a CPU buffer is active.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 0670742b2d60..3c0de6593c81 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -299,6 +299,7 @@ struct ring_buffer_remote {
 	void				*priv;
 };
 
+int ring_buffer_read_remote_meta_page(struct trace_buffer *buffer, int cpu);
 int ring_buffer_poll_remote(struct trace_buffer *buffer, int cpu);
 
 struct trace_buffer *
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 239041704e4d..4bb1a7780860 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6807,6 +6807,47 @@ bool ring_buffer_empty_cpu(struct trace_buffer *buffer, int cpu)
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
+		guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
+		rb_read_remote_meta_page(cpu_buffer);
+	}
+
+	return 0;
+}
+
 int ring_buffer_poll_remote(struct trace_buffer *buffer, int cpu)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 58a38f3d4902..2421550d5601 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -350,7 +350,7 @@ static bool trace_remote_has_cpu(struct trace_remote *remote, int cpu)
 	if (cpu == RING_BUFFER_ALL_CPUS)
 		return true;
 
-	return ring_buffer_poll_remote(remote->trace_buffer, cpu) == 0;
+	return ring_buffer_read_remote_meta_page(remote->trace_buffer, cpu) == 0;
 }
 
 static void __free_ring_buffer_iter(struct trace_remote_iterator *iter, int cpu)
-- 
2.55.0.571.g244d577d93-goog


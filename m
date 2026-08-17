Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8095A43846B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974941; cv=none; b=ONQ6Jf+H6+2FLMqe+OcOuRYKY3WP/O1q/dIx6f7PyTR2Nm1BsivuMUsmq/4GH9LuScgYjcOD9iq7vlRfpTMYqVEW/Cb6rMPd7truMrGpOQVGb4ejzN2h9db8G5Q0baBVCUvrBMo5avkIXI3/CQlqpG8/mQPlwgci64t4ytuwJtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974941; c=relaxed/simple;
	bh=0buim+GLezv7UcmcEYPlcew/FRZnMVn2NaaWHPhgq2k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gDxKjaur7isxYLIA45GcKskQQp4hWKBFEw9dHQ3eyzPBgwMPB9lpmPSJ+5YKK2txTZ03Z8H38JTCN+UxvE1na5SuHkGekon2usWcTW5RSgJwgxSL50V+rwCdsOxbjb0eeYC649iVrWS22rnLgNNWYJS69A8L6/gSxgz7vX0c+AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gPW33SJd; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gPW33SJd"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-496bbcf7d1eso27778775e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 06:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786974932; x=1787579732; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M/+mM+yAGa1d3mhSt8ncAaOe827emzSuD4j6hilgerk=;
        b=gPW33SJd/GnJJRIBF/T2+85EIVTQt8YMSUwctBdn/5ivQnkLfh7Jc5IyaPyxSXZT7H
         wJidsZaQT/iwJsSl88ellTNXXHu9Iwm2rTw8EG/gNMha0Re+ywsZa9IfgwhiawJntxpQ
         aB3RegaiJncRAurhWSuuR9ZaQr4tTmd63xr6Q0ehtR2KDJUFxIV928ef/Z8zEqd+HZzp
         ScoMrkS7mznL43x6x80R6Tj+kaMke55rOHs4/ispj3TJHjQXVlaCjQS2ACDceWNaS9z9
         XaH0XMEaItqxzAcRj5iofP9HorVI+u/Yjnjko3xcTcfw1KmJgZUVb8S/C6Aw/5tbhmur
         I6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786974932; x=1787579732;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M/+mM+yAGa1d3mhSt8ncAaOe827emzSuD4j6hilgerk=;
        b=ZBzGdkrHDnPi+O22V+eTM7lt2FS5aZztt/xd1bDtL0hDcR+4WjUi1QhWD0r8WA1Jk6
         tpxyprkLBUffbAbdfuY0G7crfTvib/3KSC51OnXClg8HU30JvcU4aOSYWmqJnU0teBPC
         tyhu9X86yJPy3LOv2xOSp/6SqXc279KgCGcOzBDER+cADEj7qe4Xi0HmtVAfUqYirW/V
         dz6w9lYhx71accvn/1LcQVDnQSHpnq/sxIoTxFqkU/CZyC8K1Je/lWRUaQ8wUOpR5oY7
         9Fj6BMsIc86dtDZjsQcUViVwHH4xtIdnCZI5sAY7S/l8H3VwpHoYc99CE1lv0hwt7y+F
         bjLA==
X-Forwarded-Encrypted: i=1; AHgh+RomFsfcyZInzjZ/IEi0mzL/qu2wTs93mGuj+E2VjSvgdnPjfccn0X4Q1U7n7l9Yi0XVytz1HpVjG3/U9GUYhP5NysY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaBEpvDDf0krJ9/P80jVsrbqj0QUscRlMhpjPwTDk+va8Ea3gm
	4OYQ3yaoXNCehifoJJKOWj5GeW8PCqhawUpHn3LTPj1HLlyDQ7Pf6NatazhsibAkyT5nZgLgjHL
	mxmIlJfdanS1mkIkAyanlNw==
X-Received: from wmcv23.prod.google.com ([2002:a05:600c:4297:b0:493:b719:1145])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a7b:c5ce:0:b0:499:726c:d658 with SMTP id 5b1f17b1804b1-499879bb9e5mr279555845e9.19.1786974932188;
 Mon, 17 Aug 2026 06:55:32 -0700 (PDT)
Date: Mon, 17 Aug 2026 14:55:10 +0100
In-Reply-To: <20260817135517.3919534-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260817135517.3919534-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260817135517.3919534-12-vdonnefort@google.com>
Subject: [PATCH v6 11/18] ring-buffer: Add ring_buffer_read_remote_meta_page()
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
index a6f2293f409b..77561f90d0e4 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6810,6 +6810,47 @@ bool ring_buffer_empty_cpu(struct trace_buffer *buffer, int cpu)
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
index 3a5e0d84c172..9e78267d71f8 100644
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
2.55.0.691.gc56d675ccc-goog


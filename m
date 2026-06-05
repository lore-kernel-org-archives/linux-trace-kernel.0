Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F304E3B42FF
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Jun 2026 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780677591; cv=none; b=ag2lBMAN+MuIbKCvwXw/3nwIZEoWzSuVN+gFT+7UIaXjrVeXJ2ZpORLdWXBNXPLLauSPOvRv8VSIHV0p1s+KFIRPLhpr1gd2MYgU9k5xl/uT7qXeHmCssNu3Y7AB+XOU32f08xZ9tM42E86SyJgvp/eZWxXfVoKdcUkyF0Fs6TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780677591; c=relaxed/simple;
	bh=GUNeWjnkRtv9F5nfgqsZ1NuJVjW5hzloIkJn6TDviT0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NWPIu32i090+Uk4q1OfGc1hWnne+tyoXEHh9BN+oy8L1K6hKKW/aM75amypNODdwjojTeRuGcGnjv7se++e4mrWZ5lH/2SMO+mLWF/l42RUPthJjOzMhUU4BXNeUxwHeP8TZXWGUb8jj+tHmsNf4YJ2OQER6IXWxWaQZjln11aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ke8hOyz/; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ke8hOyz/"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-68fa01a8b02so1518132a12.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Jun 2026 09:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780677587; x=1781282387; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h6Z2x1Lu4IhM6IjuH0hi2nolqw5JAakv2CV+EufayTM=;
        b=Ke8hOyz/Y6PuZDFkeRg16B2dzB9JHE8GfH9g056xtUksJGFE/8YbPTePNTselpHEjK
         n4EufRtdzzSuaKImb6/HxW2IlQ4pAmJSEfYCp/TrbXoRg/Ygkm3z/gZkk7YsX4c7CJYx
         VbtYbrsbuGEbI/ZGsQ997r+xK60iUFMDGf2QTzPT+WEhG9nT5VHUeObx5jM0vytI9FBG
         QRxEcX7Wd5z+LZRB0y3vjrnVs0vWABvmQ7pilawUiRK5tWznB7FxIywUDN1SG8y/sZzR
         dV8EffzcfblVv9H2XNwz2SntTIvpa5d/R4gbF0MgCDECAniDjb/oeLISSE8rhtay4+BQ
         3Uxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780677587; x=1781282387;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h6Z2x1Lu4IhM6IjuH0hi2nolqw5JAakv2CV+EufayTM=;
        b=ddEWaoy5iSyZUZMH18HDYm7mUKNfY6lbnQy7cAtOaQ3gt/L7GEUoL2PlpHROg8/l5X
         QpFHB8AV8x1DwK58nD8LduUAfs2STSiDB+c1/qzaVrVsNV4tIC0fmwdKb0K7fzXx3Tom
         1ZQIxa/ypKcBZB/r+stMPyTkV+IJmNmJBC5yE/jVrz7Jr+TaH6oG2QLvu1ozCkNKbwWP
         2/UkhPluiWOXcvviQ+DrmxFqMRbOipnU83yCm+dTyDicQjygI6O7B2r9Wb5HRMflQfEU
         YtA5wfx5DqrUhUU0TlhyW8rEdOCaYpFsjy3N89o40mqNUt1HlND5RVn6F118UVoCe0Xz
         UdLw==
X-Forwarded-Encrypted: i=1; AFNElJ/HlEU119LsiJWnTg1XFKFmx1B2kMllMsKMUXqirPRPlkPRdpOEH7L4TODotFKYiJwKdErLHBu0mYLBE0edRYyMjlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYdq36P4Ikw+qfJwvbOpyoNLFox/CC2yf6Vf5zJz7abeqis6QW
	XUjvsLd5uVlX7NHIA3H1Wt3qZi1tVyFQVS3hi/3YuSo9g1AN/UnuWiQDF8QwAxOpH0X25WZ3m9C
	8qgSfBy6mOPgA7mCStZbjBg==
X-Received: from edwr3.prod.google.com ([2002:a05:6402:343:b0:68a:abfd:6659])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:a2c6:20b0:68b:451f:88d0 with SMTP id 4fb4d7f45d1cf-68ff217355amr1240828a12.9.1780677587193;
 Fri, 05 Jun 2026 09:39:47 -0700 (PDT)
Date: Fri,  5 Jun 2026 17:38:18 +0100
In-Reply-To: <20260605163825.1762953-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605163825.1762953-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605163825.1762953-12-vdonnefort@google.com>
Subject: [PATCH v2 11/18] ring-buffer: Add ring_buffer_read_remote_meta_page()
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
index 88ef44e2da53..efae14e3ba80 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6635,6 +6635,47 @@ bool ring_buffer_empty_cpu(struct trace_buffer *buffer, int cpu)
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
index 19dfa355b7f3..b0404ad8981d 100644
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
2.54.0.1032.g2f8565e1d1-goog


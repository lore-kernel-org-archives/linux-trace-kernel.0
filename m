Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCDD38944D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551240; cv=none; b=SmwNBfrKyrkNR2mzi3O74QGnvUTTE7VA6YmKsjC9RVD6GnuJnSa3gEbWUVhlm84YyCCwEkznjnpypnze22/qWLCrRHerEoRrymlX0V8nBTziqtMTfhiTpysiK35iA+Wrg9eJ09iK8mck5yDkp5OwsCRit2PwFlq7vGvAwXJy/nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551240; c=relaxed/simple;
	bh=0buim+GLezv7UcmcEYPlcew/FRZnMVn2NaaWHPhgq2k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rgVsJwB/qAHkZTcRFB8eEdCIMf1qNq/gWJaPaADcVsaR8W6sAzzcgVjditkJ60mhKcM2dUwsQ2C+08tK1EUKwqv0pqDzDj1oNWUVw+AUzdNMj5hcdb7eu4W5FLtolOyolTc+XQsSJqHF/LX3cH3bsQH68GV94swAg3xRJTVUPKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=juFG/wFG; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="juFG/wFG"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4997b060af8so7425155e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 09:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786551237; x=1787156037; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M/+mM+yAGa1d3mhSt8ncAaOe827emzSuD4j6hilgerk=;
        b=juFG/wFGWR3l7+juyRoKP5gY/ji/mPMTS8pN8KQ551j/ysbOBUV4Gduve8vuoiDzQt
         PUZFDbmaydzwb8wMvfkQX4kAcJYzxfoc1DI4u7U57QMNSvTofpSCm4My5P0ndVQW+D/9
         KSm7yg6ZUuLgUZ7gclri/RDWdxye9ODmK5n6gtwdoC83ONGAgUU7IlwFGS+TlVHR3NuX
         F392Zt0G3rdM3LSWIpp+yfjHgrFU2gNi9rl3g9rkl5HHwxLYDuWnRTqX6GMOwzK+sCw1
         Ldff5whRcMkcFY421EqV30rjKBB2oXJtdLRUFNyKA4yFthocouDgjJ99Z+FjIHcoedJi
         s33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786551237; x=1787156037;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M/+mM+yAGa1d3mhSt8ncAaOe827emzSuD4j6hilgerk=;
        b=BU29M7j/R0OCQpJg1XHGM+X5EvfX9ezxWHLH992C1OabTmyGlrm2hSQAP2jwAbm6Nv
         MHYnHLSSyEAgAxRbdoHigz0buPsLKVVF4N8vCzXVWis8290+4cY3gNJ49WnCyCp4Pzx0
         VIZq63TW8M01oyMszaVxK96MGzLZyYxIBpL380LIt+OEyWXsrtdctnuzREgQOlrP7WmN
         evgjJp5Q6+aktWjFlFx9RrRMTjeDg83EgU4zMm2SBjkrCsvBVf+Q3HxZYfMXoh4PNKRb
         VRQMAUiePTrFZjdyeNn999S7GvyWqNv1yDkcx9JelGrCwRH2DnTVri0YsWVVvYvnAJps
         iYCw==
X-Forwarded-Encrypted: i=1; AHgh+RrlrZhMeso+GEs7Tbyro4N4yyqzyDz7AL4FJcSI8HunKDf0QNzqswwyLXCt2PY+3LH3WI7b+oPFENPw/7BHztPSXA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPSlO4LfuvMRlyYjDvOQGWMwd8KCVOWtHKHyfrM1F4WGJrcVCC
	EBeCDfb5zR/BcSd2lgB4YSXukoaYLc7UOuypzthEV6sKS3ANHGX+2+ym+MZQU3GZZDwW0tDMLJ7
	qTrL3gsEilbU8Q05bSLE1MA==
X-Received: from wrsc3.prod.google.com ([2002:adf:fb43:0:b0:47f:8f3e:9a28])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:468f:b0:499:4892:e84e with SMTP id 5b1f17b1804b1-4997c14569amr67460745e9.11.1786551236585;
 Wed, 12 Aug 2026 09:13:56 -0700 (PDT)
Date: Wed, 12 Aug 2026 17:13:33 +0100
In-Reply-To: <20260812161340.2417322-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812161340.2417322-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812161340.2417322-12-vdonnefort@google.com>
Subject: [PATCH v5 11/18] ring-buffer: Add ring_buffer_read_remote_meta_page()
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


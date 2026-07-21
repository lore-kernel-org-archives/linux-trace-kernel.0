Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1FD47DD5A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630196; cv=none; b=LyCHohqxgwVvPgbI/Yy3JObDUiYv9Us/pouGNrCsVAzAzRZkIZB1MNWVynAc0lDa1wpkXa5W9T297uKxq0yDXAKZ17s4VP8YdJcRiAu8dH9VrvYLC7eXL4D7ulbBJhj3bqC8oYsJuvO+4ZFRpe6Wxn8G7TttCohtvE5FbLgw5pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630196; c=relaxed/simple;
	bh=tqb9hClnsbzzrqME6yk9pwSsf3qcS3X3j/sxi4nfxO0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mCfN5AWJNFGojtVB/Fjg8jhRSbFIcwi93SVIHUS6dm0Ka+uDfRZ+pJutpTP9ZFbUnIH5pwpTpNFloLgkfJ2ABPmlrh7SvrFf0DYc4jAU+Mn/s18q2xi8OCuOOaTfSfM3F57TiPq9qbu8BkDYSrHHtnGsYqtCXJweP42shUdD/lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=utBsQtw3; arc=none smtp.client-ip=209.85.221.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="utBsQtw3"
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-472c330e555so5438704f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 03:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784630193; x=1785234993; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QaNBgaHJNIj3Shc+crJefx+umJMnjlE9OsiQWnPI6wY=;
        b=utBsQtw3SIESpQzQpEjmgVtWDQo24WRwAn8vpPmkgNeHPZKZBVNyprnP+IYAPgBWrE
         XXXwStpJLiFtKwGOa8wOx2OCZQTtPQDPgZkVvaay8L+FGEn/340GKSp9kY0oD8akmpA5
         jLDGNhC2Db74x5qkn3qFiaRng1xm7RjzX1jpkZcubaNomSA52MdLEme9ec3C0M8Pz5hy
         wJqzrGLkxN3Ig5bXNEyUDUpM6Ad5zxkQVzi4bapiLtctOpOsqtYuAPsbCkkICnmIx94S
         WgkT8wXnjvCzTx18nd8FJEQlGcZFoO+LAUNzERb8IL7ZJhumGIeLEei3C1dtbENrdnJh
         Nw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784630193; x=1785234993;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QaNBgaHJNIj3Shc+crJefx+umJMnjlE9OsiQWnPI6wY=;
        b=NDm4/eLjuGBAoWOMks2jqkQ48wfjiSmuynU7ladnIMEL0OKJoyymnxNNYB36Kjb3iK
         yRPE7bshUuKSug/uvYF3KSMgUp/Ft4yZrtXVVd4PGw1oNIPFnMR9Ct/m9sVstSr89k3L
         YFP1tfisu7w+etGa7AhsigFG6xbzwCde4jLi7PD2xnSj/cPyAJJtguzj4bl93zUAofSk
         Zp2pO5GVhq6TKqXt0A834/OjxniyavxKyWL4Nifm+EDa6rA5C5+fq4vNH3/LuoVrWgIl
         eqhMmOgMoMWceEYHdguPH8VI/Ih/rW0nl4fUQ7+EOTKrrW284RuxzOcF7DEJqiNcIAVn
         GWUQ==
X-Forwarded-Encrypted: i=1; AHgh+RrC3m5yNckCqPvruCAZfUtdmNAIidB5jW/4pgpL60nH30GAwv1Lxbh/QLGLMEhY1svJRG6hY0wvG0+nwLFElLf91gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzatYr1QTD4dtulUzInAixJEsR9T0J+mEA/2+TO5TsxZWcDzUAP
	+UUb9z/btFBo8MW0/o2k5juZfL7bglXLalGiat640rLR2sUKCIoImyFDch7AKrtIHulj/rc0Tpa
	e4hjWmpDQadiXBjmnyTrFkg==
X-Received: from wrtf11.prod.google.com ([2002:a5d:50cb:0:b0:473:c5ac:de69])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4382:b0:47f:8212:54fb with SMTP id ffacd0b85a97d-47f821256cbmr1572826f8f.2.1784630192998;
 Tue, 21 Jul 2026 03:36:32 -0700 (PDT)
Date: Tue, 21 Jul 2026 11:35:56 +0100
In-Reply-To: <20260721103603.342266-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721103603.342266-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721103603.342266-12-vdonnefort@google.com>
Subject: [PATCH v3 11/18] ring-buffer: Add ring_buffer_read_remote_meta_page()
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
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
index 517bdb061083..c35e36c553aa 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6805,6 +6805,47 @@ bool ring_buffer_empty_cpu(struct trace_buffer *buffer, int cpu)
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
index c54e1c65d163..fcd2dd754f6e 100644
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
2.55.0.229.g6434b31f56-goog


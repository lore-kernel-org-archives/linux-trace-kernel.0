Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDB949E5F1
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261922; cv=none; b=e4MgBerQSr5XIxKF7w77grTddmjSs70KwKps14mySjf3NRHY9xO9lpwhbXSRhP1TzfqRuyAsvGCP8DP6L8O4qiEGi3Gi2X69mMb6ENqfzbAChH0CGNOwl1cC/873ZkLCObd0OuSnqkj+JwTvkLexBeQWtv02R14LS4GszcVaFwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261922; c=relaxed/simple;
	bh=j71Sqg0HqieWplu84cLXf0UWFIJkhiNp/QWh/moIYSM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U3Kv3D1IxsI4ojAeJrF9MfwAlDTh6W/uDX2vHxYNYAH7IN8atkeglYjofb8ZNdntycw92Yjznp5DuiOs7f27NVA6ax0bloTMasz67tjOnhPEYfWD4dtDPcpJPpo90TreE0r7kbj6QEbEZraATC1fDft1q8MMmhO4NMD8U5bMmcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K7nCJLkV; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K7nCJLkV"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49b0e6638e3so17816185e9.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 07:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790261918; x=1790866718; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p7BbaNLQdlfwNnIQp6SkICmB6RAILmmvxnVT02lEHvo=;
        b=K7nCJLkVnm+qQI2d2eRHd7M9CROBV97Ua5llehx3Pead34v5HyEE74aoWb9dnhMR2Q
         bH2AXqVz1Mvxlpz21CgAcaNYsYR/CYq8bkIV7YD+ZXITeNI1wSezRuE9fRM+iWjgI4Sq
         cI6HffsZT5bFOVKIB6JU709QVnQ7epiQTDHTsqLO6L1gIDS32qNevP99NjIzf/qLWIEZ
         2zgxDDkmYKpU9TG6vf/aK/G16UA3B4QXABG5S6i9gmr6j2OH+PZty2MpLfDPMJ7DNCP1
         HEKrtjWg8RKjnW//55QqSss57KQDJ8W0bw7zApJtpIP0QKRrkm7K1X9qlUrn+BAkqiiZ
         t2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790261918; x=1790866718;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p7BbaNLQdlfwNnIQp6SkICmB6RAILmmvxnVT02lEHvo=;
        b=tcG+wCggczu3PWpxGFThQdYgSmRgcQRqGPbP7vYQfknqIu0hmhnEupOpkumh+S/DFD
         ZQinuamKC5LFZ80nQyJPV+NDe1j8lSkydbQkQvfSl6bFbau0xswVEE8NfeCVVaf/YqNL
         RWtFKyg4TAvEgWA4qfk4GfUbur4t2+bmU+F5GVY1Aq3UYOQ8Nyxo8KkX7Ks73eJLvIOD
         W6oR/rUB21VpcNm13KbsroagZBvqPF+/3IoEFfOyJi9n2s9akl2FmSHJWrfqmWitnPes
         RjBHiPhUKS1YRcK4oE1NGbIz7mAMgPNxAu87ThnZ7NLUM/e4fy3AMLAbR9cMttWQZnVZ
         WGJw==
X-Forwarded-Encrypted: i=1; AKwUvBwjchVacsTNAVQOY8Ga+g0SyNEboiSBDZyszlOCXDCap7rU8sYeDIwNqoPupjb5CEeV6QpjZXOuaPoqZ9HAxU9gHPI=@vger.kernel.org
X-Gm-Message-State: AFuF++mwNy/Ow0lOgwE2I5SGDFr7FalX9C+Xf06y9BDsj5Lf72/Th8Et
	hnNy1zQKilSUsOvxV1tDtC64PcVnKtq7OuYO/n5gb1bVnUivv34tE6ZCTeepGOXNRYueI2bRyiR
	HXpld0zsYkGsajZzZ9iKSLg==
X-Received: from wmsr18.prod.google.com ([2002:a05:600c:8b12:b0:49e:602d:8036])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b86:b0:49d:1fd8:b874 with SMTP id 5b1f17b1804b1-49fe66f13c2mr49000245e9.19.1790261917979;
 Thu, 24 Sep 2026 07:58:37 -0700 (PDT)
Date: Thu, 24 Sep 2026 15:57:47 +0100
In-Reply-To: <20260924145754.1285146-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260924145754.1285146-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260924145754.1285146-14-vdonnefort@google.com>
Subject: [PATCH v7 13/20] ring-buffer: Add ring_buffer_read_remote_meta_page()
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
---
 include/linux/ring_buffer.h |  1 +
 kernel/trace/ring_buffer.c  | 41 +++++++++++++++++++++++++++++++++++++
 kernel/trace/trace_remote.c |  2 +-
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index eac3e9080c3c..31ad626f48b6 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -315,6 +315,7 @@ struct ring_buffer_remote {
 	void				*priv;
 };
 
+int ring_buffer_read_remote_meta_page(struct trace_buffer *buffer, int cpu);
 int ring_buffer_poll_remote(struct trace_buffer *buffer, int cpu);
 
 struct trace_buffer *
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index f9533a97e2f4..df16e05d7049 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6902,6 +6902,47 @@ bool ring_buffer_empty_cpu(struct trace_buffer *buffer, int cpu)
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
index 79afb2cdf358..ea0fc347dff8 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -351,7 +351,7 @@ static bool trace_remote_has_cpu(struct trace_remote *remote, int cpu)
 	if (cpu == RING_BUFFER_ALL_CPUS)
 		return true;
 
-	return ring_buffer_poll_remote(remote->trace_buffer, cpu) == 0;
+	return ring_buffer_read_remote_meta_page(remote->trace_buffer, cpu) == 0;
 }
 
 static void __free_ring_buffer_iter(struct trace_remote_iterator *iter, int cpu)
-- 
2.56.0.rc1.310.g51773c2048-goog


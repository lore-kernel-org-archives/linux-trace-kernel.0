Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895E03E95B1
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Mar 2026 16:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073590; cv=none; b=mCvAqyFespjW0ybpc2XDsCA4TLRfR5Br9UcDdFueSm16S3WMEY3ffr2vKVpH6PzsDyd9sTqd0np9JnfmqrcdCRJ6L1VDWdxqIX8SHqPlkn+oFm7GcKyYfj7yagGdcGqVr7QyoZeAB2bOkTJcCJ/V3snTm1YbYKcarwGiojE+03k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073590; c=relaxed/simple;
	bh=uwYQWXJq4cr4nt+LXGOlVB79zrFFf6vy3e6v8doz2/E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uO7Elv7KdxZnxzXg/mBpRHsR7huHt1zPY1bMff8DH+K/IkSCRxjegpbp5Cj+GVCZjiUXBr4XuMcJx4id7Bx8qReW+E+p3R8swoPrtx8CG1DM5dJ9HvAe6h7jRrxpeFfn8++RMmKNJnAWq1ubVN4dlHc+I7GDRGWEJFEFuCX5zE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=prxdfGvK; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="prxdfGvK"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4853040372fso21808975e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 09 Mar 2026 09:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773073587; x=1773678387; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wZNlRO5e/MGzFMVxx7Ks/cRDmNOcF7u1/X5pARmyFgQ=;
        b=prxdfGvKC8X/lRfi18HoOMoyMcKREmZ8cuMAlXJd/oSsDwgwvEOhRi7JWn9OZbLzND
         fSYAmMl+ONRRZ7tt/8RW4yZI6bqyH+j2bk9enEfw/Q3FNwACC+sj/CaSuXHcjAgX7N+X
         yCI9jTpjiumn6cgRQ/suZNpbxbouw0xt9pHwUoJhH4bRAUKbHD/F38xVEvqU2CAvvca6
         hDfHuJipDtDIxxsx+E2vk/ZaCYPnWYYvrA5JIbhaKncZK0x7Jk1Zu6Y3Q3V97rnQtiOY
         DHTkJFRmZX6T9wNQ/ho5BcQqC2shsYqFu6Q98DhhpXhTPa/PtU941MBObkg2O+4ZDPHg
         Bpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773073587; x=1773678387;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wZNlRO5e/MGzFMVxx7Ks/cRDmNOcF7u1/X5pARmyFgQ=;
        b=fGyQTjh4VrZe2gEtxMh5pZtQFNXNi943jN1vK2cQ9oXnTO3O5LohKJXsRUpltzraLs
         05JDyK/7JlMAiJOoZMKer3aLZ+m9ZO0hv/NLrOIGvF20jNpRAWWEVFui7NYjAFzfasj3
         c8FsbStgCn7/bZyvqHbIhsXYxQ2IZ2xBgGpqfjshGx727XXUOb+LZXvBTTucHE/9OT46
         HKzniy89e2x88X9LiRL1Nz31P4HA3KhjJGu2Xj7bx0zeY+Ya47x8QTqsmC5lf7X+SN4J
         b4daS9FYGarFSC8wgTEzeN1Sm4UVyyUKWsKi0fZsfU1PJO7C2boUw5+IuKFZa+roxMG1
         l+Qg==
X-Forwarded-Encrypted: i=1; AJvYcCV+vwctKeSuAHJkjFhSSFhjhM3g2nFXJMLm8MKtIWFFkplk2GEolhl+HRJNnWJtLuGCyQs/elNM7YMYeldhyzjM+qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIAg0S34bUlzj5e8nq62/oFutk+ulHDRQU4Peg+PYRYgQGCT18
	oCo6/o13DwEPLlAecx6LvONmb4MI2tYCBcI/w4FMSYvt9Qishg77mieBGXE+qKnjd2oGcEss0EW
	QwT1hDOKYXZr0itjrW5cOAw==
X-Received: from wmet19.prod.google.com ([2002:a05:600c:2ad3:b0:47f:c96e:8381])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3ba2:b0:485:35ba:1d81 with SMTP id 5b1f17b1804b1-48535ba1ea6mr94547295e9.21.1773073586927;
 Mon, 09 Mar 2026 09:26:26 -0700 (PDT)
Date: Mon,  9 Mar 2026 16:25:12 +0000
In-Reply-To: <20260309162516.2623589-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260309162516.2623589-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260309162516.2623589-27-vdonnefort@google.com>
Subject: [PATCH v14 26/30] KVM: arm64: Add trace reset to the nVHE/pKVM hyp
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Make the hypervisor reset either the whole tracing buffer or a specific
ring-buffer, on remotes/hypervisor/trace or per_cpu/<cpu>/trace write
access.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 9c4fe3bfbfff..66abf77cf371 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -94,6 +94,7 @@ enum __kvm_host_smccc_func {
 	__KVM_HOST_SMCCC_FUNC___tracing_enable,
 	__KVM_HOST_SMCCC_FUNC___tracing_swap_reader,
 	__KVM_HOST_SMCCC_FUNC___tracing_update_clock,
+	__KVM_HOST_SMCCC_FUNC___tracing_reset,
 };
 
 #define DECLARE_KVM_VHE_SYM(sym)	extern char sym[]
diff --git a/arch/arm64/kvm/hyp/include/nvhe/trace.h b/arch/arm64/kvm/hyp/include/nvhe/trace.h
index fd641e1b1c23..44912869d184 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/trace.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/trace.h
@@ -12,6 +12,7 @@ void __tracing_unload(void);
 int __tracing_enable(bool enable);
 int __tracing_swap_reader(unsigned int cpu);
 void __tracing_update_clock(u32 mult, u32 shift, u64 epoch_ns, u64 epoch_cyc);
+int __tracing_reset(unsigned int cpu);
 #else
 static inline void *tracing_reserve_entry(unsigned long length) { return NULL; }
 static inline void tracing_commit_entry(void) { }
@@ -21,5 +22,6 @@ static inline void __tracing_unload(void) { }
 static inline int __tracing_enable(bool enable) { return -ENODEV; }
 static inline int __tracing_swap_reader(unsigned int cpu) { return -ENODEV; }
 static inline void __tracing_update_clock(u32 mult, u32 shift, u64 epoch_ns, u64 epoch_cyc) { }
+static inline int __tracing_reset(unsigned int cpu) { return -ENODEV; }
 #endif
 #endif
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 02d5271199d5..9b05f0c87586 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -625,6 +625,13 @@ static void handle___tracing_update_clock(struct kvm_cpu_context *host_ctxt)
 	__tracing_update_clock(mult, shift, epoch_ns, epoch_cyc);
 }
 
+static void handle___tracing_reset(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(unsigned int, cpu, host_ctxt, 1);
+
+	cpu_reg(host_ctxt, 1) = __tracing_reset(cpu);
+}
+
 typedef void (*hcall_t)(struct kvm_cpu_context *);
 
 #define HANDLE_FUNC(x)	[__KVM_HOST_SMCCC_FUNC_##x] = (hcall_t)handle_##x
@@ -671,6 +678,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__tracing_enable),
 	HANDLE_FUNC(__tracing_swap_reader),
 	HANDLE_FUNC(__tracing_update_clock),
+	HANDLE_FUNC(__tracing_reset),
 };
 
 static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
diff --git a/arch/arm64/kvm/hyp/nvhe/trace.c b/arch/arm64/kvm/hyp/nvhe/trace.c
index 2c8e6f49d7de..a6ca27b18e15 100644
--- a/arch/arm64/kvm/hyp/nvhe/trace.c
+++ b/arch/arm64/kvm/hyp/nvhe/trace.c
@@ -287,3 +287,20 @@ void __tracing_update_clock(u32 mult, u32 shift, u64 epoch_ns, u64 epoch_cyc)
 	/* ...we can now override the old one and swap. */
 	trace_clock_update(mult, shift, epoch_ns, epoch_cyc);
 }
+
+int __tracing_reset(unsigned int cpu)
+{
+	int ret = -ENODEV;
+
+	if (cpu >= hyp_nr_cpus)
+		return -EINVAL;
+
+	hyp_spin_lock(&trace_buffer.lock);
+
+	if (hyp_trace_buffer_loaded(&trace_buffer))
+		ret = simple_ring_buffer_reset(per_cpu_ptr(trace_buffer.simple_rbs, cpu));
+
+	hyp_spin_unlock(&trace_buffer.lock);
+
+	return ret;
+}
diff --git a/arch/arm64/kvm/hyp_trace.c b/arch/arm64/kvm/hyp_trace.c
index 1e5fc27f0e9d..09bc192e3514 100644
--- a/arch/arm64/kvm/hyp_trace.c
+++ b/arch/arm64/kvm/hyp_trace.c
@@ -313,7 +313,7 @@ static int hyp_trace_swap_reader_page(unsigned int cpu, void *priv)
 
 static int hyp_trace_reset(unsigned int cpu, void *priv)
 {
-	return 0;
+	return kvm_call_hyp_nvhe(__tracing_reset, cpu);
 }
 
 static int hyp_trace_enable_event(unsigned short id, bool enable, void *priv)
-- 
2.53.0.473.g4a7958ca14-goog


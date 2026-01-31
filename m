Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249C835DCEB
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Jan 2026 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769866190; cv=none; b=ng/zODV+LtDr5r/MkKiEbEFobCwjiUMjcJ8l9xvykm0DXbxWACQx4C+pbejM2UJpKjUVEfj+RUCHDiaL0cFKKRRjnXtnOgOYe+yeVdPhg8ZQ12hhJyK/Sgsw+NyTQFQYUc8bZPadJ8xi/lUuHA+PT9YRyfK+8fDBBo7EbL9RQnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769866190; c=relaxed/simple;
	bh=bVsSvNIxRvkfjgEZMc4BHM6toYEjCu9hVcCZBW789dk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jeegktwryavODOvA187vEnmdRO0e34/OSDt2SxDLEkcZr7g/6UgIUH0L5Kw9poPz8WvncyT9Bduj8UvMDBnJ/4AnQK72cn7QcSGCrrxGEKDeq92mjEB5Ssjx1P5T6uN3ndP7b+1u48nLRqYkcl2wGCdRBrkL0iSPVcf3m0k/5dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o8fNKLqt; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o8fNKLqt"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b88649b11d2so452224566b.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Jan 2026 05:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769866186; x=1770470986; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=klNtZXITSNnjVXJK4UiBawa/P+I9Z7pdBnip+Ybnk/g=;
        b=o8fNKLqtevuMmLo1/O4vcbgTAQsgMD9vqyP/yqzio5OLircO8OUmwo7tzHT5dSUSkY
         hbYmTmz+Wp7l01trWpjoq3zKhE77PN8Tx+B2ECHiA5LoZF6+yGwZ5Jf/Z7RfuXsdJSCW
         cHvs0dxweQgeqbBWmJxDGIZGsr0xc5DbkxYwjMVEra0XdqDE8dV33t/Zc2utKox5FGIC
         uXFzPXRsZ3UBmkvm3upW48O60N49iiiv6xJNwM7H2gFWYgCPmhKIpCUW2E7Zl1ok6rNS
         Z0YmzHpFsyZfbMmPqrZ6v1VBl4yyJ+pWaNhOvrDbW0lHtrhg39sGXxjaNMB+HBV6QOZy
         QnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769866186; x=1770470986;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=klNtZXITSNnjVXJK4UiBawa/P+I9Z7pdBnip+Ybnk/g=;
        b=XzRqcYYm+Vm8/9uvHkumOGwgnwg4rnpJ8slPa0PIubQpG2am+7c0BBeCN8AaL0OGTu
         +MzL8a3W/4Ml0ySzWC3ceef9HQjREuKOUc8zJ4oUbJzLqB9zl8k36/enVANy4Z8mxk/1
         SrKLYiCbd0SjZdShJLUrZwK6u6aF+uik4mwmXMP7Jf5FTdUF0f48P+7RYUEGD8vaiUHO
         pXEhfdM5MDt55Y1fSBi3b+8UAYtHg5+zbLL5CFSYQP+51YQiPc7yua0Ysq6tYcyjdfdW
         UxeaHsLYawlZfE0eQ4dl4fPap71lYV9WejcDuRaoIMMOfrGUoCIf2DyqUzlpjXmxH0M8
         EpWg==
X-Forwarded-Encrypted: i=1; AJvYcCUEubmCWrjRd3R4Itt9pwST0aSyadgw6I9WElGSpcx2XXT5zx8Ika+YrXlPomXpGq6XQHGbke2Y4dZV3Lkl/U1KY3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqyWSkjoatvlJgxBakcQ4h9acwQdYiJbAQBATg/L4WMdi7b4/c
	P4Ek6DUgbJNf4PxFk/fVTZN8KpxAFtggw257IPU9hU78r1xSX5Xw9KQgrg3xtRJhIAgvRc07vy9
	+BrHghzjgUFY3w6oq960luA==
X-Received: from ejbze20.prod.google.com ([2002:a17:906:ef94:b0:b73:9000:7e99])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3c92:b0:b87:225f:2e74 with SMTP id a640c23a62f3a-b8dff5dbcbbmr368357266b.14.1769866186355;
 Sat, 31 Jan 2026 05:29:46 -0800 (PST)
Date: Sat, 31 Jan 2026 13:28:44 +0000
In-Reply-To: <20260131132848.254084-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260131132848.254084-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260131132848.254084-27-vdonnefort@google.com>
Subject: [PATCH v11 26/30] KVM: arm64: Add trace reset to the nVHE/pKVM hyp
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
index 352ebbedaab2..c5cb2adde7ed 100644
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
index 9df0d37a494b..5acbd451efbd 100644
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
2.53.0.rc1.225.gd81095ad13-goog


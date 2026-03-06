Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A173C6A45
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Mar 2026 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807783; cv=none; b=Fk+oOK7VMhJnfTrdol5EeWugMP4gU+J1f5AjQba9pT5vFc3SkBR2RYvddGaYZvSq8tN9gw9cMnhf6G9sgb3FPU8CaOkykPApKVZWtn9P9fRXDecXqddxkH5znXXk105bdlv4zBrK1gIwIUpcY/CBYaw3No7Wszn46vjfZxobdMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807783; c=relaxed/simple;
	bh=uwYQWXJq4cr4nt+LXGOlVB79zrFFf6vy3e6v8doz2/E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qIEeWqHpWEzlHH1NzSWmIBb+8Jpk3+H2B4so6y8tQW8b5bRoCeny5c6Qs6Rer8cVonYRw2AJRGbxOOQjke7E17QoiZ+QbNVArlV3oB9G0pc1mvKN//dKF2zWiyk2+cr6RkozBq24dEcyN1nDqhK45cpV8PKA17hFXbNtAtBkJs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3jCnQMhh; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3jCnQMhh"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4836ff58111so98961725e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Mar 2026 06:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772807779; x=1773412579; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wZNlRO5e/MGzFMVxx7Ks/cRDmNOcF7u1/X5pARmyFgQ=;
        b=3jCnQMhhpIP8xtEV4vqGqNpyRPA7uHq9lz1XHFzYCu8MUs7pbsJSdT3x1i9dnPGxXw
         G7dvwx1rFc90p6+14dK/7zs/rwo2xQG6xKnKKKenadlaWoL+ouDgFuFUjVkwpLmMLTH4
         +JQbkol/lIu9vBQGvsbS1iqTNuMLNnjdwkNLQpgLFOQFeb0sC+oS17MyWhnTBuGxpv5j
         ZtDPeIW2md9S0ufXMmhEuOYm++AKDAfQAG8TEf40H2uJh3Wz21qmG0zyg2ON30leE5hq
         rkdOOqx6yGkAUgEJr5BaMgZGHqrYI6v+De5I8uggfxE4xvHg87pshW3zijgJQLrOc3Zr
         gokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772807779; x=1773412579;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wZNlRO5e/MGzFMVxx7Ks/cRDmNOcF7u1/X5pARmyFgQ=;
        b=DSAYyHa5TAGDI0DQEs9FGjAxguqyulT4ASFij5ZA+MDGsPJK3aPKVegheFIGgw0CLJ
         w8k4AdBzTH7nGfYzhhUjUr8CM588bHiLWMDGzcu1cOkPdLKHMaO94ssURzDVsfWPSdHz
         R6BxI8DVGfP466X5XJ9ON7WfYanYTSF1LZQWtNbIW7gT+yEuAu3hQuWEP6/lAmJvZSKY
         eOhIsDpWserd9ZNxJ7CB4pdEY9xOxqHJ1qUisNLmlNvb4ZtjCVCoA0o3SxKMfu6uPZMp
         TLbE8bCSThAC5fJ0UlOYdh/lsAF4RsZqc728XYKqV9M758phgOJGzi0NWQjQfIhg8fSJ
         b6MA==
X-Forwarded-Encrypted: i=1; AJvYcCUbgFJPLzHkn9gvyjHY6GxzVV3Fm6lpR0RaEFFcSUKBTMcwzBp0LqnIGBqx61IA8WMOo3wtPBJd0nfuhJq4hKWn6IE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSLZctNRp3dvA+ICExA0H8WQcpigrK38aNra25QxUbdphR3S+d
	yA6bn4Zl+2xc1TrVVjoCHuD23zQv1xVDV+0Ax6Vm/P2bTjk6d4f9f2imhk8SFNo52eWcvSuZrmM
	0szKlg4+yTxbPminPfpO3BQ==
X-Received: from wmbdv11.prod.google.com ([2002:a05:600c:620b:b0:483:7c8d:ed1d])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5253:b0:483:456a:514b with SMTP id 5b1f17b1804b1-4852692f158mr38056235e9.12.1772807778854;
 Fri, 06 Mar 2026 06:36:18 -0800 (PST)
Date: Fri,  6 Mar 2026 14:35:30 +0000
In-Reply-To: <20260306143536.339777-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306143536.339777-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306143536.339777-27-vdonnefort@google.com>
Subject: [PATCH v13 26/32] KVM: arm64: Add trace reset to the nVHE/pKVM hyp
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


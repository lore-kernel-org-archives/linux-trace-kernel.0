Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5056F32E6B1
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 10:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424293; cv=none; b=TThBolquZgt2Shjlik9XU6Ic31FYSwfkh8BARxhQp0kYGCpKSAhBLEqRl5+qOiBc/A506rYtYnzEYOMU7pQV5tlJop432tgGF3nnlQmatjCEdw91SMwcoML+ZgugLXJXetPc+aKpZAJw3JEu/8twdxJ+/Ua4og88SocwRiCPR/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424293; c=relaxed/simple;
	bh=QFKjh1R2iw3S0W0hXtvPh8PHuYOY6kFyXpOghIsh/CI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FrldILXsLxSAkkjYuPKfLVPFZgNP/Mm7OZMQnIEvrRgOt3gxp+HMSjtapkq7w6p0pjweCq/r/d9vKYSQlpPAwzSOWnU5DMNatPD4iJCPvr0aEHnR19UGjFBBeLXl7TGMKwGv5DjwFDqNCiYQB5eceD8wiJsoGKPhLfB3yTN6/88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=onbCchpj; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="onbCchpj"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4801bceb317so47143645e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 02:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769424289; x=1770029089; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D5VGkgm1sA7YTajg4sL82LxwMLKcPOrXuXxlizx/7Ps=;
        b=onbCchpj9XEalpr4YfdCyFYVn3tJRUBdP2rQuidw9NXPlT96edzyswXRrnnDTCfGcv
         wbUnkEaD5rjHGlXppielEvK+65LhdyZN9aTiD7/KxfVOdcau+7/850Dv3k5mcZtAcfXU
         Xena0E2plufG3zl68jiUggOee7DI2YFhh2kAFx2DRXr5zMn7XH2nUfxZHMIEp64j2lkw
         OUNvwKSLfxS4b1BMZBsu9KvwmYDX3HBstnyFr4OfBvFAzWFXLD/VUJ3dkVRWGzmj4xKH
         y8S8EqTP5CZBNuTNpVF7qa2Wxa9sZIJ1SEPBXdLdfWgT9tvnEUJwqhuSTvdDfIutvPBK
         D1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769424289; x=1770029089;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D5VGkgm1sA7YTajg4sL82LxwMLKcPOrXuXxlizx/7Ps=;
        b=OMIhPkBX3p8pRxzRAjJHHKDCd70MD7lna+MuI1tLjYd+vdfCt4Ib+wNqKBjCVsYF01
         z9Su2+ESSlm+guXtGrTt2Wzy/IYj1zIUT31geMLRJwiBkwgLOrjIbldVNm2obdQzYgdf
         JTtQp4/XqUrNdwBR7xq6DE31nCGWUaXB+1bDg/uBBBFMboQwacC1TUZKNkXgIMoyyjJY
         Kdbxk9Hj04mDkAcIaeOATxDDEsPXU98DuvXP8ONmegleQyTZxIU+C9Za9vV22h3ygyYU
         ANIFizQeq9jz5jK1PTiTSH6hYd8u+xsJz9vURgdMbmU3CcVhSVc2YtQHtV0hGbn6Yv0Z
         GPbw==
X-Forwarded-Encrypted: i=1; AJvYcCUuizB1zOv7u8cCM+V5hKFoSW4ylkJaGcYif6XBK68Wz5Bhn0kdrw6ZWsLy+Cq8yv7/fv5WZq9GEhGMVP57op0Dmsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw44JuDTWiXD6ehTa/ecsuDMemyahrpHbRHu6DsF9cVmTxRziIy
	6cbT+A0HfrCtlwS/QL4GCBzGiHD1UZ6DuSohbLvbF9xEGkdzcGAFwQpAuSD3epXqyiEA6eiwrmO
	wXvQdz+YFJXIDqrWawmnPDQ==
X-Received: from wmfr9.prod.google.com ([2002:a05:600c:1589:b0:47e:db03:6850])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f8e:b0:477:b642:9dc1 with SMTP id 5b1f17b1804b1-4805cf669d1mr57613505e9.20.1769424289565;
 Mon, 26 Jan 2026 02:44:49 -0800 (PST)
Date: Mon, 26 Jan 2026 10:44:15 +0000
In-Reply-To: <20260126104419.1649811-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126104419.1649811-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126104419.1649811-27-vdonnefort@google.com>
Subject: [PATCH v10 26/30] KVM: arm64: Add trace reset to the nVHE/pKVM hyp
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
index 97e9f6c1a52c..93475cc36640 100644
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
2.52.0.457.g6b5491de43-goog


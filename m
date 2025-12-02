Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B8D32039B
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Dec 2025 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764668221; cv=none; b=BWFOrvP0ApcuQF2ESmyd0QLU6eMC/cwspZiFSVW1nX4+GIDJ1/aIb69TkMZCatZQIh4i14yVpg7wa64Ns7M2pEIDZbkB8DB3ON5yjWvWy6A2guWklpXg1MQeo8TFedESCZneLE1R97j+1qXrPmwk4RWACYSN8E5KQ0sGB066muA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764668221; c=relaxed/simple;
	bh=qTbHPCSdBPQqySVFZymIwcDF5oRcWOCun/2CVgn5za4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YKL6VokrRkKOlQ5XNmQ9FJt4Hh4DvFfVPImXH6UzXy3MDbM5DBrQWO2hSgJjs2WMuOa8V5X1G/LL3cUejuUd8GSh+oVF5GVUhbfvuevjsD2e76K7yyF2YzzV1RPHYX89cFC2Jde89ZGHGL3/Yb3vZTvwVkNaMbjoewfb2V98J78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=istR5lRL; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="istR5lRL"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-477b8a667bcso58839175e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Dec 2025 01:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764668217; x=1765273017; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bEnANpDqC7DUDnEr2ekaLVgf0v4JzeZNFTwI2/AeuLE=;
        b=istR5lRLll5fYAIQDlAVjXE48HXQ4ji/2dN1S0tPxUWQkKUMdQ4PI/0uY2nCTlTWlH
         RAUyx5qMh09f/41Q9T/WM3UaSOhAyPK5BYRhTH+kmxwk83iTMNpLJLinEvAmVU9Bgoyn
         e5S/pwNZSHz8/RQ9aRMQwBzajqFoSf0nnuak8q5x+zKMV8LUvHEIaZQRnmReblBUPUUe
         8jGLYXCBOGEJ/78iXjuVP06h6pIGQK5/PdcTqbv9ARjHLsXOJwcu/7WbCBfLnQzKBaq0
         SlwYYEANhxeiVvfpkvzx9HFzU5v1G/TLz9W52IOXYKoxynKxOy1MAlkt4RY2bTnkyYNh
         Qpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764668217; x=1765273017;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bEnANpDqC7DUDnEr2ekaLVgf0v4JzeZNFTwI2/AeuLE=;
        b=RiAkqrD0ugiChsSdZvKi8r3Pa3vez+1wUcOxtmhwFVkXT89zxiwXfEZWJdoK0C5Tb1
         FWhyPOSyR4wNRuPLEjImYgPF0J+vxFTNQ83XtZrhnx7coTW8GmnL22eCewSsMq6bxFn1
         /kE1GMWARpmUnb+P4a8MjkegtcEDfYFww9q3SwRd6GjacE0+f8UAYBPwWC3sVvawHPA3
         SPwy28+5L3SACCbbOYW7EtJqaMPOrQv6FXkWigMbM3Q3Q1VmXqo513zk3Nf8GsJ/EjqU
         htpz0DJjgRxVNfJ5TIDVWnESktw+u4MfRk3KEb48L83vfHBp0h425V/indxbPElTl4qT
         cguQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAQjJHkKlw7wsBiuG4F59NBB7UECaXoKMe3eME0nWIiwjlx2tCft+gackVC1I7PbUviVjJ2v8U+mAiDu+RFv+NLgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YycSInHjtSKUUdCMnMwrzddydNAc1t1cA/VKM9V+iwSUwR9s9Jb
	SbKOJg4QyKKeaL9rJCXxDbgzM1/XFLelg+h2zGbyhkR9LSLb06KudhatAkabie0tBePOXSmjSh3
	YP1HZN5jRwDCjD9BPDpPIXA==
X-Google-Smtp-Source: AGHT+IER9UhUXOk0INPeDjv7f9jwsIm3/XwUKhMfyM3LlqPp5ud54kE4SsIEfAALA0iAVFhbNzkMQB7hQXqYJZIE
X-Received: from wmga5.prod.google.com ([2002:a05:600c:2d45:b0:477:aa1e:920c])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c8f:b0:471:989:9d7b with SMTP id 5b1f17b1804b1-47904b160e3mr277571685e9.21.1764668216619;
 Tue, 02 Dec 2025 01:36:56 -0800 (PST)
Date: Tue,  2 Dec 2025 09:36:19 +0000
In-Reply-To: <20251202093623.2337860-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202093623.2337860-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.52.0.107.ga0afd4fd5b-goog
Message-ID: <20251202093623.2337860-27-vdonnefort@google.com>
Subject: [PATCH v9 26/30] KVM: arm64: Add trace reset to the nVHE/pKVM hyp
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
index 375607c67285..a28b072125ec 100644
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
index 45b8f70828de..f92e82cbfcb4 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -625,6 +625,13 @@ static void handle___tracing_update_clock(struct kvm_cpu_context *host_ctxt)
 	cpu_reg(host_ctxt, 1) = 0;
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
2.52.0.107.ga0afd4fd5b-goog


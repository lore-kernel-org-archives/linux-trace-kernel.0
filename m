Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB502F0C46
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764094; cv=none; b=sZ8pMjrU2RaLIy3MYYM+IOIOQ/WeRjk7ihN4r+HwgqcxS0R7aDHPMKw0RF0drJxMm6Wy2I97uPIYmTMklRLXJPKzrze0mjrL38ScLWSZymHR49B+QObhMwgEWGLcfy5zY08Gj+1DlJzxKcx68nxE9WuUGkvqlAkMv7eBBitYf94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764094; c=relaxed/simple;
	bh=jypk5uOzFJnzT2qErsq1qKMfgdBOaynt2C5kV5nnb8k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W1C0IzKQ2LZBb1sQVYJjR+aRlKxucMjI1GVCuPTrxWkguilCi09mfY/8BV4gK1iXwFVYiGerPWg7vjRNBEk8hBXBaYMmlvFHWMtcYwwVIVBLVHNpp7HebwT7WMMeYYTIU3tRAfszBWhOPKZM6p3denyIKyiXvLjaQ09zx788M80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FpbwLB8d; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FpbwLB8d"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3b9edf34ad0so297409f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755764090; x=1756368890; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Anc7yfsrkZjtmAwVlWu/raMXGnSP49ufLfjdUKF9Bzs=;
        b=FpbwLB8dYmMXIs5MFMix0S5p12Vu4pHfAyeWhXqBLzJ3U/dhgQQHGTUaAcqWbpAyAp
         vt/F9PzzMQS8jS515Q5HMaJfIYz5PmFxOqIO3gGgx0o7IKOGG04bQuGy0fxjb1+ToyMP
         0W1QHt+KjYd2BP5FsAp0XTwQv3vAusAqS5BVLpcNpChsEEQ/N1kYlGWgiJ1M5zCE01gW
         K+TtttceVmPlaZUiGZQWB7ob7Td5vlsxcakvx72defLbJ4+arr4yF+DACaG+zmcy+j1V
         UWJjtrSEv/0LNRG2xeRf4jMW0aBx0iz74RL9IK6WTLS48a65qUQWdSJL4w4awGmBrmnj
         Lhgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755764090; x=1756368890;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Anc7yfsrkZjtmAwVlWu/raMXGnSP49ufLfjdUKF9Bzs=;
        b=cbwDZqWNrt/2u0/t6o9aMfM2d9vTrCwZ4CJSJ6Yntenf0GZdrxNww5zr8jW4D1pb0q
         mDGaB3c625fv8kUbluna88YlpsiRFov/KwSPSfcoxM3cvhqX9nE0sAeTzcDoqtxKjSM0
         g5tZkZmgPvM2kW57DAPVMdJDAfY11KY9FqhWVClEGmQVZvIzzH6aasFSMbwrfz/kyE2n
         xqq4NxVq9Gycw44qIuRXOOXBmeIMbUxcJfekcZwdJLP0OSFIoY/p+ndGOQdnbVNOh+rI
         DuzH+yXG+GA8I4VoM7u6hnD3ENgXDRovyfoLLGR0Lz9mBuCAlc8vYQgHZTKz2hdRrf3x
         0WzA==
X-Forwarded-Encrypted: i=1; AJvYcCWL0uRF0Gpjc9M1EV8pYS6FcJ6EakvZQIfSgsQq3yYUo+R0r87qCO80WXyX+qt1+PGH641rT2F/XrImMwsM5rrmaQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiK+C+4bitvF7Et5qFdGvkJmiSKWCGmbmHJ1/A1pcosjfPcLSr
	WxaSIXIO9TYa0/43EVEjz12CPaTTSXeYKuhf67UGKeuhNR8T3rHP9D91j4fAJafBrQ0wCFOybCp
	gHOes8iDnucg5oT8BTs/3vA==
X-Google-Smtp-Source: AGHT+IFe/ozybAk7VIdtcz4OiVN8ypSFB84+/HqOqWcPlIw7lP5kraFDV++Jsyd/28g3gn+e5nGHBsqAwfa7Z6+X
X-Received: from wmbet4.prod.google.com ([2002:a05:600c:8184:b0:459:ddf8:fed5])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1a8d:b0:3c3:5406:12b8 with SMTP id ffacd0b85a97d-3c497836ba0mr1259766f8f.60.1755764090639;
 Thu, 21 Aug 2025 01:14:50 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:14:08 +0100
In-Reply-To: <20250821081412.1008261-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821081412.1008261-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250821081412.1008261-21-vdonnefort@google.com>
Subject: [PATCH v6 20/24] KVM: arm64: Add trace reset to the pKVM hyp
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Let the hypervisor reset the trace buffer when triggered from the
tracefs file remotes/hypervisor/trace.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index d122d79718a0..c40820a4b049 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -91,6 +91,7 @@ enum __kvm_host_smccc_func {
 	__KVM_HOST_SMCCC_FUNC___pkvm_load_tracing,
 	__KVM_HOST_SMCCC_FUNC___pkvm_unload_tracing,
 	__KVM_HOST_SMCCC_FUNC___pkvm_enable_tracing,
+	__KVM_HOST_SMCCC_FUNC___pkvm_reset_tracing,
 	__KVM_HOST_SMCCC_FUNC___pkvm_swap_reader_tracing,
 };
 
diff --git a/arch/arm64/kvm/hyp/include/nvhe/trace.h b/arch/arm64/kvm/hyp/include/nvhe/trace.h
index 4e11dcdf049b..0d2732f0d406 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/trace.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/trace.h
@@ -11,6 +11,7 @@ void __pkvm_update_clock_tracing(u32 mult, u32 shift, u64 epoch_ns, u64 epoch_cy
 int __pkvm_load_tracing(unsigned long desc_va, size_t desc_size);
 void __pkvm_unload_tracing(void);
 int __pkvm_enable_tracing(bool enable);
+int __pkvm_reset_tracing(unsigned int cpu);
 int __pkvm_swap_reader_tracing(unsigned int cpu);
 #else
 static inline void *tracing_reserve_entry(unsigned long length) { return NULL; }
@@ -21,6 +22,7 @@ void __pkvm_update_clock_tracing(u32 mult, u32 shift, u64 epoch_ns, u64 epoch_cy
 static inline int __pkvm_load_tracing(unsigned long desc_va, size_t desc_size) { return -ENODEV; }
 static inline void __pkvm_unload_tracing(void) { }
 static inline int __pkvm_enable_tracing(bool enable) { return -ENODEV; }
+static inline int __pkvm_reset_tracing(unsigned int cpu) { return -ENODEV; }
 static inline int __pkvm_swap_reader_tracing(unsigned int cpu) { return -ENODEV; }
 #endif
 #endif
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 36a263422e4e..a7c5e9fc27a0 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -608,6 +608,13 @@ static void handle___pkvm_enable_tracing(struct kvm_cpu_context *host_ctxt)
 	cpu_reg(host_ctxt, 1) = __pkvm_enable_tracing(enable);
 }
 
+static void handle___pkvm_reset_tracing(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(unsigned int, cpu, host_ctxt, 1);
+
+	cpu_reg(host_ctxt, 1) = __pkvm_reset_tracing(cpu);
+}
+
 static void handle___pkvm_swap_reader_tracing(struct kvm_cpu_context *host_ctxt)
 {
 	DECLARE_REG(unsigned int, cpu, host_ctxt, 1);
@@ -658,6 +665,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_load_tracing),
 	HANDLE_FUNC(__pkvm_unload_tracing),
 	HANDLE_FUNC(__pkvm_enable_tracing),
+	HANDLE_FUNC(__pkvm_reset_tracing),
 	HANDLE_FUNC(__pkvm_swap_reader_tracing),
 };
 
diff --git a/arch/arm64/kvm/hyp/nvhe/trace.c b/arch/arm64/kvm/hyp/nvhe/trace.c
index 32fd889315f0..b6d97237a7a0 100644
--- a/arch/arm64/kvm/hyp/nvhe/trace.c
+++ b/arch/arm64/kvm/hyp/nvhe/trace.c
@@ -230,6 +230,25 @@ int __pkvm_enable_tracing(bool enable)
 	return ret;
 }
 
+int __pkvm_reset_tracing(unsigned int cpu)
+{
+	int ret = 0;
+
+	if (cpu >= hyp_nr_cpus)
+		return -EINVAL;
+
+	hyp_spin_lock(&trace_buffer.lock);
+
+	if (hyp_trace_buffer_loaded(&trace_buffer))
+		ret = simple_ring_buffer_reset(per_cpu_ptr(trace_buffer.simple_rbs, cpu));
+	else
+		ret = -ENODEV;
+
+	hyp_spin_unlock(&trace_buffer.lock);
+
+	return ret;
+}
+
 int __pkvm_swap_reader_tracing(unsigned int cpu)
 {
 	int ret;
diff --git a/arch/arm64/kvm/hyp_trace.c b/arch/arm64/kvm/hyp_trace.c
index a6664a03f8a9..5c115c3a26a1 100644
--- a/arch/arm64/kvm/hyp_trace.c
+++ b/arch/arm64/kvm/hyp_trace.c
@@ -301,7 +301,7 @@ static int hyp_trace_swap_reader_page(unsigned int cpu, void *priv)
 
 static int hyp_trace_reset(unsigned int cpu, void *priv)
 {
-	return 0;
+	return kvm_call_hyp_nvhe(__pkvm_reset_tracing, cpu);
 }
 
 static int hyp_trace_enable_event(unsigned short id, bool enable, void *priv)
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


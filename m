Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21371FF610
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 May 2025 13:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402882; cv=none; b=ILS8BYg+lb1MvEiSyvGdOo4ioObCfFdHi6uTFhLLb6NVIQY9IHTG8/no9v7tmx7r5AWVe15LB8pGnPzvJrtbJ4CliwboC7vH8l/BRFRL6x/VA2spgdhp0Y2TxYGyFtkfn+Ss7AyNk2Ra/rJVoimG6zEldQgsEqkh6y1ikn5shYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402882; c=relaxed/simple;
	bh=gtmroQFekXKLWe/nKseT96/h3TyZYMQQgPfNxygd8SU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fnv8UKOa6E1vGRClB5xmlRZCDUfIWXFq/YFhEeCttuYB7CDXmrHRhvN6zo8PVgXXkwpnaSzzMYuefA4YZ6Lv3Z/i2HWkF5x531Qez3smKEsrg+UCoYRf0ODUB7q1PWIH6gA9HofgfiS3TBKwxk5wPP5vzeIiDL0DNc120J//kIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LreIuLzy; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LreIuLzy"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a206f05150so1483397f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 May 2025 06:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747402878; x=1748007678; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OpAELfoeAsFVtMepRzx2zM79+vNwJLrfBYC1dznWjvY=;
        b=LreIuLzy9RPWmaa9wdhtexOkXRcoYg0lup/Q8zXX08IRbc0taXkQfzemQWFLb8WKz5
         zJmd+yrtVFwIK1H+GO423y8bycmryMzxEe0OAxbHzy/9Zx3haCq/Pvm+iJ07/DPMWou7
         F2XRxTVFZfEErw3IeF4myrlvScNVD5s5gdQYrPeGx6CG1LPKQATBQXpntTXg5D7aWhKp
         ZpuwDVosKTKbhflZENpsToY8PUuzLgFKwtYprr4hsP4vKkL8E+JEr1Z5F35U2EaJwrpu
         YN5+X7Q6cwXHnFNKCpyqA70DnbDofYOLOnuBT/pdZh8vtQ2cpKWHuPF6pgxO7I58lZrE
         BH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747402878; x=1748007678;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OpAELfoeAsFVtMepRzx2zM79+vNwJLrfBYC1dznWjvY=;
        b=B5QKWQ2kJ9YRaUfMyRt59fRUe2s66hyEooNDtGVM0C4cxTuVJd2brsUhZT64WM1cgB
         ISUT/w56pATiGO8Uy3rCvtHZYSLcyYA2DdcH5FwYkLFtAHeAXxDP9KZn7ocs+3gcTfaM
         zqgNoHYDuJ7GX7MzufcFhHbwLjRqNEsEV3PoEAagMFXt8QSbHEoaMjnGpFYKzd7/cbst
         HVoY2AYHqDGS8QVPyS4TDrcQBtblMmbMv5W5DUUQFoDvLlBniqclrMM2pAGPxgulsqry
         VB5PtTKy0qH1IfXD1pqJC1K2XTZHAF81DlQBe5v4QVmGWI7cT5YZ0YUpyElOh/5fz97t
         dfyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWzSbGFHJv9fOBnEq74jEivX+HOvwJH3RHkNyfvnoatKebalZ3qKnpoTjvuP1pwh0NA9LhwUkQQYRh+/m7cBV0NfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP7GAqL/rfhXzgH/gisg4EMl50MpXTp5toMwwyDLtOWuzDKou+
	QFSEtdtkdkX8hkWFtbVGo026elX9pFYORWmujsCOGIy9QJRUOU70wTmCUPEEIv3xgeYQl0eI90E
	phjo9IaArsG5TtcdDhgGLVA==
X-Google-Smtp-Source: AGHT+IEExJBuC7RFCuynPTpengmlGUugJWjBceO6wu7ms84bKjx06UaFKlpNW0XZ+nv2qFVPSYjFHNd7fTq0iTw5
X-Received: from wmbec10.prod.google.com ([2002:a05:600c:610a:b0:441:b661:2d94])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2502:b0:3a1:fc84:f75f with SMTP id ffacd0b85a97d-3a3601d09b9mr2120545f8f.58.1747402878524;
 Fri, 16 May 2025 06:41:18 -0700 (PDT)
Date: Fri, 16 May 2025 14:40:30 +0100
In-Reply-To: <20250516134031.661124-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250516134031.661124-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250516134031.661124-25-vdonnefort@google.com>
Subject: [PATCH v5 24/25] KVM: arm64: Add selftest event support to pKVM hyp
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a selftest event that can be triggered from a `write_event` tracefs
file. This intends to be used by trace remote selftests.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 79019e11f529..522cccef32b7 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -94,6 +94,7 @@ enum __kvm_host_smccc_func {
 	__KVM_HOST_SMCCC_FUNC___pkvm_reset_tracing,
 	__KVM_HOST_SMCCC_FUNC___pkvm_swap_reader_tracing,
 	__KVM_HOST_SMCCC_FUNC___pkvm_enable_event,
+	__KVM_HOST_SMCCC_FUNC___pkvm_write_event,
 };
 
 #define DECLARE_KVM_VHE_SYM(sym)	extern char sym[]
diff --git a/arch/arm64/include/asm/kvm_hypevents.h b/arch/arm64/include/asm/kvm_hypevents.h
index ce3953bc884a..3d1244972869 100644
--- a/arch/arm64/include/asm/kvm_hypevents.h
+++ b/arch/arm64/include/asm/kvm_hypevents.h
@@ -24,4 +24,18 @@ HYP_EVENT(hyp_exit,
 	),
 	HE_PRINTK()
 );
+
+#ifdef CONFIG_PKVM_SELFTESTS
+HYP_EVENT(selftest,
+	HE_PROTO(u64 id),
+	HE_STRUCT(
+		he_field(u64, id)
+	),
+	HE_ASSIGN(
+		__entry->id = id;
+	),
+	RE_PRINTK("id=%lld", __entry->id)
+);
 #endif
+
+#endif /* __ARM64_KVM_HYPEVENTS_H_ */
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index f7d1d8987cce..333824325c9e 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -46,6 +46,7 @@ menuconfig KVM
 config NVHE_EL2_DEBUG
 	bool "Debug mode for non-VHE EL2 object"
 	depends on KVM
+	select PKVM_SELFTESTS
 	help
 	  Say Y here to enable the debug mode for the non-VHE KVM EL2 object.
 	  Failure reports will BUG() in the hypervisor. This is intended for
@@ -83,6 +84,15 @@ config PTDUMP_STAGE2_DEBUGFS
 
 	  If in doubt, say N.
 
+config PKVM_SELFTESTS
+	bool "Protected KVM hypervisor selftests"
+	depends on KVM
+	default n
+	help
+	  Say Y here to enable pKVM hypervisor testing infrastructure.
+
+	  If unsure, say N.
+
 config PKVM_TRACING
 	bool
 	depends on KVM
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index 7d7d0c07a6d4..e6b45631c48b 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -628,6 +628,20 @@ static void handle___pkvm_enable_event(struct kvm_cpu_context *host_ctxt)
 	cpu_reg(host_ctxt, 1) = __pkvm_enable_event(id, enable);
 }
 
+static void handle___pkvm_write_event(struct kvm_cpu_context *host_ctxt)
+{
+	int smc_ret = SMCCC_RET_NOT_SUPPORTED, ret = -EOPNOTSUPP;
+#ifdef CONFIG_PKVM_SELFTESTS
+	DECLARE_REG(u64, id, host_ctxt, 1);
+
+	trace_selftest(id);
+	smc_ret = SMCCC_RET_SUCCESS;
+	ret = 0;
+#endif
+	cpu_reg(host_ctxt, 0) = smc_ret;
+	cpu_reg(host_ctxt, 1) = ret;
+}
+
 typedef void (*hcall_t)(struct kvm_cpu_context *);
 
 #define HANDLE_FUNC(x)	[__KVM_HOST_SMCCC_FUNC_##x] = (hcall_t)handle_##x
@@ -674,6 +688,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_reset_tracing),
 	HANDLE_FUNC(__pkvm_swap_reader_tracing),
 	HANDLE_FUNC(__pkvm_enable_event),
+	HANDLE_FUNC(__pkvm_write_event),
 };
 
 static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
diff --git a/arch/arm64/kvm/hyp_trace.c b/arch/arm64/kvm/hyp_trace.c
index 70c0939ebc6a..5b5d17a47ecc 100644
--- a/arch/arm64/kvm/hyp_trace.c
+++ b/arch/arm64/kvm/hyp_trace.c
@@ -317,8 +317,34 @@ static int hyp_trace_clock_show(struct seq_file *m, void *v)
 }
 DEFINE_SHOW_ATTRIBUTE(hyp_trace_clock);
 
+#ifdef CONFIG_PKVM_SELFTESTS
+static ssize_t hyp_trace_write_event_write(struct file *f, const char __user *ubuf,
+					   size_t cnt, loff_t *pos)
+{
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
+	if (ret)
+		return ret;
+
+	ret = kvm_call_hyp_nvhe(__pkvm_write_event, val);
+	if (ret)
+		return ret;
+
+	return cnt;
+}
+
+static const struct file_operations hyp_trace_write_event_fops = {
+	.write	= hyp_trace_write_event_write,
+};
+#endif
+
 static int hyp_trace_init_tracefs(struct dentry *d, void *priv)
 {
+#ifdef CONFIG_PKVM_SELFTESTS
+	tracefs_create_file("write_event", 0200, d, NULL, &hyp_trace_write_event_fops);
+#endif
 	return tracefs_create_file("trace_clock", 0440, d, NULL, &hyp_trace_clock_fops) ?
 		0 : -ENOMEM;
 }
-- 
2.49.0.1101.gccaa498523-goog


Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5546320A0C
	for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508359; cv=none; b=AC7qIU9ZGr65/Xd+HsKeE7H5HtVLHcFEMtkmdGyO2VbZtYbqpaL62DvjKIKifD24c2v59Pvr4rIC+hktlW/84VQg+/8gg1Sr8ivO1qm0tHIQApK9218zzpL8isAtCde/zwEwRIcc7YX7ZtcGz4zX4PBtII4MOvDDd0oqIBuHtlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508359; c=relaxed/simple;
	bh=CnpG2QpjkkNDkYKK5inWza9MJr+svUJhufuMoeoqnuo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jip18HgPEYU3IoHUQOmON92KI5Inf0JDAu5vOTR+QblNZsQpdzfT7xfdui4i3AN/kbwjw52CKOkQzCQsyVSVaqZ4NldGSWz0Zl5gPs7wwclIc5NaAqrGWftXTKvFgi3KJOq7issN85QYMcpvIqiE46tcLOcpMZvs8kDCRiEqL5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mcbm4sVW; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mcbm4sVW"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-429c5da68e5so301278f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 07 Nov 2025 01:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762508354; x=1763113154; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XTGXk+lEQWu2rXlHhBAaWQnSfDozXn1jFf3AtP0+OHw=;
        b=Mcbm4sVWQHXGCiYyYao8v3gixD4e7xeXPwElqBwgL3+ENF4EnrJupFE8OUIXJYVINI
         bynRG8AV7Inkgcl+kQHXJE+qW5P6YKLOphFuXrUSSjgMHkvOyVxxcL4uVfWeTDxuJKmf
         JdKv+2EHNhVFfcvBUCx+h7unyDOTpBfdnHlqf8HLaHYGtQiXX9jmKjbGsRip7nJW97LB
         6+l6H/BmXqDjEyKNKAD8doLzWW63q8VTjwXoBtiRpSEQulezMtBBJNQ5PlP0PHk819q2
         T4olqv8bhdYoSreJ8RTu3OObC6jNxdV4Aduu2wPZWzIUf1IbTa8iBnD+6lbrs6ZGPWe6
         bxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762508354; x=1763113154;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XTGXk+lEQWu2rXlHhBAaWQnSfDozXn1jFf3AtP0+OHw=;
        b=Gfa3rVPJExy40HI1Nb7Dk7iMpgRlgR0kHRo7JUhoOOz14NRLeqrbCrnFnP/zxvBH77
         Sj6vd0fXS6eeZSZsanRBplTP6WEDvb6hXKg3EL5MKrGgwr6lS2+nrGc24LkI1SQ6ihAq
         bnU7GdYfUuQ427YVTJBDzzt7ZQpHP2cmCbk16ZuyVmXDy7Q9g6TVAU+WfLKw87Z29cQP
         ViRhHGvHlvwZ7r8qlVmMf44nGXoVKEhu1bR5M4Zggobh5NhvkEncnTPcDjWVaLAVVo/X
         TDBiGlUyjMJr3GtddqDGmBvzTwN7GX1LopN2DoRF4kIh9WCBm4r0fSri1oWiGjq9nZFH
         HpsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpzn35oTpgfiXHSskraMY+3H5IfZNKXGTinqLoC0VytROxbxj/qmrdzGzJyl/PRJsqG0FpRq9t7p2BzimlPeeD1lc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4umQosf5PwPKkg6wRpZkMLvdYtdHfEQNGuPat3p1eeMGQHotx
	rgump2luSjhlpcNG9bQB85LNKI+UxlV+/d5F/i5AIJsdbOGnWLW2qfjp6aO454sesRplyiHihXv
	QTMCGfWs3SAnDyIARpa9Uow==
X-Google-Smtp-Source: AGHT+IF/gtPJvCUAHC9x3215dCUFMskWv8ZlqPR+TxZo+QPZ0YsWx91fk4OG78nveWagqXOIs3IjHx01h0gv1Hon
X-Received: from wrme6.prod.google.com ([2002:adf:e386:0:b0:429:c854:2a08])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:18a3:b0:3e7:6424:1b47 with SMTP id ffacd0b85a97d-42b26f637c7mr1167260f8f.6.1762508353798;
 Fri, 07 Nov 2025 01:39:13 -0800 (PST)
Date: Fri,  7 Nov 2025 09:38:39 +0000
In-Reply-To: <20251107093840.3779150-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251107093840.3779150-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107093840.3779150-28-vdonnefort@google.com>
Subject: [PATCH v8 27/28] KVM: arm64: Add selftest event support to pKVM hyp
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a selftest event that can be triggered from a `write_event` tracefs
file. This intends to be used by trace remote selftests.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index f7b29eae7010..6a3d65918e5d 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -96,6 +96,7 @@ enum __kvm_host_smccc_func {
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
index 64db254f0448..af66e4bbeea9 100644
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
index bb81906878c9..80e6b0159203 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -643,6 +643,20 @@ static void handle___pkvm_enable_event(struct kvm_cpu_context *host_ctxt)
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
@@ -691,6 +705,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__pkvm_reset_tracing),
 	HANDLE_FUNC(__pkvm_swap_reader_tracing),
 	HANDLE_FUNC(__pkvm_enable_event),
+	HANDLE_FUNC(__pkvm_write_event),
 };
 
 static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
diff --git a/arch/arm64/kvm/hyp_trace.c b/arch/arm64/kvm/hyp_trace.c
index 73539f5b5e42..7d078f87f86d 100644
--- a/arch/arm64/kvm/hyp_trace.c
+++ b/arch/arm64/kvm/hyp_trace.c
@@ -318,8 +318,34 @@ static int hyp_trace_clock_show(struct seq_file *m, void *v)
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
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace.tc b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace.tc
new file mode 100644
index 000000000000..49dca7c3861a
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/pkvm/trace.tc
@@ -0,0 +1,10 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test pkvm hypervisor tracing pipe
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/trace_pipe.tc
+
+set -e
+setup_remote "hypervisor"
+test_trace
-- 
2.51.2.1041.gc1ab5b90ca-goog


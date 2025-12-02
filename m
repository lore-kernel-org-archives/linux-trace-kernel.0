Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3414324707
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Dec 2025 09:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764668224; cv=none; b=qHlaQ8HnfbyP0DPe29qaoLgQS241u3Td8JSMDbjupv2gJ/NIrcRegRwOvvXfrRBIZrNkagn9GnuNe7ZGG4nGIFILwuWfTwIKppcI4+x5HKtomCnRypYI5PCs7QPFF7EbAAmTvXBGoAsXDS8FyGVUM1g8J0RhgHJzAK5Rizhb9PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764668224; c=relaxed/simple;
	bh=CNwmikJ1pcOMdWXqSjfDjobuvQ769MsB+HKcUFCSPU4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RQK1JcnCoDFRjOkGF99hR050gA8dxCOS7Ii8svCVfGSVav5+fk0YDskWqY6TPC7eUzNwMDCvac/rqNA8ZDft05tP7Qz5sxdj3GHXkd0RFvJD8jS4iTXTuxYwtaCZyBUR2pY3BDq5Rj+TZuoRf5Ijw+g4t0u671umjY0jnW1QmuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E1ECO80k; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E1ECO80k"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-6407e61783fso5026226a12.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Dec 2025 01:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764668220; x=1765273020; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VIuzqBUK9QgwPsg6n9bFE9jwVKo5Xpv1ngyFRL9o1JY=;
        b=E1ECO80kZreQewkuHnBoZ6XpklYfMDyv34fjdUJQXkdCj/Tak0Bw9KTbh6hO9xm2tF
         r7OxCGJ1xXVvKIcZRxomw+6u2/6GkD9SuqW/0/oroFCiN3KsP6qYaCBlLmVGBm6ddsCa
         CiVBlIl5ONh3wGkeumvuQwD4yKp9XW1mFZQkLXrsX3bS+XPwvXvjE/BfFoo7W6SdSTkc
         +knwjTnctbhDvqKxLbeNQw8ODGDQgyTl3vzcBZkNzNXwYEytPdertv4PLz7I/a35sXsn
         QByS1ed+SBIG2vTcd9wnHqoAREDmZMxo5nk04pfYFCAN/uzi9J93NREmybN9tAx59SJY
         h0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764668220; x=1765273020;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VIuzqBUK9QgwPsg6n9bFE9jwVKo5Xpv1ngyFRL9o1JY=;
        b=qa3InZZzNmBZKs3YlZI6CJqNqSR5omzmq5SPt9H/fDLWBFT1ApTn57VnNEYKzwN7LZ
         kVJl/Hq26mlrqxzVG0oKYmRz7x/OKNNiTSXSoXpuGpeQvFkoA0MUHRqlf3S8KcxiAU6b
         htGs4LpajxwWbDkSXgP3ZDWa97/uwmdus437oP7IU8O77NbOuVgyBUPbPD3M4ZU20njL
         HblkXtNyhUAECxpjl/28NbPTLqNF09GZADNYzpoGwgUhnfFxKr6FGYnyVDqV9O61M3dE
         +ouXSLV81tn5nNWDrR9GDv1RUNLWIU1QmasCSuVGk4jgjj3VdvcnCJ3QBNSLmAohFFyw
         xYMw==
X-Forwarded-Encrypted: i=1; AJvYcCVh2KewzBBrTwg1SPeXO/OCJrINliCwUpNFl9SWDdnjvwUt5mUdSKeteJFdVdfrkjyYe9VYDbIxdhyk+raRBz88jDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1+I+fr5iQWDAnAUaVOpSaxLFgr5pgTsE9RoPK6hhuyuMbQT3K
	H3JnZFRssmYJshiUqjLLrulOdzSNrTYTswXjiMUaGHtfYdtBGuk8pzgsdSRb131dGCUZ84EJ/iZ
	X4srh4lwQ9toaZVjAOTEkrw==
X-Google-Smtp-Source: AGHT+IEM7X8A+Hr+6Paat0E8X6JUwIYRBH+lXGFDjpwXPF4BN9qe9YEMSyyUdVnl+6EQi5h0wYtY5MMHF1nWX41O
X-Received: from ejcss8.prod.google.com ([2002:a17:907:c008:b0:b6d:76e0:3c6])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3e8d:b0:b6d:7f84:633 with SMTP id a640c23a62f3a-b76c53c0c18mr3398928066b.20.1764668219620;
 Tue, 02 Dec 2025 01:36:59 -0800 (PST)
Date: Tue,  2 Dec 2025 09:36:22 +0000
In-Reply-To: <20251202093623.2337860-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202093623.2337860-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.52.0.107.ga0afd4fd5b-goog
Message-ID: <20251202093623.2337860-30-vdonnefort@google.com>
Subject: [PATCH v9 29/30] KVM: arm64: Add selftest event support to nVHE/pKVM hyp
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
index 37c015b54ff6..e2de7ad64938 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -96,6 +96,7 @@ enum __kvm_host_smccc_func {
 	__KVM_HOST_SMCCC_FUNC___tracing_update_clock,
 	__KVM_HOST_SMCCC_FUNC___tracing_reset,
 	__KVM_HOST_SMCCC_FUNC___tracing_enable_event,
+	__KVM_HOST_SMCCC_FUNC___tracing_write_event,
 };
 
 #define DECLARE_KVM_VHE_SYM(sym)	extern char sym[]
diff --git a/arch/arm64/include/asm/kvm_hypevents.h b/arch/arm64/include/asm/kvm_hypevents.h
index 268b3cd7a1b2..c276fd28e0bf 100644
--- a/arch/arm64/include/asm/kvm_hypevents.h
+++ b/arch/arm64/include/asm/kvm_hypevents.h
@@ -42,4 +42,15 @@ HYP_EVENT(hyp_exit,
 	),
 	HE_PRINTK("reason=%s", __hyp_enter_exit_reason_str(__entry->reason))
 );
+
+HYP_EVENT(selftest,
+	HE_PROTO(u64 id),
+	HE_STRUCT(
+		he_field(u64, id)
+	),
+	HE_ASSIGN(
+		__entry->id = id;
+	),
+	RE_PRINTK("id=%llu", __entry->id)
+);
 #endif
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index ffda4850022f..13a6c5c4fabd 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -641,6 +641,15 @@ static void handle___tracing_enable_event(struct kvm_cpu_context *host_ctxt)
 	cpu_reg(host_ctxt, 1) = __tracing_enable_event(id, enable);
 }
 
+static void handle___tracing_write_event(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(u64, id, host_ctxt, 1);
+
+	trace_selftest(id);
+
+	cpu_reg(host_ctxt, 1) = 0;
+}
+
 typedef void (*hcall_t)(struct kvm_cpu_context *);
 
 #define HANDLE_FUNC(x)	[__KVM_HOST_SMCCC_FUNC_##x] = (hcall_t)handle_##x
@@ -689,6 +698,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__tracing_update_clock),
 	HANDLE_FUNC(__tracing_reset),
 	HANDLE_FUNC(__tracing_enable_event),
+	HANDLE_FUNC(__tracing_write_event),
 };
 
 static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
diff --git a/arch/arm64/kvm/hyp_trace.c b/arch/arm64/kvm/hyp_trace.c
index 1ad6a55ba95c..7b537222f364 100644
--- a/arch/arm64/kvm/hyp_trace.c
+++ b/arch/arm64/kvm/hyp_trace.c
@@ -348,8 +348,32 @@ static int hyp_trace_clock_show(struct seq_file *m, void *v)
 }
 DEFINE_SHOW_ATTRIBUTE(hyp_trace_clock);
 
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
+	ret = kvm_call_hyp_nvhe(__tracing_write_event, val);
+	if (ret)
+		return ret;
+
+	return cnt;
+}
+
+static const struct file_operations hyp_trace_write_event_fops = {
+	.write	= hyp_trace_write_event_write,
+};
+
 static int hyp_trace_init_tracefs(struct dentry *d, void *priv)
 {
+	if (!tracefs_create_file("write_event", 0200, d, NULL, &hyp_trace_write_event_fops))
+		return -ENOMEM;
+
 	return tracefs_create_file("trace_clock", 0440, d, NULL, &hyp_trace_clock_fops) ?
 		0 : -ENOMEM;
 }
-- 
2.52.0.107.ga0afd4fd5b-goog


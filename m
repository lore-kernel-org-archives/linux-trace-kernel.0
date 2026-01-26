Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A1133A9D6
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 10:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424297; cv=none; b=JjkBtzCE4Dn1aF9RiE2WVMHGfrpLxY+7fLEgMOXHchy5FNOBRsxMPNpb3P37nhqM80qrF2vVgo2KPcpOBYVs+TShcPfQ+4UeJqAbsMmMG7gtcBcuy/LsOO60kJTDCzEyGGU+Ffnm+tfGFWJMmBCDO50X1+YI/uDtz0gCysRT3UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424297; c=relaxed/simple;
	bh=jc/1tMtJgbj0D+3+RNgTcGKl6/fF2uDcmqUjShgP6kg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=miYuqpvKiOiXp5CxzTP3tAxi14Adi2ZfJwD4U1rK3lvhhGAMSEKQd62S7RZhssiqT/oH2G8/LNFjKlgm4tQcjf2McBnWDBe+HV5umV8yZuwNlkUVfwREpqG8y4uW6YKgueTSj8FI4ii770Gk9p7Gr2qy2/o7VSKBHx2gExXGDAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kCf6e4OO; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kCf6e4OO"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4779d8fd4ecso26802325e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 02:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769424292; x=1770029092; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NT+CpEP6PzXqQH6e99olRbkgz8yl4Nh6CScVnzMBNjw=;
        b=kCf6e4OOEEDofSixq6Tabv6fXMjHy2uBD+n9aEAv/xaK6wtDdy9M38f+aqxvlWcS1p
         xMWC1GGiC/2R4hbquaKS/GYIaiTsuParZft2SsAugOZ4tTFUvVeK8uZQjZpVdrFeWFwU
         Lt8K9FV7bEg9v029GtK8GuN3Gx9TKKYzquuwW6GOAprg/5k3IhobqlIr4BVhaXPsrzep
         G52eQOn3xaToItE5XXjI6+JCGNW/sn/Iqnd6fprJ6gGs9SWaZagm3WRgJvo0nd5hLab2
         kfRWsG828gGbdCrNyv/ENfhPMungpQXoc2ejdGjB5gIWRUEUB4plqQ2Eq0rD4bNlvZAZ
         R6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769424292; x=1770029092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NT+CpEP6PzXqQH6e99olRbkgz8yl4Nh6CScVnzMBNjw=;
        b=kUYI9uRVJF3KyyrpfkdC0CtDQOidV3ixHj4CXqkRty/t/mxS3l6hPPZKo5pnx1snc6
         ZHWo+F2XZ3MyCkO0BnfloIAPiCvABB2lca1scEEUuuLejFq3F41XZwbt+jdY7puFmbqw
         jn//ajj46iiIDby41UapwrCc5WBauSxxodrvQ90EzikNRmYVi8rdzAPIaAxahrRF+n/m
         67IFRj9uY+5khiaUsp0WIpmi1hCzsdW0Jwi8swh9vlSkXpbOhTtaQSH9x7OxSKVnfWWv
         1dw7w98cw9H+n7soRNo9n1CgVyVq8PR7j/b60qKKm5GnuB8sQWmAmN57voH8Exdx9z+7
         kLVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIkooFOEz9pb8oRciSzSrFYa1m4mMsZi0odNX2oqxysN8cKD5gLUeRybdoq0z4f0aYeZ2HiCQo1r6ENnZ7Dtdu9J4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+BD+erzAvB4i/42AlReYNuvgBIWuts/2ENCOY85bjPBv0K7SK
	u6uLbm/OAuXz3lqhUX8g296V22sUPkyZHRPUvH06zODYv1brrUMSjkBUxSUfE2zF8O5Y561e8xO
	3yDqJ725SrkoZW6x0JEFmaQ==
X-Received: from wmcv18.prod.google.com ([2002:a05:600c:4292:b0:47e:e776:2495])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b6a:b0:477:9e0c:f59 with SMTP id 5b1f17b1804b1-4805cd0e356mr65382385e9.2.1769424292276;
 Mon, 26 Jan 2026 02:44:52 -0800 (PST)
Date: Mon, 26 Jan 2026 10:44:18 +0000
In-Reply-To: <20260126104419.1649811-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260126104419.1649811-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260126104419.1649811-30-vdonnefort@google.com>
Subject: [PATCH v10 29/30] KVM: arm64: Add selftest event support to nVHE/pKVM hyp
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
index f8fa556ec3e1..c045c074614b 100644
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
index 221a1dacb2f0..743c49bd878f 100644
--- a/arch/arm64/include/asm/kvm_hypevents.h
+++ b/arch/arm64/include/asm/kvm_hypevents.h
@@ -46,4 +46,15 @@ HYP_EVENT(hyp_exit,
 	),
 	HE_PRINTK("reason=%s vcpu=%d", __hyp_enter_exit_reason_str(__entry->reason), __entry->vcpu)
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
index e1d4a53260ff..5655c1690f4a 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -643,6 +643,13 @@ static void handle___tracing_enable_event(struct kvm_cpu_context *host_ctxt)
 	cpu_reg(host_ctxt, 1) = __tracing_enable_event(id, enable);
 }
 
+static void handle___tracing_write_event(struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(u64, id, host_ctxt, 1);
+
+	trace_selftest(id);
+}
+
 typedef void (*hcall_t)(struct kvm_cpu_context *);
 
 #define HANDLE_FUNC(x)	[__KVM_HOST_SMCCC_FUNC_##x] = (hcall_t)handle_##x
@@ -691,6 +698,7 @@ static const hcall_t host_hcall[] = {
 	HANDLE_FUNC(__tracing_update_clock),
 	HANDLE_FUNC(__tracing_reset),
 	HANDLE_FUNC(__tracing_enable_event),
+	HANDLE_FUNC(__tracing_write_event),
 };
 
 static void handle_host_hcall(struct kvm_cpu_context *host_ctxt)
diff --git a/arch/arm64/kvm/hyp_trace.c b/arch/arm64/kvm/hyp_trace.c
index 1ad6a55ba95c..c1e28f6581ab 100644
--- a/arch/arm64/kvm/hyp_trace.c
+++ b/arch/arm64/kvm/hyp_trace.c
@@ -348,8 +348,30 @@ static int hyp_trace_clock_show(struct seq_file *m, void *v)
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
+	kvm_call_hyp_nvhe(__tracing_write_event, val);
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
2.52.0.457.g6b5491de43-goog


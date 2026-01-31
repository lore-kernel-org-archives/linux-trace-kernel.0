Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7175A360734
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Jan 2026 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769866193; cv=none; b=l83G+0LJe7GPMcw5g4GZ9KOL7rOMpQaZZGHzlBCemV8NzQI8YUHmmml4+OP6KiOLJ/woyF20jxSAl7t7iooDLyXVBvWYiVxOT4MstIQU+L9R9upOpo73asiMMt1PEYyLspy3vF99Z7o6AUVHfbwea+drJrvyaeefclCsPrx9qaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769866193; c=relaxed/simple;
	bh=BNB4B1BAs8BlVHq4fy+EUAdRjl2Wa/TOMGYs5X5AlFQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PwmPe8DVkQ3GeF7KyPKoS/mjuvfLN+YGO7msv+Q150CK90DiyX7ZIb9cmQcIT4xfVC0XZxKFbQvjNUfrEWeRT5gOizQzVUk47HRQoym9e6Q3N1qorc8DThPWUitSS1FiznkLeMU2bCEvS6L3SFRhbNe98JAdrUf73uet6SuneYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ehPFKbjn; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ehPFKbjn"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-431054c09e3so2761227f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Jan 2026 05:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769866189; x=1770470989; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JeFGHpGUZmExC+IpkIdtjA9N9gKTbIl9waldaXKaMEk=;
        b=ehPFKbjnMgvrM6GbTiF35Y4sii1jFDMB3qgyhmPo6hDEA9nF+DgvMXS/jLR0tY2Gf1
         D8B6XJ5Xm7SCL53CiSvGqb/pSe+T3uDJLVXR4r9NXsFyE4QOhvDumf8mrIZ4hqzgtK9B
         M/NmzVklYRd3bX7qPeauPFWvvrY2icI/xFAvnvYIuxZJo6my3p2Rlqy1sy1e+c6gjdiD
         lqjZvAGGPYd9s7hMRNVmYHoEfCzpkdDVeI9yqJD+pB663WZTDwpKS/xCOqL2gVBkPBFf
         dDT+HdcO9ZPBLUVdvkFN9IYD0ApJezxwAZR2P6Jz1PZZU/l5RFb6Ju48Q9DNdpskXd4h
         H+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769866189; x=1770470989;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JeFGHpGUZmExC+IpkIdtjA9N9gKTbIl9waldaXKaMEk=;
        b=cb5r7O/laDN7E/cX6Cu/DcxXm6s5H7nHSQtU63UaLHJLhgd6lJATlQ3I/TUoYXvGPs
         TwAhTRLymhnY+FRN3gWWjAk6OhsAVUscFPFnlXbpOKfPG0cM1GYCUzn9iIrdpixJ+cRU
         iQLBcJ4FVY5aYlVaBqQ/XzQB4P8He+bjK58oB0i33XyTCsHgdfmKPoSPFKKQ87M1K9/u
         q366Ioko1xN0fY2yX8+TnAHnN6t7Vi6PXdH1znc6lrVyVDAzMtqZnBQ2h0iHrPrQtt+B
         r+OwsZfwH6aV7ODzVRVvJ6pH3bJZl4dsZuDs9lVeGcCzuNDCihtCaHtvh27eM6UDmFgr
         rGrA==
X-Forwarded-Encrypted: i=1; AJvYcCVaB9c0JjvjFiuyvWTqBpXtS8ryjkt9vvkQjx41ubN1d07XaSL5ecVvrkAMlxU0Uo9bLRf+S8xL3p271GPTUZaZGGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIwEKiYbc/4cLNKXZLcTaiK+AS9DWCrp9QoDsGzK4DVDeBXNdR
	/z9V9KKKYBuBmG0AMcNBKXz6/ETf5+vsfxceN9Tf9tP3Ni+gwGLJE7fCEHBrNLbmc/jG4GSQTaS
	vKg6wTr/Heg7Jk6lRGJuAjw==
X-Received: from wrbfu10.prod.google.com ([2002:a05:6000:25ea:b0:435:c163:9abb])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:420d:b0:435:960c:5286 with SMTP id ffacd0b85a97d-435f3aba816mr8778061f8f.58.1769866189345;
 Sat, 31 Jan 2026 05:29:49 -0800 (PST)
Date: Sat, 31 Jan 2026 13:28:47 +0000
In-Reply-To: <20260131132848.254084-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260131132848.254084-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260131132848.254084-30-vdonnefort@google.com>
Subject: [PATCH v11 29/30] KVM: arm64: Add selftest event support to nVHE/pKVM hyp
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
2.53.0.rc1.225.gd81095ad13-goog


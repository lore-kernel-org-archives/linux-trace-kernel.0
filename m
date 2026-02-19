Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5BE34CFC2
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 15:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771513441; cv=none; b=keK6EYIof4GCoAYvZ3DB33ZTnUDIIljYEy1W/95EYN2PNDFVzFficH2ufDij86IxcAteQY705ystcfLSypDyglvV3wVgUfTNTwPBxSSa9/T17sRwysXpfnJzM0IemVi0RxesxpOO94PnwCzJxwdIzcNbUnH1OFo6EmsMO4c0dYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771513441; c=relaxed/simple;
	bh=59QK1IwEV466xydh4Q7mh9+JaDPhTy37zORcu48/k1U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bYbxmoWvz74kVx0d1wf44hTI93w3L1XNzQfhGFmb9ssW/hGPSt/EeU4cBhtNHUTn/sHb2pAwUk/fc1X5sGixuZT2KyQd1kkxGgAf0gmA5B/S1GCeWYmaV7XbsVoTkauaeoDum+w0iD5txJux/iMlctAhGasnRW3w0RWj/FWO4CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RHzq6dQa; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RHzq6dQa"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-43964455342so279984f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 07:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771513439; x=1772118239; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6jAHB+s4HI+rlHZ3mnIB6UI4woeuqj9h766h+D/K5JA=;
        b=RHzq6dQaLPJnF54G27OVk6vURA6bqlzXup9XS5/c5x7AsAhDvan7rjy5Cf6dGHDUeW
         fslXE2SfNhmslZOaPbb7v/VJx3f1jgPANOlwzB+8jn7fPibed6r+GYVZbiPOc3Kf/+st
         X60xAZEfL8Lc2CE2HJoxHJp1A7wY8ceSV5gg+Q6MPqIyVMQiatvjm9V8Qwv45oDKrTxl
         r6ims1aGvNWR8Ax3e+n4La6JXB/yh5Kc1TGgQrwYTIK3umxc6x4RDqeCnT00NhyUc+VL
         TnoVO8QmC0U7KPNeYa+CwjHy3eWftqVSo5IQmsDqnqsAsUk7ZmjIMHRmWzJJjaaZIG0Y
         Y4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771513439; x=1772118239;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6jAHB+s4HI+rlHZ3mnIB6UI4woeuqj9h766h+D/K5JA=;
        b=b/okBVCkKXfn3qN2DlxrJiG/JR2uPqXjLfE4Lgicc9pRkqlX30fduv45CBT6xS78Ue
         KemWBqdU+IqJl4pRZk45Pn1X7DHdtAbht3G7BuKTg0/Zk1OZIHY1w7rV5wPwxuuJ9rS9
         rQQcRhsiAErKJENA1okNbJWrM1uUsm7Zc+5qGnMDNRzsO9J/ZkH0E3S0BDUAupQ2FL7R
         5xWjGprYu/V1KbK2yZGLrd++FdF1OhhYF3odjSLaA+XQWPiAPg0MS9Dnl2d/StTN8rcN
         6wP0kSG3TFdASJk1s3PRyRMhva3RfFLay+ha5ffedWiC3UahjY1RcRU30MBlITWplY51
         81BA==
X-Forwarded-Encrypted: i=1; AJvYcCV3hXGGmFkpAJph8IljB+Dzzh2/kW9CIN8XT3R5EZhopHkHHvGtqQl6/grivEiUzIuzIA6PmJ4rKF167BFDvNeAUlo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr32mD0XARM4tfQ151mJnrmouqDqslJLnKttYOHecjxyiF0XXZ
	POKZ+ety9zsgXVHpykD5Loid9DYlOzHLLC9L/R3wYqIFpi2S80cXRJPuP8ctzWH6d/gOxBTfaEg
	in6NWg2NnWOH5M0uKvTBByw==
X-Received: from wmbdr17.prod.google.com ([2002:a05:600c:6091:b0:480:4a03:7b73])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6d55:b0:483:722c:a3d1 with SMTP id 5b1f17b1804b1-483a00b0a8dmr29071135e9.16.1771513438181;
 Thu, 19 Feb 2026 07:03:58 -0800 (PST)
Date: Thu, 19 Feb 2026 15:03:06 +0000
In-Reply-To: <20260219150307.14538-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260219150307.14538-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.335.g19a08e0c02-goog
Message-ID: <20260219150307.14538-30-vdonnefort@google.com>
Subject: [PATCH v12 29/30] KVM: arm64: Add selftest event support to nVHE/pKVM hyp
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
index 47d250436f8c..c8eb992d3ac8 100644
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
index 547d63679022..eff9cb208627 100644
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
2.53.0.335.g19a08e0c02-goog


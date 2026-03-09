Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C363FFACF
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Mar 2026 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073594; cv=none; b=Bq92YVZHtQx/3WdCZs9Tng6b4gcWv0y4/dows5del681VTJGaFaMrxRz3LP07QvOJUwNoQcKZVpDBzBOL0tOj+4Ga9MYMy4o6QWFFBxEAQDE9C/L8DAfeixLemFA0Cp7neJlXnEge4VOX4Pbz7pE4CCG7YhRAzGZ4VeYfhQvA8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073594; c=relaxed/simple;
	bh=Hq3pw944yEctnZlP5UAA9Ov4xnMxVYtjU2DXhQ3r5cM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sSX31qjlJZUbzwot78bV1MagLy0n7ut1gKlaQtVaKemvk0NqI8ZKZ3BhE2d701aGl+uOqgotm3soblVwHdgELj0f7zDaSJmpJT7msg+oo0HXmAMvYi4J/8RRj+CEvbUPyeF2LcCzmEzCCL59ssLBjyMEr37cUi4nj+STSXFLrIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c2J+bEFs; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c2J+bEFs"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-661420734b7so5796444a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 09 Mar 2026 09:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773073591; x=1773678391; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VBnYryU8DAHWNMJIKaPrPbk+603MWk0xgkkJlIYXdOA=;
        b=c2J+bEFsTEa/xJVbYalAygshn82VuwAQ2PxylGdcM0rK6R+Rwi40nlUsUrEunAG7pE
         afysJvlS3aThcDmXs50Kb6ItQQxdtIg++Br2FR5prtyWsLxRdQlCV3rIIHT8jXgaoYwa
         e7EmzWp+UbdOrEkZ/mAXkycMwOUD9HA207mb+lN4ZdYVN+uRrOrEb9MKz7LpJSKpeMe+
         BzrDcB0M7W8bd6UWU2CjMjckO2Zq2caFwkufv+sQ2nWwnKcONGDsEhVpIMlMAmJz2mgf
         TG2AQYtonW92X++qrhBRUFmqQEJBkVtkKwmkHM5eXKPcSVLncppadj5mngDZ704ElBMw
         TBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773073591; x=1773678391;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VBnYryU8DAHWNMJIKaPrPbk+603MWk0xgkkJlIYXdOA=;
        b=QU7bOQbmlBnBEKRbVjdoI7s/t0N2YQCtmA6CGKjSLQPt5nHhZlpiFLl8We1UsnbUzL
         L9Rbr/q/TPkS2pFVYdGAYE6wQajPfn5fD7eYg4SdM0e80qQwuwxCufxqit0SIudM1zNQ
         ji0MQoKaaSKWJ2zeftL+huBZ7MhYY+8TrkqhDF9cYLjuENChWlj5b+6O3kfSd+sEGPZb
         YJmaI1zgO8LY84WvDsRf40nzn/dvq8kerUb4gztJ2ZgpL38iqEclLFXk3wEXvL4bkTWB
         VZX9ZptC2XE7XVoC+DwNouO0Jgt8pKX8TwXP7SBuhrE6dTbETdm1pOydIHXyaLVHgU8q
         PKpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKrlhK1Mhn426mmg5eSBd5ffzEJQbqyZA+uWBw4VnaEhmuYqqF61Mm3sOfFgx/AexwYhkI4+SxL5mhiryWWfK8Xoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHdkr8Co8PA/UfmI/J5AEpw1yplXRbma8S9tpF6dzEGPwXHUi9
	9DOJtYohs9JXye/rh5I9kc3UJAqgoBLefU/eUinBHKgEe4Dx5AGFNu+JWOMbBcX/D1yC7sfJ9os
	pMChpbqZ15PfdmKvFtre6aA==
X-Received: from edk15-n1.prod.google.com ([2002:a05:6402:404f:10b0:662:886c:aad8])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3494:b0:661:52b5:6b9a with SMTP id 4fb4d7f45d1cf-6619d4ede26mr6783935a12.23.1773073590616;
 Mon, 09 Mar 2026 09:26:30 -0700 (PDT)
Date: Mon,  9 Mar 2026 16:25:15 +0000
In-Reply-To: <20260309162516.2623589-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260309162516.2623589-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260309162516.2623589-30-vdonnefort@google.com>
Subject: [PATCH v14 29/30] KVM: arm64: Add selftest event support to nVHE/pKVM hyp
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
2.53.0.473.g4a7958ca14-goog


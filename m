Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DBA2FDC24
	for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120144; cv=none; b=N4Tu/YCvQgRgz0a5Hzb03Ee9FZCEHW11NhcprDc+SEo6XSU7VwIgsnloooXgWS1/4e+NVBV7kDpkij+7ptuUSHj+Pctb5T+SkoERhtW4c0WLRU+t6kHKEeMbN6e8WrrrcSicMsRkgBHkX3uCDG2pIoTWLsD4FC8Mt5gAFhozOn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120144; c=relaxed/simple;
	bh=MEFs+beI5cBBgDKfKyHyJzvZIINf6BRa4OCOzMkRRmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TdybIxbkWUEq5x1D4PrYO4RNUUv4lGmqr5pwblQyA2JmhEH3qZy9D71XYUbo+QKhWF2bA9WthkQGiLdO8ko6ZLjEU2qchQdLzUP894tWiViiYiv5P5Pwx2XYiFc1aEy6/p3q9msTHQOIDHR4eEB8StmAzh7BOJ3Rr/EPVdB0mhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XTs6Qcba; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTs6Qcba"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-292fd52d527so11308615ad.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761120140; x=1761724940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0dIN4en5Nbyg37fgM4seNbI3NZS7JVL5G+Wmq/ATFM=;
        b=XTs6QcbaK1kyOTlGaNkKCHhCLwHvxno2yaCUVsidcyaX2a5yn/keuaeYN+EG1R3l6d
         fIhQfITJomjxWZq2cW2ZPcDFO4fT+w1qCM4cfU/DaXFP2/JOThHX71tdhG59CCf+URLv
         0/TuEyCVvdbCz35DfpesngUL5slei2CSMBANj/RwXfuDCig+cra9Sk0iE9e6NlcHctZS
         WHFOTpmu3Kau8vBvqha/EicmdnyzhjD8FdFRCyuGPzhgtHJrQOBVPWdoor68QutiBef6
         hPlUKxw9bS+MU/xeuYdS5JtrjJ+VN42MtOUTFojOwhVGfUkgWWbCaBF5tzLX456uPmJS
         l6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120140; x=1761724940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0dIN4en5Nbyg37fgM4seNbI3NZS7JVL5G+Wmq/ATFM=;
        b=L/7d1elUEDwolvZ+4JjPvteMNdDK8K0+1j3hm+fuuiiUlBuFjgsILbWVgiahXTO/3i
         5JLhNZfREI9uYXGmCMq8PmzzMSu73taObuPgUsKg48bb6AgaPvL0rhRyRjAasga2644D
         9BiSFnMwm+N5c9xrOKSfhL/k3UEBQB4DqaQLq171esRPesHEvqKJeTiJoW0itoCOWwBK
         soU0Sy5fz2DKNNqQJSdKktsYK93woCcAXYO7Mq15Rf7O0SvC2KIg8ChpGuen4Aid1ae1
         eYZLASQZRZCHh3A65qJt5vDmfnxZ1ThR0YupP3x3DqVeSJtZtBMEUjT1e6/Cm+d7bC37
         fO4g==
X-Forwarded-Encrypted: i=1; AJvYcCWipUmTrqhgyQoajRZsb3G/ukgfA8Mc0APrDCCJxKN2dYqGhZXru7g+73lmPAWLxizdRP4ywdMgO9HPomT0+WSX1Nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaGW3fWgaqD0A+O36gM4emfY9bplQYR6Jgqw2TLv8UzAfaTB2c
	5ACarcYf8VBYrA4wPpJy2dsa6CCHiSjOoIkcP3Pd043iKM6AUO2BiGqO
X-Gm-Gg: ASbGncsJFN1mfgdDybS87WZGf3LIFUutqBH9LUk/MYa3BvJfFqPChv9UHfnSJ1kSIm3
	bdtxXAwFqB8PFn+8V/g1ngf9CF6m6ZWCZXLJ91W6/yqpUTZrOHWXRbKTL/yUgoDGLMMeBSbC+88
	czoUQ8MvVJLAuixKPSY3NLPPNP/EB8EuudD9VoXoTXCH2tPisgCR7T6bucoO8pm8zH7fmZy+Anx
	4Xdg4LK81MOAWGJ2RKssu+iFUrPYwezSRFJUXjusSX8OFQ2WckqNHcD5kMLbGx8we55mUx+/vOE
	A6iqnt3GK7TB7VHAABTt4yG7VDBDeCruQ0Lav+q1O/BP+XytEez5N2Wxd0xi63j8Hy6s9Aa8eyw
	pgbWPDDcXItDzzzlBsoawg2kcNEOvapDhk1nlMVHj8FQynCw2FRTT+ncNTfXGYiCD78k0j5oD
X-Google-Smtp-Source: AGHT+IGIv/kxjl/Cr8AVdluhKxdEQMlUC/jiC9m9GjymD3dSUhssWXA9pvsnYvEYqz6+fWunATRtxw==
X-Received: by 2002:a17:902:e88e:b0:24b:270e:56cb with SMTP id d9443c01a7336-290c9ce6427mr247961835ad.27.1761120140275;
        Wed, 22 Oct 2025 01:02:20 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d7e41sm131947785ad.57.2025.10.22.01.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:02:19 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	jolsa@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	leon.hwang@linux.dev,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 02/10] bpf: add kfunc bpf_tracing_is_exit for TRACE_SESSION
Date: Wed, 22 Oct 2025 16:01:51 +0800
Message-ID: <20251022080159.553805-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251022080159.553805-1-dongml2@chinatelecom.cn>
References: <20251022080159.553805-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If TRACE_SESSION exists, we will use extra 8-bytes in the stack of the
trampoline to store the flags that we needed, and the 8-bytes lie after
the return value, which means ctx[nr_args + 1]. And we will store the
flag "is_exit" to the first bit of it.

Introduce the kfunc bpf_tracing_is_exit(), which is used to tell if it
is fexit currently. Meanwhile, inline it in the verifier.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
v2:
- store the session flags after return value, instead of before nr_args
- inline the bpf_tracing_is_exit, as Jiri suggested
---
 kernel/bpf/verifier.c    | 15 +++++++++++-
 kernel/trace/bpf_trace.c | 49 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3ffdf2143f16..a4d0dd4440fd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12293,6 +12293,7 @@ enum special_kfunc_type {
 	KF___bpf_trap,
 	KF_bpf_task_work_schedule_signal,
 	KF_bpf_task_work_schedule_resume,
+	KF_bpf_tracing_is_exit,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12365,6 +12366,7 @@ BTF_ID(func, bpf_res_spin_unlock_irqrestore)
 BTF_ID(func, __bpf_trap)
 BTF_ID(func, bpf_task_work_schedule_signal)
 BTF_ID(func, bpf_task_work_schedule_resume)
+BTF_ID(func, bpf_tracing_is_exit)
 
 static bool is_task_work_add_kfunc(u32 func_id)
 {
@@ -12419,7 +12421,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	struct bpf_reg_state *reg = &regs[regno];
 	bool arg_mem_size = false;
 
-	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx])
+	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
+	    meta->func_id == special_kfunc_list[KF_bpf_tracing_is_exit])
 		return KF_ARG_PTR_TO_CTX;
 
 	/* In this function, we verify the kfunc's BTF as per the argument type,
@@ -21994,6 +21997,16 @@ static int fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		   desc->func_id == special_kfunc_list[KF_bpf_rdonly_cast]) {
 		insn_buf[0] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_1);
 		*cnt = 1;
+	} else if (desc->func_id == special_kfunc_list[KF_bpf_tracing_is_exit]) {
+		/* Load nr_args from ctx - 8 */
+		insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
+		/* add rax, 1 */
+		insn_buf[1] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_0, 1);
+		insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_0, 3);
+		insn_buf[3] = BPF_ALU64_REG(BPF_ADD, BPF_REG_0, BPF_REG_1);
+		insn_buf[4] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_0, 0);
+		insn_buf[5] = BPF_ALU64_IMM(BPF_AND, BPF_REG_0, 1);
+		*cnt = 6;
 	}
 
 	if (env->insn_aux_data[insn_idx].arg_prog) {
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4f87c16d915a..d0720d850621 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3356,12 +3356,55 @@ static const struct btf_kfunc_id_set bpf_kprobe_multi_kfunc_set = {
 	.filter = bpf_kprobe_multi_filter,
 };
 
-static int __init bpf_kprobe_multi_kfuncs_init(void)
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc bool bpf_tracing_is_exit(void *ctx)
+{
+	/* This helper call is inlined by verifier. */
+	u64 nr_args = ((u64 *)ctx)[-1];
+
+	/*
+	 * ctx[nr_args + 1] is the session flags, and the last bit is
+	 * is_exit.
+	 */
+	return ((u64 *)ctx)[nr_args + 1] & 1;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(tracing_kfunc_set_ids)
+BTF_ID_FLAGS(func, bpf_tracing_is_exit, KF_FASTCALL)
+BTF_KFUNCS_END(tracing_kfunc_set_ids)
+
+static int bpf_tracing_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_kprobe_multi_kfunc_set);
+	if (!btf_id_set8_contains(&tracing_kfunc_set_ids, kfunc_id))
+		return 0;
+
+	if (prog->type != BPF_PROG_TYPE_TRACING ||
+	    prog->expected_attach_type != BPF_TRACE_SESSION)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct btf_kfunc_id_set bpf_tracing_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &tracing_kfunc_set_ids,
+	.filter = bpf_tracing_filter,
+};
+
+static int __init bpf_trace_kfuncs_init(void)
+{
+	int err = 0;
+
+	err = err ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_kprobe_multi_kfunc_set);
+	err = err ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_tracing_kfunc_set);
+
+	return err;
 }
 
-late_initcall(bpf_kprobe_multi_kfuncs_init);
+late_initcall(bpf_trace_kfuncs_init);
 
 typedef int (*copy_fn_t)(void *dst, const void *src, u32 size, struct task_struct *tsk);
 
-- 
2.51.1.dirty


Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91B6315D5E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Nov 2025 03:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763351379; cv=none; b=gNrSywsJ/jXX+ZhLCqFRaYleXUhQQS1FpjEsmgWmmtvvgCp/Z5RlEmrSrKqDznWH/TM9eskC4s6DEVhIfxSezj9zzVzX7iWN9v52GQARiKBUeRawJTO0/w1WH0QnPy2Y6cq4xeqSmrym32/pyX5glsm5IeQG0CrXLCGNRr+Z9Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763351379; c=relaxed/simple;
	bh=6lH5TThLt0iLUPf10EryfpP2LJ24tamdXbqQbNSY8i0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6pA9Qd4fBzwiDz1pobxXx04cm0aKHUm8vDIhj5i5Bh6n+AjID5s3E6ggoiZueMFJk272CbzyayCHGcAlcorHyqo+bQS1UrzQnNTVz5+MAG3RwVa1ZkCgo23fVaZQ2ZVwngoZqfC3c3rSrMBM8exgHYyz/XlozTwyQwZHd311gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YL1u8HAd; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YL1u8HAd"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7ba55660769so2178615b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 16 Nov 2025 19:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763351377; x=1763956177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Og8VZW3HRIC9jFqJjaOXGmdza1e4WZ/zf5HErz8QF0g=;
        b=YL1u8HAdC+EmxxgcbAAHN6iUsh9SGoW76xQlpOkKwIsqAUNPfItWv6s1PeOJ2O4oFz
         bScm7+NOOcCeYGuF2fNbZaiuBLRzzdgVf4USojVjkXV7ARaauZtHOJuqS1lQvRinEDUN
         dl9OC7jg31HRBUP6PQ5+cYCCm919t90umGCpXqGKLw76bE4yWZGuXnFuEEsHtDIMecra
         E3xgGq2iu20aWcXDtO53FeCfyCvVcD7IxNoc8J2G3IWod9+tj0PGNi1EfIO7BEs7y2OL
         Wgfvp3Zq5Hj+NPvdpEABOEnUahotq0Fd9xs1R0AnbnIFwfY6bH67NsEEPU/EF6vXxKwm
         /zew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763351377; x=1763956177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Og8VZW3HRIC9jFqJjaOXGmdza1e4WZ/zf5HErz8QF0g=;
        b=AOwd/0JMk6gi42ArGQKKckwjgSErpwNGeKNYQ1K0gjzZQcDxmjjqe+GPFElXk5GinQ
         B1lzY3b5kYMztLcbz65wtTvOrFDOAsLRU/QEjK0Uhk3/xCUmUbivXWkC3ZbPltXiOyS3
         sE8+aeS5Uj29zIrArL+/ItF/H3BV2lE0N1XscSWGIhwkC9CZyu5bzEHDYeLvR4mTS/YF
         T3WxnlUgks3I08EZHyaCG2AdVM1xkhfumgVHfwBKfH1DCEm1PS0YEiQ8YcoGCvGRmi69
         llPPdzKUko1Nr4w7LLTEdw9F4/gp46cY9bUfe83FkHaGz7p4ckPePu8p9+RpeqqCaoPf
         W3eg==
X-Forwarded-Encrypted: i=1; AJvYcCViw2eHGpJkDo5pZ38EC+H1CGn8wc0gUPWIkaK82bjmqI4w68Nadd+4jgGJwHvS18CPYnhCLE5adBTes5Gozl5/v8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8YqccNOqIzhOZZArbBddeBzx7SceHbw60MRy159+1b1apXA4H
	n1DqqQmbX1kldImn06pR1EwrrcVtlIwMKxDOtn+jEhJ5WWi7Sd2BV02s
X-Gm-Gg: ASbGncvgJTxyPy+m0C3WqlWUMl0zg9CLUhcv67//g97h3ezehTx6eJD50DbBH6Ss+AD
	eBpm5YL5T8k92uP0TMHua2vWH1paoxuk7rPkfHxGJtSVLVuQDLmXpp3sqLCwh4Fu4vlXeXSccoI
	oMlsQPW3tOl/RvzEULkivTc4hOq7+QZtYlE/R/mM1aNRT3rg1a2p/1oBXAI7zuQLsUag6r0qfCj
	SSqa2K5gORJsZVPjVv1AODuxOwqyXSeLApaT8TMFmtnMWreiLDLJcsiMUvTw9p2ZVLRTF8DTD6w
	UQT5wVW6rVnjxr4du2TC4Y/Gaw+2sm/Y+7IVas++x03ojrxrxK9h1Vn+dKgawBecjdmeUVmqkMW
	bpdB930oBMTdG9fpwqEYZFl2boXZEN3FkjgfMY3SER+oUpXeUNnjpayeaE5od6GWun2gIY6H81D
	SIOVBmUfpyT7k=
X-Google-Smtp-Source: AGHT+IEUOmv/ReRY/yBeh3xXoJkne3X/8LUXnfbP2zr6UY7lHFdyFxyv4QbxObXeKQfZgd/S48fgrQ==
X-Received: by 2002:a05:6a20:7349:b0:35d:58d3:2904 with SMTP id adf61e73a8af0-35d58d33edcmr7364200637.31.1763351376830;
        Sun, 16 Nov 2025 19:49:36 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc37703a0d9sm10348179a12.31.2025.11.16.19.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 19:49:36 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	rostedt@goodmis.org
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
	jolsa@kernel.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 4/6] bpf,x86: adjust the "jmp" mode for bpf trampoline
Date: Mon, 17 Nov 2025 11:49:04 +0800
Message-ID: <20251117034906.32036-5-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251117034906.32036-1-dongml2@chinatelecom.cn>
References: <20251117034906.32036-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the origin call case, if BPF_TRAMP_F_SKIP_FRAME is not set, it means
that the trampoline is not called, but "jmp".

Introduce the function bpf_trampoline_use_jmp() to check if the trampoline
is in "jmp" mode.

Do some adjustment on the "jmp" mode for the x86_64. The main adjustment
that we make is for the stack parameter passing case, as the stack
alignment logic changes in the "jmp" mode without the "rip". What's more,
the location of the parameters on the stack also changes.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- rename bpf_trampoline_need_jmp() to bpf_trampoline_use_jmp()
---
 arch/x86/net/bpf_jit_comp.c | 16 +++++++++++-----
 include/linux/bpf.h         | 12 ++++++++++++
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 808d4343f6cf..632a83381c2d 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2847,9 +2847,10 @@ static int get_nr_used_regs(const struct btf_func_model *m)
 }
 
 static void save_args(const struct btf_func_model *m, u8 **prog,
-		      int stack_size, bool for_call_origin)
+		      int stack_size, bool for_call_origin, u32 flags)
 {
 	int arg_regs, first_off = 0, nr_regs = 0, nr_stack_slots = 0;
+	bool use_jmp = bpf_trampoline_use_jmp(flags);
 	int i, j;
 
 	/* Store function arguments to stack.
@@ -2890,7 +2891,7 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
 			 */
 			for (j = 0; j < arg_regs; j++) {
 				emit_ldx(prog, BPF_DW, BPF_REG_0, BPF_REG_FP,
-					 nr_stack_slots * 8 + 0x18);
+					 nr_stack_slots * 8 + 16 + (!use_jmp) * 8);
 				emit_stx(prog, BPF_DW, BPF_REG_FP, BPF_REG_0,
 					 -stack_size);
 
@@ -3284,7 +3285,12 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		 * should be 16-byte aligned. Following code depend on
 		 * that stack_size is already 8-byte aligned.
 		 */
-		stack_size += (stack_size % 16) ? 0 : 8;
+		if (bpf_trampoline_use_jmp(flags)) {
+			/* no rip in the "jmp" case */
+			stack_size += (stack_size % 16) ? 8 : 0;
+		} else {
+			stack_size += (stack_size % 16) ? 0 : 8;
+		}
 	}
 
 	arg_stack_off = stack_size;
@@ -3344,7 +3350,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ip_off);
 	}
 
-	save_args(m, &prog, regs_off, false);
+	save_args(m, &prog, regs_off, false, flags);
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/* arg1: mov rdi, im */
@@ -3377,7 +3383,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		restore_regs(m, &prog, regs_off);
-		save_args(m, &prog, arg_stack_off, true);
+		save_args(m, &prog, arg_stack_off, true, flags);
 
 		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
 			/* Before calling the original function, load the
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 09d5dc541d1c..4187b7578580 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1264,6 +1264,18 @@ typedef void (*bpf_trampoline_exit_t)(struct bpf_prog *prog, u64 start,
 bpf_trampoline_enter_t bpf_trampoline_enter(const struct bpf_prog *prog);
 bpf_trampoline_exit_t bpf_trampoline_exit(const struct bpf_prog *prog);
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_JMP
+static inline bool bpf_trampoline_use_jmp(u64 flags)
+{
+	return flags & BPF_TRAMP_F_CALL_ORIG && !(flags & BPF_TRAMP_F_SKIP_FRAME);
+}
+#else
+static inline bool bpf_trampoline_use_jmp(u64 flags)
+{
+	return false;
+}
+#endif
+
 struct bpf_ksym {
 	unsigned long		 start;
 	unsigned long		 end;
-- 
2.51.2


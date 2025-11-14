Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B3B302CB6
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Nov 2025 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112321; cv=none; b=Tqebtihy4X3gHIDApjzaCQB2Oz7cnZ5JCrzv9SH4Z/EunJ/48LLak7uBI1GP12+2lf7CkRDCYMK8+QWDZhBMJ07+s1nLFIw52/7WP5pTxKNPMji2BhjlscbzCSSuB+TtBQ0dgDjwp4SolqAzA8VpFMrGiVg+ZgAHS3bsrGhhnpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112321; c=relaxed/simple;
	bh=FAoA8SSkUxlpnxysz5ifBOU2ouZ7qvBl4IFvJKPZUXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=breKni/wrJ60dcPlyWEVH15o4CUs05JO/MZw3ke45IBnw7UBSVy/hp0T1OV5/oA1UPhnliyqb04sOT0GAz2xpW0+J3LEdSXZ+4zX1pOYGE0bM86+HgMAQyqe/d/+GidpzvMHVL3EYmMHzaVyCdQInA9YIUkuxpwAFwU2YoVizfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8OeoAnq; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8OeoAnq"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2984dfae0acso21219975ad.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Nov 2025 01:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763112319; x=1763717119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Lo0oHQehABD95AGfmd72YLS+a/OuJSMG1VdEJWGhMs=;
        b=l8OeoAnqOdyCTK4j5BnEaaAafBCerTiyukOiSHdMZmwNPCBWUPVhee8WqSzaHcT3B3
         Li9ZlW0YnFc+pmxIrKaxEkWkO4vEDRoaXDmqgWD4jU9dflKPUwmnEvnYyVJLrCawAk6S
         SywDAy0zlsvNHse0h1HJ3pVqBoDY0fQEX3Vk1zQ5mof5hDbMW2Wcef15cXcTBKOpLLpZ
         KUN0D73KYMCRk93EVx+oAMR4acsQoo/E7QwU2XgSxw875oHeleyDscgUcIEVVtoKOHCo
         FaaVoubNbPZ6b53Mbe4j9qgTfUn/hkO+jbtb/qMWeq/WqVuZ4TCgZzQiEtnDjGcWzIyj
         oT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763112319; x=1763717119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Lo0oHQehABD95AGfmd72YLS+a/OuJSMG1VdEJWGhMs=;
        b=GpGkbWVqqwf3trxmVyN1c2vHfgzPAHgML6Cx5viF+qNPVu4I9GWq+SlYV0c8Hsp41K
         y+TV9dFrjXA71+1rkgCzlOLFRwkfPf7PwZ5Kf+VsVgW8srAVAN9EEknuyNH9i/P6ialx
         oBpG7t6JkGmbNBwYIxgO6o2S8i45xOAoqlosCiFRiPVxxLsTAbgy/uYe48xLh669FOCU
         tFdkNlz4hv8yXRSjQSIWP86ReqABPmHUv9mPR5i+TdP7qNK+cYA4H6WpcWAJ4umn+x9M
         A/GRpDKzlI9c6bSogU+2eNrsnqSzO+3qMkXanBHoM7YxAuz/0Iq0U8akBEI5hrkir+nF
         hvdg==
X-Forwarded-Encrypted: i=1; AJvYcCUfOtA4zau6lcnG9Kyt2ZBgdq37JPOyq3Hys3t4/stKCGaasM+DKQ6miLdOZ3QJ4gd6FjVBcv8LcK1qa8XEuBqE+sU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvh/1nk86vJpQp/i1NE3OhBoOQvRufccN0tNLnKsTMY5jxjVKc
	nyJgweISka1DGf+wfDK7n1+9dLbNRUrrSMda0h2yO7alUO8TAzu1SEAq
X-Gm-Gg: ASbGncuT6OcCOh1vDDxZtGPwvtLQd8im0ysgF2UsTEybr4VHxanCnmo6d/3hXr7EA+8
	QVeK0YmGoD7wx6DylHG0VHxvXUnZldKzTMGZLcFKp78YgOWEKjGuP3JrP1JpSoPwNRYo5f4NDzM
	/zL/Uh6064fnkStRxnLo4b0bSbmbTCe6t3Cz8ZmC8hTMkCjy0DoKiovg30in38BD5H8gb7vIu8g
	lvUYpCKMPyur4cGPqP06awiLkXakb0Gx/1z24X0sq13SIY/SjnZpYT/p7junkEXNm3sgG/MwJVL
	BaXM90kyURWvOz1YKh/GHUVOGHJ3kL/08Siv2mkvZ+znHLoOlswJLA6VDMQYwB+LBNK/sGOR0Sa
	kyt1/f1q9pvNpX8duADTiFUTGzOZP4YtxpqXXeNfRkLX3yIbM1eDXXwO7nvXlOZzEtH6A225HNP
	MSqhkOckeTugc=
X-Google-Smtp-Source: AGHT+IH+Ak1j0xCi7Rm3y3incs6i/Rgb5Az/FlZugKLvJkcy7tgkhMk2eLmjZEILmQE742wMiBUzQw==
X-Received: by 2002:a17:903:2411:b0:297:e59c:63cc with SMTP id d9443c01a7336-2986a73ace5mr27684325ad.35.1763112319229;
        Fri, 14 Nov 2025 01:25:19 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346dasm50451525ad.7.2025.11.14.01.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:25:18 -0800 (PST)
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
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC bpf-next 4/7] bpf,x86: adjust the "jmp" mode for bpf trampoline
Date: Fri, 14 Nov 2025 17:24:47 +0800
Message-ID: <20251114092450.172024-5-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251114092450.172024-1-dongml2@chinatelecom.cn>
References: <20251114092450.172024-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the origin call case, if BPF_TRAMP_F_SKIP_FRAME is not set, it means
that the trampoline is not called, but "jmp".

Introduce the function bpf_trampoline_need_jmp() to check if the
trampoline is in "jmp" mode.

Do some adjustment on the "jmp" mode for the x86_64. The main adjustment
that we make is for the stack parameter passing case, as the stack
alignment logic changes in the "jmp" mode without the "rip". What's more,
the location of the parameters on the stack also changes.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 arch/x86/net/bpf_jit_comp.c | 15 ++++++++++-----
 include/linux/bpf.h         | 12 ++++++++++++
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 2d300ab37cdd..21ce2b8457ec 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2830,7 +2830,7 @@ static int get_nr_used_regs(const struct btf_func_model *m)
 }
 
 static void save_args(const struct btf_func_model *m, u8 **prog,
-		      int stack_size, bool for_call_origin)
+		      int stack_size, bool for_call_origin, bool jmp)
 {
 	int arg_regs, first_off = 0, nr_regs = 0, nr_stack_slots = 0;
 	int i, j;
@@ -2873,7 +2873,7 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
 			 */
 			for (j = 0; j < arg_regs; j++) {
 				emit_ldx(prog, BPF_DW, BPF_REG_0, BPF_REG_FP,
-					 nr_stack_slots * 8 + 0x18);
+					 nr_stack_slots * 8 + 16 + (!jmp) * 8);
 				emit_stx(prog, BPF_DW, BPF_REG_FP, BPF_REG_0,
 					 -stack_size);
 
@@ -3267,7 +3267,12 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		 * should be 16-byte aligned. Following code depend on
 		 * that stack_size is already 8-byte aligned.
 		 */
-		stack_size += (stack_size % 16) ? 0 : 8;
+		if (bpf_trampoline_need_jmp(flags)) {
+			/* no rip in the "jmp" case */
+			stack_size += (stack_size % 16) ? 8 : 0;
+		} else {
+			stack_size += (stack_size % 16) ? 0 : 8;
+		}
 	}
 
 	arg_stack_off = stack_size;
@@ -3327,7 +3332,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ip_off);
 	}
 
-	save_args(m, &prog, regs_off, false);
+	save_args(m, &prog, regs_off, false, bpf_trampoline_need_jmp(flags));
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		/* arg1: mov rdi, im */
@@ -3360,7 +3365,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		restore_regs(m, &prog, regs_off);
-		save_args(m, &prog, arg_stack_off, true);
+		save_args(m, &prog, arg_stack_off, true, bpf_trampoline_need_jmp(flags));
 
 		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
 			/* Before calling the original function, load the
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a47d67db3be5..d65a71042aa3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1263,6 +1263,18 @@ typedef void (*bpf_trampoline_exit_t)(struct bpf_prog *prog, u64 start,
 bpf_trampoline_enter_t bpf_trampoline_enter(const struct bpf_prog *prog);
 bpf_trampoline_exit_t bpf_trampoline_exit(const struct bpf_prog *prog);
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_JMP
+static inline bool bpf_trampoline_need_jmp(u64 flags)
+{
+	return flags & BPF_TRAMP_F_CALL_ORIG && !(flags & BPF_TRAMP_F_SKIP_FRAME);
+}
+#else
+static inline bool bpf_trampoline_need_jmp(u64 flags)
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


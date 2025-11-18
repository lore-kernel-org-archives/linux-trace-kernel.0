Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8121835471B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Nov 2025 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763469436; cv=none; b=C4HS+dPIAv89se7aYXIXuonkgiu2Lzrnt1uHd3CCDZNExGMKU6nPISCbu3WgA1cOmRwriXL4lnZWc5YtpUytX48nD8qUWWnh7NisEE6GcqjR/eAIcYpqwHFM027mZ6ugROFLk3ZA0Wb7zFLo2KugWOYURVdksARU9wbeGnsnS+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763469436; c=relaxed/simple;
	bh=6lH5TThLt0iLUPf10EryfpP2LJ24tamdXbqQbNSY8i0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qjeZI8wGnjDLNy5KYcBBoGXa6Rv6+VktqvMghO7RjWWrxCUTYrBnts0Xss/PXj4FlkgdE83xkg7GOV+j5MPd9Yf5beGHjSICcQaG0IdkY6ndqGsodcHPnyjg9Obc/yKYmiuJ+726ll+PxqdlJvdL7zSB9EfuOnkWj5o/GauT/LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ux+GpTaA; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ux+GpTaA"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7bc0cd6a13aso3437373b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Nov 2025 04:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763469434; x=1764074234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Og8VZW3HRIC9jFqJjaOXGmdza1e4WZ/zf5HErz8QF0g=;
        b=Ux+GpTaAqZ7Lf5x0guIF+CpU2qC8RAa3PJ0KGmpnxl00r5UKn8FSsFajBXrewiDZQC
         M9rUx0qCdKLpsDsEbfWaNKdkMJvye7Fus/clloP44buHM69z2FbROzhshCvfbSzgSRYn
         L7N11+qPk1Co8xTmrA061UrB7BaAh4MA9q7oLDCZYsdH90aG5F24mACT9m//wO9QkPrW
         /ENnjwT1CswCw8G1sqxdUgWJ8YFWkbugYiTr6uqK7OnFuF4+WX8cHNgizVQe7YAjAZLG
         b6DHV1FDR0XN8djl1Oem09XvvJeOuZxjGtMlLrrEoPKvpVYnClBtwdRokOnyM8OdgiBP
         EYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763469434; x=1764074234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Og8VZW3HRIC9jFqJjaOXGmdza1e4WZ/zf5HErz8QF0g=;
        b=sw1W2kXPuz+lZ+AjFJwzesgBPaJr8KzwUHDjQkPWv81JLVNlfHiP9LKQGoMKhxYA1F
         8dA8Ver8SdiooQWhlVtgpVNcMPkbzUnWQsvm49834i9eUUjigVoBHlZoxU51fQArCCJl
         2JRZkq0xNKQcd9whgYWxL2MvJU+akGGA9x6h4eWuamZP7lktu+wsbqcONzFOyfMMD2i/
         BXmsjxamv+yrJCyRAGGgLqkk8z9fNHS/fiT7NwhvvtQZdWjNUujdPOOinw7vrbLJWYPP
         kaxxE93e0HRhnlzAzG/aTkrknWlYu2R/WopWrmhrEJjS7ceTiuT0Jw6xG9m8vWGC7y83
         qnoQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3hVYdDTKR+hfWPmD+jL0ZXdcsTMKJ2poEYjjWVFuchrfeB1veY8CBdGzc7LdefV6QrhB/So7qHPiRmjEw5WBSpF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR2nT6gowIYqYB3XOFiS00pSDTrbCON4ZrRy1zsBTZpaI93pK3
	H9NVBpvCS/jNocOJsOCwhk4kGj1qqS7OtXRD7P5Xi2k6iMOcZsqJ2EF+
X-Gm-Gg: ASbGncuMVwsxpRmgwPesRxLqs+4CJ5uPoW1N4i/IqDS7CC52JrRMogmlFCdfwpwBDWc
	C8rOImjaJYyeJzYpSOBo2r/aYO3mehzbvj2iHW6VYizypsgAUo9wKFyG2Me6QhdXzxsrC6qoDK0
	VtMRO9tVKlBI3weCIDhIDLmuuZWodGWsXgSRpCz6J7+vcCA67RU9z4uRyIkDtIPqazRRaQYY/7H
	mcnE2RPdkEm00z58OLwekyqyhcdH+wfvuEWle0GyqyH/jzkSvGH1GR5KBmqkko2TO4sM79BkZ9g
	MhvXg+k8u7CXJNnexsH3Bb1ruf1vJD6fhNnKK0OwHVkXGN3KbIIvRV2+/PDI3Rru25ra/RKx91b
	hHA2+LfoxrqRAltByuZnzd7LSKsX1gI/MD5n9Ysb+TPXxhnia6vr42fVRxzEdoYH8rIHPqakqxh
	4I79P+iRQoRbQ=
X-Google-Smtp-Source: AGHT+IFzVQjXBpjmRtPxHUA4jCnIvxaMRfFlmVFQe/HhGKJNurpODbRokRgaX1qNfPIoEbksNhY5aQ==
X-Received: by 2002:a05:6a21:9989:b0:35d:3533:3dd2 with SMTP id adf61e73a8af0-361152010d6mr4202690637.0.1763469433693;
        Tue, 18 Nov 2025 04:37:13 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b92772e7f2sm16331496b3a.57.2025.11.18.04.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 04:37:13 -0800 (PST)
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
Subject: [PATCH bpf-next v3 4/6] bpf,x86: adjust the "jmp" mode for bpf trampoline
Date: Tue, 18 Nov 2025 20:36:32 +0800
Message-ID: <20251118123639.688444-5-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251118123639.688444-1-dongml2@chinatelecom.cn>
References: <20251118123639.688444-1-dongml2@chinatelecom.cn>
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


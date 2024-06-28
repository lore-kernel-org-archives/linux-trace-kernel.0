Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8057D158D88
	for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719575317; cv=none; b=XOKvShvbozl+Om0gJ39SFjnnjVp8Io8lUf1GB2iooRz7AqcDclHZyzEPgxLLr/RvlpUXbv26Aynca+B43G1+1xeVXeor1STNUBaVxhqGkfOTbLTmHS9akzOiyu01GYoDouxRsxX7LQtqE84wTpINPBTmkWAxfdXWHq3d1fg6w6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719575317; c=relaxed/simple;
	bh=VJdO4GgFpt8aKtc7bjbF3cmUMfu8XkYdKq4Ngx877Z4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AaHcIg+PphtONl+rNEVkbK0vH1ALAvUbyzmkC5LTz/XjSNYwCxTqCoTgaWc3WNpccCa1O62bmkrG1ZT00qB1FN21W15lS1dnznmzOuvUPj8NHYtFEt8GmUNsO8W8wrR65AcOqRJ4xFyhOiXqgoX8D0lrgpbFuG/dDN9g6jyNM0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=R8rXJjaQ; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="R8rXJjaQ"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d566d5eda9so273814b6e.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Jun 2024 04:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1719575314; x=1720180114; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zu92VlTH1ow4WnF3F24wrq4zcoAj17+gcrjkHXOzv0c=;
        b=R8rXJjaQ1J+nU0tGNeQjacIbYeW9ZAmac+lPkpPLNakx8T+sLcHu5I82nEZ/Pdky9e
         0EKcO671mpjGEsWf83gSErxBI85CwOUc2twxtIVR0j5mlrXuv6hnjvgoUXpFzHzI1Wcr
         jdHKZr1fqoiScV+6rTenttRALb2GbtZg+twlLXw+Xj90PjHX7VTH2jo1Ql9/5KNMUTdE
         2sQVHDuCxinjZwDd/Ag127TMO7YFnYPvvotCgBi1eHOG/pOgVaU2WvWT5FVy9YpIeJvr
         E8i/y2dUrKQTE24GJT69f9sRc73TjB2r0hty7Yv21CncvExhwfJTdroqDNVC25OieYlV
         a48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719575314; x=1720180114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zu92VlTH1ow4WnF3F24wrq4zcoAj17+gcrjkHXOzv0c=;
        b=BX7A3zO4FCmYPOKWg/+hIQGvfstDthf693Zrmb9dl3NSAMdPcaO2YnkhBukb9JD3Mc
         zRsjX/uedqgThO2/p0hc7Lo0IyPuq3E+TRIOkhWaIDAT+gFvturkfstByQ7YgvgUiPtg
         EMIvoKPbaROHSboESdA6xUIp1vfPR0zCoY1o5dgKQU6S7eqgQkZ+OScup3nPDVm0ykfE
         Dp0P62MhUZGCATmSZzvTawH/YMQKh64BcNWEKpOMuwhBo1U8sdLGacgiqOA4wxbfWS0+
         U6bvNaUd/BAkZbi7DuiW6+fMFKRT/ldWcAeachGIIFGRmpmFcPYzEvMjWP98x812tlRg
         U6bA==
X-Forwarded-Encrypted: i=1; AJvYcCX5mLw/jYQLbfZBOPG331h7IZejG3M++4pm73ZbKijDC3EKg7S34oxL6j7HnMui1LAA9lcIqnqYYV6QvnrHYGCeJmNHF4ufm68EjKmXarZn6Ctr
X-Gm-Message-State: AOJu0YwzBs6sPnLsHD9uaMdNqVOq3bSrrPVay3V4e/lwfJAPQV5qqDfC
	1lDUpbBZpbqeMOgAf5Thiecx2DWoSc8mivUgbjx3nkNXbr4PMRKA1KguQXKjiyI=
X-Google-Smtp-Source: AGHT+IHqBcNxsuzbDkVDzeGLl+KZ+4BunsmWE6yFwxYZZDfljQ2MLP1gPrL7Qap1znSFly+4johqUA==
X-Received: by 2002:a05:6808:2105:b0:3d5:6754:807 with SMTP id 5614622812f47-3d567540b9dmr5736005b6e.22.1719575314434;
        Fri, 28 Jun 2024 04:48:34 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803ecfb90sm1377775b3a.139.2024.06.28.04.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 04:48:34 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Date: Fri, 28 Jun 2024 19:47:48 +0800
Subject: [PATCH v2 5/6] riscv: vector: Support calling schedule() for
 preemptible Vector
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-dev-andyc-dyn-ftrace-v4-v2-5-1e5f4cb1f049@sifive.com>
References: <20240628-dev-andyc-dyn-ftrace-v4-v2-0-1e5f4cb1f049@sifive.com>
In-Reply-To: <20240628-dev-andyc-dyn-ftrace-v4-v2-0-1e5f4cb1f049@sifive.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, Zong Li <zong.li@sifive.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, Andy Chiu <andy.chiu@sifive.com>
X-Mailer: b4 0.12.4

Each function entry implies a call to ftrace infrastructure. And it may
call into schedule in some cases. So, it is possible for preemptible
kernel-mode Vector to implicitly call into schedule. Since all V-regs
are caller-saved, it is possible to drop all V context when a thread
voluntarily call schedule(). Besides, we currently don't pass argument
through vector register, so we don't have to save/restore V-regs in
ftrace trampoline.

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
 arch/riscv/include/asm/processor.h |  5 +++++
 arch/riscv/include/asm/vector.h    | 22 +++++++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 68c3432dc6ea..02598e168659 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -95,6 +95,10 @@ struct pt_regs;
  *       Thus, the task does not own preempt_v. Any use of Vector will have to
  *       save preempt_v, if dirty, and fallback to non-preemptible kernel-mode
  *       Vector.
+ *  - bit 29: The thread voluntarily calls schedule() while holding an active
+ *    preempt_v. All preempt_v context should be dropped in such case because
+ *    V-regs are caller-saved. Only sstatus.VS=ON is persisted across a
+ *    schedule() call.
  *  - bit 30: The in-kernel preempt_v context is saved, and requries to be
  *    restored when returning to the context that owns the preempt_v.
  *  - bit 31: The in-kernel preempt_v context is dirty, as signaled by the
@@ -109,6 +113,7 @@ struct pt_regs;
 #define RISCV_PREEMPT_V			0x00000100
 #define RISCV_PREEMPT_V_DIRTY		0x80000000
 #define RISCV_PREEMPT_V_NEED_RESTORE	0x40000000
+#define RISCV_PREEMPT_V_IN_SCHEDULE	0x20000000
 
 /* CPU-specific state of a task */
 struct thread_struct {
diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index be7d309cca8a..fbf17aba92c1 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -75,6 +75,11 @@ static __always_inline void riscv_v_disable(void)
 	csr_clear(CSR_SSTATUS, SR_VS);
 }
 
+static __always_inline bool riscv_v_is_on(void)
+{
+	return !!(csr_read(CSR_SSTATUS) & SR_VS);
+}
+
 static __always_inline void __vstate_csr_save(struct __riscv_v_ext_state *dest)
 {
 	asm volatile (
@@ -243,6 +248,11 @@ static inline void __switch_to_vector(struct task_struct *prev,
 	struct pt_regs *regs;
 
 	if (riscv_preempt_v_started(prev)) {
+		if (riscv_v_is_on()) {
+			WARN_ON(prev->thread.riscv_v_flags & RISCV_V_CTX_DEPTH_MASK);
+			riscv_v_disable();
+			prev->thread.riscv_v_flags |= RISCV_PREEMPT_V_IN_SCHEDULE;
+		}
 		if (riscv_preempt_v_dirty(prev)) {
 			__riscv_v_vstate_save(&prev->thread.kernel_vstate,
 					      prev->thread.kernel_vstate.datap);
@@ -253,10 +263,16 @@ static inline void __switch_to_vector(struct task_struct *prev,
 		riscv_v_vstate_save(&prev->thread.vstate, regs);
 	}
 
-	if (riscv_preempt_v_started(next))
-		riscv_preempt_v_set_restore(next);
-	else
+	if (riscv_preempt_v_started(next)) {
+		if (next->thread.riscv_v_flags & RISCV_PREEMPT_V_IN_SCHEDULE) {
+			next->thread.riscv_v_flags &= ~RISCV_PREEMPT_V_IN_SCHEDULE;
+			riscv_v_enable();
+		} else {
+			riscv_preempt_v_set_restore(next);
+		}
+	} else {
 		riscv_v_vstate_set_restore(next, task_pt_regs(next));
+	}
 }
 
 void riscv_v_vstate_ctrl_init(struct task_struct *tsk);

-- 
2.43.0


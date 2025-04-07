Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A2621ABC9;
	Mon,  7 Apr 2025 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049339; cv=none; b=G7SnExuFe+MOck/zjMyIIjeuLpRRY0xIKWt/4QemifAKnPBX0WPOhAmc/MzSvKiPqAu8XI/zOFBpNekHrW9H83dysmnjSQHb2ps6gzYMaAOk1hvZ0HMDLlE9wXAVGdPETjLKQTax5ptvT3BObZ2SduFITc8wwKrlEmY9voz30+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049339; c=relaxed/simple;
	bh=ixCQP1rtUlOwa63aCKnKtMUaKI5FIrMsujmdH53+dco=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pebf6PraND+aHWKmJyIYrjA1hVtej1wPQCXi/dJ3kbiCIc2YwT9leRu8pobPOyHiKaPaU0hwnOgHLRNzi6/oVeHEMt8pBJslMwUTP7IYLqDAfJGX8fFsha87Qb1appoc1JUGWDr7QfxUiM9oVMElAk0JRdxn95P6Hlfefkd50Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MK4B9Q6D; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MK4B9Q6D"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223fb0f619dso45792715ad.1;
        Mon, 07 Apr 2025 11:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744049337; x=1744654137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GxvBXScR5G8/guPuwFtybfdLT7Xp8U7BWpl4kN1kr8=;
        b=MK4B9Q6DdMIqGW6ZLzd2K4/Bh09XQzDAf7Rf+jeVuUZC12+OqPh7H1Hx3jIuyUJcGq
         U+qeuGxuZi/XTBpfetKVHZjW65r7RV7LKLcZ5XdW/kPRkkx3ntfzqNsWBO5cBHBYKzQZ
         av2uSTt/zqkCtfxuwCJFeKFhOub31pbqbOAIksb9QidLDfTSN2pTSFB8dXU41QLprvb3
         DlJAGhbfQmStv7+4408I2C4gjh8UyuFG6CEsqoaOi7qWQTy7E6MDWsiYtYGW9A8F7CHn
         dBXX/XXyK/wFc0PtdQD1+KmW9XERc78NkHzMMyuExIw1+XO6X1vWt6YKd9nZpNjN1Y29
         DN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744049337; x=1744654137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GxvBXScR5G8/guPuwFtybfdLT7Xp8U7BWpl4kN1kr8=;
        b=iD2WkoFfPM4ySh3qj0VIwgL0pldXaZKWhb5QA4uVgMg607q7OzrpG2cKxGZlfEhIbq
         8OISoBfJ0UTw7heiMrVaFy1PuGQjWHf6CmP2h05HxLornWlCbSMZtiR+jl4hAc6PIRSb
         pnjfxnAkK5xvLu9zpygFEK8zUHfEcIZZIwCQRqBy2spiF8eXh+rVmJIMycaFi4RWedkt
         ubh0EU/Qu2aRTiPq81IAVa6eeKI6suR1XVfEIO8S0QH8ne84LmJ3S2xpXlPULs6VhjST
         Ibdl8EiFQnG3F9GpAECxbhnqsX4YQfFj0AqJIbnrEIY3WNWFHO87UYV7C4TDasud4sAJ
         THQw==
X-Forwarded-Encrypted: i=1; AJvYcCVnr3AInsmKzr+rsw4Fc0kSzVikYqF2VqB2vhcpFNEY7Pt0sp2KM5FkMnwg5H3mWKzgvxPeI5z3Kp8c1tyWiEfHbCkd@vger.kernel.org, AJvYcCWH5hkG028vycbNymqQ+gbu+Dl4ybNJk1kcNtbANggTy3l6cYbx/kQRgxfYQherJXQ8x24TFWDEciFgXbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoIZkuauCC54SoxAWDVsNaCbxNn4js02BPH+afr2SksDSUQTQP
	5bd5qnKywQ5KvKFFWfs91SsUPX/O5oRm63kt5wCXRdknH+Y0ZQ3F
X-Gm-Gg: ASbGncuN0GXbc1y383ucQ3bxj1o6EvPm1gBegYjrWQ11yZx9z140WD6n2NeilMwgrXL
	Z/gqHi1ymURxlKdKUEA4S2gvAED+kjnbWY9359RGSuJc7vblbw7gzGPQNTWjnDjA2osf4qeq7uj
	Id2Vg/7qSMRtEmhbWn1iEe4pteRjc83aFUTrQH/fpgjY2UuJCNZ87yTwi51jWYYyqT4qHb8Mdh7
	fTS82e2kVQgo8gaMWH7KatLeSkdNk8blqlvEIkOhG6mclqXDs+dI2sWP7ZA2YHDtzMDq5J3aXMy
	s/O2yU89u21p52gDJOwa1DEYOlFeEDklIr/5ythw3FjSwKyx/6Zt8TLF0eLZYSdKac6H2jAEUdU
	LL74VAhPkCEsgIFgGflU3bNsKvWzchVaLJw==
X-Google-Smtp-Source: AGHT+IEWDNqLKG23YHG2EaPKmPmMuBuN2vxb7Eb0UfS1Xfx3xzd34GxBwfA03Pt5nMI3Pt2fEK34Sw==
X-Received: by 2002:a17:903:230f:b0:223:517c:bfa1 with SMTP id d9443c01a7336-22a8a0a3a59mr190569785ad.38.1744049337341;
        Mon, 07 Apr 2025 11:08:57 -0700 (PDT)
Received: from localhost.localdomain (118-160-134-247.dynamic-ip.hinet.net. [118.160.134.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297865e03esm84282455ad.146.2025.04.07.11.08.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Apr 2025 11:08:56 -0700 (PDT)
From: Andy Chiu <andybnac@gmail.com>
To: linux-riscv@lists.infradead.org,
	alexghiti@rivosinc.com,
	palmer@dabbelt.com
Cc: Andy Chiu <andybnac@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	bjorn@rivosinc.com,
	puranjay12@gmail.com,
	paul.walmsley@sifive.com,
	greentime.hu@sifive.com,
	nick.hu@sifive.com,
	nylon.chen@sifive.com,
	eric.lin@sifive.com,
	vicent.chen@sifive.com,
	zong.li@sifive.com,
	yongxuan.wang@sifive.com,
	samuel.holland@sifive.com,
	olivia.chu@sifive.com,
	c2232430@gmail.com
Subject: [PATCH v4 02/12] riscv: ftrace factor out code defined by !WITH_ARG
Date: Tue,  8 Apr 2025 02:08:26 +0800
Message-Id: <20250407180838.42877-2-andybnac@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20250407180838.42877-1-andybnac@gmail.com>
References: <20250407180838.42877-1-andybnac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DYNAMIC_FTRACE selects DYNAMIC_FTRACE_WITH_ARGS and mcount-dyn.S in
riscv, so we can remove ifdef jargons of WITH_ARG when it is known that
DYNAMIC_FTRACE is true.

Signed-off-by: Andy Chiu <andybnac@gmail.com>
---
Changelog v4:
 - Add anew patch that makes ftrace and its asm easier to maintain
---
 arch/riscv/kernel/ftrace.c     | 15 ---------------
 arch/riscv/kernel/mcount-dyn.S | 34 ----------------------------------
 2 files changed, 49 deletions(-)

diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 674dcdfae7a1..1fd10555c580 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -210,7 +210,6 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
 }
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 		       struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
@@ -231,19 +230,5 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 	if (!function_graph_enter_regs(old, ip, frame_pointer, parent, fregs))
 		*parent = return_hooker;
 }
-#else /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
-extern void ftrace_graph_call(void);
-int ftrace_enable_ftrace_graph_caller(void)
-{
-	return __ftrace_modify_call((unsigned long)&ftrace_graph_call,
-				    (unsigned long)&prepare_ftrace_return, true, true);
-}
-
-int ftrace_disable_ftrace_graph_caller(void)
-{
-	return __ftrace_modify_call((unsigned long)&ftrace_graph_call,
-				    (unsigned long)&prepare_ftrace_return, false, true);
-}
-#endif /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
 #endif /* CONFIG_DYNAMIC_FTRACE */
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index e988bd26b28b..3f06b40bb6c8 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -56,8 +56,6 @@
 	addi	sp, sp, ABI_SIZE_ON_STACK
 	.endm
 
-#ifdef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
-
 /**
 * SAVE_ABI_REGS - save regs against the ftrace_regs struct
 *
@@ -149,36 +147,6 @@
 	mv	a3, sp
 	.endm
 
-#endif /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
-
-#ifndef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
-SYM_FUNC_START(ftrace_caller)
-	SAVE_ABI
-
-	addi	a0, t0, -FENTRY_RA_OFFSET
-	la	a1, function_trace_op
-	REG_L	a2, 0(a1)
-	mv	a1, ra
-	mv	a3, sp
-
-SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
-	call	ftrace_stub
-
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	addi	a0, sp, ABI_RA
-	REG_L	a1, ABI_T0(sp)
-	addi	a1, a1, -FENTRY_RA_OFFSET
-#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
-	mv	a2, s0
-#endif
-SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
-	call	ftrace_stub
-#endif
-	RESTORE_ABI
-	jr	t0
-SYM_FUNC_END(ftrace_caller)
-
-#else /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
 SYM_FUNC_START(ftrace_caller)
 	mv	t1, zero
 	SAVE_ABI_REGS
@@ -194,8 +162,6 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	jr	t1
 SYM_FUNC_END(ftrace_caller)
 
-#endif /* CONFIG_DYNAMIC_FTRACE_WITH_ARGS */
-
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 SYM_CODE_START(ftrace_stub_direct_tramp)
 	jr	t0
-- 
2.39.3 (Apple Git-145)


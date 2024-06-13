Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8F013CFA4
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Jun 2024 07:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263974; cv=none; b=W8dHYkKRjLouCBLFa26OFxw7es1Yqy4DxihcmrwmbLZEoLtEz7yV0hMNgaw71X9rWSl+MoXCQKiyatvSSJwi4lTHr1BIoRR/uokQkz+XpfqQ0Ci7/G3EGEOI4FQMAiTw4ywK99dWrC8qNlYOzHcO+tBiAeLZdpf8r9DxX0l/JEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263974; c=relaxed/simple;
	bh=bMHErU1rLfk/wyX5o/DIX3M08fOpuNP508e8HYuo5pE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iL0BSOrN045TQgMO1gj80v6jJ7dp8Kp9wwd5tsr1HN2LBtpkE7wXk8gnIjm38AU4/mo7Pz+37nWetinYMvYZXUgCo3DfuGvE4FbPDVDq8QnlgcLrNTGg1ZanB8vugHVzRSKC+DKEbiRJL8mxzyx9X8Aun5gbkwfz22CrZJrP77k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=IuA+BP23; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IuA+BP23"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5bacd59e562so363181eaf.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Jun 2024 00:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718263972; x=1718868772; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqGOcRG4MSO17L8Yoo0My/BpQLJGME/lNuiKW2jExFw=;
        b=IuA+BP23jxTOAG9lmxUL54VkgwxfKT7HwSd5s95zMFIDgJ7RuTNGy2P4AR2H3o8t7y
         Kb3a3HjAHdsi1CIHd+HNjleYdHbBWUsDwsmZ8SrlnqZascKvZhD95KtoZNVAXPY/QnFf
         wvifrYumjMjlLQJtVJa8x24s8NquzgrXB62yKa0qAQfdiNlMssbHUj+ih0zRU8/+3nZP
         TPGePrh9SiEcBt5FT6VbPcMtB9VNluBIrS9Au3Vx9NlVZZU9OSCtP/lFGTOUERF7cxZ6
         Jws9Vfx1Jx6xbbaVkpqJT9cQfRRWTsSL+873EI33gP95bfCjWt5bf4BPAT1rBc/EM4jp
         NyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718263972; x=1718868772;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqGOcRG4MSO17L8Yoo0My/BpQLJGME/lNuiKW2jExFw=;
        b=nO6bwyRJeGdoCgiBWlut2IQDyKSiFqRRFPyLj3GM1XRtHDANEZPltYhn2ORSDdUIUl
         cB6Qw7GOkExRjqOu4Djb7RBTt74KN1n0bB0BvK4m9tei18bTNQYbl4mdL3eWp3+JJ7J1
         6mgfQ3Ds0jwr5xWhcAtV0MZ+mu9Yz2KZHdBaCM/He0LLuSgQ11a7ICx2mSzsk23wlnAW
         xFX1JEl2gt4x/TMDcRovfE8TUg3XcVFOEOuxe6njF8ZENh3uxOGIBb/yOpcfiVL3U851
         xUmolJ0YIW0RJrmJz7T+ADiLotBRzgKZOP2LbDf0OeZ0aa4pMNqZnTxK4l+neLyaLakw
         mrDg==
X-Forwarded-Encrypted: i=1; AJvYcCVfXrkxdO7Dqyt9gTyuP+b8FjDdLZCsIxnT1NUa9QSRHiiN6QWbXJn0IjlywxKAipkB9ouU/38g4/+oUsujA1JB6CyC9qMmz6oHQ2ipoa7yMyZ2
X-Gm-Message-State: AOJu0Yz+pUwRq6VR7R7KR+/XirM6WFQZPqsZZHHhNtHGkJeZoxbqRtx2
	nGPLbaP0ru5yxWvu6d4ZTuU3epwxHCCUVRwJYih/kUFhmOviC51HTEItZxqrgUc=
X-Google-Smtp-Source: AGHT+IH5DuWNaDmtQxAXDaBzm13SBjMPGjRqC4tR8s/HjfQ0ZY47iBUeJz4hi/y6Ws3uKj9ioyrEhA==
X-Received: by 2002:a05:6871:b29:b0:254:b3cc:a6da with SMTP id 586e51a60fabf-25514c664afmr4230304fac.29.1718263971977;
        Thu, 13 Jun 2024 00:32:51 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc78a1a0sm730028b3a.0.2024.06.13.00.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 00:32:51 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Date: Thu, 13 Jun 2024 15:11:08 +0800
Subject: [PATCH 3/8] riscv: ftrace: support fastcc in Clang for WITH_ARGS
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-dev-andyc-dyn-ftrace-v4-v1-3-1a538e12c01e@sifive.com>
References: <20240613-dev-andyc-dyn-ftrace-v4-v1-0-1a538e12c01e@sifive.com>
In-Reply-To: <20240613-dev-andyc-dyn-ftrace-v4-v1-0-1a538e12c01e@sifive.com>
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
 llvm@lists.linux.dev, Evgenii Shatokhin <e.shatokhin@yadro.com>, 
 Andy Chiu <andy.chiu@sifive.com>
X-Mailer: b4 0.12.4

Some caller-saved registers which are not defined as function arguments
in the ABI can still be passed as arguments when the kernel is compiled
with Clang. As a result, we must save and restore those registers to
prevent ftrace from clobbering them.

- [1]: https://reviews.llvm.org/D68559
Reported-by: Evgenii Shatokhin <e.shatokhin@yadro.com>
Closes: https://lore.kernel.org/linux-riscv/7e7c7914-445d-426d-89a0-59a9199c45b1@yadro.com/
Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
 arch/riscv/include/asm/ftrace.h |  7 +++++++
 arch/riscv/kernel/asm-offsets.c |  7 +++++++
 arch/riscv/kernel/mcount-dyn.S  | 16 ++++++++++++++--
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 9eb31a7ea0aa..5f81c53dbfd9 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -144,6 +144,13 @@ struct ftrace_regs {
 			unsigned long a5;
 			unsigned long a6;
 			unsigned long a7;
+#ifdef CONFIG_CC_IS_CLANG
+			unsigned long t2;
+			unsigned long t3;
+			unsigned long t4;
+			unsigned long t5;
+			unsigned long t6;
+#endif
 		};
 	};
 };
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index b09ca5f944f7..db5a26fcc9ae 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -497,6 +497,13 @@ void asm_offsets(void)
 	DEFINE(FREGS_SP,	    offsetof(struct ftrace_regs, sp));
 	DEFINE(FREGS_S0,	    offsetof(struct ftrace_regs, s0));
 	DEFINE(FREGS_T1,	    offsetof(struct ftrace_regs, t1));
+#ifdef CONFIG_CC_IS_CLANG
+	DEFINE(FREGS_T2,	    offsetof(struct ftrace_regs, t2));
+	DEFINE(FREGS_T3,	    offsetof(struct ftrace_regs, t3));
+	DEFINE(FREGS_T4,	    offsetof(struct ftrace_regs, t4));
+	DEFINE(FREGS_T5,	    offsetof(struct ftrace_regs, t5));
+	DEFINE(FREGS_T6,	    offsetof(struct ftrace_regs, t6));
+#endif
 	DEFINE(FREGS_A0,	    offsetof(struct ftrace_regs, a0));
 	DEFINE(FREGS_A1,	    offsetof(struct ftrace_regs, a1));
 	DEFINE(FREGS_A2,	    offsetof(struct ftrace_regs, a2));
diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index 745dd4c4a69c..e988bd26b28b 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -96,7 +96,13 @@
 	REG_S	x8,  FREGS_S0(sp)
 #endif
 	REG_S	x6,  FREGS_T1(sp)
-
+#ifdef CONFIG_CC_IS_CLANG
+	REG_S	x7,  FREGS_T2(sp)
+	REG_S	x28, FREGS_T3(sp)
+	REG_S	x29, FREGS_T4(sp)
+	REG_S	x30, FREGS_T5(sp)
+	REG_S	x31, FREGS_T6(sp)
+#endif
 	// save the arguments
 	REG_S	x10, FREGS_A0(sp)
 	REG_S	x11, FREGS_A1(sp)
@@ -115,7 +121,13 @@
 	REG_L	x8, FREGS_S0(sp)
 #endif
 	REG_L	x6,  FREGS_T1(sp)
-
+#ifdef CONFIG_CC_IS_CLANG
+	REG_L	x7,  FREGS_T2(sp)
+	REG_L	x28, FREGS_T3(sp)
+	REG_L	x29, FREGS_T4(sp)
+	REG_L	x30, FREGS_T5(sp)
+	REG_L	x31, FREGS_T6(sp)
+#endif
 	// restore the arguments
 	REG_L	x10, FREGS_A0(sp)
 	REG_L	x11, FREGS_A1(sp)

-- 
2.43.0


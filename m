Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1C020103A;
	Wed, 27 Nov 2024 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732728596; cv=none; b=iKmP2FoX2avIqOWUE2+OXdUyUq0JXh/bAozFbN69rAWkzVM79hIgj5uF7uqqyjILWfib7ggNJtXyLKCiAcQww5d+5O6mbaVR2+JLfc6FfC0oobgzH0kYpQaIEqGgcMY3P7yGiNLiUWDOdLjB+gzb04QVjCNQuAE3ywPXYIl4YgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732728596; c=relaxed/simple;
	bh=bpMqPVQ3HsfWe+bk5gds1iHBJEE9VMgZp3CPDFR8+go=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KjlYuXVtdnzT8neAczl5XtWXXemLXrtgbXmvDmuE+bqVLdm7WW9sBMaUrXNQt30Zr/Xu9oPy5tsvMeGjr0zh0L6aqp8hvs7bK/G7ahcF+4o7L9nrL3p0lO5XGiMTI7dIjn9Xz9DhK3JqEQhNiHiuXxZGOYtJyKBj8SmHaPP2AB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnHNZHz2; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnHNZHz2"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7251331e756so16749b3a.3;
        Wed, 27 Nov 2024 09:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732728594; x=1733333394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhqF3E4/w+YtOL58NNfG2rcUNmjyen3grJ9NA1x6juQ=;
        b=dnHNZHz2Ak6h4F+UgCuK1b26TtEdgxyo92ke2v/2SFjvcdhkW1Lu3GXJxygApSMVKW
         OQnrF1nn/CFe+zLrDy8vsqA0RIgHxvCEosAsG+B8UUVP3KxFnze37KBlCP1vhqaHjB/B
         prSjGdp3ghZ9nj9VUzoYckFoua0HKInV849NCxh22ntFUSRiauAiva+arAuRJMfMgrme
         /sKZD2CsX+EPDSI+setBN8wTR6t+nrXaHSJRFtZbqypJaMgq8IFeOtXJWtXgb8SkfVu/
         i8m1rwnuUy8hk04DdgkUW88BwaIejhA1XrLCxUuSlsJh8syyorltRf3MuZEN0TA5OabW
         C83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732728594; x=1733333394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VhqF3E4/w+YtOL58NNfG2rcUNmjyen3grJ9NA1x6juQ=;
        b=n8hMrqCrLoRW9L/kC90J2uowKA3T22hMN4cZrQuWuTh85yRczZWlOfJAFMsfmsW8O0
         1eusmFTMuBlQ77icCbjJAzEoPjVHDnDtshXN/+dN9Pa4AOXlAiXr6ywrXPzffGt2qmLr
         w3EMhMNVmUDi6F6qpM6H/0WURafnu5StzF5avqPSpKl4APqMBwRplzfNTnis31eXhiXb
         9eB8iZ37sCK4qoP4dhh5Rk1jdS1HFLA0zEV4p9/ZXMTkMoTJrZPnoz7+Z947NGyKFBdR
         nkWg+D+Uhu2U8EjPRVqtAnfSqUX7A7YauGQFrBel9rLmEZrtaUsDDicy30QoXedH6rC0
         ad+g==
X-Forwarded-Encrypted: i=1; AJvYcCUsR40oLdfCmqRuMVpwe7fPWJn/pmuTdxAzC48cqvh4nsrneejKct72MZFNEDfLhmuKAaBhIf+8OOqxNZkWaVl7ntc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeTJduwr3HWQdel1BolJrVG1cE3W+G91Vpf3y3GMfMa7njyb5Z
	fvfJp5JWjw7t27BwWZWA57rV4NIJU3rANWPAvBhlYU7KrZLbK0UC
X-Gm-Gg: ASbGncuWasBTcoi3lWu/yX0+2oEVNCmI5A52rwjEBVn9nuZ3ZeMYnCZn7mz/uwA0yuJ
	eDE3XRBVt3La/je2m80f6J8B9xBWJS1wYCluzvIVj6Jm2/hxP42KSHvE3xqPu/Lfv7MXk84d+7p
	QUT4ymbgj11p3Ru0dh1nkOFZlqjHFoWsEkK3Ob+58z9uhNgaAEB9oaural3jPpM8eMTB7mETzJF
	8CZakyKEfNQDXCzrxhZIwAG2aYt7nL7Zm6Lfch5e3Y+UiTYf5LwDzjxHYCpbqymnlhBNccVKioT
	spEHgs1GWBJYPkpjcb51DZDNu7WY
X-Google-Smtp-Source: AGHT+IHe4vfUFn689BzH733Y3azaB4OQQfGNQ2U5d2DUk6y3aLJvqA63KG7l5W6jxcEPLUbmlo8oFg==
X-Received: by 2002:a05:6a00:3c89:b0:724:eac3:576a with SMTP id d2e1a72fcca58-725301a5b92mr5270747b3a.25.1732728594123;
        Wed, 27 Nov 2024 09:29:54 -0800 (PST)
Received: from localhost.localdomain (1-171-29-17.dynamic-ip.hinet.net. [1.171.29.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc1e3fdbsm9359582a12.30.2024.11.27.09.29.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 Nov 2024 09:29:53 -0800 (PST)
From: Andy Chiu <andybnac@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	llvm@lists.linux.dev,
	bjorn@rivosinc.com,
	puranjay12@gmail.com,
	alexghiti@rivosinc.com,
	yongxuan.wang@sifive.com,
	greentime.hu@sifive.com,
	nick.hu@sifive.com,
	nylon.chen@sifive.com,
	tommy.wu@sifive.com,
	eric.lin@sifive.com,
	viccent.chen@sifive.com,
	zong.li@sifive.com,
	samuel.holland@sifive.com
Subject: [PATCH v3 1/7] riscv: ftrace: support fastcc in Clang for WITH_ARGS
Date: Thu, 28 Nov 2024 01:29:02 +0800
Message-Id: <20241127172908.17149-2-andybnac@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20241127172908.17149-1-andybnac@gmail.com>
References: <20241127172908.17149-1-andybnac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Chiu <andy.chiu@sifive.com>

Some caller-saved registers which are not defined as function arguments
in the ABI can still be passed as arguments when the kernel is compiled
with Clang. As a result, we must save and restore those registers to
prevent ftrace from clobbering them.

- [1]: https://reviews.llvm.org/D68559

Reported-by: Evgenii Shatokhin <e.shatokhin@yadro.com>
Closes: https://lore.kernel.org/linux-riscv/7e7c7914-445d-426d-89a0-59a9199c45b1@yadro.com/
Acked-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
 arch/riscv/include/asm/ftrace.h |  7 +++++++
 arch/riscv/kernel/asm-offsets.c |  7 +++++++
 arch/riscv/kernel/mcount-dyn.S  | 16 ++++++++++++++--
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 2cddd79ff21b..4ca7ce7f34d7 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -143,6 +143,13 @@ struct ftrace_regs {
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
index e94180ba432f..59789dfb2d5d 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -504,6 +504,13 @@ void asm_offsets(void)
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
2.39.3 (Apple Git-145)


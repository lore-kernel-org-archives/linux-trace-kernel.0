Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBC4218E83;
	Mon,  7 Apr 2025 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049334; cv=none; b=jbb10lZd6LviPavYfbYq71vVuVbaz2J/0QxDgx0BkgI3DopB9mds85HmfA4P+5yFp/nfvm+WS1o00GbPYdO7p1jijbzuciB+Rt7Q90dlwPGcveYwveffx5a6NO9SSS5unECVteVoExDi5/Kz9OC4/Nga/7h4Ajsrztv2svda7kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049334; c=relaxed/simple;
	bh=1xPajWgfwmwF/VCSQKTh6IW17wYrEsu9sun66yJMYC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LvYwFICPMf9OIAmEYlCRMqND9OBFLqAcl1W+rWwNzBUI4zgjDTgAl4EzJUr+WgbD8X1pBkhJlIqdIvgekMMXz2NUxlvJP5eMkagBbNCtyayVrHSI/p/duXw7tD3lo+lL7mdgsa4dUyrpx7GckSby78h3/H0uPGycxD6zIeIGLqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFIsnCpu; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFIsnCpu"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22548a28d0cso64539825ad.3;
        Mon, 07 Apr 2025 11:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744049332; x=1744654132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OGgUcQY3LpMQzwnxjPDiN9+XewxjYA0t31wP+uhnCCY=;
        b=AFIsnCpuXSEUYPvt4ZA4oMMl+g9To1/sC9ja0Q3X2/FuuD4G8+iVeBKGbAOmVWzx4W
         KhsSVfBnxZyKpQ44HjQu3tsbeMOnd6x5odvWhlgk72Za8+Woy1Cgf2yeFuUDTtdbLRyS
         LDTU9521VyeXGerf9mppEtML9tQZWMBIKUFR4hb243Gk5d5vmhyNnFEh77RXsfy/BiOZ
         dtLH+yocDtCkUx86Ya/J8I6aRgqTxJFd7PIORpwdfz3XBVjppJ5RudwaJ+ntQKNttFW3
         V4bQOnVPiy9RAuQ4cm4UJ30njfLT4COgrqQm+YnpXD6WcCctQNHorb89uPA+SD3DYqK6
         yEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744049332; x=1744654132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGgUcQY3LpMQzwnxjPDiN9+XewxjYA0t31wP+uhnCCY=;
        b=YMlxbNCBupXt/lqfsgHB7aHOTbjbGetPjJtXPYupmI29c5Pyy/WkAQAwQgkhejb/kt
         ghTgTUldHQXy9exhpSkzxXn0GR6q2DEntkuUHkF2XonUHGxIXcp908ngJFnSb/kh9AE0
         kZxO4I4DmaS9QYfC7ZO7xNv4Ea0P7pNqiirHQUGLZfOUJec+beCsbgFTkSg2FBQ/2Z1V
         CmaqBzLIuggBQQOW6id78iAqLDCb3qKrLRYiK14x4+DNoM+q73TVdTPxGroGpzHWN6BC
         qgOr8G3e36JDLRXO936oLxOdD1P5PxxtR0ySv3oIxAp0ATOuX8e9yBIXi+KYf4pr8K1+
         sXsw==
X-Forwarded-Encrypted: i=1; AJvYcCWF8Wsml/MEnUNO4gNlfaVwIFrm8vD5SckM3R9x5NRFgQ+220wEX36skgCoc4ed35QC8dL+HNFQe729SSA=@vger.kernel.org, AJvYcCWMrgLkM41geZAAn1CbQ5svz0vtl5YiW1hcEA4nYu4+DNjIclzzQ5/XX9VhUsNjW/KdXSgchiocNAg12Z9ZkG5Sl6xh@vger.kernel.org
X-Gm-Message-State: AOJu0YwSQ9niyXbUc9VnlWarQ7nAiSEpWrlgDkOdQlHfC/txHiAFO2Mm
	kOlMZsYUp9FL60OAFWgNuABGxgfGrj+WgrQti1mSf9ktqE520/As
X-Gm-Gg: ASbGncuUtv33k0LnMXyM9XKwzzv0JVe2pnhUasYkGJCzc41ekJU4PpvuZJnAJJ0aHpN
	dhEUYNl4MEk0WTRorLiuSYSEzXU0KG+Wlz1HsP3wmpeyoVo4LcgATLIBh5lHz13ppsgWOa/4n+b
	O7g32lTdS1cdgfHypBtjbvS0mHXaYNhPKDns5h7pDUhAx2UdHdLdK2nQhPh7Gd/CtVPck1e4ILB
	vLfx2co4jq6irOPc0w3ZPaMEFoUnUqxIxgUag4lC0tRiyDE6KpidWfnUQ21DfZmYaZZ60/uekUQ
	tG6BfkuQNybtmbCdtYBlpHGnl1japZLW4BuIrAYxj1A/S/GDaEammUm+ojfACHmEhfTQtZS5gse
	w5fb4jfejU+GXhU8tLCE+lAlqBIn3QSrLRA==
X-Google-Smtp-Source: AGHT+IF9o01fgdgPFq84Ese3rGK1eK3K1lWa1HP0jF4cDQEDcmyxsE30VYjB8V+k5xLVlJftQJwEiw==
X-Received: by 2002:a17:902:ecd2:b0:223:52fc:a15a with SMTP id d9443c01a7336-22a8a8b80f8mr161642065ad.33.1744049332400;
        Mon, 07 Apr 2025 11:08:52 -0700 (PDT)
Received: from localhost.localdomain (118-160-134-247.dynamic-ip.hinet.net. [118.160.134.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297865e03esm84282455ad.146.2025.04.07.11.08.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Apr 2025 11:08:51 -0700 (PDT)
From: Andy Chiu <andybnac@gmail.com>
To: linux-riscv@lists.infradead.org,
	alexghiti@rivosinc.com,
	palmer@dabbelt.com
Cc: Andy Chiu <andy.chiu@sifive.com>,
	Evgenii Shatokhin <e.shatokhin@yadro.com>,
	Nathan Chancellor <nathan@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
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
Subject: [PATCH v4 01/12] riscv: ftrace: support fastcc in Clang for WITH_ARGS
Date: Tue,  8 Apr 2025 02:08:25 +0800
Message-Id: <20250407180838.42877-1-andybnac@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Andy Chiu <andy.chiu@sifive.com>

Some caller-saved registers which are not defined as function arguments
in the ABI can still be passed as arguments when the kernel is compiled
with Clang. As a result, we must save and restore those registers to
prevent ftrace from clobbering them.

- [1]: https://reviews.llvm.org/D68559

Reported-by: Evgenii Shatokhin <e.shatokhin@yadro.com>
Closes: https://lore.kernel.org/linux-riscv/7e7c7914-445d-426d-89a0-59a9199c45b1@yadro.com/
Fixes: 7caa9765465f ("ftrace: riscv: move from REGS to ARGS")
Acked-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Signed-off-by: Andy Chiu <andy.chiu@sifive.com>

---
Changelogs v4:
 - Add a fix tag (Björn, Evgenii)
---
 arch/riscv/include/asm/ftrace.h |  7 +++++++
 arch/riscv/kernel/asm-offsets.c |  7 +++++++
 arch/riscv/kernel/mcount-dyn.S  | 16 ++++++++++++++--
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index d627f63ee289..d8b2138bd9c6 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -146,6 +146,13 @@ struct __arch_ftrace_regs {
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
index 16490755304e..7c43c8e26ae7 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -501,6 +501,13 @@ void asm_offsets(void)
 	DEFINE(FREGS_SP,	    offsetof(struct __arch_ftrace_regs, sp));
 	DEFINE(FREGS_S0,	    offsetof(struct __arch_ftrace_regs, s0));
 	DEFINE(FREGS_T1,	    offsetof(struct __arch_ftrace_regs, t1));
+#ifdef CONFIG_CC_IS_CLANG
+	DEFINE(FREGS_T2,	    offsetof(struct __arch_ftrace_regs, t2));
+	DEFINE(FREGS_T3,	    offsetof(struct __arch_ftrace_regs, t3));
+	DEFINE(FREGS_T4,	    offsetof(struct __arch_ftrace_regs, t4));
+	DEFINE(FREGS_T5,	    offsetof(struct __arch_ftrace_regs, t5));
+	DEFINE(FREGS_T6,	    offsetof(struct __arch_ftrace_regs, t6));
+#endif
 	DEFINE(FREGS_A0,	    offsetof(struct __arch_ftrace_regs, a0));
 	DEFINE(FREGS_A1,	    offsetof(struct __arch_ftrace_regs, a1));
 	DEFINE(FREGS_A2,	    offsetof(struct __arch_ftrace_regs, a2));
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


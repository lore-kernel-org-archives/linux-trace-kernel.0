Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9396B13C670
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Jun 2024 07:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718263966; cv=none; b=f7E5H72OCVMHVRpHFD6JcO36sir2ySGAYJxFPUdVpJJkR/+D/Dv0hYD7A8w3Z4ILDxYelasY7RaQv0DEMzx7FBEs9AcV3xY55pHaooQJMTyJ8LNLSr51oAji3rBrTgblz9nHputYu3Mh2u5LY5Bvw9dtzPH4QDR/R9mAI9qqcgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718263966; c=relaxed/simple;
	bh=JiXCsJYbgQAz9+R6zTWp/RApNEHB55TEiq7HnF4rVDs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pmX0ERsVz+E93Y7375G9uy4PzD5shQp4nZ0ILBWpbHovRPXjkcNjRs7b60BjHVj/EPnN2u0N7jxOa4pbRUcwjdVRnKhUJ5wl6p0+tLrUGUvg83TX6dQebhKueUilzQqbLN7s9e5g1MyJ35rp2kUZLdhGs8C9UZ7PjJw5MRRts6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=CDmnzgHr; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CDmnzgHr"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-705959a2dfbso497628b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Jun 2024 00:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718263964; x=1718868764; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=90j1lP2iehIU9E2euRd9xJoPIJsKCYmj2Va6/Ket5KI=;
        b=CDmnzgHrN8I69+1iXs0n+uGJ4tABm3ifoX9XjxQPv/VsPfMX3e9qkxQ9tsrAoSfxvH
         1gNjMvnoHWg7g2fpmNDSjf3PnS7G0jxLEVnDOpTe8/RIzFepnyNlyaLaTdHL9mOpyWRk
         4x3wAJcrmpR/sI+mXb4HIp8xbD5Wdr9awdaGZJlkf24mSAvOPonAMggz5ceGrBNR0BYS
         xksIhxbkSZCUlU+4kl9dN+sXxBoRbEJkbR4tkP/NPvrQxXTNAHv1gCjZAB/IYG5c/EfH
         XHvKh1KtAUBzf4m8gIcC8rN2HMryp1hpNfSJeTOWiN9sL4KexLpwhAd4z/F/tTzuT0xq
         TrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718263964; x=1718868764;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90j1lP2iehIU9E2euRd9xJoPIJsKCYmj2Va6/Ket5KI=;
        b=N2xfuLVqg1qw/fvp/MNsRmbkN4SRAtR1Ds6rqxBDdoSSKUZRsLmykjiTVrvuNbwNuj
         AFXigVuSZO+uoBQh5hb/CfRAGfd6quBncnoieqwqEbz8honfQHLkkA1ocsMwnvW5sBSx
         GamzJKVpo0c/xsT2s7tWR/TdRJmhqA7K7kaxF8DebUypyRHuBAXQaiR9USgedG+xWSkn
         kbOOr+a49dTA+OUTgzFe+h88kE2nXdiGvBu426LoLv2CDJSu622cF3F7Do+pAKGXJl5C
         T/eWERdO2VYENrM5zoli64VX3qet6doCV6c9aIW/mwiXwweX5oQnJHoGWC9nYXi1RygN
         NBKw==
X-Forwarded-Encrypted: i=1; AJvYcCWmpwTl4wUtPttu1Ls5KCOSGkrSjv4EHm/j5iWfUBYbq0WmPBvaHo6VIPBCccYbkQWJqyYy+7ru7mMTLRxrtgPrtWK6Kt7zpyTFInkKcLCOK7vx
X-Gm-Message-State: AOJu0Yy7EFhXZOZGORKq1+qcZyQLYDe8dKcC9KqItHcWHgAhXd+Z1PSt
	3KzkyrEcQm3hHO8Cz2J6F7DM5zEbpGEcED4BE1jzqhwwhGqBi0g+GttkQv/8gQ0=
X-Google-Smtp-Source: AGHT+IGTwQ5EB55toThK3E4Aeh/60oGzOVaQMTb+lJV8UkAi/aBjTebo3WO7lB+gn84w0BlxoTDk4Q==
X-Received: by 2002:a05:6a00:2d84:b0:705:a18a:686a with SMTP id d2e1a72fcca58-705c9389332mr2770164b3a.7.1718263963654;
        Thu, 13 Jun 2024 00:32:43 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc78a1a0sm730028b3a.0.2024.06.13.00.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 00:32:43 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Date: Thu, 13 Jun 2024 15:11:06 +0800
Subject: [PATCH 1/8] riscv: stacktrace: convert arch_stack_walk() to
 noinstr
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-dev-andyc-dyn-ftrace-v4-v1-1-1a538e12c01e@sifive.com>
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
 llvm@lists.linux.dev, Andy Chiu <andy.chiu@sifive.com>
X-Mailer: b4 0.12.4

arch_stack_walk() is called intensively in function_graph when the
kernel is compiled with CONFIG_TRACE_IRQFLAGS. As a result, the kernel
logs a lot of arch_stack_walk and its sub-functions into the ftrace
buffer. However, these functions should not appear on the trace log
because they are part of the ftrace itself. This patch references what
arm64 does for the smae function. So it further prevent the re-enter
kprobe issue, which is also possible on riscv.

Related-to: commit 0fbcd8abf337 ("arm64: Prohibit instrumentation on arch_stack_walk()")
Fixes: 680341382da5 ("riscv: add CALLER_ADDRx support")
Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
 arch/riscv/kernel/stacktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 528ec7cc9a62..0d3f00eb0bae 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -156,7 +156,7 @@ unsigned long __get_wchan(struct task_struct *task)
 	return pc;
 }
 
-noinline void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
+noinline noinstr void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
 		     struct task_struct *task, struct pt_regs *regs)
 {
 	walk_stackframe(task, regs, consume_entry, cookie);

-- 
2.43.0


Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0648345CB9
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Nov 2025 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763469425; cv=none; b=oNk5qWJ4k/U3LbXL3tDuCkXmlQZQfPB9tCGq2FtsJ+Z7IUh/wFHY5U9GINjNcoY4b2iuBmCvu6EUelavsnGehMwNBoTC1Sp2nf567noghIkHif+WJAeInU/hwoinCxE9cLi7rln0+n+ZTHkceo8BgVP9Y8KSQdSaoOejA/gXD+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763469425; c=relaxed/simple;
	bh=yw0+14vG3MTkylBTsNGEjI1rTbbl51z2DrBpLhZnx4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJw6ZIWWJwyoDoNxMgMnEu88LEzub3FTBkhD5yBXwCQwRI7XT3bYRoHFKMTmxVhcrR0R112+a4y2GKV/pb3LEpNk6CYQXPaukweyI+KcS9+KpS1orOLqhXtJR1Vq+dWA8JB3o/s/IG5qtGZ73YhyzX8uzbhtIndN3ZMCtWyvEN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJ6PDHPU; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJ6PDHPU"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so4465460b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Nov 2025 04:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763469421; x=1764074221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRkWsGzjZIg7j77yjUEwdtDGoZTowRE1mWBAeLLFj3U=;
        b=XJ6PDHPU/43Hl58ZLURBIl0aD1bLDiWd/ZXkuC7Ivd8A5Xl6SCaLUOPPzeOFplUUmY
         8bdgrxGb8WfYWTclxDAQadta7nXpRXIwXDQTojnC1jqxEMU68wqJQ263XQShenChUM2l
         6cY5SqlwkYbQ2xeOB9OsVEK7X8hle3Dngo6TttlwgMW/uQp8iFcRoUXDOVfJMRP1iNgZ
         GgAATu4QyyiSv9E8Tkzh/Ppl+O17bRcDTfESNfST2L7t+gjZNYRcAnH5imdeQLjno5AH
         RDbezKUFs2Kw5vxcwS6UHhnxV6MZfGHt/YwH9RkE4CZqlBNBiYKkpESBmKuFcFEIq/Na
         AQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763469421; x=1764074221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KRkWsGzjZIg7j77yjUEwdtDGoZTowRE1mWBAeLLFj3U=;
        b=fLy82jw7EA2NGAG4+hNUbFyczKwzUakE0Dtvm2hPOQfo5ngJ4qsJnPEhYpbAzpcAsn
         psgN+LRPvBArhuSXbQjfjX6azeutb4NS6ZUByytKiKkM26pfuje/sD9071Fk03zj/8DW
         ugY9d7vBfXLl+dTsXgP9/vnDHAn5oSQE239n7Q0MTuRPCfxVUQxgld9zTNccrIJc65qp
         5piVvA0YLMtBgC3K2i7dfknTxba5Vu315EDTKCGpnxfJFg8d+OxR8sOyNwdBQedoE6K+
         wNoXax2eMq8GqKJqJyV8R7UO8oXQRUj3ngNlLP8CS10ZVleME6DJfFr/Kpfa4ipnGrlk
         i/rw==
X-Forwarded-Encrypted: i=1; AJvYcCXIjwr86wZsQzSjvDMqraJXj2HnSgMr35KNq/AXpQEVMnzB9+CPFv3c+PDA1ruGx8u5qzTyCKWMdkqT6UDtN1T8Hoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhS24clbcSKNdIjI4Pkoz9LHQP6m+ZRtB+fb/5dChpbWUaQswF
	8XZtzlZrs2db/6CvW9qTZ0dDnocx+RixcllibNOR7r2ZscWUUw0w8XKn
X-Gm-Gg: ASbGncsVjnva9+UjgRnOLUX8WSD7z6Gs2dC3vW532ci3GdXr+DYH9SVa0TfqjaduFO1
	AnJSxV4Q3MKef0NLB8HVFaWMS51IWdRTanzQ7cg0lhMj14P82RgFaE+1hC13/i3MwQhfAk46YAi
	IiiBfZ+9oUm7JdNSZFSUx95YP71JyJSKFP39JXSicmAr2ZGkJJyIcskrieWJ1W5X58Gwo7ueKqX
	RW00pajqxyAp+fPfTEZeWSk/QeD2cRoDOSexevHziFmLCtngn2fk0Q7WfHqOpcXzate2+IwLsRJ
	mPBysxax0DMkNGumbBXoI6MxZwkYY3K6x4KkRYeytdc8VIGixRyyufzlS3WoYlFN1QtKq9X23CM
	MkY0xCJ5Cqjl3Zq6c69fhdfx33oPwrsKy04FbR1dkoSpZS59+Z2YHPsVrnKFYcrlT8qaExCrys8
	LkzsQ+QzbO0wk=
X-Google-Smtp-Source: AGHT+IHLeC9ZWRL2VLtRiE54fQ6H+bxg9/eru6ZBoKg3v7IDmaLDmUU9coK6XPoveKCEmhT4BZJJbA==
X-Received: by 2002:aa7:888c:0:b0:77f:2dc4:4c16 with SMTP id d2e1a72fcca58-7ba3be8c664mr17780783b3a.21.1763469421399;
        Tue, 18 Nov 2025 04:37:01 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b92772e7f2sm16331496b3a.57.2025.11.18.04.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 04:37:01 -0800 (PST)
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
Subject: [PATCH bpf-next v3 2/6] x86/ftrace: implement DYNAMIC_FTRACE_WITH_JMP
Date: Tue, 18 Nov 2025 20:36:30 +0800
Message-ID: <20251118123639.688444-3-dongml2@chinatelecom.cn>
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

Implement the DYNAMIC_FTRACE_WITH_JMP for x86_64. In ftrace_call_replace,
we will use JMP32_INSN_OPCODE instead of CALL_INSN_OPCODE if the address
should use "jmp".

Meanwhile, adjust the direct call in the ftrace_regs_caller. The RSB is
balanced in the "jmp" mode. Take the function "foo" for example:

 original_caller:
 call foo -> foo:
         call fentry -> fentry:
                 [do ftrace callbacks ]
                 move tramp_addr to stack
                 RET -> tramp_addr
                         tramp_addr:
                         [..]
                         call foo_body -> foo_body:
                                 [..]
                                 RET -> back to tramp_addr
                         [..]
                         RET -> back to original_caller

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 arch/x86/Kconfig            |  1 +
 arch/x86/kernel/ftrace.c    |  7 ++++++-
 arch/x86/kernel/ftrace_64.S | 12 +++++++++++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fa3b616af03a..462250a20311 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -230,6 +230,7 @@ config X86
 	select HAVE_DYNAMIC_FTRACE_WITH_ARGS	if X86_64
 	select HAVE_FTRACE_REGS_HAVING_PT_REGS	if X86_64
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	select HAVE_DYNAMIC_FTRACE_WITH_JMP	if X86_64
 	select HAVE_SAMPLE_FTRACE_DIRECT	if X86_64
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if X86_64
 	select HAVE_EBPF_JIT
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 4450acec9390..0543b57f54ee 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -74,7 +74,12 @@ static const char *ftrace_call_replace(unsigned long ip, unsigned long addr)
 	 * No need to translate into a callthunk. The trampoline does
 	 * the depth accounting itself.
 	 */
-	return text_gen_insn(CALL_INSN_OPCODE, (void *)ip, (void *)addr);
+	if (ftrace_is_jmp(addr)) {
+		addr = ftrace_jmp_get(addr);
+		return text_gen_insn(JMP32_INSN_OPCODE, (void *)ip, (void *)addr);
+	} else {
+		return text_gen_insn(CALL_INSN_OPCODE, (void *)ip, (void *)addr);
+	}
 }
 
 static int ftrace_verify_code(unsigned long ip, const char *old_code)
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 823dbdd0eb41..a132608265f6 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -285,8 +285,18 @@ SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
 	RET
 
+1:
+	testb	$1, %al
+	jz	2f
+	andq $0xfffffffffffffffe, %rax
+	movq %rax, MCOUNT_REG_SIZE+8(%rsp)
+	restore_mcount_regs
+	/* Restore flags */
+	popfq
+	RET
+
 	/* Swap the flags with orig_rax */
-1:	movq MCOUNT_REG_SIZE(%rsp), %rdi
+2:	movq MCOUNT_REG_SIZE(%rsp), %rdi
 	movq %rdi, MCOUNT_REG_SIZE-8(%rsp)
 	movq %rax, MCOUNT_REG_SIZE(%rsp)
 
-- 
2.51.2


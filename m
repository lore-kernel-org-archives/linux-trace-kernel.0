Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CFC307494
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Nov 2025 09:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112311; cv=none; b=NLnKfbuH3xfZnkJgkiJ50w0mhBx7A/CdbN38zn4DXezMhnoCQrKJpndkmbgkbuWt9XaS7jfc1vmoJ0eRMH88/ujIGcF9shH0/tjao2qtsqKLIoCkHVruAjHcoNpg0CF5Wu5qjIX++EUdREIzbaJ6K8ZUC0aXzqjHW2Y/2qzFjGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112311; c=relaxed/simple;
	bh=gokrqToajl3qLeodPuzcgSTB9cabw/WpaV1bSGQlVLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=id/elyztWrbU9k+uBm8eX7011Lk4iSyjlZQGgHxThwisYrXsCPUTQEkx8igAonQevR6BsLzCaNqHMzGa67WsMOi4hyTHlT34/7OBydd4d5BCn8VD+59xeKujgqmh/KPrxLpvyP8jenqsi2hDxZUQw5QlBPCZHqTJG3iAvQGsb8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjmZXHsv; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjmZXHsv"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-297f35be2ffso26551735ad.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Nov 2025 01:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763112309; x=1763717109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2wIn/kARIOhJ0xgPL8i1YkD6/QkhYtCyZijlaHlovw=;
        b=PjmZXHsvrHkZX1BfPdMHG1LHO+98ercxeRnouDfeem7fxEpj+PUhudvllYXeEuQ4/U
         FuT6ehPHuJspLMumi9AINBr1vPA2JVl8S2YQLy4FKYSZ6aSZF48ZLZofhFbvOxWJ/02/
         +LF+cz/cia+PdpH0TvPIjwx1CV4uiTfIsCQFIq2IyxzpsujoFwm6UWx/v2m/bqbzoJFD
         ef8XIhouSlk/N3xz6iEFvQuI/U3MjK0ieSITtEbufSq0P8QmdA9sZXuT4iTfOrlzLUnf
         IRfnShm2o5/zgstgFCRkgWEoI2RGObF7GMJB/d10XZX/TZdxprnqQrmgqzF73LpIXbOr
         +ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763112309; x=1763717109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c2wIn/kARIOhJ0xgPL8i1YkD6/QkhYtCyZijlaHlovw=;
        b=lha1hhwjjJXoeZFqbjFMXSEOaQPev8bj5LccRJlf1QPRx/YCOBAK+32g4sKG2ubo/c
         gibEURrvKDfC2aknPon0zJNeXT0gaWnYJvFM/gI1IZl5XmhD63EHjXVHtFSm1rJHsojn
         ciY1Acga/6f2BF/wfY4Xo3zKADkwgyrxNRyFCCJV0UfSnZr50rOz1zuxJDjLRWH/zK+a
         TlWK0CZMJrWyeVLAAjOC1DHEkBnw47WgW1hkX/LLfDvgw+4hXZ+2q7es/3Lw/0GHkJ6R
         00deEDfYcEgAg/9f1RXI57AcQpAGm2zFAs6HYb8E2N0WXX0YIEpKDG8yquybUlX7mCjQ
         x9Og==
X-Forwarded-Encrypted: i=1; AJvYcCXhT3+QgsVh56aUcqmz1UYy+DAWQaX/7eXG8r3Qz0VPmef+kGpqocBs6ZCvGX9mgujb1QtFqQG+j5dGcUA1f89QE+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjE8DvRDuDyseubkWUfugLCYdhPKsNEQI+ofFQfc1gNJM3s2Ay
	fF3aN4pBFsLXpFnJDlKKHv4kHvWpTA+GYe/Lc/zAl3Ow1ye0RHurnBv6
X-Gm-Gg: ASbGncvicrDe1Ja2goxvrjwoZK/4iiVn0a8uStGhZs86ix418KYDXYK7UAQHailRH2J
	hU7Ua44FqIWJb2FFDCEnEBAnXR/zDjumeZ2pwG8EucInTMkPJcK/I/+rDuS53qYZUx/x38GSbbE
	nvBl1UPfDHBj3KZpxtWm++s0Q/ZoIbsxmTfZCgAca4mdflRR6JB5JycYADfSZVI2LwqgZxzWKOA
	JzPtCRi/QjHWzISV8TcHqgxITuvEGSUZjesvAAD9Q0h0STAC++ILnQ12SWJ98Tbjr4/4uLE7wOx
	TZKW5xxLYTXWrOg4eMuE2hDkMqoqn/BBnipdP291JdxIRS1oMXAwot6s8ddBsViGUlWAuWrdOsj
	Dc7w6H6XNIB4jdrjmHDAxQ06VXBJLIzUmZDxsoF6doknhQJk76arHyJ2dsluXRhalmiPRAzvnF0
	Pn
X-Google-Smtp-Source: AGHT+IG5VnwBl+1lxPrp6qdos/kEJNYbsFAuD4akbBy67+ZoqlT1tPAQmEIH9GoRP72WFoHDwsjAMw==
X-Received: by 2002:a17:902:f60e:b0:290:c0ed:de42 with SMTP id d9443c01a7336-2986a7417b8mr26050145ad.36.1763112308699;
        Fri, 14 Nov 2025 01:25:08 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346dasm50451525ad.7.2025.11.14.01.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:25:08 -0800 (PST)
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
Subject: [PATCH RFC bpf-next 2/7] x86/ftrace: implement DYNAMIC_FTRACE_WITH_JMP
Date: Fri, 14 Nov 2025 17:24:45 +0800
Message-ID: <20251114092450.172024-3-dongml2@chinatelecom.cn>
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

Implement the DYNAMIC_FTRACE_WITH_JMP for x86_64. In ftrace_call_replace,
we will use JMP32_INSN_OPCODE instead of CALL_INSN_OPCODE if the address
should use "jmp".

Meanwhile, adjust the direct call in the ftrace_regs_caller.

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
index 367da3638167..068242e9c857 100644
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


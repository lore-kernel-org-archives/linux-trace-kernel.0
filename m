Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.249
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292988;
	b=fW4Re2ganRgJf/Hz9lRLXrUPu4Q6EcAnSl0TCv2xxWKkEQgL3NegESCr2zic9j8j+5mi
	 YvVqKQvievdwWZqLvQlnYgp07a1A/2ZeSEVlFnD1ag9o289E6zz9d2UY0SkfQvdUBucO9
	 nRUTw9pU01qMeqUt5xrhG2/cpqC3ACjP/TNy0noKr/qXBFEf5hgWML01AxUpAFbOBoocL
	 addS1HK8uqlK8lju+xS4k7SRIrjAkKGw+HbowP+uWysLH4+1g5XP3NKImdVkK0kUpc6TE
	 1s6pYoGfb5RfaZPWx/0aNV5ENsHIzCv/DQbHvdE/h1DzL4qodlc/HjFMYJZ7UltaRtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292988;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 X-Mailer:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=hua8r15V7TSjOPkP1LZ0fLVVfYG8l7xLUVsTAllRXFY=;
	b=t5aXkuL+2CxuI7YDrGCwz7GEXJOZ5AhrAByiJQiMGP3rmm1BvwtVqv/riNORoBG11kCj
	 MHQOmn4T2IPHtll07nY497WFcui4d/H2LZwXwuz/xcQF5BDR9tIf/L+VmuDNI1d1jYWui
	 6fylZZja+4FFKw9ZnbdEip+93f5TSJEzCxJD4L8EnCeM24R5g7/DWGAlSmLuRW7pZD0Tj
	 GOfTF/0wBQUJCd4O0hmIARmtHqqr/AkWFxYkyUXINj3ik5Yfoqvh0lbylnZkHReEFGSjy
	 zDtcxq4qNBPu4WcnbTlGzYpR+9gdqQyDpFZRGp5lhns7crYgPzxWzhxB3n8uyNHXBAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="SB/cbvIM";
	arc=none smtp.remote-ip=95.215.58.249
Received: from mta1.migadu.com (out-249.mta1.migadu.com [95.215.58.249])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726AD606A31D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Oct 2026 16:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 726AD606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SB/cbvIM
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=434KqqiFbfCjkA3irR1iRo73T1t1MZ/g1nUcxCwYWug=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793292984; v=1; x=1793897784;
 b=SB/cbvIMn8fzU93V1cumKiWJi/6yMseJcAkNuE388oSnCtAUPcNQMjh/nRWj0CVpivpLJWth
 RIqwr0VrtyfZOZmff6NIWBuxTRyMlKhoVTzYiwTMs7hVvryUM55oji7mRz4zEDc9EmseKRfnsAn
 cTPBg3NpRc0dH2aQ1fmRRR9c=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5d6b4a9e39e1a764;
	Thu, 29 Oct 2026 16:56:24 +0000
X-Mizu-Trace-ID: 5d6b4a9e39e1a764
X-Migadu-Flow: FLOW_OUT
Date: Thu, 29 Oct 2026 16:56:15 +0000
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
To: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Puranjay Mohan <puranjay@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>
Cc: Ben Cressey <ben@cressey.dev>, 
	Florent Revest <florent.revest@linux.dev>, Bill Wendling <morbo@google.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Subject: [PATCH v3 4/7] arm64: cfi: Use CONFIG_ARM64_FUNCTION_PREFIX_NOPS for
 the type hash offset
Message-ID: <20261029-b4-arm64-callops-kcfi-v3-4-1b011ad5ddec@linux.dev>
X-Mailer: b4 0.15.2
References: <20261029-b4-arm64-callops-kcfi-v3-0-1b011ad5ddec@linux.dev>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-b4-arm64-callops-kcfi-v3-0-1b011ad5ddec@linux.dev>

Make cfi_get_offset(), SYM_TYPED_FUNC_START and the BPF JIT use
CONFIG_ARM64_FUNCTION_PREFIX_NOPS instead of hardcoding four bytes. kCFI
kernels with CALL_OPS need three NOPs, or five with ThinLTO and BTI.

CONFIG_ARM64_FUNCTION_PREFIX_NOPS is 0 on every CFI kernel today, so no
functional change.

Reviewed-by: Ben Cressey <ben@cressey.dev>
Reviewed-by: Florent Revest (Anthropic) <florent.revest@linux.dev>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Assisted-by: LLM
Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
---
 arch/arm64/include/asm/cfi.h     | 11 +++++++++++
 arch/arm64/include/asm/linkage.h | 11 +++++++++++
 arch/arm64/net/bpf_jit_comp.c    |  8 ++++++--
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cfi.h b/arch/arm64/include/asm/cfi.h
index ab90f0351b7a..f3c04a2a6a95 100644
--- a/arch/arm64/include/asm/cfi.h
+++ b/arch/arm64/include/asm/cfi.h
@@ -2,6 +2,17 @@
 #ifndef _ASM_ARM64_CFI_H
 #define _ASM_ARM64_CFI_H
 
+#include <asm/insn-def.h>
+
 #define __bpfcall
 
+#ifdef CONFIG_CFI
+static inline int cfi_get_offset(void)
+{
+	/* The 4-byte type hash sits before the prefix NOPs. */
+	return 4 + CONFIG_ARM64_FUNCTION_PREFIX_NOPS * AARCH64_INSN_SIZE;
+}
+#define cfi_get_offset cfi_get_offset
+#endif /* CONFIG_CFI */
+
 #endif /* _ASM_ARM64_CFI_H */
diff --git a/arch/arm64/include/asm/linkage.h b/arch/arm64/include/asm/linkage.h
index d1f7a16729d2..14bc3c67c38b 100644
--- a/arch/arm64/include/asm/linkage.h
+++ b/arch/arm64/include/asm/linkage.h
@@ -39,6 +39,17 @@
 	SYM_START(name, SYM_L_WEAK, SYM_A_NONE)		\
 	bti c ;
 
+/*
+ * The compiler emits CONFIG_ARM64_FUNCTION_PREFIX_NOPS NOPs between a C
+ * function's kCFI type hash and its entry point. Callers check the hash
+ * at that offset.
+ */
+#define __CFI_TYPE(name)				\
+	.4byte __kcfi_typeid_##name ASM_NL		\
+	.rept CONFIG_ARM64_FUNCTION_PREFIX_NOPS ASM_NL	\
+	nop ASM_NL					\
+	.endr
+
 #define SYM_TYPED_FUNC_START(name)				\
 	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
 	bti c ;
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index aaa34c739004..42cb2d446680 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -185,8 +185,12 @@ static inline void emit_bti(u32 insn, struct jit_ctx *ctx)
 
 static inline void emit_kcfi(u32 hash, struct jit_ctx *ctx)
 {
-	if (IS_ENABLED(CONFIG_CFI))
-		emit_u32_data(hash, ctx);
+	if (!IS_ENABLED(CONFIG_CFI))
+		return;
+
+	emit_u32_data(hash, ctx);
+	for (int i = 0; i < CONFIG_ARM64_FUNCTION_PREFIX_NOPS; i++)
+		emit(A64_NOP, ctx);
 }
 
 /*

-- 
2.54.0


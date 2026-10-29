Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292851;
	b=Cvc2/aRsvlaVPPszPEOhXl3+PmSRYm+m16fgpjKKkPRxw4p7YsUkUIFFeuOs6kU6UZIi
	 qshEl8Q7LLVEXSf/s9VmAYGvpPY5tGfxjsSSt/NsTfdOnF55ltbU5gPPheLl+Etn6Ib4M
	 q48si8oHEB5WfuqtAr484jFtjGSqVvfQSHOGzSaL2oaVDzgt5tSv4L7WcKqcnOjvrE8q8
	 0OCvoGZPpNc3ehaFaWWE/KXlqV5rRohLEsXtilO38kQr9oLJF0W0al3Gh9WZvRDG07cgn
	 z2xvhRyIRY9kjGZNsrEanlchfeKCDtn5lQfbGrRN+Vbq6WggY1Bvqp+t13mmr4GJqMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292851;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 X-Mailer:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=KoCxuWWjDP1yVw1HvFaevXnQ4QC4h2u92EWwxCuPW/M=;
	b=tYDpbweEV5vrL6QCLyxj9Q6kk+H9V6AOeYFE0ZzU4Y+yJgpOd20/5pegxkqrtFFi/TjX
	 oyWQkkUO3/3dGDeHMHROb/GkeY7G3RidYoSbOjajcLY/3SBpGa4c2Tq4DEjouPgAOZtxw
	 vOjcRGfy0ErkTgIOv5Xcpo66gO7XVJjrv14OAIc5Z0pxSrSI0vhKGuZq7JC1h053hzVUv
	 MhIO266yj/jwtLY+TbRIiDmdVl+seBO3Kg9jChE/Kv/qlDQO7R8mlh/x1+BMFsHPwtHoy
	 ec/fnQsmmUtsLx8rsy+mnPJ7/HAMj4Es8FcX2IFw7Rq8L3wXuZJghV6wHMXeTf20EzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vCOPi+h3;
	arc=none smtp.remote-ip=95.215.58.139
Received: from mta1.migadu.com (out-139.mta1.migadu.com [95.215.58.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B53606A31F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Oct 2026 16:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4B53606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vCOPi+h3
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rJ+GI9mSP2GAsgikWKRz/p+K9ZdSdVmHlMdYCh8VOxs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793292848; v=1; x=1793897648;
 b=vCOPi+h3/w82WpiXHz0zE3rAAaGy+86ZBfSAdzsRo1HBYBk2gX0IEAK8OR+Lm9gArPg1JM4P
 34VSu8O/CaQATdBIgkue7OUEEzq/995EO38CEGNpPrh8cL9dJuv7nsBOwd9yWvzmum2GcOy63v7
 4gvhuB3uhRa15U8dRQRe2M+g=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 66c164750fba40cd;
	Thu, 29 Oct 2026 16:54:07 +0000
X-Mizu-Trace-ID: 66c164750fba40cd
X-Migadu-Flow: FLOW_OUT
Date: Thu, 29 Oct 2026 16:53:58 +0000
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
Subject: [PATCH v3 1/7] scripts/sorttable: Make the arm64 before_func offset
 configurable
Message-ID: <20261029-b4-arm64-callops-kcfi-v3-1-1b011ad5ddec@linux.dev>
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

sorttable hardcodes before_func to 8 bytes on arm64 (two prefix NOPs).
Make it configurable from CONFIG_ARM64_FUNCTION_PREFIX_NOPS instead.
kCFI kernels with CALL_OPS need three NOPs. The symbol does not exist
yet, so no functional change.

Reviewed-by: Ben Cressey <ben@cressey.dev>
Reviewed-by: Florent Revest (Anthropic) <florent.revest@linux.dev>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Assisted-by: LLM
Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
---
 scripts/Makefile    | 4 ++++
 scripts/sorttable.c | 7 ++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile b/scripts/Makefile
index d7fbb7ca098b..7ef1c84cf79d 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -54,6 +54,10 @@ endif
 
 ifdef CONFIG_BUILDTIME_MCOUNT_SORT
 HOSTCFLAGS_sorttable.o += -DMCOUNT_SORT_ENABLED
+# 0 or unset (no prefix NOPs) leaves sorttable's built-in default in place.
+ifneq ($(filter-out 0,$(CONFIG_ARM64_FUNCTION_PREFIX_NOPS)),)
+HOSTCFLAGS_sorttable.o += -DFUNCTION_PREFIX_BYTES=$(shell expr 4 \* $(CONFIG_ARM64_FUNCTION_PREFIX_NOPS))
+endif
 endif
 
 hostprogs += gen_init_cpio
diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 88e49a5c4251..2e951f2f60e8 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -281,6 +281,11 @@ static int add_field(uint64_t addr, uint64_t size)
 /* Used for when mcount/fentry is before the function entry */
 static int before_func;
 
+/* How far before the function entry a patchable entry may be recorded */
+#ifndef FUNCTION_PREFIX_BYTES
+#define FUNCTION_PREFIX_BYTES	8
+#endif
+
 /* Only return match if the address lies inside the function size */
 static int cmp_func_addr(const void *K, const void *A)
 {
@@ -912,7 +917,7 @@ static int do_file(char const *const fname, void *addr)
 		/* fallthrough */
 	case EM_RISCV:
 		/* arm64 and RISC-V place patchable entries before the function. */
-		before_func = 8;
+		before_func = FUNCTION_PREFIX_BYTES;
 #else
 	case EM_AARCH64:
 	case EM_RISCV:

-- 
2.54.0


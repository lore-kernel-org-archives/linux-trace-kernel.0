Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.107
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292904;
	b=aa2T5M6UXlr5aysUpWtofM2tl+couEqjFgUsMNyGqvlv6G72nGCz+G9Dfby3dEdanWWQ
	 yxJNvkxSCje+MdgeJVhD71+YHLpy99chpPAhy6rEqL1O/toJ2lKqOAycyyCMBY14rstZC
	 BROC5pLRjomOBNN6HKm/p+T4AIqTVItl7P4SIznEncJc5AxU5Ek4w5Ds07KBwcqCDGXpS
	 rxSPJuz1v2Rxn3ERnFKGQmh1+Lcfzt0cKd7FO+uRVSijQ2x4RbdThyGP3djcH9kQGUFTQ
	 oOP1qj7dFoET5AETQTwXhr+BRFzIWbqpXdLS/on6ZMLWhSTcMHVnANW6G92yR5REhLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292904;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 X-Mailer:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=EfJ0KxzbqIuij0yRGv6RKskmiOg7DtOrzfgh1If9ul4=;
	b=l1GO+6QWZratC7NtT8Z8GmopxbJWcbKhyUUdwunXat1QxenzzVS505bRKOIKM96bQsg0
	 zl8N6MCLCW+l3txlpvP1+TcLTVJM1PMmX2r1EcwGVHz8UbcOpnWXHeNrlnFDOEs5VjxdI
	 by98ngdUl5HmSI2cnVBBXWv1gZTE2uXUCbukxaNm9ZUlw1Pl5QbViYBY5xhAwGlNr+39n
	 NoS34ijb7X/cizqJmMW6JDC7ocPYRVr9O0qThya4V0h/ZWkxilFsb4GQyPjAmCNjwFXvJ
	 HGFBqTQPCWG7Qsks5bm7Qv52ORaHjBkLlirZ+vPd+67kTU5mncMbQ0vm3yzWD9caMRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fKHFCO3I;
	arc=none smtp.remote-ip=91.218.175.107
Received: from mta0.migadu.com (out-107.mta0.migadu.com [91.218.175.107])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC991606A31E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Oct 2026 16:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC991606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fKHFCO3I
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=MWQsoPirKRzLtu5mUH+dnsV+vc6wl756TnIvbej6NSU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793292901; v=1; x=1793897701;
 b=fKHFCO3IcYVv8q26Kb1NguVMFyph5lYZG2bFWdznGCvA+zImJOH5ACCK4sWtGZauxR3cqfoA
 QvDDfk4NNQQbd11T+wrJcZBc+o1WVEOj9nhcr2so6cx7vHREk6fI4GjZfzFdFtXXL0OlVwK+O/g
 uUaawWkr792DIeEup3IuXqFg=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6b12b908b1c5348a;
	Thu, 29 Oct 2026 16:55:00 +0000
X-Mizu-Trace-ID: 6b12b908b1c5348a
X-Migadu-Flow: FLOW_OUT
Date: Thu, 29 Oct 2026 16:54:51 +0000
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
Subject: [PATCH v3 2/7] compiler_types: Let notrace keep the function prefix
 NOPs
Message-ID: <20261029-b4-arm64-callops-kcfi-v3-2-1b011ad5ddec@linux.dev>
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

Let notrace keep the prefix NOPs when the architecture defines
CC_USING_PATCHABLE_FUNCTION_PREFIX. kCFI callers check the type hash
at a fixed offset before the entry point, so a notrace function needs
the same prefix NOPs as any other. Record the entry in a section the
linker drops, so ftrace never sees it. Clang 21 takes a section name
as a third argument of the attribute. Nothing defines the macro yet,
so no functional change.

Reviewed-by: Ben Cressey <ben@cressey.dev>
Reviewed-by: Florent Revest (Anthropic) <florent.revest@linux.dev>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Assisted-by: LLM
Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
---
 include/linux/compiler_types.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index c5921f139007..43dafaa06194 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -211,6 +211,15 @@ struct ftrace_likely_data {
 
 #if defined(CC_USING_HOTPATCH)
 #define notrace			__attribute__((hotpatch(0, 0)))
+#elif defined(CC_USING_PATCHABLE_FUNCTION_PREFIX) && !defined(__BINDGEN__)
+/*
+ * Not for bindgen: its libclang may not support the section argument
+ * (Clang >= 21), and leaving the attribute out does not change the ABI.
+ */
+#define notrace								\
+	__attribute__((patchable_function_entry(CC_USING_PATCHABLE_FUNCTION_PREFIX, \
+						 CC_USING_PATCHABLE_FUNCTION_PREFIX, \
+						 ".discard.patchable_function_entries")))
 #elif defined(CC_USING_PATCHABLE_FUNCTION_ENTRY)
 #define notrace			__attribute__((patchable_function_entry(0, 0)))
 #else

-- 
2.54.0


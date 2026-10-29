Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.201
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793293072;
	b=sImeJDz9F+KBQf1ASOI8UDdKKgPfrlMLD1+S3ZIOknr6sVZrlkNOZ4QvUvy5puIphbGG
	 eviRMBh2jcaQnkqXppInXulND/93y3OnCMVDX/PB12cqADnh0t01gsnCwOvCv856szd4q
	 ZayM9vYjSTYlmi/VT2f3klCY1b0+xRTYw38J2jMepTKlRqDzMprKx4uelSl85U0gOgEXn
	 3tQZpRjuYfgZyTf6WrcixnYlV9lV5bCnSKeh2szCWPxtbvhv1gSVUFGvCm6ecRUPZDXa5
	 iBO3WBHkSXIkQ8cnFe/si5ZjFYY+LEQ/4SWYvYewhXNjdo/P2tWsxP8F8XL9gJHKMGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293072;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 X-Mailer:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=qS+HEkR0vDGWLdjeSo4joCKjj6Y1JdTXkJiDIbjQdvo=;
	b=BN94ilGuykXgLfU29Bk+Af9XqK4iKtWe15MErVei74u//UKZmMYgOiijn6yEM6PX8Jqa
	 9vvITCdXb1/FGbFUZlp82yrQuE/UFrTVjco/54UmGJvnwduiz/BW89x1fExTYQMeNrp9y
	 1Xh17DtbizcDZVCarfGH0fgfcf9SH5x/HSeDGJs5GzlEkMrzSCGAfayZdVFK4lhQqUpGy
	 TrYGojXCLyDNIdVjD9+hZVqosSWyDKeo6n94hzvhlLjMaM0RCH85F7CeGOUrwSVbfxzv+
	 1TCWEYuD28ftvs75p/pk1k29WrL354WtJslB285rfCNqolZ9fGSjVmwBjTXRWp2ItLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DJJ6of28;
	arc=none smtp.remote-ip=91.218.175.201
Received: from mta0.migadu.com (out-201.mta0.migadu.com [91.218.175.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEAE606A339
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Oct 2026 16:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CEAE606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DJJ6of28
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CAYOtMfAj2CKhNyLkHjEGE+Ku1FgcGL4RmYNUgnppcs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793293069; v=1; x=1793897869;
 b=DJJ6of28Sv53LKrKVpHYxU8UvNo/3F/LAeH/M2sEW9rTsJBNEGzpOMrVf+DGC8Jpnn1d1qIY
 pURL1Sanj3w5ARUiBNlp5LIY8SPvHaXCvGproA52siS7rf7jNznJbk7JMCDIdmOjn7E385Z+Kds
 cLAewYbrHlWZPtgNnjh4mX3A=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b8a209880955641a;
	Thu, 29 Oct 2026 16:57:49 +0000
X-Mizu-Trace-ID: b8a209880955641a
X-Migadu-Flow: FLOW_OUT
Date: Thu, 29 Oct 2026 16:57:38 +0000
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
Subject: [PATCH v3 7/7] arm64: ftrace: Allow CALL_OPS on kCFI kernels built
 with Rust
Message-ID: <20261029-b4-arm64-callops-kcfi-v3-7-1b011ad5ddec@linux.dev>
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

Pass -Zpatchable-function-entry=M,M,.discard.patchable_function_entries
to rustc when CFI and CALL_OPS are both enabled, so Rust functions get
the same prefix NOPs as C functions. The section argument needs
Rust 1.98 [1]. Probe for it, and let ARM64_CFI_PERMITS_CALL_OPS
accept RUST=y when the probe passes.

Filter -fpatchable-function-entry out of bindgen's C flags on every
architecture, not only on arm64 with CFI, since removing the flag does
not change the ABI.

[1] https://github.com/rust-lang/rust/pull/157445

Suggested-by: Ben Cressey <ben@cressey.dev>
Reviewed-by: Ben Cressey <ben@cressey.dev>
Reviewed-by: Florent Revest (Anthropic) <florent.revest@linux.dev>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Assisted-by: LLM
Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
---
 arch/arm64/Kconfig  | 7 ++++++-
 arch/arm64/Makefile | 3 +++
 rust/Makefile       | 7 ++++++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e8cb44d881d0..e64d053e1854 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -277,11 +277,16 @@ config CC_HAS_PATCHABLE_FUNCTION_ENTRY_SECTION
 	# https://github.com/llvm/llvm-project/pull/131230
 	def_bool $(cc-option,-fpatchable-function-entry=1$(comma)1$(comma).discard.patchable_function_entries)
 
+config RUSTC_HAS_PATCHABLE_FUNCTION_ENTRY_SECTION
+	# The section argument needs Rust 1.98.0 or later:
+	# https://github.com/rust-lang/rust/pull/157445
+	def_bool $(rustc-option,-Zpatchable-function-entry=1$(comma)1$(comma).discard.patchable_function_entries)
+
 config ARM64_CFI_PERMITS_CALL_OPS
 	def_bool y
 	depends on CFI
 	depends on CC_HAS_PATCHABLE_FUNCTION_ENTRY_SECTION
-	depends on !RUST
+	depends on !RUST || RUSTC_HAS_PATCHABLE_FUNCTION_ENTRY_SECTION
 
 config ARM64_FUNCTION_PREFIX_NOPS
 	int
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 9fbfe5ab3724..b47733b585b5 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -147,6 +147,9 @@ ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS),y)
 			 -DCC_USING_PATCHABLE_FUNCTION_PREFIX=$(prefix_nops)
     KBUILD_CFLAGS += $(CFI_PREFIX_CFLAGS)
     export CFI_PREFIX_CFLAGS
+    # Rust functions are not patched by ftrace, but they are called indirectly
+    # from C and make indirect calls themselves, so they need the same prefix.
+    KBUILD_RUSTFLAGS += -Zpatchable-function-entry=$(prefix_nops),$(prefix_nops),.discard.patchable_function_entries
   endif
 else ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_ARGS),y)
   KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
diff --git a/rust/Makefile b/rust/Makefile
index 0ac9ab28cc2b..686964c826f7 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -511,7 +511,12 @@ endif
 # prototypes for functions like `memcpy` -- if this flag is not passed,
 # `bindgen`-generated prototypes use `c_ulong` or `c_uint` depending on
 # architecture instead of generating `usize`.
-bindgen_c_flags_final = $(bindgen_c_flags_lto) -fno-builtin -D__BINDGEN__
+#
+# Do not pass -fpatchable-function-entry to bindgen: its libclang may not
+# support the section argument (Clang >= 21), and removing the flag does not
+# change the ABI.
+bindgen_c_flags_final = $(filter-out -fpatchable-function-entry=%, \
+	$(bindgen_c_flags_lto)) -fno-builtin -D__BINDGEN__
 
 # `--rust-target` points to our minimum supported Rust version.
 quiet_cmd_bindgen = BINDGEN $@

-- 
2.54.0


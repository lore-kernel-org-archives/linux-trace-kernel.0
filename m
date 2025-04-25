Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AFB7483;
	Fri, 25 Apr 2025 02:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745548705; cv=none; b=LrNE+EY8dAql1abC/E5kP8ouAGXYXZJOSmkTPxtz5h8779FPm4YOp0WIZWoqdG6P+ZA8RGf+vUW6LLOaHem2V4hpMUJtO/VGEHtfunSk23qpYC8d16uIhz2KEyr2ozzJdvkU9sKYmF7HMXwOqmKaAOlT343T18Zipg0JAMbQ/pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745548705; c=relaxed/simple;
	bh=QhCwiPnd0gPBrQvImDQRKzcjy0jlFgvpErnwXkD5KI4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rP4QCDPsA+YvLbfOKwQj0Q0I95BErdt/U5beEbERGmvKiDC3tfHQfrtCcMQlJLlNYc8bYOgrPeYIKS7qB5Qx21Gutl4RDs+xR7zonlMNl/VyP+lXwfiGT85RGcmCxGcxMiEqtRna2vJb7uDL7SbDSQNKhzOAnDZJkx+vw16/0UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB1BC4CEE3;
	Fri, 25 Apr 2025 02:38:25 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u88zG-0000000HC6x-1uWl;
	Thu, 24 Apr 2025 22:40:22 -0400
Message-ID: <20250425024022.303823947@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 24 Apr 2025 22:37:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Jens Remus <jremus@linux.ibm.com>,
 x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/6] x86/vdso: Fix DWARF generation for getrandom()
References: <20250425023750.669174660@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

Add CFI annotations to the VDSO implementation of getrandom() so it will
have valid DWARF unwinding metadata.

Fixes: 33385150ac45 ("x86: vdso: Wire up getrandom() vDSO implementation")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/x86/entry/vdso/vgetrandom-chacha.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/vgetrandom-chacha.S b/arch/x86/entry/vdso/vgetrandom-chacha.S
index bcba5639b8ee..cc82da9216fb 100644
--- a/arch/x86/entry/vdso/vgetrandom-chacha.S
+++ b/arch/x86/entry/vdso/vgetrandom-chacha.S
@@ -4,7 +4,7 @@
  */
 
 #include <linux/linkage.h>
-#include <asm/frame.h>
+#include <asm/dwarf2.h>
 
 .section	.rodata, "a"
 .align 16
@@ -22,7 +22,7 @@ CONSTANTS:	.octa 0x6b20657479622d323320646e61707865
  *	rcx: number of 64-byte blocks to write to output
  */
 SYM_FUNC_START(__arch_chacha20_blocks_nostack)
-
+	CFI_STARTPROC
 .set	output,		%rdi
 .set	key,		%rsi
 .set	counter,	%rdx
@@ -175,4 +175,5 @@ SYM_FUNC_START(__arch_chacha20_blocks_nostack)
 	pxor		temp,temp
 
 	ret
+	CFI_ENDPROC
 SYM_FUNC_END(__arch_chacha20_blocks_nostack)
-- 
2.47.2



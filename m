Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795402059;
	b=uK0eaNYdSNWZLdx3NcwCAsckZUBNYseYZM+wl2JRCoVW9QAHRU+R4/bt1gVWq1EKtECi
	 Bq+1RknaUbzBs8bSDA0EqbPYC7HjdcQpQV5RPMPf5Q7Jc6fAut2dI0ta0VJZ0IezJBtAu
	 D6ouwxZggOfEVlLC8UIn3zcQMdyzkjQbHN3cK0lWDwMcWqPYxU2ER79+zF+3ONCs+6X99
	 8cXV3nK0xKSKlHPCr9dXfg53EhzjvJDFIZw3P9qg/06f1IyNXv45Efy6yQmjhR+naZ4ho
	 6UiKZb96pgyFyh+LApnNaMJUctHVvf3WLpGv5ss4AVqj2wZJRHhWn0Cg1yzWB/J2vlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795402059;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4NgAHlgiACfP9WNr97wsTdXrW6wyD1bio75846g2GlU=;
	b=zht2sLBLZ+CANL7pTzWqb/8/pnCKyF75QLJAPZjxA5P8nPUyYrHMx+MGyqAJMoL2U9mz
	 M8xdD2Bw3O/3R3ZqD663YZKIFL/4v92refcJJSbkFU+iZ5kbp+BO4KpNi3qDKvJJNfYOK
	 M++GztavIt9JMl6ywg0HYDLNEENOqVeLRqvquIY+OMN2S+ScNFMe/gZVNuNGh23PchKlt
	 kdPZMmgGwIt0Aca4HO7PT1ciPqd1ZiWnuxfC6lU14k1JNDAjg7vdge2IAjXcdkOSe1pEX
	 SnDBp9FaylOxtGHBrWVlzhCBhazd2RrZridUhbeSf8eaExmo+ezeyEOmmw1rYDSzWdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MsoHMHYP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19483606A31E;
	Mon, 23 Nov 2026 02:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MsoHMHYP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753CB1F000C6;
	Mon, 23 Nov 2026 02:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795402058;
	bh=4NgAHlgiACfP9WNr97wsTdXrW6wyD1bio75846g2GlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MsoHMHYPlxhuXmneGllAp7IwF/VK4DRYJ9PkX1XgI8gZd9sN4zSllozH3f8voZ3Sr
	 yUR2TlR4kDenYjf1hIgtZ8TPQdTMmMM7k8O87vKWfjajXjhujv2c89ZaJsG0S0izG8
	 oyLOcrY8RiFXlgLmPUGdMqN37LjlHxayqpVU7UBNJy+I5GTN1y5u7s8Ens+KNreyhH
	 keP8gEFt9ELyTxm0M+vNE6VzJPd/RgWnUytjBEEf14seMhaK3ztpPxBqiI3uJHX0xV
	 kWeW6azize8vFSi62GgXnajLSnEyADJl9NRwZjGVMDathNxEGdm8In9q0aXE45TBzu
	 VmBp5F/Jlj3EA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Lukas Zobernig <lukas.zobernig@gmail.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Pablo Fraile Alonso <pablo@pablofraile.net>,
	Edgecombe Rick P <rick.p.edgecombe@intel.com>
Subject: [PATCH 2/5] x86/insn: Fix gen-insn-attr-x86.awk to emit INAT_REX2_VARIANT
Date: Mon, 23 Nov 2026 11:47:33 +0900
Message-ID: <179540205326.233843.2135456283107403299.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179540203033.233843.12951034848925983867.stgit@devnote2>
References: <179540203033.233843.12951034848925983867.stgit@devnote2>
User-Agent: StGit/0.19
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu <mhiramat@kernel.org>

In gen-insn-attr-x86.awk, the check for the (REX2) superscript tag was
placed after 'if (length(flags) == 0) continue'. For opcode 0xa1
('MOV rAX,Ov (!REX2) | JMPABS O (REX2),(o64)'), the JMPABS alternative
has no flags set by convert_operands(), so the loop skipped before
emitting INAT_REX2_VARIANT and no entry in inat-tables.c ever received
INAT_REX2_VARIANT.

Move the rex2_expr check before the empty-flags skip so INAT_REX2_VARIANT
is properly added to flags and emitted in inat-tables.c.

Fixes: eada38d575a2 ("x86/insn: Add support for REX2 prefix to the instruction decoder logic")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/x86/tools/gen-insn-attr-x86.awk       |    6 ++++--
 tools/arch/x86/tools/gen-insn-attr-x86.awk |    6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/tools/gen-insn-attr-x86.awk b/arch/x86/tools/gen-insn-attr-x86.awk
index 7ea1b75e59b7..186506a3db22 100644
--- a/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/arch/x86/tools/gen-insn-attr-x86.awk
@@ -354,6 +354,10 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 		if (match(ext, no_rex2_expr))
 			flags = add_flags(flags, "INAT_NO_REX2")
 
+		# check REX2 variant
+		if (match(ext, rex2_expr))
+			flags = add_flags(flags, "INAT_REX2_VARIANT")
+
 		# check REX prefix
 		if (match(opcode, rex_expr))
 			flags = add_flags(flags, "INAT_MAKE_PREFIX(INAT_PFX_REX)")
@@ -395,8 +399,6 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 			lptable3[idx] = add_flags(lptable3[idx],flags)
 			variant = "INAT_VARIANT"
 		}
-		if (match(ext, rex2_expr))
-			table[idx] = add_flags(table[idx], "INAT_REX2_VARIANT")
 		if (!match(ext, lprefix_expr)){
 			table[idx] = add_flags(table[idx],flags)
 		}
diff --git a/tools/arch/x86/tools/gen-insn-attr-x86.awk b/tools/arch/x86/tools/gen-insn-attr-x86.awk
index 7ea1b75e59b7..186506a3db22 100644
--- a/tools/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/tools/arch/x86/tools/gen-insn-attr-x86.awk
@@ -354,6 +354,10 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 		if (match(ext, no_rex2_expr))
 			flags = add_flags(flags, "INAT_NO_REX2")
 
+		# check REX2 variant
+		if (match(ext, rex2_expr))
+			flags = add_flags(flags, "INAT_REX2_VARIANT")
+
 		# check REX prefix
 		if (match(opcode, rex_expr))
 			flags = add_flags(flags, "INAT_MAKE_PREFIX(INAT_PFX_REX)")
@@ -395,8 +399,6 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 			lptable3[idx] = add_flags(lptable3[idx],flags)
 			variant = "INAT_VARIANT"
 		}
-		if (match(ext, rex2_expr))
-			table[idx] = add_flags(table[idx], "INAT_REX2_VARIANT")
 		if (!match(ext, lprefix_expr)){
 			table[idx] = add_flags(table[idx],flags)
 		}


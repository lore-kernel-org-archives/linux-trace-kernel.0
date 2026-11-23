Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472630;
	b=jwRIRLCgmfYmQrEUJ+d83wV1EZiggATvH0d62ltoe5/9uVan0xcBE9iKgKXlt2OwgK31
	 Csp6r0/oBqd0s10kC5DYBusy53ZwCM7P037qZ1N5xy27Ze9tv+IGuAOg4PylTKXyAZl1G
	 LlI9jLm11579W2RVbSppwQvdqZuQtCF9gZehTrslxEQsQr3WjkT0NH7FtRFxYndW9fV8i
	 ZdHNfYgzh4JN5tczKl784n2PgICQYRC7pv5CLGmgzW+iVYTexYcnBUQgPZWjyyMtY1BMC
	 SG8zmWT8Tqr4+3VHREENPFlCzxfER6tj+tR0a7Ar4oresPT4qNYIMdXpsaYcQXMVLxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472630;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4NgAHlgiACfP9WNr97wsTdXrW6wyD1bio75846g2GlU=;
	b=lZU12NXqVJSVE/NaoqYPBXJF2zFqk6z4rF56RTot5dEEkVoMflLRZFQ8QLr2DiCCXxhG
	 HO3S/Rj88Kavz0HXZtvwpKyiCjoRnPkEZBaMxce3DOi0SWxj3pmNl11eSH8hdIb1vAw59
	 w/EtYkrCMvu4jB4b1YjNtFSpeDjOy3l8vc/CPQMks31oOCSNcppftzJU0+qqad+oV9/4+
	 mo4KXw+8TCBbdtz1+M/n9Fq8VQ5KR3EfLuDRVHPO8jQRIwdYFj94ozsZoZjeUfS3Desw1
	 Q81MqYye28uzFRIS9qJFygbYfk+pU6613y016D0PI3EY9pTWhUe4EbPtOE2FLgC6nWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bp/4FdGS";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DCC606A31E;
	Mon, 23 Nov 2026 22:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bp/4FdGS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFFE1F000C6;
	Mon, 23 Nov 2026 22:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795472629;
	bh=4NgAHlgiACfP9WNr97wsTdXrW6wyD1bio75846g2GlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bp/4FdGSMwoiUia8GIG3WWWmTcVgZzRRXFpG+Eub+X2bSSd/NMlHVmcSucPH5CMGE
	 JknqdFxH/Ggw52kD7tY5I/DzhsYSIsnqcgJhN4khQgSWWMpTDfUbE/sQfcCsLa7Y8U
	 0K86C6grOoqqptKr8eo7LY1cwzvjEODgAzfA8EYjfk0SXK6hwaqcCjVLwnPgkKYmRZ
	 /fL6xPBM26KNZc3764bshirm/jBITchd5Y2bXMnNYQ+IIj4+6T9/o6zePjn+XTKWSh
	 n5Kythi2nn7aTl58V3clSN11E3U6H3lbKZ7W3iLR2BfrlGb2zUlVdXRBEi9sv+CBAu
	 lRP6Ime7DP+pQ==
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
Subject: [RESEND PATCH 2/5] x86/insn: Fix gen-insn-attr-x86.awk to emit INAT_REX2_VARIANT
Date: Tue, 24 Nov 2026 07:23:44 +0900
Message-ID: <179547262427.326766.7702369325507569446.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179547260053.326766.11540305553612301074.stgit@devnote2>
References: <179547260053.326766.11540305553612301074.stgit@devnote2>
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


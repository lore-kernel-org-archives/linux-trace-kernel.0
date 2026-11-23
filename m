Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795402093;
	b=t8ekpoG3p4SMdGKLm2Rl5NQdAjhlJokXBNePLYGw/9Of2qD/E0pw3chlKEVLjkiKmurC
	 KwWb+cFZiQRkuOWq3k6fNs2O0PaL2wuzY5EUcu80AyFFGOFHJENyZMCxQb5qWBAjEe2k6
	 zQukso2pd9x6wZbToXBu/b4lI/TbxJpHBtAbB5sjnLIrF8RJVbUW5CINHt0ML9may0xct
	 EVGk7pwo2OJxPHshY1VPUHMjkt/vGfxLy1g8I4CRKPkcCOgj30P4ZeIAnCtX98XWwVr9u
	 Ws0BdZ9bzPEeOI9aR5nZk6Kv+vt2kR0W153rdZGRG3ZJ5Ua8XG4h46vqtXUGWWdoChQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795402093;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=foOOFJ27yYtkd5trsPb+eLtTc+SPVgM6R98ixku6o3I=;
	b=aaKxaajE8Wzsa+E9S1OKMRSNKaS0bMmuzcNRu41K+N21JE/Icec+zRg6UpbZfVjeOC9B
	 +J00N/y4KQb/FUuxl0TW4iN0Yy9MnxVFJqqy7mzyrQr8AtifEtzn5+25+qUGJbb2Gz2IA
	 xHB+yaUPJPjurGkEaXfV4nRkNHbR4cfP0TgVUAbf1qAclCZ6L1pP5winccVbkJZncsEoN
	 KBQ4iruwuV6FpoDrvWN6RVWbNZnbQwTwb8yNxoudYfbZN4qLHi40zHmvxby5xZldCWOec
	 Iu+9Y+yTRhezR29EneR8xOqZJSCleZ8nqvYXss4qVrzvjU50Kl4RCorxDwsB07EJmkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VE121mMd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D7E606A327;
	Mon, 23 Nov 2026 02:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VE121mMd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189141F000EC;
	Mon, 23 Nov 2026 02:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795402092;
	bh=foOOFJ27yYtkd5trsPb+eLtTc+SPVgM6R98ixku6o3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VE121mMdFdEHVIshYriFDYwnDXssRssCbJycWXxpag6wzI2Gzlud4bP8VNCk8JLRk
	 QmC0CQOLDbdJi8NpxI9nY9YDqbLF1CTvOfcWm5vc9SffWlsbjiHZdOsgX9N79XNyZP
	 AInjop8Tm+hbqWxjn8xuJLkQb3gK+b3xlpgaJzZLetmIZwNtNJr2E8m8io6TyF6pR2
	 7Mu9JD9FgFuRs456M0D9e4feJ53rjWfm0siodXizaLiHI06jT3u7EMyiRw1iTmOBJo
	 Nl0eZyR7lb0ZHtwJTqBctVL4vx+8IsiFD5jZwj/YIwPa+5/BXee2Yk/PPHIhbMjuk0
	 mE+f5l9KQZQkA==
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
Subject: [PATCH 5/5] uprobes/x86: Fix opcode validation and analysis for multi-byte, REX2, and VEX/EVEX/XOP instructions
Date: Mon, 23 Nov 2026 11:48:06 +0900
Message-ID: <179540208688.233843.9296024425945000350.stgit@devnote2>
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

Commit 67fc809217dc ("uprobes/x86: Fix 1-byte opcode tables") set bit
0x0f in good_insns_32 and good_insns_64, assuming 0x0f would not appear
in OPCODE1(insn). Because the x86 instruction decoder stores 0x0f in
insn->opcode.bytes[0], uprobe_init_insn() returned 0 immediately for all
0x0f-escaped instructions, bypassing good_2byte_insns (including SYSCALL).

Furthermore, several places in arch/x86/kernel/uprobes.c assume that
OPCODE1(insn) always refers to a map-0 legacy 1-byte opcode, which breaks
for REX2 M0=1 (map 1) and VEX/EVEX/XOP instructions (all of which have
insn->opcode.nbytes == 1):

- uprobe_init_insn() checks REX2 M0=1 and VEX/EVEX/XOP opcodes against
  good_insns_64 (map 0) instead of their actual opcode maps, and does
  not reject unsupported REX2 JMPABS (0xa1) or EVEX map 4 (APX) opcodes.
- branch_setup_xol_ops() can misidentify VEX/EVEX/XOP or REX2 M0=1
  instructions whose opcode byte matches 0x70..0x7f, 0xe8, 0xe9, or 0xeb
  (e.g. VZEROUPPER 0xc5 0xf8 0x77, VPSHUFD, VPOR) as branches.
- arch_uprobe_analyze_insn() switches on OPCODE1(&insn) without checking
  the opcode map, misidentifying e.g. VCMPPS/VCMPPD (VEX.0F.C2) as RET
  (0xc2) and skipping UPROBE_FIX_IP.
- riprel_analyze() clears bit 0 of the first REX byte, which for a 2-byte
  REX2 prefix corrupts 0xd5 into 0xd4 instead of clearing B3/B4 in byte 1.

Clear bit 0x0f in good_insns_32/good_insns_64, use insn_opcode_map() and
insn_last_opcode() to dispatch opcode validation and analysis properly,
and fix REX2 handling in riprel_analyze().

Fixes: 67fc809217dc ("uprobes/x86: Fix 1-byte opcode tables")
Reported-by: Pablo Fraile Alonso <pablo@pablofraile.net>
Link: https://lore.kernel.org/r/20261116-x86-uprobes-two-byte-opcode-v1-1-2b6dbabead52@pablofraile.net
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/x86/kernel/uprobes.c |   97 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 68 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 0f60c0d076b6..5ea8e9c92259 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -89,7 +89,7 @@
 static volatile u32 good_insns_32[256 / 32] = {
 	/*      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f         */
 	/*      ----------------------------------------------         */
-	W(0x00, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1) | /* 00 */
+	W(0x00, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0) | /* 00 */
 	W(0x10, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0) , /* 10 */
 	W(0x20, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1) | /* 20 */
 	W(0x30, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1) , /* 30 */
@@ -151,7 +151,7 @@ static volatile u32 good_insns_32[256 / 32] = {
 static volatile u32 good_insns_64[256 / 32] = {
 	/*      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f         */
 	/*      ----------------------------------------------         */
-	W(0x00, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 1) | /* 00 */
+	W(0x00, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0) | /* 00 */
 	W(0x10, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0) , /* 10 */
 	W(0x20, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0) | /* 20 */
 	W(0x30, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0) , /* 30 */
@@ -279,6 +279,7 @@ static bool is_prefix_bad(struct insn *insn)
 static int uprobe_init_insn(struct arch_uprobe *auprobe, struct insn *insn)
 {
 	u32 volatile *good_insns;
+	int map;
 
 	if (is_prefix_bad(insn))
 		return -ENOTSUPP;
@@ -287,17 +288,44 @@ static int uprobe_init_insn(struct arch_uprobe *auprobe, struct insn *insn)
 	if (insn_masking_exception(insn))
 		return -ENOTSUPP;
 
+	map = insn_opcode_map(insn);
+
+	if (insn_is_avx_or_xop(insn)) {
+		/*
+		 * EVEX map 4 (APX) includes control-flow and privileged
+		 * instructions (e.g. Grp5 indirect call/jmp, INVEPT/INVPCID)
+		 * that are not yet handled by uprobes.
+		 */
+		if (insn_is_evex(insn) && map == 4)
+			return -ENOTSUPP;
+		return 0;
+	}
+
 	if (insn->x86_64)
 		good_insns = good_insns_64;
 	else
 		good_insns = good_insns_32;
 
-	if (test_bit(OPCODE1(insn), (unsigned long *)good_insns))
-		return 0;
-
-	if (insn->opcode.nbytes == 2) {
-		if (test_bit(OPCODE2(insn), (unsigned long *)good_2byte_insns))
+	switch (map) {
+	case 0:
+		/* REX2 0xa1 is JMPABS, which is not yet supported by uprobes. */
+		if (insn_is_rex2(insn) && OPCODE1(insn) == 0xa1)
+			return -ENOTSUPP;
+		if (test_bit(OPCODE1(insn), (unsigned long *)good_insns))
 			return 0;
+		break;
+	case 1:
+		if (test_bit(insn_last_opcode(insn), (unsigned long *)good_2byte_insns))
+			return 0;
+		break;
+	case 2:
+	case 3:
+		/*
+		 * Preserve existing behavior for legacy three-byte opcodes
+		 * (0f 38 / 0f 3a), which have not yet been audited against
+		 * a dedicated allowlist.
+		 */
+		return 0;
 	}
 
 	return -ENOTSUPP;
@@ -470,10 +498,14 @@ static void riprel_analyze(struct arch_uprobe *auprobe, struct insn *insn)
 	 * Clear REX.b bit (extension of MODRM.rm field):
 	 * we want to encode low numbered reg, not r8+.
 	 */
-	if (insn->rex_prefix.nbytes) {
+	if (insn->rex_prefix.nbytes == 1) {
 		cursor = auprobe->insn + insn_offset_rex_prefix(insn);
 		/* REX byte has 0100wrxb layout, clearing REX.b bit */
 		*cursor &= 0xfe;
+	} else if (insn->rex_prefix.nbytes == 2) {
+		cursor = auprobe->insn + insn_offset_rex_prefix(insn) + 1;
+		/* REX2 payload has M0 R4 X4 B4 W R3 X3 B3 layout, clear B4 and B3 */
+		*cursor &= 0xee;
 	}
 	/*
 	 * Similar treatment for VEX3/EVEX prefix.
@@ -1493,6 +1525,9 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 	if (insn_is_nop(insn))
 		goto setup;
 
+	if (insn_is_avx_or_xop(insn) || insn_is_rex2(insn))
+		return -ENOSYS;
+
 	switch (opc1) {
 	case 0xeb:	/* jmp 8 */
 	case 0xe9:	/* jmp 32 */
@@ -1658,31 +1693,35 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	 * Figure out which fixups default_post_xol_op() will need to perform,
 	 * and annotate defparam->fixups accordingly.
 	 */
-	switch (OPCODE1(&insn)) {
-	case 0x9d:		/* popf */
-		auprobe->defparam.fixups |= UPROBE_FIX_SETF;
-		break;
-	case 0xc3:		/* ret or lret -- ip is correct */
-	case 0xcb:
-	case 0xc2:
-	case 0xca:
-	case 0xea:		/* jmp absolute -- ip is correct */
-		fix_ip_or_call = 0;
-		break;
-	case 0x9a:		/* call absolute - Fix return addr, not ip */
-		fix_ip_or_call = UPROBE_FIX_CALL;
-		break;
-	case 0xff:
-		switch (MODRM_REG(&insn)) {
-		case 2: case 3:			/* call or lcall, indirect */
-			fix_ip_or_call = UPROBE_FIX_CALL;
+	if (insn_opcode_map(&insn) == 0) {
+		switch (OPCODE1(&insn)) {
+		case 0x9d:		/* popf */
+			auprobe->defparam.fixups |= UPROBE_FIX_SETF;
 			break;
-		case 4: case 5:			/* jmp or ljmp, indirect */
+		case 0xc3:		/* ret or lret -- ip is correct */
+		case 0xcb:
+		case 0xc2:
+		case 0xca:
+		case 0xea:		/* jmp absolute -- ip is correct */
 			fix_ip_or_call = 0;
 			break;
+		case 0x9a:		/* call absolute - Fix return addr, not ip */
+			fix_ip_or_call = UPROBE_FIX_CALL;
+			break;
+		case 0xff:
+			switch (MODRM_REG(&insn)) {
+			case 2: case 3:			/* call or lcall, indirect */
+				fix_ip_or_call = UPROBE_FIX_CALL;
+				break;
+			case 4: case 5:			/* jmp or ljmp, indirect */
+				fix_ip_or_call = 0;
+				break;
+			}
+			fallthrough;
+		default:
+			riprel_analyze(auprobe, &insn);
 		}
-		fallthrough;
-	default:
+	} else {
 		riprel_analyze(auprobe, &insn);
 	}
 


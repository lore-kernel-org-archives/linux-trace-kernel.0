Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472652;
	b=IebXC+x1SedDoKiqWPjslquM+XTAPVT1TBTKPRQmOEUpQRNyeTxI/7gbGge7ixUPPPgf
	 tLrAxv8ksrsCpUxuVN85jR1F4qur5nGmOiQ04Ud8pOA7fNktvs8Vf+lbccbLFeW1Uxb90
	 Jn8AdLAYj9UJDzftuVJr7nzVJkrvQlKPqH5fgpMy2Z/tAoqD8fC/dGhipRf1vsr6+2k6v
	 FaCnkoA8E4Lsa8t+8uTucqgXaouqehXFYpHqFy3qvJgI8U/HnnFmw18fLrC8V4ZOwb/gE
	 nQw0fj9gZelNRqQrDyC47E3AQmemWaBKxUYwH3e1q4FSIq/EhfI2hv6sOR9byY4FAmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472652;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=qlcLxBToIY1DJGdgDhmblSmI1AAESowRHaa1T7+NBVE=;
	b=LctW/8q3MGRcfLmh+a5DD/NG/naYT0vd4OeD8qP47U/7rnosGPPtPDcZlVC5ZbkTYEaQ
	 VFj5ywa7jXxgLCweXhSDcZEIVvYaX5oxLJ6LMyOI6ftk4C3QHO9JwI2g9Z/faT7MwcjCy
	 Q7XGqwjTwqBObDMoVkZxeAN+jFOURd6K4T3GpMHsdQplZOfUVtW0Umr1qZ0TqYGQKx+IW
	 5GvY7CXCjql1g9Ey4KaNAMq5qol4Hm1kTAxA9K6CV/U7h3wtIzG/pIh0gvzK5KsPRu0P0
	 K3gHsNGcQC/fLTJXTvkg2bjXUQKY+cTSXrRvrQ+tUTH/M5YENKp+KwfE3x/DpSUpkOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="L+a+V1//";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE4E606A31E;
	Mon, 23 Nov 2026 22:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L+a+V1//
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F3F1F000C4;
	Mon, 23 Nov 2026 22:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795472651;
	bh=qlcLxBToIY1DJGdgDhmblSmI1AAESowRHaa1T7+NBVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L+a+V1//LTuubxxMXaz4U3DfvS3aAYrXOerLNlmqqGKw0oPqwhZufp0Nzl0BN61/1
	 h75CSRG9LRDXyFYBazIOpF3iGlJ7h0fR8wueHLYrpG2aXVif69de1ebV4ges7US7sh
	 pm/nybRkYtCsFicWzi2I1k1sA/iWYe6zq50z3OT4xWBCZaOzZwbzfvaGzBpE9PSCrG
	 JYnUnOAD7nRKi9TONtTQUH2z8eBiC0d1DC33R21jbzqSo1feOEBWklEiuOgoYC4n48
	 wZS6oxFl/Jrq3PL4t32uFHYbwSjZxotZYwfkiiQYE7oqb7WD36zpiOmGOATngv0nRv
	 iCKDwgAy4QFMA==
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
Subject: [RESEND PATCH 4/5] x86/insn: Add insn_opcode_map() helper and fix insn_masking_exception()
Date: Tue, 24 Nov 2026 07:24:06 +0900
Message-ID: <179547264628.326766.3793172952966298909.stgit@devnote2>
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

The x86 instruction decoder stores the physical opcode bytes in
insn->opcode.bytes[] and their physical byte count in insn->opcode.nbytes,
which is required for field offset calculations such as
insn_offset_modrm(). As a result, REX2 M0=1 (map 1) and VEX/EVEX/XOP
instructions all have insn->opcode.nbytes == 1 even though their opcodes
do not belong to map 0.

Add insn_opcode_map() and insn_last_opcode() helpers so callers can
reliably determine the logical opcode map and final opcode byte across
legacy, REX2, VEX, EVEX, and XOP encodings.

Use insn_opcode_map() in insn_masking_exception() so that non-map-0
instructions (e.g. VEX/EVEX/XOP or REX2 M0=1 instructions with opcode
0x1f or 0x8e) are not misidentified as POP SS or MOV SS.

Fixes: ee6a7354a362 ("kprobes/x86: Prohibit probing on exception masking instructions")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/x86/include/asm/insn.h       |   43 +++++++++++++++++++++++++++++++++++++
 tools/arch/x86/include/asm/insn.h |   43 +++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index 8fb92da1a2c4..9861560efc36 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -326,6 +326,46 @@ static inline int insn_offset_immediate(struct insn *insn)
 #define POP_SS_OPCODE 0x1f
 #define MOV_SREG_OPCODE 0x8e
 
+/*
+ * Return the logical opcode map number for @insn:
+ *  0: 1-byte opcode map (legacy / REX / REX2 M0=0)
+ *  1: 2-byte opcode map (0x0f / REX2 M0=1 / VEX m=1 / EVEX m=1)
+ *  2: 3-byte opcode map (0x0f 0x38 / VEX m=2 / EVEX m=2)
+ *  3: 3-byte opcode map (0x0f 0x3a / VEX m=3 / EVEX m=3)
+ *  4..7: EVEX/VEX maps 4..7
+ *  8..31: XOP maps
+ */
+static inline int insn_opcode_map(struct insn *insn)
+{
+	if (insn_is_avx_or_xop(insn)) {
+		if (avx_insn_is_xop(insn))
+			return insn_xop_map_bits(insn);
+		return insn_vex_m_bits(insn);
+	}
+
+	if (insn_is_rex2(insn))
+		return insn_rex2_m_bit(insn) ? 1 : 0;
+
+	if (insn->opcode.nbytes == 1)
+		return 0;
+	if (insn->opcode.nbytes == 2)
+		return 1;
+	if (insn->opcode.nbytes == 3) {
+		if (insn->opcode.bytes[1] == 0x38)
+			return 2;
+		if (insn->opcode.bytes[1] == 0x3a)
+			return 3;
+	}
+	return -1;
+}
+
+static inline insn_byte_t insn_last_opcode(struct insn *insn)
+{
+	if (!insn->opcode.nbytes)
+		return 0;
+	return insn->opcode.bytes[insn->opcode.nbytes - 1];
+}
+
 /*
  * Intel SDM Vol.3A 6.8.3 states;
  * "Any single-step trap that would be delivered following the MOV to SS
@@ -336,6 +376,9 @@ static inline int insn_offset_immediate(struct insn *insn)
  */
 static inline int insn_masking_exception(struct insn *insn)
 {
+	if (insn_opcode_map(insn) != 0)
+		return 0;
+
 	return insn->opcode.bytes[0] == POP_SS_OPCODE ||
 		(insn->opcode.bytes[0] == MOV_SREG_OPCODE &&
 		 X86_MODRM_REG(insn->modrm.bytes[0]) == 2);
diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
index 1d2903508bbe..e7fba77f0b11 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -326,6 +326,46 @@ static inline int insn_offset_immediate(struct insn *insn)
 #define POP_SS_OPCODE 0x1f
 #define MOV_SREG_OPCODE 0x8e
 
+/*
+ * Return the logical opcode map number for @insn:
+ *  0: 1-byte opcode map (legacy / REX / REX2 M0=0)
+ *  1: 2-byte opcode map (0x0f / REX2 M0=1 / VEX m=1 / EVEX m=1)
+ *  2: 3-byte opcode map (0x0f 0x38 / VEX m=2 / EVEX m=2)
+ *  3: 3-byte opcode map (0x0f 0x3a / VEX m=3 / EVEX m=3)
+ *  4..7: EVEX/VEX maps 4..7
+ *  8..31: XOP maps
+ */
+static inline int insn_opcode_map(struct insn *insn)
+{
+	if (insn_is_avx_or_xop(insn)) {
+		if (avx_insn_is_xop(insn))
+			return insn_xop_map_bits(insn);
+		return insn_vex_m_bits(insn);
+	}
+
+	if (insn_is_rex2(insn))
+		return insn_rex2_m_bit(insn) ? 1 : 0;
+
+	if (insn->opcode.nbytes == 1)
+		return 0;
+	if (insn->opcode.nbytes == 2)
+		return 1;
+	if (insn->opcode.nbytes == 3) {
+		if (insn->opcode.bytes[1] == 0x38)
+			return 2;
+		if (insn->opcode.bytes[1] == 0x3a)
+			return 3;
+	}
+	return -1;
+}
+
+static inline insn_byte_t insn_last_opcode(struct insn *insn)
+{
+	if (!insn->opcode.nbytes)
+		return 0;
+	return insn->opcode.bytes[insn->opcode.nbytes - 1];
+}
+
 /*
  * Intel SDM Vol.3A 6.8.3 states;
  * "Any single-step trap that would be delivered following the MOV to SS
@@ -336,6 +376,9 @@ static inline int insn_offset_immediate(struct insn *insn)
  */
 static inline int insn_masking_exception(struct insn *insn)
 {
+	if (insn_opcode_map(insn) != 0)
+		return 0;
+
 	return insn->opcode.bytes[0] == POP_SS_OPCODE ||
 		(insn->opcode.bytes[0] == MOV_SREG_OPCODE &&
 		 X86_MODRM_REG(insn->modrm.bytes[0]) == 2);


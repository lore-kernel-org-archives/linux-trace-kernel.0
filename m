Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795402081;
	b=vsduvvyUpl2E0AIP7kGYmMTNHospef//zLesQ56bzfGBnLCLfADYlUyYU3MID/QJ/kA3
	 T6EuO1iwW5X1xp5HoT5zUaeR5BtN+5j76PUkH1fr/lqqjLwLWzLDlTnl6N71RH5o60+QE
	 NAphKV2IJAX6+qHBuvcktpYE1rkY2OgtGx6y9PhUA/BEoMZbWdcquDKmyiftqaiC2ldty
	 JbNBZABkvzsFQdMVhZV4ly+Prqa7bgidSH7b0lurRhmU16OalMPVN8HRzsHMVwbk70rtp
	 kJ7zFTYRiKoaXrNYs4WlUZjcisrcEpTQsEQwyo4HHdEJcGILFk/+XA8QHbamiknaNdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795402081;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=qlcLxBToIY1DJGdgDhmblSmI1AAESowRHaa1T7+NBVE=;
	b=vLM+MXdULgU9WtyQ7/SdDhMuUmzLNBOmuLsaFX3MANZ14G50/JZ60bCvC1yCf0sN6q71
	 o5aiO1ClWnb+6174L2WH9nBedX19lXbUZB95vbJDvocld4Q0LWgi5y/y4gF3eZjk1AnT0
	 5E3hVYeBhhi7lPLa68qjsuoRqZ5B5N67Aq/g+pUaUAze67SLMsMzEcxoT6riw91mqKDZ9
	 /vPDey8oxHTkjiAcAm3/D38TYDrWro9ZU5JrhR+3oXd2/rv8YeA0/s0cxaYCismHSXrsi
	 Y2xgmB6Mv1WmMlO0ZBcNjvDf4Q3JasDDHIzc5Do+9YrH4LCR6CyxiL/rkx6+bHdXSig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ClPVih9C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3F6606A31E;
	Mon, 23 Nov 2026 02:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ClPVih9C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DC31F000E6;
	Mon, 23 Nov 2026 02:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795402081;
	bh=qlcLxBToIY1DJGdgDhmblSmI1AAESowRHaa1T7+NBVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ClPVih9CGRaQScnb4wg7TmAwib3PxzfnH0knT/R3NTiXgb6ZPJrC+759nILX5PPZE
	 ANbkCbN5euGHeC/LsAfS48653jOnKRzcv1M75kjir9IwR0frL/m5GdmvKdaTEdr/DE
	 6znlJiRcfb4FfkB8CIrJP/e/y8dgMby/iNfIcpXzHY2t9aXZH2dPXoT2gZg6F67adZ
	 fKqVnuyeFhRGUwl9CR/LPWgTlHchPkrPX38RuySPebQTqCVuUel57ASkdV+q0CCYG8
	 12+ewOTL55wh7QbO2byiZ4achsVzBLA8FvZDRtfZst4L4q5YI1QgEmgGq7bn0hHFjF
	 zX94yVzSoz31Q==
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
Subject: [PATCH 4/5] x86/insn: Add insn_opcode_map() helper and fix insn_masking_exception()
Date: Mon, 23 Nov 2026 11:47:55 +0900
Message-ID: <179540207562.233843.3618280650654568620.stgit@devnote2>
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


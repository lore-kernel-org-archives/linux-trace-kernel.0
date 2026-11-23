Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795402048;
	b=2ybXhj1YNHs0DZZ4lF724dZ2mC/uYYNu8dRcgR8oikNZAAsVC3rdRip8PQD4Tzw5qNld
	 F42ofYLiLLBERQ8m0KNrh9YrDDrUCnAiP8dOZAGOPXUML7UBA6INKUYMPEG5ZkcV3BwNu
	 ZbMBhmfRZHogUcJJgovnxawMcN4QU+4AUjZ5FjIsZUaSTtGpRfcuk5NB1VC29ZlAjmEVg
	 JduIqW7sZnF4yZL0prkOI6vqe1vTEMOCgBmYcSrSSdnCg2u+sDn7tzlRE1QsNPf4bxmlD
	 XmmsMa+tI6j1mlHVU51L0sC1RrWGaodHD5ybX8en3+T5xHFMf0K3cxarY2yHzvGO08Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795402048;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JNjk/4HiJWkwvqdmrflK9/BOHpzuJMO4asKwUdIyFFE=;
	b=lFpUVJCVAeO3Ep7y5GHfeo39C/zCCHHvsV6B3Gd4rh/zFupmng52TTnR2+pQsxYibbna
	 hXNaqraEA8beGcHT9EQ0GEPhzOGl3Z4Y5anaSkrlnEguGvwYdMjItVHIEe8/iw33THmjM
	 fuQMP4om/I366qxtwcQqb5YP/37n4vODU7/jhrXxuurvHJuva9csUwDlwagkaUnEROsG4
	 GTU9hAsa20SZ5TZpYxhnhZLGHg86OUYAUPAFYdhn1uR2H+ghgyzLojDEcyET7Wf8Ka10w
	 0RkZYMt7DV8J/9de9aC89D9AkWltVL4xbqBRnN0fkwxK4GEcA+I5Ytzd/v9/IkLtMXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OeuNhyq6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0039C606A683;
	Mon, 23 Nov 2026 02:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OeuNhyq6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671181F000C0;
	Mon, 23 Nov 2026 02:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795402047;
	bh=JNjk/4HiJWkwvqdmrflK9/BOHpzuJMO4asKwUdIyFFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OeuNhyq65QQ7xxi+CyE1E+2SXTdZLYJltj0+mNNlVqbWrvwVuY/Fo2PAiaXIVFhlI
	 V8dPtmUVK/HRaQvgFrFDBGO+ocoCoOsYxFWlqc+jo5gY51jfvcC34rwKDwEjt2IdOh
	 v1usx2wS71ZwY9SQHjuusTxjj1yKXGgDyyH2kuMpDLoJid7a/N2ZCTMjbzXNRIwfUK
	 +byfdwdPuewQE3P/19eYnzlFaqSZGpIEJVN8O8Lg9kTp4wWcJ22oV1cvJyvV1Oc1hI
	 mKOPnWWDx3wyXwqfjHeaBA+Ks7zS4kMLLZD2b+rqNg9GdXkn1lh++aBFJwcsY3mMFk
	 IlwPNrflbvJxg==
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
Subject: [PATCH 1/5] x86/insn-eval: Do not mutate struct insn in insn_is_nop()
Date: Mon, 23 Nov 2026 11:47:22 +0900
Message-ID: <179540204209.233843.2595774240986518615.stgit@devnote2>
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

For REX2 M0=1 (map 1) instructions, insn_is_nop() shifts insn->opcode.value
left by 8 bits and ORs in 0x0f in-place without updating
insn->opcode.nbytes.

This corrupts the decoded struct insn for subsequent callers. For example,
in uprobes arch_uprobe_analyze_insn(), can_optimize() ->
is_optimizable_nop10() calls insn_is_nop() on any 10-byte instruction
before uprobe_init_insn(), leaving OPCODE1(insn) == 0x0f with
opcode.nbytes == 1, and a second call from branch_setup_xol_ops() shifts
it a second time.

Use local variables for the opcode bytes instead of mutating insn->opcode.

Fixes: 8a5c6cbfe4a3 ("x86/insn,uprobes,alternative: Unify insn_is_nop()")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/x86/lib/insn-eval.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index e03eeec55cfe..c67f8ac375c4 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -1700,6 +1700,7 @@ bool insn_is_nop(struct insn *insn)
 	u8 sib = 0, sib_scale, sib_index, sib_base;
 	u8 nrex, rex;
 	u8 p, rep = 0;
+	u8 op0, op1;
 
 	if ((nrex = insn->rex_prefix.nbytes)) {
 		rex = insn->rex_prefix.bytes[nrex-1];
@@ -1745,21 +1746,25 @@ bool insn_is_nop(struct insn *insn)
 	}
 
 	/*
-	 * Opcode map munging:
+	 * Opcode map handling:
 	 *
 	 * REX2: 0 - single byte opcode
 	 *       1 - 0f second byte opcode
 	 */
 	switch (m) {
-	case 0: break;
-	case 1: insn->opcode.value <<= 8;
-		insn->opcode.value |= 0x0f;
+	case 0:
+		op0 = insn->opcode.bytes[0];
+		op1 = insn->opcode.nbytes == 2 ? insn->opcode.bytes[1] : 0;
+		break;
+	case 1:
+		op0 = 0x0f;
+		op1 = insn->opcode.bytes[0];
 		break;
 	default:
 		return false;
 	}
 
-	switch (insn->opcode.bytes[0]) {
+	switch (op0) {
 	case 0x0f: /* 2nd byte */
 		break;
 
@@ -1811,7 +1816,7 @@ bool insn_is_nop(struct insn *insn)
 		return false;
 	}
 
-	switch (insn->opcode.bytes[1]) {
+	switch (op1) {
 	case 0x1f:
 		return modrm_reg == 0; /* 0f 1f /0 -- NOPL */
 


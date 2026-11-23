Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795472619;
	b=jPdy/XqCmbQ7I0aAqzv9/6T5jmb8JNuuMXc7G8oIpZ5HViJSYq5obpFA3SeKIZq4nuqZ
	 L6W676iVoTVbiBxvHS5VmdqbX5mYneRGkJEC3T2H8sPYymVckJsC3OI3ihgtPFLeH/3g+
	 7GiCHGk3ANSSkEyf0RFcvb34eRkxixkMmwkxnhjA3+LklBRBiYHWXsjdJ9actghux8pJf
	 6zi/gtggWcfu+8Yu0GuX0MAUj6bByoK8yZyL1juDlLxnwjThUQTCemwG4k8UcjIPuqIrh
	 5LQYSiOIMh/DCNJtB1OuNw7AA9YB8YmaSXtosJcou2iyTeFBvrUiT5pGKskbKuZ2byg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472619;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JNjk/4HiJWkwvqdmrflK9/BOHpzuJMO4asKwUdIyFFE=;
	b=0bdiU80EbRiWLyPY77cnoEmOy0a2ngQiVkw7F6z+1unmKseriGvKHVQ8k/7KcPKdiy9q
	 0H92YAOso7gUl3ruBlY4c5oIF9BWWxk30cEGXUG5Z4+IPcKC5MB5QPufsWaYQmRLImUCc
	 5VCyZMxf/GKputd4gwMqykcCLxu3lTAsbL/V5We4NHJmjEi6QkUAp7J8YR+7hfwsSBtFV
	 QYEjaH0dajTDsYyAGHszwiu2cj5gXbCKNN9G7t8Lb7aNbnh/1jzGJ1S8JHQXL55dTCvLY
	 q4slypTclEB+02Oy+h3dR6kfHsnzEj28ir5PcLYbCdgyZ0gGQy8nUhDPcHXjwXX9CUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TmaQUJAM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68AC606A33E;
	Mon, 23 Nov 2026 22:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TmaQUJAM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE4E1F000CF;
	Mon, 23 Nov 2026 22:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795472618;
	bh=JNjk/4HiJWkwvqdmrflK9/BOHpzuJMO4asKwUdIyFFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TmaQUJAMEZDatxBpBW/jOaIPXihlQF0aOHb4U8MeKzTEdhc/xkTPf+K3DIVfulvsn
	 bcYes6A8z9ItHgelyrkSH/naIKqxt/C4r8OAAJkp/hmnQylddRa2HOLN3HkAqd0d+2
	 /HhVTW/ayo0FHTRI9RlH8ZRol9Py2V4spfsulKocIF6KBFShoqONod2tH6AfBp2cjq
	 ShMS2ax4CRwzkMHFXaZq3PPj8QhLuKOntqO8bSctdBe9ivtiXOqZDQoa0PejDq9R45
	 MYzvnLELGJb/CmowuFqFEmMOdkfVvGGRrBruvUBJ0f/t5AqLvNKuEyumz4U6szWI3K
	 ma2rB29GIrVTQ==
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
Subject: [RESEND PATCH 1/5] x86/insn-eval: Do not mutate struct insn in insn_is_nop()
Date: Tue, 24 Nov 2026 07:23:32 +0900
Message-ID: <179547261206.326766.16873700808089736794.stgit@devnote2>
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
 


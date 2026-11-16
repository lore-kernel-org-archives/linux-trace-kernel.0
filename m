Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794843630;
	b=dHSiNHCAb9Q+TcLhGFoBKZzEDVHVVQbwdED7IXuak7qm/DxWs9pNwQDEQ+/VP9/j++4c
	 fXKgXvSZz+BgMRQ+DW/YULHx5MUuB21gMNKHDM1YOGoW3UhGFMgvQDTbxUzc5OY5TocwE
	 uP5igZZc35fipAo3g1D/UM3pXHnGFRlhvA0A0CB+Ryv55/q/PIhoSC4aTSgGeZPhK+nXc
	 AeBcbDytLiqHbeKTwqr5zPraEDXZNHpUYei0Z7f/Wx7A57pevTG5Rz3T+MpFB9l0Yq4Hn
	 255xUEr3o+NWm/aogeWZoRSzQlOe+dzcB02/qHPrher3JK8iQoptlvwiAufn20hBr6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794843630;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Rspamd-Queue-Id;
	bh=pFgl2BRMAGjKsT4FqmcSVd40/qC3NQVtDe6l2Yqur2U=;
	b=z3Y5z64JukSlLyjfv+z9C+U32/UwSlh8Ye9+D4VdO0uiAGIZrzVBVCq9ELeVZBxtwYsK
	 fKw8zPL7ulnDTku+HlElmWOOLHJj8qFTnlmRM8DC2UluiRKoyGddbovvoIAQM8e1zkFX0
	 iSqfg665l9NZbONGq90akm15qScfRSCH/FHgjHvbNMeG+fXS71xp0JcbYcQvCWwGWbSKq
	 e6djg6rYVXC0ioKW4IdklVW8li67zMhyyQLuNfUQAmdjTZ5CpucVfrH4Ji8pBaF2ZgTqW
	 mwZoSxtfhn9E81JPo/a08ViZTVODQQ7Z7SGTT+1CkOg+rq7lRHAmmtU7uKvWSB5H5Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pablofraile.net;
	spf=pass smtp.mailfrom=pablofraile.net;
	dkim=pass header.d=pablofraile.net header.i=@pablofraile.net header.a=rsa-sha256 header.s=MBO0001 header.b=aU85FW07;
	arc=none smtp.remote-ip=80.241.56.151
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D92606A32C;
	Mon, 16 Nov 2026 15:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14D92606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pablofraile.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pablofraile.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pablofraile.net header.i=@pablofraile.net header.a=rsa-sha256 header.s=MBO0001 header.b=aU85FW07
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jSsWb0Sgsz8tys;
	Mon, 16 Nov 2026 16:40:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pablofraile.net;
	s=MBO0001; t=1794843627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pFgl2BRMAGjKsT4FqmcSVd40/qC3NQVtDe6l2Yqur2U=;
	b=aU85FW07T2R+SoecrpqLp3+yfKd+UGufqjBV3zXgdG7NS32k0HmYrpP6hKEniLpfAj9OFh
	66iSJDw5djLJRMC9O1QjZuuLQaghtjosT3DpM/Dq+Vd5quzZZaBcm+C1PLH+cy2trGe7/b
	GN5Rm/0PwlKqWHE/hpsd3udDRxoqNXxSfQF+sf+qoksOoSS3GHL9oOXY7tYq0SYfwZKAah
	yBJ7TEreZK7emu1pXs+Dx5Ujri7yN4s/7xDohyXQB3g2Sp8bWNJn1OE7YgByUuh0y6QKS4
	EKzmyG3nVsrbelxEFxbAM6aQM+YJ3FHGXmBhrafMjg822r0I19ff2eGPJ698Jg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of pablo@pablofraile.net designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=pablo@pablofraile.net
From: Pablo Fraile Alonso <pablo@pablofraile.net>
Date: Mon, 16 Nov 2026 16:40:22 +0100
Subject: [PATCH] uprobes/x86: Fix bypass of two-byte opcode validation
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-x86-uprobes-two-byte-opcode-v1-1-2b6dbabead52@pablofraile.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMAwA0F8hPduEMjPQXzEe2Cg6D3RZh2II/
 +7A47u8FZRTYIVrtULid9AgUwGdKvDPfnowhqEYmrqxRGRx6SzOMYljxfwRdN/MKNHLwNiOfXs
 2nakvhqAMMfEYlmO/3f/W2b3Y572EbfsBbXP5438AAAA=
X-Change-ID: 20261116-x86-uprobes-two-byte-opcode-7fa743830931
To: Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Denys Vlasenko <dvlasenk@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, 
 Pablo Fraile Alonso <pablo@pablofraile.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3214; i=pablo@pablofraile.net;
 h=from:subject:message-id; bh=gwaVMd4k5FYsrQI8K3YbuuiRNsSmGdpy4BVh44IaoNY=;
 b=owJ4nJvAy8zAJbZmdbncrUW3dBhPqyUxZP1WfhHp1iSl8PuEccoXf/YjfoLHhdZ4yqsu08/5G
 njCY7KY/7aOUhYGMS4GWTFFFvuf8UwKtnsXn5se9hFmDisTyBAGLk4BmMgLP0aGi9IMP+YeXvpU
 UPf/7mQumUkfW6SnPy7x+2OzJrLN/3P2O0aGrkMTndQulLq/q41dv/ecdn6ZXydTSUlU4p2gZEW
 zPR38AD9rSjo=
X-Developer-Key: i=pablo@pablofraile.net; a=openpgp;
 fpr=8F6EE99CF702CAF8A8333DF5A6FFF50CA3F27559
X-Rspamd-Queue-Id: 4jSsWb0Sgsz8tys

Commit 67fc809217dc ("uprobes/x86: Fix 1-byte opcode tables") set
bit 0x0f in both good_insns_32 and good_insns_64, assuming that
the opcode escape byte would not be reported by OPCODE1(insn).

However, unlike ordinary instruction prefixes, 0x0f is an opcode
escape byte retained in insn->opcode.bytes[0] by the x86 instruction
decoder. Subsequent opcode bytes are stored in the following positions.

For example, SYSCALL (0F 05) is decoded as:

    insn->opcode.bytes[0] = 0x0f;
    insn->opcode.bytes[1] = 0x05;

Consequently, OPCODE1(insn) returns 0x0f, causing the first
test_bit() in uprobe_init_insn() to succeed and return 0 before
good_2byte_insns is consulted.

This bypasses the secondary opcode allowlist for all legacy
two-byte instructions, including SYSCALL (0F 05), which is
explicitly disallowed by good_2byte_insns.

Three-byte opcodes (0F 38 and 0F 3A) are also affected by the
early return, since their decoded opcodes begin with 0x0f.

Fix the validation logic so that legacy two-byte instructions
are checked against good_2byte_insns. Preserve the existing
behavior for three-byte opcodes, which are not currently checked
against a dedicated allowlist (in my opinion, this should be
audited on another patch, instead of returning -ENOTSUPP).

Fixes: 67fc809217dc ("uprobes/x86: Fix 1-byte opcode tables")

Signed-off-by: Pablo Fraile Alonso <pablo@pablofraile.net>
---
I created two reproducers (and a brief explanation of them). One it's a simple one that demonstrates what I told (that you can attach to a non-allowed instruction), an another one that freezes a system by attaching a "poisoned" uprobe to glibc.

- Dummy: https://gist.github.com/Pablito2020/077fc8d8b6d7a75c23c702c7021d68e6
- Poisoned Glibc: https://gist.github.com/Pablito2020/bdda586ab023ec4760716b3be7cff102

After the fix, registration of the uprobe should fail because
the instruction is rejected by the secondary opcode bitmap.
---
 arch/x86/kernel/uprobes.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 0f60c0d076b6..1cf901d18688 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -292,14 +292,24 @@ static int uprobe_init_insn(struct arch_uprobe *auprobe, struct insn *insn)
 	else
 		good_insns = good_insns_32;
 
-	if (test_bit(OPCODE1(insn), (unsigned long *)good_insns))
-		return 0;
-
-	if (insn->opcode.nbytes == 2) {
+	switch (insn->opcode.nbytes) {
+	case 1:
+		if (test_bit(OPCODE1(insn), (unsigned long *)good_insns))
+			return 0;
+		break;
+	case 2:
 		if (test_bit(OPCODE2(insn), (unsigned long *)good_2byte_insns))
 			return 0;
+		break;
+	case 3:
+		/*
+		 * As of today, allow three-byte opcodes, although
+		 * one day  we should investigate which instructions may
+		 * not be  compatible with XOL and reject specific
+		 * problematic encodings.
+		 */
+		return 0;
 	}
-
 	return -ENOTSUPP;
 }
 

---
base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
change-id: 20261116-x86-uprobes-two-byte-opcode-7fa743830931

Best regards,
--  
Pablo Fraile Alonso <pablo@pablofraile.net>


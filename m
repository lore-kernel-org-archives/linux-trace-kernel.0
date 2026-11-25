Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623166;
	b=ElyiDPg1VW9dvac2sRigyBxmY3TL7ACqV9IeLZxuCwHh0Oc4WTxEGHNn7aiXd4P42agh
	 bmkfyafgFDojuWyAlZSqRQI9M8tbZ57AopLEn6RFWpoCIinZ4ZwbNpJKf6BKKYSeg2GRb
	 k6nmNJbkJ0ra6fWk5rdjU9j+OsXlaFTiQJ2sePGgoZF1LMmN49LI4GiFUmLRLqUy6v3z4
	 zYsp1fBxPvFeP1kRsOdkvczLWVG5RYacZA1km139DfLBcnQijgmjKs24KeKYYsUajWj/L
	 gv7nvo76dunY2eDtsShVB4nn8WgF5NDMp656YA4dr93OMUHwa89IVGLQBuQKpmk3LsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623166;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=Pk46cj7nVppPyv1SdgYuZqus5oI9EjsT7BSpkL/ALFw=;
	b=pL0IRSAyrYNMNY0atfWRscoLtoAa/5cr4F3ULdjd7INX8/MB3jr6e7x+XMXdVWNmhgHM
	 9x9JPOl3B0s0okaRUs9Llvfo+yZ/NOwzDMKlKM1lPfRgXZY3i/QTZJKayWFn/X4xenvEK
	 /O67icwdgGuOiMYVCg6LOjnDLeK3+Jhycq3O1676fCqA/gcnYd1ng4f/73FTxrRISicX0
	 6klbjVeiQ0Uj0pr/1SrVXwa0fuSsKdPGF9+gK6ltqcw7j+JsAQW+nsxbkJr/pnd83yzFX
	 55nO77xTXYulFOhA8S7ZC58Mihsc8DJ/DFPELQY3yopU5Gef8y1r06m2yDlbfUvgNQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.147
Received: from esa2.hc555-34.eu.iphmx.com (esa2.hc555-34.eu.iphmx.com [23.90.104.147])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5542B606A32A;
	Wed, 25 Nov 2026 16:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5542B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1795623173; x=1827159173;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=hBFiaxNAO8+/OHuQPaW+LpZx9mtSCVvvtreXstWnX98=;
  b=MgyL7eGFKK0qJV2Ih16hVWmPQR1zl5BybEP9icb/+0F3tdTm83eCc7Pi
   Xc1V6o6zimrZQ4KNIQ9eKX0fWaPg6z4SJUWLErFUlqeQMvnZTX1VaJoK3
   XRQIqL3ltyoYRK7W71iK0gtwkorIqx6cNbNzsp/VMr8b9qUUpQeiyh09/
   8nbMfehK2zrWBjloXlvDIN8FVfU+bKtTywKL2BBE2wYzW5kHk0g1voqXi
   vRCj6Rtx8XfVYQ4qdSiM4Ahi4Luuf8142cmtRj/39eFC7bQyq2iK9Yrqf
   3pPIf4WP3LSKXD9OnhQo90UPFikTPzUqR/HMyqL8JPf3+2bQKtx7b8jjN
   A==;
X-CSE-ConnectionGUID: 68gFUhiVSEeRj4swVpyeQw==
X-CSE-MsgGUID: +pahGX0GTcyaqZv/4NESlw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces02_data.me-corp.lan) ([146.255.191.134])
  by esa2.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 18:12:42 +0200
X-CSE-ConnectionGUID: oJMcifliQjW9YKQBlxbgrQ==
X-CSE-MsgGUID: cBrXRjMLR0OGTKib8Uh/Ng==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces02_data.me-corp.lan with SMTP; 25 Nov 2026 18:20:57 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Wed, 25 Nov 2026 18:12:33 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Wed, 25 Nov 2026 18:12:17 +0200
Subject: [PATCH v5 1/3] riscv: kprobes: fix out-of-bounds read in
 riscv_probe_decode_insn
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
Message-Id: <20261125-probes-in-lrsc-v5-1-38a32e53fcc2@mobileye.com>
References: <20261125-probes-in-lrsc-v5-0-38a32e53fcc2@mobileye.com>
In-Reply-To: <20261125-probes-in-lrsc-v5-0-38a32e53fcc2@mobileye.com>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Guo Ren <guoren@kernel.org>, 
 Pekka Enberg <penberg@kernel.org>, 
 =?utf-8?q?Patrick_St=C3=A4hlin?= <me@packi.ch>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmerdabbelt@google.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0

riscv_probe_decode_insn() can trigger an out-of-bounds page fault
when probing a 16-bit compressed instruction at the end of a page.

arch_prepare_kprobe() safely reads 16-bit parcels into p->opcode, but then
passes p->addr to riscv_probe_decode_insn(), which unconditionally
dereferences *addr as a 32-bit probe_opcode_t

If a 16-bit instruction sits in the last two bytes of a mapped page next
to an unmapped page, the 32-bit read of *addr crosses the page boundary
and faults.

Passing &p->opcode instead of p->addr to riscv_probe_decode_insn()
(as arch_uprobe_analyze_insn() already does) avoid reading past the
instruction.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-812af091-20d1-4915-97a6-741f51e07022
Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
Reviewed-by: GUO Ren (XuanTie) <guoren@kernel.org>
Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
 arch/riscv/kernel/probes/kprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index 9e2afabf94e8..63ee5066def5 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -85,7 +85,7 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 		p->opcode |= (kprobe_opcode_t)(*insn) << 16;
 
 	/* decode instruction */
-	switch (riscv_probe_decode_insn(p->addr, &p->ainsn.api)) {
+	switch (riscv_probe_decode_insn(&p->opcode, &p->ainsn.api)) {
 	case INSN_REJECTED:	/* insn not supported */
 		return -EINVAL;
 

-- 
2.43.0


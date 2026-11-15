Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794746335;
	b=y57VcD5tv7ELMQP9FmUVwPbImX6Kn7GfZu238ZOmHP5+z2QrScweWhA1E2pIpf+FbJbi
	 w9IiRQFHNLONLJEH4ifTyyeRm6hTox3XFYUvVL1u3411QtZu7ChqFIWOn0KQDiNSyhRJG
	 Smf+UfFaxj2/chBJrhjp1aj9J7wTzQ/dgChXABwoBiEQSI2d+q6miasz9M+RxOsSLAoGG
	 o33Bm259UdrQBQJVKlhEgmT2rf0KeC6dv/00udXgVjn3qvwAKmOq1c3ohC05vYJflPZ7L
	 E64bN1NOaJzdCArKMRPkzAszKTtM1ZixBR7jdkEh180KLQNsuuWqAaUImIPcys76i3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794746335;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=Pk46cj7nVppPyv1SdgYuZqus5oI9EjsT7BSpkL/ALFw=;
	b=MyHkLAma2Oy+SdoeGybg7BSavgBgw/E8uwto1I/rMO+4voTR8krhhzIG1Ue9SI6LPqvY
	 081co69mTT0QHk7gfYwji0L7ekU6ynRZiSWhelWdowEoZTTXuuaprpZ3tEXzIwjdEMYY/
	 1cP0gtHVEeLY3z1t6ts+M20WQKb+J1aiSRpYWIskHj4iijqAvPN6nodes4DkHKG1d6zR9
	 ZoJ1epDqmu2xjgL3pvA6KSGIBa49Z4SvOuEPCFE0+yYvuvm71Hl79SGq72+JBqXkVgHHL
	 ZRLJKIykabzjCkxljYR+thMbAjzhPNS+NurQKF7imXlDXf4mCphN4KMg+7j4JMXl2hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.50
Received: from esa3.hc555-34.eu.iphmx.com (esa3.hc555-34.eu.iphmx.com [207.54.77.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE96E606A32E;
	Sun, 15 Nov 2026 12:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE96E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1794746343; x=1826282343;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=hBFiaxNAO8+/OHuQPaW+LpZx9mtSCVvvtreXstWnX98=;
  b=FnMX3CBImrnATVJVUUGeXEC3mBAR5tlfTX5tc16zYcUvuPAyRMF7hd4c
   6ESyJlrdZwhujriGNTQI1EZiIESqwjv7t75Tq3++a0b3df+Lq5+jM5F0m
   qNDOlzu64xlOvszWsXGNlEFvx4J/eqzOFu5XOoR3xrriKWNQbjmul9ehW
   WDAx3QRHBIO6Ub1Y3UdlH0mOgDEOqqwmEp8cXqg+kicEk5+sMJ3Pw1s+n
   9dIWhU9mR2gsD5fwrvcR8CPQmPKJbyX4vUEPHptZqGs6m1tgKUwi+D9yr
   t3XI0Z3RbJEbaT7QH1lJfBfpSflWtd000ao+bgL6K8YS/gMKWCj4pnhsR
   A==;
X-CSE-ConnectionGUID: aEAkvD/zReCyKrrAwScpaw==
X-CSE-MsgGUID: sBdAN4QhTN6uIc0xW7YSxQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa3.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2026 14:38:51 +0200
X-CSE-ConnectionGUID: CN9K0/jSSsmsMsC8BT6mwg==
X-CSE-MsgGUID: lXu0cJM9ShWVr2HvNxaj5Q==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.3])
  by ces03_data.me-corp.lan with SMTP; 15 Nov 2026 14:46:44 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Sun, 15 Nov 2026 14:38:42 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Sun, 15 Nov 2026 14:37:33 +0200
Subject: [PATCH v4 1/3] riscv: kprobes: fix out-of-bounds read in
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
Message-Id: <20261115-probes-in-lrsc-v4-1-48b9b036bd1d@mobileye.com>
References: <20261115-probes-in-lrsc-v4-0-48b9b036bd1d@mobileye.com>
In-Reply-To: <20261115-probes-in-lrsc-v4-0-48b9b036bd1d@mobileye.com>
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


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416535;
	b=HvVV/vrHmySDgsiPGnUKK5q34hq+FuoLjGqTCs4qh2/6M6wTWZZaYn9py4Hnz3VrT4qG
	 7emDNrvYj5bB+PFNuEvaZmNgB23M6WMoUjo7jpuyOUMOtsw67fXGBMbsyBbfoCzG+KHXG
	 DTbUkWWsct+GuI83xoHggzh1QCAN7GJBR/njH1QCxv1iTRaZEE2vuUTojiSMiplGCgn0o
	 NPMd4iiRFYBQuwmOUT/k8WW2G7Gjux0BahpWFLI8LRw2kfaPPpW1ROEHU1kOJuKFPakfg
	 E7U7596p7wS7xMuqFBYqLbMg9VKq2iEgv6pIhRLqOIJBaEkL1upf3dJgNpHShOZPBoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416535;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=7I+kSXjlkO2svF2yaN+rrzkzAguajUW1DvIpdUjYXTM=;
	b=J8HDlPaJ2XW3oeeHWhZknc3Ftcg3xpNX697RSXe7GUlPuW7oddMajcH1jnntPgPp+gyq
	 WqtEF8lQA9r/RC7jSOvVfxBJhJ3/Yi8bs/s+qlTtKxeABfh7CuxWSPzy3VZ+pxQxAuGen
	 QLViWVxqwVPDLB8wAQxwy4AgvNNWhCvx+SVDhgLSMbVbFdr1rU4m4KN2Ut5WioUeddVA5
	 ecTNRGnuMzbx7OqonHrq198vMbvTwL8KgkzDZs2FZC7HYwS4Fi14vEUujHhgPR4Hscqlb
	 DnlP1bAuYs2GUTCIBm0dSbajTOEXSGV6Qp/aZ0ZG3CkXZRgmh4WN7Gp6ABU0ysLaorA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.144
Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D86D606A31C;
	Wed, 11 Nov 2026 17:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D86D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1794416533; x=1825952533;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=V78osBa5zfotrilQugePzcebMECJrUnNMa7oxxsPtSs=;
  b=mqj+vHaspMLOGcP43YmKzvb1xcP/wRoyagOgzUbGWzWyuCyaOeYqydnS
   PwAZAFSrMHe9JOWan8zh6XST+Cu17CSoj0XR4ZTeeOuo8awayQKJIHdAK
   LlUJZ6IxTeuzFBV6OCStKjWvT9cJplv2L3Y6GIbG3Kmez7NbPt8uWpE0c
   tz/T+99hUn5MP8lb3/6SUwxJilM4SGVYldiWEYGzB4cGjWd5JG4vE3L5T
   DGEQviAT1HC15SxqnsI34qRpwcjV97/SQaNMsaPMDGPmjdvyqujvPJ4ws
   2wC3QccnAKSLwDVNHPa6IDOnhTc11wx9O/trWVxWw+n+3hWcfMQACTbH9
   A==;
X-CSE-ConnectionGUID: AiK2/DW6R8OMVsHnAx8VIw==
X-CSE-MsgGUID: MvuDraVZSj6F7vgfR641Dw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 19:02:05 +0200
X-CSE-ConnectionGUID: szTOWYV0RG6NjlsApLtnQw==
X-CSE-MsgGUID: HPXF/cb2TFSRHR6g+I9Msg==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces03_data.me-corp.lan with SMTP; 11 Nov 2026 19:10:02 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Wed, 11 Nov 2026 19:02:04 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Wed, 11 Nov 2026 19:01:07 +0200
Subject: [PATCH v2 1/2] riscv: kprobes: fix out-of-bounds read in
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
Message-Id: <20261111-probes-in-lrsc-v2-1-b2525b7e1e8e@mobileye.com>
References: <20261111-probes-in-lrsc-v2-0-b2525b7e1e8e@mobileye.com>
In-Reply-To: <20261111-probes-in-lrsc-v2-0-b2525b7e1e8e@mobileye.com>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, 
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


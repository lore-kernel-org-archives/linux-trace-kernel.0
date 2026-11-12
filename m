Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794477724;
	b=2sXh6jJDEhcZT9NBOaSAW/KFVDz6VYvjUBz7mj7SeXJrmlxMRG/rcpJA5lVI2PxmH82v
	 Pt1EnjoNVNeGi9Qn1BHLUuAypjqUH4BaOvo8qi3LuUaSsydHd+ZcoxSvtPwuavdi+DkMI
	 v27lhaN0p1bM/GblEKeeI7LTu9BWHWMT5B6SNsLJwKUDL0yw4m0H90G3BfvLX5Z+T7Rjj
	 ANiX3Qc6kT4B0fQf21xTdb+XwbAgWXivfp3uK4bflC5fM4wkHSMTtEKWUnKP87hEYIjXM
	 jDFcunlVT0J76mWm+Cecxn+wK6nTR0ZtNku8+9uEeJPh5vH/zHQXBJzZlYoQikiO9gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794477724;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=T0xvwAVAd10uIQD8+xR+pDRuZoC0p5eQwbtZ97QSn9g=;
	b=WwqIyMQvT82C6pmIs/nYiG6xWDKrLqzfXWZyOcdc2lZqgVq0i8RReQnbNKBM88R1/ViC
	 DENXS7FEZFBtV7gn0L4WWiZ9dki8zV98HlyyI951sQ8PZ2jbQaUI9qnXUaMGck/4Vf1XG
	 hxR8kExZD22uAH8I7KiJxxflHY9fAqUw9AnHwQs3xw8oMWbzNttboFsm2/a21B3d9BhHA
	 B/Wl9yVsotMSgVvvC0qeSkpwWqPB41Aas40l2xKoHFJNQB/t9wfvZk1o2i22dcqrbFueZ
	 aA+bRFfzKryzxe1EwbxMAg8zF2AN5+pMdK0s+DIr2HlvSxRXoPTr7q3d9TE4DeKDdCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.144
Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464F4606A32D;
	Thu, 12 Nov 2026 10:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 464F4606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1794477724; x=1826013724;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=YpC0OEjDp61x4WrPRvwkNA3r5ASkUlU6edCKs+rSt+c=;
  b=OqkeHBB9CjX32zYpDSL/VZe4BQy51gdUYt8cLN0juAUPo9/deoUlcnSV
   LIKIBpz8Esn2icrUFDaoDAH/IpTe+o23HCyh7tsirtRhBE8N6Ndmh9XyH
   UCVuHg40AQ2kQ1oYJtqHrWsqN+82SXtZz0UfczLJLQMhog6QKueezq9Yd
   Z4+aoroj/klAvIlC3u2luF9KVd1Jw4F6RKWny6yTtiO985YOouIpmXBiY
   jMuLLB+VGyXgQOzpovmagQMSoTekU8eVzi8drcyIfK6r0t6Sk8to/k066
   zjDoj0CkO+SC82U5zQRYUtwnABNlO3rbGFdmmgiGsqtC4n97ULapdcPDt
   Q==;
X-CSE-ConnectionGUID: 282oaaNjRsSWk8RHbGxu9Q==
X-CSE-MsgGUID: 2tmaI4BSQPmzEEvjnNLLug==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 12:02:00 +0200
X-CSE-ConnectionGUID: SjyM7SAtQ+OlhWgK67J13Q==
X-CSE-MsgGUID: hU6RHL/aQ0qgRa4niEPqMA==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces03_data.me-corp.lan with SMTP; 12 Nov 2026 12:09:56 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Thu, 12 Nov 2026 12:01:58 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Thu, 12 Nov 2026 12:01:44 +0200
Subject: [PATCH v3 1/2] riscv: kprobes: fix out-of-bounds read in
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
Message-Id: <20261112-probes-in-lrsc-v3-1-a95089852a17@mobileye.com>
References: <20261112-probes-in-lrsc-v3-0-a95089852a17@mobileye.com>
In-Reply-To: <20261112-probes-in-lrsc-v3-0-a95089852a17@mobileye.com>
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


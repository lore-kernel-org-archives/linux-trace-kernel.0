Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E75239E98;
	Wed,  9 Jul 2025 17:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752083803; cv=none; b=UF7/w8jKU6u9kxCBM46mRQzq4NyL+Garid7nyN43gKMNdWaQwQ9CKN38aiqtWO7JMoOb7gvZCUNUcOzrXBw47JAr0DF7IXp8AwlJnTmRW9d23XzQr1zAsbqzfG0DnP+eBZqgMcp1OQs9utjnQFvcqBbyKRuln/+u0HMS4F79RNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752083803; c=relaxed/simple;
	bh=FWBQX1/asfPTUJ186TDblgFmvHyPG/sEa71kKq0O6D4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z4A544Op5Ve/TJ9oi2N66zrHIQF2YCUwd/OAhCdsi9/PJsVWdttu+A1WQ5KbWRXqVvNuijWNZffn0Z7oyu9Us/LXlqIKgUK+con+/SNrXrjEqD9fOo2ihZggjnq6AfAjYPcvJQM23GHJecjNd9Nvvqr8dthyzKnfBfC9JVoE38s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L38JYFb8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4F2+5j71; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L38JYFb8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4F2+5j71"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752083799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EE8nze+dHV488yKI++rzQSjed2WDi861RqnjmSmBFVc=;
	b=L38JYFb8lgYDBXYxnCtNFrpuWGW19HPnD5144cJ2MQwSDv3im8/BVFP+/0vbMyWC5t8Qpw
	8XlRSBEO3ZdDuzSZeaDG98KC96cLh2i4M3/gQ7WortAe0g4iCqLLFgnjyxlsE2uoWFpRG9
	3KlzI6rEjhk0S8TikZVvngiPtnxe/oxnBUneVVR8QKiWJmgGXfEHqjNKLSSsRdhDiPZDUF
	IjVSHStnc+y87rwr0dhVF9Le55U+Qe/0QYbuta9E+Y7VZ9tUkufTxckwaT1zaj0OLylEX0
	3OSlvuPjSUXqkfmulySarsrHrWr1QHozwY8hGQORkj6nSLf9HmDYxI1f3V0GHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752083799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EE8nze+dHV488yKI++rzQSjed2WDi861RqnjmSmBFVc=;
	b=4F2+5j71TJDmp4MINN6fazxcHRAgFLBh3x+NKxcLaFUo8c2jd7mjtaLpA6fgBhg7gsxBVx
	7zI5jcA0GC4siFBA==
To: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org
Subject: [PATCH v12 08/12] riscv: mm: Add page fault trace points
Date: Wed,  9 Jul 2025 19:56:25 +0200
Message-Id: <11dceb5103773b7ba2234820a7f2f4aa3d0c441e.1752082806.git.namcao@linutronix.de>
In-Reply-To: <cover.1752082806.git.namcao@linutronix.de>
References: <cover.1752082806.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add page fault trace points, which are useful to implement RV monitor that
watches page faults.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Acked-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@dabbelt.com>
---
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
---
 arch/riscv/mm/fault.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 0194324a0c50..04ed6f8acae4 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -20,6 +20,9 @@
 #include <asm/ptrace.h>
 #include <asm/tlbflush.h>
=20
+#define CREATE_TRACE_POINTS
+#include <trace/events/exceptions.h>
+
 #include "../kernel/head.h"
=20
 static void show_pte(unsigned long addr)
@@ -291,6 +294,11 @@ void handle_page_fault(struct pt_regs *regs)
 	if (kprobe_page_fault(regs, cause))
 		return;
=20
+	if (user_mode(regs))
+		trace_page_fault_user(addr, regs, cause);
+	else
+		trace_page_fault_kernel(addr, regs, cause);
+
 	/*
 	 * Fault-in kernel-space virtual memory on-demand.
 	 * The 'reference' page table is init_mm.pgd.
--=20
2.39.5


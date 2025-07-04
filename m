Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4739A30749D;
	Fri,  4 Jul 2025 13:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635245; cv=none; b=oTZthLbv33Sjcq1woGcgKGSdHXEICFXsH4ey74SlO9sNR3UoM9jioyZLqZse+xCr7rqOP6HD3VF5Iwa8hTODjgDRuvBGqj4y+9sqEu4Q8fk2Fkkt6Migxl5pxnvgkO8yinRtzDLaPd0e+Lb7PHuyQkJZ41SddZ+UTxC0bKgciOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635245; c=relaxed/simple;
	bh=FWBQX1/asfPTUJ186TDblgFmvHyPG/sEa71kKq0O6D4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dOhOvS5AwVdd8BDsEIPt4YdDOHwUot6kPvt4GusWLjfpiYURSO3OGRA+ans0ebybAPVRmDB5uj3ByiFHR+TLvIf0SXDKWtQ4eXaCqt54Nju5rkEMZvUaRDK2bmSwp4Tt1ZBwJBhxgA5VY5Xr5W41erd+TVfJPmlfIcFkgBe42wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BdZMuLx8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FgxC8+w9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BdZMuLx8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FgxC8+w9"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EE8nze+dHV488yKI++rzQSjed2WDi861RqnjmSmBFVc=;
	b=BdZMuLx8cSXRL5EOMJAQ26EuaXJpzQsttckmE06bw/HAGjLRF9iAwRN9fxNaPyQv838kvm
	5Vlrh8g9JUuXPAsH/U7dKI6XTkpskUBziil2Rvn+FBPZWw5sBD8mzUh9ZDdiJDYl6bGjyQ
	eXzCzt7uOIObnj9t2YGxaN1tMNMdXPoSlzL7+4MTWxe6BDWgUTctzrk1y/HVPCaEgoaJJN
	s4XfOnZDLldBcLE1MM3NvzPTvDdFlDAgPpr9gcDJJ+gR88uv96UgcmJv7CTJAw9sUx+k2R
	iAYqNh6/10UXPCWDHYjJzAZlZc76QSKYyIBSgGAW9zrU+Gacp/Jz4mksLIBWLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EE8nze+dHV488yKI++rzQSjed2WDi861RqnjmSmBFVc=;
	b=FgxC8+w9z4RUHzTPkrnkogGgx03o6FFPgAURnK5rWK+Y/OBBxXCKWrHbsqZ6ruZvye7UDX
	N5/YM3gzDoHZZWBA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org
Subject: [PATCH v11 17/21] riscv: mm: Add page fault trace points
Date: Fri,  4 Jul 2025 15:20:09 +0200
Message-Id: <97604a88be30e672e40a0ddf02a1d5a623ed8c97.1751634289.git.namcao@linutronix.de>
In-Reply-To: <cover.1751634289.git.namcao@linutronix.de>
References: <cover.1751634289.git.namcao@linutronix.de>
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


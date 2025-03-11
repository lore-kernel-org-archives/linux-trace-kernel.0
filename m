Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8239C262804;
	Tue, 11 Mar 2025 17:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712733; cv=none; b=lBa54doUqgTRmJuvURfLREtLIl273eNVp5feZaiECK1xIGKXUzl26762guEHZvabY1MdPkr3mLocfeqTeYzscUlw/11D42/9S1ejgznZtvlBmttHT0VICxVsfaU44QX7C80w6nf0yAWmhR5QFbeKAMmfc5ANOmnbbqgdPTcDkiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712733; c=relaxed/simple;
	bh=Jq8ZQ0IhQ1yxtum3q/maWSWSnAIIZHjCL3LXJsYa63Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rnDEQzKz3MXxzqzyU6rR5cdV6EOD5ZZBYQFnHBBG5Pn/5fG4T1LD3QtMlk8dusMy/uwEaxZtCLUZG/7nSRPYBMqnhhFkm472c18OFfENq01QS/kGL2VmlhIN2cNnwtf1vm5E1UqXG6iMzYMO2bHStZQzioRL7Uv4ajU5qzrqkK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ucOxcmo7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R5Bt5FmJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ucOxcmo7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R5Bt5FmJ"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741712729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eXShVdGyHkymBrWxSB5AB2Yn4Vhhr4p3inDGKP7lxQo=;
	b=ucOxcmo7pEPwLOMGH7ybPgvjYUP/Y4xGR5SiB3jj/JBwJNlD+UccQbnovZXYlhW817Myit
	2jU86mFch5dc5nautbPZJCwOqTTBgJtWnLGGLxjSRsV89yFJf65ZQ6qXmy6bCJLBxYpuVE
	KxATNAu2yKbBq/xeFBi3pdyqQSC5//+xj/2ryCEOpiCdPQAng10Bwb+rbk/2Ixy8os90PP
	1rPe2Q6I67Nv7ljX6Sf0bmq4WBqgMfHv0JYjB1pcoDHnBslVQhn99hSkh/VgSUamd8oMpi
	u3z/j44cXQjeeTN6nlXf2BH2LfLke52vGCRSjWj/AZjNoquXDE3aW6Ns5owV0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741712729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eXShVdGyHkymBrWxSB5AB2Yn4Vhhr4p3inDGKP7lxQo=;
	b=R5Bt5FmJjoZpm+N1aXSQOGGFhU1AyycnUhZhcJsDD75Hk7fUKjaNBCBSe1aYf6P0hE2/N3
	gkwbrceCot64dkCw==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	john.ogness@linutronix.de,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org
Subject: [PATCH 08/10] riscv: mm: Add page fault trace points
Date: Tue, 11 Mar 2025 18:05:09 +0100
Message-Id: <672e2bed604c307c807f546627ba5a9454ef10eb.1741708239.git.namcao@linutronix.de>
In-Reply-To: <cover.1741708239.git.namcao@linutronix.de>
References: <cover.1741708239.git.namcao@linutronix.de>
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
---
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>
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


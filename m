Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BB02777E2;
	Mon, 19 May 2025 10:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747650485; cv=none; b=CzNxEr1SRNZ4G2LLuzy5cb9K6fnoCJlUAYfgYLCmENcN/lEHHuxb4D8UBc49ktyd9cwmoo5w8fdpptNGAeUPfLBzf8o/WCGI023F9kPBR4JLY7aEiODyveKU72lQCD44sr/uy0LgBPvCX13ONRrg2MDn+JelmMPptu8tt17DxS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747650485; c=relaxed/simple;
	bh=ZMuJcUkItQ8W/F+xCTbzqY9ZFtun/pwdeoRjY7+V/HM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xy5/TkSnXXqOzJneMcM5PpX0g8xjNZL3U2R/GxRgp0BHZS4/FtK1Yw3MHfUXQG0j9M7AYwtMrPsqayKtFMEEaYnQnbpmCPyqsfVgT2zURRbi55mh5/vKsLO17IkP6shlVLNMrGSrDvk5HgRybFVe4SCAowDM8JejyMK9BpR+aRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hvk5Q2g/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zFEzhtpH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hvk5Q2g/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zFEzhtpH"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747650481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vEiJP+aIWUlbRLvwbDSCG6IN+IdxLBx8kvf+B1WoqyY=;
	b=Hvk5Q2g/wL6Wqiy3SIm9MZuGOQ2ZZYmgXKrOKMRrxuFZ2af8+CP79RVyfQ1ybsGFUSD4fu
	U6ne2iM2Xeff3/5E219bNqCFW3pD5/M1OQgvUxENogQKkVVYzbZ0ebot+V8K35jSfYBtL1
	yf62Sb3U3+ytxfX2ZUWCs8M+UMiMPEqBGpa+AC13LvIfVG3lAyowIMu7fvCTInQbSgIDhp
	YrLSiKAl9Fn1aIbvy0BaDdaxJQ3vYZxWY/tC2N5TIeESwsImFBajQc8YvX1mBvlkfVjIip
	7FsV1Yu3RYauLGudpTIYWMrlP7943v2ak37vTMlCBO9MV5NxyQPvEixiUSjWag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747650481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vEiJP+aIWUlbRLvwbDSCG6IN+IdxLBx8kvf+B1WoqyY=;
	b=zFEzhtpHsZs88fszWxLk8SWpPXz/ZZhmfZc518QIwQ3VfnRzh+zA2Xf4SACearnCuZCJ0p
	gZYFTRl0sPGnIIBw==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org
Subject: [PATCH v9 18/22] riscv: mm: Add page fault trace points
Date: Mon, 19 May 2025 12:27:36 +0200
Message-Id: <f723de2597ed0dd4ab75e31de36a3932e2848ae3.1747649899.git.namcao@linutronix.de>
In-Reply-To: <cover.1747649899.git.namcao@linutronix.de>
References: <cover.1747649899.git.namcao@linutronix.de>
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
---
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
---
 arch/riscv/mm/fault.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 0194324a0c50..03b048108896 100644
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
@@ -288,6 +291,11 @@ void handle_page_fault(struct pt_regs *regs)
 	tsk =3D current;
 	mm =3D tsk->mm;
=20
+	if (user_mode(regs))
+		trace_page_fault_user(addr, regs, cause);
+	else
+		trace_page_fault_kernel(addr, regs, cause);
+
 	if (kprobe_page_fault(regs, cause))
 		return;
=20
--=20
2.39.5


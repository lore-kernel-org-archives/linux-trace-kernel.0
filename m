Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D97226989D;
	Mon, 12 May 2025 10:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047086; cv=none; b=KAoyRUl3sZcoPKiIuBoG5PjXlfQtD5+eCiA8LDOP9fCN/AxITNrRR//MRn+6g8sHA2WuHANaQcOtFJr4pWD49upda49uYsU85T61lflcgP7JerOcPXi2lDMealmON1Ey8ONAWhp13UVr9+Rl9WmtY4xk5Kxg/qKummAUc71LWAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047086; c=relaxed/simple;
	bh=kqcbhOu8kIZHISvJo8KAGZrL33iqXUCCx7EkZNU2zjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TnkYmd4uVjGWVoBNhi7KQiYq/oMEY+q7QCVTiDBGwoXWBq25kQaZBh1X0pkyoY3Y3giT6CCniSgvTdk+uMaQ6MRJ41ZqhJkyy2gU8RHmlR13b1wVOoOWS5/07gvO3/J63GT/Hw1A5UE0AB2wqzbjENaIt74rzVrVtZiblqQd98g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NJPjJ6l3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dji95j+H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NJPjJ6l3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dji95j+H"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747047079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yZnTmXXPPJ43/SdX9l5xjKLxTpAA3+OeMalQ6WpsFjI=;
	b=NJPjJ6l3HcVlf9x7yzLY6lOv0vLQF3BD1NT3n0vVucsulJ3ZbQoD2EdEcJ4Vgtq3Bjn7rO
	HpmT7KQ/sdjY9LoxGlXs+pvfNhVaQT4wYHSA+lra2MKx3faQiKCuQAgbZOgDQ+5QZF/GeG
	fNYQb0pKrYtrv5T0Gwpy36l05exJBqDDL3VPWTjOGAQ+6oMT7S53Eu8YmqNImCkHjyAsDY
	nfENxMHw2o/juaqGgbAvmnx8NL75nhUE73C/LbSidz91NbnBVh1bTWyBrpSt2Z1SRv7PEc
	wRSrB7TgZTL3MOIkOOkVezlAHDUmkrs7eaePFBZFKw6mwMbxOv7CXmU4pTLivQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747047079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yZnTmXXPPJ43/SdX9l5xjKLxTpAA3+OeMalQ6WpsFjI=;
	b=Dji95j+HM2jVtEbCTKaQFGw1LFbGxnHkrzG+jOZG1qWr9mD7mZL8ru7KvwyBj2Yx/bk6Xe
	tOCnZ2zyHZ3+eDBQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 17/22] arm64: mm: Add page fault trace points
Date: Mon, 12 May 2025 12:51:00 +0200
Message-Id: <f5fccde2326a896e5c568ef06a4dbd9aa7465f6a.1747046848.git.namcao@linutronix.de>
In-Reply-To: <cover.1747046848.git.namcao@linutronix.de>
References: <cover.1747046848.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add page fault trace points, which are useful to implement RV monitor which
watches page faults.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/mm/fault.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index ec0a337891dd..55094030e377 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -44,6 +44,9 @@
 #include <asm/tlbflush.h>
 #include <asm/traps.h>
=20
+#define CREATE_TRACE_POINTS
+#include <trace/events/exceptions.h>
+
 struct fault_info {
 	int	(*fn)(unsigned long far, unsigned long esr,
 		      struct pt_regs *regs);
@@ -559,6 +562,11 @@ static int __kprobes do_page_fault(unsigned long far, =
unsigned long esr,
 	if (kprobe_page_fault(regs, esr))
 		return 0;
=20
+	if (user_mode(regs))
+		trace_page_fault_user(addr, regs, esr);
+	else
+		trace_page_fault_kernel(addr, regs, esr);
+
 	/*
 	 * If we're in an interrupt or have no user context, we must not take
 	 * the fault.
--=20
2.39.5


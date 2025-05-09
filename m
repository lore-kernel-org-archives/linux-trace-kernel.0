Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1C6275845;
	Fri,  9 May 2025 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746778370; cv=none; b=vDPGp+CXRzo2WMl+C7KfFQERbk8GzFPXRLyzM0mgK/CTJ14tJw4xe1Woh36t/qHZgxAHtY/EutWp0ZnN4wWig7sXVeM5Uq11nqzCQA9lucoJeWJnfe2hFhH0TZgWHi7of5ahag/4GXbqegwY0VAPcDW3eDQJof+0a76x2pQ9Tlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746778370; c=relaxed/simple;
	bh=kqcbhOu8kIZHISvJo8KAGZrL33iqXUCCx7EkZNU2zjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HooblwwSMPfv0LrgB4Yty49D73tFG9Xu3ZEqaIzl+swoRgkppkhhxJzyF6OyIHNZzgtHQyO1uhhLX5Hjj+gv9+1Gy0vLaYJ7w9mIk8KG44pm8Rr8OF+Xa4Fh3McMwuJJIq8yJkxMMERB/zcNt+SyhtZdPiihpFMm+xMuirWKs0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ERcFm0/B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+cYstsyf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ERcFm0/B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+cYstsyf"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746778365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yZnTmXXPPJ43/SdX9l5xjKLxTpAA3+OeMalQ6WpsFjI=;
	b=ERcFm0/BEKXFR1FrPIyCwD8GdKDiCufdUM7t2JzMveVgQGBrg57Xw6Ovdgb4fiEVp857wa
	k3gZq7uNbBjMtK6b7sMHyw6Dc51XKAJF46h7EkjuWztwlErpe6uI16icJXn7rJFS1T/pvW
	3QRFn3YEWG8W2DwpU18FvEU84QJ8AeQlIXuUFttchkF9MXK19Om3j2/8RcJsZOXsPFMM92
	NL0GNBI/f032z7g7Q8rBV3QJVq5ku5ruLW0gnIt3LeX4jFaXJLP0R5Hw0PHWMvaVCQ363P
	xJ/CLZ7CVNNXJa2Meb/mBULDF4RS/Ejcxf1Ggjqj+tWwLCFyoNwPECVGnSIbrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746778365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yZnTmXXPPJ43/SdX9l5xjKLxTpAA3+OeMalQ6WpsFjI=;
	b=+cYstsyfZZFfEwLc1Ompdly32t1bqmyEMxr6S8moOUP7Ibr3dr774sVtaonECzeQ6oe6fa
	br3hXiinqj5ZVdCA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 17/22] arm64: mm: Add page fault trace points
Date: Fri,  9 May 2025 10:12:16 +0200
Message-Id: <f891fe7b845d47aac4cbda8c8b562dc2eaffd86b.1746776116.git.namcao@linutronix.de>
In-Reply-To: <cover.1746776116.git.namcao@linutronix.de>
References: <cover.1746776116.git.namcao@linutronix.de>
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


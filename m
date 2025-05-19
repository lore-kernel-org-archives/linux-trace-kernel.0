Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AE52777E0;
	Mon, 19 May 2025 10:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747650486; cv=none; b=L7TY2Y34QHbtI4hQrtSfBFUEFUe9pesmFUHTTz7OpJxIgwqMBE2LDNDurlgxah7hx7qwvfenQnzmK6Gyxh4ytyGRDUTVY8XMhXh8Jo5z29Qh4f12VNV0NREyQh/6C1TreQ59D1tAXO5sxKsVkg+eKUZqZa9KmC6HtCUZN4xH10Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747650486; c=relaxed/simple;
	bh=eZxxiKGqQ/QTVi4Avd2yGn2Cm71aQnObPJKFhqAAjPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wo0JhT1ZJ+LEFHwGYYe9wxBSsBKfzDbc36SFVx3gTMRh9p6AfFJOFc8mzBT9u5oym5RVvN8Tuq9c3ybwIZ84vlGqyOG2ztn3I6MXlRXl2JIlAVXDYNnB/1b4DXPzJHs785Ou/kc97SnuadnX01H+k2OfKTl+S0fhV0QfkpPyzD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ceu+HyWC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zn2+c4Ut; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ceu+HyWC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zn2+c4Ut"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747650480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1s4J8+MAyFkF3goFas4gGHMp93w0ZNiv4wTpWgOZ7sU=;
	b=Ceu+HyWCYgir8PXGwjUyJDqGnLjj/x3siSqj3We2wY4H7/muE3sLh1CFTE/kJbvadOHzl1
	vWrT9wwk2HuC3avaOSi1+2iZvLIrw6cBaJO32Z8wkjZkZ6jCjAvWzgj00Wt9lUt8xGmceU
	1l1l0+r4XlGCx0uQVcCEimcufoPuzPeGgrKtumSD0oXsI6hf1ZZDCsa2bITENMOVQFYDKh
	h/mmTtufFOaj/J1U2yLL864EcW4xh1Tm7S44LrsiVyWTbFKjwQ6lA13v4VKat7bfSho+3f
	xzRZp6pst/4ckX+NeYRIiWWB6dLGHHXsX5u6THgO67LOnF1fYU/hXfkmF7nB0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747650480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1s4J8+MAyFkF3goFas4gGHMp93w0ZNiv4wTpWgOZ7sU=;
	b=Zn2+c4UthRVDA34nwJzvVAlot/klhx9/2sOsjdAmkeKmtyC9w019CossNX+8zm9lAR4UN3
	X7ti9LK/iWkxkhBA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v9 17/22] arm64: mm: Add page fault trace points
Date: Mon, 19 May 2025 12:27:35 +0200
Message-Id: <61063f55e2c2df6db69cb63eac9d6653f38fbfbd.1747649899.git.namcao@linutronix.de>
In-Reply-To: <cover.1747649899.git.namcao@linutronix.de>
References: <cover.1747649899.git.namcao@linutronix.de>
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
index ec0a337891dd..d917556869f9 100644
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
@@ -556,6 +559,11 @@ static int __kprobes do_page_fault(unsigned long far, =
unsigned long esr,
 	int si_code;
 	int pkey =3D -1;
=20
+	if (user_mode(regs))
+		trace_page_fault_user(addr, regs, esr);
+	else
+		trace_page_fault_kernel(addr, regs, esr);
+
 	if (kprobe_page_fault(regs, esr))
 		return 0;
=20
--=20
2.39.5


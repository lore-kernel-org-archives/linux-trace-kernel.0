Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE191227BAB;
	Fri, 20 Dec 2024 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716868; cv=none; b=mtmAP9NP+EOeCjt6roqSZ2wZbQDeV2JpRKsOsQNm6pTdX6TdXUasDjeDrbXnHJCWGDwvYWiWCBiihHAE5nqsXhM6iO7EymWGSmB8jEtz62/MC/3hbcpUWfFlZnmVD8ihTSspCh7As4CtNMDFEo56SdrDCBQdrVUlaxAm/w/zXIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716868; c=relaxed/simple;
	bh=ZCYpbinhL6uGHkLuSdwWLthc9rjMA4h7HhoINLswtfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ph/TiwB6OhBGblGJg0eVSC9N2btHwGwZuKPm3kntx/HDZ9PSC4BPjnfVA31yIEDywY79/GD5ABSwSAG8msr9mKgHg8giAIX1onPISqjKG0RcVuCNSB/WI7cxBiZl5UBhvBMSP6f37dXWomXaCwUQ5Vm1yYXhEt7xOZVRWOzbThQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dr+7RMQB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AZSx8zxz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dr+7RMQB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AZSx8zxz"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734716864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8cOfqq93x0oPQPFrMlSeinUf1WhvLlURcCwn2/B9V34=;
	b=Dr+7RMQBSI0JHm4g6BniB6jZDFuoF+xofjsoJ8mUEF2oBm+1pGpYluIuQVawxnxclkoWaJ
	+HHeJBPpIxk7UerRguKKBX73oK4rTa/opx2cKh9HdBB6ModF7+KqAqvujSc+c8C7E/GEB2
	2P2Z3sAj93+oQ9J0lHeDlAqnaBLZUnzWVGNB5byDwB7t2xlZvn00gNvuJb8rFdpBjx/nfJ
	nakdz1wMlCaf7VD5ufRxyM5CrLVZAFX5mCYHZEC0nBMOkhCqK6c7JGVPG2qOYxb23Iq8bI
	DxnpERqrc++5KxybwLFKL9NKo0xzTZE/KG4CUYbw2mnFxT7hApBL8P6Z7hhqLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734716864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8cOfqq93x0oPQPFrMlSeinUf1WhvLlURcCwn2/B9V34=;
	b=AZSx8zxzXWRhcOocsxUzld2ZvnNF5RCFUWhKFiEwKDv3uSi2sPubKCRsLiteienIG1tdMy
	8jLsoA1ckq2ECHCA==
To: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Gomez <da.gomez@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Naveen N Rao <naveen@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 20/28] powerpc/ftrace: Use RCU in all users of __module_text_address().
Date: Fri, 20 Dec 2024 18:41:34 +0100
Message-ID: <20241220174731.514432-21-bigeasy@linutronix.de>
In-Reply-To: <20241220174731.514432-1-bigeasy@linutronix.de>
References: <20241220174731.514432-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

__module_text_address() can be invoked within a RCU section, there is no
requirement to have preemption disabled.

Replace the preempt_disable() section around __module_text_address()
with RCU.

Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/kernel/trace/ftrace.c       | 6 ++----
 arch/powerpc/kernel/trace/ftrace_64_pg.c | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace=
/ftrace.c
index 5ccd791761e8f..558d7f4e4bea6 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -115,10 +115,8 @@ static unsigned long ftrace_lookup_module_stub(unsigne=
d long ip, unsigned long a
 {
 	struct module *mod =3D NULL;
=20
-	preempt_disable();
-	mod =3D __module_text_address(ip);
-	preempt_enable();
-
+	scoped_guard(rcu)
+		mod =3D __module_text_address(ip);
 	if (!mod)
 		pr_err("No module loaded at addr=3D%lx\n", ip);
=20
diff --git a/arch/powerpc/kernel/trace/ftrace_64_pg.c b/arch/powerpc/kernel=
/trace/ftrace_64_pg.c
index 98787376eb87c..531d40f10c8a1 100644
--- a/arch/powerpc/kernel/trace/ftrace_64_pg.c
+++ b/arch/powerpc/kernel/trace/ftrace_64_pg.c
@@ -120,10 +120,8 @@ static struct module *ftrace_lookup_module(struct dyn_=
ftrace *rec)
 {
 	struct module *mod;
=20
-	preempt_disable();
-	mod =3D __module_text_address(rec->ip);
-	preempt_enable();
-
+	scoped_guard(rcu)
+		mod =3D __module_text_address(rec->ip);
 	if (!mod)
 		pr_err("No module loaded at addr=3D%lx\n", rec->ip);
=20
--=20
2.45.2


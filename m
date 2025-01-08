Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B121F8924;
	Wed,  8 Jan 2025 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327126; cv=none; b=Una/u4/wkoQ5IlhP4eFl9bhu8do5aDb5y3MelpiRxbS7IMXgPrcP9E1vios2tN7/Y77xU8cKBm/UUUDHOl1mKx3tUskDhQ/e2kpsoPXRiIAsOpIZAsvRChGNIdUEG2d0jNjvh69GpfBvsCGJ4xXZoGTzZVb8uVc9BgxTXW6fBS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327126; c=relaxed/simple;
	bh=QLtectwvLpXIdURiO0vN4A+c/rzqgAPwxEpJeUhAO7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EklHxS1vUdjh1goZQQbjoamthwrsaPyU26yr9Jm2uUFi3haQQPeggnHZuAhdIA6Uag8drmXUvHe+mMajDBdbdzOc131r2LCTFmWb9iSEIEwy0uSToRPj6AVE3PnIgXRwKVw2/3smSQ0j/mztzS7+AqZNPWUp85+ObIMRQ02uz1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LEApxjYZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dKYJumFF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LEApxjYZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dKYJumFF"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736327122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rwBYB6GDGtwSo0ZVmHQeUUNLy015tLjU3w/e5JgGy/c=;
	b=LEApxjYZTkhUm30+CjLuvcHX5E2bkNJXnvyUNg8o7S/Fx61HuGetUOphWXxK7KkRlZqXpf
	HIajKikSPhM8iYZN10EyVeaIzc72/iuTnHo0mHHluGSqAyHpEEYIRDomEhG9ucd0bA5QNe
	mRPhhSVD5Mw3kKlEi3iLDkgTEd9R0q6Yh3r6PhO3zt9soyTkYfj7cbuQJvgsCtqdXTTnlw
	ziHMU5S1znSAkYMIhcFJfJmVQN6bapUF4Om3FT+TXqop0bh27OgxrqxKTt84hR6nd7BVvF
	tLQEVolIS16851bhceciMfsJOItqvtrr+VnjFSLqFCRl5W7HJYyANETR5/2Arw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736327122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rwBYB6GDGtwSo0ZVmHQeUUNLy015tLjU3w/e5JgGy/c=;
	b=dKYJumFF1zyEaO2G91SGXq3IYr7DTmPO/R3ooBrOdSFGUIexbJ7PDdRkr4PzJr+nPMoUvE
	ybGJf41RElFb2sDA==
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
Subject: [PATCH v3 20/28] powerpc/ftrace: Use RCU in all users of __module_text_address().
Date: Wed,  8 Jan 2025 10:04:49 +0100
Message-ID: <20250108090457.512198-21-bigeasy@linutronix.de>
In-Reply-To: <20250108090457.512198-1-bigeasy@linutronix.de>
References: <20250108090457.512198-1-bigeasy@linutronix.de>
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
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
2.47.1


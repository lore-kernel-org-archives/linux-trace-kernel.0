Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730D01F8900;
	Wed,  8 Jan 2025 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327125; cv=none; b=BfCV/+1vj/5O2IFUQ7S0SKYt5xHXC/cJPwC8zFFzKrzMGYAh54z0yZw08LiVIr+Rpcp4XEQtEsBHyYwbuTge3fC4IBu8Y278+GQZ2e5L18RRQrnbJr7aQeD7k8HxrFIMR0nMOLm/7fDwlaWeaMcCTQR7ZddBjCKVrKtdv6lyR1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327125; c=relaxed/simple;
	bh=JMLSIq4XCqh7X46oF8dvRjupa8G10AN+Bi4dbH6ayzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GljypC4TMdKHbQUTy+Ymfk1eWANd3ShyWh8TYQFMPojM1h/uB7i/a5nizrvj+rZDz+xNV6x0TunaOIDv6Ho+y7KP7sN1CF3aumtxra0DIeUk88UXRLH84g8q2nzQg2bDFg/WaDROYQryErDbOfNPCJ4mAurOyNk4w+IYEqX6wII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zeq82ZZt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o9rVqG6g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zeq82ZZt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o9rVqG6g"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736327121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dKkEa1oBjIwyFreZFvtbWG1WNxqNuZKzuLQp9IQamCY=;
	b=Zeq82ZZtfycF+dEkhvnQG4m5Gm/Dg336iRPpNCa0jIIynUDK44CLaWcEHM91iLvvyVeDwf
	NRZdcAl0pca++p4iXsTy1ATeNGWQ0/ttOEarFzUqIaQLSXgLGkLjRtrObC8AUsP16pSHl4
	A93Z/xemaCJmcGKVUSTlDyAxp1RGB7VdiBSnn73ZwFXLJl+ggc+UB38zEeybmelfsR82Oh
	lBe0gsu3NkVEDGFh4ak12MI1+L1bJg2JybDwqVktkHEJnrLbMEebPLUZRv7A1tv5z9QURT
	rDyhVxLNQiChLewieqy0QvpLZv1OhExoOvlkAfkAIZqeAI6F196664v7KmzUdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736327121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dKkEa1oBjIwyFreZFvtbWG1WNxqNuZKzuLQp9IQamCY=;
	b=o9rVqG6g7PSN1elXM/7opz1M1ZZG8+lypfGps76VIls8huRnp2KWGJw/AyhZ6XhIyzGHkr
	7w4eXU89djJIcTAg==
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
	Huacai Chen <chenhuacai@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	WANG Xuerui <kernel@xen0n.name>,
	linux-trace-kernel@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH v3 19/28] LoongArch: ftrace: Use RCU in all users of __module_text_address().
Date: Wed,  8 Jan 2025 10:04:48 +0100
Message-ID: <20250108090457.512198-20-bigeasy@linutronix.de>
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

Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: linux-trace-kernel@vger.kernel.org
Cc: loongarch@lists.linux.dev
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/loongarch/kernel/ftrace_dyn.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftr=
ace_dyn.c
index 18056229e22e4..5b7b8ac13e350 100644
--- a/arch/loongarch/kernel/ftrace_dyn.c
+++ b/arch/loongarch/kernel/ftrace_dyn.c
@@ -85,14 +85,13 @@ static bool ftrace_find_callable_addr(struct dyn_ftrace=
 *rec, struct module *mod
 	 * dealing with an out-of-range condition, we can assume it
 	 * is due to a module being loaded far away from the kernel.
 	 *
-	 * NOTE: __module_text_address() must be called with preemption
-	 * disabled, but we can rely on ftrace_lock to ensure that 'mod'
+	 * NOTE: __module_text_address() must be called within a RCU read
+	 * section, but we can rely on ftrace_lock to ensure that 'mod'
 	 * retains its validity throughout the remainder of this code.
 	 */
 	if (!mod) {
-		preempt_disable();
-		mod =3D __module_text_address(pc);
-		preempt_enable();
+		scoped_guard(rcu)
+			mod =3D __module_text_address(pc);
 	}
=20
 	if (WARN_ON(!mod))
--=20
2.47.1


Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA64227BAC;
	Fri, 20 Dec 2024 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716868; cv=none; b=peH7w+YRwWZZc/3qQ5kEJ2l5BD4xz+goxre2/YM1MozhiRhKzzZnuZbF3dyMlfkgpwBRLfRnwtlnmkAhC0Nj0qSw4GYGH6nEU0RV7GKmzx+0bUdjH8UtPztiTLNTBwUJ6s1CPKTwQI150RqjpvutWR1jZNAmANfkZpVIL8yLcqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716868; c=relaxed/simple;
	bh=ttlHFu3gMwY1VQt+XZunT0z7GD671/sbqto0CfwXAa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jwHAJ+oWRNuwEhr04MbJIMTFFzKZLN/RUg4hfHCSgT4x5QpzpLTBIJ/oHQXFPXgrWnTfp3Y/I6yBvguFYvCf2Umm9IPGNga6NDqUWonZhy7m1F+DHEwt+NB0CE85GJGx656ct+F4fhMgMBYkOf/16rXLNmKqoHziuixdMlEPSq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u1Gg5xD+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C5zOkrNo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u1Gg5xD+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C5zOkrNo"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734716863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aq+7SEGJUTKa/Bn1/z1CJTxjtvmAy27khjcI6tCzE7c=;
	b=u1Gg5xD+dhrMVIMDZUPbt92FBu6s0DSjzHyIfRQsJL6kMqK5HQ/fRk095USwc8UVYtZaK0
	DmvD4X5fkMeVM3CXhaLUejVoF6634jqwUCYcdJynLrVdDaTn/urwHrHVcJ35iiK/HtlEaD
	mjIbPzj3AIFPDax5MxgFHsqSp7jB0FF1daE8er4OZwkEGMWM+Rf8hreXUiyhoBH9yMmWCG
	sH7o/UJj7JjE1H0wbKMGZsDHqnhLlJ0LJVl9YLGksgYC8xkaXxMABDF2z41QNg7MQ0rL9D
	SlmDwyW0Chd7KaJL44jdstaVNsAwDXOHgQqS5g+PlCYcDzvNOqjbfy2suOVUVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734716863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aq+7SEGJUTKa/Bn1/z1CJTxjtvmAy27khjcI6tCzE7c=;
	b=C5zOkrNo8i3Cb9FVlv34sBRm+FnOtE6B2tBlfe1LezVq+IYoO+Ue7rq1dFFysL+fAv9LP5
	D6vM0gELbS9VD2AA==
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
Subject: [PATCH v2 19/28] LoongArch: ftrace: Use RCU in all users of __module_text_address().
Date: Fri, 20 Dec 2024 18:41:33 +0100
Message-ID: <20241220174731.514432-20-bigeasy@linutronix.de>
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

Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: linux-trace-kernel@vger.kernel.org
Cc: loongarch@lists.linux.dev
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/loongarch/kernel/ftrace_dyn.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftr=
ace_dyn.c
index 18056229e22e4..5e0d870935542 100644
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
+		guard(rcu)();
 		mod =3D __module_text_address(pc);
-		preempt_enable();
 	}
=20
 	if (WARN_ON(!mod))
--=20
2.45.2


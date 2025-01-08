Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C72A1F76D7;
	Wed,  8 Jan 2025 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327124; cv=none; b=pIIC48rWaFmNTHY1VYrXkfcsEpXcuAxL5T1DXLBbxXP1GQeZRn59sXKYO2mzmHdMKIs54lP+jBh5WitCbP0YhUvPrN+8WQkqG7nVi3GArt+90RbqKeW3K3vSCrwePLDuoT7skzrgsFrksrrHRCBLe34ouOtnpAoiyUEPhGnHgro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327124; c=relaxed/simple;
	bh=xNkHK5skl0w0C9lJamZwTCTHZMhBReuD0NcedcOei+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mj5POqZflDGbKm4gSILhemyMgtjlHZXM4iipaKSNPFj91yg0hVXzubNVNTAw2+LCAiowphN5a4YjSmY24D+km60TiauhU7EaGh7FgDsBz/6er9/9TPegeedeNyqItFZnVjpKCXHYDc8uNi47/LqUrBvno5S1MJi1QtbKgz0yg9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qZGqUNiL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JhnK0Yu4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qZGqUNiL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JhnK0Yu4"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736327120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=luYbbdZNCAXl/IP2EISod9yvpOfM235A0wCO9dfQi8c=;
	b=qZGqUNiLevk3ULvmOAgodsKpMRTtpdv6zZ5qUtcVO8ZwmriORfqt+BAiiwnzpFb4pj7wGJ
	qqIrEs42Lod/4DpYI4l0IL434kVxZV3x+XaZ3TbpdcrNBYRR4lP0VEUHk8ZUzgfPd+3/MO
	a+FI63LXtZjf0rHQ5aK2L0M0T1UZOb4GeqtD3Y5HvX3pJKhuimEoUeA/AhEZjRj0pYyfL5
	+amDJ/rpmcycJ3/zeQNMje5n0Xnql5aGiTx6ld96PiO6RPYSW/AGgTbzc8k2h7yTa2mj4E
	k9ofqTkV3//mwiIDmmTC20MOYsAaVNPdrp5VNOXL6tRR872cXmzwLhnKHPnm7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736327120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=luYbbdZNCAXl/IP2EISod9yvpOfM235A0wCO9dfQi8c=;
	b=JhnK0Yu4bXTsTOoq/2QpxdG2IUFKpBcbjrCKe3W7xFQhlFCjP6V59gChgnIT16k/VUPy28
	I8OAkeg4E0fvk/Cw==
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
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 17/28] arm64: module: Use RCU in all users of __module_text_address().
Date: Wed,  8 Jan 2025 10:04:46 +0100
Message-ID: <20250108090457.512198-18-bigeasy@linutronix.de>
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

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-trace-kernel@vger.kernel.org
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm64/kernel/ftrace.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 245cb419ca24d..2b76939b6304f 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -257,14 +257,13 @@ static bool ftrace_find_callable_addr(struct dyn_ftra=
ce *rec,
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
2.47.1


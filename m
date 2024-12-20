Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4816622759E;
	Fri, 20 Dec 2024 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716867; cv=none; b=rZ+PtWVG/+poEXU0NtJ/HHZJqYYN2SuhmGFjef7rC6ifJ10dZbp2Ji73Xk0p+4CPJwPBjQqmbJxe3dvd7vo+NnNOlpeiYlfOai+NehDSST1IN00YhQJqlgFoe9k3eHvkCaqXQm7E/OVc14HyI+T7lKLkzvdLUEMDmV+Xe/pvz4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716867; c=relaxed/simple;
	bh=nijB/UnysS7vk+pFqu8+upO4BLDrLMQWbB8mD4qf/88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGNl/n9Fc5fd9a1WVhglWUrqQv4ChjOscp8b+0W9j+oCf5ZqZRXcSbmRKh7uxUu6UHg1Oj6j5ruwck4xuKyQpKIEwYgshSKMKzQMlSLm4TDA6nWsd1OtPkiEXvfDoL3kCHHFBaiHA8C1yIB8VqfJtgrKiG9piPszeolc+em8d1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=On3qaA/t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wP3SU0f9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="On3qaA/t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wP3SU0f9"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734716862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B42kRDJLK5sW+Ny84inWQy8805pd8AwUNUb75zPNPLQ=;
	b=On3qaA/twJ77SLnuRkru+5uQE5ZKBQhFay/+nLBh6xN3SX7UJftST8sHfDPa7ea47vdNAZ
	idXh9UZrztg2QDpZqo5r2KDtqUdUUQy4DZW0/Q2kY3288WC8tbh+komb3VRtgLX2X/+eLV
	6gh5IiEbq6BPf0yzOqrCLK5mbo4GRvQoX1Q46SArpUKYkMbU+6gA+M7jKFKSBXqXzB5bNi
	J89qbyLyottgcWoow0Kz4No4atEU0CLK369SKj0d/7AO9q6Ro7NM21+G1Ovw0F4seLlS4T
	5faShVWC0FjU40sPhMXVi6QlMhr8B1f2wrUhEvXiYW905avRmgk16GoBN3lLtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734716862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B42kRDJLK5sW+Ny84inWQy8805pd8AwUNUb75zPNPLQ=;
	b=wP3SU0f9++QJgKMFDAs2/M0ayS1yvZ1EajxroFHRFh/A4bAKgjgkMzUWuOJ+6W/3JOSGb6
	Iya0Jf1kXqQFcjAg==
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
Subject: [PATCH v2 17/28] arm64: module: Use RCU in all users of __module_text_address().
Date: Fri, 20 Dec 2024 18:41:31 +0100
Message-ID: <20241220174731.514432-18-bigeasy@linutronix.de>
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

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-trace-kernel@vger.kernel.org
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
2.45.2


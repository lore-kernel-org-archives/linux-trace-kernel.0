Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA87E1F9F64;
	Wed,  8 Jan 2025 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327129; cv=none; b=nSDexZm1ANaz3f9MqqPBXdvoTlysxhCGD2gIns59sqaFjNPE3hxHnvypWwuS/xifV3kJqIyGngqhTKOnO0l1FxUscZ76xtXVaCQ6OAEmE+tW6OOAXfnEQJYs3bfknig7xgsh+dtOh5l+xohxTLrU7WDNPOu78wSfWTV5X4uOr9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327129; c=relaxed/simple;
	bh=zhuCTsrhq1sNrdJmokFlAoIEp1UlB8V4GeZJTffN1ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUC8DgVu/KapgBzlnnR02PNx7VM27+OZQ1AYJUn/mUm53Tv2E82pnqKlPNInSs3gkaEG1rFzZJ3IuoJNhTZcuyXVWFWzYisZU7wL5uljj3S+nRHCbWVZg/EVkHAW4FZKKtZD2CKFu/YKRXWLCjp3PIhDQo+TWVcBBzYQ+GySUoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kZCak5YE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cN/CNFCB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kZCak5YE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cN/CNFCB"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736327124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VX0vljVHwWLPf6RRFuZ5ON1QvJx256zYGCAz24C+oI8=;
	b=kZCak5YES3w/CPS981gos2Cz1VvOvyEDTa+/ua2GkecyY2LbWcSr52H9Q3Vo3eDRBkgO2F
	7qRqZn9GBRZOXpBIeikBTqwBhbEYqYw+OQ/Wb5JW8wbpwZfgfRX8y7wSOXIkJNqmfEZAaB
	2zdBrO7hM7PuXbRg49MKpyWjJLYEmx0IRbM9R6D9LKfMaWfmYvtXFNeMWpSvzyV6rFlVTR
	0pvLewAQZN0GcNJsZQ42vnwYQNMT2b93+IjaDepIVo050iVG1uR/kN2JOjqNEJ2ukjH091
	6DC8fhtjbqnwcQhWI2WQOiz8kKGNheNdOA+x4O3mRu8nOgqkfZpIGjZkuGQmrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736327124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VX0vljVHwWLPf6RRFuZ5ON1QvJx256zYGCAz24C+oI8=;
	b=cN/CNFCBJOLmcq/uSXT6xcI9WzcQe8fkL1ve5n6I/VoNQPGKWOJpjQcPHxg0GJIaJxbT+M
	Jg4LK4/ad0fzs0Dw==
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
	"David S. Miller" <davem@davemloft.net>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 26/28] kprobes: Use RCU in all users of __module_text_address().
Date: Wed,  8 Jan 2025 10:04:55 +0100
Message-ID: <20250108090457.512198-27-bigeasy@linutronix.de>
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

Cc: David S. Miller <davem@davemloft.net>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/kprobes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index b027a4030976a..22e47a27df4aa 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1566,7 +1566,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	if (ret)
 		return ret;
 	jump_label_lock();
-	preempt_disable();
+	rcu_read_lock();
=20
 	/* Ensure the address is in a text area, and find a module if exists. */
 	*probed_mod =3D NULL;
@@ -1612,7 +1612,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	}
=20
 out:
-	preempt_enable();
+	rcu_read_unlock();
 	jump_label_unlock();
=20
 	return ret;
--=20
2.47.1


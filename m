Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B142BF3CF;
	Fri, 11 Jul 2025 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752239870; cv=none; b=I3+TarBr06U5zf+KkAbxJF6dlPnG8mFRp1QeswFtFCK5ILQmUCncCkWB12RLST5AGjBKlehLH1CUiDi2icW7BxmEGpgfcRkaGgcZM47RW3wUGWYd1OWc6Pxwv+TFjuomzFTgCgtD3iZWd0G/38OkueOASJrxBpQgri9D31Su3zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752239870; c=relaxed/simple;
	bh=2sx+KHYNlqmjmePdZpE8eMjypL3Mb80fn3kZxiey0PA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LCIjwRg2UChOtFxNMNCRzY+k6Sd1wu4Dom7ThN6Hnvy/6kHlinDWuOphHClRLxBZvsgmxQs97HsrelQKtHDIGKcfAyALQD7LiZUU+wP8CBF02l1peeNuh9ZpsPp/prWjnltv9ez4H8xUULRNEXDSxHKxlmb+TVeEHDd1g3gkpGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qkn4WlHO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ho3SL/ik; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qkn4WlHO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ho3SL/ik"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752239867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kmSeSCaMLTxjNle1bg96T1FnAl3KVrKCCr1RGJGYED4=;
	b=qkn4WlHORQUrFdQhPExQFdwDpontQI2oyBhYQz9t1T91kDagDvRjVH00EDS1PuLmpJkwmJ
	k8C/L1oBiZrOgEu37vgwCSiMV4WFpzmjVRPge078ymPiRWdTqluOd4kbDQ2qLZBA9TNc/M
	78OnznMULS8oq4nfKAMGTHrK9P9Lc3KK5EcwH9t2oLoJmGK8q7eqbaCpPoWlxxyexD+sWW
	qy5ijG4J0MTw7EwoHTo5O8gwPUoFawnHHsy6N4nUfQ+Onkl6OOJKYIwTplDDoQzLIFtquI
	oWcvb4HF3vBfoL3AkeE7wry6HQ7Lr8EEA+twRVAOsD+xu1cbHFabVPgDtQO7Jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752239867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kmSeSCaMLTxjNle1bg96T1FnAl3KVrKCCr1RGJGYED4=;
	b=ho3SL/ik71cNHV7Z0fe1DIrlJnkTfnPjH89WsDnFYQ1T8dLlVuATes6EbnzeRuCQGb3lvM
	63KmJSt1FIlBovDg==
To: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 1/2] rv/ltl: Do not execute the Buchi automaton twice on start condition
Date: Fri, 11 Jul 2025 15:17:37 +0200
Message-Id: <9379f4e7b9c1c69a6dca3e20a22936c850a25ca7.1752239482.git.namcao@linutronix.de>
In-Reply-To: <cover.1752239482.git.namcao@linutronix.de>
References: <cover.1752239482.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On start condition of a Buchi automaton, the automaton is executed twice.

This is fine for now, as all the current LTL operators do not care about
this. But it would break the 'next' operator, which will be introduced in a
follow-up patch.

Prepare for the introduction of the 'next' operator, only execute the
automaton once on start condition.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 include/rv/ltl_monitor.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
index 9a583125b566..67031a774e3d 100644
--- a/include/rv/ltl_monitor.h
+++ b/include/rv/ltl_monitor.h
@@ -167,8 +167,10 @@ static void ltl_atom_update(struct task_struct *task, =
enum ltl_atom atom, bool v
 	ltl_atom_set(mon, atom, value);
 	ltl_atoms_fetch(task, mon);
=20
-	if (!rv_ltl_valid_state(mon))
+	if (!rv_ltl_valid_state(mon)) {
 		ltl_attempt_start(task, mon);
+		return;
+	}
=20
 	ltl_validate(task, mon);
 }
--=20
2.39.5


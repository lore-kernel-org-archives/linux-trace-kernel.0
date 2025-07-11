Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1673288CB5;
	Fri, 11 Jul 2025 11:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752232853; cv=none; b=lH/Wi8l1TM2S+SLDkTls+sRtd7jmjdQePhI5VQSS891Wpgmn8w3oo84al6sH6CeKW9qOu4ZEE7fJGeIB2WUS6pZZ02NQr/WZqBOjE0MOqPEJ75JVjJFhdE3xPo/CNro9H+ETUC9ztDtmVjXb3QVpMzZ67KahSBSGr5Y+24keAYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752232853; c=relaxed/simple;
	bh=ZwqnPikhV2NwOzX2PNQ5agjEX5SJDyKxLD+jZln1ShY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AmINjnpZUhhcih9X7JfzgVqZIPpxaHNiuyOw1mzvwvlfw7R7KhbST2Bo0+pcDtvwL2H2WwDgPMiEjz2YZCQ+xtboEz0Sg4KnjpjN9z8E4byUFlbNaPbT2LeTQLJn6M9CRVcuF4BfBNOvMREMx3jFm/hggijKPigItwZAbvmOSHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gDKRTowC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UKAIVzQ0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gDKRTowC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UKAIVzQ0"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752232850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZwqnPikhV2NwOzX2PNQ5agjEX5SJDyKxLD+jZln1ShY=;
	b=gDKRTowCpZ8wfEodlVnUBS/BHRv103YqLtHOMxTb0dWkJ4w+TlotSsNyERw9l2ve8XEdI8
	qXAr8hR4nHzL+nJoUehhKJSQxU2Li4GDD6Bru17sooPT4QcjasGM/bjO4wXaGlICsXclhf
	Axwqa8fJSktDB1EULzw+PY6xfQXfkdj3DUupE2XjqUhXp0sm3C+kKpizTdKkftBKSOAJ5M
	vA9qJRUK65avmZYrIEUveKnUuPuAez7mthdhANqTqKZ7shP9BcIUPiDFNW3EcCo1sHXA6k
	SLsACZiBnVlWVosPk3AZUTenSkX0tuXXYPNGnNB1s3AmZ1OJ4u/ZEpcxoogcpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752232850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZwqnPikhV2NwOzX2PNQ5agjEX5SJDyKxLD+jZln1ShY=;
	b=UKAIVzQ0EE01OTTYAt7izMprOhJG6EAEbXNS84Iit4Mibz2pcvUuB4An7udEmAV9a1yMwp
	M5rHTmgbOS1oBTBg==
To: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] objtool: Add vpanic() to the noreturn list
Date: Fri, 11 Jul 2025 13:20:42 +0200
Message-Id: <073f826ebec18b2bb59cba88606cd865d8039fd2.1752232374.git.namcao@linutronix.de>
In-Reply-To: <cover.1752232374.git.namcao@linutronix.de>
References: <cover.1752232374.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

vpanic() does not return. However, objtool doesn't know this and gets
confused:
kernel/trace/rv/reactor_panic.o: warning: objtool: rv_panic_reaction(): une=
xpected end of section .text

Add vpanic() to the list of noreturn functions.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507110826.2ekbVdWZ-lkp@int=
el.com/
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 tools/objtool/noreturns.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
index eacfe3b0a8d1..6a922d046b8e 100644
--- a/tools/objtool/noreturns.h
+++ b/tools/objtool/noreturns.h
@@ -38,6 +38,7 @@ NORETURN(mpt_halt_firmware)
 NORETURN(mwait_play_dead)
 NORETURN(nmi_panic_self_stop)
 NORETURN(panic)
+NORETURN(vpanic)
 NORETURN(panic_smp_self_stop)
 NORETURN(rest_init)
 NORETURN(rewind_stack_and_make_dead)
--=20
2.39.5


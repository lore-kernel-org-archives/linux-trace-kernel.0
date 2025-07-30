Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD2C39ACC;
	Wed, 30 Jul 2025 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753879551; cv=none; b=Nh5deQwysu2Pdtfadmr5IVEinefep7i6zJmtETo0Ryynd1C2dTJbSxyXww4+zbcza/iVOKz0kkphFUdmGBYJ2itpBAwO7TZmwoNXQQMveIk7qmaVsjW16ypLccBcyUUTRfe3exKZMeZx6fP5fPXRPcohum+qX5Brovi2Kgdz0z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753879551; c=relaxed/simple;
	bh=S7X/BFf+hNgZZPjQGszpzY7Xu7SJAcMRtyRQC4tpn4k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mjuk986eA8DuzF2H8s6LkCn/V5aXCZgAaAF5DF+SaBTyv7RpWydGxpIo1GPjPvPppnf3wNMUooalWpYDFX+Qw2xnCDYotyvcGBFOCj2C+vdXowGg/GaBi5EGZjxmL3rzJCHIj2aeEYBAfmpNYHny1Osh/qDKzsnnL4oLS8bYlOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c7faKPc6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wH4afjDn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c7faKPc6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wH4afjDn"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753879547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v61WzzhbN7r8YwdelhEqsHQb/GjuYf39aJjvgZFaVg8=;
	b=c7faKPc6yyPZDxeHi+Pp5uS8YwvKWqQ7VuRWcTQCbxf+5Y6rl5sE8cPE7tMNOP0Lxzd4LW
	viUUVfgtvEn4rNBuU5JDZjQ6G5EQNZY2fTTGuf+Og/y8utYiTUBj+9jjRDzwQ+Tu3nKZhC
	vNN9y0UiyJM6t8qe9SmW1lNbL7teTeavByYuXCT/dvxIx4kWhe8a3lrZFoH9z1BKhgwIUY
	7jV9JZRGKWILeR6TUB5NJL103ZNOdz6P+VkfgLMehEaJnhknHTHZ9dh1dJRmXvgE1LVIHL
	3ylDRmVJqnlZKHgGGF1kquCftJPZJorBNyHP12gnn0I4hH5/nBRJjGh5evA83w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753879547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v61WzzhbN7r8YwdelhEqsHQb/GjuYf39aJjvgZFaVg8=;
	b=wH4afjDnxRPmQc0kChoAuO+xjPfphdMULC8d1QNIiK8wKyw85C42GapUPFqwJvWwJuIefK
	/BcnNH0RTYqXYXDA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 0/5] rv: LTL per-cpu monitor type and real-time scheduling monitor
Date: Wed, 30 Jul 2025 14:45:38 +0200
Message-Id: <cover.1753879295.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This series adds support for linear temporal logic per-cpu monitor type,
analogous to deterministic automaton per-cpu monitor. Then a new per-cpu
monitor is added which validates real-time scheduling.

Nam Cao (5):
  rv/ltl: Prepare for other monitor types
  rv/ltl: Support per-cpu monitors
  verification/rvgen/ltl: Support per-cpu monitor generation
  sched: Add rt task enqueue/dequeue trace points
  rv: Add rts monitor

 Documentation/trace/rv/monitor_sched.rst      |  19 +++
 include/linux/rv.h                            |   2 +
 include/rv/ltl_monitor.h                      | 117 +++++++++++-----
 include/trace/events/sched.h                  |   8 ++
 kernel/sched/rt.c                             |   4 +
 kernel/trace/rv/Kconfig                       |   5 +
 kernel/trace/rv/Makefile                      |   1 +
 .../trace/rv/monitors/pagefault/pagefault.h   |   2 +
 kernel/trace/rv/monitors/rts/Kconfig          |  17 +++
 kernel/trace/rv/monitors/rts/rts.c            | 131 ++++++++++++++++++
 kernel/trace/rv/monitors/rts/rts.h            | 126 +++++++++++++++++
 kernel/trace/rv/monitors/rts/rts_trace.h      |  15 ++
 kernel/trace/rv/monitors/sleep/sleep.h        |   2 +
 kernel/trace/rv/rv_trace.h                    |  47 +++++++
 tools/verification/models/sched/rts.ltl       |   5 +
 tools/verification/rvgen/rvgen/ltl2k.py       |  48 ++++++-
 .../rvgen/rvgen/templates/ltl2k/main.c        |   9 +-
 .../rvgen/rvgen/templates/ltl2k/trace.h       |   7 +-
 18 files changed, 516 insertions(+), 49 deletions(-)
 create mode 100644 kernel/trace/rv/monitors/rts/Kconfig
 create mode 100644 kernel/trace/rv/monitors/rts/rts.c
 create mode 100644 kernel/trace/rv/monitors/rts/rts.h
 create mode 100644 kernel/trace/rv/monitors/rts/rts_trace.h
 create mode 100644 tools/verification/models/sched/rts.ltl

--=20
2.39.5


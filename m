Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B222E403;
	Mon, 11 Aug 2025 08:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754901662; cv=none; b=GdWRBfSsAGx6zk1zT+oJlyyu+4VQgOg43NKr/dRYZzwsoAPU7VTldKXcbJFBkFYAbHBc1bPSeWoiiDYlqdjTXjyg2J1eUHht29rVzIGW5/SX6KbRiuakxa+TFSUWTZ7+c49MCLqHAY8ROxRDTXZEfg2U2RLSKB8OsSGbYzbLLuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754901662; c=relaxed/simple;
	bh=PFAn40ERFUpl2UgQ8ZbKZVJKmvwzvstB2a3DooiKPts=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AHba3NeAQelPonuBJaQ2jxIOvkqcaIK0jP9rjd9Qv7GhELrAaPL0twYzIv1jUtI98mGRlBjVu2bE9XETDyAmIWV+eaP86ZjqCG3pjc+8KfrLGausM49SDNat940OgBhAIsJmuBUkN/PC0aKXB0gsxOwGZkGYQbH3GBp86E4nU7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=22nbcD0h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=230HnAvP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="22nbcD0h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="230HnAvP"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754901659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RZ+2iyB7Q40bZozZ6Xus9BL/FN//MPPtLeMxMdIcwgw=;
	b=22nbcD0hLCX+Ccah4zhLdc2rbbg+N5byqQPOmIOIFVEqLd7SMDfMtVQJp4d5ofjxsOvIKW
	TXSQynpl4OXjDlCVV4Z2pPq5dARBygjKjpWyoGBpEYDVlbK0RODqt8Q2a1DEIx1cVyEjN7
	HCwKoWeY4tFG9WanO6yzz4KGrMLZVLiBqEkMd6emAXNS4yH9JL18E3/R/vPIkjmjk2Wcvg
	PiSOPN1SS3jFzW+QNIC3fvlq3+Wh36AsQNNbEWnW7VCI4DLLVYG+yk7Gq+ahqvhFvb77I5
	LPK0V9Qld6lF9vemoVuxZx6kjWGtTeHsSirhuY+Am56Sju97KOU2cExY4N4lNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754901659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RZ+2iyB7Q40bZozZ6Xus9BL/FN//MPPtLeMxMdIcwgw=;
	b=230HnAvPlgMMJiH+zXeB1Zv2WKaSYwcy4ux+SkKIIU8kSsrM5VdnL7uW0VtVS0fyygEGF+
	++tK//hn5fNLW3Aw==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 0/5] rv: LTL per-cpu monitor type and real-time scheduling monitor
Date: Mon, 11 Aug 2025 10:40:48 +0200
Message-Id: <cover.1754900299.git.namcao@linutronix.de>
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
  sched: Add task enqueue/dequeue trace points
  rv: Add rts monitor

 Documentation/trace/rv/monitor_rtapp.rst      |  19 +++
 include/linux/rv.h                            |   4 +
 include/rv/ltl_monitor.h                      | 115 +++++++++-----
 include/trace/events/sched.h                  |  13 ++
 kernel/sched/core.c                           |   8 +-
 kernel/trace/rv/Kconfig                       |   5 +
 kernel/trace/rv/Makefile                      |   1 +
 .../trace/rv/monitors/pagefault/pagefault.h   |   2 +
 kernel/trace/rv/monitors/rts/Kconfig          |  17 +++
 kernel/trace/rv/monitors/rts/rts.c            | 144 ++++++++++++++++++
 kernel/trace/rv/monitors/rts/rts.h            | 126 +++++++++++++++
 kernel/trace/rv/monitors/rts/rts_trace.h      |  15 ++
 kernel/trace/rv/monitors/sleep/sleep.h        |   2 +
 kernel/trace/rv/rv_trace.h                    |  47 ++++++
 tools/verification/models/rtapp/rts.ltl       |   5 +
 tools/verification/rvgen/rvgen/ltl2k.py       |  48 +++++-
 .../rvgen/rvgen/templates/ltl2k/main.c        |   9 +-
 .../rvgen/rvgen/templates/ltl2k/trace.h       |   7 +-
 18 files changed, 538 insertions(+), 49 deletions(-)
 create mode 100644 kernel/trace/rv/monitors/rts/Kconfig
 create mode 100644 kernel/trace/rv/monitors/rts/rts.c
 create mode 100644 kernel/trace/rv/monitors/rts/rts.h
 create mode 100644 kernel/trace/rv/monitors/rts/rts_trace.h
 create mode 100644 tools/verification/models/rtapp/rts.ltl

--=20
2.39.5


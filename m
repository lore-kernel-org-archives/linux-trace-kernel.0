Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03AA20B7F9;
	Wed,  6 Aug 2025 08:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754467299; cv=none; b=tcMB0LBnJySZbDm4KxxRKyH067ijU7W5LnyCYUoNk4V1tXpLVi7lP7qcz0TYuFLKMU9QYN9AA+FWrmqfg7M4TusIumAlocm2XmRNrfvVG/ID7Sw3fEuovGGMH1goj3BcQ6O0rZWXsDpXvLEHqdeH9R7iA0bJRWUq1DIyyveCKA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754467299; c=relaxed/simple;
	bh=nmN8S8s5S7vx+pgqT9lwA63Y9m/5Pa1lxHpR7vm+ppA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=anwtWoySgM9YfwHifMkzUPop5o+YsCQFzVkzU0o56wmOZa3PAmO2Pe+SwZaoq8k6/NlYnAHSfzBfzoFpzgznUY5kYoDyxEy6Hk3PNBW+HwOsf2F/hV576lxpyqokU8ULiyb3HaSAIp4JI34fogSyMYfO16XIbLLW+iRL5ypPpv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RodzEfXy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QuT8+/Pc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RodzEfXy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QuT8+/Pc"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754467288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0IY+6cXZrCMK9Vlh3K24Irf467jed2oTExk+JS8QPlU=;
	b=RodzEfXy5z/E9hC+3Zk9CF1CzWpzZ2pXVBrX9Sf8gjnzeM+O4diL1lEHEvwe43o10VwjnR
	VxF/EEwC1ETvcOY5S4KaX83MafUUbJqxNtKf8Y1CmB051tAMvRiGlp63r23GzU90MMP6ky
	z4yhu3Z7Y0ItNdh1ebWuNceuaodA2YT9RRCvGL18V1ai4mJtMKCTj8MqSq8wvXlpo86sb0
	MriohiOoNjTpj+AjuVmnzUTQd4Lh9IYqXPQ8oXIEP6nwtKiRABn9CNcguSl88alrejSp7Q
	20xUCbcImmBRJilEtcRISGsZQN5WlCx2+cC2Pfcb5Zg6qd6NUrkFeM2+Ag1sHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754467288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0IY+6cXZrCMK9Vlh3K24Irf467jed2oTExk+JS8QPlU=;
	b=QuT8+/Pcm6NDKLBBmuogBkmNQwvVybKpyMSWrRxDtyzpoNSGbBztm0xMSLHv2wrw9QU55E
	FqLlxe5DJO0XlZCg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 0/5] rv: LTL per-cpu monitor type and real-time scheduling monitor
Date: Wed,  6 Aug 2025 10:01:16 +0200
Message-Id: <cover.1754466623.git.namcao@linutronix.de>
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

 Documentation/trace/rv/monitor_sched.rst      |  19 +++
 include/linux/rv.h                            |   4 +
 include/rv/ltl_monitor.h                      | 117 +++++++++-----
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
 tools/verification/models/sched/rts.ltl       |   5 +
 tools/verification/rvgen/rvgen/ltl2k.py       |  48 +++++-
 .../rvgen/rvgen/templates/ltl2k/main.c        |   9 +-
 .../rvgen/rvgen/templates/ltl2k/trace.h       |   7 +-
 18 files changed, 539 insertions(+), 50 deletions(-)
 create mode 100644 kernel/trace/rv/monitors/rts/Kconfig
 create mode 100644 kernel/trace/rv/monitors/rts/rts.c
 create mode 100644 kernel/trace/rv/monitors/rts/rts.h
 create mode 100644 kernel/trace/rv/monitors/rts/rts_trace.h
 create mode 100644 tools/verification/models/sched/rts.ltl

--=20
2.39.5


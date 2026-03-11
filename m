Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB2A3C8720;
	Wed, 11 Mar 2026 10:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224180; cv=none; b=LBQw0949ZynPOyJpHTWy4xBZqOrZez1czArYaXDeY5QAvYuRWsAQ5B/XuLFqNJQj1JFzyTBS3hbi4Zt/AEBEG3vCiNSn3UkoSyJpj9qSH+lOV3tc+RECG21vArVcUsSMWSVgM83WzkG6fx1C0SACoY6V/cgZfOwOHR2nrPS77dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224180; c=relaxed/simple;
	bh=DwrCrIyc7liuv5KJBFDBcjXHm5zG0WcOKjJRPNV9OzY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LXSKq+M+YaxGGpVoPcgjQNsjyQyf/Rtfi3Mhox5vVgvF0q72XMy30jpYbbFbc4CH8VgWzJFUFJ0nSBaaBORkzWO+7Ri0YE3rxo4ibQIDc7hve2HH1eCvvNMDYaNqSaltW2Kh4LxH/iHPHsyQ4pMGG+6cTSJVZ0iKWFucsGP1+tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TytU7FTp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8siDL1+u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TytU7FTp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8siDL1+u"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773224176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OF5j2kUrLuhowFgD03T3ZNkdPhavHn6Uk9ZwgYWRMfA=;
	b=TytU7FTp6SuniBrSxS/dWPkqdfJO5Rxn+BkrzLCbnTzGfilN9kQQ12IGOrhi4WkfjHr5Vv
	ax0eGiODrp0SJEtxIyRSGsq6r7EAEKirhlF2oibohUDe/upPhNCG4J+hb49JAMpSPOJnad
	n343B0DQquFthp1Q73OnV6DOWgy9pnS7Isr+lueyarVtua0NFk9Rd97BB+MCe35uKMgzY4
	QhZHdqD6yZFfArw67Y21IQ2fnq9gjHhIXOi0OEL+FidsTvte2EOFXLlX+tY6w+GiVoflP6
	V1h0SjaX7ws/8ZxA5ySxvCKHdEUx/KU0bZ4qcbRnFMLpmC6jVKY0zIYS1g5iZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773224176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OF5j2kUrLuhowFgD03T3ZNkdPhavHn6Uk9ZwgYWRMfA=;
	b=8siDL1+uzDZhHX0LyTX4B4ASPNTJlsTRpW8iePr4DtzP5YWpWoxUmj0pKaRAqQwwLOSP40
	Jk9C2j0FyjLZmUCg==
Subject: [PATCH 00/12] hrtimer, timekeeping, tracing: various cleanups
Date: Wed, 11 Mar 2026 11:15:09 +0100
Message-Id: <20260311-hrtimer-cleanups-v1-0-095357392669@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y3MUQqDMBCE4avIPjdgUhDbq0gfopnoQht1Y6Qg3
 t2gPn4D828UIYxI72IjwcqRx5ChHwV1gw09FLtsMqWpyqfWapCFfxDVfWFDmqLyzjjYtn4Z5yn
 fJoHn/5lsPpcFc8rl5R73/QDIeGNCdwAAAA==
X-Change-ID: 20260311-hrtimer-cleanups-fd2deab892df
To: Jan Kiszka <jan.kiszka@siemens.com>, 
 Kieran Bingham <kbingham@kernel.org>, John Stultz <jstultz@google.com>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh_=28Schneider_Electric=29?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773224171; l=2083;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=DwrCrIyc7liuv5KJBFDBcjXHm5zG0WcOKjJRPNV9OzY=;
 b=QaDWtb0ViznSrzlJB4hzlFqgojvvYw4ZCzyMkepU/i7P81JVHOCdEitu5D9tuwkG26BNFHu5f
 DGxVafrFDSbBi8JKzNCZn+C91BAM6xSWzgc/HMmrjb8JjzW0e+UbJyT
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Various, mostly trivial, cleanups and fixes to the timekeeping core and
hrtimer subsystems. These are preparations for another upcoming series,
so I'd like this to go together trough tip.

Tracing maintainers: Patch 2 touches the tracing core.

Based on tip/sched/hrtick.

---
Thomas Weißschuh (Schneider Electric) (12):
      scripts/gdb: timerlist: Adapt to move of tk_core
      tracing: Use explicit array size instead of sentinel elements in symbol printing
      timer_list: Print offset as signed integer
      timekeeping: auxclock: Consistently use raw timekeeper for tk_setup_internals()
      timekeeping: Mark offsets array as const
      hrtimer: Remove hrtimer_get_expires_ns()
      hrtimer: Don't zero-initialize ret in hrtimer_nanosleep()
      hrtimer: Drop spurious space in 'enum hrtimer_base_type'
      hrtimer: Drop unnecessary pointer indirection in hrtimer_expire_entry event
      hrtimer: Mark index and clockid of clock base as const
      hrtimer: Remove trailing comma after HRTIMER_MAX_CLOCK_BASES
      hrtimer: Add a helper to retrieve a hrtimer from its timerqueue node

 include/linux/hrtimer.h                    |  5 ----
 include/linux/hrtimer_defs.h               |  8 +++---
 include/linux/trace_events.h               | 13 ++++++----
 include/trace/events/timer.h               |  7 +++---
 include/trace/stages/stage3_trace_output.h | 40 +++++++++++++++---------------
 kernel/time/hrtimer.c                      | 14 ++++++-----
 kernel/time/timekeeping.c                  | 12 +++++----
 kernel/time/timer_list.c                   |  4 +--
 kernel/trace/trace_events_synth.c          |  4 +--
 kernel/trace/trace_output.c                | 20 +++++++++------
 kernel/trace/trace_syscalls.c              |  3 +--
 scripts/gdb/linux/timerlist.py             |  2 +-
 12 files changed, 68 insertions(+), 64 deletions(-)
---
base-commit: eef9f648fb0e92618041f019d4bdcf7ae17cb743
change-id: 20260311-hrtimer-cleanups-fd2deab892df

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


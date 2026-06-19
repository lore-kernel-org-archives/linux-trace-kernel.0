Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9BA3128D7;
	Fri, 19 Jun 2026 07:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781853697; cv=none; b=OzZnZweiyF+mCe+CRaBEgAvUuVazOiv4UetFHUKLmzx6coJVVyCI2NhRvPYotC4qcWid7ls61Jpw6Fie1zk7+Z1yjQ0I3x4uDg648Dr6tcnU/fv7LXsdl9YjLSawi8HIGIzbK1ccO56v7oVMbCM4y6WUbi7Jma4Qk6WRe0IeJtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781853697; c=relaxed/simple;
	bh=LRepsmua+esowugaVO/r42GDSHHWMN0ZNhoR4nr53SM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SSwBbaAltnVZy5LtiG6ZaiysLNUP5jvyxRvCnuS/nPKvfnGYaDZxipnSazewIs8j28m+90gWLUqHx8RICQvU9zdvtRqNaTKVhDyu62vhP8UQBLCxDz4aZeks3iRiHRRptr8o5hPVrBmbOJ7nbrRqp5E/j3TfCx1oM3qPeMfcX1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gs+sQMDs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IUbUgx7h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gs+sQMDs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IUbUgx7h"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781853694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vtCUvvNusLIdXtO5kPex9kafcH+VPIiosEkS/xM338w=;
	b=Gs+sQMDsl6wyKsVhHx8ajp6FZZXKqG4j9FOQuGZDih7pGwi9ebSauGS/zRVpjlOqKwVHws
	iF7/Iq42di6kMEwWXxsdhNxhU4343V2OnZTsAn4oaK63OJ0UTuZbK9VwMmznEC27DRMF5J
	qfLs0EFt/2u0lFRYeWgu3Jotg1roRHGGgK7zEcVfcd2gl15+U2EaZFySXe6pQrilTo1fit
	X3y2tyz3XYi1tbDNt6wh7+BUICEUSpu7wU5yp9IE2GdsxACrAwAXVNTFsYacxfTUwVFPBi
	Szy3aaLY7GYZA+FBxwtsb0tjPwBSZ17Wo2J4XHNG9CDoB2j+42wGQU8MvRtj5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781853694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vtCUvvNusLIdXtO5kPex9kafcH+VPIiosEkS/xM338w=;
	b=IUbUgx7hqBt5SFp3IOf+NaWbuHQK/6g7runDMOP6V6/O2ByeRlTsc0CX46kVvlOQE3dcZ1
	xfxXpbDHT/C3AeCg==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 0/4] rv: rtapp monitor update
Date: Fri, 19 Jun 2026 09:21:18 +0200
Message-ID: <cover.1781852967.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A couple of minor improvements to the rtapp monitor:

  - Making the monitor more informative to user by changing the
    context of the tracepoint into the monitored task itself, not the
    IPI wakeup path.

  - and update the allow list regarding clock_nanosleep syscall.

  - Stop monitoring the kernel threads to simplify the monitors.

  - Add a new rtapp/wakeup monitor to give complement the rtapp/sleep
    monitor.

v2..v1 https://lore.kernel.org/lkml/cover.1779176466.git.namcao@linutronix.=
de/
  - Use clearer waker/wakee terminologies
  - Fix build issue
  - Add new patch "rv/rtapp/sleep: Stop monitoring kernel threads"
  - Require RV_PER_TASK_MONITORS >=3D 3

Nam Cao (4):
  rv/rtapp/sleep: Make the error more informative for user
  rv/rtapp/sleep: Update nanosleep rule
  rv/rtapp/sleep: Stop monitoring kernel threads
  rv/rtapp: Add wakeup monitor

 Documentation/trace/rv/monitor_rtapp.rst      |  61 ++++---
 kernel/trace/rv/Kconfig                       |   1 +
 kernel/trace/rv/Makefile                      |   1 +
 kernel/trace/rv/monitors/rtapp/Kconfig        |   2 +-
 kernel/trace/rv/monitors/sleep/Kconfig        |   1 -
 kernel/trace/rv/monitors/sleep/sleep.c        |  59 ++-----
 kernel/trace/rv/monitors/sleep/sleep.h        | 142 +++++++---------
 kernel/trace/rv/monitors/wakeup/Kconfig       |  16 ++
 kernel/trace/rv/monitors/wakeup/wakeup.c      | 153 ++++++++++++++++++
 kernel/trace/rv/monitors/wakeup/wakeup.h      |  92 +++++++++++
 .../trace/rv/monitors/wakeup/wakeup_trace.h   |  14 ++
 kernel/trace/rv/rv_trace.h                    |   1 +
 tools/verification/models/rtapp/sleep.ltl     |  11 +-
 tools/verification/models/rtapp/wakeup.ltl    |   5 +
 14 files changed, 396 insertions(+), 163 deletions(-)
 create mode 100644 kernel/trace/rv/monitors/wakeup/Kconfig
 create mode 100644 kernel/trace/rv/monitors/wakeup/wakeup.c
 create mode 100644 kernel/trace/rv/monitors/wakeup/wakeup.h
 create mode 100644 kernel/trace/rv/monitors/wakeup/wakeup_trace.h
 create mode 100644 tools/verification/models/rtapp/wakeup.ltl

--=20
2.47.3


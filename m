Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D676A238173;
	Wed,  9 Jul 2025 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752083802; cv=none; b=lLKBq1IDb5oKCS8CJ+gT+2O5uq09R9eVoGzc3oqd8B12Q+FjWDClUOBxanOYvD9IGwSQOedoTs0+VP5FVob3c6qUVdmMxhwAUhRn24LgtsxvOI7Vloc2kq8RSUoFkDidsgIcuNGft432bXk89wDIXOd8BP5IeExl6rYZP87mLjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752083802; c=relaxed/simple;
	bh=MRg+w2iH0HGF5UyuFu3lFXx9krIj2AUo3GAFy7nbrK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oN4m/H6H827swQJXHNJiMNKoboqdtYQ68hbABo5yBbwR4G6kCaQT875lKPb1dDGpm/wdOdX0bMVY4B6L+7EalUgfzxXsbGSkQhjz88oML+tZct0R1mYex+1kvUo4G2P6fVRQ4rCYWdnsFHnuVrnYi4BsdmHqvtEhskqCsYuTdUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MKN7kvyr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8o1tGaKY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MKN7kvyr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8o1tGaKY"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752083798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wd36I9Oi5n/Lmp8CkDPUxkaX/ZJRiNSgqZM9aUNzkIY=;
	b=MKN7kvyrNlbn2bf2sUzlPpkDldyd8J4mDfK6GC5ADU8UB5qfZZ3Bh8MJOCvicvyoojKeFG
	pLKNY0gEvD8xUxsc+Vx/HHwMi6x0qnRffr+6EDrdQbb+yBeZHwa5ZzwJv4KBcWN2LnWeR7
	/yy310kbqsZP2xQpcQtHDJP6/6b8PvAy+JEQcdAtrgJoZyfoDMCg+EDm3uk9vY9Gah1+xz
	JjPveFLOsWIfOtS2iCSWuI+aEM8WGq/PUMu57RpmNjgauFI/N/hsourCDtQOfz7Ev/WXB8
	PlZ6Epzo7H88VVhkc6rPFfdRp+r+qQo+lvAwbl7k+X4MM5c6piCLKAY7V2sNYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752083798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wd36I9Oi5n/Lmp8CkDPUxkaX/ZJRiNSgqZM9aUNzkIY=;
	b=8o1tGaKYxX2JnaMBFGO8l1lUFA10q0sOhr1YU7K0bmGjmAwKhXzkJqMSBc333tpK21+tk6
	dXaIkJ1SQ39FozBQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v12 05/12] rv: rename CONFIG_DA_MON_EVENTS to CONFIG_RV_MON_EVENTS
Date: Wed,  9 Jul 2025 19:56:22 +0200
Message-Id: <8fb85cacaff771e47edc55604953f73078b3ff56.1752082806.git.namcao@linutronix.de>
In-Reply-To: <cover.1752082806.git.namcao@linutronix.de>
References: <cover.1752082806.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

CONFIG_DA_MON_EVENTS is not specific to deterministic automaton. It could
be used for other monitor types. Therefore rename it to
CONFIG_RV_MON_EVENTS.

This prepares for the introduction of linear temporal logic monitor.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 kernel/trace/rv/Kconfig | 6 +++---
 kernel/trace/rv/rv.c    | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index b39f36013ef2..6cdffc04b73c 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -1,14 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
-config DA_MON_EVENTS
+config RV_MON_EVENTS
 	bool
=20
 config DA_MON_EVENTS_IMPLICIT
-	select DA_MON_EVENTS
+	select RV_MON_EVENTS
 	bool
=20
 config DA_MON_EVENTS_ID
-	select DA_MON_EVENTS
+	select RV_MON_EVENTS
 	bool
=20
 menuconfig RV
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index e4077500a91d..e25d65fe432a 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -143,7 +143,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
=20
-#ifdef CONFIG_DA_MON_EVENTS
+#ifdef CONFIG_RV_MON_EVENTS
 #define CREATE_TRACE_POINTS
 #include <rv_trace.h>
 #endif
--=20
2.39.5


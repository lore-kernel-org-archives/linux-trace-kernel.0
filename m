Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECD02FD588;
	Fri,  4 Jul 2025 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635238; cv=none; b=t5jmRwX97XUqJ7wQwZlUeiHk8TeTypjYuT9U/Tob4f2AMCu/ESX6YMtT3MaqGK8QSDNXzw4l2u21x9oc5Os1FM4rX1PxSGe/3SVVOW9oTYk6phpjBw/ESI6Z1haVqVdcyhEnsdCzSGODhUvHrsSis+UQYbn+GJiIcYWWc2hmRCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635238; c=relaxed/simple;
	bh=MRg+w2iH0HGF5UyuFu3lFXx9krIj2AUo3GAFy7nbrK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pfh5oMbQFl6isbWOKCV0zsMh28P56/Dj1cgxKlYBcSmSl6ebaLkX7FQs6GwYAqwZrvPd1+O+/+ncf3Jex3EXmnz0i/eEtWbFStv8lfd0ekYTHIjI66h+696Yoc6tkToct0rlRyEX+NmzkwGJPDO7pihc4x+GxlnRRPYzWufmNOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bdlSgWiK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TjBqI7NG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bdlSgWiK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TjBqI7NG"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wd36I9Oi5n/Lmp8CkDPUxkaX/ZJRiNSgqZM9aUNzkIY=;
	b=bdlSgWiKDkRMQlDdQRAtbeXd8yCCOFmJ6fug3oCQdwnyXITSYBph3XXzJ3s9HJD2QaRDT0
	DzS4tOtCzSbw/mIQ0Gp9RCtBRTXe4CV3z5gB7Kswy48XYv55QLDoaumklXOMO3PDRrRedh
	VXEPZPNllwT1mCJ3cJ9yWTMcf16buTfFcZ+crDbarUYpJkcJINzOXoMJTicyIe4Q5S+06Z
	FhibmgXc7F6j0zNstzmf1kSZkU35YpHhpVj9b4Hu8g8LoE8pK/vuwssK94TH+OW7EdfCJp
	eRgXlZhbc8/1Sru4D3ohOlfQEWM2jKH6bRv/589XJHKLBg6X9MlW710MoqfbIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wd36I9Oi5n/Lmp8CkDPUxkaX/ZJRiNSgqZM9aUNzkIY=;
	b=TjBqI7NGwFvkllC5FwknBYrFafmiRnaoCFjf3BTvV1KJBqutesapgsWraDJHNzhcZXTCZ4
	hQNZZKeVOsHrPvDg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v11 08/21] rv: rename CONFIG_DA_MON_EVENTS to CONFIG_RV_MON_EVENTS
Date: Fri,  4 Jul 2025 15:20:00 +0200
Message-Id: <69ad5df52ff99a08d0a855c425dfd18b9f59fbd9.1751634289.git.namcao@linutronix.de>
In-Reply-To: <cover.1751634289.git.namcao@linutronix.de>
References: <cover.1751634289.git.namcao@linutronix.de>
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


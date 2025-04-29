Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A4C2C2ABC;
	Tue, 29 Apr 2025 12:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745928098; cv=none; b=Xtsr/22x2Ct36n/dEgjJaqfx+k8UTpcz/l56MVnnvJF+1ap4cMYTgJtoygVtxAd53zSW/EuX31T2bDRdclJIRchh0Er81oenEvqrLBJ2Xd1aJCOOJ7izQmR/kdseCBjRnP66cLmX5U306KOEFoj2AFyahGEwaHk9qxpaiLaB4vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745928098; c=relaxed/simple;
	bh=RhYLrFheIiWCYjYK/KDGA0mZDhuFPEYIvPeR4F7AEr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nX7ab8zc8MPhrhHSXpIC/J978TbVVd4RZYPucdzUIOgv5pXQZjtU8OZ4vLRq6ZwCXb8q6oERw5AuhEiON3UIIPJgzajMbbMLgeWj5IArfs4NhwmPfJiU4DdjUdQYVm1xMG5vSUoihL4Bdeztlkjlgbqgap3Xz5QtW66uQIQsGFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yiP+gWOb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UK3C52AJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yiP+gWOb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UK3C52AJ"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745928089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pOuOkT1PrCTA1Z+IBTxOQ+T/0+ics4dUK08aZbw8Kkg=;
	b=yiP+gWObxXWlKtP/YkE7zJXwj/6+9NJIdTL7f3d6s3Y+AMpk45OQCiJuLZ0dwydJMgbSew
	lGIDM5hKqWh3mYitnScwtm5YoGLKw9uerA3AAMG+ltG08q9ptJpnDyP1QAdmjWIqAUgTLL
	O5SrlY7QfnpkzefP+kUH5fkAcS9ErwnRDn9dDxuNBc3cvxofWF7aclGKWoj4AOHj5ByDem
	nJhx4O+pLY9meUjh/pDqvu8rAIodVFCqy91EKltJ5JrtJ3/z1t2tTMirZlz6St5Gn1sjgd
	wKFIOatU2c9pQ7JZsb5lkVb54qCSeQlRQ9eSv4jiXtmIe+8oUBZKXooODpettw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745928089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pOuOkT1PrCTA1Z+IBTxOQ+T/0+ics4dUK08aZbw8Kkg=;
	b=UK3C52AJvKI1hNf0ykCb5gSv3fRSJO7bpFKbQ/F4XjXNZfh6nRgQqVFsttPiqIgZntg7h3
	gKDnVX+ttXiMkHDg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v5 08/23] rv: rename CONFIG_DA_MON_EVENTS to CONFIG_RV_MON_EVENTS
Date: Tue, 29 Apr 2025 14:00:53 +0200
Message-Id: <a08796e92a0b3bca0eb18f164fcb5a5971a782fc.1745926331.git.namcao@linutronix.de>
In-Reply-To: <cover.1745926331.git.namcao@linutronix.de>
References: <cover.1745926331.git.namcao@linutronix.de>
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
index 544acb1f6a33..d493fddf411f 100644
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


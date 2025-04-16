Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8986622D4D1;
	Wed, 16 Apr 2025 06:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744786322; cv=none; b=aHOBj9eizPkQM38ItLfqReJgp+p1qNQCBjPzchYq6UQGyauHveCGNs29/KOhFheUGfk8gCqZE6yeAK9BsKXhtsNugckM9lsKNCSS06TrNj+3Zva0pY+EJbcwLz+p7rk2slxn8I2vyIMFyJrqwMkwFOYsIXmzJhPTzmsHp7MZGGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744786322; c=relaxed/simple;
	bh=XSpDwdeVTB2AcA9ttMFS/qjUB4L4tN4Ug5OWOSxhkZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ctRcqtZw3yj6p5rifC3aD3NtpMhmnH0i12q74oHv0N1QjoEFZsUHuD17FtfnQLp1gK+m9PoosY85KHIp55RFWEpN39tkS1BIAp9Kuat9DP2tc46jJkiWhltMyLAcIkMHRahevYB3ae5PBtZgbyU2C8u9MERkvbyZNgRY7ZGdlQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CISPyXb/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5iRo80Rq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CISPyXb/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5iRo80Rq"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744786317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QrTG+If+tj0i64ta81V4qn3gNx721oseNH6iwdhWG4c=;
	b=CISPyXb/8o2FrYgQdb35L+hCPlYdKFVhEIZiiXoBeDKARaS1YkvlEtVGJlJrG3nxCVqqZV
	EFrY5bDMuY9d89QWDTnVTWWf7IKPzWJTAD8wGZVU6i22gOVdF5CikZOb8hDtW7wOF9S5IF
	/l7SNbxYjuh64b/L8tzmHwUkR7UjQVvyuRLXrOa9yc6xcxJClG/H3Vr7eRnorstf0YuTfa
	OOE+XecZNPm+OtPP795r+CswgtBpqsdx7kmd5+JTZc8TK/2mRxvXxUjmcZ7sCBkPkMpPb1
	rVT+HhAlUeun78i105zp/JgiBFgv+yO/QEAk+VV+1r6HXH1xCV0x4ChCX6ohZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744786317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QrTG+If+tj0i64ta81V4qn3gNx721oseNH6iwdhWG4c=;
	b=5iRo80RqXsUoclxGVly2qAOmt210DR05GwyqGon0v2UnNZIexZkRdHOMhqEHXr+YbTwLhb
	K1J+uuxL8zHVRwDg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 08/22] rv: rename CONFIG_DA_MON_EVENTS to CONFIG_RV_MON_EVENTS
Date: Wed, 16 Apr 2025 08:51:14 +0200
Message-Id: <454bd20c699ed365cd36516601cc356f821b103d.1744785335.git.namcao@linutronix.de>
In-Reply-To: <cover.1744785335.git.namcao@linutronix.de>
References: <cover.1744785335.git.namcao@linutronix.de>
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
index 50344aa9f7f9..dae84deb327d 100644
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


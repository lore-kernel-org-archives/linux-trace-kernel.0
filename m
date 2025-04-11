Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25549293B67;
	Fri, 11 Apr 2025 07:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744357092; cv=none; b=iJVy3O6BdPU/HVieeG/8H9X5Ik17xtTao8vMvsBCOe/fliIP/LmS1O70elm7IKbMdJI/xjEvuP1GZUoyecLttb85BRTbEM/cSQxC7NQUDuj+htJRZ2FXOWGXr/jeoulH+cl7u+JZRkcIQS5eIN6dJBG8Styma3qDFCaFOvoVM/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744357092; c=relaxed/simple;
	bh=nAUeebsWsEmZX/XefKY8HXRBxYNfgWdNFzHeFJ0kbp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cl9wTCSjJiGNayqnGcf1ekMvbYruZdPfrFGtigaRNTU/UBjOz9oCbXDBSha4PIlDw61kThfeQerPVTK1sGNI6oicrF7/CAGa34MHrGsueXrRjH2Xo1EaziDNN/7qYpWRSFRtXmvRigpGo517MsGyVj2lOw/bzYsBWw2kcu7bPN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ef0+UcM/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xzEF+F+G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ef0+UcM/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xzEF+F+G"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744357088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AYKM1Mz3suhO0XsbeTcjv/+gyVDOprDweDaq8TwQRtw=;
	b=Ef0+UcM/297peF2wV3rpJRrkkUR8onBJLepFRrKgx/suJ36qA7sfjYOM84xV0QKXVT/pgz
	1H3tnjQae1MTXGX+N81DUmjR+ySFjkXYuBncYJUFY+nJyXRTUhbJQ39PvdElWbIdbdgRiX
	J8UlP7L/K66tqXRhtsUguEW5EN3TuHf9DYAzvXxm9INNQsIsLdJ8hmSwqSYOSWJzSSjT6X
	FPL6ykLnlTNjmuNH5kgj2InrgEJ2cQS4HNagHVpUIxdOSzX779tuoWLSCdbwMIzqWdOzd5
	j20P0ifiwIs4zqePDS+b3XEMH0bGu0RaRBniEXLwt2sRvFsGdluBPI5NzqtZVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744357088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AYKM1Mz3suhO0XsbeTcjv/+gyVDOprDweDaq8TwQRtw=;
	b=xzEF+F+GEIcybxVAP1/TBYp6i1OhKqL32lR8ZWtpEEA8SCSgaXljTxRnc9NknvKNijggnj
	ZsOnXP7PPtCI/DAg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 08/22] rv: rename CONFIG_DA_MON_EVENTS to CONFIG_RV_MON_EVENTS
Date: Fri, 11 Apr 2025 09:37:24 +0200
Message-Id: <ecc2c812b595926f940ee93e2e34c4451544e10c.1744355018.git.namcao@linutronix.de>
In-Reply-To: <cover.1744355018.git.namcao@linutronix.de>
References: <cover.1744355018.git.namcao@linutronix.de>
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


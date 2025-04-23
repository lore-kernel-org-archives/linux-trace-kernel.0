Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F79D267B16;
	Wed, 23 Apr 2025 06:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745391045; cv=none; b=gVYPI/QriLeiYOtjzj8XtOlgjp4rCQSnuGnRFYompDRbXpcEIkdwtKSfvVIK6X2J48vFkDT16U/Nj8cKgD1pKtXwcGwFneVgrc1R/gBnMHkEoD8HPMDB3Jh0HKzOA1AT5iCJ2U2b3kiTKin5Fvis0U5pgJbBZMkMkaWbpSOXk1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745391045; c=relaxed/simple;
	bh=XSpDwdeVTB2AcA9ttMFS/qjUB4L4tN4Ug5OWOSxhkZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TSmujwmC6gADx3GvG1+VE4fB++Y9LjqWppg3SAhgvLVXRIRZNg8J2fCxYPD86mlJD3ZqzaDHCAYvNQc/kMM/mcCyf2QvPGAhc3cQx8YcoQWoQnuhKbVhadtoq17iOelx8h2MpfY+LCz/5KENijIr31beIWL1tK6WOTUHninsel4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jiIdOD/G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dCnUkPrm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jiIdOD/G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dCnUkPrm"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745391034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QrTG+If+tj0i64ta81V4qn3gNx721oseNH6iwdhWG4c=;
	b=jiIdOD/Gq+dt6ZTtm37ezUMFZDRHpp6hHE9FTSByiKXQqfgYOlhcr0B3zLU/EH0aIIG1fn
	jPwrkTmhrlgvwr34f73wgq1Djuu/StaIQopb8KZiJVs8bHvvOj5bEMtTUclYzzUyEURAJg
	l8unszhAEI1ddkQH2vTJcdSOZXhSX3nWovAGusjqEuVQlF/O5p+SGLyCBGtnidpFUAYWId
	phv2NDKAd7BU3X2UJOhtdUiQ01nepdD5bgWDwl/1rzdKdm8SldBVod6Gu8iPwBX/UsOphN
	YyywH8z3b3Z2Z6zSDrDvsg25BEPYKVTQKAzd9xHNzM1xR+cQJLV6qcamyU+FQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745391034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QrTG+If+tj0i64ta81V4qn3gNx721oseNH6iwdhWG4c=;
	b=dCnUkPrm4nGVIHfWXgK0b2wRsN8P4Q3sQnyNrr/Fbk543DrSr9w5vrgEb46avQxSahRXsQ
	9l/8fjn/tEXwcyBQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v4 08/22] rv: rename CONFIG_DA_MON_EVENTS to CONFIG_RV_MON_EVENTS
Date: Wed, 23 Apr 2025 08:50:03 +0200
Message-Id: <2ad919954e49991898581564e4d04c21a9478548.1745390829.git.namcao@linutronix.de>
In-Reply-To: <cover.1745390829.git.namcao@linutronix.de>
References: <cover.1745390829.git.namcao@linutronix.de>
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


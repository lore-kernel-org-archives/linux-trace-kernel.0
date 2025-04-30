Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EB92580F8;
	Wed, 30 Apr 2025 11:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746010970; cv=none; b=cVIm/R9RVD4epdi6D5DAQ8eQbaTIzhTO52nI4Ub2xXhd6mtLbr974Ok4tIZ9EOM5H9EaIXBndyFnP2SryLEGGb6vpAtdYnLXBpdd1mVRNiUyWCPHi+l9bThLTqI4XGtksSvhlHgpbQng1pot9gURvZkNSEr+SQz2ACu8Q5eSscc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746010970; c=relaxed/simple;
	bh=RhYLrFheIiWCYjYK/KDGA0mZDhuFPEYIvPeR4F7AEr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bPiidG1esCB14WHUafjRARytywu8iVW7KIomMPvsJsRH2GKQiyz94PxP3LTKycIbeWB9bml39gWZINdjVGS/Bw6KBYk/xDpXsyc1JUvz4TlHAnfbju4iS0hMxbL7lJxQkUGECefieAsCgfUPSyULa5OK3EJrjr/WCpj+QGLQNI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BDh3Uw4T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N2dRMs0z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BDh3Uw4T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N2dRMs0z"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746010966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pOuOkT1PrCTA1Z+IBTxOQ+T/0+ics4dUK08aZbw8Kkg=;
	b=BDh3Uw4TSkVcWtQoUr5Vd7+xnpa/RyJhQp/MJUqMQgOZ5yAZG/4FSGfz7VUsZYJIGPcUVJ
	2uv8T+Dvvc8n30ICuHDv/xw680d1lMqdOOcIlfYCbFVf8J06d1KbeCpGfAXSG8lZD2C8nm
	MraAKPBHbwZ2qIpMU2M9mwFgDC9hXUS3hQs7sPZCZ+TrMdCesEW5bzb41HwcHkQ3ZCZk7g
	JzKiGrSJL0hmMBbJ3EOR8JhNVYEpOKKy1LdmWTrAlH0Lty5EvJSdV0KngTPT0ldI+O5rsl
	y8QEjMMcCCefw6TYTuR+uDmmDoRO9u9NIHKabMSGxxodYlzBONG6XAtBO20+/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746010966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pOuOkT1PrCTA1Z+IBTxOQ+T/0+ics4dUK08aZbw8Kkg=;
	b=N2dRMs0zX9srK9f6/LyvSxLsZ8PLAxzNlRYCSpbioaeyCX7x6TytNjsyTf7C06a78wUA/k
	qFtw4qoRBP4t98AQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v6 08/22] rv: rename CONFIG_DA_MON_EVENTS to CONFIG_RV_MON_EVENTS
Date: Wed, 30 Apr 2025 13:02:23 +0200
Message-Id: <a08796e92a0b3bca0eb18f164fcb5a5971a782fc.1745999587.git.namcao@linutronix.de>
In-Reply-To: <cover.1745999587.git.namcao@linutronix.de>
References: <cover.1745999587.git.namcao@linutronix.de>
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


Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F076022E40A;
	Wed, 16 Apr 2025 06:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744786323; cv=none; b=Z3es3WOVg2UyesUKAda+n/JO9/uBpBf68h5j9pEFMJrF1UzAsy8cPPtpG+d8Z7T5JvxM6a2vCffA4OSDXnlq2HvXuhoXvIVoi7sTqQmfrs1qaBjsDlgT1M+74sYBuhua0OGgyFop1tEQAenY5n6Cwx3Y+74LmC5fGAMm8lo6hME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744786323; c=relaxed/simple;
	bh=bOWZsjpGMyuHA/9yMQEnOXQit557utN/lLEtaYfXo6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dB95+SL5TOi/ZUzOfV9PQRGanpUvEDrq8T6OyrnN95xnusJzYcX0qPtLo3KoMFYyDz1VfadQQ3yJTOCkeEMW+GhTL/mZJfIoR2N4t4Bie4tWaqrf4s2hk26fzkA8Sa748+xsqxeIXpPkOxsv7pLN2dxwOgwc9z+bBV42VwcuS8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WlG3qQu3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5TuUv3nX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WlG3qQu3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5TuUv3nX"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744786319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uFtVzpMnpK089v/2fXHCbOI7Lpmai8EW/LOy8Ub/+JY=;
	b=WlG3qQu33P/aB8umG+UkmkMu84DISZFkz6lkqpeNoQCL2i7IthhK+yX81UOYfIKgBKuqog
	R2X6+8fTk/ch6RdjW9NE+qMcgIdm5moeWUBDM2YoDf74tgPIspFzHMaPr2rtNa+b+pZS5w
	c9cCs7hfgFK0I+Tw4GxCXE7/s7bKCAhGke8ktOArVwJgMvsC563CGF1pq21kaE3L+wU2GZ
	QnLEC4fHwnithE+Oxtfge/xK16HZB75LDDY1qZYaqdvikN+ybZWDZQNYISc6Dd2Xjk31hf
	1TO8SIDvrRu/4ZPH653/91bVZo+4NB7aHYvJ1OjULewHThwNBYGnCcpCGyd1tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744786319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uFtVzpMnpK089v/2fXHCbOI7Lpmai8EW/LOy8Ub/+JY=;
	b=5TuUv3nXyChshttIFmXIHG8Re7riDqJN23RcNeYoQbu/CjDajcbhjFWoeHEXVWwlS8LwiO
	bJcge7dCXhoGv4Bw==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 14/22] rv: Add rtapp container monitor
Date: Wed, 16 Apr 2025 08:51:20 +0200
Message-Id: <7d1a7337879b991ed454d1457d44a15dabc4b3f7.1744785335.git.namcao@linutronix.de>
In-Reply-To: <cover.1744785335.git.namcao@linutronix.de>
References: <cover.1744785335.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add the container "rtapp" which is the monitor collection for detecting
problems with real-time applications. The monitors will be added in the
follow-up commits.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 kernel/trace/rv/Kconfig                |  1 +
 kernel/trace/rv/Makefile               |  1 +
 kernel/trace/rv/monitors/rtapp/Kconfig |  6 +++++
 kernel/trace/rv/monitors/rtapp/rtapp.c | 34 ++++++++++++++++++++++++++
 kernel/trace/rv/monitors/rtapp/rtapp.h |  3 +++
 5 files changed, 45 insertions(+)
 create mode 100644 kernel/trace/rv/monitors/rtapp/Kconfig
 create mode 100644 kernel/trace/rv/monitors/rtapp/rtapp.c
 create mode 100644 kernel/trace/rv/monitors/rtapp/rtapp.h

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 6e157f964991..5c407d291661 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -41,6 +41,7 @@ source "kernel/trace/rv/monitors/snroc/Kconfig"
 source "kernel/trace/rv/monitors/scpd/Kconfig"
 source "kernel/trace/rv/monitors/snep/Kconfig"
 source "kernel/trace/rv/monitors/sncid/Kconfig"
+source "kernel/trace/rv/monitors/rtapp/Kconfig"
 # Add new monitors here
=20
 config RV_REACTORS
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index f9b2cd0483c3..9b28c2419995 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_RV_MON_SNROC) +=3D monitors/snroc/snroc.o
 obj-$(CONFIG_RV_MON_SCPD) +=3D monitors/scpd/scpd.o
 obj-$(CONFIG_RV_MON_SNEP) +=3D monitors/snep/snep.o
 obj-$(CONFIG_RV_MON_SNCID) +=3D monitors/sncid/sncid.o
+obj-$(CONFIG_RV_MON_RTAPP) +=3D monitors/rtapp/rtapp.o
 # Add new monitors here
 obj-$(CONFIG_RV_REACTORS) +=3D rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) +=3D reactor_printk.o
diff --git a/kernel/trace/rv/monitors/rtapp/Kconfig b/kernel/trace/rv/monit=
ors/rtapp/Kconfig
new file mode 100644
index 000000000000..94689d66a79c
--- /dev/null
+++ b/kernel/trace/rv/monitors/rtapp/Kconfig
@@ -0,0 +1,6 @@
+config RV_MON_RTAPP
+	depends on RV
+	bool "rtapp monitor"
+	help
+	  Collection of monitors to check for common problems with real-time appl=
ication that cause
+	  unexpected latency.
diff --git a/kernel/trace/rv/monitors/rtapp/rtapp.c b/kernel/trace/rv/monit=
ors/rtapp/rtapp.c
new file mode 100644
index 000000000000..193c9d8dc0af
--- /dev/null
+++ b/kernel/trace/rv/monitors/rtapp/rtapp.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+
+#define MODULE_NAME "rtapp"
+
+#include "rtapp.h"
+
+struct rv_monitor rv_rtapp;
+
+struct rv_monitor rv_rtapp =3D {
+	.name =3D "rtapp",
+	.description =3D "Collection of monitors for detecting problems with real=
-time applications",
+};
+
+static int __init register_rtapp(void)
+{
+	rv_register_monitor(&rv_rtapp, NULL);
+	return 0;
+}
+
+static void __exit unregister_rtapp(void)
+{
+	rv_unregister_monitor(&rv_rtapp);
+}
+
+module_init(register_rtapp);
+module_exit(unregister_rtapp);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Nam Cao <namcao@linutronix.de>");
+MODULE_DESCRIPTION("Collection of monitors for detecting problems with rea=
l-time applications");
diff --git a/kernel/trace/rv/monitors/rtapp/rtapp.h b/kernel/trace/rv/monit=
ors/rtapp/rtapp.h
new file mode 100644
index 000000000000..4c200d67c7f6
--- /dev/null
+++ b/kernel/trace/rv/monitors/rtapp/rtapp.h
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+extern struct rv_monitor rv_rtapp;
--=20
2.39.5


Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E74F2FD588;
	Fri,  4 Jul 2025 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635244; cv=none; b=b7CdS5AQyuw/91um/ZNY3y/qOZRTAohozIQfFgcEcAVcwzAGUcrrYYKsltdvVV1dvl2aileAqLBAmzfo3yMid9BZAlgdARBHsXXC8Nf6zXbMWDiHN0+kGnhhNXvFRorD8XvGRkrFmCD86WqJlD+17G9XQf30lfoljPU/me1oWJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635244; c=relaxed/simple;
	bh=DcRi22O4d3UBw9x9KLG2WX/b+wJDIh4hVT93QK7WiGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DVnDHaUGnjACQLBbcC0E51qRDrMjtIqHOQT2OsOxMJTm9AIQnukuFPWQpAYCxfSs/Uv7k3LczVF/dHiygH114UH4fU0IvkpNhPdw1EGzzOEyKbn6gkXQUOCjZPZX9qnxIbvIm8x/fD1UxBDjNYTBWCmzfs7qoly9GjoZxXrOhIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tlr7Q1Lz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5gJAsm1q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tlr7Q1Lz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5gJAsm1q"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DH23WTRlvZDwouVOr7H+Q/MXu18JPTVYiKREYg9L8wY=;
	b=tlr7Q1Lzfpo07vOFcwWFU1JXM6o9RFMsItY1e1tBlq+dKbbXHK4hx+P6qr/iodwqB/KPQj
	XgTg+Sen1/Sq1oHfyBWNeU0+hPsJEvRSnncJEoB/SFwOVoJkP72dA48a9sL/FuxOXQKo1e
	60ciwsvF3h5TyjoHcq1xBr6VXRNlt0cyVVPzWUW9tZnoaH9frSU+bIiSFhbtdE6quCDA2V
	qRjC0xfoEevNq4ixA/E2DUQ4tbvxT+405EkQ2bS0ClG3KV/mOgD0MwK05RDaXcCB5ZSsQg
	2NKg4UGGT0n6fS71qMMdAg/e77Cudrk7qoHzukr03XEXQWYS/ZD+YAEyfuDelw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DH23WTRlvZDwouVOr7H+Q/MXu18JPTVYiKREYg9L8wY=;
	b=5gJAsm1qs5ExWfSrt6brx5S4+FQyE98oHhbE0dp7eRvBkyAoNW/FWH3Ydf7C7m6GKB8OTa
	3GnfcveYX/9MxGCQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v11 16/21] rv: Add rtapp container monitor
Date: Fri,  4 Jul 2025 15:20:08 +0200
Message-Id: <d8b59ae83e8bbec4284f641c29396e1f6f5cac46.1751634289.git.namcao@linutronix.de>
In-Reply-To: <cover.1751634289.git.namcao@linutronix.de>
References: <cover.1751634289.git.namcao@linutronix.de>
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

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
v11: Remove the incorrect note that this patch has performance impact (that
comes later)
---
 kernel/trace/rv/Kconfig                |  1 +
 kernel/trace/rv/Makefile               |  1 +
 kernel/trace/rv/monitors/rtapp/Kconfig | 10 ++++++++
 kernel/trace/rv/monitors/rtapp/rtapp.c | 33 ++++++++++++++++++++++++++
 kernel/trace/rv/monitors/rtapp/rtapp.h |  3 +++
 5 files changed, 48 insertions(+)
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
index 000000000000..b7415c3570bb
--- /dev/null
+++ b/kernel/trace/rv/monitors/rtapp/Kconfig
@@ -0,0 +1,10 @@
+config RV_MON_RTAPP
+	depends on RV
+	bool "rtapp monitor"
+	help
+	  Collection of monitors to check for common problems with real-time
+	  application that may cause unexpected latency.
+
+	  If you are developing a real-time system and not entirely sure whether
+	  the applications are designed correctly for real-time, you want to say
+	  Y here.
diff --git a/kernel/trace/rv/monitors/rtapp/rtapp.c b/kernel/trace/rv/monit=
ors/rtapp/rtapp.c
new file mode 100644
index 000000000000..fd75fc927d65
--- /dev/null
+++ b/kernel/trace/rv/monitors/rtapp/rtapp.c
@@ -0,0 +1,33 @@
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
+	return rv_register_monitor(&rv_rtapp, NULL);
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


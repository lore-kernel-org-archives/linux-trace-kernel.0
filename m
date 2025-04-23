Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0159E267F4F;
	Wed, 23 Apr 2025 06:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745391046; cv=none; b=LLDbmGnrA631AxKJS+vJgRW0ejdrRQbgVbaAht7S03/5I7+kinwr4FPaLEOpJtMWnyEeSyC8lkLbuFYnaOJlSiSKVQ6UrZkuT6wsF/DlPDRfUpaQoB9snRCDiY7P7MkJK+vST/5nGBSPANwCQaGP67TLwhE21X8be7YAarVAK6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745391046; c=relaxed/simple;
	bh=dHEMZ6Js5g9wt8CSMqCoeHgagN7udK4grgQ2f4hzzcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g2+oUek48VG5POztg0FRYv6VaOEWaJ32OfvlhJk8RrB1OeUQ2uxSS6RfGfuR1DeiJCfNXx6A/qu5t3tVQNku4faN3xOOCm/o/YI2ZzXWOp56bV5Ngfzy/O6oal46JHG8/swyAz4WjNuAX1AYUbXlHD/DxXfFy2nGKOFZLLIhDiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UrAuoBDG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Inifut8P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UrAuoBDG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Inifut8P"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745391039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+kn6HYtm+IWANZ1Eagm2N6HJ9e0cJKGSCEvviV39y50=;
	b=UrAuoBDG8O6l7K7UDf66GEeVcJCjmw3kdQcb6bH9nytEyIdtb1eGEw1eq2LDqLyI5o3c9q
	RCMwSO7HMexJ+TzihGYJ+I2J2ZNjwMEZg8M8sLaj1wWNLE5/OXaqoTO9hBz7hlbF7YivZ+
	qD1DSaH+RdwGKTyWN5YpvX81/4/yEDtcnImK3zsxxEAL0+LcDwYaC0ykQisKui+VT7a9Jl
	xn7vf7Rjr0tR9cv3Wq5+763UEG9JF3JCMJx4ewhr67/AdhQkrm1iwdFrviWzzjFz45a2Cy
	TY+1/IyEIHNIQwvW4LGk777M995WmmCBAujLKEoD+JzeLwA/YIVpExRYXbkDig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745391039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+kn6HYtm+IWANZ1Eagm2N6HJ9e0cJKGSCEvviV39y50=;
	b=Inifut8PfbOZrI0mwIWXs4L+7yHqJFtLmnpQgNJwWYgbUo/wetHAhm3YxxYH5UpDPbk9BM
	Zih60vyccWYGaPAQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v4 14/22] rv: Add rtapp container monitor
Date: Wed, 23 Apr 2025 08:50:09 +0200
Message-Id: <4c1256e8b482ee4d40742e1304f09c2f8da253bd.1745390829.git.namcao@linutronix.de>
In-Reply-To: <cover.1745390829.git.namcao@linutronix.de>
References: <cover.1745390829.git.namcao@linutronix.de>
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
 kernel/trace/rv/Kconfig                |  1 +
 kernel/trace/rv/Makefile               |  1 +
 kernel/trace/rv/monitors/rtapp/Kconfig |  6 +++++
 kernel/trace/rv/monitors/rtapp/rtapp.c | 33 ++++++++++++++++++++++++++
 kernel/trace/rv/monitors/rtapp/rtapp.h |  3 +++
 5 files changed, 44 insertions(+)
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


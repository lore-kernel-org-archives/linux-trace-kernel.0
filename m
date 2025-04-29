Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FAD2D1910;
	Tue, 29 Apr 2025 12:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745928101; cv=none; b=r6n/YFiPx7kM29Io1AnnxUKx47hzdOFLct4PXeOzuxoIqEJeHeug6rhwrDetTsQkMuVj4bH2+5FxHK8Utg80fNx1RG4pjNnZ39ggBEwitujSN/X3GUfLdmYvBEuWCMc8qDhRjL2sphKl8tu4tNgjM7054g4oaw65wslQThXPfWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745928101; c=relaxed/simple;
	bh=dHEMZ6Js5g9wt8CSMqCoeHgagN7udK4grgQ2f4hzzcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E6v4JZum2Y4BUVkB5dxY0IBLCr4HKvX0o5SBL+NdzD4aaYcpJFhJZG+IGkHsqERcnoi+Ge8LE3Avi/ko9iPJyBZDvwUOMEeq/10dTmDCFCVKlQV5Jf77HzB+SeJbA43eEthnZset49ekSTjh1H0HKeCP25Hc8EVVwlAYo4yEYNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GWvRxfbA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ce13FvaW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GWvRxfbA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ce13FvaW"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745928090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+kn6HYtm+IWANZ1Eagm2N6HJ9e0cJKGSCEvviV39y50=;
	b=GWvRxfbAUydYf4dJnJciZ3MxYcETSu42pG8Ix83rLM972nqdoBCCSDiBhWBSZIyaLarbM4
	2cX1lm2mtzsyEr/ejaSFRa0dawBHl5ZRb3SnSHx6Z1+IDTWGrVwHOGF5N+2q99+ZqIn+Ad
	iiZW4rJ5dRkAX6arZXN0dHVIjtUsWCgiKvQ/Am9UwKp3SRWZMmRwEl7RCw3SknDWM1xX5f
	QZVyO54vK0Dm5HOWac1DDEZx6NjL8SNJxD8TpYYbvk7N5Ux1ia0jbybg1Ud8FaECAiFnTv
	jN71X9WeJU4oJ7ztVq4GNDGC/TlDgyxDsf97wD7ADHZ9UyaJKK0rL9fcSYmJYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745928090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+kn6HYtm+IWANZ1Eagm2N6HJ9e0cJKGSCEvviV39y50=;
	b=ce13FvaWKABuOxg4qmh6ThJyw/WoFg6+Yk2DNeTMiOlHqBTjGmVo6rkVDq60nGzeirjlRh
	p7QD6Lj/lV+rv/Dw==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v5 14/23] rv: Add rtapp container monitor
Date: Tue, 29 Apr 2025 14:00:59 +0200
Message-Id: <922fa5dc21087cb45e0248aded8f732973c038ab.1745926331.git.namcao@linutronix.de>
In-Reply-To: <cover.1745926331.git.namcao@linutronix.de>
References: <cover.1745926331.git.namcao@linutronix.de>
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


Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650D4375F8E;
	Wed, 17 Jun 2026 20:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781726599; cv=none; b=WTZJMQLL4Pezu5eqGCrIV3TTP6hLp7Z5p/sagtyvP5pqzEE0ho8zcI5j4hid/Oh50aF83TmQ33Y08y5lUV1M0/u1UMFG9UPt61UahXjn6GMAppUieUhB9Jkh4+GEZ7ZacbKbXhJI4wmNXSCUdE2jZItD+G70VlG1Rn07inWCJqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781726599; c=relaxed/simple;
	bh=uU+tItC/1uVjMcfL5SvT4z+uuSzTsuI3LesfIXa7L2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=a4yRX0hy6NUhWTX2v92d0Q8KdkFZjmGqNn2d3yNukutaW9QXGlvlXqOu6WyIFxTEeE4klEDWY/RKoqReOB+yoS4ZFD9F81ZDS4eLoSjEOYiVTYeaNFaHvR6/x1nFd6aIJjs/Ga9OvawTXn6NnP4+brP/MgIG2GDFtlHDhjPQ7TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0F85120098A;
	Wed, 17 Jun 2026 22:03:13 +0200 (CEST)
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1wZwTg-003K6u-34;
	Wed, 17 Jun 2026 22:03:12 +0200
Received: from [::1] (helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1wZwTg-0000000DKEA-3gcg;
	Wed, 17 Jun 2026 22:03:12 +0200
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Wed, 17 Jun 2026 22:03:04 +0200
Subject: [PATCH] usb: typec: add trace point for typec_set_mode
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-typec_set_mode-tracepoint-v1-1-bdfbb39cfccd@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAHf9MmoC/yXMQQrCMBBG4auUWRtIWqngVURKnP7REUxCMoql9
 O5GXX6L91aqKIJKx26lgpdUSbHB7Trim49XGJmbqbf9aEd3MLpk8FSh0yPNMFo8IyeJaqxzgfd
 DgGdPrc8FQd6/9+n8d31e7mD9DmnbPhLgF+99AAAA
X-Change-ID: 20260617-typec_set_mode-tracepoint-011fc43feaca
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Ahmad Fatoum <a.fatoum@pengutronix.de>
X-Mailer: b4 0.15.2

Some Type-C controllers toggle muxes themselves. Other controllers like
the TUSB320 report the mode to the host, so it can control the muxes.

To improve debuggability of both kinds of drivers, add a trace point that
can be used to keep track of the mode being set inside the Type-C
framework:

  echo 1 > /sys/kernel/debug/tracing/events/typec/typec_mode/enable

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 MAINTAINERS                  |  1 +
 drivers/usb/typec/class.c    |  9 ++++++++-
 include/trace/events/typec.h | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c8d4b913f26c..ddd59e5e6eaf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27753,6 +27753,7 @@ F:	Documentation/ABI/testing/sysfs-class-typec
 F:	Documentation/driver-api/usb/typec.rst
 F:	drivers/usb/typec/
 F:	include/linux/usb/typec.h
+F:	include/trace/events/typec*.h
 
 USB TYPEC INTEL PMC MUX DRIVER
 M:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 0977581ad1b6..9316d067f19a 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -20,6 +20,9 @@
 #include "class.h"
 #include "pd.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/typec.h>
+
 static DEFINE_IDA(typec_index_ida);
 
 const struct class typec_class = {
@@ -2427,10 +2430,14 @@ EXPORT_SYMBOL_GPL(typec_get_orientation);
 int typec_set_mode(struct typec_port *port, int mode)
 {
 	struct typec_mux_state state = { };
+	int ret;
 
 	state.mode = mode;
 
-	return typec_mux_set(port->mux, &state);
+	ret = typec_mux_set(port->mux, &state);
+	trace_typec_mode(port, mode, ret);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(typec_set_mode);
 
diff --git a/include/trace/events/typec.h b/include/trace/events/typec.h
new file mode 100644
index 000000000000..a7dcb9f3fd49
--- /dev/null
+++ b/include/trace/events/typec.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM typec
+
+#if !defined(_TRACE_TYPEC_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_TYPEC_H
+
+#include <linux/usb/typec.h>
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(typec_mode,
+
+	TP_PROTO(struct typec_port *port, int mode, int err),
+
+	TP_ARGS(port, mode, err),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(&port->dev))
+		__field(int, mode)
+		__field(int, err)
+	),
+
+	TP_fast_assign(
+		__assign_str(device);
+		__entry->mode = mode;
+		__entry->err = err;
+	),
+
+	TP_printk("%s mode=%d (%d)",
+		  __get_str(device), __entry->mode, __entry->err)
+);
+
+#endif /* if !defined(_TRACE_TYPEC_H) || defined(TRACE_HEADER_MULTI_READ) */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>

---
base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
change-id: 20260617-typec_set_mode-tracepoint-011fc43feaca

Best regards,
--  
Ahmad Fatoum <a.fatoum@pengutronix.de>


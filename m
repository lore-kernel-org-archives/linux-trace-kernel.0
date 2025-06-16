Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5A71E492;
	Mon, 16 Jun 2025 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750091615; cv=none; b=fdYZQFEVh7OrBs8Jnx1MBaHUL620zAANp4Z6pbLdXRG5AsNUMhNH7veJZDKF9uvC8arMatW1Eqx9IldWN25MdBOa2QEf//ZPumMOh7k6I+4L/A2b7x0F2saUaLLt/Okn/kQnmJzdtR8H296bapgVIyFe/YNbEqr1InEWJrYzebQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750091615; c=relaxed/simple;
	bh=qaYMOS+0hWyrlEytEKzx5H7nPMZQC1gNkn4R4GhTIR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TLv6JkGewewsfYlES7bl0AyC8jMAf2xLOQ2AJtpYliMFcg25a5yJLvNfokyFMJhob//HEkidyGlM02hm/CqMLscVeOSJ3/x8n09oIIYP7tRCCmeZc+8RwkII6S4f806m/v9dixJSoURXXCNiWS0wXZM5bdxznr+Hrm1WR6Kb+0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=me4EEnT8; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="me4EEnT8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dVafAhGNitsOfreLos+zVpbRsLbs5vydoLjmX+bRpGI=; b=me4EEnT8FsbvDd1NLDN0CaRLBK
	gG5EDAVg75xEMZgUYAS3/wDbJXGTOW9j3xD8bMjkICxzQxi1Eshm+UcFmKqOh+luVr7HzFoj69NIX
	R2rPpXeDQ8QRUO3kkf+5c2JAgPcKdrundXOOHRMJpDB/Je9ZMAFB4Ob9B8a2YryWM3g6vbyKGRHBY
	nfWaXQHsIZR9Ww+7xqQb35htQVmSh8ZTon5gBl/YnfLItz0DiJAzJ5zIAVqLQzYf7Nb7XUg1dRktv
	5a/vru4ms6bMTYVMrXmp6G6o26bHR8bddTkC6j5/C60rgTZD6LtMnAJv365RWYroED57eFUz7bJVi
	Fo4aPzQQ==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1uRCGe-00FGuk-DJ; Mon, 16 Jun 2025 17:01:04 +0100
Received: from ben by rainbowdash with local (Exim 4.98.2)
	(envelope-from <ben@rainbowdash>)
	id 1uRCGe-00000008pch-0Trg;
	Mon, 16 Jun 2025 17:01:04 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-tegra@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 1/2] memory: tegra-mc: add tracepoints for tegra mc tracing
Date: Mon, 16 Jun 2025 17:01:02 +0100
Message-Id: <20250616160103.2105041-2-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
In-Reply-To: <20250616160103.2105041-1-ben.dooks@codethink.co.uk>
References: <20250616160103.2105041-1-ben.dooks@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

Add trace points to allow tracing of how the tegra_mc driver is being
called.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/memory/tegra/mc.c       | 26 +++++++------
 include/trace/events/tegra_mc.h | 69 +++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 11 deletions(-)
 create mode 100644 include/trace/events/tegra_mc.h

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index bd5b58f1fd42..256cf0d0aa2d 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -21,6 +21,9 @@
 
 #include "mc.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/tegra_mc.h>
+
 static const struct of_device_id tegra_mc_of_match[] = {
 #ifdef CONFIG_ARCH_TEGRA_2x_SOC
 	{ .compatible = "nvidia,tegra20-mc-gart", .data = &tegra20_mc_soc },
@@ -210,6 +213,8 @@ static int tegra_mc_hotreset_assert(struct reset_controller_dev *rcdev,
 	int retries = 500;
 	int err;
 
+	trace_tegra_mc_hotreset(mc->dev, id, true);
+
 	rst = tegra_mc_reset_find(mc, id);
 	if (!rst)
 		return -ENODEV;
@@ -269,6 +274,8 @@ static int tegra_mc_hotreset_deassert(struct reset_controller_dev *rcdev,
 	const struct tegra_mc_reset *rst;
 	int err;
 
+	trace_tegra_mc_hotreset(mc->dev, id, false);
+
 	rst = tegra_mc_reset_find(mc, id);
 	if (!rst)
 		return -ENODEV;
@@ -583,7 +590,7 @@ irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
 	for_each_set_bit(bit, &status, 32) {
 		const char *error = tegra_mc_status_names[bit] ?: "unknown";
 		const char *client = "unknown", *desc;
-		const char *direction, *secure;
+		bool secure, write;
 		u32 status_reg, addr_reg;
 		u32 intmask = BIT(bit);
 		phys_addr_t addr = 0;
@@ -652,15 +659,8 @@ irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
 		}
 #endif
 
-		if (value & MC_ERR_STATUS_RW)
-			direction = "write";
-		else
-			direction = "read";
-
-		if (value & MC_ERR_STATUS_SECURITY)
-			secure = "secure ";
-		else
-			secure = "";
+		write = value & MC_ERR_STATUS_RW;
+		secure = value & MC_ERR_STATUS_SECURITY;
 
 		id = value & mc->soc->client_id_mask;
 
@@ -710,8 +710,12 @@ irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
 			value = mc_readl(mc, addr_reg);
 		addr |= value;
 
+		trace_tegra_mc_err(mc->dev, client, secure, write, addr,
+				   error, desc, perm);
+
 		dev_err_ratelimited(mc->dev, "%s: %s%s @%pa: %s (%s%s)\n",
-				    client, secure, direction, &addr, error,
+				    client, secure ? "secure" : "",
+				    write ? "write" : "read", &addr, error,
 				    desc, perm);
 	}
 
diff --git a/include/trace/events/tegra_mc.h b/include/trace/events/tegra_mc.h
new file mode 100644
index 000000000000..acf00a19240b
--- /dev/null
+++ b/include/trace/events/tegra_mc.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* tegra memory controller tracepoints
+ *
+ * Copyright (c) 2025 Codethink Ltd.
+ * Ben Dooks <ben.dooks@codethink.co.uk>
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM tegra_mc
+
+#if !defined(_TRACE_TEGRA_MC_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_TEGRA_MC_H
+
+#include <linux/device.h>
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(tegra_mc_hotreset,
+	    TP_PROTO(struct device *dev, unsigned long id, bool assert),
+	    TP_ARGS(dev, id, assert),
+	    TP_STRUCT__entry(
+			     __string(dev, dev_name(dev))
+			     __field(unsigned long, id)
+			     __field(bool, assert)),
+	    TP_fast_assign(
+			   __assign_str(dev);
+			   __entry->id = id;
+			   __entry->assert = assert;
+			   ),
+	    TP_printk("rcdev %s, id %lu, %s\n",
+		      __get_str(dev), __entry->id, __entry->assert ? "assert" : "release")
+);
+
+TRACE_EVENT(tegra_mc_err,
+	    TP_PROTO(struct device *dev, const char *client,
+		     bool secure, bool write, phys_addr_t addr,
+		     const char *error, const char *desc, const char *perm),
+	    TP_ARGS(dev, client, secure, write, addr, error, desc, perm),
+	    TP_STRUCT__entry(
+			     __string(dev,		dev_name(dev))
+			     __field(const char *,	client)
+			     __field(bool, secure)
+			     __field(bool, write)
+			     __field(phys_addr_t, addr)
+			     __field(const char *, error)
+			     __field(const char *, desc)
+			     __string(perm, perm)),
+	    TP_fast_assign(
+			   __assign_str(dev);
+			   __entry->client = client;
+			   __entry->secure = secure;
+			   __entry->write = write;
+			   __entry->addr = addr;
+			   __entry->desc = desc;
+			   __assign_str(perm);
+			   ),
+	    TP_printk("%s: %s: %s%c @%pa %s (%s%s)",
+		      __get_str(dev),
+		      __entry->client, __entry->secure ? "secure/" : "",
+		      __entry->write ? 'w' : 'r',
+		      &__entry->addr,
+		      __entry->error,
+		      __entry->desc,
+		      __get_str(perm))
+);
+
+#endif /* _TRACE_TEGRA_MC_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.37.2.352.g3c44437643


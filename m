Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4C8216E26;
	Mon, 16 Jun 2025 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750091069; cv=none; b=rbyPAZtWmyeKuFohk2g4lkaIYUiJCTYkEfpmFG5jC1BntL4L4WcimShIcK5agVhQhjgooI0itTLiLeK084KnyuaDCZtsu3gDVW4UTqejtC3D5jtU3uvlQLiOTs5W25RRiukPamTOmx+DUOwIxdhMCxTmoAybI5sa/JBB4bVEaEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750091069; c=relaxed/simple;
	bh=Uz857Oq2+oWLt5i1lXofzZcOyaFI4AsgP0/KjBuTWmM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U/2RQDkrNW0hIaWFi4QFbnCA1f2SO2NL8LKXDglcPcNb7C6Tlxbib0yGUqI4hUSeLbWtuWtfhEz+qZEMOuXZz8M+/fIP0zCL3MSqTZpqv0oMRHffm6VubYBYVZf4rlFvbgfzynSkPQzkCsMyZvpR311fdG8qeZq8f9FiT+j1kF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=qQ/vVQOs; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="qQ/vVQOs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5AGwWrRi8jrgw3xUdQEuuEMteyOTsTLzOSwAaSI3km4=; b=qQ/vVQOsBoTKNxsqcSqzZmGLg9
	hQyXsN7Q2dUb3Wn7gvf4rdHkEfzF05K0YIYbuLV3gY0n8sVhpTd4hO/RDFQgy8BkXUGMdFMtBIeZ3
	CatTtdCsuMwvg1nS1BmMiJpobtv/blCC6TU0nUy9vXJvBEc1LSumR5hm7dlVG5KVaS3Zth3jKqUTT
	RmF/qnVnZH2mtVAWSSXQsbN57U0uX01GdY3C93jRZshGZLWGwv+JfxIjJpfgKCGaLFQgJgSYivQcu
	QY1N3KOcAXx6AxgH86Df6iXnlCA967X72vOrMprTm0/f1UVwEs/esxWhBCwxlXf2JqWFDT5cEC28Y
	c8trnfXw==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1uRCGd-003LgT-Fm; Mon, 16 Jun 2025 17:01:04 +0100
Received: from ben by rainbowdash with local (Exim 4.98.2)
	(envelope-from <ben@rainbowdash>)
	id 1uRCGe-00000008pcl-0aOx;
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
Subject: [PATCH 2/2] drivers/firware/tegra: add tracing to bpmp code
Date: Mon, 16 Jun 2025 17:01:03 +0100
Message-Id: <20250616160103.2105041-3-ben.dooks@codethink.co.uk>
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

Add trace points to the communications with the bpmp

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/firmware/tegra/bpmp.c     |  16 +++-
 include/trace/events/tegra_bpmp.h | 140 ++++++++++++++++++++++++++++++
 2 files changed, 155 insertions(+), 1 deletion(-)
 create mode 100644 include/trace/events/tegra_bpmp.h

diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
index c3a1dc344961..b7c005990269 100644
--- a/drivers/firmware/tegra/bpmp.c
+++ b/drivers/firmware/tegra/bpmp.c
@@ -20,6 +20,9 @@
 
 #include "bpmp-private.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/tegra_bpmp.h>
+
 #define MSG_ACK		BIT(0)
 #define MSG_RING	BIT(1)
 #define TAG_SZ		32
@@ -227,6 +230,7 @@ static ssize_t tegra_bpmp_channel_read(struct tegra_bpmp_channel *channel,
 unlock:
 	up(&bpmp->threaded.lock);
 
+	trace_tegra_bpmp_channel_read(channel, data, size, ret, err);
 	return err;
 }
 
@@ -240,6 +244,8 @@ static ssize_t __tegra_bpmp_channel_write(struct tegra_bpmp_channel *channel,
 	if (data && size > 0)
 		tegra_bpmp_mb_write(&channel->ob, data, size);
 
+	trace_tegra_bpmp_channel_write(channel, mrq, flags, data, size);
+
 	return tegra_bpmp_post_request(channel);
 }
 
@@ -350,8 +356,12 @@ int tegra_bpmp_transfer_atomic(struct tegra_bpmp *bpmp,
 	if (err < 0)
 		return err;
 
-	return __tegra_bpmp_channel_read(channel, msg->rx.data, msg->rx.size,
+	err =  __tegra_bpmp_channel_read(channel, msg->rx.data, msg->rx.size,
 					 &msg->rx.ret);
+
+	trace_tegra_bpmp_channel_read(channel, msg->rx.data, msg->rx.size,
+				      &msg->rx.ret, err);
+	return err;
 }
 EXPORT_SYMBOL_GPL(tegra_bpmp_transfer_atomic);
 
@@ -368,6 +378,8 @@ int tegra_bpmp_transfer(struct tegra_bpmp *bpmp,
 	if (!tegra_bpmp_message_valid(msg))
 		return -EINVAL;
 
+	trace_tegra_bpmp_transfer(bpmp, msg);
+
 	if (bpmp->suspended) {
 		/* Reset BPMP IPC channels during resume based on flags passed */
 		if (msg->flags & TEGRA_BPMP_MESSAGE_RESET)
@@ -812,6 +824,7 @@ static int __maybe_unused tegra_bpmp_suspend(struct device *dev)
 {
 	struct tegra_bpmp *bpmp = dev_get_drvdata(dev);
 
+	trace_tegra_bpmp_pm(bpmp, true);
 	bpmp->suspended = true;
 
 	return 0;
@@ -821,6 +834,7 @@ static int __maybe_unused tegra_bpmp_resume(struct device *dev)
 {
 	struct tegra_bpmp *bpmp = dev_get_drvdata(dev);
 
+	trace_tegra_bpmp_pm(bpmp, false);
 	bpmp->suspended = false;
 
 	if (bpmp->soc->ops->resume)
diff --git a/include/trace/events/tegra_bpmp.h b/include/trace/events/tegra_bpmp.h
new file mode 100644
index 000000000000..63289e475951
--- /dev/null
+++ b/include/trace/events/tegra_bpmp.h
@@ -0,0 +1,140 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* tegra memory controller tracepoints
+ *
+ * Copyright (c) 2025 Codethink Ltd.
+ * Ben Dooks <ben.dooks@codethink.co.uk>
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM tegra_bpmp
+
+#if !defined(_TRACE_TEGRA_BPMP_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_TEGRA_BPMP_H
+
+#include <linux/tracepoint.h>
+
+#include <soc/tegra/bpmp.h>
+
+#ifdef CREATE_TRACE_POINTS
+static inline const char *tegra_bpmp_mrq_name(unsigned mrq)
+{
+	switch (mrq) {
+	case MRQ_PING: return "ping";
+	case MRQ_QUERY_TAG: return "query-tag";
+	case MRQ_THREADED_PING: return "threaded-ping";
+	case MRQ_DEBUGFS: return "debugfs";
+	case MRQ_RESET: return "reset";
+	case MRQ_I2C: return "i2c";
+	case MRQ_CLK: return "clk";
+	case MRQ_QUERY_ABI: return "query-abi";
+	case MRQ_THERMAL: return "thermal";
+	case MRQ_CPU_VHINT: return "cpu-vhint";
+	case MRQ_ABI_RATCHET: return "abi-ratchet";
+	case MRQ_EMC_DVFS_LATENCY: return "emc-dvfs-latency";
+	case MRQ_RINGBUF_CONSOLE: return "ringbuf-console";
+	case MRQ_PG: return "pg";
+	case MRQ_CPU_NDIV_LIMITS: return "cpu-ndiv-limits";
+	case MRQ_STRAP: return "strap";
+	case MRQ_UPHY: return "uphy";
+	case MRQ_CPU_AUTO_CC3: return "cpu-auto-cc3";
+	case MRQ_QUERY_FW_TAG: return "query-fw-tag";
+	case MRQ_FMON: return "fwmon";
+	case MRQ_EC: return "ec";
+	case MRQ_DEBUG: return "debug";
+	case MRQ_EMC_DVFS_EMCHUB: return "emc-dvfs-emchub";
+	case MRQ_BWMGR: return "bwmgr";
+	case MRQ_ISO_CLIENT: return "iso-client";
+	case MRQ_EMC_DISP_RFL: return "emc-disp-rfl";
+	case MRQ_TELEMETRY: return "telemetry";
+	case MRQ_PWR_LIMIT: return "pwr-limit";
+	case MRQ_GEARS: return "gears";
+	case MRQ_BWMGR_INT: return "bwmgr-int";
+	case MRQ_OC_STATUS: return "oc-status";
+	}
+
+	return "";
+}
+
+#define __pm_state(__s) ((__s) ? "suspended" : "active")
+#endif /* CREATE_TRACE_POINTS */
+
+TRACE_EVENT(tegra_bpmp_pm,
+	    TP_PROTO(struct tegra_bpmp *bpmp, bool suspend),
+	    TP_ARGS(bpmp, suspend),
+	    TP_STRUCT__entry(
+		    __string(dev, dev_name(bpmp->dev))
+		    __field(bool, suspend)
+		    __field(bool, prev)),
+	    TP_fast_assign(
+		    __assign_str(dev);
+		    __entry->prev = bpmp->suspended;
+		    __entry->suspend = suspend;
+		    ),
+	    TP_printk("bpmp %s: pm %s to %s",
+		      __get_str(dev),
+		      __pm_state(__entry->prev), __pm_state(__entry->suspend))
+);
+
+TRACE_EVENT(tegra_bpmp_transfer,
+	    TP_PROTO(struct tegra_bpmp *bpmp,
+		     struct tegra_bpmp_message *msg),
+	    TP_ARGS(bpmp, msg),
+	    TP_STRUCT__entry(
+			     __string(dev, dev_name(bpmp->dev))
+			     __field_struct(struct tegra_bpmp_message, msg)
+	    ),
+	    TP_fast_assign(
+			   __assign_str(dev);
+			   __entry->msg = *msg;
+	    ),
+	    TP_printk("bpmp %s: tx %px, %zd rx %px, %zd, mrq %u (%s), flags %lu",
+		      __get_str(dev),
+		      __entry->msg.tx.data, __entry->msg.tx.size,
+		      __entry->msg.rx.data, __entry->msg.rx.size,
+		      __entry->msg.mrq, tegra_bpmp_mrq_name(__entry->msg.mrq),
+		      __entry->msg.flags)
+);
+
+TRACE_EVENT(tegra_bpmp_channel_write,
+	    TP_PROTO(struct tegra_bpmp_channel *channel,
+		     unsigned int mrq, unsigned long flags,
+		     const void *data, size_t size),
+	    TP_ARGS(channel, mrq, flags, data, size),
+	    TP_STRUCT__entry(
+			     __field(unsigned int, index)
+			     __field(unsigned int, mrq)
+			     __field(unsigned long, flags)
+			     ),
+	    TP_fast_assign(
+		    __entry->index = channel->index;
+		    __entry->mrq = mrq;
+		    __entry->flags = flags;
+		    ),
+	    TP_printk("channel %u: mrq %u (%s), flags %lu",
+		      __entry->index,
+		      __entry->mrq, tegra_bpmp_mrq_name(__entry->mrq),
+		      __entry->flags)
+);
+
+TRACE_EVENT(tegra_bpmp_channel_read,
+	    TP_PROTO(struct tegra_bpmp_channel *channel,
+		     void *data, size_t size, int *ret, int err),
+	    TP_ARGS(channel, data, size, ret, err),
+	    TP_STRUCT__entry(
+		    __field(unsigned int, index)
+		    __field(int, ret)
+		    __field(int, err)
+		    ),
+	    TP_fast_assign(
+		    __entry->index = channel->index;
+		    __entry->ret = ret ? *ret : -ENOENT;
+		    __entry->err = err;
+		    ),
+	    TP_printk("channel %u: read returned %d, err %d",
+		      __entry->index, __entry->ret, __entry->err)
+);
+
+#endif /* _TRACE_TEGRA_BPMP_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.37.2.352.g3c44437643


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795589110;
	b=vbpcpTIGJsV7Ka2LQnY63BzVxHOHB+3xLbelh3TOXUlaLBRDbPrySlq7OR8/5Uz2XEdU
	 EpL/7cAwDDcPLOSJDE0npCDLtaLdTHEVG/Uq5Kcvq5eBuRKn1meMcXg+Mcl+00PYO1EJ+
	 O5ZoodHXK0S09CJs0vAMkwQh/nMQOwkgNReEYg/7gLWsKqKbKyY5Rfd+YEn6vmtDvaEIA
	 JQ+7gNEaJQG8bNegLwLIu7cR93XV/JnBG+sx+/uhxqFIUOjsYdyDQIkLdmKbt4DFX4CX5
	 3c3Kda8nGYO0lgeRuGHj5/sY1CWOR9V+Jc6edAwAYFFYXbd3pgNOm+Gvc32NFOTuTmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795589110;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=GFTYIeKrWqXVecVR0t1STSSGWzXRjqisXCQNAyDZlaQ=;
	b=hJNlhVoVt5Jl6JsxNnJC8j27dIZ+pAPMnBENwgPj0/cIkJ2A7UomagKCFhKor2GUd4Mj
	 077OFIMZFJ3e9zQqTvQD5/OfcU0WmOP+PMBaakDNXXDatlHdIHnuY6npuVL1RX7xf82pZ
	 KIJ03bbfLXOQQH4pzPq+Kyqvk3vyJtyZ8aGxOHE+wv/OrQI6FxMBEWLf4BptgYinJNI4f
	 Vp60bRnQl/awJ7XWjs4eMYtThiv11vyBpXsPjA1JHiLa86WldBnEPqYWue3uyv8LxNIa6
	 NxLaxYFw0ar+j38DSjo+8x9fWw6n0R1iWSNLIe/CKiLPEfyG84ZFUl2ttgtbnBAulnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b="XE//2Tfe";
	arc=none smtp.remote-ip=113.46.200.219
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E96606A329;
	Wed, 25 Nov 2026 06:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79E96606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=XE//2Tfe
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=GFTYIeKrWqXVecVR0t1STSSGWzXRjqisXCQNAyDZlaQ=;
	b=XE//2TfeSY30evkGzLAgZzYv6WTlzbAq4cYt+/vdIx1ExkqAD0Yftz0N/OyTQQFZNOeA06fGw
	Tdx/1aEcJ9/uQVEZQhoQdiIM1DfigAUOG5pnMbI/jNF5BdWn7YvoCux/vifyKk84E3AI8HVJQhK
	JhFO055hBW4lMR7gD6lr6G8=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4jZ9CM2QS1z1prLQ;
	Wed, 25 Nov 2026 14:44:47 +0800 (CST)
Received: from whupemk300003.china.huawei.com (unknown [7.152.185.49])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B41140561;
	Wed, 25 Nov 2026 14:45:04 +0800 (CST)
Received: from huawei.com (10.50.87.204) by whupemk300003.china.huawei.com
 (7.152.185.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 25 Nov
 2026 14:45:02 +0800
From: Zhang Yuwei <zhangyuwei20@huawei.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	<mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <iommu@lists.linux.dev>,
	<chenjun102@huawei.com>, <zhangyuwei20@huawei.com>
Subject: [PATCH v2] iommu: Trace I/O page fault response latency
Date: Wed, 25 Nov 2026 14:43:10 +0800
Message-ID: <20261125064310.2383969-1-zhangyuwei20@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20261125013430.2144822-1-zhangyuwei20@huawei.com>
References: <20261125013430.2144822-1-zhangyuwei20@huawei.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 whupemk300003.china.huawei.com (7.152.185.49)

From: Chen Jun <chenjun102@huawei.com>

Carry an optional monotonic timestamp with each IOPF and preserve it
across group construction, including allocation error paths. Sample it
at the common report entry point and record latency after the driver's
page_response callback returns.

Cover asynchronous group responses, synchronous error responses, and
pending groups completed by iopf_queue_remove_device(). For grouped
requests, measure from reporting the last fault in the group. Use
existing tracing configuration and record fault identity, response code
and elapsed nanoseconds without command submission return values.
Print PASID validity inline as pasid(v) or pasid(i), retaining the raw
validity field for programmatic consumers.

Use the trace_call__ variant after the enabled check to avoid a second
static branch. Document the software timing boundaries and tracefs
interface.

The implementation was validated with x86_64 builds with tracepoints
enabled and disabled.

Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Link: https://lore.kernel.org/all/20261125013430.2144822-1-zhangyuwei20@huawei.com/
Signed-off-by: Chen Jun <chenjun102@huawei.com>
Signed-off-by: Zhang Yuwei <zhangyuwei20@huawei.com>
---
 Documentation/trace/index.rst      |  1 +
 Documentation/trace/iommu-iopf.rst | 54 ++++++++++++++++++++++++++++++
 MAINTAINERS                        |  2 ++
 drivers/iommu/io-pgfault.c         | 18 ++++++++++
 drivers/iommu/iommu-traces.c       |  1 +
 include/linux/iommu.h              |  2 ++
 include/trace/events/iommu.h       | 36 ++++++++++++++++++++
 7 files changed, 114 insertions(+)
 create mode 100644 Documentation/trace/iommu-iopf.rst

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index f4058e8e92e3..e61e428ecd68 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -57,6 +57,7 @@ applications.
    events-landlock
    events-pci
    events-pci-controller
+   iommu-iopf
    boottime-trace
    histogram
    histogram-design
diff --git a/Documentation/trace/iommu-iopf.rst b/Documentation/trace/iommu-iopf.rst
new file mode 100644
index 000000000000..d2c8ae320526
--- /dev/null
+++ b/Documentation/trace/iommu-iopf.rst
@@ -0,0 +1,54 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+IOMMU I/O page fault response latency
+=====================================
+
+The event uses the existing IOMMU I/O page fault handling and event tracing
+configuration; no additional configuration option is needed. For example,
+``CONFIG_ARM_SMMU_V3_SVA`` selects the I/O page fault handling infrastructure
+for ARM SMMUv3.
+
+The ``iommu:iopf_latency`` event measures software response latency from
+entry to ``iommu_report_device_fault()`` until the IOMMU driver's
+``page_response()`` callback returns. Asynchronous group responses,
+synchronous error responses, and pending groups completed with
+``IOMMU_PAGE_RESP_INVALID`` by ``iopf_queue_remove_device()`` are covered.
+It includes software queueing
+and fault handling, but excludes time in hardware queues before reporting.
+The meaning of callback completion depends on the driver; for ARM SMMUv3
+it is after RESUME command submission returns, not after transaction
+recovery. No additional command synchronization is issued.
+
+For grouped requests, one sample measures the interval from reporting the
+last fault in the group to responding to that group. Earlier partial
+requests do not each receive a separate latency event when assembled into
+a group. The address and PASID fields identify the last fault. A
+synchronous error response instead identifies the fault being rejected.
+For ARM SMMUv3 EVTQ stall faults, each reported event is marked as the last
+fault of its group.
+
+For example, with tracefs mounted at ``/sys/kernel/tracing``::
+
+    echo 1 > /sys/kernel/tracing/events/iommu/iopf_latency/enable
+    cat /sys/kernel/tracing/trace_pipe
+    echo 0 > /sys/kernel/tracing/events/iommu/iopf_latency/enable
+
+Each response records the device name, PASID and its validity, group ID
+(stall tag on ARM SMMUv3), fault address, response code, and ``duration_ns``
+in nanoseconds.
+Response codes are
+``IOMMU_PAGE_RESP_SUCCESS`` (0), ``IOMMU_PAGE_RESP_INVALID`` (1), and
+``IOMMU_PAGE_RESP_FAILURE`` (2). The event does not report whether command
+submission succeeded.
+
+Timestamps are taken only while the tracepoint has an enabled consumer.
+A response without a sampled start time produces no latency event. A
+sampled request may span disabling and re-enabling the event, in which case
+the full interval is reported if the tracepoint is enabled at response
+time. Enable transitions are best effort with respect to concurrent faults.
+Trace filters and ring buffer overruns can discard records as usual.
+
+``tracing_on=0`` stops trace buffer recording but does not necessarily
+disable the tracepoint. Other consumers, including perf and BPF, can also
+keep it enabled. Events that never reach the response callback have no
+completed interval to report.
diff --git a/MAINTAINERS b/MAINTAINERS
index 742c4e6b291f..8eed908d6c24 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14019,10 +14019,12 @@ L:	iommu@lists.linux.dev
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
 F:	Documentation/devicetree/bindings/iommu/
+F:	Documentation/trace/iommu-iopf.rst
 F:	drivers/iommu/
 F:	include/linux/iommu.h
 F:	include/linux/iova.h
 F:	include/linux/of_iommu.h
+F:	include/trace/events/iommu.h
 F:	rust/kernel/iommu/
 
 IOMMUFD
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index c16ff1fc4b95..ccf806528f6b 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -6,11 +6,14 @@
  */
 
 #include <linux/iommu.h>
+#include <linux/ktime.h>
 #include <linux/list.h>
 #include <linux/sched/mm.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 
+#include <trace/events/iommu.h>
+
 #include "iommu-priv.h"
 
 /*
@@ -96,6 +99,7 @@ static struct iopf_group *iopf_group_alloc(struct iommu_fault_param *iopf_param,
 
 	group->fault_param = iopf_param;
 	group->last_fault.fault = evt->fault;
+	group->last_fault.report_time_ns = evt->report_time_ns;
 	INIT_LIST_HEAD(&group->faults);
 	INIT_LIST_HEAD(&group->pending_node);
 	list_add(&group->last_fault.list, &group->faults);
@@ -155,6 +159,14 @@ static struct iommu_attach_handle *find_fault_handler(struct device *dev,
 	return attach_handle;
 }
 
+static void iopf_trace_response(struct device *dev, const struct iopf_fault *evt,
+				const struct iommu_page_response *resp)
+{
+	if (trace_iopf_latency_enabled() && evt->report_time_ns)
+		trace_call__iopf_latency(dev, evt, resp,
+					 ktime_get_ns() - evt->report_time_ns);
+}
+
 static void iopf_error_response(struct device *dev, struct iopf_fault *evt)
 {
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
@@ -166,6 +178,7 @@ static void iopf_error_response(struct device *dev, struct iopf_fault *evt)
 	};
 
 	ops->page_response(dev, evt, &resp);
+	iopf_trace_response(dev, evt, &resp);
 }
 
 /**
@@ -219,6 +232,9 @@ int iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 	struct iopf_group abort_group = {};
 	struct iopf_group *group;
 
+	/* Error paths may respond synchronously before reporting returns. */
+	evt->report_time_ns = trace_iopf_latency_enabled() ? ktime_get_ns() : 0;
+
 	attach_handle = find_fault_handler(dev, evt);
 	if (!attach_handle)
 		goto err_bad_iopf;
@@ -334,6 +350,7 @@ void iopf_group_response(struct iopf_group *group,
 
 	mutex_lock(&fault_param->lock);
 	ops->page_response(dev, &group->last_fault, &resp);
+	iopf_trace_response(dev, iopf, &resp);
 	list_del_init(&group->pending_node);
 	mutex_unlock(&fault_param->lock);
 }
@@ -491,6 +508,7 @@ void iopf_queue_remove_device(struct iopf_queue *queue, struct device *dev)
 		};
 
 		ops->page_response(dev, iopf, &resp);
+		iopf_trace_response(dev, iopf, &resp);
 		list_del_init(&group->pending_node);
 		iopf_free_group(group);
 	}
diff --git a/drivers/iommu/iommu-traces.c b/drivers/iommu/iommu-traces.c
index 23416bf76df9..ce2ab3277b5f 100644
--- a/drivers/iommu/iommu-traces.c
+++ b/drivers/iommu/iommu-traces.c
@@ -25,3 +25,4 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(unmap);
 
 /* iommu_error */
 EXPORT_TRACEPOINT_SYMBOL_GPL(io_page_fault);
+EXPORT_TRACEPOINT_SYMBOL_GPL(iopf_latency);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ef5043752a36..199681a8841c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -125,6 +125,8 @@ struct iopf_fault {
 	struct iommu_fault fault;
 	/* node for pending lists */
 	struct list_head list;
+	/* Fault report timestamp in ns, or zero if not sampled. */
+	u64 report_time_ns;
 };
 
 struct iopf_group {
diff --git a/include/trace/events/iommu.h b/include/trace/events/iommu.h
index 373007e567cb..cfcc29a792b2 100644
--- a/include/trace/events/iommu.h
+++ b/include/trace/events/iommu.h
@@ -11,6 +11,8 @@
 #if !defined(_TRACE_IOMMU_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_IOMMU_H
 
+#include <linux/device.h>
+#include <linux/iommu.h>
 #include <linux/tracepoint.h>
 
 struct device;
@@ -156,6 +158,40 @@ DEFINE_EVENT(iommu_error, io_page_fault,
 
 	TP_ARGS(dev, iova, flags)
 );
+
+TRACE_EVENT(iopf_latency,
+
+	TP_PROTO(struct device *dev, const struct iopf_fault *evt,
+		 const struct iommu_page_response *resp, u64 duration_ns),
+
+	TP_ARGS(dev, evt, resp, duration_ns),
+
+	TP_STRUCT__entry(
+		__string(device, dev_name(dev))
+		__field(u32, pasid)
+		__field(bool, pasid_valid)
+		__field(u32, grpid)
+		__field(u64, addr)
+		__field(u32, response)
+		__field(u64, duration_ns)
+	),
+
+	TP_fast_assign(
+		__assign_str(device);
+		__entry->pasid = evt->fault.prm.pasid;
+		__entry->pasid_valid = evt->fault.prm.flags &
+			IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+		__entry->grpid = resp->grpid;
+		__entry->addr = evt->fault.prm.addr;
+		__entry->response = resp->code;
+		__entry->duration_ns = duration_ns;
+	),
+
+	TP_printk("device=%s pasid(%c)=%u grpid=%u addr=0x%llx response=%u duration_ns=%llu",
+		  __get_str(device), __entry->pasid_valid ? 'v' : 'i', __entry->pasid,
+		  __entry->grpid, __entry->addr, __entry->response,
+		  __entry->duration_ns)
+);
 #endif /* _TRACE_IOMMU_H */
 
 /* This part must be outside protection */
-- 
2.22.0


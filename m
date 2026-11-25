Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795570588;
	b=O8dboAOv8kIMX0BqYqaC1JSwuiRE+OlY7nNzE7dDJzp+UpL79YDPwYJ1BKgH1ulzC5yX
	 WV4qCf4k8IBJclq/GuZGVQxAHKte2HNad6a+xIiYhzmvcGFAwC7IOs6XzLLryuKtrYXiM
	 FjNOsi9VmG3R+9511kUYZl/wjWe4zJ0cPi47CA0IcaGKmHMkSLzm2FLxA52rm1Ork0qUQ
	 GEmLn8+/Kt46YI5rnMmQjEXwPz3S9j0xvfc9ldfsLmakYnVeQpXHC2SqtHXKg/KMgQqfV
	 Und6xyatfbpmXGnJTr2W3xFwFdblU2cWyo3IhLFffW/7f+uyuFFqvc57MuLEA0PZf5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795570588;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=CoDH69e6XzIOtyxojAs/Hua9h2l7rwpIoBGHHmKkX/0=;
	b=XPcBx0mz5cyis01khxIsp/VGtHzgLQw7NVmz5pTOZr2ThwAwvkot9PkY8erRKUjKc19m
	 IZ7ZJTTYVdoYVpWF0gLbHzE3acgOAC7C8QnWstixARJ7Sv6qAiKleL2MAE0zHvNBkGKpI
	 sQf+DLAsV7ZHx+R0DKTDgBeJfdoMsgNNJ7REkeZPmn7n+aJHOUCaye9WgUXCB2U2RUFLn
	 qTA0ClcAIB20VJM9raYj0KN91zJ9tr2gldokWH+fKs8MME7yXiFBBH9yLqxh/3Z/hIUSC
	 P3GymIlmIPr5gyjXv50wdBDU+blRLr1q3tRa1w/ZId6Soi5JN/4Vs8L4Bxg/F2nGb9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=AJzm+MRn;
	arc=none smtp.remote-ip=113.46.200.223
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14D4606A321;
	Wed, 25 Nov 2026 01:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E14D4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=AJzm+MRn
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=CoDH69e6XzIOtyxojAs/Hua9h2l7rwpIoBGHHmKkX/0=;
	b=AJzm+MRn1kIlxfFbZWUb3cfgNUmek2GqBNhHqigRQR025B6jY0e8r+99HpWLGK442Q8ZphyXA
	JiUtke7ZEpnOGfX8cb6EbnGzNf9t1PU0KQ+WVpUFlWPBVZfamdxDURNKiYMOOH9EUlZMwJNUW4v
	3IrPdCwyI5CzYsze9KE9Sy0=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4jZ2M52YhZzmV6H;
	Wed, 25 Nov 2026 09:36:01 +0800 (CST)
Received: from whupemk300003.china.huawei.com (unknown [7.152.185.49])
	by mail.maildlp.com (Postfix) with ESMTPS id E542B40563;
	Wed, 25 Nov 2026 09:36:24 +0800 (CST)
Received: from huawei.com (10.50.87.204) by whupemk300003.china.huawei.com
 (7.152.185.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 25 Nov
 2026 09:36:23 +0800
From: Zhang Yuwei <zhangyuwei20@huawei.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	<mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <iommu@lists.linux.dev>,
	<chenjun102@huawei.com>, <zhangyuwei20@huawei.com>
Subject: [PATCH] iommu: Trace I/O page fault response latency
Date: Wed, 25 Nov 2026 09:34:30 +0800
Message-ID: <20261125013430.2144822-1-zhangyuwei20@huawei.com>
X-Mailer: git-send-email 2.22.0
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
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 whupemk300003.china.huawei.com (7.152.185.49)

From: Chen Jun <chenjun102@huawei.com>

Carry an optional monotonic timestamp with each IOPF and preserve it
across group construction, including allocation error paths. Sample it
at the common report entry point and record latency after the driver's
page_response callback returns.

Cover asynchronous group responses and synchronous error responses. For
grouped requests, measure from reporting the last fault in the group.
Use existing tracing configuration and record fault identity, response
code and elapsed nanoseconds without command submission return values.
Print PASID validity inline as pasid(v) or pasid(i), retaining the raw
validity field for programmatic consumers.

Document the software timing boundaries and tracefs interface.

The implementation was validated with x86_64 builds with tracing
enabled and tracing disabled.

Signed-off-by: Chen Jun <chenjun102@huawei.com>
Signed-off-by: Zhang Yuwei <zhangyuwei20@huawei.com>
---
 Documentation/trace/index.rst      |  1 +
 Documentation/trace/iommu-iopf.rst | 52 ++++++++++++++++++++++++++++++
 MAINTAINERS                        |  2 ++
 drivers/iommu/io-pgfault.c         | 17 ++++++++++
 drivers/iommu/iommu-traces.c       |  1 +
 include/linux/iommu.h              |  2 ++
 include/trace/events/iommu.h       | 36 +++++++++++++++++++++
 7 files changed, 111 insertions(+)
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
index 000000000000..259cf23c6899
--- /dev/null
+++ b/Documentation/trace/iommu-iopf.rst
@@ -0,0 +1,52 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+IOMMU I/O page fault response latency
+====================================
+
+The event uses the existing IOMMU I/O page fault handling and event tracing
+configuration; no additional configuration option is needed. For example,
+``CONFIG_ARM_SMMU_V3_SVA`` selects the I/O page fault handling infrastructure
+for ARM SMMUv3.
+
+The ``iommu:iopf_latency`` event measures software response latency from
+entry to ``iommu_report_device_fault()`` until the IOMMU driver's
+``page_response()`` callback returns. Both asynchronous group responses
+and synchronous error responses are covered. It includes software queueing
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
index 782389bd5cd3..82217afd67e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13704,10 +13704,12 @@ L:	iommu@lists.linux.dev
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
index c16ff1fc4b95..72e654ea5ffe 100644
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
+		trace_iopf_latency(dev, evt, resp,
+				   ktime_get_ns() - evt->report_time_ns);
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
diff --git a/drivers/iommu/iommu-traces.c b/drivers/iommu/iommu-traces.c
index 23416bf76df9..ce2ab3277b5f 100644
--- a/drivers/iommu/iommu-traces.c
+++ b/drivers/iommu/iommu-traces.c
@@ -25,3 +25,4 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(unmap);
 
 /* iommu_error */
 EXPORT_TRACEPOINT_SYMBOL_GPL(io_page_fault);
+EXPORT_TRACEPOINT_SYMBOL_GPL(iopf_latency);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ac43b8b93f14..d797b42fdb20 100644
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


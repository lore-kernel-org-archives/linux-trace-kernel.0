Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8447D30C37E
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Jul 2026 17:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012682; cv=none; b=pAnXGTVH9QAzSvqrSI04VhN+zlWO5Xfu7c8ZqyG5Tvjpr/FF7u/i394yKzDrd6OJE0lrJ6p0H4WnS0EVTEF3JxtTBYyfX+uBMvUSIHBSmPn/dUr3siLpbl5Pvr8PEFMLqGuIfDUJ2+ukbUZzbKWGEzM9kC33BtvjEgRJaBQY9Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012682; c=relaxed/simple;
	bh=HUBvyTgOqZ9LLtiG2YEc6JRVJb3TEUk45OfB6+6aa/I=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JZ/9Fz8Yaf2uz8ich/6uXCT+f/JO5pnZ6lgjL7XN00i7ThIR8/BqkzANgN6NnKXaMa9hMddqFKWMuMNF/C/gTzJHDKCMrvWPHa3+AVp/IO/igDM7Ngb1unkmVxaygjSW1HT45CPiOqvjRiMlqYXnd18mgDLX6RiFv+ZTmNC3ABo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n3jLqlob; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VhQV/Qvy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n3jLqlob";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VhQV/Qvy"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662E3KdO514974
	for <linux-trace-kernel@vger.kernel.org>; Thu, 2 Jul 2026 17:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=XlvUuFqU3Dm
	jMlP4PREibbmDL05GByoNW10Ts1vdXMo=; b=n3jLqlobbEgDPK58WllC/cv/cDG
	X1O219SwubbJjxCLUTxtuHroR4GnT63aVz70pRt2RBBz291iXep09gGvq7SEIjjc
	U8nJ943pc2ZgDMgw7pK87OEld+u7PzLpurMHLUPXBmrCIes3n1YzFCfWHkIxvjHb
	sC3TLIvj/gMZca87RwN3zI5fk2mnFEE1v184tcmg99AmP7hQj6dPyIgdvZWffYd4
	BHd3Dlhxgtruf8x3rxMnr7aQKLB9sDaL4Ocwp+a2r9UiEDpdh196VQrLyshy5KCK
	Op867wnkrFb7PgbiIZElZpW4VCpapz8PvZc8gxjDQ6QG7dzuSD4tkLMh5Dw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5npr9yhy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Jul 2026 17:17:59 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-37d4eede8ccso1827527a91.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Jul 2026 10:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783012679; x=1783617479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XlvUuFqU3DmjMlP4PREibbmDL05GByoNW10Ts1vdXMo=;
        b=VhQV/Qvynr3GVfxVH7pwmVUTgwz6a0EGBTW2O0N6Rf2tiX7oreQid/ofOSrUhKi96S
         jIpWhv0BeZk/Z+lmHHKXn0ZA7kYy5ZL6aaoNvrFThumAj+62+IH4DjqzL+1c0xE85etA
         UVo8TWfl3HbYWyMgGZY3u7xR0H58oaNOz8No7hvMXfySYdEgqlvV46jw82q7QnU6ORpI
         5rXC6niI/vVINydk669mRSI8jQ/GSvBBrM3rO5Q13Jqlc2Zwf2NLEenJSqzZuNew+pXC
         WGuAWBj91RxMoD0iVQ9xQmEKNGR5nShGVOU37JdhziIbCFp43LF+oMniyGqiVl8Vjswh
         JwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783012679; x=1783617479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XlvUuFqU3DmjMlP4PREibbmDL05GByoNW10Ts1vdXMo=;
        b=ZRsljXSSNvS4oVFmOcJuwqalt+ptsP/ZzYKlafDzGRYSNwK8HoNZmLNZ/NzGZdVn8U
         HrxPQkhykFQCj53lThiYvZzXWaWim6xKgXQJTE+OZn+1/O6vtF1RYSVEggcnIBFpuxEV
         Zl3KZOeYVLVcCrn+uHTgblHYMbE0s96RL5yISSp4QAjA5hwsaHsTN9z0QMtzba+fGb0t
         hUFSJ8LR/gKWEHrlz6vnzxdrN6a6iXKU0S+jTcKPziU1qC4tqIoLWWo5kZv9uEvWCS1Q
         l02FxpLArCzw3JZIYhC+ibmZthRWBGqPMqS1IJYc0vpICnoXE71p/+ppQ6RFFWyoJGie
         HMfA==
X-Forwarded-Encrypted: i=1; AHgh+RovVX2XvtEXQOsdunFnx6fb/WvlSTdoM8CHAeaxXlMyCN22flu2usaeEBlgRQfVXlaYsFuWE42KUNggRASq3zc2jPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQDERK5gR4CxZyvO4It3PhhIczB0JT7vCnV2wNyl/ffdtTB9cz
	vYAjbIWN3skXLl3GHfMJzUj49CuuiGS3U6I2mwu1Q1hEEbsFn3HyyV/5kL5bhio9pfAg9jqN/t3
	EYFpnbHMLayExopU69kTBaoJsqcnimKmxv1B0vO+jN/e+lw85IBLKYx9r3AQfDnofBHUCmF7/M4
	c=
X-Gm-Gg: AfdE7clnWTsivaMA/bkn65xbUwjhQ9qtmCJMUTXu6Y4hTN8esIl0s9th8uG+prz8hOT
	6MeDalNVAFCIEH+OuGzOv5rFnTwrk9Ve3dvB1EDWr2UiNpL7yOlUkfBhOfEAHJtfTlYQbRHiBov
	uvKuYge4idJrqPBkQSHPxqYeZIOT8i3sE3zeM4maDb1pA2ok6HoEkfhEVu25DNWUnEw8BM4eHRP
	mduyg1hELNsCVK3v4cSrJDZaOYtepPUEvRf6HiPl4cF/c7y0ATwvfCC4u7GEuGd2s9ioeME+DQw
	IL2zyD0TSmfP0iQG1O1owa+ASXRjhlrQeU2Q34Hzkq5+Lc7xXG9iT6eb3ABNSkmotYKgTJpucsN
	H9IyPQAqynFOxUkG9ZprAJFOaTvDcCYtGeU92R09k5N/0QfAGvoxMJj6hVSKwPXMgfq4YqpD77T
	kCytnaflMlRJxQ8A==
X-Received: by 2002:a17:90b:5150:b0:37f:d9dc:557 with SMTP id 98e67ed59e1d1-380aa1c7d31mr7534595a91.16.1783012678732;
        Thu, 02 Jul 2026 10:17:58 -0700 (PDT)
X-Received: by 2002:a17:90b:5150:b0:37f:d9dc:557 with SMTP id 98e67ed59e1d1-380aa1c7d31mr7534541a91.16.1783012678094;
        Thu, 02 Jul 2026 10:17:58 -0700 (PDT)
Received: from hu-pintu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bb80f5csm16582767eec.15.2026.07.02.10.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 10:17:57 -0700 (PDT)
From: Pintu Kumar Agarwal <pintu.agarwal@oss.qualcomm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        hannes@cmpxchg.org, surenb@google.com, rostedt@goodmis.org,
        mhiramat@kernel.org, peterz@infradead.org,
        mathieu.desnoyers@efficios.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, kprateek.nayak@amd.com,
        pintu.agarwal@oss.qualcomm.com, pintu.ping@gmail.com,
        nathan@kernel.org, ojeda@kernel.org, nsc@kernel.org, gary@garyguo.net,
        tglx@kernel.org, thomas.weissschuh@linutronix.de, aliceryhl@google.com,
        dianders@chromium.org, linux.amoon@gmail.com, rdunlap@infradead.org,
        akpm@linux-foundation.org, shuah@kernel.org
Subject: [RFC PATCH 1/1] psi: Introduce in-kernel PSI auto monitor feature
Date: Thu,  2 Jul 2026 22:46:06 +0530
Message-Id: <20260702171606.527077-2-pintu.agarwal@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702171606.527077-1-pintu.agarwal@oss.qualcomm.com>
References: <20260702171606.527077-1-pintu.agarwal@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: QZ_qflQN3AsHP_7wCsmhAWPpC9uOuB7u
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE4MiBTYWx0ZWRfX8MCE7IbXOpBt
 VgQOl8wFO4nScu38UfI20B7RMAopojlSCDUHr/RCCQLkuQ2DWbido+bJJaI2PSvXqj5zhdBlqGt
 grNpCZ9rgpey7BThMWzWcBhghgrSyX8=
X-Authority-Analysis: v=2.4 cv=NsvhtcdJ c=1 sm=1 tr=0 ts=6a469d47 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=557R9myWNUNzTcYUoKoA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: QZ_qflQN3AsHP_7wCsmhAWPpC9uOuB7u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE4MiBTYWx0ZWRfX4GfBhrLFbLj+
 wT67KFeS0UEh4Yt0btgFXiULD/CQxQf72mfxgSsQcnGqC1533bbyfy17u1INpu1/7i67jiEMkav
 SkpjjA2MiBTC4KNVqJMFrfLQACbdfovgDiJ4EHeD+K4QL3HxRoQbRbMhnL1wIa0UULcBnbWDqVE
 GKxxrKERFG8oX+907jmNPFQsp0CSMOEvUlJ/0skFj7SRDExuH067xz3ym+7G7Y9K7rbyrhVVFFp
 BTaVtfXqO9k0Z1jtnufsQmxlsfMiQIn1cQNFNO8eglNNX3/da9OtmsjfzE6bbY1Zde2hke5KqB8
 aJpjP7tK2afuEUruEngxN4WCR6MXp6R4r+wgG6hOtW8Com26zffEDeZ4eaPgyYXSzsg+WZjAqhg
 FZyZuuEY+xeJvpB8+yuDf1jysBK2IW0suU/vuXymw29G+E13ndCwDjjfkm5PRp6MdkPulFMGVAn
 9CCk8F8oTh1e4ZDzb9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1011 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020182

Pressure Stall Information (PSI) provides accurate detection of CPU,
memory and I/O contention and supports event notifications via trigger
windows and poll-based interfaces. However, PSI intentionally does not
attribute pressure to individual tasks. As a result, developers must
reconstruct root cause in user space by correlating multiple tools,
logs, or tracing data after the fact.

In practice, this becomes difficult under severe pressure conditions,
where systems are already degraded and user-space observers may be
delayed or miss the critical window entirely.
Moreover, we need to gather information before the situation occurs
and not after the problem arises.

This patch introduces an optional in-kernel PSI auto monitor that
captures contributing tasks at the exact moment configured PSI
thresholds are breached. The monitor periodically samples PSI state and,
upon sustained pressure, records the top contending tasks based on a
lightweight composite score derived from CPU runtime, RSS and I/O
activity.

Key design points:
- No modifications to PSI fast paths
- No dependency on user-space daemons or continuous polling
- Uses existing kernel accounting and tracepoints
- Provides structured trace events for integration with tracing tools
- Runtime configurable thresholds and sampling interval

The goal is not to replace existing PSI mechanisms or user-space
components such as oomd, but to complement them by providing
low-latency, in-context attribution data at the point of pressure.

Experimental results across multiple platforms and workloads,
including real time scenarios, show improved accuracy and reduced time
to root-cause identification, especially in transient and high-pressure
conditions such as system boot and stress workloads.

This patch is submitted as RFC to gather feedback on:
- suitability of in-kernel attribution vs user-space approaches
- interface choice (sysfs vs trace-based control)
- dmesg logging when threshold hit, just like OOM messages
- some avg10 monitoring as default choice
- default threshold values and tasks count
- scoring methodology and configurability
- potential integration with existing PSI infrastructure

Signed-off-by: Pintu Kumar Agarwal <pintu.agarwal@oss.qualcomm.com>
Assisted-by: Copilot:Auto
Assisted-by: ChatGPT:GPT-5.5
---
 include/trace/events/psi_monitor.h |  53 +++++
 init/Kconfig                       |  16 ++
 kernel/sched/build_utility.c       |   4 +
 kernel/sched/psi_monitor.c         | 307 +++++++++++++++++++++++++++++
 4 files changed, 380 insertions(+)
 create mode 100644 include/trace/events/psi_monitor.h
 create mode 100644 kernel/sched/psi_monitor.c

diff --git a/include/trace/events/psi_monitor.h b/include/trace/events/psi_monitor.h
new file mode 100644
index 000000000000..cf99f5994472
--- /dev/null
+++ b/include/trace/events/psi_monitor.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Tracepoints for PSI automatic monitor
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM psi_monitor
+
+#if !defined(_TRACE_PSI_MONITOR_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_PSI_MONITOR_H
+
+#include <linux/types.h>
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(psi_monitor_top_task,
+
+	TP_PROTO(pid_t pid, const char *comm,
+		unsigned long cpu_ms,
+		unsigned long rss_kb,
+		unsigned long io_kb,
+		u64 score),
+
+	TP_ARGS(pid, comm, cpu_ms, rss_kb, io_kb, score),
+
+	TP_STRUCT__entry(
+		__field(pid_t, pid)
+		__string(comm, comm)
+		__field(unsigned long, cpu_ms)
+		__field(unsigned long, rss_kb)
+		__field(unsigned long, io_kb)
+		__field(u64, score)
+	),
+
+	TP_fast_assign(
+		__entry->pid = pid;
+		__assign_str(comm);
+		__entry->cpu_ms = cpu_ms;
+		__entry->rss_kb = rss_kb;
+		__entry->io_kb = io_kb;
+		__entry->score = score;
+	),
+
+	TP_printk("pid=%d comm=%s cpu_ms=%lu rss_kb=%lu io_kb=%lu score=%llu",
+		__entry->pid, __get_str(comm),
+		__entry->cpu_ms, __entry->rss_kb,
+		__entry->io_kb,
+		(unsigned long long)__entry->score)
+);
+
+#endif /* _TRACE_PSI_MONITOR_H */
+
+/* This must be outside the header guard */
+#include <trace/define_trace.h>
diff --git a/init/Kconfig b/init/Kconfig
index 5230d4879b1c..074693f76b17 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -757,6 +757,22 @@ config PSI_DEFAULT_DISABLED
 
 	  Say N if unsure.
 
+config PSI_AUTO_MONITOR
+	bool "In-kernel automatic PSI monitor with sysfs + weighted scoring"
+	depends on PSI && TASK_XACCT && TASK_IO_ACCOUNTING && TRACEPOINTS
+	default n
+	help
+	  Enables a kernel-internal PSI observer that periodically checks CPU,
+	  memory, and I/O pressure via a delayed workqueue. When thresholds
+	  are breached, it ranks tasks by weighted RSS, I/O, and CPU usage,
+	  then logs top-N tasks via printk and emits trace events.
+
+	  Thresholds, poll interval and weights are tunable at runtime via:
+	  /sys/kernel/psi_monitor/
+
+	  Say N if unsure.
+
+
 endmenu # "CPU/Task time and stats accounting"
 
 config CPU_ISOLATION
diff --git a/kernel/sched/build_utility.c b/kernel/sched/build_utility.c
index e2cf3b08d4e9..30e9800ce947 100644
--- a/kernel/sched/build_utility.c
+++ b/kernel/sched/build_utility.c
@@ -104,3 +104,7 @@
 #ifdef CONFIG_SCHED_AUTOGROUP
 # include "autogroup.c"
 #endif
+
+#ifdef CONFIG_PSI_AUTO_MONITOR
+# include "psi_monitor.c"
+#endif
diff --git a/kernel/sched/psi_monitor.c b/kernel/sched/psi_monitor.c
new file mode 100644
index 000000000000..e929a0c05494
--- /dev/null
+++ b/kernel/sched/psi_monitor.c
@@ -0,0 +1,307 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PSI Automatic Monitor with Weighted Task Ranking + Tracepoints
+ *
+ * Periodically samples system PSI (CPU, memory, IO) and, when any
+ * configured threshold is exceeded, ranks tasks using a composite
+ * score based on RSS, I/O activity and CPU time, then logs the
+ * top-N tasks via printk and a tracepoint.
+ *
+ * Sysfs interface:
+ *   /sys/kernel/psi_monitor/cpu_thresh		 (percentage)
+ *   /sys/kernel/psi_monitor/mem_thresh		 (percentage)
+ *   /sys/kernel/psi_monitor/io_thresh		 (percentage)
+ *   /sys/kernel/psi_monitor/monitor_interval_ms (milliseconds)
+ *   /sys/kernel/psi_monitor/rss_weight
+ *   /sys/kernel/psi_monitor/io_weight
+ *   /sys/kernel/psi_monitor/cpu_weight
+ *
+ * Author: Pintu Kumar Agarwal
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/sched/signal.h>
+#include <linux/sched/loadavg.h>
+#include <linux/mm.h>
+#include <linux/delay.h>
+#include <linux/workqueue.h>
+#include <linux/psi_types.h>
+#include <linux/kobject.h>
+#include <linux/sort.h>
+#include <linux/jiffies.h>
+#include <linux/time64.h>
+#include <linux/sched/cputime.h>
+
+/* Create tracepoints defined in include/trace/events/psi_monitor.h */
+#define CREATE_TRACE_POINTS
+#include <linux/psi.h>
+#include <trace/events/psi_monitor.h>
+
+
+/* Sysfs tunables */
+static unsigned int cpu_thresh = 80;	  /* in percent */
+static unsigned int mem_thresh = 80;	  /* in percent */
+static unsigned int io_thresh  = 80;	  /* in percent */
+static unsigned int monitor_interval_ms = 10000;
+
+/* scoring weights */
+static unsigned int rss_weight = 2;
+static unsigned int io_weight  = 1;
+static unsigned int cpu_weight = 5;
+
+static struct delayed_work psi_work;
+static struct kobject *psi_kobj;
+
+#define TOP_N 20
+
+struct task_info {
+	struct task_struct *task;
+	unsigned long rss;      /* pages */
+	unsigned long io_kb;    /* kB */
+	unsigned long cpu_ms;   /* ms */
+	u64 score;
+};
+
+/*
+ * psi_avg10_percent() - derive a rough integer percentage from avg10
+ * for a given PSI state (e.g. PSI_CPU_SOME, PSI_MEM_SOME, PSI_IO_SOME).
+ *
+ * psi_group.avg[state][0] is the avg10 window in fixed-point notation.
+ * The conversion here is approximate but monotonic, which is sufficient
+ * for thresholding and ranking in this internal monitor.
+ */
+static unsigned long psi_avg10_percent(int state)
+{
+	u64 avg10;
+
+	if (state < 0 || state >= NR_PSI_STATES)
+		return 0;
+
+	avg10 = READ_ONCE(psi_system.avg[state][0]);
+	if (!avg10)
+		return 0;
+
+	/* Convert back from loadavg-style fixed-point to an approximate % */
+	/* Just consider the integer value and ignore fraction */
+	return LOAD_INT(avg10);
+}
+
+static int compare_score_desc(const void *a, const void *b)
+{
+	const struct task_info *ta = a;
+	const struct task_info *tb = b;
+
+	if (tb->score > ta->score)
+		return 1;
+	if (tb->score < ta->score)
+		return -1;
+	return 0;
+}
+
+static void log_top_tasks(void)
+{
+	struct task_info tasks[TOP_N];
+	struct task_struct *p, *t;
+	int count = 0;
+	int i;
+
+	rcu_read_lock();
+	for_each_process_thread(p, t) {
+		struct mm_struct *mm;
+		unsigned long rss = 0;
+		unsigned long io_kb = 0;
+		unsigned long cpu_ms = 0;
+		u64 score;
+
+		/* Ignore tasks that are not on run queue or idle */
+		if (!t->on_rq && !is_idle_task(t))
+			continue;
+
+		mm = get_task_mm(t);
+
+		/* mm could be NULL for kernel threads */
+		if (mm) {
+			rss = mm ? get_mm_rss(mm) : 0;
+			mmput_async(mm);
+		}
+
+		/*
+		 * Approximate I/O activity: sum of read + write bytes.
+		 * This uses the task_io_accounting fields in task_struct.
+		 * Values are best-effort and need not be perfectly accurate
+		 * for our ranking purpose.
+		 */
+		io_kb = (t->ioac.read_bytes + t->ioac.write_bytes) >> 10;
+
+		/*
+		 * Approximate CPU usage via task_sched_runtime(), converted
+		 * to milliseconds. This is cumulative since task start, but
+		 * is still useful for comparing hotspots at a given point.
+		 */
+		cpu_ms = (unsigned long)(task_sched_runtime(t) / NSEC_PER_MSEC);
+
+		score = (u64)rss_weight * (u64)rss +
+			(u64)io_weight  * (u64)io_kb +
+			(u64)cpu_weight * (u64)cpu_ms;
+
+		if (count < TOP_N) {
+			tasks[count].task   = t;
+			tasks[count].rss    = rss;
+			tasks[count].io_kb  = io_kb;
+			tasks[count].cpu_ms = cpu_ms;
+			tasks[count].score  = score;
+			count++;
+		} else {
+			/* Maintain a simple streaming top-N: replace smallest */
+			int min_idx = 0;
+			int j;
+
+			for (j = 1; j < TOP_N; j++) {
+				if (tasks[j].score < tasks[min_idx].score)
+					min_idx = j;
+			}
+
+			if (score > tasks[min_idx].score) {
+				tasks[min_idx].task   = t;
+				tasks[min_idx].rss    = rss;
+				tasks[min_idx].io_kb  = io_kb;
+				tasks[min_idx].cpu_ms = cpu_ms;
+				tasks[min_idx].score  = score;
+			}
+		}
+	}
+	rcu_read_unlock();
+
+	sort(tasks, count, sizeof(struct task_info), compare_score_desc, NULL);
+
+	pr_info("psi_monitor: logging top %d tasks under pressure:\n", count);
+
+	for (i = 0; i < count; i++) {
+		struct task_struct *ts = tasks[i].task;
+		unsigned long rss_kb = tasks[i].rss << (PAGE_SHIFT - 10);
+		char name[128] = {0,};
+
+		if (ts->flags & PF_WQ_WORKER)
+			wq_worker_comm(name, sizeof(name), ts);
+		else
+			scnprintf(name, sizeof(name) - 1, ts->comm);
+
+		trace_psi_monitor_top_task(ts->pid, name,
+				tasks[i].cpu_ms,
+				rss_kb,
+				tasks[i].io_kb,
+				tasks[i].score);
+
+		pr_info("psi_monitor: pid=%d comm=%s psi_flag=%d oncpu=%d cputime(ms)=%lu rss(kB)=%lu io(kB)=%lu score=%llu\n",
+			ts->pid, name, ts->psi_flags, task_cpu(ts),
+			tasks[i].cpu_ms, rss_kb, tasks[i].io_kb,
+			(unsigned long long)tasks[i].score);
+		}
+}
+
+static void psi_monitor_fn(struct work_struct *work)
+{
+	unsigned long cpu_pct, mem_pct, io_pct;
+	bool trigger = false;
+
+	cpu_pct = psi_avg10_percent(PSI_CPU_SOME);
+	mem_pct = psi_avg10_percent(PSI_MEM_SOME);
+	io_pct  = psi_avg10_percent(PSI_IO_SOME);
+
+	if (cpu_pct >= cpu_thresh || mem_pct >= mem_thresh ||
+		io_pct >= io_thresh)
+		trigger = true;
+
+	if (trigger) {
+		pr_info("psi_monitor: pressure high: cpu=%lu%% mem=%lu%% io=%lu%% (thresh cpu=%u mem=%u io=%u)\n",
+			cpu_pct, mem_pct, io_pct,
+			cpu_thresh, mem_thresh, io_thresh);
+		log_top_tasks();
+	}
+
+	queue_delayed_work(system_wq, &psi_work,
+		msecs_to_jiffies(monitor_interval_ms));
+}
+
+/* Sysfs helpers */
+#define PSI_ATTR_RW(_name)						\
+static ssize_t _name##_show(struct kobject *kobj,			\
+			struct kobj_attribute *attr, char *buf)		\
+{									\
+	return sysfs_emit(buf, "%u\n", _name);				\
+}									\
+static ssize_t _name##_store(struct kobject *kobj,			\
+			    struct kobj_attribute *attr,		\
+			    const char *buf, size_t count)		\
+{									\
+	unsigned int val;						\
+	if (kstrtouint(buf, 10, &val))					\
+		return -EINVAL;						\
+	_name = val;							\
+	return count;							\
+}									\
+static struct kobj_attribute _name##_attr = __ATTR_RW(_name)
+
+PSI_ATTR_RW(cpu_thresh);
+PSI_ATTR_RW(mem_thresh);
+PSI_ATTR_RW(io_thresh);
+PSI_ATTR_RW(monitor_interval_ms);
+PSI_ATTR_RW(rss_weight);
+PSI_ATTR_RW(io_weight);
+PSI_ATTR_RW(cpu_weight);
+
+static struct attribute *psi_attrs[] = {
+	&cpu_thresh_attr.attr,
+	&mem_thresh_attr.attr,
+	&io_thresh_attr.attr,
+	&monitor_interval_ms_attr.attr,
+	&rss_weight_attr.attr,
+	&io_weight_attr.attr,
+	&cpu_weight_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group psi_attr_group = {
+	.attrs = psi_attrs,
+};
+
+static int __init psi_monitor_init(void)
+{
+	int ret;
+
+	INIT_DELAYED_WORK(&psi_work, psi_monitor_fn);
+	queue_delayed_work(system_wq, &psi_work,
+			msecs_to_jiffies(monitor_interval_ms));
+
+	psi_kobj = kobject_create_and_add("psi_monitor", kernel_kobj);
+	if (!psi_kobj)
+		return -ENOMEM;
+
+	ret = sysfs_create_group(psi_kobj, &psi_attr_group);
+	if (ret) {
+		kobject_put(psi_kobj);
+		cancel_delayed_work_sync(&psi_work);
+		return ret;
+	}
+
+	pr_info("psi_monitor: in-kernel PSI auto monitor (weighted + tracepoints) loaded\n");
+	return 0;
+}
+
+static void __exit psi_monitor_exit(void)
+{
+	cancel_delayed_work_sync(&psi_work);
+	if (psi_kobj)
+		kobject_put(psi_kobj);
+	pr_info("psi_monitor: unloaded\n");
+}
+
+module_init(psi_monitor_init);
+module_exit(psi_monitor_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Pintu Kumar Agarwal");
+MODULE_DESCRIPTION("In-kernel PSI automatic monitor with sysfs, weighted scoring and tracepoints");
-- 
2.34.1


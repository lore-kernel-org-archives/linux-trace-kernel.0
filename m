Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D803148D2
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Jul 2026 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012656; cv=none; b=irqfhxfYH1C3lpmv2ibQADqhAmFtovGpEAxFMS2IayiGTgiLunw6/w4nt7Ph21EOqCVbDRuIac3qZXlds+hpiWwqGtND3p7GPMpfsPQTyV/tOo3izQxhicQrjoUGgFi6Ykc2pACGOKtdmWCqqblAhHr3VvIQt8kWQqEv6gMsUQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012656; c=relaxed/simple;
	bh=CiSDEVtJCUgDjOXSATzlhMG2ssl1rFme5N1JghbXl6Q=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=uyAynD3FtJsvhMoP4Lf2aU9DeEsYioxLDddHR1Np10PImt72SUQKtSogQ+ZqVbtd8nJU6e/MONz3vr6u7EG5WSWiuaf3/oU8k0jxQI0UE6tYGwONrev/f3LtuNcYUd43SPjunPSCD6dMJn0L7oj3Eabf47WJwWsWDqhJvEAn9IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U5Z/8to4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fJyi0kJL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U5Z/8to4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fJyi0kJL"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662E3IWm558491
	for <linux-trace-kernel@vger.kernel.org>; Thu, 2 Jul 2026 17:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=4sfY76Jt2Gh7+YPX2aJ3Rq
	ujkoz6qV+xs+njibYajIY=; b=U5Z/8to4hNzSF0PGuW70oSdVIj0ashs8R5/eso
	j/gbiTLX2B+8lyhxxhGNoUk6QFsl3RHhPaiU4S3/yAmowOcipH5nG87oxYhXK8fA
	gTIubBVItu27MkYlL/FDNFFLNwJlHNI/BW+APk92Hgzw2fqUTIqkt5QD4qcheEIX
	Wvgc9s+ezYwogwsBGfulyRSh/2ii5K5RhpRcKRCafKI5b9qCL8fdHJExF3HATxhz
	ubdRcrNNXmJHeqXpHcFlXBdkrVJpQUJVJg31xSOHo5YfhvGAD5e1m0w33MATUYqt
	shEvzPA1PI20yZAVsxhFBTku9qTN3/welROcgO2el0bQ/g+g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n94238d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Jul 2026 17:17:33 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c9541d25af7so942114a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Jul 2026 10:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783012653; x=1783617453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4sfY76Jt2Gh7+YPX2aJ3Rqujkoz6qV+xs+njibYajIY=;
        b=fJyi0kJLl2wSYIa0p9/m7vMYLtcgm8mFJjK1iTEkh4K+NKqZn+kCKfx6ExMtMezuYh
         XgI5olxb9ITFc4wfrsTRC0DG5uaQIVEjoIehqkR0yhlQ93m/aSL19ICNycuzgKPs0Hzf
         SWKa+5bVw1jDQLKFSt+Aj6nvJcmEi/nd5bqf/9bynSS6HK31CNniMBZcPokuEx/YnSB2
         1XJW4AikDEp1LLK43ZauCrfh9InbZFHP9zXaAYRcsLmm5R8NZrtZvi+mziP6zbNhY3t3
         eZoIeMGnR0hW81yyfL+D5CMguMmGuM6fD3a7qftjIQp/8hQsRsvBtFGOYmscIWnGh6rP
         saGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783012653; x=1783617453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4sfY76Jt2Gh7+YPX2aJ3Rqujkoz6qV+xs+njibYajIY=;
        b=ffq6oiXFQ2bY80kC3LH9fs8bqq1JlAhDF3RT2r1bwbTXVPH/RBnmKLF1XEFJl0KDI2
         xsKsatEl9/JCBeI9zV3572yc99alRqtWtXpjc6b3Fpd1wGpu6BxESeoeNNrakygcWk4g
         wz1J+y0nmpbXWupUQSiea5r5yKweh+7fgEf340v8r51BYJCTxgm/pCQDCLeAZLJ6owOj
         MH3MswN8ZTDTNTUpemtLk0EaWq8RPaucTMtL2NCN2Hk3S6tLSv1kkJGlX7EERDNU+6Kk
         VlTa0ZiuK9Cf1A1Lb+AtgfFF6nwNFxEp/Lt4WKCVXyMfzogOPfB7NuTbBEng8wbbbYmQ
         6JCQ==
X-Forwarded-Encrypted: i=1; AFNElJ+B7bLuM1ZxyOT4RlBY9oWCs+37fHGfG3qdLN1t+fxoAitfCDaIZRM5vm47eEklSuNvGeyK+tYv4Kh/GPN7KbTZMoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ/Q0SFDxu/836AWjQihWj8XvY1R+CALBhoWCHul8yoGL4Oo/J
	CtoxvWiSMewkdYRn49qtmcBNQz9pKy8E//WuwJtsZGDDvjNtnxCvCnV6TDW95yZHpTmZ1LWJKmU
	7T/frNmHl9nEIHNhfUs1ovWI8jOQzpYRmWIAYVvFTkzUEnviHOk31sPROy+rSL1q2ANkNQRGL8S
	c=
X-Gm-Gg: AfdE7cmZPU/6NKrOlXm9sUSc6Vb/mGQdiG2pWOkzFYgHBiiymP4e+k4bW+3ZoExmURR
	tzZGYfM6bKxVGn9wiis/wV6z56BKfzzKWNlrq2QkOnAP/11CbdO25NaAqomtx6EEsViCfe2eJ6C
	clWMr3eFOtuCFD3xDNEQJYwSuiVqT9yz4eKx4zUaO9dnFfUp4vexD4sLcKFNgh6Iwtrpucef51c
	AaqKroA7/rhUD4giL5FYwL3UNIZFukBKSkMNv+wU2QMmLPHDV6eN/0YbGN53ZtwFfbERZkqdfaw
	MqwYA//q8WpNKcqaTLB+ZGH73svWDA8q7kS5La0VzHdD4eUqPYJwDQ63L/CWnc+VlGusFxnsMlV
	T8NQPFRP59JiC/zoG+93+02DhqwC6DMCKEHXrfiR5CSWI9OW0csMxsL9wcigYMh7Xo2OzuV8ODn
	3Nascy5OBW4Tg9nQ==
X-Received: by 2002:a05:6a20:7288:b0:3bf:8230:1b71 with SMTP id adf61e73a8af0-3c01caacc38mr734670637.25.1783012652982;
        Thu, 02 Jul 2026 10:17:32 -0700 (PDT)
X-Received: by 2002:a05:6a20:7288:b0:3bf:8230:1b71 with SMTP id adf61e73a8af0-3c01caacc38mr734621637.25.1783012652386;
        Thu, 02 Jul 2026 10:17:32 -0700 (PDT)
Received: from hu-pintu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bb80f5csm16582767eec.15.2026.07.02.10.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 10:17:32 -0700 (PDT)
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
Subject: [RFC PATCH 0/1] psi: Introduce in-kernel PSI auto monitor feature
Date: Thu,  2 Jul 2026 22:46:05 +0530
Message-Id: <20260702171606.527077-1-pintu.agarwal@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE4MSBTYWx0ZWRfXxAXwk0K+tT5X
 k7kuv7QFlN8d2LqeC5UA+bg3YWGdIHxLbzTINaWrgr8cLfes4vpgIUuMHWQQCYR+mO0FWZN8AmB
 XFm5BoxfmsmE+8MlGb3rxstFU13UnpfIC3rj4DKhy0LYUWIOJDZiSHaWHJmdkYYOCpnhoKnvHdv
 e7G8yIc/kR/AaKp+yvKxIamg8mN07PDtx5kU2VWYTLDmtLJNoypGt0YLURzjYj8mPONeAy+NYnk
 GWrTf6gpz5AXh0CuJ3T7kjbMPFykhPNXH5IWGr0+FokJWhEarsWQjn4gPMYkIlWw0z5sw4/m3A4
 UcQ99/jXLZMYdksMqFAKxZ+hdowYbNXaNE2kV0vklR3LtfU5Uv4W3xtQs7pWkdoyWrRZkQROQ3E
 +0ThT8+04blDJt7LJym15UeYj2txDpmH+69WwwgyK6W51COxW51Gok1L17KL1OLMtQ31rwN07Tw
 t/wWe/IsG1afzkarseg==
X-Authority-Analysis: v=2.4 cv=Lv+iDHdc c=1 sm=1 tr=0 ts=6a469d2d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=NEAV23lmAAAA:8 a=vugxpd_pAAAA:8 a=4oupQTzvAAAA:8 a=OGjWj8McAAAA:8
 a=X3e8lVCY1utBfByIQyoA:9 a=r-HJ9bD__24A:10 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=Nf1TvN9YFKQkMYgUzGF3:22
 a=dlIDbnWlQMEhdIxAeUMX:22 a=F_R_EHrqUKoJocvyGl7m:22 a=UYjydHh6ynBBc6_pBLvz:22
X-Proofpoint-ORIG-GUID: zSvZ8kVDKCnQfJ0MAT9-dfg0vqwx74pp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE4MSBTYWx0ZWRfX3ck9+1PXOpTY
 MNdjEnuMQS/VRWRFom4az5RQlZnKJlVXW0Ps8PGQ3iFZI3SkhBRhxKz9Ocdi/t1YWJ0fKpD9I1p
 aLwYrutjg1vtg9BZ18nqyQg80p68e84=
X-Proofpoint-GUID: zSvZ8kVDKCnQfJ0MAT9-dfg0vqwx74pp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1011
 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020181

Hi all,

This RFC introduces an in-kernel PSI auto monitor aimed at improving
root-cause visibility for resource pressure events in Linux systems.

Motivation:

PSI already provides an excellent mechanism to detect CPU, memory and
I/O pressure and includes trigger-based notifications via pollable
interfaces. However, it deliberately avoids attributing pressure to
individual tasks.

In real-world systems, this creates a gap: when a PSI trigger fires,
users still need to determine *which tasks caused the stall* by combining
multiple tools (top, meminfo, vmstat, perf, tracing, etc.), often after
the event has already passed.

This process becomes particularly difficult during:
- transient bursts of pressure
- system boot or early initialization before user space
- PREEMPT_RT or latency-sensitive workloads
- heavily loaded embedded systems where user space is delayed
- small resource-constraints minimal system
- production system where most debugging interface are disabled

Proposal:

This patch introduces an optional in-kernel PSI auto monitor that:
- periodically samples PSI signals
- detects threshold breaches
- captures top contributing tasks at that moment
- emits trace events and kernel logs for analysis

The design goal is **low-latency attribution at the source of truth**,
without relying on user-space daemons or polling loops.

Why in-kernel?

While similar logic can be implemented in user space, there are inherent
limitations:

- scheduling delays under high pressure
- risk of missing short-lived spikes
- dependency on continuous polling or daemons
- difficulty deploying in early boot or minimal environments

In contrast, the in-kernel approach:
- observes PSI signals without scheduling latency
- captures contributors exactly at threshold breach
- works during early boot and degraded system states
- avoids duplicating logic across multiple user-space tools
- easy configurable even in runtime
- captures all sorts of information during same timestamp

Design Highlights:

- Does not modify PSI fast paths
- Optional (CONFIG_PSI_AUTO_MONITOR)
- Runtime configurable thresholds and interval
- Uses existing kernel accounting (task runtime, RSS, I/O stats)
- Provides structured tracepoints for post-processing
- Lightweight and intended for diagnostic use
- Idea is similar to, when OOM occurs dump contending tasks

Reviews and Assistance:

The core idea is mine.
However, I have taken few assistance from AI for review and enhancement.
I have done extensive review and suggestion using ChatGPT and Copilot.
The commit message and this cover letter were also prepared by Copilot.
I have done self-review and corrective actions accordingly.

Experimental Validation:

The feature has been evaluated on multiple ARM64 platforms (Cortex-A53,
A55) across different kernels and storage setups.
Extensive experiments has been carried out with multiple workloads.
Some tools and logs are shared here:
https://github.com/pintuk/KERNEL/tree/master/PSI_WORK

Test scenarios include:
- CPU/memory/IO stress workloads both on eMMC and NAND
- system boot tracing (no external tools)
- mixed workloads (stress-ng, workqueues, user/kernel threads, processes)
- PREEMPT_RT cyclictest correlation with real workloads

Results show:
- consistent identification of top resource contributors
- improved root-cause visibility compared to user-space-only methods
- ability to capture transient hotspots during boot and runtime
- correlation of latency spikes with system pressure

Papers and Reference:

The paper is presented in Open Source Summit India - 2026:
https://ossindia2026.sched.com/event/2KNI4/introducing-in-kernel-psi-auto-monitor-feature-pintu-kumar-agarwal-qualcomm?iframe=yes&w=100%&sidebar=yes&bg=no
https://hosted-files.sched.co/ossindia2026/19/OSS-IND-26-PSI-Auto-Monitor.pdf
The initial idea was also presented in LPC-2024:
https://lpc.events/event/18/contributions/1884/attachments/1439/3069/LPC2024_PIntu_PSI.pdf

Open Questions (RFC):

Feedback is especially appreciated on:

- whether this functionality belongs in-kernel vs user-space
- interface choice (sysfs vs tracefs/debugfs alternatives)
- scoring heuristic (CPU/RSS/IO weighting)
- potential reuse or extension of existing PSI interfaces
- cgroup-aware extensions for future work

Future Work:

- finer-grained PSI window integration
- IRQ pressure support
- cgroup-based attribution
- improved tracing/export interfaces
- optional integration with user-space analysis tools

Thanks for your time, and I’d really appreciate feedback.

Regards,
Pintu Kumar Agarwal

Pintu Kumar Agarwal (1):
  psi: Introduce in-kernel PSI auto monitor feature

 include/trace/events/psi_monitor.h |  53 +++++
 init/Kconfig                       |  16 ++
 kernel/sched/build_utility.c       |   4 +
 kernel/sched/psi_monitor.c         | 307 +++++++++++++++++++++++++++++
 4 files changed, 380 insertions(+)
 create mode 100644 include/trace/events/psi_monitor.h
 create mode 100644 kernel/sched/psi_monitor.c

-- 
2.34.1


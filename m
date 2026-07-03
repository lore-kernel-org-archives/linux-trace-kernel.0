Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B428233937
	for <linux-trace-kernel@vger.kernel.org>; Fri,  3 Jul 2026 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783092777; cv=pass; b=oOaIgOn+nx5XZbM9YrwUuz4cxfL7FywGwSzMY8wDqpDBsbN8oHapUbIKXVQ6mCJk8LHjI04Fq9Y4csJ4phXonT3cwoKa1SP/Xjuo2FM87ggg5tqgjfxYijnlvcbo/f9UHuS3ZJbZ5HsyBCNip3HxKhTcUKGbA9yS/MXqu8CqHac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783092777; c=relaxed/simple;
	bh=ZW36ogwmUNElfouapLYrC8CykYz1zkL5xeKuzSxaOQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FAxCAd2Wd1KKNfD7dWUBHHl+OT1oKQVcNzhcH6XED1S4yQUg4rETwO4br66wWA5h6EAqX22nxzsepXM6RSCQBdbgHxdRwL28eAK4fUq06VvAm4LA7ZPfTJPm2gGM0XXx+BTqLzADtblsRiLdgJMsPKdTO58PpczvoplKZ0woYdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mFFZcu9Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IfULlbMa; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mFFZcu9Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IfULlbMa"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663Bq2963134767
	for <linux-trace-kernel@vger.kernel.org>; Fri, 3 Jul 2026 15:32:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=P7MZA2lakniz4eBqr9s7+mI9bGKd1ewCVmXMguD1ohg=; b=mF
	FZcu9ZRymw7KggEuW2NlspYAq/gCPqvd2bu1cgEHNcf/IYFqXif6Adzg5R6qfEjG
	DBRo/A444siByg9vHl1IeK+nd/pXJv3xuL3GGEgRvf5S45lb8ZhVcAPI/EHkrKA8
	OEtlOJmpMlJ8MPC9oC4eCSX2qM7mxLIjCiQ7PVGss4YqzuvEio0+lmWOBxIguAEI
	5rLNN5swnws6RJJipe/6vzU3/haTd9tKapu+avSDkQZaAoRrCdEXNTjhmpTexSLz
	3dp0K8e5bGVCSY6jewZl48SdmIwUJPyNnA1v15ycWjFrqPAYBkutpn09C/dnldGs
	tt8hSVckYIMPymgVHhtQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f65qcjpaw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Fri, 03 Jul 2026 15:32:54 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1b4d961dso6159041cf.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 03 Jul 2026 08:32:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783092774; cv=none;
        d=google.com; s=arc-20260327;
        b=rNDTxFThG/MY5SQ9yl7a1+cPeDGLiD/99Kb6nOyvZYvlo+jTB6TrtmEY/oPSmUGxb9
         gONM0UtFDOBo0J7Zfs6rcxMZpgwP6470Td5kSe8oWJnqlKT68lAnhJyncJGaig458Eh0
         ahTMvEGKNLRBW/L50nHMNen4LsBK3Y2bnFIPndhxFgi/s9vBK/nuvszihsIxMZyobyKJ
         3+LEgNDTB4LHjBkytQ/HAOLfx4GpP1mo1c2oXyHliDVPVn6ug3tlsmcfe1CGhrEHlgag
         UmkBixFAxh3YTa8Rfx/kN4L4zwucuOkyi06GXOpj5YKEllbS97cuNCYcOJapJLw8MxK+
         6gtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=P7MZA2lakniz4eBqr9s7+mI9bGKd1ewCVmXMguD1ohg=;
        fh=/ix7wU4NstuXegEc+g4u5vrzVscVnwbKV1PpDiGBzIY=;
        b=WjrTl4Bur6kz32LGKzcb3AA5ghRoK6CXwxUGRMyrYCyi2GxgcDD+7C6dTDlJ/9IbEP
         llbTR3Kyv0KRx+Yxpez8MhQKXxLMLd2iWoPQru/9K6tNjdjv0ApZ2WHDnnG3Ortp96Ag
         TxFHA958ebo5eZbY10nQsqlpPfb6V8mrLK5k4DYnWzy7DAeA4utd36B5lONIIXQ1F+7I
         NW+uqG3HWZcWO0hL0n9+jw6tLGBnt8xQcYQuaMVCP4qb/OYCWROfcoFp9evWkdsgIs8s
         D6UUZ1RGy//t/H/Eqn09soIJ/dNMduqDojwhrJut5L1fwGoO4Q8mWMbukWBsxTtkwmsQ
         qflA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783092774; x=1783697574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P7MZA2lakniz4eBqr9s7+mI9bGKd1ewCVmXMguD1ohg=;
        b=IfULlbMas5Sd+RGogP3Xez92yu6bYmZILN0OAt9k0PJshYVrutMwtDRBMuTjh8RAvs
         5yArYtq7FgINIisWrttViBNtQt5TyN8PmAxnO/acz7xcTN355xG+yIQ/El+fYXuB8viY
         2Qv9QussF1MQOU19wZYX625dp8roCWn0ErYC+6RxzfwJpb+MISb6cqsQ7OVXEA5T8ovw
         R167WzFuZMDF1YDphxT16v+Fc+3ubJ5DQpKJldXbJuQueT9fAUqCdmjvldNjmEGLk5qL
         2haI01RTEq6NXKEAHaqMMebjoemRzpyJk2oeKPYUcZVnYbggzvnvgYiKaHqsxgzbDPIS
         RHUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783092774; x=1783697574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P7MZA2lakniz4eBqr9s7+mI9bGKd1ewCVmXMguD1ohg=;
        b=KZ2FvFwASuxpT36UIVcBwBxYgqBI8bBFTHJ2FeE4FhTQ8VtnZdCXjzWjBcG4cZIs8a
         +Yq6KRQsHOcRHaEVLkAn+8LqY2tX4biKwhpqRidTgEdB69toaoSK7Tsy7CNCV4obW37m
         zKG1RQZsqdjPlW9KDwXCGGHqvStmONAlMBXdADjTtILghsROxRZ0hdeIcxL7ZazPjgmI
         U2+fpdVFqAa2PYfJ+0Mum/MSsXW2jvXct3wnNo8awHeJFPMlXlDDvR3VO4Jr2plqllBv
         +6x43q05EFZeK/l1rcuoXqt2AV8tATuKHG0xs5vQBlAlRZmf9PhMcV54Ya5Ick5LXn72
         jYZQ==
X-Forwarded-Encrypted: i=1; AFNElJ9NZYXCXMEhGeoRewUf2AZTe8KEUroVUYlTvEKM8qP2eUDeV2EUzFBNX3miknSW4A1nveIqmC+akqFIPeOE+0h/zmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg5UICE8s5E+5tBIilRu6OWovFwWDpB/cIM7Jq1c8M5/3I+WC4
	gAkaPazqxLCNG0Wp3EfTjBEC8FOUcik//HsXEN3DuTr9m9bCy0SEjH2P99ExZahxyrJyMyYMb7/
	aKLkWQZeWlD7wIPtTNOHNBygNlMsANrEFYTBymackBPCs3emzM4Wo+yBU0ri4fLjdJSx1dK7S2Y
	LNtmJXFt1LMVTvenH8JCngvsD13idv3mwXyhnli19jYoSEvM0mWQ==
X-Gm-Gg: AfdE7cmZEdqvq6fREK4ZXII/eWIeoVPdIZBga/xW2ACKbOIb4Tqs2Iu+2UBwzAQZtln
	S//BEUlXRuOCzUBZ2qTmtweZw33Kb54qhBIJ2YJJhN26dIFP9SQ0NbvHHTPh8PS1Gyw2opDU2pP
	1JZR6F1lFDCgo7/umfgRJus279hjjVfn6muCKr6reHEYYPi+fIS2QAICc=
X-Received: by 2002:a05:622a:2285:b0:51c:885:3225 with SMTP id d75a77b69052e-51c3c07b16dmr58763831cf.12.1783092773303;
        Fri, 03 Jul 2026 08:32:53 -0700 (PDT)
X-Received: by 2002:a05:622a:2285:b0:51c:885:3225 with SMTP id
 d75a77b69052e-51c3c07b16dmr58763031cf.12.1783092772609; Fri, 03 Jul 2026
 08:32:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702171606.527077-1-pintu.agarwal@oss.qualcomm.com>
 <20260702171606.527077-2-pintu.agarwal@oss.qualcomm.com> <6c190305-4137-411f-ba25-e0a2d8484db7@amd.com>
In-Reply-To: <6c190305-4137-411f-ba25-e0a2d8484db7@amd.com>
Reply-To: pintu.k@oss.qualcomm.com
From: Pintu Kumar Agarwal <pintu.k@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 21:02:41 +0530
X-Gm-Features: AVVi8CfpXdOfl-lmV5_AVs0xVJ7mG6WkJWTfEqCOb6JolsiMfJcHXnfuIrS2U5M
Message-ID: <CANqwyPjEAvxtupQK1YyhYE-2h=0==+FumCj48F4FDKCpCvWZWw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] psi: Introduce in-kernel PSI auto monitor feature
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        hannes@cmpxchg.org, surenb@google.com, rostedt@goodmis.org,
        mhiramat@kernel.org, peterz@infradead.org,
        mathieu.desnoyers@efficios.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, pintu.ping@gmail.com, nathan@kernel.org,
        ojeda@kernel.org, nsc@kernel.org, gary@garyguo.net, tglx@kernel.org,
        thomas.weissschuh@linutronix.de, aliceryhl@google.com,
        dianders@chromium.org, linux.amoon@gmail.com, rdunlap@infradead.org,
        akpm@linux-foundation.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: dt7kTLMnu4L599mBXzSP184ui_bzi8q5
X-Authority-Analysis: v=2.4 cv=Bb7oFLt2 c=1 sm=1 tr=0 ts=6a47d626 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=4oupQTzvAAAA:8 a=NEAV23lmAAAA:8 a=zd2uoN0lAAAA:8
 a=IrsExXvWoLXAzPkKgFAA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=F_R_EHrqUKoJocvyGl7m:22
X-Proofpoint-ORIG-GUID: dt7kTLMnu4L599mBXzSP184ui_bzi8q5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE1NCBTYWx0ZWRfX2epbOZtO623V
 OuQAPGUava8nbWtVm2uLNpUCzq+eYlMbSvzdk7dVeqsTZiGZJD52hEqP4QHekDZFIOucJtXXaYe
 Fn2eAh23CymR2OOm916kf6vvZ2CbCbiLmmQmpcBvyfxhK2g9R41gh1v0uVJI/8TouXibnDhTJKa
 UG3GbFMe0cZWWOhrRrp2IDgg1wCOwO7msC3F2FlhTANrpoIkEuEOOSN7i5j1WO+IOlzqWgLr/b6
 MsHBBwSx+5pRQR/O90n6B/jPs4bMQ6RVKYkhpWN4/qnkon2LIOaIwaefbaq2eeboTnq9hqmXqmh
 43z/Zw8lxt1G6dRkaN2gtxrXzCPZWX/TYEkgL2zgxMPOS0wCgXeS8d2FQXK3zxkfdO3bZwoOGsV
 Ksbne35TArkKym8UgfhQKzATaKUky28dTgYik1COF/BjpIA/KJZsdbjag4a9m4Iz22bWRV31iFc
 MXQ1jtx0VdjlOM+FQjg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE1NCBTYWx0ZWRfX/ORX34iMXaUB
 hfTwDCGF/g5fwKZ1Id6tDuRMpLDqES6qpFQGaOMwghHkAcJE2jLxjtbgNcvGDZWvnKWIZOU02WW
 9yQm3BxUCy7rx2YS8q7nJpurtcSyDdw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030154

Hi Prateek,

Thank you so much for your review feedback and comments.
Please find my response below.

On Fri, Jul 3, 2026 at 1:21=E2=80=AFAM K Prateek Nayak <kprateek.nayak@amd.=
com> wrote:
>
> Hello Pintu,
>
> On 7/2/2026 10:46 PM, Pintu Kumar Agarwal wrote:
> > diff --git a/kernel/sched/build_utility.c b/kernel/sched/build_utility.=
c
> > index e2cf3b08d4e9..30e9800ce947 100644
> > --- a/kernel/sched/build_utility.c
> > +++ b/kernel/sched/build_utility.c
> > @@ -104,3 +104,7 @@
> >  #ifdef CONFIG_SCHED_AUTOGROUP
> >  # include "autogroup.c"
> >  #endif
> > +
> > +#ifdef CONFIG_PSI_AUTO_MONITOR
> > +# include "psi_monitor.c"
> > +#endif
>
> Isn't this a module? Why is this being included as a scheduler file?
> Based on a quick glance, nothing in this module needs scheduler internal
> APIs (and nor it should) so tools/sched/ would probabaly be a better
> place to put it in if there is interest for this feature.
>
The scheduler placement was chosen because the feature currently
operates on PSI internals
and was developed as an extension to kernel/sched/psi.c.
I am open to alternative placement if another location is more appropriate.

> > diff --git a/kernel/sched/psi_monitor.c b/kernel/sched/psi_monitor.c
> > new file mode 100644
> > index 000000000000..e929a0c05494
> > --- /dev/null
> > +++ b/kernel/sched/psi_monitor.c
> > @@ -0,0 +1,307 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PSI Automatic Monitor with Weighted Task Ranking + Tracepoints
> > + *
> > + * Periodically samples system PSI (CPU, memory, IO) and, when any
> > + * configured threshold is exceeded, ranks tasks using a composite
> > + * score based on RSS, I/O activity and CPU time, then logs the
> > + * top-N tasks via printk and a tracepoint.
> > + *
> > + * Sysfs interface:
> > + *   /sys/kernel/psi_monitor/cpu_thresh                 (percentage)
> > + *   /sys/kernel/psi_monitor/mem_thresh                 (percentage)
> > + *   /sys/kernel/psi_monitor/io_thresh          (percentage)
> > + *   /sys/kernel/psi_monitor/monitor_interval_ms (milliseconds)
> > + *   /sys/kernel/psi_monitor/rss_weight
> > + *   /sys/kernel/psi_monitor/io_weight
> > + *   /sys/kernel/psi_monitor/cpu_weight
> > + *
> > + * Author: Pintu Kumar Agarwal
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/sched.h>
> > +#include <linux/sched/signal.h>
> > +#include <linux/sched/loadavg.h>
> > +#include <linux/mm.h>
> > +#include <linux/delay.h>
> > +#include <linux/workqueue.h>
> > +#include <linux/psi_types.h>
> > +#include <linux/kobject.h>
> > +#include <linux/sort.h>
> > +#include <linux/jiffies.h>
> > +#include <linux/time64.h>
> > +#include <linux/sched/cputime.h>
> > +
> > +/* Create tracepoints defined in include/trace/events/psi_monitor.h */
> > +#define CREATE_TRACE_POINTS
> > +#include <linux/psi.h>
> > +#include <trace/events/psi_monitor.h>
> > +
> > +
> > +/* Sysfs tunables */
> > +static unsigned int cpu_thresh =3D 80;     /* in percent */
> > +static unsigned int mem_thresh =3D 80;     /* in percent */
> > +static unsigned int io_thresh  =3D 80;     /* in percent */
> > +static unsigned int monitor_interval_ms =3D 10000;
> > +
> > +/* scoring weights */
> > +static unsigned int rss_weight =3D 2;
> > +static unsigned int io_weight  =3D 1;
> > +static unsigned int cpu_weight =3D 5;
>
> Insanely configurable but what makes it easy for developers to know
> the right configurations under severe pressure as you put it?
>
This is one of the goal of RFC to decide what parameters should be
kept configurable
and to what default values. Currently it is at experimental stage and
gathering feedback.
As per my experiments (2 core, < 1GB RAM), 80% number is good enough as def=
ault.
This triggers only during extreme pressure, otherwise kept silent.
Based on the scenario and workload, users can configure it.
Run scenario =3D> check workload =3D> configure =3D> rerun
Scoring weight values are optional and it depends on which load we
want to give priority.
These are open for discussions and only needed for sorting logic.

> > +
> > +static struct delayed_work psi_work;
> > +static struct kobject *psi_kobj;
> > +
> > +#define TOP_N 20
> > +
> > +struct task_info {
> > +       struct task_struct *task;
> > +       unsigned long rss;      /* pages */
> > +       unsigned long io_kb;    /* kB */
> > +       unsigned long cpu_ms;   /* ms */
>
> Isn't the suffix selfexplanatory? Do you really need the comments?
>
oh yes, this can be removed if not needed.

> > +       u64 score;
> > +};
> > +
> > +/*
> > + * psi_avg10_percent() - derive a rough integer percentage from avg10
> > + * for a given PSI state (e.g. PSI_CPU_SOME, PSI_MEM_SOME, PSI_IO_SOME=
).
> > + *
> > + * psi_group.avg[state][0] is the avg10 window in fixed-point notation=
.
> > + * The conversion here is approximate but monotonic, which is sufficie=
nt
> > + * for thresholding and ranking in this internal monitor.
> > + */
> > +static unsigned long psi_avg10_percent(int state)
> > +{
> > +       u64 avg10;
> > +
> > +       if (state < 0 || state >=3D NR_PSI_STATES)
> > +               return 0;
> > +
> > +       avg10 =3D READ_ONCE(psi_system.avg[state][0]);
> > +       if (!avg10)
> > +               return 0;
> > +
> > +       /* Convert back from loadavg-style fixed-point to an approximat=
e % */
> > +       /* Just consider the integer value and ignore fraction */
>
> Why two single line comments?
>
ok I will merge it in the next version.

> > +       return LOAD_INT(avg10);
> > +}
> > +
> > +static int compare_score_desc(const void *a, const void *b)
> > +{
> > +       const struct task_info *ta =3D a;
> > +       const struct task_info *tb =3D b;
> > +
> > +       if (tb->score > ta->score)
> > +               return 1;
> > +       if (tb->score < ta->score)
> > +               return -1;
> > +       return 0;
> > +}
> > +
> > +static void log_top_tasks(void)
> > +{
> > +       struct task_info tasks[TOP_N];
> > +       struct task_struct *p, *t;
> > +       int count =3D 0;
> > +       int i;
> > +
> > +       rcu_read_lock();
> > +       for_each_process_thread(p, t) {
>
> Thats a ton of work every 10s.
>
This happens only when the threshold is breached and the system is
already under pressure.
Based on the feedback we can rate-limit this.

> > +               struct mm_struct *mm;
> > +               unsigned long rss =3D 0;
> > +               unsigned long io_kb =3D 0;
> > +               unsigned long cpu_ms =3D 0;
> > +               u64 score;
> > +
> > +               /* Ignore tasks that are not on run queue or idle */
> > +               if (!t->on_rq && !is_idle_task(t))
>
> Condition doesn't match the comment. Tasks off rq that aren't idle will
> still go through.
>
Oh yes, good catch. I will fix the comment in the next version.

> > +                       continue;
> > +
> > +               mm =3D get_task_mm(t);
> > +
> > +               /* mm could be NULL for kernel threads */
> > +               if (mm) {
> > +                       rss =3D mm ? get_mm_rss(mm) : 0;
> > +                       mmput_async(mm);
> > +               }
> > +
> > +               /*
> > +                * Approximate I/O activity: sum of read + write bytes.
> > +                * This uses the task_io_accounting fields in task_stru=
ct.
> > +                * Values are best-effort and need not be perfectly acc=
urate
> > +                * for our ranking purpose.
> > +                */
> > +               io_kb =3D (t->ioac.read_bytes + t->ioac.write_bytes) >>=
 10;
> > +
> > +               /*
> > +                * Approximate CPU usage via task_sched_runtime(), conv=
erted
> > +                * to milliseconds. This is cumulative since task start=
, but
> > +                * is still useful for comparing hotspots at a given po=
int.
> > +                */
> > +               cpu_ms =3D (unsigned long)(task_sched_runtime(t) / NSEC=
_PER_MSEC);
> > +
> > +               score =3D (u64)rss_weight * (u64)rss +
> > +                       (u64)io_weight  * (u64)io_kb +
> > +                       (u64)cpu_weight * (u64)cpu_ms;
> > +
> > +               if (count < TOP_N) {
> > +                       tasks[count].task   =3D t;
> > +                       tasks[count].rss    =3D rss;
> > +                       tasks[count].io_kb  =3D io_kb;
> > +                       tasks[count].cpu_ms =3D cpu_ms;
> > +                       tasks[count].score  =3D score;
> > +                       count++;
> > +               } else {
> > +                       /* Maintain a simple streaming top-N: replace s=
mallest */
> > +                       int min_idx =3D 0;
> > +                       int j;
> > +
> > +                       for (j =3D 1; j < TOP_N; j++) {
> > +                               if (tasks[j].score < tasks[min_idx].sco=
re)
> > +                                       min_idx =3D j;
> > +                       }
>
> Can't you just cache the min_idx and re-compute it when it changes
> instead of taking a O(20) iteration for every task?
>
ok will think about it and come back.
IMO the constant value may not affect the order.
Currently at RFC stage I wanted to keep things as simple.

> > +
> > +                       if (score > tasks[min_idx].score) {
> > +                               tasks[min_idx].task   =3D t;
> > +                               tasks[min_idx].rss    =3D rss;
> > +                               tasks[min_idx].io_kb  =3D io_kb;
> > +                               tasks[min_idx].cpu_ms =3D cpu_ms;
> > +                               tasks[min_idx].score  =3D score;
> > +                       }
> > +               }
> > +       }
> > +       rcu_read_unlock();
> > +
> > +       sort(tasks, count, sizeof(struct task_info), compare_score_desc=
, NULL);
> > +
> > +       pr_info("psi_monitor: logging top %d tasks under pressure:\n", =
count);
> > +
> > +       for (i =3D 0; i < count; i++) {
> > +               struct task_struct *ts =3D tasks[i].task;
> > +               unsigned long rss_kb =3D tasks[i].rss << (PAGE_SHIFT - =
10);
> > +               char name[128] =3D {0,};
> > +
> > +               if (ts->flags & PF_WQ_WORKER)
> > +                       wq_worker_comm(name, sizeof(name), ts);
> > +               else
> > +                       scnprintf(name, sizeof(name) - 1, ts->comm);
> > +
> > +               trace_psi_monitor_top_task(ts->pid, name,
> > +                               tasks[i].cpu_ms,
> > +                               rss_kb,
> > +                               tasks[i].io_kb,
> > +                               tasks[i].score);
> > +
> > +               pr_info("psi_monitor: pid=3D%d comm=3D%s psi_flag=3D%d =
oncpu=3D%d cputime(ms)=3D%lu rss(kB)=3D%lu io(kB)=3D%lu score=3D%llu\n",
> > +                       ts->pid, name, ts->psi_flags, task_cpu(ts),
> > +                       tasks[i].cpu_ms, rss_kb, tasks[i].io_kb,
> > +                       (unsigned long long)tasks[i].score);
>
> This will unnecessarily dump to dmesg even if you have tracevent
> enabled. Why?
>
This is also one point of discussion for RFC.
Currently  have kept both the options available and open for suggestion.
The idea is to dump it like OOM message and only during pressure and
threshold breach when we really need it.
Once the pressure releases this will automatically stop.
We can also make it as pr_debug or ratelimit or even put it under
another CONFIG.
The idea is to automatically get the information in logs instead of
user intervention.
But I am open for suggestions.

> > +               }
> > +}
> > +
> > +static void psi_monitor_fn(struct work_struct *work)
> > +{
> > +       unsigned long cpu_pct, mem_pct, io_pct;
> > +       bool trigger =3D false;
> > +
> > +       cpu_pct =3D psi_avg10_percent(PSI_CPU_SOME);
> > +       mem_pct =3D psi_avg10_percent(PSI_MEM_SOME);
> > +       io_pct  =3D psi_avg10_percent(PSI_IO_SOME);
> > +
> > +       if (cpu_pct >=3D cpu_thresh || mem_pct >=3D mem_thresh ||
> > +               io_pct >=3D io_thresh)
> > +               trigger =3D true;
> > +
> > +       if (trigger) {
> > +               pr_info("psi_monitor: pressure high: cpu=3D%lu%% mem=3D=
%lu%% io=3D%lu%% (thresh cpu=3D%u mem=3D%u io=3D%u)\n",
> > +                       cpu_pct, mem_pct, io_pct,
> > +                       cpu_thresh, mem_thresh, io_thresh);
> > +               log_top_tasks();
> > +       }
> > +
> > +       queue_delayed_work(system_wq, &psi_work,
> > +               msecs_to_jiffies(monitor_interval_ms));
>
> If I set monitor_interval_ms to 6 hours, and then change it back to 10s,
> it'll only take effect after this callback has fired 6 hours later.
>
Oh yes, good catch, I will fix this in the next version.
So, it should override with the new request.

> > +}
> > +
> > +/* Sysfs helpers */
> > +#define PSI_ATTR_RW(_name)                                            =
 \
> > +static ssize_t _name##_show(struct kobject *kobj,                     =
 \
> > +                       struct kobj_attribute *attr, char *buf)        =
 \
> > +{                                                                     =
 \
> > +       return sysfs_emit(buf, "%u\n", _name);                         =
 \
> > +}                                                                     =
 \
> > +static ssize_t _name##_store(struct kobject *kobj,                    =
 \
> > +                           struct kobj_attribute *attr,               =
 \
> > +                           const char *buf, size_t count)             =
 \
> > +{                                                                     =
 \
> > +       unsigned int val;                                              =
 \
> > +       if (kstrtouint(buf, 10, &val))                                 =
 \
> > +               return -EINVAL;                                        =
 \
> > +       _name =3D val;                                                 =
   \
> > +       return count;                                                  =
 \
> > +}                                                                     =
 \
> > +static struct kobj_attribute _name##_attr =3D __ATTR_RW(_name)
> > +
> > +PSI_ATTR_RW(cpu_thresh);
> > +PSI_ATTR_RW(mem_thresh);
> > +PSI_ATTR_RW(io_thresh);
> > +PSI_ATTR_RW(monitor_interval_ms);
> > +PSI_ATTR_RW(rss_weight);
> > +PSI_ATTR_RW(io_weight);
> > +PSI_ATTR_RW(cpu_weight);
> > +
> > +static struct attribute *psi_attrs[] =3D {
> > +       &cpu_thresh_attr.attr,
> > +       &mem_thresh_attr.attr,
> > +       &io_thresh_attr.attr,
> > +       &monitor_interval_ms_attr.attr,
> > +       &rss_weight_attr.attr,
> > +       &io_weight_attr.attr,
> > +       &cpu_weight_attr.attr,
> > +       NULL,
> > +};
> > +
> > +static const struct attribute_group psi_attr_group =3D {
> > +       .attrs =3D psi_attrs,
> > +};
> > +
> > +static int __init psi_monitor_init(void)
> > +{
> > +       int ret;
> > +
> > +       INIT_DELAYED_WORK(&psi_work, psi_monitor_fn);
> > +       queue_delayed_work(system_wq, &psi_work,
> > +                       msecs_to_jiffies(monitor_interval_ms));
> > +
> > +       psi_kobj =3D kobject_create_and_add("psi_monitor", kernel_kobj)=
;
> > +       if (!psi_kobj)
> > +               return -ENOMEM;
> > +
> > +       ret =3D sysfs_create_group(psi_kobj, &psi_attr_group);
> > +       if (ret) {
> > +               kobject_put(psi_kobj);
> > +               cancel_delayed_work_sync(&psi_work);
> > +               return ret;
> > +       }
> > +
> > +       pr_info("psi_monitor: in-kernel PSI auto monitor (weighted + tr=
acepoints) loaded\n");
> > +       return 0;
> > +}
> > +
> > +static void __exit psi_monitor_exit(void)
> > +{
> > +       cancel_delayed_work_sync(&psi_work);
> > +       if (psi_kobj)
> > +               kobject_put(psi_kobj);
> > +       pr_info("psi_monitor: unloaded\n");
> > +}
> > +
> > +module_init(psi_monitor_init);
> > +module_exit(psi_monitor_exit);
>
> There is nothing here that warrants putting this in kernel/sched.
The feature depends on sched/psi so I decided to keep it close.
But I am open for any location.

> Also this gets included by default when config is enabled and starts
> dumping a bunch of stats to dmesg without anyone asking. No?
>
This is included as a dependent feature of PSI.
If someone enables this CONFIG as part of PSI this indicates that they
are interested in getting auto-monitor stats.
Also, the dump will happen only if threshold is breached with high
default values.
However, for RFC stage I wanted to keep things simple.
Later, we can add an enable/disable flag in cmdline just like PSI.

> Afaict, almost all of the detail used here is also available from
> procfs and people can easily put together a userspace tool if they
> need it. Why do we need an in-kernel module?
>
This is the most fundamental aspect of this auto-monitor feature.
This point is already described in the cover letter.
Let me put it again:
- Get kernel stats early during boot_time before userspace comes up.
   -> Set slightly lower threshold and boot stats (helps in analysing boot =
time)
- No user intervention or continuous polling or daemons needed
  (Just enable config and start auto monitoring)
- userspace scheduling delays under high pressure
- risk of missing short-lived spikes
- capturing details as soon as pressure hits and at same timestamp
- useful for analysing real-time latency workload.
- useful for minimal environment like initramfs or busybox

The motivation is not to replace existing PSI interfaces or the ability
to build userspace monitoring tools.
The goal is attribution at the moment pressure thresholds are crossed.
A userspace implementation observes the system after being scheduled,
whereas the in-kernel implementation captures contributors at the point
where pressure is detected.
During LPC-2024 I have done significant changes to core psi module
to implement the similar logic.
But the feedback was not to disturb the core psi interface, instead
develop a separate interface and make it configurable.
So, I came up with this auto-monitor idea.

For more details please have a look at my OSS paper with data.
https://hosted-files.sched.co/ossindia2026/19/OSS-IND-26-PSI-Auto-Monitor.p=
df
And also the reference data here:
https://github.com/pintuk/KERNEL/tree/master/PSI_WORK

I am also looking out for someone who can test this on a larger
workload and capture data.
This will help us to gather insights, how the feature behaves.

> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Pintu Kumar Agarwal");
> > +MODULE_DESCRIPTION("In-kernel PSI automatic monitor with sysfs, weight=
ed scoring and tracepoints");
> > --
> > 2.34.1
> >
>
> --
> Thanks and Regards,
> Prateek
>

Thanks,
Pintu

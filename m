Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C425B43B3EC
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 16:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783699290; cv=pass; b=XWEhUOysYVTlLwOsXaKLKfcumd6HYnD+Tl7irqgSIsc52dic5vz2Em1POaUiZcQNDPIZhoAx3wWvvp4N1qJqLmi64L9z/xKzlmB57JWEFoqyuNv6CVwSay8TdsqCS//L0vvRKVPLOXCM9LeKLRftrJ5ql3toACgALVVcDoLMFNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783699290; c=relaxed/simple;
	bh=wtIU3QvOYYaApE0l2KnpG3a70qqmOaQQp0wZMIMaIBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjREON09ZckrcmgHkDQgOcWWqyCKCbEDPLXUmSsMEmu/+KPmsInSmpIcmw4twixmkZmp42dS1aWW8f/Dql8KxJOQblDKYBlxovgUtdqOKiQi+nV4vPA333yn2VLi8JDksvcM/XOMAt/5uX2L7OcPLrX2U5psp3QCi4/b6tBikxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oKMaJNuV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZjIQblTn; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oKMaJNuV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZjIQblTn"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AEcTTo1078391
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 16:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=FJz4Rx0nkK30x5U1N4P9CNFQEcuH7GfKhp9XA9qAHqQ=; b=oK
	MaJNuVoUgY2bkwND9o5JMjmAg466SoUTkkloz+5tjDeeiHyA6bXy87qyDw3xLZzJ
	DLhRdYloPjWW/A3t6V8guO8VVncTr+BguNIVNfOGfYSZyO19ce0Y/iiGDgqNcgDg
	ngqLfhc3hkzzicPfBYhT+9984/I9bOi3jPqo09Rkhst9DS+2S1zjNwS/zHUHefLS
	GfT4iupfUpnyUEEPL44M6/xAKKyA/NSV6EyDHiPgh19TyprYnGoXv6LNzqx36G5V
	R6PPOF61qtjLIL8Z5yyUqefFNZSVZDSB90duMZptvwBULzLHGCMhZ3OPE54jFpxB
	/3kCICPGZi+eZdcaoLTw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5f9euf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 16:01:23 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8f18c4d1f82so19638536d6.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 09:01:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783699283; cv=none;
        d=google.com; s=arc-20260327;
        b=iF0BQrM1uxJTjY+1mhAiAUoC0cGiT361ud6qaKx4dDTGuPGTRMfNb79S8cjQOJZ5Wx
         9Q0rqWk33fkUIUNyuLKu//fVQVYpVDxBxgL9AJY3BPW0vS630UZEFiefEz2HPb6D83Qt
         lKmERgNQ+Hf7JyZlU5ETu4TFZu2u6exCLZBuDzggVL5LmJWPJJqdko3kZ9cx/SWEaq+J
         db+v9hwwTFqAnQr7+tvDeFcNgKtNRWm02TB8KHwyI6l6s6OMr6zjUgktB8jp306jd4cS
         QWkV/E+8k+ZMKFGjO/ZJ7rxyin3xgfV9Y0TFdGSYYDiox8V7DCspubk76qquboKtM+bQ
         s58g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=FJz4Rx0nkK30x5U1N4P9CNFQEcuH7GfKhp9XA9qAHqQ=;
        fh=za+sikqA0h60ubpjlgmzZ1NIH9Y5cN8nQhTMynUc33U=;
        b=Bux+6n/KAmDgiEnWVdQtZljDxDaSPtxwH/3e85JUZj/spH6rt+/6Ikr3xCKSTsmz95
         /Ej7WedgKB0eNZGx4FFuUno6V3Ovg57iNODrqFaXmjIG4BItwL3asgYEN6JSAMgUEInd
         J+FKRFesPLRct+dgOUuDalK+xPQRbFR4NWtHkw7WD1asU7YppW6b2TQ4zWPVlDCCfHNu
         aZyQmdHBxVOYhK25vEIDaqaa9BEqeWF2T8GnQ0pBkybZlrbKEy1Q1KIVe1LQWZbk2MwI
         8ACA9sa9cJXA0BekZ66qiDeDZN4TQMKO/D/MnSsQl4eDmL+yc3CtK8C8HnJFYYgR4B7W
         PyKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783699283; x=1784304083; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FJz4Rx0nkK30x5U1N4P9CNFQEcuH7GfKhp9XA9qAHqQ=;
        b=ZjIQblTnzgPQATuVMn74JAVmiWB9Ms8mNTJi9uUWxKN57wsroWCiOr8hubS3zKBLYX
         292enWbNMv2aTwGPjckALBPlXviwR6SkoFy0NkZ7k0UL0Gqku/4eeELIp/2er1sSqHgF
         oGUODMcP+UWGt/KyaNTDUqoyvbEaszPIVGKCKk42my4EgTNsKsbuPcJ11iWlT+A4yXpT
         Wi/03hsZA99hAxWxgYADb2ONubvWhPkwjl49gaA6IrQNNuP3HGd9gLEgqrJr/yUGV1ti
         1yzU/WqiuH9jtK3Dfl2ETCGJzJGB2zdofz7dwvObwXJUNtcB6lEJVQFxak+VrvOGHabB
         VrEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783699283; x=1784304083;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FJz4Rx0nkK30x5U1N4P9CNFQEcuH7GfKhp9XA9qAHqQ=;
        b=q5EfxEb6vkAtCWjQSIHiwJaDqILMtEtX5LM5D/xsmhGYXzUwpr3ppRQvkwlH1ZhjV+
         CxLx3f9MFj6RAedOpUtV4kiagGyr6HwcxYMO+hW3WvyOZYzqE/6lvlGFDXF49HbTJJgg
         YZB0bFqSbrbNDQ0ktDrNbN+a4YXxb2mGnBsENkgaB/COxgP/En8etaiXbdSUiK2Txxku
         ZgW+VEyJBaok3rzHKoA9AAb3G+4e7nb6emBIiMe11P1wroYowjWWdBPael7mhY6evVSa
         zNEwjUqFzsh6HWbVMVL1VVon/59lrb6KIkyANR6K2/7UScusClPtVBXjHK+/XGJyZx8h
         8jCQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq7zKLUmcdlMFIj5ptA9gNF8wdzKty79/749chdBVL7f8aTbDiTLJOp/uWDI810SSp8ZPOlFnBwJvqVgJUU0aRVVVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQrfSHC0f6llEm60zdQ9vVZOA16IzfUUUai7LVcZHPTfvHmcs2
	IMGLXNVvfOGt0SSHtga/ZCWdWrDtVsov+5v0G3ROdNHrLEpySllUpfEH+KMutaopYl66qgLHUJ+
	9XGAHg9zdhEpCJGJGLu6fCB4FqWfuf/pZ5KCCs44WfVBkcDKxFBcp+1aqh75abe21z4kXe+hkpj
	hasEqVEoUcSnFuQeBaePPXx4XEI3JFP2y2E62nXPtyzVgWJfHd+Q==
X-Gm-Gg: AfdE7ckqKRhLt/LlWj1+tFu3YQ22LVwOSlsOv8vs2xKAOWJEWKfa2AIwp+VWIRuMUfo
	651sRi3isIs84Bi/KBz8ZFJ3S7d+Z1XBi8QZFd5nUNzWwQH0oQX2Pst0gSBdDJEjN5q93lDuYZi
	pzZzaWbc6pgDk5E79cvEoLaGnmueCRBdyOYePCym36q+hA+jL0dlgkufwfhBodzywO2eP7
X-Received: by 2002:a05:6214:495:b0:8ea:47d7:5e3d with SMTP id 6a1803df08f44-8fec361f6e7mr137190746d6.45.1783699282161;
        Fri, 10 Jul 2026 09:01:22 -0700 (PDT)
X-Received: by 2002:a05:6214:495:b0:8ea:47d7:5e3d with SMTP id
 6a1803df08f44-8fec361f6e7mr137189546d6.45.1783699281165; Fri, 10 Jul 2026
 09:01:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702171606.527077-1-pintu.agarwal@oss.qualcomm.com>
 <20260702171606.527077-2-pintu.agarwal@oss.qualcomm.com> <6c190305-4137-411f-ba25-e0a2d8484db7@amd.com>
 <CANqwyPjEAvxtupQK1YyhYE-2h=0==+FumCj48F4FDKCpCvWZWw@mail.gmail.com>
In-Reply-To: <CANqwyPjEAvxtupQK1YyhYE-2h=0==+FumCj48F4FDKCpCvWZWw@mail.gmail.com>
Reply-To: pintu.k@oss.qualcomm.com
From: Pintu Kumar Agarwal <pintu.k@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 21:31:08 +0530
X-Gm-Features: AUfX_myVOwbQF09JhgTn5XYZdnbmHyTnV06eeJS604jkRflOkxyVOPJTijKueko
Message-ID: <CANqwyPiE1vtoGH6Zu==VxBkkwGq_E7-Zswi57msy_G97Rz2xSw@mail.gmail.com>
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
X-Authority-Analysis: v=2.4 cv=Ab2B2XXG c=1 sm=1 tr=0 ts=6a511753 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=4oupQTzvAAAA:8 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=zd2uoN0lAAAA:8 a=DdCEAUvdny_MBrxx908A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=F_R_EHrqUKoJocvyGl7m:22
X-Proofpoint-ORIG-GUID: FPsdWuL6q4tLFNjj6a_2lOmwq3O7g3ki
X-Proofpoint-GUID: FPsdWuL6q4tLFNjj6a_2lOmwq3O7g3ki
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE1OSBTYWx0ZWRfX6bZq2BQuDHoM
 Yv6xKmHfl7KKb80j54PWS7BfgY+s4G01fe2VKC9gWIt3VH7YD6n7EB2qcfs33r+j8/9H7zmH2j9
 tvE8AKylWkdQErT/9hHRjZLMGJHyCE8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE1OSBTYWx0ZWRfX9MBvKKdgkTyF
 HaxkcqPYmxhN83A2Hbv50QuMZSXSGXP457Wqbuw5myTSHYr5e9yXFI94MBUg9l6ilwfnWJeuHY2
 L/+EepxbcdriYMn3Wzq2V5hKP8fx+EG9bRj8Lvfhajb9IvNIYCWjyXdm/ugt+1TynVFY4eFF/ZB
 FSa8JsruT8P8goFVVSfPJi0Wf8VhhgCya6kOofdPmLB+9qlm9Cga4bcHdah36/ckS55LX30MACb
 2QfoxXRjXsaGBU/HdbvbySnq1OrPjN69Cjy/2hWTE2+iZsgA0gKqHA7m94AgimGiapnnd9/Zp57
 4EUChGQszU3MJdn4yAGphItWg0htx/Z8sXymQDL7l1dexcCR0wkcRQY9ZAbImRU5MzV3uQoU27Z
 7sHZtQFCSnb0w9eC4ParrLWBuREQCUkL34uNWjL6VnDprdyhaYdZoO3FHiGPupmuuSawZWOJ5CM
 bDxGY3RB5dDVAHsoitQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100159

Hi All,

On Fri, Jul 3, 2026 at 9:02=E2=80=AFPM Pintu Kumar Agarwal
<pintu.k@oss.qualcomm.com> wrote:
>
> Hi Prateek,
>
> Thank you so much for your review feedback and comments.
> Please find my response below.
>
> On Fri, Jul 3, 2026 at 1:21=E2=80=AFAM K Prateek Nayak <kprateek.nayak@am=
d.com> wrote:
> >
> > Hello Pintu,
> >
> > On 7/2/2026 10:46 PM, Pintu Kumar Agarwal wrote:
> > > diff --git a/kernel/sched/build_utility.c b/kernel/sched/build_utilit=
y.c
> > > index e2cf3b08d4e9..30e9800ce947 100644
> > > --- a/kernel/sched/build_utility.c
> > > +++ b/kernel/sched/build_utility.c
> > > @@ -104,3 +104,7 @@
> > >  #ifdef CONFIG_SCHED_AUTOGROUP
> > >  # include "autogroup.c"
> > >  #endif
> > > +
> > > +#ifdef CONFIG_PSI_AUTO_MONITOR
> > > +# include "psi_monitor.c"
> > > +#endif
> >
> > Isn't this a module? Why is this being included as a scheduler file?
> > Based on a quick glance, nothing in this module needs scheduler interna=
l
> > APIs (and nor it should) so tools/sched/ would probabaly be a better
> > place to put it in if there is interest for this feature.
> >
> The scheduler placement was chosen because the feature currently
> operates on PSI internals
> and was developed as an extension to kernel/sched/psi.c.
> I am open to alternative placement if another location is more appropriat=
e.
>
> > > diff --git a/kernel/sched/psi_monitor.c b/kernel/sched/psi_monitor.c
> > > new file mode 100644
> > > index 000000000000..e929a0c05494
> > > --- /dev/null
> > > +++ b/kernel/sched/psi_monitor.c
> > > @@ -0,0 +1,307 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * PSI Automatic Monitor with Weighted Task Ranking + Tracepoints
> > > + *
> > > + * Periodically samples system PSI (CPU, memory, IO) and, when any
> > > + * configured threshold is exceeded, ranks tasks using a composite
> > > + * score based on RSS, I/O activity and CPU time, then logs the
> > > + * top-N tasks via printk and a tracepoint.
> > > + *
> > > + * Sysfs interface:
> > > + *   /sys/kernel/psi_monitor/cpu_thresh                 (percentage)
> > > + *   /sys/kernel/psi_monitor/mem_thresh                 (percentage)
> > > + *   /sys/kernel/psi_monitor/io_thresh          (percentage)
> > > + *   /sys/kernel/psi_monitor/monitor_interval_ms (milliseconds)
> > > + *   /sys/kernel/psi_monitor/rss_weight
> > > + *   /sys/kernel/psi_monitor/io_weight
> > > + *   /sys/kernel/psi_monitor/cpu_weight
> > > + *
> > > + * Author: Pintu Kumar Agarwal
> > > + */
> > > +
> > > +#include <linux/init.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/sched.h>
> > > +#include <linux/sched/signal.h>
> > > +#include <linux/sched/loadavg.h>
> > > +#include <linux/mm.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/workqueue.h>
> > > +#include <linux/psi_types.h>
> > > +#include <linux/kobject.h>
> > > +#include <linux/sort.h>
> > > +#include <linux/jiffies.h>
> > > +#include <linux/time64.h>
> > > +#include <linux/sched/cputime.h>
> > > +
> > > +/* Create tracepoints defined in include/trace/events/psi_monitor.h =
*/
> > > +#define CREATE_TRACE_POINTS
> > > +#include <linux/psi.h>
> > > +#include <trace/events/psi_monitor.h>
> > > +
> > > +
> > > +/* Sysfs tunables */
> > > +static unsigned int cpu_thresh =3D 80;     /* in percent */
> > > +static unsigned int mem_thresh =3D 80;     /* in percent */
> > > +static unsigned int io_thresh  =3D 80;     /* in percent */
> > > +static unsigned int monitor_interval_ms =3D 10000;
> > > +
> > > +/* scoring weights */
> > > +static unsigned int rss_weight =3D 2;
> > > +static unsigned int io_weight  =3D 1;
> > > +static unsigned int cpu_weight =3D 5;
> >
> > Insanely configurable but what makes it easy for developers to know
> > the right configurations under severe pressure as you put it?
> >
> This is one of the goal of RFC to decide what parameters should be
> kept configurable
> and to what default values. Currently it is at experimental stage and
> gathering feedback.
> As per my experiments (2 core, < 1GB RAM), 80% number is good enough as d=
efault.
> This triggers only during extreme pressure, otherwise kept silent.
> Based on the scenario and workload, users can configure it.
> Run scenario =3D> check workload =3D> configure =3D> rerun
> Scoring weight values are optional and it depends on which load we
> want to give priority.
> These are open for discussions and only needed for sorting logic.
>
> > > +
> > > +static struct delayed_work psi_work;
> > > +static struct kobject *psi_kobj;
> > > +
> > > +#define TOP_N 20
> > > +
> > > +struct task_info {
> > > +       struct task_struct *task;
> > > +       unsigned long rss;      /* pages */
> > > +       unsigned long io_kb;    /* kB */
> > > +       unsigned long cpu_ms;   /* ms */
> >
> > Isn't the suffix selfexplanatory? Do you really need the comments?
> >
> oh yes, this can be removed if not needed.
>
> > > +       u64 score;
> > > +};
> > > +
> > > +/*
> > > + * psi_avg10_percent() - derive a rough integer percentage from avg1=
0
> > > + * for a given PSI state (e.g. PSI_CPU_SOME, PSI_MEM_SOME, PSI_IO_SO=
ME).
> > > + *
> > > + * psi_group.avg[state][0] is the avg10 window in fixed-point notati=
on.
> > > + * The conversion here is approximate but monotonic, which is suffic=
ient
> > > + * for thresholding and ranking in this internal monitor.
> > > + */
> > > +static unsigned long psi_avg10_percent(int state)
> > > +{
> > > +       u64 avg10;
> > > +
> > > +       if (state < 0 || state >=3D NR_PSI_STATES)
> > > +               return 0;
> > > +
> > > +       avg10 =3D READ_ONCE(psi_system.avg[state][0]);
> > > +       if (!avg10)
> > > +               return 0;
> > > +
> > > +       /* Convert back from loadavg-style fixed-point to an approxim=
ate % */
> > > +       /* Just consider the integer value and ignore fraction */
> >
> > Why two single line comments?
> >
> ok I will merge it in the next version.
>
> > > +       return LOAD_INT(avg10);
> > > +}
> > > +
> > > +static int compare_score_desc(const void *a, const void *b)
> > > +{
> > > +       const struct task_info *ta =3D a;
> > > +       const struct task_info *tb =3D b;
> > > +
> > > +       if (tb->score > ta->score)
> > > +               return 1;
> > > +       if (tb->score < ta->score)
> > > +               return -1;
> > > +       return 0;
> > > +}
> > > +
> > > +static void log_top_tasks(void)
> > > +{
> > > +       struct task_info tasks[TOP_N];
> > > +       struct task_struct *p, *t;
> > > +       int count =3D 0;
> > > +       int i;
> > > +
> > > +       rcu_read_lock();
> > > +       for_each_process_thread(p, t) {
> >
> > Thats a ton of work every 10s.
> >
> This happens only when the threshold is breached and the system is
> already under pressure.
> Based on the feedback we can rate-limit this.
>
> > > +               struct mm_struct *mm;
> > > +               unsigned long rss =3D 0;
> > > +               unsigned long io_kb =3D 0;
> > > +               unsigned long cpu_ms =3D 0;
> > > +               u64 score;
> > > +
> > > +               /* Ignore tasks that are not on run queue or idle */
> > > +               if (!t->on_rq && !is_idle_task(t))
> >
> > Condition doesn't match the comment. Tasks off rq that aren't idle will
> > still go through.
> >
> Oh yes, good catch. I will fix the comment in the next version.
>
> > > +                       continue;
> > > +
> > > +               mm =3D get_task_mm(t);
> > > +
> > > +               /* mm could be NULL for kernel threads */
> > > +               if (mm) {
> > > +                       rss =3D mm ? get_mm_rss(mm) : 0;
> > > +                       mmput_async(mm);
> > > +               }
> > > +
> > > +               /*
> > > +                * Approximate I/O activity: sum of read + write byte=
s.
> > > +                * This uses the task_io_accounting fields in task_st=
ruct.
> > > +                * Values are best-effort and need not be perfectly a=
ccurate
> > > +                * for our ranking purpose.
> > > +                */
> > > +               io_kb =3D (t->ioac.read_bytes + t->ioac.write_bytes) =
>> 10;
> > > +
> > > +               /*
> > > +                * Approximate CPU usage via task_sched_runtime(), co=
nverted
> > > +                * to milliseconds. This is cumulative since task sta=
rt, but
> > > +                * is still useful for comparing hotspots at a given =
point.
> > > +                */
> > > +               cpu_ms =3D (unsigned long)(task_sched_runtime(t) / NS=
EC_PER_MSEC);
> > > +
> > > +               score =3D (u64)rss_weight * (u64)rss +
> > > +                       (u64)io_weight  * (u64)io_kb +
> > > +                       (u64)cpu_weight * (u64)cpu_ms;
> > > +
> > > +               if (count < TOP_N) {
> > > +                       tasks[count].task   =3D t;
> > > +                       tasks[count].rss    =3D rss;
> > > +                       tasks[count].io_kb  =3D io_kb;
> > > +                       tasks[count].cpu_ms =3D cpu_ms;
> > > +                       tasks[count].score  =3D score;
> > > +                       count++;
> > > +               } else {
> > > +                       /* Maintain a simple streaming top-N: replace=
 smallest */
> > > +                       int min_idx =3D 0;
> > > +                       int j;
> > > +
> > > +                       for (j =3D 1; j < TOP_N; j++) {
> > > +                               if (tasks[j].score < tasks[min_idx].s=
core)
> > > +                                       min_idx =3D j;
> > > +                       }
> >
> > Can't you just cache the min_idx and re-compute it when it changes
> > instead of taking a O(20) iteration for every task?
> >
> ok will think about it and come back.
> IMO the constant value may not affect the order.
> Currently at RFC stage I wanted to keep things as simple.
>
> > > +
> > > +                       if (score > tasks[min_idx].score) {
> > > +                               tasks[min_idx].task   =3D t;
> > > +                               tasks[min_idx].rss    =3D rss;
> > > +                               tasks[min_idx].io_kb  =3D io_kb;
> > > +                               tasks[min_idx].cpu_ms =3D cpu_ms;
> > > +                               tasks[min_idx].score  =3D score;
> > > +                       }
> > > +               }
> > > +       }
> > > +       rcu_read_unlock();
> > > +
> > > +       sort(tasks, count, sizeof(struct task_info), compare_score_de=
sc, NULL);
> > > +
> > > +       pr_info("psi_monitor: logging top %d tasks under pressure:\n"=
, count);
> > > +
> > > +       for (i =3D 0; i < count; i++) {
> > > +               struct task_struct *ts =3D tasks[i].task;
> > > +               unsigned long rss_kb =3D tasks[i].rss << (PAGE_SHIFT =
- 10);
> > > +               char name[128] =3D {0,};
> > > +
> > > +               if (ts->flags & PF_WQ_WORKER)
> > > +                       wq_worker_comm(name, sizeof(name), ts);
> > > +               else
> > > +                       scnprintf(name, sizeof(name) - 1, ts->comm);
> > > +
> > > +               trace_psi_monitor_top_task(ts->pid, name,
> > > +                               tasks[i].cpu_ms,
> > > +                               rss_kb,
> > > +                               tasks[i].io_kb,
> > > +                               tasks[i].score);
> > > +
> > > +               pr_info("psi_monitor: pid=3D%d comm=3D%s psi_flag=3D%=
d oncpu=3D%d cputime(ms)=3D%lu rss(kB)=3D%lu io(kB)=3D%lu score=3D%llu\n",
> > > +                       ts->pid, name, ts->psi_flags, task_cpu(ts),
> > > +                       tasks[i].cpu_ms, rss_kb, tasks[i].io_kb,
> > > +                       (unsigned long long)tasks[i].score);
> >
> > This will unnecessarily dump to dmesg even if you have tracevent
> > enabled. Why?
> >
> This is also one point of discussion for RFC.
> Currently  have kept both the options available and open for suggestion.
> The idea is to dump it like OOM message and only during pressure and
> threshold breach when we really need it.
> Once the pressure releases this will automatically stop.
> We can also make it as pr_debug or ratelimit or even put it under
> another CONFIG.
> The idea is to automatically get the information in logs instead of
> user intervention.
> But I am open for suggestions.
>
> > > +               }
> > > +}
> > > +
> > > +static void psi_monitor_fn(struct work_struct *work)
> > > +{
> > > +       unsigned long cpu_pct, mem_pct, io_pct;
> > > +       bool trigger =3D false;
> > > +
> > > +       cpu_pct =3D psi_avg10_percent(PSI_CPU_SOME);
> > > +       mem_pct =3D psi_avg10_percent(PSI_MEM_SOME);
> > > +       io_pct  =3D psi_avg10_percent(PSI_IO_SOME);
> > > +
> > > +       if (cpu_pct >=3D cpu_thresh || mem_pct >=3D mem_thresh ||
> > > +               io_pct >=3D io_thresh)
> > > +               trigger =3D true;
> > > +
> > > +       if (trigger) {
> > > +               pr_info("psi_monitor: pressure high: cpu=3D%lu%% mem=
=3D%lu%% io=3D%lu%% (thresh cpu=3D%u mem=3D%u io=3D%u)\n",
> > > +                       cpu_pct, mem_pct, io_pct,
> > > +                       cpu_thresh, mem_thresh, io_thresh);
> > > +               log_top_tasks();
> > > +       }
> > > +
> > > +       queue_delayed_work(system_wq, &psi_work,
> > > +               msecs_to_jiffies(monitor_interval_ms));
> >
> > If I set monitor_interval_ms to 6 hours, and then change it back to 10s=
,
> > it'll only take effect after this callback has fired 6 hours later.
> >
> Oh yes, good catch, I will fix this in the next version.
> So, it should override with the new request.
>
> > > +}
> > > +
> > > +/* Sysfs helpers */
> > > +#define PSI_ATTR_RW(_name)                                          =
   \
> > > +static ssize_t _name##_show(struct kobject *kobj,                   =
   \
> > > +                       struct kobj_attribute *attr, char *buf)      =
   \
> > > +{                                                                   =
   \
> > > +       return sysfs_emit(buf, "%u\n", _name);                       =
   \
> > > +}                                                                   =
   \
> > > +static ssize_t _name##_store(struct kobject *kobj,                  =
   \
> > > +                           struct kobj_attribute *attr,             =
   \
> > > +                           const char *buf, size_t count)           =
   \
> > > +{                                                                   =
   \
> > > +       unsigned int val;                                            =
   \
> > > +       if (kstrtouint(buf, 10, &val))                               =
   \
> > > +               return -EINVAL;                                      =
   \
> > > +       _name =3D val;                                               =
     \
> > > +       return count;                                                =
   \
> > > +}                                                                   =
   \
> > > +static struct kobj_attribute _name##_attr =3D __ATTR_RW(_name)
> > > +
> > > +PSI_ATTR_RW(cpu_thresh);
> > > +PSI_ATTR_RW(mem_thresh);
> > > +PSI_ATTR_RW(io_thresh);
> > > +PSI_ATTR_RW(monitor_interval_ms);
> > > +PSI_ATTR_RW(rss_weight);
> > > +PSI_ATTR_RW(io_weight);
> > > +PSI_ATTR_RW(cpu_weight);
> > > +
> > > +static struct attribute *psi_attrs[] =3D {
> > > +       &cpu_thresh_attr.attr,
> > > +       &mem_thresh_attr.attr,
> > > +       &io_thresh_attr.attr,
> > > +       &monitor_interval_ms_attr.attr,
> > > +       &rss_weight_attr.attr,
> > > +       &io_weight_attr.attr,
> > > +       &cpu_weight_attr.attr,
> > > +       NULL,
> > > +};
> > > +
> > > +static const struct attribute_group psi_attr_group =3D {
> > > +       .attrs =3D psi_attrs,
> > > +};
> > > +
> > > +static int __init psi_monitor_init(void)
> > > +{
> > > +       int ret;
> > > +
> > > +       INIT_DELAYED_WORK(&psi_work, psi_monitor_fn);
> > > +       queue_delayed_work(system_wq, &psi_work,
> > > +                       msecs_to_jiffies(monitor_interval_ms));
> > > +
> > > +       psi_kobj =3D kobject_create_and_add("psi_monitor", kernel_kob=
j);
> > > +       if (!psi_kobj)
> > > +               return -ENOMEM;
> > > +
> > > +       ret =3D sysfs_create_group(psi_kobj, &psi_attr_group);
> > > +       if (ret) {
> > > +               kobject_put(psi_kobj);
> > > +               cancel_delayed_work_sync(&psi_work);
> > > +               return ret;
> > > +       }
> > > +
> > > +       pr_info("psi_monitor: in-kernel PSI auto monitor (weighted + =
tracepoints) loaded\n");
> > > +       return 0;
> > > +}
> > > +
> > > +static void __exit psi_monitor_exit(void)
> > > +{
> > > +       cancel_delayed_work_sync(&psi_work);
> > > +       if (psi_kobj)
> > > +               kobject_put(psi_kobj);
> > > +       pr_info("psi_monitor: unloaded\n");
> > > +}
> > > +
> > > +module_init(psi_monitor_init);
> > > +module_exit(psi_monitor_exit);
> >
> > There is nothing here that warrants putting this in kernel/sched.
> The feature depends on sched/psi so I decided to keep it close.
> But I am open for any location.
>
> > Also this gets included by default when config is enabled and starts
> > dumping a bunch of stats to dmesg without anyone asking. No?
> >
> This is included as a dependent feature of PSI.
> If someone enables this CONFIG as part of PSI this indicates that they
> are interested in getting auto-monitor stats.
> Also, the dump will happen only if threshold is breached with high
> default values.
> However, for RFC stage I wanted to keep things simple.
> Later, we can add an enable/disable flag in cmdline just like PSI.
>
> > Afaict, almost all of the detail used here is also available from
> > procfs and people can easily put together a userspace tool if they
> > need it. Why do we need an in-kernel module?
> >
> This is the most fundamental aspect of this auto-monitor feature.
> This point is already described in the cover letter.
> Let me put it again:
> - Get kernel stats early during boot_time before userspace comes up.
>    -> Set slightly lower threshold and boot stats (helps in analysing boo=
t time)
> - No user intervention or continuous polling or daemons needed
>   (Just enable config and start auto monitoring)
> - userspace scheduling delays under high pressure
> - risk of missing short-lived spikes
> - capturing details as soon as pressure hits and at same timestamp
> - useful for analysing real-time latency workload.
> - useful for minimal environment like initramfs or busybox
>
> The motivation is not to replace existing PSI interfaces or the ability
> to build userspace monitoring tools.
> The goal is attribution at the moment pressure thresholds are crossed.
> A userspace implementation observes the system after being scheduled,
> whereas the in-kernel implementation captures contributors at the point
> where pressure is detected.
> During LPC-2024 I have done significant changes to core psi module
> to implement the similar logic.
> But the feedback was not to disturb the core psi interface, instead
> develop a separate interface and make it configurable.
> So, I came up with this auto-monitor idea.
>
> For more details please have a look at my OSS paper with data.
> https://hosted-files.sched.co/ossindia2026/19/OSS-IND-26-PSI-Auto-Monitor=
.pdf
> And also the reference data here:
> https://github.com/pintuk/KERNEL/tree/master/PSI_WORK
>
> I am also looking out for someone who can test this on a larger
> workload and capture data.
> This will help us to gather insights, how the feature behaves.
>
> > > +
> > > +MODULE_LICENSE("GPL");
> > > +MODULE_AUTHOR("Pintu Kumar Agarwal");
> > > +MODULE_DESCRIPTION("In-kernel PSI automatic monitor with sysfs, weig=
hted scoring and tracepoints");
> > > --

Any other feedback before I post v2 ?

Another thing that I wanted feedback is, whether to keep under
kernel/sched/ or move under tools/sched/ ?

Thanks,
Pintu

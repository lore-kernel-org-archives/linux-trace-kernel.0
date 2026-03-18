Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7593533B6E3
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Mar 2026 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773839424; cv=none; b=OVoiiBE8ZPxoH9x3EIRor6DEl6AUN8/s+I4UkiLa217mf/ombuR2Dg7D20yGFuVRCXcbDUS/0/mdB/RvOoTHIelMwEEjA5+swDE3Lro7s8xU2PlhQP/f2fyBLgJJFybIqri9YYcnqDHIfVINVIOaLidBoq/g/XCpIpryufjLBuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773839424; c=relaxed/simple;
	bh=Q4l/xww/reh/vFG6vfrgSIgll6ktYQcOmbCJG9Yc5jM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i6HthgbGtV+5va9s8KqYP4hOsuRumSrV3rrvLIaq4clbFivxxDHkLQ3UOsg3OUMZffqrFP3uAo0uKeM5rTFgwXl8czrPkZLjJPWGQwMzC0rAS8S8kTQp34qyxV+SQOMayyFsxWboZh2Ur+1uXZna3BSRnt9lmUWRLtz25DeAi1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V2coKTDd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2coKTDd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773839422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4l/xww/reh/vFG6vfrgSIgll6ktYQcOmbCJG9Yc5jM=;
	b=V2coKTDdvaPmUVtvGu249TSbj+qRUgkLk036DQQhBxbcZtut5UssP8loQuadtRWuGUjYY+
	V1bsdWCh3XUX3ezJtW5zANmixdhJJrq6cpDx4cfFww4/ZT9QL5KmBLFaGspM3pRnKE/PQb
	PY1/wUaeLbODJuVPLvOYdQt+qEK7J2o=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-gfWknQcFOHeYYQ78mwx0Fw-1; Wed, 18 Mar 2026 09:10:21 -0400
X-MC-Unique: gfWknQcFOHeYYQ78mwx0Fw-1
X-Mimecast-MFC-AGG-ID: gfWknQcFOHeYYQ78mwx0Fw_1773839421
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-89c4b4ca093so771766d6.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Mar 2026 06:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773839421; x=1774444221;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=87mlS3zeTTCtWqzXl89MNXTW6Xcc0f3FIlJL2cvovbM=;
        b=OTdP64vSEJCt3N1C96hEWBSKcbzAvLDFBi8X74OD9pcAoNkVnhX59kPvzLta6Y7MIq
         v3QFc03AHd/bgrNFz+aePguecrhzzPSbva0ayUFBaetL3oCDmyV3fwXDFTGjGRCXaDWg
         HQd4Aju0f9ZDi6LVbOfBVd5Y7uS7DXyZw/ohnS0IC9sqS9RwjCQkDWMpQzrjFFVmw2Sa
         ZX+vDWfy8Qb3TfwQ1zAbmCdwnSO+/xdcVLp7MQvPzxLX47bYqZbo3Vz0HsWVZc6E2ZJl
         Z73sASETo2+k+bDavm+wqUFelBqI3813HvrGZsGWmNUsaKWId0bqgYgT6vA4DOWi9720
         esvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMnaRAsDhWMzT4RS2SqiWS4TgxnI8MQznjJ/A/Ch2OOfr1J1ODJRNFu+BOG1nKsIh8X9gnYNGas4Sz7wT1JfIncFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCVC2IiQDmVe+28vZn16aUdOl6k/+14kkx/JY9NQNi9ooafWJC
	vavEXSy0EIUTM4TNcHTWQU+U8YbxBlIjMuVYs55i1Rrj8RJJV1GwpcHKtrDalJhD5MWKvaNVFaM
	4rTzkyRDWZ9vTri2czw15HOF7VZ3zTQP+XY2LxGTkNehvHBAObdZIEsE0nicyWP18qv0tR7M8Qg
	==
X-Gm-Gg: ATEYQzxrKkTfcCa9PpvadfPq84bzLLaVorZdzkXMktGsWylzs0MDzdI8OI08zACmdtX
	PT5qZWHyMTt/qNBMnkjTe+IOg8QTQHLb6u+hGGwbNVL1mZq8OrrrfkfGG8dqNtraKIuj3iCHXOu
	vcCv0tkznEfas2gg6YiOim6Tezyq6A6YhiFXbW5vEWfIpLKWfSySCfEVpSHWFER4ju5kfXL//xV
	QTiB7uXEHwOq1RkDFM9T1oe3pvaTPhby/tdUX9ta8DX9LAoxl/B9nCwYuzxVQMs7snHzKA64x1N
	1ISNzp9ul6avu9j8UtgHMasjzemcpY4ZYDdDt+sVeaOpSp1SSdxyxYPO8FuZy0TqbP/d7iSHI/r
	Wv9T51Hau5wiEPTeqAPJziRchbGnO+qIv7PSyE/Aj8N1fqIKch2W3xPmkWv8=
X-Received: by 2002:a05:620a:254f:b0:8cd:b3dc:9d4e with SMTP id af79cd13be357-8cfad259557mr439906885a.32.1773839420827;
        Wed, 18 Mar 2026 06:10:20 -0700 (PDT)
X-Received: by 2002:a05:620a:254f:b0:8cd:b3dc:9d4e with SMTP id af79cd13be357-8cfad259557mr439899885a.32.1773839420260;
        Wed, 18 Mar 2026 06:10:20 -0700 (PDT)
Received: from loberman-thinkpadp16gen3.rmtusma.csb ([2600:6c64:4e7f:603b:aa2b:ddff:fe88:da74])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfacdeb9edsm210216285a.17.2026.03.18.06.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 06:10:19 -0700 (PDT)
Message-ID: <01a554a9aca3ce03cfe6b60200d80dab975bb644.camel@redhat.com>
Subject: Re: [PATCH] blk-mq: add tracepoint block_rq_tag_wait
From: Laurence Oberman <loberman@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
 	axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com
Cc: johannes.thumshirn@wdc.com, kch@nvidia.com, bvanassche@acm.org, 
	ritesh.list@gmail.com, neelx@suse.com, sean@ashe.io, mproche@gmail.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Date: Wed, 18 Mar 2026 09:10:17 -0400
In-Reply-To: <e7db667e-2662-4ad9-89cd-309c457ce17e@kernel.org>
References: <20260317182835.258183-1-atomlin@atomlin.com>
	 <e7db667e-2662-4ad9-89cd-309c457ce17e@kernel.org>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wzVwh8q2V_DI_xyymFbeQ2m9Os0oJ9c1sawXajGBbPo_1773839421
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-03-18 at 08:38 +0900, Damien Le Moal wrote:
> On 2026/03/18 3:28, Aaron Tomlin wrote:
> > In high-performance storage environments, particularly when
> > utilising
> > RAID controllers with shared tag sets (BLK_MQ_F_TAG_HCTX_SHARED),
> > severe
> > latency spikes can occur when fast devices (SSDs) are starved of
> > hardware
> > tags when sharing the same blk_mq_tag_set.
> >=20
> > Currently, diagnosing this specific hardware queue contention is
> > difficult. When a CPU thread exhausts the tag pool,
> > blk_mq_get_tag()
> > forces the current thread to block uninterruptible via
> > io_schedule().
> > While this can be inferred via sched:sched_switch or dynamically
> > traced by attaching a kprobe to blk_mq_mark_tag_wait(), there is no
> > dedicated, out-of-the-box observability for this event.
> >=20
> > This patch introduces the block_rq_tag_wait static tracepoint in
> > the tag allocation slow-path. It triggers immediately before the
> > thread yields the CPU, exposing the exact hardware context (hctx)
> > that is starved, the total pool size, and the current active
> > request
> > count.
> >=20
> > This provides storage engineers and performance monitoring agents
> > with a zero-configuration, low-overhead mechanism to definitively
> > identify shared-tag bottlenecks and tune I/O schedulers or cgroup
> > throttling accordingly.
> >=20
> > Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
>=20
> Looks OK to me, but I have some suggestions below.
>=20
> > ---
> > =C2=A0block/blk-mq-tag.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 3 +++
> > =C2=A0include/trace/events/block.h | 36
> > ++++++++++++++++++++++++++++++++++++
> > =C2=A02 files changed, 39 insertions(+)
> >=20
> > diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> > index 33946cdb5716..f50993e86ca5 100644
> > --- a/block/blk-mq-tag.c
> > +++ b/block/blk-mq-tag.c
> > @@ -13,6 +13,7 @@
> > =C2=A0#include <linux/kmemleak.h>
> > =C2=A0
> > =C2=A0#include <linux/delay.h>
> > +#include <trace/events/block.h>
> > =C2=A0#include "blk.h"
> > =C2=A0#include "blk-mq.h"
> > =C2=A0#include "blk-mq-sched.h"
> > @@ -187,6 +188,8 @@ unsigned int blk_mq_get_tag(struct
> > blk_mq_alloc_data *data)
> > =C2=A0=09=09if (tag !=3D BLK_MQ_NO_TAG)
> > =C2=A0=09=09=09break;
> > =C2=A0
> > +=09=09trace_block_rq_tag_wait(data->q, data->hctx);
> > +
> > =C2=A0=09=09bt_prev =3D bt;
> > =C2=A0=09=09io_schedule();
> > =C2=A0
> > diff --git a/include/trace/events/block.h
> > b/include/trace/events/block.h
> > index 6aa79e2d799c..48e2ba433c87 100644
> > --- a/include/trace/events/block.h
> > +++ b/include/trace/events/block.h
> > @@ -226,6 +226,42 @@ DECLARE_EVENT_CLASS(block_rq,
> > =C2=A0=09=09=C2=A0 IOPRIO_PRIO_LEVEL(__entry->ioprio), __entry-
> > >comm)
> > =C2=A0);
> > =C2=A0
> > +/**
> > + * block_rq_tag_wait - triggered when an I/O request is starved of
> > a tag
>=20
> when an I/O request -> when a request
>=20
> > + * @q: queue containing the request
>=20
> request queue of the target device
>=20
> ("containing" is odd here)
>=20
> > + * @hctx: hardware context (queue) experiencing starvation
>=20
> hardware context of the request
>=20
> > + *
> > + * Called immediately before the submitting thread is forced to
> > block due
>=20
> the submitting thread -> the submitting context
>=20
> > + * to the exhaustion of available hardware tags. This tracepoint
> > indicates
>=20
> s/tracepoint/trace point
>=20
> > + * that the thread will be placed into an uninterruptible state
> > via
>=20
> s/thread/context
>=20
> > + * io_schedule() until an active block I/O operation completes and
> > + * relinquishes its assigned tag.
>=20
> until an active request completes
>=20
> (BIOs do not have tags).
>=20
> > + */
> > +TRACE_EVENT(block_rq_tag_wait,
> > +
> > +=09TP_PROTO(struct request_queue *q, struct blk_mq_hw_ctx
> > *hctx),
> > +
> > +=09TP_ARGS(q, hctx),
> > +
> > +=09TP_STRUCT__entry(
> > +=09=09__field(
> > dev_t,=09=09dev=09=09=09)
> > +=09=09__field(
> > u32,=09=09hctx_id=09=09=09)
> > +=09=09__field(
> > u32,=09=09nr_tags=09=09=09)
> > +=09=09__field(
> > u32,=09=09active_requests=09=09)
> > +=09),
> > +
> > +=09TP_fast_assign(
> > +=09=09__entry->dev=09=09=C2=A0 =3D q->disk ? disk_devt(q-
> > >disk) : 0;
>=20
> I do not think that q->disk can ever be NULL when there is a request
> being
> submitted.
>=20
> > +=09=09__entry->hctx_id=09=C2=A0 =3D hctx ? hctx->queue_num
> > : 0;
> > +=09=09__entry->nr_tags=09=C2=A0 =3D hctx && hctx->tags ?
> > hctx->tags->nr_tags : 0;
> > +=09=09__entry->active_requests=C2=A0 =3D hctx ?
> > atomic_read(&hctx->nr_active) : 0;
> > +=09),
> > +
> > +=09TP_printk("%d,%d hctx=3D%u starved (active=3D%u/%u)",
> > +=09=09=C2=A0 MAJOR(__entry->dev), MINOR(__entry->dev),
> > +=09=09=C2=A0 __entry->hctx_id, __entry->active_requests,
> > __entry->nr_tags)
> > +);
> > +
> > =C2=A0/**
> > =C2=A0 * block_rq_insert - insert block operation request into queue
> > =C2=A0 * @rq: block IO operation request
>=20

This visibility will be very useful. I plan to test it fully.
Updates to follow
Thanks
Laurence Oberman


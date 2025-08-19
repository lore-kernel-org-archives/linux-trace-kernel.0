Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628594690
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755599673; cv=none; b=V7HAaHXufX1n7On9fI101I8JOAWJ93N7Tbh2SKjl3qitETSHiXQ1FdCK1fo7tk0KPlyRrC34JdrqCqKFtULcxCNVCUYyNNiX+QBc7SaIUd53VWXSNRDDCbfCXstnKktAvIPIk463Pi2hDrdXMiXln0DFRyP8243JrbxW+eTEPnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755599673; c=relaxed/simple;
	bh=DlIjc/BXZ9/ncy5O7qEghQQppUwt0aRgaM42tAGt9ho=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=My0CSC2/O3h/W77tHWF9K6PXbTYoSz/5BY7bC9Bxm31oVweFuvY3VS74Y6pLzYU5Pkft/XrbmhnprMgJPfdD5NWqrnpk8dSmiw6v7GOVYyUNH6t2NcqsTq5j4Q6pxpxHoyiTTmQMDCZ07Ht2FVxLdYJor5qEWQDXAv7opP5lckI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AN/05YZi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AN/05YZi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755599670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DlIjc/BXZ9/ncy5O7qEghQQppUwt0aRgaM42tAGt9ho=;
	b=AN/05YZiSO/Snt9mW819fxlyIn5eezj177qSZUrhxNc2gP67JPYbwSVICLj79bdN0KBJbz
	d3qsUyJXlzZxgdemhMF7Blc9uQ9DIr557CkIpVJdaPk/3QaGqWCbZg5fl+J+vZA6wLBS4i
	NgTb81o0rYP8J6hWyVkCaNXTkcGUMmE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-5hP0JpFOOjWFVxxXwRBXJQ-1; Tue, 19 Aug 2025 06:34:28 -0400
X-MC-Unique: 5hP0JpFOOjWFVxxXwRBXJQ-1
X-Mimecast-MFC-AGG-ID: 5hP0JpFOOjWFVxxXwRBXJQ_1755599668
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e86f8f27e1so1620821185a.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755599668; x=1756204468;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gnf9n/lvCgk4Dmu8/IiYGJ+sE0rdjFg2NpPd38mVnIg=;
        b=ny6MMspUjlrsDHLZmne+yBpC/iEhBqb6mNzDZfFF7tRwrhvU2n/pcQih/IKl10tsu7
         VM+qcRJi/3/kZQOCjyYS27XBBKKHaj4JOSLuWN29qtTFMXw+ASrYwQqzl1cEz0JYcskS
         KD39GTabeQ2Yy0VnqH5zu8Ivikuth2fWY4ufCJLNKl3vx2egCrc4e+eLwGRPnJ/jwqDH
         oLe6EoqKa+odDM5HtTou2UPRGPkd7sZKjNn5lFiErvG+gj9CzN0uH9wT7AiK4lFgNAZ8
         D/d3izY5tdDu3roCzCAdYKwbKUDWRHc+ARLJVmofr8Cd4Ta/xNZtZkRdW2R8VybjxBeL
         c/KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeiRfG7JeYYL0xqLNtZgUskHC8PgprQCNOV65o4sHnA50mg5OZIiEotfrOys9EhOFSycL3vVcrSeyu0tknTSsSBp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOSSGh8CA5oyQrZXnk0RHNhh3YmZxEf1rHAl2KxM4+Uu2lEpVo
	ZFnaH3P6OEG5BwqeYXIbCOYQHTyrRhyki00NeF/gnk90oYy0vNV9mS8cEJKZIdnXRxCmBdG+V77
	k5nEhjUdjLGU5KHv9z1ZvNsrdJHrUrP7Ley/a2SsKz4TSV7qWHCNR0S2zt+S1lws0J5oSjGKW+w
	==
X-Gm-Gg: ASbGncuVAlGhXnMn83LhL+96TGVIGOBqvgmqTmnUHAP0Yzbz6ZAttuW0K/S7dZGwwsO
	z1oxZUiPTV/yJPpFzAPyEkxZtDOb0AunFjn8bkUrrPD1bKnqInoteJV1+HDD0ftBjJrN0YpnWnP
	095fKOKYmZ5LT7F6vIxRp02fAPKeNLcf/A/lzsRLo2WdexQJO5+2E0sZXol+2pINGvsF4hPoECM
	LBqXVEWbgNgE+CTFAHArzD41IwYm2atyE1mZG0u05rajE6FDQbrO44orTnW1L5AW0uDqRvpkmcG
	0pyaFaxDxKk78odWGoEXzlu+QG3OddotONobkMw++WEhU6BAV75u4AlyKoZFYohNjQ==
X-Received: by 2002:a05:620a:1993:b0:7de:d9aa:8b47 with SMTP id af79cd13be357-7e9f4b31df5mr166978285a.18.1755599668223;
        Tue, 19 Aug 2025 03:34:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH6ombpOOxW7aZAm1rgMXKP1W9YllRE7QjE/iqNYwSVum6jldYZ6xUMyzVTW3X75hHoekc+A==
X-Received: by 2002:a05:620a:1993:b0:7de:d9aa:8b47 with SMTP id af79cd13be357-7e9f4b31df5mr166975985a.18.1755599667751;
        Tue, 19 Aug 2025 03:34:27 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba9077520sm67530886d6.21.2025.08.19.03.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:34:27 -0700 (PDT)
Message-ID: <711ff45f008bb4943418c40eba604e83858767ff.camel@redhat.com>
Subject: Re: [RFC PATCH 14/17] sched: Add deadline tracepoints
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 linux-trace-kernel@vger.kernel.org, Nam Cao	 <namcao@linutronix.de>, Tomas
 Glozar <tglozar@redhat.com>, Juri Lelli	 <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur	 <jkacur@redhat.com>
Date: Tue, 19 Aug 2025 12:34:23 +0200
In-Reply-To: <20250819101244.GF4067720@noisy.programming.kicks-ass.net>
References: <20250814150809.140739-1-gmonaco@redhat.com>
	 <20250814150809.140739-15-gmonaco@redhat.com>
	 <aKRKaTJBxD3kdt_G@jlelli-thinkpadt14gen4.remote.csb>
	 <20250819101244.GF4067720@noisy.programming.kicks-ass.net>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: glhjNvG9vzhwHmN3APErY2AHDqfFxeJMjnArsAd1f7Q_1755599668
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Tue, 2025-08-19 at 12:12 +0200, Peter Zijlstra wrote:
> On Tue, Aug 19, 2025 at 11:56:57AM +0200, Juri Lelli wrote:
> > Hi!
> >=20
> > On 14/08/25 17:08, Gabriele Monaco wrote:
> > > Add the following tracepoints:
> > >=20
> > > * sched_dl_throttle(dl):
> > > =C2=A0=C2=A0=C2=A0 Called when a deadline entity is throttled
> > > * sched_dl_replenish(dl):
> > > =C2=A0=C2=A0=C2=A0 Called when a deadline entity's runtime is repleni=
shed
> > > * sched_dl_server_start(dl):
> > > =C2=A0=C2=A0=C2=A0 Called when a deadline server is started
> > > * sched_dl_server_stop(dl, hard):
> > > =C2=A0=C2=A0=C2=A0 Called when a deadline server is stopped (hard) or=
 put to
> > > idle
> > > =C2=A0=C2=A0=C2=A0 waiting for the next period (!hard)
> > >=20
> > > Those tracepoints can be useful to validate the deadline
> > > scheduler with
> > > RV and are not exported to tracefs.
> > >=20
> > > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> > > ---
> > > =C2=A0include/trace/events/sched.h | 55
> > > ++++++++++++++++++++++++++++++++++++
> > > =C2=A0kernel/sched/deadline.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8=
 ++++++
> > > =C2=A02 files changed, 63 insertions(+)
> > >=20
> > > diff --git a/include/trace/events/sched.h
> > > b/include/trace/events/sched.h
> > > index 7b2645b50e78..f34cc1dc4a13 100644
> > > --- a/include/trace/events/sched.h
> > > +++ b/include/trace/events/sched.h
> > > @@ -609,6 +609,45 @@ TRACE_EVENT(sched_pi_setprio,
> > > =C2=A0=09=09=09__entry->oldprio, __entry->newprio)
> > > =C2=A0);
> > > =C2=A0
> > > +/*
> > > +DECLARE_EVENT_CLASS(sched_dl_template,
> > > +
> > > +=09TP_PROTO(struct sched_dl_entity *dl),
> > > +
> > > +=09TP_ARGS(dl),
> > > +
> > > +=09TP_STRUCT__entry(
> > > +=09=09__field(=C2=A0 struct task_struct
> > > *,=09tsk=09=09)
> > > +=09=09__string( comm,=09=09dl->dl_server ?
> > > "server" : container_of(dl, struct task_struct, dl)-
> > > >comm=09)
> > > +=09=09__field(=C2=A0 pid_t,=09pid=09=09)
> > > +=09=09__field(=C2=A0
> > > s64,=09=09runtime=09=09)
> > > +=09=09__field(=C2=A0 u64,=09=09deadline=09)
> > > +=09=09__field(=C2=A0 int,=09=09dl_yielded=09)
> >=20
> > I wonder if, while we are at it, we want to print all the other
> > fields
> > as well (they might turn out to be useful). That would be
> >=20
> > =C2=A0.:: static (easier to retrieve with just a trace)
> > =C2=A0- dl_runtime
> > =C2=A0- dl_deadline
> > =C2=A0- dl_period
> >=20
> > =C2=A0.:: behaviour (RECLAIM)
> > =C2=A0- flags
> >=20
> > =C2=A0.:: state
> > =C2=A0- dl_ bool flags in addition to dl_yielded
>=20
> All these things are used as _tp(). That means they don't have trace
> buffer entries ever, why fill out fields?
>=20

Right, that is a relic of the way I put it initially, this whole thing
is commented out (which is indeed confusing and barely noticeable in
the patch).
The tracepoints are in fact not exported to the tracefs and do not use
the print format.

I should have removed this, the real ones are at the bottom of the
file.

>=20
> > > +=09),
> > > +
> > > +=09TP_fast_assign(
> > > +=09=09__assign_str(comm);
> > > +=09=09__entry->pid=09=09=3D dl->dl_server ? -1 :
> > > container_of(dl, struct task_struct, dl)->pid;
> > > +=09=09__entry->runtime=09=3D dl->runtime;
> > > +=09=09__entry->deadline=09=3D dl->deadline;
> > > +=09=09__entry->dl_yielded=09=3D dl->dl_yielded;
> > > +=09),
> > > +
> > > +=09TP_printk("comm=3D%s pid=3D%d runtime=3D%lld deadline=3D%lld
> > > yielded=3D%d",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^
> > =09=09=09=09=09=09=09llu ?
> >=20

As above, this should all go away.

> > > +=09=09=09__get_str(comm), __entry->pid,
> > > +=09=09=09__entry->runtime, __entry->deadline,
> > > +=09=09=09__entry->dl_yielded)
> > > +);
> >=20
> > ...
> >=20
> > > @@ -1482,6 +1486,7 @@ static void update_curr_dl_se(struct rq
> > > *rq, struct sched_dl_entity *dl_se, s64
> > > =C2=A0
> > > =C2=A0throttle:
> > > =C2=A0=09if (dl_runtime_exceeded(dl_se) || dl_se->dl_yielded) {
> > > +=09=09trace_sched_dl_throttle_tp(dl_se);
> > > =C2=A0=09=09dl_se->dl_throttled =3D 1;
> >=20
> > I believe we also need to trace the dl_check_constrained_dl()
> > throttle, please take a look.

Probably yes, strangely I couldn't see failures without it, but it may
be down to my test setup. I'm going to have a look.

> > Also - we discussed this point a little already offline - but I
> > still wonder if we have to do anything special for dl-server defer.
> > Those entities are started as throttled until 0-lag, so maybe we
> > should still trace them explicitly as so?

The naming might need a bit of a consistency check here, but for the
monitor, the server is running, armed or preempted. Before the 0-lag,
it will never be running, so it will stay as armed (fair tasks running)
or preempted (rt tasks running).

armed and preempted have the _throttled version just to indicate an
explicit throttle event occurred.

We might want to start it in the armed_throttled if we are really
guaranteed not to see a throttle event, but I think that would
complicate the model considerably.

We could instead validate the 0-lag concept in a separate, server-
specific model.

Does this initial model feel particularly wrong for the server case?

> > In addition, since it's related, maybe we should do something about
> > sched_switch event, that is currently not aware of deadlines,
> > runtimes, etc.

I'm not sure I follow you here, what relation with switch and
runtime/deadline should we enforce?

We don't really force the switch to occur timely after throttling, is
that what you mean?
Or a switch must occur again timely after replenishing?

> As per the whole _tp() thing, you can attach to the actual
> sched_switch tracepoint with a module and read whatever you want.

Yeah I believe Juri referred to model constraints on the already
existing events rather than new tracepoints here.

Thanks both,
Gabriele


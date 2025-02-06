Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539B9224B05
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Feb 2025 08:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738831010; cv=none; b=Xkpjih+qV9ou0SGzdh4sdbRr4+yK47Ukztd8hIsVoH/44/vs5GEBUv6JR7QqYaCe5DWWUKphZl2bUhXlzgw0yEpVJ+iT/PBqMwMQpfhDq0lYNPQnp6/zub19mq8tp0veNaFjotWTXG3hZSUHuD7nlOJcd+EJe8NIN5L5ovDp18s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738831010; c=relaxed/simple;
	bh=+OnXVgjV6PfqMGkC648v1jpWoywzoScucmeG1vVjVFA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bpMu7k57hmmw9Nyaxf5eIg40f4CK6QtqgIg6lTf5s3YX7ZgISZ4SYnEtwXIsTAwWzOAanYdDTqHB+k4W4VCUd5ph09M8WFsv15V59W5fS5bEKHpCBoYqTBlNWcnSRvEdxufDJE9M4E0GbvjyEHNDLCpSU9ZMPnBNZnBRnziR2SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CgisutlA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CgisutlA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738831007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+OnXVgjV6PfqMGkC648v1jpWoywzoScucmeG1vVjVFA=;
	b=CgisutlADoc7ik65LOBGg34WRWJGzTxRtCRKrWIoheSk9YxdvMcm4Vv10k/isrJGITVJkP
	Z2rBJh29/xDpbqYPP/pHtRN412aAkeoj9O/S8gVrYcGKuQ08WxgrokSOk8VGrqQ9rSpyzV
	GvE6g8Xha4Kz+Auu/x6Hnv4ZdB170xc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-8zJQJs-1OTypK_WI1WR3Sg-1; Thu, 06 Feb 2025 03:36:45 -0500
X-MC-Unique: 8zJQJs-1OTypK_WI1WR3Sg-1
X-Mimecast-MFC-AGG-ID: 8zJQJs-1OTypK_WI1WR3Sg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4362b9c15d8so2832405e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Feb 2025 00:36:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738831004; x=1739435804;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jgm++d8qawW/jYXEWDCtTkLpIjEZmLLSJeGeo61b7eY=;
        b=hIWUheFSHAbItlOQyu1dFpyg5A6uBku9fJpIN7NyqCftHdP29YCqT2UZCehax29kdg
         Q730N4HcJRiUF4VGRDS1D6sJ5dqXTQQkTWnHRysHFNgPkW8STWm7znzdGTrDU0fz7ez3
         Y+DZmctp0GC4vr1qYl5nhfY/PtcDkJyI6q1lAna8IjxHaxfhu4frIbOOmy25tjUdNX+k
         TfDrw4hXu8nd8gqTC+oeErxuwxjkHDQHK6Kjs3QQU7uY3E9kJWmvoeiGQo5Fp9TI4bfa
         QPYK/NIdDyFmF3bhg6aPaaPlvDCFmu9/5Ij7eBcFmVu7zLZQcqhtjOkL04BADYHz5z9S
         yFPg==
X-Forwarded-Encrypted: i=1; AJvYcCXM50PLS3s0yH1yWe+Wu4t+590jdS/UlHNKn5lTmwty6PqanL0cRwERShELOo/FLkZAzY2Gen4g9FMX6BXloAfUimQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJahEmVeRYebaDFSyk71Zg2UVQGAxEpSDL0ipuQRasg0nweTkU
	ZEA3ySgD0dY5EAJ3hrNR2rZvykzY2mqe0YydAVnP5H/GLloV5AVMRMCsZSoNJJ050p1aOn+NUDA
	tiOlMLI4E1QlLID7t/BQI94VjLFpqpaw8h7Wy7sGWhaN5/eGalVmZk7h5jSCwrqQBfvERh6QQVo
	rtdiQ4
X-Gm-Gg: ASbGncuBagdfvfWLQ5Qf6c3/YNKoRYX2sQBSWwts6Ccn8jQshbTMV4PUeXtgDbXMCN9
	sweErYXfz/qjqYV5M/AJiLrF9JPac1PgAuTvH+3ndLGv/ObFxB7U/pi+suzYVqjeQK1vCkiY5JN
	Wxm9yexbVV5hjx6vlMIaTMMBFb1vAJqWIE57anyGgJvhCOxH5mFS60beP/OmVbEWAbRmHCRDw0K
	V1AchJf52YJ5folWujODGYB5lqo2KsTS1SVHOavhnneVWapjAHB0s8XA23EFXn4Du0nAqM9mY+U
	/IfMM+y5sXwJMlaAbZRc6EtnfjlGvOs=
X-Received: by 2002:a05:600c:3c8e:b0:436:f3f6:9582 with SMTP id 5b1f17b1804b1-4390d433bbamr42454275e9.8.1738831004466;
        Thu, 06 Feb 2025 00:36:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFj/MmAVM8fe+Dnvzu/cvjpk828Tlny2S+XF/GaeoBwhrOTbslBJtdNx1EJBPP9Js3Vv5QzOA==
X-Received: by 2002:a05:600c:3c8e:b0:436:f3f6:9582 with SMTP id 5b1f17b1804b1-4390d433bbamr42454045e9.8.1738831004023;
        Thu, 06 Feb 2025 00:36:44 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbde2fc01sm1100749f8f.93.2025.02.06.00.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 00:36:43 -0800 (PST)
Message-ID: <d8187fcd53c62272d7e1a8dad327c4f2a5f07188.camel@redhat.com>
Subject: Re: [RFC PATCH 03/11] sched: Add sched tracepoints for RV task model
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Ingo
 Molnar <mingo@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org
Date: Thu, 06 Feb 2025 09:36:41 +0100
In-Reply-To: <20250206081942.GJ7145@noisy.programming.kicks-ass.net>
References: <20250206080952.98478-1-gmonaco@redhat.com>
	 <20250206080952.98478-4-gmonaco@redhat.com>
	 <20250206081942.GJ7145@noisy.programming.kicks-ass.net>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: q0HuRKSMi-gXGYuYCi3B9jy-NmqSMRsruu12heyu-WU_1738831004
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Thu, 2025-02-06 at 09:19 +0100, Peter Zijlstra wrote:
> On Thu, Feb 06, 2025 at 09:09:39AM +0100, Gabriele Monaco wrote:
>=20
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 9632e3318e0d6..af9fa18035c71 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -226,12 +226,14 @@ struct user_event_mm;
> > =C2=A0#define
> > __set_current_state(state_value)=09=09=09=09\
> > =C2=A0=09do
> > {=09=09=09=09=09=09=09=09\
> > =C2=A0=09=09debug_normal_state_change((state_value));=09
> > =09\
> > +=09=09trace_set_current_state(state_value);=09=09
> > =09\
> > =C2=A0=09=09WRITE_ONCE(current->__state,
> > (state_value));=09=09\
> > =C2=A0=09} while (0)
> > =C2=A0
> > =C2=A0#define
> > set_current_state(state_value)=09=09=09=09=09\
> > =C2=A0=09do
> > {=09=09=09=09=09=09=09=09\
> > =C2=A0=09=09debug_normal_state_change((state_value));=09
> > =09\
> > +=09=09trace_set_current_state(state_value);=09=09
> > =09\
> > =C2=A0=09=09smp_store_mb(current->__state,
> > (state_value));=09=09\
> > =C2=A0=09} while (0)
> > =C2=A0
> > @@ -247,6 +249,7 @@ struct user_event_mm;
> > =C2=A0=09=09=09=09=09=09=09=09
> > =09\
> > =C2=A0=09=09raw_spin_lock_irqsave(&current->pi_lock,
> > flags);=09\
> > =C2=A0=09=09debug_special_state_change((state_value));=09
> > =09\
> > +=09=09trace_set_current_state(state_value);=09=09
> > =09\
> > =C2=A0=09=09WRITE_ONCE(current->__state,
> > (state_value));=09=09\
> > =C2=A0=09=09raw_spin_unlock_irqrestore(&current->pi_lock,
> > flags);=09\
> > =C2=A0=09} while (0)
> > @@ -282,6 +285,7 @@ struct user_event_mm;
> > =C2=A0=09=09raw_spin_lock(&current-
> > >pi_lock);=09=09=09\
> > =C2=A0=09=09current->saved_state =3D current-
> > >__state;=09=09\
> > =C2=A0=09=09debug_rtlock_wait_set_state();=09=09=09
> > =09\
> > +=09=09trace_set_current_state(TASK_RTLOCK_WAIT);=09
> > =09\
> > =C2=A0=09=09WRITE_ONCE(current->__state,
> > TASK_RTLOCK_WAIT);=09=09\
> > =C2=A0=09=09raw_spin_unlock(&current-
> > >pi_lock);=09=09=09\
> > =C2=A0=09} while (0);
> > @@ -291,6 +295,7 @@ struct user_event_mm;
> > =C2=A0=09=09lockdep_assert_irqs_disabled();=09=09
> > =09=09\
> > =C2=A0=09=09raw_spin_lock(&current-
> > >pi_lock);=09=09=09\
> > =C2=A0=09=09debug_rtlock_wait_restore_state();=09=09
> > =09\
> > +=09=09trace_set_current_state(TASK_RUNNING);=09=09
> > =09\
> > =C2=A0=09=09WRITE_ONCE(current->__state, current-
> > >saved_state);=09\
> > =C2=A0=09=09current->saved_state =3D
> > TASK_RUNNING;=09=09=09\
> > =C2=A0=09=09raw_spin_unlock(&current-
> > >pi_lock);=09=09=09\
>=20
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 165c90ba64ea9..fb5f8aa61ef5d 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -491,6 +491,12 @@ sched_core_dequeue(struct rq *rq, struct
> > task_struct *p, int flags) { }
> > =C2=A0
> > =C2=A0#endif /* CONFIG_SCHED_CORE */
> > =C2=A0
> > +void trace_set_current_state(int state_value)
> > +{
> > +=09trace_sched_set_state_tp(current, current->__state,
> > state_value);
> > +}
> > +EXPORT_SYMBOL(trace_set_current_state);
>=20
> Urgh, why !?!
>=20

Do you mean why exporting it?
At first I was puzzled too (this line is borrowed from Daniel), but the
thing is: set_current_state and friends are macros called by any sort
of code (e.g. modules), this seems the easiest way without messing up
with the current code.

I'm not sure if it would be cleaner to just drop this function and
define it directly in the header (including also trace/events/sched.h
there). It felt like files including sched shouldn't know about
tracepoints.

What do you think would be better?


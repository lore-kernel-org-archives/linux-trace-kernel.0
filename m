Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4D41EFFA0
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Mar 2025 07:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741764853; cv=none; b=tVLBGFDSkSPuNzm+3EjzsFSVMCjwXESi8uTXsfvTxDM2xfiQo+gjE8P5AK7SohMyuS9E60yK085QId2L0olUipy8+Djj0FbFBIY6/HV5cZ2Ix48kZcMyMZfo/32y4cOtDrC7mC1Bk3jzLQ6x/341CgZXkT+yBDjNUkV5bavHVPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741764853; c=relaxed/simple;
	bh=2vyF+cqz3zZX2hKzydKcq21vAI1FU1aqnQ2M38aW5F8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=byis5k6AEhBthJuLn9INyP2ZFhOsF4rsC2Dlwq0FSqmyIeg7xDcJZBACfZQShPb7IvcjgEgIPYmHthzYGIjajaQx1cId45VH/gl0Nq/CalSI3W2oJNtEoFQPYFBpD0tp41O87FrBes3xdMeqUR8Pe99SmeECmjK1lfMFzhgrqx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WVSUnHoj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WVSUnHoj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741764850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2vyF+cqz3zZX2hKzydKcq21vAI1FU1aqnQ2M38aW5F8=;
	b=WVSUnHojEUu2y1TwWxSFuoTHOK+i6pKKDpcnZXQx1vskk0YNW/M9D12u8y6BcTYgvQSTZa
	r11JG+patx0ZZMuClnUZuVdcXyX25TuGzBR45dN29hWJ9wi0XOggG22uV0Env7MQUcSx8N
	IPbvQe/LmTc3SoQjgs+pxTGUdwgkKPc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-tEHvuCX-Pwqsb7SFw-A7yg-1; Wed, 12 Mar 2025 03:34:08 -0400
X-MC-Unique: tEHvuCX-Pwqsb7SFw-A7yg-1
X-Mimecast-MFC-AGG-ID: tEHvuCX-Pwqsb7SFw-A7yg_1741764848
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d00017e9dso13540185e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Mar 2025 00:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741764848; x=1742369648;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WtPBAnx7Hs4Uba/pRGLu260H1NcJqtDvQTP8rvegdd0=;
        b=fU/2flP2/d08F38JHZr9kU5PEx7IIIKODfhK3+1wBez0eARF7TERrE/e4bOuXuurJ1
         jqGsOWUuD6ZdQh8g7iZVKp8d1ou3cGdSV5YF7cmQNyK7AdsU45bG3YxRiJo4xYxY1/Yn
         lfeajRWPSqHIZRUfKM0+7E6+O4Tog747+yTlV46ROe73uD746H3lZMMVnlpc1+lWvW8H
         QbQHRzGhLB+TnVH5Rne+ZqR+T549/3as7tKsJ5SPcp7xrRcNDyM2c4nXZWzGURopjbgN
         GMLOoiZsGLSHxrOGHuASyF5p7jLtWq0d/o2oBO2SOO8CMzR746iQEpzFOqH8B7zo3YEg
         Ou8g==
X-Forwarded-Encrypted: i=1; AJvYcCVRUjsWlp+gQJp5MeukSEKI0lWe+Tr+qHCZSXBypfK8IMj2P28VG9Y45vQoVx9S5j0+HPLiN+AZj9NSLojHiznzExA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHQQpQy7yiUwtQlmmkSoUOxKZWZ6Ryk5LVZGHBpqI/XQFVDsMJ
	2w4mKkvhfijKrtTJifvHVUEsLhcGUZfptQmgs0JlLCwIwrAHAdVysYi/FvBytXh1PXqR0t1aMSb
	c45PG3hp7ZdNiB6FMuCDGNuRyWLCrUpJ8JgUhcjzh5gTqexEjIYXsZfDbOluviWbD2UJEUg==
X-Gm-Gg: ASbGnct+X9MGvoFNPlH9HUvFTOlNDAQDj6wIV7+Mkcw8fEftWAjO8I0fanuE1xtFuPC
	MY4jLYD6igZ61S/NgP1hymkHeC1xapKmG8BTrH9T9i8YrMdhox3Jia9L4iQrXdJ9mWkzAiOe7it
	Xd54cB94ZTGSjefzaAQY8XGwGlafcQAo/o668227TP4AHjLeYc4xgu14La4O4X2XFjbBKolkOnR
	F+prTpkqd9+hCYJN24VV/wQw1RmIn9MyympJrgiq9P7VTwApPcWqV5HCYgST59JRrBL+xq5hjLW
	ZlAsnIlegUGwYH7UwZBE1POCbZbqKqj2COF6GqX0LA==
X-Received: by 2002:a05:600c:154a:b0:43d:526:e0ce with SMTP id 5b1f17b1804b1-43d0526e41emr38289585e9.21.1741764847703;
        Wed, 12 Mar 2025 00:34:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyaE6aWypnT1yowUbn7eXOwfbXdedrJPjEjbbpMyAohE1BhqSz+E9IIQygt3KKHJyHXfpyMQ==
X-Received: by 2002:a05:600c:154a:b0:43d:526:e0ce with SMTP id 5b1f17b1804b1-43d0526e41emr38289405e9.21.1741764847192;
        Wed, 12 Mar 2025 00:34:07 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a78cc79sm12362525e9.27.2025.03.12.00.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 00:34:06 -0700 (PDT)
Message-ID: <70e7e51882ed0ab8f8dd0b0f93de77e7aaea69f7.camel@redhat.com>
Subject: Re: [PATCH 04/10] rv: Add rtapp_block monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	john.ogness@linutronix.de, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Waiman
 Long <longman@redhat.com>
Date: Wed, 12 Mar 2025 08:34:03 +0100
In-Reply-To: <c8a1658c6da343b6055cbfcd6ee5ddea48335d31.1741708239.git.namcao@linutronix.de>
References: <cover.1741708239.git.namcao@linutronix.de>
	 <c8a1658c6da343b6055cbfcd6ee5ddea48335d31.1741708239.git.namcao@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: 9PcDvuqX8a5NsBgLNZyCQvqaesqkO2kEp08pv1PahLk_1741764848
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-03-11 at 18:05 +0100, Nam Cao wrote:
> Add an RV monitor to detect realtime tasks getting blocked. For the
> full
> description, see Documentation/trace/rv/monitor_rtapp_block.rst.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Waiman Long <longman@redhat.com>
> ---
> =C2=A0.../trace/rv/monitor_rtapp_block.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 34 +++
> =C2=A0include/trace/events/lock.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 12 +
> =C2=A0kernel/locking/rtmutex.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 4 +
> =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 12 +-
> =C2=A0kernel/trace/rv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0kernel/trace/rv/monitors/rtapp_block/ba.c=C2=A0=C2=A0=C2=A0=C2=A0 |=
 146 +++++++++++
> =C2=A0kernel/trace/rv/monitors/rtapp_block/ba.h=C2=A0=C2=A0=C2=A0=C2=A0 |=
 166 +++++++++++++
> =C2=A0kernel/trace/rv/monitors/rtapp_block/ltl=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 9 +
> =C2=A0.../rv/monitors/rtapp_block/rtapp_block.c=C2=A0=C2=A0=C2=A0=C2=A0 |=
 232
> ++++++++++++++++++

I see the creation of this type of monitor requires a bit more steps,
but are you considering automatic generation of Kconfig and
rtapp_block.c ?
We could reuse (export) some code from dot2k for that since the
skeleton could be the same.

Not needed for this series but it would be very nice to experiment
further.

I see the tracepoint generation is a bit complicated to generalise.
Da monitors currently don't give much data, besides pointing to what
failed in the model. If the user wants more, they can enable the
triggering tracepoints (e.g. I want to see the exact details of a
context switch, I enable that in the trace).

I get it isn't the quickest thing to do but makes the monitors very
general. Do you think something like this could be done here too?
Perhaps storing possible error messages in the monitor's header file
(like the state names in a da monitor).

> =C2=A0kernel/trace/rv/rv_trace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 44 ++++
> =C2=A0lib/Kconfig.debug=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> =C2=A011 files changed, 663 insertions(+), 1 deletion(-)
> =C2=A0create mode 100644 Documentation/trace/rv/monitor_rtapp_block.rst
> =C2=A0create mode 100644 kernel/trace/rv/monitors/rtapp_block/ba.c
> =C2=A0create mode 100644 kernel/trace/rv/monitors/rtapp_block/ba.h
> =C2=A0create mode 100644 kernel/trace/rv/monitors/rtapp_block/ltl
> =C2=A0create mode 100644
> kernel/trace/rv/monitors/rtapp_block/rtapp_block.c
>=20
> diff --git a/Documentation/trace/rv/monitor_rtapp_block.rst
> b/Documentation/trace/rv/monitor_rtapp_block.rst
> new file mode 100644
> index 000000000000..9cabbe66fa4a
> --- /dev/null
> +++ b/Documentation/trace/rv/monitor_rtapp_block.rst
> @@ -0,0 +1,34 @@
> +Monitor rtapp_block
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +- Name: rtapp_block - real time applications are undesirably blocked
> +- Type: per-task linear temporal logic monitor
> +- Author: Nam Cao <namcao@linutronix.de>
> +
> +Introduction
> +------------
> +
> +Real time threads could be blocked and fail to finish their
> execution timely. For instance, they
> +need to access shared resources which are already acquired by other
> threads. Or they could be
> +waiting for non-realtime threads to signal them to proceed: as the
> non-realtime threads are not
> +prioritized by the scheduler, the execution of realtime threads
> could be delayed indefinitely.
> +These scenarios are often unintentional, and cause unexpected
> latency to the realtime application.
> +
> +The rtapp_block monitor reports this type of scenario, by monitoring
> for:
> +
> +=C2=A0 * Realtime threads going to sleep without explicitly asking for i=
t
> (namely, with nanosleep
> +=C2=A0=C2=A0=C2=A0 syscall).
> +=C2=A0 * Realtime threads are woken up by non-realtime threads.
> +
> +How to fix the monitor's warnings?
> +----------------------------------
> +
> +There is no single answer, the solution needs to be evaluated
> depending on the specific cases.
> +
> +If the realtime thread is blocked trying to take a `pthread_mutex_t`
> which is already taken by a
> +non-realtime thread, the solution could be enabling priority
> inheritance for the mutex, so that the
> +blocking non-realtime thread would be priority-boosted to run at
> realtime priority.
> +
> +If realtime thread needs to wait for non-realtime thread to signal
> it to proceed, perhaps the design
> +needs to be reconsidered to remove this dependency. Often, the work
> executed by the realtime thread
> +needs not to be realtime at all.
> diff --git a/include/trace/events/lock.h
> b/include/trace/events/lock.h
> index 8e89baa3775f..d4b32194d47f 100644
> --- a/include/trace/events/lock.h
> +++ b/include/trace/events/lock.h
> @@ -138,6 +138,18 @@ TRACE_EVENT(contention_end,
> =C2=A0=09TP_printk("%p (ret=3D%d)", __entry->lock_addr, __entry->ret)
> =C2=A0);
> =C2=A0
> +#ifdef CONFIG_TRACE_RT_MUTEX_WAKE_WAITER
> +DECLARE_TRACE(rt_mutex_wake_waiter_begin,
> +=09=09TP_PROTO(struct task_struct *task),
> +=09=09TP_ARGS(task))
> +DECLARE_TRACE(rt_mutex_wake_waiter_end,
> +=09=09TP_PROTO(struct task_struct *task),
> +=09=09TP_ARGS(task))
> +#else
> +#define trace_rt_mutex_wake_waiter_begin(...)
> +#define trace_rt_mutex_wake_waiter_end(...)
> +#endif /* CONFIG_TRACE_RT_MUTEX */
> +
> =C2=A0#endif /* _TRACE_LOCK_H */
> =C2=A0
> =C2=A0/* This part must be outside protection */
> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index 4a8df1800cbb..fc9cf4a2cf75 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> [...]
> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index 8226352a0062..d65bf9bda2f2 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> [...]
> diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
> index 188b64668e1f..6570a3116127 100644
> --- a/kernel/trace/rv/Makefile
> +++ b/kernel/trace/rv/Makefile
> [...]
> diff --git a/kernel/trace/rv/monitors/rtapp_block/ba.c
> b/kernel/trace/rv/monitors/rtapp_block/ba.c
> new file mode 100644
> index 000000000000..5e99f79d5e74
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/rtapp_block/ba.c
> @@ -0,0 +1,146 @@
> [...]
> diff --git a/kernel/trace/rv/monitors/rtapp_block/ba.h
> b/kernel/trace/rv/monitors/rtapp_block/ba.h
> new file mode 100644
> index 000000000000..c1ba88f6779a
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/rtapp_block/ba.h
> @@ -0,0 +1,166 @@
> [...]
> +
> +/**
> + * rv_rtapp_block_atoms_fetch - fetch the atomic propositions
> + * @task:=09the task
> + * @mon:=09the LTL monitor
> + *
> + * Must be implemented. This function is called anytime the Buchi
> automaton is triggered. Its
> + * intended purpose is to update the atomic propositions which are
> expensive to trace and can be
> + * easily read from @task. rv_rtapp_block_atom_set() should be used
> to implement this function.
> + *
> + * Using this function may cause incorrect verification result if it
> is important for the LTL that
> + * the atomic propositions must be updated at the correct time.
> Therefore, if it is possible,
> + * updating atomic propositions should be done with
> rv_rtapp_block_atom_update() instead.
> + *
> + * An example where this function is useful is with the LTL
> property:
> + *=C2=A0=C2=A0=C2=A0 always (RT imply not PAGEFAULT)
> + * (a realtime task does not raise page faults)
> + *
> + * In this example, adding tracepoints to track RT is complicated,
> because it is changed in
> + * differrent places (mutex's priority boosting,
> sched_setscheduler). Furthermore, for this LTL
> + * property, we don't care exactly when RT changes, as long as we
> have its correct value when
> + * PAGEFAULT=3D=3Dtrue. Therefore, it is better to update RT in
> rv_rtapp_block_atoms_fetch(), as it
> + * can easily be retrieved from task_struct.
> + *
> + * This function can be empty.

Personal preference, but what about having the examples only in the
docs and point to those from here? Just to keep the code a bit slimmer.

> + */
> +void rv_rtapp_block_atoms_fetch(struct task_struct *task, struct
> ltl_monitor *mon);
> +
> +/**
> + * rv_rtapp_block_atom_update - update an atomic proposition
> + * @task:=09the task
> + * @atom:=09the atomic proposition, one of enum rtapp_block_atom
> + * @value:=09the new value for @atom
> + *
> + * Update an atomic proposition and trigger the Buchi atomaton to
> check for violation of the LTL
> + * property. This function can be called in tracepoints' handler,
> for example.
> + */
> +void rv_rtapp_block_atom_update(struct task_struct *task, unsigned
> int atom, bool value);
> +
> +/**
> + * rv_rtapp_block_atom_get - get an atomic proposition
> + * @mon:=09the monitor
> + * @atom:=09the atomic proposition, one of enum rtapp_block_atom
> + *
> + * Returns the value of an atomic proposition.
> + */
> +static inline
> +enum ltl_truth_value rv_rtapp_block_atom_get(struct ltl_monitor
> *mon, unsigned int atom)
> +{
> +=09return mon->atoms[atom];
> +}
> +
> +/**
> + * rv_rtapp_block_atom_set - set an atomic proposition
> + * @mon:=09the monitor
> + * @atom:=09the atomic proposition, one of enum rtapp_block_atom
> + * @value:=09the new value for @atom
> + *
> + * Update an atomic proposition without triggering the Buchi
> automaton. This can be useful to
> + * implement rv_rtapp_block_atoms_fetch() and
> rv_rtapp_block_atoms_init().
> + *
> + * Another use case for this function is when multiple atomic
> propositions change at the same time,
> + * because calling rv_rtapp_block_atom_update() (and thus triggering
> the Buchi automaton)
> + * multiple times may be incorrect. In that case,
> rv_rtapp_block_atom_set() can be used to avoid
> + * triggering the Buchi automaton, and rv_rtapp_block_atom_update()
> is only used for the last
> + * atomic proposition.
> + */
> +static inline
> +void rv_rtapp_block_atom_set(struct ltl_monitor *mon, unsigned int
> atom, bool value)
> +{
> +=09mon->atoms[atom] =3D value;
> +}
> +
> +/**
> + * rv_rtapp_block_get_data - get the custom data of this monitor.
> + * @mon: the monitor
> + *
> + * If this function is used, rv_rtapp_block_init() must have been
> called with a positive
> + * data_size.
> + */
> +static inline void *rv_rtapp_block_get_data(struct ltl_monitor *mon)
> +{
> +=09return &mon->data;
> +}
> diff --git a/kernel/trace/rv/monitors/rtapp_block/ltl
> b/kernel/trace/rv/monitors/rtapp_block/ltl
> new file mode 100644
> index 000000000000..781f0144a222
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/rtapp_block/ltl
> @@ -0,0 +1,9 @@
> +RULE =3D always (WAKEUP_RT_TASK imply (RT or WAKEUP_WHITELIST))
> +=C2=A0=C2=A0 and always ((USER_TASK and RT) imply (SLEEP imply
> INTENTIONAL_SLEEP))
> +
> +INTENTIONAL_SLEEP =3D DO_NANOSLEEP or FUTEX_LOCK_WITH_PI
> +
> +WAKEUP_WHITELIST =3D RT_MUTEX_WAKING_WAITER
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 or STOPPING_WOKEN_TASK
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 or WOKEN_TASK_IS_MIGRATION
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 or WOKEN_TASK_IS_RCU
> diff --git a/kernel/trace/rv/monitors/rtapp_block/rtapp_block.c
> b/kernel/trace/rv/monitors/rtapp_block/rtapp_block.c
> new file mode 100644
> index 000000000000..3f5b1efb7af0

I'm wondering if it would be cleaner to keep the specifications under tools=
/
(just like the dot files for da monitors).
Nevertheless we should be consistent with what we choose.

Thanks,
Gabriele

> --- /dev/null
> +++ b/kernel/trace/rv/monitors/rtapp_block/rtapp_block.c
> [...]
> diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
> index 96264233cac5..79a7388b5c55 100644
> --- a/kernel/trace/rv/rv_trace.h
> +++ b/kernel/trace/rv/rv_trace.h
> [...]
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 1af972a92d06..942318ef3f62 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1638,6 +1638,9 @@ config TRACE_IRQFLAGS
> =C2=A0=09=C2=A0 Enables hooks to interrupt enabling and disabling for
> =C2=A0=09=C2=A0 either tracing or lock debugging.
> =C2=A0
> +config TRACE_RT_MUTEX_WAKE_WAITER
> +=09bool
> +
> =C2=A0config TRACE_IRQFLAGS_NMI
> =C2=A0=09def_bool y
> =C2=A0=09depends on TRACE_IRQFLAGS



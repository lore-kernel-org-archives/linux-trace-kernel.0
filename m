Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F38259C9C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 13:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850522; cv=none; b=G+rGy0M8XQxz7Milr7RrqGmR/mDoEXRNjY0O4oCU2l7FMJhyxyJW60jDkArEfQTTw+/MswSZGKeOHXkIJO0r8+XJ89wHyjuvlWK/ueifwUhnaogzM7DqFmxspmfDo7FPzWYhTNH609wDx1JmCxrl5AwH+EM/5rvOIHkOts0e8AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850522; c=relaxed/simple;
	bh=DZRUwXImKlXe3MhgvWeIi4ZMiMl8dGgxIbSxw2YzVGs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HR3q/qdkn6nNIYb798vOnwPSR7suNBrfRXKu03t0nyPBxIt0ZSzKIItp93UY9Nkkgq97ltAb5q4cdb4y6JbcYGx/OhrLA74ztH6q2jKRbcCWQape89bvT7imfzBUvytbEhEhVJ5LyXkart0EY9Cj4bGLF46UOO3e0mqXt4G5x3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EA9Y2szP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EA9Y2szP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778850520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DZRUwXImKlXe3MhgvWeIi4ZMiMl8dGgxIbSxw2YzVGs=;
	b=EA9Y2szPbl5ivp1mTelOntt8448qXczjKv7khMZhV1iDw7xkfkPXu+SWcVSmfJXZptejFX
	z3nlDTFOQ2HKr8A36IaGyeAiFNR6CivF9xy3Uxe0Cimlv3MW47d+JhxhfLkS083DJLK9J9
	Uq09llZ7/3UTo3jSTaB8jJ3a9yG0NEI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-VS2la7f_OJOzEJP9Pz9mqg-1; Fri, 15 May 2026 09:08:39 -0400
X-MC-Unique: VS2la7f_OJOzEJP9Pz9mqg-1
X-Mimecast-MFC-AGG-ID: VS2la7f_OJOzEJP9Pz9mqg_1778850518
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48fdca5c638so11999355e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 06:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778850518; x=1779455318;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZRUwXImKlXe3MhgvWeIi4ZMiMl8dGgxIbSxw2YzVGs=;
        b=dWQ88i1QYHxncRXh193pGLO6nF7RFhgHPY+Jo81ZPkC1KHhOI92btXw1+ZVSWqM73d
         UhpvXaPpZFGKRDausMdfCO7zOzX0g47yhHJJvjjHFvotw9w9ilaeSlYaOVOUqjC5YV1L
         D9RL/GzBDmX3VOJul5k8V/1wM4T/9RS9WwUpdubFrTksxhdA9k4VOClTIHsbr2C5P7r/
         Tx2rIm6bGyg+ZPdO9khDVhi79to3yQWW0ZAAJxWtXRuwEwdJsai2Vw4I89w2UUVwpxg9
         5YT0PAx4BMpEyQtuziPbAg06E2C2CNBUrW2N/C0J6NnzF8vUSbplZEPQBfPUgiSQc28W
         A0eg==
X-Gm-Message-State: AOJu0Yy0gfFLviYBA/wmmmlK+9PPUQ4xS6Rev/+5AiuDh3WYCGKBDKXr
	JYORYPEp9ma96u9uXdHx+PYjw1QPlEBe+y/qGUvEmeKMJCQMbQE+VVzMLKlQZnyPWo+c03Opp5M
	whELoa692q+aT79uXAJDkfNTR7kGmNoZMuy/JPNMziuIsr6jWfnKvdC8Yac0WzfADZQjHFaOSWh
	p642gYkjqj
X-Gm-Gg: Acq92OFB4OyWes4qmwpzWnb5SlPydIKYG6JeiKYYTswvbo02P8q1XILLg0P8y/+GUlT
	LsXlMEjxCz6ZCP4b1uUU+YjT4PGUwhi4hOAyKw0zHFCzx0dSiiAQ0Br8bJgnCZyLqxGK+/NXQ1/
	CdDf/4TLg/5nTk8+H/ie8+SSspNfkH89YuqzonEww3Y1r1Fh4wrIAy5AfIpkKz/OAHCvt3+/cMF
	e3jc0YarSkco6K4e9WZ/rGKmrXoaHHxhKVTITCUwyXAqACDMs8tSG4tV5s3FlNas0dBwtvimtBi
	oD+15s6SG0bozixlpw6rkaXHtgJbdmgC23tH++wPPfYuA4oGTP+znLWYSzSOnNz5eazuW9mbjhv
	fgs3D+ZwgsK4xouCoy5nwfdPAZeMM55GbxYpGyPOjEGvqpMk50aPNKsIfVrSt0ZEjd65Qy1gDu/
	Tfs8aTD7p61EghZzWTIoEcLhMBhQ==
X-Received: by 2002:a05:600c:37ca:b0:489:1b10:d896 with SMTP id 5b1f17b1804b1-48fe59af198mr59725015e9.0.1778850517824;
        Fri, 15 May 2026 06:08:37 -0700 (PDT)
X-Received: by 2002:a05:600c:37ca:b0:489:1b10:d896 with SMTP id 5b1f17b1804b1-48fe59af198mr59724095e9.0.1778850517152;
        Fri, 15 May 2026 06:08:37 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed2ffdfsm13109391f8f.15.2026.05.15.06.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:08:36 -0700 (PDT)
Message-ID: <9afb6ae43ebde1308eab97a8e8025d4ab5d6da45.camel@redhat.com>
Subject: Re: [RFC PATCH v2 08/10] rv/tlob: add tlob hybrid automaton monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 15 May 2026 15:08:35 +0200
In-Reply-To: <fe5ed6a9a0a911e6ec74dc06c453786a2c4fb6d1.1778522945.git.wen.yang@linux.dev>
References: <cover.1778522945.git.wen.yang@linux.dev>
	 <fe5ed6a9a0a911e6ec74dc06c453786a2c4fb6d1.1778522945.git.wen.yang@linux.dev>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: poPfAvK8Vlyza3wpofA4M79qC4j_thQ1C5cIYvJZRLM_1778850518
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-05-12 at 02:24 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> diff --git a/Documentation/trace/rv/monitor_tlob.rst
> b/Documentation/trace/rv/monitor_tlob.rst
> new file mode 100644
> index 000000000000..91b592630b3f
> --- /dev/null
> +++ b/Documentation/trace/rv/monitor_tlob.rst
> +Usage
> +-----
> +
> +tracefs interface (uprobe-based external monitoring)
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The ``monitor`` tracefs file instruments an unmodified binary via uprobe=
s.
> +The format follows the ftrace ``uprobe_events`` convention (``PATH:OFFSE=
T``
> +for the probe location, ``key=3Dvalue`` for configuration parameters)::
> +
> +=C2=A0 p PATH:OFFSET_START OFFSET_STOP threshold=3DUS
> +
> +The uprobe at ``OFFSET_START`` fires ``tlob_start_task()``; the uprobe a=
t
> +``OFFSET_STOP`` fires ``tlob_stop_task()``.=C2=A0 Both offsets are ELF f=
ile
> +offsets of entry points in ``PATH``.=C2=A0 ``PATH`` may contain ``:``; t=
he last
> +``:`` in the ``PATH:OFFSET_START`` token is the separator.
> +
> +To remove a binding, use ``-PATH:OFFSET_START``::
> +
> +=C2=A0 echo 1 > /sys/kernel/tracing/rv/monitors/tlob/enable
> +
> +=C2=A0 echo "p /usr/bin/myapp:0x12a0 0x12f0 threshold=3D5000" \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > /sys/kernel/tracing/rv/monitors/tlob/mo=
nitor
> +
> +=C2=A0 # Remove a binding
> +=C2=A0 echo "-/usr/bin/myapp:0x12a0" >
> /sys/kernel/tracing/rv/monitors/tlob/monitor
> +
> +=C2=A0 # List registered bindings
> +=C2=A0 cat /sys/kernel/tracing/rv/monitors/tlob/monitor
> +
> +=C2=A0 # Read violations from the trace buffer
> +=C2=A0 cat /sys/kernel/tracing/trace
> +
> +ioctl self-instrumentation (/dev/rv)
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I'm not particularly fond of ioctls, they aren't that flexible and in
this way I don't really see an added value.

In short, you're adding this so a program could instrument itself using
ioctls instead of using uprobes, cannot the same thing be achieved using
uprobes alone, e.g. by registering a function address or the current
instruction pointer?

If you really cannot do it with uprobes alone, wouldn't a sysfs/tracefs fil=
e
achieve a similar purpose without much of the boilerplate code?

> +
> +``/dev/rv`` is a shared RV character device.=C2=A0 Before using any moni=
tor-
> specific
> +ioctl, the fd must be bound to a monitor via ``RV_IOCTL_BIND_MONITOR``.=
=C2=A0 Each
> +open fd has independent per-fd monitoring state::
> +
> +=C2=A0 int fd =3D open("/dev/rv", O_RDWR);
> +
> +=C2=A0 /* Bind this fd to the tlob monitor. */
> +=C2=A0 struct rv_bind_args bind =3D { .monitor_name =3D "tlob" };
> +=C2=A0 ioctl(fd, RV_IOCTL_BIND_MONITOR, &bind);
> +
> +=C2=A0 struct tlob_start_args args =3D {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .threshold_us =3D 50000,=C2=A0=C2=A0 /* 5=
0 ms in microseconds */
> +=C2=A0 };
> +=C2=A0 ioctl(fd, TLOB_IOCTL_TRACE_START, &args);
> +
> +=C2=A0 /* ... code path under observation ... */
> +
> +=C2=A0 int ret =3D ioctl(fd, TLOB_IOCTL_TRACE_STOP, NULL);
> +=C2=A0 /* ret =3D=3D 0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 within budget=C2=A0 */
> +=C2=A0 /* ret =3D=3D -EOVERFLOW: budget exceeded */
> +
> +=C2=A0 close(fd);
> +
> +``TRACE_STOP`` returns ``-EOVERFLOW`` whenever the budget was exceeded.
> +The HA timer calls ``da_monitor_reset()`` (storage remains); the
> +synchronous ``ha_cancel_timer_sync()`` in ``tlob_stop_task()`` ensures t=
he
> +callback has completed before checking ``da_monitoring()``.
> +
> +Violation events
> +~~~~~~~~~~~~~~~~

Since you are not documenting the detail_env_tlob tracepoint, is it
something really required?
It's deviating from the original RV purpose (run a model and spot
violations) by adding further accounting, I'm fine with that if there is a
documented need.
In such case I would at the very least document its usage (thought I'd
really like to be rid of it and let the curious user implement the
accounting themselves).
> +
> +Budget violations are always reported via the ``error_env_tlob`` RV
> +tracepoint (HA clock-invariant violation), regardless of which interface
> +triggered them::
> +
> +=C2=A0 cat /sys/kernel/tracing/trace
> +
> +To capture violations in a file::
> +
> +=C2=A0 trace-cmd record -e error_env_tlob &
> +=C2=A0 # ... run workload ...
> +=C2=A0 trace-cmd report
> +

This is standard tracepoints usage, there's nothing about tlob we should
document here. If you feel the existing RV documentation should expand
this subject, feel free to contribute there.

> +tracefs files
> +-------------
> +
> +The following files are created under
> +``/sys/kernel/tracing/rv/monitors/tlob/``:
> +
> +``enable`` (rw)
> +=C2=A0 Write ``1`` to enable the monitor; write ``0`` to disable it.
> +
> +``desc`` (ro)
> +=C2=A0 Human-readable description of the monitor.

Same here, standard RV.

> +
> +``monitor`` (rw)
> +=C2=A0 Write ``p PATH:OFFSET_START OFFSET_STOP threshold=3DUS``
> +=C2=A0 to bind two entry uprobes.=C2=A0 Write ``-PATH:OFFSET_START`` to =
remove a
> +=C2=A0 binding.=C2=A0 Read to list registered bindings in the same forma=
t.

And this is duplicating what mentioned above about uprobes, isn't it?

> +
> +Kernel API
> +----------
> +
> +.. kernel-doc:: kernel/trace/rv/monitors/tlob/tlob.c
> +=C2=A0=C2=A0 :functions: tlob_start_task tlob_stop_task
> +
> +``tlob_start_task(task, threshold_us)``
> +=C2=A0 Begin monitoring *task* with a total latency budget of *threshold=
_us*
> +=C2=A0 microseconds.=C2=A0 Allocates per-task state, sets initial DA sta=
te to
> +=C2=A0 ``running``, resets ``clk_elapsed``, and arms the HA budget timer=
.
> +=C2=A0 Returns 0, -ENODEV (monitor disabled), -ERANGE (zero threshold),
> +=C2=A0 -EALREADY (already monitoring), -ENOSPC (at capacity), or -ENOMEM=
.
> +
> +``tlob_stop_task(task)``
> +=C2=A0 Stop monitoring *task*.=C2=A0 Synchronously cancels the HA timer =
via
> +=C2=A0 ``ha_cancel_timer_sync()``, checks ``da_monitoring()`` to determi=
ne
> outcome.
> +=C2=A0 Returns 0 (clean stop, within budget), -EOVERFLOW (budget was exc=
eeded),
> +=C2=A0 -ESRCH (not monitored), or -EAGAIN (concurrent stop racing).
> +

Is kernel code going to use this API? RV monitors are meant to be
enabled by userspace. What's the use-case here?

> +Design notes
> +------------
> +
> +State transitions are driven by two tracepoints:
> +
> +- ``sched_switch``: ``prev_state =3D=3D 0`` (``TASK_RUNNING``, preempted=
,
> +=C2=A0 stays on runqueue) =E2=86=92 running=E2=86=92waiting; ``prev_stat=
e !=3D 0`` (voluntarily
> +=C2=A0 blocked, leaves runqueue) =E2=86=92 running=E2=86=92sleeping; ``n=
ext`` pointer =E2=86=92
> +=C2=A0 waiting=E2=86=92running.
> +- ``sched_wakeup``: task moves back onto the runqueue =E2=86=92 sleeping=
=E2=86=92waiting.
> +
> +No ``waiting =E2=86=92 sleeping`` edge exists because a task can only bl=
ock
> +itself while executing on CPU.=C2=A0 ``try_to_wake_up()`` is also a no-o=
p
> +when ``__state =3D=3D TASK_RUNNING``, so ``sched_wakeup`` never fires wh=
ile
> +the task is in ``waiting`` state.

That's probably a bit too detailed for this page.
If you really want this information somewhere couldn't it stay in the
code?

Thanks,
Gabriele


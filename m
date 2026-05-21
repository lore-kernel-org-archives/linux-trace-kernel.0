Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1F819E7F7
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 06:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779345609; cv=none; b=E62lxogD8EaRliVxi0j2LTg8mJRZaMX0foWeLULvajCepzvP7ZeX6vHWVsYtfFptsxyA4CwvglieBr+erfwR9fCU3Kfh/FKjLMaDdbqj4NXQORcFNUTezOdl0AB7veeDngVdtrFKyQ0so8agq+94Nddgifrby1UaH9hzdXQ0rc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779345609; c=relaxed/simple;
	bh=oNZ9hEea3P9r6IT6wbbFKp9qYUhN+Gt4HCG9xYRoo3U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kI2y+K4AGIOxlkdeCDO0iP9E6NldyPSF5GorfRnscCx8hXtThskL/wOsbTApiDial6TLIPtmLzc7ZWvm32kZRnhKfo1IQ6MxBnlCsf5ogvCxky1nKOU8QjYdMFokgYHZybZrIPR8OfJNDx3cB7U0ZqhCOYzJXjHrW4/Iw9QFxcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OMNMArhG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OMNMArhG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779345606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YeieAjXN+COZ713WsFN7Iuc/aokCmB3d3GKl+QD6YHs=;
	b=OMNMArhGN1JtpP9ka8gUCAbHRgB5MtUQKbjTzFpttt7apy3QUFgaAzbnWHu1JdlLR7szLI
	0F0f3hW+VJDHeCkiSVy0x9X8WLK4pJeEyuun5TTS1hgJLZOPZ173s07fv7prwofDJIoA1H
	hNWVYHBvHz7rbUclGp+TSJTyUS+rXA8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-xRbovw90MVq52ejhZ6ZI1Q-1; Thu, 21 May 2026 02:40:05 -0400
X-MC-Unique: xRbovw90MVq52ejhZ6ZI1Q-1
X-Mimecast-MFC-AGG-ID: xRbovw90MVq52ejhZ6ZI1Q_1779345604
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4411a36715dso3740674f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 23:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779345604; x=1779950404;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pKCaTYqEYGK/9+YqKBNGD4rlt1kgVp7hhuTufJu49DQ=;
        b=Ip99c8MhAdhPMUU5nRnmeFj1JedDWkvr9psShy0eOcCNeIbYOi4POv9zEya6twLsxr
         Ib4/OVdiSAW97CoaPuPVgdOpSkzRvVxmpYV3WOhq1G5haU2PDggFTFMcUqDt4KXmd0vL
         LEvtF/1DU9R+zq3VMBMg8NTygiPSd2HO9FdEyXThGkPGoVg6+L5xiH6AeGhnJMpRqdkg
         cx/JyuO8O8lRaepZ9lNuXLm+pI+gjyoxYFrXrP2yjNMYmJDGkq7u0zw+PLR6qlXo45Ji
         0BZPb5PXHWOwksJncEdOxHnvwE6M0h9h+EPVgc0NsP9nWyNDLSJDg9RXV6hPMRHVUhQI
         2Wmg==
X-Forwarded-Encrypted: i=1; AFNElJ8JbliBdgNe+xxqQVB8bklmjwRbQYx5+kaiJjspBGGm0ZJSsN2qXzAWT81eoJ5SPffchMhZ0MAeAlGiM/O3rxuCODk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD+hjYIm00KN3cyuJMGyOPtwNpPrymKXUdSA7VvamfgblpJXVb
	lFALLbI0fPXhodX468nQuX1JDa/CJd8gYG6ps1UU4ndWbpcdHtA+4e9J8kuoR2ddV4iBMle09qE
	67U1P1+cF9uzAkmrCZ4t7jW0+jqypoj8JIbBsYzKLtnwQJgvzWQfKDoJktgXobkFLb66YNMoMwg
	==
X-Gm-Gg: Acq92OF+tnnuZOJ7X+XldNR4L9Pb/GzXDczTDs55uUROT4Qn+8Vd84q1Ij5z69AaLOs
	ZCtmKF+yvJPxJgv4pv89JyO0JiKSRRy8MWybwq7gO+6I8ffuMseD0J3F57nOC2JKyZuxhLUEnxF
	7hS5VfmrIFg2yCSjRObnBUa3UFFx01KpLgw4JjTJKPRkT6qCAUy2KF4Kx2UZDL+kG+yi0iHk9Rs
	ohKd/h4J6PCRGU71pJhLD6uJXJt7wzqZZxv3s7jmoyMlcYDPqpe5ssNjxpfV0Ss5Yci2Fkbp31p
	lxU/2vjMFvqRNi+oTRBRUj4X02t5dIBwZA7ESNLNo+CnkPt5UT1Bu3+v1kLeziTG8Lsv/DoAnNp
	w7kOaf/XmPfWYS0iQawbvL2HDXe+0CnYGR05m2PIhpK9Oj3Rrx/Om3BRgkEHqbniLHVcVjX0ZDr
	3OWC/2+QEVfunynb0=
X-Received: by 2002:a05:6000:25e8:b0:441:1cf9:4f06 with SMTP id ffacd0b85a97d-45ea410d5a8mr2013982f8f.31.1779345602949;
        Wed, 20 May 2026 23:40:02 -0700 (PDT)
X-Received: by 2002:a05:6000:25e8:b0:441:1cf9:4f06 with SMTP id ffacd0b85a97d-45ea410d5a8mr2013868f8f.31.1779345602103;
        Wed, 20 May 2026 23:40:02 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa7dab28sm352092f8f.12.2026.05.20.23.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 23:40:01 -0700 (PDT)
Message-ID: <fb0c1a36b4e773c65591bde2ef31c48711d30163.camel@redhat.com>
Subject: Re: [PATCH 3/3] rv/rtapp: Add wakeup monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Date: Thu, 21 May 2026 08:40:00 +0200
In-Reply-To: <bf775af281cb1540d51ac9a8531b45e723d73226.1779176466.git.namcao@linutronix.de>
References: <cover.1779176466.git.namcao@linutronix.de>
	 <bf775af281cb1540d51ac9a8531b45e723d73226.1779176466.git.namcao@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: iYlGHr_2c8TsrEmCuV2rb_UlcKORH01R33V-dsHyUk4_1779345604
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-05-19 at 09:49 +0200, Nam Cao wrote:
> Add a wakeup monitor to detect a lower-priority task waking up a
> higher-priority task.
>=20
> The rtapp/sleep monitor already detects this. However, that monitor
> triggers an error in the context of the woken task and user only gets the
> stacktrace of that task. It is also extremely useful to get the stacktrac=
e
> of the waking task, which this monitor offers. In other words, this monit=
or
> complements the rtapp/sleep monitor.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Looks neat, so the idea here is that we are looking at the same events
sleep would react for, just from a different perspective, so it does
make sense to run them both together.

You may want to set

  depends on RV_PER_TASK_MONITORS >=3D 3

in rtapp/Kconfig. Though if we plan to add more per-task monitors we may
need to find a better solution.

> diff --git a/tools/verification/models/rtapp/wakeup.ltl
> b/tools/verification/models/rtapp/wakeup.ltl
> new file mode 100644
> index 000000000000..a5d63ca0811a
> --- /dev/null
> +++ b/tools/verification/models/rtapp/wakeup.ltl
> @@ -0,0 +1,5 @@
> +RULE =3D always (((RT and USER_THREAD) imply
> +=09=09(not (WOKEN_BY_LOWER_PRIO or WOKEN_BY_SOFTIRQ)) or
> ALLOWLIST))
> +
> +ALLOWLIST =3D BLOCK_ON_RT_MUTEX
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 or FUTEX_LOCK_PI

So here the events and atoms are similar to the ones in sleep, but since
we fail on the waking event, we are going to see it from the perspective
of the waker task, right?

But are those really equivalent? Why do we do RT and USER_THREAD here
while there is a much more nuanced set of conditions in sleep?

If I understand it correctly, sleep can monitor some kernel threads but
this monitor does not, is there a reason for that? Are we just not
interested in the waker for kernel threads?

> diff --git a/kernel/trace/rv/monitors/wakeup/Kconfig
> b/kernel/trace/rv/monitors/wakeup/Kconfig
> new file mode 100644
> index 000000000000..3cf11c5cd5f7
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/wakeup/Kconfig
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +config RV_MON_WAKEUP
> +=09depends on RV
> +=09depends on RV_MON_RTAPP
> +=09depends on HAVE_SYSCALL_TRACEPOINTS
> +=09select TRACE_IRQFLAGS
> +=09default y
> +=09select LTL_MON_EVENTS_ID
> +=09bool "wakeup monitor"
> +=09help
> +=09=C2=A0 This monitor detects a lower-priority task waking up a
> +=09=C2=A0 higher-priority task. The RV_MON_SLEEP monitor already
> +=09=C2=A0 detects this case, but this monitor detects in the context
> +=09=C2=A0 of the waking task instead. This and RV_MON_SLEEP can be
> +=09=C2=A0 enabled together to get the stacktrace of both the waking
> +=09=C2=A0 task and the woken task.

I'm not sure if there is any better terminology, but "waking" task makes
me think of the task that is about to be woken, though it can mean also
that task that is waking another (what you probably mean here).

What about using the waker/wakee terminology?

I see the kernel (events/sched.h) uses waking as well, but it says
waking context (which a bit clearer to me than waking task).
May be worth running it through an LLM which can produce more
English-native unambiguous wording, or maybe I'm just flipping..

Also please document it in Documentation/trace/rv/monitor_rtapp.rst

Thanks,
Gabriele


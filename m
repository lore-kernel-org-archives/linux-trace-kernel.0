Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6A329E0E9
	for <linux-trace-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753948044; cv=none; b=F8+Tf2TssyBoDv5BSC0YxZie+EsN7Y0c8KXtXixiPqRXL8SOy0tJzAf65Ir269skZzyaY0MHF5qrxoK2C0NNmIL4zpX0YhP1ECPs79GKuchC2l0QvkP/e9pN5GRFZROVP72Yol64ZceRkKRtZdtwRfWJh3WlsjHHIMouGFu0kMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753948044; c=relaxed/simple;
	bh=bCuat1r2a3X98MMKvP9jNXv5jQkuIpbXWWUeImNIizg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5AuKYjh1d9dKg6X5S9Mkw6sY9cSSRXJHZRyBvhTcylFjmejfItTmy+iO64JGYce8bPVKfxhvFPgVksH4LLd/KA/glt8kH/4ltjD7iJUBPP/9OaxenGoNXE3+eqGJdnf+7d3AgTgSnE8JcFFdGQVWUo7Im6CmqX4F01JuOQBYIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EIWEEvjX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EIWEEvjX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753948040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bCuat1r2a3X98MMKvP9jNXv5jQkuIpbXWWUeImNIizg=;
	b=EIWEEvjXIW8etgjnEaiKJUpAr9tnUgD6hOE+6QPhZQKdhfEpDNktLUHAO+/xMhvBtb0YRJ
	5jy+k8qubXOjtbex71PB5M9qwFmlOsZgDAcr1tIeyfgR3FKH81x/wXmHp/E9VdbQ/ZmuJ3
	d+xWHOGrDLHlI+pUY95PWBxLIn4cT+0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-tr7nGljCMSiTnK7EzjMisQ-1; Thu, 31 Jul 2025 03:47:16 -0400
X-MC-Unique: tr7nGljCMSiTnK7EzjMisQ-1
X-Mimecast-MFC-AGG-ID: tr7nGljCMSiTnK7EzjMisQ_1753948033
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-456267c79deso1355245e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 31 Jul 2025 00:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753948033; x=1754552833;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u4WTc+jWAbHGbFb5VbfFSzMl/4GvLeocQH3Zr49ewVE=;
        b=aydiTbytT9u4Irvvot3VEeeCzIBxawiFXm1h1Pz9OTrGts35N1wqK2bwjc9N+KiWEj
         YhsOd5MId7g1fWbM+d/VkImVKxO/hVqXq/bBB8YSJxZjF8Lhx2Eq9ewboIQO22/Jw8HG
         TN1n0rsU/tEa6SG00tPZa74158xdw16g0Hh4z/Z+JIZOOkomexuPl+XNcKlNR0ZEIiBe
         QhlsgfLD+oF1T8pQ7e7iIEzScpjNP9dnpJNXrkFOiNhS45Fs/tGMH5eokUtbtzQc35z0
         A1Rtze+WyeTfhLBHvcgt56FPMVF00roylpXXBsjllBrMrzWSQJk9CA5bHHT6cJJklxcR
         PaPg==
X-Forwarded-Encrypted: i=1; AJvYcCWINw08/72L8lESriSLfYrc1j0tETBgS3MMHGoSl4OHgH4Q4RKXf3F1kEPc2gV99RijtZty8J11cc4QLR1KwaS+2YU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxXdtLq0otDwny1qufJjwhsQg59CcQPao9+z63CAcmnnrejJa1
	g4OBrhxGdqwTH3g5oGZFg4sr+/SNgLOMASHy5flTINg62XE7qM06FsXT92RUbHTscKxu4LTJ/lX
	C9LOA5S1TuEtyXfzniMhtsgtJN8GRyVfqeVZSuMLjJG3XikOdiKSUUaTflxAvMy12po7okgixvA
	==
X-Gm-Gg: ASbGncsLwNnfbyJEphn6ra4my5gnyUDrEtmH9xGfo2v7g57o3oz7lahGEEHjdh68b+k
	1jrS1kBzFSHqQPo0CWxQsc6puXgFdNAj81EWKFOSLw6bbfDw4Tw0TAyRHoqsZrM1C7AEGnDey5H
	Q4LlV8PJL53PksotEvRavRBx+8ITUKktUT/jBqtdk2Ov2qxDNYaHMByRK6k0WRDRXMna9jvDcfw
	+77lgMXtQSQhD0VpEiBQEnhoZ3MPQ1idWzmk/iso12+js2FLVbpABoSYm2XeIzQ20kDN6bHtyHg
	Wh6WjSuYy9QVXNclrbX0Gin7y9S8qgpeHHzMhZE/JUMDS9LalkyOVXdxzSEmOY4U5w==
X-Received: by 2002:a05:6000:2210:b0:3b7:8a03:4b6f with SMTP id ffacd0b85a97d-3b794ffe6cemr4815811f8f.29.1753948033119;
        Thu, 31 Jul 2025 00:47:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0VQ95ntO8SN9nuejm/0tmsYLQ70eiLWLUlihGZM4cQBz/RjxhjCLEWGFz2CqM4EEiVZW7yg==
X-Received: by 2002:a05:6000:2210:b0:3b7:8a03:4b6f with SMTP id ffacd0b85a97d-3b794ffe6cemr4815778f8f.29.1753948032655;
        Thu, 31 Jul 2025 00:47:12 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453c75sm1476735f8f.41.2025.07.31.00.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 00:47:12 -0700 (PDT)
Message-ID: <a78008bb05acae77f0572c3e5651cb2bceaaaf98.camel@redhat.com>
Subject: Re: [PATCH 5/5] rv: Add rts monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, 	linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann	 <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman	 <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>
Date: Thu, 31 Jul 2025 09:47:10 +0200
In-Reply-To: <20834b8fcd4dfe75642cec2097e29f4c636a33fb.1753879295.git.namcao@linutronix.de>
References: <cover.1753879295.git.namcao@linutronix.de>
	 <20834b8fcd4dfe75642cec2097e29f4c636a33fb.1753879295.git.namcao@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: 3xwxqKRIvfXOXC91eQxRDUIFs1NB1kZIJbu5vpzgAvU_1753948033
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-07-30 at 14:45 +0200, Nam Cao wrote:
> Add "real-time scheduling" monitor, which validates that SCHED_RR and
> SCHED_FIFO tasks are scheduled before tasks with normal and
> extensible
> scheduling policies
>=20

Looks a very interesting monitor!
A few questions:

I assume this works with rt-throttle because it implies a dequeue,
right?
And you probably won't see that without explicit tracepoints..

> +=09/*
> +=09 * This may not be accurate, there may be enqueued RT tasks.
> But
> that's
> +=09 * okay, the worst we get is a false negative. It will be
> accurate
> as
> +=09 * soon as the CPU no longer has any queued RT task.
> +=09 */
> +=09ltl_atom_set(mon, LTL_RT_TASK_ENQUEUED, false);
>=20

As far as I understand here the monitor would just miss RT tasks
already running but would perfectly enforce the ones starting after
initialisation, right?

> +RULE =3D always (RT_TASK_ENQUEUED imply SCHEDULE_RT_NEXT)
> +
> +SCHEDULE_RT_NEXT =3D (not SCHED_SWITCH) until (SCHED_SWITCH_RT or
> EXCEPTIONS)
> +
> +EXCEPTIONS =3D SCHED_SWITCH_DL or not RT_TASK_ENQUEUED

This monitor allows non-RT tasks to run indefinitely before the switch,
only when it happens, RT must run, right?
Not sure you can do much about it though. (without falling into the
need resched rabbithole I was trying to untangle)

Thanks,
Gabriele


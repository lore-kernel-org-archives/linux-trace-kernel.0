Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989922ED14B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760437334; cv=none; b=V7Yi3eZLZjnb2jTpzwOFlpXrONQ0m+/E7TbeGnTVloG6SCXEjE0J6KYXWimbYGDlW/MhX1UVwntbx9d69v0fmiYp1e3vFGb9E2o+7LBU6idyBq8MaCQ4yje8XHJP+QBETfSt3AhMX7sHg1yy/Ija0jl2Qf8NpVeUFBd5bJifu1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760437334; c=relaxed/simple;
	bh=8L1RGzt7soJt9IKppmbflYl6y+ueOV8Q0zaTAUUOegE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B2red/73hLoTxveK7spk9J4QKPyKTbUn+JpjKQFaGABjpCRypHdQd4/TbqMG6esgwGGcNGYZqXPjOFJ/CGQ0RSbv1dfAiQVJ2e4WAIf90dcgJ/8VlXs7rDXztOStDeh3naWI8yH74b0D/31MIsNev0W/F1XMQ+x5yss7xF7S9x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bDz9KSu+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bDz9KSu+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760437331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8L1RGzt7soJt9IKppmbflYl6y+ueOV8Q0zaTAUUOegE=;
	b=bDz9KSu+3wrJj7urkwROd88Off118U2OGrVhwUMDjU8RN1P7zp7PpqK8zGJUHy6YdToHza
	tQjQEOEtz4tTTtYyQb0PizzdzlP3QeTjS+sBwGv64UktrbYhQ+etMOyBWh4QBzCSKUnNHj
	vqeXoAv9ddFzYrf80vWmg7nSi7y+te4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-gQeN9eqwNK6BWRhr92ZpTQ-1; Tue, 14 Oct 2025 06:22:09 -0400
X-MC-Unique: gQeN9eqwNK6BWRhr92ZpTQ-1
X-Mimecast-MFC-AGG-ID: gQeN9eqwNK6BWRhr92ZpTQ_1760437329
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ee130237e1so2642660f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:22:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760437329; x=1761042129;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8L1RGzt7soJt9IKppmbflYl6y+ueOV8Q0zaTAUUOegE=;
        b=G3PCNJFvg62SCfd8a9/fHJZTTJug4fNscdbE35k3rFPeOa6k/Iq/8bbQCvF32oIndF
         p2qXWaTD7UAn7Gqqs72GfuxXVutqPEOPcX84Ci5uBiYDnZCFwc9rJ9Et5oHPcS/E4Z7L
         Rz8LUexQNQaLaQEq8T681XsJDKTBlxSZkeEbUoOpV1Ff18mh+UqtztC+p+FW1I/I1CO4
         dDk7V5tZl1h2GGHJvOOPo42VyVJ8aZd1nN+B6v+F+3XGjoPlMqRtyOFCki5HavpUFnEa
         r/+lz4akaf8RgtF7NT1DfYfIU+ssd7qliMXuBKMhWG77+BQg9l2RsXsKWWVNJt9e9N+4
         l5FQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfcTRI6VEVBgRgk52IP3vbONaEO8QyZ6MOchOmU7Wzo+O7ul/k3SI5Kkwi5bECJ9X0I4uf96QsJLp4GJS52RBCAM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRjrKXH2G5y3AIx9Jzl4JXjQPSbHpl6QXXSc3Hpjq6T+H/jH+n
	rM+1Ia1uK1RqtBG/jUNSFeLOD4EPKmS018mftYzeNnx++kFOUq5XpSGPi89IhXcSVm8agPCXicq
	tC4qIWE1SkkeHp3xmB1+s6IFabZxcubqp1KIet4LZenRRcawyzjRtIeTFG1S0tv0JLteDqTkFMQ
	==
X-Gm-Gg: ASbGncvOYfDhiD7fzr3+GPn8q6Pu1UbMpWbSsm39dHzFdMhbJVN1C3/MYWM22tkv/fG
	pfA0EXUFOdtB3h0cnRRyyQme/DYUb6qNnOnm6UkdRPY5U/zRq0EIJows3zhNswNdzNxy7lcAN35
	z+76yuu4vjfScgBnXQmw6TbByHokCJpctYKZm4HlGTzh/35TR+6t9L+GkivjpIjvt4CJSuIF4pU
	Zoq2GJ7VTurewUewFQ1d54XoOiEo/Z4I2ZguBjTfy95I4asgaIgR9v/tFgZ7O9nPusaQiYW5ITl
	7sneSxwOF/nMQh6l7bbHafCAvt32Y5ZQD5zGWi1eCiZOtzgjAtJncGRhiBqfDEyFMg==
X-Received: by 2002:a05:6000:2c0c:b0:3f0:2ab8:710f with SMTP id ffacd0b85a97d-42666ac39afmr12909543f8f.8.1760437328624;
        Tue, 14 Oct 2025 03:22:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI8UJI60MTklfSrxiStm/XC5egkna5mdYCP8ifnCsQpxVWUiBUgX/rrIY4dwlcC95NJb48vQ==
X-Received: by 2002:a05:6000:2c0c:b0:3f0:2ab8:710f with SMTP id ffacd0b85a97d-42666ac39afmr12909529f8f.8.1760437328184;
        Tue, 14 Oct 2025 03:22:08 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e1284sm22705271f8f.45.2025.10.14.03.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:22:07 -0700 (PDT)
Message-ID: <4d0467cf03f4b818a40344b6ec8142582c26a876.camel@redhat.com>
Subject: Re: [PATCH 3/3] rv: Add explicit lockdep context for reactors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, 
 Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 14 Oct 2025 12:22:06 +0200
In-Reply-To: <20251014094206-80eb5d6c-e4dd-4704-a40a-e2d0461c2185@linutronix.de>
References: <20251014-rv-lockdep-v1-0-0b9e51919ea8@linutronix.de>
	 <20251014-rv-lockdep-v1-3-0b9e51919ea8@linutronix.de>
	 <87qzv6szku.fsf@yellow.woof>
	 <20251014094206-80eb5d6c-e4dd-4704-a40a-e2d0461c2185@linutronix.de>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hfKmOH_lou9yNN6zhqU-xhRHUJelMhX7J_mcU8bdvbg_1760437329
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-10-14 at 11:46 +0200, Thomas Wei=C3=9Fschuh wrote:
> On Tue, Oct 14, 2025 at 09:38:09AM +0200, Nam Cao wrote:
> > The reactors are invoked in tracepoints' handlers, thus they must not
> > trigger another tracepoint, otherwise we may be stuck in an infinite lo=
op.
> > (this is why preempt_enable_notrace() exists alongside preempt_enable()=
).
>=20
> Sounds reasonable. However today not even the printk reactor satisfies th=
is
> rule as it transitively calls trace_console().

That's a valid concern, I assume it would become a problem also if we wante=
d to
use locks inside event handlers, as it was discussed some time ago to bette=
r
handle concurrency.

> > I'm not familiar with the internal lockdep. But I think these would
> > trigger trace_lock_acquire() and trace_lock_release().
>=20
> Indeed. Right now no monitor attaches to those tracepoints. We could
> prevent monitors from attaching to certain "well-known" tracepoints.
> But then we still need to manually track which those are, which is ugly.
> Or we move the invocation of the reactor to a workqueue/task_work.

I'm afraid also workqueues might open a rabbit-hole (waking up a task fight=
s
with locks in many scheduling tracepoints).
At a quick glance task_works also do some IPI/wakeups that are traced.
If I get it correctly we are looking for something absolutely lock-free/tra=
ce-
free, I can't really think of much at the moment, maybe abusing RCU callbac=
ks
but those would have their set of problems too.

As much as it might be interesting to write monitors on lockdep tracepoints=
,
this seems challenging.

We could opt for a foolproof Kconfig solution and prevent reactors if lockd=
ep is
active (leaving only the error tracepoints that are hopefully still safe).

Gabriele


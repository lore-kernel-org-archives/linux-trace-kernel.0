Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54478379EE4
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Mar 2026 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772703179; cv=none; b=GF/kcX4d19HQwtT8WcIYJoTkWUTCM7mjhwuC45+Y1E3lkqMT9hBuRrEbSLmWCTUjXn0tdngXzLT54BcCjfw9JxNgQQFrEE0rsE8z7NjP9Ry3MOwoyP5ZtJiqDq9GyTjiOcU7YMvajkZFC4QFyGZgxLMLAVAqbQjNUY89A/f3vk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772703179; c=relaxed/simple;
	bh=9PYOb+VpS5iduMsjRQAstf3pfoEPKqF4vCLzhZxYmzk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N4vzJM/Pyg7YInVX9AaO/LLi3n5USbNWnIk/68ilySzvfltllLi/xyk9tHAu+8bDqBI02gjuaAcGdikLXsNn8bzvggTcUw6ySLMQQLRz3jPo+Dy+m/QE00FeBk6kE6xTGMMN5CIEWT1iB4t5oopgjHYSdIS/SBrWH6uMuthq6m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcjOgqKa; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcjOgqKa"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-483770e0b25so66224845e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Mar 2026 01:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772703177; x=1773307977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9Wh14Cu8HPwYp2aF4AzVWASloPNWhH5O37QCidUK+E=;
        b=mcjOgqKak919W21aNiOfDWp3RExh27bIzdoIxIC4k58wQM4+b6YOrFljmyeqK/3Snd
         UyoDhIFVRObN6Fp1wc8I05j/16qrFKwbiU7oK33CfvMkOVYlLBP6vRSb7yybQLun09rz
         Nw6J8yJosxvThsVFKfxDV7uWnObxA+CKDCC0iU70qjfRFs7M7U0rhbSsn6+6Swxohih1
         8bKSxJI++wSK73E++jRfvZ63EH/8TyVexW3a5qqyhbO2oMlPcZ7+odbc/0E2pDbFHhlF
         fxdz+abfRQ548SA2fp4i4i6VkDAt2etu7DMYwVozDBZRJLsj79/5R0WQDEdplHcT8Hfo
         zZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772703177; x=1773307977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k9Wh14Cu8HPwYp2aF4AzVWASloPNWhH5O37QCidUK+E=;
        b=ILkac8/lsIT37dZqOW/GKTQFec2HqgwAoH/zVl7PLECOqIpPhEEuPNE2jpzZxi7Vwl
         nLBWYrd7XGzEc1pCpVFDcUTuPtwCwE75jajeNIxeMtNSxBw0hfunfR+tJ+cfP51RIZfV
         cBNP5C6E/BMLEeQH3yxYlIMisUX67FncgG5HinYFHm/+8/okhL8cL6qpiYdn7E0Bm8tw
         XIln4CA5TeIqLBTGnQn0uYAgafTGBkG9LA3iwhu3PpnSaZt+3oNbE9u2oBlM40FcrTJP
         uHwYcWj+MfYo3kXsjD+HSxllhCT+xq0eVKLqvkArihkPkyHXTwd09uWsq3NOkVx8Kk45
         zxjw==
X-Forwarded-Encrypted: i=1; AJvYcCWt1nHLWjwPNfVzr4mLs9gF3pH/xNOwVxymkRx8J86nQTw9nPaYW0Kft/ufd7NyD/XpU+ZxYUYEvOw2AZdly/Kjilc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeT4+0KZXidjflUwHtcB8u25RjUOA06J7AlyvxfLBEU1NI67Rg
	T427CNcPF8bUyZ4mrP5Cd8f9z3fxzFLUcdm+/nTHc/TxK2xDzetCulJU
X-Gm-Gg: ATEYQzwf76LRAI46noVWpPq+S5Myu7Oc7hmxZNzUtDYnSBocvKKQpydYOF+XvQb2u5h
	pshqIQ9BrPI39a0yOLWRQONK8tUVs8Mihi4VVZ84bTajZ6J/l70pIsK6zqIC7JQCSvjldKmPiDZ
	K1tkwrFo7CMJ6i27IOIsc1qgyBfakvATL+pLS4NTbaPoq34/veNUeEJ1WehXPJZI/QNx2m8nQil
	sbioNAyhxdWQAu+ETD31q3MtlifFnhIuABrQZD9UOhu2M9dO14YnSzzGlGivxaSAQeNGWI/q53O
	Am6l+35tU7EFgRoMMoPAw47WsH3NXDvW0P1SEbgXCHWsl3Q21sm8ORutCmje6sGvVRyfsRnuGmA
	A8MwObyWv9zOqffiemYP63tU1bCdwTw6TcZuhgJ/YGhEOMcGbd8es+a0jmHhqhl5f/kjcIZVypE
	1fpsM+ErBt6CF5Xx3C5m5s8+UV8pw3wkKIY8lwShw268K5tNgHk8Vh4+MX6VsnVJV6qRMpzVd0b
	AY=
X-Received: by 2002:a05:600c:64ce:b0:475:da1a:53f9 with SMTP id 5b1f17b1804b1-4851985aa88mr86271115e9.14.1772703176565;
        Thu, 05 Mar 2026 01:32:56 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fb27a20sm63043525e9.9.2026.03.05.01.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 01:32:56 -0800 (PST)
Date: Thu, 5 Mar 2026 09:32:54 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Waiman Long <longman@redhat.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>,
 mingo@redhat.com, will@kernel.org, boqun@kernel.org, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
Message-ID: <20260305093254.61facfb6@pumpkin>
In-Reply-To: <748e8e0d-5164-4c8a-9bb9-110874c5daa0@redhat.com>
References: <20260304074650.58165-1-laoar.shao@gmail.com>
	<20260304074650.58165-2-laoar.shao@gmail.com>
	<20260304090249.GN606826@noisy.programming.kicks-ass.net>
	<20260304095415.4d5f2528@pumpkin>
	<20260304155742.7b4de2d1@gandalf.local.home>
	<20260304214447.3e5817ea@pumpkin>
	<CALOAHbCOynnRdc8JkNJHb-nyoerrz0K5GUhnD8OR2hv4x==5LA@mail.gmail.com>
	<20260304212802.458b878e@fedora>
	<CALOAHbBA643_QOsnTmrfjKE71hSa+v1cToiELvGk+vjtcgJsxg@mail.gmail.com>
	<20260304220019.3efa12ab@robin>
	<CALOAHbA4Dtc3cXs2JiQ=kxES3kT+Acb=amUxkOvQ22fns-Mqgw@mail.gmail.com>
	<748e8e0d-5164-4c8a-9bb9-110874c5daa0@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Mar 2026 23:30:40 -0500
Waiman Long <longman@redhat.com> wrote:

> On 3/4/26 10:08 PM, Yafang Shao wrote:
> > On Thu, Mar 5, 2026 at 11:00=E2=80=AFAM Steven Rostedt <rostedt@goodmis=
.org> wrote: =20
> >> On Thu, 5 Mar 2026 10:33:00 +0800
> >> Yafang Shao <laoar.shao@gmail.com> wrote:
> >> =20
> >>> Other tools may also read available_filter_functions, requiring each
> >>> one to be patched individually to avoid this flaw=E2=80=94a clearly
> >>> impractical solution. =20
> >> What exactly is the issue? =20
> > It makes no sense to spin unnecessarily when it can be avoided. We
> > continuously improve the kernel to do the right thing=E2=80=94and unnec=
essary
> > spinning is certainly not the right thing.
> > =20
> >> If a task does a while 1 in user space, it
> >> wouldn't be much different. =20
> > The while loop in user space performs actual work, whereas useless
> > spinning does nothing but burn CPU cycles. My point is simple: if this
> > unnecessary spinning isn't already considered an issue, it should
> > be=E2=80=94it's something that clearly needs improvement. =20
>=20
> The whole point of optimistic spinning is to reduce the lock acquisition=
=20
> latency. If the waiter sleeps, the unlock operation will have to wake up=
=20
> the waiter which can have a variable latency depending on how busy the=20
> system is at the time. Yes, it is burning CPU cycles while spinning,=20
> Most workloads will gain performance with this optimistic spinning=20
> feature. You do have a point that for system monitoring tools that=20
> observe the system behavior, they shouldn't burn that much CPU times=20
> that affect performance of real workload that the tools are monitoring.
>=20
> BTW, you should expand the commit log of patch 1 to include the=20
> rationale of why we should add this feature to mutex as the information=20
> in the cover letter won't get included in the git log if this patch=20
> series is merged. You should also elaborate in comment on under what=20
> conditions should this this new mutex API be used.

Isn't changing mutex_lock() the wrong place anyway?
What you need is for the code holding the lock to indicate that
it isn't worth waiters spinning because the lock will be held
for a long time.

	David

>=20
> Cheers,
> Longman
>=20


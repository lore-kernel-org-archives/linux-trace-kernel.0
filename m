Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1905015199A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Jul 2025 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892333; cv=none; b=b1sw+rOt72znCFc1BlvulhCqMUOLQZ+uKIgQIUZQpAxXziP/kYNpgqs2PNN3jvk0DCBKGD8ZnGWCOy5JbcuBCJOd6sCGPd92yEGC6uOuW3Qfje2d/gvT/YuB0XiAzT5EHBTa1r7U5Ggkf0ax1LYl7SdluAc6D7aFte8PU164c1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892333; c=relaxed/simple;
	bh=hBc1ZB/zmldH2rmmcQDCS8rxOUPp2OqnGrZNEB/LC38=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G1UwMyFHjqPBrX3qI8S/2Xs9sPuRm6Q3KH7qJEIADMvRHJAAqBDKGOe8ddlNMLgCPewfogMuXFE3nS/frREfpjIzFCcra3oRmwAT+9iJeMN9tmepbfHzfDyPeSZkVFEfSnkBhwPECqTYkFWgCARW+ichSR78cpK7vmY/saUr1kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=io0iBbqq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="io0iBbqq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753892331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hBc1ZB/zmldH2rmmcQDCS8rxOUPp2OqnGrZNEB/LC38=;
	b=io0iBbqqT+1OAEzhVwCM3QqtXD4Fvjff/EjRh2oQQUKzyDqDFc+ctk5TKZdbSXJZIlPNlO
	OQ0g1ISw2eijFOpKbHfAnXT82k503olv0D5xEEAt2eGyeIyVi3wPAXhRZpkEZyeH0kZHOo
	ksEP4xuDZT1yAv/GHjD24ijey32rgpg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-TcvqjGoNNzKC872c2lzQzQ-1; Wed, 30 Jul 2025 12:18:49 -0400
X-MC-Unique: TcvqjGoNNzKC872c2lzQzQ-1
X-Mimecast-MFC-AGG-ID: TcvqjGoNNzKC872c2lzQzQ_1753892329
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-456106b7c4aso4870125e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753892328; x=1754497128;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hBc1ZB/zmldH2rmmcQDCS8rxOUPp2OqnGrZNEB/LC38=;
        b=Lkj36vQNIBgEOGOLibJ8FsWJ5f7sNxTZV3MyFyYqZmJBxMSDofJDjZqttAf6NDq8oZ
         FSk67P9/4SGzpeBGenAsSohLi7xKZW+OVk/7b3DUrjuRdXTkdCYYQvFaqF3gwptmhjBx
         K28tPmJ91ASgfsNHlj6IPyX4lbFi6ptz5gE8qNNEUkrC46aVDoLKMH7sBdop8Oua/hm5
         fxuoIr9Ivt29lm5WTEqrv+6ye5Pkd/DSO6vHWV9B4VOMz06cr7flpWh5XV9qgjnI7GIW
         9Qi6aResg2RuG5vTNm3esixEDSZw1KogBfxI7QMmMJfm3CS4ES0+CVFHvmGxq/uYzOCb
         JJZw==
X-Forwarded-Encrypted: i=1; AJvYcCWhtgcxNHmCB0UjHwXKOAtrs6wypR/cYcNMCCCfi6m3QgwXmUmjl2dnPQIzAysYCeAhrb6RLkFzRSTlZ//Hf1k5H3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr8eRz1QyREykZpWdNjy3cysk7yZyvwQWJsmLpuSfSPLCYytsA
	4tfQY39opoDeH5INLEPzOxOPvXOnUI5KxdnO1cyhREmL8358vPuYCdqiKiyOU1cfzf70gOwDitp
	r5XONYvor1BH2VdkOehgSGFcgUCyHDf8j7v8QJycnmOOdyigzNt4t3OOnA8Xuk8xqzZBJ4lNNWQ
	==
X-Gm-Gg: ASbGnctvgaMg9qGMyQIyIqoMglCoLqnogLPyjub5e9vsqX+MCzwsvjA87U1Oxch2XFc
	cYJ5Wb8d1Cd3F7UAzP/D4TRccPBSlRwiNlVYPZS/OMLWhmmJCtjmhUa6XFT2p1POxC3vKfNaztN
	t5PWWTkqmiLOi5PRG6LP6DV810ttV76R7Xu90yqnG+9ZYQmHBl+bBY6hsVA310R1AWdyEHRN1u9
	1iCOi1+vh1PUFpDb2WfpsPxcqJAXyNnRHkWr6h/1K9GzJjKtS7qOYhEo2osYYGkvcjtZN6zNm9D
	u4JS7W3gRuJkGb3LWdvv8CWr6L8rwSVN3SvM3T6BANqf9mGwwwym5BNAo7TZZ2xQ+Q==
X-Received: by 2002:a05:600c:8712:b0:456:1157:59ac with SMTP id 5b1f17b1804b1-458930bd2d6mr37773875e9.7.1753892328542;
        Wed, 30 Jul 2025 09:18:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWP0J4/3OIJlr0Em11nduOnOIRc9DYOjF+jeF8inP3uDI7CaRSpI4pRD7sR0xiZ29IYul9Fw==
X-Received: by 2002:a05:600c:8712:b0:456:1157:59ac with SMTP id 5b1f17b1804b1-458930bd2d6mr37773565e9.7.1753892328177;
        Wed, 30 Jul 2025 09:18:48 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953779aasm32083465e9.11.2025.07.30.09.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 09:18:47 -0700 (PDT)
Message-ID: <5065c29035be39dee954f2b233a40ae15dcc5035.camel@redhat.com>
Subject: Re: [PATCH 4/5] sched: Add rt task enqueue/dequeue trace points
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,  Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>,  Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall	 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider	 <vschneid@redhat.com>
Date: Wed, 30 Jul 2025 18:18:45 +0200
In-Reply-To: <20250730151818.7RemAREO@linutronix.de>
References: <cover.1753879295.git.namcao@linutronix.de>
	 <8f83869a5040bd7cd3096bd12090c1ab110ae5c4.1753879295.git.namcao@linutronix.de>
	 <767a9d59081220594d21856f329fb35988ef7925.camel@redhat.com>
	 <20250730151818.7RemAREO@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: lUTJoJ7MXCEzmf9h8Gv-wIgUVaVGoGY-WHerpv8Qn2k_1753892329
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-07-30 at 17:18 +0200, Nam Cao wrote:
> On Wed, Jul 30, 2025 at 03:53:14PM +0200, Gabriele Monaco wrote:
> > On Wed, 2025-07-30 at 14:45 +0200, Nam Cao wrote:
> > > Add trace points into enqueue_task_rt() and dequeue_task_rt().
> > > They
> > > are useful to implement RV monitor which validates RT scheduling.
> > >=20
> >=20
> > I get it's much simpler this way, but is it that different to
> > follow
> > the task's existing tracepoints?
> >=20
> > * task going to sleep (switch:prev_state !=3D RUNNING) is dequeued
> > * task waking up is enqueued
> > * changing the tasks's policy (setpolicy and setattr syscalls)
> > should
> > enqueue/dequeue as well
> >=20
> > This is more thinking out loud, but I'm doing right now something
> > rather similar with the deadline tasks and this seems reasonable,
> > at
> > least on paper.
> >=20
> > What do you think?
>=20
> I think more or less the same. The fewer tracepoints, the better. But
> the
> monitor is way more obvious this way.
>=20
> Let me see how hard it is to use the existing tracepoints...

Well, thinking about it again, these tracepoints might simplify things
considerably when tasks change policy..

Syscalls may fail, for that you could register to sys_exit and check
the return value, but at that point the policy changed already, so you
cannot tell if it's a relevant event or not (e.g. same policy).
Also sched_setscheduler_nocheck would be out of the picture here, not
sure how recurrent that is though (and might not matter if you only
focus on userspace tasks).

If you go down the route of adding tracepoints, why not have other
classes benefit too? I believe calling them from the enqueue_task /
dequeue_task in sched/core.c would allow you to easily filter out by
policy anyway (haven't tested).

Thanks,
Gabriele


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31A0238D2E
	for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Feb 2025 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738940250; cv=none; b=hjfkkUDObdfJTC72xCAvgu90nj/VQZlWOih1LRVtaC3w79VZf0ACXRrJRG9jEqlbqAT2+mv2LJnsPhyZ0SORCZMJTbdIttAren7szm3Ofj/+UUIm1gltQv76JMUYTjvvpjMgdbNbkP1MXnzNROyFSbpU0pPvTBtgpwSXzYW/I4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738940250; c=relaxed/simple;
	bh=Zlv8q7TgjhROaMibYT/4drmx95N9OLtbBAMv4y0Ny4Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EonF8tv9sHwzcNZ+t4vlTljW5V7veHy8WHbRIWd8wKuEj49PjgNggwCnJVS8ET+ibBBdLhd8incotfenMYsFNcb8qYZpcgTQ9TV737h1Nq4r5ktpN2jrGqLqNi/m+LCkbrRUmioAcgyHtHU6G4V352w46qVL0AG6NZjU+xW+feI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GdCNIYlP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GdCNIYlP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738940243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Zlv8q7TgjhROaMibYT/4drmx95N9OLtbBAMv4y0Ny4Y=;
	b=GdCNIYlPz+P55dyflATsU94TnLwvvzPRSkr9mXJ3C5o/SwY63LK5zm3nr4nu12pOjhWg8f
	Yz0d08d9YEOG9+FwlK7/GYW6KAb3mfZyaUVszTNmbPqAl/XS+DlQPxLS/jeGdyDMe6dWFo
	6BOYJ7N+7n16n9k6XjGBuvjZoDN6uoY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-0Ub4cI41N9G11dGM5BCTMg-1; Fri, 07 Feb 2025 09:57:22 -0500
X-MC-Unique: 0Ub4cI41N9G11dGM5BCTMg-1
X-Mimecast-MFC-AGG-ID: 0Ub4cI41N9G11dGM5BCTMg
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38dd0265d97so179682f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 07 Feb 2025 06:57:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738940241; x=1739545041;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zlv8q7TgjhROaMibYT/4drmx95N9OLtbBAMv4y0Ny4Y=;
        b=fNnHatpbUL7N3WjVdGK0o7HF7bSDwSW0zlZ8QKoSItoffLJlXPMDfeaIX5AIp0hb5S
         yhr3wJuEkk912PEQ9GYpR0M9o6tP+jAJ4859DBIubUfGigPfiusSO/m5NDQVtv4YXBjt
         Q48uHTRiDnyBsCVHTvlrL/5ZiT+8vMNyrnatuukO3uOPEXl3AHb7C74tPzj9W3S7csH5
         SajKSgNDWfz4hwH7D33s0diK0+M+exj+Vctu9vYhNnlZvrDY09JYd4DwFu9sIg1NN9xd
         shsmr5zwb3ncnHzkqGQu3bm/CYg1moOU5d801QSTn433UIA3U/6yx1HICNBT58Pa8Qdz
         F11A==
X-Forwarded-Encrypted: i=1; AJvYcCWIwTgXS20LlTzdoxSdO2WqFm3q16KFW00tpmDwZs2AiKqmBcmDA3bxao3QMFscwUdcwZuUYn1QncKg1R28I1rsU/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUYqqYRFmP9Ac94RZezz5n+67/4aeN5Nm8ZwFTVGdwP4eHRYck
	0a39QLF05p6knuQwXeF9dWc8JbPqP2thrXl1GWJVEbDjOPIknNG+Pjx3i80WnDCJeH3f9bKmaTL
	mPdmJZbme+9AYqxerlZmiZ1f87WZ/w+Xa3+YAfFqqXALZnf2hlEn176TPFpKOY8USJi8VJw==
X-Gm-Gg: ASbGncsrGbz31tJdC+sgZo0LrBjFhdeMygpOGUSJnVaRy4QZuBEe0QHjygZMsYcWOpD
	TrIqR9/xSdUzycfn7PklfYZE3RMOE0vrZHEqYynSymfLTXMneUtliy9xBpy3uaR7f6N3EqKCFG6
	MSVkxyp982hu5xnWWkkc56QMfZNsVUyFrkeCFVGUiOXib9ziOJgDw/ozmeCA89ATvsFBD2k/rEv
	lasOa2CXIPqwAmnN2Gf8LhfINLe876EwkQNTJPon4Vi2aKBDZOFtHrp6EuhImG2N1P43WQ3kjSO
	o940kYLiiednMDjDISYaWnQsqe/uqcw=
X-Received: by 2002:a05:6000:e8b:b0:38a:8ec6:f46f with SMTP id ffacd0b85a97d-38dc9351400mr2047646f8f.53.1738940241233;
        Fri, 07 Feb 2025 06:57:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsxt58t1ggpxOyV8Jw35Ibo+3DCejqzHyg3fxJQZBM9uxGG4KqiZt49GPYbE8JvBAjoXExpA==
X-Received: by 2002:a05:6000:e8b:b0:38a:8ec6:f46f with SMTP id ffacd0b85a97d-38dc9351400mr2047621f8f.53.1738940240672;
        Fri, 07 Feb 2025 06:57:20 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dcc9bd251sm1608877f8f.9.2025.02.07.06.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 06:57:20 -0800 (PST)
Message-ID: <71f969466238803df34d731bf9deafdf5f52c746.camel@redhat.com>
Subject: Re: [RFC PATCH 00/11] rv: Add scheduler specification monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-trace-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>, Clark
 Williams <williams@redhat.com>
Date: Fri, 07 Feb 2025 15:57:18 +0100
In-Reply-To: <Z6YYPAiM0itlIVAH@jlelli-thinkpadt14gen4.remote.csb>
References: <20250206080952.98478-1-gmonaco@redhat.com>
	 <czykavxpz46nwnelml6yorg3tvmyjvczqogeuqzji6qrfd2peu@qxr6wucv6mrj>
	 <847c962745ef5bce757b9ae257ae279913ac711c.camel@redhat.com>
	 <Z6YYPAiM0itlIVAH@jlelli-thinkpadt14gen4.remote.csb>
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
X-Mimecast-MFC-PROC-ID: 3keOg5tgdWnYUzh57xGKSnx3tuLB9hwGQSev67YdCR8_1738940241
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-02-07 at 15:27 +0100, Juri Lelli wrote:
> On 07/02/25 12:36, Gabriele Monaco wrote:
> >=20
> >=20
> > On Fri, 2025-02-07 at 11:55 +0100, Juri Lelli wrote:
> > > Hi Gabriele,
> > >=20
> > > On 06/02/25 09:09, Gabriele Monaco wrote:
> > > > This patchset starts including adapted scheduler specifications
> > > > from
> > > > Daniel's task model [1].
> > >=20
> > > Thanks a lot for working on this. Apart from being cool stuff
> > > per-se,
> > > it
> > > means a lot personally to see Daniel's work continuing to be
> > > developed.
> > >=20
> > > > As the model is fairly complicated, it is split in several
> > > > generators
> > > > and specifications. The tool used to create the model can
> > > > output a
> > > > unified model, but that would be hardly readable (9k states).
> > > >=20
> > > > RV allows monitors to run and react concurrently. Running the
> > > > cumulative
> > > > model is equivalent to running single components using the same
> > > > reactors, with the advantage that it's easier to point out
> > > > which
> > > > specification failed in case of error.
> > > >=20
> > > > We allow this by introducing nested monitors, in short, the
> > > > sysfs
> > > > monitor folder will contain a monitor named sched, which is
> > > > nothing
> > > > but
> > > > an empty container for other monitors. Controlling the sched
> > > > monitor
> > > > (enable, disable, set reactors) controls all nested monitors.
> > > >=20
> > > > The task model proposed by Daniel includes 12 generators and 33
> > > > specifications. The generators are good for documentation but
> > > > are
> > > > usually implied in some specifications.
> > > > Not all monitors work out of the box, mainly because of those
> > > > reasons:
> > > > * need to distinguish if preempt disable leads to schedule
> > > > * need to distinguish if irq disable comes from an actual irq
> > > > * assumptions not always true on SMP
> > > >=20
> > > > The original task model was designed for PREEMPT_RT and this
> > > > patchset is
> > > > only tested on an upstream kernel with full preemption enabled.
> > >=20
> > > I played with your additions a bit and I was able to
> > > enable/disable
> > > monitors, switch reactors, etc., w/o noticing any issue.
> > >=20
> >=20
> > Thanks for trying it out!
> >=20
> > > I wonder if you also had ways to test that the monitors actually
> > > react
> > > properly in case of erroneous conditions (so that we can see a
> > > reactor
> > > actually react :).
> > >=20
> >=20
> > Well, in my understanding, reactors should fire if there is a
> > problem
> > either in the kernel or in the model logic.
>=20
> Right. I guess I wonder if we can find a way to inject kernel
> problems
> somehow, so that model(s) can be further tested explicitly thus
> making
> us confident that they will be able to identify real problems when
> they
> occur.
>=20

Just for the sake of testing reactors there is already the wwnr monitor
which is intentionally broken exactly for that reason, Daniel described
a bit what scenario can trigger the error (some IRQ, so it may be
harder to see in a VM).

If we want any monitor to react, yeah that could be a bit trickier. We
could perhaps do something like livepatching/kprobes.

I'd assume we'd need some care though, since some of those monitors are
pretty basic and making them fail may cause pretty bad errors in the
kernel.
Another approach could be to just inject the tracepoint/handler call
those are all static functions but we may have some luck there and
wouldn't break the system, just trick the monitor.

But good point, I can have a look.


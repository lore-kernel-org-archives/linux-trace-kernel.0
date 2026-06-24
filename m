Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E3330C630
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 15:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782316112; cv=none; b=mu/VMbxNCXg6kjFFFhtWys04oa5pEIGKa/T2EHYfzhl5qDTlsIWbGp6z1tfxiSDzNoric/Pf5CoAW7LDz70Ban1dolTgD6rD2kXGuDqkNlJjwI9fK7myF5+LgnXu0DV7pOCG8XcOv3TANrdL/HIwe3m0l9G5sGvBF8TLQS1m8gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782316112; c=relaxed/simple;
	bh=8z4U0FFdtN5sqdRDecsz6fFlDML3JHmj00y7AqAcio0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SCBQtxshjMDFTXt/gC3Aceu3AethGEfVAvsciv5+kjH1u5bVP6J4D4m/mx74e94xCRLMLhsHIYBltdplICAQPF3NR0wZwJc5mZW2RJCEmc7rKfeeJokR6tkVW8+ESEcDGe4pheCcJmQ6redN5vdSnKdyYO76KEgtjH2Hc3jsQEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLGGbFsu; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLGGbFsu"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49222fb062bso12005395e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 08:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782316109; x=1782920909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pd9JPcwpjrMC6w7E/HnW4+VaNjSHAgtKN2WTr5nagMQ=;
        b=mLGGbFsuQWH8nK99PSEv4GoZNJDH8C34974BrdqFHe10IyUEIAgQiDo/zHijp6cZtl
         4IMkbt/Ove4N+0WXbwt4Jpm5vt8MXZpemCSRC57hW4CKl070k2kyOIY5BfXstypIjAu0
         wQN9fSqr9YvsQRzJw9FaFTkFz29R2hqNwJ8WEB83Hvd+/RoGEgp5GA0jHWs7ooWxDsTX
         1tz2+l+oZ4s0VLGwJkOH2HVubllPEJztFsQFwr+t7WhNZAYzeg0XHDTE0qdG4lD9Km7P
         DS7YMLK4Fi8Rwh0/tYr/NFJzCHiF15aP+qeXX9nl+au43h1KU4939gcjYSZif0lpPFC3
         wgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782316109; x=1782920909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pd9JPcwpjrMC6w7E/HnW4+VaNjSHAgtKN2WTr5nagMQ=;
        b=LKAwxBS0DOxTjue2lLbTFeYPjc24gPlv00cEFOpXGXuEplkC8H/F3k2AwJbnZd/ufS
         fB1bRhtIOKLvgz0+7AicGijY60R1zPn59BMfpxtsJA6B7x4TJslLwktXfPjs6UqU+hBe
         TmxlLtAuYOoSV1zu0AB16YeQlS0717sZ+ub7dCz5HadBI5ua7nX6Ss82NAiV77L8a6Rl
         jSWBRD1vrwZWcEQLO83rpU0VWhU3VyBwyNjPL/p3xkyJ8DPMKln3ajaI4JYtqQfVgipG
         zCkGYG4QgK0qgyT0dz7/asyJxKl0f8dAn8UxB0KWdfaEXj8p/So5VE9jwTxt1XuibMU7
         eUag==
X-Forwarded-Encrypted: i=1; AFNElJ+p0M2xpTMx0HZDrH/EbTsVTlh+QEJBMx3LvvBQ8eXwWXwwmcHjc21vePDOaKWURouVEXb+s6ZPufxoVgiP9SY4WTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyohUOgXoDTDJOiw0qOfnZIwBSfk7hdTL/uxaRK1RbqxXgmULQO
	NwdqHIY2d1dg0ccsWr6AMu9T6wk/6dJcocdRO4VWMKE4PbEjmz6IDwW9
X-Gm-Gg: AfdE7ckwM/qKl5x3KN3evwEDPKz3QjYhSdBvg6zKzcIr/wlmIaHbpewN5c9vZ1pwyjD
	Fs+TjGLkZRSSQNZBQ8NI7p3nEPe/jaHs/qGtnKj6KaRqkOMdkgybsWOGoqGJR+7s3qxX+j8RKrZ
	VYn8arcocqNO81aS9qNPUXkhdMXXxV2YSNu9a690eN/ctyet5M7+MdSY92kIidV2RsGANLu7W7C
	ppGIbuP8rRxhPi5OrezGdVeGT4sDZdJyC2XzTynA8c1r7bm86KLTkyNLlYFvVFFlW3//O7Jhvcc
	t1Tv17FXsKbNCS0a3oG5wKHqUKwaXGEUlKZPWz8KC/HzAeKRE5omzzUCdCVdjYdEJuk9kUIeNRZ
	oVICHIrYi7QL1se8qRoqcbzaxtMBoz3f2mFss7zIui2wtYwiV9KOTErIY5Ga/12lmgOu7Y0L7Tw
	6OuImfP8jW8fVWBjzWRolU1ZKjXfFigIr894VWn7in2jO9HZRXVg==
X-Received: by 2002:a05:600c:4ecb:b0:492:433a:53af with SMTP id 5b1f17b1804b1-49260858030mr59096755e9.16.1782316109264;
        Wed, 24 Jun 2026 08:48:29 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c9ed7491esm4146372f8f.37.2026.06.24.08.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 08:48:28 -0700 (PDT)
Date: Wed, 24 Jun 2026 16:48:26 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Thomas
 Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Julia
 Lawall <julia.lawall@inria.fr>, Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH v3 2/2] tracing: Remove trace_printk.h from kernel.h
Message-ID: <20260624164826.56a7f7b4@pumpkin>
In-Reply-To: <20260624103225.77116713@fedora>
References: <20260624081806.120105649@kernel.org>
	<20260624081948.301578807@kernel.org>
	<20260624111152.75476a46@pumpkin>
	<20260624103225.77116713@fedora>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jun 2026 10:32:25 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> On Wed, 24 Jun 2026 11:11:52 +0100
> David Laight <david.laight.linux@gmail.com> wrote:
> 
> > That is all about changes to the file causing everything to be rebuilt,
> > not the contents of the file slowing down builds.  
> 
> I guess I should say it better. It causes more build time if that file
> changes. That's what I meant. I update the wording to say:
> 
>    There have been complaints about trace_printk.h causing more build time
>    for being in kernel.h it if changes. There is also an effort to clean up
>    kernel.h to have it not include unneeded header files. Move trace_printk.h
>    out of kernel.h and place it in the headers and C files that use it.
> > 
> > The part you are moving out of normal builds is just a few #defines.
> > They won't have a significant effect on build times either.
> > 
> > So there is no point splitting out trace_controls.h.  
> 
> That is a completely different reason. trace_printk.h is about
> trace_printk() usage. The stuff split out into trace_controls.h have
> nothing to do with trace_printk()s.

True, but every header file costs extra time to open.
That could easily be more that the cost of parsing it (ok hand waving!).
With a long list of -I parameters just finding a file costs because of
all the failed opens.

I've just knocked it out of kernel.h, had to fix:
	rcu.h
	linux/ftrace.h
to make my 'normal' kernel build.
Lots of stuff includes the latter.

	David

> 
> -- Steve
> 


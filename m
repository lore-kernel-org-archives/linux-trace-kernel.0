Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563073;
	b=rylVXGlriouNWIU0txG9DeQVWUbI111Afv+xsj95IPCyyvsalzSLz4BeHI091/eMMEF+
	 +BocbU+AfsUWN9EQP3BpBF1VjZHO/V01sAn8R5nokPhtSCjPSFsigUwdMoyfa+SkkDzaF
	 1uj5Rt+nCPPeTQrX9fCt5lB7Y+wUco7BBYEfo3yWelucPrlnoSKIKi/tOuQdpjMLr6iJs
	 qHmegMX17TOQBbvLN5sV8p61s8EudMskCTaz+ssqmSKOownDfIlCBJH/vWm8mZeH05NC0
	 VGY/Cz4Yh5s8XZuWBH3O4aAKMZNqGi+tqk3k60PcgyqC7u852f9RVQ+TyM/HLhd22iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563073;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=D7igYa6I7HgARHRohqnZ1I9bY6nEhWNE4iafHmCTY7c=;
	b=w3jq6yH1NRFy49CR+ECP1Y+jBSmKRxk82UGXHaPLf9htP0TukxKl/ySPb3qbjwNQ94RV
	 h72DTlrpeaYzhiTI6mWN4z4vlGBfESvrxioOy3KpxiRQHLfZMV0GOwMEm60Xts+eXLo4h
	 G/SBW5MZQ01d14fh/+SVs4U9d1sSypwwael2MKN0HH6A8unKAIwuvcVz9lxjMNavW7asd
	 BCOI9SwS2eKzJQjWO70JtdEK2EAyffUf6l9W40dQ47Ah3QwVBA02xZWHqLZTO2MySTZ2Q
	 Jc0ZGbi4nKV5lh23f3aOgDjSMl/lQJk4Ys9/+IA1KCyjCLTMiUmbVeP4QW9SJ5WNxsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=vF0FPmh1;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=qWnwsntu;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5EE606A31C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 09:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD5EE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=vF0FPmh1;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=qWnwsntu
Date: Fri, 13 Nov 2026 10:44:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794563064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D7igYa6I7HgARHRohqnZ1I9bY6nEhWNE4iafHmCTY7c=;
	b=vF0FPmh14l68xQCGE835sm5mMv7Z2EFMzBlrIEavyAjTGWAJNCLJHHWh2wNny2KREmaxOC
	4qbcBTqf305B9nW/J3eIxyCcCwvRKcI8FONqZ+XlLEqpTxNM/75tm9EtUGuA/EjOqk+JFp
	DOEJntm3PKh+foWsVA+VNPUvfLcjJUXC72Fo8Uf0SDI58pzHQbIBFlGXh2HETQFKLrSVhx
	055cH2JoGLnbnjX/M0GzfWEhdQssmG5i+ALzuIi210Zcmzb0qELnXvTo2Chqa29PLmxzhb
	Dh2I1H0mIejd4IXdlzq3ZmuhgMqa8c92hRB8stsdTcfCBBdEpMwPFjMdMmCqQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794563064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D7igYa6I7HgARHRohqnZ1I9bY6nEhWNE4iafHmCTY7c=;
	b=qWnwsntueOfv5eRrGRvdrVIo3D4Yrnr96yXmL+DUPXgSy43a7DkpFh7sSPTX0dFuj8Gkkz
	qXsSWLz7mjqYbdCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Daniel Wagner <wagi@monom.org>, Steven Rostedt <rostedt@goodmis.org>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] rtla/timerlat: Lock the memory of the user-space threads
Message-ID: <20261113094423.xgAx5Goo@linutronix.de>
References: <20261112-rtla-mlock-v1-1-418986711b20@monom.org>
 <CAP4=nvRQE+GKPT1-KgZ4OgcVV7eKqnkURaELutSMgK4T8YAZMg@mail.gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP4=nvRQE+GKPT1-KgZ4OgcVV7eKqnkURaELutSMgK4T8YAZMg@mail.gmail.com>

On 2026-11-13 10:30:33 [+0100], Tomas Glozar wrote:
> > --- a/tools/tracing/rtla/src/timerlat_u.c
> > +++ b/tools/tracing/rtla/src/timerlat_u.c
> > @@ -15,6 +15,7 @@
> >  #include <pthread.h>
> >  #include <sys/wait.h>
> >  #include <sys/prctl.h>
> > +#include <sys/mman.h>
> >
> >  #include "common.h"
> >  #include "timerlat_u.h"
> > @@ -69,6 +70,15 @@ static int timerlat_u_main(int cpu, struct timerlat_u_params *params)
> >                 }
> >         }
> >
> > +       /*
> > +        * Keep the measuring process in memory: the latency it reports
> > +        * runs until it is back in user space, and a page fault on the way
> > +        * (its code, stack or libc pages reclaimed under memory pressure)
> > +        * would count as latency. cyclictest does the same with -m.
> > +        */
> > +       if (mlockall(MCL_CURRENT | MCL_FUTURE))
> > +               err_msg("Could not lock timerlat u memory: %s\n", strerror(errno));
> > +
> 
> Can we make this opt-in, gated by a -m/--mlockall option, like cyclictest?
> 
> We can add it as a boolean field into struct timerlat_params and pass
> down to struct timerlat_u_params. See e.g. 2ff4464e3283
> ("rtla/osnoise: Add IPI tracking cmdline option") for reference.

Why make this an option? I would prefer a RT task doing the right thing
right away. cyclictest has a history of several options to do the right
thing. Is the reason why lock should be disabled?

Sebastian

Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A60223DDE;
	Mon,  4 Aug 2025 06:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754287544; cv=none; b=sCfuXaJ7O7Sfhlfa+FoCs6xqxUvP5cFfs+q4hgGb4qTvKwXj1O2z7W9O1Wjxa4VHad8gqk8lFdClWBNrq0pY2PBcg8htp8na9IrH2C0+QxUmDKBfQVUBC9wOJvXXB+Ect8eJU2O/Nu4lUPiUEzCCXZfzojfy6Njqs1E1DmGiv98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754287544; c=relaxed/simple;
	bh=f2UO1Xfipf3cy27q87nSBY3PLFb81udKPt37Waz6k40=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QPrZdZWRdS7thzutNLUQ7ODdhijLCfz5gAyWZtJ8Sk8QXkwwhoHQY3aueaJ4Z7X1QAL+XbuKYiJKahZNCd8U6kmVCM+wtsPB0GeEiZsqy5LAs9tS37nVrYFCNZ6jn3fQcEPK0zTSG9e6osjAP/yE48E+edSf8jp0uQaxUGp3zTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZuumebY1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TAaLddOd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZuumebY1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TAaLddOd"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754287541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f2UO1Xfipf3cy27q87nSBY3PLFb81udKPt37Waz6k40=;
	b=ZuumebY1fiKoCwj+m8PUnbjAB70bQ9fB1PYJ1eHxmZ5+rHpQvNL+n/Ev08Psq7bNtVnXtY
	mL6HcAQhO1MZdXJoEVNlks8XQ9GKr6Y0g+cQ551ybOjb8vGBuBfoyka2DyGjDW1DrlP1QR
	k4L8fAA7Im4NwBsUcxmDUFRzeq/NJx8n3jT7RcGk6koPFo8X142DRMVOO50MVhkxgdV+X2
	C5DPrrLH1nmfaLcW/RU3R2MSBvEj0jmHzG4vSBxed1KRu8Iu2hR9Jj5eU352nIySGkeVzx
	UOuU20bgBIfaOV12/fm6ma2SAxYLikKeIZtApNs5x6EqJj9x8QH6gwwyy48eVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754287541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f2UO1Xfipf3cy27q87nSBY3PLFb81udKPt37Waz6k40=;
	b=TAaLddOd89dst2OGZVze4VvpYlF3PJtqU+Zc8EJNCgkPobtmumICXd39NMEHaUBIMi4kPC
	B5BE1kzzn8Tzh9Dg==
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>
Subject: Re: [PATCH 5/5] rv: Add rts monitor
In-Reply-To: <c1635857f735aa91679c153f785e09beed9b5b2f.camel@redhat.com>
References: <cover.1753879295.git.namcao@linutronix.de>
 <20834b8fcd4dfe75642cec2097e29f4c636a33fb.1753879295.git.namcao@linutronix.de>
 <a78008bb05acae77f0572c3e5651cb2bceaaaf98.camel@redhat.com>
 <20250801075810._Ng7G1QT@linutronix.de>
 <c1635857f735aa91679c153f785e09beed9b5b2f.camel@redhat.com>
Date: Mon, 04 Aug 2025 08:05:39 +0200
Message-ID: <8734a7vcy4.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Wait, by /works properly/ you mean it reports a violation. I just
> noticed you mention it in the description.
>
> It's reasonable to request RT throttling disabled on sanely configured
> RT systems. But throttling is a /valid/ kernel feature, I get you mark
> it as /unwanted/ though.

True.

> I guess if that's the case, this monitor doesn't belong in the sched
> collection because it's meant to validate the kernel behaviour, not its
> configuration for a specific purpose (RT).
> Isn't it better off with the rtapp ones (which validate the system
> configuration to run in an RT scenario).
>
> Does it make sense to you?

Yeah I was a bit unsure where to put this monitor. But under rtapp makes
sense, if you prefer it there.

> I still want to give it a run when I have a bit more time, besides with
> RT throttle, can the monitor really fail on a working system?

RT throttling and fair deadline server are the only two known mechanisms
which would fail the monitor.

In the future, there may also be sched_ext deadline server:
https://lore.kernel.org/all/20250702232944.3221001-1-joelagnelf@nvidia.com/#t

They exist for good reasons, but they are also a problem to real-time
tasks. I am posting this monitor because we did a cyclic test the other
day and observed some big latencies, and we had no idea why. It turned
out it was the fair deadline server. So we need this monitor to tell us
if some similar mechanisms exist or will appear in the future.

If you try the monitor and see problems, let me know. Most likely it
would be a flaw in the monitor, but there is also a chance there is
another throttling mechanism we are not yet aware of.

Nam

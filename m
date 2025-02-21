Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019881FFC73
	for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156465; cv=none; b=ohlVDved9dcjyhXNSECc4u4ufEs2Ym9+2too44twIQtAPYvY73/6tX6bZW3sKdFfwEbPrqDl4b49dkT9+VQ39/WYkVatW+P+s7CA8dK42DM6RKzVAfPP4smcdC0m12z+sSYnaNwIBFUz+ZKAeqAqBqqg0zKGICgxPDyIz9wNzkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156465; c=relaxed/simple;
	bh=QGsnl3UDxL6o+Zb5sIuMg4mK/ph+5EQXHCi9skL7zbg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l4g9ly1KzOfnJ/GX68+FoWJydA3meuvCmIPy9N6C9WNyl4r5PPTNLTzwVtNi4x8JvpSmSu+oegHKXPsrFLA0BdLY9orjh8tUCHyReI6oddsw/qMWmISsteEDpR8NjpqpFkfuttxs523t7pNRqfeUALLJSfLkgtfwl9pUNeIELks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9253C4CEE2;
	Fri, 21 Feb 2025 16:47:43 +0000 (UTC)
Date: Fri, 21 Feb 2025 11:48:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Wander Lairson Costa <wander@redhat.com>,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Gleixner
 <tglx@linutronix.de>
Subject: Re: [PATCH] ftrace: Correct preemption accounting for function
 tracing.
Message-ID: <20250221114812.6030671d@gandalf.local.home>
In-Reply-To: <20250221162146.9KWeIdA0@linutronix.de>
References: <20250220140749.pfw8qoNZ@linutronix.de>
	<44ymxgot422oetab62w55rth5tqrzseyhwirxg2ho7vzvvkaud@qiada52ckt25>
	<20250220115400.4d75d881@gandalf.local.home>
	<20250221162146.9KWeIdA0@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Feb 2025 17:21:46 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2025-02-20 11:54:00 [-0500], Steven Rostedt wrote:
> > >      kworker/0:5-88      [000] D.Zf2   211.983391: igbvf_reset_L14: (=
igbvf_reset+0x62/0x120 [igbvf])
> > >      kworker/0:5-88      [000] .N...   211.983396: igbvf_reset_L16: (=
igbvf_reset+0x7b/0x120 [igbvf]) =20
> =E2=80=A6
> > > (Except in line 6 where it show 'f', which seems to be an unrelated i=
ssue) =20
> >=20
> > But it appears to be consistent.
> >=20
> > Let me go and add some probes and see what they show. The output you ga=
ve
> > me that I requested didn't show anything unusual. =20
>=20
> Since I just noticed that you posted the patches, did you find anything?
> From looking at it, if we preemption at 0, migrate disable at 3 then a
> substraction of one would underflow the preemption counter to f and
> migrate disable to 2. But based on code inspection mg should be at 1.
> And this does not explain where D & Z is coming from.

I haven't found the bug for this yet, but I need to send out other fixes.
The preempt count issue you posted is agnostic to this issue, so I just
took it and added it to my current queue for this rc release.

-- Steve


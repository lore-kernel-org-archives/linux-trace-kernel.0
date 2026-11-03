Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704312;
	b=FGH89rO+Rc7om5Em6lugaTKAI4kiwK5Gm2o+47t3ck89ODWZ7wXActP6URLOjaMqhIhS
	 S9K0WsKyTzl9VuCQow/FiCNrI0XBekb4gFu/uik6O3bAQqSXOgM7y6m+2Gzken4UNVPjV
	 H/qMTZWrUzqfZf1VJLJtCMFimIIBItRzqYiO/kyJViCkXggNc5Cw7pEg015wcS/JZgJfk
	 6hK+h6uWM1wqXcv+FdAUGfZcZaouyO0yJMwhMzh8wswGrDdAUBs67lpRumMN+nVpCO4Pt
	 1JfbZYdQGdD2Zxd4z1GnQGpxYUJwy+vN/2XfJ99uf0aneoWK2fF56FI+ervH+qJtMEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704312;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=DRSP5dNsS3mHl0mDMeYY/G8SJ9kad2UxpOHnBXBI684=;
	b=Pq24Zd6IKYhmMh7WiYxDaFqm61UY98ESJgAbQ9bBVuyZnmpcLbmGlccVcuBxXeZWE6zO
	 AgX4aojpVoaKQNCedswVfct/JMqvXURrs6i2x9U9qEmvNpGRx+ofLbr8jXAAzQzxS1QsO
	 zDACHFJ/xW3llPyi0qjaY7bHrcNIRITHToIPMoO9BzItw1BBFi3m7JMiZlyko0pIjx57g
	 6klXCYEtn31AqaAuga59ds9cS3AGjoDSnuNRsDzCmag64W5eHQvCVkzeNuKQ5QFMrlzU6
	 d9uS+j3jN4VHeWMvfXc5zivv0HKAnaQIj55D/tofRQktinpM76CrKBWY5S2V8xsuBbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=VoneIZrI;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8317606A82B
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Nov 2026 11:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8317606A82B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=VoneIZrI
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48c4be28b82so4235187f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Nov 2026 03:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793704310; x=1794309110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DRSP5dNsS3mHl0mDMeYY/G8SJ9kad2UxpOHnBXBI684=;
        b=VoneIZrIjqDgDNQeYh6sNuFncCLUEz4sf+KffVyKU9JPgoaAuPHSaQJ09adwOf//iX
         dvPKugxOP47c6kXcmwY5r0qNnfa1PcceKJqRdFG1U9/xtwkoanCLczpPiq9NZhE899qm
         nMxXQHZGzkH1p2y4RHJoqNYuTsnWSndOXkBTdPwCT5qg39EMRe8IZPdo3kzQwBQJCDcA
         3LfpVp6B5Ua4Z11wn3xESWu+CQgFscxaE1qWW/TT7qqd6/6bjqPDKYplAQ4kv4h1lv0R
         mJAd5YRbV2vczxRExpaYmpDM8Xf1A63Sezd1/uA8XBs0oWDOVh9UDqn/mwXh6NR8xiUZ
         2+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793704310; x=1794309110;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DRSP5dNsS3mHl0mDMeYY/G8SJ9kad2UxpOHnBXBI684=;
        b=YEHaVHWl47cJenjvc6jTJB/GWk36gYsfcQ0aKts94jsz1QAJam91YQFks4z6FKZ39U
         1nP2IdkGpyOuVHWzhqru7KzkN70/Xr3nbTTXGhGQM0SK6xuWa/Ad1WVX0w1iLPvSSThV
         xOVAust4h7lAbZlZ4h4RiFqlZ0sq9+PnmEWutoHXJvt6BLUocobu9kD10GhCkt23Qb4H
         DtZiKsFW0IFmiR2NVsx6OCYkZ3zXczfauztiJqODF+FjoVyezTveJpeD37o3ZkAHaPJ7
         DR8JZfCmv2MJ4UU5xrFIwLxW9l0lqtW+i3Nc9/o35Z0dHycJpJBE4GD+vZc83ZKX/W1W
         k2sg==
X-Forwarded-Encrypted: i=1; AKwUvBwMEF4TzZDc14GW3x3V4N+A55STX631PAY5C7pOxSkJS55iM7W/pOItzU8EgjR2E6emojt0dfnXT2gZK1WeS+5wHQQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xo4qDi6XkRQCQPmngdHCJ5Km24v4Pa+BFlfRxykQR2Z5sGXPq
	bpUijV84BUZXBHWiNTxLqMb8+zGfjeJJQvhhdCtK8gO9ge9espU3y/XxkzOmoMvvL0Y=
X-Gm-Gg: AYBFou26+ii9iDLKIPMUPEo0BFZlJXPmx70vUf2zAixzhiCffbC14ET3l+01dTNJvXp
	ZMxbF8xrvaI+XqC5+5hI8Z9bJkgrAm+wfTDgBzFTWcM9aWskcVz0dCEnSaGG0RjyER3TNX78PUc
	ISacrFRNFPXB02Y3i2URKiPZTyQKMHE92Bo4cLMzm9bVXv7JVo/c22znArDg4DN4f8GLtkfQjnD
	AIVdKKci6qRtZmr4m9TH1JHHhzTFqgrZ8y361WIcz8nSKylauEgwSJ4IB+Wd4862x32xH+Vpwcv
	cuKvYjuedQG6yCQ7J2JNvGB04EpxJ/3gSrqtmDabfFkMwj1wZiZ/hfm6sXZm+pucujuRjIotHBd
	4bsvre+JpVvzh8fZK54YMirk3S4rm/8LBrolrBa7i82194utxvy7KTpKkohMpQ4iXFGV6dNDsMK
	jVjn4yDJzG62seFubPPHoI4MMbgjXYvVLC4G9zaTv06QX0rmT+SXchaXczdedwDs9YeI76UVCHl
	xhLLJC1/byFwVydOJqvyzscd30TGVjvia3Z6DWDq6RC9H7WiZ30azQKdQBIPV1t63sXMIUGMphi
	QZIVQ1Lmkyhbhn702nOk2CMCdgtb1K8YglNUabw/kgxd7iaAeRU=
X-Received: by 2002:a05:6000:22c8:b0:48e:2c2f:59eb with SMTP id ffacd0b85a97d-48e6e303c74mr28712071f8f.12.1793704310107;
        Tue, 03 Nov 2026 03:11:50 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78c10sm24062838f8f.25.2026.11.03.03.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 03:11:49 -0800 (PST)
Date: Tue, 3 Nov 2026 12:11:47 +0100
From: Petr Mladek <pmladek@suse.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: John Ogness <john.ogness@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>, Naveen N Rao <naveen@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/3] probes: Use trace_printk() in probe handlers
Message-ID: <aunBcxXXNhXDd-U5@pathway.suse.cz>
References: <179360345418.115681.193455787480210412.stgit@devnote2>
 <20261102123408.0fb950bf@gandalf.local.home>
 <871p9251ve.fsf@jogness.linutronix.de>
 <undine-1793671566795563056-fb7169cffcc7ac3c@undined.local>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <undine-1793671566795563056-fb7169cffcc7ac3c@undined.local>

On Tue 2026-11-03 11:06:06, Masami Hiramatsu (Google) wrote:
> On Mon, 02 Nov 2026 23:07:41 +0106, John Ogness <john.ogness@linutronix.de> wrote:
> > [ Cc'ing Petr Mladek ]
> > 
> > On 2026-11-02, Steven Rostedt <rostedt@goodmis.org> wrote:
> > > [ Cc'ing John Ogness ]
> > 
> > Thanks.
> > 
> > >
> > > On Mon,  2 Nov 2026 16:10:54 +0900
> > > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> > >> Here are patches to update the probe sample code to use trace_printk
> > >> instead of normal printk. Since the fprobe and kprobe/kretprobe handlers
> > >> can be called from somewhere where console is locked, using printk() is
> > >> basically unsafe. Only the unoptimized kprobe on x86 is safe because it
> > >> is ran with NMI context (in this case, the kernel uses printk_deferred()
> > >> automatically), but optimized kprobe/kretprobe/fprobe are not.
> > >
> > > I don't think printk() is unsafe in these situations anymore.
> > 
> > Since we still support legacy consoles, it is true that printk() is not
> > safe in these contexts when a legacy console is registered.
> > 
> > However, the printk_deferred() variant _is_ safe from any context. Once
> > we convert the legacy consoles (including boot consoles) to nbcon,
> > printk_deferred() can become printk() and still be safe from any
> > context.
> 
> Got it. But since printk_deferred() is not exposed to modules,
> these sample modules can not use it. (printk_deferred_enter/exit()
> are also not exposed.)

We could export it if it would be useful for kprobes...

> > It is misfortunate to add documentation saying printk() is not safe,
> > since the problem is converting the remaining legacy consoles. But we
> > can cleanup all such documentation later once the legacy consoles are
> > gone.
> 
> So, until it is done, this series is valid. Please let me know it.
> After that version, I can revert these.

I do not have strong opinion here.

It just looks to me that using trace_printk() everywhere is an
overkill. It is true that printk() is not safe when probing some
locations, e.g. where a console is locked. But these are locations
where you could not use printk() even in the probed code.

I believe that trace_printk() has a similar problem. You could
not use it inside the code used by trace_printk() because
it might cause an unbound recursion.

I agree that the scope of the code used by trace_printk() is
smaller than the code used by console drivers. Also it is better
located. And maybe, the recursion can be even detected and handled.

But still, the point is that even trace_printk() is not a 100%
safe cure. So, maybe, instead of proposing trace_printk() everywhere,
it might be enough to propose it only for probing the printk/console
related code. Well, I know that it involves also some less obvious
areas, for example, irq_work, some timer and scheduler code.

That said, I do not want to block this patchset. It is solving
some real problems...

Best Regards,
Petr

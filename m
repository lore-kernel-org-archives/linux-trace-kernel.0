Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794943330;
	b=B73Gni1Y9+Y0xQ9DgkCW2RRivlQBT2OxoeWubx2h1Qd8mydokP3i1/qu5BdwBDhPcaOE
	 AkqT6cA2SLwxOkkGD/poYB2pzQE8nYyhayNTUSa8t9/0miqXpOS7O5+xjJRNtSXDjnxVm
	 CbX0lbvIYlJCFmCqzt89iONpVFouryd+A2K6YZ9/v7g1fTIq3CXWYUPGXuZguT4lUnVTK
	 +TnN9oaLh3LdMUP3FakkFEdV3qIrwca0QiXTCq/3+XcANO8QffdqQmmsh2jkzGHH3ccfD
	 8kj9JQQETkSLMHbPlJxgZSHKbJBaviWnMntrzz25xmSv17P5nEGyk8jEVUKTVqD+Jew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943330;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Spam-Status:X-Rspamd-Server:
	 X-Stat-Signature:X-Rspamd-Queue-Id:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=mSnaBEqU7m7cNIvU+OxFJCwKi9iAcV4LhJSJ8WZpjwA=;
	b=1Wf7ZxaIwqsOuqoY9FKh5L2QDpy8MJ8Y443U6mP4ZfDU6Rs3/FTWdB/cGGYll/Ghn+CF
	 EbvGpkIdqHwU82p29o+ATFiqwTeRhkKUNFGSKhmr5KEisVVO5mqy8NJk4KCOjR0OgIt0l
	 VDX30MXILczD0HKxoTvFN90vPXvJVwvC8RwzfE+zASR8czWEhMM1LWI7xq2L+hhE8RBXC
	 u4mHMxahrjSfDzW0/cKYn2ApU6KyOzurVLQARdHeg9HEEQEmScqan4fo0H58DZSx+Pcic
	 +oSfTF6D4N8X3i7YoLKRjYUfFcRwpqnHQO739DqKG8Var/ufT4PaKAe5lu/rBuc/Zrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=Arecht6A;
	arc=none smtp.remote-ip=216.40.44.16
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83738606A33A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 19:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83738606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=Arecht6A
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 24C84C0570;
	Tue, 17 Nov 2026 19:22:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 5B30920029;
	Tue, 17 Nov 2026 19:22:06 +0000 (UTC)
Date: Tue, 17 Nov 2026 14:22:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Brian Norris <briannorris@chromium.org>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: 'select' GENERIC_TRACER, not 'depends'
Message-ID: <20261117142203.72235895@gandalf.local.home>
In-Reply-To: <avybp3O2zxcLozKB@google.com>
References: <20261116144652.1.Iecb63200dd245f62032a3b1f60ae78cc48868094@changeid>
	<sashiko-outbox-217828@kernel.org>
	<20261117085552.0e4ef272@gandalf.local.home>
	<avybp3O2zxcLozKB@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Stat-Signature: kdjbgfd3henwxsuoooanfepm8xr3pbg3
X-Rspamd-Queue-Id: 5B30920029
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+Ewq1CS2ih595Uko795jGOIGp3SiT6fYc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=mSnaBEqU7m7cNIvU+OxFJCwKi9iAcV4LhJSJ8WZpjwA=; b=Arecht6AVcZZo+yHETjMee17lrX6fxh0m8UK5SpffsI7bE4pY8VqSXFFp52dUyOPmFlEbMj8wHchTo0EOzBzAZLuIbolyI9SzEYtTsXHrTKNhk0zNJSpuVmGT6DSVlCnnPzW0pbL1pLPuY7e+RwZIJXczWiFO/KmdB7Um6SWQG8=
X-HE-Tag: 1794943326-672865
X-HE-Meta: U2FsdGVkX1/+MFLDKaske4c+kpP+T1ia0Yr73x+bfHBVlAGmFheqkHlwSPNk/AsPEyu8MGxrlRsk+7u3r56uGSNKD7hsHlee7Wf2yBX1RNuIO5Hs7Oj3HmXueqEsnnaZqfZjIJPfO3JUv2hekUo6bXCQ5B79YyeNE2kNd5Q/TSHQ/KR2OI4Kk9HZLBwtJUgniPZOKxp4KfC/2j+hmju5Kt/fetSe+lQth/vmW4qBfgj/cd1/4ZgZvXTBmbqE9I5W15EkAF3xln+rAo38CGzP7jk8dKaVuTsxCnPc4tHDY4lqVFEdLMKajrONgXhP/S/8lBNZmMPA3ZoUSS/r0Ea7Ojy3Xb2HFZkj

On Tue, 17 Nov 2026 10:23:35 -0800
Brian Norris <briannorris@chromium.org> wrote:

> 
> OK, I can respin with 'depends on TRACING'.
> 
> However, I think the Kconfig setup for kernel/trace/ is still a bit
> haphazard. For example, it's reasonably common to want EVENT_TRACING but
> not the more invasive tracing (like FUNCTION_TRACER; and therefore no
> GENERIC_TRACER) -- this is how all Android kernels are built, for one.
> 
> But there's no user-configurable way to enable EVENT_TRACING. We only
> get it implicitly if something else inadvertently selects 'FTRACE'
> (which selects EVENT_TRACING). For Android, that's CONFIG_KPROBES and
> CONFIG_HIST_TRIGGERS.
> 
> ...or is that what ENABLE_DEFAULT_TRACERS is? Its name doesn't really
> suggest that, and it's mutually exclusive witih many other tracers, so
> it's a bit awkward making choices, as the whole system appears much less
> orthogonal than expected.

Yes, it's the ENABLE_DEFAULT_TRACERS that is what I think you want. It's a
horrible name and should be changed as it's terminology is a left over from
the early days of ftrace where tracers were everything and the "nop"
(default) was the tracer that let you select events. The haphazard way that
Kconfig is set up is due to the evolution of the tracing subsystem where
things evolved through mutations. That Kconfig is just a nice paleontology
case of ftrace.

I think it would be good to rename that specific config, and also move it
to the top of the Tracing menu that says:

  Enable trace events

As all tracers enable events, it doesn't need to be visible when
GENERIC_TRACER is enabled. This is the way to enable events when no tracer
is defined.

> 
> Anyway, my point is that it's not exactly straightforward to enable the
> features you want and get the tests you want.

Yes, lets fix that.

> 
> I've appended a diff that seems a bit more user-friendly to me. It
> makes it more explicit in the menu how event-tracing is forced-on by
> many other tracers, but is user-configurable when it's not forced. I can
> formally submit it (in 2 patches) if you'd like.

Let's do one patch that changes the name and prompt of the
ENABLE_DEFAULT_TRACERS.

Basically:

config ENABLE_EVENTS
	bool "Enable trace events"
	help
	 Select this to enable trace events through out the kernel such as
	 scheduling, irq, kmalloc that can record to the tracefs ring
	 buffer data from within the subsystems the events exist in.

or something like that.

-- Steve

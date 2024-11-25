Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D202B9A8;
	Mon, 25 Nov 2024 05:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732512304; cv=none; b=G1EKcr3Qj45NVHO4ZhQdFePWK9ukbN9nVbx9g/QdXyLD4IJwFTUbyKzjezLbwfzqnlAZfGKdkEHWtNUcUVcaU0AEnb8RXlbDFm+NVh+Pi/kuNOE77RKpTmN3REA1PN6yx/vziYxJgF7vXp5luIxTBz22+6/K/dgFOnAEX26nIg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732512304; c=relaxed/simple;
	bh=F//lT7nKbpwzxdMxwqquKX2LccUTrAmR9tz96g21KXc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Liq7bTnS+uld4sS25WhBrf5MgPK0qcMeC76NcnN1EaAMUyR7sBw8Ck2wtPdYmPzPGdZL5h9zSG4cR6HRuDZbqI6cCP1vSdPTcfp9FAdUEX0svYhWwEWWC3B/4VCLXHYyBT6xk//ZBeg7gYok+8lGNGHL/7KneNbw0uerHP/rSyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3Pv3rCJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3Pv3rCJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E520C4CED1;
	Mon, 25 Nov 2024 05:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732512304;
	bh=F//lT7nKbpwzxdMxwqquKX2LccUTrAmR9tz96g21KXc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O3Pv3rCJ3ie/vQ2I7zUL4P368yiTB3UpUjcqZfqJ6fQjoVz55D5K+L764W9QKXKSk
	 3ud4AdALe91/D6gebK8kI9wCAnNWfBKqaMn+/kugPA2EFX8kgFU+NnFhYsgSFOVGeh
	 6cAGy2FxMZRVK2vSa6lmvGRf2VwQMKTdAFJRwqHH8FHKtjok7FsnFWMToY+QiGNXoS
	 tmHtR7kKxSQ/sJ7ez43+lUHfkj4Q1ZfECbHE2mH2KVgpDzL6zQOPx6tQX7cN7jdxpc
	 XgVaO4d1HgVRkfIvIaAOfFXkDWlRCoM2xR05b3NzyJvx37zeko+jWEBv+clpeLcm8t
	 wIGTCbLzmHhLA==
Date: Mon, 25 Nov 2024 14:24:58 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas.weissschuh@linutronix.de>,
 Naveen N Rao <naveen@kernel.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Masami Hiramatsu <mhiramat@kernel.org>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] kprobes: Reduce preempt disable scope in
 check_kprobe_access_safe()
Message-Id: <20241125142458.9ed23f07da4eaf732cfa9a8e@kernel.org>
In-Reply-To: <20241121080432.ysLlZsSP@linutronix.de>
References: <20241121-kprobes-preempt-v1-1-fd581ee7fcbb@linutronix.de>
	<20241121080432.ysLlZsSP@linutronix.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 21 Nov 2024 09:04:32 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2024-11-21 08:38:08 [+0100], Thomas Weißschuh wrote:
> …
> > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> 
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks for your review!

> 
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index da59c68df8412c4662d39d3e286d516e8cee9a69..369020170e832a34ea9c05eda6693bded02ec505 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -39,6 +39,7 @@
> >  #include <linux/static_call.h>
> >  #include <linux/perf_event.h>
> >  #include <linux/execmem.h>
> > +#include <linux/cleanup.h>
> 
> This hunk can be dropped. The definition for guard(preempt)() comes from
> preempt.h.
> 
> >  #include <asm/sections.h>
> >  #include <asm/cacheflush.h>
> 
> Sebastian


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025771E1A2B;
	Wed, 19 Feb 2025 08:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954216; cv=none; b=H9BWxrXuuXRnz8gt0WVErAXf4oA9zDTLZBKJyE/CPSeqlwKrvWWfBfFmjE/ZwBNo1v3GguOLTWq78JhrmYPvTaungQgXkeyE/qb85O/7Qaj0tLLq9TT7Ek+d3yrb91Oke3h0uvzosQSxrTp2SLzDURzwNblkxBjP2aekVNBkZbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954216; c=relaxed/simple;
	bh=rgJvidjAQMDoQVWGBwJ2leXpTN2OG2+kgUkDZ7AeZQQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JAGhon7zgdoBesQg74pe039NtA0Tt8wnU3bw86CRtVAtrF/KxmdzJSfYTnatnIqoynjHc9pppDr+x4fxLSnw2uKduL1lqJsyvjRf9/Ti0cSb3IUUwK8ECkbFP9dc10JpIUl2GnSrt6QClRcFueM+/z7snLcdb6nlPAGJeAh/8SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNj/xDKj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNj/xDKj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93432C4CED1;
	Wed, 19 Feb 2025 08:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739954214;
	bh=rgJvidjAQMDoQVWGBwJ2leXpTN2OG2+kgUkDZ7AeZQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kNj/xDKjpNDb/OyA58zXZSI/uowZdiwP3jlGB0BsxCp/GZY+e5QsVeA7f7ecNP4YU
	 r7GBP0/GW0yFUmRdYKQyND0fjqmVBWtT8/kkYq0qBWQcFz8eZ3lInPWKy/xXO5hU0P
	 lbrGs6+3zhuIAsokBOVuQg0p9yX46gFFqxgb/22T8bYI+bfKuK7rNxT4gzAEgkI5UV
	 VSeiIAfeCEvgBFH1pnlTf4eTEw0HPAJ38cUkKb1YvS4F8kJ4rJvnNG6vUttO9i3a1c
	 anyxhXUOvP5yni6wnAEIe7u3426OVqYxkwdpVNN64g7gNWf/N1W9oKvx6QXx9Qe7K2
	 21YMRo4iWIfPQ==
Date: Wed, 19 Feb 2025 17:36:52 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas.weissschuh@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/user_events: Don't use %pK through printk
Message-Id: <20250219173652.183b22ff533301c5206b9743@kernel.org>
In-Reply-To: <20250219081236-812a157c-5c60-41af-a7c8-f75f9da5e92a@linutronix.de>
References: <20250217-restricted-pointers-trace-v1-1-bbe9ea279848@linutronix.de>
	<20250219091023.f17833aea92a3d90e1bbc7da@kernel.org>
	<20250219081236-812a157c-5c60-41af-a7c8-f75f9da5e92a@linutronix.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 19 Feb 2025 08:14:34 +0100
Thomas Weißschuh <thomas.weissschuh@linutronix.de> wrote:

> On Wed, Feb 19, 2025 at 09:10:23AM +0900, Masami Hiramatsu wrote:
> > On Mon, 17 Feb 2025 14:16:12 +0100
> > Thomas Weißschuh <thomas.weissschuh@linutronix.de> wrote:
> > 
> > > Restricted pointers ("%pK") are not meant to be used through printk().
> > > It can unintentionally expose security sensitive, raw pointer values.
> > > 
> > > Use regular pointer formatting instead.
> > > 
> > > Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/
> > 
> > This is only for the kernel pointer, but the "uaddr" below means it
> > has a user space address. So I think this does not need to be applied.
> 
> "uaddr" is formatted with %llx, which is fine.
> "%pK" is used for mm->mm, which is a kernel pointer.

Oops, I misread it. OK. looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>


Thank you,

> 
> > Thank you,
> > 
> > > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> > > ---
> > >  kernel/trace/trace_events_user.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> > > index 97325fbd62836f4fb477c4a2b2936eff544291ec..3effc6fce20e65a8077de5221eb69db04fb1a775 100644
> > > --- a/kernel/trace/trace_events_user.c
> > > +++ b/kernel/trace/trace_events_user.c
> > > @@ -455,7 +455,7 @@ static void user_event_enabler_fault_fixup(struct work_struct *work)
> > >  	if (ret && ret != -ENOENT) {
> > >  		struct user_event *user = enabler->event;
> > >  
> > > -		pr_warn("user_events: Fault for mm: 0x%pK @ 0x%llx event: %s\n",
> > > +		pr_warn("user_events: Fault for mm: 0x%p @ 0x%llx event: %s\n",
> > >  			mm->mm, (unsigned long long)uaddr, EVENT_NAME(user));
> > >  	}
> > >  
> > > 
> > > ---
> > > base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
> > > change-id: 20250217-restricted-pointers-trace-a0fb12707ac6
> > > 
> > > Best regards,
> > > -- 
> > > Thomas Weißschuh <thomas.weissschuh@linutronix.de>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

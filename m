Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC185336D;
	Wed, 12 Jun 2024 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718201388; cv=none; b=a9JVnSdzZQhIZt+Ef6+0jy1gVu6BIL+aznoIyFzfB7foJ11SoJ5MtFcHhzYsRJjxffdMyR/7StCWkHM5qaaym42GezPybZ7A0TKMPfi1kcgTJHvm6rad7xS4HkL5qEpbPQXkMSBX54YRRZeDR1LmolagZ7AIlP2AgvTzFwiHSPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718201388; c=relaxed/simple;
	bh=II/NbhnYcdYmV79okBAT6ronkbwY9LssX0rkK2/jFYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wxu0jU5kyth4VxQavCyO4FoQkUQrsH2NW70feMII77aQ15StLhsmHGPD2SVNNDFiAIEtGh92e7WNd/xXxBGsoi6OwOCdV7kQBNxfgZJtngBUqtf6R2vwIqeEmT3qnSHYPZctytnBB+w1ZTIzN1RPWgg5BBuISkE2fAu/+YVhSYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=VFuu2Wwj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="VFuu2Wwj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7D4C116B1;
	Wed, 12 Jun 2024 14:09:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="VFuu2Wwj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1718201384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sp4kuln6csh80is8raFd9JuQeBE6LYfogahL+0jpLZs=;
	b=VFuu2WwjHV79Ftcbh7MPyFzpURb23M2Q8GuLu1yfrurEKnnPfVq67aRQjUcnc6pG7iF9Fz
	uVoB+nZR2nX6+c0ItUORM/GdfNQtMLltNs5JmOX74vBFe+zjQadH2pnpdOkcFnkBTZXF9s
	v/CYDvOwV2LPGahQixqcoChvchvtCxo=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 50eb8ae5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Jun 2024 14:09:43 +0000 (UTC)
Date: Wed, 12 Jun 2024 16:09:40 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Greg KH <gregkh@linuxfoundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	kernel-janitors@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	"workflows@vger.kernel.org" <workflows@vger.kernel.org>,
	Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH 05/14] tracefs: replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
Message-ID: <ZmmsJFDmnbjngRNV@zx2c4.com>
References: <20240609082726.32742-1-Julia.Lawall@inria.fr>
 <20240609082726.32742-6-Julia.Lawall@inria.fr>
 <20240610112223.151faf65@rorschach.local.home>
 <b647eacd-f6f3-4960-acfd-36c30f376995@paulmck-laptop>
 <20240610163606.069d552a@gandalf.local.home>
 <70c093a5-df9c-4665-b9c9-90345c7f2139@suse.cz>
 <2024061143-transfer-jalapeno-afa0@gregkh>
 <05ec743a-c4e9-4c66-b2cd-4e89c858d7d4@suse.cz>
 <20240611101458.7fa78da8@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240611101458.7fa78da8@gandalf.local.home>

On Tue, Jun 11, 2024 at 10:14:58AM -0400, Steven Rostedt wrote:
> On Tue, 11 Jun 2024 10:42:28 +0200
> Vlastimil Babka <vbabka@suse.cz> wrote:
> 
> > AFAICS that documented way is for a different situation? I assume you mean
> > this part:
> > 
> > * Specify any additional patch prerequisites for cherry picking::
> > 
> >     Cc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle
> > 
> > But that would assume we actively want to backport this cleanup patch in the
> > first place. But as I understand Steven's intention, we want just to make
> > sure that if in the future this patch is backported (i.e. as a dependency of
> > something else) it won't be forgotten to also backport c9929f0e344a
> > ("mm/slob: remove CONFIG_SLOB"). How to express that without actively
> > marking this patch for backport at the same time?
> 
> Exactly! This isn't to be tagged as stable. It's just a way to say "if you
> need this patch for any reason, you also need patch X".
> 
> I think "Depends-on" is the way to go, as it is *not* a stable thing, and
> what is in stable rules is only about stable patches.

How does "Depends-on" not spiral out of control? There's a *lot* of
"Depends-on" relations one could express in commit series and such. Of
course a lot of git itself is designed to show some subset of these
relationships.

It seems like in most cases, the "Cc: stable@v.g.o # x.y.z+" notation
expresses the backporting safety correctly. What is the purpose of
saying, "if you need this patch for any reason, you also need patch X"?
Who is the intended audience, and are you sure they need this?

I ask these questions because I wind up doing a lot of work backporting
patches to stable and marking things properly for that or submitting
manually backported stable patches and so forth, and in general, patch
applicability for stable things is something I wind up devoting a lot of
time to. If I have to *additionally* start caring about the theoretical
possibility that somebody in the future, outside of the stable flow,
might not understand the context of a given patch and blindly apply it
to some random tree here or there, that sounds like a lot of extra brain
cycles to consider.

So, is this actually necessary, and how does it not spiral out of
control?

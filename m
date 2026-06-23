Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21AA3CD8A9;
	Tue, 23 Jun 2026 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782203381; cv=none; b=UJ96Q+qLttKkOAMRajE4czKFinzacEt3L039QvRKhp64ZCVWhP50i3FtrFk3SRCIQhsp5W40zgKdvAUutDM8oUJIY3817GBmyzMllZ9JKfjdT1dWYZ1Ka+xC/Y0OihQl17M5BujDdoHSgnnzEt2RUWsIQx2V3o8gcIjnNV4jQOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782203381; c=relaxed/simple;
	bh=+Es/HjA6p2ThlSElIC53ivnKMmaCSzs3bzzCxWLJp/U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7aPU/rV5JbYdXS0JLI1v9oaG1KNSN5YSEqsmB67JlVV/XywmtDZdm3pAZaAQ1B2hq84U9l7v8FhsOghi9Cvlh49P8ufxKcd7tnrvLCPKg+qHOOi93StZmBsyWLNWiHBmdRAuxHag5yDTcDWokwc1wz1ieu2D5MzHkxjKbgilo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jo9YTVVL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jo9YTVVL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D31A1F000E9;
	Tue, 23 Jun 2026 08:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782203380;
	bh=6iFLpGepw9QHsSE1YK+EzzxNFwR2t/cAyuSVgcj/E/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Jo9YTVVLZDMdY5D1PlppChby+aivW0xrUO59H/B0ZC+BUvYn4QAvaOnVy29REjb38
	 em510881EQuVDISvWrlzIgoJdVWq8FrVhWVG6/nZ5QKskrGX5ziflpTJl2MFzBg4XB
	 iaLnfBxVTozMdllf6oNncfO7ogLp7qbUr14ssLSz4KMrMaVOz2pfdrwLpuaf+Y0EZO
	 h2/6nvEaaOX5bFOLTJLNJylrsa5Zp3XPDN+vgbj8XvrVs7sZYKAyBkP6uGtmfsiBqB
	 1RtZdvUWbAJOQrA8ruzYnRvh8KhEmNcxDqw3HTIcyzOz1rLP2Nj3OnhmtAUsXQ3w9R
	 X1SMxUMjPfWeA==
Date: Tue, 23 Jun 2026 04:29:35 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Thomas
 Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Julia
 Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH v2 2/2] tracing: Remove trace_printk.h from kernel.h
Message-ID: <20260623042935.3245a567@fedora>
In-Reply-To: <ajlcOU1o5Omy4q57@yury>
References: <20260622130739.375198646@kernel.org>
	<20260622131029.816825024@kernel.org>
	<ajlcOU1o5Omy4q57@yury>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jun 2026 12:01:05 -0400
Yury Norov <yury.norov@gmail.com> wrote:

> On Mon, Jun 22, 2026 at 09:07:41AM -0400, Steven Rostedt wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > There have been complaints about trace_printk.h causing more build time
> > for being in kernel.h. Move it out of kernel.h and place it in the headers
> > and C files that use it.
> > 
> > Link: https://lore.kernel.org/all/CAHk-=wikCBeVFjVXiY4o-oepdbjAoir5+TcAgtL12c4u1TpZLQ@mail.gmail.com/  
> 
> Link is nice, but can you explain in the commit message what those
> complaints exactly are? There's enough opinions shared to make a nice
> summary. I even think it's important enough to become a Documentation
> rule.

What rule is that?



> > @@ -35,6 +35,7 @@
> >  #define I915_GFP_ALLOW_FAIL (GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN)
> >  
> >  #if IS_ENABLED(CONFIG_DRM_I915_TRACE_GTT)
> > +#include <linux/trace_printk.h>  
> 
> So, before it was included unconditionally, now it's included. It
> looks technically correct, but conceptually - I'm not sure.
> 
> I'm not a developer of this driver, but ... here we need trace_printk.h
> if TRACE_GTT is enabled, in the next header TRACE_GEM needs it. To me
> it sounds like the whole driver simply needs trace_printk.h.

I just added it when trace_printk() is being used. Why else should it
be included when trace_printk() is not used. There's precedent to add
includes within #if blocks that contain code that requires the include
where nothing else needs it.

> 
> >  #define GTT_TRACE(...) trace_printk(__VA_ARGS__)
> >  #else
> >  #define GTT_TRACE(...)
> > diff --git a/drivers/gpu/drm/i915/i915_gem.h b/drivers/gpu/drm/i915/i915_gem.h
> > index 1da8fb61c09e..f490052e8964 100644
> > --- a/drivers/gpu/drm/i915/i915_gem.h
> > +++ b/drivers/gpu/drm/i915/i915_gem.h
> > @@ -117,6 +117,7 @@ int i915_gem_open(struct drm_i915_private *i915, struct drm_file *file);
> >  
> >  #if IS_ENABLED(CONFIG_DRM_I915_TRACE_GEM)
> >  #include <linux/trace_controls.h>
> > +#include <linux/trace_printk.h>
> >  #define GEM_TRACE(...) trace_printk(__VA_ARGS__)
> >  #define GEM_TRACE_ERR(...) do {						\
> >  	pr_err(__VA_ARGS__);						\
> > diff --git a/drivers/hwtracing/stm/dummy_stm.c b/drivers/hwtracing/stm/dummy_stm.c
> > index 38528ffdc0b3..784f9af7ccba 100644
> > --- a/drivers/hwtracing/stm/dummy_stm.c
> > +++ b/drivers/hwtracing/stm/dummy_stm.c
> > @@ -14,6 +14,10 @@
> >  #include <linux/stm.h>
> >  #include <uapi/linux/stm.h>
> >  
> > +#ifdef DEBUG
> > +#include <linux/trace_printk.h>
> > +#endif
> > +  
> 
> Same here. The cost of adding the header in a particular C file is
> unmeasurable. But playing "#undef DEBUG #ifdef DEBUG" games looks
> weird.

This one I'll agree with you. I didn't like the if conditional, and
looking at it now, I think it's not needed.

But the first instance above, if it is possible to add the include
within the #if conditional where trace_printk() is used then why not add
the include then?

-- Steve

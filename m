Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227713C3443;
	Wed, 26 Aug 2026 10:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787740777; cv=none; b=tPWYZe7qK7+iwmCR7RUxsQfg6oBqIkP3ewC0LQP8ECdY9C2reIUQle2V9Obmyo6EJDOgmIr6abg6ul5U9W8bzOCLHt/TiVQdGE5wTa7Jo31qjXX0yg7S31jKdi9A240CDPtOFY833/UQBJZa4lXYucRZzqO7MIzPacO22hG4w9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787740777; c=relaxed/simple;
	bh=lsfrT6W7MF1eyf3t4iO/aLVY7FrpRRms3ijhdJLYlHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhdbcUO2PuSlAsyAdsCWgUqshBN2WyROhv3FNl08nMLPweEgTV5A7QWlNy/AKo7A8Iocdd/SPdZ1AzEE/LTbTUISalADJDuds2nW9p6mko4IjLj6cDidLMJUmew6T09/YupeTid3rZPuPjl5DISY3rgpNQidSO5Pn0m+kXhma4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W8++ncOs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W8++ncOs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFEC1F000E9;
	Wed, 26 Aug 2026 10:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787740775;
	bh=ZT89CCYmEHcWFi4+KZk7/msqAsn5hkFkwUOFG+vDx1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W8++ncOsfbjpsAg2GjsL/bKW4BOm+UPAO6mt/EJgSU3NoibzxUeVRE0DTO9Rm6eHZ
	 y81tImk7OjlF0Q5oJ+93NfdEma3oHAWP/sVial98Cv48C0YNkQE0nmUMRUKFGd1/5T
	 /Nj8l10S0PtZDwnPOwMEvkGHFa5khhc8kOo6ZY8g=
Date: Wed, 26 Aug 2026 12:39:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH 1/2] module: pull out add_taint_module() to be public
Message-ID: <2026082652-thigh-backtrack-d2fc@gregkh>
References: <20260826-bind_taint-v1-0-52b05f4a965c@linuxfoundation.org>
 <20260826-bind_taint-v1-1-52b05f4a965c@linuxfoundation.org>
 <20260826102921.5B81B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826102921.5B81B1F000E9@smtp.kernel.org>

On Wed, Aug 26, 2026 at 10:29:20AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Potential NULL pointer dereference in `add_taint_module` if called by built-in code passing `THIS_MODULE`.
> - [Low] Syntax error in the `!CONFIG_MODULES` stub for `add_taint_module` causes an unconditional build failure due to an undeclared identifier.
> --
> 
> commit 371e790be5ebdf80163e6326d6a8f79c05f469bb
> Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> module: pull out add_taint_module() to be public
> 
> This commit makes add_taint_module() public so other kernel code can call it.
> It also provides a fallback stub that simply calls add_taint() when modules
> are not enabled.
> 
> > diff --git a/include/linux/module.h b/include/linux/module.h
> > index 96cc98568eea5..25221539e6459 100644
> > --- a/include/linux/module.h
> > +++ b/include/linux/module.h
> [ ... ]
> > @@ -877,6 +880,11 @@ static inline bool module_is_coming(struct module *mod)
> >  static inline void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data)
> >  {
> >  }
> > +
> > +static inline void add_taint_module(struct module *mod, unsigned flag, enum lockdep_ok)
> > +{
> > +	add_taint(flag, lockdep_ok);
> > +}
> 
> [Severity: Low]
> Is this a build regression when CONFIG_MODULES is disabled?
> 
> The third parameter in this stub specifies the type enum lockdep_ok but omits
> a variable name. The function body then passes lockdep_ok to add_taint(),
> which resolves to the enum tag rather than a local variable, causing the
> compiler to halt with an undeclared identifier error.

Ah, missed this, will do a v2 with this fixed, my bad.

> >  #endif /* CONFIG_MODULES */
> >  
> >  #ifdef CONFIG_SYSFS
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index d0e1e0bd2ad06..99cedb9618988 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> [ ... ]
> > @@ -191,8 +191,17 @@ static inline int strong_try_module_get(struct module *mod)
> >  		return -ENOENT;
> >  }
> >  
> > -static inline void add_taint_module(struct module *mod, unsigned flag,
> > -				    enum lockdep_ok lockdep_ok)
> > +/**
> > + * add_taint_module: add a taint flag if not already set for a specific module
> > + * @mod: pointer to the module that caused the problem
> > + * @flag: one of the TAINT_* constants.
> > + * @lockdep_ok: whether lock debugging is still OK.
> > + *
> > + * If something bad has gone wrong, you'll want @lockdebug_ok = false, but for
> > + * some noteworthy-but-not-corrupting cases, it can be set to true.
> > + */
> > +void add_taint_module(struct module *mod, unsigned flag,
> > +		      enum lockdep_ok lockdep_ok)
> >  {
> >  	add_taint(flag, lockdep_ok);
> >  	set_bit(flag, &mod->taints);
> 
> [Severity: High]
> Is this a regression that could unconditionally dereference a NULL pointer?
> 
> If built-in code calls this function (for example, passing THIS_MODULE which
> evaluates to NULL for built-in modules), mod->taints will be accessed without
> a standard if (mod) safeguard. 
> 
> This could lead to a fatal page fault if, for instance, a local root user
> writes to a built-in driver's bind or unbind sysfs file which then calls
> add_taint_module(drv->owner, ...).

Oops, missed this one too, I only tested this with a module, not a
built-in driver.  Will fix it up for v2.



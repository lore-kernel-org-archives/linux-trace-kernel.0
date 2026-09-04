Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092A2175A9D;
	Fri,  4 Sep 2026 12:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788524508; cv=none; b=f/DYKgOf3sdEFtlRGGk1XFO7x/yaHZQ7aAlDy65lqcDr3euL7yhuNvT/pJ4PGw5LZ8ApnnYtVUZ8Ljt40Gty4ngUp6MrILDZMN6L2SQHwhZqYXhYhEiayJfJqbZ6Xhi4mC7TdmhMvoOuRs23BruNg8J6i4r90UC7Q036WACAni4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788524508; c=relaxed/simple;
	bh=dGEwsl/QZPhzvlA+Mi/r76rmR6CKptJayLW6wdJ2m34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMWXxUwciM8KHX6iBG3U2r/Urag9dI7GBAXraBMj75kVDCRfVDuinA9xeNEq7vfsV++dznQyFlFPPk2ylSdin1k/7juNXsIdysgIntKayhj+j4skqMAfbTnhQM1kpDgBDOBAQ7J5roeC6DBCjseScJqTB4Yv/x+X4ypxakcsjWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YS/gc8PL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YS/gc8PL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78D91F00A3D;
	Fri,  4 Sep 2026 12:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788524505;
	bh=n0Ai26c+BBRDL6nXffU6QVI3E3AyrZw/QywDCntvJXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YS/gc8PLWOxND3JfXW3uxDEITVnYv+tTnEDDPxhxeMRAKYroLEr8inBUP4WK83rLR
	 zIuRyMuxYnD4xgXAcW3s4VF3Rjg7Vk8ZCHLprV0IdH+sEdREfcApZUE5zElmq0d84y
	 NKrVJpBZEQUgErkhyHtAkmB7fXdZrRXKLnHckniA=
Date: Fri, 4 Sep 2026 14:19:59 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Bradley Morgan <brads@mainlining.org>,
	Aleksandr Nogikh <nogikh@google.com>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-usb@vger.kernel.org, driver-core@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v3 1/2] module: pull out add_taint_module() to be public
Message-ID: <2026090432-outlying-glitch-9295@gregkh>
References: <20260904-bind_taint-v3-0-30025465f38a@linuxfoundation.org>
 <20260904-bind_taint-v3-1-30025465f38a@linuxfoundation.org>
 <a79a6a06-cc48-4036-882d-95e9b4cc01cf@suse.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a79a6a06-cc48-4036-882d-95e9b4cc01cf@suse.com>

On Fri, Sep 04, 2026 at 11:25:01AM +0200, Petr Pavlu wrote:
> On 9/4/26 7:10 AM, Greg Kroah-Hartman wrote:
> > Other kernel code might want to call add_taint_module() so pull it out
> > and make it global.  If modules are not enabled, this defaults to a call
> > to add_taint(), so all is fine.
> > 
> > Reviewed-by: Johan Hovold <johan@kernel.org>
> > Tested-by: Johan Hovold <johan@kernel.org>
> > Reviewed-by: Bradley Morgan <brads@mainlining.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  include/linux/module.h | 10 ++++++++++
> >  kernel/module/main.c   | 16 +++++++++++++---
> >  2 files changed, 23 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/module.h b/include/linux/module.h
> > index 96cc98568eea..f6f90cd88f15 100644
> > --- a/include/linux/module.h
> > +++ b/include/linux/module.h
> > @@ -29,6 +29,7 @@
> >  #include <linux/srcu.h>
> >  #include <linux/static_call_types.h>
> >  #include <linux/dynamic_debug.h>
> > +#include <linux/panic.h>
> 
> Note that I'm working on cleaning up linux/module.h to reduce its
> preprocessed size. The main motivation is to shorten the compilation
> time of all the small *.mod.c files. Since linux/module.h already
> includes linux/panic.h indirectly, adding this include explicitly seems
> fine to me for now. In the future, I think we should introduce something
> like kernel/module/stubs.c where the CONFIG_MODULES=n variants of
> add_taint_module() and other similar functions can live without bloating
> linux/module.h.
> 
> >  
> >  #include <linux/percpu.h>
> >  #include <asm/module.h>
> > @@ -770,6 +771,9 @@ static inline bool is_livepatch_module(struct module *mod)
> >  
> >  void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data);
> >  
> > +void add_taint_module(struct module *mod, unsigned flag,
> > +		      enum lockdep_ok lockdep_ok);
> > +
> >  #else /* !CONFIG_MODULES... */
> >  
> >  static inline struct module *__module_address(unsigned long addr)
> > @@ -877,6 +881,12 @@ static inline bool module_is_coming(struct module *mod)
> >  static inline void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data)
> >  {
> >  }
> > +
> > +static inline void add_taint_module(struct module *mod, unsigned flag,
> > +				    enum lockdep_ok lockdep_ok)
> > +{
> > +	add_taint(flag, lockdep_ok);
> > +}
> >  #endif /* CONFIG_MODULES */
> >  
> >  #ifdef CONFIG_SYSFS
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index d0e1e0bd2ad0..444d990c9983 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -191,11 +191,21 @@ static inline int strong_try_module_get(struct module *mod)
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
> 
> Nit: The final paragraph is mostly copied from the description of
> add_taint() but I don't think it is quite right. The parameter name
> should be lockdep_ok, not lockdebug_ok and the values are
> LOCKDEP_STILL_OK / LOCKDEP_NOW_UNRELIABLE, not true / false.
> 
> I suggest updating this part for both add_taint() and add_taint_module()
> to something like:
> 
>  * Use @lockdep_ok = LOCKDEP_NOW_UNRELIABLE if something serious has gone wrong.
>  * For noteworthy but non-corrupting cases, use LOCKDEP_STILL_OK instead.

How about I add another patch to the series that fixes up the
documentation for both functions?  They both should be fixed up and I
might as well get them in sync properly.

> > + */
> > +void add_taint_module(struct module *mod, unsigned flag,
> > +		      enum lockdep_ok lockdep_ok)
> >  {
> >  	add_taint(flag, lockdep_ok);
> > -	set_bit(flag, &mod->taints);
> > +	if (mod)
> > +		set_bit(flag, &mod->taints);
> >  }
> >  
> >  /*
> > 
> 
> Otherwise, this looks ok to me. Feel free to add:
> 
> Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

Great, will do, and I'll do a v4 early next week with the documentation
fixes.

thanks,

greg k-h

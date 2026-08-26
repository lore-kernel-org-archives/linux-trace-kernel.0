Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08C83AAF67;
	Wed, 26 Aug 2026 11:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787745259; cv=none; b=FVQpN5GrGN/4BxgHHGY5ANtF75nHy8hxcb3pIMMNCsexbltBLguGfa9FTWHjHcAoqH5y4P3pM96hKe+zFs+PsCRr6xOQLoRBvITlRrEk3WvQFkMxLXl1MuOrpFO01hYLj/3XDNqrQ2Gq3t//NGfy0UrRLHrJOE30g0HLMGpOv1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787745259; c=relaxed/simple;
	bh=2I4V+5nZftFyPygSOefb1nzxpoXWZ0cDxtu+pufa3Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOamRxa+nyNUSrq1AKcCMUcGaJhWFs1H0nZtE7e3l2fhEPwn8iSTHkTMf6R1MY+rKR3vfx6r/LksuQUECUwRz14Hy0sgcbzN336wC0h2Iu3ehMLMRAHCAdy6jCr+6Ao12ZsxVJutj7LrO6bDTHrLe6UuVVB9Nr0v10glTPmbLDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ydHlwx7Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ydHlwx7Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883601F000E9;
	Wed, 26 Aug 2026 11:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787745258;
	bh=zw2nAj6IlO6lwe7kWBG2krhlNtFNkwtviRZlhMibaJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ydHlwx7YiEkk76m3Xmoc7IWEmHxXnoTMom/PQoFao5hKuhrp2yfvu/fV989xxXoFy
	 xU6j3iz1lp2jvoX4laP1mHOJoeho4IF1ISDN0NFg7ryuUfNNu4HO6/Nz5zOoqDu9Yh
	 YhCI+b1BKsA05suxKCumMArw84XfIUH+apcst/dI=
Date: Wed, 26 Aug 2026 13:54:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-usb@vger.kernel.org,
	driver-core@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] module: pull out add_taint_module() to be public
Message-ID: <2026082606-hemlock-aggregate-8b6c@gregkh>
References: <20260826-bind_taint-v1-0-52b05f4a965c@linuxfoundation.org>
 <20260826-bind_taint-v1-1-52b05f4a965c@linuxfoundation.org>
 <lnbvi6d72t7zdc3w7yc34y4hyf6gnuduqpqk4q3vqzypw23j37@5zh62c4wyr6i>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lnbvi6d72t7zdc3w7yc34y4hyf6gnuduqpqk4q3vqzypw23j37@5zh62c4wyr6i>

On Wed, Aug 26, 2026 at 07:13:36AM -0400, Aaron Tomlin wrote:
> On Wed, Aug 26, 2026 at 11:19:32AM +0200, Greg Kroah-Hartman wrote:
> > Other kernel code might want to call add_taint_module() so pull it out
> > and make it global.  If modules are not enabled, this defaults to a call
> > to add_taint(), so all is fine.
> > 
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  include/linux/module.h |  8 ++++++++
> >  kernel/module/main.c   | 13 +++++++++++--
> >  2 files changed, 19 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/module.h b/include/linux/module.h
> > index 96cc98568eea..25221539e645 100644
> > --- a/include/linux/module.h
> > +++ b/include/linux/module.h
> > @@ -29,6 +29,7 @@
> >  #include <linux/srcu.h>
> >  #include <linux/static_call_types.h>
> >  #include <linux/dynamic_debug.h>
> > +#include <linux/panic.h>
> >  
> >  #include <linux/percpu.h>
> >  #include <asm/module.h>
> > @@ -770,6 +771,8 @@ static inline bool is_livepatch_module(struct module *mod)
> >  
> >  void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data);
> >  
> > +void add_taint_module(struct module *mod, unsigned flag, enum lockdep_ok);
> > +
> >  #else /* !CONFIG_MODULES... */
> >  
> >  static inline struct module *__module_address(unsigned long addr)
> > @@ -877,6 +880,11 @@ static inline bool module_is_coming(struct module *mod)
> >  static inline void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data)
> >  {
> >  }
> > +
> > +static inline void add_taint_module(struct module *mod, unsigned flag, enum lockdep_ok)
> > +{
> > +	add_taint(flag, lockdep_ok);
> > +}
> >  #endif /* CONFIG_MODULES */
> >  
> >  #ifdef CONFIG_SYSFS
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index d0e1e0bd2ad0..99cedb961898 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
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
> > 
> > -- 
> > 2.55.0
> > 
> 
> Hi Greg,
> 
> I believe Sashiko [1] found a few valid concerns.
> 
> [1]: https://sashiko.dev/#/message/20260826102921.5B81B1F000E9%40smtp.kernel.org
> 

Yes it did, will fix that up for v2.

thanks,

greg k-h

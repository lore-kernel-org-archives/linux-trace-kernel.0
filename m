Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF32284690;
	Thu, 27 Aug 2026 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787841143; cv=none; b=f/6Pgl/d8CS+Cene98gpbosO4WIsg0AHhcymfvBKWYv0W/lZBDRdwYvYEALFAanhAwdN07rvbydQxHWRlhtjPJMeWfxHV/HWisWa9wI9HAVPcKzvXjWPwNDzWZJIEVXBNkL7sNeYiYOH48Ud5sAlQypqqMVARrbqnpG3WaBdaHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787841143; c=relaxed/simple;
	bh=32W/YkfA2YFHY9KJT8XuRLvbKnhjrEAh7fIoYP4Fyg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UinFQNjJ5wSQTVnLDYxIy9vcnfJmgCOhVpztbcPFM7lKaUz6mWOPVJMHaHKq3Y3qcx++MDB9AyXrd33mw1BjHn2gWKUgGQ8QtSgTJXoq4qyjKB7wybrUmQHFNhbgEBlFeG8/+P0QcROMHr2rJ+RhEN+CC+38HUJD6H+QE+s8JT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZYpZniKZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZYpZniKZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EC61F000E9;
	Thu, 27 Aug 2026 14:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787841138;
	bh=163b9z3lbMkc0FEcq1dbE3pOnD7g0ons6yqBuYTNQqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZYpZniKZHJ61ki9gDq4SjzydVU49iCyvWcBJHaRvY1HjJYNMGVeaTPMjVP6Vtn4C5
	 FgMiSaXRrPI6oP/Ezzc9n6d8tG3LIm9ILhy82ienk5B++gTQq4zTWyI3gAgGhObWPv
	 GaqMHK/ZvtQCExiPsyaYunzDSvbfHcCjFw3piwSQ=
Date: Thu, 27 Aug 2026 16:30:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
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
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-usb@vger.kernel.org,
	driver-core@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] module: pull out add_taint_module() to be public
Message-ID: <2026082713-award-dreamless-3aa7@gregkh>
References: <20260826-bind_taint-v1-0-52b05f4a965c@linuxfoundation.org>
 <20260826-bind_taint-v1-1-52b05f4a965c@linuxfoundation.org>
 <apA9aTiIpBz4inof@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apA9aTiIpBz4inof@hovoldconsulting.com>

On Thu, Aug 27, 2026 at 03:36:41PM +0200, Johan Hovold wrote:
> On Wed, Aug 26, 2026 at 11:19:32AM +0200, Greg Kroah-Hartman wrote:
> > Other kernel code might want to call add_taint_module() so pull it out
> > and make it global.  If modules are not enabled, this defaults to a call
> > to add_taint(), so all is fine.
> > 
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
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
> 
> >  	set_bit(flag, &mod->taints);
> 
> As has been pointed out, this crashes with built-in drivers. If you go
> with a simple mod NULL check before this call (and updated kernel-doc)
> you can add my:

Yeah, I've fixed this locally and will be resolved in v2.

> Reviewed-by: Johan Hovold <johan@kernel.org>
> Tested-by: Johan Hovold <johan@kernel.org>

Thanks!

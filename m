Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4493438B9;
	Mon, 31 Aug 2026 11:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175733; cv=none; b=biGMdjtR8lu2Gi5hh83pBD7akeWq9MlzwCF3ItUqzWfIlZuFZnM8Zv5oj8N3FL5fUygJoQ6mdwNssTPhqvPQyNVwonBxDdF4mGWGM1794DxG4eJ3JtSkleLhUrig/KDhL9RuvOL1DGRUTnP05kHEHUyZUqB/88694zQ7nft/SgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175733; c=relaxed/simple;
	bh=sVXRvymv7jtz4D70yUCE9cF/ZUg6aMsBxsO+d4DPjHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfCd7zxMoMA7nJu6ScFDjurjjxu35YVrXC28TXtrIL/vYd4uYfLeVxdlDSqF4dvlPfXMbKnYkv9Oz3WQTbJQJf0qp7SC+DuMR097ENVfN7GX26AToFkzFmWsyZTB4WNMcNW/kHTLro18SN60Wg7+xdsSW+XR3mp83F1Abgkl6Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2DfOj9g8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2DfOj9g8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176981F000E9;
	Mon, 31 Aug 2026 11:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788175731;
	bh=c2w/9FnEOgDiZR3N3B2MQzsBMntz3DEZVqb5OEIGORg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=2DfOj9g81IboVDG/Ot6IwyT7EM6X86zp3vcaUyYuICJVpSZJLyXzETr8F5IEjc2Vb
	 sRCyKQchNnNPN0YLPUFndlV7dXMao38F+89NBBH7SWOGTXVxA9kBvIPT/4ju6p6Jnl
	 OpZsoE76z6B3GAucSLexDoOq48EUzSNF/j9dT07s=
Date: Mon, 31 Aug 2026 13:28:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bradley Morgan <brads@mainlining.org>
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
	Aleksandr Nogikh <nogikh@google.com>, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-usb@vger.kernel.org, driver-core@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 1/2] module: pull out add_taint_module() to be public
Message-ID: <2026083107-gently-leverage-7f97@gregkh>
References: <20260831-bind_taint-v2-0-1082d631213b@linuxfoundation.org>
 <20260831-bind_taint-v2-1-1082d631213b@linuxfoundation.org>
 <2026083120-matrix-waffle-7ee7@gregkh>
 <A47FDF4A-DA90-4015-AFDB-61CA611F6311@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A47FDF4A-DA90-4015-AFDB-61CA611F6311@mainlining.org>

On Mon, Aug 31, 2026 at 12:14:17PM +0100, Bradley Morgan wrote:
> On 31 August 2026 12:07:50 BST, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >On Mon, Aug 31, 2026 at 12:51:46PM +0200, Greg Kroah-Hartman wrote:
> >> Other kernel code might want to call add_taint_module() so pull it out
> >> and make it global.  If modules are not enabled, this defaults to a call
> >> to add_taint(), so all is fine.
> >> 
> >> Reviewed-by: Johan Hovold <johan@kernel.org>
> >> Tested-by: Johan Hovold <johan@kernel.org>
> >> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> ---
> >>  include/linux/module.h | 10 ++++++++++
> >>  kernel/module/main.c   | 16 +++++++++++++---
> >>  2 files changed, 23 insertions(+), 3 deletions(-)
> >> 
> >> diff --git a/include/linux/module.h b/include/linux/module.h
> >> index 96cc98568eea..0636e0f2728c 100644
> >> --- a/include/linux/module.h
> >> +++ b/include/linux/module.h
> >> @@ -29,6 +29,7 @@
> >>  #include <linux/srcu.h>
> >>  #include <linux/static_call_types.h>
> >>  #include <linux/dynamic_debug.h>
> >> +#include <linux/panic.h>
> >>  
> >>  #include <linux/percpu.h>
> >>  #include <asm/module.h>
> >> @@ -770,6 +771,9 @@ static inline bool is_livepatch_module(struct module
> >*mod)
> >>  
> >>  void module_for_each_mod(int(*func)(struct module *mod, void *data),
> >void *data);
> >>  
> >> +void add_taint_module(struct module *mod, unsigned flag,
> >> +		      enum lockdep_ok lockdep_ok);
> >> +
> >>  #else /* !CONFIG_MODULES... */
> >>  
> >>  static inline struct module *__module_address(unsigned long addr)
> >> @@ -877,6 +881,12 @@ static inline bool module_is_coming(struct module
> >*mod)
> >>  static inline void module_for_each_mod(int(*func)(struct module *mod,
> >void *data), void *data)
> >>  {
> >>  }
> >> +
> >> +static inline void add_taint_module(struct module *mod, unsigned flag,
> >> +				    enum lockdep_ok, lockdep_ok)
> >
> >And this line is wrong, ugh.  I gotta go get sashiko running locally...
> 
> Cough cough, Claude code speaking 

Nope, no claude running here at all, sorry to burst your bubble.  If I
had, it would have caught this :)

greg k-h

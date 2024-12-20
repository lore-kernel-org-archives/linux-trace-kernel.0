Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404AC215783;
	Fri, 20 Dec 2024 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734701424; cv=none; b=cpM1BivGCVMlrOYX3Ix+cOZGeaEJZnztSS30tKddj5aId3w6bO+Da3fOSRKKT72xZSepKX/N2OYMKLQyu7rWRgpszuklcMjyJjlWxvctUPGtHUzXqRsZMhYnphSe3H2WGxeP/FoRKmmsf2O4QfbD9FKLfttbDAZ/+tJPajz6+I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734701424; c=relaxed/simple;
	bh=JEKY80kPBTPlzs2PTVYJ1uJy5tOe+Y52IEIDI6rGqa8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kUPfX+MS8GgfPrrCnPp3m0rSAPCAK4nryWOjMCAfzhc1pYH6j5MQHcZa+EXJ8xM+7nxeVyyZa+l0wOSNPWFaXV8cXKMTbCasbbarIi6hNpO5geS0ebhGChk9E+9+oMoFOfl3K2N/Z1jB2mQJvyCPDsEI/SJ3HHqI/cjo7tMFjVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783DBC4CECD;
	Fri, 20 Dec 2024 13:30:21 +0000 (UTC)
Date: Fri, 20 Dec 2024 08:31:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra
 <peterz@infradead.org>, Kees Cook <kees@kernel.org>, Andy Shevchenko
 <andy@kernel.org>, "linux-hardening@vger.kernel.org"
 <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH 09/14] tracing/string: Create and use __free(argv_free)
 in trace_dynevent.c
Message-ID: <20241220083104.563c1ca2@gandalf.local.home>
In-Reply-To: <CAHp75Vc2t_yppC85dnYrzDEEkFBF=NnoCna_PA=8fFFtusg7Ow@mail.gmail.com>
References: <20241219201158.193821672@goodmis.org>
	<20241219201346.029319524@goodmis.org>
	<CAHp75Vc2t_yppC85dnYrzDEEkFBF=NnoCna_PA=8fFFtusg7Ow@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Dec 2024 08:56:44 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> > diff --git a/include/linux/string.h b/include/linux/string.h
> > index 493ac4862c77..c995f973a59a 100644
> > --- a/include/linux/string.h
> > +++ b/include/linux/string.h
> > @@ -10,6 +10,7 @@
> >  #include <linux/err.h>         /* for ERR_PTR() */
> >  #include <linux/errno.h>       /* for E2BIG */
> >  #include <linux/overflow.h>    /* for check_mul_overflow() */
> > +#include <linux/cleanup.h>     /* for DEFINE_FREE() */  
> 
> 
> 
> Can you keep it ordered?

Not sure what order you want to keep?

> 
> 
> >  #include <linux/stdarg.h>
> >  #include <uapi/linux/string.h>
> >


#include <linux/args.h>
#include <linux/array_size.h>
#include <linux/compiler.h>	/* for inline */
#include <linux/types.h>	/* for size_t */
#include <linux/stddef.h>	/* for NULL */
#include <linux/err.h>		/* for ERR_PTR() */
#include <linux/errno.h>	/* for E2BIG */
#include <linux/overflow.h>	/* for check_mul_overflow() */
#include <linux/cleanup.h>	/* for DEFINE_FREE() */
#include <linux/stdarg.h>
#include <uapi/linux/string.h>

It's not alphabetical, nor in x-mas tree order. I was never good at these
"find the pattern" puzzles ;-)

-- Steve

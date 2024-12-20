Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCE0218AD9;
	Fri, 20 Dec 2024 15:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734708453; cv=none; b=B0hYPkMBDa8fpEZZGq3qjuZR/pIWRodzR4CWjTnI/2Z0bjtdjlMeEjwQIpEF5orGJFMRzQ56jo/kDpI8KyELy/kub9d/jXLIKEwb3a4enYIi4rSiR5r7lBDEyWHiRz2hIAc0/on3GLsnum3vayTci6OXW/gybiNl/F1lKeSRHJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734708453; c=relaxed/simple;
	bh=ml6FTdPY+nDcLE4nyVGh7cRyXLtDysf3URM5nGVhl6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TrpGwZ3zyznHC2puMa01XIgTs7qFytREy+9/MgzLHqfHOCG2cTT1VdZLZC2guIjGhjgKMrz0Q462SmGBsOLU+Ne8IlP749iazDKiEK9/nIocOZw97s8Y5YEwNlFgJClklo3v4Iplexpp+Fhv50V5ZIQj/xBd0+YrnsY/B3gWclI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A49C4CECD;
	Fri, 20 Dec 2024 15:27:31 +0000 (UTC)
Date: Fri, 20 Dec 2024 10:28:14 -0500
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
Message-ID: <20241220102814.13e12e4c@gandalf.local.home>
In-Reply-To: <CAHp75VeWpS8ZUct5MJBbCkpPGmg0=9_t_-RhV5DD4-L4wRnvxQ@mail.gmail.com>
References: <20241219201158.193821672@goodmis.org>
	<20241219201346.029319524@goodmis.org>
	<CAHp75Vc2t_yppC85dnYrzDEEkFBF=NnoCna_PA=8fFFtusg7Ow@mail.gmail.com>
	<20241220083104.563c1ca2@gandalf.local.home>
	<CAHp75VeWpS8ZUct5MJBbCkpPGmg0=9_t_-RhV5DD4-L4wRnvxQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Dec 2024 15:48:44 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> =D0=BF=CA=BC=D1=8F=D1=82=D0=BD=D0=B8=D1=86=D1=8F, 20 =D0=B3=D1=80=D1=83=
=D0=B4=D0=BD=D1=8F 2024=E2=80=AF=D1=80. Steven Rostedt <rostedt@goodmis.org=
> =D0=BF=D0=B8=D1=88=D0=B5:
>=20
> > On Fri, 20 Dec 2024 08:56:44 +0200
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > =20
> > > > diff --git a/include/linux/string.h b/include/linux/string.h
> > > > index 493ac4862c77..c995f973a59a 100644
> > > > --- a/include/linux/string.h
> > > > +++ b/include/linux/string.h
> > > > @@ -10,6 +10,7 @@
> > > >  #include <linux/err.h>         /* for ERR_PTR() */
> > > >  #include <linux/errno.h>       /* for E2BIG */
> > > >  #include <linux/overflow.h>    /* for check_mul_overflow() */
> > > > +#include <linux/cleanup.h>     /* for DEFINE_FREE() */ =20
> > >
> > >
> > >
> > > Can you keep it ordered? =20
> >
> > Not sure what order you want to keep?
> > =20
> > >
> > > =20
> > > >  #include <linux/stdarg.h>
> > > >  #include <uapi/linux/string.h>
> > > > =20
> >
> >
> > #include <linux/args.h>
> > #include <linux/array_size.h> =20
>=20
>=20
>=20
> If you put it here it would make more like alphabetical order with only f=
ew
> exceptions

Sure, I'll send out a v2. Thanks for the review.

--Steve

>=20
> #include <linux/compiler.h>     /* for inline */
> > #include <linux/types.h>        /* for size_t */
> > #include <linux/stddef.h>       /* for NULL */
> > #include <linux/err.h>          /* for ERR_PTR() */
> > #include <linux/errno.h>        /* for E2BIG */
> > #include <linux/overflow.h>     /* for check_mul_overflow() */
> > #include <linux/cleanup.h>      /* for DEFINE_FREE() */
> > #include <linux/stdarg.h>
> > #include <uapi/linux/string.h>
> >
> > It's not alphabetical, nor in x-mas tree order. I was never good at the=
se
> > "find the pattern" puzzles ;-)
> >
> > -- Steve
> > =20


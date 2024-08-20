Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F09CFC11;
	Tue, 20 Aug 2024 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167213; cv=none; b=Gvp2dLB4eKVtL3mDl0GzFWErS8Fl8KIBQtdW3y2TeH4i5jiBLOl+EN7I7Jw+dOsKbj0Ab7saVSk8RYkTF+6I0VEu6iqOj9rcQ70DYSsFKpPWs+NhiaUSoOLdABlR9yzzjTJaf9eclovEZYep1CDxoi/BWX384KahSKoVb7QU5LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167213; c=relaxed/simple;
	bh=oOHbyQAD8zRujnoaItoz96lJE8L5M2620D65thxzNaI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2hkkl/5qXUiEhGHoBfMMXzRzzY/3d00130WqBYadZNuV1JN11gu1M1Hc8lajugBlCdDwS8OYjxZPcC/lmC8lD+ExCwZfXJAS6qBK6lsXtCrzBQRzt5L0wmgBGkpopINWQUIum/pWCpMuvfEr18UD37VbG5lmjwamEKzLf3lfQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B14C4AF0C;
	Tue, 20 Aug 2024 15:20:11 +0000 (UTC)
Date: Tue, 20 Aug 2024 11:20:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kernel@vger.kernel.org,
 clang-built-linux <llvm@lists.linux.dev>, Nathan Chancellor
 <nathan@kernel.org>
Subject: Re: [BUG] tracing: dynamic ftrace selftest detected failures
Message-ID: <20240820112038.7a32b328@gandalf.local.home>
In-Reply-To: <CABCJKueKhDVarco4mgNeR0hkAhxDtxBjdpu=QaYVi+TGoiqd2g@mail.gmail.com>
References: <20240819171152.12f05e0ae5c9472004d1b00a@kernel.org>
	<20240819112902.11451fe8@gandalf.local.home>
	<20240820005649.dd019cfa70a8955d91cf85a0@kernel.org>
	<20240819120244.5657eb2f@gandalf.local.home>
	<20240820100330.9ee6f3d51f22bb9bab7c4b83@kernel.org>
	<ZsR0Z6DxSHOI-wNj@J2N7QTR9R3>
	<CABCJKueKhDVarco4mgNeR0hkAhxDtxBjdpu=QaYVi+TGoiqd2g@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 20 Aug 2024 08:10:42 -0700
Sami Tolvanen <samitolvanen@google.com> wrote:

> On Tue, Aug 20, 2024 at 3:48=E2=80=AFAM Mark Rutland <mark.rutland@arm.co=
m> wrote:
> >
> > On Tue, Aug 20, 2024 at 10:03:30AM +0900, Masami Hiramatsu wrote: =20
> > > On Mon, 19 Aug 2024 12:02:44 -0400
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > > =20
> > > > On Tue, 20 Aug 2024 00:56:49 +0900
> > > > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote: =20
> > > > > =20
> > > > > >
> > > > > > We may need to add "noinline" or something to make sure those f=
unctions
> > > > > > don't get inlined for LTO. =20
> > > > >
> > > > > Yeah, we need such option at least for function call test. =20
> > > >
> > > > Could you add the noinline, and if it fixes the issue send a patch?=
 =20
> > >
> > > I found the target function already has "noinline". I tried to add no=
inline
> > > to the testing function (callsite), but it also did not work.
> > > I think "noinline" is for the compiler, but LTO is done by the linker=
. =20
> >
> > If LTO is breaking noinline, then that has much larger implications for
> > noinstr code and similar, and means that LTO is unsound... =20
>=20
> The noinline attribute is preserved in LLVM IR, so it should continue
> to work with LTO. Which function are we talking about here? Are you
> sure the function was inlined instead of being dropped completely?
> Does marking the function __used help?

Hmm, maybe it was dropped, as the functions are basically just stubs.

Masami, can you add __used to the functions in trace_selftests_dynamic.c
and see if that fixes it?

-- Steve


Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7241DDAB
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Oct 2023 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="roXaDV5L"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87C9F106;
	Fri, 20 Oct 2023 03:42:48 -0700 (PDT)
Received: from pwmachine.localnet (unknown [188.24.154.80])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2705320B74C0;
	Fri, 20 Oct 2023 03:42:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2705320B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1697798568;
	bh=hnnVsUjyZV+dpb5bf774eE1FJR1gw5g94Ljn0qCzUP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=roXaDV5LOfYsc+JAum0I5rZHl38D78cVf4X+FcnrWAXr25XR75w+NNtQDGBsGtp85
	 zznht0rHMR8+y+kMppbuYQvOjF5aMY/AQVIz57GYAo8aqtoR/xC/wzwtKs5yzAsS8j
	 hfPuahMC6jRfskUvssxIc8XGTQJSdxMeawdkh1f8=
From: Francis Laniel <flaniel@linux.microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5 0/2] Return EADDRNOTAVAIL when func matches several symbols during kprobe creation
Date: Fri, 20 Oct 2023 13:42:44 +0300
Message-ID: <5720486.DvuYhMxLoT@pwmachine>
In-Reply-To: <20231020000708.e33ec727fcd322b7cde292cd@kernel.org>
References: <20231018144030.86885-1-flaniel@linux.microsoft.com> <20231019095104.006a7252@gandalf.local.home> <20231020000708.e33ec727fcd322b7cde292cd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi!

Le jeudi 19 octobre 2023, 18:07:08 EEST Masami Hiramatsu a =E9crit :
> On Thu, 19 Oct 2023 09:51:04 -0400
>=20
> Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Thu, 19 Oct 2023 21:18:43 +0900
> >=20
> > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > > > So why is this adding stable? (and as Greg's form letter states,
> > > > that's not
> > > > how you do that)
> > > >=20
> > > > I don't see this as a fix but a new feature.
> > >=20
> > > I asked him to make this a fix since the current kprobe event' behavi=
or
> > > is
> > > somewhat strange. It puts the probe on only the "first symbol" if user
> > > specifies a symbol name which has multiple instances. In this case, t=
he
> > > actual probe address can not be solved by name. User must specify the
> > > probe address by unique name + offset. Unless, it can put a probe on
> > > unexpected address, especially if it specifies non-unique symbol +
> > > offset,
> > > the address may NOT be the instruction boundary.
> > > To avoid this issue, it should check the given symbol is unique.
> >=20
> > OK, so what is broken is that when you add a probe to a function that h=
as
> > multiple names, it will attach to the first one and not necessarily the
> > one
> > you want.
> >=20
> > The change log needs to be more explicit in what the "bug" is. It does
> > state this in a round about way, but it is written in a way that it
> > doesn't
> > stand out.
> >=20
> >     Previously to this commit, if func matches several symbols, a kprob=
e,
> >     being either sysfs or PMU, would only be installed for the first
> >     matching address. This could lead to some misunderstanding when some
> >     BPF code was never called because it was attached to a function whi=
ch
> >     was indeed not called, because the effectively called one has no
> >     kprobes attached.
> >    =20
> >     So, this commit returns EADDRNOTAVAIL when func matches several
> >     symbols. This way, user needs to use address to remove the ambiguit=
y.
> >=20
> > What it should say is:
> >     When a kprobe is attached to a function that's name is not unique (=
is
> >     static and shares the name with other functions in the kernel), the
> >     kprobe is attached to the first function it finds. This is a bug as
> >     the
> >     function that it is attaching to is not necessarily the one that the
> >     user wants to attach to.
> >    =20
> >     Instead of blindly picking a function to attach to what is ambiguou=
s,
> >     error with EADDRNOTAVAIL to let the user know that this function is
> >     not
> >     unique, and that the user must use another unique function with an
> >     address offset to get to the function they want to attach to.
>=20
> Great!, yes this looks good to me too.
>=20
> > And yes, it should have:
> >=20
> > Cc: stable@vger.kernel.org
> >=20
> > which is how to mark something for stable, and
> >=20
> > Fixes: ...
> >=20
> > To the commit that caused the bug.
>=20
> Yes, this should be the first one.
>=20
> Fixes: 413d37d1eb69 ("tracing: Add kprobe-based event tracer")

Thank you! I should have thought about it nonetheless but I will take more=
=20
care in the future!

> Thank you,
>=20
> > -- Steve

Best regards.



Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794940570;
	b=lYejTuXVrjBCZD/xTMapGGtFCDatYXF1kDftC3CIxFX3bsItX3PC5NCGIG7v5KdUoXkm
	 drDiBhZY+Bu+JjDJm1Ftp17XY5JLORRWDIZUPPSnS2sPpE6UNi+hv6za0/sp+jmN2eUQX
	 Q0gFe61muxM5qnoBEUy8SUP0ImxGJhFOmFFWqQTffdmu+lyoUvEbDHS3vHVuJre7my28E
	 05PlQJbUKTaVIknc4jXTJ/WgjLj4Div6P76TmSTNKgQRaL/XwjADWHSRtWtCkRd+s40GU
	 fVGS7ahcYmo+oiBb24nWJaFdg2PTGBP7rEhfzaLrKeeIV1NLKc+BbuBvAWxHcvOUaUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940570;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=B4z0W62T/tkJurVdFIQKBfimJ7xquU/QIiCVTwGcqUI=;
	b=2bmO/a7BFmS3SHdB/Z6pm155bQhZStnLrXZglJxE5loExdnYq90ABjxC/gLqLsLt9IGD
	 mScbLU4ss43DII9k0fD1pVN5dfk9/9gZck1qfGT85qKk/uCMEpWFoc3mcYoJF6dGuAFnJ
	 z1nC2JJhgtvUS57vJlCjGBRXenQxsrXya1GFCGo82b8q5WmZvqNg6EYCKWnJHJDGERUMX
	 I6p+MjPFnNRrP+lXIQC07EwXNH2g8BvQH8e1ElA70NuhjIJ7KNRCGwcH2/XpHREtfbfG3
	 vaL8nIdS2KWIpaaa4V58eoeiZlDM6MPXUnN5Po3Oxwei2qpWiPfKRaZjCQ9lLl+Mulg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oiV1yQUH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92116606A32C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oiV1yQUH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC641F000C6;
	Tue, 17 Nov 2026 18:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794940570;
	bh=B4z0W62T/tkJurVdFIQKBfimJ7xquU/QIiCVTwGcqUI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oiV1yQUHQST3nismIcobFjVG/4ldpi85GQ08nOGMZuotiF8LyEKr1qcf8WcdoeIJI
	 2Xr1b37Cb4tePI2isMuJTmavmbw/XsCCGk97HX5AfWOgvkqCyxAL7Ryyj0Zyb0uKlY
	 leixHmbiKomczMdwOnaUkEwdKFzmoEab1ccU11SQqyeO+XVD/scURDQJePhCttHoA1
	 XADvExvT9NGWVYX/SwrBsuGlEPfck+Z5+2yRWI6MsAPBi0wcVSY2GQaCgvdNuIeTEf
	 82fYRinKu/g/4VTBQ40uvVUzwFr5nGdh9/MdO/5HZIxHhIRmCmaDj9cWJIgHwctNL5
	 NdB62zH6DGrLA==
Message-ID: <sashiko-outbox-219362@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing: 'select' GENERIC_TRACER, not 'depends'
Reply-To: sashiko-reviews@lists.linux.dev
To: "Brian Norris" <briannorris@chromium.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <avybp3O2zxcLozKB@google.com>
References: <20261116144652.1.Iecb63200dd245f62032a3b1f60ae78cc48868094@changeid>
 <sashiko-outbox-217828@kernel.org>
 <20261117085552.0e4ef272@gandalf.local.home> <avybp3O2zxcLozKB@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 18:36:09 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] tracing: missing Signed-off-by trailer and unformatted email
  reply changelog
- [Low] tracing: ENABLE_DEFAULT_TRACERS stays unselected for direct
  TRACING selectors
--

commit 3e6de7d49bb4a2d1503d2aeab72b682a01dfe176
Author: Brian Norris <briannorris@chromium.org>

> tracing: 'select' GENERIC_TRACER, not 'depends'
>
> On Tue, Nov 17, 2026 at 08:55:52AM -0500, Steven Rostedt wrote:
> > On Mon, 16 Nov 2026 22:58:01 +0000
> > sashiko-bot@kernel.org wrote:
> >
> > > [Severity: Low]
> > > Should FTRACE_STARTUP_TEST depend on TRACING (or select TRACING) inst=
ead
> > > of selecting GENERIC_TRACER?
> > >
> > > GENERIC_TRACER is meant only for full tracer options so that
> > > ENABLE_DEFAULT_TRACERS is hidden when a full tracer is enabled:
> > >
> > > kernel/trace/Kconfig:
> > >     # All tracer options should select GENERIC_TRACER. For those opti=
ons that are
> > >     # enabled by all tracers (context switch and event tracer) they s=
elect TRACING.
> > >     ...
> > >     config ENABLE_DEFAULT_TRACERS
> > >             bool "Trace process context switches and events"
> > >             depends on !GENERIC_TRACER
> > >             select TRACING
> > >
> > > Because FTRACE_STARTUP_TEST is a test option rather than a tracer, ha=
ving
> > > it select GENERIC_TRACER disables and hides ENABLE_DEFAULT_TRACERS wh=
en no
> > > full tracer is configured, and implicitly pulls in TRACING even when =
all
> > > tracers are disabled.
> >
> > Actually, the selftests should depend on TRACING and not GENERIC_TRACER=
. It
> > may have been that the self tests were added before the trace events.
> >
> > But it should not "select" a config. The selftest are only to be select=
ed
> > if there is something to test.
>
> OK, I can respin with 'depends on TRACING'.
>
> However, I think the Kconfig setup for kernel/trace/ is still a bit
> haphazard. For example, it's reasonably common to want EVENT_TRACING but
> not the more invasive tracing (like FUNCTION_TRACER; and therefore no
> GENERIC_TRACER) -- this is how all Android kernels are built, for one.
>
> But there's no user-configurable way to enable EVENT_TRACING. We only
> get it implicitly if something else inadvertently selects 'FTRACE'
> (which selects EVENT_TRACING). For Android, that's CONFIG_KPROBES and
> CONFIG_HIST_TRIGGERS.
>
> ...or is that what ENABLE_DEFAULT_TRACERS is? Its name doesn't really
> suggest that, and it's mutually exclusive witih many other tracers, so
> it's a bit awkward making choices, as the whole system appears much less
> orthogonal than expected.
>
> Anyway, my point is that it's not exactly straightforward to enable the
> features you want and get the tests you want.
>
> I've appended a diff that seems a bit more user-friendly to me. It
> makes it more explicit in the menu how event-tracing is forced-on by
> many other tracers, but is user-configurable when it's not forced. I can
> formally submit it (in 2 patches) if you'd like.
>
> Brian

[Severity: High]
This commit is missing a Signed-off-by trailer, its body is an unedited
mailing-list reply rather than a commit changelog, and the subject line
states the opposite of the FTRACE_STARTUP_TEST change (which switches
"depends on GENERIC_TRACER" to "depends on TRACING").

> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index c41397eccee50..f49397f7c92d6 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -198,6 +198,7 @@ config TRACING
>  config GENERIC_TRACER
>  	bool
>  	select TRACING
> +	select ENABLE_DEFAULT_TRACERS
> =20
>  #
>  # Minimum requirements an architecture has to meet for us to
> @@ -595,7 +596,6 @@ config MMIOTRACE
> =20
>  config ENABLE_DEFAULT_TRACERS
>  	bool "Trace process context switches and events"
> -	depends on !GENERIC_TRACER
>  	select TRACING
>  	help
>  	  This tracer hooks to various trace points in the kernel,

[Severity: Low]
Does ENABLE_DEFAULT_TRACERS remain unselected when TRACING is enabled by
options that do not select GENERIC_TRACER?

Options such as KPROBE_EVENTS and HIST_TRIGGERS select TRACING directly
(which in turn selects EVENT_TRACING and CONTEXT_SWITCH_TRACER) without
selecting GENERIC_TRACER.  When those options are enabled with
GENERIC_TRACER=3Dn, event tracing is already forced on, but
ENABLE_DEFAULT_TRACERS stays n and appears in menuconfig as a mutable
toggle that has no effect on the build.

Also, the comment above config TRACING still explains that GENERIC_TRACER
and TRACING are separate so that ENABLE_DEFAULT_TRACERS is hidden when
selected by another tracer, which no longer matches the Kconfig logic once
"depends on !GENERIC_TRACER" is removed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/avybp3O2zxcLozKB@go=
ogle.com?part=3D1

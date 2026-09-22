Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EBA531636
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 10:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790072165; cv=none; b=XjRvBeHXxNoWr2a8nK2eZBEK2KcH0KWG1N9G2bO1YrTbGaqC1diULlo+c2562KHjXWb5/MlFY/jKOTc8et4ctkz2T7S2MhLhVbPbAvYE5NHwznzAm3/EJ0Irj+pT2NWIyH4TazcPAtF+Gydzfz9/fZJUd3MGxdqKTWHa4t5wS8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790072165; c=relaxed/simple;
	bh=tjLto3EYcdo74TLnk67Gam+8kzSLp4Dr+nKrBZaCzp8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ScRNoVNM1BT0F6I+XLE4EYvrHjGx4OEO4BonchV3+zCCFuDq6hH1/t8KzfL9xZQ7lnFbBN4DzT7NHbad+PZb+hqUrldUqZr0xZ6D0PYsHqBaflyP8ykakM1Sz/UYfkr2dBNtn9gu9lSJ5uIJ1TWUoMVPHGlzga8iV2we/7lbNxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtuVYsp4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtuVYsp4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FAB1F00893;
	Tue, 22 Sep 2026 10:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790072157;
	bh=+LRWFgmvw2zqNCfCI2f3ZmpbN06RJJV4ahA1yEhiLkU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YtuVYsp4lLuD6rzJKJmCwAxssc1ZLxoZ7cdusotbLUGmfq8wQZPPKwCaMCiDowj8J
	 c9A4T3fRp4GKjqK4RRCEJcRz9Yj3IJ2ZXEwOIhGBHbLUOX0rUbOwLxgH2TBN7J/4hw
	 /GepxQpfksqxRNMkQGuH3ihCp9WEqXXOceaNzNxlsQbHlHaBokpnUeeQTSFbEelYir
	 piCPflZUCj1u92TC4Awo/ZBTff14JCPN79od2Dc8zJH3XYv9MevmULVqka+tdPS+KH
	 bThRaQPUF32I0m/kMIjHFWWfR7oJme5hA38mL8s2FCPsh7e8cpPhnS2gLEcqHRF5Zy
	 FmQ6OoE4G4O5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/4] tracing: add __print_sym() to replace
 __print_symbolic()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Johannes Berg" <johannes@sipsolutions.net>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260921101538.97286-7-johannes@sipsolutions.net>
References: <20260921101538.97286-6-johannes@sipsolutions.net>
 <20260921101538.97286-7-johannes@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 10:15:57 +0000
Message-Id: <20260922101557.92FAB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] tracing: unaligned access in ftrace_sym_defs section causes kernel=
 panic
--

commit e2d306a70156a518ace125ae399dac289ad0b9ff
Author: Johannes Berg <johannes.berg@intel.com>

tracing: add __print_sym() to replace __print_symbolic()

The way __print_symbolic() works is limited and inefficient in multiple way=
s.
This commit introduces __print_sym() to replace it, requiring only a single
list of items created by TRACE_DEFINE_SYM_LIST() and doing the fixup when
userspace reads the print_fmt.

> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmli=
nux.lds.h
> index b2988aa12f664..e48327fafdfe8 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -276,8 +276,10 @@
>  	. =3D ALIGN(8);							\
>  	BOUNDED_SECTION(_ftrace_events)					\
>  	BOUNDED_SECTION_BY(_ftrace_eval_map, _ftrace_eval_maps)
> +#define FTRACE_SYM_DEFS()	BOUNDED_SECTION(_ftrace_sym_defs)

[Severity: High]
Does this missing . =3D ALIGN(8); before BOUNDED_SECTION(_ftrace_sym_defs) =
in
include/asm-generic/vmlinux.lds.h within FTRACE_SYM_DEFS() cause unaligned
addresses to be captured? Since FTRACE_SYM_DEFS follows TRACEPOINT_STR() wh=
ich
contains 1-byte aligned strings, the linker might assign an unaligned locat=
ion
counter to __start_ftrace_sym_defs before adding padding.

>  #else
>  #define FTRACE_EVENTS()
> +#define FTRACE_SYM_DEFS()
>  #endif

[ ... ]

> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 9dbc2441763b1..f14646ba9b22d 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -2109,6 +2109,102 @@ static void *f_next(struct seq_file *m, void *v, =
loff_t *pos)
>  		return node;
>  }
> =20
> +extern struct trace_sym_def *__start_ftrace_sym_defs[];
> +extern struct trace_sym_def *__stop_ftrace_sym_defs[];
> +
> +/* note: @name is not NUL-terminated */
> +static void show_sym_list(struct seq_file *m, struct trace_event_call *c=
all,
> +			  const char *name, unsigned int name_len)
> +{
> +	struct trace_sym_def **sym_defs;
> +	unsigned int n_sym_defs, i;
> +
> +	if ((call->flags & TRACE_EVENT_FL_DYNAMIC) || !call->module) {
> +		sym_defs =3D __start_ftrace_sym_defs;
> +		n_sym_defs =3D __stop_ftrace_sym_defs - __start_ftrace_sym_defs;
> +	} else {

[ ... ]

> +
> +	for (i =3D 0; i < n_sym_defs; i++) {
> +		unsigned int sym_len;
> +
> +		if (!sym_defs[i])
> +			continue;
> +		if (sym_defs[i]->system !=3D call->class->system)

[Severity: High]
If __start_ftrace_sym_defs was given an unaligned address in the linker scr=
ipt,
could this regression in show_sym_list() in kernel/trace/trace_events.c
dereference padding bytes as partial pointers and cause a kernel panic?
This seems reachable by any user with read access to the tracefs format
file for events using __print_sym.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921101538.9728=
6-6-johannes@sipsolutions.net?part=3D1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FC32EAD1B;
	Wed,  8 Apr 2026 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775663888; cv=none; b=OiVPDjHupxPp1F2yhhYOgpTA6or5aa7WHxvEcGeL8CY8zthp9bB+97CvKx57ecQvaFCHkA7NSds3kVblBvdOyryM60J1Mz2gk3rzDuK/YwKpjSHWmdus7IH2tYL6zPwUg8ArdpHWxaJ99Zby7sawfkBpIBz1W7ZA95AMCw4vavc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775663888; c=relaxed/simple;
	bh=Ct7J4URQD2kvVJNJp21MJsSon1OwFIg2gLwroDRSm2E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JG+VqBR180Y69lN5mJkMFgA9AhIHP5XxXqaQbupwWRrg9Vg5/ZW5FMxk3FZ/SfwkhY6tz1RaNF1fxjSV/715WM67WveqLEv6xhqcdNVa77JmvQ650TVhrwXKo0k3OGB2N2HF/+C3PgUSRWUEmVV9gpEqxdv9MVYRswpQZovV7/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUgZJuVe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUgZJuVe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC003C19421;
	Wed,  8 Apr 2026 15:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775663888;
	bh=Ct7J4URQD2kvVJNJp21MJsSon1OwFIg2gLwroDRSm2E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=LUgZJuVejKWMiiRl23cDtibksAgOg7Ujq6fkjSSyBRXHaaGkLoGFJOj8BzMk/98xe
	 F6Hef3x0RI/iFB1VlS6FPDZo3O8w3OGs5jMMj4Lj6Kphrf/mjwesGLDyS9A2v+/vgv
	 t/HB+vd71CF+svbnKYLUob8SqFxB88V33dcqZbqg0x83Oy4SUoNW9D1ax3dsM50BRq
	 z3OdvmOulaepOzt8w1x3Nf3hMXRHj0+K9ZyKr6crVps1ICuDEml9r5WI6nIavq6pp5
	 f3L5AzepnqPrM8i/UyzzhND57+U7R1NA7VUReQ71ofvDBiW7+vWaQT1Xw7iMhbV0je
	 lFnoHjEra/UNg==
Message-ID: <f59d594ff21658db45c58a094edeab0f92ae8345.camel@kernel.org>
Subject: Re: [PATCH v2 1/2] tracing/hist: rebuild full_name on each
 hist_field_name() call
From: Tom Zanussi <zanussi@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Date: Wed, 08 Apr 2026 10:58:06 -0500
In-Reply-To: <20260407210502.102e5d37@gandalf.local.home>
References: <20260401112224.85582-1-pengpeng@iscas.ac.cn>
	 <20260407210502.102e5d37@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Steve,

On Tue, 2026-04-07 at 21:05 -0400, Steven Rostedt wrote:
>=20
> Tom,
>=20
> On Wed,=C2=A0 1 Apr 2026 19:22:23 +0800
> Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:
>=20
> > hist_field_name() uses a static MAX_FILTER_STR_VAL buffer for fully
> > qualified variable-reference names, but it currently appends into that
> > buffer with strcat() without rebuilding it first. As a result, repeated
> > calls append a new "system.event.field" name onto the previous one,
> > which can eventually run past the end of full_name.
> >=20
> > Build the name with snprintf() on each call and return NULL if the full=
y
> > qualified name does not fit in MAX_FILTER_STR_VAL.
> >=20
> > Fixes: 067fe038e70f ("tracing: Add variable reference handling to hist =
triggers")
> > Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> > ---
> > Changes since v1: https://lore.kernel.org/all/20260329030950.32503-1-pe=
ngpeng@iscas.ac.cn/
> >=20
> > - rebuild full_name on each call instead of falling back to field->name
> > - return NULL on overflow as suggested
> > - split out the snprintf() length check instead of using an inline if
> >=20
> > =C2=A0kernel/trace/trace_events_hist.c | 12 +++++++-----
> > =C2=A01 file changed, 7 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_even=
ts_hist.c
> > index 73ea180cad55..f9c8a4f078ea 100644
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -1361,12 +1361,14 @@ static const char *hist_field_name(struct hist_=
field *field,
> > =C2=A0		 field->flags & HIST_FIELD_FL_VAR_REF) {
> > =C2=A0		if (field->system) {
> > =C2=A0			static char full_name[MAX_FILTER_STR_VAL];
> > +			int len;
> > +
> > +			len =3D snprintf(full_name, sizeof(full_name), "%s.%s.%s",
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 field->system, field->event_n=
ame,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 field->name);
> > +			if (len >=3D sizeof(full_name))
> > +				return NULL;
> > =C2=A0
> > -			strcat(full_name, field->system);
> > -			strcat(full_name, ".");
> > -			strcat(full_name, field->event_name);
> > -			strcat(full_name, ".");
> > -			strcat(full_name, field->name);
> > =C2=A0			field_name =3D full_name;
>=20
> I wanted to test this but I can't find anything that triggers this path.
> How does a field here get its ->system set?
>=20

->system is set when using fully-qualified variable names. For
instance:

echo 'hist:keys=3Dpid:ts0=3Dcommon_timestamp.usecs' >> sys/kernel/debug/tra=
cing/events/sched/sched_waking/trigger
echo 'hist:keys=3Dpid:ts0=3Dcommon_timestamp.usecs' >> /sys/kernel/debug/tr=
acing/events/sched/sched_wakeup/trigger
echo 'hist:keys=3Dnext_pid:lat0=3Dcommon_timestamp.usecs-sched.sched_waking=
.$ts0:lat1=3Dcommon_timestamp.usecs-sched.sched_wakeup.$ts0' >> /sys/kernel=
/debug/tracing/events/sched/sched_switch/trigger
echo 'hist:keys=3Dnext_pid:vals=3D$lat0,$lat1' >> /sys/kernel/debug/tracing=
/events/sched/sched_switch/trigger

Here, the sched_switch trigger would error out if the unqualified $ts0
variables were used instead of the fully-qualified ones because there's
no way to distinguish which $ts0 was meant.

Tom



> If there's no way to hit this path, I much rather remove it than "fix" it=
.
>=20
> -- Steve
>=20
>=20
> > =C2=A0		} else
> > =C2=A0			field_name =3D field->name;
>=20


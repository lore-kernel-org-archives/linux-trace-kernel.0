Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FEC478E5E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786631897; cv=none; b=Z6kKiS78SUkohAfZ3u1ct70dW8PNRehd2/12HXBCJEbNTrgksHY8FANeG6WzGHTxkKQxvd4+YdOq4UAYKsD1iLq0hBuTudRA3wAZK2Pnc0ujkeZS2pPH1j6xLsfsIyJcmIVwaqJytcA4L9WqX5zjyn8IPEFsQzMEndNvzR/AOSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786631897; c=relaxed/simple;
	bh=3gTvKMY98wq3UHJRBprDa7t7l44XPZlAnZD8y9Yl5RU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qHmctW2TSIHzyxdcFO1vl3XK7uAzoffq3eTq3dlKao+bi00zgxqQcHTBL3ViGYiqkqWIPig86MblJArDwOn94z6hoK9Vt/uxT7ExHuLtlHNlyOyvisTR80w4oMa3DOd04yO1If6kEhgQTPec2xD7pTeXPM0aHPJhyBwQAf83dek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=hA3suBxW; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="hA3suBxW"
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id E51E4A1B4D;
	Thu, 13 Aug 2026 14:38:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 4590C20016;
	Thu, 13 Aug 2026 14:38:05 +0000 (UTC)
Date: Thu, 13 Aug 2026 10:38:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <thomas.weissschuh@linutronix.de>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/7] tracing: Stop modifying the input buffer in
 ftrace_set_clr_event()
Message-ID: <20260813103821.36d6b6f7@gandalf.local.home>
In-Reply-To: <20260813141501.347E21F000E9@smtp.kernel.org>
References: <20260813-tracing-cli-event-filter-v1-0-57c4e8029c86@linutronix.de>
	<20260813-tracing-cli-event-filter-v1-3-57c4e8029c86@linutronix.de>
	<20260813141501.347E21F000E9@smtp.kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: scdjn5h6h7o63kkr37bkg4koxxg7wg8n
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 4590C20016
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/dPrw/95mF3wEXFUAUejpOBmgCU4RcyYs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=CakHe1+I6BkdYo58mzhRjPecsTJcB7vyR9Re5ENQBFg=; b=hA3suBxWHByj7Y7powkkwKlNV0lbSNvSEel8r3lFRDptOheDE8oEVjXPDRg6g3zkwiwKMcIoVQeITnRlD/yoWz46bHNLSeeP/PfhnMjH+atFXFsPakpwtw/MHFwVWt83qwyXsI7emK83bLncWRTb3FRBaAUu0CLRazNc+2j6e2s=
X-HE-Tag: 1786631885-250082
X-HE-Meta: U2FsdGVkX1/HAMNSlzlEoTxVz8JNoznLCI1/UFT3SB+/bz0393h2CNbWP9h3E7A4eS259wxhkHJOrC8N5+plT6Mrg8W40H0GTMHDWba28a5wMHyL2zHztNBEW6ZFEFmT9gNx1rG4FblkY3IphscsqQNXbrX20IPN9HOUOO8ToxNe9462HRXAHwx4dx68CoA6ZUwjDbbstYCqVW0x/Xz0AhufX/HqQfWVmOs7fVZGVCnWhTuvI1e6smR994OgzJtLZOtvPl9e3RkryiO1H3j3oUD/hpHiZoFEoWmbjTfGsJ9NE8T2MR03d5z7aFmLTIZHMnItEl1bmG1ZcxYVkpsEEUuUzANd9QfU

On Thu, 13 Aug 2026 14:15:00 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Invalid free (causing kernel panic) and memory leak due to `strs=
ep()` modifying a pointer managed by `__free(kfree)`.
> --
>=20
> --- Patch [3]: [PATCH RFC 3/7] tracing: Stop modifying the input buffer i=
n ftrace_set_clr_event() ---
> commit c968a27c39638474537de841b7e2191407463142
> Author: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
>=20
> tracing: Stop modifying the input buffer in ftrace_set_clr_event()
>=20
> This commit changes ftrace_set_clr_event() to copy its input buffer using
> kstrdup() and manage it with __free(kfree). This removes the need to
> restore the original buffer modifications before returning.
>=20
> > diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> > index 6aa32c4922807..c75a7f5b55def 100644
> > --- a/kernel/trace/trace_events.c
> > +++ b/kernel/trace/trace_events.c
> > @@ -1411,14 +1411,17 @@ static int __ftrace_set_clr_event(struct trace_=
array *tr, const char *match,
> >  	return ret;
> >  }
> > =20
> > -int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
> > +int ftrace_set_clr_event(struct trace_array *tr, const char *_buf, int=
 set)
> >  {
> >  	char *event =3D NULL, *sub =3D NULL, *match, *mod;
> > =20
> >  	if (!tr)
> >  		return -ENOENT;
> > =20
> > +	char *buf __free(kfree) =3D kstrdup(_buf, GFP_KERNEL);
> > +	if (!buf)
> > +		return -ENOMEM;
> > + =20
>=20
> [Severity: High]
> Will this lead to an invalid free or memory leak when buf is later modifi=
ed?=20
>=20
> Further down in ftrace_set_clr_event(), buf is passed to strsep(), which
> modifies the pointer in place:
>=20
>     match =3D strsep(&buf, ":");
>=20
> If strsep() advances the pointer to the next token, the cleanup function
> will call kfree() on an interior pointer, causing a slab corruption bug or
> kernel panic upon scope exit. If buf is advanced to NULL (when no colon is
> found), it will result in a memory leak of the duplicated string since
> kfree(NULL) is a no-op.
>=20
> Could a separate pointer be used to track the allocation for cleanup,
> leaving buf free to be safely advanced by strsep()?

Yes, this is a legitimate bug.

I guess you need to have:

int ftrace_set_clr_event(struct trace_array *tr, const char *buffer, int se=
t)
{
	char *event =3D NULL, *sub =3D NULL, *match, *mod;
	char *buf;
	int ret;

	if (!tr)
		return -ENOENT;

	char *_buf __free(kfree) =3D kstrdup(_buf, GFP_KERNEL);
	if (!_buf)
		return -ENOMEM;

	/* Need to keep _buf pointing to the start of the buffer */
	buf =3D _buf;

-- Steve


>=20
> >  	/* Modules events can be appended with :mod:<module> */
> >  	mod =3D strstr(buf, ":mod:");
> >  	if (mod) { =20
>=20
> [ ... ]
>=20
> > @@ -1455,15 +1458,7 @@ int ftrace_set_clr_event(struct trace_array *tr,=
 char *buf, int set)
> >  			match =3D NULL;
> >  	}
> > =20
> > -	ret =3D __ftrace_set_clr_event(tr, match, sub, event, set, mod);
> > -
> > -	/* Put back the colon to allow this to be called again */
> > -	if (buf)
> > -		*(buf - 1) =3D ':';
> > -	if (mod)
> > -		*(mod - 5) =3D ':';
> > -
> > -	return ret;
> > +	return __ftrace_set_clr_event(tr, match, sub, event, set, mod);
> >  } =20
>=20


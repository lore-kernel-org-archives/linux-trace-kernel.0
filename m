Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD80B387361;
	Fri, 22 May 2026 20:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779482422; cv=none; b=T0w0Hnev/SHLFkQ6HHm2fEIS/XCyDl1V1rUwwsmJC2sebnl3Cxz15xT5tuqqUw/RoOuyp6RNqhNyKIk9PlE5ESa2GGu+9xolUMNg3VJ0ZmQVu9XVB5bYQAWlriMGYJHtkzvfX3MiSMLTL5nudZllXdEu+mnTn/vYoKlUhkMRsNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779482422; c=relaxed/simple;
	bh=TVsEWQ31RPj5yQtFgXMNMChTXhUUt5tba93wTAZNj8Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AflMRCAeuhtp2wcn9iapUkmy+i6EBd/oVQVzTWIOanTTA3AyfeuVbAA8TmpCtQLq9GeRn8dQBVdZDdpOzVeJ9R8/+h5QN4yQB9winGeC1yV5jr/wZMlQfChxjnXtx6+bScm+/GULrhzJjSWqWyz4L5RdL35/CM4VIuwdKltGEZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=Fb2AiEin; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="Fb2AiEin"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=iJPMhZ20VwhSDg5wfXMne49M7TO5GoUJ/84XYNmFdfs=; b=Fb2AiEinp2jX1m9VpD2kbthn+g
	mFCm3S6iJ6TH2B4bfR81qkhlzgbdyUqrdgHtZTzNT5duNsC5ihjcv7afjS4vy9WmeRfLLGKDWXHi9
	0lOXVpA4XqVobMQ64Ax0txXwCbKrQjQokuV8kS/L8PiD9lB3atvcvVHooxaJ3enHMQ120wlqteddd
	94ergDojrSZs6tR5pFFTM7o0GyJWAb437KDp5APi/VmzaJ/jVloMB20MaODXbk/wFVgPj5r7rKpQ9
	/hRDhXzO6Kh5nGc7LZ59IvIjiF4Z5uRBw0cxNb6PbO3otHw6mKuR7TX7AA5qO0FkmQ6QM/JBSnx4o
	+j+2lWMA==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wQWej-0000000029b-25Gf;
	Fri, 22 May 2026 16:39:41 -0400
Message-ID: <8f8d0cd380f40b84557304d110f38ecefc994a35.camel@surriel.com>
Subject: Re: [PATCH v2] perf/ftrace: Fix WARNING in
 __unregister_ftrace_function
From: Rik van Riel <riel@surriel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers	
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com,
 sashiko-bot@kernel.org, 	sashiko-reviews@lists.linux.dev
Date: Fri, 22 May 2026 16:39:41 -0400
In-Reply-To: <20260520164117.528d02fd@gandalf.local.home>
References: <20260513161916.04151502@fangorn>
	 <20260520164117.528d02fd@gandalf.local.home>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33A
 eo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47
 Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/
 lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdY
 dIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gU
 mllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986o
 gEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/
 r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHV
 WjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o
 6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635
 Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE
 +BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTe
 g4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/jddPx
 KRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/Ne
 fO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z
 3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0Mm
 G1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tP
 okBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznneko
 TE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44N
 cQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhI
 omYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0Ip
 QrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkE
 c4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-05-20 at 16:41 -0400, Steven Rostedt wrote:
>=20
> Rik,
>=20
> Can you reply to Sashiko here?
>=20
> The below comes from Sashiko:
> https://sashiko.dev/?list=3Dorg.kernel.vger.linux-trace-kernel#/patchset/=
20260513161916.04151502%40fangorn
>=20
> Thanks,
>=20
> -- Steve
>=20
>=20
> > commit f90ac36f39b79a19c015522bb1caf7ef903caf02
> > Author: Rik van Riel <riel@surriel.com>
> > perf/ftrace: Fix WARNING in __unregister_ftrace_function
> > This commit attempts to fix a WARN_ON triggered during
> > perf_event_alloc() error
> > cleanup by checking FTRACE_OPS_FL_ENABLED before unregistering the
> > ftrace
> > function. The warning occurs because the ftrace_ops registration
> > failed or was
> > torn down by perf_try_init_event() earlier, but the event->destroy
> > callback is
> > executed again during the error path.
> > > diff --git a/kernel/trace/trace_event_perf.c
> > > b/kernel/trace/trace_event_perf.c
> > > index 61e3a2620fa3c..8d64f17135e8f 100644
> > > --- a/kernel/trace/trace_event_perf.c
> > > +++ b/kernel/trace/trace_event_perf.c
> > > @@ -495,7 +495,11 @@ static int
> > > perf_ftrace_function_register(struct perf_event *event)
> > > =C2=A0static int perf_ftrace_function_unregister(struct perf_event
> > > *event)
> > > =C2=A0{
> > > =C2=A0	struct ftrace_ops *ops =3D &event->ftrace_ops;
> > > -	int ret =3D unregister_ftrace_function(ops);
> > > +	int ret =3D 0;
> > > +
> > > +	if (ops->flags & FTRACE_OPS_FL_ENABLED)
> > > +		ret =3D unregister_ftrace_function(ops);
> > > +
> > > =C2=A0	ftrace_free_filter(ops);
>=20
> > Does calling ftrace_free_filter() unconditionally here mask a
> > double-teardown
> > regression while leaving the underlying double-free active?

I don't see how calling ftrace_free_filter() twice would
call issues, given that it sets the ->*_hash values to
EMPTY_HASH:

void ftrace_free_filter(struct ftrace_ops *ops)
{
        ftrace_ops_init(ops);
        if (WARN_ON(ops->flags & FTRACE_OPS_FL_ENABLED))
                return;
        free_ftrace_hash(ops->func_hash->filter_hash);
        free_ftrace_hash(ops->func_hash->notrace_hash);
        ops->func_hash->filter_hash =3D EMPTY_HASH;
        ops->func_hash->notrace_hash =3D EMPTY_HASH;
}

void free_ftrace_hash(struct ftrace_hash *hash)
{
        if (!hash || hash =3D=3D EMPTY_HASH)
                return;
..


> > In perf_try_init_event(), if a PMU event_init() succeeds but a
> > subsequent
> > capability check fails, it explicitly calls event->destroy(event)
> > to roll back:
> > kernel/events/core.c:perf_try_init_event() {
> > =C2=A0=C2=A0=C2=A0 ...
> > 		if (ret && event->destroy)
> > 			event->destroy(event);
> > =C2=A0=C2=A0=C2=A0 ...
> > }

The error handling there all seems to "goto err_destroy"

err_destroy:
        if (event->destroy) {
                event->destroy(event);
                event->destroy =3D NULL;
        }


> > However, it does not set event->destroy to NULL.

... but it does?

I am not sure what code Sashiko is looking at,
but it does not look like the code I just pulled.

Is there a different tree I should be looking at
than upstream Linus?


--=20
All Rights Reversed.

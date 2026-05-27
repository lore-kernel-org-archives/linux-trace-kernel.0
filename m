Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE603E9C3B;
	Wed, 27 May 2026 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896601; cv=none; b=Su6I46uOcWadgwx3Yu0WLC0VCmdDOHVQ3DLan/EBWtVe0iU8YYVOrWjDXzgdaxE4L/mgmPATDbHWZSC0aktzCr/nkf3affddL4EDA1utW9jjW/eLzn57xD+kUvXcs3wLMkyR1kETkKdqrYsNCq54fozkdGjzoPaSvX3fsaA7LIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896601; c=relaxed/simple;
	bh=ZOzDLnaS0bo+mc90PR/0OezmaxJyBZ4LrSynx59KACk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DDeQSC9w+ZqC3jC1aAg/v+vdOkVQVG5AugjxSYxIEotqJz/dInE/+giWBrb3MFvMi4CyjYoai2bu485phdSKWYRnQ0Iy6KheZLEBp55xYVhnUdfqFrmnEpxDmfJuzTsAPye6LkB1C08GqbHLQNknBoCWetxQqvO+ZoxA5BapN+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=a9M+Bd3b; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="a9M+Bd3b"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZOzDLnaS0bo+mc90PR/0OezmaxJyBZ4LrSynx59KACk=; b=a9M+Bd3bLCflWA6kqsvxf4aNoZ
	z/qnwl9lEJcFgl+/pldGHGndyhl1wCIcXDBYN8/4Af4UdumDJjeBDjSKpGLrArzoifWqB1c8dNlYz
	YPo4tFcNWEFZC6EUarWJ96RnqeiVrhye81Map4TaIwdbP+9pEbqKk+TCdj9nOdFLUJ81UZiIdD8Xt
	KNlRzibujRyhEOpsJzJDfE0Vq9hau+0xh6Jx4GSl7YdmKWN8LFBGmF/vT6/bzIv+jD1S/GBJrHb+J
	wF/Gw/CXHK7huz0nZJ+2wgM7msUjMpR1MmosDavGtJTPOCWBLNpcLcD8SMSJYmZ8TRmeA1Nu4WWsX
	fuDTHKbg==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wSGPV-000000005Ws-0Rtd;
	Wed, 27 May 2026 11:43:09 -0400
Message-ID: <31f3b54dff7cb5edb15ffb84087cdab1985a0c62.camel@surriel.com>
Subject: Re: [PATCH v3] perf/ftrace: Fix WARNING in
 __unregister_ftrace_function
From: Rik van Riel <riel@surriel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, linux-trace-kernel@vger.kernel.org
Date: Wed, 27 May 2026 11:43:09 -0400
In-Reply-To: <20260527113732.664d26db@fedora>
References: <20260527111301.2d0d8256@fangorn>
	 <20260527113732.664d26db@fedora>
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

On Wed, 2026-05-27 at 11:37 -0400, Steven Rostedt wrote:
> On Wed, 27 May 2026 11:13:01 -0400
> Rik van Riel <riel@surriel.com> wrote:
>=20
> > perf_ftrace_function_unregister() unconditionally calls
> > unregister_ftrace_function() without checking whether the
> > ftrace_ops
> > was ever successfully registered. This triggers a WARN_ON in
> > __unregister_ftrace_function() when the ops doesn't have
> > FTRACE_OPS_FL_ENABLED set.
> >=20
> > This can happen during perf_event_alloc() error cleanup when
> > perf_trace_destroy() is called via __free_event() on an event whose
> > ftrace_ops registration failed or was already torn down by
> > perf_try_init_event()'s err_destroy path.
> >=20
> > The call path is:
> > =C2=A0 perf_event_alloc() error cleanup
> > =C2=A0=C2=A0=C2=A0 -> __free_event()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> event->destroy() [tp_perf_event_destr=
oy]
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> perf_trace_destroy()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> perf_trace_ev=
ent_close()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> T=
RACE_REG_PERF_CLOSE
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 -> perf_ftrace_function_unregister()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 -> unregister_ftrace_function()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> __unregister_ftrace_function()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> WARN_ON(!(ops->flags &
> > FTRACE_OPS_FL_ENABLED))=C2=A0=20
> >=20
> > Fix this by checking FTRACE_OPS_FL_ENABLED before attempting to
> > unregister. If the ops is not enabled, just free the filter and
> > return success.
> >=20
> > Signed-off-by: Rik van Riel <riel@surriel.com>
>=20
> Thanks Rik. Is this urgent where it should have a Fixes tag and Cc
> stable as well as be sent to Linus during the -rc release, or can it
> wait for the next merge window?
>=20

I don't think this patch has any particular urgency.

It can go in using whatever flow is most convenient.

--=20
All Rights Reversed.

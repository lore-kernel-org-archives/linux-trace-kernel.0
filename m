Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D10940711B
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Apr 2026 11:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775044072; cv=none; b=EhinC46ZfR/qBRqqjwxbJPS6ubygyMopb2tNHxtAeCSUvXIqZbj0z9z9lQdL2RM/zbsVi9odj3VprSKcX35fIPQ0M2J1R8QGjYZ9J467PvM3JYwjN3CJhzewl8k23FwYomtoFKWwsR0DSFzqlLQsAtCaUy4Rv9GnDqXkqGzjSIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775044072; c=relaxed/simple;
	bh=zatSHNhn3kz3WE8tEQq06UNzCwt7u0XFUsfRa3bGCnU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h/IOs5OLpKiU5Y/1Hde2wmZ4mYjFIv3WxqcI+CWp2QUcs24OdaobzH97BJgL/pks1XaUEhJ5fhulASz09eeolwmdFIEBg0Qcr5wbZCSOckg8u5sFjZf2yInDBl2wULmSJRxfBW5bY6f37dmeTDRioUF0CH+wm6qhpuKX27dN9qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UuKoEqwh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UuKoEqwh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775044070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zatSHNhn3kz3WE8tEQq06UNzCwt7u0XFUsfRa3bGCnU=;
	b=UuKoEqwhM1MiBO4SHDSqPEgW4OZpvNN/dIo2jveqvttZACLZxrRdimyKV/29EGRVi6b8iU
	Q+sHGU9R5c7P/abmGOnP3EWmJYNCiIkf58sfVxxRqR6HeVW6L87VkkGH8f5kZ96o3DXa5U
	OlBbPxtIz1Auki4/crNGldiy1sbabUs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-CJTVSorSPCmK188NUVXJVg-1; Wed, 01 Apr 2026 07:47:47 -0400
X-MC-Unique: CJTVSorSPCmK188NUVXJVg-1
X-Mimecast-MFC-AGG-ID: CJTVSorSPCmK188NUVXJVg_1775044066
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-486fc42c83aso54233385e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Apr 2026 04:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775044066; x=1775648866;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SeycZ4XowGxMHB7V4ZVlWm1d+k5nSK/rI2Y/d3VTHjQ=;
        b=bFTt5j4tfBDb7pEwzLGD4yMfkW2gbNU07sbkbeffnEI3sbd3jK2ORmqdDMUCfAghjf
         qgjCHTUuHjD9bO3xZmiNGiN9zd9XnG12uFtzCmlLt+419SPE82Fw/nC6lAxdJJFzTMWt
         piSCi7rFatd4MWReJAYlypASoBNZYiXF9SXIE5jqTQ01FLOYIGomJACtcVZxoCjTmZgn
         pQl7rJentzycniyh1vFfEFabWWLC9QZpiNo6iU3qhHLhUoY2CfgrDxm7t+HNojjXyBFp
         vgVBv0A7+OYcAoUh6Xzc3Nw26aq4/pafxfudYoB2kV7rzLKNKLJUQnMMeaV5tFMBAbeU
         WWYA==
X-Forwarded-Encrypted: i=1; AJvYcCW2CoPeBONuMrDPL/YzYkYgZVcsj0oWZyqUGYT1WS4cvFzHBBKMlwnTFUbyxZDMdengHUWWrAGuyBSEYRu9z8JeDaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPWDl1E/UQIMquAKElzIIqW5w9uhtEJMXzU4Ha5ljalfSOKkoJ
	YxNe770fok0I9DEvGqMlRfCwzUfaNjwXJitlnY8ne4KPWld5o3DfdZ+QTty+O29HUC08xMsWMAM
	NzecOeEn3sIGfvb2oWKKqbU9G8rNDXZSQwVPKwxdhzbjWS+h2NvkJ/OMiOnaJRx0y3NBXLA3dm/
	t4ZdjxpMlU
X-Gm-Gg: ATEYQzzIs6k0fsiHwwgS9T1Eeldi4t441NbjQoGhOq0spjlMWLDVS08s+djRjRtaIHK
	aE+EJGaucoUhysIO6pJJow+B0oWhKj6IYqIrRsuTjWduwcCLTHcsKt4A1CWYzWxjq29faaGDTPg
	si5BsYciI9bmFx7/IyABP88JV9AC8TUwWpuZAr3j0qMsdWkQGNWvIax8QUMb8PIHQblLp7wLP7e
	63V+vHzgBkL1jFxLSYeAXVQLHSViI+03QJbk866Kbi6mjGUEaZ0AtLUBTK96zMHg0Q+nsc1OIIT
	XGEr1MbbEiV+GbGDB2VQ7i7pk6z2dgSY3hMKOdbGGDi0bcu3GdLJBjo8dZxWzNCiQDp+awgdOIC
	xV7tDMyEscCuY7QNR9fJfXV/Yg9mk5PcEoVpCuLkPcx+FLcIA6+iFmb5RC1KwXhK+cYVs7RGiE9
	/JrTIJ4RMtp+6OOuo=
X-Received: by 2002:a05:600c:1e8c:b0:485:46fd:7887 with SMTP id 5b1f17b1804b1-4888356734dmr56518795e9.13.1775044065997;
        Wed, 01 Apr 2026 04:47:45 -0700 (PDT)
X-Received: by 2002:a05:600c:1e8c:b0:485:46fd:7887 with SMTP id 5b1f17b1804b1-4888356734dmr56518315e9.13.1775044065472;
        Wed, 01 Apr 2026 04:47:45 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c7510d3sm55825315e9.5.2026.04.01.04.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 04:47:44 -0700 (PDT)
Message-ID: <21c06a117b044e77e6191d6ad7e8691ec8b7b53f.camel@redhat.com>
Subject: Re: [PATCH] rv: Allow epoll in rtapp-sleep monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Wed, 01 Apr 2026 13:47:43 +0200
In-Reply-To: <87v7ec6n1n.fsf@yellow.woof>
References: <20260331104918.2710853-1-namcao@linutronix.de>
	 <58674d7f10c260369f5cb78599ba6ecb3804358f.camel@redhat.com>
	 <87v7ec6n1n.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AURaFxm766YqfnGFvSo8iymgzOtqZX461CaDYTKn-Fw_1775044066
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-03-31 at 17:23 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > On Tue, 2026-03-31 at 12:49 +0200, Nam Cao wrote:
> > > diff --git a/kernel/trace/rv/monitors/sleep/sleep.c
> > > b/kernel/trace/rv/monitors/sleep/sleep.c
> > > index c1347da69e9d..59091863c17c 100644
> > > --- a/kernel/trace/rv/monitors/sleep/sleep.c
> > > +++ b/kernel/trace/rv/monitors/sleep/sleep.c
> > > @@ -162,6 +164,11 @@ static void handle_sys_enter(void *data, struct
> > > pt_regs
> > > *regs, long id)
> > > =C2=A0=09=09=09break;
> > > =C2=A0=09=09}
> > > =C2=A0=09=09break;
> > > +#ifdef __NR_epoll_wait
> > > +=09case __NR_epoll_wait:
> > > +=09=09ltl_atom_set(mon, LTL_EPOLL_WAIT, true);
> > > +=09=09break;
> > > +#endif
> >=20
> > Sashiko (the AI bot) wonders why this isn't ltl_atom_update() like othe=
r
> > things
> > around here. Is that intentional?
>=20
> No that's not intentional. It does not affect verification result, but
> still should be fixed. I will send v2.
>=20
> Funnily a colleague just told me earlier today about how good AIs are at
> reviewing..

Well, they're probably already better than (most of) us in those kind of
consistency assessments..

Anyway, I tried your changes and it seems to work as I'd expect. Feel free =
to
send a V2 and I can include it in the pull request.

Thanks,
Gabriele


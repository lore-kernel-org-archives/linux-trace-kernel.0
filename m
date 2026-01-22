Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A516C1F03D2
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Jan 2026 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769089807; cv=none; b=RjagMDeZrLsQV/vbDuRqtnTPfkgMnKZI9BBiJ8rAGgFjGGOYdD8UxvFZ+kZZH1GWgq8bvJ7OAkosycH4yXezyJdAyJ6nFH9ExI41LYuhJOSKfve8P50Wn7RLQA45+maKI/FdUVC+1IIbDEfXUz/Pn+3n+yvCC2+/YuRoKoIoik4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769089807; c=relaxed/simple;
	bh=mViq+woi6E37Oh81LrkUqu2EdTY6IKGCSug2bX/6anU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EbwQrDkBeGIs+tVWlWoaTxPJ5Dy8hnKGHi3AFB+9/l6Uwmo8kDgPsXgbqxF40KI2JJhqgujhJYFP7JCjb/B4CvFBuGFy8r70sp7CzzyXgygDuCyMp0CkPvk65rwvfr/827NUDiBFmxFci9R1JoVtW8OdR/AJq6Ct6Jb1PWEmTf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BJt1e42/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJt1e42/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769089804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mViq+woi6E37Oh81LrkUqu2EdTY6IKGCSug2bX/6anU=;
	b=BJt1e42/HARjQxwofAQnk5yo0IdXk11x8iEUcpcT+VL8/Huk1sfDLmzLdTRu0HEtXDl7Pi
	dycT+NBOdByhhh1pY6U62xzPxFqnyfW9hR0Ea7PMmwPMYvfdI3oYeTW0T6kRWVXEgLTOHI
	nK4W743ktlRtCVHVrdXC0W1VssSAVjQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-qOFIGTe8OtqnKVFbsSiRgg-1; Thu, 22 Jan 2026 08:50:03 -0500
X-MC-Unique: qOFIGTe8OtqnKVFbsSiRgg-1
X-Mimecast-MFC-AGG-ID: qOFIGTe8OtqnKVFbsSiRgg_1769089802
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4803a72daaeso8408215e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Jan 2026 05:50:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769089802; x=1769694602;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mViq+woi6E37Oh81LrkUqu2EdTY6IKGCSug2bX/6anU=;
        b=w6egDE1EZ3mCFMLLT1dN+jwqz+kA1GZtwI3y2IjpN7OTdcnzzOEBehKjubnuYFn7vM
         sJZBAYDFKvUKVj4uhH5aWdAHTED0O88WbdDf2Ep3tDXr5sbQtQfcrDHiCgz3LwmsBgJf
         NlRZRaUCXCfmn/C2vXIc4gxuUkC9EpaC/35fCrA+N4/I7JsYO2jnzLcgwfoSUv5zYX1S
         MrImoOUY+bnWPeon5ANiNwNqJjWVLKwF4mGctnsLiLVtHWxyL/ayukH6/DLVRCKiGkpF
         LBKRtQPMNwT1wnQgh1oGc4eiEwFeelyyYYEc8uKOnLTjpMaQRXG50ENMZgXtyECHsiBD
         5JYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2q2At3BOu7sejDA/qqc6Opm+f5kugoBB65LlUC2c4wsHCCYwH7wrF5KfRCQESWE5nAgw6nAWQ3QXGpD/pDfdcIps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz15k6C9ok+NqTzTGGO+kcbWGnsSNTudalWhXWUuxkqBqOVN92a
	fAy0Ey83M2rbIg/27nMWnyxhQEXwNsdIO+ahi+LRSXDn3kTlgIj+v3sXjRSOU4omN2ffDDkog3r
	F9AEHePFI91NX3gDbgIXYwDY3Kwq5bFhIKGWYRY2KeRzc8GH1YrRhfD/pI5xXGvD+UVuR/5G/R6
	6L7FOIDB0s
X-Gm-Gg: AZuq6aKDIOp2tlHuxh05UwOkpqakBr/Nqucad+B6KtMdbuaEiVkj6I1pcRxnZOWlEY2
	YxpR7E0AEDyUr3wYix/1+UftU6U5KoHm+cZRsr/3DCmDOqiqIEYleUpX7Jbpbx1WetSkS1UZnDc
	AnA4co8wzEcFtaq9E0rQ5jDPt1XXGLfiihWwzvgUJpIOv4ZnWJUe0+Gc43k3geBZlmoux2elpM/
	44XEjKVMTAdXlHGdyXn4J7d3thkOWesUs+T5zM+t9jjeY+ejS7NwxbyazfcEaq4BvH8d3/32Qnh
	JhwvxVoHdUJgWF4Z2yNxefTAecu/cZClk14JH7Nou7xpdtGGNpRl0p54EYbmgSKgA5a99jqa6s8
	/2OIWiRFUmzjvjjyezlS5jDbpTN2ItVtEb9mrlQP6PjV0pDoRA4aJ9uufLMBksDreVEjpbXCKpH
	6yBnv09YQv
X-Received: by 2002:a05:600c:4fd0:b0:46e:2815:8568 with SMTP id 5b1f17b1804b1-4804708299dmr29790505e9.10.1769089801945;
        Thu, 22 Jan 2026 05:50:01 -0800 (PST)
X-Received: by 2002:a05:600c:4fd0:b0:46e:2815:8568 with SMTP id 5b1f17b1804b1-4804708299dmr29790095e9.10.1769089801517;
        Thu, 22 Jan 2026 05:50:01 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480470287c3sm74977545e9.3.2026.01.22.05.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 05:50:01 -0800 (PST)
Message-ID: <ed5ffb1045a5d0734947019ad31b9bf46bdca3ab.camel@redhat.com>
Subject: Re: [PATCH 18/26] rv/rvgen: add fill_tracepoint_args_skel stub to
 ltl2k
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
 open list <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION
 (RV)"	 <linux-trace-kernel@vger.kernel.org>
Date: Thu, 22 Jan 2026 14:49:59 +0100
In-Reply-To: <aXIhSGAQvflGAEsN@fedora>
References: <20260119205601.105821-1-wander@redhat.com>
	 <20260119205601.105821-19-wander@redhat.com>
	 <1f168ff5ffb531570fd83e3f398380e8df053275.camel@redhat.com>
	 <aXESFlL56FA0PyTZ@fedora> <aXIhSGAQvflGAEsN@fedora>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Wx9LuIP1GThMjzhf4sjOMz-N_S4JZI4VJj8YTdtUuAw_1769089802
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-01-22 at 10:10 -0300, Wander Lairson Costa wrote:
> On Wed, Jan 21, 2026 at 02:53:03PM -0300, Wander Lairson Costa wrote:
> > On Wed, Jan 21, 2026 at 02:57:02PM +0100, Gabriele Monaco wrote:
> > > Mmh, this is a bit fishy though.
> > > We the patch using the decorator seems fine, but highlights how this
> > > method
> > > isn't meant to be in Monitor if not all monitors use it..
> > > Adding a stub here is just sweeping dust under the carpet.
> > >=20
> > > Here should probably keep the common part of fill_trace_h() in Monito=
r
> > > (e.g.
> > > replacing MODEL_NAME and other common things) and create specific
> > > implementations in dot2k and ltl2k for what is not common while calli=
ng
> > > the
> > > super() counterpart for the rest.
> > >=20
> > > Does it make sense to you?
> >=20
> > Yes, that is exactly my idea. Since the patch series were getting too
> > long and my brain too rot, I thought would be better addressing this in
> > a following up patch series. But I can work in the next version if you
> > are not ok with that approach.

Good point, that can be a separate series so that we don't mix too many thi=
ngs,
but I'd also separate the initial patch introducing the @not_implemented .

> I gave more thought on this matter yesterday before bed. Maybe this
> isn't a issue on the design. Some methods on Monitor might just have a
> harmless default behavior. I look into it more closely for next the
> round.

Well, I believe that if a bunch of methods from the parent class don't need=
 to
be called and we have to create stubs just to avoid errors, those methods
probably shouldn't be there in the first place.

That's particularly valid for the Container class, that won't ever need to =
fill
tracepoints and other stuff.

Why fill_tracepoint_args_skel() is not required by LTL is an implementation
detail, so that stub could even stay, in case future monitors are going to =
need
the entire thing.
Though I still find it cleaner to move that away too until there's a need f=
or it
shared in Monitor.

What do you think?

Thanks,
Gabriele


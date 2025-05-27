Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2441F582A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 27 May 2025 09:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748338364; cv=none; b=Et/ksmJuLFvdlFGlNI5TiF8LFKCY9ON56g07eP58iyd3kKtfT6h9C2oKSP8bx9U27MbT585blnGmIQGlQ4IZxiyRLMsom/EgvZ0SRLvKIDAhh8DVrh2RemEKOxvp8FxPmA0kZkaSDK+WxzOsOkobcDNGHah8lTxUftlekRai7IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748338364; c=relaxed/simple;
	bh=kBOYzjEOA1UOSzxYusR2QCkHuynXvOslEyq8QhBHrQE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oaDYjzh9JpRAjug52c+/aQSJxT3ieSeqad00+HmiNxijYB1k4s95/Vwd4tbIO6dtVnKWkQzz8fDsZC72HxAu4PkGPcvLQKqfWYcys5EsbXF18yNzWg16Oy7vdRCtpwDaNcRiCAz9XqDpMLqaSS2RJPyxZXsuA9GUenI8OABrdX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YdKVbTWI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdKVbTWI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748338359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kBOYzjEOA1UOSzxYusR2QCkHuynXvOslEyq8QhBHrQE=;
	b=YdKVbTWIwOyW/gt12oEHjhcnyF9aUMZG+2NUuYaDJsz8rdFKLoNY19hl5YdneVoOlxIGIR
	HvFWtwuRJu3h8kZOFJzsGAYu5nCT8nZJenRMYePwbt39N6SROmq7w1CHeZ8FJ1QdUBeyxR
	3pj2i1HQJYntBXowfnTD88punnk1za0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-mAf3ScDaMb2eNA5c3qj3Vw-1; Tue, 27 May 2025 05:32:38 -0400
X-MC-Unique: mAf3ScDaMb2eNA5c3qj3Vw-1
X-Mimecast-MFC-AGG-ID: mAf3ScDaMb2eNA5c3qj3Vw_1748338357
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a36bbfbd96so1031551f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 27 May 2025 02:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748338357; x=1748943157;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kBOYzjEOA1UOSzxYusR2QCkHuynXvOslEyq8QhBHrQE=;
        b=qZjy6HSU79MwSNWroMn7m9ho0TGURBPgw6ZTBF5f/XPL6aic/hmsigAl31YPguwa1F
         I+zUkoT244yr24ZG3k20e9Vi7Xrt28bvT/VjY3n2u163WkvLvRfJchxAbgPSruwwJv2t
         HCGWkix3hpqnGbG+OeR6ac02BkZiN3aN3iRvNgPd0WXLW3Y9/PnghRwcNtJW5XNrH9f1
         Zu6raIdK+XonEOI9PVTc89k8B0el/S0WVQYRVfDZAIpxemwfF7V5bMiGkO94QDtLd5VW
         c9wcXh9OaCJXT45RQyuf5+ioLm50nDATAZo6FhTf8iAtY3aRBai+GfxVRqNGdoOJpbG0
         +mVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgCGNwpOBGdKjgZE4iE6LAChLktuE80LS1zKDZq7tZilcpwJcS5+IQ62yPXdHTG/pxNH2EAa6skHbgWd57VoIa8wM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJNKshgrNiX6Ec+DPM8Nv4nHHhg+j+BR6PaVqxiopUhCC9FAEK
	q8aQTD+upjat8GbdIBY7BUAXs76TshmbhHnwkPZsjYkrFbrQTmMIUifTJqfJh/qJOlGjpAuuNr7
	UmHaCUOW/YP/yiRAV9yEn+3JC+szERv4dkb86K6SWegWHtiiS1UJXn2Xqet0NdDbM9/cK6Of+9g
	==
X-Gm-Gg: ASbGncuVcb+g2RkZFvvx/hAQ7Y9Y8vQtBolxSsM215ek25BFfS0AyffMRk7dWBKnkpQ
	QPDR0sbKl4lf4F2k2SFba8EKEX2TvgFB2zgAGuCNJr6uLNdNFF/fe5q9e5ciBVcfCdeU6mEwuwB
	noUtSpGX2HomYr5/JBUZIzuupqPHOudVkjya9ynYczxYmNn3JLMQ8Tnz8pLli+EdZ+jzJ8laS6I
	KZ5T07clFX2qloX+UJhwlU7vVGWDeEkWY6orlW4Bd8ri297STPZFe3rLGzU7sa9nq/rX3DVMusE
	UUQVRQFxaZpoJm6jZn+iWuncw14l8LNbeiAihg==
X-Received: by 2002:a05:6000:1814:b0:3a4:cb8e:d118 with SMTP id ffacd0b85a97d-3a4cb8ed307mr7788278f8f.24.1748338357318;
        Tue, 27 May 2025 02:32:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOPw1yKFpRKpRR31/yCWnQYEpqGvfknCwekf03EA5lc6V5ZNABZ3W/T4ahko0a/4vA/rRcPA==
X-Received: by 2002:a05:6000:1814:b0:3a4:cb8e:d118 with SMTP id ffacd0b85a97d-3a4cb8ed307mr7788256f8f.24.1748338356977;
        Tue, 27 May 2025 02:32:36 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4e4f4d58esm206946f8f.28.2025.05.27.02.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 02:32:36 -0700 (PDT)
Message-ID: <91719ddbeca0e37617558687feb1191a69793dad.camel@redhat.com>
Subject: Re: [PATCH v9 12/22] verification/rvgen: Restructure the classes to
 prepare for LTL inclusion
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 john.ogness@linutronix.de
Date: Tue, 27 May 2025 11:32:35 +0200
In-Reply-To: <20250527092734.BgoHvn6n@linutronix.de>
References: <cover.1747649899.git.namcao@linutronix.de>
	 <c1dd325f5f8f01dd7c29ff90be22164c17f073a0.1747649899.git.namcao@linutronix.de>
	 <1927d98817cd97a70d177e0a3001603ee3e34b35.camel@redhat.com>
	 <20250527092734.BgoHvn6n@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 42FQ3qm4TlgDst0680ketFb4e00msIzXmpbOeefk9zQ_1748338357
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Tue, 2025-05-27 at 11:27 +0200, Nam Cao wrote:
> On Tue, May 27, 2025 at 11:15:21AM +0200, Gabriele Monaco wrote:
> >=20
> >=20
> > On Mon, 2025-05-19 at 12:27 +0200, Nam Cao wrote:
> > > Both container generation and DA monitor generation is
> > > implemented in
> > > the
> > > class dot2k. That requires some ugly "if is_container ... else
> > > ...".
> > > If
> > > linear temporal logic support is added at the current state, the
> > > "if
> > > else"
> > > chain is longer and uglier.
> > >=20
> > > Furthermore, container generation is irrevelant to .dot files. It
> > > is
> > > therefore illogical to be implemented in class "dot2k".
> > >=20
> > > Clean it up, restructure the dot2k class into the following class
> > > hierarchy:
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (RVGenerator)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 /\
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /=C2=A0 \
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=
=C2=A0=C2=A0=C2=A0 \
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > > =C2=A0=C2=A0=C2=A0 (Container)=C2=A0 (Monitor)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /\
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=C2=A0 \
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=C2=A0=C2=A0=C2=A0 \
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (dot2k)=C2=A0 [ltl2k] <- intended
> > >=20
> > > This allows a simple and clean integration of LTL.
> > >=20
> > > Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
> > > Signed-off-by: Nam Cao <namcao@linutronix.de>
> > > ---
> >=20
> > Steve,
> >=20
> > since this series is quite /meaty/ and it seems the later parts
> > require
> > a bit more discussion about tracepoints, could we start merging
> > until
> > here (1-12/22)?
> > I'd be tempted merging also 13 (actual LTL introduction) but
> > perhaps
> > keeping it together with the LTL monitors is cleaner.
>=20
> The x86 patches have been merged through tip tree. My plan is sending
> the
> next version without the merged x86 patches, and without the arm64
> patch -
> it can be sent separately. Then the whole series can be applied.
>=20
> I will do it after the merge window.

Alright, sounds good too.
Sorry for being pushy but I'm have a couple of other series kinda based
on this one and I'm getting a bit crazy maintaining all that ;)

Cheers,
Gabriele

>=20
> Best regards,
> Nam


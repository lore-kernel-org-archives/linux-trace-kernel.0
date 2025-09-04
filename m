Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C55E2C21EB
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Sep 2025 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975181; cv=none; b=HGwyy4z6LcR8Lu+gHzEdW3KLDcdJsBMgUiW3cSS9LHvylJEA/mAJurCowXf9t77n7H5xnXZGukhUjWCbWBSjPbuKZngMxVqHOzEBZ14OWp4Lmqhl0Z7x6nwg/xQ4oAhctEWb2WOsvYbTU0JU1Jy04sAT0b9CM7agEfjlHNGt0xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975181; c=relaxed/simple;
	bh=XFpM+yYTaMrEnROi9B4nYgCpjcyWjoNNWbxY2syzKVs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TJwth5uNhVBPEp3uKLhMP2kJ/DKKamY0Z8px/mUXJF9C+j1b8m3glyIkXGx6B5+nZ0SnIwEJY4YIP9zu+U9tecT0A+IAmpMnwMfF66x3G9mJ0yIKCitJnMQQEdt96Bi3mB0avRsBRraaOTYOP/NUth32Y/VZyu4ZpizuSmPZ9ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZr+z59H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZr+z59H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756975178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XFpM+yYTaMrEnROi9B4nYgCpjcyWjoNNWbxY2syzKVs=;
	b=IZr+z59HPemFBV0HhLicwmwrlWx9C7o85KVBE74tZfiqNxqlYfIerVs1H4DTAJDFgxxbaL
	2vD+xK63L97s8HAGn/6e9sIxjD2XQopv9xjFEAWO0BYI6lB5OuCerJDaLNP3HgcdaPcoPi
	tC/yXcHlR+T84c61HhrCXBEjM52ZsG8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-A1WBfG9HNyq6s-CNu3fDoQ-1; Thu, 04 Sep 2025 04:39:35 -0400
X-MC-Unique: A1WBfG9HNyq6s-CNu3fDoQ-1
X-Mimecast-MFC-AGG-ID: A1WBfG9HNyq6s-CNu3fDoQ_1756975174
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3df2f4aedd1so493224f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 04 Sep 2025 01:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756975174; x=1757579974;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f0hzQ2a9v1Rzd23MMlpkQFgzttJOaFNChg5sTvJ96Kk=;
        b=vkfgCTgIYNFV4ZVqZg46W24rebBF1QWMhUm5Hbptk126dIncLwt+0PpDUHCi81ZKjU
         q5+Dt3kGRKCdBj+s3dpjeNbjGk9OqDOOfH4OY7Ebn+jIRyG03wQ+ZEyvYBJvadjXNb6/
         YqgbhwSoB8YfrRpzCIENVxZThBJCyJ1rMrEGXV0zCaN5bboL8bOf4VkgFPOYS4kkdLcS
         bW3hILkhdmPfoqUwx58RI3ALbr9b0RlwbaYxxrCO/aa8S+TTjgB/P6pKrzAQpTK/MxWz
         qCFXtZ6XC/OnXovMRdmm9D/jBBog6cQahGDT2B9w9aTelecbLObdjfbBXxsxX3w/HPnX
         y9tg==
X-Forwarded-Encrypted: i=1; AJvYcCXj2QYvf+UivMXPuEuENPn2cagCipQ+6InrSVa0qXDJwW58TSMxcs+oGwTuO2qPZnWv6jvgtD9PHDy0iErBCebU0Og=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLMsJD+sQcjGkvgpID7kvYVp528jGO1qiXpjTneQdJIz11RnbC
	kbrVG+aTbf6gfDhZdTCFOSUtQW4rhzd7BRTFJAWwBZGhUxIgJlUytTA0NUUJgngZm5nU7NYNSLU
	Pxb56xfhGxRSPwJKNMHKtaTPQtHW88erNN17eLFI8BspktH4+ido81FW/Y0RAh+BN9dqvVTxlKq
	ie5f3AEo1i
X-Gm-Gg: ASbGncvd83jKEv8EtMlQteedl5FUhIzvFZkdJapgc0OfNs0qpa0lZ1e4NqNslnPRje6
	LY0uhueOg01Asw8sZVIomizDxwCSm8p/a5hu2mpMg8HxxOdt/QcMOCDIkaQUC7M+0RVm8XFYVfX
	/MM5zuYsXXXluAgseP7ImANOXaVauoyCs1fesFxSPk8DxJlJYNI/f5iTR+USt1XZENC75tbj+F2
	vYe3BkbLMtb6DNTgUj5dbBPohKXlHMMDw3I+lozFliohFdtVkWaAHMLyjWyeuRTnLBQX5Uidbvm
	z1vViTPFB5yADMO+O93qxFEunKhDQyiJD1H4kzAQzp9A6i5MOq7r2PSzzGK1RlnGnQ==
X-Received: by 2002:a05:6000:4202:b0:3e1:addf:58f4 with SMTP id ffacd0b85a97d-3e1addf6672mr660507f8f.57.1756975173865;
        Thu, 04 Sep 2025 01:39:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZE7tSFnufedEV5cMkbNyKprnC3TYa8i/aOEHrDa/AD29kXH54pzkmGPOW9Qhn5Fp6F3/bOg==
X-Received: by 2002:a05:6000:4202:b0:3e1:addf:58f4 with SMTP id ffacd0b85a97d-3e1addf6672mr660479f8f.57.1756975173416;
        Thu, 04 Sep 2025 01:39:33 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d520eada16sm17982800f8f.41.2025.09.04.01.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 01:39:32 -0700 (PDT)
Message-ID: <a2813fab9089cf89d6ac60998abe4fa3f226d9d7.camel@redhat.com>
Subject: Re: [RFC PATCH 16/17] verification/rvgen: Add support for per-obj
 monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, Tomas Glozar <tglozar@redhat.com>, Juri
 Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John Kacur
 <jkacur@redhat.com>
Date: Thu, 04 Sep 2025 10:39:31 +0200
In-Reply-To: <20250904082054.W0fQJAQw@linutronix.de>
References: <20250814150809.140739-1-gmonaco@redhat.com>
	 <20250814150809.140739-17-gmonaco@redhat.com>
	 <20250904082054.W0fQJAQw@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: QpqeWQMrueDMTl-AH25WeM0LoS_xDMCxWxBqpeHODqc_1756975174
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Thu, 2025-09-04 at 10:20 +0200, Nam Cao wrote:
> On Thu, Aug 14, 2025 at 05:08:08PM +0200, Gabriele Monaco wrote:
> > +=C2=A0=C2=A0=C2=A0 def fill_per_obj_definitions(self) -> list:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self.monitor_type =3D=3D=
 "per_obj":
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn ["""
> > +/*
> > + * da_get_id - Get the id from a target
> > + */
> > +static inline da_id_type da_get_id(monitor_target target)
> > +{
> > +=09return /* XXX: define how to get an id from the target */;
> > +}
> > +"""]
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return []
> > +
>=20
> I know this is the existing style that we have. But I think this is
> not something we should keep. How about something like:
>=20
> import textwrap
>=20
> def fill_per_obj_definitions(self) -> list:
> =C2=A0=C2=A0=C2=A0 if self.monitor_type =3D=3D "per_obj":
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return [textwrap.dedent("""
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
* da_get_id - Get the id from a target
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
*/
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 static=
 inline da_id_type da_get_id(monitor_target target)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=09return /* XXX: define how to get an id from the
> target */;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """)]
> =C2=A0=C2=A0=C2=A0 return []

Mmh, I see what you mean.
I wasn't aware of this textwrap, but what immediately comes to mind is
that we'd end up mixing spaces (python indentation) and tabs (C
indentation).
While textwrap may handle the case, it doesn't look too readable to me.

I'd say we can (slowly) transition to using textwrap here but mandate
having \t for tabs to make them explicit (didn't test).

What do you think?

Thanks,
Gabriele


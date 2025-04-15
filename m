Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B1D28B4E3
	for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Apr 2025 12:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744721250; cv=none; b=RU1hojwZ8ZOo0WrLSx/IRYjLVk6WSNGJDkGeLYQMC6wYfd07OYVGUPrN1Ep1NDYqgy6G1xt9YGTeMN3ZQRadLwuuo2EEf3c+/Y9U89YA04a14TezJCLMJJpXIQu70uOt1B5kRfWNUGcUMROXzPVC+Gs4NhDkUWP4Uhx0fT/RXQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744721250; c=relaxed/simple;
	bh=h5hzw3UWlyBWtKaqUctLttnh3UnjKuRPZkqWKkRDgxc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FRyyVKAK79wJcCWFz05dj7JddEaXHmKPfDqUvMQ6OLDIZPTnCvjw/cpaXZOif/Hw0O0ar3mLlBdHy/ZFCKwoJB475AeNbV1judujuKMDz1BbmD3eW3afBuIwsT7szkn9dEybX/IH1JW9mTLa62nyztoNMm7RaMVrzWxKwbi+Ji4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iB+miSDs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iB+miSDs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744721247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=h5hzw3UWlyBWtKaqUctLttnh3UnjKuRPZkqWKkRDgxc=;
	b=iB+miSDsu14hDr0jwB/IiYWsxymI8xNSrwkc+Taw2ZmBU58d9nsjI74OD7I/YWf/zwXYBc
	VBmT4dc/Bu+mXLVDr0p7WHxvkEiLmqXAvBAyz9PIEnHfiRwVZUeOcLoyvPtxq9tL8DNP+c
	GvSjO27Dd1Rvk7gd1lGlY3LnOqECjhU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-p-E1RloCNYqQ6eNs3dGG6Q-1; Tue, 15 Apr 2025 08:47:25 -0400
X-MC-Unique: p-E1RloCNYqQ6eNs3dGG6Q-1
X-Mimecast-MFC-AGG-ID: p-E1RloCNYqQ6eNs3dGG6Q_1744721244
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43947a0919aso37621125e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Apr 2025 05:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744721244; x=1745326044;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xnvL/RzrZbvMsU8LLxk8J6aVRTg+wYgjgOPs3GeZ1OI=;
        b=wGDz+8DTc5OIIZEH+aNuUpBCdUHHN1a22WMmOI4yIpMaLXEa/EZA9YPVixirlQdC6b
         tv1juIL+JXqivQ0seZ2O8bR2FDuSmx06xKJK74bi2VCKVy3VHOsLSVK5vAMiXYzoGOq8
         6hRyljr05z75VBsRHGeso7ZOWz4GZfOM6oyMJVyn26KOu0rpVfs5Ac/jwzf4juJMkEjW
         FTX5azs873/Dy5c7OHOiizwywfMq7d3jjioSQXZQ/s3lv+2AMguTXpVyqI8uyKvM75Bx
         feRRy+UhhiX8uQrOBRDKR0P2H+gGkzOh/bnRPxS6/ZH7g/RzZO2db1mKzIsrTDb9IB7h
         hzZg==
X-Forwarded-Encrypted: i=1; AJvYcCX/syRQ8AtNsVqdb/p9q9AxCf6RnLDt91WDcdsnxf+/Qt7nbRjTABT9i2Y1ltJqjAVGLDeRTtYvxD2YZOrxuDMyAyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbEoAGierVfkwRjnqk0PSlt0v3fN8b1OLlxkhgTEqm9CHsOMAx
	d13vRME4RmBTjpIue/LikYTEJcfDXHhGO3HZ6qbzg6dlOp/ae0v2y45sXMVNX7tvALrd4Dt/DvF
	w6TNKpp7SH6BLQx0hdbGfwFC8L1Wz1XosbdMAZRKplFUdcZHHYEnrTD1iOrlOcm1TeHHEIt55Dc
	fWXYiS79Y=
X-Gm-Gg: ASbGncsrDOkB6/fASK1M6nEN89n9nZ4unfHB+sfAuKoc65pXAll+DMRx9EcBzvoyXc6
	0+qdFMHeY6Hm96fzIr2fSRWplhau/0azbFmLPhESeoqTSYpSi+h6V1UJ6GAkRGtCUiHZvPYCfKy
	0y/shRzzf9UpPo+ydTDAzCReAPpPPtDJwdMUWGHy37m0gqbG4GEBcEvI15kqdB/Lk96sJRuJ44i
	uFXAy7w8lNmd9vy6t4myatP1/HraftzijyvUokP/VbG47a0Prm0Y+iwj+qbM7pMnmdsqICYl6zb
	2gEgr3LOtmndPe/7RWmJHGyBT5AIx+zDdIRdEzg=
X-Received: by 2002:a05:6000:40cb:b0:39e:dbec:aaee with SMTP id ffacd0b85a97d-39edbecab22mr2873523f8f.58.1744721244522;
        Tue, 15 Apr 2025 05:47:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXUPk+FI5lntzdi59X0ntV/dg2Dh/FHAzlX7wLgVi/RsI8JfnVsjgzuQyhk0RPvQ5MlNQflQ==
X-Received: by 2002:a05:6000:40cb:b0:39e:dbec:aaee with SMTP id ffacd0b85a97d-39edbecab22mr2873509f8f.58.1744721244204;
        Tue, 15 Apr 2025 05:47:24 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.134.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43d053sm14314316f8f.68.2025.04.15.05.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 05:47:23 -0700 (PDT)
Message-ID: <241fb4fa91f8e57d2bcc992b6a4fb3fffc9c87fc.camel@redhat.com>
Subject: Re: [PATCH v2 19/22] rv: Add rtapp_pagefault monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 john.ogness@linutronix.de, Catalin Marinas	 <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Paul Walmsley	 <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou	 <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>, Thomas Gleixner	 <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov	 <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H . Peter Anvin"	
 <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra	
 <peterz@infradead.org>, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org
Date: Tue, 15 Apr 2025 14:47:21 +0200
In-Reply-To: <20250415123807.2MahJd60@linutronix.de>
References: <cover.1744355018.git.namcao@linutronix.de>
	 <f57547af5e8c836f5c548f624e61f3e0002ce0b4.1744355018.git.namcao@linutronix.de>
	 <4d5dd1b919aada32ddf4dbce895f19e558343ee9.camel@redhat.com>
	 <20250415123807.2MahJd60@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yrIsSzZbhuVFQt7amEO4dnn2NBEeG1hA1Un2yK5QpnM_1744721244
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Tue, 2025-04-15 at 14:38 +0200, Nam Cao wrote:
> On Tue, Apr 15, 2025 at 02:31:43PM +0200, Gabriele Monaco wrote:
> > On Fri, 2025-04-11 at 09:37 +0200, Nam Cao wrote:
> > > +static int __init register_pagefault(void)
> > > +{
> > > +=09rv_register_monitor(&rv_pagefault, &rv_rtapp);
> > > +=09return 0;
> >=20
> > Any reason why you aren't returning the error value from the
> > monitor
> > registration?
>=20
> Copy-paste from dot2k :P

Mmh, you're right! All other monitors are broken in this sense..

>=20
> > Other than that, the monitor seems neat and reasonably easy to
> > generate.
> >=20
> > May not be necessary in this series, but try to keep compatibility
> > with
> > the userspace RV tool as well, you need to have some special case
> > in
> > its tracing components because fields are not matching:
> > =C2=A0# rv mon sleep -t
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rcuc/11-108=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 [011] event <CANT FIND FIELD
> > final_state>=C2=A0=C2=A0=20
> > (null) x (null)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> (null)=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Y
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rcuc/11-108=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 [011] event <CANT FIND FIELD
> > final_state>=C2=A0=C2=A0=20
> > (null) x (null)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> (null)=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Y
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ktimers/11-109=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 [011] event <CANT FIND FIELD
> > final_state>=C2=A0=C2=A0=20
> > (null) x (null)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> (null)=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Y
>=20
> I have this userspace RV tool in my "later" TODO list, if that's
> okay.
>=20
> Honestly, I haven't looked at what it does yet. perf already does
> what I
> need.

Yeah, no rush, the tool is mostly for enabling the monitor and reactors
in a single command, the rest (tracing) you can already do with perf,
trace-cmd and friends, after enabling the monitor manually, of course.

We may even consider integrating RV in other tools instead of
maintaining a separate one, but that's for another day.

Thanks,
Gabriele


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11D926E6EC
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752671160; cv=none; b=X86ab2xQB+WUOQ/2j8QAzr6cLo9EoDAJ0CN3PfgwPpwoH1SkhUG5HUteP4YzUAN9p5tPs91Ipw1Xz5cIFLAtFjBfduFRbc+NBl01uEWKyumYNoN9AfhAQiYzQVUckV1znHB6eKnoZAIZRpqSHJef8tBaCNf5yP97oClUZM7XJZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752671160; c=relaxed/simple;
	bh=88K3VWScWf0F2m5IMpFiV300D8j/q2yUHA/rrk2KuFU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HeRvSv9LjUZJPYXZJp8JhV+NMJYa8MmZ+uuXyPGQq9LLcvp5KkuLbvSK9+zWmDv1eno/OJNiqqu1HZIaxxiBPwg8tFY/Z4UdJlECoEw3nqR18uqpdMq5jrcq8mzE0EBlpBv/csP1IAA0X4VHoXqjsAUhzawh3T6t5GdghOE98ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AfBt5P++; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfBt5P++"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752671158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=88K3VWScWf0F2m5IMpFiV300D8j/q2yUHA/rrk2KuFU=;
	b=AfBt5P++DYI0SzLzLwnaSLW5Yv4IITlspbnO10/Wse2wMisJUQ3YSWN3cJD3BW+aUurMIf
	237hCTF9QG6VVPobAWJsE3Ljm2jpkpRMfr4ty8jK15p5maAtqGE8hQ0l9HavAk+KUl2Dtp
	iyUAHw2i3VZ7/57zyEsgOsXgJN3RhFM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-zfGRn_-NMrmguUx0QopWEg-1; Wed, 16 Jul 2025 09:05:57 -0400
X-MC-Unique: zfGRn_-NMrmguUx0QopWEg-1
X-Mimecast-MFC-AGG-ID: zfGRn_-NMrmguUx0QopWEg_1752671156
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f8fd1847so2605052f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752671156; x=1753275956;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gd7zAnIbJVOfFTVHEt6M/mwsOHbTA17lPEzKnqlmFys=;
        b=F46e7WLk8sGGU9K9zZrqWkjgdLqHeSqk5liVLWsqVJUs6PnDYc7uvbxnSTkaMzEV3t
         IjrCnY8NCLf9ef8w5bFTOnnhtyi367ULQTQEAot2usd1mSK+CTU7seqqAwu6EkeR5Uqo
         m2FkedHkTHWWED5a866vKfVJWt4MCQlzudYCMBYPrb7pQdkSZRypzdtrjGumEOSOwuBR
         hxqIlk0ACFzpQBdMyL0tA3mCKJ0czfJEjtMJO4IJfUsnEnONgIGpu5t2hSSyYQrv74jU
         dHgH0NEa81jPZZDH3piiMKmH1iGTlISny5x4omGX0bWRuIenFu0lhSzA90JgQwUxenWQ
         cZqw==
X-Forwarded-Encrypted: i=1; AJvYcCXich763E9H3ZzXuYFjWp6ozkU1qiAilrr+ya1cx4kERmdHr12DVfhgQqPqlvuMZ89RrjV1LGYIl2XzIOQNx+5U4Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRdo+YmnNfUZMndxqInrOmLkhoDiiEHdz2kNdROkuuKT6Jn8RP
	HNHe6fdD9AO9GUKAbSBT5n6dGnbz/CmjqqMVtlZNfhZ59QzsS2q2MI4OpQF0RyY3EOY6B5Narmg
	8OxtFMwYijtWoDyCKzR0xXCGEU8iPWcLsxC0ixhMN48l2fA+dOY6+muigOpxQImn1i9oX+FQifw
	==
X-Gm-Gg: ASbGncuC6elDWvwy4dH5JNUdc6BNMu+j7E4M+rE5jMSzJav1N2lQGmS6Ieu+hLzj3vN
	aYzF9/lL1vveX1r6Bra6XzCKPH4CpCwJxe2vyHrUVFEidLrU60bFw8xDQm+g5jMmLunUVQ1S8MQ
	SWIwe8rrXDBiFhYHZ79BlLEjfSRYuJSTa4yjKrm7vqIBMFYULOzQ3A+qrikCID8PCARuVCHjz+M
	X6C1gvj9XArEuMnS/XK0Uo4tXtxjsfLYja0KE/OLzHUc94CflVvGRaymwZk4u0oSnNc7RSqeHNB
	T19Bm49nDJ2yHOul6VdnZ1y/KpktRFnoAxSLGGv4WIfVKXQ5XKSIEB6mkcQhCxAoLw==
X-Received: by 2002:adf:e6ca:0:b0:3a4:c528:9089 with SMTP id ffacd0b85a97d-3b60dd8870amr2159885f8f.42.1752671154233;
        Wed, 16 Jul 2025 06:05:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpfbjIynuUiT1DaZVKUwoILPAj9L75cgG3aw0ibfUnJMhCy3x9t3t+39d69bvnLyuBWUDfiQ==
X-Received: by 2002:adf:e6ca:0:b0:3a4:c528:9089 with SMTP id ffacd0b85a97d-3b60dd8870amr2159773f8f.42.1752671153045;
        Wed, 16 Jul 2025 06:05:53 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e285sm17581026f8f.76.2025.07.16.06.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 06:05:52 -0700 (PDT)
Message-ID: <5aa9b70894f464dbff8e317cbd8fc188db9920e4.camel@redhat.com>
Subject: Re: [PATCH v3 01/17] tools/rv: Do not skip idle in trace
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Nam Cao
	 <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>, Juri Lelli
	 <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John Kacur
	 <jkacur@redhat.com>
Date: Wed, 16 Jul 2025 15:05:50 +0200
In-Reply-To: <20250716124105.GX1613200@noisy.programming.kicks-ass.net>
References: <20250715071434.22508-1-gmonaco@redhat.com>
	 <20250715071434.22508-2-gmonaco@redhat.com>
	 <20250716115027.GV1613200@noisy.programming.kicks-ass.net>
	 <21b23f125e20102440e36da08a039d88bdf58eb1.camel@redhat.com>
	 <20250716124105.GX1613200@noisy.programming.kicks-ass.net>
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
X-Mimecast-MFC-PROC-ID: rSArEXoaxVnJEw9QKAGOc_fVgpLHv_kOvzmiQAiORk0_1752671156
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-07-16 at 14:41 +0200, Peter Zijlstra wrote:
> On Wed, Jul 16, 2025 at 02:18:28PM +0200, Gabriele Monaco wrote:
> > On Wed, 2025-07-16 at 13:50 +0200, Peter Zijlstra wrote:
> > > On Tue, Jul 15, 2025 at 09:14:18AM +0200, Gabriele Monaco wrote:
> > > > Currently, the userspace RV tool skips trace events triggered by th=
e RV
> > > > tool itself, this can be changed by passing the parameter -s, which
> > > > sets the variable config_my_pid to 0 (instead of the tool's PID). T=
he
> > > > current condition for per-task monitors (config_has_id) does not ch=
eck
> > > > that config_my_pid isn't 0 to skip. In case we pass -s, we show eve=
nts
> > > > triggered by RV but don't show those triggered by idle (PID 0).
> > >=20
> > > The distinction between !my_pid and has_id is that you can in fact tr=
ace
> > > pid-0 if you want?
> > >=20
> > Yes pretty much, no flag is meant to skip events from pid-0.
>=20
> > > > -=09if (config_has_id && (config_my_pid =3D=3D id))
> > > > +=09if (config_my_pid && config_has_id && (config_my_pid =3D=3D id)=
)
>=20
> But should we then not write:
>=20
> =09if (config_has_id && (config_my_pid =3D=3D id))

Sorry, got a bit confused, I flipped the two while describing:
* -s shows traces from RV but skips from pid-0 (unintended)
* omitting -s skips events from RV (correct)

If we are running a per-task monitor config_has_id is always true, we pass =
-s,
which makes config_my_pid =3D 0 (intended /not/ to skip RV).
Now when we are about to trace an event from idle (id=3D0), we skip it, alt=
hough
we really shouldn't.
That's why we also needs to check for config_my_pid not being 0.

Does it make sense?

Thanks,
Gabriele


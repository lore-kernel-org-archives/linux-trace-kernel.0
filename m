Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF513FD946
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Sep 2026 07:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420088; cv=none; b=OzTGKnhjFXRokZkGxoJiyuv07unHJkwccsI3d/Kjr7CbW52n+/fY209zTp9GaidPYMG2RA7hrYSFSKldzYAIJEnN/+kW3NknfCP2c3PfPg/XmnZqOtOXs8J3q+0Q5n1GR2W9Mao4kNnb0+Auz91yJQqq4+HzmKJEeiHL47yLeDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420088; c=relaxed/simple;
	bh=ybHCFlCHnPihYn5m+eFTCajuqHWBe7MyBmieJjWE1J8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vw20KQY3jurBXY8DqvvShB9xE1fqrvKc2QBgyP4jVU0Nt99cLGXUMsmpbUzai0lvIRFF6OEJQn2xFwvtkff6g/0cnSjP2y0ew98v4199tYQp/ynTI5yFD3uyhjkmZxvpGK28Y3H8+KfcIf2Ngmxyp2tVScLp34DILwWXJDHLz7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VX7Dwdhs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VX7Dwdhs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788420085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ybHCFlCHnPihYn5m+eFTCajuqHWBe7MyBmieJjWE1J8=;
	b=VX7DwdhsVNh9+ONPDGPiK2sC3K1gP36fQzbNGiEs7bxFZyMt+KnRJ6B1jF7WunTTpkct5C
	cLh8owNgFy8rRoppGAoTLDSBkjZcKt/mipnBydiL98mzYdUex33uG3HVdjHfuMr0ABPYph
	NtV+eF3j4stzGa1+4FZEdGY9SdmmKag=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-P1o7NatxMmm-bxJO09N07g-1; Thu, 03 Sep 2026 03:21:22 -0400
X-MC-Unique: P1o7NatxMmm-bxJO09N07g-1
X-Mimecast-MFC-AGG-ID: P1o7NatxMmm-bxJO09N07g_1788420081
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4994cf6cdb9so14064965e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 03 Sep 2026 00:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788420081; x=1789024881;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ybHCFlCHnPihYn5m+eFTCajuqHWBe7MyBmieJjWE1J8=;
        b=DzzU9pjhZ0p26WSsFNKfUXyUkyms7g82nDJc72lNsKNWAyKDxAlWeWt8ecMRpdc+et
         Pt5vlj2OMkrz4ZIKJQ7Cod89TRDCl/1UyDSrDfcmHrz+K6P212h8SMeLdOa1h9ji/hHY
         CPxzB+TTIIL8m9Eu3YaJ7sEwulqUO4yyMLRdmd1SxzDN/5UgS21Uc/IJEic0O2F5zc6e
         FYIgweXhnIcclYGrz1r+MnFfAp251kw1kOSOhGMBqKfLt7LiWw3eysfXTQY4y/GGQhbj
         XMt0jQXrtGdc5fxlKCVRgsO97mLJ7qHokMZbu4rRnB2RSExg5tdeScNfVQz02UUYbKru
         hvQQ==
X-Forwarded-Encrypted: i=1; AKwUvBwUfrCOzYiHYF8NGaiq+7UwcX6d2GXNEjw8+ZflxSf1CI4hfxwoozwlOpA5mrwdGxEEsSynxH2WUWtaO5iuSznEwDM=@vger.kernel.org
X-Gm-Message-State: AFuF++mnRUSk8dKEbmmg8Cjnq4ySyudAjPXTgzFnFw7DzJA7BNttL2eX
	8coKQsC12jZMPJxzOi0hoHakM5WN/tc00BH0H3Daqt4vJ6VCVH/WIgmnib2y+0VX/r50bHY5Xo+
	gOjfN/zc5ALbARokSG9rLhbIuaaH4k37amtLiaaLecg/AB15//c7+VeWYUhzU6xaJes5Dl92F6g
	==
X-Gm-Gg: AYBFou0owXxZlewYh3QidUsy4HHFjji2K9jV+Q/i8S/rG/pKEr/rGNhn8nZjaYQQFxb
	yjVZn1YqhvwBfS/yTKfky3rKd1DFabnz/AHnrGtXAzLVU5DxakgzjUaKOSnt6tmkelWCeqag0xL
	GdqAoG1Migd9vFr1aFtmQTg1goeo+mG7XMoMNJ+3LewfXu9Nsaob5oycWgRpwOliD9wVl632vZ+
	XO1hzBUA22zZ9Pz31FktuYd33pTaD/jR1nFYFMXgjtGtx8QSMWR/uHi4HnzF2r08tInIgEUB0fL
	vrmeDmgJv8Smsv0aTu3jrSYHcQhYaoJFHIj/fVmjeVsqPgSrJiVh7Qfes0rFz7kBQ4kNIMc1c6F
	O9WTOAUQXLiFIIxf17Q9MLnwp7q+L3A==
X-Received: by 2002:a05:600c:6296:b0:499:621a:2ec2 with SMTP id 5b1f17b1804b1-49ce581635bmr196789755e9.3.1788420081352;
        Thu, 03 Sep 2026 00:21:21 -0700 (PDT)
X-Received: by 2002:a05:600c:6296:b0:499:621a:2ec2 with SMTP id 5b1f17b1804b1-49ce581635bmr196788945e9.3.1788420080986;
        Thu, 03 Sep 2026 00:21:20 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.135.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee60d9c6sm49952545e9.11.2026.09.03.00.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 00:21:20 -0700 (PDT)
Message-ID: <eb3dd8158942d663ec8ad4c529eacd666c5f96d9.camel@redhat.com>
Subject: Re: [RFC PATCH 00/20] rv: Add support for BPF monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Nam Cao
	 <namcao@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Wen Yang <wen.yang@linux.dev>, 
 Tobias Schaffner <tobias.schaffner@siemens.com>, Viktor Malik
 <vmalik@redhat.com>
Date: Thu, 03 Sep 2026 09:21:18 +0200
In-Reply-To: <DL5B40CU17WD.3KD75URQZ6RRR@gmail.com>
References: <20260831090524.106845-1-gmonaco@redhat.com>
	 <87se3sakgi.fsf@yellow.woof>
	 <df6e9168cb06c35e21db7f9d17cfbca6bd87005b.camel@redhat.com>
	 <DL5B40CU17WD.3KD75URQZ6RRR@gmail.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: F3_YPk9D-lQdOdK-F7yqTmx9p1JgR5iLJe-P-tY-wak_1788420081
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-09-02 at 18:57 -0700, Alexei Starovoitov wrote:
> I don't think bpf fits here. I haven't seen active use of RV and even les=
s
> so of any request from people who want this kind of programmability.
>=20
> So Nack for now. Sorry.

Thanks for your opinion, however it sounds a bit harsh to me.

RV is clearly not a popular tool, but I wouldn't say it doesn't have active=
 use:
we're actively using it to validate the deadline scheduler/server changes a=
nd it
already found a number of issues (e.g. [1], [2]).
The RTapp monitors are used to validate if userspace real-time applications
interact with the kernel in the best way for predictability, as far as I'm =
aware
that's regularly used [3].

In my eyes, the missing piece of RV is in fact this programmability. Adding=
 a
monitor now requires to write in-tree built-in kernel code.

There are strong use cases for domain-specific rules that aren't general en=
ough
to belong in the kernel tree:
* stricter RTapp rules that may not apply to all use-cases
* verify some exotic system within Linux (e.g. a co-kernel [4])
* modelling for functional safety certification process (used for in-vehicl=
e
OSes like RHIVOS)

BPF seems the natural tool for the job to me. Mind that RV monitors would b=
e
simple users of BPF, requiring only modifications in the RV subsystem but u=
sing
standard BPF facilities.

I'm totally open to discuss on this though.

Thanks,
Gabriele

[1] - https://lore.kernel.org/lkml/20260522125833.264145-1-gmonaco@redhat.c=
om
[2] - https://lore.kernel.org/lkml/20260113085159.114226-3-gmonaco@redhat.c=
om
[3] -
https://lore.kernel.org/linux-rt-users/20260826132153.2476006-1-bigeasy@lin=
utronix.de/T/#t
[4] -
https://lore.kernel.org/lkml/20260827072400.45734-1-tobias.schaffner@siemen=
s.com


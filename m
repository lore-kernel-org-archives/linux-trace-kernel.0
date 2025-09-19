Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E3B191F6A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758271967; cv=none; b=MTWrXDWTkYRKKNHKpAbCeZEVRrFbSdT6y4XBlTJJ0yATMY1B0YEQZFxj7rJFwc7kQPwldoCRavaH+6DszccMJv7szy03XYEKXDN717OqBPDRulBiLRZPDnQVh6BcqV5UO+I6FsAwZcbsHkT7TPnVsU7L2kcVPjOB+44/YdbLYNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758271967; c=relaxed/simple;
	bh=q82iAOnsb0m6DGs+KumXaLQLxgxxLlYfD/Djj4RV7Kk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NN6no2JOIohVUHaVj2DghQhb46pW0NZwHHcnzQlI/p/XIzGi2K7d4j6f0w+MWYVRckgMSz7oGMlQ5CAQT4/5bkfmtZz6e9HUTHVGx1xLwX90rLk4An2x2JHe2m2T7wcFhmdTqvKOOF8keRQsaleWb/c6JypeVzVVbB3TxCpgrO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R9sLI+Ab; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R9sLI+Ab"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758271964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=q82iAOnsb0m6DGs+KumXaLQLxgxxLlYfD/Djj4RV7Kk=;
	b=R9sLI+Ab4RMfT0Dp+xlohO/oIT/4N5+ojzK0AIKmiTvkT7RJYy3cbVcjKE+0nDJgamMl4M
	vM5dF81jSvajt97MX4sEFmgQwj3k+zALvHZvLUDVcoXNKvIV832zId9ePAkSmeksgMgS+D
	CBEObCG+Uk9axiLWjXSVfAYeUJyMY6c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-PEFpXw0BOE2GWXau4jNGlQ-1; Fri, 19 Sep 2025 04:52:37 -0400
X-MC-Unique: PEFpXw0BOE2GWXau4jNGlQ-1
X-Mimecast-MFC-AGG-ID: PEFpXw0BOE2GWXau4jNGlQ_1758271956
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ebbbd9a430so1280894f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758271956; x=1758876756;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q82iAOnsb0m6DGs+KumXaLQLxgxxLlYfD/Djj4RV7Kk=;
        b=ljuQV3Bt60PEK023Ha/kuCkcbTERDax9YN4h6m0sDT2mKHa1iGdTWJXWKAozXox56f
         504Fvs0bo7VlLQmUPwoZ1WIISE3P3Aujk/Hh3OMErivsuWWcpf06crfiwN2ur8BoJcHu
         AONhefmB3oZgyH3A3HdVSsyfrXwFWFV5u7WwgR0NbH/CBFHu1UTXrMHupVL+HpFL927a
         7sO8WjZ3Wh9opX1En/RjHmPsJ8cfXVtL2snBTXvyVh0DoXqPknd8FzKIVp17RMV3/SXR
         T7O+MvoWfUidHH0q9bIAEjjfiupHTH3SMDDfe+PpJwvU+y+8sH9sxfUl141xt01cxpaj
         FDFw==
X-Forwarded-Encrypted: i=1; AJvYcCV3i6a1kyW5CTt7c/bccmL/uikWzla3zW2DbktC5ocZjgrwuSxXUlMVDX1XXeqZjZYS/LqubG9LquFsnEdPCa5Jmn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEF/pBVKc7EA98pgSJIu7yji63p/8VqHsHdbBfQAc1dZe6w84m
	dFa8vPOp0hFi7IV9QqBIkjMg8aMEeFCSBymFTQuQuL9Hh2/FF4k184S3F/HyI5P6xrYojpnwYH+
	Mp3UvYkSia6nAsWuiL7N/+C9+EQ69+AJLOh3YqViwvQeUsrdVe61Jrh14WtkhmwhvBMhFdstfWg
	==
X-Gm-Gg: ASbGncvf+l+UscKUZ4xCuazCflNum0mJr1BHfxF3bGcxHj7PTBn1lo7YKXnNi5ZXvVl
	YyMsDKnOzSMObdK8JwYB1AVEupC0Zs1sK4N/2v6Pl6qI0y6H41JxgGwpfWkpcoW3aXfEgyEr5UO
	q6cqruzIagSlJiAA50fIpgPDOv5QO3UiCTQDPueKqvPIj+D/d4ONJV2OvYft45jgLJaS/ngbrCW
	TglGcIPxN2d2g3z4xyfb3aBYLw9DgT08iydxLfubXZqsXCaHIRgLg+vj35wIpqYjqKCryuxBndN
	cyrg8Lerh68D80T+Mm2tD1nEAUhUrKLuEcJBQNDQ6VYNFuyJlH373OOArqILUrUZHA==
X-Received: by 2002:a05:6000:2002:b0:3eb:2d8a:4fca with SMTP id ffacd0b85a97d-3ee8a5bf2cfmr1585729f8f.63.1758271956321;
        Fri, 19 Sep 2025 01:52:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH54T9EErR+ZPtUNWiKXoi49mi9mF74SmM+4pHr2LUVOY5k0BhASnSakJmqeHVL+twmlH6Nqw==
X-Received: by 2002:a05:6000:2002:b0:3eb:2d8a:4fca with SMTP id ffacd0b85a97d-3ee8a5bf2cfmr1585712f8f.63.1758271955872;
        Fri, 19 Sep 2025 01:52:35 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f320ff272sm75720175e9.1.2025.09.19.01.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 01:52:34 -0700 (PDT)
Message-ID: <e7ed86066c53078ca55c1ec5c47da7b57cf2ffdf.camel@redhat.com>
Subject: Re: [PATCH] rv: Fix boot failure when kernel lockdown is active
From: Gabriele Monaco <gmonaco@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nicolas.bouchinet@oss.cyber.gouv.fr, Xiu
 Jianfeng	 <xiujianfeng@huaweicloud.com>, rostedt@goodmis.org,
 mhiramat@kernel.org
Date: Fri, 19 Sep 2025 10:52:32 +0200
In-Reply-To: <CAP4=nvQubUmOVivgzOtYRhMmZaq75WRmRdBnsn0HYJfHHZhzmw@mail.gmail.com>
References: <20250917125733.2346923-1-xiujianfeng@huaweicloud.com>
	 <b2c19df4c5036e956e4e892ac983d5488a8b9614.camel@redhat.com>
	 <87wm5x18bf.fsf@yellow.woof>
	 <4e8bae6a0ada1d52893381e7542220973f0367fb.camel@redhat.com>
	 <CAP4=nvQubUmOVivgzOtYRhMmZaq75WRmRdBnsn0HYJfHHZhzmw@mail.gmail.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Poj7TLpDjxF-tqHfYjFXD48rac9l6BITFqoWFAliW4E_1758271956
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-09-18 at 11:48 +0200, Tomas Glozar wrote:
> =C4=8Dt 18. 9. 2025 v 10:36 odes=C3=ADlatel Gabriele Monaco <gmonaco@redh=
at.com> napsal:
> >=20
> > Yeah totally, I have the feeling that with the kernel there's no such a
> > thing as a "theoretical bug", kinda like a good consequence of Murphy's
> > Law.
>=20
> My understanding of "theoretical bug" is that it's code that is
> semantically equivalent to a bug-free code, but becomes buggy after
> doing an "innocent" change. The bug might be more or less
> "theoretical" based on how "innocent" that change is. Of course, in a
> codebase of the size of a Linux kernel, this tends to happen quite
> often, and is not always possible to get rid of completely...

Yeah good point, we are getting philosophical here :) . This wasn't a
theoretical bug then, just something you don't think will really happen (a
failure creating a sysfs directory) ... until it happens.

The fact there is a way to make that function fail on-demand (kernel lockdo=
wn),
makes it just more "real". Moral of the story, better get the compiler chec=
k
things for you (lock guards).

Anyway the fix is now upstream.

Gabriele


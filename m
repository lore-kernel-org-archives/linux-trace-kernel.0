Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27AB426D18
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Jul 2026 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612348; cv=none; b=MHy737gU9BuTgZjYmdKbSMt2mzoFGnIMyJm5Vs9Swrn32p7Y3d54cN4cLcLvFM8bYS6bEqNouth+ukgjmkRuKAkkcqNhzK6a+Qk3eG5uT/fmR/L5d4797HvF+fk9n309bwsvmsGQxScATKge+Sjgr31oflPIDCUvh/4f4nEK8kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612348; c=relaxed/simple;
	bh=3dZndHpLPoHdprw6LicCelHE4XQLVrOgIL4aLvWWTd0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vj630HNDYucadv9/DyKNFDmHy3LKAw+Rga/goereCz8bjGfPAlupZ5+/mVHSNAo+pUmNMFXHyP8cJeT3aKhlXQr0l9ji/uALNLuNJTbsTVgnM0c+dCcVmup1wctCQx/sxLndnoCw9LkhN9FOjbTSbXNicMQDlpwDyohuWpyddgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gVY9QgXu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gVY9QgXu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783612345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3dZndHpLPoHdprw6LicCelHE4XQLVrOgIL4aLvWWTd0=;
	b=gVY9QgXu3COnZl1OFmPXXzTFMqoZ6kDzx4yS+EGaDnsWCdyAnnvn3z3Ax/ofwkbkTmevyA
	dPeSwEbekjd0HbH+9eQXRc7nS7jbc0lZc10keHwlptESxuIhfVAnm+U2XhbpZe51EEpE4S
	JqPmw51GNzuYnh+Wsvo0B3OrpPYdvCw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-1tSk6dtWN5eClVVmCycnVA-1; Thu, 09 Jul 2026 11:52:24 -0400
X-MC-Unique: 1tSk6dtWN5eClVVmCycnVA-1
X-Mimecast-MFC-AGG-ID: 1tSk6dtWN5eClVVmCycnVA_1783612343
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-475b0b4e8d5so31347f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 09 Jul 2026 08:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783612343; x=1784217143;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3dZndHpLPoHdprw6LicCelHE4XQLVrOgIL4aLvWWTd0=;
        b=DCi9JPt2zvb3zBYirgoGaK2kkVkKP1xe6j8K7BpYqFltGXwxqAq2rxXbgrxF1iNEoJ
         sSA1sCnMgT1WwC+hB30pLC33pSOGiKK4e56RZ6nG9f+S4DYY3MND26wtRPPeP7ilOu1F
         /eCVdMbPCpTTDOcCGDWWoqN9sBCEAcqXgGkfItplYfUiBL6rqlV2q60MKinIif2J466I
         zsDeNJzVqVhpjzCZTu0aNMtjXtI90eeH/yhyHk9n6GwPCynXsj2Hne4wsixg/rbiH2tR
         gAwbVmz0fJDzUEibnokzbAv9wmWtkVei6hDigNBeS9hPW+XGWMiOD7j+ipuO8vzgxCDd
         dJrw==
X-Forwarded-Encrypted: i=1; AHgh+RoVTWpxJjFlq2SCW/GkKtkxA9l9nDoWzFbo1Wt0jLPvytIQqDOVGsqogVdl/CJ03j5FzRKFOyNeBYjMQTDiLWVam30=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdVigG9kab9GEH/HboQeVz/utT00XnQdpg+zoQQkgcdVlDe2E0
	RG/s507kVRGxCJkRm8sowh3zG3qSDhbZDvQ4S8jHetMg8Z768ivSsdqVDobs9HqNdRs1BSlnSVu
	dDL1ZEZizRh/4vFxSqeysQyejoZhsBuVM681JJ6JHtafV/DpTMlVREv+RHVpfJvoDVVIBQVb0xQ
	==
X-Gm-Gg: AfdE7cnsZ/kImnAJKT5MY3B4xx/nZpiRDrqHdJhfG9SKXAIuhYimq+QuFByVV8Got9L
	7MZEFsDbgAT5F8fIE3uuPZvUaU8cQXbutg8JCr4BQ9P21io+OHbCo6v8SXQX68Ft593ibf8Wf8O
	F75qKuCdtXYZvBoy1SnJDoC+xWnTjGe+Dysv0wy6Ecv3Az3kj2fZ+SnDbfwwyQOOLeraQ/YZLyj
	xN2/6AZN41Vywwx+u5wXLXmeBEQaJeQ5qMrh1+gHZ852gzPzkhseGfIVnRTpOiohWe7jpRhyBcw
	Y39MPZXLviBtdAtVWrWLlOBnewnN4kQF4hdwMY4r9Nv2iZcl2illPHnrqHk56A9TDMtJB9TVdAC
	A0Igk5WYOYJe1ZLVPqO2qMq4OqBd77hsx5Quvghr890q8oYGzdi7XOXwBW1j8X5Qek4jlOU+Xeu
	bxcITq
X-Received: by 2002:a05:6000:27cd:b0:47e:4b05:2c8c with SMTP id ffacd0b85a97d-47e4b052ebbmr857918f8f.15.1783612343269;
        Thu, 09 Jul 2026 08:52:23 -0700 (PDT)
X-Received: by 2002:a05:6000:27cd:b0:47e:4b05:2c8c with SMTP id ffacd0b85a97d-47e4b052ebbmr857888f8f.15.1783612342700;
        Thu, 09 Jul 2026 08:52:22 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f214d2sm51056545f8f.33.2026.07.09.08.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 08:52:22 -0700 (PDT)
Message-ID: <b50ff177c4ddd4521627cabd67ed9df638f850ed.camel@redhat.com>
Subject: Re: [PATCH v3 14/17] verification/rvgen: Add selftests for rvgen
 kunit
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
	 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
	 <wen.yang@linux.dev>, Steven Rostedt <rostedt@goodmis.org>
Date: Thu, 09 Jul 2026 17:52:20 +0200
In-Reply-To: <87a4s0fuqx.fsf@yellow.woof>
References: <20260625121440.116317-1-gmonaco@redhat.com>
	 <20260625121440.116317-15-gmonaco@redhat.com> <87a4s0fuqx.fsf@yellow.woof>
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
X-Mimecast-MFC-PROC-ID: Hi-c4ctHBad1daSwWMAp4fT3l0zDOvqsQFWorvJcmzw_1783612343
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-07-09 at 10:11 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > The rvgen kunit command patches monitor files and adds necessary
> > definitions for kunit tests.
> >=20
> > Add a test case validating its behaviour on dummy generated files and
> > comparing it against reference files, like it's done for rvgen monitor.
> >=20
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
>=20
> I am not entirely sure about this. In the future, when the generation
> output is changed, all the references files also need to be updated. So
> it's not clear to me if this really saves future development effort.

Yeah that's an issue with all this testing with golden files. At least unle=
ss we
change the output drastically, changes to those should be easy to apply and=
 to
review (and LLMs can help here too).

> But well, we will see. For now:
>=20
> Reviewed-by: Nam Cao <namcao@linutronix.de>

Thanks,
Gabriele


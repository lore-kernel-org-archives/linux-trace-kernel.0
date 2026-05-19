Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A593D5652
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 07:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779175806; cv=none; b=WZalrsqUMwlszsqmTRHM+RGF/wieQeZgNZYcY4BAsb+Y6Ey4EQYTM2Hd/RMows+7J8QlIe70/kyRSwHs6yPFp2pEC6h8hVklHrpLx5GmOS++gF7mX22F6Ya2tniN94gJvkyXtQ2qGC9/6tegK1TU3r8VQxsyptvCk7sgSyh+bYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779175806; c=relaxed/simple;
	bh=d+RsGwFvHQgPOiwuibiqPywt3DUTQd4NTbFJRTOpsks=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/k6xtYbEm8DYOH7vGw6BdVOm3POnFO1/aYJGoTha5cUBK3pqFdgTbW4aFYnSDvT+gfgShlRWYFYIRhhTxr/0Z6/H9UCL+i4FizbP1GhVEXt89UDxWZQ279BfX5UHdfqjKbk9jyWwqUCTA7MgjBYMzKHCQ66D3d3mUcONi7FQqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V06TPKGP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V06TPKGP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779175803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d+RsGwFvHQgPOiwuibiqPywt3DUTQd4NTbFJRTOpsks=;
	b=V06TPKGPbvMD+rCBBAbjXArmytmjghM/HLArYFNaAHkvnLeykYjl4Rv9caYpVzavCK/MQ0
	HgJjPEgUa16/5ZyHswxqWFB15dptyZbvV98k45kuWuSU5aINpOiVYnHGdkey8UTvGukDA8
	kN376b0CmQdrs9/VOSFmO9XUeGEMNLE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-6Sp9PyXXNDaw_Jh8O9Wgig-1; Tue, 19 May 2026 03:30:02 -0400
X-MC-Unique: 6Sp9PyXXNDaw_Jh8O9Wgig-1
X-Mimecast-MFC-AGG-ID: 6Sp9PyXXNDaw_Jh8O9Wgig_1779175801
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48fdb2b0cb8so21443095e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 00:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779175801; x=1779780601;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d+RsGwFvHQgPOiwuibiqPywt3DUTQd4NTbFJRTOpsks=;
        b=iu8dripuQs+eG3cBmrYpseAyzQg8jOQb7v8YY/W0w4UVNAAHESrwfYLU5PPHS81oo1
         6N8Ez7wlRHVWfti0MHAcjTcyQCQ/12fcTuIxn1CPdodBwr5vUiqoaob42ntBmQodylSc
         2ZcseinVIiIfxBsFCD2toR8iCpmxXTA+J+kC3wWL9CAkgACp+lOnoJ7ZvYfGEMzS7F0i
         h6vDGjRICpV/JsFhhUX5R0EF5TfJQOwrDvBYq+lfZNYd6M7AuQuyGwWMYCiFVW20bd1U
         z8a/OE9sUR5MbvZ9Cf2vXKLEID0ge91XBl8cR8j2CQ2/B37ENSo09jnARzOhW+0L+Xbk
         4hiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/B8rZ/EN/qNYEES/r7qBWQd1QhdvPvSwUQLJ//wCpx47/sr86CxRlm4UPRFYNWUhzLd0wK5bAcQMLabqq5Ee0BG8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIP6vGsS07eNlzjrbZyOr7Rj5z5fWg3x1Gh6X32+KTNtyYVo8p
	lH1alTF8D8PHiu+Y5I+Y3ErrI2DuZz0tqAh8LDYpx+FhgEN7gjdYnAi6UTVFzxjfeDMeIYY/ZiM
	Us3vr7vpatKyZNIzM0A3VhMkNLKE1RUNQdF/TMEZJlJthmls/Yr1v+r78bW4AtUzI5C/ZT/47bQ
	==
X-Gm-Gg: Acq92OF8ihTX8M+QTGtk7XCXvJX3ufDpGtwWn6pBZ4C/QYpBWUemHylz/fTANsAtcfL
	JHshaZ+8cv0MqPB0HEs2PfJRkhFSXcByhI+L1uy2a0viyJzzZXAnlALoGUxeAVV3bc8Ve3yhDfA
	BjP1ebRqTOCcH6kGdas6KsBkESm9QVXG2KHflGa0iT7Xf6cupFAYIp0hA2yEnzQizrByrXYIZ68
	QLF2oAXuwjXDmDQDM2Wk9//JPTG+UVgDfbifQmetV1jTp4Q3+ljraon9YJbhnDkoMRb8lzdWmHJ
	lAw+Qyp7x16DpkBfb+IrQ+ngSmYKUzi5fbFhD5GTHI7EtHUQOGdoo9JrNY21FoVA4UHprx/uSpP
	HYUhL9x0n81vLZTP/YfUADo/DC4U8eOH/0Dtxj3M4J+u9R4DfjnW0m+8GZnESeBiILfNgjWL0D/
	Allc3aSm8EAZWYAWc=
X-Received: by 2002:a05:600c:8b6e:b0:48a:6fd4:d3d3 with SMTP id 5b1f17b1804b1-48fe61ed21amr299579415e9.20.1779175801245;
        Tue, 19 May 2026 00:30:01 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6e:b0:48a:6fd4:d3d3 with SMTP id 5b1f17b1804b1-48fe61ed21amr299578965e9.20.1779175800824;
        Tue, 19 May 2026 00:30:00 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537c788sm291707645e9.12.2026.05.19.00.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 00:30:00 -0700 (PDT)
Message-ID: <5b5af3a34944d1b798be9a34200a42f7b4833a64.camel@redhat.com>
Subject: Re: [PATCH v2 08/14] verification/rvgen: Add golden and spec
 folders for tests
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
	 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
	 <wen.yang@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Date: Tue, 19 May 2026 09:29:58 +0200
In-Reply-To: <87pl2t6qo8.fsf@yellow.woof>
References: <20260514152055.229162-1-gmonaco@redhat.com>
	 <20260514152055.229162-9-gmonaco@redhat.com> <87pl2t6qo8.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 38RL-UR-DUKkuY8HN2FdEPUxZMjj23ZeVeo1JUIA5Hs_1779175801
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-05-18 at 10:57 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > Create reference models specifications and generated files in the golde=
d
> > folder. Those can be used as reference to validate rvgen still generate=
s
> > files as expected in automated tests.
> >=20
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
>=20
> Didn't look at the "golden" files, I presume those are generated.
>=20
> Reviewed-by: Nam Cao <namcao@linutronix.de>

Thanks for the review!

Yes the golden are generated, I checked them and had a few AIs run through =
them
and that's how I spotted the True/true issue.
They aren't guaranteed to be spotless but again, some test is better than n=
o
test.

Thanks,
Gabriele


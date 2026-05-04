Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0336C330B10
	for <linux-trace-kernel@vger.kernel.org>; Mon,  4 May 2026 08:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883193; cv=none; b=pRtwiEWkMHFFkdLl++CwhOYCUcT784B10snQ3xAH5GA07k3wVDA4+tbF+/4628RuUL166CihYmDtR56JmF6HcRa60JEtIHZCIZ3/9CRXGq+ahgtrz+V6q5i1oiPq0th4be6fVpPhgyXER1ExaqoqHP6lPw1JsrEsh5JcwdbxESY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883193; c=relaxed/simple;
	bh=fLBrKN+ks85InWj6vqepemzsZfxfg7RV079GzSo1fT4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qGoKHpvSFGDEjH4gHtMGumAVdiCh9vi73iDMKl0kDU2dQpCJGP2VQayGib/6Wh5wrkUM4Xx8A9eDCkghRS+Y64ESjpZHqJW7kt8UgTVftEX+EueBCjeeeKvFmpm/01x/A1fbxpyUg4S3+Nq2h2xsuxtaCf7LclaHu8YNVLQEXAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VR1xxmZl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VR1xxmZl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777883189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fLBrKN+ks85InWj6vqepemzsZfxfg7RV079GzSo1fT4=;
	b=VR1xxmZlU+vR+GeOu9OYUrB8Br9ruSeaUkwAcpoEiWqz9yLPvFy3OCQEcCuuU96TnZWceD
	3SzLYZ3RX86sQrYzU0RbfI+5wqxEzt2rpLxisPLEx9maQRLVHMF+bMcEJCMlweQpdodAhI
	WU/7yX4QuMK5vCiUNc81VqUd82JH57A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-2js_EsJcPEaTDbpHOBG0Jg-1; Mon, 04 May 2026 04:26:25 -0400
X-MC-Unique: 2js_EsJcPEaTDbpHOBG0Jg-1
X-Mimecast-MFC-AGG-ID: 2js_EsJcPEaTDbpHOBG0Jg_1777883185
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488ba2f4094so26847015e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 04 May 2026 01:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777883185; x=1778487985;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLBrKN+ks85InWj6vqepemzsZfxfg7RV079GzSo1fT4=;
        b=iH5RdT6EzYEr16aHKGmi6s+CiGFkJOpLo5rwvnh8/NNRfPPcH9Yo1RWH/yvWm4MKmk
         j1kMW/1Wi4ZuXZ+3c8TmDJ1Y3SwOLg7fh5TenxyyV6jUBIGOo8Ue14Y0VrV7/NAjkpwa
         KOc4Te3jQDZe87M/wXx4wmEkVzp5o2hSCHLKt+LcAV8KXNZS33YvQsKaZxS5xuG7Tkdh
         WuPmxh8OrF4NN+r29br7pMMXslwj1MHrFSGqrgvJrbA+UipyT3uUAMRbgsWPplrjXLL1
         QGwo6uTlN1NLq2eT/zRoYocpwzC9VsqrEqRwTVLuOoGEcnYkqhUOoavaV3IshBGtTk3k
         HD5w==
X-Forwarded-Encrypted: i=1; AFNElJ9smWd5cIT0VDBSj4Eo3zoLfddE0h+SrSrFsST8/XycxK5TVVjIUPGmA2V9GC/OHOpG52ibRXOw5Pa3KwGoq3Pf8MY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMIW0tFd+HtW9n4+i2Ce43Wl+ANs+UPdy1FTVDRNNFt4DgwR+v
	S7YFnUyVoY8wiF/6xKzYwi/iYGdxbBAoADQpFWk+JWxsprYA8lNKBLIyyp7V+yLzWPrZcP4TmWg
	C/Bro/U0d3gdtD/CgJuvB+0ZsmBFSpikwnS/1je/Q3mCM1SS3mkPOw/EnVEs4nUIeGBAvHRlEyQ
	==
X-Gm-Gg: AeBDievDt+1z/6xQl0EhDH/0YUgIzy726vEo2DL7s5vJyqBjt+lxfL4nECvzU5sIzrN
	3qBTo9Ut4he+BgTq2pDJx7Q0NBiPkoBRIpoHhNZtu+S4aNYvHkWW+aJQ31PCNr0B12J/WUp0nXA
	eWx8dSwlXQomyUqvphItqmR3leXbKGoWJYx4PS+MDhk0Zy1GNRb6F5HdylMZxaaXeIYl/NF4Ru3
	bJ/SWCvibL4tWViBh4+P34t2cbOUZ3SdLbHT5ynGA6qx57ubGKZ0AUXQfa4nffJBTe9tKMkCVJ8
	B51n+PrPSbuCqvzlaH/GuVuOcEZQRtA8abZqIV/epN0orhmAvIsz7+p0owcsWiBdTklKONGhBoy
	c85s0NuIvalAXcV73+ZkMlME/YrjrC/7fDyJVStpYafiyaRDgOD8+y8iR/43wrL9C9JLiv9t8sO
	sVNHRv06zbaqPsbX7G/2ucYg9wKg==
X-Received: by 2002:a05:600c:3f06:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-48a9852cc0bmr146970345e9.4.1777883184746;
        Mon, 04 May 2026 01:26:24 -0700 (PDT)
X-Received: by 2002:a05:600c:3f06:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-48a9852cc0bmr146969775e9.4.1777883184345;
        Mon, 04 May 2026 01:26:24 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fef2a67sm102134045e9.5.2026.05.04.01.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 01:26:23 -0700 (PDT)
Message-ID: <ffb994110f4ec8165aa5a3e7cd83a57beeb609f9.camel@redhat.com>
Subject: Re: [RFC PATCH 07/12] verification/rvgen: Add golden and spec
 folders for tests
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
	 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
	 <wen.yang@linux.dev>
Date: Mon, 04 May 2026 10:26:21 +0200
In-Reply-To: <878q9z1up7.fsf@yellow.woof>
References: <20260427151134.192971-1-gmonaco@redhat.com>
	 <20260427151134.192971-8-gmonaco@redhat.com> <878q9z1up7.fsf@yellow.woof>
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
X-Mimecast-MFC-PROC-ID: BFZ2ggjPdjfP8aTl3BtRpNjjHnozYWRLBwNc5-qx7hA_1777883185
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-05-04 at 09:48 +0200, Nam Cao wrote:
> I am working on converting rvgen to use Lark, a parsing library:
> https://github.com/lark-parser/lark
>=20
> This test case breaks the current version of the new script, because
> state_c has no label while the script expects one - the script read the
> state's name from the label.

Right, good point, I forgot to add that.. Thanks for checking!

> We should define if the label or the node's name is our state's
> name. For example, if we have:
>=20
> =C2=A0=C2=A0=C2=A0 "state_c" [label =3D "state_d"];
>=20
> Will the state's name be state_c or state_d? Or should that be a parsing
> error?
>=20
> I propose using the label if one is provided, otherwise using the node's
> name. So
>=20
> =C2=A0=C2=A0=C2=A0 "state_c" [label =3D "state_d"];
>=20
> means the state's name is "state_d". But without that statement, the
> state's name is "state_c".
>=20
> What do you think?

Mmh, the only valid usecase I can think for DAs is to tweak the dot
representation, e.g.:

 "state_c" [label =3D "State C"];

in this case the user might want to have a better display on the graph whil=
e
still keeping a valid state name.

Also keep in mind that in HA we could do something like

 "state_c" [label =3D "state_c\nclk < 10"];

Here it's probably simpler to just parse the node name rather than the labe=
l.

Do you have any other reason to prefer "state_d" in your example?

Either way we are opening for confusion (like in your example), so if you
believe throwing an error makes the grammar simpler, we could also go down =
that
path.

In any case, I would make the label definition mandatory. So my current sam=
ple
model is wrong.

> (just FYI, my work-in-progress:
> https://github.com/covanam/linux/commits/rv-lark/)

Thanks for sharing, I'll have a look!

Gabriele


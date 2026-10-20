Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510446;
	b=oe1K6r6Z7gHzOT8iQitFHk1YHL0Dv8e3Brl2LfLmBYZdejYBrZS18kGplzAku6T75r3F
	 My9OlUFOHpCcm0rE1VxtbqDdOGOJH9aEI7WSoGdvvbvhjBhmpVeAMESQ6kr3T6HuQoLaE
	 ViIVFYxDrTluMPhTd0ktDBfTR2tB7kMdR1wlKVi29Zm66sapFpEZ+y9rmbsJyzQIYY2Gn
	 uauTo9SgF8Sxs8YbUZfVhDHRgCCSXyFh3/DwBhZMfL3iGEOvmpN2IEnwrGAyoRn4/LbPh
	 coBEOOyRF5+Tm8TbdQ/kHLoXp7ZtSAeV8oTYkGXyKJFT/TNc0NWKFar0e2TljUPDHbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510446;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=wDuJI+C89RvKUBm23U+xf8xPXu6IlFeSARqHPsE5CvM=;
	b=jL01KeRyTTcRQMd7PGV5/KH72rpEaqUh2RfWqGTDayZ/i4SKEHlQt5ERby3ig2MKm6A+
	 VSYN+Brypjq4WYrwlI39WD9bYR+NiRGloYzudkuMziY5Pn/cWmCXJrroxyHPc1B9blMAn
	 b8dxclZNHK/XEcefPgajXXJo/AFGLqfMkHevNNX3ugeYoXEiDqxixwwRKVwAcb/2U5+tq
	 9CkqV9XS4ivadYGqHEONbaA0ggJLJhq68YTLa7xxLympQbQjU5w9bNPkfHo1UACiP2F/X
	 rb3IXm/H4eDsdpGhV9ZTBzc7pZLyM5vrbhQnW4mdU1XZTOZwg7qdcuC2YScpUk4awJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vn3Ksod8;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06433606A323
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Oct 2026 15:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06433606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vn3Ksod8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792510445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wDuJI+C89RvKUBm23U+xf8xPXu6IlFeSARqHPsE5CvM=;
	b=Vn3Ksod8ZNgt31rk8YIWXuCkNtbz2RSPwtp8myYIF3lg8+hty2mpcLo2MBjf6uHTPLi5cx
	L7+oOKK3n7xfD5+Swkuxxr3Rk8Dn3lzQlaLVjcldND/+Xw0bEI3919QaToy2WH0p+PUwzs
	5YQB8rP+x6eEZh1793eKr2kwRNpmGI8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-S74zXV81PeSvdQKuXLVRzA-1; Tue, 20 Oct 2026 15:33:57 +0000
X-MC-Unique: S74zXV81PeSvdQKuXLVRzA-1
X-Mimecast-MFC-AGG-ID: S74zXV81PeSvdQKuXLVRzA_1792510436
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5be3d12d10fso2738924e87.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Oct 2026 08:33:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792510436; x=1793115236;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sO1PhZjq6o6BXb2HXe/PM4VjDQ9u/0YYvxXPAXHF2z0=;
        b=jiLWvfUlNH8YfFTJaBqNmr34Z3DJRY/vr8JP4BF1XHcxX7dKD8U+92FFzhN0Xg10Dx
         5dwLQMb+cogN+IkGuI9ndD2qiRXB+zDWVsxQg0OjpBD8x4BZzr3IOKNdmDBIcRinNbj/
         lMFVAJdn3gEGnxwKPgcVv7fJTXq8qMeP1Y0RgdVIM7/bSS49uHbpkftsvfOZ65wUB98g
         mq7YGApX5m+/aTF5wmLz3nFB0fieRwyezX0F40GPw8d7X0BQKNybsILLKvKKv7U9dXfS
         qqNyWaiW1qI8xYFgdADSEMC5/7nsC3beXSaeneXXyjWTVhS2ch9CVbgMHDMNbhg0Palk
         qWaQ==
X-Forwarded-Encrypted: i=1; AKwUvBzsfy4p2TmJkcUUo89lHTQ0BKYf0IiRpCuvpnzu4hxuDjoAm0zjJPnVpL7z5ie08h/py4J6Br7+sz+EjgJXcs7AY80=@vger.kernel.org
X-Gm-Message-State: AFq9FYIbDyFX0qIE/k8p/+HA90cwmvhnhyLJHzkkiFzkPKMt8Z/Y0r0R
	Twav10h/L1hTiR0WvrZgeMRxXakLYnUujt/AF+LDai127kE1l59Mq6iU4sq3SpZKY8dujdvE7Ss
	IxXb91MHRSZ6W2hVmyElX5ZNwdIfJCPgwKwA0pAy7b0DOsEh5z2MTiYN0Y9uEGyvmhTa/sGtjy+
	AjBrXx9w==
X-Gm-Gg: AYBFou0taQmBssQTzA01J5WX28XyrQPLfmKv5nZNwhZyLqzbqFBztbJhDBFdIl8k1eT
	4dzPcLWrESknBXaNBFAxsgjL367mYTk1d4jWdzTyAFM0Yaatnqyp83TlnDihKLP42vx5vNNzsxK
	0BExPfdH2QYsDjpGdBFyXoC8jPX8gm5Q6vcJqF0CvxjE7l3ZQtbsQudFnHX2CuHu4Z/lzkEJxDz
	0xxh9M+I4FEcF+N7IhK/vI5z1yKoNS2uFvgXCRGxmGLQxLQ3PEbqchnw5+uJ2wcs6IFo73n/eMi
	CHeRrYzht6c68lent/p8RVR5kQZaY+FweiT+pRwv4vSipmH5x+gHT2uxrkQzpX3DEXXS7yPQgBl
	d0PjNWieQ9JLBPYUJaKhCfL5ipg==
X-Received: by 2002:a05:6512:39d2:b0:5bf:6c4c:62ce with SMTP id 2adb3069b0e04-5bf6c4c6355mr361205e87.55.1792510436261;
        Tue, 20 Oct 2026 08:33:56 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6f:b0:4a1:d307:d578 with SMTP id 5b1f17b1804b1-4a1d75e6d1amr214085365e9.11.1792510424903;
        Tue, 20 Oct 2026 08:33:44 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.134.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d85a9bsm90373845e9.15.2026.10.20.08.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:33:44 -0700 (PDT)
Message-ID: <363cbfd91b059df208a5ddbbe45f8ad2d4cda21a.camel@redhat.com>
Subject: Re: [PATCH v7 00/14] rv: Add task latency over budget RV monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>, Wen Yang <wen.yang@linux.dev>
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 20 Oct 2026 17:33:43 +0200
In-Reply-To: <20261019154853.2fe2a47c@gandalf.local.home>
References: <cover.1791745088.git.wen.yang@linux.dev>
		<3eb0948c9ca67f64b3b311f823cd0f7628033c68.camel@redhat.com>
		<6a8b5d26-37cc-4a8f-ab1d-0df2c2e6c2d3@linux.dev>
	 <20261019154853.2fe2a47c@gandalf.local.home>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bUdTj8xHa88kNA5GhPZDZVEAZTHIPhI6h4ON8YygQ_Q_1792510436
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-10-19 at 15:48 -0400, Steven Rostedt wrote:
> On Tue, 20 Oct 2026 03:18:48 +0800
> Wen Yang <wen.yang@linux.dev> wrote:
>=20
> > If you're OK with it, I'd suggest merging the series in-kernel now, wit=
h=20
> > 1-8 and 14 kept as the shared infrastructure and 9-13 acting as the=20
> > reference implementation the BPF backend is measured against. I'd be=20
> > glad to help with the uprobe and timed-HA pieces on the BPF side once=
=20
> > they're on the table.
>=20
> Well not "now" as the merge window has already opened, but perhaps for th=
e
> next window.

That and I'm going to need to review this series between a few planned holi=
days.
I'll try my best to squeeze it on time for the next merge window.

If things are not ready, I believe we can just upstream the infrastructural
changes first.

Gabriele


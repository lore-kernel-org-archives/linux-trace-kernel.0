Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D90334574B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Jan 2026 06:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768976218; cv=none; b=DTeZzMwUEZ+1MabsZjGfJ3XzqS3gpT5SSmswONxYVfTDzw70svFfsWkTcBIeMT/iSIT2nYZFekomba1NQvdgFW4p03lHiev65ckB7jzsUNOoWkUMCgTchCvnsaqFJpdxMVx72+NwSLeJXCw1LhtOt20Pki+0HYVom4R+kS8fe5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768976218; c=relaxed/simple;
	bh=FAN8ccSe+JDIwc/UKeTLYV7g9NhHd/4ijL2J6/6sGnM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KvPmsuMo3KbBMfGRbQiTseMGjoU+mUuuKEE0QguG8OUJvUEPHCpZSOYe407CdCg44oOCnHlcCQWzM7C5B8KdjFT19BrNn+Le5ZA/hyw6BzaTLfZWN8ovRHLQb11+3lQmVb3rMIrssZJPJQST7ck0oFtJXXxSJGd1CyakDbLZo3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dM+utSae; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dM+utSae"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768976209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FAN8ccSe+JDIwc/UKeTLYV7g9NhHd/4ijL2J6/6sGnM=;
	b=dM+utSaeZIExjtJiNMKlYs93L1cNAkkRyCnhbwNOHcJG3B7e7U6Do3eGJiP5Oe+hxxIMb5
	igwcVfoEqPoIshBDDeCe3cm7VY/rBzEQmydNNy2Q/aefpAozTCXr+kGovXUqo5R0ngl1+4
	3XlS/JvZZpZeYxNrB0vKu8o2oCDUeWk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-uDrwOyEHNRWIZ_jnTkh4Ug-1; Wed, 21 Jan 2026 01:16:47 -0500
X-MC-Unique: uDrwOyEHNRWIZ_jnTkh4Ug-1
X-Mimecast-MFC-AGG-ID: uDrwOyEHNRWIZ_jnTkh4Ug_1768976207
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47ee868f5adso47126555e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 22:16:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768976206; x=1769581006;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FAN8ccSe+JDIwc/UKeTLYV7g9NhHd/4ijL2J6/6sGnM=;
        b=JlS8FUh/V63cJdSQ1Y3ckNu9LpGkfGNC2047/Ubz//THAkQGZ0djJSUcxMvZi7Xc4J
         6lFjywh2QmgD/3uC0HP+e98mbzbyTltDUekT1/NaVmDLeoIJLbpYEEP5PszBhC31sdn6
         nvZSlLNZCbKfw8+lCu91wsaRahSXaB1mUcNhiupv3nbHQbszQiszINkzu5AlKq5L3SZl
         CSHK39kC3i6c4abiCiXviraGaRLy3M4Id/hXZZW/jth5jncc49YM20wKjU5N13pLXsyU
         Tc1QvdBtZdX33onVWOPEFHPNT5bthFFijvweERbF08M6d6S7v95sWV99ZthCZdpFGQsj
         o1MA==
X-Forwarded-Encrypted: i=1; AJvYcCUpZLEhapsTkUbg7mYcQEBNu0xBDkDKtRNU0llpVBKficxpWaN7x9blpAQcydbBGyn5ne6PwDhKMaVVjJeOCxc4EkM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0tyA1wm0nmr0H8BMlJMrUEjB+P19yjI44BWBphhCeay/N5L2X
	zc7MZSf7VvCyph/jifo1e070YC1j4IPHuEQ6sgzBoRLoAgLiS30nebY8urbW47FavYfcqrQnijb
	nDVEUIoI5/WIH6/MhpsDxXsFC4BULG6dpkumoWAAaK9cdr7gydtyWvwsDQVcyIej+PD5AIgmTSW
	60WZKFWvi1
X-Gm-Gg: AZuq6aIvvIhMpFqJQCbxszscfcLX3in5IpIG3+K7DZeWB5e5OgYNn/tqg279qfKI3me
	llSAbLxeahlBiUnCQRUQncecOyosWqcLLi23n2cO5oN/qNFQk5SeXD22v+3qbOEg3xgvjfblMOu
	pLWIBgYtFbrHFyVqfXP6LBSJzcYua7/YTVRxSyGxz+9DPRFvO9i3pbemFxcUgnX+1aw7h6ia3r1
	bDfKXcwElPzh2Nl2fvVNyJ4+hUf4Z7KB8ov8Ijcf6tMact+eiXKEFwubOyPmm+ChMCDEKCkZHEJ
	CSm2jEVzKeTOFrKP12uowt9webBmaMJKJnxOqlMGEc8T2A0GU6DKPeepzq21iLTGDzNjwjZ0Xyi
	A+sG9HL5E7CXbzbzgBCNKTV2HnNxa5lxX66CH0sm1O92UVD4wdmABzCEIglvEx7aeDXoOHCWdsU
	R3mKJD4slb
X-Received: by 2002:a05:600c:3e07:b0:480:3ad0:93bf with SMTP id 5b1f17b1804b1-4803ad094b1mr100849855e9.24.1768976206589;
        Tue, 20 Jan 2026 22:16:46 -0800 (PST)
X-Received: by 2002:a05:600c:3e07:b0:480:3ad0:93bf with SMTP id 5b1f17b1804b1-4803ad094b1mr100849685e9.24.1768976206230;
        Tue, 20 Jan 2026 22:16:46 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e8c0475sm344608315e9.10.2026.01.20.22.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 22:16:45 -0800 (PST)
Message-ID: <ef6af65b1546650ff3974a305126703117b900f5.camel@redhat.com>
Subject: Re: [PATCH 26/26] rv/rvgen: extract node marker string to class
 constant
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
 open list <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION
 (RV)"	 <linux-trace-kernel@vger.kernel.org>
Date: Wed, 21 Jan 2026 07:16:44 +0100
In-Reply-To: <aW_PXmp9T4Hz25rt@fedora>
References: <20260119205601.105821-1-wander@redhat.com>
	 <20260119205601.105821-27-wander@redhat.com>
	 <0383d9a3fdaeb2b66e48a7857791bcbfe324958d.camel@redhat.com>
	 <aW9nfu8r0YcGj0z5@fedora>
	 <85c7d4762464e6a50b4318f4ea56a70202a4b287.camel@redhat.com>
	 <d15348f9f6d8ed71ba3e928ae1b5da15711894e3.camel@redhat.com>
	 <aW_PXmp9T4Hz25rt@fedora>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hEea5CmwuSF2OPppBjycNniFMu6sZdM7EpwjPK8cNAA_1768976207
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-01-20 at 15:56 -0300, Wander Lairson Costa wrote:
> I created the patches on top of linux-trace/tools/for-next. Is this the
> wrong branch?
>=20

Oh that tree is tricky, usually RV pull requests go to latency/for-next , t=
hat's
where you can find it this time (Steve created the specific rv/fixes and rv=
/for-
next but hasn't used them recently).

Anyway they're all linked to linux-next, so that's usually a safe bet.

Thanks,
Gabriele


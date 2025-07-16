Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFC72F4A16
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752671633; cv=none; b=pyYbpYiF1X5x46r5D/9t0bCHOyIayWXDQPUSkyBho7lw1F18pJoIQtpVMg77uA8DYEvehUqPBIH8AwnyAUL8I5FYN2zaXAIXOIB55UdscT7dYuFN7tuxRF/dxYp5pGmFRBqVzxOryCPl7tJv3wHmvbwN3LXzi/p+MfAFVxv3GmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752671633; c=relaxed/simple;
	bh=vztbovVhYvSRdBgfJuNmh6Rbe2CbujpKshc/AEHG0wA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nX/hh35fMAalaiKycAiTSO4hJAzQt8pQMa1M483xhU5fucAdgeEeuQ2m/srIHFYg3K11BK/kyEBj3SI0gQDxpb/dc/1zTbtR5aMdLCQoArSakunYQvI8AcZeuGQn9DEybQU9F5ke0Fw191ogOn+KSEYr5W2Xpu5mAXfq+v4hOmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=exvDzHrL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="exvDzHrL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752671630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vztbovVhYvSRdBgfJuNmh6Rbe2CbujpKshc/AEHG0wA=;
	b=exvDzHrLwJJOdfop5od3wwzGok+W7WrpDTMHMJRsVv6THllvQilmKezc7yKUOkCbqGNB3Y
	qsnfU2A55c5Dpq8ag6D7E4TTh+3ZsX2mrQiMToXLwMXhtAjhGSpznB4CrClLk59ha/DtWH
	hiL2LUEiPAl5bxkw8kNz+1ywjUR9HnI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-T4xgADuHPBq-D4L0sGpmNQ-1; Wed, 16 Jul 2025 09:13:47 -0400
X-MC-Unique: T4xgADuHPBq-D4L0sGpmNQ-1
X-Mimecast-MFC-AGG-ID: T4xgADuHPBq-D4L0sGpmNQ_1752671626
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-455e918d690so5624945e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752671626; x=1753276426;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fyKbxHjITdG/t6LvPifqhCJmc7mlWwpekSsbT3bH2ig=;
        b=nu1SRr7h4nlYNdY3sHR9Q1Gum+NAuywgc1fU9/zZuwB4l6dqOu7dft54NUunhhGM6M
         beEcaLkJf62a5A46Aq76cbyPl9E5+glNFcCsOD1o0nmYe7vtCA15pPevgfOdV6SkgjuJ
         PejPhJnSJ2z5cCbbEdkypymT93+7yrMymBYutT67fQ3JZv0H0JgStHTsw94rh0CCuNHy
         EhFVAvzlV4clVWtXaryfmJST+UWzr5JIHXCAGQALYuydxRbZklNvoPjWVqlwNdd9x/gS
         wDw9gUE9OghVgQZKspxsLAZbgFGmF+CBEI2uU+sS1ttm+BknS1ruZ0Ow8PxKuarcOQKS
         zV3w==
X-Forwarded-Encrypted: i=1; AJvYcCXPvAyuyfhRJjzvsxoK2mbaJ9Ggp0cygGtkjRgXi5wrNfEg6MlkOKO7gdZqYPzlXxtcbzp8buCFcR3hlGU+Ss8grJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/QTXeYtLbvcB/u6IHL4zePquEDzQlnSny0Ix97yby2lm0cLky
	S2kEXXPOa3Gd/gnmjI/jidz/yJI9qilPdyEUW7ZBZi24dN4g8Bmk/BygmAW0BoM1SlTHtoSuXAc
	SjbvaMjr5v5WKE6F0pWCqwEyF7NxuxiWljgfPhK0FBuBKAhbyzkmXTY/I6aQVuMC8MQh0iAQ0Yw
	==
X-Gm-Gg: ASbGncvUKVM8VImxg+3sJiIycBpS7MbPtto0la+gjO4DUJKKlO9aA60uVSsPtGg3edh
	PIj0qDX3Y0UMprruv3MK9gsR1lhYDEohYizkrwCPrJ2UPNduLRuvrwHYogj64oD3qeCRVw3u4DH
	1YYm2juJtD+N6+3GqIq+2jNHQXdcECOsIqyUnKZcu0BnbMgi1DXW6aVzmynmVxP0iBcdER/erwP
	476mxns5sR/UISVk/jMDAh38Rb/tBuFcvZyd/zj58RFExq2dqgJAsQhEawxOwdTvPB9Rt77OdJm
	/aoa4h+hL0Dmp5BDsQnVrvGDMB0dywfTA4a6u8KsmfhlSwnkL9kw1PCOasKgMD7rdA==
X-Received: by 2002:a05:600c:8b62:b0:456:1a79:49a0 with SMTP id 5b1f17b1804b1-4562dc7d288mr33139945e9.8.1752671626199;
        Wed, 16 Jul 2025 06:13:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfwHGgZ6HD4UQjq1BuuxJhLnJtnjRV9Ef9VjGwO/QB0x+rXaieVermWwev6SGcjNjt6zUwNg==
X-Received: by 2002:a05:600c:8b62:b0:456:1a79:49a0 with SMTP id 5b1f17b1804b1-4562dc7d288mr33139625e9.8.1752671625700;
        Wed, 16 Jul 2025 06:13:45 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d70csm18110704f8f.62.2025.07.16.06.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 06:13:44 -0700 (PDT)
Message-ID: <77bf0cb4262af4edf78dd0b5233788b358bdc79b.camel@redhat.com>
Subject: Re: [PATCH v3 01/17] tools/rv: Do not skip idle in trace
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Nam Cao
	 <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>, Juri Lelli
	 <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John Kacur
	 <jkacur@redhat.com>
Date: Wed, 16 Jul 2025 15:13:43 +0200
In-Reply-To: <20250716130846.GC3429938@noisy.programming.kicks-ass.net>
References: <20250715071434.22508-1-gmonaco@redhat.com>
	 <20250715071434.22508-2-gmonaco@redhat.com>
	 <20250716115027.GV1613200@noisy.programming.kicks-ass.net>
	 <21b23f125e20102440e36da08a039d88bdf58eb1.camel@redhat.com>
	 <20250716124105.GX1613200@noisy.programming.kicks-ass.net>
	 <5aa9b70894f464dbff8e317cbd8fc188db9920e4.camel@redhat.com>
	 <20250716130846.GC3429938@noisy.programming.kicks-ass.net>
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
X-Mimecast-MFC-PROC-ID: 3Z4nyoU4IONGES6_KhwLmy939ziwdoIA1wi-F4YvsWw_1752671626
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-07-16 at 15:08 +0200, Peter Zijlstra wrote:
> > > > > > -=09if (config_has_id && (config_my_pid =3D=3D id))
> > > > > > +=09if (config_my_pid && config_has_id &&
> > > > > > (config_my_pid =3D=3D id))
> > >=20
> > > But should we then not write:
> > >=20
> > > =09if (config_has_id && (config_my_pid =3D=3D id))
> >=20
> > Sorry, got a bit confused, I flipped the two while describing:
> > * -s shows traces from RV but skips from pid-0 (unintended)
> > * omitting -s skips events from RV (correct)
> >=20
> > If we are running a per-task monitor config_has_id is always true,
> > we pass -s,
> > which makes config_my_pid =3D 0 (intended /not/ to skip RV).
> > Now when we are about to trace an event from idle (id=3D0), we skip
> > it, although
> > we really shouldn't.
> > That's why we also needs to check for config_my_pid not being 0.
> >=20
> > Does it make sense?
>=20
> Sorta, but would it not make sense to use has_pid :=3D -1 for the
> invalid case, instead of 0, which is a valid pid?

Yeah that's another option, I reckon even cleaner since it's currently
misleading..


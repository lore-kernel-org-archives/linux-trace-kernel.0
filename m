Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB6B1F419A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 06:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779432366; cv=none; b=IsVEX5r1SKjsPrA+Bynpv0WeDECoTE77N8hsOEzC2bulJ5MniPk1IqN1HDRiJdIc+EexNM9wDDMVQMUdIb77/i2uW2IBmMCXnRnwsHGUYLogHjOcXpqOySi2lt7aI7qHvgx9Kr8e2tVXu7ayD74SDm9k8nDIy1AdX7i+RxMoMFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779432366; c=relaxed/simple;
	bh=OuypiTPvo6MlH6Aw9Q/Fs2RcYOmyy1Gt284dvTUNXFg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tql4w3nVCQ1fP1OB4LGm4edboYAizeLA9MdgKRJJJD6BiFYca5zElQfmMrI+SxxhJFxusOZY0WhUzfTWDIISBWuOO8g+1/zKodr8OmBiJd5i8hUGu21v/sOWKd7sJ9Hb+8pAEW5bK2mdpbld1kQh0DkAgOl+gb7RZBnLHxV+JUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VaUWO50X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VaUWO50X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779432364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OuypiTPvo6MlH6Aw9Q/Fs2RcYOmyy1Gt284dvTUNXFg=;
	b=VaUWO50X1RF4/NZ/f7rIhGuMYi/ylHJgPxNYy7ao4ZvMwZM0D4YFYgiYq6KknccCXg6weY
	AckH0SCWhtZXtOut74Mico97cnrcmai7Ow4QSXggsHofnj5j3P5ktsS+vFpKz4QMj9xxPz
	sSjvVpvTU1482c+DwMWFtYBmsHKwF2w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-dLaUuVxhNWSYdmzBPds9jg-1; Fri, 22 May 2026 02:46:03 -0400
X-MC-Unique: dLaUuVxhNWSYdmzBPds9jg-1
X-Mimecast-MFC-AGG-ID: dLaUuVxhNWSYdmzBPds9jg_1779432360
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49045243094so4869695e9.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 23:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779432360; x=1780037160;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OuypiTPvo6MlH6Aw9Q/Fs2RcYOmyy1Gt284dvTUNXFg=;
        b=HMD9cmu4Tg4s7yPPU34/fRrIgv8HWuxp+TarY8dqyI43f4l8mNszohDV0bsi9/9ks5
         n1TP8e0/qxpk3f1v/+hLimAjnoVAWG3J0ErjWBU1PoQNqisLh6SmpzFSITtqHNIQj0R7
         WpbldP9AVGAqsQm64mvFZnPmW9ziFMm8LroeDSLW6bFm18X2qlNEvuGtFwTgEDNOeKHB
         k3OXDsDrQ03jDZ3sE/sCJkoQHCV6XQ9nc104r7M0dhsoaCxmdDFtuE8e/yMVOLbz/7ux
         uRve5vU4Su1y3wd1fvpb6yyOmtBN18i2nri0GPcTd9q0bCxEKkqXUYPb83Sj/KgQ8yf4
         +W+g==
X-Forwarded-Encrypted: i=1; AFNElJ8VM70U7r+EiXHw4twHPXT7FwvElvYVPl7FXPArGiMBr8pE5f4RVNLI/ExVdN32yKxAG7jXtCFpA62Tp4F6tWtF3i4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ2EAJxRAv+jjzvTPAw6uxIUxokLslufKDaxMzIOHHGZe/zr0N
	lJjA24Y2lfUMFA73sqe8v4xkB8VEIckfEYVi3Xtu75zVrb4UuUsK1tnS0pywj1SXHRBFP4OwIz7
	U7bChdJ/3zK9QTmxF+nJnf5D0LrNS3SvqPF4iGqvOHrZFvI31IYXKSPPZMcvSFPYqPK6di6IPJQ
	==
X-Gm-Gg: Acq92OEPdQeovU4dKjgPM2cCjPoJJIY3GgmcXFOADxsV2mFz1Xh4F/bX4VdV1poEHx8
	Ib9MQx1BVJbDY51Zwa5CzZs9dwcByDeFKDh4Vxb4Yx8TggHGDyVyDl1X4tXL+bChE0IubT/VMlz
	HQpiyOYwKXj78D2RPdvOzYppkIXY1F/ZUwa0RafldWxly7JiKtXbCb4cRAUCF3bQvHIWOL+kPW9
	W2fhkuf+bj7Dw+s2gj1KG0uaiHr6ZHyVQ/u9DZVSYw3Jwsydf91/4LF4c6d4zlpAl4wH2R3htzQ
	h4TNEhYXCk6KU2O/H76TJx2fWehRaP8YvYSQ2Nn1DLAPoTGKOgescorS1yMTUTV6zgKp0ndWKma
	EQ3tdPbIpznjFam8Bt7dWy6FtDEJtgg11ULUqB8ZEma2BQ2DJ5VPc57ephF4wqFBPSb17uPUGon
	o1/TGLR1o+EZYH18A=
X-Received: by 2002:a05:600c:1c0b:b0:488:b187:3c with SMTP id 5b1f17b1804b1-490426aa7acmr29440585e9.14.1779432359908;
        Thu, 21 May 2026 23:45:59 -0700 (PDT)
X-Received: by 2002:a05:600c:1c0b:b0:488:b187:3c with SMTP id 5b1f17b1804b1-490426aa7acmr29440265e9.14.1779432359533;
        Thu, 21 May 2026 23:45:59 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454ea134sm25438455e9.8.2026.05.21.23.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 23:45:59 -0700 (PDT)
Message-ID: <e084200e670c3d7150ecb3085504d0e737ca4d0f.camel@redhat.com>
Subject: Re: [PATCH] Re: Re: [RFC PATCH v2 04/10] rv/da: add pre-allocated
 storage pool for per-object monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wen Yang <wen.yang@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org
Date: Fri, 22 May 2026 08:45:57 +0200
In-Reply-To: <7917085b-fef1-4017-b289-eefe84332ff5@linux.dev>
References: <668f83581c58644a84cab5e6736864a439bb8e28.camel@redhat.com>
	 <20260515083002.106512-1-gmonaco@redhat.com>
	 <6d2f3490-5e30-4966-a3cd-372a34e10ba2@linux.dev>
	 <5183dc18d63b617ab0f19290e8a790fa6898f372.camel@redhat.com>
	 <7917085b-fef1-4017-b289-eefe84332ff5@linux.dev>
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
X-Mimecast-MFC-PROC-ID: HR8KQzIr-qZbdtP9HqPdOpTFZBlvDRWJXRk1ERW8ILc_1779432360
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wen,

On Fri, 2026-05-22 at 01:40 +0800, Wen Yang wrote:
> Hi Gabriele,=20
>=20
> No specific reason for REL_SOFT =E2=80=94 not intentional, reverting to=
=20
> REL_HARD.
> =C2=A0
> Reproduced the stall on the same config (PREEMPT_RT +=20
> PROVE_LOCKING/PROVE_RCU).=20
>=20
> Root cause is a cleanup ordering bug in uprobe_detail_waiting.tc,=20
> unrelated to REL_SOFT/REL_HARD:
> =C2=A0
>=20
> =C2=A0=C2=A0 # original cleanup =E2=80=94 wrong order=20
>=20
> =C2=A0=C2=A0 echo "-${UPROBE_TARGET}:${start_offset}" > "$TLOB_MONITOR"=
=C2=A0 # (A)=20
>=20
> =C2=A0=C2=A0 kill "$hog_pid"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 # (B)=20
>=20
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (A)=
=20
> triggers synchronize_srcu() in the kernel. But tlob_target is stuck=20
> mid-uprobe_notify_resume holding an SRCU read lock, preempted by the=20
> FIFO-99 hog -> so the reader never finishes and (B) is never reached.=20
> rcuc/0 (a kthread on PREEMPT_RT) is also starved by the hog -> RCU stall.

great you found the issue and solution. Wonder why lockdep wasn't more
informative, but probably the issue was so frequent to hog that too.


> =C2=A0=C2=A0 Fix: kill the hog first:=20
> =C2=A0
>=20
> =C2=A0=C2=A0 kill "$hog_pid"; wait "$hog_pid"=20
>=20
> =C2=A0=C2=A0 echo "-${UPROBE_TARGET}:${start_offset}" > "$TLOB_MONITOR"=
=20
>=20
>=20
> On the PREEMPT_RT it is more reliably triggered there because rcuc/0
> runs as a preemptible kthread rather than in softirq, making it easier
> for the hog to monopolise the CPU long enough to hit the stall.
>=20
> Thank you for the thorough review and valuable suggestions. We are=20
> working through all of them and running the full test suite.
> We expect to post v3 within the next two days.

Alright, sounds good.

Thanks,
Gabriele


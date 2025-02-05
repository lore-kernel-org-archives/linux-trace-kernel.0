Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8873A22B5BC
	for <linux-trace-kernel@vger.kernel.org>; Wed,  5 Feb 2025 12:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738756926; cv=none; b=lTIfZrTbuLclP8nNq57wt0Mv/7yI0+mcrQTjvWAigFKIuOVkZASQapVaRwMukAZPzQSJ56pEYLEYzWignJqjigfseUGcGsMRhUILpnG37d8AYobeRj1PaZgjst5uyEvNFhhsda3jlhd54tZIiQFfS1S9tNEsqflC0g5Sz9vZ9uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738756926; c=relaxed/simple;
	bh=ayE+rp/IcKvikaOy9R1FKceMOlhQSI0MWRUQIQ+36Ik=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OjH/lz2SbtLRZzHZOmS/9axWDreipg9M1w/N4TvxTjqCfpKpfZbPtaVCjwcDt4wwtpQTOHztRTxVCuLXI3R/m47UZvkxMoL/5lg6BetIZysCdjCyyd8CPTi2dJcBZZRbdMoxKpJiQTRUaLhUlKwOScPO8tqr5rhSEODVcIjzGz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h7yv/qti; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h7yv/qti"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738756923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ayE+rp/IcKvikaOy9R1FKceMOlhQSI0MWRUQIQ+36Ik=;
	b=h7yv/qtighGL1vD28JysjCTULe6D1TgMba4mTpxUjUeIzbqoURUAaKYu9zwXjCgQSCKvJS
	1YZjeJhdTw+AtsBVt2m3kUQORE39hp+L3Uju0lPg2dh/c4ZAuju3GRxqEUD8oJadG6YJB+
	93FgB1s2WLVGUkzQ/gGEsy0UP/MR0S8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-Z9cdnnhQMI2EF83aj0B6IA-1; Wed, 05 Feb 2025 07:02:02 -0500
X-MC-Unique: Z9cdnnhQMI2EF83aj0B6IA-1
X-Mimecast-MFC-AGG-ID: Z9cdnnhQMI2EF83aj0B6IA
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38c5d9530ebso3889282f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 05 Feb 2025 04:02:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738756921; x=1739361721;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ayE+rp/IcKvikaOy9R1FKceMOlhQSI0MWRUQIQ+36Ik=;
        b=Cb2xoyMECFHmkCrs4aVlJtps4dGI1eEgr+gvatFiS9B5ppBJFOYlfPnmNmgH0F7Vbm
         /GneJe4bWS81HuLX9+7XLcbam4uu6+RPlUBxmYkApKf05/x/OGt1xd8wGoWT4UmU8mPy
         Lm4mglPeTL2svkmuimWp52WIOw1DQK1BDbRkL1xF3V/zehjujleNANpq2MHfkHpeeo8s
         IU3wnQPUMc3WV3emHGayIEuj4J1hVC5W4Ps53gHPBmCYb+S6UUQBDEp48A3qtCgL33D0
         Dl5w9Y2EzgB1qkqjctSZKWsTORnt87fA2avIOOoZp+kqWzp9+KwRe427VgcAYKDgtpXY
         TewQ==
X-Gm-Message-State: AOJu0YxXQ0/dFPQtVy1tjmoFX3ito2gcL04x2i/yu7V4UiKNYPwvE3wP
	qZx51XVZsN0AMAdrrLQ9xQ7fFkwg5CoT/NLmppcqYz/RCc6IOjjoRs3GCKFLLMR70WDNfZteppP
	dEVG8a9EAMabZkMaPqLQIbzxm2/qD5Rk0TOa9r+LQHgZOATvnnHSF1FDVg1nKHwekPv07xA==
X-Gm-Gg: ASbGnctcoyjFAHY27jow9G2i6Y62YFeVzcp6U+yPTuGEy+y5NKXSypijPj2sR+cW4G1
	31+2/3Fegh6fxhl52qDYZr4KhgzgSd6T8/8/RX7OW3USgh6/ELKU0sDMFHVr2Ug9QdBF7CGO34i
	LbcymESpL1cFrG3LaimgKvbDy8/mETV4T1DBaNVHBdAP4XN0GWYxxvJdzNkk7T1QY2OMEEvPi2/
	Hvhv/vMJf5XmAtlMYZnAjBuHCbeT+pvLy7JHegPwUsgYpiDpCWeAoLtCd1ag1aBNONb34AFMbnt
	dYz39R6r8AVGMoSpXIWZsVMf3FEKDLs=
X-Received: by 2002:a5d:6d81:0:b0:38b:d7d2:12f6 with SMTP id ffacd0b85a97d-38db48585c7mr1551968f8f.2.1738756921050;
        Wed, 05 Feb 2025 04:02:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFI79S0TKZG+9E6w6mg5uh7PaBSHBpX6hg5XxCyUDI3mB3oiFuhF5ZJTnQQuCKLUZeBoAUlg==
X-Received: by 2002:a5d:6d81:0:b0:38b:d7d2:12f6 with SMTP id ffacd0b85a97d-38db48585c7mr1551932f8f.2.1738756920635;
        Wed, 05 Feb 2025 04:02:00 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390d96530fsm18567525e9.19.2025.02.05.04.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 04:02:00 -0800 (PST)
Message-ID: <21e53ffc5e2805e369fadc5e0cc582379a605ab4.camel@redhat.com>
Subject: Re: [PATCH v2] trace/osnoise: Add trace events for samples
From: Gabriele Monaco <gmonaco@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, John
 Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>
Date: Wed, 05 Feb 2025 13:01:58 +0100
In-Reply-To: <CAP4=nvRNvdULubjN1XPF8jNxY3tRdfy+9Vqv97EsKjzNGKyYig@mail.gmail.com>
References: <20250203090418.1458923-1-tglozar@redhat.com>
	 <CAP4=nvRNvdULubjN1XPF8jNxY3tRdfy+9Vqv97EsKjzNGKyYig@mail.gmail.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UFOfkmpgmmqTKWrEZeNCZe4Mifal4oK9WPsQXVkgcSI_1738756921
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-02-04 at 14:35 +0100, Tomas Glozar wrote:
> po 3. 2. 2025 v 10:04 odes=C3=ADlatel Tomas Glozar <tglozar@redhat.com>
> napsal:
> > A proof-of-concept bpftrace script using this feature:
> > https://gitlab.com/-/snippets/4801190
> >=20
>=20
> I added another PoC using event histograms to the snippet. That one
> captures data from all CPUs, and thus can be used for testing on
> machines with a high number of CPUs where rtla cannot keep up with
> timerlat samples (in our measurements, >100).
>=20
> There seems to be an issue with division where most values are
> rounded up, e.g.:
> max:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 135=C2=A0 timer_latency:=
=C2=A0=C2=A0=C2=A0=C2=A0 134657
>=20
> This also affects the main histogram and seems to be specific to the
> event histogram PoC. The bpftrace one shows exactly the same results
> as rtla when run concurrently with it. Another difference compared to
> the bpftrace PoC is that you have to calculate averages manually from
> the latency sum and the sample count.
>=20
> Tomas
>=20

The patch and scripts using the new tracepoints produce reasonable
results on a large arm64 machine (128 cores).

Tested-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele


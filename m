Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ECD2BE7A3
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758028519; cv=none; b=FH0PaGZkjemWJkSQbi5YUPFEIe9W8X2LOgQ8Ktj8IHW+zcylk2U31YwtB+AZG6IFid2vV/PStkAtiUMQKrAiVRDyvyaIn9lHpqsu80oHwcFtoHulJPgHZPlxByVf6CwFv/objFLI6yQqQzjP6LbjzclGEEFAluaWJut3nNJ8XhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758028519; c=relaxed/simple;
	bh=CFNU9J4akqLpC+4ufj0IXFbsTGHn/fYlRnS55Ajz+Tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JgSCfVz06mvxhn9PD6cIVf717f4kuEjrG5qN8DKZ86werW0MLI/FT9pl7dA2mL3fK27ZutHOMBA4N2G1oycXmaQwzB3hAWmd/FHBvsZVfHqFEfeQiRqrmTAfdRukAGjSTYaLjIPhGqKMAaxauTyZUgDih519ziY61sF3ZjzXWJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ir6uen4/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ir6uen4/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758028516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CFNU9J4akqLpC+4ufj0IXFbsTGHn/fYlRnS55Ajz+Tg=;
	b=ir6uen4/sdLid+eRF90ebe7UpZ4mNqELZQanePTEHmMisBcRjgC/pW5jzKXghzPOs+ukFS
	CaUUtCDlFQdjUnLmbctgiC5fXkGyf79yvkbvX90plBV3SO94l+hEye8xI6WuX8CcKnSnFx
	VnjAOfNRxOEqCGP0MrcDsVFBS49v3Tc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-TwyOd02aMaqiZ82SQLeV_A-1; Tue, 16 Sep 2025 09:15:15 -0400
X-MC-Unique: TwyOd02aMaqiZ82SQLeV_A-1
X-Mimecast-MFC-AGG-ID: TwyOd02aMaqiZ82SQLeV_A_1758028515
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b047a0345eeso475393466b.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758028514; x=1758633314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFNU9J4akqLpC+4ufj0IXFbsTGHn/fYlRnS55Ajz+Tg=;
        b=MX/FMBobVjlRq7OxCRDqSlzdXEddIiNcEZmzHUlJz6Ao4BCjEJ3bfkcMRbwLLm7Yuc
         ZohH9yfLP3nDt0Sh4wtGaclbh9jKhQMZIlcZUsiBodeHIU1d7mFjY6iCsihkc0l/LL9h
         vQYah1/K1QAUv9kurGGmfDfp0cVM9Ew4p+1fkoE4TKG5jowlshcE217QO35rE9UqScit
         bT1ZZXXjWcReQyLaIY9PY7ZuyNKjYAHfDnJauscuq8RtXidNamHLK/P3A0grwwgSm99K
         PJluU0Wj9mqp545fBiKxRkTatWZsvqvgbMIycerThHQzfUWPmjsXcs0ZX0s8dKlLSqYv
         MZZw==
X-Forwarded-Encrypted: i=1; AJvYcCVrIrrCnkr5P2h6hqU2tdVuS2urK3zcAJNXn/YQ5+pvzx9V8CSmDwbyyt49O1hA9U77YVSRTo8jDdZxAtnzdZDtUI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+H3nZz9J9o+8pbMQd7miHPgMtPOrvg653ZbkLNOV98LgHsTDv
	ZmYcLdqI3Gkx2BwKZrTw3B940USGUUU3OcBr5+rUh69UJDr0sxq67QhBOhcheWd1aWeobpTBmsy
	rzGfto2ey2+0yD4PV7pBglvB6STFysFwwDfhMz5kfnfqGpnUXLtwAuML+sBxULLznle662RLOmF
	sfvGKnZmbbSdL85zktSOUhLgC1WmkRAD6RwZFha5bIUAqKaNdn
X-Gm-Gg: ASbGncs9H685Po73kCy3hgJFaGPrNbMVkMjSqQwczJ2fsnDrniw/Uxyodqld12wa7Ml
	EWLoKaKtChdgbmIjJKZUnte96Wg3FAYTE3Kzkp6HtURDs+X8/ETF7eUrLkSheRB9J/HkInHWpE8
	RO0sVsiqThskDMngv4MfU=
X-Received: by 2002:a17:907:6e93:b0:b04:563f:e120 with SMTP id a640c23a62f3a-b07c3a701e3mr1534969866b.53.1758028514525;
        Tue, 16 Sep 2025 06:15:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+BigIFv5ET4lzWam5rtJcyPE/Kp4vz+0aQgQ0Q9cVQP1nN06SCjVFvH6Jkzzub/uEvI9gCSLh8aBvLjiEIoY=
X-Received: by 2002:a17:907:6e93:b0:b04:563f:e120 with SMTP id
 a640c23a62f3a-b07c3a701e3mr1534966666b.53.1758028514107; Tue, 16 Sep 2025
 06:15:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915181101.52513-1-wander@redhat.com>
In-Reply-To: <20250915181101.52513-1-wander@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 16 Sep 2025 15:15:03 +0200
X-Gm-Features: AS18NWCjp52mBkr4kl6nNsC7R-KHcGjXkKQGi2ybfsO1XhfaQkh8bnHJyUJxXxk
Message-ID: <CAP4=nvSHeGEmP6sLBLK==pwEHw4SnvFOhVYiSnWC-DYBPoepfg@mail.gmail.com>
Subject: Re: [PATCH v2] rtla/actions: Fix condition for buffer reallocation
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Chang Yin <cyin@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Gabriele Monaco <gmonaco@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Bdp__3UnhpS0md-azF1ExHzmQjpUjOyYiXIJMUsapxA_1758028515
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 15. 9. 2025 v 20:11 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
>
> The condition to check if the actions buffer needs to be resized was
> incorrect. The check `self->size >=3D self->len` would evaluate to
> true on almost every call to `actions_new()`, causing the buffer to
> be reallocated unnecessarily each time an action was added.
>
> Fix the condition to `self->len >=3D self.size`, ensuring
> that the buffer is only resized when it is actually full.
>
> Fixes: 6ea082b171e00 ("rtla/timerlat: Add action on threshold feature")
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
>

The blame goes entirely on me for getting confused by my own naming of
the fields. Thank you.

Reviewed-by: Tomas Glozar <tglozar@redhat.com>

Tomas


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11721F8AC5
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764170544; cv=none; b=oKIh/T0xYc2l5IHXg0GHCebjAjZyaBUf/buXfgcOnpBnNsgPMPJkW2W6Ps9baswtG537Rno+ZpglBqU0Y1fdjlV1c17IOtY5+ZK3wYR5yPHAMZu5fU4U4XJdoYXbS19fH1ekityjayO11TJL3sc81F79soF8lPPuVw6urPV3AWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764170544; c=relaxed/simple;
	bh=twZntjw8B1z/SkMhcscmZ902S7IBmVFlXLNV+6h8G5c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bfsj1eSgn5OXYBe2DzLorWlUTb6au/3njXtHi8isihkqG5cdvT1IIj6BBfBIutJZFNX62VeElmRVU4JK40UNVNSYXJn3gC8iTpKVPxw1iKXQfE7kuyt+Yo4qVr+uJOGX49KAg/zRlJ3iE7pf6TwyKEwAyamWgzJPwqFHtPnI8cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FaWKLLUO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaWKLLUO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764170541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=twZntjw8B1z/SkMhcscmZ902S7IBmVFlXLNV+6h8G5c=;
	b=FaWKLLUONtdXRpjvTOR0A6+DPrGfjmr0exk2Qj2f7Kf+EUXneB3W7C7VcziyryL0/iovWe
	wV8uyuVV8PHD0pmIjw7n+id2fDAzYTqbhHomDcjtnDhwvr8q0W1sCk5OTfW8v7FkEY0wUG
	Rj8V73G52FBzuaeRpFTR+7CoMEBMwlU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-KLJWkHywMzWXkFN5r_Uvrw-1; Wed, 26 Nov 2025 10:22:20 -0500
X-MC-Unique: KLJWkHywMzWXkFN5r_Uvrw-1
X-Mimecast-MFC-AGG-ID: KLJWkHywMzWXkFN5r_Uvrw_1764170539
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47904cdb9bbso7238855e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 07:22:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764170539; x=1764775339;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=twZntjw8B1z/SkMhcscmZ902S7IBmVFlXLNV+6h8G5c=;
        b=uSjAZtcBsMj6K88rtvvCpm8hazqW1oRWXIEMwjY7+Y27AbdCoL4Ny+Df9bsf9OSp5A
         o9NapuzTBSeI25SBdZIVLVzvMoOSNvJMpIHb5G8qcDLON924keuiMyeQMziq32rMTRKg
         UPsYrWj6OOk3TcE2FJnGNw1JnE5tWBRAeJQMyviPdcClRwi9cJ7p9ZWBpQ+RxARJT8MI
         MA9gI92miSvhrFs0sNaay3vrXBusPtIj3NXfW1OYCMwy3/fomqta7u8LCON0kVQrAeJG
         ZVLSbhrVwbGdYzEBBYe9veZhkMGBj6tn5mqBhX80U7EEhokDGgB1HgHjhaoJhyF/gtV+
         wrSg==
X-Forwarded-Encrypted: i=1; AJvYcCUvtyzWu+ipyIUOuHcmNAJNFrMTgjHJiaLWqzFhktG8ET9hgVrxoe08Zm6S5NydROpYxVY3wZQaBMoDynPyyjKvK2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YypsUdVhNLAHsJIDNoC3pNAI8wAH+Pw9kEsLtbsRnSDZl3nZIPb
	g5w4XhfYk2l+Zn4kxSo+KCSE4FeR6BfM2DSlOcqsV+RV/YeHnDI8e0Uni05JPBaA7MWRy7FFimZ
	+O8FFgY/6oZMyNCGYsCMNEGQiSwXQLMgVT/8so1O1kvzcFUZDVOlzCedun7s1ap19LaWQldLe2w
	==
X-Gm-Gg: ASbGncsQDSI1CA5y7jZxphPKT6lzs9k7YISdUpncOh0oDraycHSespr2xVJIXQH4nxL
	+L5maoyq2AEJ0H7bkTMf/kDGPNFWztAfG5F0IedD1OS8qBV6qoNsnC106FVOyYqlh9SXKP1cOs0
	GrJFjOTWxev/plZiZsLJLM8n1uaSlreWiTB/WVs60cWHQPworPWQCIfnRo+vG90p5P72kzJwLK/
	L3hDL/fucGiNe+e9oX0aNG5wA5kuODyoFepKkoUcpD6zlLy+nzw5y1pMyyvCyvP/4V1Ha8NBAH4
	C4g1X14fzA6WGmGb0fCJ+ohpcJI6mBwuq10T55Yacx2N2nUGRQNfmgI1IjrWG0Lwuxyst01r8Kn
	czroWI+/jUDbJrmYl8UXZi0heKrVP3/lOeEM=
X-Received: by 2002:a05:600c:4685:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-477c052f04bmr211916865e9.13.1764170539130;
        Wed, 26 Nov 2025 07:22:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6iwCYKK/NcdE6zMIkReMv+h/lFvKdyEafT0SCFE5h9AxXGBDruS3ER0yazrXeIgZN8bzokw==
X-Received: by 2002:a05:600c:4685:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-477c052f04bmr211916565e9.13.1764170538739;
        Wed, 26 Nov 2025 07:22:18 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790adf0a27sm48268535e9.10.2025.11.26.07.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 07:22:18 -0800 (PST)
Message-ID: <2e46a7dc417119bb7e331ff14253b0ff678d697e.camel@redhat.com>
Subject: Re: [PATCH v2 1/2] rv: Convert to use lock guard
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 26 Nov 2025 16:22:17 +0100
In-Reply-To: <20251126095106.7eadaba6@gandalf.local.home>
References: <cover.1763370183.git.namcao@linutronix.de>
		<dbefeb868093c40d4b29fd6b57294a6aa011b719.1763370183.git.namcao@linutronix.de>
		<20251125145736.48c3ed9d@gandalf.local.home>
		<e4838dd91f14024222eef8e705f2b1ae7945bb80.camel@redhat.com>
	 <20251126095106.7eadaba6@gandalf.local.home>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Vix05hwDIUdeJzoV0TZWavH22RxfJOQ2c06XtjGWXKE_1764170539
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-11-26 at 09:51 -0500, Steven Rostedt wrote:
> On Wed, 26 Nov 2025 08:27:42 +0100
> Gabriele Monaco <gmonaco@redhat.com> wrote:
>=20
> > Steve, this is the only remaining change before the merge window, unles=
s you
> > prefer to keep it for the next round, I'm going to send a small pull
> > requests with those two patches alone.
>=20
> Feel free to send the small pull request.
>=20
> Note, it's a US holiday tomorrow and Friday, where I will probably not be
> working. Everything will need to wait until Monday, which means the merge
> window will likely be open.

I can send it quickly since you already had a look at those two patches.
It isn't a big problem you won't have time, though. It can stay for the nex=
t
round.

Thanks,
Gabriele


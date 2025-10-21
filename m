Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C44340A57
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061539; cv=none; b=dDyolQOLOIhOwKWiFOI9K8VcyaviQmF2tqcYnjcD+OA+W6Ry/w2jxO1CCSzwQKlgubfsgfcNCe2c7GSQvBm+gqtnJiLNxjDo4/liDw1hSu40TPMMGtQH2xSaLZjAaYYopreVwi9fcaO/7gWoTDtamxvbAtqYCwEYJNxeowVjV+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061539; c=relaxed/simple;
	bh=kpzpGzaDchyC3g6fReGgH0mCBJ5LX61PxEyAOyWy2tY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LLlH+Fe/QA+v1giFdZq98IqM9F9/SNYG6JGwb7M6XiMC+wh3s79F++IBEuV1EL0mHvoDTl9MLRTXxZBhEKrqB76fYClrIVeWiOUn0CbFlBA9opnyWAesqCRNCDfTqQfVk4FveHpD+6EZgvFpuEC20qkYWv9j05bOSPGs62nU2RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SnGDtgJ1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnGDtgJ1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761061537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kpzpGzaDchyC3g6fReGgH0mCBJ5LX61PxEyAOyWy2tY=;
	b=SnGDtgJ1dK2godRQ9keC/pYQovK5H5IXf0SzhiZWT2vd4SM2wwq7wOvJFmF3omU8xvHxlx
	EsYsn4nk8zKPiRRg2AGb+sfUaJpqbvfi2u6GS5wv7Lp7hGHsrJkZkADpYigDfc1Z5iKRJl
	R1ocbm5K7DHi4KccrCSBqWRilQeq08I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-P87iIR5MNbK6f2jHQNvLSA-1; Tue, 21 Oct 2025 11:45:36 -0400
X-MC-Unique: P87iIR5MNbK6f2jHQNvLSA-1
X-Mimecast-MFC-AGG-ID: P87iIR5MNbK6f2jHQNvLSA_1761061535
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-470fd92ad57so114240465e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761061535; x=1761666335;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kpzpGzaDchyC3g6fReGgH0mCBJ5LX61PxEyAOyWy2tY=;
        b=t6zsLAWq+ChTNO0F4ci5QsLN0CeibKgwh88DL8pYWVRN5bXvPBtn29Ay4rPbrSiKwe
         f5TFWR2wIrHUQyJJyGGB1WpnPoYQhni5XE14ZWvKDwCqK0HGHqwVGgMcGKnpzft4+ovl
         o+xZEzueXMFdF1l31JDhZlHxSgn9rhxdKiaYCngwEbY02OV1HJK109K6FillV1K66y0L
         kdtB+OWjGT+ftg5dEFtTFiQRsQbq6HacLGqNV712RPRzns4XK6MQrqzezMVhC1sjQM+7
         WoTx5Z/2nkCyZFhxD2SUtyID/vNwPIfdRIaR0Uk2UubKCzjO0S7Sp45G4tw7xVb5k/F8
         S0Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWOyZITtQBILs+FWMZH3/gMQ8T3ocCGms3JevYpLjnEOvG7xyBXg7smMq4Gagih32rHGAypw7wPibmqmpfQQ/T0GQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyzCoCV5EcVnMQjqks3uBqsXq8BB4FGO3Yw/Fbgfl9P2pFGj9a
	QBpU2OcqLf4mYaai6OEy4R/fSt9pH/QK6msZhLePfEo5qLnnSfguQ7V1RlREtMu5/mN/8Sh5iro
	wC4WQsPWBab144hg9SJ/1RVYzxIg0mmtC3KWSuKybnl6tVOFOU4XzTnidVIB8IrXQmqoZUfI1Yg
	==
X-Gm-Gg: ASbGncvzmDG/bL9iZBIruUp8xW3zf8bpRpHWAWY6cKFvOgCoO6VllpS1w4noYlbj3g9
	9TggjE+F8iyD+Uvb1BU8asrwCnFqNxLWU12j8EGnXUSquCS0Mxz/8cXuNomeEX2oN9lpn2Zo5M8
	Tq8rKUD38fOQ3rltnzny8F8lPDhaknvL/vLwanhKOW5JP/hSls15pewRKycYd3fkMRpxwQGmhrM
	4OUg0Pwxx/RhVlTTETjLUXqSjzFXsYfXqI/mw1XexOgythlNzmC+KgA/hmWsyxxjQ0q2KHF5Tsw
	OChoWiMOk0g0VuyB3/bngJsaU6zZ7fs+43+FPeShFRuvh/HeIYdVC+DlZXlN+cFISpxdzO/QQ9Q
	OfPFsL1CWAQDrJGJKnzPu823A
X-Received: by 2002:a05:600c:190b:b0:46e:3b1a:20d7 with SMTP id 5b1f17b1804b1-47117903f8bmr135934535e9.19.1761061534758;
        Tue, 21 Oct 2025 08:45:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9Ehm46h/d4SRNrf1wmAqWVrd1RpoVylC+bIY/lKK1Cq73XYCkx2qwEidebhFmSBfgPMwY+g==
X-Received: by 2002:a05:600c:190b:b0:46e:3b1a:20d7 with SMTP id 5b1f17b1804b1-47117903f8bmr135934385e9.19.1761061534419;
        Tue, 21 Oct 2025 08:45:34 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4715257d90bsm202343125e9.2.2025.10.21.08.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 08:45:34 -0700 (PDT)
Message-ID: <0cfa54fd4b095b0298e2cf4ab04a0db2f9b5f08b.camel@redhat.com>
Subject: Re: [PATCH v2 00/20] rv: Add Hybrid Automata monitor type,
 per-object and deadline monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>,
 linux-trace-kernel@vger.kernel.org
Date: Tue, 21 Oct 2025 17:45:32 +0200
In-Reply-To: <87ikg8bguc.fsf@yellow.woof>
References: <20250919140954.104920-1-gmonaco@redhat.com>
	 <87ikg8bguc.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iT6yDXLLEdLUwMqFXEKWr6IPwRPo6Wfih56kf06q1s4_1761061535
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-10-21 at 14:05 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > This RFC contains several related changes, I'm sending them together to
> > give the full picture and get early feedback but I'm probably going to
> > submit some of them separately.
>=20
> I'm done reviewing the series, sorry for taking forever (I have other
> urgent stuffs going on, and this series is not easy to digest).
>=20
> Overall looks decent. Thank you for this work!

Thanks, that was really appreciated! This is quite a fat series to review, =
I am
well aware of that!

Gabriele


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D90255E43
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 06:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787552540; cv=none; b=DiMc3N8duQqiC/8COicyZR9iwxt5WunhY1xZNmh7fYdHS9HpNnYiVJkgmlSrjYv0duVvtpbWrmRDG0zAWZCQEviGWmK2HyDm2zxYKQ/Dtc6/kJVVuusqanrm0NgGrlbDDEI0whgLDA/DtXsHq9QWK972CNFlUwxCPnjz8cjay7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787552540; c=relaxed/simple;
	bh=qcUY9OTujfYD1G7thrLDsVx2wL7XB0pkPW8tVjj6Muk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=npgOMdaMFaaTpXb2+e8s3RlaGkLKjSm8HsvO5X7DwkknpPKz9k8rW2RvvHmpTKGwXzZTnqyfTWjCR3tiWPDBTxaH9zAkxL9Suv256ecn1BZX3MtTSp87m26YJkiRwtbdd/ynRlof9sxvLk+A+By1kIl0VnmG8kXDOkQ7bfscut0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jRshQkdi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jRshQkdi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787552536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qcUY9OTujfYD1G7thrLDsVx2wL7XB0pkPW8tVjj6Muk=;
	b=jRshQkdiwqDDB7ypDxpW20nuBvfR63N/WuPHRk5hGt8Gwtcw2ua/vNG0TqjTC3pAZeviHM
	awt0YE9gyogDkCH0n1Xw6McUUyqhhEshk0IFF69v2hBd0ytdlIy1SH4L9lQPhu/S2FYKr4
	iCpUbwrGdxET5G8OfwogqJNq3bUWmU8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-dX5XmyiaNvKu1zIrghG7UA-1; Mon, 24 Aug 2026 02:22:15 -0400
X-MC-Unique: dX5XmyiaNvKu1zIrghG7UA-1
X-Mimecast-MFC-AGG-ID: dX5XmyiaNvKu1zIrghG7UA_1787552534
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c1686e23b9cso257265366b.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 23 Aug 2026 23:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787552534; x=1788157334;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qcUY9OTujfYD1G7thrLDsVx2wL7XB0pkPW8tVjj6Muk=;
        b=WhBmTyBQNXPETxSmeV+8rMkrBiCn3Z2XN7temyG/NrbrHPHhBAL7Ayu2VK+CgLqDIY
         KSNVppa5F0tmx+9ECA7LyqDX8mw3y+dZMqePaawkJhT1h9ax+nFEc4FmBUuAO0Wg93L+
         xx6kf+SxU+bD+MfRf2wOfWh0Bsor4C90SYnL5oilYkvik1QkelHB0e8WJn83IZvx2jkB
         MeIWf21Jj+XHH+d7WUTQC7Fe2FzrBj09qxacjPSckB4JQiVUNjsO66uumS6uj4DepSkw
         5cHPvbNXxGGxIfDljkTHBcJDILLufRr6h4LfsyB3jITBVNy4EngSPHyzNWslRODKS+kH
         kWog==
X-Forwarded-Encrypted: i=1; AHgh+RpuCLoyYq8Gsi/dkM00sEG6CJox6t+X5bXIR9ldbR1YhLtnWE/i7FLRxrvg7o7juyjgogy7feY+T2vEU602lgB94ME=@vger.kernel.org
X-Gm-Message-State: AFuF++nDGcxyXvy2e5naYXEX/ZpW1VDzXYokaz7LfmcXq4eV5Ov06jdf
	PNv0tyqGm57ThX7GOR3EqET/2w9l5s1Y0JYyeloYakbxEvCAooYbkYf5XqR274TqFawxnW7DAce
	IcEeH9OoEfdRKj7Qq578CUxhgPnFd3hzsEKMHZoo/60loCkZYUHQKhZFH66XCv9QNWyyAVyS6yQ
	==
X-Gm-Gg: AR+sD10G/5iaTzym6rUkH4gd/MLx+LXNA4S1Ei49l8s+Zih20xFEcJ55nZ1P257iD9A
	o0fXm1WdntSJ2zYkrrRwhqDva3ovnaQNe1+nZwveUYOtn38u8urqsFwqBUWo7aKlDbmMEbBry5n
	SI0JJUjWhf7bIlq66k5aei1wONSZshb4OFvrppIBMQFJ4T8DoaW2ihn7NQqS1k/zcpJpTya8JC4
	q65/qTzJ1nIzgTRp5jmQ07MZqIC0+447hgByIaB14sHyY2dJypn1Yid57cI+vgKBboZMYk3+lD1
	fUzbjZIYBx82lpfiQVSwwJ3/85+v52H2rKSfft3DHIRi98ApETjcAhht82qMMJ8TTNZ0U6DbUZ9
	4qKEZdKrQZE69GIeZTaj3z1aIlXkDIvsmUkOv5If0uQZbx2bp/by4Q0lSFcl9sCYl7LNYtw==
X-Received: by 2002:a17:907:c20:b0:c1f:b883:ed3b with SMTP id a640c23a62f3a-c246a2cf2d0mr2746850766b.4.1787552533778;
        Sun, 23 Aug 2026 23:22:13 -0700 (PDT)
X-Received: by 2002:a17:907:c20:b0:c1f:b883:ed3b with SMTP id a640c23a62f3a-c246a2cf2d0mr2746845066b.4.1787552533314;
        Sun, 23 Aug 2026 23:22:13 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24d6f203acsm62451566b.24.2026.08.23.23.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 23:22:12 -0700 (PDT)
Message-ID: <4b90103fee3b9825d09833b0a314995b21776758.camel@redhat.com>
Subject: Re: [PATCH v5 10/17] verification/rvgen: Add selftests for rvgen
 kunit
From: Gabriele Monaco <gmonaco@redhat.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, Thomas
 Weissschuh	 <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Date: Mon, 24 Aug 2026 08:22:11 +0200
In-Reply-To: <aosuwKH5GOEo0xTN@google.com>
References: <20260723074534.43521-1-gmonaco@redhat.com>
	 <20260723074534.43521-11-gmonaco@redhat.com> <aosuwKH5GOEo0xTN@google.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dYMMzzBCmiywL1GkAHMGbmJdXbzTyfX7fT7ZTKUSyqs_1787552534
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-08-24 at 01:32 +0800, Kuan-Wei Chiu wrote:
> I noticed a issue regarding the .bak file introduced in this patch.
>=20
> When running make distclean on the kernel tree, this file gets
> automatically deleted. As a result, git tracks this as a deleted file
> and leaves a dirty working tree, which is a bit annoying during
> development. Would it be possible to use a different extension for this
> golden file, such as .backup or something, to prevent it from being
> swept up by the generic clean rules?

Hi Kuan-Wei,

thanks for reporting, that looks quite annoying indeed, let me send a fix.

Gabriele=20


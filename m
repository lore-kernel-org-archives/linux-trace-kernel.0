Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219AF3D6CD3
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Jun 2026 11:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780571297; cv=none; b=VpZB0vit3DfOEiJbvMaTqYoWdHlzlvK8G0jffcRxTmtEH5Gbo6OA2KkQSATWT2kUtsBX1Yqe1q6xO7sK+6BXvNklRG4LOvLOysuxgIspOc9r0onI3C2+VVwEQwCH/o/cKlsP+L61xoYTa2MRxeY09lVcvfuXu2hdNeVpTzUDd30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780571297; c=relaxed/simple;
	bh=fLPnCQPuTwPcKpVpGvrtjT894JkTeOU/7V+DIVybco0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k124RDN34t2OJRS8QvZd2VeXpI8sZiS0DBVZx4GD8bdKXh7eK6/9PLT29elpxIuZTClCMSt/MXVja2lyqB2T7pXfagXM/Gsse0d0iK6wldeLByNaE1c56VaF2rgE2vK+WBeGVzadvf8Yu9qydLvfYjtCsfwAC8KjexYFuuGXSK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JaGryuj6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JaGryuj6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780571295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fLPnCQPuTwPcKpVpGvrtjT894JkTeOU/7V+DIVybco0=;
	b=JaGryuj66LbFmCpiSxT3pyrao+MScjtc1OxJo5rID7yL2HqOt7+C3zIVq6xV86OjlKEXfF
	tKIWLnh55YI24h4NBMfiXYsChB6fwKCBz9d5Q8ENGiWeU2ulh/GiSLvOhsHTLKelAOv2T9
	xVJF9zMv2s+ymS1XdknFkZZ8iuhzrhk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-2AOZWTuuPQGk_iZi_vyYbw-1; Thu, 04 Jun 2026 07:08:14 -0400
X-MC-Unique: 2AOZWTuuPQGk_iZi_vyYbw-1
X-Mimecast-MFC-AGG-ID: 2AOZWTuuPQGk_iZi_vyYbw_1780571293
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45ef9437b7aso404780f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 04 Jun 2026 04:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780571293; x=1781176093;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8kkXn9BTLdD6FDIZ8v4AArbMY80UOZLqgsOOXo2fDIE=;
        b=IlFDZM4P/G8RxDigPSztwajD/21uXZuKEutnOh4Ff5H2M4QRiejRmGowRgLIdxI/3h
         wkLdVQTa6WxJbzaRoWMBaEs0Tn6hV5EhnWoBabk0zNaHH13RSUXhAMxj6mtpqjuD4RT0
         Scrhyl0KI+CG8ScEXgFKZKipFpYqOTDUpRMxNHwF8g06/JlduJMINPdJ6mouX02QsyvV
         FOiStFPWV4ugFnoFPtgwnW2QBRWDaBD4UTbl4rRtGesFzkWsGMYLjIg640yi1jNH/q2S
         3lSrczj3isaPzlSkm/k64JeXnrrNedMm/Wj5ORH97RXb+NxIK+KW55yDm6RNeGVtBuHt
         IR4A==
X-Forwarded-Encrypted: i=1; AFNElJ/mIfjEBKm9el0qNTyawcFsRJL9IKW+wzUrXr/nu/+j4qfw8zbzYRwZHkYKMIVXvxm4QFjoyY87zAaLGF1vcH7lDv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXPaJlV9trL5bb+rWqd4DLCbtmAgzNJ9yNl0Skhu1sRKWVKvUM
	GK0JklafGejR818OA6Fa4BdmjWCJeKfPIvJUC2Up1QY9GxSzAAkGJicBCPeZMDAIZCP1wWlTmfS
	2NF1LVK1vDspt9qK7wyub2veqJmeuIwPPLL1g7ptnJQtPpio3epEMgbg/Pe2+6AxONu3yTSUX+8
	35yj7uRg==
X-Gm-Gg: Acq92OFw/CZ1a63NV0lcK/D0rAK599AEluDmOc/z4L5cKvwHdvEUdoDnO+Y+IZRdEWt
	+HpFM8B40UycCVUl8EetypRg7h/HDSTp1bnIf7pKw7leLwyrOTsC447yetNYomd4mwcvco6nJZz
	nDIUzrjr2bS7w/Js8fcqO5tygbli6MU6r78M1AtB2VD0htzDLAqbyt0Fo3a+UbU+muX3Tv6UCeG
	d72pQ/9bDWPjoSNyexXHGG9Eh9r55qwMdjxPJ3wPUUmwdQavwSRyIbsicQP33VKSVh+iMF7paiA
	WE9wMd8O7i2ZUrXeMinU0bcx55gnAxOi+UK7IucSitqSb6vPRNQhgycPnjehYDI19XUSd7WNBmL
	6pA/0JZetnRF49+KnhnLXH9I+YTB1PAxP18vG
X-Received: by 2002:a05:6000:4188:b0:43d:6244:f8b with SMTP id ffacd0b85a97d-460217b976emr7618389f8f.13.1780571292834;
        Thu, 04 Jun 2026 04:08:12 -0700 (PDT)
X-Received: by 2002:a05:6000:4188:b0:43d:6244:f8b with SMTP id ffacd0b85a97d-460217b976emr7618354f8f.13.1780571292460;
        Thu, 04 Jun 2026 04:08:12 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35fb24sm16309633f8f.34.2026.06.04.04.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 04:08:12 -0700 (PDT)
Message-ID: <9c5f9e0d9f115024afb8165057874905f7fd6567.camel@redhat.com>
Subject: Re: [PATCH 1/1] tools/rv: ensure monitor name and desc are
 NUL-terminated
From: Gabriele Monaco <gmonaco@redhat.com>
To: unknownbbqrx <dev@unknownbbqr.xyz>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 04 Jun 2026 13:08:10 +0200
In-Reply-To: <dc9ea036-de62-4e1f-be63-8e14d675bcca@smtp-relay.sendinblue.com>
References: <dc9ea036-de62-4e1f-be63-8e14d675bcca@smtp-relay.sendinblue.com>
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: M688YazZ0HsTlG5nrcpMnLoRikQJilGpv5-qG5osOS8_1780571293
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-04-23 at 17:19 +0300, unknownbbqrx wrote:
>=20
> ikm_fill_monitor_definition() copies monitor name and description
> with strncpy(), but does not guarantee NUL termination when source
> strings are equal to or longer than the destination buffers.
>=20
> Clamp copies to sizeof(dst) - 1 and explicitly append '\0' for both
> fields to keep them safe for later string operations.
>=20
> Signed-off-by: unknownbbqrx <dev@unknownbbqr.xyz>

Contributions need to be attributed to real people using official
names. I'm going to re-send this patch with me as author and a
Suggested-by: unknownbbqrx <dev@unknownbbqr.xyz>, unless you answer
with an appropriate attribution (i.e. your real name) [1].

Thanks,
Gabriele

[1] -
https://docs.kernel.org/process/submitting-patches.html#sign-your-work-the-=
developer-s-certificate-of-origin

> ---
> =C2=A0tools/verification/rv/src/in_kernel.c | 7 ++++---
> =C2=A01 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/verification/rv/src/in_kernel.c
> b/tools/verification/rv/src/in_kernel.c
> index 4bb746ea6..d32453824 100644
> --- a/tools/verification/rv/src/in_kernel.c
> +++ b/tools/verification/rv/src/in_kernel.c
> @@ -215,10 +215,11 @@ static int ikm_fill_monitor_definition(char
> *name, struct monitor *ikm, char *co
> =C2=A0=09=09return -1;
> =C2=A0=09}
> =C2=A0
> -=09strncpy(ikm->name, nested_name, MAX_DA_NAME_LEN);
> +=09strncpy(ikm->name, nested_name, sizeof(ikm->name) - 1);
> +=09ikm->name[sizeof(ikm->name) - 1] =3D '\0';
> =C2=A0=09ikm->enabled =3D enabled;
> -=09strncpy(ikm->desc, desc, MAX_DESCRIPTION);
> -
> +=09strncpy(ikm->desc, desc, sizeof(ikm->desc) - 1);
> +=09ikm->desc[sizeof(ikm->desc) - 1] =3D '\0';
> =C2=A0=09free(desc);
> =C2=A0
> =C2=A0=09return 0;


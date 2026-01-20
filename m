Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CCB328B69
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 07:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895492; cv=none; b=DeHQpV122LDyYZzbaj8cIMGwdpXZA9Zy6nIS7j4Qt5D1KRAzma2iUdoQNy53/5+/9gzQsMweCQH1ajLQ5AkYSOIXLlMgwDoQjPoG/HEz304uTmwN5LMSNMEcmKh5IDqLIoOU5SkhhdKNq3vEeuLjdEca2ZaYxENssv3hA1FwPKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895492; c=relaxed/simple;
	bh=f4V08HQVokgA9xFD0oqKvstbP2a1PHXdtABRTaBZiRY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EgAK2hBze+KWIc0o1zROYVLKdgdyTb/Y3qby/nid4qJJMno/O2MDa+eKRrl1ehc+bhAW6nXTOH0QIdzpJkVXCjCMm0IH/spO88Ceoxj23ZHRPTK274/nHCkTbl86qjJ33JvA6y0/7D/LPzozfYQ9vWAK6hlTp/9+IRkGvqnWugc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XbwrQ69G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XbwrQ69G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768895489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=f4V08HQVokgA9xFD0oqKvstbP2a1PHXdtABRTaBZiRY=;
	b=XbwrQ69Gjv90KSido3T2M95UsUG7aER00yHzJprgjiINrRyLbac3LEfZ+Uy2izI1rUxmaE
	AOvImtDGK/wJyIlDXc+SXWygXHNu6+qEerqNDJquYtN1IZar1gWCVdnH8jjsaka1NLDZfg
	ketA7pFNv5vD22/y5M0i9jmSK5d6BQM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-Ubssi8EoMc21sFIu04OJDQ-1; Tue, 20 Jan 2026 02:51:28 -0500
X-MC-Unique: Ubssi8EoMc21sFIu04OJDQ-1
X-Mimecast-MFC-AGG-ID: Ubssi8EoMc21sFIu04OJDQ_1768895487
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47ee8808ffbso38207175e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 23:51:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768895487; x=1769500287;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f4V08HQVokgA9xFD0oqKvstbP2a1PHXdtABRTaBZiRY=;
        b=YXP0cZafPPlObIPf730IlwUaUZira9aaKLyhsED+/8Bo7zWBKyTkokFdpmHqk7OaY2
         m7NbijvR3srk8f99DOTqxcJUe/o7Gy8PwHJTJpgo4AhrbNF3stmf7m5R4+2rIdySAWL2
         Fy+oMyO/Xa1Cn/EmpK55+8L/YN+RCCQ/O08X5/LiYctxLaKweGXFj0or39ZdK5UrG+VE
         X2mFl/A1JF8IbHI3eG3ZYdOwxeaMc38Ob0RtLNaiEhvSopaP/iQElOJTl4lYumi2xYqa
         Vir4BXpVWU7+oKf5oYSTiYdPgX2zHuyeopyvyuY3KNiJZ0n/6Pr0GwYo3EgIx8/lwz9K
         ha2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2wpW8sYJy647NHrfwZFvWLAAK9Phhwa2cDV9KG1itDlqp8SfKsJ9V9OcARigZ4a6x8YajanMZkV7HXWojwBedSvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOli0YkxtYtwcPMn94+poIzeUifoU1zyuhVaw8FwLPuOvkoiw4
	zC4DfrinXlNIrA7WhHpseeUC74H8moYvUYCb+F9/OqgaXqAY5J73F5fFHsc29kMG0sYKkRSe3+c
	6EdjDn8DqJ3E++LvnoSyCJ34KxyTJl7lCl65TxXXVkUv9pG2XvpVQW/EHqpmSpMLwNIttumGycQ
	==
X-Gm-Gg: AY/fxX6vUNTkSCF1LbIU5EHvAobi303Yt8oWJdR0zh66XM3hkcE8ypOF5deBma++auz
	qHZw8lKBMLp0G6ivJSFNndUlDN9sCPBgpwgJ/2qyVuSAuLsuxxoKxDzew52YCvVxO0dxaVykb9t
	okMNOQi49cclfIlzFqciTl6Zu2HKIYRYZNCXOpW24ZtYe1jmiyFPgO9i6he+tmaIUKXq+xxtO/D
	SBFhdncKNF9mtGGoveCKiodt/wItXKaURr7uAASCW0SVOHga5TD5DaOWRLzWsYqyDAE09cMoBWs
	Q3aWTfeHnoRDDlmDKmN0875cm/RIt6Se5O4Zr4eO82cQ4yyJkYDpkiG8hYz9j+aNq10deqPtWAw
	Qb7rG44eM40Dm6kD6060yVRV3MW9+njyM+LRWOCBu3MDwOa4y2joDMXbOhcc5iPshnIzfHgHp+i
	bt4Ms/dF3+
X-Received: by 2002:a05:600c:35c2:b0:480:3b26:82cc with SMTP id 5b1f17b1804b1-4803b2683c0mr47852805e9.18.1768895487160;
        Mon, 19 Jan 2026 23:51:27 -0800 (PST)
X-Received: by 2002:a05:600c:35c2:b0:480:3b26:82cc with SMTP id 5b1f17b1804b1-4803b2683c0mr47852605e9.18.1768895486815;
        Mon, 19 Jan 2026 23:51:26 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435699271dfsm27149313f8f.15.2026.01.19.23.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 23:51:26 -0800 (PST)
Message-ID: <3f4c9c640ba1b64c6a6adab779c5fd05a0189972.camel@redhat.com>
Subject: Re: [PATCH 11/26] rv/rvgen: fix typo in generator module docstring
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
 open list <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION
 (RV)"	 <linux-trace-kernel@vger.kernel.org>
Date: Tue, 20 Jan 2026 08:51:25 +0100
In-Reply-To: <20260119205601.105821-12-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
	 <20260119205601.105821-12-wander@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 30BBkV7lFB4cahaV7QWCJu8b-lh20r0xT7nWKq5K6Z4_1768895487
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-01-19 at 17:45 -0300, Wander Lairson Costa wrote:
> Fix typo in the module docstring: "Abtract" should be "Abstract".
>=20
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> ---
> =C2=A0tools/verification/rvgen/rvgen/generator.py | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/verification/rvgen/rvgen/generator.py
> b/tools/verification/rvgen/rvgen/generator.py
> index fc9be5f6aaa1f..ea1fa0f5d818d 100644
> --- a/tools/verification/rvgen/rvgen/generator.py
> +++ b/tools/verification/rvgen/rvgen/generator.py
> @@ -3,7 +3,7 @@
> =C2=A0#
> =C2=A0# Copyright (C) 2019-2022 Red Hat, Inc. Daniel Bristot de Oliveira
> <bristot@kernel.org>
> =C2=A0#
> -# Abtract class for generating kernel runtime verification monitors from
> specification file
> +# Abstract class for generating kernel runtime verification monitors fro=
m
> specification file
> =C2=A0
> =C2=A0import platform
> =C2=A0import os

I believe you can fix typos together in the same patch (i.e. merge 10/26 an=
d
11/26).

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

to both.

Thanks,
Gabriele


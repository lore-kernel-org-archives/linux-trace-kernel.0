Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEB3246BD8
	for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760364861; cv=none; b=nLZH2MdCqTbFVA0wksf4ofyr4017jE8V2htN0CNqWtsSv+AvfTwpPEa/LhgOVEdfL5rVkbgaQgV6IwWrZwaqDoMY99WHlwCQ6j7yJWW1YT0h5P3izJ5ASP9QxCSgGIcC955W9mX32NAz0PlN8bXi2FrxcpbP9okztzxsF3jg0IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760364861; c=relaxed/simple;
	bh=+LRmnraze8UDOeYVprNNNeH/pLRixbzyDjuRBKZ/5Ak=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4qX3dAzElH9Lx35Yy48wxGxVQokJUKchSNkD792UoKtyPADhPP47gg1dc0EELapRvcyEy0T21kNNjPkj13JSedR2zHPHg0fLArco9BzyBMG1Cgm7IUkrLjoy6m/gNQPxKRRVVLBN7vyon6YdzSwFN7E8nY0SsEtVpYkqXjKseY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WTUA8r5v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTUA8r5v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760364858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+LRmnraze8UDOeYVprNNNeH/pLRixbzyDjuRBKZ/5Ak=;
	b=WTUA8r5vDV72cBmaB/iudSUmlCfrVm+2h/5nAR7kcRaEy/IjyfPFKv5oY7B9UfVK4joffN
	kB4elTBRYJt+Fyk83ZEq3byFasgZbTlDBvNvoyS1Pgl/ghXSkbN4hv8IJJ8VvnhP2gDzXg
	/uRDBWhe4fa2IFY/jco/aBP6AQDOsus=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-tDq6AXqpPmiBAg7YhE4a-g-1; Mon, 13 Oct 2025 10:14:17 -0400
X-MC-Unique: tDq6AXqpPmiBAg7YhE4a-g-1
X-Mimecast-MFC-AGG-ID: tDq6AXqpPmiBAg7YhE4a-g_1760364856
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e4d34ff05so23381895e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:14:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760364856; x=1760969656;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=avtB/MLVqaqYb6cJjOOoguTOP3UV8Btzs9wLIrHJUWA=;
        b=l9urtmP9q2X7uPyMLUwHIpE24ZCY60sv46P2flK5zGjLc0bSK92cu8ugjEgTOB6ENq
         c8zLFiZF/1tOsIAOhpVP4mS70XIreTKUibTMYDvXaxko3iKW1qgdxHGhkDZZ+La6TKaW
         wJz/gRXy1utA948+rsI7OWoAwdykd/hd6HIbjk/UCzOoF7K9Nfc2zAl086+Hs5s7Xkji
         /QW27tazKBfrgfOHfcDW3qBvevrcDMYoouILYNC1qEt4pKkiHDN0Cwsbn9VngzK5C1EC
         Vh/wLs815U0jyeZvsPZ8H6ufDv7VKMNiIzv+dUFIDQu3NrepImPVHGbLyiMZvseVwBdV
         dY/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAEyiMhweegko3tbHiBGqpGKDTwuOZCe1n/UTuRlRzPK8Vpla0n2fmVLSAa5o+Dmh0w8MiEHDBQKxp/4aULX1gFeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMQJP0qjf0iC7h9cysu3egGOvWXqOzXL/Z7TDbYlGD/jaAeh3Y
	ddxnOdMElyjLX4nIsUZK4md44K7lGB1EOxqmf2wC1yHS4DURFo3DOxjnjJWdC6n+hZAMn93Z7L5
	NppHf/tipqnNkgnsQsymEx1FGciEdCkVB7z6oxrYaYTLZttIpY1GjUNSUSQ9z+i4WzYfOmdtEog
	==
X-Gm-Gg: ASbGncsQ5YRicylG5Qm8ACDaN94B8jkH2dr8kNP9i+nrbdYPQxj1D6fZoagzbUgVz3J
	/IzenoPzJM7DcCLO0s/f/NK08/tLHUD2cmfDuZT0Q4vv4oBFR1RVbrSZvKhciJF5Qvo0v7utrmL
	eOaNX7vNVLfoq6p58RslT1jg3SPlodNn+SvmPmC/SwwJgP2TY9EyhSosLhEwoyZ9U41+7eHpdKU
	vAbOrqBOqqy58OLaRji/fqV23wyX3azC0kspXKXANmWJXebTuZdQZrX9sEqgLUb7IoaAqJRiOQH
	S6J3/Pk+Xu0aOzJguloJLy2su3A0dVtp+OHFqM8qhLFbQMSi1wMttnDrBJCHDOMX0A==
X-Received: by 2002:a05:600c:628e:b0:46e:38f7:625f with SMTP id 5b1f17b1804b1-46fa9aa2123mr128366615e9.10.1760364856215;
        Mon, 13 Oct 2025 07:14:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHETg7OzrKPGssdxOk4Xay7k9qUcbXQBRsqtLsD0xpqB63fcoVeQyDZ4FRhiiS3UOs6njcyA==
X-Received: by 2002:a05:600c:628e:b0:46e:38f7:625f with SMTP id 5b1f17b1804b1-46fa9aa2123mr128366395e9.10.1760364855797;
        Mon, 13 Oct 2025 07:14:15 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3d2d65sm126639365e9.2.2025.10.13.07.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:14:15 -0700 (PDT)
Message-ID: <db32cd9db7168a28e6d16d16b3bbe905a6c2c9f9.camel@redhat.com>
Subject: Re: [PATCH v2 15/20] rv: Convert the opid monitor to a hybrid
 automaton
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>, Masami
 Hiramatsu	 <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Mon, 13 Oct 2025 16:14:13 +0200
In-Reply-To: <87cy6uygn9.fsf@yellow.woof>
References: <20250919140954.104920-1-gmonaco@redhat.com>
	 <20250919140954.104920-16-gmonaco@redhat.com> <87cy6uygn9.fsf@yellow.woof>
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
X-Mimecast-MFC-PROC-ID: VriPPjYUz1YVGWr6lns6ebOIm4Doq4u89Fwy_sjl_Dc_1760364856
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-10-10 at 16:29 +0200, Nam Cao wrote:
> > +=09=09 * If CONFIG_PREEMPTION is enabled, then the tracepoint
> > itself disables
> > +=09=09 * preemption (adding one to the preempt_count). Since we
> > are
> > +=09=09 * interested in the preempt_count at the time the
> > tracepoint was
> > +=09=09 * hit, we consider 1 as still enabled.
> > +=09=09 */
> > +=09=09if (IS_ENABLED(CONFIG_PREEMPTION))
> > +=09=09=09return (preempt_count() & PREEMPT_MASK) > 1;
>=20
> FYI, there is plan to keep preemption enabled during tracepoint
> handling. So keep that in mind when this monitor breaks.

Right, I've heard of it, thanks for the heads up. I'll adapt the monitors o=
nce
that happens.

Thanks,
Gabriele


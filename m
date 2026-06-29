Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD1A3A6B61
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 06:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782715915; cv=none; b=bZHjtdYfiZfOKSWwOcjt6pCrkc10o3mcTF+beMm7ZwttlJjXSx2Gq0hHowyGpo4XwH3jo78WD6l0boB6zA+NyDRsTK/RGRNuoh57iOjYG6A/n5NNQieqPPVVgRfQ4aCM/HGRBjnlup9556ac9XUwlDK+fpzX7cysVMNLO0EEkho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782715915; c=relaxed/simple;
	bh=ALkXro3TmNNCZbVZHgx9H3ghIJWe+sMD5X1yGx7fpPk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ctpAohRel191MPhaukFkKga/ad3hnkk+F35yulVPggrUFKukd2yw7fJXLzNzn9jpufjtetU3YmO2WBORwSl8g0MY6nIpqtNBzMkImJslnjE0Fc1pNgrMrNTtZqLNfHHz1ZNmd+xgkxSqnlhqCQTO7UDlconnoZlkQ3NbpS8yiOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ERTRrWoJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ERTRrWoJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782715913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ji0V4ni4RmhJJUHRPG50Xaton3kWCxzApZBwJGJW1x8=;
	b=ERTRrWoJJ6xUE5HQ5OxZTByf2rx2PsaKm+MTJr5m7+OlrTL6LOGsuSBuFGVqse2/ME8VjQ
	1UwFQ8YzYXvxTs51WWJI7Ryiq45XYkahCzCj2y93pCd4vCycPp4DvJkYHKGHrPNx1Ubk05
	5/jlqD/a7Hej3c0ZP2Q5v1uM9vXaJ6k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-miCDH-U2McWggtNzM1yz6g-1; Mon, 29 Jun 2026 02:51:51 -0400
X-MC-Unique: miCDH-U2McWggtNzM1yz6g-1
X-Mimecast-MFC-AGG-ID: miCDH-U2McWggtNzM1yz6g_1782715910
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45f3d008865so2262827f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 28 Jun 2026 23:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782715910; x=1783320710;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4VpgbX77g0zAh4zD5ha9J/8JOvu7Er6pEgstXO5xH7M=;
        b=H29oD2fg0UFNen1+zWgDJA30CJGFMDUUeSw/6SdbLP+PVFk1EdMinfDahnMjVofjCb
         lWu3pEyGNpve9XVbmYFCfT1grV+vyB+uKDq/8vpgNm+sWb0SU4U19+bpMc2UOxk/0pWv
         GRqIE4y5Iyaf11h+R6tNS4G3vaBe4xBlT1WxGUs60KmhvghjKdb87Y/mpjUck3XnY1MK
         yXjn3WT2+OurWqO6bv6kR1ZDruMVwQKnf2B5SRpiJ/9bsh7AJf9aY/vw2b7EmwyTp27L
         4U6gh9NlNpLjlccdlKjTMApA3CwjcCTus/z4dKi5frUfuuRSM4GQU1J3AvyuVIlpSjjH
         2ITw==
X-Forwarded-Encrypted: i=1; AHgh+Rppc1wGRSYuzuYy+fDpMP6FXPqVnPofvJp2ZUAhWFsxy7KVTYLUUx3Z0o5MfY6Eqd5yIH8uMp1m5RLjIDi5h+oJPL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4r6mMC2nxUJXYAxdANPCyN1z4cZOKgpvwfvoo6nImHidCIIJb
	1Aw2wfS0e+HYotgtQzIf9Qyi6HnwwG/b4bPl1NPTJJb5/5VSInF4WBOcrdAvN9ntjQvvzxzFybM
	3Jfrjt3SyxSLh8JUJhH6oa+b5RSPNqh6GflL6dO09iM/I5ZaEnXEL5PmqR9HbKba5WTbiaGe5zA
	==
X-Gm-Gg: AfdE7cmTf9oCTEjv7lpO4xHumanSA4wIdh9F1R7g/bdby8AwjVJcXam3rdTXFocXy2n
	xd5nZpFedHlz5G/oN2GE5Gj2wH/eRqZ2OE10zBVwK8ftusDD8An02Q6k/rT5WMKRKORohwMQu22
	p0/bGa+wJUQeJLVmo/2BIPbJTEJgGWw3mkV+yFm/apQfub+g73AIPAJ/MHCMPQjhMKM1p1VJCRH
	1g+9NwH/AI3nBhnIs9N5t4R6GQKZaFpdKx4D8OCSHRgk+woz4qDmGsIybvnElnLt3FILz7iqDY/
	vSKcKoyyRr3oze2yBRF26sTMsuOZykzsAcVK34p62k9bCXD60uY1bMMpSdOCUg8XEcrxjJjmPV4
	e3fvrp21SpEJpS5fHKL4gbFeXv4L/kbN3VB+vIDODhiZDfixFm1NQJ1fcoMvrPPczY6uQ8ye/po
	FDbuAp
X-Received: by 2002:a05:6000:4022:b0:473:1e79:87e6 with SMTP id ffacd0b85a97d-4731e798941mr4899974f8f.3.1782715910493;
        Sun, 28 Jun 2026 23:51:50 -0700 (PDT)
X-Received: by 2002:a05:6000:4022:b0:473:1e79:87e6 with SMTP id ffacd0b85a97d-4731e798941mr4899948f8f.3.1782715910079;
        Sun, 28 Jun 2026 23:51:50 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-473dddcb295sm6521011f8f.35.2026.06.28.23.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 23:51:49 -0700 (PDT)
Message-ID: <01b025c43dda6efe97646162e61002fdf5fff0e3.camel@redhat.com>
Subject: Re: [PATCH v3 04/17] tools/rv: Add selftests
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wen Yang <wen.yang@linux.dev>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
 Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Mon, 29 Jun 2026 08:51:46 +0200
In-Reply-To: <0c230c01-77c8-4c9e-9f49-ecb9555402cf@linux.dev>
References: <20260625121440.116317-1-gmonaco@redhat.com>
	 <20260625121440.116317-5-gmonaco@redhat.com>
	 <0c230c01-77c8-4c9e-9f49-ecb9555402cf@linux.dev>
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
X-Mimecast-MFC-PROC-ID: NX1Fqx3rE0Pl2k6rYyvpVMun2LpS6Qn82QnKOxP4JoE_1782715910
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please cut down the context a bit more next time, it makes it much
easier to find your review.

On Mon, 2026-06-29 at 01:10 +0800, Wen Yang wrote:
> On 6/25/26 20:14, Gabriele Monaco wrote:
> > +=09eval "$TIMEOUT" "$command" &> check_output.$$ &
> > +=09bgpid=3D$!
> > +=09pid=3D$(pgrep -f "${command%%[|;&>]*}" | tail -n1)
>=20
> The pgrep runs may immediately after the background fork, before the=20
> child process has had time to exec.

Yeah I'm aware of this but kind of ignored it for now and never seen it
making troubles in practice..

I could add some delay waiting for the task like:

  while [ -z "$pid" ]; do
    sleep .5
    pid=3D$(pgrep -f "${command%%[|;&>]*}" | tail -n1)
  done

With probably a maximum of some N retrials in case the task never
started or we messed up the pattern.
That may still race in case the command exits before we pgrep it, but in
practice that shouldn't be a problem in our tests.

Any better idea? We cannot really rely on the shell's $! because command
is using a combination of eval+timer and we'd get the wrong pid.

Thanks,
Gabriele


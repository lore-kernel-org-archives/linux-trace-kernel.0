Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3136626C3BD
	for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Sep 2026 07:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789458363; cv=none; b=ClAdG2aVLfS/hF7z9LX9uABpoZjVZmyy7TGz8CWlEcY7+8XAbHZ3JTQtLnRhIoJfLboPu7AT0L1RAvvfQgUo4UD4v4ZiSiiXmOxhto7eOPo0Eg3Jg+UNcHwezR+ezYvZMVV5QzEMTYQHRCemYT9gfTBbACEQ0OysRbqSDe51XnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789458363; c=relaxed/simple;
	bh=r48XyPK+rU8UpoBEgb2X75ahQ0jEesJBX8NaowC0op0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CVS60X1gZPQwGBWiwk8tXPFDZ81tz9gs5yBdm4m4+Ls0adFFfxRDZVqNSRFKrYqXrVv5INPkZvoD9HFLlpe0PxEMiCdSd57aVEIj5iyzms1dS8hD8jIXkj/QIHm2091z2dnhzt5gaBtdFcIVk+jK2l5SvyyC+836GERWH+YiYQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DyPCv/++; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DyPCv/++"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789458361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=r48XyPK+rU8UpoBEgb2X75ahQ0jEesJBX8NaowC0op0=;
	b=DyPCv/++/Nppo60nBXzHnhCm6dCPUI1edyp5WT0aEUA57tSOydVVb+XS0mXWHbU8wxUVSR
	q6OHuyIyWob2eaTDXmZuJKMcKrlqOhRuhxhUPgudcMLxfK9tIDBr0QOMqtdiausGK4NBdl
	/y/zyaB8dRgoPsgPFpwL68HMuePLSBU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-9EkM-qJjPhakDRkBN7Ovqw-1; Tue, 15 Sep 2026 03:45:59 -0400
X-MC-Unique: 9EkM-qJjPhakDRkBN7Ovqw-1
X-Mimecast-MFC-AGG-ID: 9EkM-qJjPhakDRkBN7Ovqw_1789458359
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49e6862e924so24855435e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Sep 2026 00:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789458359; x=1790063159;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HHzMD2AylVtdJpnUMRpnfNdvO19MdlSmTAiLFrp1k5s=;
        b=s+hbSE4uhZZdMUnk9bly6R1vMRmEArRHB+LuQPh2u6njyHM1D6IH9M7asE+Z3p6qe7
         NoD+x4KKs2bMe2argeCwd1Sm4Ui+yuF9/2I+z+GLa5qrgOYzNHkiUGMx6rzTEaTwLYaz
         KPSGcQjl7NIxfBxkkfQyeTVe/QeoeM6H84ATXY2T401ifQVlOEESXSdOWIBTdbpwgKOn
         QiNDHGIPeFYbDrLN2Rc6dDFflmSHcCKz8KFq0v6jDJNV0gXLIqZZiamePSKYeMERUqWG
         L1/5+cWObdkVJK5nulx/WetpqiadMKz/KYVn9j9g3/VGuieHR34kNwUvCWvKVeRWPgk5
         Q2Vw==
X-Forwarded-Encrypted: i=1; AKwUvBxoXUSMJlWDz59HYnlkz7B4aaiSAA+lIbv4lIoxNCb+RmjmlRX+JdJbogNyziXpgww5b6UlExOdpuuESFn3Cnf7mzY=@vger.kernel.org
X-Gm-Message-State: AFuF++kosPsM4aks6haOPJvUlrwPXbQQcZNdMnhAGnfp7JBKEvUsY1Oe
	1KIhBIIR+a5FiZRF24JJyGrZ8hApt+Y1ru6B+jej26AHrf0fwurckNDtWWZrmewTeKyOyNCWHW+
	d3NaF1PCQ49u7CZRtC4s4kyWcG1idQPjS4sW1/l0mGSS/JEsoxCvZwfTQDo/ogjxhSJwKFjLu3Q
	==
X-Gm-Gg: AYBFou2fOtixWzpghmdsSq8pC5QuR81RGe7TTqfwRC40Y+cnFWcAbwK9CzronhbYHcB
	mOz1w/APL/3+3qn+4oXviTA0uKg1ifMnvZ5RLtRH+PB2h/nNJT8ehSuePloHItOOlOh99pBIvZv
	IPEJBl+YPwzxQj/+S9NSXGIKOGczR8Tyh+Kz1FexuW1Y0MMXRAp7BQ3TnumOPq7kRAY1RY9nJKT
	6KOCKqdIznBbbN15tRtTWG/LsvXQmu202+VDhi/ZLBjqCh9gCHqivsgUPCUcVFchBP8F9o8P0v8
	ogho9G6S0GDjM9/05djaaWHeZXDDpUcHyRzX8mjkcYHonWvFwNhjO2CwImdNrychAo4ndh9/ZG2
	MrdeZPYgA24KhrHzcA1m6WSAKIBVHvw==
X-Received: by 2002:a05:600c:5487:b0:49d:15b9:2a2a with SMTP id 5b1f17b1804b1-49e82244b0emr463175e9.10.1789458358732;
        Tue, 15 Sep 2026 00:45:58 -0700 (PDT)
X-Received: by 2002:a05:600c:5487:b0:49d:15b9:2a2a with SMTP id 5b1f17b1804b1-49e82244b0emr462895e9.10.1789458358358;
        Tue, 15 Sep 2026 00:45:58 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.135.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d6b4ee3sm59231025e9.12.2026.09.15.00.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 00:45:56 -0700 (PDT)
Message-ID: <542f1065c1daf5167f77e160de90e9a04eb20159.camel@redhat.com>
Subject: Re: [PATCH v5 3/5] rv/reactors: export rv_register_reactor() and
 rv_unregister_reactor()
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wen Yang <wen.yang@linux.dev>
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 15 Sep 2026 09:45:55 +0200
In-Reply-To: <2c408ff5-9a13-438e-9068-21b3f1516fbd@linux.dev>
References: <cover.1788705281.git.wen.yang@linux.dev>
	 <7c931773dacd7c3da35a22629c3d7dc286b5a0fe.1788705281.git.wen.yang@linux.dev>
	 <b5ec9da630968a5f801623c8d6e2aaeb0bb509d8.camel@redhat.com>
	 <2c408ff5-9a13-438e-9068-21b3f1516fbd@linux.dev>
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
X-Mimecast-MFC-PROC-ID: 5B8XpU1oMroXgcfNBtX_CyyoNAUKGHKqoDR0-Sz2Orw_1789458359
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-09-14 at 00:33 +0800, Wen Yang wrote:
> Thanks for the review, Gabriele, I agree with your points and will=20
> follow them.
>=20
> Just to clarify the background : the struct module * field and the=20
> try_module_get()/module_put() logic were added to address the point=20
> raised by sashiko. After this change sashiko no longer complains about it=
.

Yeah I imagined it, sashiko has a point, whatever is EXPORTed can be used b=
y
modules, so it may imply modules are supported.
What sashiko ignores is maintainability requirements.
A human is reviewing anyone trying to use reactors as modules, and adding t=
hat
change without properly advertising it may do more harm than good.

> The module-based reactor support, together with its kselftest, will be=20
> send as a separate series in a few days.

Sounds good, so I can review and test it as it deserves.

> As a side note, we are looking into using the rv framework for=20
> functional safety in autonomous driving.=C2=A0 Depending on how internal=
=20
> validation progress, there will likely be further changes to the rv=20
> subsystem in the near future. I'll be glad to discuss them as they come.

Nice, thanks for sharing, I had a few conversations about RV in functional
safety domains over the past weeks, I now better understand the challenges.
It'd be very interesting to discuss your requirements too.

Thanks,
Gabriele


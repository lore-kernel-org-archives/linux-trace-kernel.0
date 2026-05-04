Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8C1348453
	for <linux-trace-kernel@vger.kernel.org>; Mon,  4 May 2026 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884604; cv=none; b=A2CLm4o7CcZar/7ZoQr4Udrjmz2cLQa11AS0JLH8uGidH9eKUdYGuyqrk3Ia17uqgt8SD+Ppo4DoXf6wQfJVA/BGjhpb5mvmAf5eyU1J9KDZHZ6X/SG/TQenw1fsAs5EFIiUbxAR8mY7iLgZcVssoTGfFw7dalD2U/GC2bBHRE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884604; c=relaxed/simple;
	bh=CJ3K3N4tQqLee938aGtoxUVu9FgWpp9tTJ22A/NKhkU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=htwiZjOADUkfctFKChaWeZtfWSdPv9iItrAgB0WnhwsBWRhRzDIFdEl3j/MMkRTBALpCRNdeiY1E2Acgf/jufBre+mT2CiFuoydt1WsVT9AaF1Flzl9hY2ede1eevlIX6JDavm8/kqyGvcpBbsbuAMFI1S79N5EIJphThVm6xA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EIWNcyt8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EIWNcyt8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777884602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CJ3K3N4tQqLee938aGtoxUVu9FgWpp9tTJ22A/NKhkU=;
	b=EIWNcyt8SmztxiobRaVGMYp2SBfiSkgZhuKZa4Q73ebZvbTBK8G/7Tqg42GUZQQcNAKzRP
	Z3VO5KiN5TzbkgSW7Z2PyavkH/RBrfcne3buMqqeyCuOal+X4ErXCzxKL8Ll2/qTSLmA4R
	I51gE7mukfrGMxkrzVpFwg8v//lE4qY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-qEsCwI8TO_GzsSLRPglhDQ-1; Mon, 04 May 2026 04:50:01 -0400
X-MC-Unique: qEsCwI8TO_GzsSLRPglhDQ-1
X-Mimecast-MFC-AGG-ID: qEsCwI8TO_GzsSLRPglhDQ_1777884600
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48d0889c1ecso5269945e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 04 May 2026 01:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777884600; x=1778489400;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJ3K3N4tQqLee938aGtoxUVu9FgWpp9tTJ22A/NKhkU=;
        b=srpOHkg67DCSZVG0R2iwChgyuGmktwkPZoxyNQH5b483f02ilcsYT2DXAcT2MFuhj7
         Ka60wCGw8BimQK4pSV0crYKtGXJ/G9EdOhVqpt2rE80YpGurc1N+ef58ZLk3hvsLGZ6k
         OemWXRR6sLjw1qZWVqKeF0ujKpIAJ38mgtwHYmpguFt6BOlpDTB/AhC3RopI1vDVi1ov
         oyzoaa97PMPzIt91s8NOWO46BoeSHst/2Srj5A9P+LEL0dYXTSAhWC3XmmKoFhmtycEu
         aa8/R9YT82+idwj/3STdxkRRcXw3PtBY1vjhYDbDRoFCoLXQsYtdqlZDLdqnMX/IDeiK
         44sw==
X-Forwarded-Encrypted: i=1; AFNElJ+GnRP2L4bg1/bTzQD1dtFUY/bXqtCqfcV1/eB+jvWR+d9oJZpIaMtP5JleYsffR0lBTiLqEB2vPAO1lkm2ZlFCL2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLnwZ2jhUviyGLuuI2I2CntrSg0+QeLBuJybBHgbypDjlNDfkT
	26bfwrKS1lGUPTdE0fP+ImFUrF0YiZXvPMGT2QAJb6KzV41LzKHl2Z0VrX9/CbbJ60Iz0B2aWaJ
	La3GE5p0NmCQAbRimcXO2LevTNfwiWmqJx7kLWI5BLeRkrmfvycenjSPDw5SklLxKHjkTecvZsw
	==
X-Gm-Gg: AeBDievEL5PuqY63ZIEjS1RaaAbXTDSa5Z7OE+kR6kQCOxmHyNJBvXvRZ12h7uyRbgK
	szqgIH/SQzFTNWHlplZOjzaqYieVCZSZ/PDIRazKzgIvNY+FZ1JMaohU5Uj7O7bR6w4rA8JAjz/
	sjB+myWVsh9mKX1n5t3KcMtb/DJuLoJVHwRsdwIYgLbopxc6KXua0/CxCZV0GssMUvCFWu2QTW7
	LxSgWmGVmpcfF30SIKKz7wI9E7IRAN0bPVcD49fgN3GIRJ2t3GXuKxmKCvU28JpZ2oMAhjTnS9+
	a3qyV2nh4qlwXA6zVAA7UvNY3Pkton8fFh20oyeYpXI88lwFrXYbhZXp5sx/h8v7E7zrQtX8BZ0
	bpdW8HGQsygFPBChsyI4Gfn8zjK4ARjxkejVdtr5oMGPM4+WHVgnsXXsLtlNdatIRdwi7qlDdwx
	eluYxHzzrrwQvDjrLBZBe5U1NqSw==
X-Received: by 2002:a05:600c:628c:b0:489:1ba8:5bf0 with SMTP id 5b1f17b1804b1-48a988be16emr153041125e9.21.1777884600024;
        Mon, 04 May 2026 01:50:00 -0700 (PDT)
X-Received: by 2002:a05:600c:628c:b0:489:1ba8:5bf0 with SMTP id 5b1f17b1804b1-48a988be16emr153040425e9.21.1777884599400;
        Mon, 04 May 2026 01:49:59 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb6ffb7sm262523395e9.5.2026.05.04.01.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 01:49:58 -0700 (PDT)
Message-ID: <b12301e81688e1795e0f73adcc33a9e6dca9435e.camel@redhat.com>
Subject: Re: [RFC PATCH 07/12] verification/rvgen: Add golden and spec
 folders for tests
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Thomas Weissschuh
	 <thomas.weissschuh@linutronix.de>, Tomas Glozar <tglozar@redhat.com>, John
 Kacur <jkacur@redhat.com>, Wen Yang <wen.yang@linux.dev>
Date: Mon, 04 May 2026 10:49:56 +0200
In-Reply-To: <8734071s43.fsf@yellow.woof>
References: <20260427151134.192971-1-gmonaco@redhat.com>
	 <20260427151134.192971-8-gmonaco@redhat.com> <878q9z1up7.fsf@yellow.woof>
	 <ffb994110f4ec8165aa5a3e7cd83a57beeb609f9.camel@redhat.com>
	 <8734071s43.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aj-hF8kGdMqg9-cck8XuCB99Jgdq3-IpNXAYLVCromU_1777884600
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-05-04 at 10:44 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > Do you have any other reason to prefer "state_d" in your example?
>=20
> Because "state_d" is what my dot renderer displays, not "state_c".
>=20

Right, in that case it gets more confusing..

Then I see no reason to allow a different label, let's just count it as err=
or.

> > Either way we are opening for confusion (like in your example), so if y=
ou
> > believe throwing an error makes the grammar simpler, we could also go d=
own
> > that path.
>=20
> I can simply add a check that the node's name matches the label.

Yeah, that'd do, keeping in mind the label after a \n can be different (HA
invariants). The invariant parsing should then make sure nothing else appea=
rs
after the \n .

Thanks,
Gabriele

>=20
> > In any case, I would make the label definition mandatory. So my current
> > sample
> > model is wrong.
>=20
> Cool, so no work for me then.
>=20
> Nam


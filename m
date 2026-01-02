Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BC221B9C0
	for <linux-trace-kernel@vger.kernel.org>; Fri,  2 Jan 2026 13:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767358851; cv=none; b=BAfKJB5TcL4rkcSZbd0fjgYVCXX00aKImyuELwVDcZuZXle4lP9rqHnJabWnb/NbXOogMb6AajYcPRCtCmA1X6NGLIa9A+mqbwgyipHFvw2LWK5QIWo0JHCjlGTuVyapJNNCn+mK5en+4M+Un3QGiXT/ZsY8r1zJstj9wowkex4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767358851; c=relaxed/simple;
	bh=6OLSMhMi4Duo74Nab2H7e8y1jhpOlkPBEHP0Ari8koI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLt3PR1Atl0nZqW3b6f9n/jHF70dsSGpuvAGNw8dTVjwg4OWR5rikj4TBvoJrtw6dTEKv5fcAYuhMiFNWtzyNWC7Ef8ibP/6pEu2cMUZIRJEMvxPXGuj9bD3KSibQzw/nB9UUV81mLq3xSohvxakGjL0TuO9WvICg7kGoXbf/2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dys/qpm/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dys/qpm/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767358848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oTNGRVtfKAKI2uclmLVeaanTjMK73StcJvnGSTEYzLs=;
	b=dys/qpm/xo/v78ynvqZbaA2DAZ2VGyHwwhPdkGXDBD+TYM2DIsoS/oquE67/p596UrhcaO
	vajkTMerBBT5jBiABNWASWMJXUyTqygT/Z2XE29wzwz9up63OPiXYG9b5QvO75EnPlp5uN
	vbbYZytix4AUiPaxbHzBuQ5XSnrA54M=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-wqzL__ISPWWnC8gTeckgSg-1; Fri, 02 Jan 2026 08:00:47 -0500
X-MC-Unique: wqzL__ISPWWnC8gTeckgSg-1
X-Mimecast-MFC-AGG-ID: wqzL__ISPWWnC8gTeckgSg_1767358846
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b8395caeb26so313514666b.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 02 Jan 2026 05:00:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767358846; x=1767963646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oTNGRVtfKAKI2uclmLVeaanTjMK73StcJvnGSTEYzLs=;
        b=E8msXQexe8mhY7pMN8EFDsLJuybaQtp1QvuZlW+r+K0377wSrqTK302GQS2PocBTrQ
         zhYEYJZu4WqDjLtCkCRabrlYHXlV9s+XE6XAPQXRX/BWxYLZDBhof0MLgASze7KXFn6f
         4N11U+OC4MKnY3Cr4c0E9/RRsftMJxuNrOyfqahpc/v9qQ7q7IIVm//7dzZCFHNP6S+Q
         nqmXG4QEH96yDf70OqIl+8C6DO1ZgKMu42LvUGVoy+Ph9I+iYelJanLSNE8VqaLF4DvZ
         fcnlyADHOPG0MUPMyQX3o+PdzY+I1xgNl8mnDnJluOwZyfSqjlTVNTFQ/Alj3FcTc0uv
         Fcwg==
X-Forwarded-Encrypted: i=1; AJvYcCWYteXdPdWQOaqxkrRetc8VPgcpbFFBvZ8g9oscTdnnvR8mU5m4rob7Tm/qEjiSQLw4csG8qIeWrZwFwVEyRD7YMTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx46oONbMOJR7cc986QodnnYOu4vYwaRDJ2oQEV3g92h0LVsBPv
	zUae4Cnf6OoV0wmtrw3oxdd9FaO4fff41IHUpW71+N+zOu/RdbTWIm3+bRU9sS772b8EnXOSP3M
	uvc6EioQd5NuIfV0fy/mHRR2hoqsWef5EWk/1exWTk10DrRxBOyQ91blLN0GO3dVfDccKndCSdH
	fVaDTYxN+NG68QI+4Ddd5CDnywevetBYsiE2opSKNv7ty5PLQm
X-Gm-Gg: AY/fxX4E67LOVIuXtM9GCwFvcCoYmJNMqM+/VDnibWGXoDnHzapXasPj5xxwMzxyTB7
	IpKYWLX+tIS4fTf/x3x5yQsXQFTJrIO/qY0uyMATEmbMcaLdTljF/vu7AurhIhLjd1CRF4AYWdH
	c9D8Q9E/uEzXKR0RpugIQZUAe46Sp3Xm1hvImnPwazJRVJ2Xfs9+87qJX+PKTaRADvBNxV07kbT
	THtyzKelfZ4YwMBaZJf3MkT
X-Received: by 2002:a17:906:6a26:b0:b76:3478:7d52 with SMTP id a640c23a62f3a-b803705d9e2mr4078372566b.38.1767358846091;
        Fri, 02 Jan 2026 05:00:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoZPseC5+gqplCCy6UFjB5TWuN1SeOylByiLhAOSBP6m/GwqpDfdjUhHyeeitv3X9DdgtcP16s8gwoPgCMqrQ=
X-Received: by 2002:a17:906:6a26:b0:b76:3478:7d52 with SMTP id
 a640c23a62f3a-b803705d9e2mr4078368566b.38.1767358845607; Fri, 02 Jan 2026
 05:00:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224125058.1771519-1-costa.shul@redhat.com>
In-Reply-To: <20251224125058.1771519-1-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 2 Jan 2026 14:00:34 +0100
X-Gm-Features: AQt7F2rM9YWbNdZwqyC3I0wYeSIHCvBJgnvrB0BCsPqeMN-iFMD80A29BWsaQAE
Message-ID: <CAP4=nvRxrs2b0PoiH=R7gPYHh3+XT_uUhsRspEuEfWuCBMcOTg@mail.gmail.com>
Subject: Re: [PATCH v1] tools/rtla: Deduplicate cgroup path opening code
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qAT0BkQUKCGU04VvJNrOlA28XAgfkBROw2b7FBGQoxs_1767358846
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 24. 12. 2025 v 13:51 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
>
> Both set_pid_cgroup() and set_comm_cgroup() functions contain
> identical code for opening the cgroup.procs file.
>
> Extract this common code into a new helper function open_cgroup_procs()
> to reduce code duplication and improve maintainability.
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  tools/tracing/rtla/src/utils.c | 65 +++++++++++++++++-----------------
>  1 file changed, 32 insertions(+), 33 deletions(-)
>

Is this meant to be a v2 of [1] with an updated commit description and comm=
ents?

[1] https://lore.kernel.org/all/20251030144231.40058-1-costa.shul@redhat.co=
m/

Tomas


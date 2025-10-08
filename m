Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DD12EBBB2
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Oct 2025 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759913217; cv=none; b=cQfAjUXfetcTe/pl32slK8rkR0Tavol0WGIbgOe9HrvCFYkrMVRGm5Q+LH7DNki4YFfMgzT6Fy7SOqV7yoMYpmhjURpwHYBVTRcSzXZH0vKq5Ve+atJI68g4yy7/qcK2elmj2yHJ4z87zOn761ydyx0dMB5BJulEzwYGJ3ToJ6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759913217; c=relaxed/simple;
	bh=ULMfWMU0T85agFvyEZ1h2u0irkQ15gdqE/R52DoIKuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=QShrQcICiwOtk3FpYXbo6nlPfayL7nv6Ebd+voUTzJBFP4afGogIAzXxP0KIatxhkML7X+AaJPoL3AwXLAZFPBT3r4uzfJ/oB3G25ig6UpIHtMx5v2OsKWNvNfVxCQ/lpynGQLSf9djXchMGAtzip54RA9WHzOC/VYCLxZfR0tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gAfJC0ph; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gAfJC0ph"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759913214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ULMfWMU0T85agFvyEZ1h2u0irkQ15gdqE/R52DoIKuc=;
	b=gAfJC0phCS8iBxh4Sd1o7Ev0BsUkiKoJpnLkwqMuyke74irJwjCYoqOsXk8ZFgDLiTakXo
	3OXM5pDYzsJFUHXeqHahbUZFCp1XAvCBbbH8MHH/Qgq5NxM3C92IOUPtWtyqMSmWcIqw1/
	62KueY8BHp1LyBmCUyTUqL0QcvcKPaw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-Hj8nZIhfMSW1ziGZTjH9bQ-1; Wed, 08 Oct 2025 04:46:53 -0400
X-MC-Unique: Hj8nZIhfMSW1ziGZTjH9bQ-1
X-Mimecast-MFC-AGG-ID: Hj8nZIhfMSW1ziGZTjH9bQ_1759913212
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b47cf7544e0so565937266b.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Oct 2025 01:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759913212; x=1760518012;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ULMfWMU0T85agFvyEZ1h2u0irkQ15gdqE/R52DoIKuc=;
        b=EbJOACl6a6BSKAvIbGjwm/KYzlGHCdxNT2ZOBeekN1FXKxo5yFoBkA51UsHClrIN6s
         rz0Pj4Qcvrse1fyOuiPcFjMpklOJNH6pRDpaTL5Ff94i2aLN/0cRLOOfLItQLJ0+5dO1
         tGIhj9zMESwFYwxgp9CFengHj6iZHDYZsj6OGekH5lyts8OPABFKs7YxqH2gMwU399F5
         Ee6/5muBheb+cubMJSl/kxhBKbOfUWd6cW7+mr96/aGYOkZ9Id+Bt0YjmB6s2o1YKRYM
         8Xbf5TCcQfmenfuBZVA+xuCwatfp0NyuFVU+I1hRizxmUVIbnUtuGlvdoW1dnTVqNqqC
         GLpg==
X-Forwarded-Encrypted: i=1; AJvYcCWXXGT1aF2Abg+hyA84aHRku+UGTvA0dNcE+z+5trE10FCKouJLVe885vdyp26yBsGglgOI/ffKPVHt283SSKHZWOA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4TOTlvYTXvAAt9XsD7mwh6GjVyYtXXChfFoarTEGGQFk0HQFC
	mLzQ5trr8jq+NWe0LOLQFDEzXiqth3qko0oFQ6N97Druyf4OcBpnjYxzVRqoiRkaIweyE/AWvje
	GXqPytyM0+sbqDhX1k6u+y5ygUq6PNc0s/3+pUS+BOli9vNWfo0M4+LhMGNMx0vzaPg6Qnvsi+3
	z3NwEULZ+rOoI7dsynsPoVs0/HWoTdA+6v4BD9CMAX7XXXqJ19
X-Gm-Gg: ASbGncvw/BR8wMZlYfIJKcuecqgQkCaiz7NbyO3yOEyOUg+3p/vyYVuByANY2ZsjhTN
	lrpVyYV9Oxjh3hJSmSeg0AHkyYF+MdYo8iHRyE8iDxIhbxNTdCveTQyFWf/uPq9eTApN4Y+7U1a
	5sr150YeZhyqsHm1IRteFXKyT/y5ZOuc28stWthV6wf5CSIAitfDc6xrmDF96N
X-Received: by 2002:a17:907:948f:b0:b07:c90a:8ade with SMTP id a640c23a62f3a-b50aa08f896mr295154366b.20.1759913212219;
        Wed, 08 Oct 2025 01:46:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVcZ1mjgGaelpWwtZ6gpgMjo65EHWgM1o6rqW0IbqucKIMYpE+E3ROn5CCMNi7oOFALlDBWH4ivEgsnq/G8cU=
X-Received: by 2002:a17:907:948f:b0:b07:c90a:8ade with SMTP id
 a640c23a62f3a-b50aa08f896mr295152466b.20.1759913211873; Wed, 08 Oct 2025
 01:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008064500.245926-1-costa.shul@redhat.com>
In-Reply-To: <20251008064500.245926-1-costa.shul@redhat.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Wed, 8 Oct 2025 11:46:15 +0300
X-Gm-Features: AS18NWBeVVYLlbrC5IqWDYSODiNJT5qTfejGMybMGTCpJ65ymvSl8i5kXXz0c3c
Message-ID: <CADDUTFyVOzhjiqAzDHKKCprWLvq6Ww_V4rcyjDyzs5FCwXTvRA@mail.gmail.com>
Subject: Re: [PATCH v1] tools/rtla: Add missing --quiet option to timerlat hist
To: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	Crystal Wood <crwood@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GQ_vKYuj_LO_vKM1Yw264BCg9CsLHTlG_kQmFUC4eqU_1759913212
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Oct 2025 at 09:45, Costa Shulyupin <costa.shul@redhat.com> wrote:
>
> The --quiet option is available in all other rtla tools and documented
> in the usage string, but was accidentally omitted from timerlat hist.
>
> Add the missing --quiet option to timerlat hist for consistency and to
> avoid confusion when silencing its output.

Actually, osnoise hist also lacks the --quiet option, and this appears
to be intentional.


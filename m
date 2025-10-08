Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23392ECE8C
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Oct 2025 08:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759913762; cv=none; b=BVRVNDB0K/aMOtrRrv+ctFN9VD1T13OgAGaEyXDniturrDazMK84dLzQ90pGW4SRJ0J+Bbk+V/juYT6coxkcYvoGwhlGVLw2MDyYBvOiEu+XvUCYhuTxxxBIeDDz9qimyAr7qzeBzzw/NydmRVyGKSkchHSPlEOo3iT9/Nv9c7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759913762; c=relaxed/simple;
	bh=u5MMr100rtEA08BaWHHgA+sasRbKdAq9QCFOKJi4Oio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nL4pjzuawtLoapps3lE/k0o0hKctj3syLoYEsjSVdIEBYQOW7iBDIa3u+y//dth5tRnfH4E1W8x6CXHUEkc3xke+AoNokixPz4+qXJjtnyepavJpEXKiNntdqEVlm0rG8b+Kl4XI/GtuKZuNXtI95qf3l076SoGcN9ijX/WqOW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X1xIvvN/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1xIvvN/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759913759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EmZevF5PTde87YSaZT3Xg+uQUGfauJNRDPEZI/VcPlY=;
	b=X1xIvvN/KuMKyp/xMBsKDN2K2KmOOHdpLZH6b3/jIgSk5oUcmXbIXT5XmoiqzWslD5NXgt
	XnF5A4lXwwPLk81eV6Iiyh69Kj7sVF0vHIQwmSZP6F6PQTSHkzwjANJds9g7hwPPjpYNNG
	yM8j2Rp3OECsOl455wE/wjZeWIyYMHs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-zNp-xCxpPtiSH9C0xzsNNQ-1; Wed, 08 Oct 2025 04:55:58 -0400
X-MC-Unique: zNp-xCxpPtiSH9C0xzsNNQ-1
X-Mimecast-MFC-AGG-ID: zNp-xCxpPtiSH9C0xzsNNQ_1759913757
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-afe81959e5cso1034093366b.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Oct 2025 01:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759913757; x=1760518557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmZevF5PTde87YSaZT3Xg+uQUGfauJNRDPEZI/VcPlY=;
        b=Pb9W+ENZl+XtEr9QfA046CgQjvwOBQQ04UF1Vbv5FqsJiS2Ln9rlJ4h2KTshDdtT9W
         5aO8Iv6P8p+JsGcLBqLPwwEyaQ8f4p+7tLochy/F2BzIfh7VA62XRB1+cUgtvCBYdAx1
         Z9BcU7tEkaoDoo/wat4duNFIlveIYubFBX+uQDng/ZWNXPZDvkVvugqdu+marynN3lL0
         vGhqAx3xeHWTiCCj08UG4ti1SZtxpyXcDQhFaCWcri/SyXNAlpD9MUFN5NEaTvFwzDFR
         vrxLAMH97HJEgzMjiEGmzWQHhEPbj3giCJpRV0bfXEXKcBI8pHijLPa4FB8/WK0yGDvD
         b81w==
X-Forwarded-Encrypted: i=1; AJvYcCWyzjOkzOWGXK5isKDgaw8u9egh0+ghZRS8tgQ+pM+JxymWo2FEb3B+pj6LfY7TbV6YmNiXNFXljm6L89HigIYvjKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YymlO1LWmne5fnhb5+pVgI0+43O/wCu10xTOZ805Ip3F6TS983H
	w7FcTZA8IilPDv5MY9wi1/GElLAjoPkvJptIlG2RxtxQTxunaxbHvZH1/R3xU6RZDsVEhGLd4sL
	I9AQl4jFWfhyN1FIOMMcojnUZhJtJw0iqaMq/eXufTmdTI1dNS/TlNu2WEqHw7SYVXDZk4u4DYD
	ZhcbKbFTXVs8rt7hoztBvgvO+80SyZ4sYXDYe/VvdYMTJy8xFi
X-Gm-Gg: ASbGncs+BneBslRmON//KrO4MeB92WOMH6hAuVAQyXFEd+T5rwvl9mYAW2qKAWJlnan
	yfVFm5klmM4NqeAJ8mGnFjzqIJMJaGgZU3x0Q2wuUHxXijZjsiSgKEU8oYjYU3sYOsYY7xILNk8
	JhhRgEp6QY9o41nA1LmvcWoc3RLis88I1AZIM5NVsQecBGESsghwKihVyd
X-Received: by 2002:a17:907:97c9:b0:b41:c602:c746 with SMTP id a640c23a62f3a-b50aa48da0fmr287436166b.20.1759913757246;
        Wed, 08 Oct 2025 01:55:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwDn/7ZQH008AVGRVzX3xl8S3wEet83yeV03ET1vAJj3u2Og5YpJNeojyb8tG8SneCqFvrdKDeitzutNVPpqE=
X-Received: by 2002:a17:907:97c9:b0:b41:c602:c746 with SMTP id
 a640c23a62f3a-b50aa48da0fmr287433966b.20.1759913756904; Wed, 08 Oct 2025
 01:55:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008064500.245926-1-costa.shul@redhat.com> <CADDUTFyVOzhjiqAzDHKKCprWLvq6Ww_V4rcyjDyzs5FCwXTvRA@mail.gmail.com>
In-Reply-To: <CADDUTFyVOzhjiqAzDHKKCprWLvq6Ww_V4rcyjDyzs5FCwXTvRA@mail.gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 8 Oct 2025 10:55:45 +0200
X-Gm-Features: AS18NWBCA23-6OFIlvrHSY8E4tcCHEcJLjRidM7TL23KHQVxPHb-wwoMpAqdnd8
Message-ID: <CAP4=nvTDsoejezFNcS1uWftF5CkuKNb-QbBDYzZjrnHHj5RVzg@mail.gmail.com>
Subject: Re: [PATCH v1] tools/rtla: Add missing --quiet option to timerlat hist
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -FeQpT4h-nPRPbycPtmHuKhOvBkVYJ7xdUR1T4bHbFM_1759913757
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 8. 10. 2025 v 10:46 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
>
> Actually, osnoise hist also lacks the --quiet option, and this appears
> to be intentional.
>

Yeah, --quiet is used to suppress printing every second, hist has no
such functionality, so it doesn't do anything there. See:

[tglozar@cs9 rtla]$ grep -r 'params->common.quiet' src/*.c
src/osnoise_top.c:      if (!params->common.quiet)
src/osnoise_top.c:                      params->common.quiet =3D 1;
src/osnoise_top.c:      if (isatty(STDOUT_FILENO) && !params->common.quiet)
src/timerlat_top.c:     if (!params->common.quiet)
src/timerlat_top.c:                     params->common.quiet =3D 1;
src/timerlat_top.c:     if (isatty(STDOUT_FILENO) && !params->common.quiet)
src/timerlat_top.c:             wait_retval =3D
timerlat_bpf_wait(params->common.quiet ? -1 :
src/timerlat_top.c:             if (!params->common.quiet)

Tomas


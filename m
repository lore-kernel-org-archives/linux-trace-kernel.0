Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E347421C194
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 20:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756499711; cv=none; b=DVZJXa/y2v3UTAKWqU7dJnr/lPJQq+7awM44lo4IhsOXXjb8B400rTKPE/ekuBVedN4AfXhEbLxtD6xWyK0cNstYH8xeUlZ/LLNhjKrL9hWMauVQEKX9xjvLWl+TtD0ZX+8Lk+lcuhdjPdaeCwk5hSX14aauFoBbiDhloW8wt/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756499711; c=relaxed/simple;
	bh=nQcbveYbyumLlnBEQzSO9RFdrd12X8EhKIGzuKIHuu4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQmneEmYPdmszjwjZXk6RGVnJjiJdM+aO3KhB+cDsfqzRXn8vSWZJhw3k3N8mcOzqtILz9YHgbhAkorjN62H/tUeg+LCN98BMev2xfaRV3b5f4pIbRax5GpIKRtF5AXeyC/5GQ/OjseTzuBWJ0ANMmTeqO+OjArnRUMAbAE2YVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h5Lvgr7l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5Lvgr7l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756499708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wPy3vN7WH71B70q6th6dL3720nuPMk4EYjFCD52DX/k=;
	b=h5Lvgr7lp0IoZsLKXhr7vb52JkeoCeHDdK4PwvqLENuDw//lbZMZJuxS9f6Snz0N2htoc9
	K5C/HwfpDHrUCWOVMePpKq5WVVvTjgCo/+H17mEze2vNdvvUaUYmLRlI9eTqDuDO1CkSgX
	Zjf6mJ78TQIYckDD/vQMrltqN+66JRs=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-soRU1l3iOzyC6thuvHzYdw-1; Fri, 29 Aug 2025 16:35:05 -0400
X-MC-Unique: soRU1l3iOzyC6thuvHzYdw-1
X-Mimecast-MFC-AGG-ID: soRU1l3iOzyC6thuvHzYdw_1756499704
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8870ba3d52cso375726639f.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 13:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756499704; x=1757104504;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wPy3vN7WH71B70q6th6dL3720nuPMk4EYjFCD52DX/k=;
        b=PdE/ZU2fYma2qpBP+GEVveBlHfAWFL2Qw1dAy7Sph0mWzVvyj4HCTMg+/dNcep8Wcc
         0NVBxB7KtUBLTtGeMbffIZ/l3HcXCUHK89dYiMuC0Pls55NVNc6G6eutDzlulP32pUbA
         Kz+vuUdMyw711plybzqGiwzIJodftwIh9fIPktbANRqZSC1i47CwLiUT+Furhx9CxvHs
         WFc0ei0L2O1bNQfojeV13eVGXhSg0H2c43sGBF33St5qRe299BeleX6FfGiKcbgg15MU
         4xE4vUX0GqxQxWZPxBDab+c98nxYKfgvkycJx7PynUN14HsDPps6Ze6wAISrYYCLpA/Z
         vp8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSTWdUL3R+0itOaGOo8+HKXps8vL2wUxzjdAjaXWLy+wja+Z7ZlRUcnFAOE7fP8g/a9RdrjZToYpek3JG/k7KUPwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXKVg1IK+5ChVw9B1KmkZeK+Ugzzb3r/95KsOOhxkp5wV4H8KP
	9P9luIz7Xz5tZbc9bdJQXfk/7P5zIRg9B5UIZNHSYJN0Ey1A/jp77+XOiiUdqmGWTmE9LP2wSXM
	vJwIL2ex1mMApwNiBSm/aZ31TSe/NavlYb/3q/egLKE0IXSquyUEbQC6+xVI+LWJZYHfEejKDnU
	rgTz5QFA==
X-Gm-Gg: ASbGncu38SHJ1I1tLMoBVg8/YTQBsIRx281k+q8UdC3f3yLjB0RTmwZno4A5zplB/QQ
	LQ//S4mLsZ0FQ3omZM771ZasGBZOdGZH0/DMGjpWtiFJXjmf1UDaWigCRq0hGpntfjnTgoy8rbw
	leJW8jQkQJkIhw/b7VlhWVq31tGOMzDl4ZeIKxhYmioUeYUvi1POrtdUsupzzZJjgkiWYkXbcle
	lO/v1xgWFHjAvh1QVvVhkndn40Lrx/gKJXVtoWfpTuVtjtsUzCWwjFOTnCWS21vS4NIPQhjla1W
	8tqcwgJCIEaXfuFFPDictcS2DVAkY1AsVlpcKNzDLwitMk8AP8DoGGCIeMawgHsl9C1r
X-Received: by 2002:a05:6602:26c3:b0:883:f41d:601a with SMTP id ca18e2360f4ac-886bd15485amr4247321739f.6.1756499704253;
        Fri, 29 Aug 2025 13:35:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5J/HkoIhG0+lfMD0FlOXH/Ard+eH64gHLgRAhQ9K2HUg52yTl+dG5QDBvToMhQsq//5Kilw==
X-Received: by 2002:a05:6602:26c3:b0:883:f41d:601a with SMTP id ca18e2360f4ac-886bd15485amr4247316339f.6.1756499703813;
        Fri, 29 Aug 2025 13:35:03 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([50.145.183.242])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8871e2e82dcsm9815139f.6.2025.08.29.13.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 13:35:03 -0700 (PDT)
Message-ID: <598d4508bedc295ff0d767e5e6ba5b77ac1540e5.camel@redhat.com>
Subject: Re: [PATCH 3/7] tools/rtla: Create common_apply_config()
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org,  John Kacur <jkacur@redhat.com>, Costa
 Shulyupin <costa.shul@redhat.com>
Date: Fri, 29 Aug 2025 15:35:02 -0500
In-Reply-To: <CAP4=nvSVh-KUSMC9vT_59+wwmOHe_+reObznXZ-o5kd2rD_LNg@mail.gmail.com>
References: <20250821035719.137161-1-crwood@redhat.com>
		 <20250821035719.137161-4-crwood@redhat.com>
		 <CAP4=nvSVh-KUSMC9vT_59+wwmOHe_+reObznXZ-o5kd2rD_LNg@mail.gmail.com>
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DflwT2P06nYSacNcHAtZlbtCsTSa4MCC6RYBdKv_BNQ_1756499704
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-08-27 at 13:33 +0200, Tomas Glozar wrote:
> =C4=8Dt 21. 8. 2025 v 5:58 odes=C3=ADlatel Crystal Wood <crwood@redhat.co=
m> napsal:
> > At some point it would be nice to have all of the common code named and
> > located correctly, but it's a start.  Do we want to stick with "common"=
 or
> > go with something less vague like "osn" for things that relate to the
> > broader osnoise mechanism rather than the specific osnoise tracer?
>=20
> For functions that set tracer options that reside in
> /sys/kernel/tracing/osnoise and are used by both osnoise and timerlat
> tracers (like osnoise_set_cpus and osnoise_set_workload), I think we
> can call them tracer options, and make the function names
> "tracer_set_cpus" etc. Or just use "common", that seems fine to me,
> too.

That could add confusion though, when saying things like "the specific
osnoise tracer".

>=20
> > +++ b/tools/tracing/rtla/src/common.c
> > @@ -0,0 +1,64 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#define _GNU_SOURCE
>=20
> Nit: the newline is unnecessary after the SPDX identifier, other rtla
> source files that don't start with a copyright comment after the SPDX
> identifier (e.g. timerlat_bpf.c) don't have it.

It just looked weird without it, since when there is a block comment at
the top, we usually do get a blank line before the code starts.  I don't
really care either way, though.

>=20
> > @@ -44,4 +103,12 @@  struct common_params {
> >  int output_divisor;
> >  int pretty_output;
> >  int quiet;
> > + int kernel_workload;
> >  };
>=20
> It stood out to me that kernel_workload is moved to common, while
> user_workload is not. On a second look though, osnoise has to make
> sure kernel workload is created, but has no user workload option, so
> it makes sense.

FWIW, user_workload moves to common in the next patch.

>=20
> Reviewed-by: Tomas Glozar <tglozar@redhat.com>

Thanks!

-Crystal


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82725369988
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Feb 2026 09:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771925833; cv=none; b=nIubS5A0FNUHROnU9hTnUuLk4VRHQJ20vJdyjURMVMluel/RDyGGPMnB4goQzaboBd6HtPzteAbckqEcgKiPMA//OFHx5zTl/IC5pqPzilMGqwh7wO34jTIK/VK24ibNzKqgF8tr4v1/HPKexvAlywhPVt/uTkcQwSQ2/2GaWeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771925833; c=relaxed/simple;
	bh=RKL4mzQXz5RLsGfSnAqrl/BEwlcze7M8/xco1f/asKs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U3uPitJ0c41cpdCKWmPm2fUPoBwWlH8Jsh7v0c/0Rfo7ZD0LasnEq2BYxNsy5OETFt2D0Kz7ln/ojWexZN1u75IrBdHrrh+5hHDCLjUuiKQ272vOUvSxwCb0VMI25Qe//YSselCLHPeHHKgZiEz7rduT5Zz2MlTHL8hDTZ/Dw44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YwEOcuw+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YwEOcuw+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771925831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RKL4mzQXz5RLsGfSnAqrl/BEwlcze7M8/xco1f/asKs=;
	b=YwEOcuw+O6wyMwJz1bgvhwG5JB98gsR07fusn3suyzpNZ2lb9Aqeqcm1JlT55UBUZqLtgg
	2kdGTJ+7+Kx2IVQRDZtcNinfilpyLmcysItRN2DNO7Jd4tbOC0guk0LI13FL6z/51WsgGw
	PqFx8hgiqxBnaciuOHiZQzxsYakbkn8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-F9R6JbsDNmW49P0gjpgsJQ-1; Tue, 24 Feb 2026 04:37:08 -0500
X-MC-Unique: F9R6JbsDNmW49P0gjpgsJQ-1
X-Mimecast-MFC-AGG-ID: F9R6JbsDNmW49P0gjpgsJQ_1771925828
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43635708e98so3169825f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Feb 2026 01:37:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771925827; x=1772530627;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RKL4mzQXz5RLsGfSnAqrl/BEwlcze7M8/xco1f/asKs=;
        b=FcP7CapvmP+nP6OoUfviAihxNPv43d7fgA1Zw0oE4UZLviGxSEs04VKjEEPgpJqUmY
         73XTx36JLrpJ44qo+WunA48Zn0F3Kv61b+fGqndD+s3GyKSx1AGAFfoW5sIpY6uHExe9
         BI1UxuNzijyh748qaC4DvJhSDpyvSpO2uozgK4XbyIZDEjqPFZvmsjK0FDBK1MAoGnVr
         ka45yfUlTg1T1AQxPB8uZzVuvLeoidV0p5TpK5QC0TH1kv6pTJZIN3MiKoH9FVspBjll
         obmCudtIFQx2S1WO3P+koOe2aZoHq4as6nqhPuosB9V7ldND8q3SvfqKLQohieyLFZ5W
         JNRA==
X-Forwarded-Encrypted: i=1; AJvYcCXrQjX0KkrgVgqhOQVAdd9O5QPNCZQVDiJx3EtK1bOeHOQGicI4s7xgymU+EUzdhGRaeVbI4MYPPtkLkMiRde3z3sA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd1NfVDL4M8GHfadbCkj6J2GJykccKTn5UgAogIStL7r/U6wRL
	gseqyw5xv6q8Y74AC3LhgFxrw3uvlRvWU2NCDFwYRqo72tjmRQF1dz5CMPhbykmMzBX7HJZcLZx
	mi/vLS4ixNWRHUODNtttF2Tv0IcBZLZ0mI3Q6vF9paCxDD5ADvMcfyWzh6W+3mCba0VRhJlXrEK
	Y0EZQMcD0E
X-Gm-Gg: ATEYQzw9bN3B3ss1YeLUyrzPefV+MSp1mYCezh0xKg9WRaYSD5C7yMb52nb6SonFtG9
	H4D3XlK4TkzfwA7mzZyBkejsCdrCEMU6boQd7Ih6xMpikuAoTEfWhM5450Wk+fmSGm/G2doEs/Y
	iMdI0P2gNW6deyIKUmztnUWxdab+FgXQC+M3AzqpvUSz07gVCJQKYUJFwRMkUlZq6bod7cCIyvz
	1U/1kNWL1l+TKsl4/W2XDuQU9UhQQ6KP+kO2rpAhzDTY6s2hQDuQdjQaV+eFGZZKXlaY2JlO2Ke
	boFjQXD/dqB4UQoTOs/G6vQPGAWp+sVVy0KuQJM6cFijAoiRSJZcFuHjjNjY1qMVPYrD28FHcqJ
	7e/sofP9Aqs7DcEm6PRrR5MF3fP79fDk8I56z8fBOu8QUhhZ5T2Qx7OM7ENXqJo1G/ZA2pOsa9J
	0fwmihh+mtJ5wizH0=
X-Received: by 2002:a05:6000:615:b0:435:9770:9ecb with SMTP id ffacd0b85a97d-4396f18f812mr22531184f8f.56.1771925827461;
        Tue, 24 Feb 2026 01:37:07 -0800 (PST)
X-Received: by 2002:a05:6000:615:b0:435:9770:9ecb with SMTP id ffacd0b85a97d-4396f18f812mr22531150f8f.56.1771925826966;
        Tue, 24 Feb 2026 01:37:06 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d401aasm24930067f8f.23.2026.02.24.01.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 01:37:06 -0800 (PST)
Message-ID: <9df2730b1a1611367c95e91247c1b88531f9b952.camel@redhat.com>
Subject: Re: [PATCH v3 07/19] rv/rvgen: fix typos in automata and generator
 docstring and comments
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
 "open list:RUNTIME VERIFICATION (RV)"	
 <linux-trace-kernel@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Date: Tue, 24 Feb 2026 10:37:05 +0100
In-Reply-To: <20260223162407.147003-8-wander@redhat.com>
References: <20260223162407.147003-1-wander@redhat.com>
	 <20260223162407.147003-8-wander@redhat.com>
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
X-Mimecast-MFC-PROC-ID: CQr1M21CpOGqxcoM23vYufZ5iQH19goSiv72pgJ-ef8_1771925828
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-02-23 at 13:17 -0300, Wander Lairson Costa wrote:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 # when a transition has more than one lables, they are l=
ike
> this
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 # when a transition has more than one labels, they are l=
ike
> this
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 # "local_irq_enable\nhw_local_irq_enable_n"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 # so split them.
> =C2=A0

Missing one little thing:

s/labels/label/

I'm going to apply it directly on my tree so you don't need to send a V4 ju=
st
for this.

Thanks,
Gabriele

> diff --git a/tools/verification/rvgen/rvgen/dot2c.py
> b/tools/verification/rvgen/rvgen/dot2c.py
> index fa44795adef46..9255cc2153a31 100644
> --- a/tools/verification/rvgen/rvgen/dot2c.py
> +++ b/tools/verification/rvgen/rvgen/dot2c.py
> @@ -3,7 +3,7 @@
> =C2=A0#
> =C2=A0# Copyright (C) 2019-2022 Red Hat, Inc. Daniel Bristot de Oliveira
> <bristot@kernel.org>
> =C2=A0#
> -# dot2c: parse an automata in dot file digraph format into a C
> +# dot2c: parse an automaton in dot file digraph format into a C
> =C2=A0#
> =C2=A0# This program was written in the development of this paper:
> =C2=A0#=C2=A0 de Oliveira, D. B. and Cucinotta, T. and de Oliveira, R. S.
> diff --git a/tools/verification/rvgen/rvgen/dot2k.py
> b/tools/verification/rvgen/rvgen/dot2k.py
> index 47af9f104a829..aedc2a7799b32 100644
> --- a/tools/verification/rvgen/rvgen/dot2k.py
> +++ b/tools/verification/rvgen/rvgen/dot2k.py
> @@ -167,14 +167,14 @@ class da2k(dot2k):
> =C2=A0=C2=A0=C2=A0=C2=A0 def __init__(self, *args, **kwargs):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 super().__init__(*args, =
**kwargs)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self.is_hybrid_automa=
ta():
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise=
 AutomataError("Detected hybrid automata, use the 'ha'
> class")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise=
 AutomataError("Detected hybrid automaton, use the 'ha'
> class")
> =C2=A0
> =C2=A0class ha2k(dot2k):
> =C2=A0=C2=A0=C2=A0=C2=A0 """Hybrid automata only"""
> =C2=A0=C2=A0=C2=A0=C2=A0 def __init__(self, *args, **kwargs):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 super().__init__(*args, =
**kwargs)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not self.is_hybrid_au=
tomata():
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise=
 AutomataError("Detected deterministic automata, use the
> 'da' class")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise=
 AutomataError("Detected deterministic automaton, use the
> 'da' class")
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.trace_h =3D self._r=
ead_template_file("trace_hybrid.h")
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.__parse_constraints=
()
> =C2=A0
> diff --git a/tools/verification/rvgen/rvgen/generator.py
> b/tools/verification/rvgen/rvgen/generator.py
> index d932e96dd66d3..988ccdc27fa37 100644
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


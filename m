Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027EF1494B2
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Oct 2024 08:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729585728; cv=none; b=KxlnOBBv59kDeTYDmxIHJjzwgrtUbH/DuUk8AJmCNOYRMr1P9xecHc6VDvSodEivN3+z53T7LjgO91hZGxNlnCbn9u9wSq8HS58t0mBZHRq7XLF1KfKSMOIodCh2cUuPJxfOsHr5QkinYbTVU8v/ILOkk3Qlt/dF7uGbEIFPzZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729585728; c=relaxed/simple;
	bh=D2/HjL8fYaK0V1zdyY6FlA7iud6uZlw38e+jkWYFUjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NUbbFarQGTXCC20s4HmpME6cDcw6w/UMSU13cuHrK90+tVuhDt1GBr0ObVDywqo0G90v5Ok3PRdZkjfO6plBYo8FdhS0Tp/6+UFHJo4bBS4IEOIDFR2pRYBJaFgXP3UIGAZd1lWr5181n5HEHyCS8LcSZNzdckBUBuunw+87+Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T5pjOMmk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T5pjOMmk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729585725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=th0KlitpWOgI2xLbjUY3717b3+mGXGriqhUdr26to2A=;
	b=T5pjOMmk2jzsS1iETdR356lTcEMTEuniv28y/uqTExHQr75SkoftPejBaEoDzXJKW/nxdr
	gNNK9wIGgDXTACSGe9FaLD0QX/q6ZnCB68l7q1vC9Jelaeh/s6+Bq6gNnqsqG/bcl0CyNa
	PHXjgb5FWpAxG4YkSV01OlpP5X7t8+A=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-I6mS-FDMP7OPre7Ux9FYnQ-1; Tue, 22 Oct 2024 04:28:44 -0400
X-MC-Unique: I6mS-FDMP7OPre7Ux9FYnQ-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-539f5f33333so4229546e87.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Oct 2024 01:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729585723; x=1730190523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=th0KlitpWOgI2xLbjUY3717b3+mGXGriqhUdr26to2A=;
        b=qLyOxuhJzbITRFlQeSY/aTzn8SzmQum/M+WbxO/HhPtByxOhyMu10E26HeCxb8rpvd
         ql3UhC0+BYqNYR92RABpPwD78FCZ0jE75vHKoVPMT+C5hOmJWh0oDavLnYH377SYvmwe
         +kShu7GwqCnDm1x6O1lAYSx8fni2D/jbU0iaGUY85PGmgJ3xDd1btzyqcEQcVHEr8UuU
         69nAXHSS+71jNKpORnf990xuJfGb7+bqAXIWPOZaz3jDrT9SH6+5+uvFvKQX5bMv23Wh
         Ppd7EN7L/1BZ3OZ+y9TnCsdIDEjh3XiVnRZoEzAuC0nDI7qYe7ICPzHnAaAk4H5FL1x2
         VHDA==
X-Forwarded-Encrypted: i=1; AJvYcCW0rGifN5tVzAvVLTALqvBxMQIoyV5wF1I0JWrS1hLbNKF/RmzYRh1ZLvTQrNmaO196Qj9/MvUEPWl2FNPPEtJCsj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzh6/a2/swSD+O19GF80o7EwgxrH7l2uP27yBlNZ2XU0iHeJVF
	siatJucryDmYcPUdSu+rSl7dUJ5SDLsGTjzyMLERlYNIx5DFvpLeN4F7xFRM6O7Q2+nfDWHeWIt
	02LJXz2KQy060zYs03RoWDeR2FHBaONBewm52ew9ItmMq5w6leptD7ipaP92v7go58RYhcr3tYH
	ZBrdUVfjj9D3iSRtqwkxFMCQQexglSZZEl4/boaNNUDg7N
X-Received: by 2002:a05:6512:1051:b0:539:f10b:ff93 with SMTP id 2adb3069b0e04-53a15229dc3mr6845164e87.27.1729585723007;
        Tue, 22 Oct 2024 01:28:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVQ7GBQa87DLkdUq9QijZLFoILvHKWFkYQEtrL9jTxAF5AMT35QlttgZTdyIOfFnWz5bVV7T801TJE1JDP49c=
X-Received: by 2002:a05:6512:1051:b0:539:f10b:ff93 with SMTP id
 2adb3069b0e04-53a15229dc3mr6845143e87.27.1729585722566; Tue, 22 Oct 2024
 01:28:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <j2B-ted7pv3TaldTyqfIHrMmjq2fVyBFgnu3TskiQJsyRzy9loPTVVJoqHnrCWu5T88MDIFc612jUglH6Sxkdg9LN-I1XuITmoL70uECmus=@protonmail.com>
In-Reply-To: <j2B-ted7pv3TaldTyqfIHrMmjq2fVyBFgnu3TskiQJsyRzy9loPTVVJoqHnrCWu5T88MDIFc612jUglH6Sxkdg9LN-I1XuITmoL70uECmus=@protonmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 22 Oct 2024 10:28:31 +0200
Message-ID: <CAP4=nvRpL76sVM4DayG0ysUfbQgJgVL88bwP31V-5QrYf6wB9g@mail.gmail.com>
Subject: Re: [PATCH 1/3] tools/rtla: Improve code readability in timerlat_load.py
To: furkanonder <furkanonder@protonmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>, 
	"jkacur@redhat.com" <jkacur@redhat.com>, "lgoncalv@redhat.com" <lgoncalv@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 21. 10. 2024 v 17:10 odes=C3=ADlatel furkanonder
<furkanonder@protonmail.com> napsal:
>
> The enhancements made to timerlat_load.py are intended to improve the
> script's robustness and readability.
>
> Summary of the changes:
> - Unnecessary semicolons at the end of lines have been removed.
> - Parentheses surrounding the if statement checking args.prio have been
> eliminated.
> - String concatenation for constructing timerlat_path has been replaced
> with an f-string.
> - Spacing in a multiplication expression has been adjusted for improved
> clarity.
>
> Signed-off-by: Furkan Onder <furkanonder@protonmail.com>
> ---
>  tools/tracing/rtla/sample/timerlat_load.py | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/tracing/rtla/sample/timerlat_load.py b/tools/tracing/r=
tla/sample/timerlat_load.py
> index 8cc5eb2d2e69..785e9a83539a 100644
> --- a/tools/tracing/rtla/sample/timerlat_load.py
> +++ b/tools/tracing/rtla/sample/timerlat_load.py
> @@ -37,12 +37,12 @@ except:
>      exit(1)
>
>  try:
> -    os.sched_setaffinity(0, affinity_mask);
> +    os.sched_setaffinity(0, affinity_mask)
>  except:
>      print("Error setting affinity")
>      exit(1)
>
> -if (args.prio):
> +if args.prio:
>      try:
>          param =3D os.sched_param(int(args.prio))
>          os.sched_setscheduler(0, os.SCHED_FIFO, param)
> @@ -51,21 +51,21 @@ if (args.prio):
>          exit(1)
>
>  try:
> -    timerlat_path =3D "/sys/kernel/tracing/osnoise/per_cpu/cpu" + args.c=
pu + "/timerlat_fd"
> +    timerlat_path =3D f"/sys/kernel/tracing/osnoise/per_cpu/cpu{args.cpu=
}/timerlat_fd"
>      timerlat_fd =3D open(timerlat_path, 'r')
>  except:
>      print("Error opening timerlat fd, did you run timerlat -U?")
>      exit(1)
>
>  try:
> -    data_fd =3D open("/dev/full", 'r');
> +    data_fd =3D open("/dev/full", 'r')
>  except:
>      print("Error opening data fd")
>
>  while True:
>      try:
>          timerlat_fd.read(1)
> -        data_fd.read(20*1024*1024)
> +        data_fd.read(20 * 1024 * 1024)
>      except:
>          print("Leaving")
>          break
> --
> 2.46.2
>

Reviewed-by: Tomas Glozar <tglozar@redhat.com>


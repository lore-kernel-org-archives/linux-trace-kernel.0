Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12CF1487F6
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Oct 2024 08:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729585756; cv=none; b=nDa9g+Qj50oAkEY5s2cKl9xT4qH/R8g9wxsVKiJf63EvgcbVK6moPHSAWZ3WTlXnNrS30KSMlC5vWidlhXK1iqzBXSessqf7bqS0eEWU1fJKDOuGOu88UynMj50VUwZXNML6hKOystE3h2wEN25s5NpF1f99a2J7zZgUvGcToaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729585756; c=relaxed/simple;
	bh=cb0thsKCxz5VIj09AN1tmqphvkDj5hY0NrY6HqAG/1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fPtUHxRwFsxARLzxHLLH7G43J003IFdubw2/gACiYGTWG6AvkEmK9el+/rp8glCQPxiYsH8bfk46xRCjk+efOJS1RLX4MWrimXxwNCxqTkONJ5B3Up90W0VkGcw6TYPMLW79nZa8MpBuDdXv02+DFKeggRYRY95o227XVHBsxH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YeGNGlIV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YeGNGlIV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729585753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vGRPiN187IfR7144rSm3DUecJF6sy1+NJCS3lLSr/HU=;
	b=YeGNGlIVPS4jglpKcvZ00BHM60g4Dv2gZX8mu37xClTm6S2zTMnV1np6aBJIIXfpIEvnlO
	mLng5x3HF0eFdAGEk3nsICja9eY2RDuy0A2vifr1Aiw5hQwGhE6FJJxCgxJ2h7WFx6/N7K
	Rcd9MwYIav1ST7nhRnYeL19EHMXMJTw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-1KjYeogSP9eUyYRRt2LpIw-1; Tue, 22 Oct 2024 04:29:12 -0400
X-MC-Unique: 1KjYeogSP9eUyYRRt2LpIw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a99ea3e1448so375417166b.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Oct 2024 01:29:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729585751; x=1730190551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGRPiN187IfR7144rSm3DUecJF6sy1+NJCS3lLSr/HU=;
        b=qyjeNMelV2Uwdi/i7mk5wT9G7/Vwxmo8iFeYDiSpCDQbMHdbp6fsnwReIOWaYYFotW
         UN0NX8NiCpk1ZnnFIMHSwXFxiHV3hE6xBZQTGjnYB9wfhLu9FFLBy/2ctdrzA0xECpgx
         D73HUN9ThS8PhoNvtXll6fA5WcYThcVzed/PR15ZcEs4JsMbTl78wDDpVITTL46d75TN
         3zXvmWc5hSNCkrht+Qnyb8dY7i7gdHloztY8myh7XRoBT+IZ16F9McXHjwqyiAnHP0iK
         0OWGw5QGLO/EWW6tLs5vGJr5OetyGghl75rMezZEsxMdvfK6eih/49zSiJn0yk1NQeIz
         LajQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF9K2FCTtO0E0vaNx8bCNiuChPcaxVHZzLkscMW9ZoOAQbRB5rcbLTMR05WEvTOZD7cC+4wJZVIxJIbtO+1kj+Toc=@vger.kernel.org
X-Gm-Message-State: AOJu0YywxooPAKA12wqovpBJE6PGB0ePbrxIlhom+pZAhZ4PgfeYdxz6
	nMNWaWHaQwhKBmMpEnVGquOIuDUCghJyYpE955zilhixdPQs7ZJbH9JVCn9cR2/R6ZmXuY5jkb9
	0I+fnpLkgBlUzEsko845zHck2q60gGheFES9sHyX9AS9GghPCZ5+Tr/7eQhynx+heGx1kmrTW4l
	7wWlQMX6/6g2BuKrkLY3Ld95rr/IZvdn/08Lh6dKB/uyOc
X-Received: by 2002:a17:907:9721:b0:a99:d3f4:ff3b with SMTP id a640c23a62f3a-a9a69a7dae9mr1339314366b.27.1729585750691;
        Tue, 22 Oct 2024 01:29:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRAhNlRA1mjZB/wl32UmxVftUYiMV4a2riZV2UQZ/XsHWa01nqI7UdeZhTJDlgSuRXPijMuwPIBkhJ2hZtcY8=
X-Received: by 2002:a17:907:9721:b0:a99:d3f4:ff3b with SMTP id
 a640c23a62f3a-a9a69a7dae9mr1339312166b.27.1729585750239; Tue, 22 Oct 2024
 01:29:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QfgO7ayKD9dsLk8_ZDebkAV0OF7wla7UmasbP9CBmui_sChOeizy512t3RqCHTjvQoUBUDP8dwEOVCdHQ5KvVNEiP69CynMY94SFDERWl94=@protonmail.com>
In-Reply-To: <QfgO7ayKD9dsLk8_ZDebkAV0OF7wla7UmasbP9CBmui_sChOeizy512t3RqCHTjvQoUBUDP8dwEOVCdHQ5KvVNEiP69CynMY94SFDERWl94=@protonmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 22 Oct 2024 10:28:59 +0200
Message-ID: <CAP4=nvQoHvC1=eGwy_VGZAC3Xx=zr2h5pgb_f5GDdf6o7q=WLA@mail.gmail.com>
Subject: Re: [PATCH 2/3] tools/rtla: Enhance argument parsing in timerlat_load.py
To: furkanonder <furkanonder@protonmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>, 
	"jkacur@redhat.com" <jkacur@redhat.com>, "lgoncalv@redhat.com" <lgoncalv@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 21. 10. 2024 v 17:12 odes=C3=ADlatel furkanonder
<furkanonder@protonmail.com> napsal:
>
> The enhancements made to timerlat_load.py are aimed at improving the clar=
ity of argument parsing.
>
> Summary of Changes:
> - The cpu argument is now specified as an integer type in the argument
>   parser to enforce input validation, and the construction of affinity_ma=
sk
>   has been simplified to directly use the integer value of args.cpu.
> - The prio argument is similarly updated to be of integer type for
>   consistency and validation, eliminating the need for the conversion of
>   args.prio to an integer, as this is now handled by the argument parser.
>
> Signed-off-by: Furkan Onder <furkanonder@protonmail.com>
> ---
>  tools/tracing/rtla/sample/timerlat_load.py | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/tools/tracing/rtla/sample/timerlat_load.py b/tools/tracing/r=
tla/sample/timerlat_load.py
> index 785e9a83539a..d7341ed5127a 100644
> --- a/tools/tracing/rtla/sample/timerlat_load.py
> +++ b/tools/tracing/rtla/sample/timerlat_load.py
> @@ -25,13 +25,12 @@ import sys
>  import os
>
>  parser =3D argparse.ArgumentParser(description=3D'user-space timerlat th=
read in Python')
> -parser.add_argument("cpu", help=3D'CPU to run timerlat thread')
> -parser.add_argument("-p", "--prio", help=3D'FIFO priority')
> -
> +parser.add_argument("cpu", type=3Dint, help=3D'CPU to run timerlat threa=
d')
> +parser.add_argument("-p", "--prio", type=3Dint, help=3D'FIFO priority')
>  args =3D parser.parse_args()
>
>  try:
> -    affinity_mask =3D { int(args.cpu) }
> +    affinity_mask =3D {args.cpu}
>  except:
>      print("Invalid cpu: " + args.cpu)
>      exit(1)
> @@ -44,7 +43,7 @@ except:
>
>  if args.prio:
>      try:
> -        param =3D os.sched_param(int(args.prio))
> +        param =3D os.sched_param(args.prio)
>          os.sched_setscheduler(0, os.SCHED_FIFO, param)
>      except:
>          print("Error setting priority")
> --
> 2.46.2
>

Reviewed-by: Tomas Glozar <tglozar@redhat.com>


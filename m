Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D60369204
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275991; cv=none; b=I9lRZpuQgSkjvo1K8fXg8fu8ayZBo5J+dkIjNAKfK7E0tonijEVHtFpt9w9F5POeL5yw0hDQc19JX4UqM754ddzpoahuU4USFIi43fYURE8Rtnb99h70iknQZI097uafllknGmnyVpdeOo4FusbySdAmpCudLAo/h7nMvGaCq5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275991; c=relaxed/simple;
	bh=nlQk3Fo7l4wjv+7Ly6liOeonvctxsE9EFpAX/SSjx+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQGR6o6ymwwtKpCkZ2vu6WWll9uUpi45wiU87FhbCPfCRmPHI+KximHRd4flOS6DiwqFeuXZ7aSyTYocO4+1QgbhAS9fjhWA9yi3sBcmlJxemezt6iptcFEJf7aOgCGsWJCpixHTZgFfyj+tDpFqDinibViqG0VAC0Mq1Mb8r80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=geG83Egr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="geG83Egr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774275989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hPrayZ5bCR8SUVZWUxn9+RJQ5ap97Cb8RO+ppSHaOTs=;
	b=geG83EgrzQ0SqGabUgcAAA+Qflm1HmBMZ40fbEmCxjx/5P37xdCwrn+7FDgvmgBZ1uXyXb
	h5kN42EZ6GuVz5P7C6iWC0hGo1PfAfecz7VNg75m2vDf6qYKfZvHlsQYfPl0Dn7onJgoaG
	/CJN8HUr+p3w62zAXs++fw9M9lMS3/Y=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-aYBFQ2H0NpC5wlH69AS-zw-1; Mon, 23 Mar 2026 10:26:27 -0400
X-MC-Unique: aYBFQ2H0NpC5wlH69AS-zw-1
X-Mimecast-MFC-AGG-ID: aYBFQ2H0NpC5wlH69AS-zw_1774275986
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b97b6ccf166so315037866b.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 07:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774275986; x=1774880786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hPrayZ5bCR8SUVZWUxn9+RJQ5ap97Cb8RO+ppSHaOTs=;
        b=go2MW1Uqx+AznyIZyrf+wHuuTLvqfW+WAiX1kEwt5Dz+yyTZq77XriCNmoTq41Tkx4
         PyvXRtyMcxmzmWPKsJ9DZvnYd+WTM2vKueJVU41LSXfkciWhxSqsbYpmyW9+aZZDfMDc
         lTCjeIlDm5Hw7Gd6tO+IDW0BLfcbEc8M+WmcbM3fg+dvUY1wp49prkz/kc2Vw7WKRZrL
         Rb64UuDgfMVtUFR9v/3saVXIamtCMYNc6JCHvhdIpqzyBnqKwF4qVm0ZEZVCv3DvBeuo
         qeDel/37pWy9F7JvcRe7w8CeBYYZRDvtG9VJjV3pkh5Fod9ZX5O5+mtEKliBq7kf2QPM
         s5vw==
X-Forwarded-Encrypted: i=1; AJvYcCUFJVkZ3f24QRXoOQJ7JficSkunQyIAGmiyASSJmMXgAARIyPgcsIMRyTjaSNMIsqkmJCIM740lnaYaHqEGJKAv5M8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMmZwifcpd5yh8VMxNLRSi/E32SkoCc1Dj6gOTvXO0ZLtDInxT
	JtBbKE6bj0HcEJABiT5R8/ACKmj/GiTTwpNDIO6EG5+5jrB+JkSB/5Anp29ChxGRkquFr0cdYZK
	zi19WK25BTwcwC6ubsc77SKiMqkV0acFqGvvRXqtedeYZ9VwI1A86EsmnLxEq1OzKGbuWPtMry8
	+YchEiYvg1YhIGq8rvhH0G4bNsN3401RC+R8oEWwhIgPO3ZxeG
X-Gm-Gg: ATEYQzwMFlHSjOcseVz0fuRc4NHSsr/6Kc5wsmKbfiAKLYGjzEtl011o4RnlPDmWktu
	7eIyMw4LWy0nQwEngA2CipaLL12ma2Bvn2JExv+IU8lF++D2SmOFLSWcvlFYOtFpf7HI8ZX3eYG
	iKGDzUbcxi7naNpGNKuqqEiDlVz/XP/tuH3ZRo2qkKZexVnZx3PtyjWSsGNNnlV75X1CnPp2H4v
	50qqg==
X-Received: by 2002:a17:907:cf8a:b0:b98:32c1:246e with SMTP id a640c23a62f3a-b9832c15bb8mr887146066b.8.1774275986281;
        Mon, 23 Mar 2026 07:26:26 -0700 (PDT)
X-Received: by 2002:a17:907:cf8a:b0:b98:32c1:246e with SMTP id
 a640c23a62f3a-b9832c15bb8mr887141766b.8.1774275985672; Mon, 23 Mar 2026
 07:26:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320150651.51057-1-tglozar@redhat.com> <20260320150651.51057-4-tglozar@redhat.com>
 <CADDUTFx7eSqQoA0Sv2hJCcpunosWcg3=VkhWQNoFv1iOC=Fc-w@mail.gmail.com>
In-Reply-To: <CADDUTFx7eSqQoA0Sv2hJCcpunosWcg3=VkhWQNoFv1iOC=Fc-w@mail.gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 23 Mar 2026 15:26:14 +0100
X-Gm-Features: AQROBzAJEfs0pMyWRv-uz3ieDQzIldlm_q3-K_uSMJ3o7b1hAvMc5Kkkyx7-4Zs
Message-ID: <CAP4=nvTKpEm9BAsR6+SE_qES_zDzYrY2atpNwCGjpwq-g+8oHQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] rtla: Parse cmdline using libsubcmd
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WVqcEcIxR3wQDyZY0k7itXI2MPfjYhZKyHjkSMe6QKM_1774275986
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

so 21. 3. 2026 v 17:08 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
>
> On Fri, 20 Mar 2026 at 17:07, Tomas Glozar <tglozar@redhat.com> wrote:
> >> +#define TIMERLAT_OPT_NANO OPT_CALLBACK('n', "nano", params, NULL, \
> > +       "display data in nanoseconds", \
> > +       opt_nano_cb)
>
> -n/--nano requires value incorrectly
>

Yes, this is a mistake.

>  File: src/cli.c:463
>  Cause: TIMERLAT_OPT_NANO used OPT_CALLBACK which expects an argument,
> but -n is a flag.
>  Fix: Changed to OPT_CALLBACK_NOOPT:
>
> > +               HIST_OPT_NO_IRQ,
> --no-irq clashes with auto-negation of --irq
>
>  File: src/cli.c:1042
>  Cause: libsubcmd auto-generates --no-X negations for every option.
> --no-irq (histogram boolean) collides with the auto-negation of --irq
> (stop threshold). The first match wins, so --irq was matched first and
> its negation intercepted the call.
>  Fix: Moved HIST_OPT_NO_IRQ before RTLA_OPT_STOP('i', "irq", ...) in
> the options array so the explicit --no-irq boolean is found first.
>

Thank you for reporting that, I had no idea libsubcmd does this, I
haven't seen it documented anywhere, and I never used it in either
perf or bpftool.

It is a very strange thing to do for non-boolean options in my
opinion. If I understand the intention correctly, the option is
intended to unset another option specified before it, i.e. this:

$ ./rtla timerlat hist --event=3Dtimer --no-event

is supposed to behave the same as:

$ ./rtla timerlat hist

But it doesn't work:

$ ./rtla timerlat hist --event=3Dtimer --no-event

Usage: rtla timerlat hist [<options>]

perf fails even harder on this:

$ ./perf version
perf version 7.0.rc2.g61637af4f771
$ ./perf record --event=3Dcycles --no-event
Segmentation fault (core dumped)

I'm thinking about modifying libsubcmd so this can be at least
disabled (not sure if the behavior is even intended in the non-boolean
case). Reshuffling the RTLA option array could work, too, but is
unintuitive from the developer's point of view, and will also force
histogram options to be before threshold options in the help message,
which is not what I wanted.

Tomas


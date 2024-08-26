Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4419B187868
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724680573; cv=none; b=i/mxuuTUBAmQdA/AKBuN/LYert0KhQhQn8fsNsN+y3hUjKRCEFBEcpFfOY0VZ6iELZkagVxXOdhvujNvH/vRTGJKUl8jA5tX0ZBtkDV+awdhxwb2Rh7NXeM250rBiyuPNthcT1yfJqy4owWDkmSxySakxdBj5xaAYVbSL4GN2iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724680573; c=relaxed/simple;
	bh=HjiUBC97Q01Xu22aP52ISBhofEJcGVXs5WolZJRB6Bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZruUw8LSxhESg1NE9i0cmEjal7NL196PLol6mH2pKSxQl510nNsgrBKp+TgdE9kHTXYpBTWRXKITdkx7ldIlWGTAD2QkiXnwqcOYEUzHfjl69n09Co8I5Ep/9uzUDQMQRzSZDPs3k5mI0yFA0nK5J4zwJ0r73gS9d4CsDmHoL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NSFlfio1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NSFlfio1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724680570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XzOm+9Xa6ifYIbWLkBS+rtE3tSs1WNqiOAiB0oWWTw0=;
	b=NSFlfio1vXpvhbHpmj+ScxTkizYpmXlTkx2uMGBtANk5XXToFL3Ig3l6hBV5RVfxZnz3Ve
	V1pqj0ZVoZHysK/SHvZBsNUcLdSt1uc/U/4uEePO90L6RIzIiACrfdWP7CE0+tbA60fwQ/
	0KgMJQ0/E7lkk5nNcRltTXQ0gNFjXME=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-qbyakENrO8KLfrtt-qOT0Q-1; Mon, 26 Aug 2024 09:56:09 -0400
X-MC-Unique: qbyakENrO8KLfrtt-qOT0Q-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a8680b74416so678582666b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Aug 2024 06:56:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724680567; x=1725285367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzOm+9Xa6ifYIbWLkBS+rtE3tSs1WNqiOAiB0oWWTw0=;
        b=vDT+y61KgmfF5kXG8qwNdlVfUb0AaH+OQ/t3j8My7oRIl1sTpGhshCNGGEtzvHR7XH
         XUVbZSCvPiXdYvsoNIgjhiGFtTvXHx3NcR/hcfSZyt5RZROGgFksZvyajwiPiWZY1Ebu
         Kqonn+o2VDm+R0rrq7Lqp4z96FjGlcZmj0FZQWPBuYxXI7+7TXCbeOY8i1/RI+qKzguw
         mOKnUmzYZAA15s0tcCmiVuOgFDaB7m+dfasuuih1pVqyL94Uh97Hub6hM880dbiju4el
         x0AwzwWdNeEI18Ekdqq8JnENx3UmA82mgTetmG5uSqLjeovlbbOYemhn6TXxARtMH3g6
         eADg==
X-Gm-Message-State: AOJu0YwDR1XsPEmQu9SZvJ5F0A9PPlsmojZuYl9+A08Rk2Ayz0PWOuIu
	YmJ2aEbUloM4qMVxQYZ81fOlTU+Tn5gYNYtBynnWtQf1v1NEK2zdk33HLkDKJTQ4quNKDZ7bXdu
	ZX0lNAXjW3PmMIn5YeAbUlB3P/co+4mwtK6dlBJPYRxMmJ1xtG093AQ/CE6FGBkDt6blxjQGhH6
	yliWI7nDWnR3FxXAmJcMDbiLOmd+WhbrGiC2L7QJSvHlde9AhGtmH3NpM1LQ==
X-Received: by 2002:a17:907:7f20:b0:a72:7b17:5d68 with SMTP id a640c23a62f3a-a86a2f14590mr987596366b.3.1724680567570;
        Mon, 26 Aug 2024 06:56:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDpKhVZcE4ATt9+9C53mZQffqQCeuC4OYs4bi74Q+yYmqXUKTW4j3u77+7kGSUjCJzLoz7CSAOclyxuuuQpYY=
X-Received: by 2002:a17:907:7f20:b0:a72:7b17:5d68 with SMTP id
 a640c23a62f3a-a86a2f14590mr987591266b.3.1724680566622; Mon, 26 Aug 2024
 06:56:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813155831.384446-1-ezulian@redhat.com>
In-Reply-To: <20240813155831.384446-1-ezulian@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 26 Aug 2024 15:55:55 +0200
Message-ID: <CAP4=nvQD5nOHqMHqSCR_1n89jnkoKvMMZhGgGSj4OCLPxtaXhw@mail.gmail.com>
Subject: Re: [PATCH] rtla: Sync the help text between top tools
To: Eder Zulian <ezulian@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, jlelli@redhat.com, 
	jkacur@redhat.com, williams@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 13. 8. 2024 v 17:58 odes=C3=ADlatel Eder Zulian <ezulian@redhat.com=
> napsal:
>
> In addition, fix a typo in the error message generated when the
> specified duration is invalid. Suggested by Tomas Glozar.
>
> Signed-off-by: Eder Zulian <ezulian@redhat.com>
> ---
>  tools/tracing/rtla/src/osnoise_top.c  | 2 +-
>  tools/tracing/rtla/src/timerlat_top.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/sr=
c/osnoise_top.c
> index 73106683c281..50e97dbc951d 100644
> --- a/tools/tracing/rtla/src/osnoise_top.c
> +++ b/tools/tracing/rtla/src/osnoise_top.c
> @@ -442,7 +442,7 @@ struct osnoise_top_params *osnoise_top_parse_args(int=
 argc, char **argv)
>                 case 'd':
>                         params->duration =3D parse_seconds_duration(optar=
g);
>                         if (!params->duration)
> -                               osnoise_top_usage(params, "Invalid -D dur=
ation\n");
> +                               osnoise_top_usage(params, "Invalid -d dur=
ation\n");
>                         break;
>                 case 'e':
>                         tevent =3D trace_event_alloc(optarg);
> diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/s=
rc/timerlat_top.c
> index 94a2f5bbaeb7..312fc7e833ba 100644
> --- a/tools/tracing/rtla/src/timerlat_top.c
> +++ b/tools/tracing/rtla/src/timerlat_top.c
> @@ -459,7 +459,7 @@ static void timerlat_top_usage(char *usage)
>                 "         -c/--cpus cpus: run the tracer only on the give=
n cpus",
>                 "         -H/--house-keeping cpus: run rtla control threa=
ds only on the given cpus",
>                 "         -C/--cgroup[=3Dcgroup_name]: set cgroup, if no =
cgroup_name is passed, the rtla's cgroup will be inherited",
> -               "         -d/--duration time[m|h|d]: duration of the sess=
ion in seconds",
> +               "         -d/--duration time[s|m|h|d]: duration of the se=
ssion",
>                 "         -D/--debug: print debug info",
>                 "            --dump-tasks: prints the task running on all=
 CPUs if stop conditions are met (depends on !--no-aa)",
>                 "         -t/--trace[file]: save the stopped trace to [fi=
le|timerlat_trace.txt]",
> @@ -613,7 +613,7 @@ static struct timerlat_top_params
>                 case 'd':
>                         params->duration =3D parse_seconds_duration(optar=
g);
>                         if (!params->duration)
> -                               timerlat_top_usage("Invalid -D duration\n=
");
> +                               timerlat_top_usage("Invalid -d duration\n=
");
>                         break;
>                 case 'e':
>                         tevent =3D trace_event_alloc(optarg);
> --
> 2.46.0
>

Yes, this is what I was referring to in
https://lore.kernel.org/linux-trace-kernel/20240813114931.360823-1-ezulian@=
redhat.com/T/#mc4e07c9fd633f00366d48ea3c6e9b6bad1ebaf4b.
Looks good!

Reviewed-by: Tomas Glozar <tglozar@redhat.com>

Tomas


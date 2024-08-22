Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CCD320F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Aug 2024 04:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724302004; cv=none; b=VzPiyNOJBUGwO4zZgRmJzM2Aj2AzWZXf4RjwWGnqheIRTaM4YeuyvasGww6F3MZFUeCMLrKH0iDMtI6/HlNDyhRyaC+bLgCmciEREo6zRDTdx86Pgk8WNwlLx3Aj2y45za7DfGwMWlOQtiDvWrrNlUOnXfLU++St0QReObW45SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724302004; c=relaxed/simple;
	bh=SFMUJz9VYDZVGm0KWAVZ8AsTHD3YlfR/dIgg1bSXxFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YRMgHOX3W7tQ5+24RIIBAdDNwIpgZJkOK3RrHh9S4qU5HgW2Ee/sDXEzlgObd3+DHNSAjTtFKIp6t5iNM8u+sJG2yDdC3a4wOxEfSm4hpYXANbtilqv08S+QsWG54pTlur9PX4rBuhl/LqG2PRC18pE6QVCYHjFgqIuWXbsTwYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gqi6psKJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gqi6psKJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724302001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AxgBbtoWoYDIxPtq5as6kaqu18HnZZgGdFWt6jRyjXc=;
	b=gqi6psKJyhuCwTzH5mKMzjz/zhkFy9UdAGGelG2Jhr+vA6e4NPbqdnwoR1neBsAgTl6+mB
	wvPyFbw0gUA+1Jo/FTti0AjYAsB5Tr+xSw/qdP1rFjMNu0q9Gi2KbSKBd2s3VOR0os5SJp
	qbQ79cGkGdmrnWDlNJtAR8QegE+ceUc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-9ayRTWoWPwa_WmQKaNP1NA-1; Thu, 22 Aug 2024 00:46:38 -0400
X-MC-Unique: 9ayRTWoWPwa_WmQKaNP1NA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5bedb783849so493674a12.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Aug 2024 21:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724301996; x=1724906796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AxgBbtoWoYDIxPtq5as6kaqu18HnZZgGdFWt6jRyjXc=;
        b=hs3ygJC/QGWsCc9fl+sPGwT4xSaNxIrJzLKJ/GnSco5SATJlrm8IatzZVd30ICsbRt
         1VLlUglOcSSPBaqdZ2uYPkmq/El6DKIEPqI+jtBa4YZTmFTI0fwTnKap5T1alpm6TBLV
         3pDvhs1jw52pM0kvIrq2pTVUd6Zh+nd8ndQWt7JgiVNAevbmMVX1cmSJmUaLb+CxYGVB
         jQMM21kJtqALeuJgUkp7yXr78CTk85WnHd4Xa1k3nOLcxtaX0MSvm5g644cUXNSQ+VAr
         80QS/DO/o8oyRYW9WSPWsqGF3An9PlNFQENpfl/NKqwCiW5bjOovlGzVDiPjwcZ+dS2g
         aERg==
X-Gm-Message-State: AOJu0YyRAcoD7vLJs8zyXSmrMQfG83YG+WHJ8jd98X8+z1SppHbHl850
	1WQIlFoMu+r3NWU6U0v2aSLltjB3U8tyrnd0vEK0fXOQ8WNRscuOksSqMiei/4wmEtOk2mzLWs1
	EkkoLEK40tZ+jkPtwftPvYrdt+4G5yR/n3g/WV/+6+2aOmCV8N5711vMPv4wuVbbMhYiq9NJHf4
	etqdSEviXQjTlL9LbdzXSD736w2HDNpc6sH4hX/UWTItYf
X-Received: by 2002:a17:907:f19a:b0:a7a:847d:63b7 with SMTP id a640c23a62f3a-a866f8bf4e7mr347693366b.59.1724301996565;
        Wed, 21 Aug 2024 21:46:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOY4/XftlbAK7jgJIbzk61zbWpgSOHo6odI0wMzpkT9FDR3l+FKtI4OJ4eZGIkrkHK8J45DnDkuZ1EVKIH4Hc=
X-Received: by 2002:a17:907:f19a:b0:a7a:847d:63b7 with SMTP id
 a640c23a62f3a-a866f8bf4e7mr347691566b.59.1724301996090; Wed, 21 Aug 2024
 21:46:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813114931.360823-1-ezulian@redhat.com> <CAP4=nvROfKr8s75B=POefQozE88se6zrfPcfaP_n5TqtXY9ABQ@mail.gmail.com>
In-Reply-To: <CAP4=nvROfKr8s75B=POefQozE88se6zrfPcfaP_n5TqtXY9ABQ@mail.gmail.com>
From: Eder Zulian <ezulian@redhat.com>
Date: Thu, 22 Aug 2024 06:46:24 +0200
Message-ID: <CAPZYz94_6ij29YWyoNFo91=OoE7DmuJ63UhzFUqcu7ZFij_Mbw@mail.gmail.com>
Subject: Re: [PATCH] rtla: Sync the help text between hist tools
To: Tomas Glozar <tglozar@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, jlelli@redhat.com, 
	lgoncalv@redhat.com, jkacur@redhat.com, williams@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 2:36=E2=80=AFPM Tomas Glozar <tglozar@redhat.com> w=
rote:
>
> =C3=BAt 13. 8. 2024 v 13:49 odes=C3=ADlatel Eder Zulian <ezulian@redhat.c=
om> napsal:
> >
> > In addition, fix a typo in the error message generated when the
> > specified duration is invalid.
> >
> > Signed-off-by: Eder Zulian <ezulian@redhat.com>
> > ---
> >  tools/tracing/rtla/src/osnoise_hist.c  | 4 ++--
> >  tools/tracing/rtla/src/timerlat_hist.c | 4 ++--
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
>
> FYI some of the issues you fixed for hist are also in timerlat_top.c:
>
>         "      -d/--duration time[m|h|d]: duration of the session in seco=
nds",
> ...
>         case 'd':
>             params->duration =3D parse_seconds_duration(optarg);
>             if (!params->duration)
>                 timerlat_top_usage("Invalid -D duration\n");
>             break;
>
> and the "Invalid -D duration" (instead of "-d") one is also in
> osnoise_top.c. Those would probably go to a separate patch, though.

I followed your suggestion and submitted it as
https://lore.kernel.org/linux-trace-kernel/20240813155831.384446-1-ezulian@=
redhat.com/T/#u

>
> Reviewed-by: Tomas Glozar <tglozar@redhat.com>
>
>
> Tomas
>
Thank you, Tomas.


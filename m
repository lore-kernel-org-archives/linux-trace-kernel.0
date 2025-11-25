Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F331023817D
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 13:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764078538; cv=none; b=TOcQFpcLEgXq1rit8Gr9lnqaRuZ5jjVap5qTN4UMYcjZup6mLqkT7qB8ivEOyF0rIvcYav5lm16B9GDoBzBywCBQb0bw1LoCHer73FL8KgLIPr7CPR/O3v74KzDV+XMw+abDnsqedgO6sM/bsrmUpFs7CsZW0wNhG/iT/ijRpYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764078538; c=relaxed/simple;
	bh=KUlkbAmvU6Tr9qioFlf7FQnezoFY7TBm5fTvKgCmJCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3Zg3rFvwmS8G9ToALlDVHTWw9bH/+IPX/OShqvrRJmhbCeITN5CoEXi4bhFq9Svozgm1oxgpElq2CvQJ0D4UK99kS+GMk7IE1cEmjg6UcAk5H/PfbrBZJVuhErXAOPscZIUT4aGsY5trGIakAlTuOLF3Oles6qIUnfPcSjgAzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RqPr5fe7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RqPr5fe7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764078535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T9hy4SCVLvP/hTQZDIVrEdSy2/Jcy5XlGO+eLboO4Ww=;
	b=RqPr5fe7O2HU/bpnfhEAKW2yI4H7+5X31ZwJvtnrZ9iSUundZ/uOEKyXMGMQQUvgLvRFdn
	+2xfo98EnwRlE5spn6Mv/q56C6WsWe5ABdkhl5L9Q7JI2fsE8zll8mTQXO40C5EVWyH89K
	PD9YfeSQI+EvmulLwr0I/JbEq98vNZc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-m9YRSVzTNjCrnIT6Rz3srA-1; Tue, 25 Nov 2025 08:48:54 -0500
X-MC-Unique: m9YRSVzTNjCrnIT6Rz3srA-1
X-Mimecast-MFC-AGG-ID: m9YRSVzTNjCrnIT6Rz3srA_1764078533
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b767784598dso365705666b.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 05:48:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764078533; x=1764683333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T9hy4SCVLvP/hTQZDIVrEdSy2/Jcy5XlGO+eLboO4Ww=;
        b=NqUyKq3KJbL7hYRTV1fF4BcFcsBNtnkaTdKtHMHoetw2v97ersHhRCP9EbKLK8UDdy
         V8WnEMUoY/EnHlFnbG1SwFfOuLrgErATmnQGU7UDDZTx0wc59XKDZbfMSy83F0B/TPAN
         lAwWp6TGdIOboosvYPZ9/zCmgV6shNckRqwiEnqIjbfmwA7BM8zT7Qss/2iYI+i4Aby7
         FxLEHINoGhiUJo5ZE6F+LzTmlZ/8P2Bk9caZRYIyfskhweowxjwyjopF+p41os0JB56s
         KSN+gvBhm+qBmXhDQFEpTxvqfr9xxtzBvAnscW2/01x/YjNk++nZRBJ3cf1G17ohOZCV
         BoYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAjBJnXhWyWyK9xNt/iPWOk+Lcg/MYMg8MgW/m/WvzlsP1+klZh63wh7FeS12TNQrCSFbvpUDdaGD3I6IedmXtt48=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUrS/m0MigvPCdySPVW+781M8PbbzufTACG9ghToOKJq9ymejZ
	pIEnxVDyRyZgSrUePU25cUVJcJ+Rne9bq2f0ZQuJsahaRastz5o52QcF+zKlY6U4oP61uoQorC1
	2MJl5yd4GqAfkWqkTvd5O83uvDd5w3dO2hdcxRoMahvEiPpwYwbiuOPZn617TP5YSeKvws4QQfy
	ExgI5g2b8lDjqD7kAveOauDQITGDxpj4S/wkkidWfJtL1Y//0s
X-Gm-Gg: ASbGncvw+JBWmrr1938iMmCKm8alhoLbj3e1l33V9umvNyilyozoLVGCbo0EbOQnEZJ
	+CZ716pcW2SF53+XE7b5reZKb3PNHBlPlWafaUluMTlH34bu/pLPJIhpfhqVeI9pBzToiu66ftJ
	evwccwYPi6uw8UD0ZiJfsxkwqmiegJNrY8g4vUjfu0/tiBp2UhT8cHD/5ODKYdg/R4gQ==
X-Received: by 2002:a17:907:3d8e:b0:b73:7184:b7d3 with SMTP id a640c23a62f3a-b7671a448f1mr1950273066b.58.1764078532970;
        Tue, 25 Nov 2025 05:48:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqXkuS6eNc9UH0H1SzFazMyi3xmAIiysbsk3mVN1m8RGNDVn4H3AhY8kGu/8VChbm3fDuQ1S4Gn1wwYy4mP30=
X-Received: by 2002:a17:907:3d8e:b0:b73:7184:b7d3 with SMTP id
 a640c23a62f3a-b7671a448f1mr1950269266b.58.1764078532592; Tue, 25 Nov 2025
 05:48:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027153401.1039217-1-tglozar@redhat.com> <20251027153401.1039217-3-tglozar@redhat.com>
 <liouklnl72kulibowk33roalgtjor24u3h6hfbuzudlodasdvz@fhy2zeif43nk>
In-Reply-To: <liouklnl72kulibowk33roalgtjor24u3h6hfbuzudlodasdvz@fhy2zeif43nk>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 25 Nov 2025 14:48:41 +0100
X-Gm-Features: AWmQ_bk_Rzt0Qbfc4WzIDgOMiJn7k8fEViDqy4mHfJMd9wBBUgmFHBMSlGkiJ5k
Message-ID: <CAP4=nvS6zDkb-yo+uu0LHk=OBKP+UO-p46tLygGOUG0zkrkbiw@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] rtla/timerlat: Add --bpf-action option
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Crystal Wood <crwood@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZBQBleBZh82582zedKDF6Yzq1cUiKfw90BZjl-8oLTU_1764078533
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 3. 11. 2025 v 15:45 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
> >
> > Executing additional BPF code on latency threshold overflow allows doin=
g
> > doing low-latency and in-kernel troubleshooting of the cause of the
>
> typo: double "doing"
>

Thanks, I'll fix that :)

> > --- a/tools/tracing/rtla/src/timerlat.c
> > +++ b/tools/tracing/rtla/src/timerlat.c
> > @@ -48,6 +48,17 @@ timerlat_apply_config(struct osnoise_tool *tool, str=
uct timerlat_params *params)
> >               }
> >       }
> >
> > +     /* Check if BPF action program is requested but BPF is not availa=
ble */
> > +     if (params->bpf_action_program) {
> > +             if (params->mode =3D=3D TRACING_MODE_TRACEFS) {
> > +                     err_msg("BPF actions are not supported in tracefs=
-only mode\n");
>
> I would just emit a warning to the user and proceed ignoring the bpf acti=
on argument.
>

I believe if the user explicitly requests BPF actions to be used,
measurement should not proceed without the action. Imagine someone
setting --bpf-action in an automated test, expecting it to report
something. But the action never fires, because they do not notice they
are running an old kernel that does not support this.

The user can always restart/reconfigure RTLA to skip the option.

Tomas


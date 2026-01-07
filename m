Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87FA32AAA1
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Jan 2026 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792030; cv=none; b=WLCeki7cOBZ73UTDks8PJnpLvWh54o7mkeBZCTn+xCGVWLSm7rCa+A+Z2wxw+hyn17xqXJqKiPCZR/f4rQzD7jhcub0o5AKU9EU90EtdCvclHipKtYStBGB/81rXXsUb8hr7H+a5GR4P0bHIcC+miD32gippVsc0JptaU3uccrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792030; c=relaxed/simple;
	bh=eoUYiccCPfQCG3U2pquAI7WoxvfBiLnWgqIySjCZ4Zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3y5LulKs8W3XjbO+hIMsbNjoFhYyMj4RqpdNWitviNJ97IgNKeKDwxbgjcHQ1oYyCx9og+/XUL3A3tk0AFip1YMbPrzPMgnKB253R1uM0pcg6U5j3QNfMA1+XjM0D9/3DuOx54R9IMAlEl/yAe5T1j+NLr5woG2BdwLB1KfrwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Og+Nbaik; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Og+Nbaik"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767792027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0FAV0wASxR2yI419oALk6fAKqfLd6t7b3o1j99zRYxc=;
	b=Og+NbaikuKrp6lLPjcB4QAV57SVl/874cph0wXII5xGKWlclefuReO4Q3RZaL0JEGjl5K3
	MkY11Eiy1hczcrtydDDrcfonViug0iGi48C//b3iTdT5zPTNkzks2qLAX2RQX1x5D5Jdmj
	tu+PIBOSy4VO5oU7KU0unn3tw/qCnDY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-72xgC32AOsKvvWxFnQRRvQ-1; Wed, 07 Jan 2026 08:20:24 -0500
X-MC-Unique: 72xgC32AOsKvvWxFnQRRvQ-1
X-Mimecast-MFC-AGG-ID: 72xgC32AOsKvvWxFnQRRvQ_1767792023
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-59b6ab3cceeso1369088e87.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 07 Jan 2026 05:20:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767792023; x=1768396823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0FAV0wASxR2yI419oALk6fAKqfLd6t7b3o1j99zRYxc=;
        b=YB53sl0I6mF+XvqXwNo1Fcg01hkelLCMu0iy39DZAPm1L7ACQJDocW17CiH7jnFZL9
         r2DGvJuXFnUlqdJjF1eLbq2FECkKUzrhlkBD1srKa6McJ2+PA+TG3CgEkgG+TOENSN9O
         BC7y1QKQD8DGnf2m+6y5JDk76lb3lHO9D2xwMNZj6DLpFTvwKN4PwAb25gh1lnWecwwL
         C9YHL1rw5rvEVvl4/01b0OFo1geKyrJRSj13Jmow8ejU59FOV/F8I72RLn+lex/KwO0w
         +g+aSGX1+yAaAwZZedz81MkIykOEsn2MqdVWWqUKL9iPB34esFR21J4svql6fYKG1qH7
         QCCg==
X-Forwarded-Encrypted: i=1; AJvYcCV02oZG0ELRn0l8GGVI/ll5P/8xmle1XE4T+cQf6a5cfbDnFw49wwJbJZXGi69onr3RZAjs6knrp1CpTUXV8AtNU/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwludsgOy1gp7OC95mfpb7X6AVQMOj7V7vIUMGsQ2qqIqwltHyY
	NG7V8H/gW/+uzrYXD9WgwifJ2ON8xQ5dSlhHT5e87SQ+LaZ0EBuQFMzOgMPX2uzEoX0C9iysJxh
	SV3ArSIAAxH0Fwj2YH/KZ/JpIQ5++/ylQT8ViviUlEiZMTRqGZB5WZPenFs8rUVqu421Cc9AsNF
	9ARPJKk4vbYGuVPxI6T2TU07DG59QIs9WLhKLCPjnkAfsMQ43D
X-Gm-Gg: AY/fxX7V6jsk1y2qeE4NipH/iLdYFmHQAYKX6yFg500PNaGqh1zcI7WYjq/usOf/C+X
	mgvOEtZCWKDZEwrFA2EUBsCb2jAtowAQb1glt1flTmLtITBdqrIjueaNZal0y7Xvn+TB/wZjrBh
	qvw+3z8vkM5GKwHBWapi+y7HC8e5N+Wob9LrYLuryTSIffbkgW6E3qhWtxN7JBlAyhs5CVTNpRX
	+PpGWhaWSyEVso6ZF+5q4Cb+4nrGmgHB2sLYUNdkvjFFKnRB6+kZrVXhBbTh+TvaRbF43YZdPrL
	lPegFzandOcl
X-Received: by 2002:a05:6512:3ca4:b0:59a:1a54:2d1d with SMTP id 2adb3069b0e04-59b6ed1347cmr923468e87.11.1767792023011;
        Wed, 07 Jan 2026 05:20:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEM4Wg/31yJtJLWCgaWo53ubArkeBsnxRGahv7hLfjQV7fqcR9f965ACY/ViRie6Vo/bTJVv4065z0C0SGKiSE=
X-Received: by 2002:a05:6512:3ca4:b0:59a:1a54:2d1d with SMTP id
 2adb3069b0e04-59b6ed1347cmr923449e87.11.1767792022589; Wed, 07 Jan 2026
 05:20:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106133655.249887-1-wander@redhat.com> <20260106133655.249887-14-wander@redhat.com>
 <20260106110332.4b46ed80@gandalf.local.home>
In-Reply-To: <20260106110332.4b46ed80@gandalf.local.home>
From: Wander Lairson Costa <wander@redhat.com>
Date: Wed, 7 Jan 2026 10:20:11 -0300
X-Gm-Features: AQt7F2o5LZDQmwZo2GzGL3PipkTd_z5ELpWMtWI3IvYa0sletpWe6Q_7-50shWk
Message-ID: <CAAq0SUnzMjbsV-Q9yXi1e29yLh27_+L6zC_=uKMV+aa1yGWojQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/18] rtla: Fix buffer size for strncpy in timerlat_aa
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gci7IN48gb0vhP_699FKvVxRs8Zgl84F_GrX0ccUmR0_1767792023
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 1:03=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Tue,  6 Jan 2026 08:49:49 -0300
> Wander Lairson Costa <wander@redhat.com> wrote:
>
...
> >       unsigned long long      run_thread_pid;
> > -     char                    run_thread_comm[MAX_COMM];
> > +     char                    run_thread_comm[MAX_COMM+1];
>
> The reason why I suggest strscpy() is because now you just made every thi=
s
> unaligned in the struct. 24 bytes fits nicely as 3 8 byte words. Now by
> adding another byte, you just added 7 bytes of useless padding between th=
is
> and the next field.
>

Hrm, I missed that issue. Maybe I should have set MAX_COMM to 23.
Anyway, in v3 I will switch to strscpy() (maybe strlcpy() does the job).

> -- Steve
>
>
> >       unsigned long long      thread_blocking_duration;
> >       unsigned long long      max_exit_idle_latency;
> >
> > @@ -88,7 +88,7 @@ struct timerlat_aa_data {
> >       /*
> >        * Current thread.
> >        */
> > -     char                    current_comm[MAX_COMM];
> > +     char                    current_comm[MAX_COMM+1];
> >       unsigned long long      current_pid;
> >
> >       /*
>


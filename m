Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF21312801
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Jan 2026 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767793839; cv=none; b=H6vsim+o4vOuCfhcK3WZ2e8eIQebHp6Vbydt1jNqFT13zmy9ezIGJdfRNTXfdI6x68KSZrBdXyVBukneALJJfWiXiP943m7/vmE/CXxxhlZrs1mqx9uwwwClZmsYTSdgrwMK/L5sd8chM1rwO4KuiXQr0ptBSeG2yojElz3Hri4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767793839; c=relaxed/simple;
	bh=fK02nfm3x/WpspVjzqsxTFJxRC/x1RuacbvrfeaPNFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrBnbqDVHGg6kFtECX/ZwVie7IDAy6mUPiLT5QZgmicpTfnREDk3ojEWC7/NK90FoiqvfWHKUEepEKm3/kMNMKHj9d9jt87DB/zxHOJ8bemcQaovXjZlE7zjoxJyEmB0C4EBVye7gUkmVnfy3y7470o6UkyFLkqdkMIqu0B9YPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M6NGY53S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6NGY53S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767793836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LwU3Ac+NpGby+4CQIUS5mhzem4J8LDUziJc+mt+weZc=;
	b=M6NGY53SvZdqcok2/vEkS+o1Be+flSXui11kHO04hlf1rKFRc6wxDjhdNXIQAd5kuF0a1S
	mQ/s/QFweK2QKgpCPUsQJWYyYaMfb69/HkGoHmlYzAuiViUAye9Z4rGnPfXVejgQ8woSyS
	54G0FOjQMtGgPZ2j7wA3OXpzKv/4/GY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-cA0EVmCyNGKIyq2xQ_y_Sg-1; Wed, 07 Jan 2026 08:50:35 -0500
X-MC-Unique: cA0EVmCyNGKIyq2xQ_y_Sg-1
X-Mimecast-MFC-AGG-ID: cA0EVmCyNGKIyq2xQ_y_Sg_1767793834
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-38306501f14so2070051fa.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 07 Jan 2026 05:50:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767793834; x=1768398634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LwU3Ac+NpGby+4CQIUS5mhzem4J8LDUziJc+mt+weZc=;
        b=ei0wqt2megkoDwJ5HbJ43dJjkua2bL1GRyykJ7Bz43LpQ2rZmJiy3Cwvg9BJW60eGS
         vOfsjONJwGAfl2SMnv7AjbAsWZrAelxEZPyWxbVZqceU384tJssOjClTfQ1OIzq7jZhi
         Chq7Rblhu0WpD2xdv+a1dTrkTGnWndsl0KHBHCUgZ0LWvIZ/UbT00snWvwX3f8CG50E3
         MydgGjO3rSn+wS47OF3aW3dp4kLliA26Dk3e3obH4yLi04ljz0u1A3vvp1xo8/rzBr6B
         HF6WOi59xbgMdDktfGsKXz+kid2IzU/QQL5wstdz2FAG3rrsUUx9vhgezJ5t5DNCMP1m
         LPUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmW+o9FYnTGXoFok5REhx8oU4qIJRBcxbQMp24rvY/h/xfx8ZH5LT5SDBJwpIEZrKO9Ea9GF16sOEwYEIll3MfAto=@vger.kernel.org
X-Gm-Message-State: AOJu0YytltxZurYTGKpKtW9N4Ee9A34QTisa6TLTn2zznzW7iaGubyA4
	nB9T9jQr0ZyQovHpfARu6vPQYWdBIRzlRn0ejSdFjV0HCUN3rHXSn0x5arxMQ/0XCYPWmbYD6q3
	UXafCDfQRhawexZksNfJrwyBlSy0fL6ojnvAKdy74UO5vjxKt/5rEAMJpPVDtp5H/2ND5KblXKG
	v35tBW689QoUq7soKfTRPZu0fAs3ERFEPo1/TNYHdPxQRNm76A
X-Gm-Gg: AY/fxX5f2x5nM75Qk8Uie5NnTvZuf3rvZczIj5cifXSwG/wkE2ZXPo22HnX9+lgf51q
	xUCfCS36Rlg93KQysGQREgvSQ15GYC+CyPwl6mLBmQYq6Q6XDfl/66IuD8sFtbjKQp39i4Dsc52
	dp8HAMM+E0CfQMYHM4Fe3MptZoAkOWyG7nj4NogU98Hzes/Um3QBmupMQlooJDVTbViy7f4Ivvu
	+XcGXUE+oPNxt8a4nS824Fr4A9jznvZMvO3bSmJ2bKyHpQ+iawRbvwfRYTAqyWU57LYQw==
X-Received: by 2002:a05:651c:2212:b0:37a:584c:23fb with SMTP id 38308e7fff4ca-382ff6dd8eemr7013511fa.20.1767793833670;
        Wed, 07 Jan 2026 05:50:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHm0tMT9u9iiOgRGj9K4E0/pPEVxnBe2X5bK9p2XFMNMGYd0BXK04nFgMfu+eVzo44KLvloczFrjtUOGz4zwfc=
X-Received: by 2002:a05:651c:2212:b0:37a:584c:23fb with SMTP id
 38308e7fff4ca-382ff6dd8eemr7013361fa.20.1767793833177; Wed, 07 Jan 2026
 05:50:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106133655.249887-1-wander@redhat.com> <20260106133655.249887-8-wander@redhat.com>
 <CAP4=nvT2oPtM73nfPkSJZ4612mcAPw1LWbHNrszFBVAmSJOVbw@mail.gmail.com>
 <CAAq0SUmrRecimVNCa=zv-h3uPm-GpQo3g+ZTV4zLNVA4ZVo-EQ@mail.gmail.com> <CAP4=nvTeFtHF+K0h0FkWMh6uLb5Qwy6LnYPcrbrbNOM6M6kFNA@mail.gmail.com>
In-Reply-To: <CAP4=nvTeFtHF+K0h0FkWMh6uLb5Qwy6LnYPcrbrbNOM6M6kFNA@mail.gmail.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Wed, 7 Jan 2026 10:50:21 -0300
X-Gm-Features: AQt7F2rnfMsmprZP2rAt--ee_rglZ18N55qI7Xvqb6bhHKWfVtx_oS-Vwti0GG8
Message-ID: <CAAq0SU=QWnfQnfKM=YOcBVBh6wuqaFub4kDf5taSv7PCMaOfnA@mail.gmail.com>
Subject: Re: [PATCH v2 07/18] rtla: Introduce common_restart() helper
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jt8ljbliKs5pHpHSW0Dv-0srmNyZJeSwllSpOoLWbYE_1767793834
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 10:47=E2=80=AFAM Tomas Glozar <tglozar@redhat.com> w=
rote:
>
> st 7. 1. 2026 v 13:43 odes=C3=ADlatel Wander Lairson Costa
> <wander@redhat.com> napsal:
> > >
> > > The deduplication idea is good, but I find the name of the helper
> > > quite confusing. The main function of the helper is not to restart
> > > tracing, it is to handle a latency threshold overflow - restarting
> > > tracing is only one of possible effects, and one that is only applied
> > > when using --on-threshold continue which is not the most common use
> > > case. Could something like common_handle_stop_tracing() perhaps be
> > > better?
> > >
> >
> > Sure, I will change the name in v3.
> >
>
> Thanks.
>
> > > > +enum restart_result {
> > > > +       RESTART_OK,
> > > > +       RESTART_STOP,
> > > > +       RESTART_ERROR =3D -1,
> > > > +};
> > >
> > > Do we really need a separate return value enum just for this one help=
er?
> > >
> >
> > If it was success/failure type of return value, we wouldn't need.
> > However, a three state code, I think it is worth for code readiness.
> > Do you have something else in mind?
> >
>
> The main loop can simply use the continue flag, just like in the old
> version, no need to duplicate that information into the return value
> of common_restart().
>

Ok, I will change it in v3.

> Tomas
>


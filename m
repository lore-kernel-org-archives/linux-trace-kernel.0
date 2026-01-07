Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495EB322C7B
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Jan 2026 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767793644; cv=none; b=s+N6I33Td9Tj4iFgLZkHLmBy+jrnWlffYY0QsC9EXU1Ba1ysD5irIjQ5NiZrLXtK8Q5XgOM9mjs/I663WSgHrDJZoxH5Jp6RhqtV2q6WkWOs7OfpKHLwpgjpffbIiOysDv8wDOk0broDWCItL1tYnu4XtOeoYJOrPO3o4osNAG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767793644; c=relaxed/simple;
	bh=5UeIv+085j7X+A2KkpBcuIkf8eSlo8D6e6Ms8n27crs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRiHUJNJ/G0IwtMOtMwq5Dmwt4fiTP/uUpCAOXVsFQs+0Iv6le91W2KP54M+8L+mSgTbQm+GzgCvAZcM+eJPbjWvCG/1GB4pl4iyWZiieC0kQo/eZZYeXk1Vax9jixVSm9jwQh6nM1bbHTvTDygCu66XtVwHUmMAFq2NweTVHR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ExWGNxVA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ExWGNxVA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767793641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLoPxkvg9MQAFGxKvostktDgMdVNq96nmc+PVOzg14c=;
	b=ExWGNxVADYrF9YeNp3DNJFvJRwzb00SkBox1AO4eq7w7PywNsZwupstpT8cXrhGXNGzWC6
	pZeDlyxAxb9J99n8Exh9iA0Wo0C68KdpNadT3Tzjm9kAcJ+NgJ6DhDi/jwlMyt7nP4mbJw
	3srhQRDR+yzCOTsgpaWMmDnrVCghP3c=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-jIMzcGK-OeqDN_dFzEMc2w-1; Wed, 07 Jan 2026 08:47:20 -0500
X-MC-Unique: jIMzcGK-OeqDN_dFzEMc2w-1
X-Mimecast-MFC-AGG-ID: jIMzcGK-OeqDN_dFzEMc2w_1767793639
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b726a3c3214so193535866b.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 07 Jan 2026 05:47:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767793639; x=1768398439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZLoPxkvg9MQAFGxKvostktDgMdVNq96nmc+PVOzg14c=;
        b=fJe9lEEj0ydgQhIjQ5maIUPuv9upC01/ggLIfqVFgZ4Ezem+4Ymj/cCgxN9vYDDBvf
         fja71R9k9pyPsNT9D9nKwjD99LSodPw9eugATqCtxk5c5tfmP7bjWFio4pcbYDf2rR9q
         /mbT7ohnmoJZlajhUc9np3WVZuJh7POCBF/OB5sudFXQ8jDfSF3gJS/9N+Uxuxy1Qfbh
         OJUqyHRfT8GgkfI9BH/5kk/6HVEFtatQm0v7B13SgBP5Dg5KX2IrTlIJzif8Uru9kL1+
         1wD5cDkcbQ6Fiu3QnDHVWzeJnwdjz39St1PkJZfKAu9GkY/Q+TxP7Bf5oUVtvjCeyMdb
         1H+A==
X-Forwarded-Encrypted: i=1; AJvYcCUQxLxzwOeC/MdynKO4AMh50GwIAi3QP1rysDHlq3+6PKJW7ANm0WdjBTFJXB8foYQ57+PHkX+J8q/BPWJkBtER6Tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwEO6O/+g99c/6QUfrG2zqVnU3FC8wMmfd7Ml0fusdvlG1Bd8N
	V76fx2FvwORHrW3StJMUlj9iEgiNVNThdHGEt1dDsS20FdwR5yNliPnFfNHZgmD2VBoRS9v3+rL
	pPXN/UR9177fpXTqafwgYKvjfiN7UfxHXcdG/9M/eHmJJqftPtt+D+kZKLbwBXkXsLbhsTuDZPc
	kmC01JRpnJMW5lyQ9wmdlcwJ9nDPBZi+PxzcbmydEx6qz21cXn
X-Gm-Gg: AY/fxX52z1PVGqBeNDtIRtuwWV/OdGwtWr+p018d7XYF+jXaZoa5R229/s5lC39BG5C
	2EaTnSQgVjEINnAr8WYj35BSoZKWypXk+9JA0+stU/x4Crje60AkQrj96Sul1L72cdIHr/aY6YJ
	KOdTW7CUZiBUaAs8uq4r8GhudimlgfZkpd3FxDs2esjoDSv4tjSWLluhifYi+eYRcTQ5huyfTjL
	gW7k/QaOy939kalbRVlSvbx
X-Received: by 2002:a17:907:97d3:b0:b76:4c16:6afa with SMTP id a640c23a62f3a-b844520d854mr274385266b.28.1767793638870;
        Wed, 07 Jan 2026 05:47:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1i2QRzGxxzUUyfW72AkZX83kM1+QBJ7NrayLZXt+2mPD0j700Gvi3U/l9XmWKJUNVUbEXTKZjcZRfR/KKLT4=
X-Received: by 2002:a17:907:97d3:b0:b76:4c16:6afa with SMTP id
 a640c23a62f3a-b844520d854mr274382666b.28.1767793638425; Wed, 07 Jan 2026
 05:47:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106133655.249887-1-wander@redhat.com> <20260106133655.249887-8-wander@redhat.com>
 <CAP4=nvT2oPtM73nfPkSJZ4612mcAPw1LWbHNrszFBVAmSJOVbw@mail.gmail.com> <CAAq0SUmrRecimVNCa=zv-h3uPm-GpQo3g+ZTV4zLNVA4ZVo-EQ@mail.gmail.com>
In-Reply-To: <CAAq0SUmrRecimVNCa=zv-h3uPm-GpQo3g+ZTV4zLNVA4ZVo-EQ@mail.gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 7 Jan 2026 14:47:07 +0100
X-Gm-Features: AQt7F2ph3Al6PnRm9hkpWdRKwER31ZBY_y1Igwr58DOaNMEWshQZaPUQl5IDXow
Message-ID: <CAP4=nvTeFtHF+K0h0FkWMh6uLb5Qwy6LnYPcrbrbNOM6M6kFNA@mail.gmail.com>
Subject: Re: [PATCH v2 07/18] rtla: Introduce common_restart() helper
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ct-_e_tKzw9to6T1f4NFv4F9QWkw24UysZckZbWSXUA_1767793639
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 7. 1. 2026 v 13:43 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
> >
> > The deduplication idea is good, but I find the name of the helper
> > quite confusing. The main function of the helper is not to restart
> > tracing, it is to handle a latency threshold overflow - restarting
> > tracing is only one of possible effects, and one that is only applied
> > when using --on-threshold continue which is not the most common use
> > case. Could something like common_handle_stop_tracing() perhaps be
> > better?
> >
>
> Sure, I will change the name in v3.
>

Thanks.

> > > +enum restart_result {
> > > +       RESTART_OK,
> > > +       RESTART_STOP,
> > > +       RESTART_ERROR =3D -1,
> > > +};
> >
> > Do we really need a separate return value enum just for this one helper=
?
> >
>
> If it was success/failure type of return value, we wouldn't need.
> However, a three state code, I think it is worth for code readiness.
> Do you have something else in mind?
>

The main loop can simply use the continue flag, just like in the old
version, no need to duplicate that information into the return value
of common_restart().

Tomas


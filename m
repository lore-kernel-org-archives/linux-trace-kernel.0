Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAA2476071
	for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787838338; cv=none; b=aUkZ4jogIyrrovu0NXxJIulw5ieA41Gw6NiDJFZpo8nbhoFy1ANFmS5zw+dPYIBvyPT+z6XE8JD+IhOWa8D1yqBXWRtA8OPLD48WsesZYgkBJkX4fCOqNF9y2uuVEUJ9cRula9I38bW3DjAkuG8kPmpWduHZMcfxlwCe/PFYPSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787838338; c=relaxed/simple;
	bh=GWQxLxmMzGcN6gNyfg7urHOaVb9S7OFSIk+bbfaDvx0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=suuBcGZ5S7AJgvAPOyUotHvXPp64vWo35uOcPnzGPB536nebwDYVlyw+ozG8/gB66p/IGmcAH7d0TxqntQJDAMfXm6atwIMbubPc0ZG8LrUCFxoWk0ykTQIVfc+4fnkHMYQTIJ2X7jB6vc+il7HiTILtyg7Wf+OytBjapQInx1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IaPloGT0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IaPloGT0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787838332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GWQxLxmMzGcN6gNyfg7urHOaVb9S7OFSIk+bbfaDvx0=;
	b=IaPloGT0nTT71QavwqoNYSk4ei0ehihvGnS2ze6ggKHRv7Rm4lsqCuqvlnl27M4CyOKvH0
	z0WTPBBqrZBlEV9X8v+U1iiEDJh0z5Y/y1HQsCrMsC+6cI5JLKi7pYqWn+MTRT/p1BeK8k
	9b9bS7IGH82NTvicu6s5kjfXRdT9hJI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-JQiS6e7cO1qbf0vLzEvi0w-1; Thu, 27 Aug 2026 09:45:28 -0400
X-MC-Unique: JQiS6e7cO1qbf0vLzEvi0w-1
X-Mimecast-MFC-AGG-ID: JQiS6e7cO1qbf0vLzEvi0w_1787838327
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a22bf0so352593a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 06:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787838327; x=1788443127;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CqL5GR4/LfSzZQaiC+djEvxjAQw4ctnck/dWaLycuXY=;
        b=jbde8xBp+Q1/F4N5amrQDxzA/CE2pFuuxtdtbGFoufnyfqoEtV+mhTEeAs0T3F0TMa
         0vVX7+dLbkIK0bqfTAfx3qCZ+vm7QIKFX5N6p3/B0VQeUHQCChiK8MnkZ3m90YWNKHSn
         qQDTRowRvTxg3ZSU7W/XuQqswMhZeYfOa6F/C0nan6e9esnaHHVX+jH7tHJxFBb0mKfO
         rt2a5caRYv0LZ6WPhWgrahIBItrlOGQR63nVEhsQHsDAaVrGJxrPVdfh2nGnRvxQQV+f
         x5o9JqNvZo8tPzzyCyQopfeHTw8dXmqdMmTs5JFKlK2dHZSdOprU1w+MEoDiOEE1NBvk
         mC8w==
X-Forwarded-Encrypted: i=1; AHgh+Ro1Y4byO0UJneKDz7hhLoEC5z0r7fV9gdAhqfO5QNtn5tUcxs81cZaohiEbQo08rsoKAtxtwF2WBWQ5Opcv/b00f8Y=@vger.kernel.org
X-Gm-Message-State: AFuF++nBm9OsunLtyEcQWwy3H4BvymZLFhIeKLU+WYD/w1vtEShvs0sA
	ssPDljaKEAmZ//CfEgOcDEigAlP6tuTK9kgjBWLDa+m83kf0gWK/qAOc3VEyh9HlmsTO3xvm1v+
	FWW53qRgHNRI+EwYNY8UQHu7GzaYzdDJLstvHXDjm+hydzc19xA80ATpdCW1WYGewqJ+YQwSzAQ
	==
X-Gm-Gg: AR+sD12+/8sJGbF2s8oTEzJALSY8xgmnaJqFk4X5eQELcemzj4fp92R/96OUR/Oe+HD
	zSli6tAv7estLOQjXg+y1ziTimqGIF6Zzn/0i2EqiuFKyIkX79NrPq0d5Crhl9OESBdrCxXpe5+
	rITwTRGZfo/TXbUhC8gFb5n1m6bxer5tXuQBvOGPE022X4QTQ9IsJsvbupy1WCeef0uv8F3Tz/8
	cw7LktTZ1FmwvYSTRhi5PEZPLp+Qd4QC3mHfTlAIgIrQmgX1gO0EGttm6hYWVcU/hArv2zFdDT9
	UMzheMvXJpRkNqoyXIL5nZvDJkx7QR/8YU+sYrz+uj0JENwMLX3H3SKWh3AVNTcuXYFropxLWO7
	oPCjXGGyiqlwPvHZF8OsLCTDP4cXsOagI9KuFLVitRNALh3AyFIyvwMqYQczLesQMjcmcng==
X-Received: by 2002:a17:907:97c3:b0:c25:378c:6262 with SMTP id a640c23a62f3a-c25378c6a8emr504967366b.22.1787838326700;
        Thu, 27 Aug 2026 06:45:26 -0700 (PDT)
X-Received: by 2002:a17:907:97c3:b0:c25:378c:6262 with SMTP id a640c23a62f3a-c25378c6a8emr504960766b.22.1787838325861;
        Thu, 27 Aug 2026 06:45:25 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a73041asm818532066b.28.2026.08.27.06.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 06:45:25 -0700 (PDT)
Message-ID: <abe07f686da0a2127a9078d55cf5e96c41611eda.camel@redhat.com>
Subject: Re: [PATCH v6 2/9] rv: Add generic uprobe infrastructure for RV
 monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 27 Aug 2026 15:45:23 +0200
In-Reply-To: <16b5866f7425a94d42ae370e8e6974911ced9513.1787243842.git.wen.yang@linux.dev>
References: <cover.1787243842.git.wen.yang@linux.dev>
	 <16b5866f7425a94d42ae370e8e6974911ced9513.1787243842.git.wen.yang@linux.dev>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -XXmEmDr9Ez35oIu21fnYDYV15DIz8F0AtP5xNgVbXo_1787838327
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-08-21 at 00:45 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
> +/**
> + * struct rv_uprobe - embeddable uprobe handle for RV monitors
> + *
> + * Embed via DECLARE_RV_UPROBE() and pass &name to rv_uprobe_register().
> + * The caller may free the containing struct after rv_uprobe_unregister(=
)
> + * (or rv_uprobe_unregister_nosync() + rv_uprobe_sync()) returns.
> + *
> + * @uc:=C2=A0=C2=A0=C2=A0=C2=A0 embedded uprobe_consumer; set handler/re=
t_handler before
> registering
> + * @uprobe: registered uprobe pointer (NULL when not registered)
> + * @path:=C2=A0=C2=A0 path of the probed binary, held until unregistrati=
on
> + */
> +struct rv_uprobe {
> +=09struct uprobe_consumer=09uc;
> +=09struct uprobe=09=09*uprobe;
> +=09struct path=09=09path;
> +};
> +
> +/* Embed a named rv_uprobe inside a caller struct */
> +#define DECLARE_RV_UPROBE(name)=09=09struct rv_uprobe name
> +
> +/**
> + * rv_uprobe_is_registered - test whether an uprobe is currently active
> + * @p: probe to test; may be NULL
> + */

I think kernel-docs for functions should stay with their definitions (in
rv_uprobes.c). This header should have kernel-docs only for what is defined=
 here
(structs or inline functions) and the source should have complete kernel-do=
cs fo
r what's defined there.
Use /** only for complete kernel-docs. You can validate it with
tools/docs/kernel-doc .

> +bool rv_uprobe_is_registered(const struct rv_uprobe *p);
> +
> +/**
> + * rv_uprobe_register - initialise and register an uprobe
> + * @binpath: absolute path to the target binary
> + * @offset:=C2=A0 byte offset within the binary
> + * @p:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 caller-provided rv_uprobe (em=
bedded via DECLARE_RV_UPROBE);
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p->uc.han=
dler and/or p->uc.ret_handler must be set before this
> call
> + *
> + * Resolves the path and registers p->uc with the uprobe subsystem.
> + * No heap allocation is performed.
> + *
> + * Returns 0 on success, negative errno on failure.
> + */
> +int rv_uprobe_register(const char *binpath, loff_t offset, struct rv_upr=
obe
> *p);
...
> +/**
> + * rv_uprobe_unregister_nosync - dequeue an uprobe without waiting
> + */
> +void rv_uprobe_unregister_nosync(struct rv_uprobe *p)
> +{
> +=09if (!p || !p->uprobe)
> +=09=09return;
> +
> +=09uprobe_unregister_nosync(p->uprobe, &p->uc);
> +=09p->uprobe =3D NULL;
> +=09/* path held; caller must call rv_uprobe_sync() then path_put(&p-
> >path) */

This comment isn't necessary here if you have the kernel-doc up-to-date.

> +}
> +EXPORT_SYMBOL_GPL(rv_uprobe_unregister_nosync);

The implementation looks alright, but I still need to test it.

Thanks,
Gabriele


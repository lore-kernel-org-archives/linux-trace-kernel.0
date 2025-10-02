Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EE030FC22
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Oct 2025 11:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759405354; cv=none; b=SltVC5Ho2Ib2q5z6GaYFMgmcrZFjNNsYZJBhZlCdVli8g8h87KMrXI6htm86E0tPknha18Qr4JJsDshCSHNHOrFCh2cf478s4mBiY5GmWjaYemxavbk7tlRf0r88nU8eAErWMT6tjO7MYf7ZRaN18NAat5Bc6nG24O77skaPbkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759405354; c=relaxed/simple;
	bh=wXK7zsjJiBTLEDX4TzLrlZCb/qq1/pF+eUcI8C+X+oo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S70pr9jjdVHH1PvqeEoe1QlqGEsImc5Tli7eMGku6mQUtD9mWVsbcci9mj8IhvyKawh/73XyCCdvjxDYK945SDx3jBkQPFmKZXdxTgXT2u0XDxeKu85MDt4HTTS/jYnJwGNgSVaCV2SsK1qONwkjwoJ3AAyDsX8F2NQX2sTWLpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UZn8TZ71; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZn8TZ71"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759405351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wXK7zsjJiBTLEDX4TzLrlZCb/qq1/pF+eUcI8C+X+oo=;
	b=UZn8TZ71/OZSjuSZZ9W9Kk2mb0LW2RuVIYIxEZyjGXfooTdSHbmK4NncE2BT1CAPssQrgl
	UPR6zA3GzV0Xf0eFF33sOcIS5JyxuBO0b9uzHiYcYHU+dMhQT8QIE280Xsw79mv2IdtEeA
	VFuhyEAeP5KUX/VMvNaSrGJ6GwzDDrs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-HakqGWEQONWm6xVBrj5vrw-1; Thu, 02 Oct 2025 07:42:28 -0400
X-MC-Unique: HakqGWEQONWm6xVBrj5vrw-1
X-Mimecast-MFC-AGG-ID: HakqGWEQONWm6xVBrj5vrw_1759405347
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e4cb3e4deso9306745e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Oct 2025 04:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759405347; x=1760010147;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Ej62FVOQq6zEj2u9bPFI8FOph7VYHFWyQUQShm6AY8=;
        b=aXuctdqGM9NlHXpUwRSZpIWwytbxrxJJDd0hS0EKMqyHBcEFxE3lpe1us1FuLTMOZU
         dMPdpvIvThpGkLrrIRbihYXP+qhq2vqu4atYwFzQMBXyUaJMhjBif50pVkivUeIfIg6w
         LJfbBpH0nG54YEuqVF3FWvI6pF+IJUMUYtlNaCMpDLEEJKhHlipZtu4DVjo/SzSPK5Bz
         JetMwUdjnQPLFSefzIHKuAMWrUjJVTykmRaufPhensROGzwV4IK0dLlojjI91APwbmnX
         QWT5G++632q7YgdY3bPZzfqyw/z0Yfu+I3S6DeHMdl+Imh1rCvUuhE34oQ+7+HWmzCSm
         EpKg==
X-Forwarded-Encrypted: i=1; AJvYcCXMrmYuh+L8GnEjorFqyBvJW+sXGWV+YYS3HYa9l4pIyxQtCulfQn2ISyABvCwhEFoWVct9Y59P3Lvwt30+fggS/NE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj4N1QXMZ7tpEDYKAFJtUhu0p3Z7RBNy/8sNQx374LUu9mNdzw
	ytvPANU0vftitw6l7uaHKRORYD051jXgXpCjnHxep+xVV2/fhvCmAS4VK6HJz7THu1FemRKXHLy
	pk020G+rdYjjQl5VGqNk5vNtFIT/Seu2RonhpLxa2hkfiTL6QOUadEAIa7TdZQCuubj82iO55Bg
	==
X-Gm-Gg: ASbGncsVaq1a1hbpk2BWkpfQe+7mIw7Jp0FcnQm26AN14hbfJG1/+bbyDTSqJb9xfTU
	21ao8DGQOwzBn646oCprmEmP622lxwxwZM7eV4sW1MWehrxYXhNqcC8GREc1zcNaqJzKtBW+a4+
	hlZTPwNXVSEGEkkIUd6pkb6ZdgdOgJ6/1oY3Wv1n+k9MvOuuAHeet1Hvmqxy8SSiLTjzQ03pKUa
	RxiOjVevs7VWnDo0wmLMOM4zam0YL/TxoFrDjLka4V0LUq8XnsIzpcJWOZ01DaF2oOUdUJ6BsBV
	bdenza7TZtwa1MgPIjeMxIJj+Av58/d5zO0gfmmuLe6lJRRI1idGtPu8751xnyQSKUI1MpA=
X-Received: by 2002:a05:6000:1887:b0:3d3:b30:4cf2 with SMTP id ffacd0b85a97d-4255d2b3268mr1947652f8f.19.1759405347102;
        Thu, 02 Oct 2025 04:42:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQBsRd3QbWjCawGUT/34IGA9DqiAFCCG8hAG/sJP5Zufv3lc6VVpYan82fkDtRhahnnjowCw==
X-Received: by 2002:a05:6000:1887:b0:3d3:b30:4cf2 with SMTP id ffacd0b85a97d-4255d2b3268mr1947631f8f.19.1759405346651;
        Thu, 02 Oct 2025 04:42:26 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f45e9sm3335434f8f.51.2025.10.02.04.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 04:42:26 -0700 (PDT)
Message-ID: <77c1e6213e1c250ad8bf57849d8c90dfd2f105d1.camel@redhat.com>
Subject: Re: [PATCH 1/2] rv: Fully convert enabled_monitors to use list_head
 as iterator
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	stable@vger.kernel.org
Date: Thu, 02 Oct 2025 13:42:24 +0200
In-Reply-To: <20251002082235.973099-1-namcao@linutronix.de>
References: <20251002082235.973099-1-namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AClCGAf8rgPLLkQa_MaX9QKWZ9iMdCYuEwGBNNS3X7E_1759405347
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Thu, 2025-10-02 at 08:22 +0000, Nam Cao wrote:
> The callbacks in enabled_monitors_seq_ops are inconsistent. Some treat th=
e
> iterator as struct rv_monitor *, while others treat the iterator as struc=
t
> list_head *.
>=20
> This causes a wrong type cast and crashes the system as reported by Natha=
n.
>=20
> Convert everything to use struct list_head * as iterator. This also makes
> enabled_monitors consistent with available_monitors.
>=20

Looks good to me and passes my tests.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele

> Fixes: de090d1ccae1 ("rv: Fix wrong type cast in enabled_monitors_next()"=
)
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes:
> https://lore.kernel.org/linux-trace-kernel/20250923002004.GA2836051@ax162=
/
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Cc: <stable@vger.kernel.org>
> ---
> =C2=A0kernel/trace/rv/rv.c | 12 ++++++------
> =C2=A01 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index 48338520376f..43e9ea473cda 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
> @@ -501,7 +501,7 @@ static void *enabled_monitors_next(struct seq_file *m=
,
> void *p, loff_t *pos)
> =C2=A0
> =C2=A0=09list_for_each_entry_continue(mon, &rv_monitors_list, list) {
> =C2=A0=09=09if (mon->enabled)
> -=09=09=09return mon;
> +=09=09=09return &mon->list;
> =C2=A0=09}
> =C2=A0
> =C2=A0=09return NULL;
> @@ -509,7 +509,7 @@ static void *enabled_monitors_next(struct seq_file *m=
,
> void *p, loff_t *pos)
> =C2=A0
> =C2=A0static void *enabled_monitors_start(struct seq_file *m, loff_t *pos=
)
> =C2=A0{
> -=09struct rv_monitor *mon;
> +=09struct list_head *head;
> =C2=A0=09loff_t l;
> =C2=A0
> =C2=A0=09mutex_lock(&rv_interface_lock);
> @@ -517,15 +517,15 @@ static void *enabled_monitors_start(struct seq_file=
 *m,
> loff_t *pos)
> =C2=A0=09if (list_empty(&rv_monitors_list))
> =C2=A0=09=09return NULL;
> =C2=A0
> -=09mon =3D list_entry(&rv_monitors_list, struct rv_monitor, list);
> +=09head =3D &rv_monitors_list;
> =C2=A0
> =C2=A0=09for (l =3D 0; l <=3D *pos; ) {
> -=09=09mon =3D enabled_monitors_next(m, mon, &l);
> -=09=09if (!mon)
> +=09=09head =3D enabled_monitors_next(m, head, &l);
> +=09=09if (!head)
> =C2=A0=09=09=09break;
> =C2=A0=09}
> =C2=A0
> -=09return mon;
> +=09return head;
> =C2=A0}
> =C2=A0
> =C2=A0/*


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA69480DE3
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Jul 2026 11:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907060; cv=none; b=jpFGdJ+dYigBY9UMgg29ZK9X6Pi2Hp8ueRQPnecap2TxGXBFWtKAlAC4XrYP5K/kP/7YcD+Uc1AkLiglmBEpebRANltji9PmO/N7K8oBb0kahv8gWo1K2N/gQiWMtp9jeD+kKPQ5JaY12KPnuO4LqZhM8SWTNAWuGYOi7/Lng6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907060; c=relaxed/simple;
	bh=GKzO/WyD4D/mbF6c/AmcKtFnDY+JtxUxoljaWdrLzQM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PixniNAVht1Ki9IVa3nEXsShNOQVVsZpo/8zOVyOsXcGv7txe3Xe+WmxS2uWlHgc0KqL1sOYORlqnoHldAodEERgFHwQn6Xglonk3O6WJqtfqw251DDL/JMXpDnLJC+hRdDaZAtFR/2BUQ7in4n65PeuxggZOo2OorzXbo5vknA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WEOp4lly; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WEOp4lly"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782907055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GKzO/WyD4D/mbF6c/AmcKtFnDY+JtxUxoljaWdrLzQM=;
	b=WEOp4lly61DLuM/TA3Z4QfoqWlChOxTZgsJxEcSKKvEXCPkdvP6QcPRDAAumqghpyWrYKR
	Fcyv41FeG/WOuumDIIycdn7UECFET+o+u/EE4w2m7L5R2VegWIMv5KYvhmCdhQVkNcQI75
	esFo50JEDMtxpUMQGfzOulGz5tjrwU4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-bPK3ZYf4O6uoR28aH-Wkwg-1; Wed, 01 Jul 2026 07:57:34 -0400
X-MC-Unique: bPK3ZYf4O6uoR28aH-Wkwg-1
X-Mimecast-MFC-AGG-ID: bPK3ZYf4O6uoR28aH-Wkwg_1782907053
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49244130073so4732905e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Jul 2026 04:57:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782907053; x=1783511853;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GKzO/WyD4D/mbF6c/AmcKtFnDY+JtxUxoljaWdrLzQM=;
        b=WvsyCmqstjtno8rhsojT7lBfvib18WAkE8lN3a2pUXyBhPRJWv3ad1fzQmZzqAjDga
         gAZdZWnowLYIv2HYG6w6hxftxy06wXcz+gtDPz+LcLn7zkTmc4pZyvYfyJg73UhfX4jg
         c0HwV1rhhc7z9iIeflJjaUnSNyArx/IckC+xBurkClMa+bkS9f5Au3oPi5wmA6mGKTz4
         wsUc/9KgWuYlNNUNQaXi0VZlfLSmJQWwdxpIy/VAdroZiOCTixcFtClORNq+Jj9GmNgb
         aGc91xzfbGBNgY4t9r2WYh91L/LZ5UlWaCDSkg4E96ztLUOeeAPNkyH7AnhirmK0wfC+
         oSPg==
X-Gm-Message-State: AOJu0Yzr2LT/7JJc8urAvRZxIJhehciZ7UJB81l3kCwPhXYbg/7N7GPI
	b1klXHZzBQ25w0J1GIUzPLpnuoZW5NqbNHGpQFebiT4sW0IVNUDRqivKC/X0R6eYyNo60ahcCs+
	2+3d0ocI0NYTl8/tUWMOT4ReJHwm3HcL8T3DEGlIFJqEGQ05sdM5NxtqEGZzj19MWjWBQsqlAMA
	==
X-Gm-Gg: AfdE7ck0qPO6NXa5iMsCLuSvprDJc2t0irfBrj2q/eOQu2piglxCtV8p0g4dsOaEQ4x
	Oz7H1orq7sf1bV+sj/i6PA/2oaGXnphRC5+5v5C7EW7+MTfe76v8T811MdosZsUq2tQTm6wnlhT
	t2vmAxcl5PonldNO/FN6uQEXmD0EQLtwHsTFzBchbJkVcIAl6Q3N4H1t3KqPHtBszXVgWi1jyNs
	AjcorNKaF1RGrqp/mf15XInFghPJx8lefIgky2f4eGcd4dZOSvSYelS4BJ9iNLxONqKA7CvNnRe
	c7YgCPOh/QFmc6KKkB2uxVJtEQLW4VnW/Kdt5cg+rhWsheIJHYNbul3Cv4ZCJijoHsFDLrUPySv
	xX7rSxrcu3UWi3PrvOLbK9n2NdiGRAsL3HL3scqmHoWdI26Rwea5jROFBg3FUiSMR+DqiuY7OLD
	xvY/D8
X-Received: by 2002:a05:600c:35d0:b0:493:c3cb:409e with SMTP id 5b1f17b1804b1-493c3cb42d9mr5624735e9.15.1782907053499;
        Wed, 01 Jul 2026 04:57:33 -0700 (PDT)
X-Received: by 2002:a05:600c:35d0:b0:493:c3cb:409e with SMTP id 5b1f17b1804b1-493c3cb42d9mr5624465e9.15.1782907053164;
        Wed, 01 Jul 2026 04:57:33 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be810be8sm67046565e9.9.2026.07.01.04.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 04:57:32 -0700 (PDT)
Message-ID: <e8e6c6ddb99e096b2daf2a88891cdce703730bdd.camel@redhat.com>
Subject: Re: [PATCH v3 2/9] rv: add generic uprobe infrastructure for RV
 monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wen Yang <wen.yang@linux.dev>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 01 Jul 2026 13:57:31 +0200
In-Reply-To: <d1e84072-7968-4a64-9497-09db83b38682@linux.dev>
References: <cover.1780847473.git.wen.yang@linux.dev>
	 <9d1a1d491af16853b2b421f358fd6cca965588ab.1780847473.git.wen.yang@linux.dev>
	 <a645534b04d9bf32f2c2caa5d2206bb87cfcb3e1.camel@redhat.com>
	 <878be1d4-2f93-4fbd-a1f6-b2b7836c9c44@linux.dev>
	 <ebde84b7c65cd6b01a1e8d124de0b1eaf0793006.camel@redhat.com>
	 <d1e84072-7968-4a64-9497-09db83b38682@linux.dev>
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
X-Mimecast-MFC-PROC-ID: Fqa8JpqH1kRBGymUcZMfyrdP2MwZ3S4H0wnTlBji83E_1782907053
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-01 at 02:44 +0800, Wen Yang wrote:
> Thank you for the patient explanation.
> You are right, and v4 implements the embedded approach.
> struct rv_uprobe directly embeds struct uprobe_consumer:
>=20
> =C2=A0=C2=A0 struct rv_uprobe {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct uprobe_consumer=C2=A0 uc;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct uprobe=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *uprobe;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct inode=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *inode;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 *priv;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*handler)(...);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*ret_handler)(...);
> =C2=A0=C2=A0 };

Alright, great. Why are you still using double function pointers? Do you re=
ally
need rv_uprobe->handler instead of just using rv_uprobe->uc.handler ? That =
also
simplifies one function call down the road.

Thanks,
Gabriele

> rv_uprobe_free() is gone =E2=80=94 no allocation means no explicit free.=
=C2=A0 After
> rv_uprobe_unregister() (or rv_uprobe_unregister_nosync() +=20
> rv_uprobe_sync()), the caller frees the containing struct directly.=C2=A0=
 In=20
> tlob:
>=20
> =C2=A0=C2=A0 rv_uprobe_unregister_nosync(&b->start_probe);
> =C2=A0=C2=A0 rv_uprobe_unregister_nosync(&b->stop_probe);
> =C2=A0=C2=A0 rv_uprobe_sync();
> =C2=A0=C2=A0 kfree(b);=C2=A0=C2=A0 /* frees both embedded consumers */
>=20
> This is the pattern from your sketch.
>=20
> Regarding my earlier reply that argued for the separate allocation: I=20
> was wrong. The key barrier is synchronize_rcu_tasks_trace() (called=20
> first in uprobe_unregister_sync()), which waits for all=20
> rcu_read_lock_trace() readers including handler_chain().=C2=A0 After it=
=20
> returns, no cons_node.next read is in flight and embedding is safe.
>=20
> We appreciate your thorough review. All of your comments have been=20
> addressed in v4.
> We'll run local tests for one or two days, and then it will be sent out=
=20
> shortly.
>=20
> --
> Best wishes,
> Wen
>=20


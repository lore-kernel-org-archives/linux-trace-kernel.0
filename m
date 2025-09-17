Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894B91C6FFA
	for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117464; cv=none; b=WXFOj/V1IS+/bbMah/eTZ74wtjMchnrt4WQlGZsZrVvp66OQWBS1g1HehehU4ZqgX9+C3P8ARrU9mOOUSa3IrwZ25RZs71y4E2lodYie7SSNjyZYALDyLLctVWJ5J3AfbSbpArmCfd1LlTbW6LMyo0Jes4Rrxho/4Gjj8u1Rxvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117464; c=relaxed/simple;
	bh=cnu/AlOq3yEvaOQmafeb++s6Qd9sABr4RnTPJGVFwlQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bqeCzTXD5Uvahfk0E6EaWOuNWNyZ1bgO2qfD92i0TjFKJXNlgeKk4Solu34LBmZj2ZDU/Tcoj3FY0nwwYgFVOtgYywbd5/BUMTZVrTcW7PHHVXcAhtf2qkmrNncsc5jzYNX4y9fQ3dw+v1vwRrROlc1OZ9/rgknsLJKPnqjPCfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZVXMhOW3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZVXMhOW3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758117461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cnu/AlOq3yEvaOQmafeb++s6Qd9sABr4RnTPJGVFwlQ=;
	b=ZVXMhOW3ZwkmfwNGUNYAw8ZRNzbFJ6CvrZNWL4oZmlcqbZiaF6vzcr4a93w+gLKsRB/uc8
	gpenHUiTxrB18mlQHOD5NNBz/gQqu3mlUNQXHy6qsNAnYV7EGHyxbDFtfC72qAtc16Dc2D
	XnkI20CkBAQYe/efdcn6sFMS9sKjQhg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-ShkMNKghOeqqJf39mbW7xg-1; Wed, 17 Sep 2025 09:57:40 -0400
X-MC-Unique: ShkMNKghOeqqJf39mbW7xg-1
X-Mimecast-MFC-AGG-ID: ShkMNKghOeqqJf39mbW7xg_1758117459
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3eb0a50a518so1176886f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758117459; x=1758722259;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vRrH1aSVxH9prBxDdrPIT+z71qgvJ3/IAVqgQ3ga1/g=;
        b=Rk3n368XbI5x1vhCTnyht2P2Ml8JW117QBve3/hQsOa4mvfYOe+A03wbqDnSuSkGR9
         rFoUPlXqryCcVxK8UNiRarJqKgPcRDihw6H5+Jx8xOx6LgX3zcXIlYUi8JJnn+XvyDtm
         t8uWTgJGyl/64OLszhBGXTjRLwzWNqMCNQ5e0YS9/FAlslAm154OrR+yH6qzQywcrdiv
         VpuRr/4m7ElhWem0RkqdpDjCXt4GJl8Yl7CczsXOhPcYuAjkLhxUARX7lHQxTwyuQaea
         MuWd2etm37nMzk496yg8jKcv2/Qghq+I4tKvwlUoeSrxDtk0KJ4lp3rEJe+WquD6i2PN
         ZkHQ==
X-Gm-Message-State: AOJu0YxtRZYyo/PhLGDSCQUBSl1aj7wt2ZQQa6fnbwI5QQkwV+6g1zZr
	/rQFgfH+L1H3Am7+Af57Y9lV3k8hTmSrhQSXlfPJGWvjXL6cRd1aPbdGoZyEyFlXEQFFIQImQW4
	kFmzQlThctrFXEzcqV9RIJzHWkHvtv5I4PWu/nLLTH1qyA50Krurjan9QHzqDxdAQE28g/BsB2g
	==
X-Gm-Gg: ASbGncv3ueyJdChbcxyGX79utie9qMF2OSkAWDDHVDsEdTJBBlruI5BZmY0zQgHxEuK
	e5HZgbBWvMG5IUJq5Z4GoQMWZFDf14Zri4N+eiZ4WquDH35QITaUbUNbrFhhv5pudbYjzxx+N90
	EIrsTUJI9HfLIt4ZTlQNxqQ7l0QSRCOYAk5f5tmamnPtNjWG17MSp51UWRO5qivsIWu57AhZ1jB
	AZ925ah7awv6wU+2gacaMeIA/9LPzcCowdj776An/mL9BTLa3SsLK7NYmQwqd8ECqn0NPt/s0Ig
	g8ffAemyLwWyrzaxIThPoXbLMj+Gd82UfDyii8UThrRehdLB++KXOYWkPdQqeACrkw==
X-Received: by 2002:a05:6000:2506:b0:3e7:5f26:f1d6 with SMTP id ffacd0b85a97d-3ecdf9af5b7mr2046912f8f.13.1758117459193;
        Wed, 17 Sep 2025 06:57:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuI6bOIzJVz42mHmQIDU0oQlOz0/AKrUJuaICSbonx63TdxAFqrJk7KpPJJTFucSos8pORGQ==
X-Received: by 2002:a05:6000:2506:b0:3e7:5f26:f1d6 with SMTP id ffacd0b85a97d-3ecdf9af5b7mr2046886f8f.13.1758117458694;
        Wed, 17 Sep 2025 06:57:38 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46139123102sm37927375e9.9.2025.09.17.06.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 06:57:38 -0700 (PDT)
Message-ID: <b2c19df4c5036e956e4e892ac983d5488a8b9614.camel@redhat.com>
Subject: Re: [PATCH] rv: Fix boot failure when kernel lockdown is active
From: Gabriele Monaco <gmonaco@redhat.com>
To: Xiu Jianfeng <xiujianfeng@huaweicloud.com>, rostedt@goodmis.org, 
	mhiramat@kernel.org, namcao@linutronix.de
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nicolas.bouchinet@oss.cyber.gouv.fr, xiujianfeng@huawei.com
Date: Wed, 17 Sep 2025 15:57:36 +0200
In-Reply-To: <20250917125733.2346923-1-xiujianfeng@huaweicloud.com>
References: <20250917125733.2346923-1-xiujianfeng@huaweicloud.com>
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
X-Mimecast-MFC-PROC-ID: IH9a-7W2G6S3H5LSPJs0Ye4JLPmCTXDL_Fdb3BqcqKw_1758117459
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-09-17 at 12:57 +0000, Xiu Jianfeng wrote:
> From: Xiu Jianfeng <xiujianfeng@huawei.com>
>=20
> When booting kernel with lockdown=3Dconfidentiality parameter, the
> system
> will hang at rv_register_reactor() due to waiting for
> rv_interface_lock,
> as shown in the following log,
>=20

Thanks for finding this, the problem was already fixed in [1], which is
on its way to getting merged.

[1] -
https://lore.kernel.org/all/20250903065112.1878330-1-zhen.ni@easystack.cn

> INFO: task swapper/0:1 blocked for more than 122 seconds.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Not tainted 6.17.0-rc6-next-20250915+ #29
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
> message.
> task:swapper/0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state:D stack:0=C2=A0=
=C2=A0=C2=A0=C2=A0 pid:1=C2=A0=C2=A0=C2=A0=C2=A0 tgid:1=C2=A0=C2=A0=C2=A0=
=C2=A0 ppid:0
> Call Trace:
> =C2=A0<TASK>
> =C2=A0__schedule+0x492/0x1600
> =C2=A0schedule+0x27/0xf0
> =C2=A0schedule_preempt_disabled+0x15/0x30
> =C2=A0__mutex_lock.constprop.0+0x538/0x9e0
> =C2=A0? vprintk+0x18/0x50
> =C2=A0? _printk+0x5f/0x90
> =C2=A0__mutex_lock_slowpath+0x13/0x20
> =C2=A0mutex_lock+0x3b/0x50
> =C2=A0rv_register_reactor+0x48/0xe0
> =C2=A0? __pfx_register_react_printk+0x10/0x10
> =C2=A0register_react_printk+0x15/0x20
> =C2=A0do_one_initcall+0x5d/0x340
> =C2=A0kernel_init_freeable+0x351/0x540
> =C2=A0? __pfx_kernel_init+0x10/0x10
> =C2=A0kernel_init+0x1b/0x200
> =C2=A0? __pfx_kernel_init+0x10/0x10
> =C2=A0ret_from_fork+0x1fb/0x220
> =C2=A0? __pfx_kernel_init+0x10/0x10
> =C2=A0ret_from_fork_asm+0x1a/0x30
>=20
> The root cause is that, when the kernel lockdown is in
> confidentiality
> mode, rv_create_dir(), which is essentially tracefs_create_dir(),
> will
> return NULL. This, in turn, causes create_monitor_dir() to return
> -ENOMEM, and finally leading to the mutex not being unlocked.
>=20
> Fixes: 24cbfe18d55a ("rv: Merge struct rv_monitor_def into struct
> rv_monitor")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
> =C2=A0kernel/trace/rv/rv.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index 1482e91c39f4..e35565dd2dc5 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
> @@ -805,7 +805,7 @@ int rv_register_monitor(struct rv_monitor
> *monitor, struct rv_monitor *parent)
> =C2=A0
> =C2=A0=09retval =3D create_monitor_dir(monitor, parent);
> =C2=A0=09if (retval)
> -=09=09return retval;
> +=09=09goto out_unlock;
> =C2=A0
> =C2=A0=09/* keep children close to the parent for easier
> visualisation */
> =C2=A0=09if (parent)


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D8D1E5B6F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Mar 2025 06:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741762643; cv=none; b=VmyRtXffrO34orhtOdFZLJjJPDNbuW/Kv8YVgsNOCk41IuHZM6SMflCusd7XAyBFxQyFB6tGBV8cpLZXNgqq59Ulh5EOaU0GGbrruV9g54C3nDcrlnxlX4eWCAym26hufsuugwDdfuw4DobHfXjlPTalf0fAIxNUyDL9FRMMPcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741762643; c=relaxed/simple;
	bh=Edom/xOL39at/W86FkiT/aqeMxav/v4I7zuZUvzIm94=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BoOaPieA/KwiLSOLYiTVd5mtk7gxCSwGLtWc4+n6vq7VtWGY/1bJ0AWeOug4PcLS+pLK8tN7u9EGKbUYa2KW8il9b/ofOOeIoCl0guSjIJ5TFpBY4aIQcSj1/meCYN2QtJdLlSRRz0yY80w6vrTbAMHyDcBH4K+4GSVvkQOF0gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N+TrUd1V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+TrUd1V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741762641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Edom/xOL39at/W86FkiT/aqeMxav/v4I7zuZUvzIm94=;
	b=N+TrUd1V+I6cIG/g8hp1UXPxtbORWXjM43vJUNsWU9OSi0zAfBbKA0oMuiRtAj5nfdBoLl
	KqI/LWUo4z4L5chhzPwuCzp9fTBqcceD5ERbevNrd6b5WuRRwjN0rlSmFKxA0rL1rMHo0p
	UqURv8LkS5wHBzAZw8C8WRpbXKpj/TY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-UtuPJE6SM4yW5p3WTt-f-w-1; Wed, 12 Mar 2025 02:57:19 -0400
X-MC-Unique: UtuPJE6SM4yW5p3WTt-f-w-1
X-Mimecast-MFC-AGG-ID: UtuPJE6SM4yW5p3WTt-f-w_1741762639
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-391425471d6so1355097f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Mar 2025 23:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741762639; x=1742367439;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D/T6VZ51OxElvIx263fopdHYKj4WI3VHYEX8QXJymOA=;
        b=iT0USCH+yMmrgmniPzfgzCRMswXDd7rOcxjdpiTfXTvX7jnxfCxP2I2rbZEbQgXZIb
         LxhTlAhDXTLgyWFD8zEFqgVzBt1EKxPA5XeCfCaVamp8NSmIWEScTtMufeKIQSC4xYSj
         xpf+0IxXusWih1cewXhghl1T5bFMZ1cRMecRMBzjFmjNnl7yKoGDyRHzvo+bYclDSPvR
         e9nRzjmMZZAYuaDzd9cYRhqHndWxRPPK5UK2sCJj8KAUnEsDmIuktNuZb6v2Ab1ysQrR
         gL9G2G+Jqe8vtXXZWeXjycLV2QX9H6SISABLNUOdvQ6wISuEP3iSO4uubqUT5O+iddfI
         B4kw==
X-Forwarded-Encrypted: i=1; AJvYcCUOJKCnLFhiQ4pEs69pDsxeaZHtA58igJZ+2GM7BgzD5UC5OESE6+R0C84E7HexK9mxtxA1m/HtIAsNaYVQBv+q2/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTjEYnYNNPlvWfrC4Hp1SgOp++FXD/SQBqm1ChOjjj17M2RuYr
	cl3JKYprcPgCDcaDd/lNWcrJceMXn0bx4aZvaF0hhHNiB0tRlIpqU3gtBuOoYFxTEPXvs+5eha7
	8VV94pohaWAHEgAEopTUwculXwaeSEoGKH288uxk4RAPxte1e2+VAwNuTzmWzsFOE8hUH3Q==
X-Gm-Gg: ASbGncvcE2BNJqWChztZQUlCsnCm1r30Eo6zfiOcRg3Wm8EuTLLrBEVfibGmsT+dPAO
	+tzjkHFyj5texpx/0Z5f8kznwUFi1V16EkmJH1lNvv6V+gBbvlxTdxz118FiwYERoCmNCwRTuNr
	j6aeahdyc527MsDvJ6P0tndRW64an7nGe94PL7UW0CJdkOBlcF81nMs/1GoTYWJO/WpAnxb1ra+
	9jkM+c/MDCxfSzaorGQWac6pTozCJ6MyamBpovGqahjBe1k7LwFgH91dm6KxGE6PLWfD5aNGrGL
	kc77wgpHiwZqMLEXbZpnASk2jGo59zYUWahiphfw4Q==
X-Received: by 2002:a05:6000:178d:b0:391:300f:7485 with SMTP id ffacd0b85a97d-39132d20ce3mr13892362f8f.8.1741762638756;
        Tue, 11 Mar 2025 23:57:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEB2R+Abn/HbQu8JTjfd7VvjZqSMksnSyKTyI92bFesczk8jr9hcPiHcT/8gs/MMH4A/5tWrA==
X-Received: by 2002:a05:6000:178d:b0:391:300f:7485 with SMTP id ffacd0b85a97d-39132d20ce3mr13892343f8f.8.1741762638386;
        Tue, 11 Mar 2025 23:57:18 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e34fasm20308143f8f.75.2025.03.11.23.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 23:57:17 -0700 (PDT)
Message-ID: <5ed67309a14e9971fa46bdaf2ae2cd3f5db60fe5.camel@redhat.com>
Subject: Re: [PATCH 10/10] rv: raise the number of per-task monitor to 2
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, john.ogness@linutronix.de, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 12 Mar 2025 07:57:14 +0100
In-Reply-To: <8ebb6cc8f566eaf6c62eef8391e930dbac10d66b.1741708239.git.namcao@linutronix.de>
References: <cover.1741708239.git.namcao@linutronix.de>
	 <8ebb6cc8f566eaf6c62eef8391e930dbac10d66b.1741708239.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QF4t2kQTnbv__IaX1VBCwBi9qPyNjGJQpIqer1KHkFY_1741762639
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-03-11 at 18:05 +0100, Nam Cao wrote:
> There are 2 monitors to check realtime applications. Users may want
> to
> enable them both.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> =C2=A0include/linux/rv.h | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/rv.h b/include/linux/rv.h
> index 6de4f93b390e..224c2194f582 100644
> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -44,7 +44,7 @@ struct ltl_monitor {
> =C2=A0 * adding more or developing a dynamic method. So far, none of
> =C2=A0 * these are justified.
> =C2=A0 */
> -#define RV_PER_TASK_MONITORS=09=091
> +#define RV_PER_TASK_MONITORS=09=092
> =C2=A0#define RV_PER_TASK_MONITOR_INIT=09(RV_PER_TASK_MONITORS)
> =C2=A0
> =C2=A0union rv_task_monitor {

I was thinking this value could be defined in Kconfig. Here you are
adding two monitors that belong with each other, that would fit nicely
with nested monitors [1] (patch waiting for final Ack).

Your monitor (let's call it rtapp) would require 2 slots and you could
enforce that in Kconfig.

Of course you don't have to add it to this series, but just as a heads up.

Cheers,
Gabriele

[1] - https://lore.kernel.org/lkml/20250218123121.253551-5-gmonaco@redhat.c=
om/


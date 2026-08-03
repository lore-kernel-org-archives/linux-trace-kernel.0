Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF583A1685
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Aug 2026 06:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785738972; cv=none; b=tZtdgmWXswWXk2QG2wLmHcEmeSRx244rtPstsSoWn9FNTVUHRhzFdpeQGctKycA0pSn+k0dRpEi4sKdcDTB3HziRrkeDf4HGC09zCqK3y2nlO4SoSx+DBXgtVKrkYtntpvZiYyg8Q6XQa3u6OegiIHElUbhQb9lILDSX9rqYruQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785738972; c=relaxed/simple;
	bh=qe58jRsFT9ppS/jPsQYvFZw6SjfEwMQiBXUmYFmiVzg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lhi5YruW2O3qSeQMppGj/qldkT0ih4IQxcktxb9gWcGVj4GBtoWjNaJiqRkRud26vEhNv/NNuk5tnIps98rk+jN9dHAjKiSxfiLpn8/ICJ9CUOXGhjjPXIVUkbsBCMN7TQ4mRZKH0bGnol+xbfFueX2UWMtxGzHoP1VtN+sKvSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LVFqZ98T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LVFqZ98T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785738969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qe58jRsFT9ppS/jPsQYvFZw6SjfEwMQiBXUmYFmiVzg=;
	b=LVFqZ98TpS0TlpBtJFyFCUX3j97u1fJSTkYUkj1TQI/wl4KqVJVIoVpeT9ZMMZBEcGzTFJ
	pwrg/zvLMvGq+YqJhQCgNUfu1oY7GiJK1mMJydUppteYj2S2UUZj/ft5813PkTkWHa3gsB
	y3n8OcYHLgleXShV+wQhYv02uJ+tROQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-kJvqunQJMW2q9q2M-TVpGQ-1; Mon, 03 Aug 2026 02:35:56 -0400
X-MC-Unique: kJvqunQJMW2q9q2M-TVpGQ-1
X-Mimecast-MFC-AGG-ID: kJvqunQJMW2q9q2M-TVpGQ_1785738955
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47407691804so2283067f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 02 Aug 2026 23:35:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785738955; x=1786343755;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=j97nUM679ILSO2OJT5uVm1JNmnswxH5ehx4we/pp/9A=;
        b=WBD+FOdewTyb0XLfgRAiKSoO/d0Gt+Ox7E/a3eBmj7dfla6fT2CEK0WkPwRWEyzoaS
         UhQazcA32j0aJy8XEqrNjzri9kAVwR5M9tgf4aqbcd6fS8pq3kO/4WSW0Ym9cl3vnyno
         hhUu7X6gNN+j7gPT1rCpXGawgJ61dLKjcZwcjkLJNoGVROp0eQaJL7dvALFV3wgEHLXb
         4m7jIyJXPrA3V8q7py+NGPFPoXCwmVMf3pQb9aEOpWVW+haBUFNWLz2NDcrPm0CCJf8w
         Uq3QUVJW9qcvqwnFvSa2Gcmqa0ktqXUlM4OjREHudXWbA8hLU9vVVQi2G9O4uT/rtd1K
         4Luw==
X-Forwarded-Encrypted: i=1; AHgh+RrqxRAoP4qHzvHxcNSpqWX5qaRJDwXX9XGk5AgPzBQHSZstT0wtL+/Ayje36utIC36e79Cvuj24MyPdHipcCRZIxrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw194VEcO6NKXtmhnetjHVrGko+7FGVHWLKp4MieexK7rEhIqYW
	1NorB25HMTVSk8yx1782U6lgRXFTm9OhrKVGcRSpOaWDhuVp4Yfq8ntY9JQkl4wlWSLAw1zf9or
	qFsGdN5+uDn5ZwUbVnSBNq+k4xMOQh6mLcRcnRAqC89tt9tDk42gu1iv+r+SMnJBNNkD1uj3gK1
	WtgQJmVA==
X-Gm-Gg: AR+sD13p6hiftFRLzFIqqFfN+c/y6UWNBY+WADG8/n6zubBQD9dDurrNQV1KwP+TFwk
	LZDqIZQCCx5pxSQyWzIdOx/r3xXah9DCaXEAvAxqYD2rIbH3xMbRMBqND2xFaMSyDaNri1YyXD/
	nXXpxmtwjGAMsxhfFJny86WfuBpUiobPHCvh1kL0JQy0299LbIuDITBClXJfxVeHPjfZ+MbHdgm
	pPzwgnD9gkv4DvykEPDCNAKiBaKHLHgAHs59jPgH0ltfvSlXn/E3ElfJmp7+G0fEfOKk+0wi3+6
	7gNZwtcOxtap2lWP2qRJgRt3Ssohp334zjcQp/Yo0Dbs97kbRVuflH2LGGXef4PdXwoga0qfPTi
	yslK80E2pd7OkbiUF3gV57xxmkQIO
X-Received: by 2002:a5d:46c1:0:b0:47f:8b9e:f457 with SMTP id ffacd0b85a97d-47fd72b0552mr15007962f8f.17.1785738955068;
        Sun, 02 Aug 2026 23:35:55 -0700 (PDT)
X-Received: by 2002:a5d:46c1:0:b0:47f:8b9e:f457 with SMTP id ffacd0b85a97d-47fd72b0552mr15007927f8f.17.1785738954669;
        Sun, 02 Aug 2026 23:35:54 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41cf404sm29281638f8f.1.2026.08.02.23.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 23:35:54 -0700 (PDT)
Message-ID: <489b764f5add05c08a468dca02b6c0f0d8197a90.camel@redhat.com>
Subject: Re: [PATCH v2 2/4] rv/reactors: propagate rv_register_reactor()
 error from reactor init
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 03 Aug 2026 08:35:53 +0200
In-Reply-To: <76b672af7c3eed78582ae90fcbf4736a76783df5.1785695669.git.wen.yang@linux.dev>
References: <cover.1785695669.git.wen.yang@linux.dev>
	 <76b672af7c3eed78582ae90fcbf4736a76783df5.1785695669.git.wen.yang@linux.dev>
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
X-Mimecast-MFC-PROC-ID: ABNl6-b0xifPHgZgTE2Av_BO62DbFHsHmkHKZRB2h1A_1785738955
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-08-03 at 02:43 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> Both register_react_printk() and register_react_panic() ignore the
> return value of rv_register_reactor() and always return 0.=C2=A0 If the
> registration fails (e.g. a duplicate reactor name), the init functions
> silently report success even though the reactor was not registered.
>=20
> Propagate the error from rv_register_reactor() so a failed registration
> is reported instead of being silently ignored.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

>=20
> Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> ---
> =C2=A0kernel/trace/rv/reactor_panic.c=C2=A0 | 3 +--
> =C2=A0kernel/trace/rv/reactor_printk.c | 3 +--
> =C2=A02 files changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/kernel/trace/rv/reactor_panic.c b/kernel/trace/rv/reactor_pa=
nic.c
> index 76537b8a4343..db7116ceafff 100644
> --- a/kernel/trace/rv/reactor_panic.c
> +++ b/kernel/trace/rv/reactor_panic.c
> @@ -26,8 +26,7 @@ static struct rv_reactor rv_panic =3D {
> =C2=A0
> =C2=A0static int __init register_react_panic(void)
> =C2=A0{
> -=09rv_register_reactor(&rv_panic);
> -=09return 0;
> +=09return rv_register_reactor(&rv_panic);
> =C2=A0}
> =C2=A0
> =C2=A0static void __exit unregister_react_panic(void)
> diff --git a/kernel/trace/rv/reactor_printk.c
> b/kernel/trace/rv/reactor_printk.c
> index 48c934e315b3..002a10f6aa7b 100644
> --- a/kernel/trace/rv/reactor_printk.c
> +++ b/kernel/trace/rv/reactor_printk.c
> @@ -25,8 +25,7 @@ static struct rv_reactor rv_printk =3D {
> =C2=A0
> =C2=A0static int __init register_react_printk(void)
> =C2=A0{
> -=09rv_register_reactor(&rv_printk);
> -=09return 0;
> +=09return rv_register_reactor(&rv_printk);
> =C2=A0}
> =C2=A0
> =C2=A0static void __exit unregister_react_printk(void)


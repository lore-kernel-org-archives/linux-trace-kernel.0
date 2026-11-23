Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795425044;
	b=qUnVYf+bd88RANJdA5w88woS/dkBOz7DUyLfp0y23CVMUiayr9uEDpVz30cZiOFtycad
	 SO/eGQXIMYhw2VzHm3EfgUT93+JXTn+EswOZkoJ2AQWazouHiBQJqCDgMNUEb3/siM6WZ
	 FjVHoOi+MtFsK4Jt3ZEYZyVdPDH6fXPgVumv6kX+aqwJkbcsgdUg2b3l3Yzn3IZFDmPgk
	 /XSIhyc84tLlfkMz/sRgUFcI2taxO+/eNC5yuaW9EdS2onre/ebj4DcZTJq2OqWNuEJah
	 Uery1O5Vhwx5L2lXjx350jfmPHfpb2b3mdkCZ6p1uWGnvcy/r8J/PClurQ55/gvmTmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795425044;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:User-Agent:
	 MIME-Version:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Transfer-Encoding;
	bh=ecm2PV2gI1P0bnbXEOX8qjFIo1KpUBcbqXWnncfBn1c=;
	b=irYqcLruIGtK5Mxsguz51+HMWbgPiXZXTgfY2xxNpQjlT49fdrgJhB8Ql0m5KBcgi3nN
	 e4yQmnzIQGQNIEBw8dMp0zs3hWyeu81IYNhQwY3WYKh6LxSA04zvaHP3ykIorIkDqJucq
	 KVNXC1atqrvzl/yRuvtctkSh1iSr+hawTTZvoogecf580t0QNwqebhwoLNBvvSj8dUy7h
	 EsOBTvu2IMpUPgq7FmSjzE30sX5aGhkrNYrd46WZqqHtNd37NDjTuuChMif1h5Ou7YeE5
	 Kpvhp8xOQdB+pRDA93CyJv3iHPY9vfoQ99rDzTAr15PQE7pY8u6dqMNBsTtWiyHi+BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PZq1TMse;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC5B606A32A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Nov 2026 09:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CC5B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PZq1TMse
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795425043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ecm2PV2gI1P0bnbXEOX8qjFIo1KpUBcbqXWnncfBn1c=;
	b=PZq1TMse/ERr17WHnFn6Fwa6tzq1FOrQ1gOmwo4GD1YHbn8sHV+8R5nM0jmfBwH7PWzosv
	hXupiLkut1Du425A4UAmqV7eTWQefct0xhb8e428fxkMu46WX0u2lWA6gSBS4GeFT4qQxI
	VlpfHMB1xEm+Pur9rJ27tNbjLdkbquU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-zMYlng-kMfK4R_8zLnA06g-1; Mon, 23 Nov 2026 09:10:41 +0000
X-MC-Unique: zMYlng-kMfK4R_8zLnA06g-1
X-Mimecast-MFC-AGG-ID: zMYlng-kMfK4R_8zLnA06g_1795425040
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4bb6bbc025aso23176355e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Nov 2026 01:10:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795425040; x=1796029840;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ecm2PV2gI1P0bnbXEOX8qjFIo1KpUBcbqXWnncfBn1c=;
        b=WPkVjHSQHJTElXNXAnksvUZmItjjWT3Ek+f9+YEsFPK2b20VFs1qJOH1KyexYL/Uqz
         zmK+Jj575Kd9aG7yGJldkIpdt4LnWuRaHzSD3JN2glos+jbwkXsgrIfZsEOFF+n6Km6P
         ZXi2K21fq6VNbqFYRfIjX9XPUPwvT77uGYV4lTnRAVMxrNwRlW7muyNHlQtsJKsnzh/v
         HnUfNLfsdGnJMBdhD0PpveuJFPpjl50ychJGILBPGC9oOc86dncmHu/cQ9X3X/fn6ra7
         kwn1y4qdl8l+nuYhsIwe1bjRdqpBVd15X4gtb6P+z1o0Dzq9XKXzASi4HNsHOu0/k2//
         FLIQ==
X-Gm-Message-State: APuU4Z+88oztVatW6lR3ePUHWQMQ3wCrsri1D9r/HbFMSn+5s0bfyZOh
	VONI3jYkmIHgObdpMIKndRECfN0RlQsKszX+vlSKM86QIS8Cbkbl9ZTIfn82MKFIOpPPFsAx+Nj
	ADbTeN/5htlQoFFmHD/begUXESjCaOZ+rZ3B2br4XZpZ3dYDLRE1y0qa1gWsa9/OUSQDuw4YmDg
	==
X-Gm-Gg: AZFdTZfW7LhzNGeq4IuSt2Yor5S0RiVyHQ+T8zmh+ckWG2+u5RxVtYTJ3PjakihuQ5k
	i3bDNtipmp3uwV9Rzi2kzaaTTSER4p4n/waxjxLWzjOgdpFXO6gYCTOY+WCikT3h29fr5/+SkYB
	B0UdLdWzaKTw0TO72UD4yQM+8hkPG1lYjszygJu19ezTZlK25cpdG22MBrltQ3uNXOaQHPI/Th8
	/tQ0QhY/2sg1Fb8ztDwHk6CXxY7hwdY9//NotKs4kH4NqAUZwG1sf6lENwUcPayQxj1PutQheBK
	QtnhGRd4jyrSuiV/EFEjMpmYdnJWNI9XqlaannOPH8+BZvqO2Ult0072qCr4HTcaJ9WHCMiWIYJ
	AgUgOqDfYBbXGi8mY2cfo0TLOvhkE3jK/xkq3licqhhmlY6JG8U1g6K5jD3sIwl+g9/nHXwMKy1
	tt
X-Received: by 2002:a05:600c:5246:b0:4bb:60ba:49e0 with SMTP id 5b1f17b1804b1-4bb88930707mr236628875e9.26.1795425040212;
        Mon, 23 Nov 2026 01:10:40 -0800 (PST)
X-Received: by 2002:a05:600c:5246:b0:4bb:60ba:49e0 with SMTP id 5b1f17b1804b1-4bb88930707mr236628515e9.26.1795425039893;
        Mon, 23 Nov 2026 01:10:39 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a3a3dsm317775305e9.10.2026.11.23.01.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 01:10:39 -0800 (PST)
Message-ID: <96080be96fbb96ec77e3e015779da807fa4ce64e.camel@redhat.com>
Subject: Re: [PATCH 6/6] rv: Do not send the trailing NUL to userspace
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wei Li <liwei1412@hotmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Jonathan Corbet
	 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
	 <rdunlap@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Nam Cao <namcao@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	liwei391@huawei.com
Date: Mon, 23 Nov 2026 10:10:36 +0100
In-Reply-To: <CY8PR19MB7009D39FB627A9576A9868AFB7682@CY8PR19MB7009.namprd19.prod.outlook.com>
References: <CY8PR19MB70098BF493A3B67418C7B9ABB7682@CY8PR19MB7009.namprd19.prod.outlook.com>
	 <CY8PR19MB7009D39FB627A9576A9868AFB7682@CY8PR19MB7009.namprd19.prod.outlook.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.62.1 (3.62.1-1.fc45)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TejPI8bzX1_lhexLpclxHBz911fRtTpS7z2A-kldps0_1795425040
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-11-04 at 17:21 +0800, Wei Li wrote:
> From: Wei Li <liwei391@huawei.com>
>=20
> In the rv module, there are three read handlers that pass
> 'strlen(buff) + 1' to simple_read_from_buffer(). The terminator byte is
> not data, so the read returns one extra byte. Pass strlen(buff)
> instead.
>=20
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---

Good catch, thanks!

Acked-by: Gabriele Monaco <gmonaco@redhat.com>

> =C2=A0kernel/trace/rv/rv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 4 ++--
> =C2=A0kernel/trace/rv/rv_reactors.c | 2 +-
> =C2=A02 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index 7846e4092b9c..835d53978961 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
> @@ -483,7 +483,7 @@ static ssize_t monitor_desc_read_data(struct file *fi=
lp,
> char __user *user_buf,
> =C2=A0
> =C2=A0=09snprintf(buff, sizeof(buff), "%s\n", mon->description);
> =C2=A0
> -=09return simple_read_from_buffer(user_buf, count, ppos, buff,
> strlen(buff) + 1);
> +=09return simple_read_from_buffer(user_buf, count, ppos, buff,
> strlen(buff));
> =C2=A0}
> =C2=A0
> =C2=A0static const struct file_operations interface_desc_fops =3D {
> @@ -752,7 +752,7 @@ static ssize_t monitoring_on_read_data(struct file *f=
ilp,
> char __user *user_buf,
> =C2=A0
> =C2=A0=09buff =3D rv_monitoring_on() ? "1\n" : "0\n";
> =C2=A0
> -=09return simple_read_from_buffer(user_buf, count, ppos, buff,
> strlen(buff) + 1);
> +=09return simple_read_from_buffer(user_buf, count, ppos, buff,
> strlen(buff));
> =C2=A0}
> =C2=A0
> =C2=A0static void turn_monitoring_off(void)
> diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.=
c
> index 06f21bcdd6cf..8a4f0740e3ab 100644
> --- a/kernel/trace/rv/rv_reactors.c
> +++ b/kernel/trace/rv/rv_reactors.c
> @@ -353,7 +353,7 @@ static ssize_t reacting_on_read_data(struct file *fil=
p,
> =C2=A0
> =C2=A0=09buff =3D rv_reacting_on() ? "1\n" : "0\n";
> =C2=A0
> -=09return simple_read_from_buffer(user_buf, count, ppos, buff,
> strlen(buff)+1);
> +=09return simple_read_from_buffer(user_buf, count, ppos, buff,
> strlen(buff));
> =C2=A0}
> =C2=A0
> =C2=A0static void turn_reacting_off(void)


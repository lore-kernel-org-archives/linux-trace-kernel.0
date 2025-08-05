Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2526721639B
	for <linux-trace-kernel@vger.kernel.org>; Tue,  5 Aug 2025 06:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754374735; cv=none; b=rfSlmi3dBekzOVEUZ/YS9PhR/TFUvzVjO6Wa4fkvyXefN86g5vEbZsEEQRBnY77ZaiR3PKYXosYHVucDoCR0iROdTI5q0razUznjt1oDvSgNrMmMB+X8xryOSiUitJ5tC4TsN/E6ioAyfJXiDLWX5Fv7skaFC/M1RJTlPoSeM5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754374735; c=relaxed/simple;
	bh=HFCI5b1Y4nwWKoLxP6FRo+xfZMGLRgXPjqgdMVhYiMw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KaNJZ096YdaM8CcgWlythpOGQS2uonKQ7r5XZRLhjUiltd54H2/2ktJ/DcnClpoN2K0mysWkNpVCwFRcbMN8+MVqiBM9C6X3qnT6V/9aFvx6kHdlcpVstN3B2nYUVEX0+aHdaOC9u2ZAhHYSgvEpTG4K7iHGgemINq4q3SzKRlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cpK2BZWE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpK2BZWE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754374733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HFCI5b1Y4nwWKoLxP6FRo+xfZMGLRgXPjqgdMVhYiMw=;
	b=cpK2BZWE6i3E9IbWLhaSufXY0QQzjv/KWMNQzLiK33lNuRpRZD9NpkMZA9EblEp7AkkMt8
	fmwNtH/GNFgaPUjy+qj7MRGgtz0zv/+vIcVrDT1xAUqzVH8lImAlt44gKmkNbX+MOQVSBS
	wWUHlSdkGoW/mcoEYfw8RkXz6gF0ZDU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-cTVi3o3aO-SY9Nh9YnFgwQ-1; Tue, 05 Aug 2025 02:18:51 -0400
X-MC-Unique: cTVi3o3aO-SY9Nh9YnFgwQ-1
X-Mimecast-MFC-AGG-ID: cTVi3o3aO-SY9Nh9YnFgwQ_1754374731
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-478f78ff9beso147172941cf.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 04 Aug 2025 23:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754374731; x=1754979531;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJ1eNsgcn/sAni6mkXijStzdoI600KWnpZ9DrmvA1T8=;
        b=iUELmBb2BQwhzJ2CBjareQAc8C2X+z6E3YiHvU4pwHVPN4KcfVF4Ynes0g3Rg1raBE
         2S+mx2m86pLzWtgZARj5XBVhLBd0IVOid6IVK8ZfiTjsp/hCFXvfiUoZTMm6dRZu4x8Y
         qqr+jllhb7Ff9lecc4L/JqJg0kNcEl1S2bqP4uKpoQ3fGd5O3nSUHQMLUUw025J/X31a
         ZyN7xEUKE+7JtYaUsCAv4cq7Zeh5E0r47UnRWyiAllVVvsoqL/ArujUJxKP2noFOhQe7
         eMhqV+JQXeNr6bTnEnRQ1fUIeUYVtsAoRf03LaKnApHebVNRpe9zEMYPhIUxUW0cnvYK
         V0rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVzpXwfTMzQM5lqdGeFFtw5xWiqKY62XER0QY2SqQfnbstehrZAytb5XB+lxwpviiUeDdHMQJpm3NfraVhVnxQXwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYgNJuzbJ8vdo8v4r82rHzKJ7SB75LuksEzRd06N50jgox+JMc
	7eHyZPBP6nrNGnR5bwiXQ41G9FKChamA9DgLO+YuvqsSD7XjCC5ienTDaUB+9/Cl0wNi8JNIKGf
	WWKJLiNbkn1bCgR496zqpkVGLafpmF3rXMoa0wfvJv11EbXDl7DPWQQrFDhKR7vgo4aH3QNpx9g
	==
X-Gm-Gg: ASbGnctmq5dl7Lx0yKSiARr92zEk49HCXDQ+NJTiG6sGflorxfSbUyqPgPFUXVvuPWY
	O3+sOuJ0/veoqv36ra+K/On8QmzilZdfiy1sZ1rzNJNjEQA9dLW7psP1dUWUEsNm6zH5j7+QaMk
	NOmtCYqaXhldTCbQJOlEc3rtDQF6NSYUFOpA+OMF8SL+JF+ZLUWUIwdFyfhRuqucZLKsKKkpN9z
	0ytd06dqzwx3gD4PIuJh1i9MjFZAEDjf/5jD6pdmezCfsXUc7qjZ3QYzwl4kIlgxcOgHsu+03az
	XHlE+h+NTQ8HlR9zmoVJ1S60xY9Nd3lrSrnD6jRkNIAbU+1c/awD/TikmZBbwd2Kkw==
X-Received: by 2002:a05:622a:1a96:b0:4b0:8822:443f with SMTP id d75a77b69052e-4b0882245c2mr1837491cf.18.1754374731261;
        Mon, 04 Aug 2025 23:18:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9eaYCUZBrblo1oRVSbdJ7BzN0HK/JTOAD5cc/KJrR9x6Z1tgaDU/5IdS8zKXHi5VNZgTAVg==
X-Received: by 2002:a05:622a:1a96:b0:4b0:8822:443f with SMTP id d75a77b69052e-4b0882245c2mr1837281cf.18.1754374730790;
        Mon, 04 Aug 2025 23:18:50 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b076710ff1sm14137741cf.52.2025.08.04.23.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 23:18:50 -0700 (PDT)
Message-ID: <580bf2db57cefa07631e73e5af453228cfb3cecb.camel@redhat.com>
Subject: Re: [PATCH] rv: Support systems with time64-only syscalls
From: Gabriele Monaco <gmonaco@redhat.com>
To: Palmer Dabbelt <palmer@dabbelt.com>, rostedt@goodmis.org, 
	namcao@linutronix.de
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 05 Aug 2025 08:18:46 +0200
In-Reply-To: <20250804194518.97620-2-palmer@dabbelt.com>
References: <20250804194518.97620-2-palmer@dabbelt.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MnMKEyDGvjGu_Lh1ItFDWsx3qUiZ1NZMf-WfhJpTncI_1754374731
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-08-04 at 12:45 -0700, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@dabbelt.com>
>=20
> Some systems (like 32-bit RISC-V) only have the 64-bit time_t
> versions of syscalls.=C2=A0 So handle the 32-bit time_t version of those
> being undefined.
>=20
> Fixes: f74f8bb246cf ("rv: Add rtapp_sleep monitor")
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> ---
> This seems a little ugly, as it'll blow up when neither is defined.=C2=A0
> Some #if/#error type stuff seemed uglier, though, and that's the best
> I could come up with.=C2=A0 I figure anyone without either flavor of fute=
x
> call is probably deep enough in the weeds to just figure what blows
> up here...

Yeah, this is getting ugly.. I wasn't fun of this ifdeffery already but
a few of them seemed acceptable, if we are really expecting any single
one of them to potentially not be available, it isn't looking good.

What about doing in the beginning of the file something like:

/*
 * Define dummy syscall numbers for systems not supporting them
 */

#ifndef __NR_whatever
#define __NR_whatever -1
#endif

#ifndef __NR_some_exotic_syscall
#define __NR_some_exotic_syscall -2
#endif

The negative number would never match, we may add a mostly
insignificant overhead checking for it but we keep the function
readable. What do you think?

I'm not sure if we can get the compiler rid of it completely, but it's
probably not worth it.

What do you think?

Thanks,
Gabriele

> ---
> =C2=A0kernel/trace/rv/monitors/sleep/sleep.c | 4 ++++
> =C2=A01 file changed, 4 insertions(+)
>=20
> diff --git a/kernel/trace/rv/monitors/sleep/sleep.c
> b/kernel/trace/rv/monitors/sleep/sleep.c
> index eea447b06907..c1347da69e9d 100644
> --- a/kernel/trace/rv/monitors/sleep/sleep.c
> +++ b/kernel/trace/rv/monitors/sleep/sleep.c
> @@ -127,7 +127,9 @@ static void handle_sys_enter(void *data, struct
> pt_regs *regs, long id)
> =C2=A0=09mon =3D ltl_get_monitor(current);
> =C2=A0
> =C2=A0=09switch (id) {
> +#ifdef __NR_clock_nanosleep
> =C2=A0=09case __NR_clock_nanosleep:
> +#endif
> =C2=A0#ifdef __NR_clock_nanosleep_time64
> =C2=A0=09case __NR_clock_nanosleep_time64:
> =C2=A0#endif
> @@ -138,7 +140,9 @@ static void handle_sys_enter(void *data, struct
> pt_regs *regs, long id)
> =C2=A0=09=09ltl_atom_update(current, LTL_CLOCK_NANOSLEEP, true);
> =C2=A0=09=09break;
> =C2=A0
> +#ifdef __NR_futex
> =C2=A0=09case __NR_futex:
> +#endif
> =C2=A0#ifdef __NR_futex_time64
> =C2=A0=09case __NR_futex_time64:
> =C2=A0#endif


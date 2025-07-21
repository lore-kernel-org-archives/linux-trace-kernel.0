Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E9B2DE213
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753108727; cv=none; b=eeN7tDJxnX7vFlMpzpKfalCE+rcV2WIZsU5qvR6NcJvMvg+EKRIbt9BmMTECyRaMxWLv5CTtvzB9zV8Hje7YCMFLdKj7LHX0tH7lgVfDr8aoKynDq7RrkfytC9EeLwtXNj7+eGaZg4WFtFVeFQf+Q9XJ6VWlCc/kDU4u3PaAc9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753108727; c=relaxed/simple;
	bh=ficA/UNuJNSo2/10BoD+yWMib7bqQXYdCpjt1tPFLe0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GnTexDKx1uhPEhGcJ0ChaGbV0Nqc75OCZ/1dss7/g0NWemLTHGc6K7gWaR3XLxDdGexwdTj1zR6SF/a7Tzc4+ieB11ZU0SgQR1kJAivdx3EF9DNTsV3KyPMIsjMzWZEuc9SE2sOxT2OAFlaJpwZ/ucF64FWwl455K0pM2iDqCA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JjPeJ3dw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JjPeJ3dw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753108724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ficA/UNuJNSo2/10BoD+yWMib7bqQXYdCpjt1tPFLe0=;
	b=JjPeJ3dwEjQrfTp9H2Zl8RWtpjAyoyDS4WK5zrIov8dm7rjO2gv3glKIqBuoEfHsx9Wo+B
	5f5boogXX6YnnXzYIXeLFm/sO4GqObU+BSe8SzLeTwGxJZZJ5E+P/KBhbQYxDg4G0PaupX
	oG8V0XaybKn2NsZnpl1I7UKo37OPa0A=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-b-u27aH5NqGexRvG0F5mKw-1; Mon, 21 Jul 2025 10:38:40 -0400
X-MC-Unique: b-u27aH5NqGexRvG0F5mKw-1
X-Mimecast-MFC-AGG-ID: b-u27aH5NqGexRvG0F5mKw_1753108720
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4f6ba526eso2998035f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Jul 2025 07:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753108719; x=1753713519;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BrgKcuivlt5jU+LsnrLsElzWtBZnf++RUU5Yf+O5CqI=;
        b=CYEh7/HmR9tT5xtoUMbc+bMSK8rJtgpswK3Unhj5UIl8xVE6XFrzZIQ26PtzgfopPU
         77yxArzZyyqi1euReLqYREI8tHZkE3cKNXQdxnyuzLghr6VkDgqBnBoD5fyJzhmBdg6R
         ewxknNL2zpTFOEkCjnXEtgJyWKEkGCZWfzeRZLaNt/Nj1JjA84hgCsd4vajjcVfkEzFB
         5cApA8UkFtHklUeTdbFRrSiAl7dHPHeLKU2XbuHsEZEtUjjrFRGyVGweA6fCBIMUWwWY
         6/IZ2PeFesAm/E+xuNZCQBHOUFX6D8cbOC+4VnxJETte896jfUxUZxMXTYcaiAwQYIPF
         /lug==
X-Forwarded-Encrypted: i=1; AJvYcCVEYf5rir721pnd4e0d26gLr3RJJYqJt/ywjBVWq48IbIkD/2KegLX9m5jl+i13VLtOk2AzmPD66C9Apxsi3bSKx7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAn2kJlXHmtGE1Rl8gEiGCcTfhFE9SNpXBIC9JWn1xoU2XMIrw
	0AbQfPUNm3tFHOrSdTlknJwaOcdzNQ7O8J7le/cGeZFMyxZOCXF2/hf+vQvtPBWr1wUgG17Cap6
	vqsiStp78DqIgnyollWBf+MtV0me0FsesX90rr4/C1ps5YXq6RSBE454gw16RK+lMOctCSzUX/1
	8USvVAoSP1
X-Gm-Gg: ASbGncujPyzORFf2wQ6icQsNZ28qtfnaD865CnRq8aKbTGKqGLiIhuPWCUMTsyHZhjS
	863YEYElEKB+kSWVERWz6kJIqA7deqLzG/IIJIbFyPA0TqcC5WPcsuA4fMRpZxR59sfFJoR6JJo
	i/XVUHiJ7Gpy4U1HhOg4OEDndBkRgPLz8pkWW2hn5ZkVq/7FGXGfABzknzhgcwgmjk14aI/7U3R
	LzfkSCoUjXofrvvO8THTfiRtcavX10GaRgCOzQnlWQ+FhVPUrPWmsGPWB9+s0k51HzfqXm9oGFP
	ftKfjSLuU6QaGLJkfY9VTmQNYJ9zTCuzn1kHo324wzx35D/ovafuJk1tbSPCWyyPTQ==
X-Received: by 2002:a05:6000:310d:b0:3b6:c6b:e4e6 with SMTP id ffacd0b85a97d-3b60e4be9b2mr17513034f8f.11.1753108719576;
        Mon, 21 Jul 2025 07:38:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJglViKxSMGSg9xURndSNz783lX38gRK7ryxqJzYa2D640xKlmt6ckijV5eMR9hBj7gumblw==
X-Received: by 2002:a05:6000:310d:b0:3b6:c6b:e4e6 with SMTP id ffacd0b85a97d-3b60e4be9b2mr17512999f8f.11.1753108719024;
        Mon, 21 Jul 2025 07:38:39 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45627962384sm116603785e9.2.2025.07.21.07.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 07:38:38 -0700 (PDT)
Message-ID: <1d12e86b32c8c5977e5925079f6b74675a3a9e91.camel@redhat.com>
Subject: Re: [PATCH 6/6] rv: Remove struct rv_monitor::reacting
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 21 Jul 2025 16:38:37 +0200
In-Reply-To: <5c18ef23f817fb653bb27f027cc1ffdf53f6e1fd.1753091084.git.namcao@linutronix.de>
References: <cover.1753091084.git.namcao@linutronix.de>
	 <5c18ef23f817fb653bb27f027cc1ffdf53f6e1fd.1753091084.git.namcao@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: CPyRZFZxGpCHTz_BI0Pe1PoO-XHT5Yg7Ty0AZBTzrTo_1753108720
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-07-21 at 11:47 +0200, Nam Cao wrote:
> The field 'reacting' in struct rv_monitor is set but never used.
> Delete it.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---

Yeah seems to be the case, thanks for spotting it.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

> =C2=A0include/linux/rv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 1 -
> =C2=A0kernel/trace/rv/rv_reactors.c | 14 ++++++--------
> =C2=A02 files changed, 6 insertions(+), 9 deletions(-)
>=20
> diff --git a/include/linux/rv.h b/include/linux/rv.h
> index 2f867d6f72ba..80731242fe60 100644
> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -104,7 +104,6 @@ struct rv_monitor {
> =C2=A0#ifdef CONFIG_RV_REACTORS
> =C2=A0=09struct rv_reactor=09*reactor;
> =C2=A0=09__printf(1, 2) void=09(*react)(const char *msg, ...);
> -=09bool=09=09=09reacting;
> =C2=A0#endif
> =C2=A0=09struct list_head=09list;
> =C2=A0=09struct rv_monitor=09*parent;
> diff --git a/kernel/trace/rv/rv_reactors.c
> b/kernel/trace/rv/rv_reactors.c
> index aee622e4b833..6b03f3f6ecc1 100644
> --- a/kernel/trace/rv/rv_reactors.c
> +++ b/kernel/trace/rv/rv_reactors.c
> @@ -149,7 +149,7 @@ static const struct seq_operations
> monitor_reactors_seq_ops =3D {
> =C2=A0
> =C2=A0static void monitor_swap_reactors_single(struct rv_monitor *mon,
> =C2=A0=09=09=09=09=09 struct rv_reactor *reactor,
> -=09=09=09=09=09 bool reacting, bool nested)
> +=09=09=09=09=09 bool nested)
> =C2=A0{
> =C2=A0=09bool monitor_enabled;
> =C2=A0
> @@ -162,7 +162,6 @@ static void monitor_swap_reactors_single(struct
> rv_monitor *mon,
> =C2=A0=09=09rv_disable_monitor(mon);
> =C2=A0
> =C2=A0=09mon->reactor =3D reactor;
> -=09mon->reacting =3D reacting;
> =C2=A0=09mon->react =3D reactor ? reactor->react : NULL;
> =C2=A0
> =C2=A0=09/* enable only once if iterating through a container */
> @@ -170,8 +169,7 @@ static void monitor_swap_reactors_single(struct
> rv_monitor *mon,
> =C2=A0=09=09rv_enable_monitor(mon);
> =C2=A0}
> =C2=A0
> -static void monitor_swap_reactors(struct rv_monitor *mon,
> -=09=09=09=09=C2=A0 struct rv_reactor *reactor, bool
> reacting)
> +static void monitor_swap_reactors(struct rv_monitor *mon, struct
> rv_reactor *reactor)
> =C2=A0{
> =C2=A0=09struct rv_monitor *p =3D mon;
> =C2=A0
> @@ -179,7 +177,7 @@ static void monitor_swap_reactors(struct
> rv_monitor *mon,
> =C2=A0=09=09list_for_each_entry_continue(p, &rv_monitors_list,
> list) {
> =C2=A0=09=09=09if (p->parent !=3D mon)
> =C2=A0=09=09=09=09break;
> -=09=09=09monitor_swap_reactors_single(p, reactor,
> reacting, true);
> +=09=09=09monitor_swap_reactors_single(p, reactor,
> true);
> =C2=A0=09=09}
> =C2=A0=09/*
> =C2=A0=09 * This call enables and disables the monitor if they were
> active.
> @@ -187,7 +185,7 @@ static void monitor_swap_reactors(struct
> rv_monitor *mon,
> =C2=A0=09 * All nested monitors are enabled also if they were off, we
> may refine
> =C2=A0=09 * this logic in the future.
> =C2=A0=09 */
> -=09monitor_swap_reactors_single(mon, reactor, reacting, false);
> +=09monitor_swap_reactors_single(mon, reactor, false);
> =C2=A0}
> =C2=A0
> =C2=A0static ssize_t
> @@ -221,7 +219,7 @@ monitor_reactors_write(struct file *file, const
> char __user *user_buf,
> =C2=A0
> =C2=A0=09len =3D strlen(ptr);
> =C2=A0=09if (!len) {
> -=09=09monitor_swap_reactors(mon, NULL, false);
> +=09=09monitor_swap_reactors(mon, NULL);
> =C2=A0=09=09return count;
> =C2=A0=09}
> =C2=A0
> @@ -233,7 +231,7 @@ monitor_reactors_write(struct file *file, const
> char __user *user_buf,
> =C2=A0=09=09if (strcmp(ptr, reactor->name) !=3D 0)
> =C2=A0=09=09=09continue;
> =C2=A0
> -=09=09monitor_swap_reactors(mon, reactor, true);
> +=09=09monitor_swap_reactors(mon, reactor);
> =C2=A0
> =C2=A0=09=09retval =3D count;
> =C2=A0=09=09break;


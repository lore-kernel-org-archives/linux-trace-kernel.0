Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795272204;
	b=CbsFPiP63Qxntpur+YWRRDOXDdCjYDTfPgiUAW99NLStQvn58hTv9EI7gx5XUT1f+XN1
	 q5AEiNqDYOV5VfcEAjn/vezvWJV0scCFV2yv/EM50wxPskKr1rhwbqWdPybzyFb4Uq3t4
	 MxdHg2YXfMD2tSKVLNdlKajR2bIWBfsQrD0iYc5cDzxh1oBi9Ajzp9ujEgGmAQmFxEdHN
	 lK5eaMHJ528yX6w2G7Y4QIDStxxQcAU37uqiBKmfpyD1YBDzGsE6bO4UGT5+3isP/6MVU
	 B8Vz/7ryAejMgdSxqXTvXiKM0ROhi71imGtEaxLk/CbsQcDQxSQ+VWQJML9+gqvTtEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795272204;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:User-Agent:
	 MIME-Version:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Transfer-Encoding;
	bh=cCJcXQgk/Si4catT5eOwtfh+QW2z1vm+mPPFnEPeMZ4=;
	b=hfwYagXod4fIsaAMzKRP+kTQ9b1zJVgqIVl7KOzcl6Z6HUB6EgXPWSRWFycouIxEhq9s
	 GD4OqCagjMJtg9k8RLrvRGKAutXWZ7U2JFVOI2rC+/zH0+xdUG4y/JAJKr6SJ9xZv73qR
	 jorQdi2800sYBXYC9wvOCcebdCaOpqvrSRJycTQkN9QFkTbeudRsn13kVMp12EAzwwUXD
	 wRYpCrsZJD69Ld7aNgwNHypIGKXSpbBHkFyYYdHUtia4H7V0GrIXrM+jZKixMNpxQzGsy
	 8IPMKJ/MF9M/Eg16oiFp7vgASO2YWBbMKiuCc8W0WEl2/wAdwmfx3vlHgxUrES5LYbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GNpSypgf;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396C3606A320
	for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 14:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 396C3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GNpSypgf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795272202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cCJcXQgk/Si4catT5eOwtfh+QW2z1vm+mPPFnEPeMZ4=;
	b=GNpSypgfGPVGCuri//eCXZYtp5nxBq11XUwZEKhtWYUPD3pj7bdm3xtKym/CsVYklNsgrx
	GjrVLhPXfcoZveO9OSbIhJpHRy0BskN/V5ljPzUhQughMKlM85Zonp+qjBZ9y1vn3z/T8N
	tQin5OsfQuijmw22Vo5N8ihL+ERotbU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-JbG4WOHYOfuRcMrIdJ971A-1; Sat, 21 Nov 2026 14:43:20 +0000
X-MC-Unique: JbG4WOHYOfuRcMrIdJ971A-1
X-Mimecast-MFC-AGG-ID: JbG4WOHYOfuRcMrIdJ971A_1795272199
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a009f82bedso12619115e9.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 06:43:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795272199; x=1795876999;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cCJcXQgk/Si4catT5eOwtfh+QW2z1vm+mPPFnEPeMZ4=;
        b=DoeeWvKe898YmoB5P7Ddmp7XQ+lPU8tFbuO53s6r7vOxJf+HvdgJMHAuoY/aQsXOwu
         Y2AYml2qM/xM7ibcMdZMeVibB6zH5m17f8cMFBUB5op7Zeu2i8w+Anz4vnq8g+pB231t
         cT02XgHqZ9avg3SuCzpeOD3adTQkyQQvXpCHvRHqNFu6L5exVvhhVDHKcLBcMNaKGRVF
         3HfvZPElPohxRzB7OMmaSHVnZIhwmKm5OL2P0Q7tBSGuD/ZdGaYnKtxEPf5nXHuhZPF+
         ecaxAHbqHvvfJN3HZCtXT7VQZ2MX/IaWkroceDQbnxV76D+jfUBx/Fox7t6pxibXkA11
         IXgQ==
X-Gm-Message-State: APuU4Z/gIhIhPAC/g3ie6H6C6UM45PADOG2svl3RMhHTSFUwlahHo3nw
	W5F1e2YOs+H9vNjLdpYdsTfTYiFX22oFVkcZKn5/1cr+uI69NZMJ4negA9hmtJyHtbY4FFBRDLH
	0SePZ/hfwqA023vTafr1Kl9+aExw+2GgV2lZH0dhF6bMEWqX7bYiXIWssPtbMsv9xr8FuD5gA2g
	==
X-Gm-Gg: AZFdTZdqwf0k/uIgBKAySmoBbTo0CR0mOqMuDqJIdWzOPBwDWLPl/AqXKMTzs1kDJFs
	7PnDMe6Q/nfHwSMVqcNPUS9o4HJDZh9S/1XIjz/e5wPK0AiPGKBpVXFoZvTtB6V0ppsKsxFwYlh
	fjlOsFOr088laQJgbgdoGKPJMNJJNkNQBj+uKdOl+reLV+ya6md55bCkyZiSq8eJHKLAN4NTyDU
	ELM5v1TuGSuITN+4JONi12A2k1VhAjZrUt18f5KcdRfd0PgPxu0yO2N5QOC55M9nVmHMCc9usPs
	tn7dLbTjJKqbZSyKAT00bHKFd2CoMCCGIah0kJcUcSSiuxsunHddc2x91BuwRcTfPIBiAkh7BFk
	kdjL/OlXHbHZ5EOQyLhUn8ioEAIoFDpNJkbxPkg18S6L5FXnkGX4Z/C1+75q27WqExmMdgLLyVu
	cM
X-Received: by 2002:a05:600c:3b8a:b0:4bb:76d9:f81a with SMTP id 5b1f17b1804b1-4bb88824fc8mr150766705e9.34.1795272199367;
        Sat, 21 Nov 2026 06:43:19 -0800 (PST)
X-Received: by 2002:a05:600c:3b8a:b0:4bb:76d9:f81a with SMTP id 5b1f17b1804b1-4bb88824fc8mr150766295e9.34.1795272199011;
        Sat, 21 Nov 2026 06:43:19 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c340df4sm13970576f8f.55.2026.11.21.06.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 06:43:18 -0800 (PST)
Message-ID: <9d23c0a68ae574f0c124da238d8ebf676d152039.camel@redhat.com>
Subject: Re: [PATCH 3/6] rv: Show the mixed enable state of containers
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wei Li <liwei1412@hotmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Jonathan Corbet
	 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
	 <rdunlap@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Nam Cao <namcao@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	liwei391@huawei.com
Date: Sat, 21 Nov 2026 15:43:17 +0100
In-Reply-To: <CY8PR19MB70099F2263C408361053B295B7682@CY8PR19MB7009.namprd19.prod.outlook.com>
References: <CY8PR19MB70098BF493A3B67418C7B9ABB7682@CY8PR19MB7009.namprd19.prod.outlook.com>
		 <CY8PR19MB70099F2263C408361053B295B7682@CY8PR19MB7009.namprd19.prod.outlook.com>
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
X-Mimecast-MFC-PROC-ID: cAaXf7SrjqGr7KDEGKzD0shSF41fo4RxtlgQNCzrQl4_1795272199
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-11-04 at 17:21 +0800, Wei Li wrote:
...
> +enum rv_monitor_state {
> + RV_MON_DISABLED =3D 0,
> + RV_MON_ENABLED =3D 1,
> + RV_MON_MIXED =3D 2,
> +};
> +
> =C2=A0struct rv_monitor {
> =C2=A0 const char *name;
> =C2=A0 const char *description;
> - bool enabled;
> + enum rv_monitor_state enabled;
> =C2=A0 int (*enable)(void);
> =C2=A0 void (*disable)(void);
> =C2=A0 void (*reset)(void);
> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index 4e689d4590ae..7846e4092b9c 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
> @@ -235,12 +235,15 @@ bool rv_is_container_monitor(struct rv_monitor *mon=
)
> =C2=A0static ssize_t monitor_enable_read_data(struct file *filp, char __u=
ser
> *user_buf, size_t count,
> =C2=A0 loff_t *ppos)
> =C2=A0{
> + const char set_to_char[3] =3D { '0', '1', 'X' };

Real nit, but nothing ensures these match the enum fields although they sho=
uld,
you could use a designated initializer:

  { [RV_MON_DISABLED] =3D '0', .. [RV_MON_MIXED] =3D 'X' }

> =C2=A0 struct rv_monitor *mon =3D filp->private_data;
> - const char *buff;
> + char buff[2];
> =C2=A0
> - buff =3D mon->enabled ? "1\n" : "0\n";
> + guard(mutex)(&rv_interface_lock);
> + buff[0] =3D set_to_char[mon->enabled];
> + buff[1] =3D '\n';
> =C2=A0
> - return simple_read_from_buffer(user_buf, count, ppos, buff, strlen(buff=
)+1);
> + return simple_read_from_buffer(user_buf, count, ppos, buff, 2);

Why don't you use sizeof(buf) here?

> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -269,10 +272,22 @@ static int __rv_disable_monitor(struct rv_monitor *=
mon,
> bool sync)
> =C2=A0
> =C2=A0static void rv_disable_single(struct rv_monitor *mon)
> =C2=A0{
> + struct rv_monitor *cntr =3D mon->parent;
> + struct rv_monitor *p =3D cntr;
> +
> =C2=A0 __rv_disable_monitor(mon, true);
> + if (!cntr)
> + return;
> + cntr->enabled =3D 0;

Do you mean RV_MON_DISABLED?
You added the enum which is nice, don't rely on magic numbers.

> + list_for_each_entry_continue(p, &rv_monitors_list, list) {
> + if (p->parent !=3D cntr)
> + break;
> + if (p->enabled)
> + cntr->enabled =3D 2;

Do you mean RV_MON_MIXED?

> + }
> =C2=A0}
> =C2=A0
> -static int rv_enable_single(struct rv_monitor *mon)
> +static int __rv_enable_monitor(struct rv_monitor *mon)
> =C2=A0{
> =C2=A0 int retval;
> =C2=A0
> @@ -289,6 +304,27 @@ static int rv_enable_single(struct rv_monitor *mon)
> =C2=A0 return retval;
> =C2=A0}
> =C2=A0
> +static int rv_enable_single(struct rv_monitor *mon)
> +{
> + struct rv_monitor *cntr =3D mon->parent;
> + struct rv_monitor *p =3D cntr;
> + int retval;
> +
> + retval =3D __rv_enable_monitor(mon);
> +
> + if (!retval && cntr) {
> + cntr->enabled =3D 1;

Do you mean RV_MON_ENABLED?

> + list_for_each_entry_continue(p, &rv_monitors_list, list) {
> + if (p->parent !=3D cntr)
> + break;
> + if (!p->enabled)
> + cntr->enabled =3D 2;

Do you mean RV_MON_MIXED?

> + }
> + }
> +
> + return retval;
> +}

I need to test it, but at first it looks good and sounds like a nice additi=
on.

Thanks,
Gabriele


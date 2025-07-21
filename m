Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EA02DAFB2
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753107212; cv=none; b=sqR9AyZHouPPf8rkIV50Gu+aZY4zwIn3Yigi5Fx3A8nX9nUXGRRktMEKI595uXfpshW7EYXU6wF04JjcSXu5Z9Nuw7ikaEPByT4wHQw26PQOTZLnItuZ84ZLpdc5tkUYJwB+vtEfehlIgvfkX2wj5qzp44skRwa3GTLzzCIupBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753107212; c=relaxed/simple;
	bh=x2UjVnvYDk6iWKKVUD8J2TvhKaPg6P7QpUBJbtA0byg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=maoqm4pCq1kmGf08eOmF5dh92U9IjFZktm7yj679MsuVGCNWQGeAXkxnSpoYJjTOME0aL/qjqkUyj06rR8e+YaJ2wsWi76td7NhzMyeeIvCk/1xydXd2dvuvuzqLNYPEOyGmI64uqIs/Ec3C33e0IxtrqHL/MeeS0hm0JVaxCBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OIVv5bCF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OIVv5bCF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753107208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x2UjVnvYDk6iWKKVUD8J2TvhKaPg6P7QpUBJbtA0byg=;
	b=OIVv5bCFvyWAR7JLUfjuywotfU+UFMvX5xX+CTwdA2Q5BVB2LdqFQDCMZRcUWpWMGk0U9m
	g2SVJsEXybmEs6onTzAWuntkc0dEvg/gnJsCk7Es08L4XTOKOxELYWcsrufO0gfGoo4U+e
	0iREDG2fOsOZKMsQXUJEPWAfE1qSCCM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-OQ7DdgT3NOeHlx0CI8RDhg-1; Mon, 21 Jul 2025 10:13:26 -0400
X-MC-Unique: OQ7DdgT3NOeHlx0CI8RDhg-1
X-Mimecast-MFC-AGG-ID: OQ7DdgT3NOeHlx0CI8RDhg_1753107204
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b61e53eea3so1783701f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Jul 2025 07:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753107204; x=1753712004;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dv3+BgYV5FzmJEDCL2Att7OErGC7H1LFDrFwOvO+8/g=;
        b=O/BLtEmKlksELWdbx8Ptw6s5AbBQAJcw4A3i8oMO/wvViC7EOUHP2nz+j9/0u7r975
         /9wDBjFsBOhqLrtt/isnoXlkyZbK7Sv/ZzW+EoM95UoMgG8y2Wa4SYYLAo/M5ab5Zhmq
         +23L3F9m4RU3AqxP6aD6rFIDfoqPlgEjaU1v5pKuHQdCAF0Qq8eyjEdV22/RktUYWc1/
         XmCBoBiV1oMMCiQumpKtlJXd6EwS6YG/7QK/DYU7HbD8P7q/UrphL5sh6Nz8V97Nuc+V
         FphX6IJ1ADcey2dDN7mQLRB/55diMyddy7uiRt0S93XDAU0DxHhF9tt0zzdbYPGzmXF2
         5ggw==
X-Forwarded-Encrypted: i=1; AJvYcCVfbFDfB9W2lJGMXe/+VquLuqy2VCWkvPDIQoDXHUIZpQCvPQ2zPuQBUj47n0oHUqfJDmAiB6IaQ/BKcB1UfBedHeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YymS2R3uCRi5FdBe7LRMrdh8qQf36KKRzbpLUOf3TX1lbjXabkM
	4RMkGXi6kIGjPtTr0czfdnTu6mE5jct0qTGFPZRIx2DfAAmquFLbcVqZmqDiJb1hDYStxpl1Pls
	qWGE/9SK1J5/YeyjhwMYdu/PNO+qJYBfdmtl3QYiPN3C1D1MMhpTZeXNIlxkc1sgeopq6nMqKVA
	==
X-Gm-Gg: ASbGncuYifwGBaQQtdfZPpeti1yl5B2vdJ/f2I7pHXNejqsULpLgyqRo5MbVEdbaC6H
	OofVvl0wta1dXlbVzTt5XCnnQI4HIkTzrxX9SM9fbqleoaYgHwPA1B0wB90hy0gGA92WQcDl9m6
	4PxIIinOj9JALHhM3649DHljJ8ceP/q2IRDuDrLBrlc2EhZOgTkm1VlwnN3nZVGx8/wEn3+cFcN
	Bj92rMzHcXNs2lajQ9eYKKjNhZHKjubSwgbVmEsp19ZiJ02uAJjq1t1Elj31pI4gbN7ylq8TYFU
	q2+Pu8bXn+D/la6HnGyAjzBSLvZSCWhLEO0kD/Rkpv05RNhaMage6r1CzxvV4IzwQA==
X-Received: by 2002:a5d:5d88:0:b0:3b6:1d3:f7e2 with SMTP id ffacd0b85a97d-3b60e4be9f4mr14144669f8f.8.1753107204189;
        Mon, 21 Jul 2025 07:13:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKbiiAq7uQjOcZtntlqL6PvPdY2SDuejhKPA+1mU+628lAogcoNW7zqLn4I22e1JNgDvfe1w==
X-Received: by 2002:a5d:5d88:0:b0:3b6:1d3:f7e2 with SMTP id ffacd0b85a97d-3b60e4be9f4mr14144645f8f.8.1753107203616;
        Mon, 21 Jul 2025 07:13:23 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2bb80sm10641031f8f.23.2025.07.21.07.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 07:13:23 -0700 (PDT)
Message-ID: <d53d5bddaf9ac2d9ecbbc2153a2c24c0044096ab.camel@redhat.com>
Subject: Re: [PATCH 2/6] rv: Merge struct rv_monitor_def into struct
 rv_monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 21 Jul 2025 16:13:21 +0200
In-Reply-To: <61a0bc99fae3a5222946b1786063ac03f6360e42.1753091084.git.namcao@linutronix.de>
References: <cover.1753091084.git.namcao@linutronix.de>
	 <61a0bc99fae3a5222946b1786063ac03f6360e42.1753091084.git.namcao@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: X5aEDG5hcdnQzqoyzyQWfGAp-lSzL5nfStx9kPJ6oLI_1753107204
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-07-21 at 11:47 +0200, Nam Cao wrote:
> Each struct rv_monitor has a unique struct rv_monitor_def associated
> with
> it. struct rv_monitor is statically allocated, while struct
> rv_monitor_def
> is dynamically allocated.
>=20
> This makes the code more complicated than it should be:
>=20
> =C2=A0 - Lookup is required to get the associated rv_monitor_def from
> rv_monitor
>=20
> =C2=A0 - Dynamic memory allocation is required for rv_monitor_def. This i=
s
> =C2=A0=C2=A0=C2=A0 harder to get right compared to static memory. For ins=
tance,
> there is an existing mistake: rv_unregister_monitor() does not free
> the memory allocated by rv_register_monitor(). This is fortunately
> not a real memory leak problem, as rv_unregister_monitor() is never
> called.
>=20
> Simplify and merge rv_monitor_def into rv_monitor.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Right, I don't see a valid reason for keeping it separate, considering
that's also simplifying things.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele

> ---
> =C2=A0include/linux/rv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 ++
> =C2=A0kernel/trace/rv/rv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 211 +++++++++++++++-----------------
> --
> =C2=A0kernel/trace/rv/rv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 27 ++---
> =C2=A0kernel/trace/rv/rv_reactors.c |=C2=A0 62 +++++-----
> =C2=A04 files changed, 140 insertions(+), 168 deletions(-)
>=20
> diff --git a/include/linux/rv.h b/include/linux/rv.h
> index 97baf58d88b2..dba53aecdfab 100644
> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -7,6 +7,9 @@
> =C2=A0#ifndef _LINUX_RV_H
> =C2=A0#define _LINUX_RV_H
> =C2=A0
> +#include <linux/types.h>
> +#include <linux/list.h>
> +
> =C2=A0#define MAX_DA_NAME_LEN=0932
> =C2=A0
> =C2=A0#ifdef CONFIG_RV
> @@ -98,8 +101,13 @@ struct rv_monitor {
> =C2=A0=09void=09=09=09(*disable)(void);
> =C2=A0=09void=09=09=09(*reset)(void);
> =C2=A0#ifdef CONFIG_RV_REACTORS
> +=09struct rv_reactor_def=09*rdef;
> =C2=A0=09__printf(1, 2) void=09(*react)(const char *msg, ...);
> +=09bool=09=09=09reacting;
> =C2=A0#endif
> +=09struct list_head=09list;
> +=09struct rv_monitor=09*parent;
> +=09struct dentry=09=09*root_d;
> =C2=A0};
> =C2=A0
> =C2=A0bool rv_monitoring_on(void);
> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index 108429d16ec1..6c0be2fdc52d 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
> @@ -210,9 +210,9 @@ void rv_put_task_monitor_slot(int slot)
> =C2=A0 * Monitors with a parent are nested,
> =C2=A0 * Monitors without a parent could be standalone or containers.
> =C2=A0 */
> -bool rv_is_nested_monitor(struct rv_monitor_def *mdef)
> +bool rv_is_nested_monitor(struct rv_monitor *mon)
> =C2=A0{
> -=09return mdef->parent !=3D NULL;
> +=09return mon->parent !=3D NULL;
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -223,16 +223,16 @@ bool rv_is_nested_monitor(struct rv_monitor_def
> *mdef)
> =C2=A0 * for enable()/disable(). Use this condition to find empty
> containers.
> =C2=A0 * Keep both conditions in case we have some non-compliant
> containers.
> =C2=A0 */
> -bool rv_is_container_monitor(struct rv_monitor_def *mdef)
> +bool rv_is_container_monitor(struct rv_monitor *mon)
> =C2=A0{
> -=09struct rv_monitor_def *next;
> +=09struct rv_monitor *next;
> =C2=A0
> -=09if (list_is_last(&mdef->list, &rv_monitors_list))
> +=09if (list_is_last(&mon->list, &rv_monitors_list))
> =C2=A0=09=09return false;
> =C2=A0
> -=09next =3D list_next_entry(mdef, list);
> +=09next =3D list_next_entry(mon, list);
> =C2=A0
> -=09return next->parent =3D=3D mdef->monitor || !mdef->monitor-
> >enable;
> +=09return next->parent =3D=3D mon || !mon->enable;
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -241,10 +241,10 @@ bool rv_is_container_monitor(struct
> rv_monitor_def *mdef)
> =C2=A0static ssize_t monitor_enable_read_data(struct file *filp, char
> __user *user_buf, size_t count,
> =C2=A0=09=09=09=09=09loff_t *ppos)
> =C2=A0{
> -=09struct rv_monitor_def *mdef =3D filp->private_data;
> +=09struct rv_monitor *mon =3D filp->private_data;
> =C2=A0=09const char *buff;
> =C2=A0
> -=09buff =3D mdef->monitor->enabled ? "1\n" : "0\n";
> +=09buff =3D mon->enabled ? "1\n" : "0\n";
> =C2=A0
> =C2=A0=09return simple_read_from_buffer(user_buf, count, ppos, buff,
> strlen(buff)+1);
> =C2=A0}
> @@ -252,14 +252,14 @@ static ssize_t monitor_enable_read_data(struct
> file *filp, char __user *user_buf
> =C2=A0/*
> =C2=A0 * __rv_disable_monitor - disabled an enabled monitor
> =C2=A0 */
> -static int __rv_disable_monitor(struct rv_monitor_def *mdef, bool
> sync)
> +static int __rv_disable_monitor(struct rv_monitor *mon, bool sync)
> =C2=A0{
> =C2=A0=09lockdep_assert_held(&rv_interface_lock);
> =C2=A0
> -=09if (mdef->monitor->enabled) {
> -=09=09mdef->monitor->enabled =3D 0;
> -=09=09if (mdef->monitor->disable)
> -=09=09=09mdef->monitor->disable();
> +=09if (mon->enabled) {
> +=09=09mon->enabled =3D 0;
> +=09=09if (mon->disable)
> +=09=09=09mon->disable();
> =C2=A0
> =C2=A0=09=09/*
> =C2=A0=09=09 * Wait for the execution of all events to finish.
> @@ -273,90 +273,90 @@ static int __rv_disable_monitor(struct
> rv_monitor_def *mdef, bool sync)
> =C2=A0=09return 0;
> =C2=A0}
> =C2=A0
> -static void rv_disable_single(struct rv_monitor_def *mdef)
> +static void rv_disable_single(struct rv_monitor *mon)
> =C2=A0{
> -=09__rv_disable_monitor(mdef, true);
> +=09__rv_disable_monitor(mon, true);
> =C2=A0}
> =C2=A0
> -static int rv_enable_single(struct rv_monitor_def *mdef)
> +static int rv_enable_single(struct rv_monitor *mon)
> =C2=A0{
> =C2=A0=09int retval;
> =C2=A0
> =C2=A0=09lockdep_assert_held(&rv_interface_lock);
> =C2=A0
> -=09if (mdef->monitor->enabled)
> +=09if (mon->enabled)
> =C2=A0=09=09return 0;
> =C2=A0
> -=09retval =3D mdef->monitor->enable();
> +=09retval =3D mon->enable();
> =C2=A0
> =C2=A0=09if (!retval)
> -=09=09mdef->monitor->enabled =3D 1;
> +=09=09mon->enabled =3D 1;
> =C2=A0
> =C2=A0=09return retval;
> =C2=A0}
> =C2=A0
> -static void rv_disable_container(struct rv_monitor_def *mdef)
> +static void rv_disable_container(struct rv_monitor *mon)
> =C2=A0{
> -=09struct rv_monitor_def *p =3D mdef;
> +=09struct rv_monitor *p =3D mon;
> =C2=A0=09int enabled =3D 0;
> =C2=A0
> =C2=A0=09list_for_each_entry_continue(p, &rv_monitors_list, list) {
> -=09=09if (p->parent !=3D mdef->monitor)
> +=09=09if (p->parent !=3D mon)
> =C2=A0=09=09=09break;
> =C2=A0=09=09enabled +=3D __rv_disable_monitor(p, false);
> =C2=A0=09}
> =C2=A0=09if (enabled)
> =C2=A0=09=09tracepoint_synchronize_unregister();
> -=09mdef->monitor->enabled =3D 0;
> +=09mon->enabled =3D 0;
> =C2=A0}
> =C2=A0
> -static int rv_enable_container(struct rv_monitor_def *mdef)
> +static int rv_enable_container(struct rv_monitor *mon)
> =C2=A0{
> -=09struct rv_monitor_def *p =3D mdef;
> +=09struct rv_monitor *p =3D mon;
> =C2=A0=09int retval =3D 0;
> =C2=A0
> =C2=A0=09list_for_each_entry_continue(p, &rv_monitors_list, list) {
> -=09=09if (retval || p->parent !=3D mdef->monitor)
> +=09=09if (retval || p->parent !=3D mon)
> =C2=A0=09=09=09break;
> =C2=A0=09=09retval =3D rv_enable_single(p);
> =C2=A0=09}
> =C2=A0=09if (retval)
> -=09=09rv_disable_container(mdef);
> +=09=09rv_disable_container(mon);
> =C2=A0=09else
> -=09=09mdef->monitor->enabled =3D 1;
> +=09=09mon->enabled =3D 1;
> =C2=A0=09return retval;
> =C2=A0}
> =C2=A0
> =C2=A0/**
> =C2=A0 * rv_disable_monitor - disable a given runtime monitor
> - * @mdef: Pointer to the monitor definition structure.
> + * @mon: Pointer to the monitor definition structure.
> =C2=A0 *
> =C2=A0 * Returns 0 on success.
> =C2=A0 */
> -int rv_disable_monitor(struct rv_monitor_def *mdef)
> +int rv_disable_monitor(struct rv_monitor *mon)
> =C2=A0{
> -=09if (rv_is_container_monitor(mdef))
> -=09=09rv_disable_container(mdef);
> +=09if (rv_is_container_monitor(mon))
> +=09=09rv_disable_container(mon);
> =C2=A0=09else
> -=09=09rv_disable_single(mdef);
> +=09=09rv_disable_single(mon);
> =C2=A0
> =C2=A0=09return 0;
> =C2=A0}
> =C2=A0
> =C2=A0/**
> =C2=A0 * rv_enable_monitor - enable a given runtime monitor
> - * @mdef: Pointer to the monitor definition structure.
> + * @mon: Pointer to the monitor definition structure.
> =C2=A0 *
> =C2=A0 * Returns 0 on success, error otherwise.
> =C2=A0 */
> -int rv_enable_monitor(struct rv_monitor_def *mdef)
> +int rv_enable_monitor(struct rv_monitor *mon)
> =C2=A0{
> =C2=A0=09int retval;
> =C2=A0
> -=09if (rv_is_container_monitor(mdef))
> -=09=09retval =3D rv_enable_container(mdef);
> +=09if (rv_is_container_monitor(mon))
> +=09=09retval =3D rv_enable_container(mon);
> =C2=A0=09else
> -=09=09retval =3D rv_enable_single(mdef);
> +=09=09retval =3D rv_enable_single(mon);
> =C2=A0
> =C2=A0=09return retval;
> =C2=A0}
> @@ -367,7 +367,7 @@ int rv_enable_monitor(struct rv_monitor_def
> *mdef)
> =C2=A0static ssize_t monitor_enable_write_data(struct file *filp, const
> char __user *user_buf,
> =C2=A0=09=09=09=09=09 size_t count, loff_t *ppos)
> =C2=A0{
> -=09struct rv_monitor_def *mdef =3D filp->private_data;
> +=09struct rv_monitor *mon =3D filp->private_data;
> =C2=A0=09int retval;
> =C2=A0=09bool val;
> =C2=A0
> @@ -378,9 +378,9 @@ static ssize_t monitor_enable_write_data(struct
> file *filp, const char __user *u
> =C2=A0=09mutex_lock(&rv_interface_lock);
> =C2=A0
> =C2=A0=09if (val)
> -=09=09retval =3D rv_enable_monitor(mdef);
> +=09=09retval =3D rv_enable_monitor(mon);
> =C2=A0=09else
> -=09=09retval =3D rv_disable_monitor(mdef);
> +=09=09retval =3D rv_disable_monitor(mon);
> =C2=A0
> =C2=A0=09mutex_unlock(&rv_interface_lock);
> =C2=A0
> @@ -399,12 +399,12 @@ static const struct file_operations
> interface_enable_fops =3D {
> =C2=A0static ssize_t monitor_desc_read_data(struct file *filp, char __use=
r
> *user_buf, size_t count,
> =C2=A0=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loff_t *ppos)
> =C2=A0{
> -=09struct rv_monitor_def *mdef =3D filp->private_data;
> +=09struct rv_monitor *mon =3D filp->private_data;
> =C2=A0=09char buff[256];
> =C2=A0
> =C2=A0=09memset(buff, 0, sizeof(buff));
> =C2=A0
> -=09snprintf(buff, sizeof(buff), "%s\n", mdef->monitor-
> >description);
> +=09snprintf(buff, sizeof(buff), "%s\n", mon->description);
> =C2=A0
> =C2=A0=09return simple_read_from_buffer(user_buf, count, ppos, buff,
> strlen(buff) + 1);
> =C2=A0}
> @@ -419,37 +419,37 @@ static const struct file_operations
> interface_desc_fops =3D {
> =C2=A0 * the monitor dir, where the specific options of the monitor
> =C2=A0 * are exposed.
> =C2=A0 */
> -static int create_monitor_dir(struct rv_monitor_def *mdef, struct
> rv_monitor_def *parent)
> +static int create_monitor_dir(struct rv_monitor *mon, struct
> rv_monitor *parent)
> =C2=A0{
> =C2=A0=09struct dentry *root =3D parent ? parent->root_d :
> get_monitors_root();
> -=09const char *name =3D mdef->monitor->name;
> +=09const char *name =3D mon->name;
> =C2=A0=09struct dentry *tmp;
> =C2=A0=09int retval;
> =C2=A0
> -=09mdef->root_d =3D rv_create_dir(name, root);
> -=09if (!mdef->root_d)
> +=09mon->root_d =3D rv_create_dir(name, root);
> +=09if (!mon->root_d)
> =C2=A0=09=09return -ENOMEM;
> =C2=A0
> -=09tmp =3D rv_create_file("enable", RV_MODE_WRITE, mdef->root_d,
> mdef, &interface_enable_fops);
> +=09tmp =3D rv_create_file("enable", RV_MODE_WRITE, mon->root_d,
> mon, &interface_enable_fops);
> =C2=A0=09if (!tmp) {
> =C2=A0=09=09retval =3D -ENOMEM;
> =C2=A0=09=09goto out_remove_root;
> =C2=A0=09}
> =C2=A0
> -=09tmp =3D rv_create_file("desc", RV_MODE_READ, mdef->root_d,
> mdef, &interface_desc_fops);
> +=09tmp =3D rv_create_file("desc", RV_MODE_READ, mon->root_d, mon,
> &interface_desc_fops);
> =C2=A0=09if (!tmp) {
> =C2=A0=09=09retval =3D -ENOMEM;
> =C2=A0=09=09goto out_remove_root;
> =C2=A0=09}
> =C2=A0
> -=09retval =3D reactor_populate_monitor(mdef);
> +=09retval =3D reactor_populate_monitor(mon);
> =C2=A0=09if (retval)
> =C2=A0=09=09goto out_remove_root;
> =C2=A0
> =C2=A0=09return 0;
> =C2=A0
> =C2=A0out_remove_root:
> -=09rv_remove(mdef->root_d);
> +=09rv_remove(mon->root_d);
> =C2=A0=09return retval;
> =C2=A0}
> =C2=A0
> @@ -458,13 +458,12 @@ static int create_monitor_dir(struct
> rv_monitor_def *mdef, struct rv_monitor_def
> =C2=A0 */
> =C2=A0static int monitors_show(struct seq_file *m, void *p)
> =C2=A0{
> -=09struct rv_monitor_def *mon_def =3D p;
> +=09struct rv_monitor *mon =3D p;
> =C2=A0
> -=09if (mon_def->parent)
> -=09=09seq_printf(m, "%s:%s\n", mon_def->parent->name,
> -=09=09=09=C2=A0=C2=A0 mon_def->monitor->name);
> +=09if (mon->parent)
> +=09=09seq_printf(m, "%s:%s\n", mon->parent->name, mon-
> >name);
> =C2=A0=09else
> -=09=09seq_printf(m, "%s\n", mon_def->monitor->name);
> +=09=09seq_printf(m, "%s\n", mon->name);
> =C2=A0=09return 0;
> =C2=A0}
> =C2=A0
> @@ -496,13 +495,13 @@ static void *available_monitors_next(struct
> seq_file *m, void *p, loff_t *pos)
> =C2=A0 */
> =C2=A0static void *enabled_monitors_next(struct seq_file *m, void *p,
> loff_t *pos)
> =C2=A0{
> -=09struct rv_monitor_def *m_def =3D p;
> +=09struct rv_monitor *mon =3D p;
> =C2=A0
> =C2=A0=09(*pos)++;
> =C2=A0
> -=09list_for_each_entry_continue(m_def, &rv_monitors_list, list)
> {
> -=09=09if (m_def->monitor->enabled)
> -=09=09=09return m_def;
> +=09list_for_each_entry_continue(mon, &rv_monitors_list, list) {
> +=09=09if (mon->enabled)
> +=09=09=09return mon;
> =C2=A0=09}
> =C2=A0
> =C2=A0=09return NULL;
> @@ -510,7 +509,7 @@ static void *enabled_monitors_next(struct
> seq_file *m, void *p, loff_t *pos)
> =C2=A0
> =C2=A0static void *enabled_monitors_start(struct seq_file *m, loff_t *pos=
)
> =C2=A0{
> -=09struct rv_monitor_def *m_def;
> +=09struct rv_monitor *mon;
> =C2=A0=09loff_t l;
> =C2=A0
> =C2=A0=09mutex_lock(&rv_interface_lock);
> @@ -518,15 +517,15 @@ static void *enabled_monitors_start(struct
> seq_file *m, loff_t *pos)
> =C2=A0=09if (list_empty(&rv_monitors_list))
> =C2=A0=09=09return NULL;
> =C2=A0
> -=09m_def =3D list_entry(&rv_monitors_list, struct rv_monitor_def,
> list);
> +=09mon =3D list_entry(&rv_monitors_list, struct rv_monitor,
> list);
> =C2=A0
> =C2=A0=09for (l =3D 0; l <=3D *pos; ) {
> -=09=09m_def =3D enabled_monitors_next(m, m_def, &l);
> -=09=09if (!m_def)
> +=09=09mon =3D enabled_monitors_next(m, mon, &l);
> +=09=09if (!mon)
> =C2=A0=09=09=09break;
> =C2=A0=09}
> =C2=A0
> -=09return m_def;
> +=09return mon;
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -566,13 +565,13 @@ static const struct file_operations
> available_monitors_ops =3D {
> =C2=A0 */
> =C2=A0static void disable_all_monitors(void)
> =C2=A0{
> -=09struct rv_monitor_def *mdef;
> +=09struct rv_monitor *mon;
> =C2=A0=09int enabled =3D 0;
> =C2=A0
> =C2=A0=09mutex_lock(&rv_interface_lock);
> =C2=A0
> -=09list_for_each_entry(mdef, &rv_monitors_list, list)
> -=09=09enabled +=3D __rv_disable_monitor(mdef, false);
> +=09list_for_each_entry(mon, &rv_monitors_list, list)
> +=09=09enabled +=3D __rv_disable_monitor(mon, false);
> =C2=A0
> =C2=A0=09if (enabled) {
> =C2=A0=09=09/*
> @@ -598,7 +597,7 @@ static ssize_t enabled_monitors_write(struct file
> *filp, const char __user *user
> =C2=A0=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t count, loff_t *pp=
os)
> =C2=A0{
> =C2=A0=09char buff[MAX_RV_MONITOR_NAME_SIZE + 2];
> -=09struct rv_monitor_def *mdef;
> +=09struct rv_monitor *mon;
> =C2=A0=09int retval =3D -EINVAL;
> =C2=A0=09bool enable =3D true;
> =C2=A0=09char *ptr, *tmp;
> @@ -633,17 +632,17 @@ static ssize_t enabled_monitors_write(struct
> file *filp, const char __user *user
> =C2=A0=09if (tmp)
> =C2=A0=09=09ptr =3D tmp+1;
> =C2=A0
> -=09list_for_each_entry(mdef, &rv_monitors_list, list) {
> -=09=09if (strcmp(ptr, mdef->monitor->name) !=3D 0)
> +=09list_for_each_entry(mon, &rv_monitors_list, list) {
> +=09=09if (strcmp(ptr, mon->name) !=3D 0)
> =C2=A0=09=09=09continue;
> =C2=A0
> =C2=A0=09=09/*
> =C2=A0=09=09 * Monitor found!
> =C2=A0=09=09 */
> =C2=A0=09=09if (enable)
> -=09=09=09retval =3D rv_enable_monitor(mdef);
> +=09=09=09retval =3D rv_enable_monitor(mon);
> =C2=A0=09=09else
> -=09=09=09retval =3D rv_disable_monitor(mdef);
> +=09=09=09retval =3D rv_disable_monitor(mon);
> =C2=A0
> =C2=A0=09=09if (!retval)
> =C2=A0=09=09=09retval =3D count;
> @@ -702,11 +701,11 @@ static void turn_monitoring_off(void)
> =C2=A0
> =C2=A0static void reset_all_monitors(void)
> =C2=A0{
> -=09struct rv_monitor_def *mdef;
> +=09struct rv_monitor *mon;
> =C2=A0
> -=09list_for_each_entry(mdef, &rv_monitors_list, list) {
> -=09=09if (mdef->monitor->enabled && mdef->monitor->reset)
> -=09=09=09mdef->monitor->reset();
> +=09list_for_each_entry(mon, &rv_monitors_list, list) {
> +=09=09if (mon->enabled && mon->reset)
> +=09=09=09mon->reset();
> =C2=A0=09}
> =C2=A0}
> =C2=A0
> @@ -768,10 +767,10 @@ static const struct file_operations
> monitoring_on_fops =3D {
> =C2=A0=09.read=C2=A0=C2=A0 =3D monitoring_on_read_data,
> =C2=A0};
> =C2=A0
> -static void destroy_monitor_dir(struct rv_monitor_def *mdef)
> +static void destroy_monitor_dir(struct rv_monitor *mon)
> =C2=A0{
> -=09reactor_cleanup_monitor(mdef);
> -=09rv_remove(mdef->root_d);
> +=09reactor_cleanup_monitor(mon);
> +=09rv_remove(mon->root_d);
> =C2=A0}
> =C2=A0
> =C2=A0/**
> @@ -783,7 +782,7 @@ static void destroy_monitor_dir(struct
> rv_monitor_def *mdef)
> =C2=A0 */
> =C2=A0int rv_register_monitor(struct rv_monitor *monitor, struct
> rv_monitor *parent)
> =C2=A0{
> -=09struct rv_monitor_def *r, *p =3D NULL;
> +=09struct rv_monitor *r;
> =C2=A0=09int retval =3D 0;
> =C2=A0
> =C2=A0=09if (strlen(monitor->name) >=3D MAX_RV_MONITOR_NAME_SIZE) {
> @@ -795,49 +794,31 @@ int rv_register_monitor(struct rv_monitor
> *monitor, struct rv_monitor *parent)
> =C2=A0=09mutex_lock(&rv_interface_lock);
> =C2=A0
> =C2=A0=09list_for_each_entry(r, &rv_monitors_list, list) {
> -=09=09if (strcmp(monitor->name, r->monitor->name) =3D=3D 0) {
> +=09=09if (strcmp(monitor->name, r->name) =3D=3D 0) {
> =C2=A0=09=09=09pr_info("Monitor %s is already
> registered\n", monitor->name);
> =C2=A0=09=09=09retval =3D -EEXIST;
> =C2=A0=09=09=09goto out_unlock;
> =C2=A0=09=09}
> =C2=A0=09}
> =C2=A0
> -=09if (parent) {
> -=09=09list_for_each_entry(r, &rv_monitors_list, list) {
> -=09=09=09if (strcmp(parent->name, r->monitor->name)
> =3D=3D 0) {
> -=09=09=09=09p =3D r;
> -=09=09=09=09break;
> -=09=09=09}
> -=09=09}
> -=09}
> -
> -=09if (p && rv_is_nested_monitor(p)) {
> +=09if (parent && rv_is_nested_monitor(parent)) {
> =C2=A0=09=09pr_info("Parent monitor %s is already nested, cannot
> nest further\n",
> =C2=A0=09=09=09parent->name);
> =C2=A0=09=09retval =3D -EINVAL;
> =C2=A0=09=09goto out_unlock;
> =C2=A0=09}
> =C2=A0
> -=09r =3D kzalloc(sizeof(struct rv_monitor_def), GFP_KERNEL);
> -=09if (!r) {
> -=09=09retval =3D -ENOMEM;
> -=09=09goto out_unlock;
> -=09}
> -
> -=09r->monitor =3D monitor;
> -=09r->parent =3D parent;
> +=09monitor->parent =3D parent;
> =C2=A0
> -=09retval =3D create_monitor_dir(r, p);
> -=09if (retval) {
> -=09=09kfree(r);
> -=09=09goto out_unlock;
> -=09}
> +=09retval =3D create_monitor_dir(monitor, parent);
> +=09if (retval)
> +=09=09return retval;
> =C2=A0
> =C2=A0=09/* keep children close to the parent for easier
> visualisation */
> -=09if (p)
> -=09=09list_add(&r->list, &p->list);
> +=09if (parent)
> +=09=09list_add(&monitor->list, &parent->list);
> =C2=A0=09else
> -=09=09list_add_tail(&r->list, &rv_monitors_list);
> +=09=09list_add_tail(&monitor->list, &rv_monitors_list);
> =C2=A0
> =C2=A0out_unlock:
> =C2=A0=09mutex_unlock(&rv_interface_lock);
> @@ -852,17 +833,11 @@ int rv_register_monitor(struct rv_monitor
> *monitor, struct rv_monitor *parent)
> =C2=A0 */
> =C2=A0int rv_unregister_monitor(struct rv_monitor *monitor)
> =C2=A0{
> -=09struct rv_monitor_def *ptr, *next;
> -
> =C2=A0=09mutex_lock(&rv_interface_lock);
> =C2=A0
> -=09list_for_each_entry_safe(ptr, next, &rv_monitors_list, list)
> {
> -=09=09if (strcmp(monitor->name, ptr->monitor->name) =3D=3D 0)
> {
> -=09=09=09rv_disable_monitor(ptr);
> -=09=09=09list_del(&ptr->list);
> -=09=09=09destroy_monitor_dir(ptr);
> -=09=09}
> -=09}
> +=09rv_disable_monitor(monitor);
> +=09list_del(&monitor->list);
> +=09destroy_monitor_dir(monitor);
> =C2=A0
> =C2=A0=09mutex_unlock(&rv_interface_lock);
> =C2=A0=09return 0;
> diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
> index 873364094402..f039ec1c9156 100644
> --- a/kernel/trace/rv/rv.h
> +++ b/kernel/trace/rv/rv.h
> @@ -32,34 +32,23 @@ struct rv_reactor_def {
> =C2=A0};
> =C2=A0#endif
> =C2=A0
> -struct rv_monitor_def {
> -=09struct list_head=09list;
> -=09struct rv_monitor=09*monitor;
> -=09struct rv_monitor=09*parent;
> -=09struct dentry=09=09*root_d;
> -#ifdef CONFIG_RV_REACTORS
> -=09struct rv_reactor_def=09*rdef;
> -=09bool=09=09=09reacting;
> -#endif
> -};
> -
> =C2=A0struct dentry *get_monitors_root(void);
> -int rv_disable_monitor(struct rv_monitor_def *mdef);
> -int rv_enable_monitor(struct rv_monitor_def *mdef);
> -bool rv_is_container_monitor(struct rv_monitor_def *mdef);
> -bool rv_is_nested_monitor(struct rv_monitor_def *mdef);
> +int rv_disable_monitor(struct rv_monitor *mon);
> +int rv_enable_monitor(struct rv_monitor *mon);
> +bool rv_is_container_monitor(struct rv_monitor *mon);
> +bool rv_is_nested_monitor(struct rv_monitor *mon);
> =C2=A0
> =C2=A0#ifdef CONFIG_RV_REACTORS
> -int reactor_populate_monitor(struct rv_monitor_def *mdef);
> -void reactor_cleanup_monitor(struct rv_monitor_def *mdef);
> +int reactor_populate_monitor(struct rv_monitor *mon);
> +void reactor_cleanup_monitor(struct rv_monitor *mon);
> =C2=A0int init_rv_reactors(struct dentry *root_dir);
> =C2=A0#else
> -static inline int reactor_populate_monitor(struct rv_monitor_def
> *mdef)
> +static inline int reactor_populate_monitor(struct rv_monitor *mon)
> =C2=A0{
> =C2=A0=09return 0;
> =C2=A0}
> =C2=A0
> -static inline void reactor_cleanup_monitor(struct rv_monitor_def
> *mdef)
> +static inline void reactor_cleanup_monitor(struct rv_monitor *mon)
> =C2=A0{
> =C2=A0=09return;
> =C2=A0}
> diff --git a/kernel/trace/rv/rv_reactors.c
> b/kernel/trace/rv/rv_reactors.c
> index 740603670dd1..7cc620a1be1a 100644
> --- a/kernel/trace/rv/rv_reactors.c
> +++ b/kernel/trace/rv/rv_reactors.c
> @@ -138,10 +138,10 @@ static const struct file_operations
> available_reactors_ops =3D {
> =C2=A0 */
> =C2=A0static int monitor_reactor_show(struct seq_file *m, void *p)
> =C2=A0{
> -=09struct rv_monitor_def *mdef =3D m->private;
> +=09struct rv_monitor *mon =3D m->private;
> =C2=A0=09struct rv_reactor_def *rdef =3D p;
> =C2=A0
> -=09if (mdef->rdef =3D=3D rdef)
> +=09if (mon->rdef =3D=3D rdef)
> =C2=A0=09=09seq_printf(m, "[%s]\n", rdef->reactor->name);
> =C2=A0=09else
> =C2=A0=09=09seq_printf(m, "%s\n", rdef->reactor->name);
> @@ -158,41 +158,41 @@ static const struct seq_operations
> monitor_reactors_seq_ops =3D {
> =C2=A0=09.show=09=3D monitor_reactor_show
> =C2=A0};
> =C2=A0
> -static void monitor_swap_reactors_single(struct rv_monitor_def
> *mdef,
> +static void monitor_swap_reactors_single(struct rv_monitor *mon,
> =C2=A0=09=09=09=09=09 struct rv_reactor_def
> *rdef,
> =C2=A0=09=09=09=09=09 bool reacting, bool nested)
> =C2=A0{
> =C2=A0=09bool monitor_enabled;
> =C2=A0
> =C2=A0=09/* nothing to do */
> -=09if (mdef->rdef =3D=3D rdef)
> +=09if (mon->rdef =3D=3D rdef)
> =C2=A0=09=09return;
> =C2=A0
> -=09monitor_enabled =3D mdef->monitor->enabled;
> +=09monitor_enabled =3D mon->enabled;
> =C2=A0=09if (monitor_enabled)
> -=09=09rv_disable_monitor(mdef);
> +=09=09rv_disable_monitor(mon);
> =C2=A0
> =C2=A0=09/* swap reactor's usage */
> -=09mdef->rdef->counter--;
> +=09mon->rdef->counter--;
> =C2=A0=09rdef->counter++;
> =C2=A0
> -=09mdef->rdef =3D rdef;
> -=09mdef->reacting =3D reacting;
> -=09mdef->monitor->react =3D rdef->reactor->react;
> +=09mon->rdef =3D rdef;
> +=09mon->reacting =3D reacting;
> +=09mon->react =3D rdef->reactor->react;
> =C2=A0
> =C2=A0=09/* enable only once if iterating through a container */
> =C2=A0=09if (monitor_enabled && !nested)
> -=09=09rv_enable_monitor(mdef);
> +=09=09rv_enable_monitor(mon);
> =C2=A0}
> =C2=A0
> -static void monitor_swap_reactors(struct rv_monitor_def *mdef,
> +static void monitor_swap_reactors(struct rv_monitor *mon,
> =C2=A0=09=09=09=09=C2=A0 struct rv_reactor_def *rdef, bool
> reacting)
> =C2=A0{
> -=09struct rv_monitor_def *p =3D mdef;
> +=09struct rv_monitor *p =3D mon;
> =C2=A0
> -=09if (rv_is_container_monitor(mdef))
> +=09if (rv_is_container_monitor(mon))
> =C2=A0=09=09list_for_each_entry_continue(p, &rv_monitors_list,
> list) {
> -=09=09=09if (p->parent !=3D mdef->monitor)
> +=09=09=09if (p->parent !=3D mon)
> =C2=A0=09=09=09=09break;
> =C2=A0=09=09=09monitor_swap_reactors_single(p, rdef,
> reacting, true);
> =C2=A0=09=09}
> @@ -202,7 +202,7 @@ static void monitor_swap_reactors(struct
> rv_monitor_def *mdef,
> =C2=A0=09 * All nested monitors are enabled also if they were off, we
> may refine
> =C2=A0=09 * this logic in the future.
> =C2=A0=09 */
> -=09monitor_swap_reactors_single(mdef, rdef, reacting, false);
> +=09monitor_swap_reactors_single(mon, rdef, reacting, false);
> =C2=A0}
> =C2=A0
> =C2=A0static ssize_t
> @@ -210,7 +210,7 @@ monitor_reactors_write(struct file *file, const
> char __user *user_buf,
> =C2=A0=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t count, loff_t *ppos)
> =C2=A0{
> =C2=A0=09char buff[MAX_RV_REACTOR_NAME_SIZE + 2];
> -=09struct rv_monitor_def *mdef;
> +=09struct rv_monitor *mon;
> =C2=A0=09struct rv_reactor_def *rdef;
> =C2=A0=09struct seq_file *seq_f;
> =C2=A0=09int retval =3D -EINVAL;
> @@ -237,7 +237,7 @@ monitor_reactors_write(struct file *file, const
> char __user *user_buf,
> =C2=A0=09 * See monitor_reactors_open()
> =C2=A0=09 */
> =C2=A0=09seq_f =3D file->private_data;
> -=09mdef =3D seq_f->private;
> +=09mon =3D seq_f->private;
> =C2=A0
> =C2=A0=09mutex_lock(&rv_interface_lock);
> =C2=A0
> @@ -252,7 +252,7 @@ monitor_reactors_write(struct file *file, const
> char __user *user_buf,
> =C2=A0=09=09else
> =C2=A0=09=09=09enable =3D true;
> =C2=A0
> -=09=09monitor_swap_reactors(mdef, rdef, enable);
> +=09=09monitor_swap_reactors(mon, rdef, enable);
> =C2=A0
> =C2=A0=09=09retval =3D count;
> =C2=A0=09=09break;
> @@ -268,7 +268,7 @@ monitor_reactors_write(struct file *file, const
> char __user *user_buf,
> =C2=A0 */
> =C2=A0static int monitor_reactors_open(struct inode *inode, struct file
> *file)
> =C2=A0{
> -=09struct rv_monitor_def *mdef =3D inode->i_private;
> +=09struct rv_monitor *mon =3D inode->i_private;
> =C2=A0=09struct seq_file *seq_f;
> =C2=A0=09int ret;
> =C2=A0
> @@ -284,7 +284,7 @@ static int monitor_reactors_open(struct inode
> *inode, struct file *file)
> =C2=A0=09/*
> =C2=A0=09 * Copy the create file "private" data to the seq_file
> private data.
> =C2=A0=09 */
> -=09seq_f->private =3D mdef;
> +=09seq_f->private =3D mon;
> =C2=A0
> =C2=A0=09return 0;
> =C2=A0};
> @@ -454,37 +454,37 @@ static const struct file_operations
> reacting_on_fops =3D {
> =C2=A0
> =C2=A0/**
> =C2=A0 * reactor_populate_monitor - creates per monitor reactors file
> - * @mdef:=09monitor's definition.
> + * @mon:=09The monitor.
> =C2=A0 *
> =C2=A0 * Returns 0 if successful, error otherwise.
> =C2=A0 */
> -int reactor_populate_monitor(struct rv_monitor_def *mdef)
> +int reactor_populate_monitor(struct rv_monitor *mon)
> =C2=A0{
> =C2=A0=09struct dentry *tmp;
> =C2=A0
> -=09tmp =3D rv_create_file("reactors", RV_MODE_WRITE, mdef-
> >root_d, mdef, &monitor_reactors_ops);
> +=09tmp =3D rv_create_file("reactors", RV_MODE_WRITE, mon->root_d,
> mon, &monitor_reactors_ops);
> =C2=A0=09if (!tmp)
> =C2=A0=09=09return -ENOMEM;
> =C2=A0
> =C2=A0=09/*
> =C2=A0=09 * Configure as the rv_nop reactor.
> =C2=A0=09 */
> -=09mdef->rdef =3D get_reactor_rdef_by_name("nop");
> -=09mdef->rdef->counter++;
> -=09mdef->reacting =3D false;
> +=09mon->rdef =3D get_reactor_rdef_by_name("nop");
> +=09mon->rdef->counter++;
> +=09mon->reacting =3D false;
> =C2=A0
> =C2=A0=09return 0;
> =C2=A0}
> =C2=A0
> =C2=A0/**
> =C2=A0 * reactor_cleanup_monitor - cleanup a monitor reference
> - * @mdef:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 monitor's definition.
> + * @mon:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the monitor.
> =C2=A0 */
> -void reactor_cleanup_monitor(struct rv_monitor_def *mdef)
> +void reactor_cleanup_monitor(struct rv_monitor *mon)
> =C2=A0{
> =C2=A0=09lockdep_assert_held(&rv_interface_lock);
> -=09mdef->rdef->counter--;
> -=09WARN_ON_ONCE(mdef->rdef->counter < 0);
> +=09mon->rdef->counter--;
> +=09WARN_ON_ONCE(mon->rdef->counter < 0);
> =C2=A0}
> =C2=A0
> =C2=A0/*


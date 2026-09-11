Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CE0440630
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 06:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789109627; cv=none; b=SvGNn1fSAJqNcGkdlmS1v8PK9A6yAAqv/shet+wXJ8WQ2myFWalpp9sSX9tWv6gLub34+yTE2+9X3ikV3zI6FvnyfuKtSmgg5XZF10keAON5yJIKj4hV668mq7HRlW2m49O+OCuushB4smrO7NDX0U815q3G3AP+Wk11nTAARCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789109627; c=relaxed/simple;
	bh=Ohd1NFB0IXU8jz8CK7K7mRmN+2gXKpvVzdyDRVnvAkw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qSdUM6X6N1VFjXJ/YdmOMX/5NTxVhIuFCD4dhFBNeRCH1/A4BudGVW+vvpTycV3OEfU5Eo4HYxESQP37WppZCi5NzKuDMyjh/SBqT79mATVGIQcosQhCf4UG0EfQBeAZ7JhK1Nkw/Hb9jMhZ0ewqbbHwBNx7k7bCpZ/uyVyVclU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PNTw+uM7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PNTw+uM7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789109618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ohd1NFB0IXU8jz8CK7K7mRmN+2gXKpvVzdyDRVnvAkw=;
	b=PNTw+uM7bcAnd+Rq2Q9CfjPZWDqnKmwYF0ldyfvO4GwReHkRuSFnIag5qo/DFqcX6jBdn9
	8gqHoMdmqZrRu30m3NydsIdflUQ4YfK2+jYKFw27twOg1jUYmAvWJsm98oqtWqrt/wi/Tz
	JRyOqjNRzLNOjVdAOOCveR8FfKoUgXk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-haPDqdfAOnuaVtqz13tFNg-1; Fri, 11 Sep 2026 02:53:37 -0400
X-MC-Unique: haPDqdfAOnuaVtqz13tFNg-1
X-Mimecast-MFC-AGG-ID: haPDqdfAOnuaVtqz13tFNg_1789109616
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-485835753caso372421f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Sep 2026 23:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789109616; x=1789714416;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CUiWZRov/457RXv0Axbnnwf3f4Hs0T8xh/BGp2XYrEo=;
        b=crvS4nw9T4TJIbp7xFxeGRMR6MpHuaIAFjOrQLiP18VLd+JuJjCuOzhY/j10R8fHkF
         FhLZJ2NZ0mf44Dz5G5zxM4/hOlWkl9gJTnRtJ0vgkScc0ZdoXMGdokIu7EsMJfrBzr9b
         rjIcW0EQf+5If9VCUWIoK8zbV7cGAY6i9YhIo6h+H+H7Bzsy9xlrmgiSS+yQXCE7fM1I
         cEG1oo5uXNQt0uwquqsV2yS+jqUYDPb33ap9hAksvOKgJNUOEWnqRPWjzlT3a1LCHl5Z
         iXZJe+eLGEersJHI+ZaEsW66O17pFfWx7IQkYhyLL+IFPjC2M2eCVNTy7PR3w5hJpX0R
         aH8w==
X-Forwarded-Encrypted: i=1; AKwUvBxGlLF/2EQEHKW8fc530ndSvQlLdo/r3x3JWy7w3sFoQyikxQALYo7jmSFuu6h4ENbO4OEOaA7HxoumwM8dhxPn69E=@vger.kernel.org
X-Gm-Message-State: AFuF++ntL727RXx2PTuO9F+96Z/6W25v1JBYwQ7d3rK/VOHgznkmq0/A
	gcoC/gFD/w5B/Qwl3Z4ml5jCPEP9T3ypUeEcs1cF3IXbpnQP+IO2e2QJo6jWI8OZI2U78rm6bpJ
	DHCkAE2RUxXGTt3RUHFFSk7OJe3xBhcN8NM5cd38/O2ghIy+tso8Vs+PjtHY/JNQdaT/+F6yuWG
	zcWcwqs/sz
X-Gm-Gg: AYBFou3gQViv5gK2H2ymirqrewa8N1141/+RHILrvjyF0d/YWqYiowy2no5512oGDlE
	pcoIPISSaCYl92X0F+QB4A3MjBoMi1VEJtFb8oHjtgR9g0GBgi1kYp4JoZ5hVDpH9hPYDyA2qVY
	hGxxTlRH15GSzSccsrOTmBRYIuYuXhv0SVBj9X4PFWGDusNzluon6lTfT9bYkswgecuzoEZ4Hzo
	YDzy8y89BpqIt7P6VdJAaZflJ0UqEOJgoIkhNVLpB8Q6R8U0/4c4sTAIq+e3xORggUvMfAHgjBZ
	uHT79YL/fwplNg4WcGrUjV3aOJthzoMNCYVQZUeMcx5ACF8BDjmrj/S1o1mnrYVgfMlEPkalblc
	U73bpv1rHB1PXg6f61OhRPHnbR9WzeQ==
X-Received: by 2002:a05:6000:25f4:b0:486:e723:efb with SMTP id ffacd0b85a97d-486eb46ae78mr2581468f8f.57.1789109615874;
        Thu, 10 Sep 2026 23:53:35 -0700 (PDT)
X-Received: by 2002:a05:6000:25f4:b0:486:e723:efb with SMTP id ffacd0b85a97d-486eb46ae78mr2581456f8f.57.1789109615462;
        Thu, 10 Sep 2026 23:53:35 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.135.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32d3c7sm3615184f8f.10.2026.09.10.23.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 23:53:34 -0700 (PDT)
Message-ID: <b5ec9da630968a5f801623c8d6e2aaeb0bb509d8.camel@redhat.com>
Subject: Re: [PATCH v5 3/5] rv/reactors: export rv_register_reactor() and
 rv_unregister_reactor()
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 11 Sep 2026 08:53:33 +0200
In-Reply-To: <7c931773dacd7c3da35a22629c3d7dc286b5a0fe.1788705281.git.wen.yang@linux.dev>
References: <cover.1788705281.git.wen.yang@linux.dev>
	 <7c931773dacd7c3da35a22629c3d7dc286b5a0fe.1788705281.git.wen.yang@linux.dev>
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
X-Mimecast-MFC-PROC-ID: XGhGVUry4SmTngGYZYqyHo4idu7B5ikblVm3TETR-j4_1789109616
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-09-07 at 01:10 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> rv_react() is exported to modules, but the reactor registration helpers
> are not.=C2=A0 Export them with EXPORT_SYMBOL_GPL() so reactor modules an=
d
> the tristate KUnit test module can register and unregister reactors
> without hitting undefined symbol errors at link time(modpost).
>=20
> Commit 3d3800b4f7f4 ("rv: Remove reactor's reference counter") noted
> that if module-based reactors are supported, try_module_get()/module_put(=
)
> should be used. Add struct module *owner to struct rv_reactor so a module
> cat set owner =3D THIS_MODULE; pin the module in monitor_swap_reactors_gi=
ngle()
> and release it when a monitor detaches or is unregistered.

You needed these symbols in KUnit and we are exporting them for /potential/
future support of reactors as modules. I don't see any technical reason why=
 we
shouldn't support this, but they are currently /not/ supported.

I know sashiko and other LLMs complain about this, and they have a point, b=
ut
you can ignore them. At most state in this commit message that this does NO=
T add
support for reactors as modules.

Let's focus this series on its original intent (fix a lockdep warning and a=
dd
some KUnit tests that expose a reproducer), then if adding support for reac=
tors
as modules is so simple, you can do it in another series.

If you really want to /also/ add support for reactors as modules in this se=
ries,
you need to make that very explicit (not just a vague line in the changelog=
, but
rather rewrite the entire cover letter and commit message).
And mind that this would mean your series needs to go through another round=
 of
review and serious testing: you are adding a new feature.

> In-tree reactors leave owner =3D NULL and are unaffected.
>=20
> Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Please, whenever you significantly change an already reviewed patch, remove=
 the
reviewed-by, so I can quickly see I need to review it again.

Thanks,
Gabriele

> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> ---
> =C2=A0include/linux/rv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +++
> =C2=A0kernel/trace/rv/rv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 5 +++++
> =C2=A0kernel/trace/rv/rv_reactors.c | 38 +++++++++++++++++++++++++++++---=
---
> =C2=A03 files changed, 40 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/linux/rv.h b/include/linux/rv.h
> index 541ba404926a..ff3289ba4f02 100644
> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -128,10 +128,13 @@ union rv_task_monitor {
> =C2=A0};
> =C2=A0
> =C2=A0#ifdef CONFIG_RV_REACTORS
> +struct module;
> +
> =C2=A0struct rv_reactor {
> =C2=A0=09const char=09=09*name;
> =C2=A0=09const char=09=09*description;
> =C2=A0=09__printf(1, 0) void=09(*react)(const char *msg, va_list args);
> +=09struct module=09=09*owner;
> =C2=A0=09struct list_head=09list;
> =C2=A0};
> =C2=A0#endif
> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index 29f155c6968b..458b17c005b3 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
> @@ -803,6 +803,11 @@ int rv_unregister_monitor(struct rv_monitor *monitor=
)
> =C2=A0=09guard(mutex)(&rv_interface_lock);
> =C2=A0
> =C2=A0=09rv_disable_monitor(monitor);
> +#ifdef CONFIG_RV_REACTORS
> +=09if (monitor->reactor)
> +=09=09module_put(monitor->reactor->owner);
> +
> +#endif
> =C2=A0=09list_del(&monitor->list);
> =C2=A0=09destroy_monitor_dir(monitor);
> =C2=A0
> diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.=
c
> index ff7d478227c3..136eb7f47c4a 100644
> --- a/kernel/trace/rv/rv_reactors.c
> +++ b/kernel/trace/rv/rv_reactors.c
> @@ -62,6 +62,7 @@
> =C2=A0 */
> =C2=A0
> =C2=A0#include <linux/lockdep.h>
> +#include <linux/module.h>
> =C2=A0#include <linux/slab.h>
> =C2=A0
> =C2=A0#include "rv.h"
> @@ -159,7 +160,7 @@ static const struct seq_operations
> monitor_reactors_seq_ops =3D {
> =C2=A0=09.show=09=3D monitor_reactor_show
> =C2=A0};
> =C2=A0
> -static void monitor_swap_reactors_single(struct rv_monitor *mon,
> +static int monitor_swap_reactors_single(struct rv_monitor *mon,
> =C2=A0=09=09=09=09=09 struct rv_reactor *reactor,
> =C2=A0=09=09=09=09=09 bool nested)
> =C2=A0{
> @@ -167,29 +168,39 @@ static void monitor_swap_reactors_single(struct
> rv_monitor *mon,
> =C2=A0
> =C2=A0=09/* nothing to do */
> =C2=A0=09if (mon->reactor =3D=3D reactor)
> -=09=09return;
> +=09=09return 0;
> +
> +=09if (reactor->owner && !try_module_get(reactor->owner))
> +=09=09return -EBUSY;
> =C2=A0
> =C2=A0=09monitor_enabled =3D mon->enabled;
> =C2=A0=09if (monitor_enabled)
> =C2=A0=09=09rv_disable_monitor(mon);
> =C2=A0
> +=09if (mon->reactor)
> +=09=09module_put(mon->reactor->owner);
> =C2=A0=09mon->reactor =3D reactor;
> =C2=A0=09mon->react =3D reactor->react;
> =C2=A0
> =C2=A0=09/* enable only once if iterating through a container */
> =C2=A0=09if (monitor_enabled && !nested)
> =C2=A0=09=09rv_enable_monitor(mon);
> +
> +=09return 0;
> =C2=A0}
> =C2=A0
> -static void monitor_swap_reactors(struct rv_monitor *mon, struct rv_reac=
tor
> *reactor)
> +static int monitor_swap_reactors(struct rv_monitor *mon, struct rv_react=
or
> *reactor)
> =C2=A0{
> =C2=A0=09struct rv_monitor *p =3D mon;
> +=09int ret;
> =C2=A0
> =C2=A0=09if (rv_is_container_monitor(mon))
> =C2=A0=09=09list_for_each_entry_continue(p, &rv_monitors_list, list) {
> =C2=A0=09=09=09if (p->parent !=3D mon)
> =C2=A0=09=09=09=09break;
> -=09=09=09monitor_swap_reactors_single(p, reactor, true);
> +=09=09=09ret =3D monitor_swap_reactors_single(p, reactor, true);
> +=09=09=09if (ret)
> +=09=09=09=09return ret;
> =C2=A0=09=09}
> =C2=A0=09/*
> =C2=A0=09 * This call enables and disables the monitor if they were activ=
e.
> @@ -197,7 +208,7 @@ static void monitor_swap_reactors(struct rv_monitor *=
mon,
> struct rv_reactor *rea
> =C2=A0=09 * All nested monitors are enabled also if they were off, we may
> refine
> =C2=A0=09 * this logic in the future.
> =C2=A0=09 */
> -=09monitor_swap_reactors_single(mon, reactor, false);
> +=09return monitor_swap_reactors_single(mon, reactor, false);
> =C2=A0}
> =C2=A0
> =C2=A0static ssize_t
> @@ -236,10 +247,14 @@ monitor_reactors_write(struct file *file, const cha=
r
> __user *user_buf,
> =C2=A0=09guard(mutex)(&rv_interface_lock);
> =C2=A0
> =C2=A0=09list_for_each_entry(reactor, &rv_reactors_list, list) {
> +=09=09int ret;
> +
> =C2=A0=09=09if (strcmp(ptr, reactor->name) !=3D 0)
> =C2=A0=09=09=09continue;
> =C2=A0
> -=09=09monitor_swap_reactors(mon, reactor);
> +=09=09ret =3D monitor_swap_reactors(mon, reactor);
> +=09=09if (ret)
> +=09=09=09return ret;
> =C2=A0
> =C2=A0=09=09return count;
> =C2=A0=09}
> @@ -314,6 +329,7 @@ int rv_register_reactor(struct rv_reactor *reactor)
> =C2=A0=09guard(mutex)(&rv_interface_lock);
> =C2=A0=09return __rv_register_reactor(reactor);
> =C2=A0}
> +EXPORT_SYMBOL_GPL(rv_register_reactor);
> =C2=A0
> =C2=A0/**
> =C2=A0 * rv_unregister_reactor - unregister a rv reactor.
> @@ -327,6 +343,7 @@ int rv_unregister_reactor(struct rv_reactor *reactor)
> =C2=A0=09list_del(&reactor->list);
> =C2=A0=09return 0;
> =C2=A0}
> +EXPORT_SYMBOL_GPL(rv_unregister_reactor);
> =C2=A0
> =C2=A0/*
> =C2=A0 * reacting_on interface.
> @@ -421,6 +438,15 @@ int reactor_populate_monitor(struct rv_monitor *mon,
> struct dentry *root)
> =C2=A0=09 * Configure as the rv_nop reactor.
> =C2=A0=09 */
> =C2=A0=09mon->reactor =3D get_reactor_rdef_by_name("nop");
> +=09if (WARN_ON(!mon->reactor)) {
> +=09=09rv_remove(tmp);
> +=09=09return -EINVAL;
> +=09}
> +
> +=09if (mon->reactor->owner && !try_module_get(mon->reactor->owner)) {
> +=09=09rv_remove(tmp);
> +=09=09return -EBUSY;
> +=09}
> =C2=A0
> =C2=A0=09return 0;
> =C2=A0}


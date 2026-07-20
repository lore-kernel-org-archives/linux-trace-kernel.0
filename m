Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1812C234E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Jul 2026 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560986; cv=none; b=QhtUKh73+bhYSUZb4gOH5nmQRll3Xax1axWM06arhLzaikp1iDZuLkaVcI6r6q7WXG7a4yV9Dcg3v9PRJgdAA0F/3DmdjOpya+nj006RbGj5DLJvxRQXls4Xe/l8ICPyo4XxCMGtf/+tSkz9+WjAHxqbG3vvib2LjeXgy1HRK5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560986; c=relaxed/simple;
	bh=FyPuOgVaCRL/sKGvzzggWmv2H0077pdYKSKb8ufByZU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZKReuxwbeRuVb7ycacW77RosqHpoF9hhhnDora24NxjPLi9dNAs6wtDzR27ZyfKTgoRdlUOLm5zOPTg8ChAvR3DYgKf0wZcEhrRXRGrbyFCLBvInopqaj/hVI3JDLW0enILEHMUOuqrZrVv0/mWHiWtajDobsC1m/imO/UERBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WVoOC0Gn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WVoOC0Gn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784560984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FyPuOgVaCRL/sKGvzzggWmv2H0077pdYKSKb8ufByZU=;
	b=WVoOC0Gn3BbJ4DcYKlsZae+D8Eu03fA25PxbSur/iOtJPgEcnjeQij0bvbDMkosLSsPt0O
	JTLbbPJkB+NQkO6LWQo+JJKiBvmX/SeyGgKxqZYj7/mUT2WdFtEhRXf8radVbD4h9TvPuC
	Wjp+6lEmPnz+pvE/JnB4JqTrYpuekr4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-6qVdcMDPPSyvPo2WUaeNOA-1; Mon, 20 Jul 2026 11:23:02 -0400
X-MC-Unique: 6qVdcMDPPSyvPo2WUaeNOA-1
X-Mimecast-MFC-AGG-ID: 6qVdcMDPPSyvPo2WUaeNOA_1784560981
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c16740eb587so515174166b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Jul 2026 08:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784560981; x=1785165781;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qRG0EQoIBPvYKanAjjzqNY2Gr16T4oqswbVpTvZJXsA=;
        b=dHWB6zbtpLJXCiNpbU+Oh5MFtv0HWIlfsbx9KsqiC+lOKtc/Ws1wXdHEDl0Q3ZTrkd
         enqUpIV1EOZzt0YDMFsSIVZaYETulXFAghZ9SRMW1CBgUyYqCMvL+IoFuF0U8hFdnMfx
         gTDkuYKuUns46vaamOI/kZv/L34Tb4kNl9vufGcxSa2vt6iGZEnTrN4eOyxhTH1r5AeF
         yFAe8rylxPFzGYxLP55V35CZXC9/WDjbyWkrdCV5FyILylSKbSrdCqwuz6YSCQFWzcBB
         EKug3+bwP8/Eo+9BfVjA45GYsyYOwVZSWLNVGLxKVIjrHy1oRs0K6SL3+cVTn/Iint8M
         hNlw==
X-Forwarded-Encrypted: i=1; AHgh+RrDW5RQZ0ZBKWpcPuZmIay52ERTG0R3MTBffKFAOcxkovaAP3PKg3f0lgwhNr4IgszvYyA2ModR0BLLu3Mp4NoZcBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwagV9bYTT+u+VtC7DPzxBexXJNYbGUWsgBVU2uJJWeWD+WzYtY
	JqSbWLcxvF5fUdgWj/pQz/4OBBvFPN79b7ZoAyGpFFtTGr9wP04GFxJYjTO31fRZN+se3eZ4sr3
	DlbOFRKKDLOjzRcTiPDvT6cA7nTWtQg+g8ouvUBjKBvDBgvJx+5A9T3SnOtGAhMqipS8WZKnZfQ
	==
X-Gm-Gg: AfdE7ckxxZkI1baiIFYBb4HqoQtV12/sfXeeFaIVBOTNTBiYrlCaCu/rV89hgsrN+r9
	ws4uBObRAHDMRz4Le9cNEk2mJgRKbUzupKs6q1JCikKh3YYrr9Y3869jrtqf/pHMKcQSZ9F48xG
	pgqhwBNJVs1Pk7RPI+qDgHa+RtmN/Fn6hqOCozBoLdRMrRvNp1t0by7CihLurMSMf3kC/ONrwi8
	MZ0S5E9zWqGYQnYZLEPbtAafgNox2eAk74MbjjgeGPFRpVGiIaAfXiUHvo59BgS7Zp66zVp9XC3
	/35RtOmRh/B10tSpz5VoDrl2K+k8oDGrqvlp0qVVp90EI8N+YjYUObu22l8zgsHqTM24WX4B9Jy
	bNHxwGuzK8N8p5KUoewcP5M5oyhLyYZRn3hZHavtbaWQNiQjsKaDJ7+mvrz4C8CJ+GXfjGw==
X-Received: by 2002:a17:907:961c:b0:c16:5855:6594 with SMTP id a640c23a62f3a-c16b485db23mr721732366b.55.1784560981393;
        Mon, 20 Jul 2026 08:23:01 -0700 (PDT)
X-Received: by 2002:a17:907:961c:b0:c16:5855:6594 with SMTP id a640c23a62f3a-c16b485db23mr721730466b.55.1784560981001;
        Mon, 20 Jul 2026 08:23:01 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1734c0d439sm484787466b.51.2026.07.20.08.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 08:23:00 -0700 (PDT)
Message-ID: <55912ee1fc569e5c81e25a32d516db54d1986336.camel@redhat.com>
Subject: Re: [PATCH v4 2/8] rv: add generic uprobe infrastructure for RV
 monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 20 Jul 2026 17:22:59 +0200
In-Reply-To: <31d0438f98e80503370a6fb3932d0ec7df0673c3.1783524627.git.wen.yang@linux.dev>
References: <cover.1783524627.git.wen.yang@linux.dev>
	 <31d0438f98e80503370a6fb3932d0ec7df0673c3.1783524627.git.wen.yang@linux.dev>
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
X-Mimecast-MFC-PROC-ID: MQQ76GsR1eb-uUU-zcyTynU9qNVoNY4Z4tsvjqtsFIQ_1784560981
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-08 at 23:38 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>
> +++ b/kernel/trace/rv/Kconfig
> @@ -59,6 +59,13 @@ config RV_PER_TASK_MONITORS
> =C2=A0=09=C2=A0 This option configures the maximum number of per-task RV =
monitors
> that can run
> =C2=A0=09=C2=A0 simultaneously.
> =C2=A0
> +config RV_UPROBE
> +=09bool
> +=09depends on RV && UPROBES
> +=09help
> +=09=C2=A0 Generic uprobe infrastructure for RV monitors.=C2=A0 Provides =
path
> +=09=C2=A0 resolution, registration, and safe synchronous teardown.

This isn't exposed, it's selected automatically when required, I don't
even think the help text is visible (menuconfig doesn't show it), do we
really need it?

> +
> =C2=A0source "kernel/trace/rv/monitors/wip/Kconfig"
> =C2=A0source "kernel/trace/rv/monitors/wwnr/Kconfig"
> =C2=A0

...

> +++ b/kernel/trace/rv/rv_uprobe.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Generic uprobe infrastructure for RV monitors.
> + *
> + * struct rv_uprobe embeds struct uprobe_consumer directly.=C2=A0 This i=
s safe
> + * because rv_uprobe_sync() calls uprobe_unregister_sync(), which calls
> + * synchronize_rcu_tasks_trace().=C2=A0 handler_chain() runs under
> + * rcu_read_lock_trace(), so after synchronize_rcu_tasks_trace() returns=
,
> + * all in-flight handler_chain() iterations, including any pending
> + * uc->cons_node.next reads, have completed on all CPUs.=C2=A0 The calle=
r may
> + * then free the struct containing rv_uprobe immediately.
> + */
> +#include <linux/dcache.h>
> +#include <linux/fs.h>
> +#include <linux/namei.h>
> +#include <linux/uprobes.h>
> +#include <rv/rv_uprobe.h>
> +
> +/**
> + * rv_uprobe_register - initialise and register an uprobe
> + */
> +int rv_uprobe_register(const char *binpath, loff_t offset, struct rv_upr=
obe
> *p)
> +{
> +=09struct inode *inode;
> +=09struct path path;
> +=09int ret;
> +
> +=09if (!p->uc.handler && !p->uc.ret_handler)
> +=09=09return -EINVAL;

uprobe_register() does this already, do we need it here too?

> +
> +=09ret =3D kern_path(binpath, LOOKUP_FOLLOW, &path);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09if (!d_is_reg(path.dentry)) {
> +=09=09path_put(&path);
> +=09=09return -EINVAL;
> +=09}
> +
> +=09inode =3D d_real_inode(path.dentry);
> +=09p->inode =3D inode;
> +
> +=09/*
> +=09 * uprobe_register() requires the inode (and mount) to remain
> +=09 * referenced across the call.=C2=A0 Keep the path alive until after
> +=09 * uprobe_register() has stored its own reference, then release it.
> +=09 */
> +=09p->uprobe =3D uprobe_register(inode, offset, 0, &p->uc);
> +=09path_put(&path);

I believe I was mistaken here, as sashiko pointed out, uprobe_register()
doesn't keep a reference to the inode, (explicitly stated in it's docs:
"Caller of uprobe_register() is required to keep @inode (and the
containing mount) referenced.").

We should probably revert back to holding path instead of inode and
putting it after synchronous cleanup. That's also what BPF does.

Thanks,
Gabriele

> +=09if (IS_ERR(p->uprobe)) {
> +=09=09ret =3D PTR_ERR(p->uprobe);
> +=09=09p->uprobe =3D NULL;
> +=09=09p->inode =3D NULL;
> +=09=09return ret;
> +=09}
> +
> +=09return 0;
> +}
> +EXPORT_SYMBOL_GPL(rv_uprobe_register);
> +
> +/**
> + * rv_uprobe_is_registered - test whether an uprobe is currently active
> + */
> +bool rv_uprobe_is_registered(const struct rv_uprobe *p)
> +{
> +=09return p && p->uprobe;
> +}
> +EXPORT_SYMBOL_GPL(rv_uprobe_is_registered);
> +
> +/**
> + * rv_uprobe_unregister - synchronously unregister a uprobe
> + */
> +void rv_uprobe_unregister(struct rv_uprobe *p)
> +{
> +=09if (!p || !p->uprobe)
> +=09=09return;
> +
> +=09rv_uprobe_unregister_nosync(p);
> +=09rv_uprobe_sync();
> +}
> +EXPORT_SYMBOL_GPL(rv_uprobe_unregister);
> +
> +/**
> + * rv_uprobe_unregister_nosync - dequeue an uprobe without waiting
> + */
> +void rv_uprobe_unregister_nosync(struct rv_uprobe *p)
> +{
> +=09if (!p || !p->uprobe)
> +=09=09return;
> +
> +=09uprobe_unregister_nosync(p->uprobe, &p->uc);
> +=09p->uprobe =3D NULL;
> +=09p->inode =3D NULL;
> +}
> +EXPORT_SYMBOL_GPL(rv_uprobe_unregister_nosync);
> +
> +/**
> + * rv_uprobe_sync - wait for all in-flight uprobe handlers to complete
> + */
> +void rv_uprobe_sync(void)
> +{
> +=09uprobe_unregister_sync();
> +}
> +EXPORT_SYMBOL_GPL(rv_uprobe_sync);


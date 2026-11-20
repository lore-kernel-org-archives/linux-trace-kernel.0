Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176768;
	b=iwY4bUn1UYa4oUThIiAoRb4i+eQmPhGWfEQGyZ8v7HWGP150saZQxm8Q0AF/+C4sO8vL
	 idL3jmgLsIMUX3usLFxzecYVgvt0o2FfKc/7F7xU/O7Cl18KCCgtR3goIuzJRlzLgSODC
	 H98kVi8bDKzVy5fq/gFUa9xh/Zh1gDfu8Hsc1mDGOazahGxNgcIF21Nf512aZ31CmRn3s
	 sT5uIWuu2US10Uqte3SnHB9iq82CRz+B52/7rOgzu2Oz361IzPht00hl8uUWFnyys9o0h
	 eE9Ik7hQ04L+7aN1mcq1X8sa7SBRPpVOW2gP6gD1tlmeTEhgNt1YzEDJp6QgpCaI5ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176768;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Autocrypt:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=Fm0n4WElJ0e9msCLidXhb9kiBDeF1hAX/ZUDT+BPJeQ=;
	b=TdpFmm7IyZqFiwddDhg0uLA9c4TdGWaleX62CuPcja26A8EEXv8NVZN6zmX5W5qzOU49
	 Fll+HyC6Qy1OrIg1SrahQFNFk24VC22yn9d9LTBfTsn+Ffezn1lJdYclSj0LSc4XocgZu
	 edv/Ve+YRy/VEBVZT18No5bpyeSIltJ2BGBESMpX/E7jCSM706NCvmrVVcmpRG++Rb/W2
	 JuS/zY8WbaQqX/QW5XK1jwIHgSXo0KqdaDRV45RiTBtKluUEKzW+v8QoD204jLd2zV6DF
	 BQcTwmmLd+SNXtzAJnfpljT6sthP120UzM44qxTkcM9GxB/pF+3okoze/BjotgKP/VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eUpbCPdI;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75343606A335
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Nov 2026 12:12:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75343606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eUpbCPdI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795176765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Fm0n4WElJ0e9msCLidXhb9kiBDeF1hAX/ZUDT+BPJeQ=;
	b=eUpbCPdIsgzjJ4SgjSQeoOs/pkvo9XmJ66R5YFDFz4YCV65Rn3flMAzt7p3AdLVh7yGYeA
	tQEjM86xlF3qrRS7j5UgPVUeX5CiGORhwIUzxEuHAEfE48uwABYXgeKLe3U1tEjpEkOwB0
	7faKq+AOLrGB7i3d35vUyyAFNiYhjO8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-SDJ3S5PXMtODSJ5aPV0b9g-1; Fri, 20 Nov 2026 12:12:43 +0000
X-MC-Unique: SDJ3S5PXMtODSJ5aPV0b9g-1
X-Mimecast-MFC-AGG-ID: SDJ3S5PXMtODSJ5aPV0b9g_1795176762
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e4d1e29f3so719308f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Nov 2026 04:12:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795176762; x=1795781562;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Fm0n4WElJ0e9msCLidXhb9kiBDeF1hAX/ZUDT+BPJeQ=;
        b=0xkvTW9R/MgRd1EJMciuJoi9PGMyiwrlPQu+oj/HVZK5z8EfLqXxtxsPqwINd1eWBY
         +vFR/rRD7q5oXMHWz5rEWa5ImhT+J7UILAOCNarFgKdLZihlECEwitueLElJ/KYz1kOf
         F5Id28ZLqvFx/FOWiY/k8ZiSXFeOqzALD7Z04flRFSGyhPZ2nOPkJngeDaYb7+fH1ozo
         CFuxlMV7FEfKW4ICZWLgeL9ckppMCMbbm1g6042T3uKNbII211f0kLV2szaZ0T/RucwK
         aPszyVBN7Uqw+8D6sOfi/5U4UTDFbefIgDoEKsukF4zh3y7j6saSwRLUsWSFk175/vCW
         V3FA==
X-Forwarded-Encrypted: i=1; AL+hErFOdDhyPblxp9ordWOKw0qDFDvaGNauI733qe78xaNzriCmnswJjbMPfmb60wT7E0vF7dOwZuAtIWhTBXQaazGRg/k=@vger.kernel.org
X-Gm-Message-State: APuU4Z83UsUVUQXJssdlE1m+H65sIKH4iJXvfi3irnB7DoZyO2Eg+u77
	zoeZScggfL9XK88Yo5HmbR+0jX4dwLtykc7IW3Z2wY6CL/dobu02b8Kxdkxk+D03nESUv/7ccXn
	0mnq9RzBsqe0SSgAWlDzgLwuBdZnC2ZjH246bj1DHvDWbkSAHwA5SElL3p1SE45ArtBVT9M7zoz
	Xw6cLcwZgxLLY=
X-Gm-Gg: AYBFou1B8EMyc1eplA0Dm1zRtQdJTQFu3FTqzoUAaFbQhQybTonrMetidVnAsOSZbzQ
	AxxbnQcoSoktkFWQ2sr6Wb/gYnVBc1Fh8pP2qwH053UeQovcXsHe3eT/r8u4qInNk41QiBspDix
	4gLXbReh2ZAgWxFBlHhqoztJ0P32fTVFqK//zD7a+kAJSUbIBT7pZea15RBBPhhI+tth20I0bpx
	1pZtiXbPRlggrVtdz3+3SLk7SkjWRvEjgp9CTx3KqWJOOpnY+dO2rUzFxATzhov0pGxxOHO5GeZ
	E6TwgxrF3kGOfHmFJoGdRNZfJl/x0D9gb7xjVOgxaBDUmhApTBpd+5K1Uk+aSJ0Jy1yUounNdiI
	6PZxqe44FbkskgH5M+lOsMR1fmKmm4B6SU7/TAK4Fn9OY2KQW8S5lcR1eCKaLkbJgjylfGUhhKd
	Zq
X-Received: by 2002:a05:600c:4f84:b0:4bb:8701:a2df with SMTP id 5b1f17b1804b1-4bb88809950mr64759775e9.17.1795176762186;
        Fri, 20 Nov 2026 04:12:42 -0800 (PST)
X-Received: by 2002:a05:600c:4f84:b0:4bb:8701:a2df with SMTP id 5b1f17b1804b1-4bb88809950mr64759385e9.17.1795176761785;
        Fri, 20 Nov 2026 04:12:41 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab65cb41f4sm5183887f8f.7.2026.11.20.04.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 04:12:41 -0800 (PST)
Message-ID: <9709becb82665468bef304ece738c17280550337.camel@redhat.com>
Subject: Re: [PATCH v8 09/14] rv: Add generic uprobe infrastructure for RV
 monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 20 Nov 2026 13:12:40 +0100
In-Reply-To: <21469501d58c0b7efc662226f4c9e9a9d7d32847.1793900349.git.wen.yang@linux.dev>
References: <cover.1793900349.git.wen.yang@linux.dev>
	 <21469501d58c0b7efc662226f4c9e9a9d7d32847.1793900349.git.wen.yang@linux.dev>
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
X-Mimecast-MFC-PROC-ID: Q-ThwW38HbuKnYqP-HJj7N3cc1ZdecLGZsv-CGQQtx0_1795176762
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-11-06 at 01:49 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> Monitors that instrument user-space function boundaries need to register
> uprobes and deregister them safely.=C2=A0 Provide a thin wrapper so monit=
ors
> share a single implementation of this boilerplate.
>=20
> struct rv_uprobe embeds struct uprobe_consumer directly, avoiding a
> separate heap allocation per probe.=C2=A0 The struct holds an inode refer=
ence
> (acquired via igrab()) for the probed binary for the full uprobe lifetime=
,
> as uprobe_register() does not take an inode reference.=C2=A0 On unregiste=
r,
> the inode reference is released with iput() only after
> rv_uprobe_unregister_sync().
>=20
> rv_uprobe_unregister_sync() calls uprobe_unregister_sync(), draining
> all in-flight handlers before the containing struct may be freed.
>=20
> The API provides register, nosync unregister, a global handler barrier
> (rv_uprobe_unregister_sync), and an active-state predicate.
>=20
> Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> ---

This API requires a lot of manual steps from the callers. We can refine
it later on but at least I'd simplify the teardown.

I remember we discussed this already. The uprobe registration requires
both inode and mount to stay alive, path_get() does both, so I don't
think we really need also the igrab()/iput().

Do users really need to carry the inode around together with the path?
Other APIs (e.g. bpf_trace.c and trace_uprobe.c) pass only the path and
get the inode internally, I don't see why we cannot do that and mandate
the path is owned by the caller (which is already the case).

All the other logic might be fine in the callers, but at least let's aim
to simplify what is general enough.

Thanks,
Gabriele

> =C2=A0include/rv/rv_uprobe.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 35 +++++++++=
++++++++++++++
> =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +++
> =C2=A0kernel/trace/rv/Makefile=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0kernel/trace/rv/rv_uprobe.c | 56 ++++++++++++++++++++++++++++++++++=
+++
> =C2=A04 files changed, 96 insertions(+)
> =C2=A0create mode 100644 include/rv/rv_uprobe.h
> =C2=A0create mode 100644 kernel/trace/rv/rv_uprobe.c
>=20
> diff --git a/include/rv/rv_uprobe.h b/include/rv/rv_uprobe.h
> new file mode 100644
> index 000000000000..b93c2a81bc22
> --- /dev/null
> +++ b/include/rv/rv_uprobe.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2026 Wen Yang <wen.yang@linux.dev> */
> +/*
> + * Generic uprobe infrastructure for RV monitors.
> + */
> +
> +#ifndef _RV_UPROBE_H
> +#define _RV_UPROBE_H
> +
> +#include <linux/types.h>
> +#include <linux/uprobes.h>
> +
> +struct inode;
> +struct pt_regs;
> +
> +/*
> + * Free the containing struct only after rv_uprobe_unregister_nosync() +
> + * rv_uprobe_unregister_sync() + iput(p->inode).
> + *
> + * The inode reference does not pin the dentry, so callers that re-resol=
ve
> the
> + * probed path must hold a struct path: 9p cache=3Dnone remints an inode=
 per
> + * lookup.
> + */
> +struct rv_uprobe {
> +=09struct uprobe_consumer=09uc;
> +=09struct uprobe=09=09*uprobe;
> +=09struct inode=09=09*inode;
> +};
> +
> +bool rv_uprobe_is_registered(const struct rv_uprobe *p);
> +int rv_uprobe_register(struct inode *inode, loff_t offset, struct rv_upr=
obe
> *p);
> +void rv_uprobe_unregister_nosync(struct rv_uprobe *p);
> +void rv_uprobe_unregister_sync(void);
> +
> +#endif /* _RV_UPROBE_H */
> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index efa930f94ea4..2bc412304293 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -86,6 +86,10 @@ source "kernel/trace/rv/monitors/nomiss/Kconfig"
> =C2=A0
> =C2=A0# Add new monitors here
> =C2=A0
> +config RV_UPROBE
> +=09bool
> +=09depends on RV && UPROBES
> +
> =C2=A0config RV_REACTORS
> =C2=A0=09bool "Runtime verification reactors"
> =C2=A0=09default y
> diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
> index 4b84b83b942b..8dc14a1819b8 100644
> --- a/kernel/trace/rv/Makefile
> +++ b/kernel/trace/rv/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_RV_MON_DEADLINE) +=3D
> monitors/deadline/deadline.o
> =C2=A0obj-$(CONFIG_RV_MON_NOMISS) +=3D monitors/nomiss/nomiss.o
> =C2=A0obj-$(CONFIG_RV_MON_WAKEUP) +=3D monitors/wakeup/wakeup.o
> =C2=A0# Add new monitors here
> +obj-$(CONFIG_RV_UPROBE) +=3D rv_uprobe.o
> =C2=A0obj-$(CONFIG_RV_REACTORS) +=3D rv_reactors.o
> =C2=A0obj-$(CONFIG_RV_REACT_PRINTK) +=3D reactor_printk.o
> =C2=A0obj-$(CONFIG_RV_REACT_PANIC) +=3D reactor_panic.o
> diff --git a/kernel/trace/rv/rv_uprobe.c b/kernel/trace/rv/rv_uprobe.c
> new file mode 100644
> index 000000000000..1c7f8466aeed
> --- /dev/null
> +++ b/kernel/trace/rv/rv_uprobe.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Generic uprobe infrastructure for RV monitors.
> + */
> +#include <linux/fs.h>
> +#include <linux/uprobes.h>
> +#include <rv/rv_uprobe.h>
> +
> +/*
> + * uprobe_register() takes no inode reference of its own, so grab one he=
re
> and
> + * drop it only after rv_uprobe_unregister_sync().
> + */
> +int rv_uprobe_register(struct inode *inode, loff_t offset, struct rv_upr=
obe
> *p)
> +{
> +=09int ret;
> +
> +=09p->inode =3D igrab(inode);
> +=09if (!p->inode)
> +=09=09return -ESTALE;
> +
> +=09p->uprobe =3D uprobe_register(inode, offset, 0, &p->uc);
> +=09if (IS_ERR(p->uprobe)) {
> +=09=09ret =3D PTR_ERR(p->uprobe);
> +=09=09p->uprobe =3D NULL;
> +=09=09iput(p->inode);
> +=09=09p->inode =3D NULL;
> +=09=09return ret;
> +=09}
> +
> +=09return 0;
> +}
> +EXPORT_SYMBOL_GPL(rv_uprobe_register);
> +
> +bool rv_uprobe_is_registered(const struct rv_uprobe *p)
> +{
> +=09return p && p->uprobe;
> +}
> +EXPORT_SYMBOL_GPL(rv_uprobe_is_registered);
> +
> +/* The inode stays held: in-flight handlers may still reach it. */
> +void rv_uprobe_unregister_nosync(struct rv_uprobe *p)
> +{
> +=09if (!p || !p->uprobe)
> +=09=09return;
> +
> +=09uprobe_unregister_nosync(p->uprobe, &p->uc);
> +=09p->uprobe =3D NULL;
> +}
> +EXPORT_SYMBOL_GPL(rv_uprobe_unregister_nosync);
> +
> +/* Global barrier over every probe dequeued so far. */
> +void rv_uprobe_unregister_sync(void)
> +{
> +=09uprobe_unregister_sync();
> +}
> +EXPORT_SYMBOL_GPL(rv_uprobe_unregister_sync);


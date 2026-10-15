Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448C452BE3E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792094418; cv=none; b=aF5RgmM67xDEQieURAnowOBgXz7+lWKXOrOUghQ9a+wDXCE3APETxynf/jgGGRW+nI0XDn8K+df06HAHp0V/z0VocD/LrcmRVQ4/klPvIjfHJyJM/uPZlAEM7X1EPTvzb26u0ePHkAxuBcq2kiHu+6eAlyQj5QYuLdhPHcUGKdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792094418; c=relaxed/simple;
	bh=ZdV5BaJIv/kE8+aeDqKQTezDSi8KwwtxS2Acj5Oy3oY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDhg6KjuV0GPnboLc738YgaxrdwxTGcrGmVOXg649AIcvbqU5wN8QZuHRR6R8NT1z9NPUzlCH6As4k8H3bWemkb7NJOTnLzEfu0z8jF7wnUmQLxOXbrevin0sx50HxLlJ68kG1tBwaj4nNYPp55vvS5KNdS4EtLLPFon1wBWXos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eskUSyVx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eskUSyVx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792094413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mJGzDfyie7g0wS80PP/jhU5GIsqjteLyTWE7rXt+IdM=;
	b=eskUSyVx/r9BN4n6VBOV5j0Y13uEQjcPALTL5FLtgsm6ojcqLAfpErvaAREIYdMhUBwstI
	3mexhucMYHU/mwzIBGSsT91lg3UwPJsp/jolOD1m5H81StFc2Lr3kIfZen/BcgysgNzGTL
	eQjiW/GpjMXlVidWpTSi0faQLvrU+c8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-_x05be_KMK6S_fFSCETYxw-1; Thu, 15 Oct 2026 20:00:09 +0000
X-MC-Unique: _x05be_KMK6S_fFSCETYxw-1
X-Mimecast-MFC-AGG-ID: _x05be_KMK6S_fFSCETYxw_1792094409
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91b529a8610so38701836d6.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 13:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792094409; x=1792699209;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ARFS9DZSP4dQZPdHoed8w0xeryUKGtwmSApYre2IIFw=;
        b=LkgDQWULpI49ElG0VkOM0viXAbRhK2prVgO3cp7EWk/CJvAYSvSQLyvNVnbk07mvbB
         oTtTFTLXMxCx5GWipTXT4X9Y+AhLgEB8DnsujtPs2pQdlxwEbWJiHFyQESwYtrlVfK03
         fSutq3vWSofTll3JkSjSa/kHpeZEk5c+0GcxA8lD/3cJ+Qy9NFjmox+/tpZm2+w2rnDn
         RUwvayaRjHXUiLY51swUXASDGGpYEaJXIcpvzUUVBlXm1gkLUQl5Q9p1oZfIFPJ2NbXl
         lMXVujQlXE8SkV6sehgN/E6XeL/FF2aMk/FO5PTeUZbPzT9hLPB7/1pIzcIff36VLQSi
         bnjA==
X-Gm-Message-State: AFq9FYLzaRIvNkSQeTanWhBDVC61SjP28RiXRN+bWYXJRz+Rgrz00CpN
	2m2trg5wWV/ptJrvsyatO3cO6USdIIVIULaX1KpEmG6d9lxTeOQDTIdtvIxRSSiEpEtJPj2xd4s
	mVibnQ1zQc/WXYsvgcXTG7f8Gx4saLOTU5X5xvhaI9wlPqOJn44cxegI9eUMFrZw2s3M28Z/1jg
	==
X-Gm-Gg: AYBFou1WiA3ZRUkvFpZxulvgb+bDJnrebPznY4Nj25jZZgSca6zjwqFyIUtRP6DvvDP
	NNdguxSl+C1DoizacSYskOAr6qs5x9kVJwFOIbiarK2l96wzSSOFuLfEAgAK6gC9R6DlKLszvVm
	4FTzYZjAdkLKaJxwWbz4gPYlVg2jwbDavf2J4ia/ev78A9qWLDS95iGqDJ4ue6CrDo86BQEadN7
	B1L6KF6rSS8aI8xIFiAazirprTnROuDndDhRwX3p1UiPAs9ym7W8s6rV7XPVzetSscReZjGk1bR
	1zWN86AZAaDvIJiHCAIR09rykgFEyIbh+LfUnUvZgfC1yHfzKLEcCY4x6IzyG4yWHYoSYBnPHEc
	zQx4pcUADE3Rf31R5CptcGaicSObq0AP3bPXyyBx9noCnZ/nI6G8xMtY=
X-Received: by 2002:a05:6214:518a:b0:911:9373:a171 with SMTP id 6a1803df08f44-91b5556ad41mr329656106d6.30.1792094408514;
        Thu, 15 Oct 2026 13:00:08 -0700 (PDT)
X-Received: by 2002:a05:6214:518a:b0:911:9373:a171 with SMTP id 6a1803df08f44-91b5556ad41mr329654976d6.30.1792094407643;
        Thu, 15 Oct 2026 13:00:07 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (71-34-25-140.mpls.qwest.net. [71.34.25.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcb8c4adasm4342446d6.1.2026.10.15.13.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:00:07 -0700 (PDT)
Message-ID: <8ae7b1fc1ca394e1342688073359f97fc275f4b6.camel@redhat.com>
Subject: Re: [PATCH v4 7/9] tracing/osnoise: Split out per-cpu variable
 resets
From: Crystal Wood <crwood@redhat.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Date: Thu, 15 Oct 2026 15:00:06 -0500
In-Reply-To: <sashiko-outbox-171968@kernel.org>
References: <20261014220759.908839-1-crwood@redhat.com>
	 <20261014220759.908839-8-crwood@redhat.com>
	 <sashiko-outbox-171968@kernel.org>
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: __UlScuSPFgyM8Uq93C60Fm3tayCCCnADDqJY0B1hv4_1792094409
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-10-14 at 22:21 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] tracing: Data race between osn_reset_cpu memset and NMI handler
> --
>=20
> commit 01cd6ef0e171fa1526bc0f401fc2072fe284c438
> Author: Crystal Wood <crwood@redhat.com>
>=20
> tracing/osnoise: Split out per-cpu variable resets
>=20
> This commit splits out per-cpu variable resets by resetting the per-cpu
> state every time a kthread is stopped or an fd is detached. It uses a bul=
k
> memset to clear the zero struct_group in osn_reset_cpu() to avoid zeroing
> individual fields explicitly.
>=20
> > diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.=
c
> > --- a/kernel/trace/trace_osnoise.c
> > +++ b/kernel/trace/trace_osnoise.c
>=20
> [ ... ]
>=20
> > @@ -409,6 +379,36 @@ static struct osnoise_data {
> >  #endif
> >  };
> > =20
> > +static inline void osn_reset_cpu(int cpu)
> > +{
> > +=09struct osnoise_variables *osn =3D cpu_osn_var(cpu);
> > +
> > +=09WARN_ON(osn->kthread);
> > +=09WARN_ON(osn->fdd);
> > +=09memset(&osn->zero, 0, sizeof(osn->zero));
>=20
> [Severity: High]
> Does this non-atomic memset race with the NMI handler
> trace_osnoise_callback()?
>=20
> If osn_reset_cpu() is invoked from a remote CPU while the osnoise tracer =
is
> still globally active (for example, via timerlat_fd_release() or
> stop_kthread()), it will concurrently overwrite osn->zero on the target C=
PU.
>=20
> The target CPU's NMI handler could be running concurrently and might bypa=
ss
> the sampling check if it reads it before or during the zeroing. This woul=
d
> lead to it executing operations like:
>=20
> kernel/trace/trace_osnoise.c:trace_osnoise_callback() {
>     ...
>             local_inc(&osn_var->int_counter);
>     ...
> }
>=20
> A concurrent memset from another CPU destroys the target CPU's local_t
> guarantees and atomic operations, corrupting per-CPU state via torn reads
> and writes. This replaces what was previously a safe single-byte
> osn_var->sampling =3D false assignment with a bulk memset over the entire
> state.

Ugh... so on one hand I wouldn't call this "high priority" given the way
the data is generally read as deltas.  Most of it doesn't really need to
be reset.  It's not limited to NMIs though, as we don't disable
interrupts or even preemption here.

On the other hand, now that sampling is unconditionally cleared in
stop_kthread() as of patch 3, we might be able to just drop this
patch... but not without a respin unfortunately.  There was apparently a
patch shuffling accident in patch 3 where tlat->timer is used after
memset() clears it, which this patch undoes.  I'm surprised Sashiko
didn't mention that... v5 coming.

-Crystal


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DA83D3D07
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Mar 2026 12:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773835213; cv=none; b=gzyn/sJY3FZmXsKIfa1OZQhWNxPfePkatpT2zK+Tp8ECE8wBjCYYQ556mddIQ9xA6/RTyLj06+fQeulQGce66Ox6nZpt6vD5WpdRhAdCdhq9WLHPh1hRFbKvzID0YYcY3pgOTVwlu4ZBxj2XZlbXGMzGQorM/K+EVqi/dsHDMug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773835213; c=relaxed/simple;
	bh=WyJGc4dIi98GsoDa5E25SxUyfp0zZ8Lzy+ymZSbaGOs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mOFq5AeQ5oGwzdbayGzi4bTx7r3mV0vzI8sqOBMJuAveatuO9ZGuDvZfG2v2ykzvFh0iHJu360hXFNWhsyyv4YmId6CnC6eUXcYhQpioZoYX58nPYVcdsAVfXzC3B1H5X9gPS4FkE2tGkQAwpBoAY0C5T0oWuJe1IvUNfeihESA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D2BXO8Pb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2BXO8Pb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773835210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Ye67f8JmjH+dlyAmmcTQ+ip/lHWFAuvwAGF9tnLwIs=;
	b=D2BXO8Pb3QrwzuoKwkE1mEN2RDVCV7DLHn2FjoZjJxJViVhDIoIGn24ab1Cza4fo8jZvYX
	h8GVv3ClD/gSHpdrJlCNvqPFQrDMv6pjT2toRw58nN2j+BOreoY/9MVKUDu4MEpQGe1Q6f
	U9yeeV5nUEstDIx5V7Vuol5rsH3ysKs=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-BCp67Hd7Ns6tdoIgS181jg-1; Wed, 18 Mar 2026 08:00:09 -0400
X-MC-Unique: BCp67Hd7Ns6tdoIgS181jg-1
X-Mimecast-MFC-AGG-ID: BCp67Hd7Ns6tdoIgS181jg_1773835208
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-389e0db12cbso30119591fa.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Mar 2026 05:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773835208; x=1774440008;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGC0p783LbZSoU5uLQBLRHunnE5uv+G361DRYkF9MWc=;
        b=sAVmaqwoSAuRYcfBr20Y/eZNMGBAYvQAZQLe13bzKake4iAh0RW/hDphUjNescCrh7
         dRFJ7yrec62NbfXsUHOMLj+4A0mUZf+jD7vxWuKMm+s80oL8hFxLVXYizMnpD0Q+ncU1
         Azs/v+Qclk0X3bBGDf8mH1u7g9tpg/2Ded1lhN50MJJlWY9fqRcLCXJXzepw9fqADP6G
         FfLQYh+dhz3QyrJZI57lAgxk7uqAjR0K/a39Pbx9ahB/M4J1BcTWbUH9W7/REiVzrZfp
         tB+COurI06ihztOXW0Tv7fV5+oZ84SQ/WIiZBrgGOI/HgIjdnYImKQ6/OJFDh3c0zYb2
         oy2A==
X-Forwarded-Encrypted: i=1; AJvYcCU1YGVe2AM/egL+Sj0ckpjl+rxrc6DB8ZCS1mGpuYIvXYJ7pEGLYcd0jF5XputqJkX2Gcp4pyNSLkbnRfkZ4hRvloc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIPbG7dC+Yns+mIMzxXFEuBir52lpzgAb1+SDGFMnVX4adUPm5
	1piHNeUK1AwgGuViauYubROU+74VzAMmSUbnOfsxSaaYunuupVt6ShU16y+ikC3Cpp+v81D8f0x
	JqVWl97EwzKH1yLk4JGCnXiE3/NxB3U0LRg1SAL/F2RCuEggvTj0k3wSK+va6AG/MpqrokKqpNw
	==
X-Gm-Gg: ATEYQzzkLos2g04g7e5Cm+8VJ9KdiCVPaTncgKf/0VoNDHlgOuaoqy0roWSEeP2IGue
	JaTVYiRsllqLAbzMZ7kBF9LPVf3m9yqZ/DIdOmdDnwsV/ShNOsyf0skeV/jjrkiPMP08ipNzHFZ
	8esKnU3w0NvmrWVAeHEc4lFkxzLAZUP+UyrFtCafKcgULc1gXTpJLs8KrZT98OKOih65M4xksg7
	rLmXDCejMKypMx9pi3A88V1fP3f1KJug0nvoEeOReQTlih3tC04gjp/2ksChZ8OEDc6bPqB/M+8
	W7ZC8/8SAQgcpWHyK8mf44djVm/I8LRwT8GF8DIVJC8daHEDl1Kwde9w/d84pYvCysvapS4bsE2
	6RFoGi7SfWAE2kl2qUc8QcK0HMQ==
X-Received: by 2002:a05:6512:350a:b0:5a2:7a31:9197 with SMTP id 2adb3069b0e04-5a27a3193a5mr1082750e87.17.1773835207960;
        Wed, 18 Mar 2026 05:00:07 -0700 (PDT)
X-Received: by 2002:a05:6512:350a:b0:5a2:7a31:9197 with SMTP id 2adb3069b0e04-5a27a3193a5mr1082710e87.17.1773835207314;
        Wed, 18 Mar 2026 05:00:07 -0700 (PDT)
Received: from [192.168.1.166] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a279c2737bsm511973e87.4.2026.03.18.05.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 05:00:06 -0700 (PDT)
Message-ID: <77a291dc72c038003a41ec11999ada57f27cd386.camel@redhat.com>
Subject: Re: [PATCH v7 14/15] rv: Add deadline monitors
From: gmonaco@redhat.com
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Nam
 Cao	 <namcao@linutronix.de>, Juri Lelli <jlelli@redhat.com>, Jonathan
 Corbet	 <corbet@lwn.net>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Peter
 Zijlstra	 <peterz@infradead.org>, Tomas Glozar <tglozar@redhat.com>, Clark
 Williams	 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Wed, 18 Mar 2026 13:00:04 +0100
In-Reply-To: <abLBnlqIHVPEcisP@jlelli-thinkpadt14gen4.remote.csb>
References: <20260310105627.332044-1-gmonaco@redhat.com>
	 <20260310105627.332044-15-gmonaco@redhat.com>
	 <abLBnlqIHVPEcisP@jlelli-thinkpadt14gen4.remote.csb>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -zHQS9NP4CNjiigXPY6RhKK7lHuVEiRHpYPeHEMeK-Y_1773835208
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, 2026-03-12 at 14:37 +0100, Juri Lelli wrote:
> > +/* Used by other monitors */
> > +struct sched_class *rv_ext_sched_class;
> > +
> > +static int __init register_deadline(void)
> > +{
> > +=09if (IS_ENABLED(CONFIG_SCHED_CLASS_EXT))
> > +=09=09rv_ext_sched_class =3D (void
> > *)kallsyms_lookup_name("ext_sched_class");
>=20
> Looks like the above look up can fail. I don't actually see how/why
> if would fail if things build correctly and EXT tasks are around.
> But, theoretically, we could end up with rv_ext_sched_class =3D NULL ?
>=20
> > +static inline bool task_is_scx_enabled(struct task_struct *tsk)
> > +{
> > +=09return IS_ENABLED(CONFIG_SCHED_CLASS_EXT) &&
> > +=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tsk->sched_class =3D=3D rv_ext=
_sched_class;
> > +}
> > +
> > +/* Expand id and target as arguments for da functions */
> > +#define EXPAND_ID(dl_se, cpu, type) get_entity_id(dl_se, cpu,
> > type), dl_se
> > +#define EXPAND_ID_TASK(tsk) get_entity_id(&tsk->dl, task_cpu(tsk),
> > DL_TASK), &tsk->dl
> > +
> > +static inline uint8_t get_server_type(struct task_struct *tsk)
> > +{
> > +=09if (tsk->policy =3D=3D SCHED_NORMAL || tsk->policy =3D=3D
> > SCHED_EXT ||
> > +=09=C2=A0=C2=A0=C2=A0 tsk->policy =3D=3D SCHED_BATCH || tsk->policy =
=3D=3D
> > SCHED_IDLE)
> > +=09=09return task_is_scx_enabled(tsk) ? DL_SERVER_EXT :
> > DL_SERVER_FAIR;
> > +=09return DL_OTHER;
> > +}
>=20
> Considering that, if that happens, get_server_type() will return
> DL_SERVER_FAIR for scx tasks as well (possibly confusing monitors?),
> shall we add a warn or something just in case. A 'no we don't need
> that
> because it can't happen' works for me, just thought I should still
> mention this. :)

I forgot answering..

Well, technically yes, this all can fail.
I figured a silent degradation in this remote case would be alright,
but probably just print it during initialisation wouldn't hurt.

We cannot do much if it really happened and, yes, monitors would likely
fail if both SCX and fair servers coexist.
I'd assume it /should/ never happen, but it costs nothing adding:

  pr_warn("Error detecting the ext class, monitors may report wrong
results.\n");

Thanks,
Gabriele


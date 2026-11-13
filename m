Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602335;
	b=I7hpjwFDpPl5P6pLS+t1rPYgj2mX7gNyPg78qw8SU4XbQx5KAOF3bJX1n71DjXJYlBx8
	 m/LWd43Ae1p8wvLdm/QDuW7ObK5/a/g2NYIpj7BbNPzZxnS2by0ToTNaIhphtnf9PaUAZ
	 p/NYwXYw0X4ld4r6yhOLiiyDVbbJGBo/cCoNfz6eDWapD3LpCkvKEbPt8FRhDyjd5Y6SR
	 E/BbRT/5Gt7KzpXAW18KjM4iPjAp10dvVtM9LUbelNEMQvZE33RzRI1ZQpUnmjQnnAnxY
	 y0xUI9d8gcfEwYuII7fR3hJZNoK1M+8uZJPgSfX+jIAYLpsGZCy/GX5CG9VY9FfaTTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602335;
	h=DMARC-Filter:DKIM-Signature:X-MC-Rep:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Subject:From:To:Cc:Date:In-Reply-To:References:User-Agent:
	 MIME-Version:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Transfer-Encoding;
	bh=3sFSIY7zk3iPL6qFeV9u9740fEYkNs58q+BGNdovxmU=;
	b=MEdUBeh4nEh0IXaG6umiHB7EHQvOPYYBOfPELjeixsQAJpTfleRLuUj4viF3Unm37wAp
	 fXnfBap9OKXn1q/ZJEGpTUXQLy0JqG34GUlPESPfXPmZpQtaqCS37h72aYrKMZ/rEBxbd
	 zOY30F2L1QW+6A5KKJjEh7XzR5ZRZ+aB+mrfD+AqX1y99Ysa/5yJ9FbMwXrI+6UFZtK25
	 SPkcKH0VqYFZ8wNOJ+8rp+sSQYyETqQcu8tAIH0Wmbcd7ODKAhnBPInl6vfnCOrIak7F1
	 a3wIROahbo6W/y2Xxkw/2kBrQ4MP1DdzU254ZgktmoxGz0gM8E3KLcZD2zZu3jxQLHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SRC8yc62;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17052606A334
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 20:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17052606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SRC8yc62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794602332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3sFSIY7zk3iPL6qFeV9u9740fEYkNs58q+BGNdovxmU=;
	b=SRC8yc62JrvZHits+xd3+nqTN9IXDZ/8uY7AutEvArJoFfi404EGKq3x7b56o+zoh8de/u
	HzptctvLcKn0u6zP8DSqhsOo/70C7CipRjKw0Qkh+Og0QsNctKIMkwTtOdwFAaxH/fKe6K
	HbZ5XGwmifLNpcqLw/R61VwdhzAtOBE=
X-MC-Rep: binary re single
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-WJT7P8P6O9qWUVqQtEIUuw-1; Fri, 13 Nov 2026 15:38:50 -0500
X-MC-Unique: WJT7P8P6O9qWUVqQtEIUuw-1
X-Mimecast-MFC-AGG-ID: WJT7P8P6O9qWUVqQtEIUuw_1794602330
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-5587351d419so1081971b6e.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 12:38:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794602330; x=1795207130;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4tpO5biOpGgL10yOplA7RI/2o5T3LjwiEUChVIujqhc=;
        b=iD4v4dNCLJP0rpNIP5Uhq5JNdZq74h0NW6c4DbxJ4g6WPp+PjBC3ffZKnOgFl5sb+z
         GtPOQE5zaOMeXouTb4nY4P5Uwo4AnWuyQao7OQMHGYDXL1odr+tA7pcwyN3P4+/P8OWo
         +zmU/+gL1WfDm3ONH1Cgak6Tzkj3cercRd9DAx++kEL25tN4I2L/8f4exb04nCDTmeLi
         jG6bQBQLqPveJJ4uaqS9BoT8TExnzBy4yh2UlfFLXuH4+me8d4kfi8C96Ecrn5EfjlK/
         I882s4DidpKXJrqHpED0ofN7bwIX1+n/pPqE7nF2RshbHYPXGP2Cy9eeqP1PwotiB+3U
         97XA==
X-Gm-Message-State: APuU4Z91Esx7Wf9UYD0gmWE+tE/m8R/3/vte3P+xraDkVj5jLpIC2uUR
	3hDYjPyDCZ3wVwVdbhSAlBFw1gIRYWPYYmmM6mTaROYEUL1CNI4KaCHCtBYEKYx6buvqZQvwNiT
	yzvQPFvTpKbyHTYra8hCZbWGt3biwz0yIbAfajIutitLYkjBvCS8ehNdOoVXuT9nKB9YzR413mM
	dgAvzukA==
X-Gm-Gg: AYBFou3NHa81k8C7vH/9fbhYxxBHtdvP4VkTBuRjrltde3GR/YuExrLXYisH1LOnpI6
	YeKksYFTA4rSZasQ5U+xFKe/y+1gLWDolO8DeFmgLIlSFGIokI1UljOV8oT7oVLp9Yh/5cZiQ3C
	r7e9i0NcIP0KD5BV/tMcKf0nZ1lcIAHldzHboJVvF75n7rZwnZdSXf6rrwz49Ya9jWUVgN2P3FX
	v0BPJ88QYCCuGmQDdzrC9F7wMId+nn4s6O/zNlVd8FG8qtJBCEEXURWLOg06fVwLXZ1P3BDa6Pd
	3gHqgkMrjF31oedupICXXma+m1jUZ0G71Od5SvXxk2F7cpV1OkJHLbwgsc9g4IztdOZOeh3ABxL
	0tceAivnZlHrZ7msQgDYbyvGNaxLcroz7+FhdgS0+F5iDexh3efd+aidtT75Zlxio8anOp/2F4G
	ngO4xxozD2FFwaEiKat2blPeoGtCvo
X-Received: by 2002:a05:6808:1816:b0:53a:8c5:d7d7 with SMTP id 5614622812f47-56e6626d27cmr2968945b6e.58.1794602329944;
        Fri, 13 Nov 2026 12:38:49 -0800 (PST)
X-Received: by 2002:a05:6808:1816:b0:53a:8c5:d7d7 with SMTP id 5614622812f47-56e6626d27cmr2968927b6e.58.1794602329547;
        Fri, 13 Nov 2026 12:38:49 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (71-34-16-191.mpls.qwest.net. [71.34.16.191])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56e7024673csm2970739b6e.8.2026.11.13.12.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:38:48 -0800 (PST)
Message-ID: <8e121bf5d3e3dc1d0afe7dcc18f6feb68fae9ee8.camel@redhat.com>
Subject: Re: [PATCH v7 06/10] tracing/osnoise: Reset cleanup
From: Crystal Wood <crwood@redhat.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Date: Fri, 13 Nov 2026 14:38:48 -0600
In-Reply-To: <sashiko-outbox-212339@kernel.org>
References: <20261113064103.3041704-1-crwood@redhat.com>
	 <20261113064103.3041704-7-crwood@redhat.com>
	 <sashiko-outbox-212339@kernel.org>
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44)
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
X-Mimecast-MFC-PROC-ID: M4zzFUjG9ksSRopIns20He0bMlIBZFLXc2SRi4CEeZ8_1794602330
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-11-13 at 07:20 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] tracing/osnoise: CPU hotplug race in timerlat_fd_open() leaves
>   stale fdd
> --
>=20
> commit 25ee38a6983ff50cb9227e203eed4ba8758cefa4
> Author: Crystal Wood <crwood@redhat.com>
>=20
> tracing/osnoise: Reset cleanup
>=20
> This commit reorganizes per-CPU and global state resets in the osnoise an=
d
> timerlat tracers when stopping kthreads, detaching file descriptors, or
> restarting the tracer.
>=20
> > diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.=
c
> > index e61f57230eefb..8db0697b69e4a 100644
> > --- a/kernel/trace/trace_osnoise.c
> > +++ b/kernel/trace/trace_osnoise.c
> [ ... ]
> > @@ -408,6 +380,39 @@ static struct osnoise_data {
> >  #endif
> >  };
> > =20
> > +static inline void osn_reset_cpu(int cpu)
> > +{
> > +=09struct osnoise_variables *osn =3D cpu_osn_var(cpu);
> > +
> > +=09WARN_ON_ONCE(osn->kthread);
> > +=09WARN_ON_ONCE(osn->fdd);
> > +
> > +=09osn->sampling =3D false;
> > +=09osn->pid =3D 0;
> > +=09tlat_reset_cpu(cpu);
> > +}
> > +
> > +/*
> > + * osn_var_reset - Reset non-per-cpu state, and check for stale data
> > + */
> > +static inline void osn_var_reset(void)
> > +{
> > +=09struct osnoise_variables *osn;
> > +=09int cpu;
> > +
> > +=09for_each_possible_cpu(cpu) {
> > +=09=09osn =3D cpu_osn_var(cpu);
> > +
> > +=09=09WARN_ON_ONCE(osn->kthread);
> > +=09=09WARN_ON_ONCE(osn->fdd);
> > +=09=09WARN_ON_ONCE(osn->sampling);
> > +=09=09memset(&osn->zero, 0, sizeof(osn->zero));
> > +=09}
> > +
> > +=09tlat_var_reset();
> > +=09osnoise_data.tainted =3D false;
> > +}
>=20
> [Severity: Low]
> Can osn_var_reset() hit WARN_ON_ONCE(osn->fdd) if timerlat_fd_open() race=
s
> with CPU hotplug takedown?
>=20
> timerlat_fd_open() disables migration without holding cpus_read_lock() or
> checking whether the CPU is still active under osn_var->lock.  If a task
> pinned to CPU0 enters timerlat_fd_open() just as CPU0 is being offlined,
> balance_push() skips the task while migration is disabled, allowing
> osnoise_cpu_die() to run before timerlat_fd_open() attaches osn_var->fdd:

True, but not a new problem other than that we have a new way of
detecting it.  I can send a followup patch once I return (I'll be away
for the next three weeks).


-Crystal


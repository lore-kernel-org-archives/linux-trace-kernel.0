Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C8737BE8B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 06:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779086218; cv=none; b=RA26czsAU3AzhaIVk+pcYlBPMgEwSGrUn8r3Q/tbRkSDTHDPOrmCVqYVyaZzY9SzN1cBXh61eoy5N2vPmWsH6FVDd5irvKSzB8cl8q6mCHoCbfwX6aamwIOP45p5lR8D0YKw8z+lxLHgP+761wWPB3gAq0hTrbV+GIec4iHX+qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779086218; c=relaxed/simple;
	bh=xEL2+fWCA2Q9BGIknE3ZwEAbzGSj8+9gjQyetfyxssQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YiVEb+HrwlHtQrMzKRBWFmKRX7mPjAc/03vZw5uxKTH5vZnv3cu6hxBHGdopo5VkPGOKg3oTY2bYzzA3H9wgjHbXkD6YKdcX+o3yTRJqErlFgQFU/PABbD3rnVd8hDLFn2dwy3RvLcmhRRK/euUp3HxIjpTGM7KcnC97rRAdvJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J0/Tuhg6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J0/Tuhg6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779086213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xEL2+fWCA2Q9BGIknE3ZwEAbzGSj8+9gjQyetfyxssQ=;
	b=J0/Tuhg6LhVbDOCFRvwyazSio9v5m2LekHnirSFrtkcUPrPdkQYUsFyzLx2KXMGNNAD1R4
	QXdGM5yz1S9z4woU1S013VPnK8Tw7kkF4U3b+YCOq/sRkSxxF0POcm4VT53Ht7EbNTlOXh
	1+iK/Pcp7OJAqicgdAS61sD0OhZxUdE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-Q3PVpGnrNjyATF28A7ZL2w-1; Mon, 18 May 2026 02:36:51 -0400
X-MC-Unique: Q3PVpGnrNjyATF28A7ZL2w-1
X-Mimecast-MFC-AGG-ID: Q3PVpGnrNjyATF28A7ZL2w_1779086210
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-44f56d5523eso2156932f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 17 May 2026 23:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779086210; x=1779691010;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VfPZRg2qD8k4pCWGiYWBu0a8OEZ/46CwJ++dcTlHMKs=;
        b=AA9E7DprL0MDtT0KCTVAHOjGJGASEOR6bvG89O6tzLecgLti4lVPF3eWnmTA19d0GU
         Yojl0LTlofiDt88ceDFYT4zgP2jE0rcOq3qJiuQgYdRpG/b+yZb8z/YyBebrmMHnfME9
         Utqm/hjcy4ddK/btnfQ0oijJVHSjKHvlFR8dLDpjBX3SVq3xxaUgrLOyxcuCV2c86T2i
         LscyHNhZps4Uvc+QnTjqaPTCucQIJygHraFR25AiXugncuxaVrjyvWl4EL0UyRHAxH5L
         wWF+eIBJW+nc+rptNmk8jYE7lXriIIcUruQVRbEOqQFA70+G4PyrLX//rz2XlsHOCWjS
         qEOQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Hx+54rDlQnu9N3gmRb7c7njpkIXMb2LEQefPIQV+XtFfyf3yFyAIgmE1AHE23hMWY7bS57LKLpqx4I/eyfFYZwuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzstGUVtGWHuuKWsZkbsD3bCCWMiXek6YvVot0e0aOtIrBkgc3n
	RwHbhucWQ++4sc9WRaT42PuqggM6wFXkB1IVosX1uaKZVagSaMDvra5RldeFtGCVSjmH7lT4Jde
	p0kaC8OmiHVyluF2x3ahMDLEJEMaIusodZ2v6+0tWnY0MZncGyesKIvhy+XbsjsY/KZEtAO46Bg
	==
X-Gm-Gg: Acq92OGKCNI9OOw16W85LgOxVRO7VkQNg5Nio/gZOeeaSZML7q/HZLa7jMlJEr/Y5XO
	9Wvm9schC1Miz/UmegFxGG8Htmb3HZc5o/jfLTwn4MR06ubjzRwz+snBRrCWx376Ysb/j/WF9Ou
	JQg/0fGySfPjOTGD4ZfvR7yBBeKtzXjNZSocKU0aAcd/1PPQihCfXmqt4T+OzZEs6ploRERZ5Mu
	ip2PEkql1n1pcEk1nwU9Jc+O5HYUM+f325dyC2y8R/7IWS311PwSWPZ+Pj0+//0o+KJICsDWxFk
	kt51L+KacsDzpcwNuo9+uXW5YqZA8zp3sLbnRyRYe+18qrfYmDHwJnxR1LqC/+4cw1x013KYoD/
	1WSWr3+vbcHAbGFzQf+stlA2n6nnlG+3STJoUbs9RXQKCoG3qxfZwLaxYn1OebQPMtS3m3FvjTg
	MrFiRiO0i5NFbJ7F99n/CevqVsew==
X-Received: by 2002:a5d:5d85:0:b0:441:2335:ac3f with SMTP id ffacd0b85a97d-45e5c59f46fmr20725774f8f.31.1779086210284;
        Sun, 17 May 2026 23:36:50 -0700 (PDT)
X-Received: by 2002:a5d:5d85:0:b0:441:2335:ac3f with SMTP id ffacd0b85a97d-45e5c59f46fmr20725732f8f.31.1779086209847;
        Sun, 17 May 2026 23:36:49 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768072sm34103890f8f.5.2026.05.17.23.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 23:36:49 -0700 (PDT)
Message-ID: <27f7000d27f32ff74f50208779ef26d5566d06f5.camel@redhat.com>
Subject: Re: [PATCH 9/9] rv: Mandate deallocation for per-obj monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wen Yang <wen.yang@linux.dev>
Cc: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org
Date: Mon, 18 May 2026 08:36:47 +0200
In-Reply-To: <c4a3c4fc-7efb-4eb0-81d6-cc7a0d51f8fa@linux.dev>
References: <20260512140250.262190-1-gmonaco@redhat.com>
	 <20260512140250.262190-10-gmonaco@redhat.com>
	 <c4a3c4fc-7efb-4eb0-81d6-cc7a0d51f8fa@linux.dev>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YSqZzmD6lvl3G8djRDF5qqTcLARHP6DCs0Sxf49qYps_1779086210
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2026-05-17 at 17:52 +0800, Wen Yang wrote:
>=20
> One gap: tools/verification/rvgen/rvgen/templates/dot2k/main.c uses=20
> RV_MON_%%MONITOR_TYPE%% but generates no deallocation code, may fail
> to build with a -Wunused-function warning.
>=20

Thanks for the review!

That's technically the purpose of this patch, we don't know exactly how is =
the
per-obj monitor going to deallocate, so we make sure build fails if they do=
n't
set up a way.

This combined with the fact per-obj monitors aren't really documented (yet)=
,
makes it quite confusing, doesn't it?

Would you prefer we always generate a dummy hook calling da_destroy_storage=
()
and let the user decide what to do with it without forcing (obscure) compil=
er
warnings?

Thanks,
Gabriele

>=20
> --
> Best wishes,
> Wen
>=20
> On 5/12/26 22:02, Gabriele Monaco wrote:
> > The per-object monitors use a hash tables and dynamic allocation of the
> > monitor storage, functions to clean a monitor that is no longer needed
> > are provided but nothing ensures the monitor actually uses them.
> >=20
> > Remove the inline specifier on the deallocation function to let the
> > compiler warn in case it isn't referenced. If the monitor really doesn'=
t
> > need one (for instance because instances will never cease to exist
> > before disabling the monitor), the da_skip_deallocation() helper macro
> > can be used to silence the warning.
> >=20
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> > ---
> > =C2=A0 include/rv/da_monitor.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 14 +++++++++++++-
> > =C2=A0 kernel/trace/rv/monitors/deadline/deadline.h |=C2=A0 5 ++++-
> > =C2=A0 2 files changed, 17 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> > index 402d3b935c08..378d23ab7dfb 100644
> > --- a/include/rv/da_monitor.h
> > +++ b/include/rv/da_monitor.h
> > @@ -489,8 +489,11 @@ static inline monitor_target
> > da_get_target_by_id(da_id_type id)
> > =C2=A0=C2=A0 * locks.
> > =C2=A0=C2=A0 * This function includes an RCU read-side critical section=
 to synchronise
> > =C2=A0=C2=A0 * against da_monitor_destroy().
> > + * NOTE: inline is omitted on purpose to let the compiler warn if this
> > function
> > + * is never referenced. For monitors that don't require a deallocation
> > hook,
> > + * da_skip_deallocation() can be used.
> > =C2=A0=C2=A0 */
> > -static inline void da_destroy_storage(da_id_type id)
> > +static void da_destroy_storage(da_id_type id)
> > =C2=A0 {
> > =C2=A0=C2=A0=09struct da_monitor_storage *mon_storage;
> > =C2=A0=20
> > @@ -504,6 +507,15 @@ static inline void da_destroy_storage(da_id_type i=
d)
> > =C2=A0=C2=A0=09kfree_rcu(mon_storage, rcu);
> > =C2=A0 }
> > =C2=A0=20
> > +/*
> > + * da_skip_deallocation - explicitly mark a deallocation function as n=
ot
> > required
> > + *
> > + * Only use when you are absolutely sure the monitor doesn't require a
> > + * deallocation hook (i.e. it's not possible for an object to finish
> > existing
> > + * when the monitor is still running).
> > + */
> > +#define da_skip_deallocation(hook) ((void)hook)
> > +
> > =C2=A0 static void da_monitor_reset_all(void)
> > =C2=A0 {
> > =C2=A0=C2=A0=09struct da_monitor_storage *mon_storage;
> > diff --git a/kernel/trace/rv/monitors/deadline/deadline.h
> > b/kernel/trace/rv/monitors/deadline/deadline.h
> > index 78fca873d61e..c39fd79148c2 100644
> > --- a/kernel/trace/rv/monitors/deadline/deadline.h
> > +++ b/kernel/trace/rv/monitors/deadline/deadline.h
> > @@ -194,7 +194,10 @@ static void __maybe_unused handle_newtask(void *da=
ta,
> > struct task_struct *task,
> > =C2=A0=C2=A0=09=09da_create_storage(EXPAND_ID_TASK(task), NULL);
> > =C2=A0 }
> > =C2=A0=20
> > -static void __maybe_unused handle_exit(void *data, struct task_struct =
*p,
> > bool group_dead)
> > +/*
> > + * Deallocation hook, use da_skip_deallocation() when not necessary
> > + */
> > +static void handle_exit(void *data, struct task_struct *p, bool group_=
dead)
> > =C2=A0 {
> > =C2=A0=C2=A0=09if (p->policy =3D=3D SCHED_DEADLINE)
> > =C2=A0=C2=A0=09=09da_destroy_storage(get_entity_id(&p->dl, DL_TASK,
> > DL_TASK));


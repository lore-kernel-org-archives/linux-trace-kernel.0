Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163073515D5
	for <linux-trace-kernel@vger.kernel.org>; Fri,  4 Sep 2026 09:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512648; cv=none; b=YEdou61R0wgiyM9xZmbCY4ZfMEYBki9OVA2BCh+UBou3jF3+BLm7oxMpphNkJ83UHJR2vorSWOmcU2LE4pefi5uGDeDpKGIpuDeqz9LeEV4tT5xoNzuDCJGTOOxrdUFxtvggWgS6Wpv/AAX7HyjiP2clA07Q73LXhTDjaYBTOIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512648; c=relaxed/simple;
	bh=k9qAPKtYvovu8qXJCKcDvO86yRXk72wYQsBLiBbmLP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOvR3GHif0TiAihQCVe3L2pNy2Mea5X8lIo0MyxV54vtSkIsPfbosHpBBirCc7OGymIRzAY/wuSkSWze6yMPIDtYlMWr8d1Ytx6Qx2mVMKDoQcC35qV4qxZhnMmnk9Iug7bDqne3hU3CyZDpBityuC+yt6w+flXcJPuNPW9ZjR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NYIJ/QLQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NYIJ/QLQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788512645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q31ZBmdW8hNNfLkDMMwoS1IW8VBGns0g1GPgqGkxWn8=;
	b=NYIJ/QLQwG5ya587jNmwleRgNM9nt4BT4d2vVb5D/fZyD0wz3ZRwiO8bwZcl8jlaa3Hfos
	T9xCw2S6MDIkCelIVmFzkbXkFhOpah2w6eWnReI578JNMk/9M//5NNH+K5Vn8kB+3VNI6W
	Pbzo4miBlilxlYnBYq4sVK7EgUcOFZI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-RXoynTeoOB2dyKmxcB7qCA-1; Fri, 04 Sep 2026 05:04:04 -0400
X-MC-Unique: RXoynTeoOB2dyKmxcB7qCA-1
X-Mimecast-MFC-AGG-ID: RXoynTeoOB2dyKmxcB7qCA_1788512644
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c2192261d79so78938266b.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 04 Sep 2026 02:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788512643; x=1789117443;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q31ZBmdW8hNNfLkDMMwoS1IW8VBGns0g1GPgqGkxWn8=;
        b=dtyd02y2ql6ONWhYVUkiDXDaQ0Ziju1OFxGQAO21Cob3B0//ojxR0OyO4gIowk+QOw
         CmyctMUtH44FAIOUspmatJd8SEo8j3n6GJ1YHX5h8vK5Tt+jQj7Mkh3gaFO25V93+jXI
         7O1Z+H/OkaQzNanHoUubxeosOYz2oPaVMNDwWRti7YZX6OiFeYJnm6n1nRgsrRbU4pnd
         WwjKuifbuioGDmx/reYmLR4a+vgOi8/VPg+fIL2751AhOFPI/fV6PKARzmfUz2jVhvNU
         CfjAT+ilQdlL/cDzu/vh9J/WBscGB7j/3zYAzu5fuMh43/Q7keUWv5YdFvF5G0lYX+Vo
         qPZw==
X-Forwarded-Encrypted: i=1; AKwUvBwu2Fc9NCcWR7ij42Mrgglh5w66Dn3XKNiHzbVCU85FJXl7EtawksG8Xjrtwrg0F13NtHCr2ddj2j6qWk6p6DXj7HI=@vger.kernel.org
X-Gm-Message-State: AFuF++l1DL0GjBw/5qEKKcYfavQl4FY+ETXdMkVY/XyYEtKl/BLM916f
	aDh8A+wsjbkyN3uD2P9BZHiqbr44U/HhkZm2SM6i1ber6Z4g4/UNtTfCtq00QNZ7Mklt9Dilpin
	h5BW0ZMV3AMuKR4L7xiMtPTzhIdU1fuSyYf73+G5JdYA+H4s0Mih3jyCWfm4KCstQ34pr0xYq93
	hpVYgVGO2ggEpR2RiJr6hAAHJ18e/GYAd1H/eUC4W1eEVB10zj
X-Gm-Gg: AYBFou2DLh3XNVp5TUM8GoleZIAzHHQE+rksR6r7u4sRKG7cBpAbogkI32R7NaquhyA
	QMwZ7I0wX6XuYpP4wAI60RLlVww6yLGQsF4kITojtKSALmOOcF0yOBX/0dXVd59fPCDcPZbTwwS
	9ihjwjxPc1WwpasRBNL9WKWcfqReY1bLkpbI8100xiuskMXZ9kOaYRb/OYOapPOzVuVb3Oev7ix
	NpIEOA9nYhQg0Q=
X-Received: by 2002:a17:907:7252:b0:c25:437:3dcf with SMTP id a640c23a62f3a-c260ca1e82cmr197403366b.21.1788512643452;
        Fri, 04 Sep 2026 02:04:03 -0700 (PDT)
X-Received: by 2002:a17:907:7252:b0:c25:437:3dcf with SMTP id
 a640c23a62f3a-c260ca1e82cmr197399966b.21.1788512642934; Fri, 04 Sep 2026
 02:04:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612115121.54862-1-tglozar@redhat.com> <725da8a4ca6a46ea8ba41778971602b49d650e60.camel@redhat.com>
 <CAP4=nvRMAZ6AJ_WQPVM2sm9jH++4RwN8DhodU7oL6-AcXNg8OA@mail.gmail.com> <67895578a730d56a50568a7403ba4ef8f7b3e24a.camel@redhat.com>
In-Reply-To: <67895578a730d56a50568a7403ba4ef8f7b3e24a.camel@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 4 Sep 2026 11:03:51 +0200
X-Gm-Features: AcwNN1WkH9BSXuBJ4lQTj1zRaXaKoqL7KYm5xcyjbCTbrCjNWz5Iy4eGvq5Ul9Q
Message-ID: <CAP4=nvTciQ-jsdoL=udYzSb037KMGY1QTerVGZ5M3nTyu17imA@mail.gmail.com>
Subject: Re: [PATCH] rtla: Simplify osnoise tracer option setting code
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ODkQK9DNMNYHSGleB7ddg2a8p7Aez3l_OlVMO6tHf3c_1788512644
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 12:31=E2=80=AFAM Crystal Wood <crwood@redhat.com> w=
rote:
> >
> > They are called "osnoise options" in the interface (although they are
> > shared with the timerlat tracer), which cannot be changed. I don't
> > like using an esoteric prefix like "osn".
>
> I'm not suggesting changing the kernel interface, just having some
> convention within rtla (and within trace_osnoise.c) to make it clearer
> which things apply to osnoise-the-subsystem versus osnoise-the-specific-
> tracer.  It might be "esoteric" which one gets the abbreviation, but as
> long as it's consistent I think it'd be an improvement over the current
> jumble.
>

After giving it some thought, I believe the best approach is to use
the proper tracer name (osnoise/timerlat), with "common" for shared
options, regardless of the tracefs file names.

For example, "osnoise_set_timerlat_period()" should be just
"timerlat_set_period()", and "osnoise_get_cpus()" should be
"common_get_cpus()". Implementing this with the macro lists is a bit
tricky, though, so I'm leaving that for a future patch.

> >
> > > > + * Long long option get/set/restore/put functions, generated from =
OSNOISE_LL_OPTIONS.
> > > > + */
> > > > +#define OSNOISE_LL_OPTION(name, path, init_val)                   =
                           \
> > > > +static long long                                                  =
                   \
> > > > +osnoise_get_##name(struct osnoise_context *context)               =
                   \
> > > > +{                                                                 =
                   \
> > > > +     long long name;                                              =
                   \
> > > > +                                                                  =
                   \
> > > > +     if (context->name !=3D (init_val))                           =
                     \
> > > > +             return context->name;                                =
                   \
> > > > +                                                                  =
                   \
> > > > +     if (context->orig_##name !=3D (init_val))                    =
                     \
> > > > +             return context->orig_##name;                         =
                   \
> > > > +                                                                  =
                   \
> > > > +     name =3D osnoise_read_ll_config(path);                       =
                     \
> > > > +     if (name < 0)                                                =
                   \
> > > > +             return (init_val);                                   =
                   \
> > > > +                                                                  =
                   \
> > > > +     context->orig_##name =3D name;                               =
                     \
> > > > +     return name;                                                 =
                   \
> > > > +}                                                                 =
                   \
> > > > +                                                                  =
                   \
> > > > +int osnoise_set_##name(struct osnoise_context *context, long long =
name)                      \
> > > > +{                                                                 =
                   \
> > > > +     long long curr =3D osnoise_get_##name(context);              =
                     \
> > > > +     int retval;                                                  =
                   \
> > > > +                                                                  =
                   \
> > > > +     if (curr =3D=3D (init_val))                                  =
                       \
> > > > +             return -1;                                           =
                   \
> > > > +                                                                  =
                   \
> > > > +     retval =3D osnoise_write_ll_config(path, name);              =
                     \
> > > > +     if (retval < 0)                                              =
                   \
> > > > +             return -2;                                           =
                   \
> > > > +                                                                  =
                   \
> > > > +     context->name =3D name;                                      =
                     \
> > > > +     return 0;                                                    =
                   \
> > > > +}                                                                 =
                   \
> > >
> > > Using "name" for the value is confusing... "val" would be better.
> > >
> >
> > But it's the *name* of the option/field/argument here, not the value.
> > If you use "value" you'll get:
> >
> > #define OSNOISE_LL_OPTION(value, path, init_val)
> >
> > which is incorrect. Would making the macro options in capital letters
> > (i.e. NAME) make it more clear?
>
> That's not what I meant.  I was suggesting this:
>
> int osnoise_set_##name(struct osnoise_context *context, long long val)
>
> -Crystal

Ah, now I get it. I fixed this in the v3 of the patch [1].

[1] https://lore.kernel.org/linux-trace-kernel/20260904085500.488905-1-tglo=
zar@redhat.com/

Tomas


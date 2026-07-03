Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F3F3D3338
	for <linux-trace-kernel@vger.kernel.org>; Fri,  3 Jul 2026 14:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783087817; cv=none; b=kIQ+zctii0zJUp2QdIg9lEizEbfZQj7laWs51J5bKO1XuWP8jsru6KyyyRzFvqfdYm3d8z8LnX20OEi/V8m/Zu3aNOMqAPzogXmFKqC1iaA7S/tqs13/Id66xwB+xqEbKRqX4CGpmV5xTswVlXgCIkAbFyQ2oeXPxUig32+d8t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783087817; c=relaxed/simple;
	bh=Ikp84dHAZnxM5GlGMhGYT7BrUHq3P73VSigOMViV7M8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7S5ieODwt2a7yJKLGmapBVuLehxlEYcwMGSdkIKgNmRxiQiAr4s+KQaBthSQXHUr86UIn+XErdLUMZobIZ9yBNGfoecdseXd4Lx91AZjJlZ1czPicpFCd8CnCJdNiyFAjmMRpTNZX77hxN+l+qHXk7XZBeAnEkOFyGqK55WWZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M7cu/g+R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M7cu/g+R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783087814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vdLv+uitNEfIJhs9BwISrPsnB96UQFIpD1P7PQWVwIs=;
	b=M7cu/g+RjC9Tq4k3LwLT/u43hXUtAYdf6ru0XcdEnVBgXMLXmRHhMom/3AjcTgzujpROEg
	ZNqoNbbNSbFY/Qy+h8NKTrl83o5TSAYcpdwU2aCThOKQAYKlmb1qP5cQIG/Bd4STBXh9DA
	xehxPlD0F/z0FwWzRZnlTRFQQa2SE4E=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-Z9kBFKY2NLyStJ8uqMJHcA-1; Fri, 03 Jul 2026 10:10:13 -0400
X-MC-Unique: Z9kBFKY2NLyStJ8uqMJHcA-1
X-Mimecast-MFC-AGG-ID: Z9kBFKY2NLyStJ8uqMJHcA_1783087812
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5aeaf9fadb5so409984e87.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 03 Jul 2026 07:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783087812; x=1783692612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vdLv+uitNEfIJhs9BwISrPsnB96UQFIpD1P7PQWVwIs=;
        b=LbxANs630AWfvFyfUABMgf4GHN8FyytIdlfvBzygfd2Nl0zv05OhvBYnDiSnQCHJQ0
         XkziG94NpNdbUE9eH/yheLIVmsELCU+Vu1Az2RvwEU9t0VnlJFb2DFqAw4kTAtB6Wrx2
         7VybS3OxcWljS30WEbmLC4psxK6ZEudVrF2DnJQA/kPjvcY6dnl/HJAsSvQE7/PPmveF
         Mcle/mnYkA4bfKV3hBl78288ZtTvH1YAGMapKNgmTJSvB80yb57Wy/EX5kzvCqElFYs2
         zaE+NLcGGzgTcDH73DaZMRbjE8XFbvrLx98Ria9ADQkZdkUyFXWx0A42kPQTkcJ1iI+m
         b8Kw==
X-Forwarded-Encrypted: i=1; AHgh+Rpm0m5+lP7tUpi0gMr2pgPhJzQuVXXRJ+pMwM5Yz766T0oZBSh6t7+IEEr1Uv/ex65I5y+JOAd1XPYk6mBKOWK2CkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpIKuFcGR4cV8GV4uxPwmEFF7gOalSWCiejd6u+0VsgTyE3UK5
	Oru9nroU2X9wyirCPoROO1bznCvL5g1OPVEBoJN9KIb//OcF0LAeNH/WcNgcQuHfAF97RhMp+pO
	8PI/oJbP8uFdYGYEcluS5+utoNYWZ9BMtfjvAOXdF7VrBGWK6TbeZdxzj/9jZbfKZlkYukREsNl
	Il/ZyIRqy8zFnz9Y6ufqEdwSAc6y/ztTmckxtNOx+1y8bjA57a
X-Gm-Gg: AfdE7clpsb3dngb3TUtWIzvX6tM0yoOmVo8fDuge1Slu4gQTLuecssUhq8nb5RNU8be
	7O8ot++wZ/E+dVtdwAQa8CdnJSegdqIrnw4c/M1awbQZ6XtWOVsfMElOFWCM74P9RN36ej9uJoZ
	/mZF9sM6fx8V+//4J4HXyyp+GIhiWQiJCtXR3u282a++NIYXh9uSZxtLq9RpH3hoytyFsIMP3lz
	VsH34tbQyjILoRsBpupXdx9lA==
X-Received: by 2002:a05:6512:22d8:b0:5ae:c099:a92 with SMTP id 2adb3069b0e04-5aec68b7ea8mr1846707e87.42.1783087811895;
        Fri, 03 Jul 2026 07:10:11 -0700 (PDT)
X-Received: by 2002:a05:6512:22d8:b0:5ae:c099:a92 with SMTP id
 2adb3069b0e04-5aec68b7ea8mr1846699e87.42.1783087811357; Fri, 03 Jul 2026
 07:10:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612115121.54862-1-tglozar@redhat.com> <725da8a4ca6a46ea8ba41778971602b49d650e60.camel@redhat.com>
 <CAP4=nvRMAZ6AJ_WQPVM2sm9jH++4RwN8DhodU7oL6-AcXNg8OA@mail.gmail.com>
In-Reply-To: <CAP4=nvRMAZ6AJ_WQPVM2sm9jH++4RwN8DhodU7oL6-AcXNg8OA@mail.gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 3 Jul 2026 16:09:59 +0200
X-Gm-Features: AVVi8Cf0Wjr_sdPxDoWRMx_bbnbZjyuoeK35GoDbfQ1sCxQxq9EZqfrL-f_Q518
Message-ID: <CAP4=nvQUJY7zdcV79N_W014unSRfNizhimnmT9DoXrFVheqKww@mail.gmail.com>
Subject: Re: [PATCH] rtla: Simplify osnoise tracer option setting code
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -igwR8E6DFbH0u_ez4_hghhouGL3MrKwjAVdinMGLh4_1783087812
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 3. 7. 2026 v 14:11 odes=C3=ADlatel Tomas Glozar <tglozar@redhat.com=
> napsal:
>
> p=C3=A1 12. 6. 2026 v 19:55 Crystal Wood <crwood@redhat.com> napsala:
>
> > > OSNOISE_LL_OPTIONS takes three options: name - struct osnoise_context
> > > field name (written "<opt>" above), path - filename inside
> > > /sys/kernel/tracing/osnoise passed to libtracefs, and init_val - init=
ial
> > > value of struct fields, corresponding to an otherwise invalid option
> > > (some options use OSNOISE_OPTION_INIT_VAL =3D -1, some use
> > > OSNOISE_TIME_INIT_VAL =3D 0).
> >
> > Can we simplify by always using -1?  Especially since that's already
> > treated as the universal "invalid" by osnoise_read_ll_config().
> >
> > FWIW using "init val" to mean "invalid" rather than "default" is a bit
> > unintuitive.
> >
>
> The idea behind *_INIT_VAL is to re-use a value that is invalid on the
> osnoise tracer side to mean "not (read from tracer and) set yet (on
> the RTLA side)". OSNOISE_TIME_INIT_VAL is used for values where 0 is
> invalid (e.g. period, runtime), OSNOISE_OPTION_INIT_VAL is used for
> those where 0 is valid. I believe the distinction comes from the fact
> that some of the osnoise options are unsigned on the kernel side, and
> -1 (=3D 18446744073709551615) is actually a valid value there. E.g.:
>
> [root@cs9 osnoise]# cat period_us
> 1000000
> [root@cs9 osnoise]# echo 18446744073709551615 > period_us
> [root@cs9 osnoise]# cat period_us
> 18446744073709551615
>
> There are values where both 0 and -1 are valid (stop_tracing_us,
> stop_tracing_total_us, timerlat_align_us), and they use
> OSNOISE_OPTION_INIT_VAL. Those cannot use OSNOISE_TIME_INIT_VAL as 0
> is a meaningful and common value for them (disabled for
> stop_us/stop_total_us, zero alignment for timerlat_align_us). Those
> will break if pre-set to 18446744073709551615.
>
> Merging OSNOISE_OPTION_INIT_VAL and OSNOISE_TIME_INIT_VAL would
> introduce this breakage to options that are using
> OSNOISE_TIME_INIT_VAL now. IMHO the cleanest solution is dropping the
> entire complex logic around checking if the value was read from the
> kernel already, as there is no user: RTLA always saves the value once,
> then restores it at the end.
>

Ah sorry, I missed that we use get_llong_from_str() for everything,
which already treats all values as (signed) long long, despite period
and runtime ("OSNOISE_OPTION_INIT_VAL" options) being declared
unsigned. We can just drop the INIT_VALs then and just use -1.

Tomas


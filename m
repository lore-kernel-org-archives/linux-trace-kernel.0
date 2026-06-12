Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAEF364E84
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Jun 2026 17:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781286906; cv=none; b=tHb6Z6CcM6G66nujvq7rD19+PBFLZ5gz9b25Im9qmH6PJEyqOHm88yevDo7hLcV2sfyNRe4KGWO0/kssqIcEX29ckVomDuDJpdvOVGMF9U0jJ6P3rebxjn/3LP79rf3Fje0a1/N/N9u3DD/BWpJe8bJM4WdAxh2MNxwFbz8Slwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781286906; c=relaxed/simple;
	bh=IMwwu+eNJCeVhS5LhWzy2Jw4/oZo5p8Rdoh9+2U3Jrk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PuTRitXxToo6UTaE6uXu0+hiaHmzL4YyWQAtw/8pibt8c7wAIv4vIyxe/lBighJMM+IKA1+v5g/35nFXRpKv5vvW4hSh+WK0cY7GyUXBNBQXW7we/IeKxRgTjOKuY23btltdgASCL7rg882+tlZJTPTg7Lv5NCjf/nlk7lIeNWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VneR8ir1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VneR8ir1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781286903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7QlBALwHaaUfLykQq2jQq7yxXT7I+8fynip/nN0uEBM=;
	b=VneR8ir1VZ7VhWY2T2uoMiAxINrPjXHyOerfaUXy+oulRapHcuURjLoM62hcL1n62ADW3e
	3lYatVNYCL+SPE0LiV5SiOeZAIUhlDQZyUUuI56S7rfx9cgGALmgPD6Op6FX3d7nDPAlYn
	I+LZ/ga5r1oJGgNLnUfcGgxdrO7kLk4=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-PTZ7yWMzPHSLDk2EViZfkA-1; Fri, 12 Jun 2026 13:55:02 -0400
X-MC-Unique: PTZ7yWMzPHSLDk2EViZfkA-1
X-Mimecast-MFC-AGG-ID: PTZ7yWMzPHSLDk2EViZfkA_1781286901
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-69e393262d6so1822835eaf.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Jun 2026 10:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781286901; x=1781891701;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pXDhvV8bnaAuLCQ67j/U6pOfdL+WZT0Eo2w9Zx37nwM=;
        b=ansiiHbl1GP1eaKviAhfMgPtef/7al875QCy4qjDGoLWbyD8s1JCROyWNW44S9zuc3
         0JrqAikzC0kAqe5Kuh89oApMyaQUPaT3zbu+oM1hK8zrhWDEg3ddY6oTzpydKKdMfEfy
         lL1UkVxh8Rvu0FhDmqy2fk7fFJb2zW+01FhfRc5RsUA/RlG/bxvXyVDxaZT/eSjATx3Y
         jQ0rFlwzZu/CxUCMeeQidq+0OJ2+bBqplFgE7j5ASudTJOkyKs4FzasKRVcSzV9ir+Ts
         LPkTnH/AYTii+f77I/LOkFXjo41jDyjeYK2GUxwxDf6aXrTk/huRmxbuo6CzmEyqPyKo
         0kmg==
X-Forwarded-Encrypted: i=1; AFNElJ8Ci9r9n8cXXu0W2XMH4htznb4RR4rMhjFgFOhA3x1RBxsO0a2Wx3hzsaJCUVcB4ilIIJb3yuIvBm3lGigSahsYS1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwokMch3G4OUMz1T8fBy7V7aSPb6jV+IPlgVjjtLJ1XcbrgRMGE
	iIAUrwmewNm5sdfHhX2TdHmBtf8zjMXkF2K2CLLwJ0RG1Tcxhm5vIosohOmGLiQjrZUTYcziL4m
	MOHlw+WVUw3ZyF24T0U88yg/EhnqyamEXKqgX26RYZQJxiA3/rlX8mG/4183Mtdg4OaTST43atw
	==
X-Gm-Gg: Acq92OFc2S0hrg0tpeeuX9kz9jaFkLx12tdrg8W9Tezm+Ws1GNncdIRv5cGChQjgSgo
	qEd7OPyKc3UBZp4l0YrQ38jkEt0MxWt4WRpM11CT7IEYQ4kcdLj25v8YHzSEWZoAxOJhC1IxVdY
	Mt4oTGi1rg70KhrGSYJ7Ynt109pwJHbnPdLBAhptbDKJH1Y1IhFdkVJFTgOZT5VcCn9tv3TCXxr
	5+PHo+pxMsXbX3cSfVR9e9RS8QVQKZmyk193sLLVdWZThHuoc+PM39MTeC9fl6dXi1DcIc3d57H
	/QAQKsL1mh9xoDDalN59pJlxt0Ff4p5CO39mfgJs457vaYw1nLslqLdqyLfODShJqNjanF4onl7
	/EkIUWQfVtDD5+fdyfqZyye2N2fpAd6u/LN5rUusfO1mbShzo+T+8aA==
X-Received: by 2002:a4a:e915:0:b0:69e:b6df:6824 with SMTP id 006d021491bc7-69edc5e9a07mr2194825eaf.6.1781286901355;
        Fri, 12 Jun 2026 10:55:01 -0700 (PDT)
X-Received: by 2002:a4a:e915:0:b0:69e:b6df:6824 with SMTP id 006d021491bc7-69edc5e9a07mr2194809eaf.6.1781286900853;
        Fri, 12 Jun 2026 10:55:00 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc01:6890:c623:cd89:345e:99f3])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69ed8369957sm2041681eaf.3.2026.06.12.10.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 10:55:00 -0700 (PDT)
Message-ID: <725da8a4ca6a46ea8ba41778971602b49d650e60.camel@redhat.com>
Subject: Re: [PATCH] rtla: Simplify osnoise tracer option setting code
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, 
 Costa Shulyupin <costa.shul@redhat.com>, Wander Lairson Costa
 <wander@redhat.com>, LKML	 <linux-kernel@vger.kernel.org>,
 linux-trace-kernel	 <linux-trace-kernel@vger.kernel.org>
Date: Fri, 12 Jun 2026 12:54:59 -0500
In-Reply-To: <20260612115121.54862-1-tglozar@redhat.com>
References: <20260612115121.54862-1-tglozar@redhat.com>
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6ShruZlhvNgNIpEitLwFOV2_U8IwOj_Tm8O1M2a4jBM_1781286901
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-06-12 at 13:51 +0200, Tomas Glozar wrote:
> Each osnoise tracer option (in /sys/kernel/tracing/osnoise) used by RTLA
> requires four functions to be defined:
>=20
> - static osnoise_get_<opt>() - to get the current value of the option
>   and save it into struct osnoise_context's orig_<opt> field,
> - osnoise_set_<opt>() - to set the value of the option requested by the
>   user after reading and saving the original with osnoise_get_<opt>(),
>   and save it into <opt> field of struct osnoise_context,
> - osnoise_restore_<opt>() - restore the value recorded in orig_<opt>,
> - static osnoise_put_<opt>() - restore the value recorded in orig_<opt>
>   and update <opt> to reflect that.
>=20
> The logic is duplicated for all the options, except for cpus (which is
> the only string option) and period/runtime (which are handled together
> and feature extra checks).

Thanks for taking this on... this is one of the things that was bugging me
during consolidation work that I didn't get to.

> Deduplicate the logic using a set of macros featuring the X macro
> pattern, defined in src/common.h:
>=20
> - OSNOISE_LL_OPTIONS, which invokes OSNOISE_LL_OPTION macro for all
>   "long long" options,
> - OSNOISE_FLAG_OPTIONS, which invokes OSNOISE_FLAG_OPTION macro for all
>   flag (boolean values in osnoise/options file) options.
>=20
> The list macros are then invoked in four places:
>=20
> - for struct osnoise_context fields in src/common.h,
> - for function declarations, moved into src/common.h from
>   src/osnoise.h,
> - for function definitions in src/osnoise.c,
> - for context initialization and restoration, in osnoise_context_alloc()
>   and osnoise_put_context(), both in src/osnoise.c.
>=20
> OSNOISE_LL_OPTIONS takes three options: name - struct osnoise_context
> field name (written "<opt>" above), path - filename inside
> /sys/kernel/tracing/osnoise passed to libtracefs, and init_val - initial
> value of struct fields, corresponding to an otherwise invalid option
> (some options use OSNOISE_OPTION_INIT_VAL =3D -1, some use
> OSNOISE_TIME_INIT_VAL =3D 0).

Can we simplify by always using -1?  Especially since that's already
treated as the universal "invalid" by osnoise_read_ll_config().

FWIW using "init val" to mean "invalid" rather than "default" is a bit
unintuitive.

> OSNOISE_FLAG_OPTION is similar, but instead of path, it takes the option
> string inside /sys/kernel/tracing/osnoise/options (opt_string), and no
> init_val, as it is purely boolean (0 or 1).
>=20
> Previously, for options timerlat_align and osnoise_workload, the return
> value of osnoise_set_<opt>() distinguished between -2 (option cannot be
> set) and -1 (option not present). This distinction is expanded for all
> options for consistency; for most options, it is currently not used,
> only osnoise_workload is implemented to avoid error on -1 on older RTLA
> versions.

"on -1 on"?

> The change overall has two main benefits: it makes it much simpler to
> add a new option, as well as to change existing logic consistently for
> all of them. It also makes the code shorter by a bit over 500 lines.
>=20
> There is no intentional user-visible change coming from the refactoring.
> osnoise_restore_<opt>() for flag options now sets <opt> instead of
> orig_<opt>. As the latter is also set by osnoise_put_<opt>(), plus long
> long options set <opt> in both the old and new implementation, the old
> behavior was likely a mistake, and should not matter for now, as the
> options are only restored once at the end of tracing and neither <opt>
> nor orig_<opt> field is read again.
>=20
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/src/common.h  |  79 +--
>  tools/tracing/rtla/src/osnoise.c | 836 ++++++-------------------------
>  tools/tracing/rtla/src/osnoise.h |  22 -
>  3 files changed, 188 insertions(+), 749 deletions(-)

While we're at it, can we move this code to common.c, and drop
"osnoise" from the names, to move closer to using that only for the
actual osnoise mode?

Or if we really want to namespace things that are specific to the
osnoise subsystem (i.e. everything implemented in trace_osnoise.c) but
not specific with respect to the osnoise/timerlat split, I'd suggest
something different like "osn_".

> + * Long long option get/set/restore/put functions, generated from OSNOIS=
E_LL_OPTIONS.
> + */
> +#define OSNOISE_LL_OPTION(name, path, init_val)=09=09=09=09=09=09\
> +static long long=09=09=09=09=09=09=09=09=09\
> +osnoise_get_##name(struct osnoise_context *context)=09=09=09=09=09\
> +{=09=09=09=09=09=09=09=09=09=09=09\
> +=09long long name;=09=09=09=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09=09=09\
> +=09if (context->name !=3D (init_val))=09=09=09=09=09=09\
> +=09=09return context->name;=09=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09=09=09\
> +=09if (context->orig_##name !=3D (init_val))=09=09=09=09=09=09\
> +=09=09return context->orig_##name;=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09=09=09\
> +=09name =3D osnoise_read_ll_config(path);=09=09=09=09=09=09\
> +=09if (name < 0)=09=09=09=09=09=09=09=09=09\
> +=09=09return (init_val);=09=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09=09=09\
> +=09context->orig_##name =3D name;=09=09=09=09=09=09=09\
> +=09return name;=09=09=09=09=09=09=09=09=09\
> +}=09=09=09=09=09=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09=09=09\
> +int osnoise_set_##name(struct osnoise_context *context, long long name)=
=09=09=09\
> +{=09=09=09=09=09=09=09=09=09=09=09\
> +=09long long curr =3D osnoise_get_##name(context);=09=09=09=09=09\
> +=09int retval;=09=09=09=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09=09=09\
> +=09if (curr =3D=3D (init_val))=09=09=09=09=09=09=09=09\
> +=09=09return -1;=09=09=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09=09=09\
> +=09retval =3D osnoise_write_ll_config(path, name);=09=09=09=09=09\
> +=09if (retval < 0)=09=09=09=09=09=09=09=09=09\
> +=09=09return -2;=09=09=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09=09=09\
> +=09context->name =3D name;=09=09=09=09=09=09=09=09\
> +=09return 0;=09=09=09=09=09=09=09=09=09\
> +}=09=09=09=09=09=09=09=09=09=09=09\

Using "name" for the value is confusing... "val" would be better.

> +=09=09=09=09=09=09=09=09=09=09=09\
> +void osnoise_restore_##name(struct osnoise_context *context)=09=09=09=09=
\
> +{=09=09=09=09=09=09=09=09=09=09=09\
> +=09int retval;=09=09=09=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09=09=09\
> +=09if (context->orig_##name =3D=3D (init_val))=09=09=09=09=09=09\
> +=09=09return;=09=09=09=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09=09=09\
> +=09if (context->orig_##name =3D=3D context->name)=09=09=09=09=09\
> +=09=09goto out_done_##name;=09=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09=09=09\
> +=09retval =3D osnoise_write_ll_config(path, context->orig_##name);=09=09=
=09\
> +=09if (retval < 0)=09=09=09=09=09=09=09=09=09\
> +=09=09err_msg("Could not restore original " #name "\n");=09=09=09\
> +=09=09=09=09=09=09=09=09=09=09=09\
> +out_done_##name:=09=09=09=09=09=09=09=09=09\
> +=09context->name =3D (init_val);=09=09=09=09=09=09=09\
> +}=09=09=09=09=09=09=09=09=09=09=09\

Why does the label need to have ##name in it?

> +=09=09=09=09=09=09=09=09=09=09=09\
> +static void osnoise_put_##name(struct osnoise_context *context)=09=09=09=
=09\
> +{=09=09=09=09=09=09=09=09=09=09=09\
> +=09osnoise_restore_##name(context);=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09=09=09\
> +=09if (context->orig_##name =3D=3D (init_val))=09=09=09=09=09=09\
> +=09=09return;=09=09=09=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09=09=09\
> +=09context->orig_##name =3D (init_val);=09=09=09=09=09=09\
> +}
[snip]
> +/*
> + * Flag option get/set/restore/put functions, generated from OSNOISE_FLA=
G_OPTIONS.
> + */
> +#define OSNOISE_FLAG_OPTION(name, option_str)=09=09=09=09=09=09\
> +static int osnoise_get_##name(struct osnoise_context *context)=09=09=09=
=09\
> +{=09=09=09=09=09=09=09=09=09=09=09\
> +=09if (context->opt_##name !=3D OSNOISE_OPTION_INIT_VAL)=09=09=09=09\
> +=09=09return context->opt_##name;=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09=09=09\
> +=09if (context->orig_opt_##name !=3D OSNOISE_OPTION_INIT_VAL)=09=09=09\
> +=09=09return context->orig_opt_##name;=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09=09=09\
> +=09context->orig_opt_##name =3D osnoise_options_get_option(option_str);=
=09=09\
> +=09return context->orig_opt_##name;=09=09=09=09=09=09\
> +}=09=09=09=09=09=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09=09=09\
> +int osnoise_set_##name(struct osnoise_context *context, bool onoff)=09=
=09=09\
> +{=09=09=09=09=09=09=09=09=09=09=09\
> +=09int val =3D osnoise_get_##name(context);=09=09=09=09=09=09\
> +=09int retval;=09=09=09=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09=09=09\
> +=09if (val =3D=3D OSNOISE_OPTION_INIT_VAL)=09=09=09=09=09=09\
> +=09=09return -1;=09=09=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09=09=09\
> +=09if (val =3D=3D onoff)=09=09=09=09=09=09=09=09\
> +=09=09return 0;=09=09=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09=09=09\
> +=09retval =3D osnoise_options_set_option(option_str, onoff);=09=09=09=09=
\
> +=09if (retval < 0)=09=09=09=09=09=09=09=09=09\
> +=09=09return -2;=09=09=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09=09=09\
> +=09context->opt_##name =3D onoff;=09=09=09=09=09=09=09\
> +=09return 0;=09=09=09=09=09=09=09=09=09\
> +}=09=09=09=09=09=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09=09=09\
> +void osnoise_restore_##name(struct osnoise_context *context)=09=09=09=09=
\
> +{=09=09=09=09=09=09=09=09=09=09=09\
> +=09int retval;=09=09=09=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09=09=09\
> +=09if (context->orig_opt_##name =3D=3D OSNOISE_OPTION_INIT_VAL)=09=09=09=
\
> +=09=09return;=09=09=09=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09=09=09\
> +=09if (context->orig_opt_##name =3D=3D context->opt_##name)=09=09=09=09\
> +=09=09goto out_done_##name;=09=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09=09=09\
> +=09retval =3D osnoise_options_set_option(option_str, context->orig_opt_#=
#name);=09\
> +=09if (retval < 0)=09=09=09=09=09=09=09=09=09\
> +=09=09err_msg("Could not restore original " option_str " option\n");=09=
=09\
> +=09=09=09=09=09=09=09=09=09=09=09\
> +out_done_##name:=09=09=09=09=09=09=09=09=09\
> +=09context->opt_##name =3D OSNOISE_OPTION_INIT_VAL;=09=09=09=09=09\
> +}=09=09=09=09=09=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09=09=09\
> +static void osnoise_put_##name(struct osnoise_context *context)=09=09=09=
=09\
> +{=09=09=09=09=09=09=09=09=09=09=09\
> +=09osnoise_restore_##name(context);=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09=09=09\
> +=09if (context->orig_opt_##name =3D=3D OSNOISE_OPTION_INIT_VAL)=09=09=09=
\
> +=09=09return;=09=09=09=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09=09=09\
> +=09context->orig_opt_##name =3D OSNOISE_OPTION_INIT_VAL;=09=09=09=09\
> +}

Can we reduce the amount of code we put in macros by moving some of the
logic to osnoise_read/write_ll_config() and osnoise_get/set_optino()?=20
Or a non-macro wrapper around them if there are other callers that need
the current behavior.

Something like (assuming universal -1 invalid):

static int osn_read_ll_config(const char *rel_path, long long *val, long lo=
ng *orig)
static int osn_write_ll_config(const char *rel_path, long long *val, long l=
ong *orig)
static int osn_get_option(const char *name, int *val, int *orig)
static int osn_set_option(const char *name, int *val, int *orig)

-Crystal (who wishes we were using a modern language that didn't require al=
l
this macro stuff)


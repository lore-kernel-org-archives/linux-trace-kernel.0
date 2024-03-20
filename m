Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE85F110A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Mar 2024 00:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710894658; cv=none; b=bzsIIoBDSuXDrQbxaMO1DJnVxeytyUNtQ4H2Lort/BrjsGfpGogwrGSoy3Vfa1pAOw5WgqmXsGR5CBAfPWD/uyVjP8aqqGjXAS4KR+2Y4RvZXOylBmoWLJ+qxzXdxBV4AeDZwD+dUCPY+qkryN+gAhiXLfNAQxdhAASM5VO2KzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710894658; c=relaxed/simple;
	bh=w6xT7TQIIw629OsLA2mpj4+Cm8CL0j6xp7UsXUzQdAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GOv59ydKEhlm19SAgOMpDCzB01c9oxwivnN9wyZBZq2D/5pJqqix+HQd0paAGQdtgS6aTkutCaMsHD0xiV+tRywYdHa/KzR1Ic77yG8r4di5bzCXa3B26DuYOTcefSSLXJH4uLRhuOr+xpcua4HYZLW9spD9u8AhxQsqSvoV4PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tf93vdkt; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tf93vdkt"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56829f41f81so8543770a12.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Mar 2024 17:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710894654; x=1711499454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZl/MC6G04dgdXWq6n8Jo9rFZ4kdECi4eDf/v32uMoM=;
        b=tf93vdktKGXgvMi2OBANw36z3xAQA+ILE9EafUgsuib/q7vga3OOWWo2hGr6FyLB9Z
         o8gg7Na2jnjmB+TK4OukDIHEEk6CkwwR58z9ElI8cldehaLEYbQduWKyuiQWUhe8KsP5
         s+d56Pufm/MfbK1wSXLb9MxQngrTcXmb3LdMWwBCGILbIkwCE/++7+zcSrwn75g5aTCp
         KCHId80aBV0JBKBeT+htDQjFC5+ok6P/2wSmYYYuyI3EGExpxgxNzQXTIxelWNsrw/FI
         Ns9Klbtp9aFBW36HI4UyQaTdoI4ObKcte+AtM5XKJmohZt8jmw4hoJZg4v0vMZGwYCrP
         ZVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710894654; x=1711499454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZl/MC6G04dgdXWq6n8Jo9rFZ4kdECi4eDf/v32uMoM=;
        b=eZjnEaNicBB7v/mKGjGsB2x8we6TamwGJ3Fe76seAsJrqlwsst432aVVoBUDZdp5OA
         83RdWOFcZTKdJZ1CDVEyL4gYxQ03Ed1ox4D94wNEB3kpMFXqYZsVDQTIsRgq66sUQKEE
         DTYjy5gnufMUvbGkvRTMSK7oeYr9YH8MdUUTNMLjRfebpb0KwRyut3IwhQpkqZI4eFwc
         8rOq5dcdBrMOObO9Vd6jOVZKZLdzgsXgjW/T/zC8v1SyGT1V/siCcocwJWJX1goI0n+m
         dOItRdP3e5cmeTDSP9WYPli5IBoqv/m2NarhDyj7a6yvEEXGB6PgckZwSsH349/uk91k
         cZvw==
X-Forwarded-Encrypted: i=1; AJvYcCWC+ynTrKfQ4SAB1T5PbKA0f9fFSbfcn8xGhKxR2uV8Za+61l/lQs0o9DhB8DXWlQRUyAeGabVNXDb6vOmd9J91ZFLifRRm16Nd7crSrG9UN1NO
X-Gm-Message-State: AOJu0Yz0eZPbZswbCpujDtn7K7fUq4LMaLThGn8e1l9EE8WIV6doeDTd
	Ftajg6EfiR9cjW9y17EDtNu8jgZTn2GpvVrT9Qc9IERzMZRzBz5YuRZTSSB5knxn2Gjtw8x8ze2
	eW01hfuDLJB+4aLy9puKfLVvU2J1jqPjo61G1
X-Google-Smtp-Source: AGHT+IFVRbRtTK93+JswPYwn75sDfz6NqIQ9pLfPvYXf2GKGX5xRtCwHXsSI1NF/q7+RSh2ICglMKo8eb6X0v/DUYE8=
X-Received: by 2002:a05:6402:5d1:b0:566:b09e:80c4 with SMTP id
 n17-20020a05640205d100b00566b09e80c4mr242572edx.19.1710894654186; Tue, 19 Mar
 2024 17:30:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319-tracing-fully-silence-wstring-compare-v1-0-81adb44403f5@kernel.org>
 <20240319-tracing-fully-silence-wstring-compare-v1-2-81adb44403f5@kernel.org>
In-Reply-To: <20240319-tracing-fully-silence-wstring-compare-v1-2-81adb44403f5@kernel.org>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 19 Mar 2024 17:30:41 -0700
Message-ID: <CAFhGd8q_4QfjPwGhtfOA40ZGNF7_wf3V43rAvcb_qXQnz1TFOw@mail.gmail.com>
Subject: Re: [PATCH 2/2] tracing: Ignore -Wstring-compare with diagnostic macros
To: Nathan Chancellor <nathan@kernel.org>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	ndesaulniers@google.com, morbo@google.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	patches@lists.linux.dev, Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 9:08=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Commit b1afefa62ca9 ("tracing: Use strcmp() in __assign_str() WARN_ON()
> check") addressed a clang warning, -Wstring-compare, with the use of
> __builtin_constant_p() to dispatch to strcmp() if the source string is a
> string literal and a direct comparison if not. Unfortunately, even with
> this change, the warning is still present because __builtin_constant_p()
> is not evaluated at this stage of the pipeline, so clang still thinks
> the else branch could occur for this situation:
>
>   include/trace/events/sunrpc.h:705:4: error: result of comparison agains=
t a string literal is unspecified (use an explicit string comparison functi=
on instead) [-Werror,-Wstring-compare]
>   ...
>   include/trace/stages/stage6_event_callback.h:40:15: note: expanded from=
 macro '__assign_str'
>      40 |                              (src) !=3D __data_offsets.dst##_pt=
r_);       \
>         |                                    ^
>   ...
>
> Use the compiler diagnostic macros to disable this warning around the
> WARN_ON_ONCE() expression since a string comparison function, strcmp(),
> will always be used for the comparison of string literals.
>
> Fixes: b1afefa62ca9 ("tracing: Use strcmp() in __assign_str() WARN_ON() c=
heck")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/all/CA+G9fYs=3DOTKAZS6g1P1Ewadfr0qoe6LgOV=
SohqkXmFXotEODdg@mail.gmail.com/
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  include/trace/stages/stage6_event_callback.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace=
/stages/stage6_event_callback.h
> index 83da83a0c14f..56a4eea5a48e 100644
> --- a/include/trace/stages/stage6_event_callback.h
> +++ b/include/trace/stages/stage6_event_callback.h
> @@ -35,9 +35,14 @@
>         do {                                                            \
>                 char *__str__ =3D __get_str(dst);                        =
 \
>                 int __len__ =3D __get_dynamic_array_len(dst) - 1;        =
 \
> +               __diag_push();                                          \
> +               __diag_ignore(clang, 11, "-Wstring-compare",            \
> +                             "__builtin_constant_p() ensures strcmp()" \
> +                             "will be used for string literals");      \
>                 WARN_ON_ONCE(__builtin_constant_p(src) ?                \
>                              strcmp((src), __data_offsets.dst##_ptr_) : \
>                              (src) !=3D __data_offsets.dst##_ptr_);      =
 \

What exactly is the point of the literal string comparison? Why
doesn't strcmp do the trick?

> +               __diag_pop();                                           \
>                 memcpy(__str__, __data_offsets.dst##_ptr_ ? :           \
>                        EVENT_NULL_STR, __len__);                        \
>                 __str__[__len__] =3D '\0';                               =
 \
>
> --
> 2.44.0
>

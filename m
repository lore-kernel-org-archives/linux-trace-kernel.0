Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374B61925B3
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Nov 2024 08:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732005413; cv=none; b=rWHYVlC/LLLPm/F6BcbDY7SHPuNWpcp6HtDkDq0GNWsMt5798wipyM6kFzd+aqYWIgIRMJpIog41p4j7BU/mQ8U85F1a8omveV+dskX0j1T74qZFseGxcpSJFO0NToUL5C3Kwq3rFD0Tf9UHtTechZ4Jr9hit/HQiVOw5+8l/Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732005413; c=relaxed/simple;
	bh=+MTvleFySir8FtP2uB/UOknrMvhVUid7WSDjacUiN1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tPgEdkKJxZft/csYobSD3rBNUvhdaacqMxbgSt35cQGfXL+p3BUMH8DK09A68Qou8HK+KEQzQYM7CQwO0QcZiiCnH9kRl9yjAsOe/Ee8ktEbslJo8R8hUUvjfq//CdHaSEiNQkQpq1rn3kU3bzrFvUmdTeb400JsuaLu+fR0d04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y5rA1Uvr; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y5rA1Uvr"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4315df7b43fso5688475e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Nov 2024 00:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732005410; x=1732610210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDqTouV9BVPKs1qxw5HUNjIJ97gDgkRw2ACsRZndJJ0=;
        b=y5rA1Uvr1AY7MU3tjf1WQo0VPiTQ+CjFRmipu5fOD8lJYIyleWx6LUnEMvktHg+rlF
         2iCt5nBkLChXKuER/bVFKbY+lf0AYdw9fj6P3M4Gzk6ILoYRh3oBLqTPE6IUfQI89OHe
         m6UPH6CRxUUCzr4hnxz9sidGWEJaf2xiIGAXoI8gYAgKrdg0uqD3TVA6U1NIh7U843LY
         72CVX9MwEH/9c/jsqXb/Vd5cVp1uv1bwHah03BvYuduH2VkQhaUwWorewihdkN+Fl8mF
         dhIvEcl8kbGb1UUbcxE3s7dQunLfgi/cDetQJBwFU+WuEf6IhZI/X+0dO3neLrqfPh3E
         hiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732005410; x=1732610210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDqTouV9BVPKs1qxw5HUNjIJ97gDgkRw2ACsRZndJJ0=;
        b=AgnSLbANYEL0TjGMxwPN39LjWt6sBNrXb74H9AqCcFAH/HR78gQAX1aRZYmsy5B0Kr
         2klgvkbKqHqoPkRDUJwxacdc2sicsfPn5Kg29qF7apNXpAZ557KcBF/J0F/YWCJX90ux
         R7IymRuLojStViutXpebnhR/cCidqYMbgrMOYJBMrzfDP+slrf/MY62HV89Ak3D7c5mu
         cUahz0l9A43WFy0G3hQB4Why9IJ+1QZq4ydCkguwrZzPVDsL/g0BO7y1X/876HJ1x5fR
         2/iz319c2cLhMBTJ72KSq8jHg6WD0DuMY/gLYPWv/Jdp+bLFrG9XL2r0JVM1TbyCOl0Y
         mnlw==
X-Forwarded-Encrypted: i=1; AJvYcCWcbcUhPDkpgxnjrYd1gK/ESL5zZ8n853zYH6T/vNVRhiqTNP3MdeZj9bpxGKQO9fzhA1oWAQ5HHWu2zFMGco5nwMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHRkfqeu6Czo40F85AC0bZtzn/0fL5hwbP/wPUTmnUZ9zFouU4
	LxzAI+yThGTOgCaH8Wh0X0n5j1C+mJcM6mohdDL3Zs4jf9gU8blxcLeiskqc6Ajd6vo95gJOPJM
	qbPI3YV9nQ1JtCirR7Id5Bh08v2wovXy2wd8J
X-Google-Smtp-Source: AGHT+IFn12obJ8XL6amrk2N2Qj1d2LRmnwgIFMT7b3jmYMIY7gdAA1MtHRCcurUYNkF/oO5FeyBfxH420CYhnypZ3DA=
X-Received: by 2002:a05:600c:444f:b0:42c:b905:2bf9 with SMTP id
 5b1f17b1804b1-432df74eb09mr147079455e9.16.1732005410440; Tue, 19 Nov 2024
 00:36:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202411181440.qEdcuyh6-lkp@intel.com> <20241118202727.73646-1-aliceryhl@google.com>
 <20241118182818.7717993c@gandalf.local.home>
In-Reply-To: <20241118182818.7717993c@gandalf.local.home>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 19 Nov 2024 09:36:38 +0100
Message-ID: <CAH5fLgjBpz7bPvanupPSsJx3fjLAa7g7nMjLgSxjEde_KDGV2w@mail.gmail.com>
Subject: Re: [PATCH RESEND] jump_label: rust: pass a mut ptr to `static_key_count`
To: Steven Rostedt <rostedt@goodmis.org>
Cc: lkp@intel.com, boqun.feng@gmail.com, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, ojeda@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 12:27=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Mon, 18 Nov 2024 20:27:26 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
>
> > When building the rust_print sample with CONFIG_JUMP_LABEL=3Dn, the Rus=
t
> > static key support falls back to using static_key_count. This function
> > accepts a mutable pointer to the `struct static_key`, but the Rust
> > abstractions are incorrectly passing a const pointer.
> >
> > This means that builds using CONFIG_JUMP_LABEL=3Dn and SAMPLE_RUST_PRIN=
T=3Dy
> > fail with the following error message:
> >
> >       error[E0308]: mismatched types
> >         --> <root>/samples/rust/rust_print_main.rs:87:5
> >          |
> >       87 | /     kernel::declare_trace! {
> >       88 | |         /// # Safety
> >       89 | |         ///
> >       90 | |         /// Always safe to call.
> >       91 | |         unsafe fn rust_sample_loaded(magic: c_int);
> >       92 | |     }
> >          | |     ^
> >          | |     |
> >          | |_____types differ in mutability
> >          |       arguments to this function are incorrect
> >          |
> >          =3D note: expected raw pointer `*mut kernel::bindings::static_=
key`
> >                     found raw pointer `*const kernel::bindings::static_=
key`
> >       note: function defined here
> >         --> <root>/rust/bindings/bindings_helpers_generated.rs:33:12
> >          |
> >       33 |     pub fn static_key_count(key: *mut static_key) -> c_int;
> >          |            ^^^^^^^^^^^^^^^^
> >
> > To fix this, insert a pointer cast so that the pointer is mutable.
>
> Hi Alice,
>
> BTW, how do you test the sample tracepoint? I see you add a tracepoint in
> the module load call, but currently we can enable module tracepoints on
> module load. How do you enable it when the rust_print module gets loaded?

I've only really used the sample in this series as a build test. The
bulk of my testing has occurred by using this tracepoint support in
Rust Binder where I have 30 different tracepoints and I've been able
to verify that I can enable them and so on there.

Alice

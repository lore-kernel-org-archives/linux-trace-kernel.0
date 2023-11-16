Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JNMw6s5r"
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19B11AD
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:21:08 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-67089696545so3084376d6.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700126468; x=1700731268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hL39H6t6bxsTD+ztOctS1932vRb+QRkl89FhLK7eO2w=;
        b=JNMw6s5rSK6aDd8SMSh4RhDcGyigZuz9BGcs5euMtWaKZYpBFWJD9J0ev1egp29pKe
         SGQF5rg70UdOFExlx88rrV7MABEQ3bFyUCPIhHFKgQGkNL07/jlovj4Px5uPZQK0Ju7m
         eNg3uxTFz7+N/FblKvu9aosTHZYKPhbPmq4hFlqNJaEwXpAwHmkuu1qCWV3U0KVsz+cx
         7TdMAa7e0gQRsSynqYYqmu44P0RpwxqDJBfh1lLb6HPRD9a7olrhNg8XYy1ap7JFnRjf
         GB5FIL0RiQMtZ+cZqBnerjQHNWQOkZGAcP25SZbHD6RF3nkI6RG/FtSyTBQ9EqP1f1S0
         gK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700126468; x=1700731268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hL39H6t6bxsTD+ztOctS1932vRb+QRkl89FhLK7eO2w=;
        b=T8RIul5cAp+Uj/cbuKqeimbEXzKdFCbN85uH9pAUwC+OUGCrjyHOZ+Mw7whAqfyvGn
         8w+ToNBdBS+iNiPYNWMUp36Rmvfhe9I9RRnyUmAeJcqJ991vn1ogkF4jdWxNz961e8Km
         kWE/uxPGw4BXliOJyCDI/h5ueH3/b0oPwULMTpqYWIJdZ/K6hQhz4a5+N3HrpO8EfZdz
         eJ8SJOftc+EVSc/mUhgQ3bPKiPqEECxiq9aQJsaK14jEmDxTmRSnH0eljso1oubhSRxv
         Ytr52LCi0NAJedwHJzsz0KyWCQz1okcSLLS8nqQIaUBLlFbVaxpsKV6NIwBBqyHAbvqJ
         fiAg==
X-Gm-Message-State: AOJu0YznX7DYpof0kOvNSWqXxelL5s0H64tx2AhmBU8VYyXIfceQJFMz
	ySF2nlMNZljyO1SA2UFFFf+inMJzFyz5cf0BT6mY3w==
X-Google-Smtp-Source: AGHT+IHC6nwGkpF/PSyV/svhCqIi/GYkWrnJGNLPzykP9GcOVpjYZIb5GpU44Ibf43ZB0BLs7Gg4kVobl5xh6hb3jWM=
X-Received: by 2002:ad4:5cc6:0:b0:66d:15de:329c with SMTP id
 iu6-20020ad45cc6000000b0066d15de329cmr11619912qvb.43.1700126467765; Thu, 16
 Nov 2023 01:21:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com> <20231115203401.2495875-21-iii@linux.ibm.com>
In-Reply-To: <20231115203401.2495875-21-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 16 Nov 2023 10:20:31 +0100
Message-ID: <CAG_fn=UhFURUGqFXCrWym98PLzSR9oYfVDFvLpoaRO91_CMenw@mail.gmail.com>
Subject: Re: [PATCH 20/32] s390: Turn off KMSAN for boot, vdso and purgatory
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	Marco Elver <elver@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Pekka Enberg <penberg@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Vasily Gorbik <gor@linux.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 9:34=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> All other sanitizers are disabled for these components as well.
>
> Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
(see a nit below)

> ---
>  arch/s390/boot/Makefile          | 1 +
>  arch/s390/kernel/vdso32/Makefile | 1 +
>  arch/s390/kernel/vdso64/Makefile | 1 +
>  arch/s390/purgatory/Makefile     | 1 +
>  4 files changed, 4 insertions(+)
>
> diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
> index c7c81e5f9218..5a05c927f703 100644
> --- a/arch/s390/boot/Makefile
> +++ b/arch/s390/boot/Makefile
> @@ -8,6 +8,7 @@ GCOV_PROFILE :=3D n
>  UBSAN_SANITIZE :=3D n
>  KASAN_SANITIZE :=3D n
>  KCSAN_SANITIZE :=3D n
> +KMSAN_SANITIZE :=3D n

Nit: I think having even a one-line comment before this block
(something similar to
https://elixir.bootlin.com/linux/latest/source/arch/x86/boot/Makefile#L12)
will make it more clear.

But given that the comment wasn't there before, leaving this up to you.

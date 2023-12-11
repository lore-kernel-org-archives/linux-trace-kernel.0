Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nHMFiq70"
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5D1E3
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:57:17 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7cb0ab68c12so294804241.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702335436; x=1702940236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkXKnEfT8eKc5Yh5rOydAPt9sQ7NUY597Q2G+9UH8MI=;
        b=nHMFiq70nH5mhzLtP1Lg5xRDXJdj8MglQpkFewHaDlhsCVDjZW3EGwawPjyn2ENZ7r
         7o5QnJjgCU8dfJ7d2S3sxraSgUf4HLnOHSMj/GoIt7fv2lQtA1dSPfRazZCRIE4yN7Zu
         nHJ1TWw5OAmotxPlNKfrpYdUQhh+OmmjJi0axSQBCvViCC5d2aK65FNKkjyXjRS3ihBu
         LlF1p5xEPMyPPj4siicZAE5dHwePCQ0E/O9v0zEVdut3srmAqFlUFL9RAAaMT9CV01dw
         VaMC4oXmgGP7pgzZZMLMNGoh98UZ2NDVeQ1ICIjrBkvRWnVjWArAFJ5pMFpELhQzNF+f
         B+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702335436; x=1702940236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VkXKnEfT8eKc5Yh5rOydAPt9sQ7NUY597Q2G+9UH8MI=;
        b=TTOP98o23soQEux4ZyQkTyXiHoBKNiGz77f55Jzflpd9Kf5u/LWA7ypDpPD0kyDkMO
         sZsnndfhcx1pnJ79trfMnobKwTNTf5f6PpBuOQfUE0GMu4hgtQbIBhb/upTpQuMoyuk/
         2JJ6gogGytI5Pm/vDRX8ZwxuOGfmmB5INky+0Y8PtETD6+J1UfkGGruvTWh+n/zBq2J/
         MDHpRYUGleuCQyapXkrVKCPCidiEoDdQEmcZJNjXWkpvv0vVhmZS2Hvf/syJmbDRspVS
         xZNrkokAFCCRZ928adevHCpip/QsudFtM1ZgV1lc47qlHne5TkAX8EuhyeVYcpFqx/l9
         B/6g==
X-Gm-Message-State: AOJu0Ywa/AfHRJ4wkunS5nIpGq2JiqnznSaXK6Rl3iPmcy8eo/MbeGQJ
	hytvq4/4TFdwokeCC/WoXx89aSXn4eQfrT1ahD8u3Q==
X-Google-Smtp-Source: AGHT+IE2xtn4pdHDL5Lsao1xivD+gQkdLWb1Ukglk33Rvsu/8sJpEoK/GIG0VTF0ZL+Ihg0qHAqGLharR2cgxinzA7Q=
X-Received: by 2002:a05:6102:38cd:b0:464:811a:9ef9 with SMTP id
 k13-20020a05610238cd00b00464811a9ef9mr3502893vst.17.1702335436511; Mon, 11
 Dec 2023 14:57:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMn1gO6reT+MTmogLOrOVoNqzLH+fKmQ2JRAGy-tDOTLx-fpyw@mail.gmail.com>
 <CANpmjNN7Gf_aeX+Y6g0UBL-cmTGEF9zgE7hQ1VK8F+0Yeg5Rvg@mail.gmail.com>
 <20230215143306.2d563215@rorschach.local.home> <CAMn1gO4_+-0x4ibpcASy4bLeZ+7rsmjx=0AYKGVDUApUbanSrQ@mail.gmail.com>
 <CAMn1gO6heXaovFy6jvpWS8TFLBhTomqNuxJmt_chrd5sYtskvw@mail.gmail.com>
 <20230505095805.759153de@gandalf.local.home> <n37j6cbsogluma25crzruaiq7qcslnjeoroyybsy3vw2cokpcm@mh7r3ocp24cb>
 <CA+fCnZebmy-fZdNonrgLofepTPL5hU6P8R37==sygTLBSRoa+w@mail.gmail.com>
 <fv7fn3jivqcgw7mum6zadfcy2fbn73lygtxyy5p3zqpelfiken@5bmhbdufxgez>
 <CA+fCnZfQEueCifc-8d5NVWEUtAiOG1eRW-LFKbOhab_Y7jqU0Q@mail.gmail.com> <osqmp2j6gsmgbkle6mwhoaf65mjn4a4w3e5hsfbyob6f44wcg6@7rihb5otzl2z>
In-Reply-To: <osqmp2j6gsmgbkle6mwhoaf65mjn4a4w3e5hsfbyob6f44wcg6@7rihb5otzl2z>
From: Marco Elver <elver@google.com>
Date: Mon, 11 Dec 2023 23:56:37 +0100
Message-ID: <CANpmjNMw3N09x06Q+0mFCEeTKfUsDdXwXM2hdgAQ+wwbZGpB9w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] kasan: switch kunit tests to console tracepoints
To: =?UTF-8?Q?Paul_Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Peter Collingbourne <pcc@google.com>, andrey.konovalov@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrey Konovalov <andreyknvl@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Dec 2023 at 23:48, Paul Heidekr=C3=BCger <paul.heidekrueger@tum.=
de> wrote:
>
> On 11.12.2023 21:51, Andrey Konovalov wrote:
> > On Mon, Dec 11, 2023 at 7:59=E2=80=AFPM Paul Heidekr=C3=BCger
> > <paul.heidekrueger@tum.de> wrote:
> > >
> > > > Hi Paul,
> > > >
> > > > I've been successfully running KASAN tests with CONFIG_TRACEPOINTS
> > > > enabled on arm64 since this patch landed.
> > >
> > > Interesting ...
> > >
> > > > What happens when you try running the tests with .kunitconfig? Does
> > > > CONFIG_TRACEPOINTS or CONFIG_KASAN_KUNIT_TEST get disabled during
> > > > kernel building?
> > >
> > > Yes, exactly, that's what's happening.
> > >
> > > Here's the output kunit.py is giving me. I replaced CONFIG_DEBUG_KERN=
EL with
> > > CONFIG_TRACEPOINTS in my .kunitconfig. Otherwise, it's identical with=
 the one I
> > > posted above.
> > >
> > >         =E2=9E=9C   ./tools/testing/kunit/kunit.py run --kunitconfig=
=3Dmm/kasan/.kunitconfig --arch=3Darm64
> > >         Configuring KUnit Kernel ...
> > >         Regenerating .config ...
> > >         Populating config with:
> > >         $ make ARCH=3Darm64 O=3D.kunit olddefconfig
> > >         ERROR:root:Not all Kconfig options selected in kunitconfig we=
re in the generated .config.
> > >         This is probably due to unsatisfied dependencies.
> > >         Missing: CONFIG_KASAN_KUNIT_TEST=3Dy, CONFIG_TRACEPOINTS=3Dy
> > >
> > > Does CONFIG_TRACEPOINTS have some dependency I'm not seeing? I couldn=
't find a
> > > reason why it would get disabled, but I could definitely be wrong.
> >
> > Does your .kunitconfig include CONFIG_TRACEPOINTS=3Dy? I don't see it i=
n
> > the listing that you sent earlier.
>
> Yes. For the kunit.py output from my previous email, I replaced
> CONFIG_DEBUG_KERNEL=3Dy with CONFIG_TRACEPOINTS=3Dy. So, the .kunitconfig=
 I used to
> produce the output above was:
>
>         CONFIG_KUNIT=3Dy
>         CONFIG_KUNIT_ALL_TESTS=3Dn
>         CONFIG_TRACEPOINTS=3Dy
>         CONFIG_KASAN=3Dy
>         CONFIG_KASAN_GENERIC=3Dy
>         CONFIG_KASAN_KUNIT_TEST=3Dy
>
> This more or less mirrors what mm/kfence/.kunitconfig is doing, which als=
o isn't
> working on my side; kunit.py reports the same error.

mm/kfence/.kunitconfig does CONFIG_FTRACE=3Dy. TRACEPOINTS is not user
selectable. I don't think any of this has changed since the initial
discussion above, so CONFIG_FTRACE=3Dy is still needed.

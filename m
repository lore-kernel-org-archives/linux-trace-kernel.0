Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hAJRmqbg"
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFD9DC
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:33:25 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-466006f9fa5so1358245137.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702373604; x=1702978404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gsXSrEFfFqnsLGyUGm1rzVcPU2A/TTzMQTc9kn2e+Kg=;
        b=hAJRmqbgvB1yiyOfMJQD25YEoOysf9qd1fttPhesh1en8fETL0cQati5rnqGg6xQs5
         A/H4Th/bWbblRgZ+K7BuPuv4I3WAl8aeK4HVKaATPpIJe2Py+nTv/SvcCJv7lm70EI/n
         oGKE+1dGKV1xeHZ0detzlHtPA5IZnGOhCG1eb+bRMYMyu9C7ho9DlkUSA6zwp5GT5IRS
         RxpaRfajrApvhZF+oVNX4vVN1Op29Zk6oqYfF8K8AvYrVwXtd59DEQdfjP+EzylTBzwq
         skSj/OJCIRLkWyYhLG5GQjL0DYa4EDOvaJoTqZiV3WpS4sqFoCqEGQodEWRVLmddmpm3
         bZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702373604; x=1702978404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsXSrEFfFqnsLGyUGm1rzVcPU2A/TTzMQTc9kn2e+Kg=;
        b=fpiWJzXqIUNV7/ZFO9BcSzPeFaX1YhRMVB+ZzOhjN2QrtFeSXWu+OjrogMiEYH+MKS
         XuYJGFMlmkruLMcq135DxQJY0PVABhTzNSlbEmbiWIvLUvgqWP6ouGJ47kpR0bOfZ9Ij
         l+ffJZZvOfrvEiVeDfDur4p2klRB9xjDihItgmhNCgD5JOzY/31WAnoLmYzD7TOgk5Xk
         5tUpcC/KNnbnZbn4BZNSun8+sK0/peyImFW8FeOZoe7lXGGQKYP/wtWXsciSNOeRySiT
         MTm5yMvzsB5ODw2zUSxt+1/OFcHSkYon7um+RQMbHvgGKAEWJZLFiHToAk/WlneQL3qu
         Mrqg==
X-Gm-Message-State: AOJu0YxO5sp5/UF1mvK7Ao9PYzcUWByV25sDIt/a7/LUUlU3vDmJtLlf
	DnAdzdOBQQr9DpO0P2hMR0I/9YxajhUT615WYVEraQ==
X-Google-Smtp-Source: AGHT+IHlXf7ufoX8iXosJ2Nva+E8Qq+/po5/QAYPJ2Cb40hg+ICo+pQLEugoyr6S8RABxkMFeoJMyIrjbdahPjoIXoc=
X-Received: by 2002:a05:6102:e13:b0:464:6008:72cf with SMTP id
 o19-20020a0561020e1300b00464600872cfmr4421711vst.20.1702373603951; Tue, 12
 Dec 2023 01:33:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMn1gO6heXaovFy6jvpWS8TFLBhTomqNuxJmt_chrd5sYtskvw@mail.gmail.com>
 <20230505095805.759153de@gandalf.local.home> <n37j6cbsogluma25crzruaiq7qcslnjeoroyybsy3vw2cokpcm@mh7r3ocp24cb>
 <CA+fCnZebmy-fZdNonrgLofepTPL5hU6P8R37==sygTLBSRoa+w@mail.gmail.com>
 <fv7fn3jivqcgw7mum6zadfcy2fbn73lygtxyy5p3zqpelfiken@5bmhbdufxgez>
 <CA+fCnZfQEueCifc-8d5NVWEUtAiOG1eRW-LFKbOhab_Y7jqU0Q@mail.gmail.com>
 <osqmp2j6gsmgbkle6mwhoaf65mjn4a4w3e5hsfbyob6f44wcg6@7rihb5otzl2z>
 <CANpmjNMw3N09x06Q+0mFCEeTKfUsDdXwXM2hdgAQ+wwbZGpB9w@mail.gmail.com>
 <rbcdbilhh67fvjdgnstu25v4jnfeesthoxstnzzglynbngu5bk@5ozwgzaulbsx>
 <CA+fCnZf5kxWUWCzK8EKgUuq_E2rYv5aw=SqZMDb93+=7vSUp+w@mail.gmail.com> <rgndtm3sawyzdh76oofoqp22jyqdb25sd4326k2heevjmxum7f@wfgwvdf4iuyi>
In-Reply-To: <rgndtm3sawyzdh76oofoqp22jyqdb25sd4326k2heevjmxum7f@wfgwvdf4iuyi>
From: Marco Elver <elver@google.com>
Date: Tue, 12 Dec 2023 10:32:45 +0100
Message-ID: <CANpmjNN5Q+byA3sWv1uB_R=QYQxKg5YsLKayqv7WNWokkL5H4Q@mail.gmail.com>
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

On Tue, 12 Dec 2023 at 10:19, Paul Heidekr=C3=BCger <paul.heidekrueger@tum.=
de> wrote:
>
> On 12.12.2023 00:37, Andrey Konovalov wrote:
> > On Tue, Dec 12, 2023 at 12:35=E2=80=AFAM Paul Heidekr=C3=BCger
> > <paul.heidekrueger@tum.de> wrote:
> > >
> > > Using CONFIG_FTRACE=3Dy instead of CONFIG_TRACEPOINTS=3Dy produces th=
e same error
> > > for me.
> > >
> > > So
> > >
> > >         CONFIG_KUNIT=3Dy
> > >         CONFIG_KUNIT_ALL_TESTS=3Dn
> > >         CONFIG_FTRACE=3Dy
> > >         CONFIG_KASAN=3Dy
> > >         CONFIG_KASAN_GENERIC=3Dy
> > >         CONFIG_KASAN_KUNIT_TEST=3Dy
> > >
> > > produces
> > >
> > >         =E2=9E=9C   ./tools/testing/kunit/kunit.py run --kunitconfig=
=3Dmm/kasan/.kunitconfig --arch=3Darm64
> > >         Configuring KUnit Kernel ...
> > >         Regenerating .config ...
> > >         Populating config with:
> > >         $ make ARCH=3Darm64 O=3D.kunit olddefconfig CC=3Dclang
> > >         ERROR:root:Not all Kconfig options selected in kunitconfig we=
re in the generated .config.
> > >         This is probably due to unsatisfied dependencies.
> > >         Missing: CONFIG_KASAN_KUNIT_TEST=3Dy
> > >
> > > By that error message, CONFIG_FTRACE appears to be present in the gen=
erated
> > > config, but CONFIG_KASAN_KUNIT_TEST still isn't. Presumably,
> > > CONFIG_KASAN_KUNIT_TEST is missing because of an unsatisfied dependen=
cy, which
> > > must be CONFIG_TRACEPOINTS, unless I'm missing something ...
> > >
> > > If I just generate an arm64 defconfig and select CONFIG_FTRACE=3Dy,
> > > CONFIG_TRACEPOINTS=3Dy shows up in my .config. So, maybe this is kuni=
t.py-related
> > > then?
> > >
> > > Andrey, you said that the tests have been working for you; are you ru=
nning them
> > > with kunit.py?
> >
> > No, I just run the kernel built with a config file that I put together
> > based on defconfig.
>
> Ah. I believe I've figured it out.
>
> When I add CONFIG_STACK_TRACER=3Dy in addition to CONFIG_FTRACE=3Dy, it w=
orks.

CONFIG_FTRACE should be enough - maybe also check x86 vs. arm64 to debug mo=
re.

> CONFIG_STACK_TRACER selects CONFIG_FUNCTION_TRACER, CONFIG_FUNCTION_TRACE=
R
> selects CONFIG_GENERIC_TRACER, CONFIG_GENERIC_TRACER selects CONFIG_TRACI=
NG, and
> CONFIG_TRACING selects CONFIG_TRACEPOINTS.
>
> CONFIG_BLK_DEV_IO_TRACE=3Dy also works instead of CONFIG_STACK_TRACER=3Dy=
, as it
> directly selects CONFIG_TRACEPOINTS.
>
> CONFIG_FTRACE=3Dy on its own does not appear suffice for kunit.py on arm6=
4.

When you build manually with just CONFIG_FTRACE, is CONFIG_TRACEPOINTS enab=
led?

> I believe the reason my .kunitconfig as well as the existing
> mm/kfence/.kunitconfig work on X86 is because CONFIG_TRACEPOINTS=3Dy is p=
resent in
> an X86 defconfig.
>
> Does this make sense?
>
> Would you welcome a patch addressing this for the existing
> mm/kfence/.kunitconfig?
>
> I would also like to submit a patch for an mm/kasan/.kunitconfig. Do you =
think
> that would be helpful too?
>
> FWICT, kernel/kcsan/.kunitconfig might also be affected since
> CONFIG_KCSAN_KUNIT_TEST also depends on CONFIG_TRACEPOITNS, but I would h=
ave to
> test that. That could be a third patch.

I'd support figuring out the minimal config (CONFIG_FTRACE or
something else?) that satisfies the TRACEPOINTS dependency. I always
thought CONFIG_FTRACE ought to be the one config option, but maybe
something changed.

Also maybe one of the tracing maintainers can help untangle what's
going on here.

Thanks,
-- Marco

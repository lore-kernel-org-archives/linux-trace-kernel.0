Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5YuCn/y"
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1EFCB;
	Mon, 11 Dec 2023 15:37:43 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6d9d307a732so3838374a34.1;
        Mon, 11 Dec 2023 15:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702337862; x=1702942662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t86WZt4ENI/hv5N6g/BMDwtkCseB1St9FbZ8iMLj7J0=;
        b=g5YuCn/ydonCSaXaRgFIV42YSQRysQ0PSOiP8ZafYb8Id5Z8uOWNxFhQcbsjpNtPna
         y7w6NS4CsJ6Ah1WMIga8s9uZCeH/+HuWx+RTD+pw8sG2Jh6tPximIOuA+w2z8gAerOJH
         JFERr0dih3b270JWS8d2ZjvRo7UiB/OfCRy0zYXL9AP6zCpPV0xG/ogIthJUGpQpKuyP
         QXhEoI9j+b/HaUbdeqNvyuYN5Q7cBErWZvUR7Omam2uh5w6xh/2xdqTI0dHIRYG+UOV9
         fCgJFYdtsA3wVWsFILBgdyPR//wcvNGEe+VsSaiaozqKBJ5To3IWbe+RTQAWRd9mKEYu
         8USw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702337862; x=1702942662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t86WZt4ENI/hv5N6g/BMDwtkCseB1St9FbZ8iMLj7J0=;
        b=G1C9IR0wbjBipMQTpmi2f72T4qXhnxegABnnUn/O9eNl9/xhHsonGx7C31wkloWZaz
         hEfTH3dM6wNJl12xt/34IJh03jniFzF+7vQCZjeJqMC1pp1YZLhRdt9SUJC4gQ2iEdxz
         1ZIaProYmdIH0QD3bsQsCCGEmew+xjPQ/GnMN4b6Zj5KemZL4fL1Hv43kBjKWTQlV89H
         5W/my7NlLOstB8xlcvOoO1bX+6QLx1GMO+pj+lJVO+D1gzEChw73AOByayXQX38Z1Rgm
         paj6R2FKNgxEK8ThXll88qm18e/iByoARhHyGx+LcFwA5VX/wRUElICA2EKUhDNdw1pg
         HC1w==
X-Gm-Message-State: AOJu0Yxzqvt9Vl/h8IQit54cUs/sJDm9/wjpOMO84C45i2Z0Em+xCN+G
	igQnElrLGFTzjJxDUjRXzJswynucw8Ymird0WB4=
X-Google-Smtp-Source: AGHT+IG4FfgKtfsGPWYbi9QAB1q+LRDEA87I2H5e0e/b7szIlVMYT/arqkZQIO5Lc9PGgI8WXY5FUBR6yaCN2BqAZ4s=
X-Received: by 2002:a05:6358:c304:b0:170:3f9f:b367 with SMTP id
 fk4-20020a056358c30400b001703f9fb367mr4811270rwb.26.1702337862479; Mon, 11
 Dec 2023 15:37:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230215143306.2d563215@rorschach.local.home> <CAMn1gO4_+-0x4ibpcASy4bLeZ+7rsmjx=0AYKGVDUApUbanSrQ@mail.gmail.com>
 <CAMn1gO6heXaovFy6jvpWS8TFLBhTomqNuxJmt_chrd5sYtskvw@mail.gmail.com>
 <20230505095805.759153de@gandalf.local.home> <n37j6cbsogluma25crzruaiq7qcslnjeoroyybsy3vw2cokpcm@mh7r3ocp24cb>
 <CA+fCnZebmy-fZdNonrgLofepTPL5hU6P8R37==sygTLBSRoa+w@mail.gmail.com>
 <fv7fn3jivqcgw7mum6zadfcy2fbn73lygtxyy5p3zqpelfiken@5bmhbdufxgez>
 <CA+fCnZfQEueCifc-8d5NVWEUtAiOG1eRW-LFKbOhab_Y7jqU0Q@mail.gmail.com>
 <osqmp2j6gsmgbkle6mwhoaf65mjn4a4w3e5hsfbyob6f44wcg6@7rihb5otzl2z>
 <CANpmjNMw3N09x06Q+0mFCEeTKfUsDdXwXM2hdgAQ+wwbZGpB9w@mail.gmail.com> <rbcdbilhh67fvjdgnstu25v4jnfeesthoxstnzzglynbngu5bk@5ozwgzaulbsx>
In-Reply-To: <rbcdbilhh67fvjdgnstu25v4jnfeesthoxstnzzglynbngu5bk@5ozwgzaulbsx>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 12 Dec 2023 00:37:31 +0100
Message-ID: <CA+fCnZf5kxWUWCzK8EKgUuq_E2rYv5aw=SqZMDb93+=7vSUp+w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] kasan: switch kunit tests to console tracepoints
To: =?UTF-8?Q?Paul_Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>
Cc: Marco Elver <elver@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Peter Collingbourne <pcc@google.com>, andrey.konovalov@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrey Konovalov <andreyknvl@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 12:35=E2=80=AFAM Paul Heidekr=C3=BCger
<paul.heidekrueger@tum.de> wrote:
>
> Using CONFIG_FTRACE=3Dy instead of CONFIG_TRACEPOINTS=3Dy produces the sa=
me error
> for me.
>
> So
>
>         CONFIG_KUNIT=3Dy
>         CONFIG_KUNIT_ALL_TESTS=3Dn
>         CONFIG_FTRACE=3Dy
>         CONFIG_KASAN=3Dy
>         CONFIG_KASAN_GENERIC=3Dy
>         CONFIG_KASAN_KUNIT_TEST=3Dy
>
> produces
>
>         =E2=9E=9C   ./tools/testing/kunit/kunit.py run --kunitconfig=3Dmm=
/kasan/.kunitconfig --arch=3Darm64
>         Configuring KUnit Kernel ...
>         Regenerating .config ...
>         Populating config with:
>         $ make ARCH=3Darm64 O=3D.kunit olddefconfig CC=3Dclang
>         ERROR:root:Not all Kconfig options selected in kunitconfig were i=
n the generated .config.
>         This is probably due to unsatisfied dependencies.
>         Missing: CONFIG_KASAN_KUNIT_TEST=3Dy
>
> By that error message, CONFIG_FTRACE appears to be present in the generat=
ed
> config, but CONFIG_KASAN_KUNIT_TEST still isn't. Presumably,
> CONFIG_KASAN_KUNIT_TEST is missing because of an unsatisfied dependency, =
which
> must be CONFIG_TRACEPOINTS, unless I'm missing something ...
>
> If I just generate an arm64 defconfig and select CONFIG_FTRACE=3Dy,
> CONFIG_TRACEPOINTS=3Dy shows up in my .config. So, maybe this is kunit.py=
-related
> then?
>
> Andrey, you said that the tests have been working for you; are you runnin=
g them
> with kunit.py?

No, I just run the kernel built with a config file that I put together
based on defconfig.

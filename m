Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oWrSP1Il"
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61C41BD
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:05:51 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a8ee23f043so5884747b3.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Nov 2023 01:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700125551; x=1700730351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJvcy5OQThQMBzLC/CmhcyXSfL+uAyptQQ2e5phxAM4=;
        b=oWrSP1IlUTG1W8C2Vn3MDQRkcOkQC47jhTsbJE/syle+x2E7pLk8YH73UqsmtyCF5X
         wjMY1VnB609yWCdmQTbYSx6hEvgz9PlngiYT2pBwgpQSS1+4lNcph9dOwAmspD512EoA
         DyHUWd9wOherKtEvRiHolu3BRIZ9y9+IRZIIiP2S57xykxHFJkkVZyhOesC0+tL4jxIN
         7wgNrnGeECevzbZc3Us2+uMI2bErIcqBxMq8Kz8bYRmxIj97dJbe22z0hEPSYaSEBXbh
         w2FcIamjnoB00s5iy8eJtvDXW8ynQlsWRawCX7xBaPUoQ6LguUMaS3AavD7Q9sUsyuBD
         oB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700125551; x=1700730351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJvcy5OQThQMBzLC/CmhcyXSfL+uAyptQQ2e5phxAM4=;
        b=vhoYWLSm9tBkLA62rq7LW3MTeqzlwGR0Kgia2+pmEUY/CVL6IHKnBz+rkH4ul0Hs8B
         AMidXmalTDQprxNoYdOyhfkku6DeUMZzx8ILsXol3e7zKF3vlgs1ZHO/72cifsLIgKjH
         iqGD6CG8DJZkhT1zYyev0T0poxPx2jRgaDUr0HADpzMB8R3JpuK9eTUVambR3eLCEld1
         eCpJQAaY4/QVyk0bVQkAZ44trED01dMqPjM01GT0NweTsfnoG13ocmXRgxWt07uwaW1X
         qcjUqLFxJICuz4czSWOHMSy7F9uJ6sZWUAHctKoMp9E8BbrwAliKbdiVKFQYv99rdNBA
         22HA==
X-Gm-Message-State: AOJu0YyEVHQ7mdncL7j1/eUZMqjHNzkoj1fYk9sCWg4mUKaniM2rN82E
	8SIAocRc4mJBTIEMdY8MRiV4T3XWmAYGXK3585r1FQ==
X-Google-Smtp-Source: AGHT+IGJR4QLM16FKTPZT3Tz/J1QFBPNhj+bwePlZEFgi7iCb5pKMX+w3+XgoMz2yIXIyLcBCWd/7G270rmy6YIVNjQ=
X-Received: by 2002:a81:8a41:0:b0:5a8:3f0a:618e with SMTP id
 a62-20020a818a41000000b005a83f0a618emr16007472ywg.37.1700125550745; Thu, 16
 Nov 2023 01:05:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com> <20231115203401.2495875-31-iii@linux.ibm.com>
 <CAG_fn=WW1BUehMSsbjtPb4gKpakLGi3bF2KFEPxE4dV7n1ToSQ@mail.gmail.com>
In-Reply-To: <CAG_fn=WW1BUehMSsbjtPb4gKpakLGi3bF2KFEPxE4dV7n1ToSQ@mail.gmail.com>
From: Alexander Potapenko <glider@google.com>
Date: Thu, 16 Nov 2023 10:05:14 +0100
Message-ID: <CAG_fn=XftAnT0=kxkjGrtn9QEye1Xayg_jw3Fk_cy6SforMTpg@mail.gmail.com>
Subject: Re: [PATCH 30/32] s390/unwind: Disable KMSAN checks
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

On Thu, Nov 16, 2023 at 10:04=E2=80=AFAM Alexander Potapenko <glider@google=
.com> wrote:
>
> On Wed, Nov 15, 2023 at 9:35=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.c=
om> wrote:
> >
> > The unwind code can read uninitialized frames. Furthermore, even in
> > the good case, KMSAN does not emit shadow for backchains. Therefore
> > disable it for the unwinding functions.
> >
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >  arch/s390/kernel/unwind_bc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/s390/kernel/unwind_bc.c b/arch/s390/kernel/unwind_bc.=
c
> > index 0ece156fdd7c..7ecaab24783f 100644
> > --- a/arch/s390/kernel/unwind_bc.c
> > +++ b/arch/s390/kernel/unwind_bc.c
> > @@ -49,6 +49,7 @@ static inline bool is_final_pt_regs(struct unwind_sta=
te *state,
> >                READ_ONCE_NOCHECK(regs->psw.mask) & PSW_MASK_PSTATE;
> >  }
> >
> > +__no_kmsan_checks
>
> Please add some comments to the source file to back this annotation,
> so that the intent is not lost in git history.

Apart from that,

Reviewed-by: Alexander Potapenko <glider@google.com>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

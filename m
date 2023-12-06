Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aWHzB67H"
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF18DC
	for <linux-trace-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:37:57 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3333a3a599fso355734f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 06 Dec 2023 03:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701862675; x=1702467475; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UsKZRR7fb35TZGm9xzU+NNHL9tg4Q2nzB0Mt74LhSX4=;
        b=aWHzB67HWlNZRZogXA9OZ7sLsBjI5xY+Gz2o2kO+y0Au6TJfeBL+XAwHHGnf4Te5Lk
         iIivZlFDDlrKu5llEmWU/g/K7v7H3YkMhDnFR1VTd9inPqGVE0YvVeWhxTrtvFYjy9v4
         IZ1zTjk2+f3K5glsXDNGf+Q1HBncRzdXdxv4nAiLjN5pUZnpP1GDFZLwD+6Vc9KPTRgP
         pTUjHj/dpBXmT1VxfxH5VhI4AOZiwfKS8SWgyOrX2D5eifY+9gYRxHkYje/0s+hzUztF
         gj30LtmbBKzdDcwpQCiO6IDXhecPdHCdpmgRqjMCJFCsWo84LgGnotELeDMDBsAxmkbN
         te3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701862675; x=1702467475;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UsKZRR7fb35TZGm9xzU+NNHL9tg4Q2nzB0Mt74LhSX4=;
        b=PoDk2abuvF1Hi6CMsimg2RJCM3HZ55cZmMpNO071QxyN7wDBb7Qdi5SvQc+tVxgED7
         XpoXmHN25TVVxD8DYqZO3VZYGzOMR5f+x1jRugeFRsonTzb2sQSf6GGQDVpIN23zl8Q/
         3RncA13PLBRPryjYr06I6rZ/It5Qp4RYgSTmtEawj1wUCXqZvmiJevxWyeNMaoYzbi0M
         vAP/KrhwqQmrN6ltnbqsZ9QB2X5e0rHDK/2zm8ciKlzJOmF2JLFYLEI4qZWiJaPP3mvZ
         dl8x5XXc0KEgO42BfH5/QfBdOyPR19o+5G+jfdHfMaoYrtVY//CCnQkeGmfrws3C8GUK
         y6pw==
X-Gm-Message-State: AOJu0Yytv1VmHT+qlXJiKkGvYlrx5sKab0md6oZ1oNjpwNJeYbG52oQV
	D1EMVyCPD/FK0sEJpcASse5M+w==
X-Google-Smtp-Source: AGHT+IGtAUsYbhUVYEL0MZxwr4M0sLnELDMNsFle3FJdHz2OEGubCuMsgvDyo+NQ/Uio0wU7tRjUGg==
X-Received: by 2002:a05:600c:4749:b0:40b:5e26:2379 with SMTP id w9-20020a05600c474900b0040b5e262379mr1281084wmo.42.1701862675544;
        Wed, 06 Dec 2023 03:37:55 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id bh6-20020a05600c3d0600b0040b54335d57sm17055244wmb.17.2023.12.06.03.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 03:37:55 -0800 (PST)
Date: Wed, 6 Dec 2023 11:37:53 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Yuran Pereira <yuran.pereira@hotmail.com>,
	kgdb-bugreport@lists.sourceforge.net,
	linux-trace-kernel@vger.kernel.org, jason.wessel@windriver.com,
	rostedt@goodmis.org, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 2/2] trace: kdb: Replace simple_strtoul with kstrtoul in
 kdb_ftdump
Message-ID: <20231206113753.GB81045@aspen.lan>
References: <GV1PR10MB65635561FB160078C3744B5FE8B4A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
 <GV1PR10MB6563DC208657E86715361E94E8B4A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
 <CAD=FV=XpK0T-oPi2Q6-9jELFseSsvgkFtRuXP1LXK6PbV_MwCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XpK0T-oPi2Q6-9jELFseSsvgkFtRuXP1LXK6PbV_MwCg@mail.gmail.com>

On Tue, Dec 05, 2023 at 01:41:57PM -0800, Doug Anderson wrote:
> Hi,
>
> On Sun, Nov 19, 2023 at 4:10 PM Yuran Pereira <yuran.pereira@hotmail.com> wrote:
> >
> > The function simple_strtoul performs no error checking in scenarios
> > where the input value overflows the intended output variable.
> > This results in this function successfully returning, even when the
> > output does not match the input string (aka the function returns
> > successfully even when the result is wrong).
> >
> > Or as it was mentioned [1], "...simple_strtol(), simple_strtoll(),
> > simple_strtoul(), and simple_strtoull() functions explicitly ignore
> > overflows, which may lead to unexpected results in callers."
> > Hence, the use of those functions is discouraged.
> >
> > This patch replaces all uses of the simple_strtoul with the safer
> > alternatives kstrtoint and kstrtol.
> >
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#simple-strtol-simple-strtoll-simple-strtoul-simple-strtoull
> >
> > Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
> > ---
> >  kernel/trace/trace_kdb.c | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
> > index 59857a1ee44c..3891f885e4a6 100644
> > --- a/kernel/trace/trace_kdb.c
> > +++ b/kernel/trace/trace_kdb.c
> > @@ -96,23 +96,21 @@ static int kdb_ftdump(int argc, const char **argv)
> >  {
> >         int skip_entries = 0;
> >         long cpu_file;
> > -       char *cp;
> > +       int err;
> >         int cnt;
> >         int cpu;
> >
> >         if (argc > 2)
> >                 return KDB_ARGCOUNT;
> >
> > -       if (argc) {
> > -               skip_entries = simple_strtol(argv[1], &cp, 0);
> > -               if (*cp)
> > +       if (argc)
> > +               if (kstrtoint(argv[1], 0, &skip_entries))
> >                         skip_entries = 0;
> > -       }
>
> Similar nit about braces as in patch #1. tl;dr is change the above to:
>
> if (argc && kstrtoint(argv[1], 0, &skip_entries))
>   skip_entries = 0;

Surely that should be:

if (...)
	return KDB_BADINT;

There seems little point switching to a "safer" API if we just ignore the
errors it provides us.


Daniel.

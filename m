Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA2E1527BD;
	Thu,  2 May 2024 07:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714633250; cv=none; b=Vf57qbQJWvn5ewUjPPA3ywS/lb8a8MJccSKzshtINMpQ7QPhGkc99KmSJoD9x5QkHnHq+xmAlyva599aEClZ0jMI5Ok/sowe8inLi65weliuHvWB7/gAQ0f/Slfu/hTKicj9VUQYHekwhQbko6uIjnV8NZ+9zpREDhiTZ1Rw7nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714633250; c=relaxed/simple;
	bh=3ykTqPCAseFEcAOH3oX/4Wb3M2GB7b3iDS29Fr4qpfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4dJh8eOIiaCUzIK2LoT8EOT+cXb2YggDb9K9m1ytEoyxIOXRNbKyEPQMgC9dXhreoncE9A9Iv1/LFdbLu3nykrD5r3XnvOBWNegUvUoG81tL6D80iv1F1rzEne/JfcxSbSGuUf5SZH2t1RqCTVV4P8MmzS6Skf8IkgsBh8bskc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-61e0c1ec7e2so5049457b3.0;
        Thu, 02 May 2024 00:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714633246; x=1715238046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28IeqbACMJJBIkfIbzD+lbPyWA6agdVi1fU9IOn8pCM=;
        b=RBstq0LQAsrMwgFYUcogehobTrT6mtE9BpkM+6mSAL9zCPOYEjAqk/jxp5nwvZuHM6
         QLcAeCIwVf1Yhy5o2FLh90BiMbqHJIRqYhlRFALILXQr3rtChCgpy4ey1N/ClLlQG60o
         a5DPNqvsqX0H6U+hs7dAsAndmNsCfrL87XWQPEMH7GzF3A/v3Gx7brcGDia3wK5CBAE3
         C9g+Obzb5LC5+KDtwMVb4kegGAU7t9bX52Qt53VzAbtEZnVfdXh5OAXkgDgesjyYb2dS
         SQXu+IeJK1uSVphKnGe8sbPuPLQ+EwFCp+Oa7UWqQrn796tYlneadT7GXEf3XnoQYeK5
         RWmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeXDxbWs7KM99Y2aTCvb9Iv8psWPv8f4mgnRQXrm1/FqThuR8YTrJxEypM8F5xYDRQiVWua9BAmGzNxFQA9pkyDFClzYLVjWQxCfz/e89sNwEmt0PPcxfBdEsRsLyveGhkPGrStIFtc8dS0FY=
X-Gm-Message-State: AOJu0YzmTgDzRJXbdRMYRNMBMEqU2JFzcxnnSh2j1w0lK55s80pDs1CV
	DvHuNPlT3AeeTQANvSuUjyIVUcLzPihyu0EayV7wPcS6mkkQwjygnNbnosDo
X-Google-Smtp-Source: AGHT+IG2iCEJyCY9G9u3rS+D9l3qZdMaj5h3oV0/uTdxyIZO+98GVJTjgbcaJExpyHRx3b9aXAlKng==
X-Received: by 2002:a05:690c:45c6:b0:61a:e323:46e9 with SMTP id gv6-20020a05690c45c600b0061ae32346e9mr1282218ywb.25.1714633245933;
        Thu, 02 May 2024 00:00:45 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id c62-20020a814e41000000b0061aea696527sm79781ywb.96.2024.05.02.00.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 00:00:44 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-de8b66d1726so393375276.0;
        Thu, 02 May 2024 00:00:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUXQyaZlGFyoRtNTVEsDR29kAT6vJj5n2z1gN6niG6NoPvZSOim+9ufBRcYc+0nwApkHaZQEd/hgAH75kcdyXUa7jbJmMhhNI+c8yigDtOFGnCsUneDJ9+US/MC+U6tNuIz7BtbRsXA2zu3Jrg=
X-Received: by 2002:a25:3627:0:b0:de6:d50:ea0f with SMTP id
 d39-20020a253627000000b00de60d50ea0fmr1460759yba.2.1714633242830; Thu, 02 May
 2024 00:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709326528.git.geert+renesas@glider.be> <82d5efdde44f9489c5a7d11d0a19750445116c95.1709326528.git.geert+renesas@glider.be>
 <44019debdd26c1a4c75362b7a1f2bfaf9be2c792.camel@physik.fu-berlin.de>
In-Reply-To: <44019debdd26c1a4c75362b7a1f2bfaf9be2c792.camel@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 May 2024 09:00:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXp1aAH1Yk-wA1UnVOU_dg6wAe8pvNXuFjoMAwDw+-Z2Q@mail.gmail.com>
Message-ID: <CAMuHMdXp1aAH1Yk-wA1UnVOU_dg6wAe8pvNXuFjoMAwDw+-Z2Q@mail.gmail.com>
Subject: Re: [PATCH 12/20] sh: dma: Remove unused dmac_search_free_channel()
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Will Deacon <will@kernel.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-sh@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

On Wed, May 1, 2024 at 11:09=E2=80=AFAM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Fri, 2024-03-01 at 22:02 +0100, Geert Uytterhoeven wrote:
> > arch/sh/drivers/dma/dma-api.c:164:5: warning: no previous prototype for=
 'dmac_search_free_channel' [-Wmissing-prototypes]
> >
> > dmac_search_free_channel() never had a user in upstream, remove it.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > dma_extend(), get_dma_info_by_name(), register_chan_caps(), and
> > request_dma_bycap() are also unused, but don't trigger warnings
> > ---
>
> I assume the other functions didn't trigger a warning because their symbo=
ls
> were exported. Correct me if I'm wrong.

No, because they have a forward declaration in arch/sh/include/asm/dma.h.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

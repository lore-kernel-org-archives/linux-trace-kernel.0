Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82A62032D;
	Thu,  2 May 2024 07:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714633408; cv=none; b=hbkyqQJQpRBat+Clsq0884N7+pTs+22xqYkuUpikr2r1/8Y4/KzikVmizZtW47QBo8S5tZWarfMZUHmDocz3nKUeLBTTZMB5GEQ09MAETNu3srHlY5RY4x0sNnqMPst62J38dPF6XAcDvetyBS2Uwmw5Ov1EQ7VVDVx/D1j3AYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714633408; c=relaxed/simple;
	bh=E1lVX89FvGyrjRisUePQIbezkTkf/vI/dqOI3vafcRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CAgA+NQDXCSluNxqGBbDT/X35RPgmMaYC0iguPD1KewyEOPIlFO5Igunn8Yjd/CRC5GG8WAW1sEEFmECggekDz9Y7zfsc/xIfiJDbxAso+MKyQl43iSG0si0wvJ0jPtfU7MjU3XvRWOazoQYa55OcFED97T29idUIq41celRwVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-61bec6bab2bso26460237b3.1;
        Thu, 02 May 2024 00:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714633404; x=1715238204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qe5zTEsYiHYroXz4oBXUEmOas66Ot4RQYAN6ERhGBs=;
        b=hfgQBL9fX3+1yiMZbFsKZjt0vfM/gvjOFWyVOYUtjcwoGzL6uTUbwL6lCKI/le0O0z
         V/IPxNxN3O/7Nh8+D5fDsc3+FHsKUC4Uj9Af89Ow3Dtwx88GpZF5lcp/IV1rwDo3VEIF
         uV5nIpRCZc4wjvgmI0Ss5MziFT6JGrnj/nrcoUIrHuLKzZYoTiVEnvfSoeWavQMLWb+6
         4ZgKcPi7L81Et+sHa9PMr8rq+Ktlaxd4QuOPZvgESYSY6JZFigod9lr5aak/YL/o5Wp0
         ecP6UVgWjg5b5VaumosQA8censwm1Sud8aFfilh4PJlCXToDPY/LgzdhUov3C1MqRI38
         5cqA==
X-Forwarded-Encrypted: i=1; AJvYcCWFHaai2fiPYa40bDUEl2t5NJFrCjJt6SQ185I+pZ4ZEtfn5rqA2nKA9a7CrZKaOpSpe+c6TKn08rTcMyeAuqxyEvzIIkcereapQiAnHV6rnJ5qi3VYDmGID4hagu0LxKKtpOYianv2R3aGtKI=
X-Gm-Message-State: AOJu0Yxzy6Krj+oKxUyvx68CRe312OIxJdiR9TnRpJz+QTEHqckvWBCd
	k6KjRvdSmJlm8StE4sXbTp1nCDU7WZYJ4Bc3OqO0wHbUMA+IzRJn7Cy7Wasn
X-Google-Smtp-Source: AGHT+IG68O2ddAvZhCcaOa//MJ+YEY1tGuQUx4kTbgN/o7dzgAu5d3ySozMMh0lcs1Txxs3Hnyzn/A==
X-Received: by 2002:a05:690c:f88:b0:615:3e2c:d318 with SMTP id df8-20020a05690c0f8800b006153e2cd318mr5885540ywb.41.1714633401947;
        Thu, 02 May 2024 00:03:21 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id j135-20020a81928d000000b0061af7439278sm81394ywg.77.2024.05.02.00.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 00:03:21 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc236729a2bso7654768276.0;
        Thu, 02 May 2024 00:03:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXt6G57e48YnQ610xerbksGWFAkixqAotwhdLFqWtWItgsr+5ohcQ4EIXGylXRUJFf0PBHBnOkEI1DsI1F4FPw7pJmW6oPg3BH/W8ez9MGT7734lLkIBoY2OTE3UM4a838OZ+r9LnUz/FBcjSA=
X-Received: by 2002:a25:d084:0:b0:dcd:4e54:9420 with SMTP id
 h126-20020a25d084000000b00dcd4e549420mr5363508ybg.5.1714633401431; Thu, 02
 May 2024 00:03:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709326528.git.geert+renesas@glider.be> <2beb81fdd7592a94329e3c9a6ba56959f6094019.1709326528.git.geert+renesas@glider.be>
 <4f302ebb109fb0528a7de4f552e78ee0dd9595c0.camel@physik.fu-berlin.de> <950ecbb643db322a953bb048b451702246ca9031.camel@physik.fu-berlin.de>
In-Reply-To: <950ecbb643db322a953bb048b451702246ca9031.camel@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 2 May 2024 09:03:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUsVz3ph0AD21a1Xz0CBc9ni4ipdS8AhWRJkywm7K2G4Q@mail.gmail.com>
Message-ID: <CAMuHMdUsVz3ph0AD21a1Xz0CBc9ni4ipdS8AhWRJkywm7K2G4Q@mail.gmail.com>
Subject: Re: [PATCH 20/20] [RFC] sh: dma: Remove unused functionality
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	Arnd Bergmann <arnd@arndb.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Will Deacon <will@kernel.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-sh@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

On Wed, May 1, 2024 at 3:58=E2=80=AFPM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Wed, 2024-05-01 at 11:12 +0200, John Paul Adrian Glaubitz wrote:
> > On Fri, 2024-03-01 at 22:02 +0100, Geert Uytterhoeven wrote:
> > > dma_extend(), get_dma_info_by_name(), register_chan_caps(), and
> > > request_dma_bycap() are unused.  Remove them, and all related code.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > I assume we could re-add these again in case we need them, but it would=
 be good
> > if Yoshinori could comment on whether we should keep these functions or=
 not.
>
> I was wondering: Could there be any userland tools using these DMA functi=
ons?

They cannot be called from userspace, as there is no API for that.
They can only be called from inside the kernel, or from a kernel module
(possibly out-of-tree).

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

Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F183EDAA0
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 11:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781089629; cv=none; b=OxpPyxOEI0mR8MIuJJrg5NlinnwsljhQP4pjQkrBTOmUFF9PtItEq4ktPnbf29UaQ5OFxdlORQBk5Fhioi2hb1vtzW0kq3J7aamOkK4sf3NJtiPNj6oVPTjL70okUDgDFzYQhUk/RMBn/qV9MOrM9AjIeGN0KZ9UmX+IeRfnp3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781089629; c=relaxed/simple;
	bh=JehR0oU+hw1WQAoEsOX3iWYFXq1/Qs0MJtpZSJOhIMY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZAO65PW6EZW+g6T7esEKMdU5VLslGjOSjai9t7E3n+cl20F23tXk328QNbNsoW2v1652BGclkHKEsxrJHPWZKZpWUr0d5FrHX/rYiCxKZ86NoK/7C8SEmuk7udJA1apK7gQlqfhdo0Tv7Z9CsRo0GQAGAcJzXiaw1WdewAwmD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/Yn1xRZ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/Yn1xRZ"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4602e2a0372so4804569f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 04:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781089621; x=1781694421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CD+jAvn+F6KZcBr47jRj5pM/yHOUpsx3lmiZzRlGXro=;
        b=C/Yn1xRZnhF25737NjWSEkIg18ZI70MHxYR8DjpMBhXmxB4sBymcnF+vySC9fRJRnG
         BQ2RrTelpb/CtLwd1mpTKSFY68VeMqPc+39Bb6p6TR0zpkVtorrKWyjbqxYY+xe8hy8p
         RaDJW5GPHIkyTuwkKiat0ckNeFj4K/wcwXUD0DeqOdTN2/UpqkAID2eRkG/hrYLb4rEA
         oup46s6ZklMS8u6fwFqfch6CUrWUigCm2IC7kVul3HaOezp/kx4K23UFOOD8KwqySuaF
         Bj8TLRr+TiyikJAfZ454m7ytMt2Z+yTjP57CVlzzHUnMRQGoMwyn3zPxyCLsvaGDMwop
         sn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781089621; x=1781694421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CD+jAvn+F6KZcBr47jRj5pM/yHOUpsx3lmiZzRlGXro=;
        b=D0kkb2uocTlJmB3MP55J6m5GyshW73iqnCs5iUY5saz/iwC7BLc5Qv+DdLNIrmE/V9
         NOH4Ov//Y7Kp+XPi4GAFuxnn4vwteIP+xVh4H3pW9ShYTF5DF2Y0zAvj5CcyUNbxLtNW
         6riK4YagwP2t8D4uQX+t7pUtoSwlm5y8JCi5hjEpQxA2Zx+/2kxPid6zqp8Lx469AmgS
         LouLM44eGsoCIdZgu6z+OfQBKHNHOQyEN4vCityPE7m3SRTSG/LIOE+gWkjp93ev0UGJ
         vI9gnOLZjlFsWfmTRIUHen1Ed1sGtXWI1dkF1y8KqWtcREB5Fhg9uvLixzC/nA66ni6p
         DLQw==
X-Forwarded-Encrypted: i=1; AFNElJ8H7xQ56xYpgoIuOgZwnTBSWSpNKPP763DtCnSIZazbJiLgSHO3Q/znAVp3N3MHP29J/bG5ZlPaWygPCP7+FhL2Vqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPueF5KHQgODQWa5hYgBA4h7fADNnuX7BiEJlZUdcUm1AA8wzf
	irnbkJC8DUoF8iAcHRzDdrrOK/knsQgpyV0ly6/DuWY2vQlRuWhR4P9/
X-Gm-Gg: Acq92OFFv0MUZ/HB+cPdGl6yoTUC4qmBMTWUoTaPoOFoW7YCZm1tU2WrhYefZ1ppu0m
	dDlsrZAat8KaIUtyG3UGCQmu+99aolo0EPUjf4WfSNS0IQ7kAJXdZoQA8cQFoByYUnmY4Ah/9fN
	btPXjH1mLua+Q5W4MzsjrVgqZGc3+pofoELUBNpympnx1AcuknLXSl4TKtyNmnWegAwe9vs0oZw
	ue81Q7aSENd55v/glyzb5eO5gmkNFaAzMorNaDGefIDkHLWEcDH3jZEb6bYxMyl2Lx2FwgxbBVk
	dLzwLuYJD+OoG9tXudJ09vTF9sMeeL1MdIrdDf/2AcUZ7wS3ceexMZbXiyp+0YACpsMQdQzyKm8
	E+3xuZtMxsJPlo8LX4McU1NsKuih1VjKuM0heequBvdr0bMMOsEmm3fJZXL+CIgu6rkUov8mDWw
	wcnV/Wlq0a81n5hoL37doZ19L7laAcPeRNavoShdOLn5DoprXtpmW1BviJ/m29es2S3SvRCew=
X-Received: by 2002:a5d:554f:0:b0:45f:f142:d56d with SMTP id ffacd0b85a97d-4603050e58dmr28190240f8f.13.1781089621362;
        Wed, 10 Jun 2026 04:07:01 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4b18sm55870321f8f.10.2026.06.10.04.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 04:07:01 -0700 (PDT)
Date: Wed, 10 Jun 2026 12:06:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: "Markus Schneider-Pargmann (The Capable Hub)" <msp@baylibre.com>, Steven
 Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Heiko Carstens <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: fprobe: Remove __packed from generic
 __fprobe_header
Message-ID: <20260610120659.7c61cfa6@pumpkin>
In-Reply-To: <20260610171740.c30c43c5faee0beac3ad7546@kernel.org>
References: <20260428-topic-fprobe-packed-v7-1-v1-1-9abc9b866b4c@baylibre.com>
	<20260610171740.c30c43c5faee0beac3ad7546@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 17:17:40 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hi Markus,
> 
> Thanks for ping me.
> 
> On Tue, 28 Apr 2026 10:30:29 +0200
> "Markus Schneider-Pargmann (The Capable Hub)" <msp@baylibre.com> wrote:
> 
> > fp pointer and unsigned long have the same size on all relevant
> > architectures that build Linux. Furthermore this struct is only used in
> > architectures that do not set ARCH_DEFINE_ENCODE_FPROBE_HEADER which is
> > set only for 64bit architectures (apart from LoongArch).
> > 
> > Both fields are aligned on these architectures so the struct with
> > __packed and without it are the same.
> > 
> > Remove the __packed as it is unnecessary.
> > 
> > Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")  
> 
> NOTE: This is not a Fix, but just cleanup or minor update. Or, you have
> any problem with this __packed attribute?
> 
> Unless there is no problem (or any concern), I would like to keep this
> as it is.

There is likely to be a difference on architectures that fault misaligned
accesses.
On those gcc will use multiple byte-sized accesses (and a log of shifts etc)
for code that accesses those members because it will assume that the
structure itself can be misaligned.

So you only want __packed on structures that might be misaligned and those
that contain misaligned members.

If the structure is only guaranteed to be 32bit aligned then use __packed
__aligned(4) so that two 32bit accesses get used instead of 8 8bit ones.

-- David

> 
> Thank you,
> 
> > Signed-off-by: Markus Schneider-Pargmann (The Capable Hub) <msp@baylibre.com>
> > ---
> >  kernel/trace/fprobe.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> > index cc49ebd2a773..21751dcdb7b9 100644
> > --- a/kernel/trace/fprobe.c
> > +++ b/kernel/trace/fprobe.c
> > @@ -181,7 +181,7 @@ static inline void read_fprobe_header(unsigned long *stack,
> >  struct __fprobe_header {
> >  	struct fprobe *fp;
> >  	unsigned long size_words;
> > -} __packed;
> > +};
> >  
> >  #define FPROBE_HEADER_SIZE_IN_LONG	SIZE_IN_LONG(sizeof(struct __fprobe_header))
> >  
> > 
> > ---
> > base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> > change-id: 20260427-topic-fprobe-packed-v7-1-f44f9bbdedf6
> > 
> > Best regards,
> > --  
> > Markus Schneider-Pargmann (The Capable Hub) <msp@baylibre.com>
> >   
> 
> 


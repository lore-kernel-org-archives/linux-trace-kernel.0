Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDCE28C2C6
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 May 2025 15:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748445960; cv=none; b=m96XohGU6sgYGymov5NM+j16OqU6D7JUnloqRe5INA1dt8HX2hGq5kNFoaMB89CsOsIlvZc1AqxkSvv6swD9WpJPKy/D1MwR4tyYW/ogweI+Xd23mXn4kGt2Lp4B5WSx6hgrs+lTxibjaywBzNnussueWAAnRv2gx4TF72kZ/9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748445960; c=relaxed/simple;
	bh=PU9chQywfCMBgYD5NaCcwYrj6++fQTNDBXxxWSs6M44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UaSlwUZG8usH/dQhUQlVMXMkeGgnsGketCDznWiHFnqd0N9DwkQBRT9Dfc+lVinHtvx+wEcrp1UIZuzyhoWbHr3cnbm7L9stORiIIBxFGeVorDr8grvza2kumkCsicKJAHphTlbYe9uk/FoOMkN1jBN4IZtW0WPuY3QMYr4K9ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=EdZRhU2R; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="EdZRhU2R"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b2705e3810cso623583a12.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 May 2025 08:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748445958; x=1749050758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PU9chQywfCMBgYD5NaCcwYrj6++fQTNDBXxxWSs6M44=;
        b=EdZRhU2RN+aEZvLx1snhnNI9BryOF+t3fe9Kd5RNLlIgt/tc2tJnbUss2NgZqONhIM
         aPF4bxXmFSdOvkaNVAOYeb5O5M4XobCyqPRpcm9waZhAqebVIXlwyYGy7CmwVO7+M13C
         9EaY8CWY+peUzzmIFaEJI4k4Siq0LPHa9+2gcEKx/0nx95RKtCA7yBvEXM4PAMAdmLA7
         swtOhw/p/bFrIat+Idkv6iyayLrQtGMRt2IUoGaLGkF6dg0yFBAFPxYfOfBwz7veQEm+
         zlrh51qDpQrYFYNCFrSXR5FpFKkY6N+AgSpAhVLhSNCUK17dl3YbKLYkf4i7esXMwfuK
         L9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748445958; x=1749050758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PU9chQywfCMBgYD5NaCcwYrj6++fQTNDBXxxWSs6M44=;
        b=I9zcsWizuxD+SzQPi9BDdncD5XaiigUJSg/DB42/5kbCUdNizfb6Q44g59eNhFy/3p
         Ngfxu8xmYzUzJtlVdxMePcmw3IQUpa+ZdYrKudsHpFVSap183Ka+3lJ+EmmSwhLb+H0B
         XFZ7MdkS2jAkHMi0mAid12ZI5t0dRalw5lGQ6eP3kYwYTwjEcrhcwFS+6DjkSG3p9I1p
         2cWOZDOuShg5GGQO0e4e/vCcMVu1NxnrgtNEJdp920sqCE0h6Rg2dYWAC47Y9FuqI0o8
         dQhfRaOKD0+ZK97zwoHq8OAHZzA8FTnGmmGaDINUTmlNvLQ7YRf0ds8g+CFglUIgfF2M
         ZOUg==
X-Forwarded-Encrypted: i=1; AJvYcCVBQHVKUTRwITTujph6w9ZEWJQ+1GUgtg0oB5VDPlcVMYl0Ull3aHzpv5l9PczOxz3wR9kDmXorgKqjjRwHnoD+RWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ0Xm1wJuxaQtJYIHvx0REwaLVKwOrlKm2B/75w2G9aV2HDXbs
	YgXyk8UoIc/s2K06LHHt62RC8aw2a6ZDwaJNIOFVUBHU+QyNmDMY2/xCrfrQBM/mST5TEeY8GQx
	sfuEt5cK+yZVZ/RI0F+dW4L7P+l6ysmRTDkfzOI3RaQ==
X-Gm-Gg: ASbGncsSJatXZmdnUxQIW1twqzb+wbebJ7Ki2EHJv3p9Fj/qiUfaRvAg6uW1YqShN1g
	ZISKuqkbIpEQF1HMBo8I+UMRJ3Su/D9QkKIDKtYucMKzFV7pdWtIQJS3NW9xExPdDDUnTNL549W
	Xs58LdHdJkwHsYuFEmpRF1igNbFiQWzlcv
X-Google-Smtp-Source: AGHT+IFFLhz0tMuJ5OoJ7sq+5B4EgghyiZS3sT2o+wvwGnin2/XNjmW1voB64CyNLiLlOl9Lzv45F8CFBTLXOmtDGfQ=
X-Received: by 2002:a17:90b:4d8f:b0:30a:80bc:ad4 with SMTP id
 98e67ed59e1d1-311e03a7f6amr1843239a91.0.1748445958464; Wed, 28 May 2025
 08:25:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411161746.1043239-1-csander@purestorage.com>
 <3ucksa6coiwco3wpmcjtfwezqjigzm2zwvdvkt2ryvefzojtqy@4lda47c236uz>
 <CADUfDZpPGQEY9u3p3MCU2S3qmDyKmE1JnSQ6G2jO4_J40rQeeQ@mail.gmail.com> <92d947de-110e-4c17-a822-f626bac9b540@lucifer.local>
In-Reply-To: <92d947de-110e-4c17-a822-f626bac9b540@lucifer.local>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 28 May 2025 08:25:47 -0700
X-Gm-Features: AX0GCFv3sm9dKmwHw3WUhFClDZ3EiFDcrlchd9OQvH_FSdqpgWJC60zCCV5o0e8
Message-ID: <CADUfDZqQDes94v17mWCk2FdXbyasybmPeLOeCCrikB7trOfDUg@mail.gmail.com>
Subject: Re: [PATCH] mm: remove unused mmap tracepoints
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Eric Mueller <emueller@purestorage.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 8:23=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Sorry this wasn't picked up.

No worries, I think I didn't send it to the relevant people and
mailing list originally since it wasn't in the MAINTAINERS file (which
Liam has since fixed).

>
> Andrew - one to pick up after merge window? :)
>
> Caleb - I'd ping again after the merge window is over if it's not picked =
up
> this week. This isn't a great time as people tend to be busy sending stuf=
f
> over to Linus.

Sure, no rush on this. Just spring cleaning my inbox :)

>
> On Wed, May 28, 2025 at 08:16:24AM -0700, Caleb Sander Mateos wrote:
> > Hi MM folks,
> > Would you mind picking up this patch to remove some old tracepoints?
> > Liam has already given it a review.
>
> I am actually curious about reintroducing these at some point, but no har=
m
> removing them for now as they are as you say, unused. If I do work on
> reintroducing them I can obviously... reintroduce them :)
>
> >
> > Thanks,
> > Caleb
> >
> > On Fri, Apr 11, 2025 at 10:23=E2=80=AFAM Liam R. Howlett
> > <Liam.Howlett@oracle.com> wrote:
> > >
> > > * Caleb Sander Mateos <csander@purestorage.com> [250411 12:18]:
> > > > The vma_mas_szero and vma_store tracepoints are unused since commit
> > > > fbcc3104b843 ("mmap: convert __vma_adjust() to use vma iterator").
> > > > Remove them so they are no longer listed as available tracepoints.
> > > >
> > >
> > > Thanks for doing this.
> > >
> > > Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>
> LGTM so:
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks,
Caleb

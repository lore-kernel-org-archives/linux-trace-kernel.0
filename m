Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223AA84D2B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Nov 2024 15:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732203327; cv=none; b=HdpMS2hKwEUWhjCgsET7bltIqDXFcbmBNNq9Y2Q3+eXm7/lcJmbTYOwO5umB3ngvKOisPUW2VmU1FzALyQqXUL5tQTE/b0QLQiFJhLBZLY2/8naLPtz2+51Autg9XRCDXtAr6D2iuaJhzKnkYAbKQk8WYPMEqQ8Q3ZgrIHuA2Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732203327; c=relaxed/simple;
	bh=SsArjD+1glKC3LFuUTU1qcWsOXBbI35QwXJjYvQPPgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TvHLQ77PS2ZzBhmBTRqN7l9LO52fp+sASE0+Ra/b1RKIRlnTBBSEAOo5VYygtQnIjQzAlxMaq8mh3kzr8XDq4B7GDNHoFW6ebGmPSPAkyOARvfDbCeC0t1D8pUIalmR1zgX7SF5cxwxrnqKtLsEidg3zl36gP9mlqkem8eXqjLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LrA0ehL6; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LrA0ehL6"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-460a8d1a9b7so248671cf.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Nov 2024 07:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732203325; x=1732808125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=547IccmQdfQpz/uAg3RPtdIl621CchRTsFZX3/wSte0=;
        b=LrA0ehL6FTKR5tjVH6H7Sz1LsI2UZxFCr7xYy40jxgryu6zR+aFZvSqmA9N9f5WCz2
         DJLxu053DEtZRDaNl3XQFC7VO8uV78F7xuNwvJXBz0OJsw5PgxKS0poXzu94reKRWxfm
         ry/pGpd8aAvjCW83om3onFTfX9EqavzbXADID/DMmfphL3zwBF6UULv0/Jdp/cKpR3MW
         Unw2X0eleCHKBGMQS17yQncoihX8fdf2SHUGXXew/rnzGuAAxpPkZl93Xs8ujHAsDPWX
         4IY4tUCljB511KYHE4agp51sowqB4Oo9+rg1GOtWhccOc5KlpMYh7Gy0GS95nk/l1ENx
         mW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732203325; x=1732808125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=547IccmQdfQpz/uAg3RPtdIl621CchRTsFZX3/wSte0=;
        b=IgUQgh6iAG6vsN0P7HCtiersv9W4JHaBM3g4W3MCjhm77+Eg8F/yXmFrZ7IeYKRhIR
         IV/tfQVclZnOz3SfUwqkfOgPJbwfMdsKbow5hQnCIf4K0qPq/twSH2KSTKMgsrQufGBk
         W07mhAL18b3xSROwM+pu53aJNA9ZajUbciLSaMpvBvIibPWLLXOCtIEiLAfnDVccMFTE
         WhkyiszJw0c7zTDgQ/HB4RtULPLgdzRSddQY8Xc5ZsvHgZ7PqRpENPkbiIowYlQoh1Sj
         AvklJ5X0eas9z4r/OR3iTn1sseYUwPzY3CBsCQU9IrJ2At8TXtczShxnKXXKXo0FBP+0
         W+CA==
X-Forwarded-Encrypted: i=1; AJvYcCX3kYrUds2kDFKwyEKEO9+d36/O0ySpIA9BbHMhYDPzxrGwLh42KkRrT2aoypAf775LScg4CuxFTOrvURkyF3ZwIh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6lQOk9DEIzNjsWjJid2K+R8N7tDXUkdfNyvXaanNw8U9UtUWv
	lEbP9PhP1UPNXuapC+ISwahQofbOGpmSzG5jJg6enEI+hgcoGzvTsczNRBuVY4JvVMg2EJOxd9m
	MKdtTNsR1gUPfojxPHvoUU38ocTfmk0jXcmTkHuo9a4hh9lD8oPW3F1M=
X-Gm-Gg: ASbGncvZCtFy8UXil3NcRs5HER+g+4AxkFs6Klm+XiD8CYcTsnLzoLl4yE/tCay4qs+
	15YgIDmumxJZbjatJu2vWkjlLoXhUa804nAuBPY5sTD6IO6QcJC2Bb+PCgvSt
X-Google-Smtp-Source: AGHT+IFADvU4IPxoEGDBvsiWv2fnt3CEBsmaslZcEQXF5z8gP7iOsIe3UKpqtmvlizSwxHzRxnFWvsa1H0vOdEmntPk=
X-Received: by 2002:ac8:59ca:0:b0:461:6e0a:6a27 with SMTP id
 d75a77b69052e-4653bd848d4mr96191cf.20.1732203323364; Thu, 21 Nov 2024
 07:35:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028010818.2487581-1-andrii@kernel.org> <20241028010818.2487581-2-andrii@kernel.org>
 <20241121124011.GK24774@noisy.programming.kicks-ass.net>
In-Reply-To: <20241121124011.GK24774@noisy.programming.kicks-ass.net>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 21 Nov 2024 07:35:12 -0800
Message-ID: <CAJuCfpEBJsR803Ac-cwN0MWadzWW_WKZchaexdJauYETaww40w@mail.gmail.com>
Subject: Re: [PATCH v4 tip/perf/core 1/4] mm: Convert mm_lock_seq to a proper seqcount
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, mjguzik@gmail.com, brauner@kernel.org, jannh@google.com, 
	mhocko@kernel.org, vbabka@suse.cz, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	arnd@arndb.de, richard.weiyang@gmail.com, zhangpeng.00@bytedance.com, 
	linmiaohe@huawei.com, viro@zeniv.linux.org.uk, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 4:40=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Sun, Oct 27, 2024 at 06:08:15PM -0700, Andrii Nakryiko wrote:
> > +/*
> > + * Drop all currently-held per-VMA locks.
> > + * This is called from the mmap_lock implementation directly before re=
leasing
> > + * a write-locked mmap_lock (or downgrading it to read-locked).
> > + * This should normally NOT be called manually from other places.
> > + * If you want to call this manually anyway, keep in mind that this wi=
ll release
> > + * *all* VMA write locks, including ones from further up the stack.
> > + */
> > +static inline void vma_end_write_all(struct mm_struct *mm)
> > +{
> > +     mmap_assert_write_locked(mm);
> > +     /*
> > +      * Nobody can concurrently modify mm->mm_lock_seq due to exclusiv=
e
> > +      * mmap_lock being held.
> > +      */
>
> You can write:
>
>         ASSERT_EXCLUSIVE_WRITER(mm->mm_lock_seq);
>
> instead of that comment. Then KCSAN will validate the claim.

Thanks for the tip! This one looks not critical but I see there are
more important comments in "mm: Introduce
mmap_lock_speculation_{begin|end}". I'll send a new version shortly.

>
> > +     mm_lock_seqcount_end(mm);
> > +}

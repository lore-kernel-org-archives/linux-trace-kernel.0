Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C17191F9C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550262; cv=none; b=FOV8IKrmpgMmRuj0s4SB48qHtkpKdbSggME2orBJW0HFCqRP8yx7H+jEdZIG2PB8+Ej+TRR1YPmexu1AdLXnTdk+xOJDCg4FoSEVZT2IRdt5+72KmvWBXkFCIUauBJYVd22jKQPIs6IujzUL/yLMHihyVbQB+Gci7Wn6LDsWadY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550262; c=relaxed/simple;
	bh=8XW2n2VhDigOuWDnayQlpettVtHAzkIB+llF2eI+Whk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lt6Gtbg0cUxfs/ewTXQvrYPLRtIV0I2CCh++QCofoZ9K45ysg377aJKjrho1j5vWhbr3Ic1K16b3GiPwlmmhStmlureVNlxTXKWJa+EwzuWxaZvaNVZmE1yWOcS0VdQMPPdEsmUowJvDuQnaG9MLAr8KwJ4Yny1R0lZioSX80bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWMt7fj3; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWMt7fj3"
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-eaf8e85f66eso774373276.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758550259; x=1759155059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XW2n2VhDigOuWDnayQlpettVtHAzkIB+llF2eI+Whk=;
        b=XWMt7fj39vU8t34Vq6XztEwf8qbKcfWyAIecuYVaApochod81YcP9nbSpq2eko3oJr
         1N2MCr9gTFD947xt5sdBfyY2Zri7pLxi3hFw7TRqD4BzESw8W+HhHY8hGc4UOMX7qfoz
         VjQkwbSSClk65dmnUjH5esFRXrrfRQ4gMAjuVLqGjQHrKiwJr0q3q4HUJJ5GOsE03I3I
         GMeRYhSxDPkoERtX1+Zd0W/2vX81ePe3cQ+1BML63z6Nm1jw1AsgjIcIcQHVWC2hooFf
         4VN4yDL4ZPQbtCb1zZ2KejOqrdgEHrzKUGWIviTanQmQBr3djhX2pHklYXc6V70PvBd1
         W48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758550259; x=1759155059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XW2n2VhDigOuWDnayQlpettVtHAzkIB+llF2eI+Whk=;
        b=mb/Nm+3gbZKljGxPKgGr9fS202auh2tsgxNnOiMceXgrSll7s1y8wDCH9c3KlFyuz7
         frYo0XSXUWqxGC1raaQVgLzZ6x84XEw5VDT+xSIQGNxqa6kJRo4rON3R1C84bXapRRtj
         6+2V41ZnG6xH54f5EUZuqvRtIGhohjPwhbNulC33JR0vnXSE90ipzAW1jArOlBYQAo92
         NBxQh0o0JQn8rvtLtjGxWwQTRKJyGqDkgZ9r6oAor3ALxJpIbR3CHvBGDEz85kIoArCA
         SS4gGI+Y7zcbSjPGzsPRYWgeEG2auz5YduPf7QT0MdgXUD24IoO7dtytKfRKyGNcEbgF
         OTZw==
X-Forwarded-Encrypted: i=1; AJvYcCUUx73kCPEvoi1MiYhm6zF0DTXok608CgReQF3E6i/SWuYfV4HmpWwStpxsozsO1KV2Ystw4rRCbKKSuMXz0pTQz/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy2KA6x7gXVGSPYPylXQLuX+ycZ1faL7FHnEgCpGJ8saY8rNJL
	GdUX2rVGkhz9KatUJdy1CIRJ/TKIMLxTbtHBV0mbXPSD3jynu57SLyd8hrqYcJX3gN7MlJWRfnq
	mbEu7lkLpJjDqLZ3YewEMP5XiYqJdq78=
X-Gm-Gg: ASbGnctvn38PE72Fo3Mv80NiWjkhFWUI44HwvRPz/XwJFH/HtDd1w4iX316jihgI7kI
	C9jgrqWj758kdvhwqWOfUQgAoEfwMzWMOzP37wJEiwyw41I/lfVIi9FHeuD0tItBlAZdXyFrRKt
	Cy4dw5mlmhraujcOv14gk01JSgU4Qp/uSGgCJGBXqX2eXL6tMkPrKC1d2aph1ijvidbxfXMug6p
	sxYmO8=
X-Google-Smtp-Source: AGHT+IFJzannJGdG0U/xTsTeep3q5OsJ2aVW353S/liXxsa4qbfagG/H+I3ZslMdOqGQa0hUJ2OFr0JeEIz8m/TPPLc=
X-Received: by 2002:a05:6902:2b90:b0:eae:e869:7c1d with SMTP id
 3f1490d57ef6-eaee8697e34mr4628048276.51.1758550259329; Mon, 22 Sep 2025
 07:10:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922095705.252519-1-dongml2@chinatelecom.cn> <CAPhsuW7THs9G+QV5_g+tMvXTAqVJ7jha-m70f675e9phK1Pryg@mail.gmail.com>
In-Reply-To: <CAPhsuW7THs9G+QV5_g+tMvXTAqVJ7jha-m70f675e9phK1Pryg@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Mon, 22 Sep 2025 22:10:48 +0800
X-Gm-Features: AS18NWBlqc_FP-SWeeZCKNLtFTPzs5iuu6l_5C6HkEcL7Ve0M-pNng3gsAfS8eU
Message-ID: <CADxym3b=hU4DuuhA_DAs6VYNUTp7spTsTWamMaxDGSxjoiuwbg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: remove is_return in struct bpf_session_run_ctx
To: Song Liu <song@kernel.org>
Cc: jolsa@kernel.org, kpsingh@kernel.org, mattbobrowski@google.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	sdf@fomichev.me, haoluo@google.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 10:08=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Mon, Sep 22, 2025 at 11:57=E2=80=AFAM Menglong Dong <menglong8.dong@gm=
ail.com> wrote:
> >
> > The "data" in struct bpf_session_run_ctx is always 8-bytes aligned.
> > Therefore, we can store the "is_return" to the last bit of the "data",
> > which can make bpf_session_run_ctx 8-bytes aligned and save memory.
>
> Does this really save anything? AFAICT, bpf_session_run_ctx is
> only allocated on the stack. Therefore, we don't save any memory
> unless there is potential risk of stack overflow.

Hi, Song. My original intention is to save the usage of the
stack to prevent potential stack overflow, especially when we
trace all the kernel functions with kprobe-multi.

The most thing for me is that the unaligned field in the struct
looks very awkward, and it consumes 8-bytes only for a bit.

>
> OTOH, this last-bit logic is confusing and error prone. I would argue
> against this type of optimization.

Ah, you are right about this part. It does make the code more
confusing :/

Thanks!
Menglong Dong

>
> Thanks,
> Song

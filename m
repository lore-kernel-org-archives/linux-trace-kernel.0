Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE55E1C9B65
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Oct 2024 20:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728938918; cv=none; b=SMA1N4n8Qv8CqEXgABlaW+Lvzw1rGNXbD1VZCaPXpwDLOX0I9NgH7qHekg6JR98LtAiftPcA9SW2hfz4v7fHX2Rr3Q10+ExOLoSPG/cLmS6/GhTmt9FEc+wZouU1b5IFtBm7uGPpCcAsVqEFmmq4phHMqfjupO+G+YvgWraaEr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728938918; c=relaxed/simple;
	bh=oLiOJMlbQiOQsxhqpnja9W8p5wjHHPLRN1lJCefWKIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1Nv+GpsEAtZfCvsjWzlRSn2mgTEWIn07fbUBxT3UJKJpai1TliPPLvEoe0YggAM6yO6JbZ0XxFa2id4KSqnobBD/pw87VJQETxBm25zHg/sNZloEcBS4PG3kJvCJr4C+KgsWsG/TuR2Z3ahZDyPf6gyCL/hJHzT3JJyO6pLAvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A3oHYq2i; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A3oHYq2i"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c8ac50b79so327695ad.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728938916; x=1729543716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLiOJMlbQiOQsxhqpnja9W8p5wjHHPLRN1lJCefWKIQ=;
        b=A3oHYq2icxsJJhuHZJ76PIZC/B8owrWq4oGhC0ybqMsNnT926a2I7NDiDIO0WNOAk3
         SUyyM+SF1O6+m19vpzWc+oCTO1VNmadjYUAn4ERqYrA7ANLIn7iigwaHP/UUDerddsOD
         bYs+yT+sJejmyMZMeQdVBnrMscZ9rAJKqvcVlkG7HjxljptNamPs7xFovEvkVFehplUI
         nbkvOyXaMuoAM3SKAuQpsS451DMXhdf2cxLM0DN6nWF9YP4omRYfHuVNZJB9RDLa3Kv1
         m5M3A1LLsmYwJJ/T69m5sZBCQmIkG8+oz5HdkrWGJQVapJdKfQQuxln6G5GMjw88s+Fw
         HReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728938916; x=1729543716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLiOJMlbQiOQsxhqpnja9W8p5wjHHPLRN1lJCefWKIQ=;
        b=pVxPOO1A2uxA6AZEeq7PiAj9brEL1yI5bXpUaUajDBgNbe3IgBSf9+ACQimyTtsCVZ
         erMdlp6WXl3oCAj2BDsQrNGKI2c7QAhWal3JU/yopZtq8W7WK60l6YKhWJmu3Jivn6oy
         Q6Q3Ftx+XZVYl4d3F0SGR2lYjousBek1lQilqU4TuwUqUcCf/b72yjh1l7o0ntRF2w9D
         jBEdEycuNCEg2NM3Y86MoG6yjOympW9Lvxs6gqlj7VKP9JIiW+AJxXYetHRwhAGzsnyN
         mN9af/Hh2Bi9AVANZ8iMkZlhB1Uk7YyxzvZB5qJE0crHJUwzdnQuT5AxZL4AvZoza6Vo
         Bq0A==
X-Forwarded-Encrypted: i=1; AJvYcCX3uukv5fdHAPufcRq1AvFxAogQ100hzm/bBSlM0OH2J5YbD9COj7Gc5u1lIOKgHdb43BPLRB5o7dgSgbb066LXZv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL1ogY+9Rpk2tHf4cWUDH2sayGtwzBUfwlPipS8OwPt5DDdn24
	qrNBd91kDQDAnGnDxe5UPQ912W55JqzuAWHpUvAUlkUntFbXFMJfSD7f4s7tX7hl+tznXRUrfIb
	pDhLOzHy7TuFgt3pO1+IcpnnpUDYjUwJRbCzV
X-Google-Smtp-Source: AGHT+IElWbl5AVByUDgVhkR4DJhOP0D4H2xXZYriU+tuWxs0dxelbS2co5cCS0cZFwpG8zDMPaW/VapnM4qXE+UzLNw=
X-Received: by 2002:a17:902:ea0d:b0:20b:a6f5:2770 with SMTP id
 d9443c01a7336-20cbce0d691mr4772125ad.6.1728938915788; Mon, 14 Oct 2024
 13:48:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010205644.3831427-1-andrii@kernel.org> <20241010205644.3831427-2-andrii@kernel.org>
 <haivdc546utidpbb626qsmuwsa3f3aorurqn5khwsqqxflpu3w@xbdqwoty4blv> <CAEf4BzYRiE9vYCRLmiRHD+fqb_ROwqrb0sX6sktqDNdfeH85DA@mail.gmail.com>
In-Reply-To: <CAEf4BzYRiE9vYCRLmiRHD+fqb_ROwqrb0sX6sktqDNdfeH85DA@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 14 Oct 2024 13:48:23 -0700
Message-ID: <CAJuCfpF+YeXVYuEuTt_XKFJuSbu_BxWU96znnfnwG6mMQC7ETA@mail.gmail.com>
Subject: Re: [PATCH v3 tip/perf/core 1/4] mm: introduce mmap_lock_speculation_{start|end}
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, peterz@infradead.org, 
	oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org, willy@infradead.org, akpm@linux-foundation.org, 
	mjguzik@gmail.com, brauner@kernel.org, jannh@google.com, mhocko@kernel.org, 
	vbabka@suse.cz, hannes@cmpxchg.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 1:27=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Oct 13, 2024 at 12:56=E2=80=AFAM Shakeel Butt <shakeel.butt@linux=
.dev> wrote:
> >
> > On Thu, Oct 10, 2024 at 01:56:41PM GMT, Andrii Nakryiko wrote:
> > > From: Suren Baghdasaryan <surenb@google.com>
> > >
> > > Add helper functions to speculatively perform operations without
> > > read-locking mmap_lock, expecting that mmap_lock will not be
> > > write-locked and mm is not modified from under us.
> > >
> > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > Link: https://lore.kernel.org/bpf/20240912210222.186542-1-surenb@goog=
le.com
> >
> > Looks good to me. mmap_lock_speculation_* functions could use kerneldoc
> > but that can be added later.
>
> Yep, though probably best if Suren can do that in the follow up, as he
> knows all the right words to use :)

Will add to my TODO list.

>
> >
> > Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> >
>
> Thanks!
>
> >

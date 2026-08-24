Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521BA403EB5
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570551; cv=pass; b=QmM7XDPsutNovdim+VEIAB3hOlAATYL/aBuPjA0zQYww4b9Muv/E/w/VvRSEZ22R7h6WSLNr96hDAlfTTyLH1VRPakhJVSpwXZ4M+71aRqo552M6dMI/Snv3ecXOEkz/ll3ezlPB3ogNFPdWrMS1k/mF5d0JmEVGwCpIC4B8m1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570551; c=relaxed/simple;
	bh=/0my3t+lF/CL2tBi99WPrBzsGUD/BsCNVNf5PeYgNTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lt2WOMiscE9EegeEilkgtJezwmnqPAl0H47Fll1tWUGHga+rPP5+lh+qHWm5uxkZqdPQOaT55H7vQ3fFMyKvWEXEtYWoj9EQIuzaIVIYpeffndSzy1Nh69cC2rN0OKclzoBXr1xOCsb0hlHSeQn1DSEb1GSb2S9g2wc6dlsa2R4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLz4Rr4y; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLz4Rr4y"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-80c5cb9a888so35466197b3.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 04:22:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787570549; cv=none;
        d=google.com; s=arc-20260327;
        b=EI8KZ33QbqVlnYkJ6qYA4k5p0JzIRvnZICzJTHH9X9agpq3EhIGvrJJSbr3j36NR2E
         JajtSj5JiD1jYyFprsXEWj5l7aIt9AWrLKl39cbh+If0BfizwYZDQyCCcTkfBGbkKfMT
         b+dWfTU0zghazSBehYzE05/lbJpBhSGdtCRnGYVtKRRJbWVCGvsko2KMAZpOCuKPUoO+
         ElxNA3TUS4zXhe9Nov2+ZEMiFMhO8c6OCWafjVbMOWfSe6As9tjlszhv5WpsMz3VXOGz
         HZ85qgCYVnibEbBU/q81pSHsdLyH1VS6A97JyYNSAArdDLgWQBTjXOOC6RYRTz3pPeDg
         L/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a7Hu8aS2tMxi0HUTc73kwEzJzh8H0U/IURM0mZn2fi4=;
        fh=qwqSfyPV8Gbz/kRySpdIIVPGVwxDn0OZjH0xVjlHdZc=;
        b=FQGWqvbKSAU0Drv9s6f1/pbhLgni8baQXAWUsSbTl7Gs0ZuT49MrONJGVba2I55c0V
         67X4bF7dGTq8lS8dLfDQR6Sm3vXVevauiKdi+TwNK9FHrOz1Xg9Fssf1X1osvcNgi22e
         u+TN+Xcx1ILdosgtiYPdKys5ZX5JzuyQKxMZmT2whCflU6hFKEFc7najZ0VRz8alVqYM
         9Ag8jzaWf+762SlPlBQS4Vp06ExmilhxdhmSwbmHIhyHcfS+kgbV04Ej5z88hM1tmd+j
         Ewr+yGrAOK5/8cyEwj1LXEzjZBXwNudAXY+P5DUuTNerOs/BstQRn7pMsoXsYAcMiX1a
         0krQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787570549; x=1788175349; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a7Hu8aS2tMxi0HUTc73kwEzJzh8H0U/IURM0mZn2fi4=;
        b=LLz4Rr4ylmw/d3dg0PhTA61l2aP/C5xNLIlCTjk6Ky23FerKnk/4bTUnqe9RrApKha
         uBg6y07mFcJu190HnVGZ+9U6obHsawSgxu6Ql6Cf75RU/swkpow6U4k6oVt/W0b4NJRB
         zaEt75vLV0m8Vwzu82HLkcLkoxsyWKwCDTl6DLhzRZ8W5lfwX6VkTxwF+qtujXJ1jX9R
         nRFFGN6PjMppL8aR+g/Fh2fPiDUslbHIjodCsPXlMmzNhRn0Qwoj1cAqfphF2U4HuikG
         zULG+zhlIVSBeZFM9F52mQHtVtFpmuoNncMqJ+ajg6og3w2ferP5NGIHlozdL5pXx40w
         nVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787570549; x=1788175349;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a7Hu8aS2tMxi0HUTc73kwEzJzh8H0U/IURM0mZn2fi4=;
        b=RJd5mb85RoE3DlKJFwwz/TCXfzCPcfqJPBd2+A/2hPN7nzCVCY9BiQV5Zk2Co8d55c
         UtdXd7y08w3EXKzYmM4OffKVKfttnB+paGnhdAiPUHp5+8uetRkaO+fMCVRyaTiSjDRM
         dAf3c408T4B4Y7gBHmBZOXbXPjfC1UqNSEXyzzZnYBcunH2WLYC65jamDgrSJuOxhNFy
         1NyR/Tma0Bk5wU+J/d1u/gUd+wNyMfm//Zlv7+TqjWpIIhXgLOpJtF/2cXA5YvC3A/fx
         6b8g7s6jFtolXYndOYKOwZJaUbb8fkLC1dlI/t4S9BJt2DXOZIxZL2t42wf0Xq1mAIX+
         Vk5Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq8irT5YbHg1b4Po7Ixa7NAYkt8F1J4fSOfzHqZHSMrNUnrfifd+EukHKK8UUvPNSWuSiJllox5YQNuRDNuwZ8ohtg=@vger.kernel.org
X-Gm-Message-State: AFuF++k9FhivkxJcEPuS/g/RBT+Zzqyt9ngt0pQwFRVgDvMEp9ySMdLJ
	UVN0PrSweNAsr26/jU6shSiAzUU+LRcgfAQHEHYyQ6WVAvtwfcSLk8ijgBRkf0i7WnMzSeUo9+H
	19O6XHAEN8gRvPGKxaZul8taOnl4RgAJLHWt5fLw=
X-Gm-Gg: AR+sD11pAFr4R3LggwIDenGNg7Bs6MszjE1hbsXzRxgauQ9YhE9sSB7uCgfG8/BBGgo
	uC4LAldKSB69AfXPDQmsLZ3KRgxiSVa04eD/aEP1lTkm5Y1OKFN6H1bKU0gTUZGSdXTQzc5mMBG
	a/uOptCIachTge1jVvQTcm8lDHMk4T1rudqOovDHz65ywaiLydOXvpvdQl312uyf+rrNjSyNlSh
	2hH5y5CMeqKBLvsVBv1dErPulG8fBqz1Fh31e9VZEdmQTGxDyDmf8XU06Ky3ZrMd2e7nJnFm2a3
	9Slq3FII10wyOo4QoSsun6kGTvdRlTw/LPYpBeSTTKkJpRU=
X-Received: by 2002:a05:690c:c423:b0:80c:76fd:f732 with SMTP id
 00721157ae682-849f6a957a9mr78206597b3.26.1787570549300; Mon, 24 Aug 2026
 04:22:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822054620.452262-1-ming.jvle@gmail.com> <aosT4H14zcowzU_7@redhat.com>
 <CABbwK50esft7xj6cPWXN7iHnqW6E30w1Cg5FMmE97gJ34SqtfA@mail.gmail.com> <aotM6tRUHI9Bo7gW@redhat.com>
In-Reply-To: <aotM6tRUHI9Bo7gW@redhat.com>
From: Keke Ming <ming.jvle@gmail.com>
Date: Mon, 24 Aug 2026 19:22:17 +0800
X-Gm-Features: AcwNN1X5o6OEgGW73-QMaSvUJll9Em5qhnHqT0sH4wBhQMCp_avkxk205HuEKP0
Message-ID: <CABbwK50istUW_xnFsjCA+MMgFCuBbY-Zs3QmJU=Fg7heqKdF6A@mail.gmail.com>
Subject: Re: [PATCH] uprobes: Free utask on dup_return_instance() failure
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 08/24, Oleg Nesterov wrote:

> Hmm. It is not that I think "it is not enough", I think this is pointless
> whatever we do.

Well, I didn't mean to insist on the cleanup, I also think it may
be redundant. If the child is bound to exit, manually calling
uprobe_free_utask(t) in dup_utask() is pointless, as the normal
exit path will handle it.

> Yes, this is what I meant. But this is only the first step to cleanup
> this logic. I'll try to write another email tomorrow.

Of course, I'm all ears.

Here is my current understanding. One thing I am not sure about
is the signal semantics. If the copied uprobe state is incomplete,
the child should not return to user mode with that state.

Option A:

```
if (dup_utask(t, utask)) {
  uprobe_warn(t, "dup ret instances");
  goto kill_child;
}
...
if (!area) {
  // whether we also need to kill it is open to further discussion.
  uprobe_warn(t, "dup xol area");
  goto kill_child;
}
...
kill_child:
  // I was thinking about SIGKILL here because it cannot be ignored
  // Of course, you can correct me
  send_sig(SIGKILL, t, 1);
```

Option B:

> Note that uprobe_copy_process() warns but returns "void", too late
> to abort copy_process().

Looking at copy_process(), uprobe_copy_process() is currently called
after the "No more failure paths" point and after the child has already
been made visible through the task list and pid links.

Would the longer term fix be to move the uprobe state copy earlier,
before the "No more failure paths" point, and then add the needed
bad_fork cleanup for  p->utask?

Keke.

On Mon, Aug 24, 2026 at 3:41=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 08/24, Keke Ming wrote:
> >
> > > Note that uprobe_copy_process() warns but returns "void", too late
> > > to abort copy_process().
> >
> > You are right that freeing the partial utask is not enough.
>
> Hmm. It is not that I think "it is not enough", I think this is pointless
> whatever we do. Please see below.
>
> But you know what? I am afraid I am totally confused again, this happens
> more and more often. So please correct me.
>
> > Would it make sense to keep the cleanup
>
> But again, why do you think it makes any sense to keep the cleanup
> you propose?
>
> > and additionally send
> > SIGKILL to the new child when the  uprobe state copy fails?
>
> Or SIGILL like the rest of uprobes.c does...
>
> Yes, this is what I meant. But this is only the first step to cleanup
> this logic. I'll try to write another email tomorrow.
>
> Lets suppose we change uprobe_copy_process() to kill the child. Then
> why do we need to call uprobe_free_utask() in dup_utask() or do anything
> else in copy_process() paths?
>
> The child won't return to userspace, it will exit and call uprobe_free_ut=
ask()
> itself.
>
> > Also, should the existing "dup xol area" failure path be handled
> > the same way?
>
> Yes sure. But perhaps needs another discussion.
>
> Oleg.
>

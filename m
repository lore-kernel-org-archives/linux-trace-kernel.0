Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80581B5804
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Sep 2024 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725885359; cv=none; b=S4SUW4LO+2Ou56FbUURUIuOI17J5mRFyQbVizPOJG9f/s8nI3pOjvF/EcyqT8HNoESRnv3XYRAFlWwu12I91ire5PK+Rt883YBNOEs6YtzPncwrloq7eghrIRE1zULzBSGQCYRx8A0EXdVTV1d3qVLmWhsdBMC92ctMxdpl8cMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725885359; c=relaxed/simple;
	bh=MA+HcgDvLW83Ymxu9IsChq33lTehtLFFHUfEU4mQ44Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJCbKPW1tlv+LNPhdABuaISF4roIKZdAz+kNeftnsL95RzAReeDyXkYot7gffa9Civ6aKXgcxC0rvcNTi5y9VlNjMD4jxvLDnzHVrLBk4k+GRAMZATwHEcXYy2umM4UMtiyDy/VIBDWbKTZxov3PDpZ1/VfpArLJEvHa5nfJCvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lCWnd3za; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lCWnd3za"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53661d95508so6141e87.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 09 Sep 2024 05:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725885356; x=1726490156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItkNpbg3b1iQLTwUvcYvCzK1VuBRAi6YVDO131ItVjs=;
        b=lCWnd3zarZv4fjZ72QoKr9Lni7taADtD/ZhigDT/oKQ1fmf99uYTKFtN4nQaXpDi3z
         p+kLijj73kNPgQ16M3HNc1XqgD7m4z+lQqoUeHVQ1bJ+WG0eTl4TDNEjzdPDAwdgc7Hy
         0BN1XnZ9FbsUC8DmQP8xrWLk1dM8pAo1TZT0NoQwX//Zp6YLmkcsjbeP10oOAqzwFSn+
         OJjHQiRTXjpPYftezBK3LSFqGj/KfCeQXN4PxaoqBGqCK08Ten/mqs3a05VoRa8pnvip
         wg7+8DiIuD0hxTleV5fAYziZMQY4EsLeiWC5u1m39W5xTmZTicLnBkYOKQ6IKg0e4jw9
         g1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725885356; x=1726490156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItkNpbg3b1iQLTwUvcYvCzK1VuBRAi6YVDO131ItVjs=;
        b=A++sBDn3vIuw9+SJBXIvjSeWG8b3F7shJJ+ls7RLNoH517TBTW1eMKNzpgpJlriYYR
         bZxTCVKy+8irHQVNCtWkcPhzenZEp09adic+Jgec/FEHTmyPiAvY4EOwztwaLsOuNFhd
         NikL8nHLkLyqjO2ZycPw9ebnDoziFcXHDygFiHLikrsK2Mz4NnEGj1o9LpiX2Z7bDJis
         /lzuoRhZ53dUV7mpdbAaaHn+1yR2lUPrjW/x/CYuELXmaQe2pSA+3PfNgfa8RYcgWTEM
         LkoSdzTNSfIUIzlv3011/O7hg1FL08/y4Qbkwo/S1SqyshqPFvYsQc0gMqKvUKDI83Ry
         ZT1w==
X-Gm-Message-State: AOJu0Ywu/Qs1CIPdP/nmKo3wcdLKZcO8mVF50Rk60QpCMzHyBLtxMECF
	FsGvG1mU/D81y7gSWs40ymj5UnezCG77bd3+ftjt/+YMSsxo0cHxIuiJ7+tKw00OPNN4CjvzS1f
	ZVhX9nuNQy7FSnAm8okXfx148SJWH+sOsSYCW
X-Google-Smtp-Source: AGHT+IGGsTOsKMOzuVujWW/9F9gatm28KzGs7KuJZ0r/H8oFsyXYru+A8pCPf172NNXYDzQoEw6rG6CU7Y501Yf4VYs=
X-Received: by 2002:a05:6512:23aa:b0:536:52dc:291f with SMTP id
 2adb3069b0e04-5365eb6a2f4mr188381e87.1.1725885354776; Mon, 09 Sep 2024
 05:35:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906051205.530219-1-andrii@kernel.org> <20240906051205.530219-2-andrii@kernel.org>
In-Reply-To: <20240906051205.530219-2-andrii@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Mon, 9 Sep 2024 14:35:17 +0200
Message-ID: <CAG48ez2hAQBj-VnimJBd3M-ioANVTk+ZQXYWD+j9G+ip2K_nfw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: introduce mmap_lock_speculation_{start|end}
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, mjguzik@gmail.com, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 7:12=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org> =
wrote:
> +static inline bool mmap_lock_speculation_end(struct mm_struct *mm, int s=
eq)
> +{
> +       /* Pairs with RELEASE semantics in inc_mm_lock_seq(). */
> +       return seq =3D=3D smp_load_acquire(&mm->mm_lock_seq);
> +}

A load-acquire can't provide "end of locked section" semantics - a
load-acquire is a one-way barrier, you can basically use it for
"acquire lock" semantics but not for "release lock" semantics, because
the CPU will prevent reordering the load with *later* loads but not
with *earlier* loads. So if you do:

mmap_lock_speculation_start()
[locked reads go here]
mmap_lock_speculation_end()

then the CPU is allowed to reorder your instructions like this:

mmap_lock_speculation_start()
mmap_lock_speculation_end()
[locked reads go here]

so the lock is broken.

>  static inline void mmap_write_lock(struct mm_struct *mm)
>  {
>         __mmap_lock_trace_start_locking(mm, true);
>         down_write(&mm->mmap_lock);
> +       inc_mm_lock_seq(mm);
>         __mmap_lock_trace_acquire_returned(mm, true, true);
>  }

Similarly, inc_mm_lock_seq(), which does a store-release, can only
provide "release lock" semantics, not "take lock" semantics, because
the CPU can reorder it with later stores; for example, this code:

inc_mm_lock_seq()
[locked stuff goes here]
inc_mm_lock_seq()

can be reordered into this:

[locked stuff goes here]
inc_mm_lock_seq()
inc_mm_lock_seq()

so the lock is broken.

For "taking a lock" with a memory store, or "dropping a lock" with a
memory load, you need heavier memory barriers, see
Documentation/memory-barriers.txt.

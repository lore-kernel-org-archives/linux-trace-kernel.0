Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792694561;
	b=2neQxL5T0dasuM4wfil5f77TCGMHcpBg0RQQSkcAsiBbKJ6u9lutLT1TUxSJo31c8stJ
	 wy3rAIbCwJAtKSUNk39LmVshyqEr2hAc4p5DOw2rSWpPjxE4eo8t0dezs3TyGVJ0xUe9x
	 xBzTorgv1Do/j8hm1AyXg8eHKKnO4heDP6k4dXcxj7ENjmZPoTsqC2YcLdUVb4hBH7wnK
	 2s4f5eZC9U8lZN9v0kDTzm4i3fBVoKvFfZT+YO/SLM8tj3jt2vVy+zJlOjJ7GfuINGFPV
	 hRK4yFDSKxxdRAAa9FtWMVBt9hbKlLL5mbzWS1EcpA0ac5ur7C2m/VHSnZ0YEkcRs7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IZ/uBrhQVS3DiMAnoAWQ1amBgCkO8xqm7sNIOjhR87M=;
	b=mEj+EK13NYb/etLUP2y2UKZz1O4d0MUJgrCEjTCLlMbbWHVTQW5WGGn/D6eNz51fi3tp
	 d6gs18NvHfA1MVFVbf9RbKVRlt1rTurpcg3R9hnmhXfg2T1AiHYodObMiQToZsjOjxMrL
	 d7/n5sPCXyFvnk9xk7xoIAkIYDGQH0ef/hwmXULsJjb9lIMhjOCktDsb+14A+CWICde+D
	 CjMbHlNeQPQTYkb5lpUPMGFUgEnF4LBpzptyN6fLHLFkHWpGSNWprrwnVo2073uA/J5Lr
	 YtWIqvnXqC6Wt1diKPXAbdEaMb510r2vVHU7mReTRE6Jhf9G/VHa7TmuLV9e/AvzT0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=AjYjOo95;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F174606A31A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 18:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F174606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=AjYjOo95
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2db33db4de9so10525ad.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 11:42:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792694560; cv=none;
        d=google.com; s=arc-20260327;
        b=TVtxHKr4HcEnO44TexXO7bWWkjo0L88BsARM1BVpY/3nQ/Ee11BaFI+anUOKL/3qec
         XGZi1+3GiCI1QR1nWsZRWD5bv5P0Ou6t1IwSSU2zTrHLWtqV5Gmh74zN0UY2sPGd3NJo
         um1TeUZkNtsHNtLd5WuZzs/V0Wb0YLBaAgeXuyxwhQ6YTgOoUqx3HXVvK2hlJeV2J73r
         O7+M9RByARtE5QgeizpuhLAwTqSSK2znj7MhnQYPExufplsUa4+6Ucu+WTx5YbaZQKC3
         gNupBMh+/2bNmajtRG88fGvG3SI0qfgEp3/P8azwpaHI5iI1YLHJvRbXoUASo6yzJ0Ft
         Wb8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IZ/uBrhQVS3DiMAnoAWQ1amBgCkO8xqm7sNIOjhR87M=;
        fh=vfOXcOedcQuhF0TFxp5LTOMRu7Yns9YDmFNzIvXCIzo=;
        b=pAaF1kZ8APpI7587I/PSZaeVZjBE+q9RCVvKxtBSYKPIDCcKm3lt9nEeeEI7+LR9cj
         hcvveZtuyX+6aiW5wIUF1bVg9RV/qpApK/joesTwhcDvB+Zd+n8fgsexuw/LSoUkxIs+
         Vn3578LB/CfOEu88VDyzTOW8Z9Xy5o/Vi2Myz7HKJuWB0vXjqp6mvluepkBn4XybjOd9
         l98vz8ZLgHYqFGkYK76bUq3GiGM0kZ/Y4lVVZXn24ocOpqo+M+goG8dab0WqoKVk0Sz0
         b14705w6ywtcAqvYGsXdeDw1meGSoPgATaCrS1ATFV795v8gnh+SsAmE6duy4ucEh+v+
         GwQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792694560; x=1793299360; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IZ/uBrhQVS3DiMAnoAWQ1amBgCkO8xqm7sNIOjhR87M=;
        b=AjYjOo95jj9xl9uSAdDzx0lnWrtlNBZWVfl9eonPSAZ/h1lQzGvwFUWLmI5y9N7++6
         nFHrpq9j6kdMPdO23m1pe8o+I6ytXCHDxTlI75nRCMiXl8D9WwnwLSQoHBx/3gkP+eQ9
         Ub0l1IrPaRGKNw6Z76jwymKiHpDfTwUMY77wsCTYQut7XKep0Chvd9qwb3Ote/0nFNO+
         uD5SL9oRjLepnNBGR9QKeEhpLzGIFu22sRP0R0131eZyl8P6yi1s+z1RyKaxiSHEHR+w
         aaXEbbLI49NZveiQ+EXzb40nSZWe/kGH9H9Tv68s8wOUdG5ZeQ1DxPSxJRGSIijkeX6G
         P7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792694560; x=1793299360;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IZ/uBrhQVS3DiMAnoAWQ1amBgCkO8xqm7sNIOjhR87M=;
        b=pbqInqKO0J1sBFQAoHPwDj1039NA994d5bOThiSCLqMhdp6KNP2+eLlC9QnUKMEGf3
         1rqJXRr+13Sj91RXBq+5t0Bg7EsET7NS2I80CVb51cnqK2Agq8FHFbUJlbV2XliYEEsG
         h+WhEqiF2KfzDL8FUApVcyLTyuZ74IIpU0mf4wzroxLJ3X22pt1k3zhQ4JS4OBeuLyUh
         YbNxh6m4ThmyRoXgXX7jH51lHGAW2EXpp74if6yg5ABC5nxlC7sMFKZuG2jPZqaZ13ww
         QWFyl2oan9IuwM/o9iZgZObRecBJynqPaLecZVwAUo3AhSDjfHVS1ZtN4zSQKL8LhOPG
         MEsw==
X-Forwarded-Encrypted: i=1; AKwUvBzon9egFH7FdApP7QHH7OJ8mBfAnCOLYQJHMbVB6PlIoVBPTKwcu42MPoqmSknhdHiynOoOkvTc46+UmfA0sRaWmgg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIUrX3rPzXy+IoY4Ec3qcOf/QqfP8HmFAUIB4X/KLDYbgF4NsFO
	pXtmY2ybZdLmAa+5+/3ev8ompQXRwjgKv2liihys+BAeYQwsD3CF5/ftmwg+MsU5Kn6H9JqZWRb
	eP3F3q5DPJUoi7e9p6Br3TgidGVaFF0JH7TSuAyud
X-Gm-Gg: AYBFou2x5LKdlJQ0BC11mGuZm6g5YXt1+SaD9gzG+Kq0y7cbUVHq+TrR7ezmGjdg889
	Q9veUT4+l/o5tMpflNLEjR4fDX2HvhpijOZOjct44rwktA1X4EVaJp7i9L0W9RAQpsTQE2yZP18
	GlSPvXqL8yiuoaD3q+FhWtiWFod1cren2Ffq5OHLY1dGs5blWgBFtAt0Cb9oynWIGmEFYgUCKHt
	uNo09Ezx8bi2+2J+VQ3w1MZYmj+dLA/co+q18wTfjRDRKuj6wN4tOXjEo2rARD81ReAtBMe2wii
	enTnH6Q6VitA9PPS9q4URGjGKiXCrvFEJv9CwPgzc6K/tS1ISHAbvrXNd81Zk8NbtvwEVPWTGMp
	EKMJVxrukRBEE3BtSbnv0dgFyxEKZF3DFMhqhCsjYFYRZh2TwI/7mEuS4DXFnK2n2ReJ3rPOKzv
	WqXI/qW5WbUzhl5F+J3STyCnYQFktpSaXfXjjm5Wbxk34=
X-Received: by 2002:a17:903:98f:b0:2e6:12af:5b04 with SMTP id
 d9443c01a7336-2ea7c74bcb0mr574065ad.0.1792694560033; Thu, 22 Oct 2026
 11:42:40 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com> <20261022015712.1297331-7-alexei.starovoitov@gmail.com>
In-Reply-To: <20261022015712.1297331-7-alexei.starovoitov@gmail.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 22 Oct 2026 20:42:03 +0200
X-Gm-Features: AclHuK-4emBvKnbiUXwxsP0RzswCumffVqYk-pDdBlhbp7tQ8eLavk3E__t9lUU
Message-ID: <CAG48ez28oYxMAxJaXnYtT_8xGReS6SLC5vURw4eStWpuPsSSdg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/9] uprobes: Don't sleep on mmap_lock with
 dup_mmap_sem held in dup_mmap()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, peterz@infradead.org, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, oleg@redhat.com, mhiramat@kernel.org, 
	jolsa@kernel.org, akpm@linux-foundation.org, liam@infradead.org, 
	ljs@kernel.org, surenb@google.com, david@kernel.org, vbabka@kernel.org, 
	hughd@google.com, kees@kernel.org, tglx@kernel.org, x86@kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 3:57=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> @@ -1713,8 +1713,22 @@ __latent_entropy int dup_mmap(struct mm_struct *mm=
, struct mm_struct *oldmm)
>         LIST_HEAD(uf);
>         VMA_ITERATOR(vmi, mm, 0);
>
> -       if (mmap_write_lock_killable(oldmm))
> -               return -EINTR;
> +       /*
> +        * Take mmap_lock of oldmm and dup_mmap_sem of uprobes.
> +        * Don't sleep on one of them while holding the other.
> +        */
> +       for (;;) {
> +               if (mmap_write_lock_killable(oldmm))
> +                       return -EINTR;
> +               if (uprobe_try_start_dup_mmap())
> +                       break;
> +               mmap_write_unlock(oldmm);
> +
> +               uprobe_start_dup_mmap();
> +               if (mmap_write_trylock(oldmm))
> +                       break;
> +               uprobe_end_dup_mmap();
> +       }

I guess in practice that probably works fine, though in theory this
locking pattern could potentially lead to livelock?

Like, if two threads T1/T2 both try to acquire the locks L1 and L2
with this pattern, you could get something like:

Thread 2: lock L1
Thread 2: trylock L2 [fails due to contention by a third thread]
Thread 2: unlock L1

Thread 1: lock L1
Thread 2: lock L2
Thread 1: trylock L2 fails
Thread 2: trylock L1 fails
Thread 1: unlock L1
Thread 2: unlock L2

Thread 1: lock L2
Thread 2: lock L1
Thread 1: trylock L1 fails
Thread 2: trylock L2 fails
Thread 1: unlock L2
Thread 2: unlock L1
... and so on

In practice, it's probably fine as long as SMP cores don't run in
perfect lockstep...

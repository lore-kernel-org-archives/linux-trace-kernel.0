Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6691CAA88
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jan 2025 21:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737669188; cv=none; b=bD+c4/33bLhqhh+c0VTyGl4x9FvCLc4VrIUqxhk+b/HxUUjgmljxCFOyURw/1dQNXAiofsWzn7gMpFh3MKgEI3WP/KNqFrAG8KLw5FBUAlf94A1owg2IHiw9XVv3Ur7OgOtQQnjFNq//satsywtR4snb+OfvG8AzHn7hfvQVwrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737669188; c=relaxed/simple;
	bh=zKuaqHe3ECZ+QZJ2plP1NWcmvneXigvDjbh4dDIey84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QdptlpDIEYO86rkVZlbEKJ91ZNIOXyQX5d+u9GSPoHfOGiNrn4lvQvIljZrfiYmtDVA5vWauDo87hDyC8d7fXOmSgtNGl42VaeXLofAJHJaIVIuD8GOrBIJGWFI3AEwS0VjJk20ffk7BVAUADadExZQwPfSVgnxx2GVe71u9mEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mZrSJIX3; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mZrSJIX3"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-467896541e1so69991cf.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jan 2025 13:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737669184; x=1738273984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHGt0WbleYB5l+m2dLlfWbtdjxWYo81KWqBel+Isirk=;
        b=mZrSJIX3jKSn/SHtCgZOyvB0W2eF33yPdj6WsAfx1FQOv9U+JNX8wzB/XIBa73PAr0
         ReJgkrba1SMbpMf+YPbj085qMjHuiDNW1Fps8sfnRKe782rU73DM+PnAeJad7QC4tNEV
         qve0/jSI7suadkwhuSBsRYK38xm+LzgjVMKY8IxEtlr0XypAofSFgk85e3SSgZGdlUMK
         3xUz1xtKofOHLeQmx+wWESdkisDS3fsmzRYg1/f71zUFMQioT5x+bo6vJd1OiKhARcdG
         aJoFd/+t88ir3ai/DG+OVXhw4ZpUGfKxqxb9oXi+fTpN1BMAH9kEZ6JzLUJSoRHakI8z
         YIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737669184; x=1738273984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHGt0WbleYB5l+m2dLlfWbtdjxWYo81KWqBel+Isirk=;
        b=iC6wKmu8E2Qg4/MmrML4W+eQSXuxK4uUBIKwW6KIRzXJp2+v42JQmbVqmd5NAs5Xet
         Mj9QSAkWKLGRfPWLvifxr81abwzjqD+qnW5EPK8BRN+8x2cMV+EPbtgOGZzHifABZeiQ
         ymbjbV3RRbIgXqKgytfZdD5+MpD3rKULTA91z/no1BgjI7efSB/VeRT5hjAhfMbEOzty
         xnJf1UcL6igRfnBLRHsddGzGMkivYvp/zWNpegD0U2x82C4iVHCcwitFAlGfB668mN+G
         CIW+l2PEsaFfPymEk3Iq11Q1UzyuhB5qMrvLf7avlAdvsovA8LJC1bAQq1CAv/A0eW4F
         jG9g==
X-Forwarded-Encrypted: i=1; AJvYcCVlTW6VQY12T3dyMeg2qCUm97UZ+8v8Zou8ClPE/KnJ3nk7c5fAFThhrPCTStf7Ut1QT6+97coDdGdybfze+xbG2QI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLgQ8mXMw8Axhsm2Ez3sb9MtasA2gxkRAssY0Tw/NnrWPz8lz+
	21TVB58BLV/OMW2X/mVfnbrNZjdBj2Lx4pnTiWB1xUZopSqdQ92qJjDWu5y3fT768vhPbMcgYks
	6NXtR34x1I9iyLKGX+VCYjWQNSJgHR+43adWq
X-Gm-Gg: ASbGncvJ5DbrG4ozTl791d0owXDZpguSFx1jr4iumWl9l1LjB69DZVjbmVHVVDdVIpU
	IbqPgzEurRPNgKRE5yeLX+ChCXEcjyb1Ya2wOp57zGgRhj51lU06PCCXD5Ue3UiBFohN4oDgPY6
	TWcHjfcY8FHDd2iyOZ6jbTBTjanms=
X-Google-Smtp-Source: AGHT+IFrvyD1YIeawr10Rqwn0aqWOnQMagnJHkBqii3YUgDR1PE9AGJ2YTglhmvCvF2LAkLUTFvBu1sN/7u/Lgk0CGI=
X-Received: by 2002:a05:622a:1aa6:b0:46c:77a0:7714 with SMTP id
 d75a77b69052e-46e5dadbf65mr4804111cf.21.1737669183862; Thu, 23 Jan 2025
 13:53:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123214342.4145818-1-andrii@kernel.org>
In-Reply-To: <20250123214342.4145818-1-andrii@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 23 Jan 2025 13:52:52 -0800
X-Gm-Features: AbW1kvYitEyfLCjZHD7-lTTvjs22unJX8NoVKvDf4fLvx82SDzv6eFu65vu0VC4
Message-ID: <CAJuCfpE9QOo-xmDpk_FF=gs3p=9Zzb-Q5yDaKAEChBCnpogmQg@mail.gmail.com>
Subject: Re: [PATCH] mm,procfs: allow read-only remote mm access under CAP_PERFMON
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com, 
	rostedt@goodmis.org, peterz@infradead.org, mingo@kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	shakeel.butt@linux.dev, rppt@kernel.org, liam.howlett@oracle.com, 
	Jann Horn <jannh@google.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 1:44=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> It's very common for various tracing and profiling toolis to need to
> access /proc/PID/maps contents for stack symbolization needs to learn
> which shared libraries are mapped in memory, at which file offset, etc.
> Currently, access to /proc/PID/maps requires CAP_SYS_PTRACE (unless we
> are looking at data for our own process, which is a trivial case not too
> relevant for profilers use cases).
>
> Unfortunately, CAP_SYS_PTRACE implies way more than just ability to
> discover memory layout of another process: it allows to fully control
> arbitrary other processes. This is problematic from security POV for
> applications that only need read-only /proc/PID/maps (and other similar
> read-only data) access, and in large production settings CAP_SYS_PTRACE
> is frowned upon even for the system-wide profilers.
>
> On the other hand, it's already possible to access similar kind of
> information (and more) with just CAP_PERFMON capability. E.g., setting
> up PERF_RECORD_MMAP collection through perf_event_open() would give one
> similar information to what /proc/PID/maps provides.
>
> CAP_PERFMON, together with CAP_BPF, is already a very common combination
> for system-wide profiling and observability application. As such, it's
> reasonable and convenient to be able to access /proc/PID/maps with
> CAP_PERFMON capabilities instead of CAP_SYS_PTRACE.
>
> For procfs, these permissions are checked through common mm_access()
> helper, and so we augment that with cap_perfmon() check *only* if
> requested mode is PTRACE_MODE_READ. I.e., PTRACE_MODE_ATTACH wouldn't be
> permitted by CAP_PERFMON.
>
> Besides procfs itself, mm_access() is used by process_madvise() and
> process_vm_{readv,writev}() syscalls. The former one uses
> PTRACE_MODE_READ to avoid leaking ASLR metadata, and as such CAP_PERFMON
> seems like a meaningful allowable capability as well.
>
> process_vm_{readv,writev} currently assume PTRACE_MODE_ATTACH level of
> permissions (though for readv PTRACE_MODE_READ seems more reasonable,
> but that's outside the scope of this change), and as such won't be
> affected by this patch.

CC'ing Jann and Kees.

>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/fork.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index ded49f18cd95..c57cb3ad9931 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1547,6 +1547,15 @@ struct mm_struct *get_task_mm(struct task_struct *=
task)
>  }
>  EXPORT_SYMBOL_GPL(get_task_mm);
>
> +static bool can_access_mm(struct mm_struct *mm, struct task_struct *task=
, unsigned int mode)
> +{
> +       if (mm =3D=3D current->mm)
> +               return true;
> +       if ((mode & PTRACE_MODE_READ) && perfmon_capable())
> +               return true;
> +       return ptrace_may_access(task, mode);
> +}
> +
>  struct mm_struct *mm_access(struct task_struct *task, unsigned int mode)
>  {
>         struct mm_struct *mm;
> @@ -1559,7 +1568,7 @@ struct mm_struct *mm_access(struct task_struct *tas=
k, unsigned int mode)
>         mm =3D get_task_mm(task);
>         if (!mm) {
>                 mm =3D ERR_PTR(-ESRCH);
> -       } else if (mm !=3D current->mm && !ptrace_may_access(task, mode))=
 {
> +       } else if (!can_access_mm(mm, task, mode)) {
>                 mmput(mm);
>                 mm =3D ERR_PTR(-EACCES);
>         }
> --
> 2.43.5
>

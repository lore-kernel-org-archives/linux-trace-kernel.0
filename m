Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4118283FD4
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 17:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779125973; cv=pass; b=XwriIX/sw0zvhlbqZhHOpEiMmHWyT9M/nJ6qzZOlk5qdmMDlxhQvVC0TLSDeOaaUimtodJybxeSY+Q8yT+48enrAdMJ9k0g5zkq4Z+fj55KVTFfnXLCAMYiuK1lzIvksJDgTeKjS8wOI9GOp5N4rai+rE+62qmAbinq1V92k+Ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779125973; c=relaxed/simple;
	bh=aPWQJbWILXW2i3R+ONWIGBZsXGofUidSdKL6B/NJEWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gttXrpwZPfhW51RVuIqbg4brZ1ekPhazX7NCCTkAfOZj2pLW8xpVH9ZeXngN3GHTl40TFmtmh4P25jRwcPV2KeDQtgc8s9rdNMV9EFEQhJU3QW6RBnR0++YhRzHbruB8/skXxSWqOuqKuWMXlP0WwWU6tJfyP5ePEOapW34v/Uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7VqZKdS; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7VqZKdS"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2bab82d75fdso11889235ad.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 10:39:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779125971; cv=none;
        d=google.com; s=arc-20240605;
        b=HRNNR0CkRvbzwherHIzpI/SnqGgsV5nuX+tOWLEHia6AtoCYYSWQw88h4QlGOT9sY1
         qdUaygypbrxL8JKQ7pMJ6X+Uoixz+CVXPZuJNgGlPky71mX4j+AhszkuvMvMpURZalcH
         06NSn7qJ7QES1CCAGqX33IvIp/XD8KfcrFEeKT/YjWrRSa6n+6Xt/hJf9s+57ecfg9ow
         +zIN8pYapj8zOw4d6DnZpgn8nLVMaSLbK5I16BeSMZB72HnV5jSMvTFenjFHcq4M29Fu
         7x3eDNNbIbA7s9yJrqNv6DjpvoEUWvzPmvErVvLOzOAyIKis1wDd9z6Mo0RdSjjtmjPa
         gmAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HHqCGvY/O+5u0ZmGB0C5bqEKmgKCYPaaY1uI1EEOomQ=;
        fh=KMCqACLQU29iP6ychaSiVJOygMuo95/MnE6jh57cqNU=;
        b=FwVxYdpXBEMJqsU1ipBfTA5PUqH4hDMjPSCf6GPdcIoCPABJcp1JNCds4ai7EE2US2
         vP9h6OBuLYJW+8vnOwp5htxUbnsh24KuPLLmF21Ze74chDeNxathHBWLh6S1lSrMvJiE
         cIwHi2kFwWZE71rKUqipTv9Y3YgpuWTcePwGPf0X+S8+K/T8/BjwBb/CEV9tVD0xCkik
         h5s2ghtMZ5MceFemVepE73rRPwDVQBIJl0dPzkPNq8sajUWSkL+Y5oNRAH9RNgQkofQL
         k6bw37d0h6Tzl2TXnZvfc+UXm9Wo5vMgohUclbcckMWtDs3tSNCuYKc95gDhxcgUF8on
         IaUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779125971; x=1779730771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHqCGvY/O+5u0ZmGB0C5bqEKmgKCYPaaY1uI1EEOomQ=;
        b=W7VqZKdS2CN9mICv4m1zVnAdM+2/OVPHWmkS3XNjD9AYhfLWcreiGQDYkVXMceTGCc
         r2Hvah/qK4JFBXuVPUbJpiTpVGo/nYvO3ng2LH//V12Qgcp5cPQzGFq1qSYYPz30i/g0
         aIa8pRQ83qT6trLUF+xz05yM11bx4EtM3c2wQxfBvb9mFhJg2XnngN0b8tU4ItJJDX0L
         uLioIhJvcPjL8/aJl5CMWwt0fizqbBl1i/om4URsZazHS0P5lao/JzB8szvYst2woonQ
         uHg3Qg9XeqAg1ieFDkBOzEe7YX8C4IVZxCNnceQ9lyddnP93pq8qvlj7zzJMVGsKb3PM
         fJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779125971; x=1779730771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HHqCGvY/O+5u0ZmGB0C5bqEKmgKCYPaaY1uI1EEOomQ=;
        b=ii1zOxL0qA5kixK6CF0TapVEgc350poUb+XscmPks+3pUCnyTEucuVZ442w4PcqCof
         LIPkrsFOE4Gi45OTVq65M6j9hCbWrSt0GpVV19AdLBCgceg83beXAbuNJRZEB7muoF/K
         Fi9vSjRFBuyFeeQg+OrZjwHmL/HWubkZaKCCwLoLOkS6obJAC9/mrZQlEA9mYzhnSGtp
         XtkYCGMjGaAe7ZUJRxJICkUzsRp/S9EZp85XilxLQ2hfxfvTWrGny3RrZoac7DpNQuRc
         yx66RduVfWvt8xJJPQhjH8w5qPLRucApW4xLcvbfaMRg5Njpg6YMJrsRU5OQSS6e5Ap3
         18eQ==
X-Forwarded-Encrypted: i=1; AFNElJ9PNGBiHPI0ZwiHnSVbw0uCHh5uMy2h+dwmBwik8iaNISmZZiGOQJUbsBKxEyQIr0z80ckt9ALRV2FTsTkZCigYtPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUqam9e4dvGJPbLE/uclh0skIvv9TcrlOnYbU2JJiQJi4nERyy
	Yhe7AQgSbGUeSmVCmjSCoa15SDno4lF2Wd4Y5I6o1sHe/DxX9he3oDpLioG5yPtPyNb6TDk2F+7
	oKBWkIi398dNPWeTH2iCQePaoxZSi+HM=
X-Gm-Gg: Acq92OHjqyIzCXwPLmz3dALvYerOBna9vaT9vfSSbJdUDcjmntzpEEHQq62dq9t8YTN
	30JxxEA2xZHYME1Kq8JJDUoneDOpfJEDZUoA9LFEscGp3CQnJCsLxrjvgzlnLUNDbZmX9AmkqCE
	1Ire7R8JOZ7bmaDfdhhtRebxM475CcewMlaVhGohLAUSWxk1xks8+4JTBiZh9o2BTI9rHRjTAur
	Zf4Kx5b+E12xXfmC8HS0RTLTzxxjOOlxZm5w99pck3/LUR5qWfjtldsHB+iCnlPLw7+l80yRBPd
	5Grpy27iKJ2Llg2dvJipT2M=
X-Received: by 2002:a17:902:d502:b0:2bd:9b0f:5f2e with SMTP id
 d9443c01a7336-2bd9b0f60d2mr137231485ad.22.1779125971257; Mon, 18 May 2026
 10:39:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518105957.123445-1-jolsa@kernel.org> <20260518105957.123445-6-jolsa@kernel.org>
In-Reply-To: <20260518105957.123445-6-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 18 May 2026 10:39:16 -0700
X-Gm-Features: AVHnY4IfzfH4rplKUJQ-s69e9XK7XipwV-1i2Q2kkUCiJKoRdqL4LE_RrV-IPP0
Message-ID: <CAEf4BzbzjCuWM2=g4U68sFsegpyU3CchscratkTjuWG4Q53XMQ@mail.gmail.com>
Subject: Re: [PATCHv2 05/11] libbpf: Detect uprobe syscall with new error
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 4:00=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> In the previous optimized uprobe fix we changed the syscall
> error used for its detection from ENXIO to EPROTO.
>
> Changing related probe_uprobe_syscall detection check.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Fixes: 05738da0efa1 ("libbpf: Add uprobe syscall feature detection")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/features.c                                | 4 ++--
>  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>

sashiko is wrong, this change is correct (we do not want to attempt
sys_uprobe optimization if -ENXIO is returned from broken kernels)

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index b7e388f99d0b..e5641fa60163 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -577,10 +577,10 @@ static int probe_ldimm64_full_range_off(int token_f=
d)
>  static int probe_uprobe_syscall(int token_fd)
>  {
>         /*
> -        * If kernel supports uprobe() syscall, it will return -ENXIO whe=
n called
> +        * If kernel supports uprobe() syscall, it will return -EPROTO wh=
en called
>          * from the outside of a kernel-generated uprobe trampoline.
>          */
> -       return syscall(__NR_uprobe) < 0 && errno =3D=3D ENXIO;
> +       return syscall(__NR_uprobe) < 0 && errno =3D=3D EPROTO;
>  }
>  #else
>  static int probe_uprobe_syscall(int token_fd)
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/to=
ols/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> index 955a37751b52..c944136252c6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> @@ -762,7 +762,7 @@ static void test_uprobe_error(void)
>         long err =3D syscall(__NR_uprobe);
>
>         ASSERT_EQ(err, -1, "error");
> -       ASSERT_EQ(errno, ENXIO, "errno");
> +       ASSERT_EQ(errno, EPROTO, "errno");
>  }
>
>  static void __test_uprobe_syscall(void)
> --
> 2.53.0
>

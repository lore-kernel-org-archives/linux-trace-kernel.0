Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3492B3EF0CC
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Apr 2026 22:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775083857; cv=pass; b=i45EWVSRHxUPKa/LE78a4TC8HPO3awmCHCNceBN9Ou3EisWiKO8jX79XqbAofNivCu6XGmuL80/PAzwndRLXupek4Yqwy5cQI1jo4gQkzGU6Pu8HM51luWdcRDZB5LQuwJUTGXnD1dMAR9d4R7Q4IMI1rXUB2C3kCu5z/kP6W/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775083857; c=relaxed/simple;
	bh=v4M8KMoXQgklC+cA2d0h0B28LBb6xOYosA8DjXrFB7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OIyJLVYAB075mhu5tP1rhEIU7/Q1TTNszuAxs6TLjdeR68jnEYwCLWfk/T2gaIsUkft01bimvflLZMcyS//J9ZZx6/V0XC7hkLN7yZHBeB84riNgkAW1IRMyRHcmNbdze1lLQvq0xsLEpU7FlFQXtQyDXlQRHAjiiiCs4Det/Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6LyGuPu; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6LyGuPu"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43cfde3c3f3so263382f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Apr 2026 15:50:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775083848; cv=none;
        d=google.com; s=arc-20240605;
        b=RHImetGrk2dV/0apjn4Oxj2bqrFsvi3FSfsFfXBpJS2pVaH2oQU0BzI39UeROk62Sc
         yZA8FcMFQUmRvRmN2tNW4OsynhyN9umaO2VvWQzy6X4Qd3YCkt2uYXNpFya+g8AIM/50
         MtYt5/0WaovQElxESAPDC+Gf1WLc935DjfPtOf6np3XssXzaxKB2cvr2MxJz4y1R7Tya
         o6SQYDAobjU4XUxBp3gSN9Ro5tOjO8Q+mm2sIQ0Vme8AiHKa3hVvQqOs3e6NoTyfqLjD
         Vc789q8ntamwjq9SFoWqq1XmLDJlmLKi3FaX1QyJm8G3vPSUDVZOSbS4JH6ArDrFF4OW
         5SJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YP1hjNEZjxmIPc8JMepwPHqQTyFtrx81oZfWBBr0Gok=;
        fh=3eJZ1Sj0zLFdJ3DK3ijFeG4aVi36ydGVZRHNgej3aGM=;
        b=f8N+VqWLAMbQvQ3nPQt97szzxFjDgD7N92GMPnEMfMSS0Sa031Z5+vRkvMHksD387Y
         7iznRh7CTTBvQb78jD4+nOYPwcYsquU53rXBC+PJDj1ZBNmA7sycq1xInNJ9UXeG2/Eu
         3j9IdwafHClVS3j5FTLhFcOWamj5ls8MJhRDQWoe1mfBPAhA8KHvsteDv5eJbTtAeG3B
         NUsenIS0w99xAZXt1FcLC6772q4DDx/+75VzP5daHfapnyiH9D4ClNJm+DQ7u0Qru+mL
         TAKvGnijcrQ1wjxMx1vT/wKc5ndw8Brfs03gGRN149pLhX+EO5zFh2S6sm+4aEvqIRFH
         3OTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775083848; x=1775688648; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YP1hjNEZjxmIPc8JMepwPHqQTyFtrx81oZfWBBr0Gok=;
        b=M6LyGuPubn9CG7GKr5u+m8OeJsVUu1AMCpWfN3pfkONIvilTkoMuA/VXx+UgfFTdPi
         SQI0YnWtd8FTboWAwZS5Y4lvnAra/pdVKB3Kz+11vowJZFMSws6V6fsv11BiFR09N1ma
         0lb8vEt3qz75X4eiCKBNLmL3VxXUzUpTHaxjncM/UTMRiVWDTrbnTrz792y5wIUGqd5P
         eEKhCLb1vMd9bH2szVHsFQo0cWGYZOaXylbM1uBOnm2aVgYzTbSF2f2p4ijqvWLEmvmR
         xZu8w8lLJnCvLrQTZ3jihy3OxT9uZgCrCxEpl4Fj0pEeGSPWElYvqCcV0dg2hNrqkWdq
         eINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775083848; x=1775688648;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YP1hjNEZjxmIPc8JMepwPHqQTyFtrx81oZfWBBr0Gok=;
        b=QajP1yBa8y5xMpj+nDB3o4S4QFhMp/qxIAhK0K9rsjsNeybT+WZByqtxbPJz5k7/om
         x0ejpd6j3g8Ws4doB4MdLz0ymRLBo3/EsKZuW+7HGq5fwb+3yv3+RUIsQpZwqbieDzt0
         NNVVIJ7/WxGvd4clxZIj7IiT5XucjxJsfWq7xPB0Acq5rVks4YD74rptPjrX2mcc20d/
         K3X7kHPYIF6Fp3rYhukWm99h1Wk5DGpzhtfUz7JxIpZTYGSrWrs/2SRT54wuMOiNtuj8
         RToR3HF3km9or71qMvVnP1gxqX2fDFI+ojnPpw9NWtFJoClHES6YtZrrlr78Uct2ppOh
         sFjw==
X-Forwarded-Encrypted: i=1; AJvYcCUXUIl1BfXK4mKPST5TW6xI4zs54Zp5hVwgEucOBBv7gSNo1Z23NCLE5ttDoXoeqMoaJ6tJm7cJzx+ipVpTxqUsX64=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvG0OTbC190+qo6HZVoOjhSyGwU830mSuCKBR7t9+Oaol7OH+M
	V5oqez3GFfWv1kme0mdJHFNhgkUG7KHq8ltVch4cHX+B+X0bO4fKczPjFcvf7xXSoUCV9zGNvqA
	RUWuowgooHQx+ntprq9pxKrFcy2cuLqk=
X-Gm-Gg: ATEYQzzam3QKF0eLVooVNLpV8+us+EQ/hgtqepLQ6KjosUJYjPmw9uMq7Y/FNw4Yw+7
	vP3K/uxwi2lhhUh5w65i0uCRyEdigy8t8lB2QRS/mWyvPm3JgJW+Fl+PPOuZqrd75hc7peM+sAT
	ozeq8NcrKtqHzL5PwE4KC44jgFitlyj/mu0ZlgO1DX1wxQ2cKloulsZhPiIZAKadgO8vkF1Cjx0
	rD3jWdvxD7G9AFq5Sh2iIeD5G+44Bs/ue3uWacuT3pTeXRLOGtfIRV4k+7QfhITRvHM0RiRe0ZE
	i1dO3uBTUsLba4EByR8kiizFmVMJAJHUZ9vM7YY+HkRUSTis5KW7T87MxH8=
X-Received: by 2002:a05:6000:2689:b0:43b:447a:11b8 with SMTP id
 ffacd0b85a97d-43d15045e2amr10280803f8f.6.1775083848125; Wed, 01 Apr 2026
 15:50:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401191126.440683-1-varunrmallya@gmail.com> <20260401191126.440683-2-varunrmallya@gmail.com>
In-Reply-To: <20260401191126.440683-2-varunrmallya@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 2 Apr 2026 00:50:10 +0200
X-Gm-Features: AQROBzD1-AIT4sIJv-J5BCUSlZzW71S_yOFNJ0PyY4p0C6cBjNf7hayAGjE8zSg
Message-ID: <CAP01T74cudrCFGAJhhNUWdCS+D1Gn5yFNccaS85YcoX8vdgzBQ@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Add test to ensure kprobe_multi
 is not sleepable
To: Varun R Mallya <varunrmallya@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	yonghong.song@linux.dev, jolsa@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 Apr 2026 at 21:11, Varun R Mallya <varunrmallya@gmail.com> wrote:
>
> Add a selftest to ensure that kprobe_multi programs cannot be attached
> using the BPF_F_SLEEPABLE flag. This test succeeds when the kernel
> rejects attachment of kprobe_multi when the BPF_F_SLEEPABLE flag is set.
>
> Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  .../bpf/prog_tests/kprobe_multi_test.c        | 41 +++++++++++++++++++
>  .../bpf/progs/kprobe_multi_sleepable.c        | 13 ++++++
>  2 files changed, 54 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> index 78c974d4ea33..f02fec2b6fda 100644
> --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> @@ -10,6 +10,7 @@
>  #include "kprobe_multi_session_cookie.skel.h"
>  #include "kprobe_multi_verifier.skel.h"
>  #include "kprobe_write_ctx.skel.h"
> +#include "kprobe_multi_sleepable.skel.h"
>  #include "bpf/libbpf_internal.h"
>  #include "bpf/hashmap.h"
>
> @@ -633,6 +634,44 @@ static void test_attach_write_ctx(void)
>  }
>  #endif
>
> +static void test_attach_multi_sleepable(void)
> +{
> +       struct kprobe_multi_sleepable *skel;
> +       int err;
> +
> +       skel = kprobe_multi_sleepable__open();
> +       if (!ASSERT_OK_PTR(skel, "kprobe_multi_sleepable__open"))
> +               return;
> +
> +       err = bpf_program__set_flags(skel->progs.handle_kprobe_multi_sleepable,
> +                                    BPF_F_SLEEPABLE);
> +       if (!ASSERT_OK(err, "bpf_program__set_flags"))
> +               goto cleanup;
> +
> +       /* Load should succeed even with BPF_F_SLEEPABLE for KPROBE types */
> +       err = kprobe_multi_sleepable__load(skel);
> +       if (!ASSERT_OK(err, "kprobe_multi_sleepable__load"))
> +               goto cleanup;
> +
> +       /* Attachment must fail for kprobe.multi + BPF_F_SLEEPABLE.
> +        * Also chosen a stable symbol to send into opts
> +        */
> +       LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
> +       const char *sym = "vfs_read";
> +
> +       opts.syms = &sym;
> +       opts.cnt = 1;
> +
> +       skel->links.handle_kprobe_multi_sleepable =
> +               bpf_program__attach_kprobe_multi_opts(skel->progs.handle_kprobe_multi_sleepable,
> +                                                     NULL, &opts);
> +       ASSERT_ERR_PTR(skel->links.handle_kprobe_multi_sleepable,
> +                      "bpf_program__attach_kprobe_multi_opts");

Nit: While vfs_read will likely remain stable, the check could
probably be stronger to distinguish an attach error from -EINVAL?
I added a typo to vfs_read and it still passed, because it failed to
attach instead of getting rejected on unfixed kernel.
May not be a big deal since vfs_read is unlikely to break.
I verified it works by adding bpf_copy_from_user to the program and
attaching to SYS_PREFIX sys_getpid and invoking the splat though, so
LGTM otherwise.

> +
> +cleanup:
> +       kprobe_multi_sleepable__destroy(skel);
> +}
> +
> [...]

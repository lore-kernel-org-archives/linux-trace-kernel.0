Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D193DA5D8
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Apr 2026 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123215; cv=none; b=sXfQERkMk/p2p0rL/RW/AyW0ni9q6Ezz4rxQpOj6RVVtSO/qK9yTz/grFiyqnXCADNAC/97HURe4Jx/mzDDEeoJqnUvkMdzStmGwd3Odx9++a6FkDGFctU0Wv6rua2DRO0VsjZdFYsBrzv25aq68KW9eTiDujrsLsjd1JH6c8VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123215; c=relaxed/simple;
	bh=/6Wxpwh1Jw3QuzToWmSpaDn4Z6kHsjQxgV3vtD1wfB8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtUBXDO4BHvxGonEfAMOEngaJsJVD74Ggay2+hsgDenUMxV78bmhOVLFS3tudB9Txlpo0gHwkH68cIbiqH7W67ZXNiXlxh+CY3p8n6NHYDdq445cNUrXTT3segPZx4ubhtWQcr4LqBr9y+YMksk2y0ixDrcN1i5WqD2GsLEEFdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qKLuRE48; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKLuRE48"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-483487335c2so6108455e9.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Apr 2026 02:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775123207; x=1775728007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xyst/4kmEsxgwGqDda+/V97Ys8/9T/NJBxPyHbegpPw=;
        b=qKLuRE48N2JAojAlolw2Tdqrv6Gyoo91vCG2ifgYDY9YZYe3FW0IKiaY3G0ADwtiIj
         7M2IOSqbzb9APo4F2kuq6bOKVpE0M05OwQNZL/LLRIlhTyrF+zf6UVAao0wSDDHUnufB
         tkZV5LkAR5CkIz4/pLTV2E8lS7U/ynPYeZ39bDdm4hrYt7nmyu4nclC70Sv7QocypD7E
         S01nRYAppM4fC/3NxVhODLMsfqokmBls+lwiBQXGT3hMJdxQ4s73EqAiTmUzMu5jKaBA
         PEdae+zP7tR/AidBwGrpEDH8jk0QaTxt1TLWu0siUzy9i6dqpKKMTVWU/tGgoWzVxfqr
         B8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775123207; x=1775728007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyst/4kmEsxgwGqDda+/V97Ys8/9T/NJBxPyHbegpPw=;
        b=AQmACRSMztXcoOlj6t/MihYqgmZcYTth7I0Q7UB3rRTX/ae8DErMYFKyxt1q26mdgS
         fc7ADLRzPdYU7ufy+ZyJn7PIcWhnU7+dcYwOT6CGWC6ga2KjBV3rKULCI8MZWdc5Dnw7
         AzO5xUCVyk0/ZFu7VXk6cDTigo5f2RlprZwWieaGjZKX2Zn+n/KGuqRbhP3nlAA/c2Fi
         k1vBXBpG2RuPrPj70jTUOQ4l5YJogJb9qEwIqDi3Hg4C0pXKthSUdNomulsoI7bLYTpK
         sXNX/oEoUP71F8VB5XWGFcQ4hH4jEF+Suau22grWqpJUTsFPFBlSFIWnmI/XkmNrTTXH
         YMSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBYPwXRAahxEj9g7dNR7spFbjqJTo6DlDapAmbLCsL3aaPSeZvfRN0xO3Ufv0lMz+frYtf+FARAIMRNxMpubiz6S8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF5UvYAumIlNrNjCtO+4LsgbW3YzTPPI7ZJlbYGQ41d9S3Ua0u
	7TUMiVSov2NOOfCn0iUiWO7XepXpwPv41nG4UC56Bc1+IIG0rceIOIvE
X-Gm-Gg: ATEYQzx5N9XjDdNLR9lKtGN+aHZ9LHG7hsU2gab+Y0gTpzTyNVISvIBlnxnh5bhOhL9
	5/swVaO+P5ferQPaPI3+XHCXu+gtevrUfc+twcv3NcWkNO1vZPt6c6we1b8R+rKMjMqIyN/AQhQ
	TAmvHQpquAfnVXi+joUcYeq0g+5bfwkqQyk6Ozi2SfyuAqj38SQQPgAK+fPMpJCkk0RBtg3j2Kw
	9l33EFZYBvxI9WWCK2rM2nrBDwmqup4yeLhznYU39cAUMVQGUmR6hg2msL9uLUqCNj+PJTfYpYw
	5ZewsW/1raUd4e8K0flop3jA+9xLQiMgpPD1SUVuRoN2065bRETrrMdcqGIF6z8xf4v13D/zqi5
	VZJxczmDKqTVtHVg9JjpAdWOWT++Ac75+fHtV0lPDgSHdT9l4aVdLAXjqVOlm8HdGPHiZaX8T7i
	oGNvyLnfE=
X-Received: by 2002:a05:600c:450f:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-48883568af7mr117366155e9.5.1775123207187;
        Thu, 02 Apr 2026 02:46:47 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c760320sm106077895e9.3.2026.04.02.02.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 02:46:46 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 2 Apr 2026 11:46:44 +0200
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Varun R Mallya <varunrmallya@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, yonghong.song@linux.dev,
	rostedt@goodmis.org, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Add test to ensure
 kprobe_multi is not sleepable
Message-ID: <ac47BIEUBBkTch31@krava>
References: <20260401191126.440683-1-varunrmallya@gmail.com>
 <20260401191126.440683-2-varunrmallya@gmail.com>
 <CAP01T74cudrCFGAJhhNUWdCS+D1Gn5yFNccaS85YcoX8vdgzBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T74cudrCFGAJhhNUWdCS+D1Gn5yFNccaS85YcoX8vdgzBQ@mail.gmail.com>

On Thu, Apr 02, 2026 at 12:50:10AM +0200, Kumar Kartikeya Dwivedi wrote:
> On Wed, 1 Apr 2026 at 21:11, Varun R Mallya <varunrmallya@gmail.com> wrote:
> >
> > Add a selftest to ensure that kprobe_multi programs cannot be attached
> > using the BPF_F_SLEEPABLE flag. This test succeeds when the kernel
> > rejects attachment of kprobe_multi when the BPF_F_SLEEPABLE flag is set.
> >
> > Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
> > ---
> 
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> 
> >  .../bpf/prog_tests/kprobe_multi_test.c        | 41 +++++++++++++++++++
> >  .../bpf/progs/kprobe_multi_sleepable.c        | 13 ++++++
> >  2 files changed, 54 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > index 78c974d4ea33..f02fec2b6fda 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
> > @@ -10,6 +10,7 @@
> >  #include "kprobe_multi_session_cookie.skel.h"
> >  #include "kprobe_multi_verifier.skel.h"
> >  #include "kprobe_write_ctx.skel.h"
> > +#include "kprobe_multi_sleepable.skel.h"
> >  #include "bpf/libbpf_internal.h"
> >  #include "bpf/hashmap.h"
> >
> > @@ -633,6 +634,44 @@ static void test_attach_write_ctx(void)
> >  }
> >  #endif
> >
> > +static void test_attach_multi_sleepable(void)
> > +{
> > +       struct kprobe_multi_sleepable *skel;
> > +       int err;
> > +
> > +       skel = kprobe_multi_sleepable__open();
> > +       if (!ASSERT_OK_PTR(skel, "kprobe_multi_sleepable__open"))
> > +               return;
> > +
> > +       err = bpf_program__set_flags(skel->progs.handle_kprobe_multi_sleepable,
> > +                                    BPF_F_SLEEPABLE);
> > +       if (!ASSERT_OK(err, "bpf_program__set_flags"))
> > +               goto cleanup;
> > +
> > +       /* Load should succeed even with BPF_F_SLEEPABLE for KPROBE types */
> > +       err = kprobe_multi_sleepable__load(skel);
> > +       if (!ASSERT_OK(err, "kprobe_multi_sleepable__load"))
> > +               goto cleanup;
> > +
> > +       /* Attachment must fail for kprobe.multi + BPF_F_SLEEPABLE.
> > +        * Also chosen a stable symbol to send into opts
> > +        */
> > +       LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
> > +       const char *sym = "vfs_read";
> > +
> > +       opts.syms = &sym;
> > +       opts.cnt = 1;
> > +
> > +       skel->links.handle_kprobe_multi_sleepable =
> > +               bpf_program__attach_kprobe_multi_opts(skel->progs.handle_kprobe_multi_sleepable,
> > +                                                     NULL, &opts);
> > +       ASSERT_ERR_PTR(skel->links.handle_kprobe_multi_sleepable,
> > +                      "bpf_program__attach_kprobe_multi_opts");
> 
> Nit: While vfs_read will likely remain stable, the check could
> probably be stronger to distinguish an attach error from -EINVAL?
> I added a typo to vfs_read and it still passed, because it failed to
> attach instead of getting rejected on unfixed kernel.
> May not be a big deal since vfs_read is unlikely to break.
> I verified it works by adding bpf_copy_from_user to the program and
> attaching to SYS_PREFIX sys_getpid and invoking the splat though, so
> LGTM otherwise.

why not use bpf_fentry_test2 ? you could also put it in pattern argument
and bypass opts completely (up to you)

also there's test_attach_api_fails test, please move it over there

thanks,
jirka

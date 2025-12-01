Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ED8244692
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Dec 2025 19:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764616963; cv=none; b=Ca7LqBHc0vDU4JTGy/lOoVEldtuB9nSxzMOFDdPxskW1otb1mqDCeLQLdAMz8CvCzoKu8FPKNi5Ejcr8ZZ7hsUAx6qrnsG73F8jjAq0oqSJTLTSVRuy47HOSofUm7DpGRMz8VcJ0eyxvDKdITx+RHJRvh4DhkQ+JNTJbg65Hg2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764616963; c=relaxed/simple;
	bh=6bGmfSg9pFxFWCQ2lBH9/70lRpBBtellr+mx+SjLue8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAYo6rQAFDn9lWq3Sf4FMNzP/p382iyv+rmE9Elkj2BaPFoosk9GHIRoGsp6VO3co3L1RWphTMPrbq4tZtCBd3q5MJ+doBCTRp5UCfLucQq4WDCQXgSgtpCU2nhy5ijDZ0W0EnTrXFqJYarrSv6OlCCyztMhr13TnRmiaiC19nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fHytndiy; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fHytndiy"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640ca678745so7989812a12.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 01 Dec 2025 11:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764616959; x=1765221759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z59nUw0HuPHZG3Lmu1RiiXJwza3oOV4CrE+d6R1LGsw=;
        b=fHytndiyVGErJBS9twJOur9xegsonwVPMvvm43AofXqqfNNkG2ovdU11ylj4d14hDW
         F50+mse2Znh1kFPNxgqIpK5Fb0A+BmoO3lCaemKkWLbO2il5Gux9hk8nT2fZMvswgNGQ
         VeTsJ1tKmS3H6bXFZa8EugqoI05IA0T4DDpaISuKfCGcLzlHWBpOjSbDoI317b1rcjzx
         d/6e+KHN6xeBFY5jKfoAjf/S9a10WTF++gYpw/ZSQjOVdyLFf2fMzWsjJGvvbo/xPz46
         MoYQsfmLeg3pOfDmyOwrrqdtZlt4Sbbb2q91xVl+TBLxprn2ByTNYhY0LsuCI3zeyZO5
         eamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764616959; x=1765221759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z59nUw0HuPHZG3Lmu1RiiXJwza3oOV4CrE+d6R1LGsw=;
        b=JPAWA3PT7TEIoH+7ksem/xPlG/fl/tg54atubmUT3uX/bkbJOEuYka8JpP1vbPdXIy
         0QtUXqJwZqAspSFlixk1IqUEfWGSbGMuTV/77JG/mTk/pj5uRvzqIQYYTA6o5XVEMVjK
         Biem0Ecgusyu2nrccGY2vt9s6mxizk06cYPbzuf2SmQ2yVb2df/M2ZfBQ4BLNyDdq1PU
         xgUhe5eDz4OksNWFolOc6K1SPqQhzzPZ7MY4N8pr6STMEmCOGJU9XZiFRf80hLy/ewmD
         G2DwGYfrL4r0P6Qecc1NcPSWJFvHrYqTI0yapk64W/jpboIgmiRL5B7eUL+m7GS6VmNn
         gBAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxnEjBnMKcy9itZzZqGnVg0qHjmXwR4Rw+E+ZL66SXwq6her9DuzxgSgdnvx3GmyYLS0/chlTHiGbnWKmDYYXzoT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+15c1yYtLzlpNFVhfIMjKzK3d+U9+PSSqR97FrlvzHdQta22G
	rQaanmwpjtnwL0wzelVHx27EtVUm5MbwA40259Kows4kXkCfJF7nKiKShULW4WGXmg==
X-Gm-Gg: ASbGncs141noirmCzL4ULa3A1+/eYwtygPU1omxCxOkD950gYb0f2IpBvMn2S54vbZz
	pUHTt2HLYbTvxm+Ge2LiiSN5+Bb5OK1QhTWAznn+9s8FEPfwgHvnwEfOQ/DRYQpMfKarJFHwF5c
	pr8VRMK3SpZvoCPleT5Vw0eueYBVl1GQSzan9Y+h6eYV7bDf5RkNKICw3SI2SmNrzZY6w5nCUTZ
	PV8sp7sT/upw4X+5SFc5X4sf5DKgnIhQyrZ1HFpifIS83fzNJEbc665UMNelGiuCl1Y9Dr8PMC0
	FKy1Q35jInp4Wstc9JKT61KYDpkXPcyl8QeuRkEPqSv58Z8XxEND4twtf4j3hc3rbsQJ8sF2/yw
	fRp5nLvtDKLTOpaOUqX34lC/KCpwx9st3tqHwS/X16XOjqbOJmXCZ3lSyGflYdowcSAKaHuQVTN
	Kl3uQHZmWx745PD4e4G9lB2DfO3/ChP0btAWudTP39+PlpzGz4TE2Lscpf4eI=
X-Google-Smtp-Source: AGHT+IG34UoQT3kUqLvNKu43Fndn2m4sH7w76ErF20Sd8BMOLDE8kvp8ODO7XKQ+MuwlmC5TvMcJ6w==
X-Received: by 2002:a05:6402:2696:b0:641:54ce:1bf9 with SMTP id 4fb4d7f45d1cf-64555ba1ff3mr38828154a12.14.1764616959243;
        Mon, 01 Dec 2025 11:22:39 -0800 (PST)
Received: from google.com (155.217.141.34.bc.googleusercontent.com. [34.141.217.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647510519efsm13127899a12.29.2025.12.01.11.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 11:22:38 -0800 (PST)
Date: Mon, 1 Dec 2025 19:22:35 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Shuran Liu <electronlsr@gmail.com>
Cc: song@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf 0/2] bpf: fix bpf_d_path() helper prototype
Message-ID: <aS3q-wLcRFuCGuUG@google.com>
References: <20251201143813.5212-1-electronlsr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201143813.5212-1-electronlsr@gmail.com>

On Mon, Dec 01, 2025 at 10:38:11PM +0800, Shuran Liu wrote:
> Hi,
> 
> this series fixes a verifier regression for bpf_d_path() introduced by
> commit 37cce22dbd51 ("bpf: verifier: Refactor helper access type
> tracking") and adds a small selftest to exercise the helper from an
> LSM program.
> 
> Commit 37cce22dbd51 started distinguishing read vs write accesses
> performed by helpers. bpf_d_path()'s buffer argument was left as
> ARG_PTR_TO_MEM without MEM_WRITE, so the verifier could incorrectly
> assume that the buffer contents are unchanged across the helper call
> and base its optimizations on this wrong assumption.
> 
> In practice this showed up as a misbehaving LSM BPF program that calls
> bpf_d_path() and then does a simple prefix comparison on the returned
> path: the program would sometimes take the "mismatch" branch even
> though both bytes being compared were actually equal.

FTR, I strongly encourage any new BPF LSM implementation to consider
using the newer BPF kfunc alternative instead, being
bpf_path_d_path().

> Patch 1 fixes bpf_d_path()'s helper prototype by marking the buffer
> argument as ARG_PTR_TO_MEM | MEM_WRITE, so that the verifier correctly
> models the write to the caller-provided buffer.

This is the correct thing to do, appreciate you sending through the
fix.

> Patch 2 adds a minimal selftest under tools/testing/selftests/bpf that
> hooks bprm_check_security, calls bpf_d_path() on a binary under /tmp/,
> and verifies that the prefix comparison on the returned path keeps
> working.

Makes sense to add a test for this regression, but please also see my
comments against this patch.

> On my local setup, tools/testing/selftests/bpf does not build fully
> due to unrelated tests using newer helpers. I validated this series by
> manually reproducing the issue with a small LSM program and by
> building and running only the new d_path_lsm test on kernels with and
> without patch 1 applied.
> 
> Thanks,
> Shuran Liu
> 
> Shuran Liu (2):
>   bpf: mark bpf_d_path() buffer as writeable
>   selftests/bpf: add regression test for bpf_d_path()
> 
>  kernel/trace/bpf_trace.c                      |  2 +-
>  .../selftests/bpf/prog_tests/d_path_lsm.c     | 27 ++++++++++++
>  .../selftests/bpf/progs/d_path_lsm.bpf.c      | 43 +++++++++++++++++++
>  3 files changed, 71 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/d_path_lsm.c
>  create mode 100644 tools/testing/selftests/bpf/progs/d_path_lsm.bpf.c
> 
> -- 
> 2.52.0
> 

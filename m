Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736A02153EA
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Dec 2025 01:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764724934; cv=none; b=pvLcLOF979Y95K51bKTQCgfDeRkJjE18Tw8TB1cvxfCp1bWV37mRnu9bDrEfquS4/aUN419u2rD705WH317fy+p/BkZpyc2LQQV2tfTmjDdkIAYNU55DYmoswuPnX+VY16SHi90joXQ7MaMU5FaUKfh/jHtWFXbNCrSWCXBd0S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764724934; c=relaxed/simple;
	bh=/pMD5bWmHdRBvf4yKFtgHYmIt4rs553By1J0fnkw5HM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e3L+s/YHbmDi5AYne30Rn4xN43KZSEiPbe+F0kYz6hgqsG7lhsCfXVUrh8t880kwWT1mup4//VDY+H9LLp7/hy7Mn3JfC56PUqezxZd+3Kifgrx9ADDpHcdIS+zrpJwynNMztOvX/YO5bBML4WQ9Xz5r3fgAP+FT9x4ffhcg29c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIIbAjoT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIIbAjoT"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477aa218f20so42500855e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Dec 2025 17:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764724931; x=1765329731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+WY3aZ77NdSSZ7bHvGKcvVuNvrlczHOotCJwifC8BM=;
        b=jIIbAjoTnNabPceowEdVu+Qhgc4aryQp/owrk2DJLqSoQ4vl2FWuCRBdr/I+VIfUqZ
         4paBhBQWfEGJCPId+V5z/AP/UMS9IS/8SE2aRHljfs2IrIA/oTjuhMXktxX9BEYwoZbb
         2txtpBxaBEfX/6ROw5iAVVg2WfKMl88o7YmulAmeWC9yIPf2eK1cKbt3ouVlYS8YXkSH
         8GeISNAfMhA/qLIqAfnIsm6PLSR+5yjIISZj29FyXmFF3Qj+gQ1t2Ba6OaZXcGImRdLA
         U9Z6rOCma9eHdnKp+V+8GUeVqoDz90xs0Zorn1rJHLihlVKzFRcmCX13v5+3A1XZ58f/
         N5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764724931; x=1765329731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z+WY3aZ77NdSSZ7bHvGKcvVuNvrlczHOotCJwifC8BM=;
        b=TwUiTArCkl18v83zsTSIYgFiBQ4d6jqtXqP7StdToODGUQgp3dEb29bgOnlmILYgqf
         ZVa6y96PXlXmbjT55RgdKr+Y7lN9F80h1wxfrjODKFIff2k5Ly/5qqFHaFXhfhewFHaj
         asbxFdCl9glxMnmd+caC3iud/mW974jk6NW6WHI2tcHYFQJQ2LJY6a8mOzZcM5ruQDCL
         VV/KMoYad9hLvATS5f6s3d8sx3MUrUuk5BPaImKSJ8voo0IQENVsw+UwWIjPgc9A3mEi
         ec+3YlMaMN6h2fbTWa1GYX8N/bnE06sve9k85xJyj3gyOd6aIgl8v1nOxpJkSs9J4E05
         BqGw==
X-Forwarded-Encrypted: i=1; AJvYcCU3UvJY24Yo6L6/dDGISjD/x2HusMP/2FPkEXoIhZohd0A5qQOsl9Ozenjf/3uHQnpdTzk2gvrD/iajlMCh7R2qAsU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh0uf/nmeOTCL8K/xuL2AE/BChb7HJA2BneNSTlm8Vm3EcgoJu
	MUyEz3CV2C/LtX+fuV0Pv+g5DEWMMSivGDM5XxL72IGKbgUl0xAvKmSv+jPRsSrhM4HgNIhP7dw
	jVmeemTkQDBuzLiumzm1rn0N2qdELvUU=
X-Gm-Gg: ASbGnctUBqxXO0sfjwxPYMJP6ZlaBd5a2xBLI4hfDW/2wWZH82WXpeZdGra5YEok9OY
	nDtc3lfFX76HF5EyMddrkEDtMoRYkRkBC8hR1c0M/5HoIPZ6up817lR0tXezdWPp4gvHMiI4S9U
	SRvnOPh5JInW+TIQ0MVMe4sbE3UIzLB3zvbWENoaSPD2OIn2WguoFotVLYU3nXvtQdICDGOpBXt
	w5qGkOHExQk74Mpq841cBbyHNMv5xJ8Qv7QZo+G62jENP9lPCIJMfiYDsWc0hCX1LfnQZqVYypj
	cb90Ku8dRORRObVB2UMfG7c7LA4TrRZIIr0uYjw=
X-Google-Smtp-Source: AGHT+IEZPiDn6ShqkuIdilgas/r1CN9HX9hxB+EUwqJ2DZ9iEFPTR7ckrt5KLi2omsstyuSuQGr9BaixCvlkHpaFUos=
X-Received: by 2002:a5d:64c9:0:b0:429:d0b8:3850 with SMTP id
 ffacd0b85a97d-42f731f6a09mr291406f8f.48.1764724930681; Tue, 02 Dec 2025
 17:22:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202141944.2209-1-electronlsr@gmail.com> <20251202141944.2209-3-electronlsr@gmail.com>
In-Reply-To: <20251202141944.2209-3-electronlsr@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 2 Dec 2025 17:21:59 -0800
X-Gm-Features: AWmQ_bmjDp76AGtK2oDFg7O2PT4muz01SgzrZrE4BlXdnWYrNXYeaoIKfF7ZsQk
Message-ID: <CAADnVQJQj=mdFbPf7nmc0+qZVC4RCK5AbJvNQv2W--tvGyzzVA@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: fix and consolidate d_path LSM
 regression test
To: Shuran Liu <electronlsr@gmail.com>
Cc: Song Liu <song@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Zesen Liu <ftyg@live.com>, Peili Gao <gplhust955@gmail.com>, Haoran Ni <haoran.ni.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 6:20=E2=80=AFAM Shuran Liu <electronlsr@gmail.com> w=
rote:
>
> Add a regression test for bpf_d_path() when invoked from an LSM program.
> The test attaches to the bprm_check_security hook, calls bpf_d_path() on
> the binary being executed, and verifies that a simple prefix comparison o=
n
> the returned pathname behaves correctly after the fix in patch 1.
>
> To avoid nondeterminism, the LSM program now filters based on the
> expected PID, which is populated from userspace before the test binary is
> executed. This prevents unrelated processes that also trigger the
> bprm_check_security LSM hook from overwriting test results. Parent and
> child processes are synchronized through a pipe to ensure the PID is set
> before the child execs the test binary.
>
> Per review feedback, the new LSM coverage is merged into the existing
> d_path selftest rather than adding new prog_tests/ or progs/ files. The
> loop that checks the pathname prefix now uses bpf_for(), which is a
> verifier-friendly way to express a small, fixed-iteration loop, and the
> temporary /tmp/bpf_d_path_test binary is removed in the test cleanup
> path.
>
> Co-developed-by: Zesen Liu <ftyg@live.com>
> Signed-off-by: Zesen Liu <ftyg@live.com>
> Co-developed-by: Peili Gao <gplhust955@gmail.com>
> Signed-off-by: Peili Gao <gplhust955@gmail.com>
> Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
> Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
> Signed-off-by: Shuran Liu <electronlsr@gmail.com>
> Reviewed-by: Matt Bobrowski <mattbobrowski@google.com>
> ---
>  .../testing/selftests/bpf/prog_tests/d_path.c | 65 +++++++++++++++++++
>  .../testing/selftests/bpf/progs/test_d_path.c | 33 ++++++++++
>  2 files changed, 98 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/test=
ing/selftests/bpf/prog_tests/d_path.c
> index ccc768592e66..202b44e6f482 100644
> --- a/tools/testing/selftests/bpf/prog_tests/d_path.c
> +++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
> @@ -195,6 +195,68 @@ static void test_d_path_check_types(void)
>         test_d_path_check_types__destroy(skel);
>  }
>
> +static void test_d_path_lsm(void)
> +{
> +       struct test_d_path *skel;
> +       int err;
> +       int pipefd[2];
> +       pid_t pid;
> +
> +       skel =3D test_d_path__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "d_path skeleton failed"))
> +               return;
> +
> +       err =3D test_d_path__attach(skel);
> +       if (!ASSERT_OK(err, "attach failed"))
> +               goto cleanup;
> +
> +       /* Prepare the test binary */
> +       system("cp /bin/true /tmp/bpf_d_path_test 2>/dev/null || :");
> +
> +       if (!ASSERT_OK(pipe(pipefd), "pipe failed"))
> +               goto cleanup;
> +
> +       pid =3D fork();
> +       if (!ASSERT_GE(pid, 0, "fork failed")) {
> +               close(pipefd[0]);
> +               close(pipefd[1]);
> +               goto cleanup;
> +       }
> +
> +       if (pid =3D=3D 0) {
> +               /* Child */
> +               char buf;
> +
> +               close(pipefd[1]);
> +               /* Wait for parent to set PID in BPF map */
> +               if (read(pipefd[0], &buf, 1) !=3D 1)
> +                       exit(1);
> +               close(pipefd[0]);
> +               execl("/tmp/bpf_d_path_test", "/tmp/bpf_d_path_test", NUL=
L);
> +               exit(1);
> +       }

No forks please. They often make selftest to be flaky.
Use simples possible way to test it.
Without forks and pipes.

pw-bot: cr

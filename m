Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3FB2ECE92
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Dec 2025 10:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764757939; cv=none; b=KmINhzK0oQghwAIMds2UbssxjyFegBv+8B6XYKRXEjw0fZYPoNm6caGqE62HXEgqVVhjCXkNRK+HrupkPB1+/UJFHslptgaZO8UAeVUuIw0ZdVVDSOBMqyiqeYblMF8lDh0tC5ieqSGAp3rR+aFODZdlD2+BAzx9xA2MnsV00ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764757939; c=relaxed/simple;
	bh=2aOcCjl3M0B1t8QPIlt4/5AQoGR7I2VJ4KYXHNVnF9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ybry6+C1KF5OAKhGXC0eUw5EdAfV7ZUgDItghSyr6u6d3sjhmaWncv+Cx4IZVvWfKnVAolOxOGWB0loPXDF2afs9O6G/6W9havTMygKh6ZLekT8w2AmLDv5CDB9dg5HoKnmWhd/wPzNRgYbu9RtigMXW7SaiErJ9VhdyxG3TN1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DIXlDOcE; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DIXlDOcE"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640c1fda178so12299304a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Dec 2025 02:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764757935; x=1765362735; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UcqkI9Xd4pMaIL7B+Xnf+RODe2LidpZwWFDHvB1Tt0o=;
        b=DIXlDOcE5HQbNqxjV4C6idorUyGEk13TCgo0TGRCxPjivECC8edEMe088iirAZxzyM
         sCkYRq06Eam5CaFltpP+Puz1Vv5odDAZOT/+RdIgW6r7bWaV3bU/UXiRN/0WblnUizv4
         OdhJMbyod0Nexs3Mutz+33KbOj6aIM6PgD0R9Pz0JoFzeNFXGMlDXcPM3c3soSAMZnH2
         v7QoRhFHimHqF6C+I+pUU/j3tjc8NWQ9HQev554/WkdOzXXOISB/CJTrB8ud1udUF48C
         ejj0SuZh1/3+ybjcFmxroHaQPSwqebPaKz5f41VDj/y+WJEukmSaK1F4TBE4NyTr4JXc
         yU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764757935; x=1765362735;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UcqkI9Xd4pMaIL7B+Xnf+RODe2LidpZwWFDHvB1Tt0o=;
        b=WjxVX/hKmjOqgMOOy2/fq1Mj9fmYXwD8mYwERTmhkqRQu0+HPk6nALmvK//XgLQp2C
         JAtl0fWOxVsvo1mUha6FVS5txPtPBX0MKJL3gpGmcyjl4klS+YFI2fvf3ySIDXacLG8I
         5X2DtezBeNcWC5W9lNh0N53Asmiup7Ycozr2RvnVNWExDFoZMm40YZEBhw7OvORgrvlg
         FGH3DRMD5Bxh3eh/OVy4l0Ag3WfjEbMthSZRchHo7v3UWJT2XUGAuuy+lRFPlwtNdRwt
         bBFpb3gEKHkBqEJm1BT/ACMm3Vdy9HCrbUQOKmPUQFENzo6eYZZvlDI4XM6Tpal/K8QY
         bfLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV5ivQB3//vzKS0cZSXRPntD06MFVeqkz3fMGZ2iev/q3lq2t2ZSM4iV+UwKm4XNcxx/JgnDCIGY248t7cpcJrL3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Ks4RrlM2riM0k8pZAppI6gocRWqEH+hAz/NSw0KbWARZl6yu
	XO6XMTV8bLBCRnOpY5XfGvews609sziCj/idFYa75FUgIeq7FpBtf3gaCY7fdoV7wg==
X-Gm-Gg: ASbGncv7FnaUze8QiAIcp+GMZEgjTh1RoukRtLIyxngCk4QdEcLbRHfAvZJTB1nTS5K
	oa4mXJ5/pLZfN1CbvOu+wVKOji999ZoBUtYCJmyYTWiMabYBvRo6ozF20UdJfVbN1Rs0CLkijEs
	1DV+x/teU2dAAosJiNconaT6OJkgbKbg0BcUwm0jTeh/wKF1Njl53b1z9/nXtAnknJo/aIVgEv1
	CjcvKb9KUBOrJ4FI9dTKgOAreqvVsYqL0O4FHkAUdLzWg5nqlglTww7lUwF9vr4SIK8rrdFLJCj
	h6z8yIWtX0Zb25mocI0Nm0IHSboFQRb5iSGDBMmGXc6a1M2Fd+PH5LjiSZHDStEYR0R7fBbz0DB
	4g5KfDWkOfmwwZ7dvcEbrdw6angvJek8XTst4Z0FauwqIiGS030LZXmiMcmEr7en6/wSVBBTCGS
	NdZWKNEbYQye8FVPIZZq0k4Aw/rZ1yHYqPyeJ4j3TTs5bChKPuChmCUizL
X-Google-Smtp-Source: AGHT+IEAY85Pq3Z+N4w3Oj4K17isL6Bl9lnWw+LXYqAqN863wp8c0ApWNgbwOUam/wsgef5nVp4zjQ==
X-Received: by 2002:a05:6402:1472:b0:640:80f4:3914 with SMTP id 4fb4d7f45d1cf-6479c4f6ff8mr1426286a12.19.1764757934636;
        Wed, 03 Dec 2025 02:32:14 -0800 (PST)
Received: from google.com (49.185.141.34.bc.googleusercontent.com. [34.141.185.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64751062261sm20113764a12.33.2025.12.03.02.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 02:32:14 -0800 (PST)
Date: Wed, 3 Dec 2025 10:32:10 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Shuran Liu <electronlsr@gmail.com>, Song Liu <song@kernel.org>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Daniel Xu <dxu@dxuuu.xyz>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	Shuah Khan <shuah@kernel.org>, Zesen Liu <ftyg@live.com>,
	Peili Gao <gplhust955@gmail.com>,
	Haoran Ni <haoran.ni.cs@gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: fix and consolidate d_path LSM
 regression test
Message-ID: <aTARqrMyC36CXa_L@google.com>
References: <20251202141944.2209-1-electronlsr@gmail.com>
 <20251202141944.2209-3-electronlsr@gmail.com>
 <CAADnVQJQj=mdFbPf7nmc0+qZVC4RCK5AbJvNQv2W--tvGyzzVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJQj=mdFbPf7nmc0+qZVC4RCK5AbJvNQv2W--tvGyzzVA@mail.gmail.com>

On Tue, Dec 02, 2025 at 05:21:59PM -0800, Alexei Starovoitov wrote:
> On Tue, Dec 2, 2025 at 6:20 AM Shuran Liu <electronlsr@gmail.com> wrote:
> >
> > Add a regression test for bpf_d_path() when invoked from an LSM program.
> > The test attaches to the bprm_check_security hook, calls bpf_d_path() on
> > the binary being executed, and verifies that a simple prefix comparison on
> > the returned pathname behaves correctly after the fix in patch 1.
> >
> > To avoid nondeterminism, the LSM program now filters based on the
> > expected PID, which is populated from userspace before the test binary is
> > executed. This prevents unrelated processes that also trigger the
> > bprm_check_security LSM hook from overwriting test results. Parent and
> > child processes are synchronized through a pipe to ensure the PID is set
> > before the child execs the test binary.
> >
> > Per review feedback, the new LSM coverage is merged into the existing
> > d_path selftest rather than adding new prog_tests/ or progs/ files. The
> > loop that checks the pathname prefix now uses bpf_for(), which is a
> > verifier-friendly way to express a small, fixed-iteration loop, and the
> > temporary /tmp/bpf_d_path_test binary is removed in the test cleanup
> > path.
> >
> > Co-developed-by: Zesen Liu <ftyg@live.com>
> > Signed-off-by: Zesen Liu <ftyg@live.com>
> > Co-developed-by: Peili Gao <gplhust955@gmail.com>
> > Signed-off-by: Peili Gao <gplhust955@gmail.com>
> > Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
> > Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
> > Signed-off-by: Shuran Liu <electronlsr@gmail.com>
> > Reviewed-by: Matt Bobrowski <mattbobrowski@google.com>
> > ---
> >  .../testing/selftests/bpf/prog_tests/d_path.c | 65 +++++++++++++++++++
> >  .../testing/selftests/bpf/progs/test_d_path.c | 33 ++++++++++
> >  2 files changed, 98 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
> > index ccc768592e66..202b44e6f482 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/d_path.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
> > @@ -195,6 +195,68 @@ static void test_d_path_check_types(void)
> >         test_d_path_check_types__destroy(skel);
> >  }
> >
> > +static void test_d_path_lsm(void)
> > +{
> > +       struct test_d_path *skel;
> > +       int err;
> > +       int pipefd[2];
> > +       pid_t pid;
> > +
> > +       skel = test_d_path__open_and_load();
> > +       if (!ASSERT_OK_PTR(skel, "d_path skeleton failed"))
> > +               return;
> > +
> > +       err = test_d_path__attach(skel);
> > +       if (!ASSERT_OK(err, "attach failed"))
> > +               goto cleanup;
> > +
> > +       /* Prepare the test binary */
> > +       system("cp /bin/true /tmp/bpf_d_path_test 2>/dev/null || :");
> > +
> > +       if (!ASSERT_OK(pipe(pipefd), "pipe failed"))
> > +               goto cleanup;
> > +
> > +       pid = fork();
> > +       if (!ASSERT_GE(pid, 0, "fork failed")) {
> > +               close(pipefd[0]);
> > +               close(pipefd[1]);
> > +               goto cleanup;
> > +       }
> > +
> > +       if (pid == 0) {
> > +               /* Child */
> > +               char buf;
> > +
> > +               close(pipefd[1]);
> > +               /* Wait for parent to set PID in BPF map */
> > +               if (read(pipefd[0], &buf, 1) != 1)
> > +                       exit(1);
> > +               close(pipefd[0]);
> > +               execl("/tmp/bpf_d_path_test", "/tmp/bpf_d_path_test", NULL);
> > +               exit(1);
> > +       }
> 
> No forks please. They often make selftest to be flaky.
> Use simples possible way to test it.
> Without forks and pipes.

Yeah, I was also a little hesistant about letting this slide.

Shuran, change your BPF program such that you're attached to file_open
instead. That'll make testing from your test runnner far simpler.

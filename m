Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A6D4CA284
	for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 18:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787856437; cv=none; b=RgiKOhTUmtzxTs5O/TcgOjE7Z24cxPDA6Ww3/e50vfps2WYkErm5U/0YIkHGJrgjxUxX2evXRfMbTvF8vKE0YxIRCYmdUL+t+aeG1EoPNLAO9L4CVAlzjxPNDA8lPY/lrFskGb0y3xoEZN8E4mRZzyTIGxJGNNiBOi6vPJ/ziGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787856437; c=relaxed/simple;
	bh=HMARD6I/0aPWbzP51ykVkczorudt+7foZyQjQ7957eA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fD6ytn1ycrcktGjjyZTJL/5aXQ6iEMZRMDNdSfj6z3VSXuxPtBNDzoEaP8h8ZInUI+OVYjIovwKTUqBBN8EaSLLlFstey1LR/jp4jHY2tg7hKMyIYZnCcL2IRk7vUcIh2/DdRFF+1fOZeYHXxPl6qa0nHTbrTjEEzmCbZ/Tgi8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBqYd8DB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBqYd8DB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFE01F000E9;
	Thu, 27 Aug 2026 18:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787856435;
	bh=lyJKEeXUjH0mM/8ZJEI5psuKdb2FzOLm9NioZRcp8/U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XBqYd8DBchXuz/xHeMxxiMcCeBbBAQV6NDcP7x5GiXUJ/ZbX3FQfw1fFRiCChufQx
	 RxQPe8z5X/IJVr44CsAyxVwXQG3dv4syhz1D+SMUad/C2+q32jFsM+F+3iodxXvL24
	 Bd/48p9hX+Fz19oiZpII8R0G5x10SZZVnwxITrrv3biab36KdDJcRHj+4D4JwFGpWm
	 syZTnqfUIGybAFbHwSyOmhWD5smEcmvZNPy5kdB+4Z8xUQVvRJsEuw++nUwLPe9saX
	 Q++URFo5F3c1m21aAGrQ1EpGkf1s7bLxMUyVSVlAbSUX3bChfnBkAQ/dTRyRqUz83f
	 N2d+C1ZZsakvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/6] lib/string_kunit: Add test for copy_task_comm()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260827-tonyk-long_name-v5-3-5fa843782a00@igalia.com>
References: <20260827-tonyk-long_name-v5-0-5fa843782a00@igalia.com>
 <20260827-tonyk-long_name-v5-3-5fa843782a00@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 18:47:15 +0000
Message-Id: <20260827184715.BAFE01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Calling `set_task_comm()` with a zero-initialized dummy `task_stru=
ct` will cause a kernel panic if tracepoints or perf events are enabled, du=
e to a NULL pointer dereference on `task->signal`.
- [Low] The test uses an unexported kernel symbol (`__set_task_comm`), whic=
h will cause a linker failure when the KUnit test is compiled as a module.
--

commit 6dcb08d5f95331fc252e0238ecf8e3db7d303fb5
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

lib/string_kunit: Add test for copy_task_comm()

This commit adds a new KUnit test for copy_task_comm() to verify copying fr=
om
a task_struct works correctly. It tests the standard case as well as special
cases where the source and destination buffer sizes mismatch.

> diff --git a/lib/tests/string_kunit.c b/lib/tests/string_kunit.c
> index 0819ace5b0275..27a27ab13254a 100644
> --- a/lib/tests/string_kunit.c
> +++ b/lib/tests/string_kunit.c

[ ... ]

> @@ -881,6 +881,43 @@ static void string_bench_strrchr(struct kunit *test)
>  	STRING_BENCH_BUF(test, buf, len, strrchr, buf, '\0');
>  }
> =20
> +#define TASK_NAME "task_name"
> +#define TASK_NAME_LEN 9
> +#define TASK_MAX_LEN TASK_COMM_LEN
> +#define SMALLER_LEN (TASK_NAME_LEN - 3)
> +#define BIGGER_LEN (TASK_MAX_LEN + 3)
> +
> +static void string_copy_task_comm(struct kunit *test)
> +{
> +	char str[TASK_MAX_LEN] =3D TASK_NAME, copy[TASK_MAX_LEN],
> +	     smaller_buf[SMALLER_LEN], bigger_buf[BIGGER_LEN];
> +	static struct task_struct task, *tsk =3D &task;
> +	int len1, len2, i;
> +
> +	/* set and get task name */
> +	set_task_comm(tsk, str);

[Severity: High]
Will this cause a kernel panic if tracepoints or perf events are enabled
during the test?

The test uses a zero-initialized static task_struct. The set_task_comm()
macro invokes __set_task_comm(), which eventually calls trace_task_rename()
and perf_event_comm().

If the task_rename tracepoint is enabled, the tracepoint macro dereferences
tsk->signal->oom_score_adj. Similarly, if COMM perf events are active,
perf_event_comm() calls perf_event_pid() which dereferences
tsk->signal->pids[PIDTYPE_TGID].

Since the dummy task's signal pointer is NULL, won't either path crash
the kernel with a NULL pointer dereference?

[Severity: Low]
Does this introduce a build failure when the test is compiled as a module?

CONFIG_STRING_KUNIT_TEST can be built as a module. The set_task_comm() macro
calls __set_task_comm(), which is defined in fs/exec.c but does not appear
to be exported via EXPORT_SYMBOL.=20

Will this result in a linker failure at the modpost stage for module builds?

> +	copy_task_comm(copy, tsk, TASK_COMM_LEN);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-tonyk-long=
_name-v5-0-5fa843782a00@igalia.com?part=3D3

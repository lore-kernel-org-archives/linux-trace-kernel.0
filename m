Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793482766;
	b=2GjbEQ4N3NdZofzJV/hTwuZzIxbC/obM7V6Y75HsJf4D3vAtP0IdGVygRg7chPz9ViZL
	 8NAI5rge7g3TuF1D5cafcORsBIq2OU9pIftZhcEBFsltMPje4+OoODCXjUtrjdHO4rnm4
	 zz+4AGrMtvVZQ+t9C5KXGFppJZ7tIb3phO77zEnys2JZz8dEOAkGPvOMRzKi2WDk7psDB
	 Jylhc9vagycDWdAPyiD8TQ/1NNajYN/jTgb6ewvZPluaDyeEmRBdKpPQ5REsKIY6YfzA6
	 wi6/nVkscDKxPu0P2UQ8dcbbuAZY9oVEV7vA1hADR55nRJWQMPI8LjkMuPVfa6SKPdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793482766;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3S03iCV4dK9dJWIYRZ6o0GPEOUkUn6vSd4nqDG1Mmw8=;
	b=LWGH+6TtvpFeCYDOWMlmPmmKO5hkX/fJe7QoNOEBm8XmsFSDp3tBfnWw27/aohA6vXXF
	 4aCinni32m90uLyhVXxJPc3br02g33GaFTzX4cnjL5zeaMKBrUPFdV9Uj8UcrjqXqzVI5
	 l9HrAjkLeKWXlScjulsDGYiUearLo1yRV+k0b1AY+REnYHG1c4L2bfu+K4JiM6ao5hBnA
	 gdLYg/dLIpssYxvf6zpacFeS+E5EzQ+wbRq3yRB6TSZonJUtpZTGQl+Qnx0dgxIs8DDRL
	 2a2J35o7VNKJoDPPOVw8quMMmhFC/CmJQkk8d/aw6sg9MxeIXBpulVROL02IaGTUByw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NQYoCgfO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E084606A31A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 21:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NQYoCgfO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1831F1F00919;
	Sat, 31 Oct 2026 21:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793482766;
	bh=3S03iCV4dK9dJWIYRZ6o0GPEOUkUn6vSd4nqDG1Mmw8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NQYoCgfOR+/eaqcXcfxqPWGIt5MQfh3HfJmWUNTfTfBMiMeDZemhE9dkDX7MaL/Xh
	 wMvhden+1pqNtQ0QuondGl3OZa78iqW2P5D3HlJWYOalge64f/Ai2+iS06M8l/G8Zb
	 EDKtLUUM5tU34GwcGxvTyqJ72AEVG3WrQpeiFeeAz6GKQLWNX3Bi5b8nHf8ajxQwoa
	 dSvIPV41RUM4jknMgfMf1aAUDKXj+uQTMR+HN6gCVNXE0XgnBHJ9twYP5UZB6Gwl6u
	 sz6A4D3bDWD1Ag6jFl+TS0tBtOWbXjIhxZQ2Ko3aiH2LqVDcLhpVlaD4C0zXC6LwsK
	 MkcP2ZtjeeTIw==
Message-ID: <sashiko-outbox-192180@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/6] lib/string_kunit: Add test for copy_task_comm()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>, "Peter
 Zijlstra" <peterz@infradead.org>, "Juri Lelli" <juri.lelli@redhat.com>, "Vincent
 Guittot" <vincent.guittot@linaro.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Christian
 Brauner" <brauner@kernel.org>, "Kees Cook" <kees@kernel.org>, "Shuah Khan" <shuah@kernel.org>, willy@infradead.org, mathieu.desnoyers@efficios.com, "David
 Laight" <david.laight.linux@gmail.com>, "Linus Torvalds" <torvalds@linux-foundation.org>, akpm@linux-foundation.org, "Yafang
 Shao" <laoar.shao@gmail.com>, andrii.nakryiko@gmail.com, arnaldo.melo@gmail.com, "Petr
 Mladek" <pmladek@suse.com>
Cc: kernel-dev@igalia.com, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261030-tonyk-long_name-v8-3-c9b030332254@igalia.com>
References: <20261030-tonyk-long_name-v8-0-c9b030332254@igalia.com>
 <20261030-tonyk-long_name-v8-3-c9b030332254@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 21:39:24 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] lib/string_kunit: uninitialized stack read in string_copy_task_c=
omm()
--

commit 0d3a01595d2cc8a60f5d8a8716e5935db351758d
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

lib/string_kunit: Add test for copy_task_comm()

This commit adds a KUnit test case for copy_task_comm() in
lib/tests/string_kunit.c to verify copying a task command name into buffers
of equal, smaller, and larger sizes.

> diff --git a/lib/tests/string_kunit.c b/lib/tests/string_kunit.c
> index 0819ace5b0275..66c3398f23174 100644
> --- a/lib/tests/string_kunit.c
> +++ b/lib/tests/string_kunit.c
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
> +	strscpy_pad(tsk->comm, str);
> +	copy_task_comm(copy, tsk, TASK_COMM_LEN);
> +
> +	len1 =3D strlen(str);
> +	len2 =3D strlen(copy);
> +
> +	KUNIT_ASSERT_EQ(test, len1, len2);
> +	KUNIT_ASSERT_EQ(test, len2, TASK_NAME_LEN);
> +	KUNIT_ASSERT_EQ(test, copy[len2], '\0');
> +	KUNIT_ASSERT_TRUE(test, !strcmp(str, copy));
> +
> +	/* copy to a smaller dst buffer */
> +	copy_task_comm(smaller_buf, tsk, sizeof(smaller_buf));
> +	KUNIT_ASSERT_TRUE(test, !strncmp(str, smaller_buf, SMALLER_LEN - 1));
> +	KUNIT_ASSERT_EQ(test, smaller_buf[SMALLER_LEN - 1], '\0');
> +
> +	/* copy to a bigger dst buffer */
> +	copy_task_comm(bigger_buf, tsk, sizeof(bigger_buf));
> +	KUNIT_ASSERT_TRUE(test, !strncmp(str, bigger_buf, TASK_NAME_LEN));
> +	for (i =3D TASK_NAME_LEN; i < BIGGER_LEN; i++)
> +		KUNIT_ASSERT_EQ(test, bigger_buf[i], '\0');
> +}

[Severity: Medium]
Does this loop in string_copy_task_comm() read uninitialized stack memory at
 the end of bigger_buf[]?

In string_copy_task_comm(), bigger_buf is declared on the stack without an
initializer and sized to BIGGER_LEN (TASK_MAX_LEN + 3, where TASK_MAX_LEN is
TASK_COMM_LEN).

However, copy_task_comm() in include/linux/sched.h clamps the copy length to
TASK_COMM_LEN and does not zero-pad dst beyond _len:

include/linux/sched.h:copy_task_comm() {
	const char *_src =3D tsk->comm;
	size_t _len =3D min(len, TASK_COMM_LEN);

	if (!_len)
		return;

	memcpy(dst, _src, _len);
	dst[_len - 1] =3D '\0';
}

Because copy_task_comm() only writes TASK_MAX_LEN bytes into bigger_buf, the
trailing 3 bytes from TASK_MAX_LEN to BIGGER_LEN - 1 are never written. When
the loop iterates i up to BIGGER_LEN, won't KUNIT_ASSERT_EQ() read those 3
uninitialized stack bytes and fail the test (or trigger a KMSAN report) when
stack variables are not zero-initialized?

Note that in the later commit de6fdb508944 ("sched: Extend task command name
with TASK_COMM_EXT_LEN"), tsk->comm and the clamp in copy_task_comm() are
increased to TASK_COMM_EXT_LEN (64) while TASK_MAX_LEN here remains
TASK_COMM_LEN (16). That masks the uninitialized read only because
bigger_buf (19 bytes) ceases to be larger than tsk->comm (64 bytes), which
leaves this commit broken during bisection and means the bigger_buf test
case is no longer testing a buffer larger than tsk->comm after that commit.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-tonyk-long=
_name-v8-0-c9b030332254@igalia.com?part=3D3

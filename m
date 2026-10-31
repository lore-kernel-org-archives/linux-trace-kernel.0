Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793482769;
	b=aIsCkPjcHHSjsXNzWkLNAB5xRUt0BtewcKDS6w+5PJvUuBmgYhtZg6vn1vItSyxCWJkU
	 h47qwFANFUFFtUd7kXb0yoVKxQ/n2ac7cOXJV6lBW1ZZfTNkCJu85Wa0KNnzAqWISOZHp
	 Uz8bqvlCrCfiX9820xK4qHQXuL9YgptzrFUyVGfa9h3Ye699yqWyxG0a88a/BfP6jNIRY
	 C86EIJ/pm3S2pHUT4/fbbiviEUw+J3lKKM0EiLpV9gLUNu+0SG/dBS8/VnfVbbUbFKnur
	 o+OyJxsmX7TFiKhjDjTk7qMiZFec8k0q4NnVClAL3Tc5Dp/tBC796vzXiv2uii8jwUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793482769;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7H7cXGlDlil6ZV+zgm8kUhVnxjK56KVfjw3bskyCfV0=;
	b=22JNntj1dqIe1uT1cFg0N8c2cVsbdWkCCpbVDWHUIvBcSdFvxZ5D/vELthn2SRtI1+Qy
	 bU9zJqNmkSKQOgp6NAkcky9MAcwTD/10x2FAVRcCnpz7FyK5v9TY9haXWfR0vLK/48hH7
	 g0lOpRbJzpLY4m7habX7MxrVFmcrI6JqAK9GgFPJBAfQbuahnQDNagfkWHaaTBfHivD56
	 xxpXR94oHVc1HvyZFPFNzUQwc3mir1jcGqO24uXDqEhlTk/Cya1CfQYrKU7AvieJ0f1BS
	 W3lddRQKK3A0tAnUjvQVf+Pu3u2YQt1NS0CDzjLqnnmp2kPC2A2o2esLeNKG/BvAnnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="FZHk2/+9";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAB6606A31A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 21:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FZHk2/+9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE841F0093A;
	Sat, 31 Oct 2026 21:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793482768;
	bh=7H7cXGlDlil6ZV+zgm8kUhVnxjK56KVfjw3bskyCfV0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FZHk2/+9ACjM7o7Rjf7SP/4O3KHTPhWa5w9B2T12kMqVSLkBY0utwyXfrtOG8GwXD
	 9E8rjAS7AMjD9jrCjJnOIlDsqeM/Gn5Ku6l5q2+f7Gds9PLHnvmALDW4dY7pLmYsEG
	 bqqxXfI0rlIhnmk5lBxig1yjz/UpwJgOkx64KX83cjKYxK+BSb0ZBhBee6MdL6BfJl
	 +/E5mUb5xx9Uvfe4Bk22+M22elaQwVQEI+64t/VoDTtPAYgJOVaGZQaT6DABLSvAAn
	 0orxhLjf012TPAs7eySi7/mT8XhpSPN/jD7hYy+2M/Zm1b6qQVj1rT1sb958mf50xB
	 9g1jgdeYN6MUA==
Message-ID: <sashiko-outbox-192182@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/6] prctl: Add support for long user thread names
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>, "Peter
 Zijlstra" <peterz@infradead.org>, "Juri Lelli" <juri.lelli@redhat.com>, "Vincent
 Guittot" <vincent.guittot@linaro.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Christian
 Brauner" <brauner@kernel.org>, "Kees Cook" <kees@kernel.org>, "Shuah Khan" <shuah@kernel.org>, willy@infradead.org, mathieu.desnoyers@efficios.com, "David
 Laight" <david.laight.linux@gmail.com>, "Linus Torvalds" <torvalds@linux-foundation.org>, akpm@linux-foundation.org, "Yafang
 Shao" <laoar.shao@gmail.com>, andrii.nakryiko@gmail.com, arnaldo.melo@gmail.com, "Petr
 Mladek" <pmladek@suse.com>
Cc: kernel-dev@igalia.com, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261030-tonyk-long_name-v8-5-c9b030332254@igalia.com>
References: <20261030-tonyk-long_name-v8-0-c9b030332254@igalia.com>
 <20261030-tonyk-long_name-v8-5-c9b030332254@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 21:39:27 +0000
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
- [Medium] prctl: missing arg validation and buffer size UAPI in PR_{SET,GE=
T}_EXT_NAME
--

commit d86849bc61de6aa30e004f18202851c2e72d0d41
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

prctl: Add support for long user thread names

This commit adds the PR_SET_EXT_NAME and PR_GET_EXT_NAME prctl() options to
support getting and setting extended user thread names up to
TASK_COMM_EXT_LEN bytes.

> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index b6ec6f6937195..a07f8edadd652 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -56,6 +56,9 @@
>  #define PR_SET_NAME    15		/* Set process name */
>  #define PR_GET_NAME    16		/* Get process name */
> =20
> +#define PR_SET_EXT_NAME    17		/* Set extended process name */
> +#define PR_GET_EXT_NAME    18		/* Get extended process name */
> +
>  /* Get/set process endian */
>  #define PR_GET_ENDIAN	19
>  #define PR_SET_ENDIAN	20
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 6a72c7e644e70..fc9e3c5a91353 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c

[ ... ]

> @@ -2616,6 +2616,19 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long,=
 arg2, unsigned long, arg3,
>  		if (copy_to_user((char __user *)arg2, comm, TASK_COMM_LEN))
>  			return -EFAULT;
>  		break;
> +	case PR_SET_EXT_NAME:
> +		comm[TASK_COMM_EXT_LEN - 1] =3D 0;
> +		if (strncpy_from_user(comm, (char __user *)arg2,
> +				      TASK_COMM_EXT_LEN - 1) < 0)
> +			return -EFAULT;
> +		set_task_comm(me, comm);
> +		proc_comm_connector(me);
> +		break;
> +	case PR_GET_EXT_NAME:
> +		strscpy_pad(comm, me->comm, TASK_COMM_EXT_LEN);
> +		if (copy_to_user((char __user *)arg2, comm, TASK_COMM_EXT_LEN))
> +			return -EFAULT;
> +		break;

[Severity: Medium]
Should PR_SET_EXT_NAME and PR_GET_EXT_NAME in SYSCALL_DEFINE5(prctl) valida=
te
that the unused arguments (arg3, arg4, and arg5) are zero and return -EINVAL
otherwise? Because libc's prctl() wrapper is variadic, 2-argument calls from
userspace can pass arbitrary register values in arg3..arg5, which prevents
extending these options with flags or length parameters in the future.

In addition, PR_GET_EXT_NAME unconditionally copies TASK_COMM_EXT_LEN (64)
bytes to the userspace buffer at arg2, but TASK_COMM_EXT_LEN is only defined
in include/linux/sched.h and is not exposed in include/uapi/linux/prctl.h:

include/linux/sched.h:
    enum {
        TASK_COMM_LEN =3D 16,
        TASK_COMM_EXT_LEN =3D 64,
    };

Without a UAPI constant or a buffer size argument in PR_GET_EXT_NAME, could=
 a
userspace caller passing a smaller buffer (or passing a buffer length in ar=
g3)
have 64 bytes written past the end of its buffer, or break if
TASK_COMM_EXT_LEN is ever increased?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-tonyk-long=
_name-v8-0-c9b030332254@igalia.com?part=3D5

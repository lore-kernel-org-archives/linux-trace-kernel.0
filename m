Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3B735E92F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 19:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787857733; cv=none; b=jHRNuNPQqK/QVrdnTDO8vo+vYMTKt06W75n4dxTOyJTlXsoTBnF+Ybu4U2l19QtpNcduYSbFhKF/5ph3obdJ7kpUevOOlATPy1+EXJVl5msJTFgWg5huIdT60StevdDkt3XqDk18Gfu7qh+l4l+S5XAk9XncpaUwcLagovutu8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787857733; c=relaxed/simple;
	bh=CWrv+Vu1CPOozReF8kBUqgyu9M2fgDCgv1BaNtg4otg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D5N8LLDepjldp8oZAGWJYg1KMsqkZWzLJ5jqnVlFFhfqeCb9YFRdJ1moQHxO2yr7G16mnfUXCbeliaYy0Kv8LRoiRQUdC1XuLfMSt6/FVZ6WzCn/9639WUlBhHM21jkGCCEi70jzlBZ191zFXb3sCBLZLYM87siGO3dNKdL92sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gd1rOYIn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gd1rOYIn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEA01F000E9;
	Thu, 27 Aug 2026 19:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787857729;
	bh=WC9AnGOoFYhzoysS3DnfHN2Ml9xQVg509C23lA5ClbE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gd1rOYInslaQjjppuUfloQ0hgJs6b8mnFa/MJwC1eGLs0uMbOW6pPLFKgUdaGUiPY
	 d5nEDER6Hw2L65ZUBb1FjeCILtCMilBwvQeKyX4OuBOCOhiS0NqFw+SC+UfZL/yB7s
	 IAQ40yBt4ncIukFpqNUzof2olmsI2t+Xe/6j9jpv6jhfju2sMFS4WqRDZRmy8XJStz
	 7NrhirOxWAlMy3d8l65QqPkLw62PVjX2EQS0QohCGGuk+7ZukazR7dFBZaXpUjp1wC
	 q3L+t4ufHgycCulUZtBg5c1i0zbrqwR2a6IXhq9l4p/HFuIKwNQELrly33M64ksnC6
	 580xM/GkqmqtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/6] prctl: Add support for long user thread names
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260827-tonyk-long_name-v5-5-5fa843782a00@igalia.com>
References: <20260827-tonyk-long_name-v5-0-5fa843782a00@igalia.com>
 <20260827-tonyk-long_name-v5-5-5fa843782a00@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 19:08:49 +0000
Message-Id: <20260827190849.AEEA01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Expanding the task comm buffer size without updating the caller si=
ze check allows out-of-bounds reads from 16-byte source buffers.
- [Medium] PR_GET_EXT_NAME writes a fixed 64 bytes to a user-provided point=
er without taking a buffer length parameter, risking userspace buffer overf=
lows.
- [Low] Calls to `get_task_comm()` were not updated in the smack security m=
odule, causing a build failure.
--

commit 14b42cecc71f504b5e0c3127a6bba6b0901cce09
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

prctl: Add support for long user thread names

This commit adds support for getting and setting long user thread names
using the new PR_SET_EXT_NAME and PR_GET_EXT_NAME prctl options.

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index c41d61e9babf9..4f2cd802f1721 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2032,7 +2032,7 @@ extern void kick_process(struct task_struct *tsk);
> =20
>  extern void __set_task_comm(struct task_struct *tsk, const char *from, b=
ool exec);
>  #define set_task_comm(tsk, from) ({			\
> -	BUILD_BUG_ON(sizeof(from) !=3D TASK_COMM_LEN);	\
> +	BUILD_BUG_ON(sizeof(from) < TASK_COMM_LEN);	\
>  	__set_task_comm(tsk, from, false);		\
>  })

[Severity: High]
Does this change allow out-of-bounds reads from 16-byte source buffers?

The macro validates that the buffer is at least TASK_COMM_LEN (16 bytes),
but the internal implementation __set_task_comm() uses the enlarged
destination struct size for bounding:

fs/exec.c:__set_task_comm() {
    ...
    size_t len =3D strnlen(buf, sizeof(tsk->comm) - 1);
    trace_task_rename(tsk, buf);
    memcpy(tsk->comm, buf, len);
    ...
}

If a caller passes a 16-byte array without a NUL terminator, will
strnlen() read past the end of the buffer up to 63 bytes, copying
out-of-bounds stack or heap memory into tsk->comm?

[ ... ]

> diff --git a/kernel/sys.c b/kernel/sys.c
> index 5ebd3c1dfddf7..4caf6ef836f1a 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
[ ... ]
> @@ -2613,6 +2613,19 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long,=
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
Could this lead to userspace buffer overflows?

This option writes a fixed 64 bytes to a user-provided pointer without
taking a buffer length parameter. If a userspace application calls
prctl(PR_GET_EXT_NAME, buf) with a buffer smaller than 64 bytes (e.g.,
assuming it behaves like PR_GET_NAME which uses 16 bytes), will this
blindly overwrite userspace memory and cause silent corruption?

[ ... ]

[Severity: Low]
Is the build broken for CONFIG_SECURITY_SMACK=3Dy?

Calls to get_task_comm() do not seem to have been updated in the smack
security module after the macro was removed in a previous patch in this
series.

security/smack/smack_access.c:smack_log() {
    ...
    audit_log_untrustedstring(ab,
        get_task_comm(comm, sad->subj_tsk));
    ...
}

security/smack/smack_lsm.c:smk_bu_tsk_to_obj() {
    ...
    pr_info("Smack %s: (%s %s %s) %s %s\n", smk_bu_mess[rc],
        smk_of_task(tsp)->smk_known, oskp->smk_known,
        acc, get_task_comm(comm, tsk), note);
    ...
}

Will these dangling usages cause compile-time failures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-tonyk-long=
_name-v5-0-5fa843782a00@igalia.com?part=3D5

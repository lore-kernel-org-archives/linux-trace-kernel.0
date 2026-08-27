Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436931E5B68
	for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 19:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787857504; cv=none; b=OK/5UcO8m30N0/n5NcYi3L5E4NoaFKMRPkOQAoJg3ffzFNGrKybVozt8ebijsQTuqsodm9scPcM2cN73a26QlMwuUHqSnKEqYaw6CkaLWltZOzDshUIIsIiDSQD19nPE0sca/sLryNjIQQ5HLFysJolVqddqpsTEb5KEgbA3y+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787857504; c=relaxed/simple;
	bh=skdIiKvzj7d0OdXfRzCRXd/SJIPzAtkjU3vkV2uG8ns=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aHtyn8dEp+bxznNCTNl2LkY1buqHUO5qeg/GxmuWfwkYc4t5vQbUpAF6BF/9FNyCqt3sSD1P7hkXP+QUQbn72Si6btQElEodk5/WNyW+g3yXKkdxpEHj5sYJCzW6ugj6LrWe11oTXg2hFKHoC6rANunUEllpoOIFXymDIWkfFyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dk/K8oGi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dk/K8oGi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80591F00A3A;
	Thu, 27 Aug 2026 19:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787857502;
	bh=B6dLwqQm3QwutHinWrBt2Tk1qWnpTgZde26cjboOqlg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dk/K8oGiHlotkEQvu5mRvMzAW1Z918yetDMQxs/CEtTWu/YIcAoXnMdCalU1fPVyJ
	 I32Zi11mmbvHeMNCXuvlSXr/3J/jb/bxqIgGKUmfn0ZVas1d8nC/i+sR6tJ03CN3VZ
	 86YqVFrO9kn2QumBRnEmwOa38/QMumJTVOpoUfO0YoEOa+v66CYUZiXQ4FQIv64VwR
	 w4j5JGpwp1PQ7QTIej2wpdJBqlITIB4N+ShkR7tLmRYc90HiuDEeebEyC+1/uWOCzK
	 zxEqHQqriZxb61FBT/oLVi6d/YTCVEShu3oLb3EXRLUYqMXzkOPjhOH7y4KTE/8dwg
	 YjIt+mP863uOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/6] sched: Extend task command name with
 TASK_COMM_EXT_LEN
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260827-tonyk-long_name-v5-4-5fa843782a00@igalia.com>
References: <20260827-tonyk-long_name-v5-0-5fa843782a00@igalia.com>
 <20260827-tonyk-long_name-v5-4-5fa843782a00@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 19:05:02 +0000
Message-Id: <20260827190502.B80591F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] blktrace binary API breakage due to increased payload size for=
 BLK_TN_PROCESS events.
- [Medium] Audit logs expose the full 64-byte extended task name, violating=
 the commit message's claim to cap all existing userspace APIs to 16 bytes.
- [Medium] The tracepoint `bpf_testmod_test_read` copies the task name with=
out guaranteeing NUL termination, leading to an out-of-bounds read when pri=
nting.
- [Low] The patch series removed the `get_task_comm` macro but failed to up=
date its callers in the Smack LSM, resulting in an implicit function declar=
ation and a compilation error.
--

Hi,

I have some questions about this patch.

commit 4fa4b0c6a1f339946bd26a6d2c55d7f5cfb4c1f3
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Subject: sched: Extend task command name with TASK_COMM_EXT_LEN

The commit increases the task command name from 16 to 64 bytes. It aims to
support long names for userspace threads while capping existing userspace A=
PIs
to TASK_COMM_LEN to avoid buffer overflows.

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index c7cdbb3e4aa68..c41d61e9babf9 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
[ ... ]
> @@ -1187,7 +1188,7 @@ struct task_struct {
>  	 * - set it with set_task_comm() to ensure it is always
>  	 *   NUL-terminated and zero-padded
>  	 */
> -	char				comm[TASK_COMM_LEN];
> +	char				comm[TASK_COMM_EXT_LEN];
> =20
>  	struct nameidata		*nameidata;

[Severity: Critical]
With the struct task_struct comm field expanding to 64 bytes, does this bre=
ak
the blktrace binary ABI?

In kernel/trace/blktrace.c:trace_note_tsk():

	trace_note(bt, tsk->pid, BLK_TN_PROCESS, tsk->comm,
		   sizeof(tsk->comm), 0);

This will now write 64 bytes to the UAPI trace buffer instead of 16 bytes,
which can cause parsing errors or buffer overflows in userspace tools like
blkparse.

[Severity: Medium]
Will out-of-bounds reads happen in existing tracepoints that copy directly
from task->comm using TASK_COMM_LEN?

For example, in tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h:

	memcpy(__entry->comm, task->comm, TASK_COMM_LEN);

If a task name is 16 bytes or longer, there won't be a NUL terminator in
the first 16 bytes, which might cause TP_printk("%s") to read past the 16
bytes into adjacent trace event fields.

[ ... ]
> -#define get_task_comm(buf, tsk) ({			\
> -	BUILD_BUG_ON(sizeof(buf) < TASK_COMM_LEN);	\
> -	strscpy_pad(buf, (tsk)->comm);			\
> -	buf;						\
> -})

[Severity: Low]
Does removing get_task_comm() break the build if CONFIG_SECURITY_SMACK=3Dy?
Callers in security/smack/smack_access.c:smack_log() and=20
security/smack/smack_lsm.c:smk_bu_current() still seem to use this macro.

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 9412af9144bc9..75bcc0d43c558 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1667,7 +1667,8 @@ static void audit_log_multicast(int group, const ch=
ar *op, int err)
>  	audit_put_tty(tty);
>  	audit_log_task_context(ab); /* subj=3D */
>  	audit_log_format(ab, " comm=3D");
> -	audit_log_untrustedstring(ab, get_task_comm(comm, current));
> +	strscpy_pad(comm, current->comm);
> +	audit_log_untrustedstring(ab, comm);

[Severity: Medium]
Since comm is declared as char comm[sizeof(current->comm)] at the top of
this function, and current->comm is now 64 bytes, does this expose the full
64-byte task name in the audit log?

The commit message mentions capping all existing userspace APIs to
TASK_COMM_LEN.

This same pattern appears in kernel/audit.c:audit_log_task_info(),
kernel/auditsc.c:audit_log_task(), and
security/lsm_audit.c:dump_common_audit_data().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-tonyk-long=
_name-v5-0-5fa843782a00@igalia.com?part=3D4

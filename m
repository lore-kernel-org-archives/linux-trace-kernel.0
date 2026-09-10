Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F614AD7D8
	for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Sep 2026 17:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060373; cv=none; b=mnxFONj3l4CamsYloTRs/4kjbU9nbzEKdKT1URdmUzgTem1Zdl4qgzA1EacoQooKx87WDAcFnYFw29oww2YNdoJLNrN+1rWtU9klbnAQ1U2MSjXGU6dKN+DSb4VzVAnTntKrc2cNse2VSvhL72fO0Cpp7KHExNnFljJ6pxJU3og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060373; c=relaxed/simple;
	bh=T64neCmSU60XlfVWRmun9Xwcpev0rvIlCdymO2c14M4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bBMjloxwdu6WdyEhT0xdVeFiKvhZKScEngbSMg8nVDdhPwpHXJQ9QwxIH7qDv7e4zybyg4VCDkFM6N5pZBJiIZvk+4CnINeMM2mpAZBE6L/TEkZJUFFpaoaNou7Lj88kKGcBucPcH9KUK+FZtS6yThfRieP8l2U6KPrhy7PwiRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPmOiYVE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPmOiYVE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D551F000FF;
	Thu, 10 Sep 2026 17:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789060352;
	bh=b/K4paELnfJzvSdie2zdmxHLW2r7EYcfPLfHgzOexM0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nPmOiYVEnSBpWZtNnatNlWKWvq9qTLxnJM7v+pX7PhMV7kCHuUkEtQwx1gCdAAjb7
	 r6nplf7w3AcKfrXnxXRizRpuXgihvil9Ja0aIkactcEpJU8sb4yFOWqynMbB+gkqRm
	 uiqDWtmQuoXrEMsb1MbGH2VUcui7IOk9bVvRX1XovvMAW4g7tIJcRTPdik/vT6Yqbf
	 kvm2O7xdhVzdMQo3Qe17I/S9H0X4D5ZheP00it9xDQmklI0i24OVpXkemlZ3mUNe5r
	 aCUug6nAPQ5JgmPJsVL1mT68vu9DaRWpdSGN6PqtL5Z8keCQUQlyI19PqNdCSSA5j+
	 xoT1uADKyOkBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/6] prctl: Add support for long user thread names
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260910-tonyk-long_name-v6-5-d70afbf194c5@igalia.com>
References: <20260910-tonyk-long_name-v6-0-d70afbf194c5@igalia.com>
 <20260910-tonyk-long_name-v6-5-d70afbf194c5@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 17:12:32 +0000
Message-Id: <20260910171232.B4D551F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incorrect argument passed to `strscpy_pad` in Smack LSM causes an =
out-of-bounds read, leaking `struct task_struct` heap memory to the kernel =
log.
- [High] Incorrect argument passed to `copy_task_comm` in the BPF test modu=
le causes an invalid pointer dereference and kernel panic.
--

commit a226c4fbdd68ce01686ac76a75507a8ad81e5825
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Subject: prctl: Add support for long user thread names

This commit adds support for getting and setting long user thread names
with pr_set_ext_name and pr_get_ext_name.

[ ... ]

> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -138,6 +138,8 @@ smk_bu_tsk_to_obj(struct task_struct *tsk, const stru=
ct task_smack *tsp,
>  	char acc[SMK_NUM_ACCESS_TYPE + 1];
>  	char comm[TASK_COMM_LEN];
> =20
> +	strscpy_pad(comm, tsk);
        ^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
This isn't a bug introduced by this patch, but by an earlier patch in the
reviewed patchset. It remains unfixed in the final state of the series.

Does this code pass the correct argument to strscpy_pad()?

The strscpy_pad() call implicitly converts struct task_struct *tsk to=20
const char *, causing the first 16 bytes of the task_struct to be copied=20
into the comm buffer and subsequently logged via pr_info().

Could this cause an out-of-bounds read, leaking struct task_struct heap=20
memory to the kernel log when smack bringup auditing is enabled and a=20
relevant access check fails or is logged?

Exposing raw task structures to logs bypasses kernel address space layout=20
randomization and leaks kernel layout data.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h =
b/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
> @@ -20,7 +20,7 @@ TRACE_EVENT(bpf_testmod_test_read,
>  	),
>  	TP_fast_assign(
>  		__entry->pid =3D task->pid;
> -		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
> +		copy_task_comm(__entry->comm, task->comm, TASK_COMM_LEN);
                                              ^^^^^^^^^^

[Severity: High]
This isn't a bug introduced by this patch, but by an earlier patch in the
reviewed patchset. It remains unfixed in the final state of the series.

Are we passing the correct argument type to copy_task_comm() here?

The inline function copy_task_comm() expects a struct task_struct *=20
but receives task->comm, which is a string pointer.

Inside copy_task_comm(), evaluating tsk->comm treats the string's memory=20
address as a task_struct and adds the structural offset of the comm field,=
=20
yielding a wildly invalid address.=20

When bpf_testmod_test_read() executes during bpf selftests, won't this=20
cause a wild pointer dereference and kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-tonyk-long=
_name-v6-0-d70afbf194c5@igalia.com?part=3D5

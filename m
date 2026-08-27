Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76720361657
	for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 18:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787855757; cv=none; b=K/Tx4q4u+75q1LzIuuIGqN1vzvB4MTslk05RJvTX7r6KwlBkwYmQMNRg9ZqTamoAy58gfMwh3dDumhtWoutqTzKQEaDXszrUEx4WQekETtLEQ63KPNUYsQPiFNp632I51+GJHFYut39oojP3xvqb+D2JZY4NBXt5XSfHNXdY3kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787855757; c=relaxed/simple;
	bh=p3dPFm7loSI8i0vucRQlkJOclXOQdsr8iqtU1ektu5Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cpd+VXStGe+Cs6sHL3tjtdIsaSklVjAJAM2e5R3/UonbxNe83Sk91VxPAYcezDQXLWBexDLnL8k2JOnQOCEWDY63EzBFDkyi0yI2eSq9ulby7jlvM3/vQ4VKok/5Tt8iBMSSkhS9Yylb4AkbIL1wT7+Aj1s9q7fMsK3q2HkyTUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fo5aE1X0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fo5aE1X0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB271F000E9;
	Thu, 27 Aug 2026 18:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787855754;
	bh=tm7W2lqC2dFXA58QDZbEbRfNyKe/U+XsePBWKbTcxTk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fo5aE1X0iUPvEucYE8rKy1x+Bkm05NlQb4Xl+gP7th/jcj9PW4dF/piwk+yxVVb+d
	 KiUB8ntHYOZPN+26nDn6PzyL1AW1ICJyENgPav+wmx58ibTy86ldR8dAwkOC3NGXgh
	 ZQ45JF8b9Cbkg/pvXf9+cHoiLv9cV5r7o4tV95pCv9rPQTxuoI+XofF9idy3af+0uZ
	 OrDTphsoBYyadK3f5sainqMfVQGXUPzWkJu7sL/fs6ztMeOYz7LJs+UaWKrzViOuWK
	 Tpng3ZQiXw0llBIHmFsxd5jJS4kGrKR3j/Hg2hHQa9cgRgjQF7QIzrAz0dqlUBdUk0
	 oV3jGlPetqRcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/6] treewide: Replace memcpy(..., current->comm)
 with copy_task_comm()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260827-tonyk-long_name-v5-2-5fa843782a00@igalia.com>
References: <20260827-tonyk-long_name-v5-0-5fa843782a00@igalia.com>
 <20260827-tonyk-long_name-v5-2-5fa843782a00@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 18:35:54 +0000
Message-Id: <20260827183554.8BB271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The treewide replacement of memcpy() with copy_task_comm() misse=
d a tracepoint in the BPF test module.
--

commit 0b4391937405bf7ef33f5ddc8cc5b7e81c93d587
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

treewide: Replace memcpy(..., current->comm) with copy_task_comm()

This patch replaces treewide instances of memcpy() copying task->comm with a
new copy_task_comm() function. This ensures the destination buffer is always
NUL-terminated, preparing for future extensions of the task command name
length.

[ ... ]

> diff --git a/include/trace/events/task.h b/include/trace/events/task.h
> index b9a129eb54d9e..e3faaeb997ef2 100644
> --- a/include/trace/events/task.h
> +++ b/include/trace/events/task.h
> @@ -21,7 +21,7 @@ TRACE_EVENT(task_newtask,
> =20
>  	TP_fast_assign(
>  		__entry->pid =3D task->pid;
> -		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
> +		copy_task_comm(__entry->comm, task, TASK_COMM_LEN);
>  		__entry->clone_flags =3D clone_flags;
>  		__entry->oom_score_adj =3D task->signal->oom_score_adj;
>  	),

[Severity: Medium]
Did this treewide replacement miss a tracepoint in the BPF test module?

Looking at TRACE_EVENT(bpf_testmod_test_read) in
tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h, it still uses
memcpy() instead of copy_task_comm():

memcpy(__entry->comm, task->comm, TASK_COMM_LEN);

If a task sets its name to 16 or more characters (which becomes possible
with the extension to 64 bytes in later patches) and the
bpf_testmod_test_read tracepoint is hit, the 16-byte __entry->comm buffer
will not be NUL-terminated.

Can this cause an out-of-bounds read when tracing consumers or TP_printk()
read the non-NUL-terminated comm buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-tonyk-long=
_name-v5-0-5fa843782a00@igalia.com?part=3D2

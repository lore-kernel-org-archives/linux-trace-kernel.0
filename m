Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775AA50C29E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Sep 2026 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789059551; cv=none; b=q+sUuauui48RCgR+rRGa1eGyjWEYbWx//R+tcG4JOZ/mRfESIqLpF+9LWFLTuEkI5Y4/LSeBzy9AO8kOLpSB0DJy60TCMVOSZIFm6BSGW0WLP7kMrSiiyxVnuMFkFdzP1/9IQvkvS87vMhulM97Wy+4iZWa8mwe5OpxOUpGyf88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789059551; c=relaxed/simple;
	bh=GDo5RBPqO7bKY+VLsXUWVyBjuEuJ5LXs7PugCn6Qajk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fw5DSykJ2vlT+i8DR21nKUPSf6GuFBu8aHUzlsKjQjpF4JoILRr4XYiY3LO/r8uilDgUlsboem50Rfg42t6UD3EkKXhNeCUFKHFKQrU0Rjv0nITCKhKICnZkgQYJ1CYCABxPHTaWd61pYeB0ldn0vjp7P77GzT8g02j2Q8G5xGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIWKzVsS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIWKzVsS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699241F000FF;
	Thu, 10 Sep 2026 16:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789059538;
	bh=23K9Ija2xT6Vet4uB8b3KLJMp/ABnoCYNRqUVFU3YHQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RIWKzVsSrEpAOUuHclPHPYj3SHyMyre1/HqPxVZDhRxaLxsGEjTyWlIPMF9LhKlSX
	 TeZ4Hzf1eJ7vG7OjgktFp6gf+bkj7FpROO4Em9ypu8d3RWlM7vdlvEKxCtWFyP7mxD
	 UyWY3I/B6Ipken4vZ27sBf25iaRSxHCbpMU0bhgmyS2dosMGlptJOYry3YFaqZTbSO
	 JqvsX39KNkbRt7uwOL9dGV0P4gtHSKX9Lp78H/9141PIQ6EafRaUeuaaakI4dyhKX4
	 mY5qTaH/xQmd5IRsp/1do5dydjomOvsQJXhtcaUQ9zvphX1S61YH8E0avAU9hEM7uO
	 ZfPqRCUMCELKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/6] treewide: Replace memcpy(..., current->comm)
 with copy_task_comm()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260910-tonyk-long_name-v6-2-d70afbf194c5@igalia.com>
References: <20260910-tonyk-long_name-v6-0-d70afbf194c5@igalia.com>
 <20260910-tonyk-long_name-v6-2-d70afbf194c5@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 16:58:58 +0000
Message-Id: <20260910165858.699241F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incorrect argument passed to copy_task_comm() causes a compilation =
failure due to a type mismatch.
--

commit 78bb0b12f82412f87836e6af88b5c97b35cbb5ab
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

treewide: Replace memcpy(..., current->comm) with copy_task_comm()

This commit introduces a new copy_task_comm() function that safely copies
a task's comm string while ensuring it is NUL terminated. It then replaces
various treewide instances of memcpy() copying task comms with this new
function to prevent truncation issues.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h =
b/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
> index 45a5e41f3a920..27a1c12799cf6 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod-events.h
> @@ -20,7 +20,7 @@ TRACE_EVENT(bpf_testmod_test_read,
>  	),
>  	TP_fast_assign(
>  		__entry->pid =3D task->pid;
> -		memcpy(__entry->comm, task->comm, TASK_COMM_LEN);
> +		copy_task_comm(__entry->comm, task->comm, TASK_COMM_LEN);

[Severity: Low]
Does this cause a build failure when compiling the bpf_testmod kernel modul=
e?

The new copy_task_comm() function expects a struct task_struct pointer as
its second argument, but task->comm (a char pointer) is being passed here
causing a type mismatch. Should this be updated to pass just task instead?

>  		__entry->off =3D ctx->off;
>  		__entry->len =3D ctx->len;
>  	),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-tonyk-long=
_name-v6-0-d70afbf194c5@igalia.com?part=3D2

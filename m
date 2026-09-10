Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D978C4CCDE1
	for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Sep 2026 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789059529; cv=none; b=ZaQadkgmrlMv+k9oX01J+TJdNvCjCCuahuU8VJqHu3uuinTjByPEBvviuijv5dZivwc0KARwiOuKaQdqgGUQTZw/m560cmb/YKuNcJ9CRWRHCD54xniVLSi+qoq0IIBesSujF3f45HLF53s6RGmcDfUxj4HwF6EqTAkXqIlkOnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789059529; c=relaxed/simple;
	bh=62NcunostMjYWulkrRK1QeMNYeaLxQKZctku0U/gOAU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jTbY8iHno/X5Ss/HErqOh+/NZjfpZsNTzJXyg/6OlJ3jT72Jc43p/6/tEHe001IjEILng18ND5XJiupiJX6lCad5x92JIinhIbYoq+LIv+H+Swy2Jc3wcBPtAknAzVWLQ2M3cos2wN2aJPPiEqebunvkF+5UUGazs1fvWeq7inQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msjKHcvs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msjKHcvs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F961F00893;
	Thu, 10 Sep 2026 16:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789059522;
	bh=vmOFciyCtbqwq4E3Us48R8dWySxBytQY2xY8Bt48Jh8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=msjKHcvsMQHBc2n89Cc/sgoukQAMHSCTAKu/9SNoUHtbPeo/f0D+oSbj57+R7ENPV
	 1yvkUvOnkBhfSwbmz5SrSbsavBzw5yURUtMFfC6eyTBhKs72zlUzYck2gW8FEcOoWH
	 dPmwBd1LjJHuYTaum2GzU9yTQxwnkZV4CT9Bguct44/GjQC0qlkyB5NHXCmt3tlNvR
	 rDzdLZ+LsGvfxT5tEx0nU7HRMJnrhXu0DNle/Ica1UZTdQ5+xO4jqWCx7EZRlYmMNY
	 RAaW2zEOBdBIi0q/CAN8NUgAlArjeRls7+UAZhhJTybigoC+kO9+7uRRXoYkXwrlD4
	 agn7CFAaZQ9gQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/6] treewide: Get rid of get_task_comm()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260910-tonyk-long_name-v6-1-d70afbf194c5@igalia.com>
References: <20260910-tonyk-long_name-v6-0-d70afbf194c5@igalia.com>
 <20260910-tonyk-long_name-v6-1-d70afbf194c5@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 16:58:42 +0000
Message-Id: <20260910165842.B4F961F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Passing a pointer to `struct task_struct` instead of its `comm` fi=
eld to `strscpy_pad()` leads to an incompatible pointer cast and a kernel m=
emory info leak.
--

commit 90523a0d5e26d2bcb762f02d00c73857b4ad6c5d
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

treewide: Get rid of get_task_comm()

This commit replaces calls to get_task_comm() with strscpy_pad() across the
tree. It aims to properly handle buffer padding and truncation depending on
buffer sizes.

Link: https://lore.kernel.org/lkml/CAHk-=3Dwi5c=3D_-FBGo_88CowJd_F-Gi6Ud9d=
=3DTALm65ReN7YjrMw@mail.gmail.com/

[ ... ]

> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 8e88ac65fd7fc..0e1aa2bb4a7ca 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -138,6 +138,8 @@ smk_bu_tsk_to_obj(struct task_struct *tsk, const stru=
ct task_smack *tsp,
>  	char acc[SMK_NUM_ACCESS_TYPE + 1];
>  	char comm[TASK_COMM_LEN];
> =20
> +	strscpy_pad(comm, tsk);

[Severity: High]
Could this lead to a kernel memory info leak by passing the task_struct
pointer instead of the process name string?

strscpy_pad() expects a const char * as its second argument, but it receives
a struct task_struct * here instead of tsk->comm.

If this compiles (e.g., without -Werror), this copies up to 16 bytes starti=
ng
at the base of the task_struct into the comm buffer. When this buffer is
later printed via pr_info() during a Smack Bringup log, it dumps raw kernel
memory to dmesg, which could be leveraged to bypass KASLR or read sensitive
struct fields.

> +
>  	if (rc <=3D 0)
>  		return rc;
>  	if (rc > SMACK_UNCONFINED_OBJECT)
> @@ -147,7 +149,7 @@ smk_bu_tsk_to_obj(struct task_struct *tsk, const stru=
ct task_smack *tsp,
> =20
>  	pr_info("Smack %s: (%s %s %s) %s %s\n", smk_bu_mess[rc],
>  		smk_of_task(tsp)->smk_known, oskp->smk_known,
> -		acc, get_task_comm(comm, tsk), note);
> +		acc, comm, note);
>  	return 0;
>  #else
>  	return rc;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-tonyk-long=
_name-v6-0-d70afbf194c5@igalia.com?part=3D1

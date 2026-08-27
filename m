Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD6342CAE7
	for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787856028; cv=none; b=dUMzRoNZadVi18CCjst3gGJSJJvX6buHcPlHGYs/oO8KtZNDMSCNXRM4CaCyS4XYTtOmyy9ypxXY/cnjVNlhZqZnwfJZ7O/3Gi7K5F9jEwdJDxxpwCTWWf/eteljjGlOAqWbvijVm77K6TvY4D5iZvSo+MaVE3STe/KWPNyZf1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787856028; c=relaxed/simple;
	bh=HJSr71KzZjTqDIc21eNavwxCcESfFFsBWNofrKWKRNo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GTJmirkbySSYya2xdh3yYJG6P9EQ08hTOlcmseHwTSqurZtjf5qIPYgHMeHLXPTH8/pahcXakKtdV8vH+jfoPmgcQUn3x6iZueinLnodcEJf7gxasg6mEp58XPMnbB9terY4abCQmB0v4os2ZGvOa98OmrUfyj3rOFCx5vxTZdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TumrV9fr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TumrV9fr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FA31F000E9;
	Thu, 27 Aug 2026 18:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787856027;
	bh=KcYqLb1TjjRzhXorr6bZgUN99MfcL6jybuctk4GK+RM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TumrV9frOtiZFCjj/EYd7SJ4ovtgc1e/0OOvQhpXl9loTMIeI63jigpQsdV9pEVLK
	 nSqMmc7H9KDjxmagJUeVB8Z0FQeo7K5wIKxLR4c0jmTOS5GQddPH5FoquQmhOdtiQ2
	 IPTdVv60ybwpae90VXD8ir/TR+YTVK/OUWp7mU9y79fW0eHNpyGP76PTM4sZFJMEF7
	 yt8XdYlRle4htIz1iOrZvkcPVNTvaxZzQ+aU3MpPKbv0pCVx2u1he9ZlOukfhqT4ax
	 DndYdG6fHQcU0NSFb3MAPJkNpaXKKZTU/GVLka8Le8VDyTMHFazEsO/BldlU7AKGEE
	 T5bhx68fjxniQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/6] treewide: Get rid of get_task_comm()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5kcsOpIEFsbWVpZGE=?= <andrealmeid@igalia.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260827-tonyk-long_name-v5-1-5fa843782a00@igalia.com>
References: <20260827-tonyk-long_name-v5-0-5fa843782a00@igalia.com>
 <20260827-tonyk-long_name-v5-1-5fa843782a00@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 18:40:26 +0000
Message-Id: <20260827184027.27FA31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit removes the `get_task_comm()` macro definition from `inc=
lude/linux/sched.h`, but fails to update its usages in the Smack security m=
odule. This will result in an implicit function declaration or undeclared i=
dentifier error during compilation, breaking the build when `CONFIG_SECURIT=
Y_SMACK` is enabled.
--

commit 2f9c1f9e715d0c7c819d963ab3e8781e9ac3ae49
Author: Andr=C3=A9 Almeida <andrealmeid@igalia.com>

treewide: Get rid of get_task_comm()

This commit replaces usages of get_task_comm() with strscpy_pad() across
the tree to correctly handle buffer size mismatches. It also removes the
definition of the get_task_comm() macro entirely from include/linux/sched.h.

Link: https://lore.kernel.org/lkml/CAHk-=3Dwi5c=3D_-FBGo_88CowJd_F-Gi6Ud9d=
=3DTALm65ReN7YjrMw@mail.gmail.com/

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index c7cdbb3e4aa68..474ca86ec105e 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
[ ... ]
> @@ -2035,25 +2035,6 @@ extern void __set_task_comm(struct task_struct *ts=
k, const char *from, bool exec
>  	__set_task_comm(tsk, from, false);		\
>  })
> =20
> -/*
> - * - Why not use task_lock()?
> - *   User space can randomly change their names anyway, so locking for r=
eaders
> - *   doesn't make sense. For writers, locking is probably necessary, as =
a race
> - *   condition could lead to long-term mixed results.
> - *   The strscpy_pad() in __set_task_comm() can ensure that the task com=
m is
> - *   always NUL-terminated and zero-padded. Therefore the race condition=
 between
> - *   reader and writer is not an issue.
> - *
> - * - BUILD_BUG_ON() can help prevent the buf from being truncated.
> - *   Since the callers don't perform any return value checks, this safeg=
uard is
> - *   necessary.
> - */
> -#define get_task_comm(buf, tsk) ({			\
> -	BUILD_BUG_ON(sizeof(buf) < TASK_COMM_LEN);	\
> -	strscpy_pad(buf, (tsk)->comm);			\
> -	buf;						\
> -})
> -

[Severity: Low]
Does this removal cause a build failure when CONFIG_SECURITY_SMACK is enabl=
ed?

There appear to be remaining callers of get_task_comm() in the Smack securi=
ty=20
module that were missed in this treewide replacement.=20

For example, in security/smack/smack_access.c:smack_log_callback():

    get_task_comm(comm, sad->subj_tsk)

And in security/smack/smack_lsm.c:smk_bu_tsk_to_obj():

    acc, get_task_comm(comm, tsk), note);

Without the macro definition in sched.h, will this result in implicit=20
function declaration or undeclared identifier errors during compilation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-tonyk-long=
_name-v5-0-5fa843782a00@igalia.com?part=3D1

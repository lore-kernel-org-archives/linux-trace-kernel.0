Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25DD43B6CB
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 08:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769417; cv=none; b=LHrQk6rdhxHTEOiqdYZc3KMAPvXD+MsLVjPi8MZAJAmw2jQm5t+YZJubibCN3d0NnhS48BAcLW5tXCTII/mE4yiel16KcQCRuvA9l3P8+AEvGmUebYCzubCAWqV18NjzaCDfB6Z+sJZ2q72V5NWsoT7oP6DFMpOR8Vke2KVQvBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769417; c=relaxed/simple;
	bh=EgwEU0l6WvOJVsKTFujdIU9ulf5nTsnF+WL5jP+ZgGE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AO1pltHSKHzmAa01y0LzStuglwUZkwToPbAOnEyBX81HCrv2Y7OiDH6H8iTmWLwIBEWPiT7eFKReCSmRHaHIwCAEIhw6ojOzZlLMA9jVSiKJt9zCnLZniF/+5mOs8irO0BUd15C974Faglvyv+k2p5tAz8vIbNtYIB/s/FPbxm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frEpm0cd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frEpm0cd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936231F00A3A;
	Mon,  7 Sep 2026 08:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788769415;
	bh=JxmwKP7+NWzQHt4BrZqvrlI5hiVH34X/ltiFNeXvoU0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=frEpm0cdVpDS52VoRQownJmVu/hTAgZ7JlAPHZWZ7Qb/5pJjyi/EPKKiUWpChS3h1
	 Vhui2TEymP7/DGUN6avUZSJGH9M552ojMnz1FXOowvAtBhn3DVtTqMf338fj0Bg/xi
	 B9YdH+H3K7x0OWqeA6YOmuydo9qNmjqKE2/nh7ub8lw/mFDEWxbfUTC6hFuAv00MW3
	 gEsO67Y5+WFxgD7bNwb8FuT38W/AeDvGstxFuM9vXc574g3LcOImduX1bJ323apiEp
	 QsEAGKa/RCkyzQ7RgWAB586uJ5mzOKSVlVAKFSUetk8WoUHAVWM+N9oMz57LDFr9rw
	 Ae9yus9spw3zA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/8] fs: convert process/thread iterators to
 for_each_*_rculock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ye Liu" <ye.liu@linux.dev>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260907081334.1152889-7-ye.liu@linux.dev>
References: <20260907081334.1152889-1-ye.liu@linux.dev>
 <20260907081334.1152889-7-ye.liu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 08:23:35 +0000
Message-Id: <20260907082335.936231F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Mixing scope-based cleanup (scoped_guard) with goto-based error han=
dling in the same function.
--

commit e0076a589e993892daf78cfc52036d64c5fb68e6
Author: Ye Liu <liuye@kylinos.cn>
fs: convert process/thread iterators to for_each_*_rculock

This commit replaces manual rcu_read_lock() and rcu_read_unlock() pairs
combined with process iterators in the fs/ directory with
for_each_*_rculock() macros. These new macros scope the RCU read lock to the
loop body using scoped_guard(rcu).

> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 58be389424605..2c47d838a1c76 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
[ ... ]
> @@ -1161,8 +1161,7 @@ static int __set_oom_adj(struct file *file, int oom=
_adj, bool legacy)
>  	if (mm) {
>  		struct task_struct *p;
> =20
> -		rcu_read_lock();
> -		for_each_process(p) {
> +		for_each_process_rculock(p) {

[Severity: Low]
Does this code mix scope-based cleanup with goto-based error handling?

Looking at __set_oom_adj(), the function still uses goto err_unlock; for
error paths earlier in the function:

fs/proc/base.c:__set_oom_adj() {
    ...
    if (legacy) {
        if (oom_adj < task->signal->oom_score_adj &&
                !capable(CAP_SYS_RESOURCE)) {
            err =3D -EACCES;
            goto err_unlock;
        }
    ...
}

The newly introduced for_each_process_rculock() macro expands to use
scoped_guard(rcu). The cleanup subsystem guidelines explicitly state that a
function should either convert all resources that need cleanup to scope-bas=
ed
cleanup, or convert none of them, to avoid confusing ownership semantics.

Could this function be fully converted, or should the rcu_read_lock() remain
manual here until the rest of the error handling is updated?

>  			if (same_thread_group(task, p))
>  				continue;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907081334.1152=
889-1-ye.liu@linux.dev?part=3D6

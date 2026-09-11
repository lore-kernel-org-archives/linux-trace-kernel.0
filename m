Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4AE1B3925
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789114507; cv=none; b=Az1azJlada1/8ORa/Ar8gav777Aef/wPK0v/EP9aBkAlKwXWS8B9j6fkoItbspSK3O6Fa2X/JYXCbDA3PNohW2R0M8CiCjshbTULtyAZMK6tYaZKz331+A+tR72KAvvONkFwW8qzXm5ixAXUa9MDA4TXpLryDGWETMzAT1xwjzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789114507; c=relaxed/simple;
	bh=S7uG7gsgzSpS/yBDZ6TjlWqGgKEu9eyvqEblCp/IsB4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TLEC19p2NXt7aOTr2UP4z6Hc9G1W4QXaTWV7G+Hr/s/W572lquRD/LnA46aBi1Pyo605VXQ1LzMxidzH6GTZvxKAJ7x8gHVlB9YXlmtFBPt7HJ/1u3H4JSEes/g0fS9qQF5209iPNDPszW37OMTVwv3QR7yXcwqahVKnaSHUtls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4RYcQuM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4RYcQuM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735D51F000FF;
	Fri, 11 Sep 2026 08:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789114504;
	bh=0sTl0Zb88t8yR0hTbKgarFWW7fGf/gc/1FefTRJPBzI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h4RYcQuMKSDiISSvWy7v/ILqmGvsBjzUDQ+2i+FnRsloi43waDw/qiiB2qprwzWKR
	 uCTPMNdQc7/SSdNTzcCtJADgGnv2JxQuMcrH57j8ClEptTX7UZA1q/OgHP4c5OXdLe
	 1j5yRNkRE1z2RLZGkWj0C41LYl3/bbH+9zt+VwVkyv5vspdpngB71eGs7Ot4AM11Ci
	 x61ibIkZLtU8J1gzhYzcNaaB/RAfRU1dDUcP0LxxW4AjngVQQ+FeFNqY5DAS0QkYEy
	 P6JTbhsoLEJXgJc+H+m4Y8Unaj7hFOPtoOIjyeKdSKIAi+gt6XbPB6FXK3lkQtf6cs
	 wqJL/Qbk3WF2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/15] fs: convert process/thread iterators to
 for_each_*_rculock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ye Liu" <ye.liu@linux.dev>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260911075800.491472-14-ye.liu@linux.dev>
References: <20260911075800.491472-1-ye.liu@linux.dev>
 <20260911075800.491472-14-ye.liu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 08:15:02 +0000
Message-Id: <20260911081504.735D51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Mixing `goto`-based error handling with scope-based cleanup help=
ers in `__set_oom_adj()`.
--

commit dca26f99f6fe0ae1bf52a29a296c82180cb53c70
Author: Ye Liu <liuye@kylinos.cn>
Subject: fs: convert process/thread iterators to for_each_*_rculock

This commit replaces the manual rcu_read_lock() and rcu_read_unlock() pairs
combined with for_each_process() and for_each_process_thread() loops in
the fs/ tree with the for_each_*_rculock() macros. These new macros scope
the RCU read lock to the loop body using scoped_guard().

> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 58be389424605..2c47d838a1c76 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1161,8 +1161,7 @@ static int __set_oom_adj(struct file *file, int oom=
_adj, bool legacy)
>  	if (mm) {
>  		struct task_struct *p;
> =20
> -		rcu_read_lock();
> -		for_each_process(p) {
> +		for_each_process_rculock(p) {

[Severity: Medium]
Does this code introduce a regression by mixing scope-based cleanup helpers
with goto-based error handling?

The newly introduced for_each_process_rculock() macro expands to use
scoped_guard(rcu). However, __set_oom_adj() still relies on goto-based
cleanup paths earlier in the function:

fs/proc/base.c:__set_oom_adj() {
	// ...
	mutex_lock(&oom_adj_mutex);
	if (legacy) {
		if (oom_adj < task->signal->oom_score_adj &&
				!capable(CAP_SYS_RESOURCE)) {
			err =3D -EACCES;
			goto err_unlock;
		}
	// ...
err_unlock:
	mutex_unlock(&oom_adj_mutex);
	put_task_struct(task);
	return err;
}

The kernel cleanup subsystem guidelines in include/linux/cleanup.h note
that goto and cleanup helpers should never be mixed in the same function,
as it creates confusing ownership semantics. Could this function either
avoid using the scoped cleanup loop or fully convert the oom_adj_mutex
to a guard() pattern as well?

>  			if (same_thread_group(task, p))
>  				continue;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911075800.4914=
72-1-ye.liu@linux.dev?part=3D13

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3888B36197F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 08:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789114433; cv=none; b=XOHayiYg1TiUk71gGejUfVnElRWNkw4ZH5cQG8FiAx1xqDaJa002pjXNW/4NEQffGAi+UA11Ba7WH5K8vkXn340WFLHsMYQKg3mx/jZ9A8ZOmvM3P9Nr0YuDxn+xyy3VKrLtnKbrOmpZ+DB4sCD6WOLxBXdF4+hTuRAHlWvNtWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789114433; c=relaxed/simple;
	bh=tj5FUK9GBozTztAohw7zYPu8Ha54QchXYNREYhTb5Dk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bv9h2ZV0o7qCCuNk7T+vwONCYUV6JEj67j8yGD6MH1xoaJjRpy55ZyO4i/uzK7mrLQdRuxFYgYh+NB6kycXw8IsuDmf/MbgnhLMJeoeknkRq6w6u989uA+w5VdFenT3amI/EM47Qfvz2D1oWA5jbHCJAtsr31mWTYvp48PsZi+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J27xykXt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J27xykXt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FE81F00893;
	Fri, 11 Sep 2026 08:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789114431;
	bh=qMU50b8bhBsMuItBC/03FHZVqvydgk+QI5+Hycn6i9U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J27xykXtRrJMW8gA9vX8uVf1hQQwm/+MbAjVMO9NK23HCCdMaP9zBziqwvrmxNUiY
	 qWexqKootY4D7LeQoYbgVzboo8jlOn/yb66x4KyukmMFscUFB0wtV7gAvoflIVYOLP
	 4sOHXHBhhYeXA5iCYlibUfZKwVitRR4/fLPy03C6u2mbGidZMozIO7kvOhGfrhXcti
	 YhWPvVLaQW67AY+5Tr1+7D7HSeK8JHzEk/Je39nWQpbxEyij6uLMVvCljOb754gmn6
	 3CaoEdzeBwQDeKzgcycSyKFxxHSgAzmBz3D/+T+9rd6wBy74VS2lKxKS1wIDTIi9sY
	 /SOXq0DL51Sfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/15] mm/memory-failure: convert process iterator to
 for_each_process_rculock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ye Liu" <ye.liu@linux.dev>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260911075800.491472-5-ye.liu@linux.dev>
References: <20260911075800.491472-1-ye.liu@linux.dev>
 <20260911075800.491472-5-ye.liu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 08:13:51 +0000
Message-Id: <20260911081351.A8FE81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential NULL pointer dereference or Use-After-Free of `folio->ma=
pping` in `collect_procs_file()` due to concurrent truncation.
--

commit 788d1f422c3f19026d9e0d86b550c238607720ed
Author: Ye Liu <liuye@kylinos.cn>

mm/memory-failure: convert process iterator to for_each_process_rculock

This commit replaces the manual rcu_read_lock()/rcu_read_unlock() pairs
combined with for_each_process() loop in mm/memory-failure.c with
for_each_process_rculock(), which scopes the RCU read lock to the loop body
via scoped_guard(rcu).

> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index a8b03e2920ba8..7d93deb1f7b3d 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
[ ... ]
> @@ -589,9 +587,8 @@ static void collect_procs_file(const struct folio *fo=
lio,
>  	pgoff_t pgoff;
> =20
>  	i_mmap_lock_read(mapping);

[Severity: High]
This is a pre-existing issue, but could this lead to a NULL pointer
dereference or a use-after-free of mapping due to a race with truncation?

In memory_failure(), the folio lock is dropped in hwpoison_user_mappings()
before calling collect_procs(). collect_procs() performs an unlocked check =
of
!folio->mapping:

static void collect_procs(...)
{
	if (!folio->mapping)
		return;
	...
	else
		collect_procs_file(folio, page, tokill, force_early);
}

If a concurrent truncation removes the folio from the page cache immediately
after this check, folio->mapping becomes NULL. collect_procs_file() then
initializes mapping =3D folio->mapping and calls i_mmap_lock_read(mapping).

If the compiler performs a second read of folio->mapping, mapping will be
NULL, crashing the kernel on the semaphore acquisition. If the compiler
caches the first read, mapping will point to an address_space whose host
inode may have been concurrently freed, leading to a use-after-free since
the elevated page refcount does not pin the inode and no RCU read lock is
held during the blocking i_mmap_lock_read() call.

> -	rcu_read_lock();
>  	pgoff =3D page_pgoff(folio, page);
> -	for_each_process(tsk) {
> +	for_each_process_rculock(tsk) {
>  		struct task_struct *t =3D task_early_kill(tsk, force_early);
>  		unsigned long addr;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911075800.4914=
72-1-ye.liu@linux.dev?part=3D4

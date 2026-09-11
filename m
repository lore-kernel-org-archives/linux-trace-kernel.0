Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3C738DC65
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 08:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789114282; cv=none; b=X8NtC10dgxi0o/LDjS+vcwigKjAzV12w5qt5kqSGbeMwZuHIKISGnXLgdYIMeoWLgRrdPsvhKiFsM/AxKeklePUjWdWkeoT1zTeMtxq9krIfeMw9dDZDasn0M9S7GHsx3KwfgfJpU67x5utdXZSG2wPtAZnDj/oh7TFWI6yjENQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789114282; c=relaxed/simple;
	bh=eXuHGt67k3YWCU6sY4xsi4oujrtMDFHr4EXYTh2zNkI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dZ39O0mt99VtLo4L2hLW5drO1YuKbB+3gCZeN2I9l7bpCTopgVlkHbUQ8uvqlGsQt1dduvKLCm9qajptO8ZC9YCZuolJ5LqjWdAVFWJY4HyhiHXUDM437ybirzc1ADLRikOKx7jc91YLbuIaYeMOgOT7TVwWx04YL4f57h0Uzlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4lh7G31; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4lh7G31"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542271F000FF;
	Fri, 11 Sep 2026 08:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789114280;
	bh=PDQhD0qR7mWu4lGo6maeC8gc5EWr8d/4JkfM9qeJFa8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d4lh7G31kf1OgaqpCnikktJjjtGJuLkCNP2AuachVA6uFTqL95bbf5zZhFcR1NoGC
	 53YNB6NY5ZBBMGYsXB8IoQZpWmOXFyPUHowRgKSxBWNjHpo70lFzXDDr/yiPi76UTQ
	 rvncmlOFzGI4LzGlyGhUdJc4Vse9JA+DUdYEQ4EVaMefwgMs4bamVt/HmX5fyqB6bf
	 ZP3WIWXF3MrWXrhTNEwujfTFdnjNCmikYWwtClnTaFv8KU169v8kMq/xmLfLIQmMjb
	 +Et9TNeCaXWKq1P1v3Bv/8Ro6k5zBqG3d6pinjQJs+sPokCreymIdXjEoGnD+8F9x8
	 Dp+gh72vpGZQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/15] cpu/hotplug: convert thread iterator to
 for_each_thread_rculock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ye Liu" <ye.liu@linux.dev>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260911075800.491472-6-ye.liu@linux.dev>
References: <20260911075800.491472-1-ye.liu@linux.dev>
 <20260911075800.491472-6-ye.liu@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 08:11:19 +0000
Message-Id: <20260911081120.542271F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The commit message incorrectly claims to replace `for_each_threa=
d()` with `for_each_thread_rculock()`, but the code actually replaces `for_=
each_process()` with `for_each_process_rculock()`.
--

commit 3ac98de6fbc4e97ba4981ef0c4941692c15a9309
Author: Ye Liu <liuye@kylinos.cn>

cpu/hotplug: convert thread iterator to for_each_thread_rculock

This commit replaces a manual rcu_read_lock() and rcu_read_unlock() pair
in clear_tasks_mm_cpumask() with a scoped RCU lock iterator macro.

> cpu/hotplug: convert thread iterator to for_each_thread_rculock
>    =20
> Replace the manual rcu_read_lock()/rcu_read_unlock() pair combined
> with for_each_thread() loop in kernel/cpu.c with for_each_thread_rculock(=
),

[Severity: Medium]
Is the commit message accurate regarding the iterator being replaced?

The commit message subject and body describe converting a thread iterator
using for_each_thread() to for_each_thread_rculock(). However, looking at
clear_tasks_mm_cpumask() in the diff:

> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index b3c8553d7bd6c..00638d2abc0f6 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1254,8 +1254,7 @@ void clear_tasks_mm_cpumask(int cpu)
>  	 * full-fledged tasklist_lock.
>  	 */
>  	WARN_ON(cpu_online(cpu));
> -	rcu_read_lock();
> -	for_each_process(p) {
> +	for_each_process_rculock(p) {

The code actually replaces for_each_process() with for_each_process_rculock=
().

Could the commit message be updated to match the process iterator actually
used in the patch to avoid confusion during review or bisection?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911075800.4914=
72-1-ye.liu@linux.dev?part=3D5

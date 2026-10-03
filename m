Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B5F3769E9
	for <linux-trace-kernel@vger.kernel.org>; Sat,  3 Oct 2026 01:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991195; cv=none; b=OwSq0zzEBHsK1nAXImsJJqI9kxG+HA4+w7URQBVGfuXsQKzjbtyLra6jtZ40PC/nCE0nTJ8XMmdOkfuDaIkS+WnQwzElx9UEFZ2XJqNcrL3AZZaMNUOX+IfjzUlIHb6qYO/BO8IxCVu7esCJlqzFrru/za7FSO9HDKuEs4E157s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991195; c=relaxed/simple;
	bh=pmTrLcMgTq6KXGH+HP72txZ4XukBcYW4rPiWuOvp15w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BYTYftOCHVOeJw2GbG1xJLx5AQzP0RX9mitKUkGqtV4yj4ftTUi3V6U/E6zC05v+Sp89pXIK3hWMGMhmzyMYuQ9bRT97hH+962K3s18dStRmcxa16OhvC9s2nhDdgKLhMYFxHFbP3ziE7zm18yoOeIb/IHehdXPtz9+rVH+ApCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/2k8JyR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/2k8JyR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C221F000FF;
	Sat,  3 Oct 2026 01:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991193;
	bh=NYW9Hkk6d4rffnQZ7d4uQ8V+8rAL2AaKqDu2461qRh0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X/2k8JyR/qka6TzG4HDqqxn34ak5iHZuazC6gfcqnRSHR71WPjit7v8mt1FHdwq6Z
	 ZXM8dmVdicoqDtiteOcBwKVcbGmMUmzYb5t8An4nMUPqgASkLoXa9+8Xm1+bU1JQeF
	 CBSUdJG30T0d0s0RGKtXGS59JcKT95A7eCKFo58ljAZibJfrXilHlE0aEUrbvZreCY
	 /5xuAQY6k+ryPcfuZbkd5yHLWly3ipP6oktKidwg0dAdBgSN0WAcZIrJ1vkJjL/xav
	 Z+tggKSAZ6o9S4YucMpQo69L80Liplly2hvCu0il9biK0YLRek2fVf0eEdoKDvMxH7
	 11pOnsuWmmtyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] selftests/user_events: Test registration from
 existing threads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jeff Barnes" <jeffbarnes@linux.microsoft.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261002153934.798176-2-jeffbarnes@linux.microsoft.com>
References: <20261002153934.798176-1-jeffbarnes@linux.microsoft.com>
 <20261002153934.798176-2-jeffbarnes@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:12 +0000
Message-Id: <20261003013313.26C221F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests: dead code due to ASSERT_EQ abort semantics
--

commit 9691dbbeea14ab3039a7e9d6bdc6fcfa2fc670a9
Author: Jeff Barnes <jeffbarnes@linux.microsoft.com>

selftests/user_events: Test registration from existing threads

This commit adds a test to verify user event registration from existing
threads. It creates two threads that attempt to register events using the
same enable address and bit. The test checks that the second registration
fails with EADDRINUSE because they share the same address space.

> diff --git a/tools/testing/selftests/user_events/abi_test.c b/tools/testi=
ng/selftests/user_events/abi_test.c
> index b71813eaf5c04..bb1a17ce00da0 100644
> --- a/tools/testing/selftests/user_events/abi_test.c
> +++ b/tools/testing/selftests/user_events/abi_test.c

[ ... ]

> @@ -258,6 +259,137 @@ FIXTURE_TEARDOWN(user) {

[ ... ]

> +TEST_F(user, preexisting_threads_same_address) {

[ ... ]

> +	ASSERT_EQ(-1, registration.second_ret);
> +	ASSERT_EQ(EADDRINUSE, registration.second_errno);
> +
> +	if (!registration.second_ret)
> +		ASSERT_EQ(0, registration.second_unreg_ret);
> +}

[Severity: Low]
Are the conditional and its assertion here reachable?

The kselftest framework's ASSERT_EQ() aborts the test via __bail() if the
values do not match. The preceding ASSERT_EQ(-1, registration.second_ret)
means that execution only continues if registration.second_ret is -1.

If registration.second_ret is -1, then !registration.second_ret will
always evaluate to false, skipping the second assertion.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002153934.7981=
76-1-jeffbarnes@linux.microsoft.com?part=3D1

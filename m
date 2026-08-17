Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F70390229
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 12:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786968934; cv=none; b=muks+T/yWeXm0/fp/stuxp+SxcrobF4Wtz0ij315QWZx4ck0kAoK8XvO24p3k/5wYBdLZ6JyyNlUMQgYV5BQYPmXxFBuVMzL5TF+0jiY5r7pZP8/bpKw92hAFYQZUiEUsGNuR7ebCNnKSF2BuRTYXxZqmJeLv33vgBnPEHkubdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786968934; c=relaxed/simple;
	bh=F34J3UqByMetoOkvnPk9H08LdLanFeQi8+zMsOilxGU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FxKRJShiGf4KVOfWS5SAAMKDix0i+2Kg/G5+5CgiWCSI1DeCz4itqdZKmHiAwl8YTxEyH8DkTQk6po4eWwtryav1yEJ/n+NZIDZbGzGWo7hDoL3VLbDswbxS1FhRjmHk9VODYPN/aJt2NiurdSdKa/RBBhwnSycefS+DW8ilekQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vwlf/9/5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vwlf/9/5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C14A1F000E9;
	Mon, 17 Aug 2026 12:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786968932;
	bh=momeNjwzeIODc++V2uuw52sw5CM7ZYYQbleh4G4YhFs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vwlf/9/58CRGVDmaMxLVqvvjxGtTRTONu4JqxDISfsZTBXDSqcJ/AyKSX2wNJzwH4
	 HGlQhgdPpMMaj7J4yoXtF439SmyV40GLEfQ73V9gj9k7vHaGyPZx8SwHRoZHpCAmAa
	 zSqMT9K7B+9v3vJcJH2QfGcgBNON9sFnsxSN2AjLciyBY6WM6fFIxN2uvMsXZFvPQZ
	 /zReBc5QIxV6pkJhdfjD0rPNCuPLlvM7XYmvpYBf3EwCWKCzJZgVhSrWyYbo31AEBz
	 nh3lrSs9027c1yPzK4Mzfn6Md+d+jAw9/RARlS7PLneS3SiVOnhRi++l47Vw6RhPzq
	 tfUG5HcG0jTHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] tracing: Fix crash passing ERR_PTR to kthread_stop()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Su" <sh_def@163.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260817120642.668375-3-sh_def@163.com>
References: <20260817120642.668375-3-sh_def@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 12:15:32 +0000
Message-Id: <20260817121532.9C14A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Using `WARN_ON` inside `event_test_stuff()` causes a massive warni=
ng storm and potential soft lockup if kthread creation repeatedly fails.
--

--- Patch [1]: [PATCH v2] tracing: Fix crash passing ERR_PTR to kthread_sto=
p() ---
commit 692df106ab8d8e56701ad9c14c135871ee02df4a
Author: Hui Su <sh_def@163.com>

tracing: Fix crash passing ERR_PTR to kthread_stop()

This commit adds a check for the return value of kthread_run() in
event_test_stuff() to prevent passing an ERR_PTR to kthread_stop() if thread
creation fails under memory pressure during boot-time trace self tests.

> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 0356cae0cf74e..9e941e5805f5e 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -3866,6 +3866,8 @@ static __init void event_test_stuff(void)
>  	struct task_struct *test_thread;
> =20
>  	test_thread =3D kthread_run(event_test_thread, NULL, "test-events");
> +	if (WARN_ON(IS_ERR(test_thread)))
> +		return;

[Severity: High]
Does this risk causing a console flood and soft lockup if thread creation
persistently fails?

During boot-time trace self tests, event_test_stuff() is called within
large loops spanning all trace events:

kernel/trace/trace_events.c:event_trace_self_tests() {
    ...
	list_for_each_entry(file, &tr->events, list) {
        ...
		ftrace_event_enable_disable(file, 1);
		event_test_stuff();
		ftrace_event_enable_disable(file, 0);
    ...
}

If kthread creation fails, WARN_ON prints a full stack trace and returns.
Since event_test_stuff() returns void, the caller blindly continues to the
next trace event, potentially leading to thousands of consecutive stack
dumps.

Could this be changed to WARN_ON_ONCE() or modified to abort the test loop
gracefully?

>  	msleep(1);
>  	kthread_stop(test_thread);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817120642.6683=
75-3-sh_def@163.com?part=3D1

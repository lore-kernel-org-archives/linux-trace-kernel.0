Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F376217A2E8
	for <linux-trace-kernel@vger.kernel.org>; Sat, 15 Aug 2026 19:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786821036; cv=none; b=O5E6B073Vz2uAJ/V3S212O1ysGuzbrg+IfoCe/CdTHzG6PDq1gTB8NhmyfTszBYReJH/GVBZ5lrqwTvMZ0+6fuxtVtFk3OdX6cqPzP0ZaF7RIS9/fog/JwA7IaIjV9qyUCLd3w4zW/o9I1Ud4cpDzCihKvb90Z8gpWmtgfQv5Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786821036; c=relaxed/simple;
	bh=i8QicLoEzSIGpA/4Owv0U5Fl1Y9w0z/49g14n+1xEUg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PkUJlTUz+v7QvrU+oYig5s3oC/OygX33RZt1PAORRLp4j1HS3s82A4RbO8OKoRDkOPTDiC48CRbKABCWkv9yeJTu1Bslhk6mGj8me5dgwQHdE5w5JMpCxRZChJ/TeZVpSHfsoR38uRGbrHfPVzZVxXLk42Ob9AzVxuayFV1rLjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpaeZhL/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpaeZhL/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D8F1F000E9;
	Sat, 15 Aug 2026 19:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786821034;
	bh=k7CQxRGE+oUMUyEVBPhDWgVuWWFHUWCSKuzYutCSNGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SpaeZhL/W/N/75T+dxhp/9xcC34QbLkreqfuWEVPcnUmhtYUKzSRX19mWi8qJRxog
	 IQVAcOyrEhA22LhNhjZgjhX0UocGNja5FEZ+7I2noFC6rJjOFtz3EFdXver/I9Uvs8
	 vJhXQOflsMTyB5pkgQa/fg+98dm7h02DNHL2Gr5J4mUbqKdI181kmzeY1jHgctTWtc
	 uIx9XCKS2y1/qEL6rTD0Ridk32mkpKwM0VHSiPsvVEttGOzK4USgtYfTnq7bg9GPYw
	 IemIRl1VDHg7WpzCfYzRTyAYkcZmZZethC9+HcwU8bqhSUqm9udnQ7wJWsZ8omFRm1
	 SsspJOz2V+qng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing: Fix crash passing ERR_PTR to kthread_stop()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hui Su" <sh_def@163.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260815190151.568893-4-sh_def@163.com>
References: <20260815190151.568893-4-sh_def@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 19:10:34 +0000
Message-Id: <20260815191034.82D8F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Silent Test Bypass
--

--- Patch [1]: [PATCH] tracing: Fix crash passing ERR_PTR to kthread_stop()=
 ---
commit 40985725587eec80dcbbfbf251d18cd9797fe26c
Author: Hui Su <sh_def@163.com>

    tracing: Fix crash passing ERR_PTR to kthread_stop()

    event_test_stuff() calls kthread_run() and unconditionally passes the
    returned task_struct pointer to kthread_stop(). kthread_run() returns an
    error pointer such as ERR_PTR(-ENOMEM) when kthread creation fails, for
    example under memory pressure during the boot-time event self-test.
    kthread_stop() then dereferences the invalid pointer, crashing the
    kernel.

> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 0356cae0cf74e..207f47f54dbbf 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -3866,6 +3866,8 @@ static __init void event_test_stuff(void)
>  	struct task_struct *test_thread;
> =20
>  	test_thread =3D kthread_run(event_test_thread, NULL, "test-events");
> +	if (IS_ERR(test_thread))
> +		return;

[Severity: Medium]
Does returning silently here cause the self-test framework to falsely report
success when the workload thread cannot be created?

The caller event_trace_self_tests() unconditionally prints "OK" after calli=
ng
this function:

kernel/trace/trace_events.c:event_trace_self_tests() {
        ...
		ftrace_event_enable_disable(file, 1);
		event_test_stuff();
		ftrace_event_enable_disable(file, 0);

		pr_cont("OK\n");
	}
        ...
}

Should event_test_stuff() propagate the error so that the caller can correc=
tly
report the test failure or skip it appropriately?

>  	msleep(1);
>  	kthread_stop(test_thread);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815190151.5688=
93-4-sh_def@163.com?part=3D1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFEF441027
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 19:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789414085; cv=none; b=EB94fmOAhCD84pHCjNi0TrDIRBpDN/YGLTfBBsR32qqhEeIayrmIRINlr0EuTqyTsdnWIzOSfLGJE5RGFT6jVbzB43BbvZmHnZ34BmoTlCOzzmIvJJ2/JBSMSd6Ia8DnYexHzQcb2DRXCo71VQnX6Zw6Ik/SVuVd9MGTNMFzzkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789414085; c=relaxed/simple;
	bh=SkquSYama8kjHzK8vh1otQywhiMDsIIwVDieArpgTT8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pkuxoIhb5xpUOiPxnDiMlnSKS7o/r5cVRnqYeL1x51pZ2HqqCsYuxOyyaoJNL1IYV1nzdGPjOF/vP+471Trz8WrNU2Zee1WgG4ukYptIIYdRiLXhdnXtfv4hwg8bTCtlUrt7tftKslo0dxru7roTA4SwT9T7wu/wM+ix78qiaKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nx8QXAVw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nx8QXAVw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248CC1F000FF;
	Mon, 14 Sep 2026 19:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789414082;
	bh=dRZC1pvUt8Jf+vFSr4idYkwMLJA/1IJBVAyJJIz9UKQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nx8QXAVw9EE2b0VrFkwxYulh4TBcxkKmD4RyMDExuJFT/QLqPNpOJAs2zCu/cGT1I
	 jipzhqY7LM9j3HAbzISdk/gdWNy3O1mqg+B8VDqX3PaOS7iAtAbRhql/cm5nKFp+Ax
	 +fYaX2d8a+Ef/JTEszwVG6JHeahmM9Jt8yTWPZFH3Ewxqrlz60iR1gh+8hMDoZK44D
	 umrZrUuoiAAOxKbiF9b+JLAq3lqYmLxqAy2554R9QEqBnlbnPZ1Yst9H7OK5J/uc09
	 5ouIZgfXS2kuwHtU6zkaifQcmC5nakQoqj6OQJ1atGrZZpenLqdvkvtdMJLlzRU2QI
	 +zbay++dNdWYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/4] rv/reactors: add KUnit tests for reactor
 registration and dispatch
Reply-To: sashiko-reviews@lists.linux.dev
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <7d213b110815da45595ad8cd7bcce5641fac3404.1789412799.git.wen.yang@linux.dev>
References: <cover.1789412799.git.wen.yang@linux.dev>
 <7d213b110815da45595ad8cd7bcce5641fac3404.1789412799.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 19:28:01 +0000
Message-Id: <20260914192802.248CC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing module reference counting for RV reactors leads to a Use-A=
fter-Free if a reactor module is unloaded while still assigned to a monitor.
--

commit ad2a08e6decf463e8a9bfc030b93a95b3cf6f3b1
Author: Wen Yang <wen.yang@linux.dev>

rv/reactors: add KUnit tests for reactor registration and dispatch
   =20
Add KUnit tests covering the reactor register/unregister lifecycle
(including duplicate and name-length rejection) and rv_react() dispatch
(a no-op without a callback, exactly one invocation with one).

> diff --git a/kernel/trace/rv/rv_reactors_kunit.c b/kernel/trace/rv/rv_rea=
ctors_kunit.c
> new file mode 100644
> index 0000000000000..3850c6dda288f
> --- /dev/null
> +++ b/kernel/trace/rv/rv_reactors_kunit.c
[ ... ]
> +static void reactor_teardown(void *arg)
> +{
> +	rv_unregister_reactor(&test_reactor);

[Severity: High]
This is a pre-existing issue, but could rv_unregister_reactor() leave
dangling pointers if a dynamically loaded reactor module is unloaded while
still assigned to a monitor?

Looking at rv_unregister_reactor() in kernel/trace/rv/rv_reactors.c, it
removes the reactor from the global list but does not appear to iterate over
active monitors to detach it.

Furthermore, in monitor_swap_reactors_single(), the reactor is assigned to
the monitor without taking a module reference count via try_module_get():

kernel/trace/rv/rv_reactors.c:monitor_swap_reactors_single() {
    ...
    mon->reactor =3D reactor;
    mon->react =3D reactor->react;
    ...
}

If a user with tracefs access assigns a dynamically loaded reactor (e.g.,
reactor_printk.ko) to an RV monitor and then unloads the reactor module,
when the monitor's tracepoint fires, rv_react() would invoke the dangling
monitor->react function pointer.

Could this jump into the unmapped memory of the unloaded module and cause
a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789412799.gi=
t.wen.yang@linux.dev?part=3D4

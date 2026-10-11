Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECEF23BCF7
	for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Oct 2026 19:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791748380; cv=none; b=iRSZnI6b1vVAc0AqGB6DfR4RDVXmYhn3pu91geu7G8EMwNS7MVeaARPan5XUkSLbODq+R42tfXY9KLm3K3RIXixFwdPACO3YIIIPudxYCgTXDKy4dsmD7MN06R98h2jJuK8wcmlmd97mOoO/K9tPhrv6LxeDXuaa52ArMNHUmbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791748380; c=relaxed/simple;
	bh=xuP9PkEvuvaznLFhqRLKNHCk2LS/iY5Pq5YpdBjczXw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qk9kEcrXFp0IY80xrR5IDyhxctXy/JuSOa2wTasd9qeFjeMJtDmHgKlvgzsdzHGKj1zR80ie38EMJsvVNblGZXuijq7UFulsyEkhsImsLY3eBS5ayycFOunabNrjTF/5lgeWGtnQeqtwE+BDtXw6LCFh0Jr9DH1T4Y9qaC1t5RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnwL4Wpq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnwL4Wpq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7AFD1F0089C;
	Sun, 11 Oct 2026 19:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791748379;
	bh=q3uKiuYTHBqb35whYWzw70d7z1TH/d/S/Qpt+MkCMnI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UnwL4WpqEepe63pO1/ZdiZLBQEG9m1sCBTw6CLCUbwRXzRcAOH+9ZOEwm9ZUqqDNw
	 HJKQzzo3AdhTpeHQivqY40jvylvQ2Q75h0IYhG2Rk/ubWVfWzpNL0CxN3atugu18Zo
	 jAPKTypVJKZY1yywlndoXEHPDwn3AXRHJVXrgQ016jnxJWbIS46TWtWbh8VxLCHICf
	 iVn3SNJwyHv0RrXOhvXeBOEnH11EsCsrIwzlLPNwuu29T/ySc2W02y2BZgMnbhVmN4
	 Wzzh9Ake96HqP7zO1gP2GjT2+gZnlMk5TE72zE0mTzkHDXGdbXFb0f23+u1MzVdjdX
	 zS6E6iJ7R1lKQ==
Message-ID: <sashiko-outbox-167426@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/14] rv: Add a KUnit test for the HA timer
 underflow
Reply-To: sashiko-reviews@lists.linux.dev
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <cdaf33af866392428f1942cef4e442b1d106989c.1791745088.git.wen.yang@linux.dev>
References: <cover.1791745088.git.wen.yang@linux.dev>
 <cdaf33af866392428f1942cef4e442b1d106989c.1791745088.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 19:52:58 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] rcu: scoped_guard(rcu) drops lock prematurely, leaking RCU-prote=
cted pointer
--

commit 578060191fd58b6c308a14708ec520459063ef75
Author: Wen Yang <wen.yang@linux.dev>

rv: Add a KUnit test for the HA timer underflow

This commit adds a minimal per-object HA monitor called rvtest. It also
introduces a test to verify that the HA clock math does not underflow
when checking invariants and starting timers.

> diff --git a/kernel/trace/rv/rv_monitors_test.c b/kernel/trace/rv/rv_moni=
tors_test.c
> index 3ad11195e664a..889a209f64358 100644
> --- a/kernel/trace/rv/rv_monitors_test.c
> +++ b/kernel/trace/rv/rv_monitors_test.c
[ ... ]
> +static void rv_test_rvtest_underflow(struct kunit *test)
> +{
> +	struct ha_monitor *ha_mon;
> +	struct da_monitor *da_mon;
> +	const int id =3D 4242;
> +
> +	prepare_test(test, &rvtest_mon);
> +	da_handle_start_run_event(id, NULL, start_rvtest);
> +
> +	scoped_guard(rcu)
> +		da_mon =3D da_get_monitor(id, NULL);
> +	KUNIT_ASSERT_NOT_NULL(test, da_mon);
> +	ha_mon =3D to_ha_monitor(da_mon);
> +
> +	/* Uptime below the budget: time_ns - expire_ns would underflow. */
> +	ha_reset_clk_ns(ha_mon, clk_rvtest, 0);

[Severity: Medium]
Does this scoped_guard drop the lock prematurely?=20

Because there are no curly braces around the scoped_guard, the RCU read-side
critical section only covers the single assignment to da_mon. Immediately
after da_get_monitor() returns, the guard scope ends and the lock is
released.

However, da_mon and its container ha_mon are dynamically allocated
RCU-protected objects. They are extensively used outside the critical secti=
on
in the subsequent test steps.

For example, ha_reset_clk_ns(), ha_start_timer_ns(), and=20
ha_cancel_timer_sync() all dereference this pointer after the RCU read
lock has been dropped. Could this violate RCU lifetime rules and create a
use-after-free risk?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791745088.gi=
t.wen.yang@linux.dev?part=3D3

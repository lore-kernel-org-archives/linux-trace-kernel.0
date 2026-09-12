Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBD82576E
	for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789203523; cv=none; b=GiojyuZvRc5O7gPLS/S/QlI9v9oPxuNkOs/7pJkFbKZLuezQLMn8lW5rGQniCIunBZm3CRx0cIdUMHJYopZcJ6grOWnjbhzRdVGHhmpzHOujQg/yvNPrY6UM0C1f6Jmke5V8HYB66C5vgijGVa5xgDquKvfpQxmnVPERaM0ArLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789203523; c=relaxed/simple;
	bh=ODFwmoUJ7F502RttgbtPmz+OvugeZHktqiNYvAVmzn0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DyKcxtpOsNGBqIoTkTBngVUv8VIGRIoDWToUv26AHatoVRZYnDuEM8kJGX6RSPMb2J7XsySwr4bz3tt+1acY/ENwRoEPuu+5EZfccwnFtYll1/YezMko7kXLmcqyMlIvJHsjc6IHAHl/5u8KD5HG6lOj0RIYkB4D04yNRrJt2uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/M9nNcA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/M9nNcA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E7B1F00893;
	Sat, 12 Sep 2026 08:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789203521;
	bh=j/YwX7ZK/wvEVNtWsR1Cxi44xkm6+FYXKPm3WWnlEv0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U/M9nNcAhC4uiQlNupO5yW0xIl/m+h8nVpIVRiM6eOa00VlpW2PQOpQAijwDowvc9
	 YHwMskf2uXADifEQ7cISpNz2wpfnqGXjjE4cnSU8B2d/knEg+/veqzFW7WuYfnoAq1
	 zvtLnnlyx0YfgiCMhuaZiHH+muMexhUQF/F9hhYBCICH4x9M6g/RhqD9wThg2Ac2bV
	 IigCeBfKa/McokiVOUL3bUyTAN5EBNosNhXO6XU6fqZTBhlsXYr07s6/8Ou3LcqYUN
	 H29+vvTDSoiv7gO+e0djVe2b5Js+N7OWY8BChIMvVcqmq+psVqzyeO4CPvfBkQSAUw
	 DrQeIxYcWlJLA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v7 05/10] trace: make the stackmap capacity settable
 on the kernel command line
Reply-To: sashiko-reviews@lists.linux.dev
To: "Li Pengfei" <ljdlns1987@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260912083753.3426176-6-lipengfei28@xiaomi.com>
References: <20260912083753.3426176-1-lipengfei28@xiaomi.com>
 <20260912083753.3426176-6-lipengfei28@xiaomi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:58:40 +0000
Message-Id: <20260912085841.48E7B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Booting with the parameter `ftrace_stackmap.bits` without providin=
g a value causes a NULL pointer dereference, crashing the kernel during ear=
ly boot.
--

commit 7bbdd67c3f0e40d0b1656f5e92da61a336e639f5
Author: Pengfei Li <lipengfei28@xiaomi.com>

trace: make the stackmap capacity settable on the kernel command line

This commit adds the ftrace_stackmap.bits kernel command line parameter to
allow sizing the stackmap capacity at boot. The value is clamped between
10 and 18 to bound the worst-case element pool allocations.

> diff --git a/kernel/trace/trace_stackmap.c b/kernel/trace/trace_stackmap.c
> index 439d3be9e3516..49ea403822ba3 100644
> --- a/kernel/trace/trace_stackmap.c
> +++ b/kernel/trace/trace_stackmap.c

[ ... ]

> +static int __init stackmap_bits_setup(char *str)
> +{
> +	unsigned long val;
> +
> +	if (kstrtoul(str, 0, &val))

[Severity: High]
What happens if the ftrace_stackmap.bits boot parameter is passed without an
equals sign and value?

During early boot, parse_args() uses next_arg() to parse the command line. =
If
the parameter is passed without a value (e.g., just ftrace_stackmap.bits),
next_arg() assigns a NULL pointer to the value string.

Does passing this NULL pointer directly to kstrtoul() cause an immediate NU=
LL
pointer dereference and kernel panic, since kstrtoul() does not check for a
NULL pointer before dereferencing it?

> +		return -EINVAL;
> +	val =3D clamp_val(val, FTRACE_STACKMAP_BITS_MIN, FTRACE_STACKMAP_BITS_M=
AX);
> +	stackmap_map_bits =3D val;
> +	return 0;
> +}
> +early_param("ftrace_stackmap.bits", stackmap_bits_setup);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912083753.3426=
176-1-lipengfei28@xiaomi.com?part=3D5

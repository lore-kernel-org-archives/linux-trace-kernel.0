Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1A233E36A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 07:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787816059; cv=none; b=sHFwAiagSJcglIF0P5tkm5ZtO79bISlBXiW9flcpH8MANMqBkI0syq1Y63ECxJxf4Avcu1RncC0fkPZODLhZXinajNgRdjuOWJw+bf0oPwodDCpAk2+z7r/79IBQ9XzFDqZMHONTfbNjkmb4RfaEkTbeX+3qDr4Z2xJREdyM26c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787816059; c=relaxed/simple;
	bh=xO9A9Qc5SodOi5/Nh7ecPB/7WDaMf2YsZTErW+oZzDk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tyQ4INfSr2Poz1pwbvU1ohAT6tSKOAgTP369qru9WKQidNvgqDIJPzjWdiaARm4qolS4j9AAXAxwecBEpXS9d9MIIYqFjtZPOVKKvvoB1mV8g2C89w2qeKFtVLEdvU0A3jgmOh6xtAd1dVOjupIaylUGcL5VGeElxdI9hYnmO/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dq3qOFbp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dq3qOFbp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2091F000E9;
	Thu, 27 Aug 2026 07:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787816058;
	bh=kt5uj/Y4hxWXpyT8VWyrkjJA7fHnbr/avzgudgqmbzU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dq3qOFbpmbejcysSh7RZW5SNOH+HmtOuITcwgvgqGZ/Kd36XQX0A+EA2tvN7bwncB
	 wq7UzBiHcIOUZS9EgopmIDfCGInCoAXgFvzJSmu5JUsLNvI13ZJ8n++oNOuSxlgGMD
	 8p90nyytIKgZkIVDdHvRdyVHunnCSMYWHT/gUcUjSh3zHPby9a5PA46N3+cy+Aprj1
	 eD9hMuAqBqTVlC97EHzKBJhnquYq0i6EJQ03q9rg8bmXaIkAx7vQGmy6RmQu+w8vsp
	 VmMAc9cOUAYzcoLGXZwXaANHA9EU9gy2gyqqhcteRNkkSHF8Pczt59fQvmhDpwGzS8
	 1k1RkPmByz9Rg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC 1/3] rv: add per-edge dwell-time statistics primitive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tobias Schaffner" <tobias.schaffner@siemens.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260827072400.45734-2-tobias.schaffner@siemens.com>
References: <20260827072400.45734-1-tobias.schaffner@siemens.com>
 <20260827072400.45734-2-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 07:34:17 +0000
Message-Id: <20260827073417.CA2091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] NMI Deadlock / Lock Reentrancy on 32-bit architectures
--

commit 29c9d40bef06feb46125ab67ac5762b58ace9c11
Author: Tobias Schaffner <tobias.schaffner@siemens.com>

rv: add per-edge dwell-time statistics primitive

Add a small primitive that records, per automaton edge, how long the
monitor dwelled before taking it with a count, a sum and a maximum.
The counters are kept in local64_t variables so a monitor's hot path
can update them without disabling interrupts.

> diff --git a/include/linux/rv_edge_stat.h b/include/linux/rv_edge_stat.h
> new file mode 100644
> index 0000000000000..751de8074dcc3
> --- /dev/null
> +++ b/include/linux/rv_edge_stat.h

[ ... ]

> +static __always_inline
> +void rv_edge_stat_account(struct rv_edge_stat *s, u64 dwell_ns)
> +{
> +	s64 max;
> +
> +	local64_inc(&s->count);
> +	local64_add(dwell_ns, &s->sum_ns);
> +
> +	/* Keep the largest dwell; retry only if a nested update raced us. */
> +	max =3D local64_read(&s->max_ns);
> +	while (dwell_ns > (u64)max) {
> +		s64 prev =3D local64_cmpxchg(&s->max_ns, max, dwell_ns);

[Severity: High]
Could this cause an NMI deadlock on 32-bit architectures?

The commit message notes these counters are lock-free, but on 32-bit platfo=
rms
lacking native 64-bit atomics (e.g., ARMv6 or RISC-V 32 with
CONFIG_GENERIC_ATOMIC64=3Dy), local64_t operations fall back to atomic64_t.=
=20

The generic atomic64 implementation uses a hashed array of spinlocks acquir=
ed
via local_irq_save(), which disables regular interrupts but not NMIs.

If an NMI interrupts rv_edge_stat_account() while it holds one of these
non-reentrant spinlocks, and the NMI handler triggers an RV monitor event
that hashes to the same lock, would the CPU deadlock attempting to acquire
the already-held spinlock?

Does this implementation need an explicit check to abort if
IS_ENABLED(CONFIG_GENERIC_ATOMIC64) && in_nmi(), similar to the protection
used in the trace ring buffer?

> +
> +		if (prev =3D=3D max)
> +			break;
> +		max =3D prev;
> +	}
> +}
> +
> +#endif /* _LINUX_RV_EDGE_STAT_H */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827072400.4573=
4-1-tobias.schaffner@siemens.com?part=3D1

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB552E173D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786716179; cv=none; b=M0vavHKP2OQen6aGvqOkYvhya67kH/kPvQSwk3MiCqvJGOAYE2pdzHwO1+ZzeACl0Vo80UjJu0wIC4egU2Jnf+U2zCLaHuBEEzilyaqPVo4lspChbycYBpzV+tnzkQ6I/NSrsBokdGrL6xyoGvTEeBSTfAFRY+rw+SsU5/vO6Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786716179; c=relaxed/simple;
	bh=8Lo/Hy8TY7ECweRASA0fsU7NhCGgYKRu1dvQp4pnV7I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RH8IAYFRLc6Gx5qflCnqcdwZ7LP8QDEld4U6y7gUws1xsghbKLMYRbGFUHTnKK2feZwmxXV8Nul3Hz9dS2fCfQeSY4mwsfw7JkRXh9LfIBjyvYDNbBLGKlCJ26vrh9vSAlALXw0NKSsXdZ5N7R39TtBrSTZgzmml+voWuNKUaFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECobVDo6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECobVDo6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6C81F000E9;
	Fri, 14 Aug 2026 14:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786716178;
	bh=L2PHGh8XhqF5mQKsNslPqGOg65X9vL03TaHwSYdIspk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ECobVDo6wd92QJP9ymzYthalJHDhJ+sS/+OoawLjohmmZfyS/UCY/1P3wUdtvt7kH
	 NtMaABBr7gGirmURf9O2lSGMnJzn+KLi4CKlKJzbuNSz0uDNkozN5tEF44yZP3aOg3
	 UWMlxAUoV9DmJ0KPkD8MKEEq7DLaYGyQIc00Ll55H74NQo9FULyHGnMdI0Yf+hWUxp
	 kMJWC7x/NK0Vumvb/RlmiREMaZEd7E041w46hiKDEN4FmtD2E+ATr308ay4HahyVaF
	 1n6OJiikXCKtkqJAMxWUNZvDZG/DBYEM5ata41NwomMW1vDFY9OrMCVSHUowTk+0K5
	 DrdFPzkNmavPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] rtla: Discard trace entries with cpu >= nr_cpus
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tomas Glozar" <tglozar@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260814135511.2207190-3-tglozar@redhat.com>
References: <20260814135511.2207190-1-tglozar@redhat.com>
 <20260814135511.2207190-3-tglozar@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 14:02:58 +0000
Message-Id: <20260814140258.7A6C81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The printf format strings incorrectly use `%lld` to print `unsigned=
 long long` variables.
--

--- Patch [2]: [PATCH 2/5] rtla: Discard trace entries with cpu >=3D nr_cpu=
s ---
commit 2e2ceb9161355aea34f26cdf4de0da20e2aa2e3d
Author: Tomas Glozar <tglozar@redhat.com>

rtla: Discard trace entries with cpu >=3D nr_cpus

This commit adds a bounds check to rtla to discard trace entries when the
CPU index exceeds the known number of CPUs. It introduces an invalid_events
counter and updates the tool's output to report when such events occur.

> diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/os=
noise.c
> index 4ff5dad013b10..b9bcbf9ee430c 100644
> --- a/tools/tracing/rtla/src/osnoise.c
> +++ b/tools/tracing/rtla/src/osnoise.c

[ ... ]

> +void
> +osnoise_report_invalid_events(struct osnoise_tool *tool)
> +{
> +	unsigned long long total_events;
> +
> +	if (tool->trace.invalid_events > 0) {
> +		if (tool->trace.missed_events !=3D UINT64_MAX) {
> +			total_events =3D tool->trace.processed_events + tool->trace.invalid_e=
vents +
> +				tool->trace.missed_events;
> +
> +			printf("%lld (%.2f%%) invalid events, results might not be accurate\n=
",
> +				tool->trace.invalid_events,
> +				(double) tool->trace.invalid_events / total_events * 100.0);

[Severity: Low]
Since invalid_events is declared as an unsigned long long in struct
trace_instance, should this printf format string use %llu instead of %lld?
If the value were to somehow exceed LLONG_MAX, it would print as a negative
number.

> +		} else {
> +			printf("%lld invalid events, results might not be accurate\n",
> +				tool->trace.invalid_events);

[Severity: Low]
Does this format string also need to be updated to %llu to match the
unsigned long long type of invalid_events?

> +		}
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814135511.2207=
190-1-tglozar@redhat.com?part=3D2

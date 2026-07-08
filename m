Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6073A63FB;
	Wed,  8 Jul 2026 00:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783472146; cv=none; b=qRY8hcBBZHXaI4YuPWtNrw8m0FyrUQ649hXV/tWusNdQIBmzuTI/tf0RjMYwIzSbIP+65hOIRhE2dE2w81yRr6IXej6nyQShEZ/dE+uQ72Zvk1c6RkKA+wtpYCvrToy37+1b9OyVRXyCssqkOuyenKUayy8hY0G5a44Qlla92b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783472146; c=relaxed/simple;
	bh=y5hhRHC7vKyufrVYCl4P8U8W+OF7RqDoVp1egTbeEy8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UyPNrRJP/SsJgjk6qsGU26nLDZLp1ToW36rI7zH0tIJh8Z4Ttm97SD2O4BQ3LKXPKwlVePm3dbltERFvnsviTE86JhfozPldXoDoOVrsaVxP8M/rCzDarAapoIGoZXbafXjKI3XsF9BQI5H+gz8jYT/ackLgulc9/fB9dCKhfTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZ/nGzZe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZ/nGzZe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124341F000E9;
	Wed,  8 Jul 2026 00:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783472145;
	bh=XRAnSmciVx2Uv4vUT+zMl7S2GSv+W3820dA+59HEuQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oZ/nGzZeYoH2tT49qy0JP7bPImKjYNCoqtGmbMWIGBgeDFbE8SO6DCo58NrcxAN9C
	 vATmCqgUsIO930R4BTHH5pyVrRwvJE3cr7M+WPLO/9u+C3n/bh8NYmZOVUcUQh8Let
	 VUFVvI2f4FLqj609hnDneqUzOMRM2WxJ2VujUxQIuIfL/SNghUH0mp3Aa/Z/F1frBk
	 UVx8xtryZ64qzN+191OYfvfG19bkyM8FiPZfL8W2Hquykb22LHoa5K2nWO7lpPjfDc
	 WxwIrJWtZ3Ow3AZcvyfZSILzOGb0Frvq8B09eK2qhR8k84fXcIiORHFICg53bIfXIP
	 VLojfCpZDBDXg==
Date: Wed, 8 Jul 2026 09:55:40 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Pu Hu <hupu@transsion.com>
Cc: "ada.coupriediaz@arm.com" <ada.coupriediaz@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "davem@davemloft.net"
 <davem@davemloft.net>, Hongyan Xia <hongyan.xia@transsion.com>, Jiazi Li
 <jiazi.li@transsion.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
 <linux-trace-kernel@vger.kernel.org>, "naveen@kernel.org"
 <naveen@kernel.org>, "will@kernel.org" <will@kernel.org>,
 "yang@os.amperecomputing.com" <yang@os.amperecomputing.com>
Subject: Re: [RFC 0/3] arm64: kprobes: Fix single-step fault and reentry
 handling
Message-Id: <20260708095540.31c97fcbe9a56f3fd7f0b284@kernel.org>
In-Reply-To: <20260706083636.159883-1-hupu@transsion.com>
References: <20260704234730.46d51c47d75e7d208e7bec9f@kernel.org>
	<20260706083636.159883-1-hupu@transsion.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi, Pu,

Thanks for updating the series. But even if it just update
the signed-off-by, please update the version.

Also, can you check the Sashiko's comments?

https://sashiko.dev/#/patchset/20260706083636.159883-1-hupu%40transsion.com

Thank you,

On Mon, 6 Jul 2026 08:36:46 +0000
Pu Hu <hupu@transsion.com> wrote:

> From: Pu Hu <hupu@transsion.com>
> 
> This series fixes two arm64 kprobes issues observed when running
> simpleperf with preemptirq tracepoints and dwarf callchains while a
> kprobe is active on a frequently executed kernel function.
> 
> The crash happens in the kprobe debug exception path. While a kprobe is
> preparing or executing its XOL single-step instruction, perf/trace code
> can run in the same window. That code may either take a fault of its own
> or hit another kprobe.
> 
> Patch 1 makes kprobe_fault_handler() handle a fault in
> KPROBE_HIT_SS/KPROBE_REENTER only when the faulting PC points at the
> current kprobe's XOL instruction. Otherwise the fault is left to the
> normal fault handling path.
> 
> Patch 2 allows a kprobe hit in KPROBE_HIT_SS to be handled as a
> recoverable one-level reentry. Only a hit while already in
> KPROBE_REENTER remains unrecoverable.
> 
> Patch 3 adds a kprobes selftest which registers a kprobe on a frequently
> executed filemap fault path and drives repeated file-backed page faults
> from userspace. This provides a smaller reproducer for validating the
> fault handling fix.
> 
> This follows the same logic as the existing x86 fixes:
>   6381c24cd6d5 ("kprobes/x86: Fix page-fault handling logic")
>   6a5022a56ac3 ("kprobes/x86: Allow to handle reentered kprobe on single-stepping")
> 
> Reproducer:
> 
>   simpleperf record -p <pid> -f 10000 \
>     -e preemptirq:preempt_disable \
>     -e preemptirq:preempt_enable \
>     --duration 9 --call-graph dwarf \
>     -o /data/local/tmp/perf.data
> 
> The new selftest can be built from tools/testing/selftests/kprobe/ and
> used to exercise the page fault handling path with the test kprobe
> module loaded.
> 
> Before this series, the crash reproduced frequently. With both patches
> applied, it was no longer reproduced in our testing.
> 
> 
> Pu Hu (3):
>   arm64: kprobes: Do not handle non-XOL faults as kprobe faults
>   arm64: kprobes: Allow reentering kprobes while single-stepping
>   selftests/kprobes: Add kprobe stress test for page fault handling
> 
>  arch/arm64/kernel/probes/kprobes.c            |  22 +++-
>  tools/testing/selftests/kprobe/.gitignore     |   2 +
>  tools/testing/selftests/kprobe/Makefile       |  75 +++++++++++++
>  tools/testing/selftests/kprobe/fault_stress.c | 105 ++++++++++++++++++
>  .../selftests/kprobe/kprobe_folio_stress.c    |  70 ++++++++++++
>  5 files changed, 273 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/kprobe/.gitignore
>  create mode 100644 tools/testing/selftests/kprobe/Makefile
>  create mode 100644 tools/testing/selftests/kprobe/fault_stress.c
>  create mode 100644 tools/testing/selftests/kprobe/kprobe_folio_stress.c
> 
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

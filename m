Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795786895;
	b=sjebcOdwpLLZvcZtkaRr2ErnBg40Jt18PPKyygI84uhWEbNXboc973/naay1MmMpW8S1
	 CC6X+b5jx90tU0OUKwyef2YI6Pppbc5I/KhJ6zZmepq5IkwJgADcJp1GdQiNfAhjisVVK
	 4PLU4byM2JEYaA3X2TreXKNgYqyxi0bFV4uxDRaGo2vWQhreXatEEOA1t9G0aQY14nLtt
	 7iB5LGze2/r7vwXTl1017toYVjydeIKi9XTk+E4Lj3eWuc6ItZUY3X5l8TlDfDxF19V8K
	 VsO2OYdvI8eIrKQEdLdcJBVFNnf2Wz5nu9DSjPK8u4vY55fEDzcv4kbsJBQRhMGY8Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795786895;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=7PWYFgnWRA7J2Tp/U4CnHi6Y624sycAtEGCSG6P7wvY=;
	b=q25f7HCUiXtdoW2VwdNx6JUQttwLvYCFB0yh0qazXc4sA3XogoMHG5Sa9WHRCCGN/rxR
	 YY5ehldbpY7gSdpb4f8nMJVs0iBzrRk9X2F1ggZ4TrPvPJJO5zMiKfUG1z6VYlYa+kmrz
	 zq60M5LmpX4fl5Lul5dKchOvmYJHwRxLToCmuJvKuLlpn5Dz4wgqpjqksFqstM6pVEVD1
	 Abty7nkhpGYiyUw/IkzR4d5Qj18CtY/4AQSHAQ+grI9GRiYE7G5/cKMBEaX5FVMJQLOoK
	 4BLO37OIsllr3T2iPTpM8U+sOd4aEJRdC8rOoPXdT6/i0Ujo29jiPFrSAXNIsDamMTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=lhRJNn0e;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80802606A31F;
	Fri, 27 Nov 2026 13:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80802606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=lhRJNn0e
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F3CB1570;
	Fri, 27 Nov 2026 05:41:30 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E06573F632;
	Fri, 27 Nov 2026 05:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795786893; bh=8KEDacbw0dHPGzTZCNTPxnLhbFoFMfZ9vy+2X8aYvwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lhRJNn0e0C7SOTPvKpU24lIDbZ0aTvOoLxGMhvMLvDl0xm2HQGGd1Q4gkd2evIv+3
	 detfJ3BZlCwzoWLpVLy7SFHm9VpAYM9k8LFLvxE43d8mWDZq2wvGrYg9O+uwOOQa6N
	 ZMs14ruTwOSQucCvmEkmAvhRAUalfERUcaDj4R7g=
Date: Fri, 27 Nov 2026 13:41:27 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Will Deacon <will@kernel.org>,
	Hongyan Xia <hongyan.xia@transsion.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Song Liu <song@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] arm64: Always inline raw preempt count updates
Message-ID: <awmIhwotoPEWoO6B@arm.com>
References: <cover.1795631277.git.kmehltretter@gmail.com>
 <5ba8c2a33188f43f0b1d99d6ba97c8ea2e285f94.1795631277.git.kmehltretter@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ba8c2a33188f43f0b1d99d6ba97c8ea2e285f94.1795631277.git.kmehltretter@gmail.com>

On Thu, Nov 26, 2026 at 03:30:52AM +0100, Karl Mehltretter wrote:
> From: Hongyan Xia <hongyan.xia@transsion.com>
> 
> Raw preempt count updates can be emitted out of line by the compiler.
> For a noinstr caller, that puts the update in ordinary instrumentable
> text. Force __preempt_count_add() and __preempt_count_sub() inline so
> their code stays in the caller's section.
> 
> Link: https://lore.kernel.org/all/c3a90368dd6c096af9d918e036a27728696fb8a4.1786603168.git.hongyan.xia@transsion.com/
> Signed-off-by: Hongyan Xia <hongyan.xia@transsion.com>
> [kmehltretter: split out the arm64 preempt.h hunk and rewrite the changelog]
> Reviewed-by: Hongyan Xia <hongyan.xia@transsion.com>
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

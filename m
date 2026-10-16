Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212432D73A0;
	Fri, 16 Oct 2026 10:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792147330; cv=none; b=QwORAwDVv7jVMsCa4qVvtVN7B4vy9g/AspWXSMs3shrvegJHycfSx5ZaATHiLTsB7LgmuUdvVnRoPWLJjvSWv6lC/cQuuRRJsGla+1TdJZHzke9IGucP9NvOzEBSGceMooaHbUjQpYmi2uMsiDEwrszefV5DiJNg8uEYEpnR8eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792147330; c=relaxed/simple;
	bh=F71yxtaSCRE0wXd4f6uIRENIbKKS4F4/XQzsDVoFqOI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PI5Gjf04c/skoa3s4AYmz51k3N9qijtQyeOwQIsTZg8ziv8reE99SHrkuYyz+FPXxeT0izR05SxefMICsK32H5TEunlLYvn3dDJ75eIaoFDXiBseIl16248l+KdZVlMS3pYRNJKEb3tGLqq7kH9F9W2e1FQY6Eq2d150tIOGF4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vLf0FZ4g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EO7sA8qy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vLf0FZ4g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EO7sA8qy"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792147326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=epipb8UoYa5GWthCFcixoeMax2SLLfM/Rj85ANexd1w=;
	b=vLf0FZ4g3rNum2yM5/2nRCLLFF98FWcx27XeYwjcgF4q/MH0kVjJGYHaQhdBBU+QXqYX6E
	AdNGoggZGd8TPd8ir5VwzLV3krIZWF91W2FCx1L54v3sMnWmOpb4xDaqsxp1B+5PzuM3DG
	6C88yDXZPFlrKhruG35E5ebTQYENERf68qZ1Xtusim1zwzmr0JOyU0kpPEIup2YObfJKm8
	c1Cvu4AZJ1z79QwxmUs+ZHlZDG6cvd+HVRLpBUC1FPvbS5chtP43Q1OupshtOktj36VFoo
	zA9tKUM7Y0tF1P820FOOJNPlevimzgEEu3ylxJx327thQrhIq7JlW5i0S0YIgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792147326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=epipb8UoYa5GWthCFcixoeMax2SLLfM/Rj85ANexd1w=;
	b=EO7sA8qyfPso319AYSbb7NyPsYzOTG7CwoFSdh/qMxnqgMYlnroole8M+YBbo7MoE9T9H4
	6Wq3i301xBraihCg==
To: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Naveen N Rao <naveen@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Xiaofeng
 Yuan <yuanxiaofeng@eswincomputing.com>
Subject: Re: [PATCH v6 2/2] riscv: kprobes: add KUnit test for LR/SC
 sequence rejection
In-Reply-To: <20261016081706.1085-3-yuanxiaofeng@eswincomputing.com>
References: <20261016081706.1085-1-yuanxiaofeng@eswincomputing.com>
 <20261016081706.1085-3-yuanxiaofeng@eswincomputing.com>
Date: Fri, 16 Oct 2026 12:42:04 +0200
Message-ID: <87pkxa3p1f.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com> writes:
> +.section .rodata
> +SYM_DATA_START(test_kprobes_lrsc_offsets)
> +	RISCV_PTR .Llrsc_before
> +	RISCV_PTR .Llrsc_lr
> +	RISCV_PTR .Llrsc_inside
> +	RISCV_PTR .Llrsc_sc
> +	RISCV_PTR .Llrsc_after
> +SYM_DATA_END(test_kprobes_lrsc_offsets)

"_offsets" is not precise, as this array has absolute addresses. Maybe
rename to "_addresses"?

> diff --git a/arch/riscv/kernel/tests/kprobes/test-kprobes.c b/arch/riscv/kernel/tests/kprobes/test-kprobes.c
> index 027424a3f..c2d9c87f2 100644
> --- a/arch/riscv/kernel/tests/kprobes/test-kprobes.c
> +++ b/arch/riscv/kernel/tests/kprobes/test-kprobes.c
> @@ -43,8 +43,39 @@ static void test_kprobe_riscv(struct kunit *test)
>  	kfree(kp);
>  }
>  
> +static void test_kprobe_lrsc(struct kunit *test)
> +{
> +	/*
> +	 * test_kprobes_lrsc_offsets[] points, in order, at an instruction
> +	 * right before an LR/SC sequence, the LR itself, an instruction
> +	 * inside the sequence, the SC, and an instruction right after it.
> +	 * reject[] must have the same number of entries.
> +	 */
> +	bool reject[] = { false, true, true, true, false };

I am not a fan of coupled code. A change at test_kprobes_lrsc_offsets
mandates a change here.

Instead of this, how about we split test_kprobes_lrsc_offsets into
test_kprobes_lrsc_allowed_addresses and test_kprobes_lrsc_rejected_addresses?

Nam

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794470100;
	b=HJgNdRcpAIJa5mZSDKQjiwHd9fOJ1UusR227GJMDx3J1FGSibl+IPsAlaD5vikIZHpNN
	 Qr4wlad871tV+KcdCGNYXEhd2NHunTnIUJetw1fnQCLFovi49QuKmzPSqhe34FC+hIfi9
	 67ZeqpD6sIfZ/guxnqk8IWbeU8OeR2EcQWf81oRbqqionp2OyXLsnvy3NJsk0Goj5xrj5
	 I4VjIH0xJj4Zuw5YXikL8mB1Bz6oozEcuuejD0c/jILdgQ7rPKHJuL9DKOvwz/BIa8/jX
	 VVMn5Xg9y3MNAxtYZ0vei7/SjxOdENB6lmGnn/g6iTwUK9J8/5k3Yn4hxa8kWr8IXVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470100;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=KwJrcQfVDfyTH1nd3+0sXLk+BgnSBwKnfL6FKVxivf0=;
	b=HCDPSCMgiKsEY8gJrJqz6dvYLiLyqAV4H7+NuGpx6R94OIcJ3reTlooblB+eqHrQ+E6Z
	 pNRWSLkCu/BG4y8VNzqfT03Wsb2Tx85ckqrXbUH+tVORtDLZ7b+nAAC+VbQPEO5vlUm6W
	 5dDUoeAWpbdkKw37MUOp6+9PnKqi64F/Qyp6pFTBOM5tSkWRak2VHuA04CxeKH2ilslOe
	 Ha3iYrkvcvUSbQ3Qf8ppx0B9LnZ886E9SaQLxl1v1P/U5QhJqADdyKqRcguLIY7zs7o7N
	 FRZPQhWPuRWghLFzlJjJzawZ/Ln4Tb2L2hAPRtl4FoOfDh4FSYm308SRoVQphpznB4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=vuOGSBeH;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Shvk1tnS;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F786606A330;
	Thu, 12 Nov 2026 07:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F786606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=vuOGSBeH;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Shvk1tnS
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794470090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KwJrcQfVDfyTH1nd3+0sXLk+BgnSBwKnfL6FKVxivf0=;
	b=vuOGSBeHFSXLeTnQ1rAmzpGcwlluLM5hh7tNPIOJQWRQ4ZFfFHOMKBedzNPU3Ny4marm0U
	4Nq1bbOWWQ2f/P9fY7Rz1zTLdNUrRzYoJMkbevZhFGKeJ8/31SN506Nuy7ooUxPtdkxYqf
	OHrvaCOHqplXvSYu/cUkeJr9SUKt4K0hov2z9YVYpDvmSwZDEr3VmhG2dZdwMsvWvp/15H
	Axonar3cZC1LFU+SEzK9ppesxtpem3J2DaAv8F55F51fdsnUXmeCuxs/Wn+tlllHo2dvVh
	Sj0kcI1eQke0orVsN/UBFe0n21MwkE/ts/ljIKuAvphhY8VZ62dbXelLsDC0tQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794470090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KwJrcQfVDfyTH1nd3+0sXLk+BgnSBwKnfL6FKVxivf0=;
	b=Shvk1tnSPIAhWNY0KOp1zgdj9cJM0uGvvjmxj+Jvwz/CDs+mOlvWZ5EsBlJZQ5r4Hu6byN
	vKdGoaJfbnoEEmCg==
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Masami Hiramatsu
 <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>
Subject: Re: [PATCH v2 2/2] riscv: probes: reject probes inside an LR/SC
 sequence
In-Reply-To: <20261111-probes-in-lrsc-v2-2-b2525b7e1e8e@mobileye.com>
References: <20261111-probes-in-lrsc-v2-0-b2525b7e1e8e@mobileye.com>
 <20261111-probes-in-lrsc-v2-2-b2525b7e1e8e@mobileye.com>
Date: Thu, 12 Nov 2026 08:54:49 +0100
Message-ID: <87jymicwmu.fsf@yellow.woof>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Vladimir Kondratiev <vladimir.kondratiev@mobileye.com> writes:
> A kprobe or uprobe replaces an instruction with a breakpoint. The trap
> clears the hart's reservation, so if the breakpoint sits on the lr, on
> the sc, or on any instruction between them, the sc fails, the loop
> branches back to the lr and the probe fires again. The sequence never
> completes.

Xiaofeng sent a series addressing the same issue:
https://lore.kernel.org/linux-riscv/20261019134121.1763-1-yuanxiaofeng@eswincomputing.com/#t

I have only skimmed this patch, but this patch has an important
difference: riscv_probe_in_lrsc_body(), while the other series
implements a kunit.

Perhaps you two should join forces?

Nam

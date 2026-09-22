Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096AD55D897
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091615; cv=none; b=EFwHfVpNDce9jO8aFLuiZSrBHYTseW+daaPbO/ppVUnk4/7is4+QYG+BDqyMBKZryhVR1017+YMhHzHsqiCI5WHwsZeI0Z0ku8y7u6dv4Bu/JoO0ehWh6QxTx2vtkVauyz7fcPUm/1+I4MvDB4jNPJ2xJ6/67vyr7FMlrDSYbb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091615; c=relaxed/simple;
	bh=RoaEb/YXzDoIHH3AiLUmW9ounZQpxCVhS/0oNgDOzXo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mHgfAWugFHAVkTSHF+p8ZG6zgeVEPqS6ZjtiCT6QuQbf3P+agZtevGEQpnkAYz4QiG6dBIgP/t5/6Mpkl593uiZiBy6w2SyIjvuRpVAf8WNgKBch7QL8g5OivpXtWfUTYfSnUXhQ5ifg5okSU32zAnm2VLmEEM/fgv7Ep24Pszs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xsPbYhyF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0e5K4U5N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xsPbYhyF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0e5K4U5N"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790091612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RoaEb/YXzDoIHH3AiLUmW9ounZQpxCVhS/0oNgDOzXo=;
	b=xsPbYhyFI3dubyUQwVkpMIrTKkMwQMrwIazpvAVQZaEjPSa/yeqHqsWdgo6qAfaqsNRzoF
	4Msz+urRx4xDu55KwxuqOQJtT7tKFXd3rZeBhvpvOEbELhRNGvNRMqB4c9je9rn4M4uZbV
	Dhz1YE+lSKSl8osbfU49nn53GVrUhHa+fOUd3Go6885LLmmpZ9Z7lyJ3C9/4GHvUJ6oxbS
	CtbujQFEd45ONBVZzV5nt8TLPUFzRCef3j6tRbNtjbIT7q0rlkyOVoPdcazAUNnYjnvSnx
	KumXUK6FoRkTlttStkUyIcph/AveIAF30KBCcyniH5NNPm4j9qrX593t3U1PdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790091612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RoaEb/YXzDoIHH3AiLUmW9ounZQpxCVhS/0oNgDOzXo=;
	b=0e5K4U5Ny6HmXEqacnXfJEfvhBlnwt3iG3VXBRhtuMynIkiiORc8mU12NhhN1C4Y8D/dfW
	WTTLcUv9npKK7/CA==
To: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
 Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>, Naveen N Rao
 <naveen@kernel.org>, "David S. Miller" <davem@davemloft.net>, Masami
 Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] riscv: kprobes: reject probes inside LR/SC
 sequences
In-Reply-To: <20260828091202.1124-1-yuanxiaofeng@eswincomputing.com>
References: <20260828091202.1124-1-yuanxiaofeng@eswincomputing.com>
Date: Tue, 22 Sep 2026 17:40:11 +0200
Message-ID: <87mrt9e1lw.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com> writes:
> A breakpoint trap taken in the middle of an LR/SC sequence clears the
> load reservation, so an SC following the probed instruction always fails
> and the enclosing retry loop re-enters the breakpoint, livelocking the
> CPU.
>
> This series makes the RISC-V kprobes implementation reject probes placed
> inside an LR/SC sequence:

CC: kprobes maintainers, I would appreciate your opinion on this. Should
kprobes reject it, or leave it to users to take care not to do that?

Nam

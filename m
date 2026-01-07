Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACAD16A956;
	Wed,  7 Jan 2026 22:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767825422; cv=none; b=jPirlsJCqv5xcnbZjrrct48eqAJPdNj6+MALCEpN57KqUxvGNhZ/2szEgNUNZjn4/eNQuuYvo5kdmD4LTWosrhxDRQekl6vaXBjh0o4ZT416Pi7jaEx+Uv+n0OwJA270vwDyTGTlRo3hgBuO6XeH99jAYps9DZc80d5cEhgGvAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767825422; c=relaxed/simple;
	bh=ZUNm8c6aAEtDnspk3VLQ42ha1pnLFLiQPIXXJlqPy4I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Cu/OkxQmfRiwPZttSPGnOd+a5XkMgcDX0AX3d9oV7ImYfZcS8V6OsSEAJhnRl2xKeu9G7YobTgYqrJAR8bqS52+QjCDZKyPXviEQZ+vQzOLs03zuVQHbHcaRhGzL7J7PbQPRPMGWegEqEItgwDfbpGV7sOsLCrBXt0fhUR5hcMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDY1fwm6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDY1fwm6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69005C4CEF1;
	Wed,  7 Jan 2026 22:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767825420;
	bh=ZUNm8c6aAEtDnspk3VLQ42ha1pnLFLiQPIXXJlqPy4I=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=VDY1fwm6u8MQKsaFyH1vTxG8WGAUw7O+0HOqcpbfkWMkTIbV7QmGsJCDTVGi4QTI0
	 pJfgOrUmYtkVd2CY77jDWsj/i87LVfgMDe3ZoRQI6nF6zQRD775qMfW746QS4cW0Sc
	 Wx2+KsFNeI1L++4Y0l3/tjlFUi2E/ffTZEA+O3YcfsEwl2ohr1b4kHOT4Gh8/vuiiO
	 fYn1CJ+B4fWlPp6H7gbhE29TW5CJ6wY1dmZYQKpld+VYC0MrJJ3DR3oyroNtbuMYHF
	 1Cp0ezWfclLyCfJoI9Nmy9B+Y4TJ+1koI12Ew1RBaNWvOyGbjzvtWdDusqxoyJmDaH
	 y7YoBF8uhAKPg==
Date: Wed, 7 Jan 2026 15:36:57 -0700 (MST)
From: Paul Walmsley <pjw@kernel.org>
To: Martin Kaiser <martin@kaiser.cx>
cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
    linux-riscv@lists.infradead.org, linux-trace-kernel@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: trace: fix snapshot deadlock with sbi ecall
In-Reply-To: <20251223135043.1336524-1-martin@kaiser.cx>
Message-ID: <e06402bf-a612-4d9c-c5f6-5361826f5fdf@kernel.org>
References: <20251223135043.1336524-1-martin@kaiser.cx>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 23 Dec 2025, Martin Kaiser wrote:

> If sbi_ecall.c's functions are traceable,
> 
> echo "__sbi_ecall:snapshot" > /sys/kernel/tracing/set_ftrace_filter
> 
> may get the kernel into a deadlock.
> 
> (Functions in sbi_ecall.c are excluded from tracing if
> CONFIG_RISCV_ALTERNATIVE_EARLY is set.)
> 
> __sbi_ecall triggers a snapshot of the ringbuffer. The snapshot code
> raises an IPI interrupt, which results in another call to __sbi_ecall
> and another snapshot...
> 
> All it takes to get into this endless loop is one initial __sbi_ecall.
> On RISC-V systems without SSTC extension, the clock events in
> timer-riscv.c issue periodic sbi ecalls, making the problem easy to
> trigger.
> 
> Always exclude the sbi_ecall.c functions from tracing to fix the
> potential deadlock.
> 
> sbi ecalls can easiliy be logged via trace events, excluding ecall
> functions from function tracing is not a big limitation.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Thanks, queued for v6.19-rc.

- Paul

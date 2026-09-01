Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2450330DEDC
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Sep 2026 02:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788229777; cv=none; b=VIv5CvGcJDA/2eJjQdGoAyCs0Wu+HKVR48DyG9e2bQ1Q9wtaHEw2El6cnDJ/Z5geKdnYEgYttpDzWN5NiV1UrQvCQi4y++95w4cPDswjZ0U/5dxIwlRBhXjeBAvp7cp9xE6vCdEEFdXKnBU5w7NxvpiEWZ+VGIrLSGaEEm5LQuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788229777; c=relaxed/simple;
	bh=6CY7ap3cohsqeL7kwEBLZ8jpOZ8X7ZSqj0GEv5kwk9s=;
	h=Subject:Message-Id:In-Reply-To:Date:Mime-Version:References:To:
	 Content-Type:Cc:From; b=KeUMEvo9DQ3PUjoAWEfpg8/rgYk4w8nqrfGBP8NB8GVrYQCgguAFF40n9BIWszBzvAuUgRTXBWrUQTTsEksOaaVt9TJGCacZ/p552o2jpsc1GeVZaigvN2SqG8LRSviy2wXZ4uYhaL6DcUXK9aN93pxVeDQJdop+pEqgf/sErGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hlhscmI2; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hlhscmI2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1788229764; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=nSl8I61Po4NfLfKWOqzFnz5x9QTmz7kfJ1JFGJE3pRE=;
 b=hlhscmI2xhebF6JU6PU6pMC525JkzK9pEvUyuBitNtDz8R0gCPPMWh10l/jEMNIgIBh/Sm
 aCbodVFA7wel9kPjXOGlkOHIsYme+5WNozR7DxCLAG/T8nYSit+M2VTFCox+ePYZVcpyeF
 98UhbrxwegdzE+KwfHnvqCCsnUyreAO3xqusX+YMEvriYDCc+GPjkV/zgDRHEQEqdUOQ7d
 9L5OS7+lAjP9qfuoNDewhhUpcFSCY6m2R1KnQ3ix+m9YDtMHKlZImmLpeiO7VAIDJhIp9u
 5ot74krM2P1BgmTRoO97fLXsL0QZ7fdpxaYEsJaJauAEQiZB3l6PuMxOLa+wpg==
Subject: Re: [PATCH] riscv: ftrace: reject out-of-range non-direct targets
Message-Id: <bd8646c1-1ed7-4b04-a00b-ef31700a41fa@bytedance.com>
In-Reply-To: <20260831105820.22085739@gandalf.local.home>
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla Thunderbird
Date: Tue, 1 Sep 2026 10:29:06 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260707121235.759104-1-qirui.001@bytedance.com> <20260901020000.1-qirui.001@bytedance.com> <20260831105820.22085739@gandalf.local.home>
To: "Steven Rostedt" <rostedt@goodmis.org>, <palmer@dabbelt.com>, 
	<pjw@kernel.org>
X-Original-From: Rui Qi <qirui.001@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Cc: <mhiramat@kernel.org>, <mark.rutland@arm.com>, <aou@eecs.berkeley.edu>, 
	<alex@ghiti.fr>, <linux-kernel@vger.kernel.org>, 
	<linux-trace-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
From: "Rui Qi" <qirui.001@bytedance.com>
X-Lms-Return-Path: <lba+26a963882+7eba76+vger.kernel.org+qirui.001@bytedance.com>

On 8/31/26 10:58 PM, Steven Rostedt wrote:
> On Mon, 31 Aug 2026 11:50:45 +0800
> "Rui Qi" <qirui.001@bytedance.com> wrote:
> 
>> Hi Steven,
>>
>> Gentle ping on this patch. It's been over a month since submission
>> and I'd appreciate your review when you have a chance.
>>
>> The patch fixes ftrace_modify_call() on RISC-V to properly validate
>> old_addr/addr instead of always treating sites as FTRACE_ADDR, and
>> rejects out-of-range non-direct targets that can't be dispatched
>> through the existing ftrace_caller path.
> 
> This patch looks very architecture specific. Is there a generic ftrace
> issue you have with this? "out-of-range" issues are specific to an
> architecture (x86 doesn't have this issue).
> 
> You need the RISC-V maintainers to review and accept this patch. I don't
> see anything specific to generic ftrace infrastructure here, which is what
> I maintain.
> 
> -- Steve
> 

Hi Steven,

Thanks for the clarification. You're right, this is entirely
RISC-V specific -- the out-of-range issue comes from RISC-V's
AUIPC/JALR relocation limits, and the fix only touches
arch/riscv/kernel/ftrace.c. There's no generic ftrace change here.

Palmer, Paul, could you take a look at this patch? The core fix is
making ftrace_modify_call() honor its old_addr/addr arguments instead
of always validating against FTRACE_ADDR, and rejecting out-of-range
non-direct targets that can't fall back through ftrace_caller.

Thanks,
Rui

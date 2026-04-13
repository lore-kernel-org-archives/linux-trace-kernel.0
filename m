Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F903ACA7B;
	Mon, 13 Apr 2026 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776070111; cv=none; b=jec5x5Zq5r3oHfAXTDiJHsH68ZObqMi6V8FPKx0yDA5YG63/R7Qpn+1tOxV5pantCJytlOWS+VlHMT+eADmqJGr+YWN2AnIjJhSapIr/nAVeGfe42zFmB9tOmV/oItzIN6dr/wjjR49zbOafaHsiW6V829NtDcXzyzbijDRtuBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776070111; c=relaxed/simple;
	bh=9XyG+RgV1b+tsr/ZaBdHnBUF1N+3A8a1jOkoY61XNVg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UyXajx4JIJdYA/g80rMjmp1AkPMhrp/d8hu3cUJGX/eU0z/AWPpnczivA0YSqE0g1ey8QUsw4FWKV74NaOO7IaHbAbr4HeoGE47O2hi4wd2+OlTp+KvDKUv2235/hfehzpf2eJ6Mkyx3qoX5tjHVEF3XiaJwCbDG7ast1G4GHG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkN9vi0C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkN9vi0C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEE4C116C6;
	Mon, 13 Apr 2026 08:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776070111;
	bh=9XyG+RgV1b+tsr/ZaBdHnBUF1N+3A8a1jOkoY61XNVg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hkN9vi0CIE/F1Mewkm69Ft6sLpxx5f286jA5295VUF6qqxxKg5g1xF58Sg238kuUN
	 EUnpcTxqjEJ4MprB5+Kc1YyMInwpGTTCbvWT3Hj8OzufmrFfmth6fKMsVlHsDDfxp+
	 AoAlezP/gDhkz+1cdbA7d8OkozyiPFnXJ83kZACDeEYw05NnU0GwmMdW4mwcP0CPnt
	 10XzWsu7tjVriryBG45TUwgWc1F4WxTz/9ZmhUzlWQFZwMcZM6Ij3aCMXJwsKOZcca
	 hZCko72I1w2Cir1lPOXjRARevoUN4YHNFU+afWyqwgB+eWU7K4Ge+iFaEqygKnUd9W
	 d5voSUtrbkFsA==
Date: Mon, 13 Apr 2026 17:48:27 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Cao Ruichuang <create0818@163.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Account for fprobe attachment at
 creation
Message-Id: <20260413174827.25a02a9dc83248eff3f6737c@kernel.org>
In-Reply-To: <20260410043243.65800-1-create0818@163.com>
References: <20260407115751.96184-1-create0818@163.com>
	<20260409172955.98e2d20a7f7736a1a9834816@kernel.org>
	<20260410043243.65800-1-create0818@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Apr 2026 12:32:43 +0800
Cao Ruichuang <create0818@163.com> wrote:

> Hi Masami,
> 
> I reran this in clean QEMU on two kernels and got different results.
> 
> 1. Ubuntu distro kernel:
>    Linux 6.8.0-100-generic #100-Ubuntu SMP PREEMPT_DYNAMIC
>    Tue Jan 13 16:40:06 UTC 2026
> 
>    baseline count=2
>    after_create123 count=4
>    after_enable1/2/3 count=4
> 
>    baseline enabled_functions:
>      __hid_bpf_tail_call ...
> 
>    after_create123 enabled_functions:
>      kernel_clone (2) R ->arch_ftrace_ops_list_func+0x0/0x280
>      kmem_cache_free (1) R tramp: ... ->fprobe_handler+0x0/0x40
>      __hid_bpf_tail_call ...
> 
> 2. Current source-tree kernel built from the clean snapshot of my patch
>    branch:
>    Linux 7.0.0-rc6 #2 SMP PREEMPT_DYNAMIC Fri Apr 10 12:19:39 CST 2026
> 
>    baseline count=0
>    after_create123 count=0
>    after_enable1 count=1
>    after_enable2 count=1
>    after_enable3 count=2
> 
>    after_create123 enabled_functions:
>      <empty>
> 
>    after_enable3 enabled_functions:
>      kernel_clone (2) ->arch_ftrace_ops_list_func+0x0/0x200
>      kmem_cache_free (1) tramp: ... ->fprobe_ftrace_entry+0x0/0x220
> 
> So the behavior I reported earlier reproduces on that Ubuntu 6.8 kernel,
> but not on the current source-tree kernel. I think my earlier conclusion
> was too broad.

Thanks for reporting the difference of behaviors.

> 
> I will stop pushing this testcase change for now unless I can narrow down
> which kernel change caused the difference.

OK.

Thanks!

> 
> Thanks,
> Cao Ruichuang
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

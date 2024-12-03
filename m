Received: from mta-03.yadro.com (mta-03.yadro.com [89.207.88.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CFB1F707A;
	Tue,  3 Dec 2024 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.207.88.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237079; cv=none; b=DPIQqETwQhsdo2pzce9AwUNwEKlYLCLu4u5lbKT84KLkBGpkL063EwsVxDt8FgqVQ/fW8dPDZS5580E+pBibILkEP+DlcpCvQOwqYTDgeVi0Uya9T0NBFV8D1ISohTcWeSdA14IBPDVvGhuCPWX9CUSP4lEtlDJpVp/IVbH0AFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237079; c=relaxed/simple;
	bh=j+1Z523yN4c3k35sEz8WLWeR9a0Tote+0vlm4AhrGg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a+MxjVCVf7JauTTt3grRcKyo8NCfxoNZGdxdhySlyS1fz/t1ftQgty1jicW8BoKM4dUGrJBN1Zkz/THTf9NPx8Qz1hSe6JLW/8m4KrVqmUZVmKqmNmslYc6Sl7oQBW9QWXOC70Jwm/im5HtSIrbx4pSv4TCa+q4zUMLqynUx7M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=F/xs/DWx; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=fWTohsPr; arc=none smtp.client-ip=89.207.88.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="F/xs/DWx";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="fWTohsPr"
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com 47C23E0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1733237067; bh=yZe/rHto/yJINXzpM0VYaXBnEXiTAtPyuKao0ifLMUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=F/xs/DWxB9Q2xFJTiRE+BRDiKHj8Xg2JNDNpNKatEFAPn6Sq07CSqnIlkmho4PfwY
	 i4n8ckL5a3UEcYTNOdpkqLXDKZBfkd7+wWE0mfifon8WjKC8MyRJDp03drsPHit5qs
	 YQ9JnPohpFjFSsvMm/cRC4ssbK1H5e16wHHOhNFvdjZdWNGq1Um3S0RFtcZhc9MLLx
	 JI6jMOpobs78O2XmE6kLtD4ZuLeOTprjTa1H/Bj57GLN36L35e6RvCsN1uEfiK+MmH
	 xw0PDm5poqRVGxc5JxpvzQd/rZMdMmLU2C+NBl1lHNHgIe0+HD+RrzjY70tqcVWiiQ
	 4I9yvZTO/OnBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1733237067; bh=yZe/rHto/yJINXzpM0VYaXBnEXiTAtPyuKao0ifLMUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=fWTohsPr10f9KWPbfxCVvIwt69HevffSbsXqEZwu0WmT/iJSr6Wx4XOMh6Tw4Ad+T
	 q5eZ4Qizq7Ej1Yh2GCmzHd3vuVmhdLUhUkUpFEGb1BNl1+/gC7sjTpWuMv1FRKZXEk
	 lvtHtuet3zGS8CLJjXx3dc/4KJ1DhZTBy7XOFhii3mdZNcrDl+JORThtZRey7sxPIa
	 ElFPQLxavdFMRreKNyLlsIV+jRBOXPYHkmHEGB2PyhLbKxMQihpOo+SnmtNBOSg7a3
	 SjEGQJVx/l1YViUNgBV2f9s43som2T4UPePX0ueYyz1oFITpw/l1a2GcyHg2MwNnAg
	 Cx9inGVCixcLg==
Message-ID: <7e5ce1ce-e30a-46c5-80fb-eb52e59e4dc2@yadro.com>
Date: Tue, 3 Dec 2024 17:44:25 +0300
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH v3 1/7] riscv: ftrace: support fastcc in Clang for
 WITH_ARGS
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
CC: Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor
	<nathan@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt
	<palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Mark Rutland
	<mark.rutland@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Andy Chiu <andybnac@gmail.com>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <llvm@lists.linux.dev>,
	<bjorn@rivosinc.com>, <puranjay12@gmail.com>, <alexghiti@rivosinc.com>,
	<yongxuan.wang@sifive.com>, <greentime.hu@sifive.com>, <nick.hu@sifive.com>,
	<nylon.chen@sifive.com>, <tommy.wu@sifive.com>, <eric.lin@sifive.com>,
	<viccent.chen@sifive.com>, <zong.li@sifive.com>, <samuel.holland@sifive.com>
References: <20241127172908.17149-1-andybnac@gmail.com>
 <20241127172908.17149-2-andybnac@gmail.com>
 <87wmghotth.fsf@all.your.base.are.belong.to.us>
Content-Language: en-US
From: Evgenii Shatokhin <e.shatokhin@yadro.com>
In-Reply-To: <87wmghotth.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: T-Exch-05.corp.yadro.com (172.17.10.109) To
 T-EXCH-10.corp.yadro.com (172.17.11.60)

Hi,

On 03.12.2024 15:05, Björn Töpel wrote:
> 
> Andy Chiu <andybnac@gmail.com> writes:
> 
>> From: Andy Chiu <andy.chiu@sifive.com>
>>
>> Some caller-saved registers which are not defined as function arguments
>> in the ABI can still be passed as arguments when the kernel is compiled
>> with Clang. As a result, we must save and restore those registers to
>> prevent ftrace from clobbering them.
>>
>> - [1]: https://reviews.llvm.org/D68559
>>
>> Reported-by: Evgenii Shatokhin <e.shatokhin@yadro.com>
>> Closes: https://lore.kernel.org/linux-riscv/7e7c7914-445d-426d-89a0-59a9199c45b1@yadro.com/
>> Acked-by: Nathan Chancellor <nathan@kernel.org>
>> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> 
> Fixes tag?

As far as I understand it, Ftrace for RISC-V has had this problem since 
support for FTRACE_WITH_REGS was added. FTRACE_WITH_ARGS inherited it.

So, it should probably be as follows:

Fixes: aea4c671fb98 ("riscv/ftrace: Add DYNAMIC_FTRACE_WITH_REGS support")

It is more of a workaround rather than a fix though, because it is still 
undecided where the problem is, in the kernel or in LLVM/clang. That 
discussion went nowhere, unfortunately, so it is better to use a 
workaround and move on, IMO.

> 
> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
> 

Regards,
Evgenii


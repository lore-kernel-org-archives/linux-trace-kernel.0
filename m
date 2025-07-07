Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8B92877DD;
	Mon,  7 Jul 2025 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751894438; cv=none; b=YWQ0REJXxzwXZAixzUwF9yEfwR1FFDbXAe/PKNXi8rot87H7mXkql0iIdR+05vU3KEkgGMV9mGuNUcJghOT7Hxo/Jkz0f8sKBPmJjFThgw344GEtBqbIUACMffzYu0cho2U+BlGqdg02hlWi+qWRfCihzpn8RxVLJtfbESveNTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751894438; c=relaxed/simple;
	bh=HX/Wn7yFzVm60oKLboh9jjsNNdPthnujxuDWLlK2SRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gEEyo/xray/D7U81UCO7hMhgSI+eOrF7rndlTEa/geQE+WDPdDF16fX0h2pdeAXVPWeTTzMSjKQfOZkEhNMu1DZLPNHcUwulDRtex7RtPu6QPxEZLk4EHB6cTt07zPunvBP+pVm0ZJp3Hhi/FtlVNYKN6/rwxCO2aDBduZD2BZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bbPXT2Pk5z9sHR;
	Mon,  7 Jul 2025 15:02:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x54AqpKF2bFd; Mon,  7 Jul 2025 15:02:17 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bbPXT1Wqrz9sCk;
	Mon,  7 Jul 2025 15:02:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 2AC538B767;
	Mon,  7 Jul 2025 15:02:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id QYGnrCvnMDzJ; Mon,  7 Jul 2025 15:02:17 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3F5A48B763;
	Mon,  7 Jul 2025 15:02:16 +0200 (CEST)
Message-ID: <2ea9c28f-c3d1-4837-b000-10eccaa2775b@csgroup.eu>
Date: Mon, 7 Jul 2025 15:02:15 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] execmem: drop unused execmem_update_copy()
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Daniel Gomez <da.gomez@samsung.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 x86@kernel.org
References: <20250704134943.3524829-1-rppt@kernel.org>
 <20250704134943.3524829-2-rppt@kernel.org>
 <7e52f721-1d8e-4c50-af33-bee3f0d2ac6e@csgroup.eu>
 <aGu0Yj08EZvpL5Xv@kernel.org>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <aGu0Yj08EZvpL5Xv@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 07/07/2025 à 13:49, Mike Rapoport a écrit :
> On Mon, Jul 07, 2025 at 12:10:43PM +0200, Christophe Leroy wrote:
>>
>> Le 04/07/2025 à 15:49, Mike Rapoport a écrit :
>>> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>>>
>>> The execmem_update_copy() that used text poking was required when memory
>>> allocated from ROX cache was always read-only. Since now its permissions
>>> can be switched to read-write there is no need in a function that updates
>>> memory with text poking.
>>
>> Erm. Looks like I missed the patch that introduced this change.
>>
>> On some variant of powerpc, namely book3s/32, this is not feasible.
> 
> The only user of EXECMEM_ROX_CACHE for now is x86-64, we can always revisit
> when powerpc book3s/32 would want to opt in to cache usage.
> 
> And it seems that [MODULES_VADDR, MODULES_END] is already mapped with
> "large pages", isn't it?

I don't think so. It uses execmem_alloc() which sets VM_ALLOW_HUGE_VMAP 
only when using EXECMEM_ROX_CACHE. And book3s/32 doesn't have large pages.

Only 8xx has large pages but they are not PMD aligned (PMD_SIZE is 4M 
while large pages are 512k and 8M) so it wouldn't work well with 
existing execmem_vmalloc().

> 
>> The granularity for setting the NX (non exec) bit is 256 Mbytes sections.
>> So the area dedicated to execmem [MODULES_VADDR; MODULES_END[ always have
>> the NX bit unset.
>>
>> You can change any page within this area from ROX to RWX but you can't make
>> it RW without X. If you want RW without X you must map it in the VMALLOC
>> area, as VMALLOC area have NX bit always set.
> 
> So what will happen when one callse
> 
> 	set_memory_nx()
> 	set_memory_rw()
> 
> in such areas?

Nothing will happen. It will successfully unset the X bit on the PTE but 
that will be ignored by the HW which only relies on the segment's NX bit 
which is set for the entire VMALLOC area and unset for the entire MODULE 
area.

That's one of the reasons why it has 
CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC , to make sure text is 
allocated in exec area and data in no-exec area.

Christophe

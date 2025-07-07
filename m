Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D93C293C5F;
	Mon,  7 Jul 2025 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751883675; cv=none; b=C/YNg9N7ZViUWbOagpRjN5IxjXY4iJyrzbiRjeHkQYdlgpuHnieIc+mzWyBVa/Bk8tFltxwZ9EU87UbZfWUZhkVQUkWRehk51KYxz1WRyhiQiRKyMzI+jz3ELStmRsEkzq6HqxEQ5dbtptTVP3pk6dw+ckK1XmEnHXcbOM0n3JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751883675; c=relaxed/simple;
	bh=jt2BXEm3g+Z/1H9Wsd5rbIl3GoPvYR7N6CzX/jo4d8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nsyeUQmWKxJteFc+PPt6W/PZJbSfjQwhhdQrB2T+O1kLS2AMVWQ2uMDyfv/03lXHLdwfQiaod+4XGEK6A3XANZ8ZtK6d5FG4zHPdRRTBJI6hfv3O2no7C1qFru9HtV6V+URs2uFa7JkMeU0oNrSwzWvBUL55scoC/dPNpUmN4DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bbKkY1qMhz9sq6;
	Mon,  7 Jul 2025 12:10:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m-Y4tmPX2Nye; Mon,  7 Jul 2025 12:10:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bbKkY117sz9snj;
	Mon,  7 Jul 2025 12:10:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 06D048B767;
	Mon,  7 Jul 2025 12:10:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id G1Qaq7PtQJLm; Mon,  7 Jul 2025 12:10:44 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 13A378B763;
	Mon,  7 Jul 2025 12:10:44 +0200 (CEST)
Message-ID: <7e52f721-1d8e-4c50-af33-bee3f0d2ac6e@csgroup.eu>
Date: Mon, 7 Jul 2025 12:10:43 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] execmem: drop unused execmem_update_copy()
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
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
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250704134943.3524829-2-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 04/07/2025 à 15:49, Mike Rapoport a écrit :
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> The execmem_update_copy() that used text poking was required when memory
> allocated from ROX cache was always read-only. Since now its permissions
> can be switched to read-write there is no need in a function that updates
> memory with text poking.

Erm. Looks like I missed the patch that introduced this change.

On some variant of powerpc, namely book3s/32, this is not feasible. The 
granularity for setting the NX (non exec) bit is 256 Mbytes sections.
So the area dedicated to execmem [MODULES_VADDR; MODULES_END[ always 
have the NX bit unset.

You can change any page within this area from ROX to RWX but you can't 
make it RW without X. If you want RW without X you must map it in the 
VMALLOC area, as VMALLOC area have NX bit always set.

Christophe

> 
> Remove it.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>   include/linux/execmem.h | 13 -------------
>   mm/execmem.c            |  5 -----
>   2 files changed, 18 deletions(-)
> 
> diff --git a/include/linux/execmem.h b/include/linux/execmem.h
> index 3be35680a54f..734fbe83d98e 100644
> --- a/include/linux/execmem.h
> +++ b/include/linux/execmem.h
> @@ -185,19 +185,6 @@ DEFINE_FREE(execmem, void *, if (_T) execmem_free(_T));
>   struct vm_struct *execmem_vmap(size_t size);
>   #endif
>   
> -/**
> - * execmem_update_copy - copy an update to executable memory
> - * @dst:  destination address to update
> - * @src:  source address containing the data
> - * @size: how many bytes of memory shold be copied
> - *
> - * Copy @size bytes from @src to @dst using text poking if the memory at
> - * @dst is read-only.
> - *
> - * Return: a pointer to @dst or NULL on error
> - */
> -void *execmem_update_copy(void *dst, const void *src, size_t size);
> -
>   /**
>    * execmem_is_rox - check if execmem is read-only
>    * @type - the execmem type to check
> diff --git a/mm/execmem.c b/mm/execmem.c
> index 2b683e7d864d..0712ebb4eb77 100644
> --- a/mm/execmem.c
> +++ b/mm/execmem.c
> @@ -399,11 +399,6 @@ void execmem_free(void *ptr)
>   		vfree(ptr);
>   }
>   
> -void *execmem_update_copy(void *dst, const void *src, size_t size)
> -{
> -	return text_poke_copy(dst, src, size);
> -}
> -
>   bool execmem_is_rox(enum execmem_type type)
>   {
>   	return !!(execmem_info->ranges[type].flags & EXECMEM_ROX_CACHE);


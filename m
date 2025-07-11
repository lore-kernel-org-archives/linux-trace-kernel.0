Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17212E764B;
	Fri, 11 Jul 2025 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244194; cv=none; b=SOCKCT3kxhKj3BFxytW3hr9SNV0yuQgZXiPaG5D+ZjYKcXGcb+Gk7t7ZGM28Wp7m2mTJAPAGT8erMV9kzUkR/KsDdHCrqpZcHPE74Pg/gBBqd+J0T8OLRYDIM52U3QO+FYGtH4Tqwj5tP4T1gchuhmRk7ogf8f1WvEZbmxDCr7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244194; c=relaxed/simple;
	bh=DTb+gl/sBn1Q70ZFf4J9pi63JbHRu+GK7lRSoMKGCfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LJl2NuA3EnRyt5gkgecmCLXXhbchxLnKItv/mUAy1sVFJcszCaKlckOfXi/gKrKIY3QEtWdd6T1CPucMLd8wO5jYRZMRU6jdnqELKt+7UJU8XPz3fvw/5VFjCK0cxIAsiZRwZjqybhmxiUa+06TwyXg1//6bCt7VOJIxxlXyBN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOlk+bhs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOlk+bhs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F92C4CEED;
	Fri, 11 Jul 2025 14:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752244194;
	bh=DTb+gl/sBn1Q70ZFf4J9pi63JbHRu+GK7lRSoMKGCfo=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mOlk+bhs+QWla1mgbTTAaraZvXJCzWrRmqnz3rb7Y8etqK3kSJwFXCUZQsvMbXPq0
	 +//oeak4deRfAFpavcouYKjPgsKPWdYQgGANPWUAQsebYi5o7oVas9K8j+kQFgJc2+
	 JesaEDMCVMCtM7TfExq69iR+FmL159eLZW8R5EtXGzlYyaSwR1tRRgze8DfOUotxFF
	 aY6BkH84hf/3AwOX/szk6bMA0O+YP7sTYDw2on3MjguYR0w2lpVvscLaqcEwpqLpb1
	 AOEwX0ZqbpLEfeMr7IhgrswEpwz+lHaa1djwmjCJtS3JnPUqyUDV7WujpCsf2KJWAG
	 axH98LIXH2KSw==
Message-ID: <784081fa-0fee-4df6-b8d5-6435eead877f@kernel.org>
Date: Fri, 11 Jul 2025 16:29:48 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH v2 2/8] execmem: introduce execmem_alloc_rw()
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Daniel Gomez <da.gomez@samsung.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Steven Rostedt
 <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Yann Ylavic <ylavic.dev@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-modules@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org
References: <20250709134933.3848895-1-rppt@kernel.org>
 <20250709134933.3848895-3-rppt@kernel.org>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250709134933.3848895-3-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/07/2025 15.49, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Some callers of execmem_alloc() require the memory to be temporarily
> writable even when it is allocated from ROX cache. These callers use
> execemem_make_temp_rw() right after the call to execmem_alloc().
> 
> Wrap this sequence in execmem_alloc_rw() API.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Daniel Gomez <da.gomez@samsung.com>

> ---
> diff --git a/mm/execmem.c b/mm/execmem.c
> index 0712ebb4eb77..6b040fbc5f4f 100644
> --- a/mm/execmem.c
> +++ b/mm/execmem.c

{...}

> @@ -387,6 +397,21 @@ void *execmem_alloc(enum execmem_type type, size_t size)
>  	return kasan_reset_tag(p);
>  }
>  
> +void *execmem_alloc_rw(enum execmem_type type, size_t size)
> +{
> +	void *p __free(execmem) = execmem_alloc(type, size);
> +	int err;
> +
> +	if (!p)
> +		return NULL;
> +
> +	err = execmem_force_rw(p, size);
> +	if (err)
> +		return NULL;

You don't need to save the error here. That, allows err declaration to be
dropped.

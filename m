Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83AB2BE655;
	Mon,  1 Dec 2025 09:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764581887; cv=none; b=jsK3HDQPDo2EOvNlhakS3X9iFX9FqXJBDdVJJ24xc/BodJzh7ewBH8jPDj9qJtNnIRgyQdSRQTZBA5USsXpYo1w0vgZKh8EcLCVBqv+Yl62n4GZhljF7zVFtxr2QTEOsmtE6f38+/CifjXCrB+PoR1UxxeLIuzRyxL+vyqos4jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764581887; c=relaxed/simple;
	bh=4p2wg1jmOngnkzqKp6YIZ9UwcAm/w6dhGKvcrcI//Ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IyN2z+SMNbe/bcIMAo92ZjVFksmsU+TY+4/FBICkVZmpT67q3CnLQLNk/Dpne35qgYR4GwrtRwvgrGbh9azN01albW4iayp7E2IQ3jHkdEMX2kxEZgkSi6vCs3BxH+jnyx0fAMpMSdkgY7LS4jJmXabwsz+2Y/RsrlpvHj9uQ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdvDEAEF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdvDEAEF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73726C4CEF1;
	Mon,  1 Dec 2025 09:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764581887;
	bh=4p2wg1jmOngnkzqKp6YIZ9UwcAm/w6dhGKvcrcI//Ok=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=GdvDEAEFt0aGU5ln/ROKVDXUPfJFeouk5NuQRf4tzsuamtFpi6ayLs4mMLZn0bkSA
	 tbBtWTvwS1FdfhGP03SFL+5x2JrTBLkfrPT5zbmp8IkhZAUcUAeStqzOprHT1vEKBH
	 BxwhXHuBsY6erQgpyld5jroWvYmoLA4hmWXecHHXScuQE38VjTnq4MqnKX70DeBPPr
	 ExeDG4SucnRtoWYtI3elukieHFaaTCndJDK1mrQMi+bOVZlknQigDvQHuAoSE22e8b
	 KbTG3h3Q8YOO018TQwixvc4ft1NT2apZi3P/SBkhkF4CD1QSXZEe9cCXeae0b2Ri1A
	 FDU8aHJPDvC/Q==
Message-ID: <3e7ddbea-978f-44f7-abdd-7319908fd83c@kernel.org>
Date: Mon, 1 Dec 2025 10:38:01 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] kernel.h: drop STACK_MAGIC macro
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Randy Dunlap <rdunlap@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20251129195304.204082-1-yury.norov@gmail.com>
 <20251129195304.204082-2-yury.norov@gmail.com>
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Content-Language: fr-FR
In-Reply-To: <20251129195304.204082-2-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 29/11/2025 à 20:53, Yury Norov (NVIDIA) a écrit :
> The macro is only used by i915. Move it to a local header and drop from
> the kernel.h.

At the begining of the git history we have:

$ git grep STACK_MAGIC 1da177e4c3f41
1da177e4c3f41:arch/h8300/kernel/traps.c:        if (STACK_MAGIC != 
*(unsigned long *)((unsigned long)current+PAGE_SIZE))
1da177e4c3f41:arch/m68k/mac/macints.c:          if (STACK_MAGIC != 
*(unsigned long *)current->kernel_stack_page)
1da177e4c3f41:include/linux/kernel.h:#define STACK_MAGIC        0xdeadbeef

Would be good to know the history of its usage over time.

I see:
- Removed from m68k by 3cd53b14e7c4 ("m68k/mac: Improve NMI handler")
- Removed from h8300 by 1c4b5ecb7ea1 ("remove the h8300 architecture")
- Started being used in i915 selftest by 250f8c8140ac ("drm/i915/gtt: 
Read-only pages for insert_entries on bdw+")

Christophe

> 
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> ---
>   drivers/gpu/drm/i915/i915_utils.h | 2 ++
>   include/linux/kernel.h            | 2 --
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
> index a0c892e4c40d..6c197e968305 100644
> --- a/drivers/gpu/drm/i915/i915_utils.h
> +++ b/drivers/gpu/drm/i915/i915_utils.h
> @@ -32,6 +32,8 @@
>   #include <linux/workqueue.h>
>   #include <linux/sched/clock.h>
>   
> +#define STACK_MAGIC	0xdeadbeef
> +
>   #ifdef CONFIG_X86
>   #include <asm/hypervisor.h>
>   #endif
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 5b46924fdff5..61d63c57bc2d 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -40,8 +40,6 @@
>   
>   #include <uapi/linux/kernel.h>
>   
> -#define STACK_MAGIC	0xdeadbeef
> -
>   struct completion;
>   struct user;
>   


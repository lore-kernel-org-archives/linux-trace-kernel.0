Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ED53537CE;
	Tue, 21 Apr 2026 21:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776808300; cv=none; b=freBOxrK11j+mZ4eTGVYcHFZa+8Br7gZdfZVQVt4JBI99fxtmHApmgkFUBbGPoUnKbo5X3g+LjCL4ryVwyiZE2KWSluZxDZMZF4IGMLIrbj9FGoSM2iQbzRocoRJ4XHEQQG9m4+KmG4ADwg5R8b8FvWiV50ajENSoiMWqMWRD64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776808300; c=relaxed/simple;
	bh=e8khfY+cFY85RCCUdY/+9cWHVCfWjH1ZA3LYAAwUCyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mw1xrIrUsbkpnabLj0DWVEGPDPVOq69lJZpuExJZHDwqSg6SFsUHedRdhpPAmM+byTbvsrTN4lSg9WL3n9HKR4eba19goRoZ8cKzLswSBj5NPR1O4hiu2Ye/7hzREwdsjHC3zoCretq2l0RjIpkdKlUBWbNZS8UY4Z1y4GwxU1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SI5KPqSS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SI5KPqSS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2412C2BCB5;
	Tue, 21 Apr 2026 21:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776808299;
	bh=e8khfY+cFY85RCCUdY/+9cWHVCfWjH1ZA3LYAAwUCyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SI5KPqSS6PI9nIybbOlKTmKJzGEkpUEtaSpQYkVOSMasHZFMgD8HH16qGWceIZh/p
	 HWx8Yh+/4L1jYD4DEmxx/gFtDDRJxpNo0byS0UgXK/HnhxbbkbzXUdNsKzN8cCVS9B
	 suZyA0yM2KirZGVhZ2/lr77wGwI7K2vtFJS8rvwXbDF874R3b195arZqCWCrvmF6SM
	 YlkYXqDnERbd9pBGatD1xzDeDsWaLEn+fki5ayk/Vjcq80kj2RoqG2eiMLXfXQVcfg
	 rp/wVFQg3tmMNpjeB2Elq93MkXy7lhZdgd9oFfRqyrP3bhxzrv1sIUuijZqZfrMpOR
	 jhENS3pOR3kAg==
Date: Tue, 21 Apr 2026 14:51:35 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	torvalds@linux-foundation.org, rostedt@goodmis.org,
	Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: trace: do not generate undefsyms_base.c
Message-ID: <20260421215135.GA367904@ax162>
References: <20260421100455.324333-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421100455.324333-1-pbonzini@redhat.com>

On Tue, Apr 21, 2026 at 11:04:55AM +0100, Paolo Bonzini wrote:
> The code to autogenerate undefsyms_base.c in the Makefile is larger
> than the file itself.
> 
> Remove the "echo" indirection that creates the file, which keeps
> the build system sane and makes it much easier to edit it if/when
> new situations arrive.
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Yeah, I don't really know how I did not see this originally :/ tunnel
vision is real I suppose.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  kernel/trace/.gitignore       |  1 -
>  kernel/trace/Makefile         | 35 ++++-------------------------------
>  kernel/trace/undefsyms_base.c | 28 ++++++++++++++++++++++++++++
>  3 files changed, 32 insertions(+), 32 deletions(-)
>  delete mode 100644 kernel/trace/.gitignore
>  create mode 100644 kernel/trace/undefsyms_base.c
> 
> diff --git a/kernel/trace/.gitignore b/kernel/trace/.gitignore
> deleted file mode 100644
> index 6adbb09d6deb..000000000000
> --- a/kernel/trace/.gitignore
> +++ /dev/null
> @@ -1 +0,0 @@
> -/undefsyms_base.c
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index 4d4229e5eec4..1decdce8cbef 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -133,41 +133,14 @@ obj-$(CONFIG_TRACE_REMOTE) += trace_remote.o
>  obj-$(CONFIG_SIMPLE_RING_BUFFER) += simple_ring_buffer.o
>  obj-$(CONFIG_TRACE_REMOTE_TEST) += remote_test.o
>  
> -#
>  # simple_ring_buffer is used by the pKVM hypervisor which does not have access
>  # to all kernel symbols. Fail the build if forbidden symbols are found.
> -#
> -# undefsyms_base generates a set of compiler and tooling-generated symbols that can
> -# safely be ignored for simple_ring_buffer.
> -#
> -filechk_undefsyms_base = \
> -	echo '$(pound)include <linux/atomic.h>'; \
> -	echo '$(pound)include <linux/string.h>'; \
> -	echo '$(pound)include <asm/page.h>'; \
> -	echo 'static char page[PAGE_SIZE] __aligned(PAGE_SIZE);'; \
> -	echo 'void undefsyms_base(void *p, int n);'; \
> -	echo 'void undefsyms_base(void *p, int n) {'; \
> -	echo '	char buffer[256] = { 0 };'; \
> -	echo '	u32 u = 0;'; \
> -	echo '	memset((char * volatile)page, 8, PAGE_SIZE);'; \
> -	echo '	memset((char * volatile)buffer, 8, sizeof(buffer));'; \
> -	echo '	memcpy((void * volatile)p, buffer, sizeof(buffer));'; \
> -	echo '	cmpxchg((u32 * volatile)&u, 0, 8);'; \
> -	echo '	WARN_ON(n == 0xdeadbeef);'; \
> -	echo '}'
> -
> -$(obj)/undefsyms_base.c: FORCE
> -	$(call filechk,undefsyms_base)
> -
> -clean-files += undefsyms_base.c
> -
> -$(obj)/undefsyms_base.o: $(obj)/undefsyms_base.c
>  
> +# Basic compiler and tooling-generated symbols that can safely be left
> +# undefined. Ensure KASAN is enabled to avoid logic that may disable
> +# FORTIFY_SOURCE when KASAN is not enabled. undefsyms_base.o does not
> +# automatically get KASAN flags because it is not linked into vmlinux.
>  targets += undefsyms_base.o
> -
> -# Ensure KASAN is enabled to avoid logic that may disable FORTIFY_SOURCE when
> -# KASAN is not enabled. undefsyms_base.o does not automatically get KASAN flags
> -# because it is not linked into vmlinux.
>  KASAN_SANITIZE_undefsyms_base.o := y
>  
>  UNDEFINED_ALLOWLIST = __asan __gcov __kasan __kcsan __hwasan __sancov __sanitizer __tsan __ubsan __x86_indirect_thunk \
> diff --git a/kernel/trace/undefsyms_base.c b/kernel/trace/undefsyms_base.c
> new file mode 100644
> index 000000000000..e65baf58e6ff
> --- /dev/null
> +++ b/kernel/trace/undefsyms_base.c
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * simple_ring_buffer is used by the pKVM hypervisor which does not have access
> + * to all kernel symbols.  Whatever is undefined when compiling this file is
> + * compiler and tooling-generated symbols that can safely be ignored for
> + * simple_ring_buffer.
> + */
> +
> +#include <linux/atomic.h>
> +#include <linux/string.h>
> +#include <asm/page.h>
> +
> +void undefsyms_base(void *p, int n);
> +
> +static char page[PAGE_SIZE] __aligned(PAGE_SIZE);
> +
> +void undefsyms_base(void *p, int n)
> +{
> +	char buffer[256] = { 0 };
> +
> +	u32 u = 0;
> +	memset((char * volatile)page, 8, PAGE_SIZE);
> +	memset((char * volatile)buffer, 8, sizeof(buffer));
> +	memcpy((void * volatile)p, buffer, sizeof(buffer));
> +	cmpxchg((u32 * volatile)&u, 0, 8);
> +	WARN_ON(n == 0xdeadbeef);
> +}
> -- 
> 2.53.0
> 

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7538916D4FE;
	Fri, 21 Jun 2024 08:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959577; cv=none; b=OjOca8mGFYhzXazYqcK7ml0yuFZ8awRnWh2kIUHvuhfQVhiYoels2sF3pHTNirN1dcB9S0TmCR3PdtZjSSrETtslhdSYtD4AmhFhai1tZ/5NKtMl90cPLdXZRSwPijKPydjfvV7Z78FAHiD885lacODJqDRAeEV/7cp9BkbR9tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959577; c=relaxed/simple;
	bh=OexbvJJQPcse02BM2DvA0BV+L4iJ2rtwhwgVcED68cM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U6ssrgce7t5Ejs2Hxym0pkigFCLvicJoZFbOekSxrkJbG5le3KpTHsFNoGnBv8W2YjqlcdjbVOLaGsY0v5NjwOVZoHfoGoHCkhzZojyXFz5DcR+/iw15Y9ROHtrYwjnCL24o4O/oBh3IeucHzPDUDb+Q/HetaTJ3bcISQDT5KE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kl4f1XQP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kl4f1XQP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494D9C2BBFC;
	Fri, 21 Jun 2024 08:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718959577;
	bh=OexbvJJQPcse02BM2DvA0BV+L4iJ2rtwhwgVcED68cM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kl4f1XQPvVobSXO77Km68OiFEluIaP/hmmdkskC1C3hK4Jt9tO/z4dflgTt9dVqML
	 TSr9xTVx/Yy4MiuesEkZ7agKC0j1eN8/M4RNdatmLZJhsoB8kc8iU4gpVF0vFKQ8Sy
	 hbHw/sHOEsmzc364P/y3KSGsaMUbBq/hmXux+OqrwBTuq8aVK8knYNUpAjwlZobEt5
	 wDuvdmEhijRfJWhPLByyrQLfNlKHIzlFm/0YC4S7n66CeF5C0OsHlkIPdbmQYYyYFK
	 oIxyG803Kf+utSD6lTFtwHiStgKK/VBM3b83TnJDEkdOwBtlKMtWMWXvEchPjkOweX
	 kbAMXQf0haCbg==
Message-ID: <4eca8d31-780b-46b5-a8ea-5ccc34370656@kernel.org>
Date: Fri, 21 Jun 2024 10:46:12 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] rtla: Add dependency on libcpupower
To: tglozar@redhat.com, rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 jkacur@redhat.com, jwyatt@redhat.com,
 Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20240612145439.206990-1-tglozar@redhat.com>
 <20240612145439.206990-2-tglozar@redhat.com>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20240612145439.206990-2-tglozar@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Thomas

On 6/12/24 16:54, tglozar@redhat.com wrote:
> From: Tomas Glozar <tglozar@redhat.com>

I think we can split this into two patches, this first part on tools/Build:

> Add a test for libcpupower into feature tests and use it to add a
> dependency on libcpupower to rtla.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/build/Makefile.feature           | 1 +
>  tools/build/feature/Makefile           | 4 ++++
>  tools/build/feature/test-libcpupower.c | 8 ++++++++
>  tools/tracing/rtla/Makefile            | 2 ++
>  tools/tracing/rtla/Makefile.config     | 9 +++++++++
>  5 files changed, 24 insertions(+)
>  create mode 100644 tools/build/feature/test-libcpupower.c
> 
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 1e2ab148d5db..e4fb0a1fbddf 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -53,6 +53,7 @@ FEATURE_TESTS_BASIC :=                  \
>          libslang-include-subdir         \
>          libtraceevent                   \
>          libtracefs                      \
> +        libcpupower                     \
>          libcrypto                       \
>          libunwind                       \
>          pthread-attr-setaffinity-np     \
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index ed54cef450f5..c93d62afc1e8 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -38,6 +38,7 @@ FILES=                                          \
>           test-libslang.bin                      \
>           test-libslang-include-subdir.bin       \
>           test-libtraceevent.bin                 \
> +         test-libcpupower.bin                   \
>           test-libtracefs.bin                    \
>           test-libcrypto.bin                     \
>           test-libunwind.bin                     \
> @@ -212,6 +213,9 @@ $(OUTPUT)test-libslang-include-subdir.bin:
>  $(OUTPUT)test-libtraceevent.bin:
>  	$(BUILD) -ltraceevent
>  
> +$(OUTPUT)test-libcpupower.bin:
> +	$(BUILD) -lcpupower
> +
>  $(OUTPUT)test-libtracefs.bin:
>  	 $(BUILD) $(shell $(PKG_CONFIG) --cflags libtraceevent 2>/dev/null) -ltracefs
>  
> diff --git a/tools/build/feature/test-libcpupower.c b/tools/build/feature/test-libcpupower.c
> new file mode 100644
> index 000000000000..a346aa332a71
> --- /dev/null
> +++ b/tools/build/feature/test-libcpupower.c
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <cpuidle.h>
> +
> +int main(void)
> +{
> +	int rv = cpuidle_state_count(0);
> +	return rv;
> +}
> diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
> index b5878be36125..a6a7dee16622 100644


And this part for rtla:

> --- a/tools/tracing/rtla/Makefile
> +++ b/tools/tracing/rtla/Makefile
> @@ -32,8 +32,10 @@ DOCSRC		:= ../../../Documentation/tools/rtla/
>  
>  FEATURE_TESTS	:= libtraceevent
>  FEATURE_TESTS	+= libtracefs
> +FEATURE_TESTS	+= libcpupower
>  FEATURE_DISPLAY	:= libtraceevent
>  FEATURE_DISPLAY	+= libtracefs
> +FEATURE_DISPLAY	+= libcpupower
>  
>  ifeq ($(V),1)
>    Q		=
> diff --git a/tools/tracing/rtla/Makefile.config b/tools/tracing/rtla/Makefile.config
> index 0b7ecfb30d19..8b6bc91e5dff 100644
> --- a/tools/tracing/rtla/Makefile.config
> +++ b/tools/tracing/rtla/Makefile.config
> @@ -42,6 +42,15 @@ else
>    $(info libtracefs is missing. Please install libtracefs-dev/libtracefs-devel)
>  endif
>  
> +$(call feature_check,libcpupower)
> +ifeq ($(feature-libcpupower), 1)
> +  $(call detected,CONFIG_LIBCPUPOWER)
> +  $(call lib_setup,cpupower)
> +else

Also, it is better to make it optional: if the system has this library,
set a CONFIG_HAS_LIBCPUPOWER, otherwise no..

> +  STOP_ERROR := 1
> +  $(info libcpupower is missing. Please install libcpupower-dev/kernel-tools-libs-devel)
> +endif

Then, place your code inside this option. If the option is called
but the tool was not compiled with CONFIG_HAS_LIBCPUPOWER, just
complain saying that the option is not supported because it was
compiled without it. Then put this info there, to compile
with these options enabled.

>  ifeq ($(STOP_ERROR),1)
>    $(error Please, check the errors above.)
>  endif


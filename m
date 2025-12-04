Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B274A824BD;
	Thu,  4 Dec 2025 07:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764834196; cv=none; b=j12X7aloWcyMuP5sNa9bCckWlZFy5VZ9KHN6nVK/kDI1ARV4lH6MJiUXcTfXfF5+smorhXsvGifXtSS1tgC3726vj/71C0bwt+nYYw60utIGf95VqgGHedtuG60dSMjYUCWByR/QwJE7m5DM0zKGqThcpXiuCUeNBet4iToMJnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764834196; c=relaxed/simple;
	bh=Hbnl4cXb2cP1C8GXEHYqEtQdD+Wqt6C5+BhCFhWMNSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nSFrpG1+XzPOEBPqQFuNI3+k7+WdsFK0S8Q0rcqaVlNg0ZuIKfDR7gFJ4TQJXEHHroWElFVQ7Ra8HS4Tg37LPT3TTyfuQdFWdQJDoh+cWrRLET2QqYNQK/FTeYzTO1IppzvjKqly0d95PSE5w5Rog8kmKPuKzLCjBEsIYCrdn94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCsN0eAC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCsN0eAC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB85C4CEFB;
	Thu,  4 Dec 2025 07:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764834196;
	bh=Hbnl4cXb2cP1C8GXEHYqEtQdD+Wqt6C5+BhCFhWMNSU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pCsN0eAC1y8xg5YHzXmmtrdj13jHziWW7nOTTEubp8hjIiLTX5lTjKyTtYAuzvbV7
	 0ORoRKSUgm0nqof+h127kcqawTdloFfQ+Oje1V9opLp4OHRaz9fb5qniCf0we9bVYC
	 MMN9XFFwcu5s2JOAkSA2SOB26OlY3nQhDcbT4SIoo8ZYmpGEJQhW2UT5FQ9RacUPHa
	 VxsspGsGJj2VEsD1hByk2olXC0GV9asVYuE1CbJvRXWskL+oLqKL6F6Qxb2sqtWpBS
	 MJYXyiqYpiokNOo2sbwZxSa50sYM+k4++TprZhgsc6F4sOG4D8jCtT806WSu99EalI
	 92kS2erbIa07g==
Message-ID: <74dae26a-ef75-48e7-a391-47152365e39c@kernel.org>
Date: Thu, 4 Dec 2025 08:43:05 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] kernel.h: drop STACK_MAGIC macro
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Randy Dunlap <rdunlap@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 David Laight <david.laight@runbox.com>, Petr Pavlu <petr.pavlu@suse.com>,
 Andi Shyti <andi.shyti@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Daniel Gomez <da.gomez@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>
References: <20251203162329.280182-1-yury.norov@gmail.com>
 <20251203162329.280182-2-yury.norov@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20251203162329.280182-2-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/12/2025 à 17:23, Yury Norov (NVIDIA) a écrit :
> The macro was introduced in 1994, v1.0.4, for stacks protection. Since
> that, people found better ways to protect stacks, and now the macro is
> only used by i915 selftests. Move it to a local header and drop from
> the kernel.h.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   drivers/gpu/drm/i915/gt/selftest_ring_submission.c | 1 +
>   drivers/gpu/drm/i915/i915_selftest.h               | 2 ++
>   include/linux/kernel.h                             | 2 --
>   3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/selftest_ring_submission.c b/drivers/gpu/drm/i915/gt/selftest_ring_submission.c
> index 87ceb0f374b6..600333ae6c8c 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_ring_submission.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_ring_submission.c
> @@ -3,6 +3,7 @@
>    * Copyright © 2020 Intel Corporation
>    */
>   
> +#include "i915_selftest.h"
>   #include "intel_engine_pm.h"
>   #include "selftests/igt_flush_test.h"
>   
> diff --git a/drivers/gpu/drm/i915/i915_selftest.h b/drivers/gpu/drm/i915/i915_selftest.h
> index bdf3e22c0a34..72922028f4ba 100644
> --- a/drivers/gpu/drm/i915/i915_selftest.h
> +++ b/drivers/gpu/drm/i915/i915_selftest.h
> @@ -26,6 +26,8 @@
>   
>   #include <linux/types.h>
>   
> +#define STACK_MAGIC	0xdeadbeef
> +
>   struct pci_dev;
>   struct drm_i915_private;
>   
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


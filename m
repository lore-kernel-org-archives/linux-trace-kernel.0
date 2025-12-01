Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B771990C7;
	Mon,  1 Dec 2025 07:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764575219; cv=none; b=dd1aBtRb/ZgfX2isH6H+iiX2kudVrcPvx5Qv+SpjR8IYjFMluDOznhS94NMzdASXVI0+FgV6i/VEtj0qsWxxqTUVhcTaK+mrEsiYhAT+63TBLnSYDqAIea+FMBirMWGwajFwX5TVE/Lsos3PowrOO9qpTqv6X4fsCcuZuXVxlnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764575219; c=relaxed/simple;
	bh=1dWpF5m0U65JFwuXFMqq8W9BWW9b9OZm7ada94xLxCw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sGKJVDXF8uZInRk0PWPPn+Ac15WFTh7Sy2MY8AW6Eo1/m9vgKILzc0fIBeHR9+xn6KbgeYuXsu2BjRQPMRdqbWRVhUM7reP80xIk0eqMZ+8PnRqEXZcuigTQ7oBXsaXb+SZBu8rcGFc8RtD/kdHYCZs4NBogqiEFJKImF01Avz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uf6CRoZA; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uf6CRoZA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764575218; x=1796111218;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=1dWpF5m0U65JFwuXFMqq8W9BWW9b9OZm7ada94xLxCw=;
  b=Uf6CRoZAr+4wAOSWID2vSdJLQHl1Oo6/Dm51a+8te8z3GaWFWmIN4TTE
   qRcOWkLyCkXAyOp0RbV3Dgtbsx/FMTF8flDZzAYa4GYVZc7nbnS0oP2qO
   KjOnSomTOruMRuqiPsa05P6PxvgVPUAv4vGmWf3f4Qu28AaI9I49MndBR
   mb0+bvLhP3Y7HCfxT4HkxXfVGRYrIaJr2JWwCf6Qs/SNAbd3B86ed+CG9
   RTKUlMz8Gz42TYSAgE1lvGkg0Zh42GLjAP5Gp+DyRaPM4m0riVXf8z5Z4
   0AKNSO50+JuFrYKD49hrFwyywGTfspXog1u27qfz0N1bWdPLblRq+t2I/
   A==;
X-CSE-ConnectionGUID: 8uOh7vpGTvGmVOSnVFVYUA==
X-CSE-MsgGUID: 86OOUy/EQ76+PPnFH0ya/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="70117554"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="70117554"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2025 23:46:57 -0800
X-CSE-ConnectionGUID: mwQgID8jR7ixSawycaiLdw==
X-CSE-MsgGUID: Ev7FdPzsSbizWUmwi+UbdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; 
   d="scan'208";a="193997252"
Received: from ettammin-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.132])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2025 23:46:50 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Randy Dunlap <rdunlap@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: Re: [PATCH 1/3] kernel.h: drop STACK_MAGIC macro
In-Reply-To: <20251129195304.204082-2-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20251129195304.204082-1-yury.norov@gmail.com>
 <20251129195304.204082-2-yury.norov@gmail.com>
Date: Mon, 01 Dec 2025 09:46:47 +0200
Message-ID: <d854dadd78a43f589399e967def37a0eda3655c2@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, 29 Nov 2025, "Yury Norov (NVIDIA)" <yury.norov@gmail.com> wrote:
> The macro is only used by i915. Move it to a local header and drop from
> the kernel.h.
>
> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> ---
>  drivers/gpu/drm/i915/i915_utils.h | 2 ++
>  include/linux/kernel.h            | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
> index a0c892e4c40d..6c197e968305 100644
> --- a/drivers/gpu/drm/i915/i915_utils.h
> +++ b/drivers/gpu/drm/i915/i915_utils.h

i915_utils.h is on a diet itself. STACK_MAGIC is only used in selftests,
please put this in i915_selftest.h.

I guess also need to include that from gt/selftest_ring_submission.c,
the only one that uses STACK_MAGIC but doesn't include i915_selftest.h.

BR,
Jani.


> @@ -32,6 +32,8 @@
>  #include <linux/workqueue.h>
>  #include <linux/sched/clock.h>
>  
> +#define STACK_MAGIC	0xdeadbeef
> +
>  #ifdef CONFIG_X86
>  #include <asm/hypervisor.h>
>  #endif
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 5b46924fdff5..61d63c57bc2d 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -40,8 +40,6 @@
>  
>  #include <uapi/linux/kernel.h>
>  
> -#define STACK_MAGIC	0xdeadbeef
> -
>  struct completion;
>  struct user;

-- 
Jani Nikula, Intel

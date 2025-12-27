Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B112B3A1E8C;
	Sat, 27 Dec 2025 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766847038; cv=none; b=TElq6Dd5nQgnZiTWdt4zo6uNqNpssW5zCkh3wefI5gAaPyxXbaPii0T5i6KMvCy2NxBunsb5S7dKUhnhnwGBDtxsIwGs5W+NkIfcuFPGsv/IwupPtKQfKsogpVAX1ZTIIkdmGqBWNH8hmlNZXo9luYpCWNh4tLvg+7Jqzf8PO/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766847038; c=relaxed/simple;
	bh=agRaZ2qn8iGUDwGx0pm/utEXG1tRsSPPIZC9YbnVHhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j60yItf/eQWPIuGiDlEICqAvmYq5TJ6PkUJio74o9CQ0kiFCU/rINeu+WHZPvtz4SzBv+yzNurN9sen6qk7TmXXOXBAaYyvlFd1EQpvtcbjY8+jQYbBHnVjkongfvwBWDExvjSfvBCwNz2cwkMB6L5HMTvr8vTNeiJLMFSKkdUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GDc6obbc; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GDc6obbc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766847037; x=1798383037;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=agRaZ2qn8iGUDwGx0pm/utEXG1tRsSPPIZC9YbnVHhk=;
  b=GDc6obbcL4oXfnSnxmfMg6ROqROmjkJbbFR0SOVmCboMPfR/zKUQFIhP
   IyK6dPg2YtKALrdJy1IV75564pnN3bx4b41KPAT2jf8teYPEp+ncPJt1e
   l+8PVGYDOSHlbSYIedrRuELEbLPOJgJlz4nkUgJU4rAgX8+QmVMhtTFJm
   gD6Tj3ZE2BkjiqnCLdmyI16sIahqotTvJkAWeE6QOINZ1O4Zho1Y9fu7X
   mNOH+S4M4dtDZnThvKSnliPdaqNTOhL65ZkqC17PHwQ50/B1QB6jc6X99
   IWyGJ89tgJLd2shNbxwPkSineasWMgjVDtqF90uGCZ/yBKeKb1pnYjt5o
   g==;
X-CSE-ConnectionGUID: Lyd4BPhOTJGnlSw+NxZBsw==
X-CSE-MsgGUID: j5EeKtsCSSWKxijzXlSqrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11654"; a="67746607"
X-IronPort-AV: E=Sophos;i="6.21,180,1763452800"; 
   d="scan'208";a="67746607"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2025 06:50:36 -0800
X-CSE-ConnectionGUID: IA2r5lQCRxqLIY/qge67gg==
X-CSE-MsgGUID: v/3GM6fwSxC70TDwEy1EbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,180,1763452800"; 
   d="scan'208";a="199795529"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.211])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2025 06:50:31 -0800
Date: Sat, 27 Dec 2025 16:50:28 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	David Laight <david.laight@runbox.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/7] kernel.h: drop trace_printk.h
Message-ID: <aU_yNNJmIjUMIFlU@smile.fi.intel.com>
References: <20251225170930.1151781-1-yury.norov@gmail.com>
 <20251225170930.1151781-8-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251225170930.1151781-8-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Dec 25, 2025 at 12:09:29PM -0500, Yury Norov (NVIDIA) wrote:
> The trace_printk.h header is debugging-only by nature, but now it's
> included by almost every compilation unit via kernel.h.
> 
> Removing trace_printk.h saves 1.5-2% of compilation time on my
> Ubuntu-derived x86_64/localyesconfig.
> 
> There's ~30 files in the codebase, requiring trace_printk.h for
> non-debugging reasons: mostly to disable tracing on panic or under
> similar conditions. Include the header for those explicitly.
> 
> This implicitly decouples linux/kernel.h and linux/instruction_pointer.h
> as well, because it has been isolated to trace_printk.h early in the
> series.

...

>  #include <linux/pagevec.h>
>  #include <linux/scatterlist.h>
>  #include <linux/workqueue.h>
> +#include <linux/trace_printk.h>

I believe 't' is followed by 'w' and not vise versa.

...

> index 20b3cb29cfff..549fdeaf4508 100644
> --- a/drivers/gpu/drm/i915/i915_gem.h
> +++ b/drivers/gpu/drm/i915/i915_gem.h
> @@ -27,6 +27,7 @@
>  
>  #include <linux/bug.h>
>  #include <linux/types.h>
> +#include <linux/trace_printk.h>

In the similar way 'r' then 'y'.

...

Please, double check these and the rest.

-- 
With Best Regards,
Andy Shevchenko



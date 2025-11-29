Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6FC1EFF93;
	Sat, 29 Nov 2025 20:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764448233; cv=none; b=ecCMm5CNefMEEEYLCwp1okau+4/CDeLj6TwT22h4ude7d2XrB5xAFyDCDFS4kdHissNv94QhTAD5Py4llD9tiGLidL48Lsj2bsUgtN5OGN0jGLLSAGErGG4R7oX77lsoPp+8xPEPgiehlVL2yUql7c+D54caaIleVXwBWiIiju0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764448233; c=relaxed/simple;
	bh=Pl1lILzEe3LH5OBkbM+SoRdHXHebqrUDGpe8WEwHlas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8759JVrXqdCDWivaTXAJfbebeL+mvNKdlmmcPrW9kgM/OgRQeABHGapy/iBG92grDgRKyA4jPdCtKgho86pfFxjuLCiuKNkZNus/MEqrsvyKqro861quzAu2XcwRIC2wqWxAFMkrT/oQBecGjEGrpp6gR+6whMaTPwI6alRZwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oe21u0Yy; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oe21u0Yy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764448232; x=1795984232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pl1lILzEe3LH5OBkbM+SoRdHXHebqrUDGpe8WEwHlas=;
  b=Oe21u0Yy4ZzMaATh+/UuPJH6E7IEFZ/w15WERQSN9RhDUiKBa9Z4SXb6
   v4PPTKSg+ZOwe7pXkt8oh6t6Pg2KgMxHoEshx9xkJah/ofKwREiu/LZ7n
   Dkz1q8/TUtPRUINevvbcm/rX/7f+phwNzqsp1Xvqn/DAGune1wTMVK2Rh
   98HfztHHZCU5onN2HY/ohq3Oz+JVsUXDrRwpaqep5jYolKH1PmrgFLzmN
   QDehJAs60g5PRXE+Lls+fec+BXFmEvkynU6drOaRB4iI5S6rEOkY9wq/V
   V12ink2GwunAGWovzecMs7OMWFV8Av5bzWQKzEcZexqKK6ZVpxFpNOszU
   g==;
X-CSE-ConnectionGUID: rFkCF/94RtimPsP7IkmOYQ==
X-CSE-MsgGUID: vhGy3skfROKCPiff14D7yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11628"; a="70293276"
X-IronPort-AV: E=Sophos;i="6.20,237,1758610800"; 
   d="scan'208";a="70293276"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 12:30:31 -0800
X-CSE-ConnectionGUID: WTp37b03Qtu039IHsFhgDQ==
X-CSE-MsgGUID: 3jllhBBnTWyegBibIUCwag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,237,1758610800"; 
   d="scan'208";a="198042828"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 12:30:26 -0800
Date: Sat, 29 Nov 2025 22:30:23 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tracing: move tracing declarations from kernel.h to
 a dedicated header
Message-ID: <aStX3242e3mo5H05@smile.fi.intel.com>
References: <20251129195304.204082-1-yury.norov@gmail.com>
 <20251129195304.204082-4-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129195304.204082-4-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Nov 29, 2025 at 02:53:02PM -0500, Yury Norov (NVIDIA) wrote:
> Tracing is a half of the kernel.h in terms of LOCs, although it's a
> self-consistent part. Move it to a separate header.
> 
> This is a pure move, except for removing a few 'extern's.

Yeah, I also have something similar (but half-baked) locally, the Q I wanted to
ask is why a separate header? We have already some of tracing headers. Doesn't
suit well?

...

> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -27,6 +27,7 @@
>  #include <linux/math.h>
>  #include <linux/minmax.h>
>  #include <linux/typecheck.h>

> +#include <linux/tracing.h>

There is better place for t*.h, i.e. after static_call_types.h.

Btw, have you tried to sort alphabetically the bulk in the kernel.h after
your series. Does it still build? (Just wondering about state of affairs
with the possible cyclic dependencies.)

>  #include <linux/panic.h>
>  #include <linux/printk.h>
>  #include <linux/build_bug.h>

-- 
With Best Regards,
Andy Shevchenko



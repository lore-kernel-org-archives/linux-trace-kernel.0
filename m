Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243E8263885;
	Mon, 24 Mar 2025 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833082; cv=none; b=qdWFLadbh7/8yJnrILBTt1qlNfmVPs1mPRjZ9HSkTDxFGLotmlmop+NTWuYDOv+2GX30q4pgOHEY61c7uj9/5cwb3QNBqgDoXFuf9/5EwlJDwEqu7zoVbfCaDiMFWf+PsDJqoVbDXuCPKXgMB1zcvPWnFWKd4d5Y5UhBBd2dhEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833082; c=relaxed/simple;
	bh=r1CWYmSitq8ffSacjnIINz9x92kI2IJzQEeKRfc58Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ch8uaiOhsDO5XqXfrY6EHC51u4otvBRldrsT9jdwW6hmXOnCgMh40cnazML8E0Wg9y/sbGwz1WbyeyVuoH9+7WV7RZUQyyEt9XmbvLizHHoexETltRI9PoDDt9Ru7XcIYFhm+2vR/RvhBtX/EcI1EvLznIGePjK0A3YDdT/BxvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eZGdRWRs; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eZGdRWRs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742833080; x=1774369080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=r1CWYmSitq8ffSacjnIINz9x92kI2IJzQEeKRfc58Ts=;
  b=eZGdRWRsbgik6YQdoteM/UOgNEZdJ/qbsbJ+MhSPo5mlJ9mtVplbmmzi
   VjxOa6wmRR0OVeVjTP5spQHVHO4A2CyxiU8p/X1it4Mpi2Yalrk0GvjvS
   a9jzoBXgSAtAEcn6BMBKMjth4bICRYsgl+jb14fF5j3U9/uGj2fRncOOK
   mAXsxplPCIVY18Dj7JhF8R2KYKv0qGXM7b9+W9SvHFgMgV2HcIQk7RJ/c
   yh7TYirHqJVNDkc6gSzyxH9XmIPSoBZ6gybGfOL3p3yuwhDkRKyjXnk3u
   6cQcKorAGQM4v/6nXRewyfIlFtLeFj9UyEoclrNMFNE9kZyhtWU/dV5Od
   w==;
X-CSE-ConnectionGUID: owDA7x07TMuQ1WFl944HWw==
X-CSE-MsgGUID: 4fh7HGukQnq0zZuOavSDjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="55426930"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="55426930"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 09:17:57 -0700
X-CSE-ConnectionGUID: MI0HGLbxSTSEOprtpndLBg==
X-CSE-MsgGUID: kP5VE1NRTm6Z+IaGNcSjZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="155000896"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 09:17:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1twkUn-00000005UlE-391E;
	Mon, 24 Mar 2025 18:17:49 +0200
Date: Mon, 24 Mar 2025 18:17:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Petr Mladek <pmladek@suse.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Kees Cook <kees@kernel.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 1/6] seq_buf: Mark binary printing functions with
 __printf() attribute
Message-ID: <Z-GFrV3B1eoK0wrq@smile.fi.intel.com>
References: <20250320180926.4002817-1-andriy.shevchenko@linux.intel.com>
 <20250320180926.4002817-2-andriy.shevchenko@linux.intel.com>
 <20250324120430.0620a8f6@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250324120430.0620a8f6@gandalf.local.home>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 24, 2025 at 12:04:30PM -0400, Steven Rostedt wrote:
> On Thu, 20 Mar 2025 20:04:22 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Binary printing functions are using printf() type of format, and compiler
> > is not happy about them as is:
> > 
> > lib/seq_buf.c:162:17: error: function ‘seq_buf_bprintf’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
> > 
> > Fix the compilation errors by adding __printf() attribute.
> > 
> 
> Should also note the removal of "extern"

Ah, just noticed that you are looking at v1, there is also v2 available:
20250321144822.324050-1-andriy.shevchenko@linux.intel.com

Thank you for the review, nevertheless!

-- 
With Best Regards,
Andy Shevchenko



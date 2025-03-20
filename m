Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16EA79C4;
	Thu, 20 Mar 2025 18:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742495564; cv=none; b=LqBnNSq2zMSWsYVGJbJZdA6lNImvwL8mEzthdAa514FmGQeBrryxUNGhuRU2FCLiVpswZaVrO8Nubkh/aJ+tLgvg39yflanT1gEtPe1W1OVAEXS0VB8q3EQEFfnOj5cR3fcxoGe+xAVyWqGVszFfMTFq9iq1cI6leC7uslb9AJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742495564; c=relaxed/simple;
	bh=/VB5THOtzDNiqV0ePUYjkX6q1n/sVoDrM2PYZU/ZwoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHZZ6OyOA0M700quzRSzboCfPQ7+0ATmPDtcafNJvRMygq22EYuscJ2B4vuGsjIQMIEh3IVFk2+eeahL4+xpdZqeMGeUQe4HxwPr1zIcvnVlruQO+igB1YVcrxRMtlT281jGOApoPOMCYdWlYwZFgvixGs9IisX3dXRDGADNIdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GSafHyx3; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GSafHyx3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742495563; x=1774031563;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/VB5THOtzDNiqV0ePUYjkX6q1n/sVoDrM2PYZU/ZwoY=;
  b=GSafHyx3vReBqmCR7sc3ZH7W4QnsjIEYsmFZEDSPeuQxJsel+8bMD/zN
   sjZD8RFJXoOHfVdH3JUo/AqejQ9gx4/KbU+uMqia2ubpMECCkXlHymiGb
   nIuGhwOzXaUETeSjcERuMERZmOjF2GdIYkujMu0UrT2cQ25iV6p98VJW8
   cSW5+VBJpA/QWBXsUh9IYlZ8yXDwmbAzZbdeKscY5OGWsxZkF3S7FFcN9
   bf9+2Yfeb5vRXPgx51emcxl7WQ7wLLNPo1dqo0Rh4qh8vLXtqHyJSeU0u
   yD4/sMt/1k9FH6fuG6XYxlBOFDISe0uD7ci0qtwcLHJGbwwRbbrekBwFw
   g==;
X-CSE-ConnectionGUID: GNuylIc6RR2XcRVHR5GsGw==
X-CSE-MsgGUID: 5EFdQTRiT/OKuZsTreu+Bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="47626220"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="47626220"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 11:32:42 -0700
X-CSE-ConnectionGUID: wqtcx+jhRum5JMpfJghtUA==
X-CSE-MsgGUID: HQBKoQsaQNGl4+x8ikH8Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="122895116"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 11:32:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tvKh1-00000004J4i-1P1b;
	Thu, 20 Mar 2025 20:32:35 +0200
Date: Thu, 20 Mar 2025 20:32:35 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petr Mladek <pmladek@suse.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 0/6] vsprintf: Add __printf attribute to where it's
 required
Message-ID: <Z9xfQ_bbH85awKkT@smile.fi.intel.com>
References: <20250320180926.4002817-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320180926.4002817-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 20, 2025 at 08:04:21PM +0200, Andy Shevchenko wrote:
> This whole series started from a simple fix (see the last patch)
> to make GCC (Debian 14.2.0-17) happy when compiling with `make W=1`
> (note, that CONFIG_WERROR=y and all warnings break the build!)
> down to a rabbit hole.
> 
> The series is organised in a strict order and can't be split or
> reshuffled, otherwise see above.
> 
> Also note the last patch has a bit of a hackish approach and
> I have no idea how to fix it differently, I tried a few different,
> all failed. So, if you think there is a better one, please advise!
> 
> I believe the best route for the series is printk tree with immutable
> tag or branch for the others.

Alternatively first 4 can be done first as they are pretty much
straightforward. They also can be squashed to one (as the same
topic behind), but it all is up to the respective maintainers.

-- 
With Best Regards,
Andy Shevchenko



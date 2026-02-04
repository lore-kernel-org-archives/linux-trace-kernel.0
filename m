Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A97E26D4DD;
	Wed,  4 Feb 2026 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770212968; cv=none; b=GlO/FjyWr59wbTdu69Tcpr27wwFqWqQZgRykmbXOcdaz+sNXZALq/InyW667BZYkXNeW6JOTa7yX4f7q7Ee0HXT0p1y3RHn3yE4xfd+c66CvSE+B5yBzIh+NEaNPpAgMVn01Av3STI/Xea4kQUzrvnj8gP8j8U/1AmMn77yxX3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770212968; c=relaxed/simple;
	bh=QVt+6c+KRa4w2f0sjfZEEOQv55xP3NcdMcLwEAxvx3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSlBSKzvgbrq3kP7x716beEJ59nXThsGkh3KKjpKbNw4YDUITYLc2OIOiV9q2lia0hqZfXA/WezYw8XUTbLoT0wzaesu5/bdffrtJWB0tcdnnLbEfjG6n4aNvC1an49FsGRVKnXW6epwqyXPsSgp7jCFG2bSfKDahmRwuSwbjIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bGU40r7T; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bGU40r7T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770212969; x=1801748969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QVt+6c+KRa4w2f0sjfZEEOQv55xP3NcdMcLwEAxvx3k=;
  b=bGU40r7TXt4olfc+gv5/rAyOBx1ey4wHNf+DyoP1R3LeK24Cy8j3CAGQ
   WEJmjHTAZt2MqOaCzCwYKPNgukSFzDODTEc5dSQJ8ZPkf9KEig0PuLi91
   DA3+iFUVPEAmZjjMbcCQgTSMaFglduV0QhTlvwJFYQy7sACBt045b2Ll2
   sygZwfyerw6tqPR0bNSsiPWNZvny+GFcKtmsRoXbzhPwL25u/EIcvY5aE
   lbJDpII9o5SvwFpYmwIulDavvEk33NoyiDqyGpm1UgvD4/M55g8IjdieE
   fb7Y0qm9X0n3w9zdzcO56ZEReeFAtR9xW745zi0gQDEsaWbMCMxIVV3nV
   Q==;
X-CSE-ConnectionGUID: qzpCkg3yQYeQiM06688xCg==
X-CSE-MsgGUID: dq5N7LthRKC/xUL3mvYCdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71301845"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="71301845"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 05:49:28 -0800
X-CSE-ConnectionGUID: SkZfaF6nRJqebqMK8Sf2oA==
X-CSE-MsgGUID: Q4Qd/ShPQGCnUxVumbF7GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="210206368"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.188])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 05:49:24 -0800
Date: Wed, 4 Feb 2026 15:49:22 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Simon Horman <horms@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yury Norov <ynorov@nvidia.com>,
	Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] tracing: move __printf() attribute on
 __ftrace_vbprintk()
Message-ID: <aYNOYrUEUgg2T73q@smile.fi.intel.com>
References: <20260203164545.3174910-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203164545.3174910-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 03, 2026 at 05:45:29PM +0100, Arnd Bergmann wrote:

> The sunrpc change to use trace_printk() for debugging caused
> a new warning for every instance of dprintk() in some configurations,
> when -Wformat-security is enabled:
> 
> fs/nfs/getroot.c: In function 'nfs_get_root':
> fs/nfs/getroot.c:90:17: error: format not a string literal and no format arguments [-Werror=format-security]
>    90 |                 nfs_errorf(fc, "NFS: Couldn't getattr on root");
> 
> I've been slowly chipping away at those warnings over time with the
> intention of enabling them by default in the future. While I could not
> figure out why this only happens for this one instance, I see that the
> __trace_bprintk() function is always called with a local variable as
> the format string, rather than a literal.
> 
> Move the __printf(2,3) annotation on this function from the declaration
> to the caller. As this is can only be validated for literals, the
> attribute on the declaration causes the warnings every time, but
> removing it entirely introduces a new warning on the __ftrace_vbprintk()
> definition.
> 
> The format strings still get checked because the underlying literal keeps
> getting passed into __trace_printk() in the "else" branch, which is not
> taken but still evaluated for compile-time warnings.

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



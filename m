Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E19A35971B;
	Mon,  2 Feb 2026 17:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770055049; cv=none; b=pvOalp4sB5IvpeCFam4EVVfGQI02Zb0HWQeRBSkZmleDgRd+yeEgECbl13yE/H1f2y0mLhZoOV5jXWvULAbgZSnOQsc6rPOPqUeXd4eFXUlW5+UnhRbKaQy4/tU5lLGLAXEwu3+pbwcSUJ5VHYLbw2s5vtjlzlbMpnFbGowIVK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770055049; c=relaxed/simple;
	bh=hsNNUFe85/XZuDIL1kmw/ezOBdW8qhOfrtTgsd02jRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioDDYMrvy0iT/Pgmzh3mLO8fTDu6aN/FpmTorZt+mWQpl6HatIGY9zhG0IjmIsvMxUY7km3yf7lIQBp/LKTwrplA5tMXglA65byQDy267skLMnWAoNwB93/0OXFeTSvEq4CjuAcVdYL0AtUJFIGHr3q5TVlarNl7PL9QUI0eieU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZO5p1MEE; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZO5p1MEE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770055047; x=1801591047;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hsNNUFe85/XZuDIL1kmw/ezOBdW8qhOfrtTgsd02jRg=;
  b=ZO5p1MEEvLNLHRj+uuLJdftF6mw33LmfDt0T6bGkDpcdSb7o7PU2Bm0T
   totnbJURSi+sm5IRooSJzkHAGToxuwbWYBE829qvNnRRk7PZAXwYI8LR/
   sGfGhT1xzUc+tZRuDfGyWiAW9ZB2SWiu9wNWk/I+z5X+yQO8u/NHH/cHP
   b/rO9cV9TbCIWKzh81yleBI805KOjDgNRzzOnF9JkgfBi8al6LdTtC0Ts
   KDzLC6Qkj2S5/B858mLho6PZRcYpQZp9hq6z/PGM5kt16V4EngACTB8ku
   TEPkRCZC8NkNtyhVXXdJASmjN6IdXTGH43KPIF4sWl8KTQEfS9hmufxy+
   g==;
X-CSE-ConnectionGUID: 2ajuw9p1QJSIEAFFjM5Qvw==
X-CSE-MsgGUID: WBliUdX/TfiIEss8WzWCNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="70422101"
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="70422101"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 09:57:27 -0800
X-CSE-ConnectionGUID: q6PXXN2zQw+vTS8/2wI50g==
X-CSE-MsgGUID: 7rpmEPx0QbK0JTBWIJJRQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="214067612"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.13])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 09:57:23 -0800
Date: Mon, 2 Feb 2026 19:57:21 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Simon Horman <horms@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Chuck Lever <chuck.lever@oracle.com>, Arnd Bergmann <arnd@arndb.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yury Norov <ynorov@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: remove __printf() attribute on
 __ftrace_vbprintk()
Message-ID: <aYDlgZSKRWqtH6Oa@smile.fi.intel.com>
References: <20260202095834.1328352-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202095834.1328352-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 02, 2026 at 10:58:27AM +0100, Arnd Bergmann wrote:

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
> Remove the __printf(2,3) annotation on this function, as this is can
> only be validated for literals. The format strings still get checked
> because the underlying literal keeps getting passed into __trace_printk()
> in the "else" branch, which is not taken but still evaluated for
> compile-time warnings.

Yeah, it was discussed in the past that binary printf() should not be annotated
as we have BPF code that doesn't compile (with the default WERROR=y).

-- 
With Best Regards,
Andy Shevchenko



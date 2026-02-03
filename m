Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CACC257452;
	Tue,  3 Feb 2026 17:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770139072; cv=none; b=X6682sP9Y1Tru9V588Cf3Dukeg7H9/zehVKcgJI2sMKf5tOtH5NYm1BhqIqJoNOOJjizf5yLYZjoyp4w3znrMMAr+eZVnxGtv8BR1RGfMB+qeaB8wmP8twMog+ypKy938nTrD7Ziq7dEhPdyr0AeDhdM1EmeOboa0V2w4cESS4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770139072; c=relaxed/simple;
	bh=v0lDm9YgstKw6NIqXo1gHAVbHj1ebjoVADNi9DqILIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6zoj7UFa9G425Fq742P/dpYqGgeDeZqcUqASbq7QstUfrbtkesamZyyHZT7oXhShPozUaCqKch7qfYQ6j4OlmmnQ/VOEj2x+0g9S0iTlAhYe8ctjBlDp0uVvH2m22bXZth2E27ncTydR6ctrR32zhZpjey+bWAoOYH1+4ZCgkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gesjHoji; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gesjHoji"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770139071; x=1801675071;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v0lDm9YgstKw6NIqXo1gHAVbHj1ebjoVADNi9DqILIA=;
  b=gesjHojijbZWQeZak5LT1E6TZIMNchNGFlOlACAnxxGgqDu0YFfX6VuW
   WLwKrdjChxHaQKjH6i8ToCC9G3MFGQqoSKelVn7gwPKSSvGd+5WMIdXk7
   DRMhazmP3HkqGTlVECo6VE4BqCsnxIQkVS0CQFf5JWC2JVN0OTKCCZBGl
   HH+vDie9lM1cuKvZXLl1DJREppjxXIPdSRcVv/tVmlhv9l4+Hb1RyAzgH
   7/v6b/K5e5/Kk79TaRFEabi7AHE8q5ZMtRYnVHamw+Mw0Myr22tBCwZ1L
   qPmJte8Uy8DSxC5BsvWOANjwLAHc4s45Qa0EJtXJ47QpUiR+zSexLBZys
   g==;
X-CSE-ConnectionGUID: OBIuGBHNTIG2Ris1Nx3upQ==
X-CSE-MsgGUID: PeMzfY64QXeafaWlNifrFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71221764"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="71221764"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 09:17:48 -0800
X-CSE-ConnectionGUID: eFiBkPDwTYek2C7bzla/Yg==
X-CSE-MsgGUID: ifUYzvaAT5KqOvbUgYsovw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="240590627"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 09:17:44 -0800
Date: Tue, 3 Feb 2026 19:17:41 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Simon Horman <horms@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Chuck Lever <chuck.lever@oracle.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yury Norov <ynorov@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: remove __printf() attribute on
 __ftrace_vbprintk()
Message-ID: <aYIttabs_YsTiibd@smile.fi.intel.com>
References: <20260202095834.1328352-1-arnd@kernel.org>
 <202602032036.FQK7gJvV-lkp@intel.com>
 <aYINAPJS9zXlUGCw@smile.fi.intel.com>
 <d777a8f0-41ab-48f8-93db-268f493ac656@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d777a8f0-41ab-48f8-93db-268f493ac656@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 03, 2026 at 04:56:03PM +0100, Arnd Bergmann wrote:
> On Tue, Feb 3, 2026, at 15:58, Andy Shevchenko wrote:
> > On Tue, Feb 03, 2026 at 08:12:57PM +0800, kernel test robot wrote:
> >
> >> kernel test robot noticed the following build warnings:
> >
> > Yeah, you need to go for the full stack of these calls and mark the 
> > bottom one with __diag() to avoid these warnings. That's my understanding
> > and what BPF people required. Chasing this one-by-one would produce
> > unneeded churn.
> 
> From what I can tell, I can just move the printf attribute
> to the __ftrace_vbprintk() definition to make this bit work.

Ah, that's cool!

...

> There are unrelated warnings for BPF that I managed to
> shut up the same way, doing

BPF rejected such an approach, see lore discussions in the past
(patches from me). Here some pointers (but not all of them):

20251208141618.2805983-1-andriy.shevchenko@linux.intel.com
202512090407.VxRO6xAS-lkp@intel.com
20251210131234.3185985-1-andriy.shevchenko@linux.intel.com
20251216122514.7ee70d5f@canb.auug.org.au
20251215202430.c35c2d29c4f9ff614d2ab534@linux-foundation.org

-- 
With Best Regards,
Andy Shevchenko



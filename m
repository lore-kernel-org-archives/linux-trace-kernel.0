Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B416F212FB9;
	Tue, 30 Dec 2025 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767084918; cv=none; b=CruZDwpsn8MlA8w6ulVdlR8BH9Tdsk7+CNu+0e2vlQixYtyJjH/JWLaNdaeONZMS9WjUJcmmx0iaAZP2Q38nGjM8fho4uo5gfSDIac/VlLb46TraRmYM2MsVVvhhInOlLkdfCjlNrfOHvtEbFn/OhmmjpMaLUOmXI+P5AecFy+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767084918; c=relaxed/simple;
	bh=DIUWg89A9uqjQJSa8uU7nqynCwHKpJnUH0bwlQIa0Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdekWOiAfuI4JgEdMetkycJ8YGhQ1LRujgi+ufxsFoYUzjYEb/rx5B1Q6HXQcx/RNZHdW+cxl8i1j/iEy2fUdUGVA/LC8G5iUwtsmoQgUJBQkyMDpNQwmPc3KOJb8s+dT5aVTyM+E0pTrBCjq8wjh23MhAoiuTUjeQARKnOZjdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aKiyNuE5; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aKiyNuE5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767084917; x=1798620917;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DIUWg89A9uqjQJSa8uU7nqynCwHKpJnUH0bwlQIa0Eo=;
  b=aKiyNuE5LWDgt9o6HTSQWVQdHMhGhpKRsO9NjUrI1Oz1QrimEVJ8srLf
   ZRExc3lGaif6Y4WESdh0lCldES7sp4vv9+UbmS/pwnwVTPe6wNNn5mQvp
   hbq8IKWj2H21DWr/ESDsNxB0oFlHJtuyCsskQ2gTVY5G/gLz++O8YBIMA
   Rk99qhLo1Kv8UOetuguj0McKrP3K2A84q4Jq72OYfRBWCVPTt+/BxYyX8
   H6x7B/cbkla030JCYg2nSnO/B64/O0RojkP2wy5NTaNOM6hXsjQz7Br+7
   eOoChRREeA0TvdOx5K8aehVDr8L+LD5m233tCjLbxvzZXGhpf9KYdEoAp
   g==;
X-CSE-ConnectionGUID: R+PLZ7oVRoKa63SusPmwSA==
X-CSE-MsgGUID: pa1mjJu8QU+uUCkSUm+gRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11656"; a="56248170"
X-IronPort-AV: E=Sophos;i="6.21,188,1763452800"; 
   d="scan'208";a="56248170"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 00:55:16 -0800
X-CSE-ConnectionGUID: LM6UUyFmSBmENn61vwtC3A==
X-CSE-MsgGUID: WjgB+I+XRlqqfcoeZHvIGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,188,1763452800"; 
   d="scan'208";a="201161436"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.103])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2025 00:55:10 -0800
Date: Tue, 30 Dec 2025 10:55:08 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
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
Message-ID: <aVOTbArAxmbT5LY9@smile.fi.intel.com>
References: <20251225170930.1151781-1-yury.norov@gmail.com>
 <20251225170930.1151781-8-yury.norov@gmail.com>
 <20251226115848.298465d4@gandalf.local.home>
 <20251228133150.1d5731d04bc1b685b0fe81c1@linux-foundation.org>
 <20251229111748.3ba66311@gandalf.local.home>
 <9833cb61-1ec5-4cc1-ad9d-3e07f3deff80@efficios.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9833cb61-1ec5-4cc1-ad9d-3e07f3deff80@efficios.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Dec 29, 2025 at 05:25:08PM -0500, Mathieu Desnoyers wrote:

...

> One possible compromise would be to move it to its own header file,
> and introduce a CONFIG_TRACE_PRINTK Kconfig option (default Y) that
> would surround an include from linux/kernel.h with a preprocessor
> conditional. But please make sure the default stays as it is today:
> include the trace printk header by default.

"by default" where exactly? The problem is that kernel.h is a total mess and
it's included in a lot of mysterious ways (indirectly), and in C you _must_
include a header anyway for a custom API, just define *which* one.

Based on the Steven's first replies I see a compromise in having it inside
printk.h. If you want to debug something with printf() (in general) the same
header should provide all species. Do you agree?

-- 
With Best Regards,
Andy Shevchenko



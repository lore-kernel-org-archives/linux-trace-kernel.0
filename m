Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D061A219E8;
	Sat,  3 Jan 2026 12:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767445090; cv=none; b=cmBDwb0FLYwHGPkBm6oDJAuNs2gnaPl6eeRmQGxZaOHfuVfXIE7b74tKUiVa830QVl+jqOKHXB4GtAAR3meNvdmP+2Cn9nEzKOxKH4hS8LBD2iYMTnkdh28fMzkvQdga7+2lJxVq8Hkgq+HfmIJ9l80jSE8qUv1bSDIulTO2XcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767445090; c=relaxed/simple;
	bh=zUPx4E/hNNF3I3u24hIELKoJzQiebtlyaltGOIKAEr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQyJ8a26OW0JitqrILjnEkV9BzRbclhDuYgA0r7BD1seNoKoAUEqoUkIUoD8XXKSiJ8SV8Sw2Waea7AAOPqafi34YNYHsKU253ErHK0+WHfsHl6nmThIwWZMoJpRtkFoVKmp5Wn+zjr9T5Z3KloAR2irOqKIW5b+WNUqg2sFF3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sg7C5n5f; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sg7C5n5f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767445089; x=1798981089;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zUPx4E/hNNF3I3u24hIELKoJzQiebtlyaltGOIKAEr4=;
  b=Sg7C5n5fyjaTjuZS9vkKtNPNhWFuH35W91yy0WRfp3bgFEqZNgyKNjk2
   h23uNEciTfS/xwzXQ9TRe6UAHHYtPK9YAMh3w0qQ1hLfETUYXD0hjmsVd
   +SgVK3A1nNevWq0j9YTB+JvxogmArydUXn7weD8YvI7k+GlDA2KcLXWVy
   iiHsaGgqs6RBbfUCLw4kUUgntZBNeHnIX2ol0DjvrF+VqIk0VWJJLrmaD
   0PmP2zpJRmECGUSbKdQBUXzQgM89oJDO5Lic9fSM4UnD0unrEbOOr1Ymt
   7+/I2SzTmWmD0w6G2SXIlANDO1ZbthGMSQ38DIhdsxQgovrLLOreWCl+R
   A==;
X-CSE-ConnectionGUID: hWSF8DjhS86gOBs0ih/mFA==
X-CSE-MsgGUID: COADD78sQvO/VjlBoKvDyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11659"; a="86315913"
X-IronPort-AV: E=Sophos;i="6.21,198,1763452800"; 
   d="scan'208";a="86315913"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2026 04:58:06 -0800
X-CSE-ConnectionGUID: OZMavmVNQHWWd/KK3gHuqg==
X-CSE-MsgGUID: bvE4/ZGiSoa6EseZj1KFRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,198,1763452800"; 
   d="scan'208";a="202014319"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.75])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2026 04:58:00 -0800
Date: Sat, 3 Jan 2026 14:57:58 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
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
Message-ID: <aVkSVk2L6VH9MYGz@smile.fi.intel.com>
References: <20251225170930.1151781-1-yury.norov@gmail.com>
 <20251225170930.1151781-8-yury.norov@gmail.com>
 <20251226115848.298465d4@gandalf.local.home>
 <20251228133150.1d5731d04bc1b685b0fe81c1@linux-foundation.org>
 <20251229111748.3ba66311@gandalf.local.home>
 <20260103005059.GA11015@joelbox2>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260103005059.GA11015@joelbox2>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 02, 2026 at 07:50:59PM -0500, Joel Fernandes wrote:
> On Mon, Dec 29, 2025 at 11:17:48AM -0500, Steven Rostedt wrote:

...

> I use trace_printk() all the time for kernel, particularly RCU development.
> One of the key usecases I have is dumping traces on panic (with panic on warn
> and stop tracing on warn enabled). This is extremely useful since I can add
> custom tracing and dump traces when rare conditions occur. I fixed several
> bugs with this technique.
> 
> I also recommend keeping it convenient to use.

Okay, you know C, please share your opinion what header is the best to hold the
trace_printk.h to be included.

-- 
With Best Regards,
Andy Shevchenko



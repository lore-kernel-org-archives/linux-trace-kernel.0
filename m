Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991AC3612CF;
	Fri, 16 Jan 2026 10:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768560119; cv=none; b=TGHk8h9uUHpmmGWEEXdc3MAukGC5PZP74QF+kaDEa2kcApUG2NPCnuxKPCG/M74+8qhZUPr4hz4R6GBWVybmKbhcZn00rXpBA3ImVX9IuKOwQkN79asFoiv1vjyMrPj4gff5/oZupAEBVOI/jWwpAwxfZgF9N7TZSDVgvLGNwb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768560119; c=relaxed/simple;
	bh=nG5D28yq7MyPW7K9UDaQ4YtDHaNWaFvEhZSYKBSfzv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdAOb9pZ2mB47fE+ZPDC0FzMDO4/a8yU5OZnKbNFvOQYHwLEU239xbx/8xuXhYvC9rmH0iEUKNQAqjvFm6oYLXTN2WbZoNWqnTSFiEywk08jHgvf40zI0n9cbs9eUmVVPh9Sff/XnUaSqzwk4X/H3gKfwYH94Qrema1/wd9Ce30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ge/TpREL; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ge/TpREL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768560118; x=1800096118;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nG5D28yq7MyPW7K9UDaQ4YtDHaNWaFvEhZSYKBSfzv8=;
  b=Ge/TpRELKAXLhksM1xIdQtvb5UDZiRq+W/Tr5CfXv5eQlGyQ9uFgIX/+
   8vAjBQeOWwdwHVebfo01VzWVGh1ZxeaJWVzTXDZaIgL8RycDAZR+z5CNp
   1eGUREBxhx1TLw1AWWx6TaD9661XZxmJnhyb/ttflfRyJBvOcfBiMR96J
   1Mj1C7MKJpS5Mwvyn86LaxzMRdWlWXh70Pt0u6nPhbw7gcyCzHdzPrP2X
   MbauTQffVrfINCpyoFwIvUCEYh9Z2+7NsALA2zDiVLvsrUePlvst6ZxnP
   XfiMetgrZLVrU+GLH5yra0fx3ROT/tokrR9T+0cPHzO9hk6aH1G5zEA5P
   A==;
X-CSE-ConnectionGUID: AJLmVZ9dQCK1dOL6+8GRoQ==
X-CSE-MsgGUID: lmyfTIt5TRyHpQtUFg1VXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="73503220"
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="73503220"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 02:41:57 -0800
X-CSE-ConnectionGUID: faDvYPF7QraHgKGP0sCxgQ==
X-CSE-MsgGUID: eIsMQWNcRmqC2zOdnGB9rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="204825957"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 02:41:51 -0800
Date: Fri, 16 Jan 2026 12:41:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yury Norov <ynorov@nvidia.com>
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
	Danilo Krummrich <dakr@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: Re: [PATCH v5 5/6] tracing: Remove size parameter in __trace_puts()
Message-ID: <aWoV7cYMHmMpYVRt@smile.fi.intel.com>
References: <20260116042510.241009-1-ynorov@nvidia.com>
 <20260116042510.241009-6-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116042510.241009-6-ynorov@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 15, 2026 at 11:25:08PM -0500, Yury Norov wrote:

> The __trace_puts() function takes a string pointer and the size of the
> string itself. All users currently simply pass in the strlen() of the
> string it is also passing in. There's no reason to pass in the size.
> Instead have the __trace_puts() function do the strlen() within the
> function itself.
> 
> This fixes a header recursion issue where using strlen() in the macro
> calling __trace_puts() requires adding #include <linux/string.h> in order
> to use strlen(). Removing the use of strlen() from the header fixes the
> recursion issue.

I like this change, it unloads the header dependencies from string.h, however
the latter is not that messed up.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



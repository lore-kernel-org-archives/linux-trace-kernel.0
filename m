Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2066C311971;
	Sat, 29 Nov 2025 20:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764448360; cv=none; b=X03npImoqsVKfaA/L+4H9QcNcvUuYPeIsV+Y4yS/5fxLrFeajcHLxkCnVGgDNLE3YPR2HwNsn2elsFiKX+HW0yUaQupPd4XPS6eZYdNbnw2BdNehI39IVQkBuRFM5ywi133kGKKNaROAwQo8bSqu3+H5KSe6HKRhrxgCD2dVwXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764448360; c=relaxed/simple;
	bh=ShffxbWiE7yWibvnAjeOzPZLjmqw2h5xktqTp4Co+KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VycYX4fAkp6yvLLB885qObG1EUC9sFq609aFpO7XMhVleIp+ggtiCDFSFYWtrjZpXoM4UjLnjgakOd8YDoIyV1QRVCBV5WcF+5XHBcoSRSy8mWe52Lc8+wa0fpXwCEd0eTMRNc+JTFOjS1vCETkqXcw6o9xu1uCz6Ado1P41U5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OtgJUsDb; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OtgJUsDb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764448359; x=1795984359;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ShffxbWiE7yWibvnAjeOzPZLjmqw2h5xktqTp4Co+KA=;
  b=OtgJUsDbKMDvOMFjtcrUKOLtPM8x7FVVqNb32upGTgKuPIpvDhCGmjRs
   lexgrKQLO7ki3YncydvClSl9wC2ldso40RetJw6jvqP9HGFqyVt0opqp5
   9SDcYx8/aVHV4H7QKuWzkbYkNwbL/BX0/4IovkJ4hxLudODQH/T1fFJy5
   6zp5CfI/79fxkz8hXi0XLhuvIiBeiC82Yb9yxfUDuc1DmjalEIOrKXypN
   7a50C/8XrpfVxTZBPjTE9hXQQ/Bqyub04V7UaIudsLVh+iwtak41iFaU5
   ol7bsrgusAWoG4dFGd3vAVpiAdlg+blr8AO6AmOnfD8be9Ft4LC95hVXf
   Q==;
X-CSE-ConnectionGUID: f2kNvUB9Q5SWrrBKxBsZ7g==
X-CSE-MsgGUID: Gt6I9D0TSp+MXjymESQ/2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11628"; a="66387779"
X-IronPort-AV: E=Sophos;i="6.20,237,1758610800"; 
   d="scan'208";a="66387779"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 12:32:38 -0800
X-CSE-ConnectionGUID: 7BMz4dpNQP6Xdxj4ChepVw==
X-CSE-MsgGUID: BeRkOaU8QsqgNKfB/YNSJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,237,1758610800"; 
   d="scan'208";a="194138307"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 12:32:32 -0800
Date: Sat, 29 Nov 2025 22:32:30 +0200
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
Subject: Re: [PATCH 1/3] kernel.h: drop STACK_MAGIC macro
Message-ID: <aStYXphpN84Nr8LZ@smile.fi.intel.com>
References: <20251129195304.204082-1-yury.norov@gmail.com>
 <20251129195304.204082-2-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129195304.204082-2-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Nov 29, 2025 at 02:53:00PM -0500, Yury Norov (NVIDIA) wrote:
> The macro is only used by i915. Move it to a local header and drop from
> the kernel.h.

Agree, if one wants to reinstate it, there should be better place for it
(something related to kasan?).

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



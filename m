Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041763B8D75;
	Fri,  5 Dec 2025 20:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764968132; cv=none; b=ogRs4ilxEXQ0NO3Se1yBndH2g8tSgV76461CfNJIZ7wXJO01DGcfUuU93Bz5usaUmwEIhaW9X/7kfo7kMMXHXF9JLkpV4zZnZX7qDK5ZOFbz25KwOc/vqZn4NffUDAdGXrNLqECON0urzWjZ9LHpWYQ9m0CM/XmNFhspjgmo4j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764968132; c=relaxed/simple;
	bh=2M76oGPEhzayf94fY3W/5vUFykQITW0NDibgO6rlkhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkg8IW08QVZaMjUYFNgJxvc1IlqHyjM3oIVD94Nlk0ccljuf09y9BSPoyNG62TpZ3Sh/56SqvPeogg9/dItNjpPzHA1WnWftFNJujU/cHyjGYfA+TGASU5rmbYwirBLk3bn3j+pInryQq5U0kzumS6Ful/vkA3nCcyySaaZlId4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HpXu7yf2; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HpXu7yf2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764968130; x=1796504130;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2M76oGPEhzayf94fY3W/5vUFykQITW0NDibgO6rlkhs=;
  b=HpXu7yf2YBAxDhbhHE3o5zOn0dr1Dv21K/vBVqCkGOfAbpt1olZ2HoSN
   yHbns3jg9yRrL8+xSItF2OYxPC1GGkQzCA56ZNPMA+xFvxjt4jdE/9Bdn
   F6TS2tvlXrFy/rpujR9X1BUZHkHmsM89HFaYRde0BHXounL0eMcxFlv4/
   38R6i4DPIDf4XPr0A1RmU19VEVQka+zjnCA8VeQP/42yZH0B0caprpXQH
   9GG5ocojkFI/cgZxLkA7hvnSpb/bUyxu/CkiHne+dEd9wil0oqvIs/UiN
   BcAg15F7I3ErmKPFbFlHS/j7mYDsTXgCl/0qnAUot7daQJrapwDjuD+8p
   w==;
X-CSE-ConnectionGUID: dXkM8pWeRP2wa/zlDg7LDQ==
X-CSE-MsgGUID: Mcdfyza7QbK/DX4yS9TTmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="77628237"
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="77628237"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 12:55:29 -0800
X-CSE-ConnectionGUID: tAx0bR2HStyhixRuAJB4Sw==
X-CSE-MsgGUID: nZK1zXyWQR+i24Bpjzp7qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="194687534"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 12:55:24 -0800
Date: Fri, 5 Dec 2025 22:55:21 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
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
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] tracing: move tracing declarations from kernel.h
 to a dedicated header
Message-ID: <aTNGuY24Y3sHkRiz@smile.fi.intel.com>
References: <20251205175237.242022-1-yury.norov@gmail.com>
 <20251205175237.242022-5-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205175237.242022-5-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Dec 05, 2025 at 12:52:35PM -0500, Yury Norov (NVIDIA) wrote:
> Tracing is a half of the kernel.h in terms of LOCs, although it's
> a self-consistent part. It is intended for quick debugging purposes
> and isn't used by the normal tracing utilities.
> 
> Move it to a separate header. If someone needs to just throw a
> trace_printk() in their driver, they will not have to pull all
> the heavy tracing machinery.
> 
> This is a pure move, except for removing a few 'extern's.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



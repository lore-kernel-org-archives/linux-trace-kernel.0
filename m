Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0475435C181;
	Fri, 16 Jan 2026 10:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768560218; cv=none; b=VXyK0rx6Rz6oSRuj5+32Nh2J3nkKkgQ8dOtCg+zNOFhxWVlGGF0h8LhujvzW1Wcfov1w3R5Gb8ivxv2jCmWvpPC1Wo4imuGIE8Oih/Cwd+t/K3GRh1cCRKjVDUmPVpj6PEndWzFzqyVkyPRIxt7jebW6DxsO9CYUdqyWVKw0ROE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768560218; c=relaxed/simple;
	bh=L0lytLGMbujuZg+wBdouHk2nzLvJCJL5TeiQkzFCsbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdV2m5ftkpvR0pMUsY4grV9QonqfYTxHeFYQqtcp2TthmFuxcneWP792Hazg+5fuS1j/fmP0FkzdIyhIK1RInqCAG5wsVhrIwdhBvJbOD2JEkRJEJeTUCreF49qQVQB90mHRbG8Z8WZd7SqbFradryTkquE7HrnBvUNgr78pJIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G8KWyAek; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G8KWyAek"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768560217; x=1800096217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L0lytLGMbujuZg+wBdouHk2nzLvJCJL5TeiQkzFCsbY=;
  b=G8KWyAekit1XCkOWiV2Z5YgAmWsbdUdbZPYsnMq6l6dWp9yl9y+HZmR9
   Yz86eXx/Bnkao3gSpGoiTlV5BCVcCGtZijSKOGnv4spAOLE5WFYDJyIBD
   YIJ5J64eUjwS8UZ4P/wsNJBl3Xxs+SLXlR0C7tcUBalXrZ/Oe47tej7vw
   /xLfKv1R+NnKyR6BugyRsTTMx1M1IlSXlq20sgh1/aMMf3QU19mqVgZiJ
   zhxiiClVbNMhQJipVscsDMolh5nX7k+CgU4Xwo0bgLfiH3ACLm8GzVB2L
   d/1KgcoDJcEZt50qSSC0SqRBRrNFH1qhyuqp/LcQTDqxlgzWEzyNhnarf
   w==;
X-CSE-ConnectionGUID: 6NGwJz20SF+FUoMm2YcaPA==
X-CSE-MsgGUID: RfjE1Ng4STiG8P+CF8VNBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="87292975"
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="87292975"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 02:43:36 -0800
X-CSE-ConnectionGUID: aLO6LASYTmOVfJQX2XCTvA==
X-CSE-MsgGUID: hLd/cwkqSKuD90ysnWpX4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,230,1763452800"; 
   d="scan'208";a="205493856"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 02:43:31 -0800
Date: Fri, 16 Jan 2026 12:43:28 +0200
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
Subject: Re: [PATCH v5 4/6] kernel.h: include linux/instruction_pointer.h
 explicitly
Message-ID: <aWoWUNZM2lq9XlWO@smile.fi.intel.com>
References: <20260116042510.241009-1-ynorov@nvidia.com>
 <20260116042510.241009-5-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116042510.241009-5-ynorov@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 15, 2026 at 11:25:07PM -0500, Yury Norov wrote:
> In preparation for decoupling linux/instruction_pointer.h and
> linux/kernel.h, include instruction_pointer.h explicitly where needed.

LGTM, assuming no build breakages
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



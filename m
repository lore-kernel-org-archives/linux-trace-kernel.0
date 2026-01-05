Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C57C221F39;
	Mon,  5 Jan 2026 18:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767636724; cv=none; b=T5znf6T1LrnYLOCwj+weOeYew5Ek0o0os86i/1otm4ZcIVARb6DabnxUdOSmD3PnzoF4KbhJKbYcPuyu2z5CTjQUxMeKa3vJ+GAB9WQuVkvqC6OPiLwtO75sUW8vCbMXWXhqI2lwjpIlIxuII08nk3nP422dAw/6TjnMfneIYgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767636724; c=relaxed/simple;
	bh=6wdEmcL6E7q+3kAfrlRMIvHeY7Y5Wr3QYQiqZOjdOQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLe/9ukxdMBlX1V+J7o19gi0fH78oImKI+luv2gbAJ6YaRGFyvHoigdOjMgV+X77fP/iuNqyPf1x355AGod6SKpe30uMgF1zD5OAtUAS4gd4UEDGMz9AzLbQdm88Is/rr/gFC+p3F66BTq5MhUupu8fEfEYLg1Nt1U4chmgo66U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kaBW7vZ0; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kaBW7vZ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767636722; x=1799172722;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6wdEmcL6E7q+3kAfrlRMIvHeY7Y5Wr3QYQiqZOjdOQw=;
  b=kaBW7vZ010Koj4Kslm3GkrWSHZu10E4V2pCbHrxrWoFwViihSmVa7gDh
   W4r8JZa4yxJDrIKpQaqbISwRbe9iYBfzfaZZt+4I4EKQIn2w4ZcysBLK4
   bP9k2ee93Agg49ct+XAp8KVrq3bHW8wAltG6roV6Bq1liUG4MfqEXcpvb
   BYeeB+buHx9Pb3stSMsjLBSpGkHC8u2E4qiesH+RlQIZpJqDQm395oTFJ
   YUzMmmmH/pvA15FjVVr5XsRtdWOMbwFQB0QotraXzKw7qbLUa4vVyPck1
   z0q3fHJAvRR9VdiZVuFlnZeawn/0vEjuxsPN8DIm6Ky5QGm10AtrfgY5F
   g==;
X-CSE-ConnectionGUID: 0MVakd1OQx+jtrhaU/zYUQ==
X-CSE-MsgGUID: nzKc8olTQ3i8btesAPfLVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="79310645"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="79310645"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 10:12:01 -0800
X-CSE-ConnectionGUID: MqA6g6iGT8edS9Jk7MYGGw==
X-CSE-MsgGUID: oarw9iqVSeuBzJJDGf2UBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="206591309"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.215])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 10:11:56 -0800
Date: Mon, 5 Jan 2026 20:11:53 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
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
	Vivi Rodrigo <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 7/7] kernel.h: drop trace_printk.h
Message-ID: <aVv-6WZA9aX2r_QH@smile.fi.intel.com>
References: <20251226115848.298465d4@gandalf.local.home>
 <20251228133150.1d5731d04bc1b685b0fe81c1@linux-foundation.org>
 <20251229111748.3ba66311@gandalf.local.home>
 <20260103005059.GA11015@joelbox2>
 <aVkSVk2L6VH9MYGz@smile.fi.intel.com>
 <937926D0-00DC-499B-9FD8-D921C903882D@nvidia.com>
 <aVmyZ0iXzTkNU86y@smile.fi.intel.com>
 <20260105113902.6bdfcfa8@gandalf.local.home>
 <aVv8vwtGFhssitxG@smile.fi.intel.com>
 <aVv946dXQfOifz5O@yury>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVv946dXQfOifz5O@yury>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 05, 2026 at 01:07:31PM -0500, Yury Norov wrote:
> On Mon, Jan 05, 2026 at 08:02:39PM +0200, Andy Shevchenko wrote:
> > On Mon, Jan 05, 2026 at 11:39:02AM -0500, Steven Rostedt wrote:

...

> > Yury, I think in v5 you need to drop this patch, otherwise we won't move further.
> 
> Not sure we need v5 because the only change is dropping the last patch
> in the series. But if you prefer - I can send v5.

It depends on who is going to apply them. For me personally v5 is not needed,
but I think there were some tags given in v4? With that it might make some
sense to have a v5.

-- 
With Best Regards,
Andy Shevchenko



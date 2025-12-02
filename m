Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454684594A;
	Tue,  2 Dec 2025 07:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764661050; cv=none; b=Jw4jZhxijzPfdLN2S0Euvmci0xp7x7eSZyL4VHAoKPSSiyyPBd6/pQp2NZqiJOw0R60lsda5pfrB0mSf1W6JBuZS+vTWnKZK25W0ddvj72wCoPCCqzIox1axrQ/XIZCLoXtpcRnqS6PkMEEnbD9SXBv72kaHvUKNgSwYiXxc6Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764661050; c=relaxed/simple;
	bh=dpaBgaXtJH3szD/lMO34UVn3hJPCUmClZoyBvobwS6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asNrHSqFqNMU+RGRIBBszOQqnqTynx7hkYEYlCHrMQRn3ZizLmy3+tcpMfeo2tsGsjsbi6bfhcNuTp2KOnf6ZMylyTg2AjZxWMbCbjwHq5lrly+3i9bs58mJCkmc+gWl664CFZBv2zccOPdqT2b6JaE3hC1xzIEu6s00RwfuCXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VkpOcoR9; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VkpOcoR9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764661048; x=1796197048;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dpaBgaXtJH3szD/lMO34UVn3hJPCUmClZoyBvobwS6s=;
  b=VkpOcoR9mlGzqyZu1tBfmpwr76/HitbPx3Ah1JwnwxKPsbRP4Got8KH0
   Bu0f7GCL9sPTP8ZausYek6oeyVVJNKwvK8qjdBCDT+cY0DAHm/TMt27BB
   WQWNOkJKZABYBosrcsxV0y9wRe8FSt3M9Xiumgz4EKtuvSwp8izMMoxA/
   AGACxoq7DFOmRwQSDWvUt6A6IC3w/RJJA9NMzr+7grXxws//KJKD7sg92
   RdOEh4W64fODIpsYPkdWKvKKS9cdf4dZBTc1OctMpCJtXdXC9A6YadqAJ
   y+2SO2JDVm6OcnwGQrJOpt8UF92QRH6+LUyaEdLWWQygadIRPuWnmtqZ1
   A==;
X-CSE-ConnectionGUID: VVZNBxjLRumoAAAgEujPiw==
X-CSE-MsgGUID: /uZoWBWeREKzaUwhjM1d+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="84219295"
X-IronPort-AV: E=Sophos;i="6.20,242,1758610800"; 
   d="scan'208";a="84219295"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 23:37:27 -0800
X-CSE-ConnectionGUID: 44r/V27uQ+OX+jTsikvq0Q==
X-CSE-MsgGUID: LH6LluTOTwivvfv8Aejv7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,242,1758610800"; 
   d="scan'208";a="198504967"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.91])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 23:37:22 -0800
Date: Tue, 2 Dec 2025 09:37:20 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <aS6XMMeSDyrYMmWE@smile.fi.intel.com>
References: <20251129195304.204082-1-yury.norov@gmail.com>
 <20251129195304.204082-2-yury.norov@gmail.com>
 <3e7ddbea-978f-44f7-abdd-7319908fd83c@kernel.org>
 <aS5T9-1z7PK32q9R@yury>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aS5T9-1z7PK32q9R@yury>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Dec 01, 2025 at 09:50:31PM -0500, Yury Norov wrote:
> On Mon, Dec 01, 2025 at 10:38:01AM +0100, Christophe Leroy (CS GROUP) wrote:
> > Le 29/11/2025 à 20:53, Yury Norov (NVIDIA) a écrit :

...

> You can check commit 4914d770dec4 in this project:
> 
> https://archive.org/details/git-history-of-linux

Side note: we have history/history.git tree on kernel.org, and,
if anyone wants to check, it is handy.

Each of the history tree has its own pros and cons:
https://stackoverflow.com/a/51901211/2511795

-- 
With Best Regards,
Andy Shevchenko



Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145B2748F;
	Sun,  4 Jan 2026 00:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767486068; cv=none; b=TYwpLgkMvKyV+LPjQjNIfQPThVnf8OzrVwsubS5XqlCq1afTqgsejHpOfS53SWxkXALVDsH8zjaP+wgkIIYQhGrQomnj+kr5B257lDuXiBNP1CxPQs4e6glgHKRbjVaWCndDZ2pMKkArtChyXe4XoWv6g7QPnYdNdGxhR/Hbl64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767486068; c=relaxed/simple;
	bh=EZ07LHl/c+KnJFICNJyVpY6174knisfxMAC3WeK1sEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0ok/7+PzyogWW8lR/deYsFhazusFykqHkuQLHlLXjgOUdG9C/EUCpkyvlyLmg1RvNKWAvsZW+AMv9qDF71CgVYvyH7ISRCl5EDPG8/M5A1ApqljJaL6A1OZWnLyAg+wXBX/TyVrJ9CY8kcZls81ZUGkhj4tDL3cO2hSicRvcaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=emW0wBHC; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="emW0wBHC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767486067; x=1799022067;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=EZ07LHl/c+KnJFICNJyVpY6174knisfxMAC3WeK1sEs=;
  b=emW0wBHCWvdQW3PtKUG7X51cR7vjWMUuMCiCdnsI0jqqWvDlCxR7sUlf
   P+t8uwCdVTcUZAUMGWcLHQXn1LbnBgH2hGZXtIPQhYDHv62XYxPEy5y9B
   4Pkxzl1gCK9MI3yLLExgQSk60fHVemA/jYYjgzgv4GVq0tWRi/xN1ufoE
   rfs1SNFygvAiCpxnHBVkGblxAOeiJZ0smCV/MNhs2fDoI8D9ymCgXlbC9
   SxoTzE9MpCFUB2j8EE3zfYpl1R/VLq0AanFKUTMlJ5WTK86IcDO5WCq1k
   BJBSeS16pkhcaDs7WJp1qYr3QONGL0Y6I+DDHlrV7R7KvBV52W8RgHxL5
   A==;
X-CSE-ConnectionGUID: /wtEvrpgQeu9n0IcaY5TaQ==
X-CSE-MsgGUID: lmXjVk1zT/20tPqYs6yuVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11659"; a="68893373"
X-IronPort-AV: E=Sophos;i="6.21,200,1763452800"; 
   d="scan'208";a="68893373"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2026 16:21:03 -0800
X-CSE-ConnectionGUID: er8J3jTxQTKaWgFpHOj7dA==
X-CSE-MsgGUID: znKggkO8RgWK0+QLdUyaaQ==
X-ExtLoop1: 1
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.75])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2026 16:20:58 -0800
Date: Sun, 4 Jan 2026 02:20:55 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
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
Message-ID: <aVmyZ0iXzTkNU86y@smile.fi.intel.com>
References: <20251225170930.1151781-1-yury.norov@gmail.com>
 <20251225170930.1151781-8-yury.norov@gmail.com>
 <20251226115848.298465d4@gandalf.local.home>
 <20251228133150.1d5731d04bc1b685b0fe81c1@linux-foundation.org>
 <20251229111748.3ba66311@gandalf.local.home>
 <20260103005059.GA11015@joelbox2>
 <aVkSVk2L6VH9MYGz@smile.fi.intel.com>
 <937926D0-00DC-499B-9FD8-D921C903882D@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <937926D0-00DC-499B-9FD8-D921C903882D@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jan 03, 2026 at 03:36:44PM +0000, Joel Fernandes wrote:
> > On Jan 3, 2026, at 7:58 AM, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Jan 02, 2026 at 07:50:59PM -0500, Joel Fernandes wrote:
> >> On Mon, Dec 29, 2025 at 11:17:48AM -0500, Steven Rostedt wrote:

...

> >> I use trace_printk() all the time for kernel, particularly RCU development.
> >> One of the key usecases I have is dumping traces on panic (with panic on warn
> >> and stop tracing on warn enabled). This is extremely useful since I can add
> >> custom tracing and dump traces when rare conditions occur. I fixed several
> >> bugs with this technique.
> >> 
> >> I also recommend keeping it convenient to use.
> > 
> > Okay, you know C, please share your opinion what header is the best to hold the
> > trace_printk.h to be included.
> 
> I do not think it is necessary to move it.

I'm not talking about move, I'm talking about the C 101 thingy. Any custom API
should be included before use, otherwise compiler won't see it. Which header do
you want to include to have this API being provided? Note, it's really bad
situation right now with the header to be included implicitly via non-obvious
or obscure path. The discussion moved as far as I see it towards the finding a
good place for the trace_printk.h.

-- 
With Best Regards,
Andy Shevchenko



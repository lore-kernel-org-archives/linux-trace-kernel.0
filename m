Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4402C237E;
	Thu, 18 Jun 2026 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781782269; cv=none; b=MNfzfNq90LQ2QZWWn+nTn7DnetrN3zJ66543N56NXBDnqBc+qeANS0hkm2OUai3ZuBNap2oSWi29zansSyQO7aiGICHceSVXF4yIjBKWW01YcWCfSyKnaqj6ZFX5/RsCL5cmWEHUzm1ko3caMP+DTj8UXXgWOJucbDexYu3WsnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781782269; c=relaxed/simple;
	bh=exqW6jqn0JFmQgPZsiczt4WrBH7hyT3D7XC8zd1c2LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhHgkaX1KB62c+4ZAZGzNftk/L58iuoP/QuXkt2R2qUbVV48Wf4wiVqoy0aN1gr5zNNRiJMu8levd+Jky7Nh1qNcMiqaPWe4D43mzRGtpeR6fJWlU4k7XpxTACA2dIUDPSdyvPet7w7I84XAxG57tXYcP8PW65OdW/efnid+Pmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m8K4CEpo; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m8K4CEpo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781782266; x=1813318266;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=exqW6jqn0JFmQgPZsiczt4WrBH7hyT3D7XC8zd1c2LA=;
  b=m8K4CEpo5Wg0ec9dMbQTRmbLJqSKlUGmVdyaHn00ol53riXxgS2gLkZ5
   Vx1/J314WH12Umcx2JStYAJpIqQ7QJ+x5kiu+Fq34FANJBYh3p+mfQBop
   WiarkdRFjEaIQXEnI0RX15IGM6SBLVX2XttfOUSyPdHS+4xVGwRHustQY
   RYngW8FoA0ZRzYHnr+TFfz0SRfoa3aIThgcOq5sQAtcvyMgruHS2+dq73
   QiMqc6WFh37pzfIAC4sP7LxdWG/A02Pswh1PsKxXzkPbblUJsWi+Wrpci
   FvMkKpjdGmwNw6qKyIqWgwhvtiFfDAk7b8Lawp0bpHy0P2ha/9QiN54yr
   g==;
X-CSE-ConnectionGUID: CbFbPC+JQWmeRfrh3eABvQ==
X-CSE-MsgGUID: C3kc30nKTGGRF99xdKsSeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="93213674"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="93213674"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 04:31:05 -0700
X-CSE-ConnectionGUID: ZJHAHjVIRnydtgjxYzVMXA==
X-CSE-MsgGUID: yYbXqfKiQd6Y23gLQtzbzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="247196307"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 18 Jun 2026 04:31:03 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 841A298; Thu, 18 Jun 2026 13:31:01 +0200 (CEST)
Date: Thu, 18 Jun 2026 14:31:00 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] usb: typec: add trace point for typec_set_mode
Message-ID: <ajPW9P6qZyhqtjvp@kuha>
References: <20260617-typec_set_mode-tracepoint-v1-1-bdfbb39cfccd@pengutronix.de>
 <ajPO6roV4HRZYGNd@kuha>
 <43e13854-a634-4706-bc12-723c871a5579@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43e13854-a634-4706-bc12-723c871a5579@pengutronix.de>

Hi,

On Thu, Jun 18, 2026 at 01:00:58PM +0200, Ahmad Fatoum wrote:
> Hello Heikki,
> 
> On 6/18/26 12:56 PM, Heikki Krogerus wrote:
> > On Wed, Jun 17, 2026 at 10:03:04PM +0200, Ahmad Fatoum wrote:
> >> --- a/drivers/usb/typec/class.c
> >> +++ b/drivers/usb/typec/class.c
> >> @@ -20,6 +20,9 @@
> >>  #include "class.h"
> >>  #include "pd.h"
> >>  
> >> +#define CREATE_TRACE_POINTS
> >> +#include <trace/events/typec.h>
> > 
> > Those should probable go to drivers/usb/typec/trace.c and then you
> > need add something like this to drivers/usb/typec/Makefile:
> > 
> >  obj-$(CONFIG_TYPEC)            += typec.o
> >  typec-y                                := class.o mux.o bus.o pd.o retimer.o mode_selection.o
> >  typec-$(CONFIG_ACPI)           += port-mapper.o
> > +typec-$(CONFIG_TRACING)                += trace.o
> 
> Thanks for the suggestion. I will do that for v2.
> 
> I also saw there is Sashiko AI feedback on this patch[1], but I am not
> familiar enough with how the event headers are used outside the kernel
> to determine if that's actionable advice or if it can be ignored.
> 
> Do you have an opinion on that?
> 
> [1]:
> https://sashiko.dev/#/patchset/20260617-typec_set_mode-tracepoint-v1-1-bdfbb39cfccd%40pengutronix.de

It's correct. You need to use a private trace.h in this case, so just
move it here: drivers/usb/typec/trace.h

And also make sure you include everything needed in that header like
it's telling you.

Thanks,

-- 
heikki

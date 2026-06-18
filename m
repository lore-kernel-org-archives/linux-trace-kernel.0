Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446533EFFA6;
	Thu, 18 Jun 2026 10:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781780212; cv=none; b=scIZ8bGkGbaaEBhgJou+fuvnTt5S8G9a6kQAxHO3ZbTmAKgPPu2HlworD+4efh0Me/RwN5A2aiw+VaWCYtWZk7KLhb09gqfQ1yl6grx/fLuPFf7+pvJtcxX7cJMstWpwZinfWkierkiC4EVu1MjVDYXXuEQ1FnLyEdR8S669rr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781780212; c=relaxed/simple;
	bh=fsQYycVBnqb9n34Pt2t06JT/O+eXxaMrTWpTT6VYuZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btGrqCMSs2nVdU2pBTD0/RlBIyS4nM6xfFFx99o42cgpEjdTeYKd0vc8yvtoKQHJq0vcwURfnZvzsxLraJD/xD2zl8+ETq5pjUBsxqTouvDiqkxY8C5RJbrDVn7o8rmOlNE6xdTY5tDSXDUAd2e7O741XbxDK9KonE0jYX6E5Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UzE195kQ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UzE195kQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781780209; x=1813316209;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fsQYycVBnqb9n34Pt2t06JT/O+eXxaMrTWpTT6VYuZE=;
  b=UzE195kQE6GqpPi9u33hKY3NgfOIdgE+V9poq937QovP6F9TDvGqqAH4
   0LMMg8sNourNK+A95Wul5jwyH5tdvG7tUn0wjzWcd5lalqXaP86MJ9Aly
   E8C8y7eRZvEukRmI5gD9JUFPuMcJdgFwGu7H1OoXVlKyP8WJ5LpFdBf92
   S4ScjPH09XygTSv77eZXi1TuJuEpAs8unvTRkKNW0ioeHwv7b7sRyGyhy
   mS1jJNC9Bos8+xm4U0hQj3UpQgS+h6b42WbQskScC0mVO7XKhFQCdTugY
   OxwEhS8SOthIEx8jQkiceuu/F56MRBSkzzrCfHSg+LrghcfwAV2ZrIdbt
   Q==;
X-CSE-ConnectionGUID: ffSgM2IlTlCHxKfDWDHLdQ==
X-CSE-MsgGUID: O+gUHiA9QxuVSBu8aymlOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="92948531"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="92948531"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 03:56:47 -0700
X-CSE-ConnectionGUID: bKeu51ycQH2Sjlhr9qejKA==
X-CSE-MsgGUID: MZPV6/pfTFWl6pz6ePmTDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="278514150"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 18 Jun 2026 03:56:45 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 4E86A98; Thu, 18 Jun 2026 12:56:44 +0200 (CEST)
Date: Thu, 18 Jun 2026 13:56:42 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] usb: typec: add trace point for typec_set_mode
Message-ID: <ajPO6roV4HRZYGNd@kuha>
References: <20260617-typec_set_mode-tracepoint-v1-1-bdfbb39cfccd@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617-typec_set_mode-tracepoint-v1-1-bdfbb39cfccd@pengutronix.de>

Hi Ahmad,

On Wed, Jun 17, 2026 at 10:03:04PM +0200, Ahmad Fatoum wrote:
> Some Type-C controllers toggle muxes themselves. Other controllers like
> the TUSB320 report the mode to the host, so it can control the muxes.
> 
> To improve debuggability of both kinds of drivers, add a trace point that
> can be used to keep track of the mode being set inside the Type-C
> framework:
> 
>   echo 1 > /sys/kernel/debug/tracing/events/typec/typec_mode/enable
> 
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
>  MAINTAINERS                  |  1 +
>  drivers/usb/typec/class.c    |  9 ++++++++-
>  include/trace/events/typec.h | 36 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c8d4b913f26c..ddd59e5e6eaf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27753,6 +27753,7 @@ F:	Documentation/ABI/testing/sysfs-class-typec
>  F:	Documentation/driver-api/usb/typec.rst
>  F:	drivers/usb/typec/
>  F:	include/linux/usb/typec.h
> +F:	include/trace/events/typec*.h
>  
>  USB TYPEC INTEL PMC MUX DRIVER
>  M:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 0977581ad1b6..9316d067f19a 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -20,6 +20,9 @@
>  #include "class.h"
>  #include "pd.h"
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/typec.h>

Those should probable go to drivers/usb/typec/trace.c and then you
need add something like this to drivers/usb/typec/Makefile:

 obj-$(CONFIG_TYPEC)            += typec.o
 typec-y                                := class.o mux.o bus.o pd.o retimer.o mode_selection.o
 typec-$(CONFIG_ACPI)           += port-mapper.o
+typec-$(CONFIG_TRACING)                += trace.o
 obj-$(CONFIG_TYPEC)            += altmodes/
 obj-$(CONFIG_TYPEC_TCPM)       += tcpm/
 obj-$(CONFIG_TYPEC_UCSI)       += ucsi/


Thanks,

-- 
heikki

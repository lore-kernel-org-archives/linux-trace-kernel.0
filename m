Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F4E19F130;
	Mon, 30 Jun 2025 20:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751313876; cv=none; b=YxOzU30QnYvLnWyURFvMPVg77cHnKmCR8FRx/ArQgHIr6mWz2nu58b2oiBlyXEiNucHzQs5dBMi7zZUCvh14aJSeGXC3DDLjc3IBLkf01VNxpJn17wVXj1cxypOBohb3gqG1O7wF1le36gr2j4yMfRkGMJAUA2lnaZVtZWz7MlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751313876; c=relaxed/simple;
	bh=xa33IS3UQEmZahHF2MYWQY7MF+mLgkuwCbErVfLDTQc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oGrblCAbayeyDn6nWRV7OGQXl3i9yfm4NphEXsKcpWxSR4ada06eTASSZLa/P/gtTMwvrc2YIFB9UQp25nRhgGLEBW3dZbOLDX4L8NgIFXO3h0kudZ8NxfviRAkfT24SYSC1Re6xkzj2x77R18lASViUfkOcEh5qFCKf5GIyFkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id C6F941CE072;
	Mon, 30 Jun 2025 20:04:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 1767D2002A;
	Mon, 30 Jun 2025 20:04:30 +0000 (UTC)
Date: Mon, 30 Jun 2025 16:04:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 john.ogness@linutronix.de
Subject: Re: [PATCH v10 14/19] rv: Add rtapp container monitor
Message-ID: <20250630160430.20dc6dc0@batman.local.home>
In-Reply-To: <96c2766a74a730fe54a9339feb5b93128ee65331.1749547399.git.namcao@linutronix.de>
References: <cover.1749547399.git.namcao@linutronix.de>
	<96c2766a74a730fe54a9339feb5b93128ee65331.1749547399.git.namcao@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: sxe4a575kkax86zy59qqnxzsmdx9t4bh
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 1767D2002A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/wGyjdvw7eluh7v4AyJGIhzwgw8kngfYA=
X-HE-Tag: 1751313870-811461
X-HE-Meta: U2FsdGVkX1/vvktjvdUTAaTsA5kmwXx66Pm+Iey61FGh2Fh1sK0ed8u073P/v4wc8kfZj3vYfnBrHN3uwTSmO61/fwH46AxYLFw48aWurMk8CQzBTLyTpMdYXzcAS4xNQocRndeyTWiBgBMnZ0NE0U6aCkt25oE94M7qls8/0+mr8RIrJba6jsoEMlUoy56q7ThsBnpxbZ8FUCGF0FJ8KZK2gCWhMWKfAtXyzh1aIoEYk4lGXodcFfcBvHgif5Bd88bWLmGLvCwVobXPgsEXwj66ND8FGPJ3vBBS1gZSle7QsIn/RpCKLT6Di/Lja47Gjvo7U84xkvgoCMGPD/BW0R0F7DYTtiyaElDyiDX7Flhdzb02BFP783fa3+TIRLZU

On Tue, 10 Jun 2025 11:43:39 +0200
Nam Cao <namcao@linutronix.de> wrote:

> Add the container "rtapp" which is the monitor collection for detecting
> problems with real-time applications. The monitors will be added in the
> follow-up commits.
> 
> Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  kernel/trace/rv/Kconfig                |  1 +
>  kernel/trace/rv/Makefile               |  1 +
>  kernel/trace/rv/monitors/rtapp/Kconfig | 14 +++++++++++
>  kernel/trace/rv/monitors/rtapp/rtapp.c | 33 ++++++++++++++++++++++++++
>  kernel/trace/rv/monitors/rtapp/rtapp.h |  3 +++
>  5 files changed, 52 insertions(+)
>  create mode 100644 kernel/trace/rv/monitors/rtapp/Kconfig
>  create mode 100644 kernel/trace/rv/monitors/rtapp/rtapp.c
>  create mode 100644 kernel/trace/rv/monitors/rtapp/rtapp.h
> 
> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index 6e157f9649915..5c407d2916614 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -41,6 +41,7 @@ source "kernel/trace/rv/monitors/snroc/Kconfig"
>  source "kernel/trace/rv/monitors/scpd/Kconfig"
>  source "kernel/trace/rv/monitors/snep/Kconfig"
>  source "kernel/trace/rv/monitors/sncid/Kconfig"
> +source "kernel/trace/rv/monitors/rtapp/Kconfig"
>  # Add new monitors here
>  
>  config RV_REACTORS
> diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
> index f9b2cd0483c3c..9b28c24199955 100644
> --- a/kernel/trace/rv/Makefile
> +++ b/kernel/trace/rv/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_RV_MON_SNROC) += monitors/snroc/snroc.o
>  obj-$(CONFIG_RV_MON_SCPD) += monitors/scpd/scpd.o
>  obj-$(CONFIG_RV_MON_SNEP) += monitors/snep/snep.o
>  obj-$(CONFIG_RV_MON_SNCID) += monitors/sncid/sncid.o
> +obj-$(CONFIG_RV_MON_RTAPP) += monitors/rtapp/rtapp.o
>  # Add new monitors here
>  obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
>  obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
> diff --git a/kernel/trace/rv/monitors/rtapp/Kconfig b/kernel/trace/rv/monitors/rtapp/Kconfig
> new file mode 100644
> index 0000000000000..658bb78e733a0
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/rtapp/Kconfig
> @@ -0,0 +1,14 @@
> +config RV_MON_RTAPP
> +	depends on RV
> +	bool "rtapp monitor"
> +	help
> +	  Collection of monitors to check for common problems with real-time
> +	  application that may cause unexpected latency.
> +
> +	  If you are developing a real-time system and not entirely sure whether
> +	  the applications are designed correctly for real-time, you want to say
> +	  Y here.
> +
> +	  Beware that enabling this may have impact on performance, even if the
> +	  monitors are not running. Therefore you probably should say N for
> +	  production kernel.

I'm trying to figure out from the patch how exactly does this cause
performance issues?

Can you elaborate?

Thanks,

-- Steve


> diff --git a/kernel/trace/rv/monitors/rtapp/rtapp.c b/kernel/trace/rv/monitors/rtapp/rtapp.c
> new file mode 100644
> index 0000000000000..fd75fc927d654
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/rtapp/rtapp.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/rv.h>
> +
> +#define MODULE_NAME "rtapp"
> +
> +#include "rtapp.h"
> +
> +struct rv_monitor rv_rtapp;
> +
> +struct rv_monitor rv_rtapp = {
> +	.name = "rtapp",
> +	.description = "Collection of monitors for detecting problems with real-time applications",
> +};
> +
> +static int __init register_rtapp(void)
> +{
> +	return rv_register_monitor(&rv_rtapp, NULL);
> +}
> +
> +static void __exit unregister_rtapp(void)
> +{
> +	rv_unregister_monitor(&rv_rtapp);
> +}
> +
> +module_init(register_rtapp);
> +module_exit(unregister_rtapp);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Nam Cao <namcao@linutronix.de>");
> +MODULE_DESCRIPTION("Collection of monitors for detecting problems with real-time applications");
> diff --git a/kernel/trace/rv/monitors/rtapp/rtapp.h b/kernel/trace/rv/monitors/rtapp/rtapp.h
> new file mode 100644
> index 0000000000000..4c200d67c7f67
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/rtapp/rtapp.h
> @@ -0,0 +1,3 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +extern struct rv_monitor rv_rtapp;


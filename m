Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6981D63E8;
	Mon, 21 Jul 2025 22:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753137355; cv=none; b=Bp840b1cJ1QB5GYxon2jZLqPaJ70pDw8ZOftl2JVnres+KY5HulzVCOlpFGVIyUvMebp0SXmkoYHHeZ5X3hkQOhnZUYlro5iBzRdHlN5qSI0HzSDJCkbgKdRVsvrf+mYBxrkSgileYieV+0JYLhInPRPo7+4d4g7QtrY/qYUZDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753137355; c=relaxed/simple;
	bh=6648v/1Gw/kzJwAyWAbIYIgYzO4iGVzHLbGFVu2xgek=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OvGeIo2W9pDUjZDAnOqwm2VIk5MCU4tS+MzpFkWE4LWQuw2OQIjommcYUfMQX3nHQGara6oDcn+KNYc0f439RX1qexyItJptWA9/I2TGCB/76G2f2m/swxji6cilT7NWsjJMzScY0Jl/qPZZx8u1oMA4QYcrNUZCRGTBrVdXYZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxg2yGNG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxg2yGNG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7EAC4CEED;
	Mon, 21 Jul 2025 22:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753137353;
	bh=6648v/1Gw/kzJwAyWAbIYIgYzO4iGVzHLbGFVu2xgek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rxg2yGNGpHoMaM8RL5JterMHHm4lUbbgo5dCQMkYNQjAXmR+dFFtVSKpGLO6EexjZ
	 uKE4WLzhcpG/ZuJ3IyK3YpZxV/urT35EYxLMFQuPT1umglRDg3lomha8A6T5Zhrs+e
	 rBry0HvlZ3NMVM0aSXRHz1WBM2y5l7tBg3liU/pcn9gR/siyE1+0KxtdAmKtFxtcTK
	 jblmT7fQDMxFr+5qGoI38U3BQArdOS0kCrz9eejucoeuRPIirqSVWWkwUV2dEx1UiM
	 RlC/iWT/jlJPMOcS3MnXQC4iUvJKRJrXZTIjow8P8Xi2wAsSloSd/g48NhQXGXc0E5
	 G3Hwc2oQmxVYg==
Date: Tue, 22 Jul 2025 07:35:50 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] tracing: probe: Allocate
 traceprobe_parse_context from heap
Message-Id: <20250722073550.0afaabe8dd1a0aa4800e5f2c@kernel.org>
In-Reply-To: <20250721131907.436c0671@batman.local.home>
References: <175299249728.418723.17799706394466693180.stgit@devnote2>
	<175299250735.418723.6298873768702875564.stgit@devnote2>
	<20250721131907.436c0671@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Jul 2025 13:19:07 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun, 20 Jul 2025 15:21:47 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> >  
> > +#include <linux/bitops.h>
> > +#include <linux/btf.h>
> > +#include <linux/cleanup.h>
> > +#include <linux/kprobes.h>
> > +#include <linux/limits.h>
> > +#include <linux/perf_event.h>
> > +#include <linux/ptrace.h>
> >  #include <linux/seq_file.h>
> >  #include <linux/slab.h>
> >  #include <linux/smp.h>
> > -#include <linux/tracefs.h>
> > -#include <linux/types.h>
> >  #include <linux/string.h>
> > -#include <linux/ptrace.h>
> > -#include <linux/perf_event.h>
> > -#include <linux/kprobes.h>
> >  #include <linux/stringify.h>
> > -#include <linux/limits.h>
> > +#include <linux/tracefs.h>
> > +#include <linux/types.h>
> >  #include <linux/uaccess.h>
> > -#include <linux/bitops.h>
> > -#include <linux/btf.h>
> > +
> 
> A re-sort should be a separate patch, as I can't tell what changed in
> the header for this patch.

OK, let me make it a separate patch.

Thanks!

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

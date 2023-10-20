Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5E41D538;
	Fri, 20 Oct 2023 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056B9C433C7;
	Fri, 20 Oct 2023 16:28:36 +0000 (UTC)
Date: Fri, 20 Oct 2023 12:28:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: Krishna chaitanya chundru <quic_krichai@quicinc.com>, "Manivannan
 Sadhasivam" <mani@kernel.org>, "Masami Hiramatsu" <mhiramat@kernel.org>,
 <linux-kernel@vger.kernel.org>, <mhi@lists.linux.dev>,
 <linux-arm-msm@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
 <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
 <quic_parass@quicinc.com>
Subject: Re: [PATCH v2] bus: mhi: host: Add tracing support
Message-ID: <20231020122833.647bbc49@gandalf.local.home>
In-Reply-To: <9216f694-cce0-2b95-df34-e5b60538644a@quicinc.com>
References: <20231013-ftrace_support-v2-1-6e893ce010b5@quicinc.com>
	<9216f694-cce0-2b95-df34-e5b60538644a@quicinc.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Oct 2023 09:03:59 -0600
Jeffrey Hugo <quic_jhugo@quicinc.com> wrote:

> > diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> > index f78aefd2d7a3..3afa90a204fd 100644
> > --- a/drivers/bus/mhi/host/init.c
> > +++ b/drivers/bus/mhi/host/init.c
> > @@ -20,6 +20,9 @@
> >   #include <linux/wait.h>
> >   #include "internal.h"
> >   
> > +#define CREATE_TRACE_POINTS
> > +#include <trace/events/mhi_host.h>  
> 
> This feels redundant to me.  A few lines ago we included internal.h, and 
> internal.h includes trace/events/mhi_host.h

It's not redundant. The #define CREATE_TRACE_POINTS enables the magic of
creating the tracepoints and trace events via the TRACE_EVENT() macro.

It should never be done in a header file, only in .c code!

The header file include of trace headers are used for having access to the
declarations of the functions. That is (trace_*()) in the code.

-- Steve

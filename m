Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2321864
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:37:13 +0000 (UTC)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CF11B0;
	Fri, 29 Sep 2023 04:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ootNujH4iGHwjSkyEVNQmJn1cqLN7lBrvMBiPY4LClA=;
  b=WVxXRnm46UgzPhPsYsnCbPrqvO/i7hGnOMaCmAEUNx+TNrWcr7nWTTg+
   dLmjpBTQgnxsxgLdkyybU7BKycZQa5YLvnVaEh4cP5YmtTxNssMigzTO0
   xH6UXr1UipC3XbBdQy8lNA0mtC2wfI0+O+tarbjHgKByZH7DrBGEpKgYB
   c=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,187,1694728800"; 
   d="scan'208";a="67334250"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 13:37:09 +0200
Date: Fri, 29 Sep 2023 13:37:08 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Masami Hiramatsu <mhiramat@kernel.org>
cc: Steven Rostedt <rostedt@goodmis.org>, kernel-janitors@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/eprobe: drop unneeded breaks
In-Reply-To: <20230929203259.74d4ba263b3455172ef37f06@kernel.org>
Message-ID: <alpine.DEB.2.22.394.2309291336260.3137@hadrien>
References: <20230928104334.41215-1-Julia.Lawall@inria.fr> <20230929203259.74d4ba263b3455172ef37f06@kernel.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On Fri, 29 Sep 2023, Masami Hiramatsu  wrote:

> On Thu, 28 Sep 2023 12:43:34 +0200
> Julia Lawall <Julia.Lawall@inria.fr> wrote:
>
> > Drop break after return.
> >
>
> Good catch! This looks good to me.
>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> And
>
> Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")

Thanks.  I didn't include that because it's not a bug.  But it does break
Coccinelle, which is how I noticed it.

julia

>
> > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> >
> > ---
> >  kernel/trace/trace_eprobe.c |    5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> > index 72714cbf475c..03c851f57969 100644
> > --- a/kernel/trace/trace_eprobe.c
> > +++ b/kernel/trace/trace_eprobe.c
> > @@ -788,12 +788,9 @@ find_and_get_event(const char *system, const char *event_name)
> >  		name = trace_event_name(tp_event);
> >  		if (!name || strcmp(event_name, name))
> >  			continue;
> > -		if (!trace_event_try_get_ref(tp_event)) {
> > +		if (!trace_event_try_get_ref(tp_event))
> >  			return NULL;
> > -			break;
> > -		}
> >  		return tp_event;
> > -		break;
> >  	}
> >  	return NULL;
> >  }
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>

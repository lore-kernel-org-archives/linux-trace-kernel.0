Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CABA41;
	Fri,  9 Aug 2024 17:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723225292; cv=none; b=kaKE/Xq+eG3DGBQU1vteW0TU2+wTEJKEIn5kQ9Sh4Hy8M8JTbGE6GOKybpwrRgNEaOFToUafhI65Y6znYmanffMvo7XaIiyWCmsMMaq9F+iGUa8O5KAQoBrBpriglBlFNGvNo95vjyBXco19UnUVjjdbaQW7FVUpUI2GIZsslpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723225292; c=relaxed/simple;
	bh=K8+dk9K7iJjeQQsItBQdAdMS1Bs5PSg3zHcAZ+TFio4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lzuIz7rv8wR0D0TmnffodyQQV2wYXjyOh915VlQH13VrGw16HVYCQQFueqL/UqR3tORZ77uaDDO+R2Z9DQrE4+Mwcrgk+Rk3VAohenwErthEawXEHsFPdyYr/3JLh3GKah8Gpkh2VWIwRKWqu2eql7Xtcxt+vLgJVi3wzQtDaic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49DF8C32782;
	Fri,  9 Aug 2024 17:41:31 +0000 (UTC)
Date: Fri, 9 Aug 2024 13:41:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: John Kacur <jkacur@redhat.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Daniel Bristot de Oliveira
 <bristot@kernel.org>, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Clark Williams <williams@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] rtla/osnoise: prevent NULL dereference in error
 handling
Message-ID: <20240809134133.751723e5@gandalf.local.home>
In-Reply-To: <c73c51ae-99da-793a-6dcb-2fbc6871261d@redhat.com>
References: <f964ed1f-64d2-4fde-ad3e-708331f8f358@stanley.mountain>
	<c73c51ae-99da-793a-6dcb-2fbc6871261d@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Aug 2024 13:34:28 -0400 (EDT)
John Kacur <jkacur@redhat.com> wrote:

> On Fri, 9 Aug 2024, Dan Carpenter wrote:
> 
> > If the "tool->data" allocation fails then there is no need to call
> > osnoise_free_top() and, in fact, doing so will lead to a NULL dereference.
> > 
> > Fixes: 1eceb2fc2ca5 ("rtla/osnoise: Add osnoise top mode")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  tools/tracing/rtla/src/osnoise_top.c | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
> > index f594a44df840..2f756628613d 100644
> > --- a/tools/tracing/rtla/src/osnoise_top.c
> > +++ b/tools/tracing/rtla/src/osnoise_top.c
> > @@ -651,8 +651,10 @@ struct osnoise_tool *osnoise_init_top(struct osnoise_top_params *params)
> >  		return NULL;
> >  
> >  	tool->data = osnoise_alloc_top(nr_cpus);
> > -	if (!tool->data)
> > -		goto out_err;
> > +	if (!tool->data) {
> > +		osnoise_destroy_tool(tool);
> > +		return NULL;
> > +	}
> >  
> >  	tool->params = params;
> >  
> > @@ -660,11 +662,6 @@ struct osnoise_tool *osnoise_init_top(struct osnoise_top_params *params)
> >  				   osnoise_top_handler, NULL);
> >  
> >  	return tool;
> > -
> > -out_err:
> > -	osnoise_free_top(tool->data);
> > -	osnoise_destroy_tool(tool);
> > -	return NULL;
> >  }
> >  
> >  static int stop_tracing;
> > --   
> 
> Although your fix appears to be correct, I wonder if it would be better to 
> create a second error label, such as out_destroy_tool: as described in 
> section 7 of the coding-style.rst
> 

There's no reason for that. It's the only error path. That is, nothing
would jump to the original out_err:

And for a single error, an if statement is good enough.

-- Steve

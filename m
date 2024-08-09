Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD9F23DE;
	Fri,  9 Aug 2024 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723226744; cv=none; b=GhtZbj0vp+JbQ3SPZooTj9u2QG2/sQYFBUVLVaI4wjnDblAZ0xMXKic65V29/oYO4gUH6KyN6GxQr6fGR49rkv9aXbTFsNrxc8czgsbKbJaeoH/Vb1ilPoLC6Ea9WmqoFwxw9PvzZ02A3DHwo3IGHy/lw2Ic5TTrKvPiUtb6JUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723226744; c=relaxed/simple;
	bh=rFwRMeqH0yhoQipGZ53eFLQUu6WdxoIJnw+e3aTlPos=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oe0L2BosNSppqVrx3K5TV0cZXyNo5VICjeDXeVRVuszj7k0Lkf1Z3FMnBuzclza3MBTIjfF6RrQBAD2MzB3KEQc7nAoRio2muRm8U8HP2W5cmEQMIQJAcxB2NzPNqRXflN85/oJvOEU9SaICGkc+a2dgemA7d7Mx7P3My+8nmIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2074DC32782;
	Fri,  9 Aug 2024 18:05:43 +0000 (UTC)
Date: Fri, 9 Aug 2024 14:05:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: John Kacur <jkacur@redhat.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Daniel Bristot de Oliveira
 <bristot@kernel.org>, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Clark Williams <williams@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] rtla/osnoise: prevent NULL dereference in error
 handling
Message-ID: <20240809140545.698f654e@gandalf.local.home>
In-Reply-To: <7ece353a-36a6-6154-97d9-b255728b9807@redhat.com>
References: <f964ed1f-64d2-4fde-ad3e-708331f8f358@stanley.mountain>
	<c73c51ae-99da-793a-6dcb-2fbc6871261d@redhat.com>
	<20240809134133.751723e5@gandalf.local.home>
	<7ece353a-36a6-6154-97d9-b255728b9807@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Aug 2024 13:53:33 -0400 (EDT)
John Kacur <jkacur@redhat.com> wrote:


> > > Although your fix appears to be correct, I wonder if it would be better to 
> > > create a second error label, such as out_destroy_tool: as described in 
> > > section 7 of the coding-style.rst
> > >   
> > 
> > There's no reason for that. It's the only error path. That is, nothing
> > would jump to the original out_err:
> > 
> > And for a single error, an if statement is good enough.
> > 
> > -- Steve
> > 
> >   
> 
> Ah, right of course.
> Okay in that case, Signed-off-by: John Kacur <jkacur@redhat.com>
> (applied the patch, built and ran)

Note, "Signed-off-by" is for the author of a patch or someone pushing it
through their tree. I believe you want either "Acked-by" or "Reviewed-by",
and since you ran it you could also add "Tested-by".

-- Steve

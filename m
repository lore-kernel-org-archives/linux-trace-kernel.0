Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847BB19B3CB;
	Thu, 10 Oct 2024 19:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728590068; cv=none; b=surGdjtxLfrXWJdE79c/KCHL4hQcD/tKyBCERkeygPca2x6aX9WsiEBzyqd3tTzYz8jBdFZE6XG49iN5TkuAjbTzElyJ64uPB+KNhYc89LgeL9JdcU8MU/UIpJq+i1DxKoWvXH5jQf7rhBlzDLhxm9crZ+vNx9Bx7bfNSWTq62g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728590068; c=relaxed/simple;
	bh=Mp+NSHuQ3PaW2Ut+1wNtbzV8zGtQDEkTebMOTQDXOrI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YIfo7mtM1N2jbzaSO7iuFNmV5qYVNyCc3UhHtU9ei8N4A9dwF+zUI6ZACJ+rGz4H4pOREq9Nln/PJw8Yr/GSyEIMjUr/IY/FAOmr1TM5yx9rWt9j0WYmCmGFuDz6EgeBV4MbJpXWOlWZAR1gflp2IyRoYXOUKJQ2w8/AFdcmp6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=KV/XNnqj; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="KV/XNnqj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jXk5N6BqpmRr9oTzuzv1AOIztPQsWeFIkvJ+kq0iaUg=;
  b=KV/XNnqjtAF1i6hGzxFDIkPwYbo4ovPr+cUw9ioiS3K76Nby/N9JQVSx
   4o2MoGyw9dOxzUaBtp9l/9n0iV/b+D5j7LZNaZdi84MUi4JgOs++hfR8W
   4UmTuUYj3M+eyZunWOULYd6kYjBFRZ4/jlERfZBQWTDYf7xRMgj90lsdf
   M=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,194,1725314400"; 
   d="scan'208";a="98793900"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 21:54:15 +0200
Date: Thu, 10 Oct 2024 21:54:14 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Steven Rostedt <rostedt@goodmis.org>
cc: kernel-janitors@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
    linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 21/35] ring-buffer: Reorganize kerneldoc parameter
 names
In-Reply-To: <20241010153653.1809bca9@gandalf.local.home>
Message-ID: <alpine.DEB.2.22.394.2410102153540.3363@hadrien>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr> <20240930112121.95324-22-Julia.Lawall@inria.fr> <20240930111431.258b72d1@gandalf.local.home> <20241010153653.1809bca9@gandalf.local.home>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 10 Oct 2024, Steven Rostedt wrote:

> On Mon, 30 Sep 2024 11:14:31 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > On Mon, 30 Sep 2024 13:21:07 +0200
> > Julia Lawall <Julia.Lawall@inria.fr> wrote:
> >
> > > Reorganize kerneldoc parameter names to match the parameter
> > > order in the function header.
> > >
> > > Problems identified using Coccinelle.
> > >
> > > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> >
> > Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>
> This is part of a series, but do you want me to take it through my tree, or
> is this going though another tree?

Please take it.  Thanks.

julia

>
> -- Steve
>

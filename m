Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8194F8C07;
	Thu,  3 Oct 2024 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727964158; cv=none; b=Jq3f43ioU7QMiS+/hMiDfVeY+SeJREip3jz+IIbH2JwHpQ+v62YaZmdDtZoT/zcNe5OQWTTwZGTu5I/BSM92PK2C0QDpKRQpgKTYLOmZWH2SlDyV2YYMXDpQ/yZOgtwr/2H5OJcePbw3uUAnXl5VrUJJHDsoBDYTcMvRSb/nfP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727964158; c=relaxed/simple;
	bh=cYVz7f2E3iwB9QO0NypQD+6gIne4uPyn0hF5MYflNXI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=co4K46UfX56BQ30XisfgWyTYothnTOMa2fEmSr7mklxuTWf4tjWKaXbLszsoxXjSLfsk9+9qJF/ajch4PNZ2ai1IVCciK5Ud7wwYN+DyOXtBHmrJ8cwyxzncG7xs698PnuV5s3bkHYkyfgXaY1KVX6IyQ8peXK9XDsl5lIwlTJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EABEC4CEC5;
	Thu,  3 Oct 2024 14:02:37 +0000 (UTC)
Date: Thu, 3 Oct 2024 10:03:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
 linux-cxl@vger.kernel.org
Subject: Re: RIP: 0010:trace_check_vprintf 6.12-rc1 & CXL test
Message-ID: <20241003100330.63538bcd@gandalf.local.home>
In-Reply-To: <Zv4USZVyEctYiCgM@aschofie-mobl2.lan>
References: <Zv3z5UsG_jsO9_Tb@aschofie-mobl2.lan>
	<20241002221114.74bf1b85@gandalf.local.home>
	<Zv4USZVyEctYiCgM@aschofie-mobl2.lan>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Oct 2024 20:49:29 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

 
> > > [  110.737704]  trace_event_buffer_commit+0x13b/0x280  
> > 
> > Hmm, do you have "tp_printk" on the kernel command line?  
> 
> Yes I did and when I remove it the problem goes away.
> 

I know exactly what the bug is. I'll fix it and also add a "tp_printk" test
to my test suite :-p

-- Steve

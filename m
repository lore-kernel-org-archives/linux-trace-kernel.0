Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ADF43901C;
	Fri, 27 Feb 2026 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205618; cv=none; b=lbC18bwlodirxOOaoFCg+WCMlIxaj3FmHO6mkNrw4Tx9YLcW/kS9YHqmMcOhIUmzNenb7g5eIl99qvqXm3V9LQeMHZDCVjgwgwasuLXQ4nftv2BtRvixDIfkClAm1YVVQlpX0Xy2T33JaQ2xLRdT/I0WAuH5048tUsSCfAJSrJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205618; c=relaxed/simple;
	bh=UuiGcMogUEujekOoWdyf/aYNw0UL7PWarR8ko8R02DU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VHAIBBQ5hAtvQFvvhz651P5dKKRL7cJKAwk1NHVC7Ptl3XU8VvYnFR4jPmoAjAmfVZou+r6lv+BOiLUln+DoWLUW442PgSgYVGDqtcqenC4WrR/qrD0DcGNZXWNKqSD/dtklLDxSjmUYhkxzHl/BYY7KdkOi7yo87wBuYa7L0HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 78C1114075B;
	Fri, 27 Feb 2026 15:20:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 91A6620029;
	Fri, 27 Feb 2026 15:20:13 +0000 (UTC)
Date: Fri, 27 Feb 2026 10:20:38 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Qing Wang <wangqing7171@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com
Subject: Re: [PATCH] tracing: Fix WARN_ON in tracing_buffers_mmap_close
Message-ID: <20260227102038.0fef81e9@gandalf.local.home>
In-Reply-To: <aaF-bhAIhCgusG9k@google.com>
References: <20260227025842.1085206-1-wangqing7171@gmail.com>
	<aaFrmHzIAkEe7ufy@google.com>
	<aaF0zS3xh5KgM_yy@google.com>
	<aaF-bhAIhCgusG9k@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 91A6620029
X-Stat-Signature: 9k1uu49dj93j6krefafx3x699k4w33e4
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18y4lCsY6kr0eq/TTXyyUJPBBB1FhaXq0Q=
X-HE-Tag: 1772205613-480801
X-HE-Meta: U2FsdGVkX18B8oFSfkMXJeQ543eyt9vcNzvLiapzUgMH2SOWqtb4KBgOA/KSSKZD7Y6bI1H/WakV+DTG2tR43Li4WhLpDGcNSsd6mqBXw69jsrVizzGpRN8mbhV9uglfDiX+f1XbbusfFppDMsL+O8SWpQLiuSC/4ptvSwegdPSiake7EETZrYvqPljY3QGFWHns/IjDJaNLCAdUPiYx7yed3cEQB4CE35O9zn1ECRqlAxXlvrTToC1OuHnY5jVlOGB8/s/mqJh3qsqXIymWRxN7lsmE3vKX1w/DBu+5ahUtO1OoA6+CZyHdISGwMi8gWXI6dAd0PRvXZroDGI+krrwdIoM/JDl3vc3xMgP/pAq8uwTHkfuD0w==

On Fri, 27 Feb 2026 11:22:22 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> > Ah right, Syzkaller is using madvise(MADVISE_DOFORK) which resets VM_DONTCOPY.  
> 
> As we are applying restrictive rules for this mapping, I believe setting VM_IO
> might be a better fix.

Agreed.

-- Steve

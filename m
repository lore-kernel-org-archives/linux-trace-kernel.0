Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9C42F290B;
	Wed,  5 Nov 2025 23:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762385109; cv=none; b=qZj//LBHO0RxlCdjPxj7QekppWLXq28FDtFD8W1Mx31scWkdVDh8e+rxZO+XdDGxVXYtzDkkOZ7O/eYO7EikVtli0r04en9LebVp60+l9s7j9pAs8DPJ36PbV3AQx3Q5m0Io8oNdV3ii2G6PZSJPeftWjYpUvUP4L8zYcANLzR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762385109; c=relaxed/simple;
	bh=0PbFZYo/huWPHytJNGIJHR5vXA4bX9Qa1ZarjHpXrh8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dYSU7Mf+ftLtzQZqGytNpqe8pe4G41yx939PITw2ko5s2Ay4LKz3Vcpn7ncGSZ35McZy7GRXA6KsXf8vc/fOMOEFrabqeIbx5V7UnHPgr/1xl9fXz2fjWzYOsDYrX2uU3VvUH+tacZFTZ63vddUwh8k0Uu4nUcJSdjnfEO8DN5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 250E81404B4;
	Wed,  5 Nov 2025 23:24:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 450D51B;
	Wed,  5 Nov 2025 23:24:56 +0000 (UTC)
Date: Wed, 5 Nov 2025 18:25:05 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Lukas Bulwahn <lbulwahn@redhat.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Lukas
 Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: add tracepoint core-api doc files to
 TRACING
Message-ID: <20251105182505.6efad861@gandalf.local.home>
In-Reply-To: <20251106080616.a46ca1c46b4034ce9757e5c9@kernel.org>
References: <20251105092428.153378-1-lukas.bulwahn@redhat.com>
	<20251106080616.a46ca1c46b4034ce9757e5c9@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 1c3jrrfjqttyzebwumctc4a8m3cop3rn
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 450D51B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/CLPqo8xoLUUfECe5hmX416Fvy/gJRGPk=
X-HE-Tag: 1762385096-718870
X-HE-Meta: U2FsdGVkX18Z0Q8/rIwk6t81gvakes4pp0x/KmmKYdzq/PkWl3klhqZBXpf5eiIW1JCUpPcafstlnhGWxDRyV61eZuhDSl6NQWtZ9I6zt9lPDAtYyetIIdQX3lHYZobMw5kjx720yu2RWsopXMlNghia3DqBy6wDyFcD3ZcmwrUqq+BJ4DdlDiwLCKQ7m5Cyd4hSJe+NKLIPtHFt0wOKqR18fFhN/s+LXWaMtIOlzdoybxTXvaMAyCfV1UZSoTODDuw+f81KMuj9v31kcp63lBkZl77XCj/HOwd1LHHlIf3fo1oBCPig0gUCk611Fq9bQ94H3YPKNO8g1r4XAfw5pftrrZtDeAarAHV74J8IFfgrEKosGGNlS1LdTZlUD0rCYtGHyQx/StHW5Y4dGr6WYRoJL8vugylZoOVx66K809A=

On Thu, 6 Nov 2025 08:06:16 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> > 
> > The files in Documentation/core-api/ are by virtue of their top-level
> > directory part of the Documentation section in MAINTAINERS. Each file in
> > Documentation/core-api/ should however also have a further section in
> > MAINTAINERS it belongs to, which fits to the technical area of the
> > documented API in that file.
> > 
> > The tracepoint.rst provides some explanation to tracepoints defined in
> > selected files under include/trace/events/, which itself is part of the
> > TRACING section.
> > 
> > So, add this core-api document to TRACING.
> >   
> 
> Yeah, that should be maintained by us.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Agreed:

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

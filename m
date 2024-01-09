Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1D33F8D1;
	Tue,  9 Jan 2024 23:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBzNVUFZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA09BC433F1;
	Tue,  9 Jan 2024 23:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704843729;
	bh=V5SoNVHkaohW6Hi1oKlnnVxlzfimMwLGEIxtkbPfkOY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dBzNVUFZCGsnRy5x2vJUDc+1d4+1Ncx2H18JJaBwC6K8lN1kLfD31qtbZxunZXcQo
	 Ra4HhlW9bqPCFTiw4dHBu8EgPTkLBFgXQg89VJ6qrBMXdwLYxr7/CRKINlDVc3abkm
	 0Qqu1wanaTj4W3pbQFl1MNlgP1tNYCiWgRkfcR3r3qs7/pR7dwl+AmYVFUbw7rFNgF
	 cW+CBxNZa1/06HIh/+cf602N4T9Tj7ZhVicz38dbDAdwp2UCvhGZvxf/oisYQ8hTif
	 BF7vUX1tF05iXM4Vg1Re0n0cuDu91w0uk+aKt2XZQO70unaNa5JLo9TWiftS75iBCO
	 ApDuYto7mrYZg==
Date: Wed, 10 Jan 2024 08:42:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com
Subject: Re: [PATCH v10 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-Id: <20240110084205.2943f88bf8b797b04297b0ae@kernel.org>
In-Reply-To: <ZZ1ir0edlY3OzjyC@google.com>
References: <20240105094729.2363579-1-vdonnefort@google.com>
	<20240105094729.2363579-2-vdonnefort@google.com>
	<20240109234230.e99da87104d58fee59ad75c6@kernel.org>
	<ZZ1ir0edlY3OzjyC@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jan 2024 15:13:51 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> > > @@ -388,6 +389,7 @@ struct rb_irq_work {
> > >  	bool				waiters_pending;
> > >  	bool				full_waiters_pending;
> > >  	bool				wakeup_full;
> > > +	bool				is_cpu_buffer;
> > 
> > I think 'is_cpu_buffer' is a bit unclear (or generic),
> > what about 'meta_page_update'?
> 
> Hum not sure about that change. This was really to identify if parent of
> rb_irq_work is a cpu_buffer or a trace_buffer. It can be a cpu_buffer regardless
> of the need to update the meta-page.

Yeah, I just meant that is "for_cpu_buffer", not "rb_irq_work is_cpu_buffer".
So when reading the code, I just felt uncomfortable.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

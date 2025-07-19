Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A115F72610;
	Sat, 19 Jul 2025 01:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752887600; cv=none; b=o4K4YFRLYY7ChW6JwvppYYSfIFPvGp/Cy3GKgOzS1AccoPAZE1hLw810aXhb8YeBi9DKnnoGH9R+a+rivFMSZODZTAUr68RIbml5wM9Ob9EGfyaTVnN6B+mlvA+OGjIeSaXCxIetUlsFpzQ7jR72R9HdsuVX09JOYcYX0NKcrSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752887600; c=relaxed/simple;
	bh=ZSv2cbNAj5K8fUKKa9BPIIRPA8PojDwm0K4mjVhTxos=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=o1DA+tkfBCE5IaDcSu/E/idB2TO1AO3VE3C0oil7w/LRtjr0j6l0rVrxHE9/8q1jAJu+oWZOgm0tY7kxzYCVnYAyXij2A/r7U/4oywOyA1Ys9iBjgrQySlEHOz0B49O1rL9Xhb5PhdX6X41X6l3hOM/TyfNEqz0lK8KkCv736eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOwe+7O8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOwe+7O8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9779C4CEEB;
	Sat, 19 Jul 2025 01:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752887600;
	bh=ZSv2cbNAj5K8fUKKa9BPIIRPA8PojDwm0K4mjVhTxos=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mOwe+7O8/9InZki11JoJUCgM1R8Ee55VdAB9s+S1J7xbW3kTQg9XBai7XiXhqgvlM
	 QnDW42aOwD0CV+EaExzdiFr72aL4+NZFklI4ggIzkZVAXpkONehrbNDUPQT31bueVz
	 6dGvktZxJJZTmoVQ2Z9DWDnardWCM+1D3f8zabombb0bMgdx+mekku6pHBHTTOR+gI
	 V29XI/QYEEj3HHuVDUXW5anHHYSbW182L/VB8+0YDZ5kANXGh5l5RPbyM388EmVyfg
	 S/eA2WPvBHl4DacNcCyyiPtaGM5wZe93KuYDxmxa0jB+LBZcly9c/vLvpusSnpoKJF
	 fVon7mIPNxYpw==
Date: Sat, 19 Jul 2025 10:13:15 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] tracing: uprobe-event: Allocate string buffers from
 heap
Message-Id: <20250719101315.6bb5b44b76353bc324fa5dc6@kernel.org>
In-Reply-To: <20250718135846.6dd841e7@batman.local.home>
References: <175283843771.343578.8524137568048302760.stgit@devnote2>
	<175283849142.343578.11299469553352925660.stgit@devnote2>
	<20250718135846.6dd841e7@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Jul 2025 13:58:46 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > +		buf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
> > +		if (!buf) {
> > +			ret = -ENOMEM;
> > +			goto fail_address_parse;
> > +		}
> >  		snprintf(buf, MAX_EVENT_NAME_LEN, "%c_%s_0x%lx", 'p', tail, offset);
> >  		event = buf;
> >  		kfree(tail);
> 
> You could easily do the same thing as I mentioned in my reply to patch 4:
> 
> 		if (!buf)
> 			goto fail_mem;
> 
> error:
> 	free_trace_uprobe(tu);
> out:
> 	trace_probe_log_clear();
> 	return ret;
> 
> fail_mem:
> 	ret = -ENOMEM;
> fail_address_parse:
> 	trace_probe_log_clear();
> 	path_put(&path);
> 	kfree(filename);
> 
> 	return ret;
> }

OK, let me update it. Thanks!

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

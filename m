Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6963925949F;
	Wed,  8 Jan 2025 00:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736296729; cv=none; b=U9Tz/LHXIBvL/TYGhwH9XXBZ/wn3c/WrKaUqejnXFr1Tekh5CslXeaf+dFqjGUUUVF+u1raMhHn50Nu9FSsqrInffV3zELEkGEtJZtZFvBbZWK8GpeuLAHJT69m517wvsIKFBLjwAcPS5o+j4ov5AGPq1IUb3ikhBKq2Uuzc/y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736296729; c=relaxed/simple;
	bh=Jb6+xUcAlme8rTe7N/fLaQdqGDKpjgvklGOWAq8cQPg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MnD3Mr8PbJqVSC2RuRy1xRbkDCkgS8h+5c5hTnqGJz1jb7zplgeh4m8O+EprB3cQBGJ7SKGDtJ7QeaM1fJdOjmao7KtpMxf3WNMT1WI2LPvUxYDP+hedEJl2Nsua3RXR3GjJs4CUajvndEQr/5uAHwDPqSBhbrQIGN68fQMX6Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHU9umiq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHU9umiq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00789C4CED6;
	Wed,  8 Jan 2025 00:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736296729;
	bh=Jb6+xUcAlme8rTe7N/fLaQdqGDKpjgvklGOWAq8cQPg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jHU9umiqdCcYoU10czweUD2am2ftiEMrQCdKkeiO6LBXbBU+81RYmRqsEwRlseJz8
	 JUXuERgtBKtv6XDC9OpFGuJmDDmvnq/BvPxjJUGNEfG+ClM2YkB+zX8wSmUV7bQAbN
	 Ra0s7yciFqBIWwkWWP+V2WslvTbGMgBxNdoPWt0yJFeEi9k0nepm9SyCER1aIF+gQo
	 JsKiNFMYIBYVlf5qNezc9nJjRyx/d7TT6Qh6j7pXE5ok5L0OiS9pavjx4zHYcaEfuU
	 7Ljel9y6VGnRkCB+Ugvrv6TAbHr5RMbkulNTJjRqWywL5EiGUQZEvoyL0lujndk7Ew
	 tYSQTzshDFhLg==
Date: Wed, 8 Jan 2025 09:38:43 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Oleg Nesterov
 <oleg@redhat.com>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] tracing: Use __free() in trace_probe for cleanup
Message-Id: <20250108093843.dc5ea69f297a9fd99cf4c396@kernel.org>
In-Reply-To: <20250107103643.37a3b002@gandalf.local.home>
References: <173625060316.1375434.11048027439794595989.stgit@devnote2>
	<173625062518.1375434.10516553019799245668.stgit@devnote2>
	<20250107103643.37a3b002@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Jan 2025 10:36:43 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue,  7 Jan 2025 20:50:25 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > @@ -1790,18 +1777,15 @@ int traceprobe_expand_dentry_args(int argc, const char *argv[], char **buf)
> >  				       offsetof(struct file, f_path.dentry),
> >  				       equal ? equal + 1 : tmp);
> >  
> > -		kfree(tmp);
> > +		kfree(no_free_ptr(tmp));
> 
> I don't get this? You are telling the compiler not to free tmp, because you
> decided to free it yourself? Why not just remove the kfree() here altogether?

In the for-loop block, the __free() work only when we exit the loop, not
each iteration. In each iteration, kstrdup() is assigned to the 'tmp',
so we need to kfree() each time.

Hmm, maybe this is a sign that I should not use __free() for the 'tmp',
or I should call kfree(tmp) right before kstrdup(), like below.

 	for (i = 0; i < argc; i++) {
		char *tmp __free(kfree) = NULL;
		...
		kfree(tmp);
		tmp = kstrdup(argv[i], GFP_KERNEL);
	}

Does this make sense?

> 
> -- Steve
> 
> 
> >  		if (ret >= bufsize - used)
> > -			goto nomem;
> > +			return -ENOMEM;
> >  		argv[i] = tmpbuf + used;
> >  		used += ret + 1;
> >  	}
> >  
> > -	*buf = tmpbuf;
> > +	*buf = no_free_ptr(tmpbuf);
> >  	return 0;
> > -nomem:
> > -	kfree(tmpbuf);
> > -	return -ENOMEM;
> >  }


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

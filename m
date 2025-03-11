Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ACA360;
	Tue, 11 Mar 2025 01:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741656572; cv=none; b=UoM1xTx9coD5wrtU6peraMb4YNqgDXRywWmONsSTA1A/dfa2FiOkPFOloCyXzRtJbgB5EKLagRCa89+p0k56LFZaeRtlDKdeX+rCRw0NYsBJqYAORPfthifNiFkqtzi66N7peiyFYkMpcq2wMrFGRI2iy9a9e/dTWnTX6mGmBs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741656572; c=relaxed/simple;
	bh=TS2WD0LGdmJ3Bg5okMf22/qVCeyY/UfSxXD8aVLF15g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uOdTyI1ofdl3k9A3rAMmJfyh0MNiWmJpmkQHmx3a6VdDJUrqukuZXpzb6aW9+7pmNUILHOrOp4WSiHAkldXkWMw0Y8IDV7jBM2i9eXhnYxZzfjM909rj4FcIGIxNk2XrXt/s83HKfNeT8mo77GaFLSE0xcmrJ9FGvnQjM7MRAAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cg+bgZee; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cg+bgZee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99764C4CEE5;
	Tue, 11 Mar 2025 01:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741656572;
	bh=TS2WD0LGdmJ3Bg5okMf22/qVCeyY/UfSxXD8aVLF15g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cg+bgZeeMUhgypkVyufXcErFqv+HHMEjTCAeFYdEWluBGCAoIceH+iC0y1gOFFIsI
	 SjR8CDAItsGlgIHEg9P89wZDHF4qJzzrBp3z3YjOlrfLc+8g6ffkExyQ6JVHslsh1o
	 xGiQSA0CRdYRCEQMTTTLQoyRLogDkfhy+SULTnE5ydqjr2YroNYsM39PVkjQ33U2tM
	 M/8t6kgMlvLAVxj+vZzgaKZxLx83o78e+S/IuFgyf/EFtGxZQH8+Qum0GklCvNLIwi
	 pXnqRe3oZd1yNf797NhWGrt7iCdL0RdghTWtMY1e5GuuW0pNDomKaPOyLr7HZcvv4k
	 pWIX3knQA0mMQ==
Date: Tue, 11 Mar 2025 10:29:28 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: probe-events: Cleanup entry-arg storing code
Message-Id: <20250311102928.ae96ceb8870e73e30f6f1279@kernel.org>
In-Reply-To: <20250306191404.69b0877e@gandalf.local.home>
References: <174099254917.619976.17555764627143910556.stgit@devnote2>
	<20250306191404.69b0877e@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Mar 2025 19:14:04 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon,  3 Mar 2025 18:02:29 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > +	/* Search the offset for the sprcified argnum. */
> > +	for (i = 0; i < earg->size - 1 && earg->code[i].op != FETCH_OP_END; i++) {
> > +		if (earg->code[i].op != FETCH_OP_ARG || earg->code[i].param != argnum)
> > +			continue;
> 
> I wonder if you can save a loop by changing this to:
> 
> 		if (earg->code[i].op != FETCH_OP_ARG) {
> 			last_offset = earg->code[i].offset;
> 			continue;
> 		}
> 
> 		if (earg->code[i].param != argnum)
> 			continue;
> 
> 
> > +
> > +		if (WARN_ON_ONCE(earg->code[i + 1].op != FETCH_OP_ST_EDATA))
> > +			continue;
> > +
> > +		return earg->code[i + 1].offset;
> >  	}
> > -	return -ENOSPC;
> > +	if (i >= earg->size - 1)
> > +		return -ENOSPC;
> > +
> > +	/* Not found, append new entry if possible. */
> > +	offset = get_entry_arg_max_offset(earg) + sizeof(unsigned long);
> 
> Then here you could use last_offset instead of running the loop again?

Yeah, but I would like it easier to read and safer (adding WARN_ON)
especially, 

> 		if (earg->code[i].op != FETCH_OP_ARG) {
> 			last_offset = earg->code[i].offset;
> 			continue;
> 		}

this is a bit unsafe if we introduce another operation except for
the FETCH_OP_ARG and FETCH_OP_ST_EDATA. (and it is expecting the
offset is always increased.)

Thank you,

> 
> -- Steve
> 
> 
> > +	store_entry_arg_at(&earg->code[i], argnum, offset);
> > +	return offset;
> >  }
> >  


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

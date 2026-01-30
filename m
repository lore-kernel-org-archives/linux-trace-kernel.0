Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD27D1EA7DB;
	Fri, 30 Jan 2026 14:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769784801; cv=none; b=jk9cxmcV86rdAM2ueEdbO3YZrfPqCzvQEXzobtK0We1sR4a3qIalL+6VnJqbn87t8vN3evy5xdwJF/IERK4zrRSM2J4qB8KutdMHFXDVGFP5rEdh1RltDL4s0zF0Q+IAqNZJLjcVGCx0dEGa4EQBolCBDoPtAqma94ugXroXk+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769784801; c=relaxed/simple;
	bh=PrW73Thnw+qE1jXAaZqhYs8XkFFD7CxWfNDvGbk40Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lXu3DvE6IX+WmgiWcscv4kph3tBlzT5XqoEkLrdw7UritjZASQp3afUDb2VQkNL9EiiH2UoLlfgLRJXsFMlGn6xSujbTfCKd6brd/Ka9AVOvf9LgE9TE3abb4SRjcqUaYkXmZQYvThPY0okIHIRutKBsI+3oLKSmimJhQ/sq85c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 6612959F6B;
	Fri, 30 Jan 2026 14:53:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id A8E5B20011;
	Fri, 30 Jan 2026 14:53:16 +0000 (UTC)
Date: Fri, 30 Jan 2026 09:53:31 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, Julius Werner <jwerner@google.com>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bootconfig: Fix to terminate value search if it hits a
 newline
Message-ID: <20260130095331.5c9f754e@gandalf.local.home>
In-Reply-To: <176974810577.124104.16012554973099890517.stgit@devnote2>
References: <176974810577.124104.16012554973099890517.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 9u3dzepyxsefh5umazitmgyoc6p8tejg
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: A8E5B20011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/IrkJImjsq4myRYOO2Lzhcgad4T02fUNA=
X-HE-Tag: 1769784796-95478
X-HE-Meta: U2FsdGVkX1+0NelTB7KQDxqW3Q5Uel3wrMCngjG8WVAKUOJDGkt9RNApy2kqOY92VIa6rsr6l0eEDO1KbXXtp9ViaJgUJZdTK2Ldg3FZHjRLp7+mjAQE2d7e8WRrGZ8r+iyUJpZNBMoIisrkbRXYY3hrfTezIXN0/BSDyc4PD9f0NVL5V/X4iUAeIMvmzXZoQ87VX7mBJWOeCgP1DyjGDDoTSTmtxG4QFDGLV11y5YErbnI/FPhLHKcDz4G6AIYC4mQ8HPSrnakQ49Qg0GpPA8LYwb27Ydsm3BqNNvDFW9ztVozHAzTUSx590l5UP6dIi2RV5+v+bLFYulRytjof6gbUb15zC6TQbzziFHPyT2NiNvADmmQSSX5PDWApRdm1EhIqJI5PjY3LZj6ELB1c3GpUXtf0LuAj+5KJzRU+ciw67BI50vW8PA==

On Fri, 30 Jan 2026 13:41:45 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Note that if the line has a comment, it still keep searching the
> value to the next line::
> 
>   foo = # comment
>   value

Hmm, so the above is the same as: foo = "value";

But what is:

    foo = value # comment
    bar

 ?

Would that be foo = value bar;

Or simply an error. Or would both be an error?

OK, this isn't related to the patch, but as comment processing was brought
to my attention, I'm wondering how it works for the above.

> 
> This is interpreted as `foo = "value"`.
> This also updates the test script so that it can check the above cases.
> 
> Fixes: 76db5a27a827 ("bootconfig: Add Extra Boot Config support")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  tools/bootconfig/test-bootconfig.sh |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

As for the patch itself:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

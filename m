Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B72E555;
	Wed, 23 Jul 2025 00:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753230579; cv=none; b=TDyF8vILGxmK6k+p1w0ANwH9xR2QGeVI6WGDNnri55SMjDmP93ACu53p3d9Ic2qpgd4ZsSOy1lUG4mA4I/eJRmXW2znrks8wl33NvnNmNU6qiyS/1QMI7ueoZIbEQz/buyQGi2wRVwsIRlEDT56R78ZkBCd4dUIGVznPKwho6vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753230579; c=relaxed/simple;
	bh=6QqDWXA5PEJIc6VfT9BPt4BSvrIbbdnA5VYus8jE+1I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XcMRCis6ile8GwAAZjKw/5sK6t2S0Z31/hW78Rv9K8EpsdF5Q16j/76sQum4s4221Xe3qrjcmYPO6M0meZttyryfIpMZAyupDnJrA+s3slV3UTWgM9CFohy0ri+qqfqdTKCBFjFUbl04kaiyVCFF78Swmtt5jRPZ18T0aQkW5P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bw09MBp2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bw09MBp2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249EFC4CEEB;
	Wed, 23 Jul 2025 00:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753230579;
	bh=6QqDWXA5PEJIc6VfT9BPt4BSvrIbbdnA5VYus8jE+1I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bw09MBp2V68rM7tgW+6mvuL7SXrpJg2yNDRBU5Nk3tWk3UodWyhFFilJbmGbOBpBU
	 2DtENVwbnCREBC5hVZF/Aj8jqlrJ/XyMXQI+efmtqW2lei6R2sApXTxvy/mJD/RdTf
	 CEgEu5gJk4ICofeXlrH5cc98T4mEtcVMZFSzprCCteWK7+Q4RnvHaRpSr/WgDwUAIb
	 AcIR5CKL7IN/QA5u9q2y5QXtYlhr714zKR+dJl8Gz88gkpDVH0OFvmj/6WIQg5/mzn
	 hsqHfFX6TfaLRGQnDUiOc5YsKbpgW9rIXMuh3ZK9r+yq/zdluima4D3AmsIk2hTJIk
	 ouIcQPNQci+iQ==
Date: Wed, 23 Jul 2025 09:29:35 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] tracing: probes: Add a kerneldoc for
 traceprobe_parse_event_name()
Message-Id: <20250723092935.c6404b04f1ab40c86d18a10b@kernel.org>
In-Reply-To: <20250722184420.24a9239e@gandalf.local.home>
References: <175322168606.44400.9155291012158349647.stgit@devnote2>
	<175322175536.44400.179953626110801411.stgit@devnote2>
	<20250722184420.24a9239e@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Jul 2025 18:44:20 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 23 Jul 2025 07:02:35 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Since traceprobe_parse_event_name() is a bit complicated, add a
> > kerneldoc for explaining the behavior.
> > 
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/trace_probe.c |   17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index 9d26d901c9e5..7dcc4a548c69 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> > @@ -247,7 +247,22 @@ int traceprobe_split_symbol_offset(char *symbol, long *offset)
> >  	return 0;
> >  }
> >  
> > -/* @buf must has MAX_EVENT_NAME_LEN size */
> > +/**
> > + * traceprobe_parse_event_name - Parse a string into group and event names
> > + * @pevent: A pointer to the string to be parsed. On return, this is updated
> > + *          to point to the event name part of the string.
> 
> I believe, these are supposed to be single lines. What it has on return
> should be in the "Return" section below.

Hmm, indeed. OK, I'll move it into Return section.

> 
> > + * @pgroup: A pointer to the group name. This is updated to point to the parsed
> > + *          group name, which is stored in @buf.

Ditto.

> > + * @buf:    A buffer to store the parsed group name.
> > + * @offset: The offset of the string in the original user command, for logging.
> > + *
> > + * Description: This parses a string with the format `[GROUP/][EVENT]` or
> > + *          `[GROUP.][EVENT]` (either GROUP or EVENT or both must be specified).
> > + *          The parsed group name is stored in @buf.
> > + *          The caller must ensure @buf is at least MAX_EVENT_NAME_LEN bytes.
> > + *
> > + * Return: 0 on success, or -EINVAL on failure.
> 
> So the Return section here should state what is returned in the parameters too.
> Like:
> 
>  *    @pgroup is updated to point to the parsed group which is stored in @buf.

OK, thanks!

> 
> etc.
> 
> -- Steve
> 
> 
> 
> > + */
> >  int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
> >  				char *buf, int offset)
> >  {
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13C919C54E
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Sep 2026 00:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309174; cv=none; b=btj95mCywIi1SkZ5bj/WfgO21NIAeSao8bn7fLIwcbYmxrdtpMR4el0N6xCFlBS9ijU5vDavQz9F3TNqaXL7AQjX9virc1DcMpQ0dIVtOtx4WgBFwHC6ne7Egfu/NFA0YDtiUrXzlnZ0Isi1t6SonDHxHi7cvlf6Cg2TIhZH90Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309174; c=relaxed/simple;
	bh=WLy4VAeO/OhjwdEd4R/MQIyy2jTP3RfdRwsMY59iZmE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fXRYRgEEcJ5tKvZcDnBUtq4JTZCA71HDL+CKGWgC7f4S2sCVoyz+dfIg1IYmU2y7aW9ol/sWb4+VygM8PDVSKOGOziKBcss6fukTl9g1ysWPLMPaDAoCB3+ARmef5lRREZGA5id6cJK4BSuORq4VL8hDWALv5g7yzCcbvPPAq74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=M0gk/sfd; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="M0gk/sfd"
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 1C1B9A05BE;
	Wed,  2 Sep 2026 00:32:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 6B2F530;
	Wed,  2 Sep 2026 00:32:44 +0000 (UTC)
Date: Tue, 1 Sep 2026 20:32:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Take trace_array reference when opening
 options file
Message-ID: <20260901203243.350c2e8a@robin>
In-Reply-To: <20260901191339.25a5a060@robin>
References: <20260901163620.6cbe0ada@gandalf.local.home>
	<20260901205421.5832E1F000E9@smtp.kernel.org>
	<20260901191339.25a5a060@robin>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6B2F530
X-Stat-Signature: pijhu9a6k1az355su3i9nsn58umcf333
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19rsLzF1mXs9bT0fyOB+CaMVsBOuxxQbjE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=JOtgYTFntyaLgKro8FRfk/JDhdSIMLDtCgBFmt7+kO4=; b=M0gk/sfd8d5gvTYupDZtJWqO9QOnREV55/o0Z9KcOJhppS2vTc4V1EDlh8d4id6d0LS3qpGBDu2FOD2ePdY9lRAn/bTY0qQTJMO/fnjyKnfxqewasaePFwOL1jGPkIeFHZJoZtHPyMfiLfE9yOXPjR+/i6L15L6EXSbrw7wRYAg=
X-HE-Tag: 1788309164-618110
X-HE-Meta: U2FsdGVkX18r/rjO2D8QQrdsH4rl0jJ0JGki/ECvulCmQjfMfdgpLlKfYsWPrxwKm6w6hba0ML19HgmbCSvCQs6KVNI9QEv0uNd2zoXOgUIMRhMBCsVEGd7FToBf9gp7LR62hved4AJHZ91fZFAHw+fDBdo4ZtqnNgTHm89Rc5WqfgXmWUsKzS1EaANQtTiUO/vD98LdF4XHI8l6GhHpXMW+ixsmybVKHr8v++HszQB8/8Lb4gOBuM1Cu1RyCQLfIeirQLMpCi1Ru8saxACXZsIRePvIu/9XIW9dSqahkrDP3Rh6wPpxw3RQfd9/MxtYQJYykGFWy6+5M+w6HqZVtlTYbncoRNxX7LSa/zMp6aUlzb7sy8nGmOOTVqG7BFqv

On Tue, 1 Sep 2026 19:13:39 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > For example, if a user opens a per-instance tracing_max_latency file,
> > keeps the descriptor open, and the instance is removed, could a
> > subsequent write dereference the freed memory?

Not sure what tree you are looking at.

> > 
> > kernel/trace/trace.c:tracing_max_lat_write() {

That function has been moved to trace_snapshot.c

> >     ...
> >     return tracing_nsecs_write(filp->private_data, ubuf, cnt, ppos);
> > }
> > 
> > Where tracing_nsecs_write would perform an unlocked write to the
> > freed pointer?  

and this has been fixed by:

  7d660c9b2bc95 ("tracing: Have tracing_max_latency inc the trace array ref count")

That was added in 2023.

-- Steve

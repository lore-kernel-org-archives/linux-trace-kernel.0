Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D7D2FF177;
	Tue,  2 Sep 2025 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756822506; cv=none; b=FO7+m1aV6RY422sqVReVB7S3uIgql3NlBNJKaDFDdcdSEfjxd/ujivb5jrFdNz8jFY7wqoa1zKjecAVepsvsHqjIXiPxfmOvly3REpSof6BZM+x9FwAWPpIHZPZ5nwODQeKfhVyrz0ZyQDIXPepxM1CBTemKzNpi1ABfPFvQ+RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756822506; c=relaxed/simple;
	bh=Q06S9QrfPeM3G6P+qKoliklZkfVG0uFkiMuKOxMWx3s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OLS5iYhd7IctEPrtOROj4SXJovKhQgzANlozE1e62bhtvIcNwrFF463f60tFAGDArJF24Csc+elRwHQpbLpJACIb9vZt+eDJJ/PnqMZIFQg3k5TFAv8mTYBI4o52ek8PgKqnckOZTexOZXFCVtsUTCQZmX5SUuq/QqgLMUIODAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id B0BE3118DE0;
	Tue,  2 Sep 2025 14:14:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id D75B22F;
	Tue,  2 Sep 2025 14:14:55 +0000 (UTC)
Date: Tue, 2 Sep 2025 10:14:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Luo Gengkun <luogengkun@huaweicloud.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] tracing: Fix tracing_marker may trigger page fault
 during preempt_disable
Message-ID: <20250902101454.08ac4b51@batman.local.home>
In-Reply-To: <cc6eb973-d82b-4afc-83fb-a2c28cc79d36@huaweicloud.com>
References: <20250819105152.2766363-1-luogengkun@huaweicloud.com>
	<20250819135008.5f1ba00e@gandalf.local.home>
	<436e4fa7-f8c7-4c23-a28a-4e5eebe2f854@huaweicloud.com>
	<20250829082604.1e3fd06e@gandalf.local.home>
	<20250902005645.8c6436b535731a4917745c5d@kernel.org>
	<cc6eb973-d82b-4afc-83fb-a2c28cc79d36@huaweicloud.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: beakny4makx9cgn6wr3cpdqnepb7zwzk
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: D75B22F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Vny/0m1YTHEB86J0KxD22azBiTD+a6Bc=
X-HE-Tag: 1756822495-445596
X-HE-Meta: U2FsdGVkX184HKgOFkdHQFjK+vres2d7VudWt6HZdwYteDupaA5t8163Q1Cdzk5ffctsf+ji2tSeR5xXFP78YjW2zatrfZOwMQS2KXzu0/20/e5PEAyxQMHxTSY4wf58CvnSFV56gUR4RcAoGgEb7lyEro680Ri5G+pxONAwzgKFUOsfdU6EyC8jTEMSzTopv8FcBjcoOSWn5N/xHneyLIJ4gUrAyNA9C2KxeawuR5JgDJ9qcoy5jJisn1wz87OJ3F60Ef9bNyFGDjoS8aDfzta/VXK187CkvGH+uEbQPqMcpDc60Hi/LzR9u1XxahZwvUupmWNHDPJzAhT4eRnnmOz/bJDsUuBVg85WDSVDvNy9pa4VYNXIIw==

On Tue, 2 Sep 2025 11:47:32 +0800
Luo Gengkun <luogengkun@huaweicloud.com> wrote:

> > If this does not check the preempt flag, it is a problem.
> > Maybe arm64 needs to do fixup and abort instead of do_mem_abort()?  
> 
> My kernel was built without CONFIG_PREEMPT_COUNT, so the preempt_disable()
> does nothing more than act as a barrier. In this case, it can pass the
> check by schedule(). Perhaps this is another issue?

This is why I never triggered it. I always have PREEMPT_COUNT enabled.
I have tests that test without it, but I don't think those tests access
trace_marker, and if they do, they don't stress it.

-- Steve

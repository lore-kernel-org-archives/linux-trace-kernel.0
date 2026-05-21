Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676792FF176;
	Thu, 21 May 2026 01:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779327491; cv=none; b=uMESb71dpfqIrPQQi6tXvfj9Il+PTwvzOeKhys+ivIxaUZb8BiWKjwJac9XzQSQOMnIXtgxYrxNnRY/ip886l6GH0L7Z+TC37CHuCBURPCt6nhIS5VZh5FIJEQuC3WTz55yw8qVYHnf2YFTztFJA7/YpKBs1TF53KuUC7nuEtuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779327491; c=relaxed/simple;
	bh=K1FxVSZb4njXLhNH7PTK5pjLrGpmUGS3TKC/JlI/C60=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aGZGt2QPAtJd/tRR+TFT9PiFzFACfaEzYnXdftqPvBZs3zYn6paSfRtYteGjMBJQpVG/DRv/hQx/1KqXBMVHt/6etA1phzfSh/Sm5OB/DutvqFnmWfuN1JmW0cGt3Aq6OCOkC2hLYmjg8W7GqGI+YfHyCOXSOylczSJHMiLMLNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 727D21A0496;
	Thu, 21 May 2026 01:38:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 96DE060017;
	Thu, 21 May 2026 01:38:02 +0000 (UTC)
Date: Wed, 20 May 2026 21:38:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring-buffer: Fix reporting of missed events in iterator
Message-ID: <20260520213801.677eb113@fedora>
In-Reply-To: <20260521102921.a1449dedfe0392a3bb4a91b9@kernel.org>
References: <20260520142817.4050abab@gandalf.local.home>
	<20260521102921.a1449dedfe0392a3bb4a91b9@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 96DE060017
X-Rspamd-Server: rspamout06
X-Stat-Signature: rnkriewu3o1ypbu37p69efah1d8x9hk5
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/xj6YCdAVjAh2O2btnOaHIFVYG+PKp+xQ=
X-HE-Tag: 1779327482-796803
X-HE-Meta: U2FsdGVkX1+GC8K3FlYeRpXdEQZtUktbcK/GbmIu0oOwW+24VmZV0uxZIeaXp+7OpnncYc0Z2EBcX39k7yk0H/iLnRuc1rhQw4yrAPi6Naw4O+0H4Flm4IDI7WkZwT8a18gdsUoAtJGr45c3sT+lD6fBuc2qaSrfnCc+a0MeOHUdhaGDrkoD4vHOI3eG9k3KXkQezr13SkHpm0l26eA7qwllPaWZ0XfsiAtaSugHhLJbSlr/Eji5JCMpEu5XsMJaqK8jiZCgG6REzCU+Z6kUxeL+ua3cvNX6UXNft4qSB/kKzPFfsQmERzW8VrdmIp+HfhgvCfLgjgX0yF/FEyRdLlfDq/jPfwMJVNyDjFx2wojOPkxbvJCUwQ==

On Thu, 21 May 2026 10:29:21 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:


> > Do not reset the missed_events flag when checking if there were missed
> > events, but instead clear it when moving the iterator head to the next
> > event.
> >   
> 
> As Sashiko pointed, this flag should be reset in rb_iter_reset() too.
> (But that seems like another issue?)
> 

Hmm, I think that was an issue even before this patch, but Sashiko is
right. It should be fixed. I'll send a v2.

Thanks,

-- Steve

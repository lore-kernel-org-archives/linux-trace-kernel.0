Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CC7280035;
	Thu, 15 Jan 2026 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768492369; cv=none; b=jECwfiVfxKdGMWU06tTG2svre9CclitOM1zDnTJWr4Crftv8/hRzEyJvC+HXU9p23skFdU8a/eFEne4PA/orHe1wXvEXm9hpXvSuEO/H0Cv1uvOGpj8iDy/GhSM3LWrPttkIVHTu3xqTyTGr+92X/qckzyqXQFppZhyBFJ2zZoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768492369; c=relaxed/simple;
	bh=m0zHsQ9KPbG0ieMsAJ0j/xiECqpG3uNINShpFxPoOi4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e8D1gNxf7kNgiVLxcUXVkc7fvHUXNH59JuQpIbyF0qDCvKeGJdhAiva6lRjCsIiqDqbqSf8HBkojoMvGcaWbWKVEectdfYc2s9d0yXoVj/gmQSEK6Do+xGO2+8xuZBYEAEFcCvqFB/ywRH3jOSFBNqU+0GkiZdJCVOwHVq2pi1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id CB4408B7BB;
	Thu, 15 Jan 2026 15:52:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id A96922F;
	Thu, 15 Jan 2026 15:52:38 +0000 (UTC)
Date: Thu, 15 Jan 2026 10:52:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Crystal Wood <crwood@redhat.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, LKML
 <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing/osnoise: Fix OSN_WORKLOAD-related crash
Message-ID: <20260115105237.3788e1be@fedora>
In-Reply-To: <CAP4=nvQeBnAtbQFjAdKhQUP1_Xi2uEH0i+kZC6TZwu7GZJYu3w@mail.gmail.com>
References: <20260114123547.583859-1-tglozar@redhat.com>
	<bbb834f13cb1480b2517497481a1b3e0137d089a.camel@redhat.com>
	<CAP4=nvQeBnAtbQFjAdKhQUP1_Xi2uEH0i+kZC6TZwu7GZJYu3w@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A96922F
X-Stat-Signature: 5fefy77g6dygdqu7s9cjyz9oeg9p6rez
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/49v1T/YDq3jp7dhPBYxY6JX+G+3tKRM0=
X-HE-Tag: 1768492358-519891
X-HE-Meta: U2FsdGVkX1//MBxH14PwRZkdCWaeGxW9DcRK5dXrz4cvfZ7PrUmQqjXFD2zLv42iSrK7VuV7Zz9vOs01+HM4M1kU5gmfWV/m8R6FwZm0B958eVjII3tuyMknHYY+MQYDBjD6DR4KJ5RMkTvJ9JONsV6K7xITTZD+gRDeUHjdj+q3o5RbLN7+TUYRHrx5h9F96HfQUVr1liZqeTaczmC+BGOGOzZLL/w+75rykrhZPSItXyllGD0U4JnQI3CvBrIjDDOW2X5zckOjtjNJ6Y99P3lnP9vw5OYJatBbIa5Mw5gqgly8xRIFsybETeitwoUytsW6j26tpYsP8k/SNVe6uLWBT6AMpHHV

On Thu, 15 Jan 2026 14:32:27 +0100
Tomas Glozar <tglozar@redhat.com> wrote:

> > Of course, this is complicated by stop_per_cpu_kthreads() happening
> > before interface_lock is acquired.  Do we know why that happens outside
> > the lock?  That might even be the actual cause of this bug.  
> 
> Before commit b484a02c9c ("tracing/timerlat: Drop interface_lock in
> stop_kthread()"), stop_kthread() took interface_lock, so
> stop_per_cpu_kthreads() couldn't be called while holding
> interface_lock. As that is no longer the case, the position of taking
> interface_lock in osnoise_options_write() could be re-evaluated
> (comment in 5bfbcd1ee57b says interface_lock cannot be taken at the
> same time as cpu_read_lock).

Right. Also take a look at commit 177e1cc2f4123 ("tracing/osnoise: Use
a cpumask to know what threads are kthreads"). I don't remember the
details but there was a lot of issues with lock ordering between the
interface_lock and the cpu_read_lock. Whatever changes you make, make
sure to run lockdep while doing your tests.

-- Steve

Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED3B4499A1;
	Thu,  9 Jul 2026 23:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783639285; cv=none; b=kqNHTJxQiZQQI+FqsD77xoZUqBd6wGxFujv5lEzKelpBUO5EgIgRZ3C1ITTZOhjnBYp+NXUSN2hhP6m3Aov62vJjQ0IB0F5KjmhMWbJbFl4Pkq7naU/Q9eZbUMOsG6zLUk4f5t3+BaPTKP0aboXnX8c7A/prF+FpGOCO4LmsgDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783639285; c=relaxed/simple;
	bh=oAjaHlgO65Pwe0dXWcnoZ0y3o3WfE5eKRljRwctUT0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IACn/MSJOe1PK8+bCEVnogbMMYwpdWscpJqhThalbexvKY32V37MqJ7QFqlrY2aiayNMC0sX+OSN74/UCqXp7nzLUtXyk4cJbtifwDeUWnFlimfPltEBtJCrLQmEKjIWPYi86XJtrcwJjDAkV/8aQj9FQmYLgOHB9Hbn2J14dsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id E9EFA8D2AC;
	Thu,  9 Jul 2026 23:15:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 013606000B;
	Thu,  9 Jul 2026 23:15:08 +0000 (UTC)
Date: Thu, 9 Jul 2026 19:15:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 1/3] tracing/remotes: Fix leak in
 trace_remote_alloc_buffer() error path
Message-ID: <20260709191516.7a7ad6f6@gandalf.local.home>
In-Reply-To: <20260709160017.1729517-2-vdonnefort@google.com>
References: <20260709160017.1729517-1-vdonnefort@google.com>
	<20260709160017.1729517-2-vdonnefort@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 013606000B
X-Stat-Signature: 5ib5k848gopibxtkh9bnuhobj5zmzbhx
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19PXkPTbr4sA5lI/rfeAGxjnNlw1Tf8+qU=
X-HE-Tag: 1783638908-371657
X-HE-Meta: U2FsdGVkX18woGrK5nNGzN8XbWuiTqNW2cfc5IIJzIQGFzqhzAn5OQz1mObbrj0j5zt052lxg2AykAdiTl6zzOkVeRw5hZyed0/0cn2bYxi8D0ryHF6vW5vImWvHsJsCqp3EBUZNwgy4x7K3KzEYh/+m2AWVtxDxwD92MBKzpq60J2h9r+aKcUhUuLFLLEm0R4oElXvmILm9KtiW5lzqFIQWhn9VQy9Ol7r54uiaQe4wi+u891fBqWlMs9VY109/rLiQ49SAbWzTgxXx479CysIDmqVTKaJZQVFFpW7cSGNRpf9A3RwYWPQH2sD614JurwROuNeWruJg4K9R1bVy+POFuQUesEdqAgt2+XgkbX9ZIxomMesX9FDezITI9E1Mff1PpbqOsYagDZG5gvRhhKdLihu90X1BtF3S/Et8DRA=

On Thu,  9 Jul 2026 17:00:15 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> If page allocation fails in trace_remote_alloc_buffer(), desc->nr_cpus
> is not yet incremented for the current CPU. As a consequence, on error,
> half-allocated rb_desc will not be freed in trace_remote_free_buffer().
> 
> Increment desc->nr_cpus as soon as the first allocation for the current
> CPU has succeeded.
> 
> Fixes: 96e43537af54 ("tracing: Introduce trace remotes")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

This patch makes Sashiko find other possible issues with the code :-p

  https://sashiko.dev/#/patchset/20260709160017.1729517-2-vdonnefort%40google.com

-- Steve

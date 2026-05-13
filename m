Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBF53A2E36;
	Wed, 13 May 2026 18:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778695871; cv=none; b=E0B/qoLFv+6IfpsIpmijUwtae/S+4OE7J87MMt+Pu/gdzo9w7by/fi+fcjU6++pL7wfiPUkw/Oe3c1atxQ5EezNiBtzwTap4B9uz8OxD6USzEUFWbG8VAAD0VMNiJb3GFnjqoirWRdjMFpYHpfYt1YWIxaceWeB4e7f9CftwSww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778695871; c=relaxed/simple;
	bh=vosxcqrM4whM5jmyDbQN3cBpptIJU8yCYGE6BNheFcw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohSZYZcmfROV07fFglvfs9r35S6iM3OiXo0oe1zwG2A7JTeKFeVr/nEttzbsVgtGPBKTDG0jiLx8pLrZCrNmqp7aSuUDGGIWDT7svmyU+ays5iVsLuNJK1BduueqNYs9MNzXjFd7Gt6Cvv+vM/6HMf9tOkTeWnrNaKZ0tYkrlQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 4EA941C0336;
	Wed, 13 May 2026 18:11:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 93BE020025;
	Wed, 13 May 2026 18:11:06 +0000 (UTC)
Date: Wed, 13 May 2026 14:11:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Rik van Riel <riel@surriel.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2] perf/ftrace: Fix WARNING in
 __unregister_ftrace_function
Message-ID: <20260513141109.0a0140b8@gandalf.local.home>
In-Reply-To: <20260513132445.24d8d9f6@fangorn>
References: <20260513121607.14eab1f6@fangorn>
	<20260513123344.05b6bcfe@gandalf.local.home>
	<20260513132445.24d8d9f6@fangorn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 93BE020025
X-Stat-Signature: 71k8bdjeoup1pp5qp7y18mh7k3ar6sro
X-Rspamd-Server: rspamout01
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/kmjP3gCJNNubGXtdqlf4nWtOZ4bLv9BU=
X-HE-Tag: 1778695866-184117
X-HE-Meta: U2FsdGVkX1/Qk27Rzg3JY5iv0cE0jLyKRql5UXi7GkyyAzsvXge8e85u7Bm3zLvvIZ4EeZ/iBOKdF5+qgRc+fjUrbKYoPytYqO8rmWUtVDS74lzxsEGSfMUr24+HioJh6FFbUnAowjs4Z8K0hVEZbQa3LUiXNBSOb022AXHUxYv/wKK2zBSGfRr14EmoZSsujJscCjCyGwboHQFJYQm8FiuvMdf2q1G6ph04CaxeqZ+1enPCmXDCJCEaBkFxwKmrD8eRmZAX4kyJe7hVcBGdX96DjYp39i5FWH6FdeZOhoJrJ2ckxqFNaGDg+y+1OkJvkVICXiHbFKniIwaXWC1D7wsjay/lS4o3UovTNfFgM6cQQgLS6TPJgdeR7Drc6/PRgz0TM0sA7rzs/UfO8zIkEfI2IoWN3AzevBsKUWKfsQ7ndhCfT+S3h3N88dd8bc4u

On Wed, 13 May 2026 13:24:45 -0400
Rik van Riel <riel@surriel.com> wrote:

> From 9de86227b917c49315b7b67aac3a83afae8d792d Mon Sep 17 00:00:00 2001
> From: Rik van Riel <riel@meta.com>
> Date: Sat, 25 Apr 2026 03:33:54 -0700
> Subject: [PATCH] perf/ftrace: Fix WARNING in __unregister_ftrace_function
> 

Can you resend this as a normal patch so that it can be picked up by patchwork.

Otherwise it will be ignored.

Thanks,

-- Steve

Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F413C2C08A1
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Feb 2026 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771258414; cv=none; b=haWj0PSkQ0e/BIMt98W12n1NvKVUNIgWx03QyAOrqIEMpf0jipGGIgRW9j6XDV6+xTKl5iCE/wJ5XkTngHaLqTLbV17huuDNO64XvXqT5gt9GCqJA8odblGvn0qf1qjnKum0zs2jrJV9egL24OO3nuaO/2e1RYHA+Src9c0eg2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771258414; c=relaxed/simple;
	bh=qc7/hUJjUzJlnkRhkCNiAFDT455mPOzjJ2hcG7qZ/cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BoZ5OPdxP+xHcbn+ovGG+/0L9kgbI12/rBc7GZNd9sGl6S5iepkT/p2bC2J5w9JQvoFN5yDoefjavkOvUoQyfC6pjACwKAnOVMzapnPbcDYkQrTTGwcW6SZ5+E/JColqr1DiOp49fpXYN0WtRUQG9h3BkdIiYFv682lGVtMyaB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c8XLrnX1; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c8XLrnX1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771258410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yEJ5XvR25sXoqOGNkg3EARgXM9Vsv7j5sELin0pzSgk=;
	b=c8XLrnX12RT3ltlhocYhfvfPUctuYDZKleznOrVR3zi9mOSYePzGZRsxPNmGk6J/FUD3ME
	ZxEmQfr9BExV+vYE5W5cv/Ix/VhWA2BpWQP1DBxZweQqzFInCyW1HtDzt67O5149Px4gho
	wObQ+K2SdLr6UpeJefyD4jzhGWZVPMs=
From: Usama Arif <usama.arif@linux.dev>
To: Thomas Ballasi <tballasi@linux.microsoft.com>
Cc: Usama Arif <usama.arif@linux.dev>,
	akpm@linux-foundation.org,
	axelrasmussen@google.com,
	david@kernel.org,
	hannes@cmpxchg.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	mhiramat@kernel.org,
	mhocko@kernel.org,
	rostedt@goodmis.org,
	shakeel.butt@linux.dev,
	weixugc@google.com,
	yuanchu@google.com,
	zhengqi.arch@bytedance.com
Subject: Re: [PATCH v6 1/3] tracing: Add __event_in_*irq() helpers
Date: Mon, 16 Feb 2026 08:13:21 -0800
Message-ID: <20260216161323.4098568-1-usama.arif@linux.dev>
In-Reply-To: <20260213181537.54350-2-tballasi@linux.microsoft.com>
References: 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Fri, 13 Feb 2026 10:15:35 -0800 Thomas Ballasi <tballasi@linux.microsoft.com> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Some trace events want to expose in their output if they were triggered in
> an interrupt or softirq context. Instead of recording this in the event
> structure itself, as this information is stored in the flags portion of
> the event header, add helper macros that can be used in the print format:
> 
>   TP_printk("val=%d %s", __entry->val, __entry_in_irq() ? "(in-irq)" : "")

Should this read __event_in_irq() and not __entry_in_irq()?

> 
> This will output "(in-irq)" for the event in the trace data if the event
> was triggered in hard or soft interrupt context.
> 
> Link: https://lore.kernel.org/all/20251229132942.31a2b583@gandalf.local.home/
> 


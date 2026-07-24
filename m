Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88594749F7;
	Fri, 24 Jul 2026 22:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784933267; cv=none; b=T0G1FDmYRy7JR67ZXfQuVz+TaRTTgUTQsXyNFwh5/LeNqjGdOE9rP2oKb0UD3f8mJvTGYJjB0nnUmcoM0wOvs3aFgRBwewqPSxR/dyn4V/fpqvWxaM0zjurleFhWlCcuWNs4nj1WOYhwwzcnjkbSm61tSacCqlCmauXr05JBd04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784933267; c=relaxed/simple;
	bh=JE3xXTeKorYeWjAFXGxFKVDr2Uk1PuwIJQ8n2fxt+EI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fGUB45YvLnJic1WsDH9f8UsR+zRP3ID76w5+r5GEROYxj5/MZT6r2yAqxcmXmV23lIZjP0YoTwxx5vsGKBNnDsCAT+/zdJ0k65WTeVvOZV3zitbGMR2fJRnoumBzGwNStx0akAoxS94KWF920KbVn90vCIsdho++JcIIPdPHAAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 4F8E41A01EA;
	Fri, 24 Jul 2026 22:47:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 8CC9E1B;
	Fri, 24 Jul 2026 22:47:31 +0000 (UTC)
Date: Fri, 24 Jul 2026 18:47:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ftrace: Add global mutex to serialize trace_parser
 access
Message-ID: <20260724184757.502183d4@gandalf.local.home>
In-Reply-To: <20260723133404.1926732-1-wutengda@huaweicloud.com>
References: <20260723133404.1926732-1-wutengda@huaweicloud.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 3mhq4ff6zj1rwpyjouwjh6txob3r4fir
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 8CC9E1B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18UIBK1/w4JNRRMUmKexfeNrkoYNccd8Zg=
X-HE-Tag: 1784933251-714667
X-HE-Meta: U2FsdGVkX18oQC2JNbRZ7HgxxyU34IYcxZMoUFG52y1isuHNcVhw7f5UVDpz7hoyTEk7Cqe39cvFis00/QJ74qwmBhAztrNzfaPFo9VJ8Y++DSvRSx1k6jSmmlo5/ZHixuyUIQPnMmOWAnMoVEZF3tg7Ihq08zbQitPrDWPJ7Zr+gnpafJVOfw5OpDBHIb9gFRXjAP2v5s5H9/RdnCZ89ca3A2bGg2xXZa9iCwuXccI0M/2+S8syPLasubxiAMiEYhE+PlP5KxT7sK3cTbjTZgkEd5pnzthF+Hi5xWeDuG8Cw42XMN3RjsuKe7TkBDorLGj8uQj+YY3S1P0Jm5oBA+HWUZoVNYHBcxFmoMBiRHEkTXnBDxH04EFsaqojQPXB826fx4gVQyqDTIwY/adqtA==

On Thu, 23 Jul 2026 13:34:04 +0000
Tengda Wu <wutengda@huaweicloud.com> wrote:

> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -1097,6 +1097,12 @@ struct ftrace_ops global_ops = {
>  					  FTRACE_OPS_FL_PID,
>  };
>  
> +/*
> + * parser_lock - Protects trace_parser state against concurrent operations.
> + * Held across trace_get_user() and subsequent buffer parsing to prevent races.
> + */
> +DEFINE_MUTEX(parser_lock);
> +

Sashiko pointed out[1] that this should be static. And it should. Could you
send a v4?

static DEFINE_MUTEX(parser_lock);

Note, you can ignore the other Sashiko comments.

-- Steve

[1] https://sashiko.dev/#/patchset/20260723133404.1926732-1-wutengda%40huaweicloud.com

Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C172F39BD;
	Tue, 11 Nov 2025 23:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762903701; cv=none; b=J7tx2GkF1UPDY6gbM3rmKdbn8zAkZARIKCASCJg0RemTsCv3DkQwqN4N1bOYtn9YgLpTk0nJQ9VatKUMeNeB0FnzMaFz+8yBwxQ4eWXE8erd0RwIK7k7p4MwCdMdRLJh91qFUAFBwPI7s/C/1YyAWKXjMGp6CToQ/nzRL212c6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762903701; c=relaxed/simple;
	bh=W/djOArHAR3toGu0GxNmDGHGKwf1xQnaHuiWeLA871s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q8GPesVCKB5NKHP3mkCRukVx+rHqJrUdNECn0ZIIqcYo8PbBbMAkvl1SdDLJkr1zHS4aUkJsOj1oaVQjg0Dep94FmlMrwxF1w3BpFV2h2CfNm+PCBw+pTMgxZtQBknNxj52e8va6pzecBM3oQ0hz8LIOHssv8yz6Sk/mY0FvgJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 916A5C019F;
	Tue, 11 Nov 2025 23:28:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id CB48620010;
	Tue, 11 Nov 2025 23:28:09 +0000 (UTC)
Date: Tue, 11 Nov 2025 18:28:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Sven
 Schnelle <svens@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Donglin Peng <pengdonglin@xiaomi.com>
Subject: Re: [PATCH v2] function_graph: Enable funcgraph-args and
 funcgraph-retaddr to work simultaneously
Message-ID: <20251111182820.4b44cc8e@gandalf.local.home>
In-Reply-To: <20251111135432.2143993-1-dolinux.peng@gmail.com>
References: <20251111135432.2143993-1-dolinux.peng@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: CB48620010
X-Stat-Signature: njdr4u56iyo4ydge51tbw7539nd85qyz
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19K+o1DJOW6fTX5CjUPWkyA2ntbNEJBtPY=
X-HE-Tag: 1762903689-389407
X-HE-Meta: U2FsdGVkX19jthbkaP6qfnlVE3bun2p22Ro+nxeN8sXS25zr6cv+35KjxMXUUj9qV3zJkRRcfCAkfIg9GnVm8PuY3DlM8dp4qfUL40FZEhh7PQcs2txQaajUq18JlQA65D8WvmsWP4nkGmI8ipQu/LGXl5u8i6yVANlP7uJqrv6M1+E30jZfmV6wxir7ZcGQbZJtaS59OUWKwbvx+5PFVIoZdyUWP30Mcpee/1bPsx7t8g1dMYSbdMnSxDtlONL5Ilbsjbmp9FguLFF5qQiFruRXhUIYgyrjCdVUCRhhWoreFW/HPIrHYsEo4snnXiABaH3gV0NX1ymGbpNl96F4j15YmOlkcM9++b+cw5FLAPHND5qgJ1bovqFKsHh3+YmQ3WCjm5VVz58=

On Tue, 11 Nov 2025 21:54:32 +0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>

BTW, are you two people?

You only need one signed-off-by. Which one do you want to keep?

-- Steve

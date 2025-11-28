Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FDC2AEE4;
	Fri, 28 Nov 2025 03:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764300443; cv=none; b=SXijd4dYCHRY3WoXWGUJL6eWbLff0rw2+VR2eC7+AQp+hKT3tadXUzlFrm6SCYp8NlpHdDiN6xN1BHbY4DgnCwOVMNkGD+XFaiVwa47AQ1lsMyMiCLQqi0XvPiKs8sh478BjMuE1jUXHSRm6qxOF06woq4Q1pQaTpITy9hR/F9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764300443; c=relaxed/simple;
	bh=P10db3ts7PPUPNNn92Vlx3E8LzLg0pwbGLrEltdzHBY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ibBbOKqlvCb+KqHYed7dBHHpBGPDU+qzMH+0RvRbyYoqbbPdTVxTIDbU7N3UG5b2HuSBhtUi8YtwC8UJ1G7/XpONKsTf/VghCs0e/yNB5RddRiRMWmjBu/lv+xlppL0NNjjEwmWsEYn33pe245S+PNP9QmUecHKDQbufkHpXwP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id F2CC61308C1;
	Fri, 28 Nov 2025 03:27:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id E73842000D;
	Fri, 28 Nov 2025 03:27:11 +0000 (UTC)
Date: Thu, 27 Nov 2025 22:27:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <kees@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>
Subject: Re: [PATCH] overflow: Introduce struct_offset() to get offset of
 member
Message-ID: <20251127222710.324357cf@robin>
In-Reply-To: <6219BF5A-0EC3-4111-A329-D35244C9714A@kernel.org>
References: <20251126145249.05b1770a@gandalf.local.home>
	<202511262356.6FE5084CB0@keescook>
	<20251127204342.05fc985e@robin>
	<6219BF5A-0EC3-4111-A329-D35244C9714A@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: py5iexwr5hpbaiwk6mbfbieygaqofhr5
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: E73842000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+RmDkHZWFGs6lGl4zPjX2RATp304l1LcQ=
X-HE-Tag: 1764300431-518083
X-HE-Meta: U2FsdGVkX1+soda1kokO/cvLz18PzGqMCiC+lLSFcGQmCq6HNplI3L82wV+MTS59HmS7FgzpFyJCzrrkBqNQHp3tsWb0+WamBK+xGt6KZgjILPPKPx3h+kQDXThX/go+Xwk3rWrexGiyP+8750hQl5mzfKmEpEYFWf6DA6oxbxeiWf6PBFWJtzE8n0f8nyIjUGDRV9SFPqxUKZF8TCtCiAnaajqoTR3AsOml7Pb+xyM5mmw8lJmcgYSwYQkyEnyP0q73zxF1Eb4pAeiykXrvEUH9M8poYAVKPvwiBFZz5x71GvH8R26a6GWPRMhXN5Xh/DQNXBpeJ7X+p+d4OpiGkbtQPCq+MOEB

On Thu, 27 Nov 2025 18:00:01 -0800
Kees Cook <kees@kernel.org> wrote:

> I'd rather it keep the same API style as struct_size() if it's going to share the naming style.

Fair enough. Then I won't change it.

> 
> If you have an instance and not a pointer, just slap on a & :)

:-p

I guess that would work. Although it will kinda look a bit strange.
At least to me.

-- Steve

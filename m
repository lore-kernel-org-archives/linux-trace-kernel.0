Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AC430BF68;
	Fri, 30 Jan 2026 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769783244; cv=none; b=qwFNao6bo15QSlpkGEwCvDSt4Am1pjBPyLAQx7Ba2nAgq+XwGuVNS+iRu1upPVBBRbz5N569YSp578Bs8Eqn55W+hRoWMM9rkKbLLFK6XucoHlDHgGbkERe/VOEFK3rkvp/qrZEaGn8C8Jgi2F++AP1Itc3x/hlolhJ0x4M8/os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769783244; c=relaxed/simple;
	bh=qNDLmub+dZcNCz3k8/30xXTErfOyg7WGZKIWBRVxCZo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V3VmToq+82y5H2vreS/TyK5LVQnxvWXUB0zTKEcos7akHbQuGMdxUh2x9KSKzmCsvHdOdZaC1wGzLPd4DzG5zpCYNM2nWPAvgrp3g37ZsR/+aPxfjkNnm3kL7Jz5p1BDoarE9v0J935s7z9MLWAG97Bl0c33YCWvgNaHT/JSjaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 341EB1606F1;
	Fri, 30 Jan 2026 14:27:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 86D8617;
	Fri, 30 Jan 2026 14:27:19 +0000 (UTC)
Date: Fri, 30 Jan 2026 09:27:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] tracing/Documentation: Add a section about
 backup instance
Message-ID: <20260130092734.57060f0a@gandalf.local.home>
In-Reply-To: <20260130092329.23ee13f9@gandalf.local.home>
References: <176955897718.2786091.11948759407196200082.stgit@mhiramat.tok.corp.google.com>
	<176955901173.2786091.7719483008240216705.stgit@mhiramat.tok.corp.google.com>
	<20260129151900.44b6182c@gandalf.local.home>
	<20260130222449.bc25b973597721b6a22e4f6d@kernel.org>
	<20260130092329.23ee13f9@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 86D8617
X-Stat-Signature: y3kf73izrydcb1u1sphj51uipu4uxcdc
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+sZdkXBIelWUd8oBNLHOqYXtspuGLdi9Y=
X-HE-Tag: 1769783239-985882
X-HE-Meta: U2FsdGVkX19QWsXrkREE1Fu+qG4HxyqSzHRBSOlS7sDpNcNSgZKa4M9p1S5CNDbzvovr+keRAkHUZw4BzjxlLHnnEbfmKIysgL+xAs9DAR7+nVOd7Oibu9tLGGAQi8KojD0rTxzLHmHPkVX7/x/SH+N2CFhyzjvCf+IrlGl55QTZu+Xs9IHnfLO1q1c/2FiECfGUUtKbkVLWrupGKUFLWT9VMlM7L/0KFlrazafLdFFY1NTV4CA2+1pKvw4qsJaKCtu8sujMZ2nwheSN8aM7lF0N6f3TDWmKWOXmRv22zIY3J2W5UHF+Imiweihb8/YAmAYN1KufKgrvl658mRmDAbnKFgLQS2HqI5MeoeHeLN/qiX+U0wZF+iWwKpSIahzumC3AUPwdoC86Zcvoca0Zyg==

On Fri, 30 Jan 2026 09:23:29 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Nope ;-)  In this case, leaving out the "the" is appropriate. Now you would
> need article if it was: the "boot_map" instance

  "need the article"

God, I can't even get it right :-p

-- Steve

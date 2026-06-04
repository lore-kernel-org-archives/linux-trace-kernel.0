Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA963C37AC;
	Thu,  4 Jun 2026 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780563136; cv=none; b=BMoQJbEOPGbrvWGMagxXWULfQ22ROfgPL4vkTBuXv/OvQmrXBKLKe3z9g9CHhMfRdSoUcoacTRU6shAfX4DWUtJorVjgmmPN0jIaIeUg27t1Tcf8x+fmd+n8vY8vDdsBAvLofL9dZOOffs+9oFr6uFjIISlafdE1yU1muLjR2fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780563136; c=relaxed/simple;
	bh=10azPskImeIlNEhi6GQJ02Qf8zWisXMIDiEIA8eXp1g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZHeLJ0LE+/NA1cxkp4dh1r+hQqMCt6hm0xnXXBzsprr55FCcHw3YhTFZSuR0YUrZI6W+QIb1wbuT9Qb7KBLy8M59RK9ceJTu9Bjkr9l71ybwFV780CMLNMQjQLi30EMqd39n/ETwvUQQnrlo8KaeClpN57W5lE83prW3/LqEpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 9CF96A06EA;
	Thu,  4 Jun 2026 08:52:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 821B617;
	Thu,  4 Jun 2026 08:52:05 +0000 (UTC)
Date: Thu, 4 Jun 2026 04:52:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Eva Kurchatova <eva.kurchatova@virtuozzo.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, peterz@infradead.org, jpoimboe@kernel.org,
 samitolvanen@google.com
Subject: Re: [PATCH v3] tracing: fix CFI violation in probestub test
Message-ID: <20260604045203.77fc710a@fedora>
In-Reply-To: <20260604084716.99e2be26a21c71d6e4ed8270@kernel.org>
References: <20260603153147.573589-1-eva.kurchatova@virtuozzo.com>
	<20260604084716.99e2be26a21c71d6e4ed8270@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 821B617
X-Rspamd-Server: rspamout01
X-Stat-Signature: 3eb7eao6j3wiy7fs1ofwh5xc3scxae4a
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Harp0XexfJJBCbFnlRMJZOxmzHacb9bg=
X-HE-Tag: 1780563125-13778
X-HE-Meta: U2FsdGVkX1+qXUpwGuh/xsO92eG6jQTySNMidNiLJcovHGevb1Bz4fFP5ccb3wTeH1h7fIv3sMpaHQX9BcTv4QfUHzEmMTM6fev4SVg13utRIVY+ajLLTpa1fqh1WyzaUXsafqZuxwmCG1g56MNVM1laovKIOW/nU2/LH3hmk4PaOUILO6Uk6g/OjG/bJ/qLwOAcBCHT7w4480GO5nt397wG24AbvvlJChJXFvfJXCfm3NACELzfxPPtFL7iWzqSpgmRFs2lpRfkiTwXV432OSrAD4ISga7rLtJ0kat9WQ2QkDWgHApJZlhBPiJBvTz7I3D1CowHvQnOtWwNAg187OoszRumhzZU

On Thu, 4 Jun 2026 08:47:16 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks.

> 
> Peter, will you pick this fix because it fixes objtool change?

No, it's a tracepoint change. objtool only affected it.

I'll take it as I just finished testing.

-- Steve

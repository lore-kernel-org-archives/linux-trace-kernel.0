Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377943F6C30;
	Fri, 15 May 2026 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861812; cv=none; b=ELIM8oWoh04/hmTm4U73cPf2ciiFSMypET+1BvB2NUsp4slfRlz/qVdkCuGXVAjSM3mMxsALvU6LuuaieHOwuEJ4jzjxnrKSYJ80D8Jf20Lle295ifu1pvAdOPqpCwoC7c3PZCsA/zbjGds6QgMh7DgtEwdJhWOVWaClmw4y1/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861812; c=relaxed/simple;
	bh=KgatLovvioxlTYvliLi6/mZEFLPMibgsOgoovw/U/y0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PiuqU5nEefqSGh1eXkYVL8lafbcNH19hBJL+/6eiaHaByeOwNJ8D9V+fjrFXh5WJVzFON6BNry/vL+SfAyVrxRSgA6zqR2EK5UFyRZBTdkpQw4UWU850De67aADiz+t6bJP10oqaVmfmB2dYZ+GTYRHu2Z3fYRkUT4U0VDonbKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 24CAE1C00A8;
	Fri, 15 May 2026 16:16:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 27AD42E;
	Fri, 15 May 2026 16:16:42 +0000 (UTC)
Date: Fri, 15 May 2026 12:16:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] tracing: Bound histogram expression strings with
 seq_buf
Message-ID: <20260515121649.207f2291@gandalf.local.home>
In-Reply-To: <20260417223002.2-tracing-expr-v3-pengpeng@iscas.ac.cn>
References: <20260407153001.1-tracing-hist-expr-pengpeng@iscas.ac.cn>
	<20260409123001.1-tracing-hist-expr-v2-pengpeng@iscas.ac.cn>
	<20260417223002.1-tracing-expr-v3-pengpeng@iscas.ac.cn>
	<20260417223002.2-tracing-expr-v3-pengpeng@iscas.ac.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 27AD42E
X-Stat-Signature: d6ktcj59rb3cw5nd1x3kc96c349serrj
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/C61JYH+N+3EhX6VFH2YLIXqHM/OiXdeY=
X-HE-Tag: 1778861802-183698
X-HE-Meta: U2FsdGVkX19QXT0ZNtu3Lnc9ad41jhMlFc9YWt11o5jk5K2AoGw0w0o7U2gPG3ofrrh6tODzHVmVgpNstvCWXXz41vBn9nCnLuyfpbHxht5u+KDLQwYTxshGJhylXDa9h3/xinGFott3hx3iX+rfhB4fBAbbTPJLjT604Vx2RRsMWsTO6ORnqY7r6YLuiQnt9MO6lxl18tPttl/O6vpjlvnMzs2Tlt84K9DpwA/M0TuB6N1FfVVeO8DsmGM5R6XIk9yk9OnWDYHGPa2ic63c52noRYh97g4h6u0twgBaYbKyfbLHivpoJLpxMO72z3H77NSlNYElqydPowEfqsGdLm9EExxXxIEW

On Fri, 17 Apr 2026 20:28:00 +0800
Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:

> expr_str() allocates a fixed MAX_FILTER_STR_VAL buffer and then builds
> expression names with a series of raw strcat() appends. Nested operands,
> constants and field flags can push the rendered string past that fixed
> limit before the name is attached to the hist field.
> 
> Build the expression strings with seq_buf and return -E2BIG when the
> rendered name would exceed MAX_FILTER_STR_VAL.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---

Things have changed and this no longer applies cleanly. Can you send a v3
rebased on top of v7.1-rc3.

Also, make sure it's a new thread and not a reply to this patch series.

You can add a

 Changes since v3: https://lore.kernel.org/all/20260417223002.2-tracing-expr-v3-pengpeng@iscas.ac.cn/

to that patch too.

-- Steve


> Changes since v2:
> - split the ERR_PTR() conversion into patch 1/2 as requested by Steven
>   Rostedt
> - keep this patch focused on the seq_buf conversion and overflow
>   detection
> 

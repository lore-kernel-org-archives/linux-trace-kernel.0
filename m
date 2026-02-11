Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D97352F8B;
	Wed, 11 Feb 2026 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770834793; cv=none; b=dLqZExQ9Yhw6fLJnC8tlpQpAfR1fued1dhoc5FhqCHQeI353OJLt2eaE7Zez6ICDcvOFZsT0irwGF6ct+Odb/73GERdO+QPQeEUFrpoQEGknGNLIhQL3FmOSzqEJB/B18mRbb9pDeX39V0sksX/1y66cRlAeR6S2enmneFaDMHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770834793; c=relaxed/simple;
	bh=UqDoK/HTi3tOC0r2xE/+tIz31ktkFqFEl8qmLmRSRnI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQlAmfylJiT0iidi8T2Cse6aAcXbl7ElBiZjQ1VfMXQ9LM89ie1FA+jU4vE1UHgNIjHk+R/etd/uGWnJIRjkiFCOFnj5R30TEpwHHkayaoJTg4tfeKaPT3riv3C1b8PZ5nkRGhldB0O2mzFmIPghd3+k222BrhKngMlzXlyAB9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 2F1B01A052D;
	Wed, 11 Feb 2026 18:33:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 6427520;
	Wed, 11 Feb 2026 18:33:03 +0000 (UTC)
Date: Wed, 11 Feb 2026 13:33:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/4] tracing: Reset last_boot_info if ring buffer is
 reset
Message-ID: <20260211133302.2a2780ff@fedora>
In-Reply-To: <20260211132848.2bda172a@fedora>
References: <176991653525.4025429.12655335935351822711.stgit@mhiramat.tok.corp.google.com>
	<176991654703.4025429.9641092475053587709.stgit@mhiramat.tok.corp.google.com>
	<20260204204049.0f7dc697@robin>
	<20260206225051.f22b670b54e8906a4bc1bec9@kernel.org>
	<20260211132848.2bda172a@fedora>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: mkgd7a6jgbgqkwb4d8mn4ugaq1rwwagd
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 6427520
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19zhE6Rg2F78nzOofdubyME4+FGR74MaUg=
X-HE-Tag: 1770834783-58378
X-HE-Meta: U2FsdGVkX19YdFzGVi13c6xoO56ViWZ458AxAB9wDc9QXK5gn4mXqgNyNmwJcqcqGhV1BFVIdSzu6RrwerTB+EdycKTOMkVHwg1LV7bqDedekWwwWS9BIyl5RMFQS0YoztKmv3aEERPS9EudP55tSbrxbUA7LtxYABv3FHfLxjpEL/wE4A7M1tViMeabXengjByC44RV05opuaAxlxtakrtjAn8XU5NOfPh6c2sqHw42ReUJtD0H2vAadW5WVBo9+G9uEpzBi1tckNX1anZqiQI1S4JOJzbwJi2M6k6Vyi5RE/43WXqk+k96u9Msy37QnOBKgjB8QXStormSNb2DE/j5foByYrLawj4mPS05OYvQ9x5CogXitY0OfRqDTzGBDXNbz0+cf+AS8fQZFtYd9g==

On Wed, 11 Feb 2026 13:28:48 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> I have code to move all the snapshot buffers into its own file. I'm
> going to drop this one as I think leaving it makes it more confusing.

Never mind, I was looking at the wrong patch.

-- Steve

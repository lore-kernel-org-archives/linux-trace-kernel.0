Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F6F275B12;
	Sat, 12 Jul 2025 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752333197; cv=none; b=Joswp8a2TEG7eB+omNnkX5+fqMilZNZQrhwS4+4SVgPc2ydD9aQdAl+E47nUK4FOzLG/tMJCTtTujyRMm7T/43wzppapsA3SXPJNmwT5O3Zdq47pkUTTvNOw9jK6/iFfgGffRbscpBF+3Tiy+jOm84igeeOJy7aU2Hy3YHusrsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752333197; c=relaxed/simple;
	bh=TxM6V5lQNkqAI2vum6w5k/qqAHVj2nw6yWinElESfns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ob+VYrrlBls305DGvPodSdBZ2UGyvLgJeNBrI9F07yt7OThvJX5lvj5HRV8o1Nsq68Yiwx6+B5LIjzjX/tgHohDbj92leCt1O1YGw/UZdSk4sta0un0QmGMpfq0ue7SaOngCBQIeYCcsZhbksvOv9Chs1HYcVxLIWjh7JEzQdAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 786C555B63;
	Sat, 12 Jul 2025 15:13:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id CF4DC40;
	Sat, 12 Jul 2025 15:13:06 +0000 (UTC)
Date: Sat, 12 Jul 2025 11:13:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: Remove "__attribute__()" from the type
 field of event format
Message-ID: <20250712111305.22586237@batman.local.home>
In-Reply-To: <20250712103732.79c7b9e1@batman.local.home>
References: <175197567999.977073.8989204607899013923.stgit@mhiramat.tok.corp.google.com>
	<175197568917.977073.2201559708302320631.stgit@mhiramat.tok.corp.google.com>
	<20250709131107.397a3278@batman.local.home>
	<20250711143703.60a1a9a9f31a45f2000eec9d@kernel.org>
	<20250711120322.4ddb9b39@batman.local.home>
	<20250712204524.13ece418f90ea66d4bd0e598@kernel.org>
	<20250712103732.79c7b9e1@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: CF4DC40
X-Stat-Signature: s1ymsnhyputens5ishmdqroc9x6s5576
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Oy2ACIXxHoH8Xg8IjNLWVkjTlIXRdxP8=
X-HE-Tag: 1752333186-143848
X-HE-Meta: U2FsdGVkX187K0UYmllEuW5yt+mnhLMDSA+mOWJTuAEO3u3c53yBj0jxpaqJRVOZjrSE5NmQEkZhZiJJspaB+G2DcgEKnRrUfM0ni97GA4rNYvBD+1mSe/W9qTou0kkhwSEi8c44ZuaheHmQKBFP9cjT2agqQjwx6GMbpIDFfSc1U7p0qLe9VsWgh+SIel5sxp2JUwWuRSydzT4Dwiz3VSnsaUnIDQLZYJZie8kTlHUfD5KGNHn8l7M7dHhZJaWDwstJMvh3arA/xUxIFKco/WdT0wgWcLjZOy5tKDfSikWgHiC+1M9cRAaFhhgVJRQR1Dns8zrj662B5aT0VrYWWkKInjmnVF6ELF0KSSCvn3WAUcSQGhTWLq06+rf7bhrh

On Sat, 12 Jul 2025 10:37:32 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> +			} else if (need_sanitize_field_type(__type)) {
> +				sanitize_fields(call);
>  			}

Note, I just cut and pasted what you had and added "sanitize_fields()".
Obviously this isn't going to compile, but I just did this to show you
where the changes had to be made.

-- Steve

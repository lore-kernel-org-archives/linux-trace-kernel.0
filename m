Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D74220F37;
	Wed,  9 Jul 2025 16:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752079884; cv=none; b=YKU7YT85wQEDZWUxp/HSj12LIQZYnCr9HkbG7TzycoD5z8BQmUBTd2+rqE9IX0R6g3DYEGf/N0vYiu4fVxSnC/mElQckozfM2oHV03CwMfYd1iUrwrpbF4J5sDQnTq4NxI7r5Y/ZeXhY/BWDeZgpnXhByLY8hDrYmGHQ5LU9RXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752079884; c=relaxed/simple;
	bh=tfc8AtxPw+ap096NeufOKoTHLGveoD4nijUKSFLapCM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sLkHWWn+Y7iHWu9XlVWxGaF9JySjRZCWZEj8xhCMbM+LwUVSsO3nADex08y/lVVpJjsg8DpyYzlRXCjwfhOHObk1o53WVQ//qAJUWpHz3AT6bdlYzxf5IrR3kdSfe+O4FXkO2430+JQmQ+zD6MhvqmwKo0oLM4AKIKyvz3OPtJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id CE42B1601E0;
	Wed,  9 Jul 2025 16:51:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id F3AC034;
	Wed,  9 Jul 2025 16:51:19 +0000 (UTC)
Date: Wed, 9 Jul 2025 12:51:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: kernel test robot <lkp@intel.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 <oe-kbuild-all@lists.linux.dev>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] tracing: Remove "__attribute__()" from the type
 field of event format
Message-ID: <20250709125118.3caad8b6@batman.local.home>
In-Reply-To: <aG3AghTb49v6BBYn@rli9-mobl>
References: <175197568917.977073.2201559708302320631.stgit@mhiramat.tok.corp.google.com>
	<aG3AghTb49v6BBYn@rli9-mobl>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 8uy9a5h5hxkbs1ahj16xa3zbcxdj5b5h
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: F3AC034
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+X4E1czMyTNgkK5aFe39jLFCsv4YE57OU=
X-HE-Tag: 1752079879-312940
X-HE-Meta: U2FsdGVkX19o7+dTY0sNErQwyWuNezb5QDNlPJ31aVp6aSSSZc2fcsylevVJnnHwLfp3ZiV1+1z36y3olGQ4pcQcK3EQAzs8pfppyckTKBqe11qQxgByb+Efh11hx3foHz+qI6sMNKbMPiLWja+sMQiGCZFcnFASuAEaR8i4aXO9+pkOqIkEvY5u0MzWChOFyO16ZImjW0Gb/cmxBc7d0rXnR6gpuvpGIUF2VJPFC2wJzGw7T6PMeWnmQbm/7rgwCnizydX+KQYYIMkhc5+/K0rzLLzCWMLUBllM0yNq+o5q0gTAYULKJfU/SCSHw7E+N+0V6f7bHe02MyUt5wDbmm3lXfyBn2QJ

On Wed, 9 Jul 2025 09:06:10 +0800
kernel test robot <lkp@intel.com> wrote:

>    kernel/trace/trace_events.c: In function 'sanitize_field_type':
> >> kernel/trace/trace_events.c:120:30: error: initializer element is not constant  
>      static const int attr_len = strlen(ATTRIBUTE_STR);
>                                  ^~~~~~

I guess this could be fixed by making the above:

	static const int attr_len = sizeof(ATTRIBUTE_STR) - 1;

-- Steve

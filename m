Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EB118DB0C;
	Tue, 25 Mar 2025 18:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742928085; cv=none; b=GNT3j9c6DiIG8Gzpgqc5+xMs2iVPeXQq+GQgdkrVq/I4SwrB0wy4b4TpIp6wKUlOUjVX7wjHGcrKcj8XGykqxn+uyjjYtixFR7/YXPOcFow+6f2cYfYBUXbEJnprwJ4EAvhm0aQiD4ce81QGNmLFMvQui+XovuuaHSbf6c+PGgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742928085; c=relaxed/simple;
	bh=3QlJ/fqc/eRBJ/1iWDzYoLVh3DKkcdnUjvWURgKyYck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kpPqXbsuzedsDJXfEhTmh482CI2xuGHw/UX3F6Zw4aZHJ2X+5lBKPiI+RxFthWPBb2zIrAkZc60Oq5QSMMs2EZLCHF+/KwwKgukzGHCSpf2S0pzSsZZhasfmLhBgLIF6K+GPKJ3aoX2Ge06DPkJ3tpR6UamMx07tjkcwSEHpQWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F73CC4CEE4;
	Tue, 25 Mar 2025 18:41:24 +0000 (UTC)
Date: Tue, 25 Mar 2025 14:42:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] selftests: tracing: Enable fprobe events before
 checking enable_functions
Message-ID: <20250325144208.1149b51c@gandalf.local.home>
In-Reply-To: <174212771234.348872.14455715715729686727.stgit@devnote2>
References: <174212767109.348872.18231451508464729427.stgit@devnote2>
	<174212771234.348872.14455715715729686727.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Mar 2025 21:21:52 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 

-ENOCHANGELOG

This still needs a description.

-- Steve


> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---

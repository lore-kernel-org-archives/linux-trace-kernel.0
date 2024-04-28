Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966E32905
	for <linux-trace-kernel@vger.kernel.org>; Sun, 28 Apr 2024 04:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714277859; cv=none; b=BOfOIm+ZtXVKrs9fjb6TlxZG6l25hCT+rUDmI9aTznBEeAAUjf7FQW03Tap7J7HGy/TrRCyjOygkLdSH7B0SSI9LpwhRGzUjvaKe/iN2s1IjAC6JRtJTNPZSI8wm5k5bU0v91IbtLooCv5Fza4RgmyI0U8T4dpjs9MW6Ql7s+qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714277859; c=relaxed/simple;
	bh=MmmvR+5+WXsG339tj5GTNORZ+WBAub98KSTjh+WIdxs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fiRPu0IJiZ7V92E/k994LUH1LRc/+EMP+/asTJiEXtIoSIobiY8adrpYxJsnpd3bTt+leuA3pjamO2+1UVkDzSWyFlJCMAci87t3JtZY/anPXHQ36j/E6Tbxm3n16HAoAzkL0FwX1BhYOs4zcOOhWULoxnAtcNkM93AN1MfeY0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D2EC113CC;
	Sun, 28 Apr 2024 04:17:37 +0000 (UTC)
Date: Sun, 28 Apr 2024 00:17:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Bang Li" <libang.li@antgroup.com>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 libang.linux@gmail.com
Subject: Re: [PATCH] ftrace: Replace ftrace_disabled variable with
 ftrace_is_dead function
Message-ID: <20240428001732.0009d6a2@rorschach.local.home>
In-Reply-To: <0c43ff81-042c-4705-8a46-543c47e2c203@antgroup.com>
References: <20240419143844.97847-1-libang.li@antgroup.com>
	<20240419214054.688d624e@rorschach.local.home>
	<0c43ff81-042c-4705-8a46-543c47e2c203@antgroup.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Apr 2024 11:50:29 +0800
"Bang Li" <libang.li@antgroup.com> wrote:

> Thank you for your explanation, let me understand this. How about
> replacing ftrace_disabled with unlike(ftrace_disabled)?

Why? They are slow paths. No need to optimize them.

-- Steve

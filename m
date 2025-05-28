Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB8E28641B;
	Wed, 28 May 2025 16:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748449787; cv=none; b=EyY4JJZu5cJNd2Kk2cZeZ7EokZn2xqp+QaXpXhnN5bV346ZPigUEJ4ID3HI18hcrllhOOJh4wJ44TH/Ug6NmkN9PD0CJAQkYcO82FlD3iYvsK2VR83jWC76M4TYXOLSksDk8QTzWuoPlNvcBumm2oT1FAO9PhH1U6rTTc5imv54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748449787; c=relaxed/simple;
	bh=pujbF8oV8nkU83fk8rqq/LxjCEyaQOIc104Y3Esq8I0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OaFzAoAWqRNSH25q92f7clDK52G6QCQyD2bYcfTHhIcpFFm4NaDiaJyYBb2rsZdQfgFbRzWJm5A5Ph1KYBb6CyL4Etnml6HF9no5FENQXMmebPorIqpzi8TXDMd7/v5P3DPhGXocWrN3lKf9cdvwgF7KcYj22AEoJk6Ql2aZWaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91E8C4CEE3;
	Wed, 28 May 2025 16:29:46 +0000 (UTC)
Date: Wed, 28 May 2025 12:30:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring-buffer: Removed unnecessary if() goto out where
 out is the next line
Message-ID: <20250528123046.5577977f@gandalf.local.home>
In-Reply-To: <20250528093455.e710b3783bbdc93f8be66625@kernel.org>
References: <20250527155116.227f35be@gandalf.local.home>
	<20250528093455.e710b3783bbdc93f8be66625@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 May 2025 09:34:55 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> OK, so this is a kind of cleanup.

Correct, which is why I only added a "Fixes" tag but not a "stable" tag.

If someone wants to backport this, let them ;-)

> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

-- Steve

> 
> Thanks,
> 
> > Fixes: a389d86f7fd0 ("ring-buffer: Have nested events still record running time stamp")
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

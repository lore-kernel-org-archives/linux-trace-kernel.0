Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CFE16B395;
	Wed, 31 Jul 2024 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722419192; cv=none; b=Nzt5KUwAMFoL+kfG45l2DGnrjuD/ByUK/5CXkKCkXPwLCDZZgD0SDVHFyWsuOjveEIJZfbMuI04kfdcS41WSHA3ChnaYzH3Zt1N+4keTnD4Tdx9rnSSsjMjYS6onsBOxrQFU1jGOwUrGD8GseYkySelVRUmDEj9Fmza2m1Auy2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722419192; c=relaxed/simple;
	bh=yVnJOIKofacfRq64hTVjmvQiITuTD5zdQUZVRt40Yno=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=u5vk2HGNgVTysjeewzSsLpXe8wJn2gjd9XOf19MTDu4+yml1Rp628z4fucMYoKWl11V34S/rh+SViadLrsKULy3uuKSWBrqzq/p8fG52XwdEUsKQnodaP2ylL/0wqZRGFqohtFPppzrQOuWUAp0nisHywFJvNKkNIYf0uDJGq44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4lpqQ+P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4lpqQ+P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC6EC4AF09;
	Wed, 31 Jul 2024 09:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722419191;
	bh=yVnJOIKofacfRq64hTVjmvQiITuTD5zdQUZVRt40Yno=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B4lpqQ+P9vRln1D2CljbDitQrBQQUg9tA7S5n2HIBeFfC/QsCcfpUKSe2cGhfneks
	 120CM5t5t6nOpG36h8ZSMQ9yqUQ2N+IvyKRHNcqTcH35M8+TYh/bJsjuDTKLZkwLAP
	 QQOOU7oyk/yyEWV9mTGCGPLeXvReEUJScRIcpx9Os5WAcbCDtpKrpI4vnVrNKDzyuv
	 gF/JZVcNKpsVc6aGmmRbGbVV2DduK+SbUVHGJmo8n7SEqDM1grXWiI0SmzuN/jV9wq
	 3ZhBLy5kZINwC0Oy2/dOQAYdVSUhWwpZZRd7yc1Nmd2I3oX/T4L1TdtI+bonrp0tj1
	 xRRmXrUNGYQjw==
Date: Wed, 31 Jul 2024 18:46:27 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: andrii@kernel.org, peterz@infradead.org, jolsa@kernel.org,
 rostedt@goodmis.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] uprobes: simplify _unregister paths
Message-Id: <20240731184627.c61cfa6ef8748f71f41e9407@kernel.org>
In-Reply-To: <20240730123421.GA9085@redhat.com>
References: <20240730123421.GA9085@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 14:34:21 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> On top of
> 
> 	[PATCH v2 0/5] uprobes: misc cleanups/simplifications
> 	https://lore.kernel.org/all/20240729134444.GA12293@redhat.com/
> 
> I sent yesterday.
> 

OK, this series looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Oleg.
> ---
> 
>  kernel/events/uprobes.c | 47 ++++++++++++++++++++++++-----------------------
>  1 file changed, 24 insertions(+), 23 deletions(-)
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

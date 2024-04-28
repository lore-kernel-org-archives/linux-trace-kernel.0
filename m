Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04929476;
	Sun, 28 Apr 2024 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714339448; cv=none; b=J6J/aalKzeuoEg8Nc7IbuPuOIXqaM4BApXX90TWIIypsHSFz9N0MM+iKRVxSyV6/S3R5Rm7RnG6qI3RFSL5hUF4+WboruEG2tPz0iTHmRFbbV+nYgGprdaON0kEwC1c+GxqnmZWDAQXT+jyXhZRYagDWTJnZ2ylngMnCss3FrB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714339448; c=relaxed/simple;
	bh=kqv1IgIR76iRrqzwMb+SBclQzX24R1UAyDfTHDcutg0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4dOEM87gnYD8PC2D9gxc27z/MO+w7MAniBst8X1KXdgnY3hVkVIwpLCDp9fDHG5wrWgK7+hFZxxjxDNwkPtHiaH8f5KX3OnIatJceJ5DURJfFOxnJFqGcPZH/DpIOpnoF3xXF2gZrc4KziwyL1BmfzjhRPPkpKAXlq+Zq4vNBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57F2C113CC;
	Sun, 28 Apr 2024 21:24:07 +0000 (UTC)
Date: Sun, 28 Apr 2024 17:24:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Vincent Donnefort <vdonnefort@google.com>, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 rdunlap@infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v20 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20240428172406.6eda8a17@rorschach.local.home>
In-Reply-To: <6apbwt27afeercymrjsulrgyv4c2pj2tzqdllukf4czsbfifqo@6p23uqdjqtu7>
References: <20240406173649.3210836-1-vdonnefort@google.com>
	<20240406173649.3210836-3-vdonnefort@google.com>
	<20240410134352.66d35fbc@gandalf.local.home>
	<6apbwt27afeercymrjsulrgyv4c2pj2tzqdllukf4czsbfifqo@6p23uqdjqtu7>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Apr 2024 12:04:15 -0400
"Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:

> > Nit: For all labels, please add a space before them. Otherwise, diffs will
> > show "unlock" as the function and not "ring_buffer_map", making it harder
> > to find where the change is.
> >   
> 
> Isn't the inclusion of a space before labels outdate since 'git diff'
> superseds 'diff' and fixed this issue?

I still use patch and quilt ;-) and that still suffers from that on
reject files (used for backporting and such).

-- Steve

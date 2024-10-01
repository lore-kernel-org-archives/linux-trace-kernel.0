Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7988318C011;
	Tue,  1 Oct 2024 12:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727785916; cv=none; b=UP9U3iRfR2ydfmGP18w+DzSSn/BNozeejFWymnC2DBaym/RKnidXxeHb/1xJv/CeklgoUgiV9tHRa5TtaWUD6xKoLTm7mXnzuNg/loXojXRZTN8EBq4lK8LXKhfYnPkcsViHcEyTh8HioReH0EBcl7S+ZdHDIgIE4a0wqZbZfvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727785916; c=relaxed/simple;
	bh=19IX4OeghtpVbPlwb866tD5DcuwT5Zco6nuxCjl0SIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sJcsI/yDi8VuxAl8FwNUgJ/ZNwY0d9+5pXbNTCkD8m+w0TLtS7gWhMTN4NvDT0Zek+k+QcetWCVKVyoof+e8tEsi9XfidIYJlcctdXXqxol2jnwd9cIyfVJw/vUXOosUcC8mWvG3uGfVkQDZq5AdiSfBKBMPqSgC8kkImA09Xck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7893DC4CEC6;
	Tue,  1 Oct 2024 12:31:55 +0000 (UTC)
Date: Tue, 1 Oct 2024 08:32:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Question about config UPROBES and UPROBE_EVENTS
Message-ID: <20241001083244.486589b9@gandalf.local.home>
In-Reply-To: <20240930113231.6c87108d@gandalf.local.home>
References: <1a3567d5-e558-351a-c45d-73b2e5a8788c@loongson.cn>
	<20240930081529.f6f9161c20db9b95c9b46252@kernel.org>
	<f639079e-bc1c-7f2a-4c3f-de1a6780da84@loongson.cn>
	<20240930100630.7894c442@gandalf.local.home>
	<20241001002813.6012587b5e52737a576f1d0b@kernel.org>
	<20240930113231.6c87108d@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 11:32:31 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > uprobe_register/unregister APIs are exposed to the kernel modules,
> > since systemtap had been introduced this feature.
> >  
> 
> OK, but since they have always been visible, I would just make
> CONFIG_UPROBES a normal option and CONFIG_UPROBE_EVENTS select it if it
> gets selected, and not depend on it.

Thinking about this more, since systemtap is out of tree, and if that's the
only user of uprobes, I don't think it should be exposed as a prompt.

If you want uprobes for systemtap, you must also have uprobe events.

-- Steve

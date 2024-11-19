Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03561CCB35;
	Tue, 19 Nov 2024 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732031595; cv=none; b=tiLMu1iAH6K62c8MxuSdwYIlbOxNW1qbG3roG4nBxRR2ED14qb0b7WLwZm2LoApzDzZYz49NljPXdmOYKSOuE/Go/Ox5sbHp4yGFsq1hKUrVy4gcpEZ6Gy4Y/ZvEwPv51wG3v/RkKvZYKjo0olkr+io9y/UqfP55XwSGPc25Ask=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732031595; c=relaxed/simple;
	bh=w4IDxBU4NKo5Fny29rVUCw8EImyqzh4Y6qUKw0J/6SM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D5Z6wN9jSMRvGiN+Jc7lnSlsxJKJTyb65/JA6rnQUVrbupvzm9yzgJDuUJmNVhWUFEUxVoBiAQHnH44V33wOhDGzwqbzqEUONeZVdTPrrtCun9PwwMY8oQKz6YRjX77aEkBnxSEjP0keCFg7nrgw+tQjviYSDzBUArtj5Blj2Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9BBC4CECF;
	Tue, 19 Nov 2024 15:53:14 +0000 (UTC)
Date: Tue, 19 Nov 2024 10:53:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: lkp@intel.com, boqun.feng@gmail.com, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, ojeda@kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] jump_label: rust: pass a mut ptr to
 `static_key_count`
Message-ID: <20241119105347.32cbd654@gandalf.local.home>
In-Reply-To: <CAH5fLgiyWDiDFAJO-LDj_ZdRjSnqh-j7vw7URLUm8ZHiFKfGXw@mail.gmail.com>
References: <202411181440.qEdcuyh6-lkp@intel.com>
	<20241118202727.73646-1-aliceryhl@google.com>
	<20241118182818.7717993c@gandalf.local.home>
	<CAH5fLgjBpz7bPvanupPSsJx3fjLAa7g7nMjLgSxjEde_KDGV2w@mail.gmail.com>
	<20241119101233.19005043@gandalf.local.home>
	<CAH5fLgiyWDiDFAJO-LDj_ZdRjSnqh-j7vw7URLUm8ZHiFKfGXw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Nov 2024 16:31:40 +0100
Alice Ryhl <aliceryhl@google.com> wrote:

> > Would you be able to create some simple code to do that? If you add
> > something in the rust sample code, I'll add it to the ftrace selftests.  
> 
> Sure, I'll submit a sample which does that for the 6.14 cycle.

Is it because you don't have time this week or is it because you think it's
just too late to add code during the merge window? If it's the former, then
sure, we can wait. But if you want to wait just because we are in the merge
window, you don't need to. For things that add testing, it's OK to send
even this late in the game. What I and many should not accept, is any
active development on the kernel itself. Adding a sample module to be able
to test if things are working properly does not fall under that category.

The reason I ask, is I feel nervous about sending code to Linus that I
personally do not test. It's not a show stopper. I'll still send your
patches without or without this change. Before I send a pull request to
Linus, I like to run one last smoke test on the code, and that's when I
discovered I don't really have any tests to test your code.

-- Steve

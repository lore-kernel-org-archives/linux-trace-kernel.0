Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB551CF5DA;
	Tue, 19 Nov 2024 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732029121; cv=none; b=SxZePZSTKDl+mxaN3HtlUL0rrP/4z1g2CRJnhbPKMZQJg1jupk3uwVIjzbnuupzB/fG3UGRHe1FlBvMGnvdTnYMXNUzkgk5uABu3VaigqKhIc8YpUlA8qT8eZs7PStwI5JFzuVGxh0XGDoNu3ZzrQKuQRM9YC8z1pX8D8g4rr38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732029121; c=relaxed/simple;
	bh=q5Yttr+SrrX9BB0caMrVKv9WuECMvBqGcFu7dKqFJo8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n7dEo8nDOwRHXxdq4bh9GI7QtSUsVrZyemBmt2mhx8VBEBkwgtxZrxvNjrRDesh2ZW/Oj+UcDjesG+3qqALYig/HzJJYKiJK21QLiX9OtWADMjKCO2zEGgKtBUZacSU4lHxNPXK68Sq1SOAq4LJMgKUi05RyWHn9ZUS2XmaPTTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7B2C4CED0;
	Tue, 19 Nov 2024 15:11:59 +0000 (UTC)
Date: Tue, 19 Nov 2024 10:12:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: lkp@intel.com, boqun.feng@gmail.com, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, ojeda@kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] jump_label: rust: pass a mut ptr to
 `static_key_count`
Message-ID: <20241119101233.19005043@gandalf.local.home>
In-Reply-To: <CAH5fLgjBpz7bPvanupPSsJx3fjLAa7g7nMjLgSxjEde_KDGV2w@mail.gmail.com>
References: <202411181440.qEdcuyh6-lkp@intel.com>
	<20241118202727.73646-1-aliceryhl@google.com>
	<20241118182818.7717993c@gandalf.local.home>
	<CAH5fLgjBpz7bPvanupPSsJx3fjLAa7g7nMjLgSxjEde_KDGV2w@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Nov 2024 09:36:38 +0100
Alice Ryhl <aliceryhl@google.com> wrote:

> I've only really used the sample in this series as a build test. The
> bulk of my testing has occurred by using this tracepoint support in
> Rust Binder where I have 30 different tracepoints and I've been able
> to verify that I can enable them and so on there.

Could you modify the sample code to have a tracepoint that I could enable.
I don't use the Rust Binder code so I can't test it. I use the trace_event
sample code for selftests, and it would also be a good idea to add the rust
trace event sample to the self tests as well.

Would you be able to create some simple code to do that? If you add
something in the rust sample code, I'll add it to the ftrace selftests.

Thanks,

-- Steve

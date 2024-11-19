Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C830113AA35;
	Tue, 19 Nov 2024 16:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732035109; cv=none; b=cplsrFOqUBS5mcGamBjMtr22PFOIlaXhp24QLXe8s4BJ/+DDRHnr4ot8dRKFNJoebSSzB9HTh3VYXMT8wakXYJ64ZDtDOsz6U15ZAbgYKCBmepiR6PWWTh0h5Aqde7wRuQwdT9oPK3wAAnHFXtTL5S8oS4kre0r2piYdDuSgsho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732035109; c=relaxed/simple;
	bh=xivD34URD6sc3gq5SYCxpCxpAwpAnCy59UUznZ2ojIw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qO2MqzxPGfYC5XsfqyaTNR/fmnIgUcnhwFwSfwGB3TVbIZok57WLzKbipTVmfv6ByQYdGgMw4bALEHXmAzIkypYhHfowyRcfgKX/Pk9cvcEn6J1n3XqB9yXiOkQHMNcCwTlcvF0wix+TRFMjEwNMLjtM9W7W31l8X5ct7w2riEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C94C4CECF;
	Tue, 19 Nov 2024 16:51:48 +0000 (UTC)
Date: Tue, 19 Nov 2024 11:52:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: lkp@intel.com, boqun.feng@gmail.com, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, ojeda@kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] jump_label: rust: pass a mut ptr to
 `static_key_count`
Message-ID: <20241119115221.72f14db3@gandalf.local.home>
In-Reply-To: <CAH5fLgj0xHFLH8CCno568KtiQd9uD2G8Gek60mRLF98FZn0H2A@mail.gmail.com>
References: <202411181440.qEdcuyh6-lkp@intel.com>
	<20241118202727.73646-1-aliceryhl@google.com>
	<20241118182818.7717993c@gandalf.local.home>
	<CAH5fLgjBpz7bPvanupPSsJx3fjLAa7g7nMjLgSxjEde_KDGV2w@mail.gmail.com>
	<20241119101233.19005043@gandalf.local.home>
	<CAH5fLgiyWDiDFAJO-LDj_ZdRjSnqh-j7vw7URLUm8ZHiFKfGXw@mail.gmail.com>
	<20241119105347.32cbd654@gandalf.local.home>
	<CAH5fLgj0xHFLH8CCno568KtiQd9uD2G8Gek60mRLF98FZn0H2A@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Nov 2024 17:16:56 +0100
Alice Ryhl <aliceryhl@google.com> wrote:

> Mostly because of the merge window, though also because waiting would
> let me use things landing in 6.13 through other maintainer trees; this
> would let me have the sample declare a miscdevice. But what I can
> submit now is this: create a Rust file that exposes a function which
> just triggers a tracepoint, and then I can call that function from C
> somewhere in the ftrace selftests, and then afterwards the C code
> could assert that the tracepoint got triggered. Is there an existing
> ftrace test that I can look at to base my work on?

You can look at samples/trace_events/trace-events-sample.c which actually
creates a thread that runs periodically and triggers trace events.

And the test:

  tools/testing/selftests/ftrace/test.d/dynevent/add_remove_tprobe_module.tc

Also the module:

  samples/trace_printk/trace-printk.c

and the test:

  tools/testing/selftests/ftrace/test.d/event/trace_printk.tc

-- Steve

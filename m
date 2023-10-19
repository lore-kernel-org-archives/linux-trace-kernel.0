Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D44727479
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Oct 2023 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F71C433C9;
	Thu, 19 Oct 2023 13:51:07 +0000 (UTC)
Date: Thu, 19 Oct 2023 09:51:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Francis Laniel <flaniel@linux.microsoft.com>,
 linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5 0/2] Return EADDRNOTAVAIL when func matches several
 symbols during kprobe creation
Message-ID: <20231019095104.006a7252@gandalf.local.home>
In-Reply-To: <20231019211843.56f292be3eee75cdd377e5a2@kernel.org>
References: <20231018144030.86885-1-flaniel@linux.microsoft.com>
	<20231018130042.3430f000@gandalf.local.home>
	<20231019211843.56f292be3eee75cdd377e5a2@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Oct 2023 21:18:43 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > So why is this adding stable? (and as Greg's form letter states, that's not
> > how you do that)
> > 
> > I don't see this as a fix but a new feature.  
> 
> I asked him to make this a fix since the current kprobe event' behavior is
> somewhat strange. It puts the probe on only the "first symbol" if user
> specifies a symbol name which has multiple instances. In this case, the
> actual probe address can not be solved by name. User must specify the
> probe address by unique name + offset. Unless, it can put a probe on
> unexpected address, especially if it specifies non-unique symbol + offset,
> the address may NOT be the instruction boundary.
> To avoid this issue, it should check the given symbol is unique.
>

OK, so what is broken is that when you add a probe to a function that has
multiple names, it will attach to the first one and not necessarily the one
you want.

The change log needs to be more explicit in what the "bug" is. It does
state this in a round about way, but it is written in a way that it doesn't
stand out.

    Previously to this commit, if func matches several symbols, a kprobe,
    being either sysfs or PMU, would only be installed for the first
    matching address. This could lead to some misunderstanding when some
    BPF code was never called because it was attached to a function which
    was indeed not called, because the effectively called one has no
    kprobes attached.

    So, this commit returns EADDRNOTAVAIL when func matches several
    symbols. This way, user needs to use address to remove the ambiguity.


What it should say is:

    When a kprobe is attached to a function that's name is not unique (is
    static and shares the name with other functions in the kernel), the
    kprobe is attached to the first function it finds. This is a bug as the
    function that it is attaching to is not necessarily the one that the
    user wants to attach to.

    Instead of blindly picking a function to attach to what is ambiguous,
    error with EADDRNOTAVAIL to let the user know that this function is not
    unique, and that the user must use another unique function with an
    address offset to get to the function they want to attach to.

And yes, it should have:

Cc: stable@vger.kernel.org

which is how to mark something for stable, and

Fixes: ...

To the commit that caused the bug.

-- Steve

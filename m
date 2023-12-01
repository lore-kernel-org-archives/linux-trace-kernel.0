Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B5D25742
	for <linux-trace-kernel@vger.kernel.org>; Fri,  1 Dec 2023 18:07:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B3FC433C7;
	Fri,  1 Dec 2023 18:07:16 +0000 (UTC)
Date: Fri, 1 Dec 2023 13:07:37 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Justin Chen <justin.chen@broadcom.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, mhiramat@kernel.org,
 mark.rutland@arm.com, linux@armlinux.org.uk,
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Florian Fainelli <florian.fainelli@broadcom.com>, Doug Berger
 <doug.berger@broadcom.com>
Subject: Re: ARM Ftrace Function Graph Fails With UNWINDER_FRAME_POINTER
Message-ID: <20231201130702.2824115c@gandalf.local.home>
In-Reply-To: <81af85b4-5274-4362-9413-890425c60524@broadcom.com>
References: <d870c149-4363-43de-b0ea-7125dec5608e@broadcom.com>
	<CAMj1kXGST7uH530hB0i-rzisNesNrUGsJ5a5eC9805Udi5msrQ@mail.gmail.com>
	<81af85b4-5274-4362-9413-890425c60524@broadcom.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Dec 2023 09:25:59 -0800
Justin Chen <justin.chen@broadcom.com> wrote:

> > It appears the sub instruction at 0x6dd0 correctly accounts for the
> > extra 8 bytes, so the frame pointer is valid. So it is our assumption
> > that there are no gaps between the stack frames is invalid.  
> 
> Thanks for the assistance. The gap between the stack frame depends on 
> the function. Most do not have a gap. Some have 8 (as shown above), some 
> have 12. A single assumption here is not going to work. I'm having a 
> hard time finding out the reasoning for this gap. I tried disabling a 
> bunch of gcc flags as well as -O2 and the gap still exists.

That code was originally added because of some strange things that gcc did
with mcount (for example, it made a copy of the stack frame that it passed
to mcount, where the function graph tracer replaced the copy of the return
stack making the shadow stack go out of sync and crash). This was very hard
to debug and I added this code to detect it if it happened again.

Well it's been over a decade since that happened (2009).

  71e308a239c09 ("function-graph: add stack frame test")

I'm happy assuming that the compiler folks are aware of our tricks with
hijacking return calls and I don't expect it to happen again. We can just
rip out those checks. That is, if it's only causing false positives, I
don't think it's worth keeping around.

Has it detected any real issues on the Arm platforms?

-- Steve

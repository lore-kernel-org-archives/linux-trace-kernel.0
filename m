Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BA8171C0
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Oct 2023 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6kFfEI4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668CAC433C7;
	Mon,  9 Oct 2023 15:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696863842;
	bh=zB+vI20UfPAoIRDFm4Wc3RigAKAOlJQXx6ZG9XBMgtU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X6kFfEI4HpwGjzHjtOzXmkTx/+6u72xXY8H7ww/5qDY2nhVN81Fj6QaE58qWjoxng
	 NsYO21WczbjklYww+dY+HfEEmT5pywPC1VFv35AGphK7rOxfnsUHfPEBwQUFRZwGwZ
	 8z78vN4K8b0BGXjXV596E9NN8EwUX5bLb7G7GSLfLG9uXNC35stIsbhlrkBDz6qTf/
	 5dCXhoxKBix+k807kRU7R/e7mTylWjKvBBPytgUSC83b2O/YHmHlyf0YXwkAbiOaq4
	 LM41jMrd3WKOTsERWM56INn6efOz0yeEkJx1I/JQtK1KjcI8Fc3NdgfxNlUXx933Xc
	 by1xxCh/24I6w==
Date: Tue, 10 Oct 2023 00:03:56 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Atul Kumar Pant <atulpant.linux@gmail.com>, naveen.n.rao@linux.ibm.com,
 anil.s.keshavamurthy@intel.com, davem@davemloft.net, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, shuah@kernel.org
Subject: Re: [PATCH v1] samples: kprobes: Fixes a typo
Message-Id: <20231010000356.1805c6e0f517245161ebdf03@kernel.org>
In-Reply-To: <20231009095103.6d08e72a@gandalf.local.home>
References: <20230817170819.77857-1-atulpant.linux@gmail.com>
	<20230923173040.GA159038@atom0118>
	<20231007153900.GA20160@atom0118>
	<20231009095103.6d08e72a@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Oct 2023 09:51:03 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 7 Oct 2023 21:09:00 +0530
> Atul Kumar Pant <atulpant.linux@gmail.com> wrote:
> 
> > On Sat, Sep 23, 2023 at 11:00:46PM +0530, Atul Kumar Pant wrote:
> > > On Thu, Aug 17, 2023 at 10:38:19PM +0530, Atul Kumar Pant wrote:  
> > > > Fixes typo in a function name.
> > > > 
> > > > Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> > > > ---
> > > >  samples/kprobes/kretprobe_example.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/samples/kprobes/kretprobe_example.c b/samples/kprobes/kretprobe_example.c
> > > > index cbf16542d84e..ed79fd3d48fb 100644
> > > > --- a/samples/kprobes/kretprobe_example.c
> > > > +++ b/samples/kprobes/kretprobe_example.c
> > > > @@ -35,7 +35,7 @@ struct my_data {
> > > >  	ktime_t entry_stamp;
> > > >  };
> > > >  
> > > > -/* Here we use the entry_hanlder to timestamp function entry */
> > > > +/* Here we use the entry_handler to timestamp function entry */
> > > >  static int entry_handler(struct kretprobe_instance *ri, struct pt_regs *regs)
> > > >  {
> > > >  	struct my_data *data;
> > > > -- 
> > > > 2.25.1
> > > >   
> > > 
> > > 	Hi all, can someone provide comments on this change.  
> > 
> > 			Hi all, can someone please review this change. It has been not
> > 			reviewed for quite some time.
> 
> That's because trivial typos in comments are considered very low priority,
> and are usually only added (if they are ever added) if the maintainer has
> extra time, which may not be for a while.

Anyway, let me pick this. I found this in my inbox now. :)

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

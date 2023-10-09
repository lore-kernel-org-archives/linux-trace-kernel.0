Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F6E341AC
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Oct 2023 13:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDFCC433CA;
	Mon,  9 Oct 2023 13:49:45 +0000 (UTC)
Date: Mon, 9 Oct 2023 09:51:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Atul Kumar Pant <atulpant.linux@gmail.com>
Cc: naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
 davem@davemloft.net, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, shuah@kernel.org
Subject: Re: [PATCH v1] samples: kprobes: Fixes a typo
Message-ID: <20231009095103.6d08e72a@gandalf.local.home>
In-Reply-To: <20231007153900.GA20160@atom0118>
References: <20230817170819.77857-1-atulpant.linux@gmail.com>
	<20230923173040.GA159038@atom0118>
	<20231007153900.GA20160@atom0118>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Oct 2023 21:09:00 +0530
Atul Kumar Pant <atulpant.linux@gmail.com> wrote:

> On Sat, Sep 23, 2023 at 11:00:46PM +0530, Atul Kumar Pant wrote:
> > On Thu, Aug 17, 2023 at 10:38:19PM +0530, Atul Kumar Pant wrote:  
> > > Fixes typo in a function name.
> > > 
> > > Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> > > ---
> > >  samples/kprobes/kretprobe_example.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/samples/kprobes/kretprobe_example.c b/samples/kprobes/kretprobe_example.c
> > > index cbf16542d84e..ed79fd3d48fb 100644
> > > --- a/samples/kprobes/kretprobe_example.c
> > > +++ b/samples/kprobes/kretprobe_example.c
> > > @@ -35,7 +35,7 @@ struct my_data {
> > >  	ktime_t entry_stamp;
> > >  };
> > >  
> > > -/* Here we use the entry_hanlder to timestamp function entry */
> > > +/* Here we use the entry_handler to timestamp function entry */
> > >  static int entry_handler(struct kretprobe_instance *ri, struct pt_regs *regs)
> > >  {
> > >  	struct my_data *data;
> > > -- 
> > > 2.25.1
> > >   
> > 
> > 	Hi all, can someone provide comments on this change.  
> 
> 			Hi all, can someone please review this change. It has been not
> 			reviewed for quite some time.

That's because trivial typos in comments are considered very low priority,
and are usually only added (if they are ever added) if the maintainer has
extra time, which may not be for a while.

-- Steve

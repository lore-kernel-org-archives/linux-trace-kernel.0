Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BA312E44
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Nov 2023 20:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A60AC433C8;
	Wed,  1 Nov 2023 20:00:36 +0000 (UTC)
Date: Wed, 1 Nov 2023 16:00:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] eventfs: Fix kerneldoc of eventfs_remove_rec()
Message-ID: <20231101160035.12824b55@gandalf.local.home>
In-Reply-To: <9d71fc3b-f7a9-9f23-6fbe-a7665954cd30@quicinc.com>
References: <20231030121523.0b2225a7@gandalf.local.home>
	<9d71fc3b-f7a9-9f23-6fbe-a7665954cd30@quicinc.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Oct 2023 21:57:13 +0530
Mukesh Ojha <quic_mojha@quicinc.com> wrote:

> On 10/30/2023 9:45 PM, Steven Rostedt wrote:
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > The eventfs_remove_rec() had some missing parameters in the kerneldoc
> > comment above it. Also, rephrase the description a bit more to have a bit
> > more correct grammar.
> > 
> > Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode");
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202310052216.4SgqasWo-lkp@intel.com/
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> 
> Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

Hi Mukesh!

First, I want to thank you for your reviews. We certainly need more
reviewers.

But I need to also state that "Reviewed-by" tags should not be sent so
lightly. The only times a Reviewed-by tag should be sent is if you
participated in the discussion of the code, you have authored some of
the code that is being modified, or are marked as a reviewer of the code in
the MAINTAINERS file.

For example, you added to the discussion here:

   https://lore.kernel.org/all/65dcdd9c-a75b-4fe7-bdcf-471a5602db20@linaro.org/

And adding your Reviewed-by tag is appropriate.

But when a maintainer receives a Reviewed-by from someone they don't know,
without any discussion in the patch, it may make that maintainer think that
the person sending the Reviewed-by is only out to get listed in the LWN
"Reviewed-by" count.

I review other developers' code all the time, and unless the code touches
something I worked on or I'm marked as a reviewer in the MAINTAINERS file,
I do not send a Reviewed-by tag unless I added some input to the patch in
question.

My advice to you is to keep up the reviewing, I appreciate it (I really
do!), but don't send out Reviewed-by tags unless you are marked as a
reviewer of the code, or participated in a discussion on that code.

Thanks,

-- Steve

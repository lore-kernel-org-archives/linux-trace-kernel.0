Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F36F18E01
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Nov 2023 12:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6302EC433C8;
	Thu,  2 Nov 2023 12:36:36 +0000 (UTC)
Date: Thu, 2 Nov 2023 08:36:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] eventfs: Fix kerneldoc of eventfs_remove_rec()
Message-ID: <20231102083634.5278a500@gandalf.local.home>
In-Reply-To: <0be16a8e-5f4f-4c26-d6b1-c090accfac5c@quicinc.com>
References: <20231030121523.0b2225a7@gandalf.local.home>
	<9d71fc3b-f7a9-9f23-6fbe-a7665954cd30@quicinc.com>
	<20231101160035.12824b55@gandalf.local.home>
	<0be16a8e-5f4f-4c26-d6b1-c090accfac5c@quicinc.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Nov 2023 12:05:33 +0530
Mukesh Ojha <quic_mojha@quicinc.com> wrote:

> I will try to participate and take this in a good way..but i thought
> for easier change where there is no discussion is needed., it is fine
> to add if you have spent time in checking the code and change is proper.

If it's easy then automated bots will likely catch any issues. No need to
say you looked at it too. Otherwise we'll get 20 Reviewed-by tags on
comment changes.

A Reviewed-by tag has much more meaning when the code being reviewed is not
trivial, where questions about correctness is needed. In other words, if
something doesn't look quite right, ask. If it is, and the author explains
the reason it is, the fact that the explanation is now documented in the
archives is useful.

Thanks,

-- Steve

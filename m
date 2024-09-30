Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DD419342B;
	Mon, 30 Sep 2024 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716412; cv=none; b=YYkMrxTC+fLzX8KSOBQw2BVC1iHzdQx3H7zLwqTCEXE1zCO70Go/sAaets1hMCJxB89OG7K6PiYeuYuRJphApQip8/dpNOfMIj8ARRGN1PYBOVatuYaoPcfs6CVVAISHjO6Cnr5/Q0W65zstgG9EQdcq3mSomO7zrjKi/+Hhs/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716412; c=relaxed/simple;
	bh=Eew9bXlDuPZUSAxAdTkv17Hsuq5cqSvBcNnD9EMG2lE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tSqFUHsjXSpdBqzq+55VkPxZHGpsoOemAlPJZa2BNBpYeo2IWhAcHlW7mPgApEOW35XixgC43cL1UqCe25eLDF3TakbFwDOP9b+FU1jtsu09sDHxI9ZfLIL/rJB6bPMoFl1vfua2npvnIy4wUoBtBu2g8smsTIUBRwJtx3XmPm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F91C4CECE;
	Mon, 30 Sep 2024 17:13:28 +0000 (UTC)
Date: Mon, 30 Sep 2024 13:14:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML
 <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mike Rapoport <mike.rapoport@gmail.com>, Kees Cook <keescook@chromium.org>,
 Ard Biesheuvel <ardb@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation/tracing: Mention that
 RESET_ATTACK_MITIGATION can clear memory
Message-ID: <20240930131415.1438c0b7@gandalf.local.home>
In-Reply-To: <f8546c5d-fa2e-416f-8a1b-431025b4df4d@redhat.com>
References: <20240926130159.19e6d0e2@rorschach.local.home>
	<f8546c5d-fa2e-416f-8a1b-431025b4df4d@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Sep 2024 19:54:48 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 26-Sep-24 7:01 PM, Steven Rostedt wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > At the 2024 Linux Plumbers Conference, I was talking with Hans de Goede
> > about the persistent buffer to display traces from previous boots. He
> > mentioned that UEFI can clear memory. In my own tests I have not seen
> > this. He later informed me that it requires the config option:
> > 
> >  CONFIG_RESET_ATTACK_MITIGATION
> > 
> > It appears that setting this will allow the memory to be cleared on boot
> > up, which will definitely clear out the trace of the previous boot.
> > 
> > Add this information under the trace_instance in kernel-parameters.txt
> > to let people know that this can cause issues.
> > 
> > Link: https://lore.kernel.org/all/20170825155019.6740-2-ard.biesheuvel@linaro.org/
> > 
> > Reported-by: Hans de Goede <hdegoede@redhat.com>
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> 
> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Thanks,

And I forgot to send this to the Documentation maintainers :-p

Jon, could you take this? Do you need me to resend, or can you just pull it
from lore?

   https://lore.kernel.org/linux-trace-kernel/20240926130159.19e6d0e2@rorschach.local.home/

-- Steve


> 
> Regards,
> 
> Hans
> 
> 
> 
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index bb48ae24ae69..f9b79294f84a 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -6850,6 +6850,9 @@
> >  
> >  				reserve_mem=12M:4096:trace trace_instance=boot_map^traceoff^traceprintk@trace,sched,irq
> >  
> > +			Note, CONFIG_RESET_ATTACK_MITIGATION can force a memory reset on boot which
> > +			will clear any trace that was stored.
> > +
> >  			See also Documentation/trace/debugging.rst
> >  
> >    


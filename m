Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901541CB329;
	Thu, 22 Aug 2024 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724337253; cv=none; b=Xe+hKRUWoNM/iD73SusBcQE2/hkP877+59mtv4piF8OjnoFi8DcMMt8ko8RbmqJByVkkBh96qpixFluLsJcmc2zip9kfmwAJxIK3LR9e+0z1ybypyFEeVKFM+z48PZucKWW+qdfP7goRnx26sm8f+mm8OFYo/ZVrA3wv0XwRuZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724337253; c=relaxed/simple;
	bh=ths4hBzRouIQ/Xtd87TPrQwfMeFkjec47CprI+qjXb0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jCUaclURkh6xMTeIRKnSh9RVz0isN8nTaNyNB0+HX2DII8D1T+t+0R/8fTTpi/M4fr6oBV27uyXfLOWPxdKsFrIRbfvm4JVb4Lmj/MP2UaEi22FW6my1ZzuztIDlv2+f140chf27MfBeOOJBS+s5mG0HShBaLAQRTvsW/agQgqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EC0C4AF09;
	Thu, 22 Aug 2024 14:34:12 +0000 (UTC)
Date: Thu, 22 Aug 2024 10:34:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: tglozar@redhat.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, jkacur@redhat.com
Subject: Re: [PATCH] tracing/timerlat: Check tlat_var for NULL in
 timerlat_fd_release
Message-ID: <20240822103443.6a6ae051@gandalf.local.home>
In-Reply-To: <ZscfFFUM6pBuwpGZ@uudg.org>
References: <20240820130001.124768-1-tglozar@redhat.com>
	<20240821160316.02c03c44@gandalf.local.home>
	<ZscfFFUM6pBuwpGZ@uudg.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Aug 2024 08:20:52 -0300
"Luis Claudio R. Goncalves" <lgoncalv@redhat.com> wrote:

> You mean the 
> 
> +	if (!tlat_var->kthread) {
> +		/* the fd has been closed already */
> 
> bit or the kthread handling in rtla itself?
> 
> As Tomas already said, thank you for testing and reviewing the suggested fix!

The close only happens once, but the kthread does get freed elsewhere.

I used my new persistent ring buffer to debug this! I'll be posting some
more patches that allow trace_printk() and friends to use the persistent
ring buffer (or any instance) soon.

For this bug, I would recommend instead doing:

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 66a871553d4a..53de719f35cb 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2579,7 +2587,8 @@ static int timerlat_fd_release(struct inode *inode, struct file *file)
 	osn_var = per_cpu_ptr(&per_cpu_osnoise_var, cpu);
 	tlat_var = per_cpu_ptr(&per_cpu_timerlat_var, cpu);
 
-	hrtimer_cancel(&tlat_var->timer);
+	if (tlat_var->kthread)
+		hrtimer_cancel(&tlat_var->timer);
 	memset(tlat_var, 0, sizeof(*tlat_var));
 
 	osn_var->sampling = 0;

-- Steve

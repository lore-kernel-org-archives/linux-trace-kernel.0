Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7422144C1;
	Wed,  7 May 2025 20:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746651593; cv=none; b=Nc2t5Pe7icY9hBIEsn4n3vfmVVZJPopsFTG2osldfL8GWHdkR1aYXYQ2IulkbawlqUrW6xakkyyOw1thIzHz6tPdNc9Dqx1KSFidJMafL1xFZNy/ZMFsOWYBlXhmlK0hjci4HQawhQ+LURw376x14aHctWyZC4bSUdX2ZfkkNew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746651593; c=relaxed/simple;
	bh=+SUYH98AzHBhdr7mTmP0rZN+sNwcFAIGkPwfheN9H5M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EZbIK8T8vX3j/Px+JRdPkkcYCG3B089NN6Jiob0+1aSmix0RVElxy29bIF7zzJcSPuhb8WG3gvWJIQgYtN0WxL1VADuAAPsKzoWWaN9uGc7/MoAkbp49/6Dac/XTKZLoTdt9LLe8UmuqlRLevytO4i4mB2zubkVd8R0e+aUOTy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA5FC4CEE2;
	Wed,  7 May 2025 20:59:52 +0000 (UTC)
Date: Wed, 7 May 2025 17:00:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 john.ogness@linutronix.de
Subject: Re: [PATCH v6 13/22] rv: Add support for LTL monitors
Message-ID: <20250507170002.1abd3ce7@gandalf.local.home>
In-Reply-To: <dd181a937f2b469a45e744b622e1432b72e5592d.1745999587.git.namcao@linutronix.de>
References: <cover.1745999587.git.namcao@linutronix.de>
	<dd181a937f2b469a45e744b622e1432b72e5592d.1745999587.git.namcao@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Apr 2025 13:02:28 +0200
Nam Cao <namcao@linutronix.de> wrote:

> diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
> index 99c3801616d4..f9fb848bae91 100644
> --- a/kernel/trace/rv/rv_trace.h
> +++ b/kernel/trace/rv/rv_trace.h
> @@ -127,6 +127,53 @@ DECLARE_EVENT_CLASS(error_da_monitor_id,
>  // Add new monitors based on CONFIG_DA_MON_EVENTS_ID here
>  
>  #endif /* CONFIG_DA_MON_EVENTS_ID */
> +#if CONFIG_LTL_MON_EVENTS_ID
> +TRACE_EVENT(event_ltl_monitor_id,

Needs to be:

#ifdef CONFIG_LTL_MON_EVENTS_ID

Otherwise I get this:

In file included from /work/git/test-linux.git/include/trace/trace_events.h:107,
                 from /work/git/test-linux.git/include/trace/define_trace.h:119:
/work/git/test-linux.git/kernel/trace/rv/./rv_trace.h:130:5: error: "CONFIG_LTL_MON_EVENTS_ID" is not defined, evaluates to 0 [-Werror=undef]
  130 | #if CONFIG_LTL_MON_EVENTS_ID

and it fails to build.

-- Steve

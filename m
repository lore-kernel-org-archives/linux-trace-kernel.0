Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2981F149E17;
	Wed, 22 Jan 2025 22:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737584972; cv=none; b=Aco/ykQ60CkMPyA0P6MdYh7bsFTWIcsh5vur0s2ewmr/IPd5ZKNb5UsQcGMkdC37WO+hIaIgvYy4Hfgv97ciTN90kUwp1TL5+HIbR3bV2Wd7ImbdwbTuV4yNkgJpNR8yd4ygk+i+FcEs0B4fRJrhWiQ4sYNSDgwC5GZfz44cMhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737584972; c=relaxed/simple;
	bh=mRH0WXQJ8BgU1OJehfkeO8WfRRTbx4Gy+W71ffl4X9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NJ2kgQFsplVh4KQxfisDTho3JHQXzf0KI7yPBSWtuF8tAj745rjjLNeCNwcni619z4xTNY504PiyYmMljFX01typMYbQ/6qDiRNGG4N6R7Ta73+/IvKTEQH9r2JlXJvXNee+fPqL50qx64fjDaNJMYWKxZi3IXFHPLdg6tpdlXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC535C4CED2;
	Wed, 22 Jan 2025 22:29:30 +0000 (UTC)
Date: Wed, 22 Jan 2025 17:29:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: naveen@kernel.org, anil.s.keshavamurthy@intel.com, davem@davemloft.net,
 mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, john.ogness@linutronix.de
Subject: Re: kprobe on local function
Message-ID: <20250122172936.09bc8c9a@gandalf.local.home>
In-Reply-To: <20250122075939.qw7HsuMd@linutronix.de>
References: <20250122075939.qw7HsuMd@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jan 2025 08:59:39 +0100
Nam Cao <namcao@linutronix.de> wrote:

> Hi,
> 
> I installed a kretprobe on the function "rt_mutex_slowunlock". Although the
> function is called, the probe is never hit.
> 

How did you install the kretprobe?

> The reason is because there are 3 copies of rt_mutex_slowunlock() in
> vmlinux (at least for x86 defconfig + CONFIG_PREEMPT_RT). But probe point
> is only installed in 1 copy.
> 
> Is this considered a bug? Or is kprobe not intended to be used for local
> function? Should we modify kprobe to support such cases?

It's not a bug, but just the way the compiler works.

Have you tried "perf probe" to install the probes? That uses dwarf info to
find all the functions.

-- Steve

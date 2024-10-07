Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AEA1DCB00;
	Mon,  7 Oct 2024 17:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320939; cv=none; b=BCQFenV2pelOYmpcdmBt4Jkg5HgMn9wV53GVgTp69Nr439j/Cdl/bc9vLGev8hH7EBDewYXt6qrx/Sci54On1QJyn5SlpEBoBZF1o4UwCI/Mu+27ex3VlI61MrnFyj2rIeSIdpYqoG81LKZpUFAPK4v6I7rJBoDlTGtLRAReKsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320939; c=relaxed/simple;
	bh=SZ9Llq2XCi1Rzq6/Iql+DUGrm39jHu9DsCfZLr2VjDg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hly/YJMn58MLVDJYMddJRIeXXxHGxYRWgJDuVKA85L85EGKAzFDw6RF7GFOObyICcG+Xf9vjXLsSTAxT2xYNiMVkjKImA/k5OIQ+YgaGqxoOiD/lMKXcFiKKfDP3oZs1pZDKuMqToXS4vVfTYLsNg+RKApyVTiN+wcOvYZfXMZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BADC4CEC6;
	Mon,  7 Oct 2024 17:08:57 +0000 (UTC)
Date: Mon, 7 Oct 2024 13:08:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mike Rapoport <mike.rapoport@gmail.com>,
 Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ardb@kernel.org>, Hans
 de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2] Documentation/tracing: Mention that
 RESET_ATTACK_MITIGATION can clear memory
Message-ID: <20241007130858.7e25daeb@gandalf.local.home>
In-Reply-To: <87v7y3kflt.fsf@trenco.lwn.net>
References: <20241001095734.11a67b4b@gandalf.local.home>
	<20241004193800.2ffd0d36@gandalf.local.home>
	<87v7y3kflt.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 07 Oct 2024 11:06:06 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> Steven Rostedt <rostedt@goodmis.org> writes:
> 
> > Jon,
> >
> > This version should be good to go.  
> 
> Applied, thanks.

And I now see I sent an older version that had a typo in it :-p


+			Note, saving the trace buffer across reboots does require that the system
+			is set up to not wipe memory. For instance, CONFIG_RESET_ATTACK_MITIGATION
+			can force a memory reset on boot which will clear any trace that was stored.
+			This is just one of many ways that can clear memory. Make sure you system

										       your system

+			keeps the content of memory across reboots before relying on this option.
+

I can send a v3.

-- Steve

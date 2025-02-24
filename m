Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209A17BAEC;
	Mon, 24 Feb 2025 18:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420617; cv=none; b=nJjFgZKHlb3pVOMVzSk0dhmTdrxP6v6ki+NxMsixQE8mV++gp4JQgZ6UTNZh5E3EyMFP7nCzHUD1L5t0hwl4JEvT3B+hOlKPKbVY1y4gwUJog/2xukpBLkFFoLmQNPv3GDkQT+fL+BWJxDUrqR0iVoFJpZaALBVR4q6r/o6zO3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420617; c=relaxed/simple;
	bh=OqKqBHmdPsL821TINa8fHGXo/VWyezhWxXOYmuTumSs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bRzvpEiTYBEWNysk+TRPX2eWM3GXoBPbBWyDdsFh2Ii/ZXy5u6YWNoH+HDh8V3ifuqsR9bX30fnpj76ZOz2engzMcS79J4lgEUFB2Lu8VrMVRGpQP5/dZL6Pp/Dsp4P0h6dAjUxTWcYvvPOnwONAscYmKt0nWth6b8b9+BZD+eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E07C4CED6;
	Mon, 24 Feb 2025 18:10:13 +0000 (UTC)
Date: Mon, 24 Feb 2025 13:10:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Crash on named histogram trigger with invalid onmax
 variable
Message-ID: <20250224131049.3a4d8945@gandalf.local.home>
In-Reply-To: <CAP4=nvTsxjckSBTz=Oe_UYh8keD9_sZC4i++4h72mJLic4_W4A@mail.gmail.com>
References: <CAP4=nvTsxjckSBTz=Oe_UYh8keD9_sZC4i++4h72mJLic4_W4A@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Feb 2025 16:22:39 +0100
Tomas Glozar <tglozar@redhat.com> wrote:

Thanks for the report.

> I'm not familiar with the trigger implementation. Do you have any
> ideas on why the hist_unregister_trigger fails and/or a fix?

One day I would love to rewrite the trigger code. It's really convoluted
and not easy to follow. I'm constantly trying to remember the workflow of
it.

Anyway, I'll dig into this.

-- Steve

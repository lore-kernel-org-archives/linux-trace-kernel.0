Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C943E1EDA2E;
	Thu,  6 Feb 2025 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738855748; cv=none; b=YktfqVRHPMPGTOe+n9kMrvagcqijYJC2GQTqYHGfbdKn90Gwtiepw7TDXE81+eSS1ejY3PpewxUCGmPbg3islebri6hrsDAMQs1r6XDbB2Ut/jf7Y3sT/l0yKoOUfrSlmxIznzDHzTjf0mibAP+im1ihdGtjc/pQxTNAB+aYV7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738855748; c=relaxed/simple;
	bh=MrgnQb99g5cs+OzuYe034jD7K+cu1wANHYdTZp1r7nA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bp42Gf7QlX48JeS+sHglx4HhtAQvNchCkE4lKeIyW6/pKBCslNQzSBwNd2jwMJctAFLHCEzhEg4kWQcQ9P8h/IOXF/I9Jn+9QGfPHCR2dkCl3t43AN0OUITYqQKwNbEfJVsUe+LHTT/Ge+LDPj3PmbNQ90kmQAYkL0k2/KFRzfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003D1C4CEDD;
	Thu,  6 Feb 2025 15:29:07 +0000 (UTC)
Date: Thu, 6 Feb 2025 10:29:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6/8] tracing: Have persistent trace instances save
 module addresses
Message-ID: <20250206102949.65493416@gandalf.local.home>
In-Reply-To: <20250206172642.391c16d75dbce00518ef9688@kernel.org>
References: <20250205225031.799739376@goodmis.org>
	<20250205225103.930895467@goodmis.org>
	<20250206172642.391c16d75dbce00518ef9688@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Feb 2025 17:26:42 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> This maybe too frequently scan the module because the update_last_data() is
> called when;
> - change tracer (this maybe OK)
> - update "set_event"
> - write 1 to "enable" under events
> - change pid filter
> - etc.
> 
> Once it is scanned, it should not scan again, but update by module
> callback, because usually events are enabled individually (thus
> write 1 to "event" can happen multiple time online).
> 
> I think we can move this after TRACE_ARRAY_FL_LAST_BOOT check,
> if TRACE_ARRAY_FL_LAST_BOOT flag is set, that flag should be cleared
> with updating the tscratch, and the flag is not set, we can skip updating
> the scratch.

No, because we could enable it, disable it, and then the user could be
adding and removing modules all day long, and we only add and do not remove
(I do have a patch that does remove them).

But we can do the same check as patch 8 does, and only do this if the
tracer wasn't already active.

-- Steve

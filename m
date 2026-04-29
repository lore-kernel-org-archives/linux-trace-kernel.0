Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0F53BB4A;
	Wed, 29 Apr 2026 00:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777422739; cv=none; b=kNO/MfPICXWjD0muP+jh62xANYBpPRgE4+VLbaTHibX9OGL/m61045B+Uc9cXPQ3ru+rZp9/7+ubQOzbqHkfIO6ea4v9IKywYrU/RTDCfKl4pfIdvaMyZeCA02DsLc6mmZAeN4O8PkjwwNZC9wgORS2n1CcEZWVoZTFw2oU7xBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777422739; c=relaxed/simple;
	bh=2yCpUFzxDVMRi3hoG9Sa8B6qQyTzDdmNtYIamGQL0rA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T8khsSkfyWY/MgBzyYmoVSf2TV4jUDrHJqHTHJsJ6ae8i3g81i/upK8lO6XsiFA9hyIouN6SSfH673rfN+18ZU4XlL2/1a+23pfs1cur8hV660mUpwGJ4OTdjhl1aWdqEEkjun6HJzFwluCVjbfHi+4QilT3if8/Lsl7s/v+hck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 7D03C1A04E3;
	Wed, 29 Apr 2026 00:32:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id BA6982E;
	Wed, 29 Apr 2026 00:32:14 +0000 (UTC)
Date: Tue, 28 Apr 2026 20:32:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing/probes: Limit size of event probe to 3K
Message-ID: <20260428203213.36c66e44@robin>
In-Reply-To: <20260428122302.706610ba@gandalf.local.home>
References: <20260428122302.706610ba@gandalf.local.home>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 3q4hf56n933qkcq8eidrc8ne4z3wd6ep
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: BA6982E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18XJcdVZbVxkxb2HxulevPa0eSZfjuG/zw=
X-HE-Tag: 1777422734-20347
X-HE-Meta: U2FsdGVkX1/SOLAGmoY1FcY6KQ4lcWWKhT+BX1mO7puQJo+JqAB4cK3PntGZvxSIM+PPXSYK8L/z3tQoeWDxiCwm5OvPuLfv6soYGLGaILK+eTzMJcr4xbZxgPiBhMQeJsdH1oIgLlODrFadCzUPdZc+MSfBt2FBqnB+ljM2JpnBMc6+vHL09alnT8xMoE2eexM4bXhIkBNoAikw+9+geQGjHRq05Ft6n/WaJylkodLOfZgmAwSc+axLq0icHd22sCzFvHwcl5vbrKp8nLM4N+sMCya5os0eJmjE/zFOCqD3sLUFVWcuJv82moswO+gcu5e6cNAq2QVCAUSzCgYQ294/3qyZ4vQalvL1LwCScBDJBXiO+D7LDsmhwZAcKI/rA5kYSH2oOSZVS3R5XdGGzg==

On Tue, 28 Apr 2026 12:23:02 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> There currently isn't a max limit an event probe can be. One could make an
> event greater than PAGE_SIZE, which makes the event useless because if
> it's bigger than the max event that can be recorded into the ring buffer,
> then it will never be recorded.
> 
> A event probe should never need to be greater than 3K, so make that the
> max size. As long as the max is less than the max that can be recorded
> onto the ring buffer, it should be fine.
> 
> Cc: stable@vger.kernel.org
> Fixes: 93ccae7a22274 ("tracing/kprobes: Support basic types on dynamic events")
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Hi Masami,

I ran this through my tests along with some other fixes I have. If you
ack it, I can push this to Linus along with my other changes.

-- Steve

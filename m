Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483A63932C9;
	Thu, 30 Apr 2026 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777556851; cv=none; b=jxGYld/8tBbeA7PmHFE49mjb0RzI/NkbkCcNxbN3HGOTXWGVer7V8nGh2FNjz4YOtzy40vzjW5pNtHbCxewEumXoXc6iJylb9l6eHC1Jw44aykWs0NlibI82PMCtx0mJ1b0s/MMGMZBJciMtd97X9fQAkD2tEmnfd4D8zilJz5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777556851; c=relaxed/simple;
	bh=C7vuiSMcEC+AhI+NsRDVwWm3ryXwRYbZax1vHqQ0Krg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OcCr0Q2s/TWP2OLiIgENCRBHDps+WCKCeHcz4H7aPFThNT/rH/sAlQQZ/xDLc6Go+8Oi1GIdS8tT+14i8tUyRZhjgih8lkshwOOALRvaZ8oZ87fNZNOOHW89Im1c7gWx1W28FVSVTtH3rWva69vggJD7NtxUNR/OGegbWUrpkr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id B0F899BD36;
	Thu, 30 Apr 2026 13:32:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id E6B6620054;
	Thu, 30 Apr 2026 13:32:02 +0000 (UTC)
Date: Thu, 30 Apr 2026 09:32:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi
 <tom.zanussi@linux.intel.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] tracing: Bound synthetic-field strings with seq_buf
Message-ID: <20260430093221.4e5a606a@gandalf.local.home>
In-Reply-To: <20260430141414.b6fb7a49f4eae3cac847fb54@kernel.org>
References: <20260430043350.57928-1-pengpeng@iscas.ac.cn>
	<20260430141414.b6fb7a49f4eae3cac847fb54@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: uswdg4m4tqzrywzbp1mo3hkbaoze9r3a
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: E6B6620054
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18EUMioEITJCjyFyabfSJ6QOtNKPP6lzcw=
X-HE-Tag: 1777555922-224125
X-HE-Meta: U2FsdGVkX1+9RfKmNWSGhkE2cRvI7IdrxpgbJZ8euac3ZG5LmB360xjFMFD43N6PT3tvhlHGymJe8W95uRDR6Qbe3rfAjchHm72Vf973jJA1v0h5DSAS85hNw7uJiWkVJo+NTAXjBCNu4WfN5SdI6c7r8lksKjkOuSSlIg4WGKRo1iCqRLlllbi/fmf42pMJSxLtUHPs5l16Yo3R26poXUFaQMwQSIP2XyCVMZR/jiYxpC5SI3ckirXDCkbVt9dZ/zCoaDduECZbRnSvoEYTKBGtCI04fBAcm2+Iebc120XcK49PiN7PeS7SLJvAis+43UoUie5AcZYB5FLmQeHjL0zinIZfo3bPq5K2peDmXtSmw1K6Cq33kg==

On Thu, 30 Apr 2026 14:14:14 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> (BTW, we need to use __free(kfree) in this file too.)

I saw that too, but that can be a separate patch.

-- Steve

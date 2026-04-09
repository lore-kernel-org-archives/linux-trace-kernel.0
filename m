Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFF43DEADB;
	Thu,  9 Apr 2026 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749849; cv=none; b=FDKQaXeEmBsLLgTxEc+nBNXhjvQobaH6+Bg1zFrAjUiqEDqTCMXNpHV7psVvF2Jv6m2ftcsqarT8aehYYPChnn9PhQRw7KD58xOxGzs1f1brw0STWdkPmrr0pFccfmzLeui2IpjcZrzJjlZwwKj8jm+jvx0FSzXIuwCuKjKTARM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749849; c=relaxed/simple;
	bh=wpvklQMA0hDtCCBjrVbwuPyAMpw4aMa9pQz1l3Al3RI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E10cf61dlu6adMI/Fy+7JDM9JykzW4UzBS5KzzZO+CBPdNMxRI8GL7V1BLUE7OrcE4DnFjjjeM32ImHgGewVxKsFeyqR3HVYn0A/anzeGwc+swmNPcYt4+8oe1gBcvIFz9qbJfYYpWhpLsohjsUpS4oOFWDZ1IgslKVBwCt4+j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 69D4F1408D4;
	Thu,  9 Apr 2026 15:50:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 6319920027;
	Thu,  9 Apr 2026 15:50:43 +0000 (UTC)
Date: Thu, 9 Apr 2026 11:52:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux
 Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing: Documentation: Update histogram-design.rst for
 fn() handling
Message-ID: <20260409115200.45883a07@gandalf.local.home>
In-Reply-To: <87bjfsb37x.fsf@trenco.lwn.net>
References: <20260126181742.03e8f0d5@gandalf.local.home>
	<20260305110347.31d6bae5@gandalf.local.home>
	<87bjfsb37x.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: n6xmx31ixtdr5woyi7ebr6t5w7ox7zz4
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 6319920027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+tGIud1ExAUO/pLP/e8m3SraoUysR0b1A=
X-HE-Tag: 1775749843-565787
X-HE-Meta: U2FsdGVkX19UG9TQnpcq0VZEdA+h8kT2PJCe6IZpLapSLSGqP8V1fWNW4kzX244E2sy7kH+RayM56kTpkBPJTiXwF78nlPPjgGXoljLWMe50gHhvf4I77ALwzQHkILzS2ykNpfIHRXCTLwBbgat2icjCNuzQuJ22w4lI/97DUxTrlNu5Pas/5oM9kG4UL59FOxG1lAAgQWcXTy67w/D0mMwx+8cbuGPOoYGHgFakni1NmrZudby6+d8rpKQgDZy37yy3IpDGYZBWK1qff2eLJhfTpAkI8/D+1VIPYxboMlHJHrlGbsZPSvsp4gqC/Ev+3MRZsxqp5peNzS60+kPoKFrKmQMIH7+95iGLQ1+JGPRvLNI9gDGrVEagWF3CF5IfwWZ7/bbqY5M353EYPlkhzfUnutta7bQefwDOLLYcLe0BcoP6luqMlDIWsVoOKMS2

On Thu, 09 Apr 2026 08:47:14 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> Steven Rostedt <rostedt@goodmis.org> writes:
> 
> > Hi Jon,
> >
> > Can you take this through your tree?  
> 
> Somehow it fell through a crack in my inbox, but I have, finally, done
> that.  Sorry for the delay.

Thanks, it has happened to me too often but not as much when I started
using patchwork. Is there a patchwork monitoring linux-doc? If not, I
highly recommend it. I stopped missing almost all patches when I started
managing patches with patchwork. The few times I missed patches was when I
accidentally incorrectly changed the status of a patch. But that's usually
due to my own negligence and not simply because it was lost in my INBOX.

-- Steve

Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D38C21D585;
	Mon, 16 Jun 2025 18:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750099770; cv=none; b=q/0MvrjRXGQZUn+hxAUMtWL9cL6TCKRWhF6apAjY9pM2lHL4ROxYf2m533ZAsKk16MPKlS9/xo6j92Jy7EHt11DZXTH0WkxAfP1lYF+tHkgfD/+kEITb4mVEz+koTep+VR7Vap0I0s+6tMh1/KOAJ8fT1gbS/tw6YmCqvUS1vTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750099770; c=relaxed/simple;
	bh=e2+gGferSX8MzCRr/wdVC35vO7/qOrA9rBZTd6DAXcc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZTmOMr4n1UQY2kkRIT4eznBc+3Wzr82EIvu20roHZttiiDIC5dneLJ/YyC5hMIMKtQ5Rymux7+dm9oRu1Pt78v3x7mOf0k/wtMSa8Y/DvL51dRpTQSFkh0964I5TaZkkrsgMIgiN9jcJl7Rw+FUaizvBY70VgipZqhtxZswxg3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 19DD41D700C;
	Mon, 16 Jun 2025 18:49:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 32E8C20010;
	Mon, 16 Jun 2025 18:49:25 +0000 (UTC)
Date: Mon, 16 Jun 2025 14:49:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] alarmtimer: Hide alarmtimer_suspend event when
 RTC_CLASS is not configured
Message-ID: <20250616144924.4f102c6b@batman.local.home>
In-Reply-To: <871prnr3pq.ffs@tglx>
References: <20250612095828.6d75dfa3@batman.local.home>
	<871prnr3pq.ffs@tglx>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 7ix8epkpm8b65atrcneneu179udj35ew
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 32E8C20010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18+z4SHUCnJGyGYyuIyGuFT35MrIeuR2zI=
X-HE-Tag: 1750099765-383951
X-HE-Meta: U2FsdGVkX1/fNFC16wjOW3B7Voq+n+2bOPD5hsAonvZxE6lPQlcsR82VETRoemcns719Vh6zKEXW1UB9PGYmf5YnK3lch+pt6cHrE5mGDH9TDmQlH0issgSXwWaTG08LWG7D0lSjH2uWUbVW8IkGS0bhMuJfUKcQPRDcWkyp0N+29gG+w265WLo61ttUpV5A45cbLDgsVMZW3VStRVReabXu3KLFatT8RXD80cxscu4BG/ELo5DbTSntUXFRyLykWYnVfy8275TAEWQiX85nYZnjGkjcPv7SIe+gcikFRmHNRr7rvEoflleNXIqREQmZikiNXk1mah5oGWKAPw0gCyBtJ5A3+cBB4/h7YX8e1jua6U7EvTgPcs/szHq08iODzw9yRghwPgNQb+3miLLKFm0MLZUZplkE

On Fri, 13 Jun 2025 18:44:33 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, Jun 12 2025 at 09:58, Steven Rostedt wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> >
> > The trace event alarmtimer_suspend is only called when RTC_CLASS is not
> > defined.  
> 
> s/not//
> 
> No?

Ah yeah.

> 
> > As every event created can create up to 5K of text and meta data
> > regardless if it is called or not it should not be created and waste
> > memory. Hide the event when CONFIG_RTC_CLASS is not defined.
> >
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> 
> Other than that:
> 
> Acked-by: Thomas Gleixner <tglx@linutronix.de>

Thanks!

-- Steve

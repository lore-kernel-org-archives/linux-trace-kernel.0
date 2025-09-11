Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEF4221264;
	Thu, 11 Sep 2025 18:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757616409; cv=none; b=azifFdFToM/UqJ+sgXgTFdbvnKcW/x7A8UZAPZFae5fUTakQ0sK86tdM7VYkiRCQRPinUXMEqMUgTdVwu63flxLjZCE0igZw3m44N+mwXoerQrrQoMwB4ia6rOry9TCJakxsNmj4ZGnXZkmT3/3Jax3O8pHE66mMXD/bQylEVts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757616409; c=relaxed/simple;
	bh=6h4+B1DqahcriJNK3O58emrdy15GdClOiz1aQ1JH8Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EC/E/Nhj50KCVpmhcFSFjTaHyhtg2WfqIIUb3K2DfSD5vMdXEADHf3m6myZsrPXumApC7Q6viD4BO4G3O7jZm/bTlt/EgmDIQ3qp0Ej3vo+XFHbUjKfzERVkwqyHhd+dZkbB4A+Wc6dzBXciLKcUBuRPu8iI9IeDFrnthNeLivk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 59C4859536;
	Thu, 11 Sep 2025 18:41:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 7806930;
	Thu, 11 Sep 2025 18:41:19 +0000 (UTC)
Date: Thu, 11 Sep 2025 14:42:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vladimir Riabchun <ferr.lambarginio@gmail.com>
Cc: 20250911104138.2830f60b@gandalf.local.home,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mark.rutland@arm.com, mhiramat@kernel.org
Subject: Re: [PATCH] ftrace: Fix softlockup in ftrace_module_enable
Message-ID: <20250911144212.3d02a964@gandalf.local.home>
In-Reply-To: <20250911143758.06ef1230@gandalf.local.home>
References: <aMLPm__QGrQCwz1t@vova-pc>
	<20250911104138.2830f60b@gandalf.local.home>
	<aMMSCQAINWfiDA4L@vova-pc>
	<20250911143758.06ef1230@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: qrqfu6146gkhy94y8dwz7k1k8yoydi1t
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 7806930
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/AzPnRW+Tj/CnIAsFrS8MzHjACCjyIjx4=
X-HE-Tag: 1757616079-434514
X-HE-Meta: U2FsdGVkX18sosWUMSWyx/eychXluvFXBAraUI2Xl8EJ6iermT4zDGrjacUWItUnewDLtld/RvbvqL4XjecQjmAYpdHBiaBiUZNoIXBy2DvO70ynzLixWoZmlkwF9IFtett8Dwr90mbm/QtHc4p78fYYBrnUQRldYJer9Lpgwt6bSTAD92xvg4RUnBM6j1KhFoZIRafA61QwUJclXrZXk2xGtlzHjSzFvIjb8Rkzk7VhDCHJS6UFUNNMVntbBTdLG8oF6qwQcuoAa1kTj16j+4qGJCmbRo6cWhzdWWYaFOrtco0iDqyBbdiMgx/Ha04hUiEHcAseu0xcU6rW0wlYo3dBi1u84Mxs1sdVv6XpxQf/25kHMnoZoLM/+MOZp6Fr

On Thu, 11 Sep 2025 14:37:58 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Probably it may worth moving cond_resched under within_module check, but
> > before test_for_valid_rec call.  
> 
> Hmm, do modules even have weak functions? If they don't then that test is
> useless.

Doing a quick search, I see that they do :-/

drivers/tty/tty_ioctl.c:__weak int kernel_termios_to_user_termios(struct termios2 __user *u,

Looks like sparc can overwrite it. Thus, I'm guessing a module could add a
function and an arch may make it different. That means we still need this
for now.

Yeah, just send a v2 with the cond_resched() after the check for module.

-- Steve

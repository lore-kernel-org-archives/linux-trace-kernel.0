Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43663277013;
	Thu,  8 Jan 2026 03:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767841549; cv=none; b=qwWtMOhwKI3Nk9UPdzuzS9DzojHv6/jtiSlO0TYh2lpeNZ+rSyBOFSVZzkepEkbNju3gWOnleLNfwQt1+vTTzhwpjqzUNHivTWXSZAYrxaHV0KPykTmJLWLuoRg+orbjd9IcCKFWU2VSxjE8rKTVUdWW1D1jguSI8vh9hSL3YhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767841549; c=relaxed/simple;
	bh=F630PPok5y9P0M0M0t5PKMfvdGUZ0TSajbYY+h41XXU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kOlCSYv780+33RTupyTWjTgZLQyW+yVpziLnfpwgrIoh1s7KDBubDEVKmphOzpvYUUMUUEzenwxnNzgi3wXwuuimop3y42lFqKm1pLz0M8Ek3lcu8l/pWhNhTLv6a5G0iEdla40Ni4456Joloej0VwVPahtb1WZw+21usJY11xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id D939D1B118;
	Thu,  8 Jan 2026 03:05:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 3925B2000F;
	Thu,  8 Jan 2026 03:05:44 +0000 (UTC)
Date: Wed, 7 Jan 2026 22:05:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: Make the backup instance readonly
Message-ID: <20260107220542.0128abf1@fedora>
In-Reply-To: <20260108115125.b832464d94ebcfd0ea3b5af4@kernel.org>
References: <176779714767.4193242.1978666866487010024.stgit@mhiramat.tok.corp.google.com>
	<176779715937.4193242.8486149802702305279.stgit@mhiramat.tok.corp.google.com>
	<20260107114133.7f14dac2@gandalf.local.home>
	<20260108115125.b832464d94ebcfd0ea3b5af4@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 8offckxms15u7bt4yu5rgcwru9aq4s1m
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 3925B2000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX197z5rurA/fi0GBFd12ZMr9+C30PBYl5Fc=
X-HE-Tag: 1767841544-960140
X-HE-Meta: U2FsdGVkX18zkM/nNsb5rniHcADzhFdZzoLlV9XHQJ+JPeJcvdzZ0sZ6aoG4P8jSI23RIEw4xKN+AMMaVwZejDPRQ1LXhdxypjIYpIWxvL7YjZEZu2STmVNH1ttt5Y+z8naOUNZoRxUxECpm/oo0QzNyecSDuy02yjy2ZS9i9J2o46rvh0bHmmkpow+kSWtUat49Hu7SA8+acctWsllVVf6ZfUjRNr4mswk1pyURux4xVKhn4TTiR+2pZzxIFKxnPX3b+NeQWZdcyIQoD4JRIVM34q/TckknF3rf55CqCp7Chxgp7mX8W7enuEJjaBQkYD+UAK9iw/9bsU8g4dMyzahSP3sOXtwT

On Thu, 8 Jan 2026 11:51:25 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > We may need to make sure they can't be changed to write as well. But that
> > will require a change to tracefs (and eventfs).  
> 
> Ah, you mean the permission check is not correctly done in tracefs/eventfs yet?

Actually, i think we could use a different fops for read only instances
that do not have a write callback. And for eventfs we could have it for
read only instances to only create the id and format files.

-- Steve

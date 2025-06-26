Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD592E6133;
	Thu, 26 Jun 2025 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750952207; cv=none; b=Lf5UPNDwpAq/+fiRhoO/QVbwRVYJam4WqtIxnUJQG6MLDXcSJ2RaUd8XHsf3QDx/9KSrF6qRBbwY07qFbD51e/LImqyswW2R2TB+EucUH4BZV4WdEqgFwHu0vRCDBWbF1CDiUoeTU2xTaLRu9geiGh7bA0j/KTPot2hW5Q48GAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750952207; c=relaxed/simple;
	bh=wDC8jYentfesMeMpkJeR4ttf+wzbV1AWv04wos7u40w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GSy6zaLBDkLOnbh8+Xbz1iuuxdk5/pbMfYRO/qx4uRH8I2dF5MC36o1L7zBxKlP74iCSZ2NbwE/D8uNHypOz0ZV5Z+I8mIRwK8syxUhSEqiVpKgcmg1JS4BX5D0lJn66UOcBBwVC80ZzbBv9icclQhHP0bc/wDSMlXhvU5CEhEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 7794B1A0287;
	Thu, 26 Jun 2025 15:36:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 87A6B20031;
	Thu, 26 Jun 2025 15:36:42 +0000 (UTC)
Date: Thu, 26 Jun 2025 11:37:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gabriele Monaco <gmonaco@redhat.com>,
 john.ogness@linutronix.de
Subject: Re: [PATCH] tracing: Remove pointless memory barriers
Message-ID: <20250626113708.4a96e47c@gandalf.local.home>
In-Reply-To: <20250626113520.315db641@gandalf.local.home>
References: <20250626151940.1756398-1-namcao@linutronix.de>
	<20250626113520.315db641@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: gcmfd58bhmc61ncuppn85sp3qbi9kgu3
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 87A6B20031
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19/ljJA5rKjppQWXrxvRGDaMwWf8qKESsA=
X-HE-Tag: 1750952202-303129
X-HE-Meta: U2FsdGVkX18ri2QmmzMURErDwCcIowdWfmK4u2wgAKljm2diZWhYl2M3BnCb7JBV9Bd6e2zYfM3IBZbvDvPx5qU+nDgOXkhoDdlYmLOsgnOPrWZkDdx2M8Hekpxlkc6nNkRbM200aOLYm3qxm/onOILYC7Lj490HjkXHPVU5BMVHD+UtWAoznA9OZOjWhbJQIq6lFigFP7/T36FA0JodScbea+wa4gaEmbIGgCq3pD/Q9VNWFoE0QK3RxaBj+vljT2ctDQIdBFtFOT3PAaaVcOM92OySNxHSm46UGGCg8LYOO3DgvKANlXBsFG4P9SDECJ/cgQgTNCe/pm+9tzbb33EwEq+taonUTBAfegputBCQ+bmXoQkgDw7hO83lexFBpbNKMK5MqChNtL9PnUn5mg==

On Thu, 26 Jun 2025 11:35:20 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > @@ -2710,8 +2705,6 @@ void trace_buffered_event_enable(void)
> >  
> >  static void enable_trace_buffered_event(void *data)
> >  {
> > -	/* Probably not needed, but do it anyway */
> > -	smp_rmb();  
> 
> As the comment says, this one actually isn't needed, and yes, it can be
> removed.

One reason this isn't needed is because it's called via on_each_cpu() which
will trigger its own barriers.

-- Steve

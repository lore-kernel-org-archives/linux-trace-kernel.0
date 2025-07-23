Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6AF2F5323;
	Wed, 23 Jul 2025 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753284217; cv=none; b=LlWWfQf0+z+WtMSqbMcM9yHZGEYsrDhgvk3FKMCFw+c1xiQXr/i8T1Ic8vkQWLs730bNGmC7i6L5LgFWgS78JsRMNDQbUF08NhWrWEYaMyIiz1+SxpXsTeZexSD0I81CSUr7uVxAZMjwta5iggWazX3uCEptvJ6lLvfqxT4mG4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753284217; c=relaxed/simple;
	bh=LwRy8YHlN9niE233iOsNmeUz194hkTApdjgryRMtGXs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cc1zWBYEfYKScvJsUtZjfUW6gUuIRaxUbcKp91pFk4xgsh5GvXIhIasvfWizZRKdXz9t9TGhYYCSasCaSQE7VwgNJxfU/Fdyp/gDJ69bKgowBue86XBa03AMhEXM3QKfoXj9Uv8VnUxVSwt02siQ5ASK7v3wkVn5TWBoMnUyTkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id AF4DAB08DE;
	Wed, 23 Jul 2025 15:23:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id E6CE68000F;
	Wed, 23 Jul 2025 15:23:30 +0000 (UTC)
Date: Wed, 23 Jul 2025 11:23:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] tracing: Remove "__attribute__()" from the type
 field of event format
Message-ID: <20250723112329.691ed421@batman.local.home>
In-Reply-To: <20250724001806.2dfd6baf4990f952ee77b6c6@kernel.org>
References: <175257695307.1655692.4466186614215884669.stgit@mhiramat.tok.corp.google.com>
	<175257696222.1655692.4019049819386139160.stgit@mhiramat.tok.corp.google.com>
	<20250723104030.6ec24dfd@batman.local.home>
	<20250724001806.2dfd6baf4990f952ee77b6c6@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E6CE68000F
X-Stat-Signature: suyfsgcjsbt8iey6tt35pakoy44q18tw
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Bltuk7gnJM5d727eNPSwnwxZWxE3hvTo=
X-HE-Tag: 1753284210-568204
X-HE-Meta: U2FsdGVkX1+V2u5m9hssQjBQzhAGKQeNe2x0a8VEDhXrT3mmIPSLLv1vi6lig2PuTrImB4i0h1IyDEeYQulDD9gViZEdEXuwn3c8PzPsxWy2YffJ4pfMCCkZJQFba4AfYgoKX5Ilq8iuH+++iP01Tf/6tqj30wPwNbPfdja7dqvfGw7zOkg9PkwjbostEClRYsQQJstaxZngk84+Ys8UtPbcWGConmLMBtU12vypFlnraDAfV0TJZk73Qx5ubUimCXFYvAYY7DilCyIUmsZKKu6QurFg2chJcKP/7MX+3ukhjM+221JWNPu3zIqxzTQvjtvwrhX01+l+iJOSfqI2nsqo6mi+Yxav

On Thu, 24 Jul 2025 00:18:06 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > So this will add more work during boot up as it is processed on every
> > event regardless if it has an eval map or not. But this is only needed
> > if CONFIG_DEBUG_INFO_BTF=y and PAHOLE_HAS_BTF_TAG=y is enabled.  
> 
> Hmm, In this case can we check it in trace_event_update_all()?
> If we need to sanitize more word, it is easier to add a condition
> there.

If we need to sanitize more words later, then we can open it up to
more. But why do this work when it's not needed. We are going from
calling this function a 100 times to calling it a 1000 times. That's an
order of magnitude, and I'm not sure we want to do that if it's not
needed.

> 
> Or, maybe we can sanitize it while building the kernel as a part
> of post build process.

Ideally, that would be best, but parsing the elf file isn't trivial.

I would say let's just add this conditional for now, and then we can
start working on a way to parse all of this at build time.

-- Steve



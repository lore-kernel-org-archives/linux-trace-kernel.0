Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A8240EBB1;
	Fri,  7 Aug 2026 19:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786130812; cv=none; b=D0CHeNapiXtyx2FO9DA6nzL3DJkSQCyy6kDtdWtHa6yr+1VNqR/o1QDGRk2lf231OUUSewo+u4EpTXQv0IXJ+5hJJleG6GED9Jey/qMygUGyLYw34Cz64uAgruB7Qh/oW9ced6zB/+daUxsuwEYdVg/KJyIl9hQDj1TIkL5bMwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786130812; c=relaxed/simple;
	bh=Mjer4IIAZTqtFDOJHS6B13C4xIZbYyfjxrausYoelf0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sd2a5tel/4ACEDeX0tgJPt+GeDtVNppMRh2HzTM5Ip8DzzmN6L1OOrT4moPwvCL4sLwARAkW8zmdWNeiTm8XDW+I5z8j8hnsv3m61VyjlwTD739LRIwUZyh+S+mBVKX/lHwPgCA77RW1W8Gl1mJrweApGquUkG1JbQQxehrcd7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 606BF40010;
	Fri,  7 Aug 2026 19:26:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 868962000E;
	Fri,  7 Aug 2026 19:26:38 +0000 (UTC)
Date: Fri, 7 Aug 2026 15:26:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] ring-buffer: Prevent resizing of persistent ring
 buffer
Message-ID: <20260807152641.4b9deff0@gandalf.local.home>
In-Reply-To: <anX9k8x67m4Cdw5n@google.com>
References: <20260806211306.3704194-1-vdonnefort@google.com>
	<20260806211306.3704194-2-vdonnefort@google.com>
	<20260807111808.d5dc1a48b080d241100f4a57@kernel.org>
	<anWT4heM5Z--A1Mo@google.com>
	<anWosNi-U8lVqBZP@google.com>
	<20260807104526.38430aa2@gandalf.local.home>
	<anX47awNHC9caDN_@google.com>
	<anX9k8x67m4Cdw5n@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 868962000E
X-Stat-Signature: eif3ddu6ojp17tzeyruor4wxhit4ise4
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+3zB9Wh6YtNDBpwBeFg6fLhIpNdzI47Iw=
X-HE-Tag: 1786130798-53163
X-HE-Meta: U2FsdGVkX1+ot5lH290X2eay8ZKx3xJr9197nxul+Yo/UNEY3XeMwSzex6cfEP61uegjblv0rJqZaH979edyeiRHPMjaPCZpddxk5s6RId/YnZHOzB8TgKnPdAaTvJTiXXTPmtrzuwDUldZaF9rVEWCPzgGiL3OETBJjFc98TC+M/aCCiujvYoUrOCV6YQojSEkDO5Rx6B1OXEQVqTxxJdxh9845eyqQiT4zwP0pya4j/QUYlY5xG/E/oDvLeEMP942DR7Tsuu8VsqsGob6+s0eKgpUYe+xUdZ9NxgVL5ntcfbgzVANnzuRKUC42/Oqle6SkHw3Bp4DjL1yDuvutlmNMPEU9ezH8wO54QfBAMFTybE0eBieVWg==

On Fri, 7 Aug 2026 16:45:23 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> free_reserved_page() would do actually. But then it is definitive. 

It's not always a reserved page.

> 
> Happy to implement something like that. That also means that the instance can be
> actually freed?

They can be freed now. Try a rmdir on one.

Note implementing this is not straight forward. What I would suggest is
that because the persistent ring buffers are contiguous, to resize, you
basically need to remap to the new size. That means each of the buffers
will still be attached to each other.

What would need to be done is:

  1. calculate the new size needed to accommodate all the CPU buffers.
  2. Split them up within the new size region.
  3. Then free the remaining pages.

Obviously, access to the buffer from readers and writers will need to be
prohibited while this is happening.

-- Steve


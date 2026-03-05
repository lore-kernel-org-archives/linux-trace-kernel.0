Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A09262FD0;
	Thu,  5 Mar 2026 18:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772733794; cv=none; b=MjV7Mb5impS/EN0TBX3E7uyp04cubqEGJ2P3xDhIRul2rRlAodS1TA1jV4TPBGOoCzpcT/Yt6YqmjE21A0rKkDyfk21jV3kcDZPHzV/U7SdY7M7e8aOiBguSo6eLByYeXsVZkugUqAghMLn4YwhYJo4zZWpBCP/MA/VQjG2PvjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772733794; c=relaxed/simple;
	bh=jjn/VGbqnRXLNSkyuImblNk8UtoEbzhKJbcw2t8Iank=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ri9VIGuTkk41C25hDdq9j5oS3YF0EBMn5sNQ2sHj1SKVViLIP8jjSDplyYZGaLj4rAqav2LRMCWUeSKaQxKT44NIKOXuEehBft4xy+cKBA+3gIDZHMJsDrw3rvVajFZW97ihPmPuLDpRdSLtkvf0Y/gl4TmKBIFHnXvLph/gLAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 72154C10E0;
	Thu,  5 Mar 2026 18:03:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id BF21520024;
	Thu,  5 Mar 2026 18:03:09 +0000 (UTC)
Date: Thu, 5 Mar 2026 13:03:48 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] ring-buffer: Handle RB_MISSED_* flags on commit
 field correctly
Message-ID: <20260305130348.3266e4c9@gandalf.local.home>
In-Reply-To: <177211312362.419230.15156461178245984273.stgit@mhiramat.tok.corp.google.com>
References: <177211310553.419230.7846100548994399256.stgit@mhiramat.tok.corp.google.com>
	<177211312362.419230.15156461178245984273.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: BF21520024
X-Stat-Signature: 5c5zy8yhe15dskb9q668pcbxgiu1ie3w
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+LKmEKfq7NK/D4oRysx7lx+VlAYBVWM2c=
X-HE-Tag: 1772733789-290496
X-HE-Meta: U2FsdGVkX190OV0y8vsPRnn9XXLU6BZbAVjskIUmZ/qtqh1D6YStSLIlbP0z5eO9W9X48NKjVscRbn9mzdqasQWH1NXf7wWhbWcDHOJHCIBbsGs7UOjGMmQpSgdHe0K3UaKsfyfO6rI0giP4PAIARhPBMYRk3oJ5/hRyAU1O39wiJ1fljYPBvflZVXMfAMlS9DzOAZxWb4Dm73yU+u52ncsVAcOZWmtg8HM2KI+/wPHojXDdD40ACAv/ntbhX73fJ8PZy6mBR8zw4hmzkl0c5VSw5knxWeA3lUmZ30fnPGPf1gKuTydkS8WtSKSmX1ZmZS1sb7/yi+st7geeJltByx7HhE+prUnM

On Thu, 26 Feb 2026 22:38:43 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since the MSBs of rb_data_page::commit are used for storing
> RB_MISSED_EVENTS and RB_MISSED_STORED, we need to mask out those bits
> when it is used for finding the size of data pages.
> 
> Fixes: 5f3b6e839f3c ("ring-buffer: Validate boot range memory events")
> Fixes: 5b7be9c709e1 ("ring-buffer: Add test to validate the time stamp deltas")
> Cc: stable@vger.kernel.org

This is unneeded for the current way things work.

The missed events flags are added when a page is read, so the commits in
the write buffer should never have those flags set. If they did, the ring
buffer code itself would break.

But as patch 3 is adding a flag, you should likely merge this and patch 3
together, as the only way that flag would get set is if the validator set
it on a previous boot. And then this would be needed for subsequent boots
that did not reset the buffer.

Hmm, I don't think we even need to do that! Because if it is set, it would
simply warn again that a page is invalid, and I think we *want* that! As it
would preserve that pages were invalid and not be cleared with a simple
reboot.

-- Steve

Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC90484227
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 14:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632312; cv=none; b=sFVJpVzwYvNIAoswPCEFMAbjI02V+FgCiJbnOjAFyWNLxTy9K1H9xZpNmYEG/P++vVgYxLId/NDFULYBkkN3OwRa3wowgmp4GFkGA14FJt6m7m9JMG1mu0mGUvkkZhVgz5iVzQgqUxhMEdRtJJBNpZQKlXrlTB16PB6dhGUCw9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632312; c=relaxed/simple;
	bh=UKiEw25JACPfoRyZOGdENNRZZgzji4bHQNrW3S+x3YI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqibdjxv6ixezzCAZs2bskyl28G5PVDvzbNSDmdxT3DbqRI3G8kOINYjxLw/J2t11DkViRv+7rS6bJ+MYx7y7NXNq8WkPWefp2MFMnpYD8s5Km8eQw/+cDJq4jXBYjB3hIv9N+rhqDuzvuTnURLAUvsffaV0NUcrq071mHbkwSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=Wi0M6lCt; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="Wi0M6lCt"
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id CFC7980143;
	Thu, 13 Aug 2026 14:45:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 2E67A2002D;
	Thu, 13 Aug 2026 14:45:01 +0000 (UTC)
Date: Thu, 13 Aug 2026 10:45:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas.weissschuh@linutronix.de>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/7] tracing: Stop modifying the input buffer in
 ftrace_set_clr_event()
Message-ID: <20260813104517.588cc978@gandalf.local.home>
In-Reply-To: <20260813164014-bb2d92fc-631f-4e0d-b940-2f2c63859563@linutronix.de>
References: <20260813-tracing-cli-event-filter-v1-0-57c4e8029c86@linutronix.de>
	<20260813-tracing-cli-event-filter-v1-3-57c4e8029c86@linutronix.de>
	<20260813141501.347E21F000E9@smtp.kernel.org>
	<20260813103821.36d6b6f7@gandalf.local.home>
	<20260813164014-bb2d92fc-631f-4e0d-b940-2f2c63859563@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: c63d5gk5xugksbbqogfdpbu5m8be7nwb
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 2E67A2002D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18gTdyoOwJ5gGMvOjFDNh7D9rmbOJeSEvI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=UKiEw25JACPfoRyZOGdENNRZZgzji4bHQNrW3S+x3YI=; b=Wi0M6lCtuPF2afXqJl7wqPVA86Ex0P4Rf27JuAgydEENURxm0+hZluu8CuSdvN+cfYuzLBNe9GrkTVStIEa4YKy+mEUG6YdoyiseZv39MUEhXXtXptSQkUzUfM+Yt6rL6k1hnxWJJs77dfIlmX7dnlE5QahBZrmW7GtoNdF/cWM=
X-HE-Tag: 1786632301-102954
X-HE-Meta: U2FsdGVkX1/YTE9NQyiHwsIGVUOEF2ABuU2WZ10JVc0ItvrWfl1fraSzyEvpCrJBL9oN0TxK/L7QFkmil1BEskaAZUV7uVir8HPGXUG/1kaGBk5mULCoHYXyJlGO9XbIoS+cU7p07rGhygC+uJVzwwxZHH1BkFCulTF59WHoXmbh/b3J4UwtnSA7HFIdCpgVIAkSjNDnis5CyKD8wwNVFtm3YRcgfwC0WLnfDaJyZQ/NQvL5wEXsaePrEM565s41ZzwhTDqmggSfOcqn8r30XqdQJzKCA7D+5hEQOVgCRAZfIFlnhC8QEjBE9Q+E4akz

On Thu, 13 Aug 2026 16:40:48 +0200
Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> wrote:

> I'll deal with the Sashiko fallout if you are fine with the general idea.

I'm fine with the general idea of adding filtering logic to kernel command
line, but can you show some examples of how it would work? That is,
examples of the kernel command line.

This should be in the cover letter.

Thanks,

-- Steve

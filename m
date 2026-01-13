Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421884A21;
	Tue, 13 Jan 2026 00:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768265242; cv=none; b=Ul7WX+pKRq0QgLQVKQt3Rs1T70cxvkmI1HysiRofCxhbKK8CyCNEyPGqX4ODh5vSDTFyKzp6rs+F0O+/WX96F+aaKmV75pw3YQL7y6Z+LX7/feyrXJT8QBCEBGcjbQxQ+bbxqVrf3+4vv5TaGiwZhxl/nJeAZFwNMh6etoMccPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768265242; c=relaxed/simple;
	bh=jm+6m2/7wwBOTSVLW2huT3R0tUo6MVlIyLtQ6tFqv2s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNQ5zVVLYmjD11VHRdLibHe0sJ0lilMpQ7DeOy0i2ohFzPTzdoCwwMQcsNNUnallKM4U8mgPFNae6czdsKYzVWUFCzIJPn+ivpmoMFetTxO6K2HnOoKiok7WdyXpzBxaFStiSzW/jJmrmqp4DD3PlOsVTfCMOoK8n7DmOFScY40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 33AFEBECC0;
	Tue, 13 Jan 2026 00:47:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 96E3F2000E;
	Tue, 13 Jan 2026 00:47:18 +0000 (UTC)
Date: Mon, 12 Jan 2026 19:47:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tracing: Make the backup instance readonly
Message-ID: <20260112194722.19164ca7@gandalf.local.home>
In-Reply-To: <20260112194551.2446d041@gandalf.local.home>
References: <176788217131.1398317.11144318616426272901.stgit@mhiramat.tok.corp.google.com>
	<176788218294.1398317.13118277798168167277.stgit@mhiramat.tok.corp.google.com>
	<20260113093100.e91c5be8b8fa5f1e64899ba4@kernel.org>
	<20260112194551.2446d041@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: a7ophm4nnsazuwx1tumyi5sq5wzdoqn8
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 96E3F2000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19fJHzwAVZ2lvV4Ym5x11NrqwBZ/XpUigg=
X-HE-Tag: 1768265238-392610
X-HE-Meta: U2FsdGVkX19x9LIZDFzLJIp5U9AVLSlMfr5CpnziEGBR3RPqrp+sAqqtppz/55FX/eIjYbrD6xuMuN+31HetM8Fsnai/slL8OnICJjUQrxCgmVc8TCkapSU0yT03VbLtBk0G8vJLSYMmibqH7wX2ionrWGBL5YKM3U2Gd4Tfy/jc22Ce8VyPoCqbiMqO37v9ZRg7bADHgkgkGet+MEX3jhKhQY/gvTtKq/9WvyNemVSUQ5XO+JmgpGp0PVEpTzDrRk2h7T9CaQbPGTSXAiBXq0U4JKnNoMwLDjSfaWqQQu5Ze4Vq++ZpiWCjDdoXVV7vv2J273lSPqpU2iP7/o7kGhuNRNut8aXtHkJw4S3vngW7tnex9o7KkgqY9l1wje1G

On Mon, 12 Jan 2026 19:45:51 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Let's not add any flags to the eventfs_entry. That is created for every
> event, and events are already too big in size. I don't want to increase the
> size of each event for this feature.

Actually, there's not many of these. But they are all static variables. How
are you going to differentiate them?

-- Steve

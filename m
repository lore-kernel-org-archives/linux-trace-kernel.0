Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDF5225A38;
	Wed,  4 Mar 2026 02:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772590411; cv=none; b=gwaNFV3MXJJi0BFm/hE/MNZ6G550uwtZb69MwEYngxmeXNsMTdIWoxm8D59eB9WEdhBPVbk5BITYV64efD7ao7FsnlN4khEJgPYGMANfEH6aqS+28mMbW9I0EuGhfRCrR1FZ5WKVs3a3GBTIIZL1wOsJ1zEUu1eudnt437zPERg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772590411; c=relaxed/simple;
	bh=Wj6MmDh/Ur8WOGVdBqDvrx0yW71xTowXqGGEqpIVacQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W7KBDUQlKiP3d5+S/vQ2Z70fta5p1LaZDvU8m50rZeDtCtgI+LUmp8dMDav1bOTt2FZ5zf/m+UsoWzt1clgF8D4e7bqO0WAGRgK5XQ+lUX9SzjJtQpbKfkl77Az3iMJq5RfraUZScAEq7t6/gc8V99WGwY07WtGcVbrfJ3pujfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 8BAC713A7BB;
	Wed,  4 Mar 2026 02:13:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id E6BFE2002D;
	Wed,  4 Mar 2026 02:13:26 +0000 (UTC)
Date: Tue, 3 Mar 2026 21:13:25 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ftrace: Disable preemption in the tracepoint callbacks
 handling filtered pids
Message-ID: <20260303211325.0f0d1ffa@fedora>
In-Reply-To: <20260304104833.7b157f3cd2ff911cbcf77660@kernel.org>
References: <20260302213546.156e3e4f@gandalf.local.home>
	<20260303131706.96057f61a48a34c43ce1e396@kernel.org>
	<20260303093949.4210e854@gandalf.local.home>
	<20260304104833.7b157f3cd2ff911cbcf77660@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: dg6ftwioa1cqezbyqtie9rxs5odakdub
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: E6BFE2002D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18lPgRKx4NqeBjOZQmJjaPpWeQ2+l1Vdi0=
X-HE-Tag: 1772590406-6754
X-HE-Meta: U2FsdGVkX1+rQb3tEYuI+cSA1HmrWGOGmut1/jQowe6hisXyOX8xzlhUKo2fCEZSzGtpDjvWW9XbcIa5rGlfnVLCUoHSgX/RzjxqBsM+GaZONFgKIsdDte/IcHiqOG32qWS9UNDHKAXxXLfleHCAdOpiKgyN+v3qERtQR+5FL9YPOdXEkqtY7x4BPekC73sxW5bNIth7nb+GW9DgDX+KMA12eUd94ncb9q2HhzoEuD3wbbuMgDsnItvhSTMnJpaYbER94ItJTjpTwCpuHthMqd2wkazehKqziuCDw4HYMBqtuqR251NzfROyH3cBqi1iGM3QDOuEh3s5QyxtvUj4TiPQx+DK+aB6

On Wed, 4 Mar 2026 10:48:33 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> I think we can combine those since it fixes the same commit.
> (just for bisectability)

They can still be separate. One is for function tracing and the other
is for events. They both may have the same fixes tag, but it shouldn't
affect bisectablility, as they require different things to be enabled
to trigger.

> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

-- Steve

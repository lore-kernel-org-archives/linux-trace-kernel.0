Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4338F374E6D;
	Fri, 10 Jul 2026 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783707252; cv=none; b=uyS4Jv/ib0TQ+MOfoU2+Iq7cu4Glf/5DQaOqlgXV2IRtRf8L8nPoIBS/z2Vwi9sMZ5yYuYbp1Ze4mBsg+UxqRcLGyAe9Eed2LpIiZ1YYbdopksK/YO3heA+k0sq99L77IMpvZ5+AVxLxLVhXGptA2EL3CTetsPWZxSk+aHMbUvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783707252; c=relaxed/simple;
	bh=sxpF2fg/FvbgU2ARpmDEhtMfod94JwEIeF9/yZLDXVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZIfCnDiUMn/cV+hi7ZWC7xad+9b6rsxcBQpf28ixgz/7G38nOBKhRJyXf2TNS8qqkPwRxzc645eJhO//b6vTbWyUHKz2lsJrJrjD7mI4tuVvzIZRONmBOI/O4WN+raZEhO8tBqxbIGMKhBAystA1/mUxKmX3wKwIxRsxsjSwqnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id A4A4940536;
	Fri, 10 Jul 2026 18:14:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id C18FC2002D;
	Fri, 10 Jul 2026 18:14:07 +0000 (UTC)
Date: Fri, 10 Jul 2026 14:14:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Chen Jun <chenjun102@huawei.com>
Cc: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 "sashiko-bot@kernel.org" <sashiko-bot@kernel.org>,
 "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
Subject: Re: [PATCH] tracing: Add "within" filter for call-stack-based event
 filtering
Message-ID: <20260710141417.1fff0e13@gandalf.local.home>
In-Reply-To: <20260707112011.7ca6f721@gandalf.local.home>
References: <20260608145556.94931-1-chenjun102@huawei.com>
	<20260707112011.7ca6f721@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C18FC2002D
X-Stat-Signature: 9uut5a8gm7dh35q94zjjdq33eucestw4
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/bktudCEEfh9C6AKqfyDyfcEUHhYImOk4=
X-HE-Tag: 1783707247-981796
X-HE-Meta: U2FsdGVkX1/Q+AGaZ54cqRN5XktvAvCRmSEMsgqLUWWOm1ibWDUQqMsr1E8tdriKxjEtKLp7vZq/z288XrxapbQE1RNUG/4vEhKnySIYy1Ja07NiRUdqmExSGHMt4ztKnwkZOmS+ykr+yr9xdd3AaWpNDtOcr6HrcIOdv9Xndrcs4B5glj7vgfLhFUbOUYYavYIAFB1nMnURUcQjwZakKTfSmMlt2/1lj5uxB86iRWz7qhDoVYM7AASVynQj4e3fkn1mvP21E6Ex/TARIgRtWE4CjhHXmKZ8cTw0IK5j2zXHL33E2oGp8glJajVGm4kAXDcX5BIZ9zUxmKWgMpBR8FDmXTCI+k/z/Wvd4+nC04C14isZZhXkiqHsFooig+M/

On Tue, 7 Jul 2026 11:20:11 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Does this goto need a preceding call to parse_error()?  Other error paths in
> > this function initialize the error state before jumping to err_free.
> > Without it, users might see an unhelpful generic error message instead of a
> > syntax error indicating that the glob operator isn't supported here.  
> 
> This is a legitimate issue.
> 
> Chen, can you send a v2 and add a proper error message here?

Hi Chen,

Do you plan on sending a v2?

Thanks,

-- Steve

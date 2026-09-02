Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DDB3016F5
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Sep 2026 16:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365752; cv=none; b=Fb3PQFU2IE96bEY/OofouCdBwlq8rqjoDP9hQeEdV9aeufQJBr6k+HTm5SckUPieCN6jsakHINN31Bv5TOMhQBYdr52ibN2Pq4GNLro0+LMbgVQuuKe+0+chKwTESM5f0qtCnnWWCp9iz0BvCBy4Wso1lf28HsyXCHwZHhT9HIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365752; c=relaxed/simple;
	bh=ke7oUO5hliqlqZ/sZj+PGoc8iPIbehJicoH+qJW4iV8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mwQrMd0d/a0T+Wz2dnmCjr4VHIdxvnxE9qjg6kqp9mRvm6rrsleAdDR18d1It4flVv5FN1knugzDU30NtKBAzj6DYHDiSbS9jIfN6obiVi0OlnBQ7rc9wqiV0DHb/+vKzT6YKUrx3N4I8zfm9lm9sToGlRU3w/tMHtsS/DuSKuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=QiJBBnlj; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="QiJBBnlj"
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id B5FD71202A3;
	Wed,  2 Sep 2026 16:15:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id D3D6B20011;
	Wed,  2 Sep 2026 16:15:46 +0000 (UTC)
Date: Wed, 2 Sep 2026 12:16:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Take trace_array reference when opening
 options file
Message-ID: <20260902121647.50141f14@gandalf.local.home>
In-Reply-To: <20260902121527.5dd570f1@gandalf.local.home>
References: <20260902114502.723d8243@gandalf.local.home>
	<20260902160208.12BE51F000E9@smtp.kernel.org>
	<20260902121527.5dd570f1@gandalf.local.home>
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
X-Rspamd-Queue-Id: D3D6B20011
X-Stat-Signature: ngmszqperc1kk775w5gyfdwwma3df7eb
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX184B5As0YhSKYoFrCJycR3DYVpEWPlBK4w=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=MmdqKONNB1e6PZ7bak8srAhfcK3lCC8Po8MzsasXAsc=; b=QiJBBnljlAl+DuiJLWazYslgVHXN4alax6H9kAcWEaqL4D9+SENLu9GewOkQ+21A4sO2tXKg7I9oqPRAMWm7g4czMIQit483Bf4nKKyexN77m3IwZ0iRqo/LSRlHWwTqaCDOseX+7e6SpHoBW48NghUijlGOirVDYd4G81QuyBc=
X-HE-Tag: 1788365746-771875
X-HE-Meta: U2FsdGVkX18+TOCEvo8bL2dxh4kSC0V69NjknhfYZkZnDXWjhrcvc6gYPf7fRGOclmwB5CcYvHAsAaNFsu5W1Uy4em9oU099EwKoZKLzH46f1s5PdYm/eFYIgYZ54v5LryaQRDpgSH9T9Rj2A7+l/4QhmQnfw1bRuUsDrBtawWlaf5wYrh7bWMPXEU2Audn0uDopYJlteNt73P7MSCV4W9hrKcKw6YSz67sXaW5aURV6zYHnFTgOT33EZQCV28BNqkP1MGQVUO+WwCzMhhuaV4tAb6tfbyqoZ1Wv4eI9ywK3O1X7dMHwdf7tq8lQ6hnmqa6ewN6cdH2PlV2tk380DMCJiXJXM+Le+eEzhx93vOZvMBm7BNBH5WvschNX4g1FtmtoLkhMBpx9HbO/x47lcg==

On Wed, 2 Sep 2026 12:15:27 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 02 Sep 2026 16:02:07 +0000
> sashiko-bot@kernel.org wrote:
> 
> > 
> > [Severity: Low]
> > Does the pointer comparison in the code still trigger a compiler warning?
> > The patch notes mention adding a (void *) typecast to fix a kernel test
> > robot warning, but the cast appears to be missing from the submitted code.
> >   
> 
> Bah! I forgot to hit git commit -a --amend before sending the patch!

Looking at my bash history, I did a "git commit --amend" without the "-a".

Oh well. Next time should include the update.

-- Steve
